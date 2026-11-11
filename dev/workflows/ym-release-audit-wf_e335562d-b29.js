export const meta = {
  name: 'release-readiness-audit',
  description: 'Read-only pre-deposit audit of the yang-mills package before a permanent public Zenodo release',
  phases: [
    { title: 'Audit', detail: 'four independent read-only checkers' },
    { title: 'Verify', detail: 'adversarially re-check every blocker' },
  ],
}

const ROOT = '<repo-root>'
const COMMON = `You are auditing the git repository at ${ROOT} (branch main, 2 commits: bbaacdb and 9ed28eb) immediately before it is pushed to a PUBLIC GitHub repo (betterfuture2030/yang-mills-lean) and archived PERMANENTLY on Zenodo with a DOI. Nothing can be retracted afterwards. This audit is STRICTLY READ-ONLY: do not edit, create, stage, commit, push or delete anything in ${ROOT}; write any scratch output only under /private/tmp. Use 'git -C ${ROOT} ...' and absolute paths. Examine what is actually TRACKED (git ls-files) and, where stated, the full history (both commits), since history is published too. Untracked/ignored files (e.g. .lake, library/pdfs/*.pdf) are not published — ignore them except to confirm they are ignored.
Classify every finding by severity: "blocker" = must be fixed before a permanent public deposit (privacy leak, secret, false machine-checked claim, broken build, invalid metadata that would make Zenodo reject or misattribute the record, licence violation); "should-fix" = real but tolerable; "note" = cosmetic. Report only things you actually observed, with file path, line (or commit), and the exact evidence. If you find nothing in a category, say so — an empty findings list is a valid and expected result.`

const FINDINGS = {
  type: 'object',
  properties: {
    checker: { type: 'string' },
    summary: { type: 'string' },
    checks_run: { type: 'array', items: { type: 'string' } },
    findings: {
      type: 'array',
      items: {
        type: 'object',
        properties: {
          severity: { type: 'string', enum: ['blocker', 'should-fix', 'note'] },
          file: { type: 'string' },
          location: { type: 'string' },
          issue: { type: 'string' },
          evidence: { type: 'string' },
          suggested_fix: { type: 'string' },
        },
        required: ['severity', 'file', 'issue', 'evidence', 'suggested_fix'],
      },
    },
  },
  required: ['checker', 'summary', 'checks_run', 'findings'],
}

