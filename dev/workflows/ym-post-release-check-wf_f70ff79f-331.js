export const meta = {
  name: 'post-release-reframe-verify',
  description: 'Adversarially verify the post-release reframing edits before the permanent Zenodo release',
  phases: [
    { title: 'Check', detail: 'four independent read-only checkers over the diff' },
    { title: 'Verify', detail: 'try to refute each serious finding' },
  ],
}
const ROOT = '<repo-root>'
const COMMON = `Repository: ${ROOT} (git). The commits 3658aa1..347e407 (two commits: a539902 and 347e407) revise a package that will be released as v0.2.0 and archived PERMANENTLY on Zenodo. The main change: on 10 Nov 2026 the Yang–Mills shepherding committee (Douglas, Gross (chair), Jaffe, Klebanov, Nekrasov) published OpenAI's Lean code (github.com/yang-mills-group/OpenAI-YM-20261028) and its assessment (github.com/yang-mills-group/YM), announced in its 3rd statement of 9 Nov (https://www.kitp.ucsb.edu/sites/default/files/3rd-Statement-About-Quantum-YangMills-Theory_Nov-9.pdf). The package had been written 3–6 Nov and called itself a 'pre-registration'; since the deposit now follows the release, that framing was removed and replaced with an honest account. The Lean statement files are deliberately unchanged.
STRICT RULES: (1) READ-ONLY: do not modify, stage, commit or push anything in ${ROOT}; scratch work only under /private/tmp. (2) INDEPENDENCE: do NOT open, read or summarize any .lean file or Lean source from the yang-mills-group repositories, nor the assessment PDF's mathematical content. You may read the KITP statement PDF and GitHub repository METADATA only (gh api repos/<owner>/<repo> for created_at/pushed_at/visibility). The package states its authors did not consult OpenAI's Lean code, and your audit must not change that.
Use 'git -C ${ROOT} diff 3658aa1 347e407' to see the changes; read whole files where context matters. Classify findings: "blocker" (false statement, privacy leak, broken build/PDF, invalid metadata, contradiction a reader would notice in the headline claims), "should-fix", "note". Report only what you observed, with file, line and evidence. An empty list is a valid result.`
const FINDINGS = { type: 'object', properties: { checker: { type: 'string' }, summary: { type: 'string' },
  findings: { type: 'array', items: { type: 'object', properties: {
    severity: { type: 'string', enum: ['blocker', 'should-fix', 'note'] }, file: { type: 'string' }, location: { type: 'string' },
    issue: { type: 'string' }, evidence: { type: 'string' }, suggested_fix: { type: 'string' } },
    required: ['severity', 'file', 'issue', 'evidence', 'suggested_fix'] } } },
  required: ['checker', 'summary', 'findings'] }
const VERDICT = { type: 'object', properties: { real: { type: 'boolean' },
  severity_confirmed: { type: 'string', enum: ['blocker', 'should-fix', 'note', 'not-an-issue'] },
  reasoning: { type: 'string' }, exact_fix: { type: 'string' } }, required: ['real', 'severity_confirmed', 'reasoning', 'exact_fix'] }
