// oc-questions-render.mjs — the Open Questions page renderer (#547).
//
// VERSIONED SOURCE. tools/oc-questions copies this file into the build directory
// (write-if-different) before invoking it, because ESM resolves a bare import
// from the IMPORTING FILE's own location and the node_modules that carries
// @json-render lives there. Do not edit the copy under questions/build/: the
// next render overwrites it.
//
// stdin: a json-render SPEC. stdout: an HTML FRAGMENT. Exit 3 = the spec was not
// JSON, exit 4 = the render threw. The caller falls back to its own builder on
// any non-zero exit, so this file can never leave the owner's page broken.
//
// No JSX and no build step: React.createElement only, so a plain .mjs runs as
// written. The output carries NO <script> — the page stays a static artifact,
// which is why the vpn deploy is unchanged (agents renders, vpn rsyncs, Caddy
// serves).
import { renderToStaticMarkup } from 'react-dom/server';
import React from 'react';
import { z } from 'zod';
import { defineCatalog } from '@json-render/core';
import { schema } from '@json-render/react/schema';
import { defineRegistry, Renderer, JSONUIProvider } from '@json-render/react';

const h = React.createElement;

// The catalog is a GUARDRAIL, not a formality: a spec can only name a component
// registered here, so an unknown type is rejected instead of rendering nothing.
const catalog = defineCatalog(schema, {
  components: {
    Page: { props: z.object({ title: z.string(), expires_at: z.string() }), description: 'Page root' },
    QuestionSet: { props: z.object({ set_id: z.string(), lane: z.string() }), description: 'One lane block' },
    Question: { props: z.object({
      qid: z.string(), title: z.string(), recommendation: z.string().nullable(),
      token: z.string(), set: z.string(), action: z.string(), footer: z.string(),
    }), description: 'One question and its form' },
    RichText: { props: z.object({ html: z.string() }), description: 'An already-rendered HTML fragment' },
    Option: { props: z.object({ label: z.string(), value: z.string(), recommended: z.boolean().nullable() }), description: 'A radio option' },
    FreeText: { props: z.object({ label: z.string() }), description: 'Free-text answer' },
    Submit: { props: z.object({ label: z.string(), value: z.string() }), description: 'Submit button' },
    Clarify: { props: z.object({ label: z.string() }), description: 'Clarify button' },
  },
  actions: {},
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
    // submitting -- the one regression that would break the live endpoint.
    Question: ({ props, children }) => h('section', { id: props.set + '-' + props.qid },
      h('h2', null, props.title),
      props.recommendation ? h('p', { className: 'rec' }, 'recommended: ' + props.recommendation) : null,
      h('form', { method: 'post', action: props.action },
        h('input', { type: 'hidden', name: 'token', value: props.token }),
        h('input', { type: 'hidden', name: 'set', value: props.set }),
        h('input', { type: 'hidden', name: 'qid', value: props.qid }),
        children),
      h('p', { className: 'age' }, props.footer)),
    RichText: ({ props }) => h('div', { className: 'desc', dangerouslySetInnerHTML: { __html: props.html } }),
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