const CHECKERS = [
  { key: 'privacy', prompt: `${COMMON}
YOUR LENS: privacy, secrets and personal data — in tracked files AND in the full git history (git log -p --all, commit messages, author/committer fields of both commits).
Look for: any email address other than <author's GitHub noreply address> and noreply@anthropic.com (the publication author must NOT have a personal email published; flag any personal address [specific patterns redacted before publication]); absolute local paths (/Users/..., /private/tmp, /opt/homebrew is fine only if generic); usernames; API keys, tokens, OAuth strings, cookies; session IDs, run IDs or transcript paths of the AI tooling; exact model version identifiers (the paper is meant to say "Anthropic's Claude" generically — flag exact model version strings [patterns redacted before publication] EXCEPT that a Co-Authored-By git commit trailer naming the model is present by design: report it as a 'note' only, not a blocker); any content about the author's unrelated private projects ([specific terms redacted before publication]); personal remarks about named third-party researchers that read as defamatory or unsupported. Check dev/workflows/** and dev/workflows/runs/*.json especially carefully, and library/notes/**.` },
  { key: 'reproducibility', prompt: `${COMMON}
YOUR LENS: do the machine-checked claims hold exactly as stated?
1. In ${ROOT}/lean/YangMills, with elan on PATH (export PATH=/opt/homebrew/opt/elan-init/bin:$HOME/.elan/bin:$PATH), run 'lake build' and 'lake env lean YangMills/Audit.lean'. Report the axioms printed per theorem. The documents claim: proved theorems use only propext, Classical.choice, Quot.sound; exactly 5 declarations show sorryAx (clay_yang_mills, clay_existence, su_yang_mills_exists, su_yang_mills_mass_gap, os_nonTrivial_fullField_consistent); every sorry is in YangMills/OpenProblems.lean; su_connected, su_lieAlgebra_simple, su_mass_gap_of_clay are sorry-free. Verify each claim, and grep all tracked .lean files under lean/YangMills/YangMills for 'sorry', 'axiom ', 'admit', 'native_decide', '@[implemented_by', 'unsafe' to confirm no hidden escape hatches. (scratch/ is documented as exploratory; just confirm it is not imported by the library.)
2. Compute sha256 of OS.lean, Lattice.lean, SU.lean, Statement.lean, OpenProblems.lean and compare with the hashes printed in paper/main.tex (and anywhere else they appear: README, PROBLEM.md, .zenodo.json). Any mismatch is a blocker.
3. Confirm the committed paper/main.pdf is up to date with committed paper/main.tex: build a fresh copy in a scratch directory under /private/tmp (copy paper/ there; run 'latexmk -xelatex main.tex' there, NOT in ${ROOT}) and compare page count and extracted text (pdftotext if available, else strings) of the fresh build with the committed PDF. Report overfull boxes, undefined references/citations, missing glyphs.
4. Confirm lean-toolchain, lakefile.toml and lake-manifest.json pin what the README says (v4.36.0-rc2; Mathlib commit 9d581dfff2e41de989072ea63abf3daf69311520).` },
  { key: 'metadata', prompt: `${COMMON}
YOUR LENS: release metadata and licensing.
1. .zenodo.json: valid JSON? Validate field-by-field against Zenodo's GitHub-integration / legacy deposit metadata format (fetch the Zenodo developer docs or the zenodo/zenodo legacy deposit JSON schema from the web if you can; WebFetch/WebSearch are available). Check upload_type and publication_type values are legal and consistent (e.g. publication + preprint), creators format ("Family, Given"), license identifier spelling Zenodo accepts, related_identifiers relation/scheme values legal (isSupplementTo, references, isNewVersionOf etc.), that it does not claim a relation to Rémondière's DOI 10.5281/zenodo.23650415 that is wrong (e.g. isNewVersionOf would wrongly merge into their concept record — that would be a blocker; 'references' is correct), keywords, description HTML validity, version string. Remember: when a .zenodo.json is present, Zenodo uses it instead of CITATION.cff.
2. CITATION.cff: validate with cffconvert if installable via pip into a scratch venv under /private/tmp (python3 -m venv /private/tmp/cffv && /private/tmp/cffv/bin/pip install cffconvert && /private/tmp/cffv/bin/cffconvert --validate -i ${ROOT}/CITATION.cff); otherwise check against CFF 1.2.0 manually.
3. Version consistency: the version string in lakefile.toml, CITATION.cff, .zenodo.json, paper/main.tex, README must agree (expected 0.2.0 / v0.2.0).
4. Licences: LICENSE, LICENSE-APACHE-2.0, LICENSE-CC-BY-4.0.txt are complete official texts? Does any tracked file include third-party copyrighted material beyond fair quotation (e.g. redistributed PDFs, long verbatim passages of papers, the KITP committee statement copied in full, images)? library/pdfs/*.pdf must be untracked — confirm with git ls-files. Check library/references.bib or notes for verbatim abstracts copied from publishers at length (flag as should-fix with examples).
5. Title/author consistency across .zenodo.json, CITATION.cff, paper title page, README.` },
  { key: 'claims', prompt: `${COMMON}
YOUR LENS: statements in the published prose that would be false, misleading or embarrassing in a permanent public record. Read paper/main.tex in full, README.md, PROBLEM.md, lean/YangMills/README.md, .zenodo.json description.
Check specifically: (a) nothing claims or implies a proof of Yang–Mills existence or mass gap, and the 'no proof is claimed' framing is consistent everywhere including the Zenodo description; (b) every statement about OpenAI's announcement, the Gross shepherding committee (members: David Gross chair, Michael Douglas, Arthur Jaffe, Igor Klebanov, Nikita Nekrasov), the AGMAI group, and K. Rémondière's ClayYM deposit is accurately hedged and dated (the paper is dated 6 Nov 2026; today is 10 Nov 2026; the committee has announced it will publish OpenAI's Lean code around 10-11 Nov — flag any sentence that will become flatly false the moment that code is released, e.g. 'the Lean code has not been released' without an 'as of <date>' qualifier, as should-fix); (c) the AI-use disclosure is internally consistent (human author read the paper but has no domain expertise; natural-language content reviewed only by AI; no competing interests; self-funded; Anthropic had no role) and does not contradict anything elsewhere (e.g. README calling the library 'verified' while the paper says AI-reviewed only — note README line ~9 says 'a verified research library' and line 35 '11 verified research notes': assess whether 'verified' overclaims given notes were only AI-checked); (d) any citation in main.tex whose key is missing from paper/refs.bib, or any refs.bib entry with obviously wrong year/author/venue for a well-known work (spot-check ~25 entries including Osterwalder–Schrader 1973/1975, Jaffe–Witten problem description, Bałaban, Chatterjee, Wilson 1974); (e) numbers stated in prose (119 references, 666 bib entries, 121 PDFs, 11 notes, 5 critiques, page counts, subagent statistics) match the files. Do NOT recommend changes to wording merely for style.` },
]

const VERDICT = {
  type: 'object',
  properties: {
    real: { type: 'boolean' },
    severity_confirmed: { type: 'string', enum: ['blocker', 'should-fix', 'note', 'not-an-issue'] },
    reasoning: { type: 'string' },
    exact_fix: { type: 'string' },
  },
  required: ['real', 'severity_confirmed', 'reasoning', 'exact_fix'],
}

phase('Audit')
const results = await pipeline(
  CHECKERS,
  c => agent(c.prompt, { label: `audit:${c.key}`, phase: 'Audit', schema: FINDINGS }),
  (r, c) => {
    if (!r) return { checker: c.key, failed: true }
    const serious = r.findings.filter(f => f.severity === 'blocker' || f.severity === 'should-fix')
    return parallel(serious.map((f, i) => () =>
      agent(`${COMMON}
An auditor (lens: ${c.key}) reported the finding below. Your job is to try to REFUTE it by independently re-examining the repository yourself (do not trust the auditor's evidence; re-run the commands / re-read the lines). Decide whether it is real, and whether its true severity is blocker, should-fix, note, or not-an-issue. A blocker must be something that genuinely should stop a permanent public deposit. If it is real, give the exact minimal fix (file, old text -> new text, or command). Default to real=false if you cannot reproduce it.
FINDING: ${JSON.stringify(f)}`,
        { label: `verify:${c.key}#${i + 1}`, phase: 'Verify', schema: VERDICT })
        .then(v => ({ ...f, checker: c.key, verdict: v }))
    )).then(vs => ({ checker: c.key, summary: r.summary, checks_run: r.checks_run,
      notes: r.findings.filter(f => f.severity === 'note'), verified: vs.filter(Boolean) }))
  },
)
return results