const CHECKERS = [
  { key: 'facts', prompt: `${COMMON}
LENS: factual accuracy of every NEW or CHANGED statement about events and dates. Fetch the KITP 3rd statement PDF (curl -sL -A 'Mozilla/5.0' into /private/tmp and pdftotext) and the GitHub metadata of yang-mills-group/OpenAI-YM-20261028 and yang-mills-group/YM. Check: dates (Lean code submitted 28 Oct; statement 9 Nov; publication 10 Nov), repo names/URLs, committee membership, what the 3rd statement does and does not announce (the paper says it covers only the Lean code and the assessment), the new bib entry Douglas2026g in paper/refs.bib and paper/make_refs.py (authors, title, URL, howpublished), and the claim that the work was completed on 6 Nov (compare with git commit dates of the statement files in 3658aa1 — note the history was squashed, so check what evidence the package itself offers and whether the wording claims more than that).` },
  { key: 'consistency', prompt: `${COMMON}
LENS: consistency across every outward-facing file after the edits: paper/main.tex (and the rebuilt paper/main.pdf — extract its text with pdftotext and confirm it matches main.tex, e.g. new title, abstract, 'not a pre-registration', 'Statement-file hashes', the new Pre-release audit bullet, Douglas2026g cited and present in the bibliography), README.md, .zenodo.json (valid JSON; title; description; notes; related_identifiers now pointing at /tree/v0.2.0), CITATION.cff (validate: python3 -m venv /private/tmp/cffv2 && /private/tmp/cffv2/bin/pip -q install cffconvert && /private/tmp/cffv2/bin/cffconvert --validate -i ${ROOT}/CITATION.cff), PROBLEM.md, lean/YangMills/README.md, plan/PLAN.md, library/INDEX.md, library/notes/01-problem-definition.md. Look for: any surviving claim of pre-registration or of deposit-before-release in outward-facing files (dated library notes/critiques that say 'as of 5 Nov' are acceptable snapshots, which the README now says); titles that differ between paper, Zenodo and CITATION; the 'four major fidelity defects, three fixed and one only partly' framing consistent everywhere (paper abstract, review section, Zenodo, PROBLEM.md §5, Lean README); the gap 'required not proved' wording consistent; counts (120 bibliography entries in refs.bib now) stated anywhere in prose; LaTeX log warnings (paper/main.log: overfull boxes, undefined refs). Also confirm sha256 of lean/YangMills/YangMills/{OS,Lattice,SU,Statement,OpenProblems}.lean equals the hashes printed in paper/main.tex.` },
  { key: 'honesty', prompt: `${COMMON}
LENS: honesty and over/under-claiming in the new framing, read as a skeptical referee would. Read the new paragraphs in paper/main.tex (abstract; Introduction 'The 2026 situation' and 'Why a formal statement matters now'; status table; review section item on method and representation dependence; Limitations; AI disclosure incl. the new Pre-release audit bullet and the model-version parenthetical). Questions: Is anything still implying priority or pre-registration? Is the sentence 'The author states that the statement files were not changed after the release and that OpenAI's Lean code was not consulted in writing them; this cannot be checked independently' appropriately hedged, and is it something only the human author can attest (flag it so the author confirms it personally — severity should-fix if it asserts something on the author's behalf that the author has not confirmed)? Is the 'only partly fixed' description of the method-dependence finding accurate against lean/YangMills/YangMills/Statement.lean and Lattice.lean (you may read THESE local files): does ClayYangMills really require a Wilson-lattice limit, and is the representation existential? Does 'required (by HasMassGap) only on the Hilbert space these fields generate, a subspace of the C-even sector' match the Lean definitions? Is the AI-use disclosure still accurate after this turn (e.g. 'The author read the paper before deposit' — the paper was revised after the author's reading; flag if the disclosure now overstates the author's review, and propose exact wording).` },
  { key: 'privacy', prompt: `${COMMON}
LENS: privacy/secrets in everything that will be published: the full history reachable from main (git log -p main) and especially the new commits. Look for local absolute paths (/Users/<name>, /private/tmp/claude-*), tool session UUIDs or worktree names, names of the author's unrelated private projects, personal or work email addresses or domains other than the GitHub noreply address and noreply@anthropic.com, tokens/keys, and the author's personal details. Pay special attention to the newly added dev/workflows/ym-release-audit-wf_e335562d-b29.js (a provenance copy of an audit script whose search terms were redacted) and dev/workflows/runs/*.json. Also check that no branch other than main would be published by 'git push origin main' and report what local branches/refs exist (do not delete anything). The committee's public contact address quoted from its statement is acceptable.` },
]
phase('Check')
const results = await pipeline(
  CHECKERS,
  c => agent(c.prompt, { label: `check:${c.key}`, phase: 'Check', schema: FINDINGS }),
  (r, c) => {
    if (!r) return { checker: c.key, failed: true }
    const serious = r.findings.filter(f => f.severity !== 'note')
    return parallel(serious.map((f, i) => () =>
      agent(`${COMMON}
A checker (lens: ${c.key}) reported the finding below. Independently re-examine the repository (re-run commands, re-read lines; do not trust its evidence) and try to REFUTE it. Decide real or not, and the true severity (blocker / should-fix / note / not-an-issue). If real, give the exact minimal fix (file, old text -> new text). Default to real=false if you cannot reproduce it.
FINDING: ${JSON.stringify(f)}`, { label: `verify:${c.key}#${i + 1}`, phase: 'Verify', schema: VERDICT })
        .then(v => ({ ...f, verdict: v }))
    )).then(vs => ({ checker: c.key, summary: r.summary, notes: r.findings.filter(f => f.severity === 'note'), verified: vs.filter(Boolean) }))
  },
)
return results
