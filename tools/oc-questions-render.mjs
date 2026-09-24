// oc-questions-render.mjs — the Open Questions page renderer (#547).
//
// VERSIONED SOURCE. tools/oc-questions copies this file into the build directory
// (write-if-different) before invoking it, because ESM resolves a bare import
// from the IMPORTING FILE's own location and the node_modules that carries
// @json-render lives there. Do not edit the copy under questions/build/: the
// next render overwrites it.
//
// stdin: a json-render SPEC. stdout: an HTML FRAGMENT. Exit 3 = the spec was not
// JSON, exit 5 = the spec FAILED the catalog (unregistered type or bad prop),
// exit 4 = the render threw. The caller turns any non-zero exit into a NON-ZERO
// publish that writes nothing, so a fault here fails the command and the last
// good page keeps serving (owner order 2026-09-24: there is exactly ONE builder,
// so the artifact can state its own provenance).
//
// No JSX and no build step: React.createElement only, so a plain .mjs runs as
// written. The output carries NO <script> — the page stays a static artifact,
// which is why the vpn deploy is unchanged (agents renders, vpn rsyncs, Caddy
// serves).
//
// The catalog is a GUARDRAIL, not a formality: a spec can only name a component
// registered here, and validate() runs BEFORE the render, so an unknown type is
// REJECTED with the schema's own message instead of rendering nothing. That is
// why the page's CONTENT is typed too: a description is a sequence of block
// elements, not an HTML string injected as a prop. This file performs no raw
// HTML injection at all — React escapes every text node, so the
// escape-then-inject round trip is gone.
import { renderToStaticMarkup } from 'react-dom/server';
import React from 'react';
import { z } from 'zod';
import { defineCatalog } from '@json-render/core';
import { schema } from '@json-render/react/schema';
import { defineRegistry, Renderer, JSONUIProvider } from '@json-render/react';

const h = React.createElement;

// A run of inline text. The Python side emits these from its bounded inline
// converter, so emphasis is typed data and never an HTML fragment.
const span = z.object({
  kind: z.enum(['Text', 'Strong', 'Emphasis', 'InlineCode']),
  text: z.string(),
});
const spans = z.array(span);

const catalog = defineCatalog(schema, {
  components: {
    Page: { props: z.object({ title: z.string(), expires_at: z.string() }), description: 'Page root' },
    QuestionSet: { props: z.object({ set_id: z.string(), lane: z.string() }), description: 'One lane block' },
    Question: { props: z.object({
      qid: z.string(), title: z.string(), recommendation: z.string().nullable(),
      token: z.string(), set: z.string(), action: z.string(), footer: z.string(),
    }), description: 'One question and its form' },
    // --- content blocks: the description is typed DATA, not an HTML fragment ---
    Heading: { props: z.object({ level: z.number().int().min(1).max(3), text: z.string() }), description: 'A section heading' },
    Paragraph: { props: z.object({ spans }), description: 'A paragraph of inline spans' },
    Table: { props: z.object({ headers: z.array(spans), rows: z.array(z.array(spans)) }), description: 'A table' },
    Mermaid: { props: z.object({ code: z.string() }), description: 'A mermaid diagram; this component owns the URL' },
    CodeBlock: { props: z.object({ lang: z.string(), code: z.string() }), description: 'A fenced code block' },
    List: { props: z.object({ items: z.array(spans), ordered: z.boolean() }), description: 'A bullet or numbered list' },
    // --- form controls ---
    Option: { props: z.object({ label: z.string(), value: z.string(), recommended: z.boolean().nullable() }), description: 'A radio option' },
    FreeText: { props: z.object({ label: z.string() }), description: 'Free-text answer' },
    Submit: { props: z.object({ label: z.string(), value: z.string() }), description: 'Submit button' },
    Clarify: { props: z.object({ label: z.string() }), description: 'Clarify button' },
  },
  actions: {},
});

