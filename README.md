# A candidate Lean 4 statement of the Yang–Mills existence and mass gap problem

This repository holds a candidate formal statement, an adversarial-review methodology, a
research library, and a research programme.

> **This repository does not contain a proof of Yang–Mills existence or of a mass gap.**
> It contains a *candidate* formal statement of the Clay Millennium problem in Lean 4 with
> Mathlib, machine-checked sanity and non-vacuity results, the record of an adversarial review,
> a research library compiled and cross-checked by AI agents, and a plan for an independent proof. The statement has been
> reviewed adversarially by AI agents. It has **not** been audited by human experts.
> Its main design elements also appear in the earlier candidate statement of K. Rémondière
> ([ClayYM, Zenodo 10.5281/zenodo.23650415](https://doi.org/10.5281/zenodo.23650415)).

Read the paper first: **[`paper/main.pdf`](paper/main.pdf)**.

## Context

On 26 October 2026 OpenAI announced an AI-generated proof of the existence of 4D quantum
Yang–Mills theory, with a Lean formalization, and placed it with a shepherding committee chaired by
David Gross. When the statement, its review and the research library were completed (6 November
2026, according to the author) none of it was public; the text was revised on 10–11 November. On 10 November
2026 the committee published OpenAI's Lean code
([yang-mills-group/OpenAI-YM-20261028](https://github.com/yang-mills-group/OpenAI-YM-20261028)) and
an assessment ([yang-mills-group/YM](https://github.com/yang-mills-group/YM)) that the committee
describes as a validation that the code proves pure Yang–Mills existence. Neither is
examined here, and this deposit is **not** a pre-registration: it was made after that release (see
the paper, §1). The library notes, the plan and its critiques are dated snapshots (5–6 November
2026); apart from wording corrections made on 10 November and the status of plan item A0, they are
not updated for later events. So are the docstrings of the hashed Lean statement files. This work was undertaken under a working premise set by the
author:

> Assume OpenAI's result is correct, and aim to produce an independent result and Lean proof.

The premise is not evaluated here. The paper (§7) explains what it does and does not imply.

## Contents

| Path | Contents |
|---|---|
| [`paper/`](paper/) | The paper (`main.tex`, `main.pdf`, `refs.bib`, `make_refs.py`) |
| [`PROBLEM.md`](PROBLEM.md) | The mathematical problem: every formalization choice, the deviations from Clay with their direction, review history |
| [`lean/YangMills/`](lean/YangMills/) | Lean 4 + Mathlib statement package. See its [README](lean/YangMills/README.md) |
| [`lean/YangMills/scratch/`](lean/YangMills/scratch/) | Scratch files from the adversarial review (exploits against v0.1, some intentionally no longer compiling) and the original non-vacuity proofs |
| [`library/notes/`](library/notes/) | 11 research notes compiled and cross-checked by AI agents (problem definition; OpenAI's claim; Navier–Stokes swarm method; OpenAI's Lean repositories; Bałaban's programme; stochastic quantization; lattice results; constructive QFT; mass-gap mechanisms; Lean infrastructure; 2023–2026 frontier) plus a completeness critique |
| [`library/references.bib`](library/references.bib), [`library/INDEX.md`](library/INDEX.md) | Bibliography (666 entries, unverified ones flagged) and reading map |
| [`library/pdfs/MANIFEST.tsv`](library/pdfs/MANIFEST.tsv) | arXiv identifiers of the 121 library PDFs. The PDFs are **not** redistributed; [`scripts/fetch_pdfs.sh`](scripts/fetch_pdfs.sh) re-downloads them |
| [`plan/PLAN.md`](plan/PLAN.md) | Research and AI-orchestration plan v0.2: honest odds, milestone ladder, tracks, operating model, stop rules |
| [`plan/critique-*.md`](plan/) | Five independent critiques of plan v0.1 |
| [`dev/workflows/`](dev/workflows/) | The multi-agent workflow scripts used to produce this work (provenance) |

## Reproduce the Lean audit

You need [elan](https://github.com/leanprover/elan). Lean and Mathlib are pinned to
`v4.36.0-rc2`.

```bash
cd lean/YangMills
lake exe cache get        # prebuilt Mathlib
lake build
lake env lean YangMills/Audit.lean
```

The audit prints the axioms of every listed theorem:

* Proved theorems use only `propext`, `Classical.choice`, `Quot.sound`.
* Open problems also show `sorryAx`.
* Every `sorry` is in `YangMills/OpenProblems.lean`: four open problems plus one classical but
  unformalized consistency obligation.

## AI-use disclosure

Anthropic's Claude large language models carried out essentially all of the following:

* literature search and summaries;
* drafting of the notes, plan and paper;
* Lean design and proofs;
* adversarial review.

They were operated through the Claude Code agent environment, using multi-agent workflows, web
retrieval and the Lean toolchain.

The human author:

* set the goal and premise;
* directed the work;
* chose the publication route and licences;
* takes responsibility for publication.

Only the Lean results are machine-checked. Natural-language content was reviewed only by AI
agents. The full disclosure is §9 of the paper.

## Licence

* Lean code and scripts: Apache-2.0 ([`LICENSE-APACHE-2.0`](LICENSE-APACHE-2.0)).
* Text: CC BY 4.0 ([`LICENSE-CC-BY-4.0.txt`](LICENSE-CC-BY-4.0.txt)).
* Details are in [`LICENSE`](LICENSE).

## Citation

See [`CITATION.cff`](CITATION.cff). The Zenodo DOI will be added on the first archived release.