// Python's base64.urlsafe_b64encode, reproduced exactly: mermaid.ink receives the
// SAME URL for the same diagram as the pre-port page did, padding included.
const b64url = (text) =>
  Buffer.from(text, 'utf8').toString('base64').replace(/\+/g, '-').replace(/\//g, '_');

const renderSpans = (list) => (list || []).map((s, i) => {
  if (s.kind === 'Strong') return h('strong', { key: i }, s.text);
  if (s.kind === 'Emphasis') return h('em', { key: i }, s.text);
  if (s.kind === 'InlineCode') return h('code', { key: i }, s.text);
  return h('span', { key: i }, s.text);
});

const { registry } = defineRegistry(catalog, {
  components: {
    Page: ({ props, children }) => h('main', null,
      h('h1', null, props.title),
      h('p', { className: 'meta' }, 'expires ' + props.expires_at),
      children),
    QuestionSet: ({ props, children }) => h('div', { className: 'set', 'data-set': props.set_id }, children),
    // The form carries token, set and qid as hidden inputs: the answer backend
    // reads all three, and dropping any of them silently stops the page
    // submitting -- the one regression that would break the live endpoint. The
    // description blocks are children of the form, which is where the pre-port
    // page carried them.
    Question: ({ props, children }) => h('section', { id: props.set + '-' + props.qid },
      h('h2', null, props.title),
      props.recommendation ? h('p', { className: 'rec' }, 'recommended: ' + props.recommendation) : null,
      h('form', { method: 'post', action: props.action },
        h('input', { type: 'hidden', name: 'token', value: props.token }),
        h('input', { type: 'hidden', name: 'set', value: props.set }),
        h('input', { type: 'hidden', name: 'qid', value: props.qid }),
        children),
      h('p', { className: 'age' }, props.footer)),
    Heading: ({ props }) => h('h' + Math.min(props.level + 1, 6), null, props.text),
    Paragraph: ({ props }) => h('p', null, renderSpans(props.spans)),
    Table: ({ props }) => {
      const head = h('tr', null,
        props.headers.map((cell, i) => h('th', { key: i }, renderSpans(cell))));
      const body = props.rows.map((row, i) => h('tr', { key: i },
        row.map((cell, j) => h('td', { key: j }, renderSpans(cell)))));
      return h('div', { className: 'tblwrap' },
        h('table', null, h('thead', null, head), h('tbody', null, body)));
    },
    Mermaid: ({ props }) => h('figure', null,
      h('img', { alt: 'diagram', src: 'https://mermaid.ink/img/' + b64url(props.code) })),
    CodeBlock: ({ props }) => h('pre', { 'data-lang': props.lang }, h('code', null, props.code)),
    List: ({ props }) => h(props.ordered ? 'ol' : 'ul', null,
      props.items.map((item, i) => h('li', { key: i }, renderSpans(item)))),
    Option: ({ props }) => h('label', { className: 'opt' },
      h('input', { type: 'radio', name: 'choice', value: props.value, defaultChecked: !!props.recommended }),
      ' ' + props.label,
      props.recommended ? h('span', { className: 'rec' }, ' recommended') : null),
    FreeText: ({ props }) => h('textarea', { name: 'text', rows: 2, placeholder: props.label }),
    Submit: ({ props }) => h('button', { type: 'submit', name: 'choice', value: props.value }, props.label),
    Clarify: ({ props }) => h('button', { type: 'submit', name: 'choice', value: 'clarify' }, props.label),
  },
});

let raw = '';
process.stdin.setEncoding('utf8');
process.stdin.on('data', (chunk) => { raw += chunk; });
process.stdin.on('end', () => {
  let spec;
  try {
    spec = JSON.parse(raw);
  } catch (err) {
    process.stderr.write('spec is not JSON: ' + err.message + '\n');
    process.exit(3);
  }
  // The guardrail runs BEFORE the render: an unregistered type or a bad prop is
  // REJECTED with the schema's own message, never rendered as nothing.
  const verdict = catalog.validate(spec);
  if (verdict && verdict.success === false) {
    const detail = verdict.error && verdict.error.message
      ? verdict.error.message.replace(/\s+/g, ' ').slice(0, 400)
      : 'spec rejected by the catalog';
    process.stderr.write('spec rejected by the catalog: ' + detail + '\n');
    process.exit(5);
  }
  try {
    const html = renderToStaticMarkup(
      h(JSONUIProvider, { registry, initialState: {} },
        h(Renderer, { spec, registry })));
    process.stdout.write(html);
  } catch (err) {
    process.stderr.write('render failed: ' + (err && err.message) + '\n');
    process.exit(4);
  }
});
