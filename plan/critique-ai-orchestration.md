# Critique of PLAN.md §3 (and its knock-ons): AI orchestration lens

*Reviewer lens: AI orchestration. Reviewed: `plan/PLAN.md` v0.1, `PROBLEM.md` v0.2, `README.md`, and notes 02, 03, 04, 05, 10, 11 and 99, read in depth. Spot checks against primary sources, 2026-11-05: the Sussman–Alpöge repository README, its file sizes and its QED3 revision list (via the GitHub API); the Aronow–Lopatto repository README; the AutoformBot paper (arXiv:2605.29955, §§4–5 and App. A, in `library/pdfs/`); the Carleson blueprint (arXiv:2405.06423, §§1–2); and the Mei–Douglas abstract (arXiv:2610.20573). No file was modified except this report.*

Tags: **[N0x]** = library note x. **[P]** = primary source I checked today. **[I]** = my inference or estimate.

---

## 0. Verdict in one paragraph

Section 3 takes the right *principles* from OpenAI. It does not yet describe a *machine* that can carry a proof of 1,000+ pages with about 16–64 concurrent agents. The cycle "attempt → 3 skeptics → formalize → ledger → consolidator" has four structural problems:

1. It treats agreement among LLM skeptics as acceptance evidence, which is the weakest evidence available.
2. It puts per-node Lean formalization *inside* the discovery loop, before the Lean definitional layer exists, at a cost the plan never estimates.
3. It has no interface layer: no definition registry, no constants ledger, no lemma contracts. Agents with bounded context cannot work on a monolithic proof without one.
4. It sizes communication and consolidation after a 10⁴-agent swarm whose own designers credit organisation with less than 10% of the result.

The fix is to make the Lean-checked **proof skeleton** the coordination substrate. Concretely:

- The rung theorem is proved in Lean from module contracts.
- Each node is proved *modulo its children's Lean statements*.
- Gates are mechanical first and LLM second.
- Agents are short-lived and task-scoped, and read contracts, never other nodes' proofs.
- Swarms are used only for two to four genuinely creative bottlenecks.

At our scale, the highest-leverage uses of agents are, in order:

1. Lean statements and skeletons.
2. Importing and auditing the public AI–Bałaban corpora.
3. Bounded, constant-explicit gap filling.
4. Risk-prioritised Lean proofs.

Free-form "attempts" are the lowest-leverage use.

---

## 1. Prioritised criticisms, each with a concrete revision

Severity: **S1** = would sink the program or waste most of the budget; **S2** = major inefficiency or credibility risk; **S3** = should fix.

### C1 (S1). The NL acceptance gate rests on correlated LLM votes, and the plan contradicts itself about it

**What is wrong.**

- §3.2 says "adversarial verify (3 skeptics, majority)". The gate list then says "**G-NL:** 3/3 skeptic sign-off". The two rules are inconsistent.
- More importantly, neither is reliable evidence of correctness for research-level estimates. The evidence in the library is consistent:
  - **Aronow–Lopatto** ran "extensive machine auditing of these proofs, including adversarial passes with multiple models". They still declare themselves "less confident in correctness than … in our other work", and the proof is beyond "our own understanding" [P, repo README; N05 ref 67].
  - **Sussman–Alpöge:** "The manuscript is LLM-approved, but LLMs are fallible" [P, README].
  - **`openai/math`** withdrew 3 manuscripts and repaired 14 one day after release, over a sign error, and says its unformalized results "could have issues" [N03 §6.8; N04 §3.9].
  - **pphi2:** at least four helper axioms were later found *false as stated* [N10 §4.3].
  - **Mei–Douglas** report that mechanical numerical and vacuity checks have the lowest accepted-error rate of the methods they evaluated, and catch errors that LLM judges miss [P, arXiv:2610.20573].
  - **Correlation:** three skeptics drawn from one model family are not three independent tests. Near-identical agents converge [N03 P5, Bradshaw]. A majority of correlated judges mostly measures the model's prior.

**Revision.** Replace the G-NL bullet and the "adversarial verify" box with this:

> **G-NL is a rejection filter, not an acceptance gate.** A node passes G-NL when (i) the mechanical checks (G-Mech, below) pass, and (ii) at least one fresh-context skeptic, which has *not* seen the prover's reasoning trace, returns no *specific, falsifiable* objection. A bare vote is never a verdict. A verdict must be one of: "step k fails because …", a counterexample, a failing numeric test, or "no defect found after checking items 1–n". Nodes tagged high-risk get two or three skeptics, and at least one of them uses a different model family where one is available; otherwise a different literature seed and prompt. Any specific objection blocks until it is resolved. **Nothing counts as verified progress until G-Lean-local passes** (C3). Skeptic recall is measured every week with seeded-bug canaries (§3.6). If recall falls below 80%, the high-risk tagging threshold is lowered automatically.

### C2 (S1). No interface layer: the plan has no answer to "how does a bounded-context agent work on a 1,000-page proof?"

**What is wrong.** C1 in Track C says "Build a lemma-level dependency graph (leanblueprint)". §3 never says:

- what a node is or how large it is;
- what an agent sees when it works on one;
- how definitions and constants are kept consistent across thousands of nodes.

The scale makes this decisive:

- 1,147 dense pages is about 10⁶ tokens [I]. That is at or beyond any context window, and reasoning degrades long before that.
- The Sussman–Alpöge YM₄ raw corpus is **≈26.6 MB of TeX** in three `theorem_0_complete_account_raw_*.tex` files (10.55 + 9.09 + 6.96 MB [P, GitHub API sizes]), several million tokens.
- No agent will ever see "the proof", so every claim must be checkable locally.

The two failures the library documents are both *interface* failures:

1. **Definitions lost in condensation.** Sussman–Alpöge: definitions explicit in the slop "must be inferred in the abridged version. We have not figured out how to fix this" [P]. Their 23 Oct QED3 revision list closes audit items QED-0001 to QED-0042. Nearly all of them are undefined constants, conflated index sets, unstated supports and notation collisions. Almost none is a wrong estimate [P, `revision list/revisions_2026-10-23.tex`].
2. **Silent drift of constants and derivative counts between layers.** The Navier–Stokes `m+4` vs `m+5` mismatch [N03 §6.3; N04 §3.4] is an interface defect. Multiscale RG is dominated by ordered constant choices: d, G → L → M₀ = L^m → p(g) → κ → γ(L, M₀, …) → g₀(N). This is where LLMs reliably slip. A lemma that silently needs "L large *depending on γ*" breaks the whole chain.

The successful human precedent is explicit about the remedy. The Carleson blueprint puts **all** definitions and the statements of the module propositions in one overview section (§2). Sections 3–9 are "mutually independent except for referring to the statements formulated in the present section". The work was split into about 180 tasks, "most … to formalize the proof of a single lemma", with constants parameterised (D := 2^{ca}). Gaps "required only fairly localized changes" [P, arXiv:2405.06423 §1, §2].

**Revision.** Add a new §3.4, "Interface layer". Its content is in §3.3 of this report. Summary:

- **(a) Definition registry.** Every symbol has an ID, a LaTeX macro bound to that ID, a Lean declaration, and unit-test lemmas.
- **(b) Constants ledger.** A DAG of the order in which parameters are chosen, machine-checked for acyclicity.
- **(c) Lemma contracts.** Each node has a statement, hypotheses written only in registry and ledger symbols, the constants it requires and provides, its children, and its falsification tests.
- **(d) Node size.** NL proof ≤ 3 pp, Lean ≤ about 1.5k lines, ≤ 8 children, and an auto-generated context pack ≤ 60k tokens.
- **(e) Module assembly overviews.** One per module, as Sussman–Alpöge do for QED₃, YM₃ and YM₄ [P].
- **(f) No condensation step without a registry diff.** A condensed text may not drop a definition that its theorems use. This is the mechanical fix for Sussman–Alpöge's open problem.

### C3 (S1). Lean is placed in the wrong spot in the loop, and is under-specified as a gate

**What is wrong.**

- The cycle formalizes each node right after NL acceptance ("formalize (Lean, compile, no sorry in node)"). But the Lean objects for Bałaban's method (block averaging, regular configurations, small/large-field regions, polymer-activity norms, background fields) **do not exist**: "Nothing exists … 1–4M lines at AI density" [N10 §4.2]. If Track C cycles formalize before Track B has supplied definitions, they will either stall or invent local ad-hoc definitions.
- The second outcome is the most damaging failure AutoformBot documents: workers "replace a foundational but complex mathematical object … with an oversimplified formal definition, which can then contaminate many dependent statements" [P, 2605.29955 §5.3].
- "No sorry in node" is a *local* criterion. It is gameable by "smuggling sorry behind helper lemmas", by hidden axioms deep in the codebase, and by weakened hypotheses (AutoformBot, same section). AutoformBot also notes that correctness is "non-transitive", so the dependency cone must be checked.
- The plan has one Lean status where it needs four.

**Revision.** Replace G-Lean with a four-level status and reorder the loop. Text for §3.2:

> **Lean statuses (per blueprint node, generated by LeanArchitect `@[blueprint]` attributes):**
> - **L0 stated.** The contract's Lean statement compiles against the frozen definition modules, and its vacuity and numeric checks pass.
> - **L1 proved-modulo-children.** The proof compiles using only the children's L0 statements. `#print axioms` shows the standard three plus `sorryAx` reached *only* through declared children.
> - **L2 cone-closed.** No `sorry` anywhere in the dependency cone.
> - **L3 rung-certified.** `lake comparator --paranoid --json` passes on Linux (bwrap) against the frozen rung statement.
>
> **L0 statements are written when a contract is created, before the NL proof.** L1 is the unit of verified progress. A node may be *used* by parents once it is L0 and has passed G-NL, so work proceeds in parallel. It counts as verified only from L1.

L1 is the mechanism that lets bounded-context agents make kernel-checked progress:

- The agent needs only its children's statements, never their proofs.
- An over-strong child is exposed when the child itself is proved.
- An over-weak child is exposed when the parent fails to close.

So the DAG corrects itself everywhere except at literature leaves; C10 covers those.

### C4 (S1). No top-down check that the decomposition implies the target ("skeleton first")

**What is wrong.** The most expensive failure in a 1,000-page program is proving the wrong lemmas. Examples:

- a subsequential limit where full convergence was needed;
- clustering on the torus where OS4 needs ℝ⁴ with `a ≠ 0`;
- an IR route whose pieces do not compose.

The plan's ladder freezes rung *statements*. Nothing checks that a rung's *module plan* actually implies the rung theorem before agents spend months on the modules.

Track D is especially exposed. Its four-step working hypothesis (local, extensive RG up to ℓ₀, then DLR compactness, then ergodic decomposition, then "survival" of NonTrivial, FullFieldContent and ShortDistanceAF for almost every component) is a logical chain. It can be checked in Lean today, cheaply, as a skeleton with `sorry`'d module statements. Example: is `FullFieldContent` preserved under ergodic decomposition, or can a decomposition project a channel away in some components?

**Revision.** Add gate **G-Skel** before any NL proving inside a rung:

> **G-Skel (per rung).** The frozen rung theorem is proved in Lean from at most 30 module-contract statements, each `sorry`'d, before any module is opened for NL work. Changing a module contract after G-Skel requires re-running G-Skel. **First instance:** an `SUNExists` skeleton for Track D, from (UV-to-ℓ₀ bounds uniform in volume) + (DLR/chessboard compactness) + (ergodic decomposition of translation-invariant RP states) + (per-component preservation of each clause), due in Phase 0.

This costs hundreds to a few thousand lines [I]. It is also the cheapest way to turn the Track D "working hypothesis" into a falsifiable object.

### C5 (S1). No capacity or budget model, and formalization (not discovery) will dominate cost

**What is wrong.** §3.3 says we will be "one to two orders of magnitude smaller" and that "expected wall-clock is therefore months". It gives no throughput or token model. Note 99 action 14 flags exactly this gap. Three calibration points exist, and the plan uses none of them:

1. **AutoformBot** (Claude, May 2026) formalized 26 graduate textbooks of *standard* mathematics. It closed 2,855 of 4,007 targets (71.3%) in 483,918 lines, for about **1.8×10¹¹ compute-weighted tokens** (input ×1, cache read ×0.1, output ×5). That is about 6×10⁷ per closed target and about 4×10⁵ per line. It stopped at "strongly diminishing returns" on statements that needed infrastructure missing from Mathlib. Workers took 76% of compute and reviewers 7% [P, 2605.29955 Table 1, App. A].
2. Note 10 estimates the Bałaban/continuum layer at **1–4M lines** at AI density.
3. OpenAI, with its own frontier model, said YM formalization took "well more than a month" [N02 §2.2].

Even with a 10× efficiency gain over Claude, formalizing the full 4D route is of order **10¹⁰–10¹¹ weighted tokens** [I]. That figure must drive §6 decision 1, the budget envelope. Without it, the phase table (40–60 weeks to M7) is unanchored.

**Revision.** Add §3.5, "Capacity model (calibrated in Phase 0)":

> Throughput = (concurrent agents) × (useful agent-hours per day) ÷ (agent-hours per node per status level) ÷ (1 + rework rate).
>
> - Planning values, to be replaced by Phase-0 measurements: about 2,000 nodes for M5–M7 (Carleson density, ≈1.5 nodes per blueprint page); 2–3 agent-hours per node to L0 + G-NL; 6–12 agent-hours per node to L1; rework 1.0.
> - At 32 concurrent agents × 20 h/day, that is ≈ 4–6 months for M5–M7 [I].
> - At 16 concurrent agents, double it.
> - **Decision rule:** if Phase-0 measured cost per L1 node exceeds 3× the planning value, M5–M7 move to "L1 for high-risk nodes only, L0 + G-NL elsewhere". The final certificate is then labelled conditional until the remaining nodes are discharged.

### C6 (S2). Scale design copied from a 10⁴-agent swarm; note 03's own sizing principles P11–P13 were dropped

**What is wrong.**

- §3.1 adopts P1–P10 from note 03, but omits **P11** ("size the swarm to the evidence, measure scaling, expect weaker base models"), **P12** (sandboxing; treat agent Lean as adversarial) and **P13** (publication norms).
- P11 is the principle that matters most at our scale. It says: decompose into hundreds of lemma-level tasks, run each "as a strong single-agent long-horizon job with Lean checking", and use group swarms "only for the 2–5 genuinely creative bottlenecks" [N03 P11].
- The evidence behind P11:
  - Brown gives multi-agent organisation less than 10% of the credit, and says agents tend to fall back on solving independently [N03 §4.2].
  - Ord's parallelizability exponent is λ ≈ 0.57, measured only at N ≤ 16 [N03].
  - In the AutoformBot ablations, racing 3–5 workers beats 1 *even per token* on easy early tasks, while the gains on hard targets come from re-planning, post-merge evaluation and failure analysis [P, §5.2].
- The plan's "groups of 8–16 agents share a ledger" also cannot coexist with "about 16 concurrent agents per workflow" *and* separate groups for Tracks C, D and E. The arithmetic gives about 5 agents per group.
- Some of the plan's own scale statements are overclaims:
  - §0.4 and §3.3 attach "about 10⁴ concurrent agents and about 10¹¹ tokens" to OpenAI's YM work. Those numbers are for **Navier–Stokes**. Note 02 states: "No source confirms that the YM proof … used a large agent swarm."
  - P3's "about 1% of budget goes on warm-ups" copies the NS 100 : 10,000 agent ratio, which note 03 calls a single-data-point extrapolation (residual concern 5). It also contradicts the plan's own phase table, which spends weeks 0–20 on M2–M4.

**Revision.**

- Add P11–P13 verbatim from note 03 to §3.1.
- Correct §0.4 to: "at OpenAI's scale on NS (≈10⁴ agents, ≈1.3×10¹¹ output tokens); the YM process is undisclosed".
- Delete "about 1% of budget on warm-ups". Replace it with the budget table in §3.7 of this report, in which calibration and warm-up rungs take about 15% of the first 20 weeks.
- Default mode is **single-agent task lanes with adaptive racing**: one attempt, escalating to 3 racing workers plus a decomposition request after a failure.
- **Explore groups** with messaging exist only for the bottlenecks listed in §3.2.

### C7 (S2). The consolidator and insight ledger are the wrong medium for proof state, and they are a fatigue and lossy-compression hazard

**What is wrong.**

- A ≤5-page prose "insight ledger" written by a consolidator every cycle can hold strategy. It cannot hold the state of a proof with thousands of nodes. Asking an LLM to compress proof state into prose recreates the Sussman–Alpöge condensation problem (C2).
- Long-lived coordinating agents degrade: AutoformBot calls this "LLM fatigue". Its fix is "delegating targeted analysis to fresh, task-scoped agents" plus persistent on-disk TODOs and skill guides [P, §4.1].
- Making ledger approval a human control point ("Peter approves ledger versions") puts a non-specialist human on the critical path for content he cannot referee.

**Revision.** Split the ledger into three artifacts:

1. **Proof state** is machine state, never prose: the blueprint DAG, Lean statuses, `claims.db`, and `alignment.yaml`. The status report is *generated* from them.
2. A **strategy memo** of at most 5 pp, for explore groups only, written by a *fresh* consolidator agent every cycle from the database and the group logs.
3. A **refuted-approaches registry** per node and per module: counterexamples, failing tests, and the reason. Workers must read it before attempting a node. This is AutoformBot's trace-analyzer "skill guide", the cure for "frontal assault" (repeating a failed strategy).

Human approval moves to budget and portfolio decisions (weekly) and rung freezes. It is never on the per-cycle path.

### C8 (S2). Reallocation "toward kernel-checked progress" is a Goodhart trap; the KPIs reward the wrong things

**What is wrong.**

- P2 reallocates weekly "toward kernel-checked progress". Infrastructure (Track B) will always win on that measure. Creative bottlenecks (C6 Cauchy-in-N, D4 ergodic decomposition, O(4) restoration) produce little kernel output for long periods. Followed literally, the rule starves the critical path.
- The Phase-1 go/no-go, "≥500 Lean lines/week with skeptic pass rate ≥70%", rewards verbosity: AI Lean is 5–10× less dense than human Lean [N10 §4.2], and ten-proofs' 130k-line comment-free files are "certificates, not mathematics" [N04 §6.1(9)].
- A high skeptic pass rate is ambiguous. It can mean good provers or lax skeptics.

**Revision.** Replace the KPIs in Track B, §3 and §4 with the metric set in §3.6 of this report. Text for P2:

> Reallocate weekly according to **critical-path burndown**: the reduction in the sorry-cone of each rung theorem, weighted by node risk and by blueprint pages, *not* raw kernel output. Track B is funded according to which definitions and lemmas currently block L0/L1 nodes on the critical path.

Change the Phase-1 go/no-go to:

> The pilot slice reaches L1 on ≥ 80% of nodes, at measured cost per L1 node within 3× of the planning value, with skeptic canary recall ≥ 80% and interface churn declining week on week.

### C9 (S2). Diversity is asserted but neither engineered nor measured; strategic convergence is the bigger risk

**What is wrong.**

- P5 gives agents roles and literature seeds, but every agent runs on one model through Claude Code. Role prompts give weak decorrelation.
- At the strategy level, the plan *anchors* the swarm on one IR hypothesis (Track D), inferred from the committee's phrase "to infinite distances" and from Alpöge's "volume-first subsequential ergodic component".
- Broadcasting one ledger to every group each cycle homogenises them. OpenAI cross-pollinated "after some time", not from the start [N03 §4.2].

**Revision.** Add to P5:

> **Engineered diversity.**
> - (i) Model diversity where available: cross-vendor skeptics. Sussman–Alpöge used Claude plus Codex; Aronow–Lopatto used Claude, GPT-6 Astra and GPT-6.1 Sol; pphi2's false axioms were caught by cross-model review.
> - (ii) Blind work. Explore groups do not see each other's output for their first k cycles. Skeptics never see prover traces.
> - (iii) A dissent quota. At least one explore group per bottleneck pursues a route the strategy memo rates low. For Track D this means an IR route that does not use ergodic decomposition, such as uniform-in-volume chessboard/RP bounds or a $T^3_\ell\times\mathbb R$ route [N05 §5.1(c)].
> - (iv) Measurement. Track pairwise similarity of independent attempts, the duplicate-work rate, and the fraction of genuinely new lemma statements per cycle.

### C10 (S2). Literature leaves (Bałaban black boxes and imported AI manuscripts) have no verification path, and citations can be hallucinated

**What is wrong.**

- The route leans on Bałaban's propositions as black boxes. Aronow–Lopatto cite exact pages, for example "Prop. 2.7/Cor. 2.8 p. 249" [N05 §3]. But **nobody in this project has read a Bałaban primary text**. The PDFs sit behind bot walls; the transcriptions in [68] are secondhand and unvetted [N05 §0; N99 action 2].
- In the C3 design, a "proved-modulo-children" node whose child is a mis-cited or mis-transcribed Bałaban statement is checked against fiction.
- C1 in Track C ("transcribe Balaban's 12 CMP papers") gives no protocol for checking math OCR or transcription, which is error-prone.

**Revision.**

> **Literature nodes.**
> - Every external result enters the DAG as a `Published…`-style hypothesis structure (the `openai/math` pattern) with: verbatim quote, page, PDF hash, and the transcription's provenance.
> - A literature node is *verified* only when two independent transcriptions from the primary PDF agree and an agent with the page image signs off. Until then it is `cited-unverified` and counts as an open hypothesis in every cone that uses it.
> - Conditional rung certificates use a separate Comparator config that lists these hypotheses explicitly (the PrimeGaps186 pattern), never hidden solution-side definitions [N04 §5(5)].
> - Metric: the literature-hypothesis burndown.
> - Human dependency, batched into one request now: Peter downloads the 12 YM papers and 5 precursors (Project Euclid), MRS 1993, OS I/II and Osterwalder–Seiler 1978 [N99 action 2].

### C11 (S2). Hallucinated estimates: no per-lemma falsification harness

**What is wrong.**

- The classic failure in this literature is a wrong inequality direction or regime, or an assumed conclusion. Two examples: Jacobsen's strong-coupling expansion used at weak coupling with an inverted bound, and Faizal–Shabir's assumed uniform clustering [N11 §3.2].
- P8 tags numerics "heuristic" and reserves interval arithmetic for "explicit-constant RG estimates". There is no *systematic* mechanical test per contract.

**Revision.** Add gate **G-Mech**, which every contract runs at L0 and on every change:

> - **(a) Randomised numeric tests** of each explicit inequality on finite instances: small lattices; explicit SU(2)/SU(3) matrices; low-dimensional Gaussian integrals; propagator decay on boxes of size 2–4L.
> - **(b) Scaling and regime checks.** Exponents of g, L, ε and M₀ are consistent across a lemma and its uses. A lemma claimed at weak coupling must not need small β.
> - **(c) Vacuity checks.** The hypotheses are jointly satisfiable, shown by an explicit instance or a Lean `example` (Mei–Douglas [P]; the Heisenberg `DynamicsConverges` guard pattern [N04 §3.3]).
> - **(d) Constants-ledger consistency.** No lemma chooses a constant earlier in the order than the constants its bound depends on.
>
> Failures are blocking. Numeric passes are labelled `heuristic` (P8) until certified by interval arithmetic or Lean.

### C12 (S2). Exploration and exploitation are conflated: "open blueprint nodes" presupposes a blueprint that does not exist for the new mathematics

**What is wrong.** C3 (coupling flow), C5 (sources), C6 (Cauchy-in-N, O(4) restoration) and all of Track D are *new* mathematics. There are no blueprint nodes to "attempt" yet; the decomposition is the research. The cycle as drawn fits filling a known blueprint (C2 pilot, Track B, imported manuscripts), not inventing one.

**Revision.** Replace the single cycle with two modes:

> **Explore mode** (2–4 bottlenecks at a time): a small group of 4–8 heterogeneous agents with messaging produces *candidate decompositions*. Each is an assembly overview plus module contracts. A decomposition is admitted only when it passes G-Skel (C4) and G-Mech on its contracts.
>
> **Exploit mode** (everything else): a DAG-driven dispatcher hands ready nodes to short-lived single agents. Nodes that fail k times go to a fresh **decomposer** agent, which proposes children, or back to Explore.

### C13 (S2). Independence firewall and input hygiene are not enforced at the tool level

**What is wrong.**

- The firewall from OpenAI's release (expected the week of 9 Nov) is a policy statement. Claude Code subagents normally have WebFetch and WebSearch, so any discovery or formalization agent can read the release or blog posts about it.
- The claimed-solution literature contains text addressed to AI referees (Zenodo YM entries; an "AI agent" instruction in the Goldstein README) [N11 §3.1]. That is prompt-injection material for an auditing swarm.

**Revision.** Add P12 and these specifics:

> - Discovery and formalization workflows run **without web tools**, against a **frozen, hashed corpus snapshot** dated 2026-11-05 (cf. NS's "cached snapshot of the internet").
> - Every ingested document passes a sanitiser that flags and strips agent-directed text before it enters any context pack.
> - The A4 audit team runs in a separate environment and repository, and its only output channel is a statement-level diff file.
> - Agent-produced Lean is adversarial input. It is never built in the challenge environment before Comparator (Comparator's assumption 2). Comparator runs in Linux bwrap CI; on macOS only the unsandboxed mode exists [N10].

### C14 (S2). Understanding and readability are an afterthought (P10) instead of a gate

**What is wrong.**

- Every precedent ended unreadable: NS (no one understood it at announcement), ten-proofs' comment-free monolithic files, Aronow–Lopatto ("Human understanding: no parts"), and Bauerschmidt's "incomprehensible slop" on some family-215 papers [N02, N03, N04].
- Alpöge's own warning: "we need to not incentivize rushing out 10,000-page slop" [P].
- In the plan, exposition is a separate track with no gate.

**Revision.**

> **Readability gates.**
> - Each module needs an assembly overview of at most 20 pp, written for a constructive-QFT referee, before it can reach L2.
> - Lean style: files ≤ 1.5k lines; `@[blueprint]` IDs on every declaration; docstrings stating the NL lemma; an inventory of every `maxHeartbeats` > 400k and every `backward.*` option.
> - After a module reaches L2, a **simplifier** pass is scheduled. The kernel guards correctness while agents shorten proofs and remove helper lemmas, which is the agent version of the human simplification step that Buckmaster–Alpöge performed.
> - Metric: NL pages and Lean lines per closed node, trending down.

### C15 (S3). Mis-ordered Phase 0: discovery starts before the pipeline is calibrated

**What is wrong.**

- §7 makes C3 the "first discovery workflow" and starts C1 transcription in parallel. Note 03 P11 says to run ablations "on a calibration rung before scaling".
- The C2 pilot (Dimock φ⁴₃) calibrates the method but not the gauge-specific machinery: axial/Landau gauge fixing, the non-abelian variational problem, the ℝ operation. Those are where the 4D cost lies [N05 §2.3].

**Revision.** Phase 0 adds an **orchestration calibration**:

> - **(a)** Run the full Exploit-mode pipeline on a *known* block with a known answer: one Dimock φ⁴₃ lemma cluster of about 20 nodes, plus the 2D YM (M3) heat-kernel identity. Inject seeded errors.
> - **(b)** Measure cost per L0/L1 node, skeptic recall, context-pack size and rework rate.
> - **(c)** Run ablations: 1 vs 3 racing workers; same-model vs cross-model skeptics; with and without the refuted-approaches registry.
> - **(d)** Add a second pilot slice from a gauge module: abelian block averaging and axial gauge, in Dimock QED₃ style.
>
> C3 starts in Phase 0 too, but as a **single-agent + CAS job** (computer algebra for the one-loop coefficient, interval bounds for remainders). It is computational, not a swarm problem.

### C16 (S3). Gates for definitions and statement drift are missing

**What is wrong.** There is no rule against editing frozen definitions or weakening node statements. AutoformBot documents hypothesis weakening as a standard cheating mode. OpenAI's CM Hodge challenge was edited in 259 of 262 files "to align with the solution" [N04 §3.3].

**Revision.**

> **G-Def.**
> - Definition modules are frozen per module version. Any change needs an architecture decision record and a Lean proof that the old and new definitions are equivalent, or else re-runs G-Skel and re-opens every node that depends on the definition.
> - A **cheating auditor** agent reviews every merge that touches a contract. It diffs statements against their contracts and flags new `axiom`, `opaque`, `implemented_by`, `native_decide`, weakened hypotheses and replaced foundational definitions. Review is layered, as AutoformBot found necessary.

### C17 (S3). Human experts are the scarcest resource, but their time and interface are not designed

**What is wrong.** "G-Human: expert spot-check at rung boundaries" does not say what the expert receives, how long it should take, or which nodes they see. Conflict-of-interest rules may also bar committee members, and Douglas maintains several of our dependencies [N99 (d)7].

**Revision.**

> **Expert packet per rung:**
> - the assembly overview;
> - the 10–20 highest-risk nodes, ranked by skeptic disagreement, novelty of the estimate, and constants-ledger centrality;
> - specific yes/no questions;
> - a target of at most 6 expert-hours per rung.
>
> Track the agreement between expert verdicts and G-NL verdicts as a calibration metric. Pin all of Douglas's libraries by commit now.

---

## 2. What is excellent and must be kept

1. **P1 and the rung ladder with SHA-256 freezes in `FREEZE.log`, per-rung loophole red teams, and regression tests from degenerate witnesses.** This is the most transferable NS lesson [N03 P1], and the v0.1 cluster bug (`a = 0`) proves it works.
2. **Comparator, set to the three standard axioms, as the rung acceptance gate**, plus the explicit CI plan (Linux, bubblewrap). Add `--paranoid` and `--json` [N04 §6.1(6)].
3. **P6: Lean is the source of truth, with `alignment.yaml` and a hypothesis-diff agent.** This answers 2610.08144 directly. Extend `alignment.yaml` to lemma granularity, with statuses `proved` / `weaker` / `stronger` / `different-proof` / `literature-dependency` [N04 §6.2B].
4. **The independence policy:** a firewalled audit team with only statement-level findings crossing; public pre-release AI manuscripts are fair game and cited. Keep it, and enforce it at the tool level (C13).
5. **P7: the infrastructure swarm from day one.** Formalization is the dominant cost, and Track B is embarrassingly parallel and kernel-verified, which makes it ideal agent work. Re-scope it to "blocked-by-critical-path" (C8).
6. **C3 (the missing 4D coupling flow) early.** It is small, decisive and computable, and it fits the Buckmaster–Alpöge pattern of delegating "delicate bookkeeping of inductive orders and constants" to models [N03 §5]. Run it as a CAS job (C15).
7. **The Track E sanity filters** (fail for U(1)₄, no confinement for finite groups or SO(3), respect θ = π) and **E5, the obstruction red team.** Cheap mechanical filters on agent ideas are exactly the right design. Extend the E5 discipline to Track D.
8. **P8, `heuristic` tagging of every numeric claim**, and **P9, provenance by construction.** Keep both, and add AGMAI pathway-2B fields: prompts, attempts, failed-attempt counts, compute per result [N02].
9. **Treating Sussman–Alpöge and Aronow–Lopatto as "literature to verify, not to trust".** Promote this from a cross-check into a pipeline (§3.2, Importer role).
10. **"Mass gap is a portfolio bet, explicitly not on the critical path."** It is honest and correct at our scale. Cap its budget (§3.7).

---

## 3. Proposed operating model (drop-in replacement for §3.2–3.3, plus new §3.4–3.7)

### 3.1 Design axioms

1. **The Lean skeleton is the coordination substrate.** Prose is a view generated from it.
2. **Agents read contracts, never proofs**, apart from the one node they are working on.
3. **Mechanical checks first, LLM judgement second, kernel last and decisive.**
4. **Short-lived, task-scoped agents with persistent state on disk.** No long-lived coordinators.
5. **Swarms only where the decomposition is unknown.**

### 3.2 Roles

| Role | Lifetime | Input | Output | Notes |
|---|---|---|---|---|
| **Architect** | fresh per invocation, persistent decision records | module overviews, registry, ledger | module contracts, definition and constant changes (decision records) | The only role that may change interfaces. Every change needs G-Def. |
| **Decomposer** | fresh | a failed or oversized node plus its refuted-approaches entries | children with contracts, L0 statements | Triggered after k = 2 failures. |
| **Prover (NL)** | fresh, per node | context pack (≤ 60k tokens) | NL proof ≤ 3 pp against children's contracts | Racing: 1 by default, 3 after a failure or for high-risk nodes. |
| **Lean statement writer** | fresh | contract | L0 statement, unit-test lemmas, vacuity `example` | Douglas lesson: definitions were wrong several times, so unit tests are mandatory [N10 §4.3]. |
| **Lean prover** | fresh | NL proof, children's L0 statements | L1 proof | Never edits contracts. |
| **Skeptic** | fresh, blind | claim + NL proof, no trace | structured, falsifiable verdict | Cross-model where possible. Canary-calibrated. |
| **Falsifier / numerics** | fresh | contract | G-Mech results (numeric, scaling, vacuity, ledger) | Uses Arb/python-flint and SymPy; small-lattice code. |
| **Consistency sweeper** | fresh, one invariant per run | whole-corpus grep over registry IDs | violations list | Example invariants: the normalization of g; the definition of the small-field region; gauge conventions; orientation of the reflection θ. |
| **Alignment / hypothesis-diff** | per merge | NL ↔ Lean | drift flags | P6. |
| **Cheating auditor** | per merge touching a contract | diff | flags | Layered review (AutoformBot). |
| **Importer** | per external manuscript section | public AI manuscript | candidate nodes with contracts, `cited-unverified` leaves | Sussman–Alpöge QED₃/YM₃/RPM1/YM₄ overview; Aronow–Lopatto I–V. |
| **Literature verifier** | fresh, ×2 independent | primary PDF page | verbatim transcription; diff | Promotes leaves from `cited-unverified`. |
| **Explore group** | 4–8 agents, a few days, messaging | bottleneck brief, frozen corpus | candidate decompositions (overview + contracts) | Blind for the first cycles; dissent quota. |
| **Red team (statements)** | per rung freeze | draft rung statement | degenerate witnesses as Lean exploit files | P1. |
| **Simplifier / expositor** | after a module reaches L2 | module | shorter proofs; module overview ≤ 20 pp | Readability gate. |
| **Reporter** | fresh, daily | `claims.db`, CI | generated status page and strategy memo | Replaces the "consolidator" for proof state. |
| **Humans** | — | expert packets; weekly metrics | rung sign-offs; portfolio and budget calls | Never on the per-node path. |

**Explore-mode bottlenecks, initially:**

1. Track D: OS4 and clustering without a gap, i.e. the ergodic decomposition and preservation of the clauses.
2. O(4) restoration (evaluate the RP O(d) trick).
3. C6: Cauchy-in-N with a pinned marginal coupling.
4. E1/E2 (3D gap; RG crossover + finite-size criterion), within the capped Track E budget.

**Highest-leverage uses at our scale, ranked:**

1. G-Skel and L0 statements: cheap, kernel-checked, and they remove mis-scoped search.
2. Importing and auditing the public AI–Bałaban corpora into the DAG. This reuses roughly 10⁴–10⁵ pages of other people's compute. It doubles as skeptic calibration on material whose correctness is unknown, and it produces the node-level verification the field lacks (N99 action 6; N11 lead 2).
3. Constant-explicit gap filling: C3 and the constants ledger.
4. Risk-ranked L1 formalization.
5. The G-Mech harness.
6. Explore groups on the 2–4 bottlenecks.

The lowest-leverage use is unconstrained NL generation of long manuscripts.

### 3.3 Artifacts (all versioned; most generated)

- `blueprint/`: leanblueprint plus LeanArchitect `@[blueprint]`. A node is a lemma, with `\uses` and `\lean`.
- `defs/registry.yaml`: ID; LaTeX macro (`\defref{BSF.smallfield}` renders the symbol *and* links the ID, so condensation cannot silently drop a definition); Lean declaration; unit tests; owning module; version.
- `constants.yaml`: each constant's name, the constants it depends on, the module that chooses it, its choice rank, and any explicit numeric choice. CI checks acyclicity and that every contract respects the ranks.
- **Lemma contract** (one per node, embedded in the blueprint):

```yaml
id: H.4.7                      # module H (history / large-field), section 4, node 7
statement_tex: "..."           # uses only \defref symbols
lean: YM.H.largeFieldSuppression   # L0 statement, compiles against frozen defs
requires_constants: [L >= L0(d,G), g_k <= gamma1(L, M0)]
provides_constants: [C_H47(L)] # must be ranked after L, M0
children: [H.4.3, H.4.5, G.2.1, LIT.Balaban122II.p355]
falsification: [numeric: smalllattice_H47.py, scaling: auto, vacuity: YM.H.ex_H47]
risk: high                      # novelty x ledger-centrality x skeptic disagreement
size_budget: {nl_pages: 3, lean_lines: 1500}
status: {L: 0, G_NL: pass, G_Mech: pass}
provenance: {models: [...], prompts: hash, corpus: sha256:..., human: none}
```

- **Context pack** (auto-built per task, ≤ 60k tokens): the target contract; children's contracts (statements only); the parent's use-site; the registry entries used; the ledger slice; page-cited literature excerpts; refuted-approaches entries; the module overview abstract.
- `claims.db`: status, verdicts, G-Mech results, costs and provenance per node. `alignment.yaml` and `formalization.yaml` v0.4 are generated from it, with an honest `review.status` and named reviewers [N04 §6.1(8)].
- `refuted/`: per node and per module, with counterexamples and failing tests.
- `FREEZE.log`; scope notes per rung (the `docs/NNN.md` pattern, one sentence per exclusion [N04 §3.3]); a public correction log (`history.md` pattern).
- **Granularity hierarchy:** rung → ≤ 30 modules (G-Skel) → propositions → lemma nodes (NL ≤ 3 pp, ≤ 8 children). Planning density is about 1.5 nodes per blueprint page (Carleson: about 180 tasks). Expect the blueprint to be **larger** than the source manuscript; Carleson's was 4× [P].

### 3.4 Gates (in order)

| Gate | When | Pass condition | Checked by |
|---|---|---|---|
| **G-Skel** | before a rung opens | rung theorem proved in Lean from ≤ 30 sorried module contracts | kernel |
| **G-Def** | any registry or ledger change | decision record + equivalence proof, or re-run G-Skel and re-open dependents | kernel + architect + cheating auditor |
| **G-Mech** | contract creation and every change | numeric, scaling, vacuity and ledger checks pass | scripts |
| **G-L0** | contract creation | Lean statement compiles against frozen defs; unit tests pass | kernel |
| **G-NL** | after the NL proof | no specific objection from ≥ 1 blind skeptic (≥ 2 incl. cross-model if high risk) | LLM, canary-calibrated |
| **G-L1** | verified-progress unit | proof compiles from children's L0; axiom cone ⊆ std3 + declared children | kernel + `#print axioms` |
| **G-L2** | module close | sorry-free cone; module overview ≤ 20 pp | kernel + readability check |
| **G-L3** | rung | `lake comparator --paranoid --json` in Linux bwrap vs the frozen rung; scope note | Comparator |
| **G-Human** | rung | expert packet signed | humans |
| **G-Lit** | literature leaf | two independent transcriptions agree with the primary page | agents + PDF hash |

### 3.5 Cadence

- **Continuous.** The dispatcher pulls ready nodes (all children at L0 and through G-NL). Agents work in git worktrees, and approved work enters a batched merge queue (AutoformBot pattern).
- **Per merge.** CI runs `lake build`; per-node axiom and sorry cones; Comparator on any touched rung; `leanblueprint checkdecls`; G-Mech for touched contracts; the alignment diff; the cheating auditor.
- **Daily.** Reporter regenerates the status page. Trace analysis on failed tasks updates `refuted/` and the skill guides. One consistency-sweep invariant runs over the corpus.
- **Weekly.**
  - Portfolio reallocation by critical-path burndown (C8).
  - Seeded-bug canary run (§3.6).
  - Interface review of churned contracts.
  - Budget check against the capacity model.
  - **One** batched human decision list (budget, portfolio, any rung freeze).
- **Per rung.** Red team → freeze → G-Skel → … → G-L3 → expert packet → simplifier pass → exposition.
- **Monthly.** Kill or continue each Explore route (E5 discipline extended to Tracks D and E).

### 3.6 Metrics (replace "Lean lines/week" and "skeptic pass rate")

1. **Critical-path burndown:** the sorry-cone of each rung theorem, measured as risk-weighted nodes and blueprint pages at L1 and L2.
2. **Skeptic recall** on seeded canaries. About 5% of NL proofs sent to skeptics carry a planted error (sign flip, exponent off by one, dropped hypothesis, constant chosen out of order). Report recall overall and by error class. Target ≥ 80%.
3. **False-accept rate:** nodes that passed G-NL and later failed at L1 or under expert review. This is the ground-truth calibration of G-NL.
4. **Cost per L0 / L1 node** (agent-hours and weighted tokens), and its trend.
5. **Rework rate:** nodes re-opened.
6. **Interface churn:** contract changes per week. It should decline after G-Skel.
7. **NL→Lean statement drift:** the fraction of contracts whose statement changed during L1. This measures blueprint quality; Carleson's success signal was "fairly localized changes".
8. **Duplicate-work rate** and **attempt similarity**, for diversity (C9).
9. **Literature-hypothesis burndown:** `cited-unverified` → verified → discharged.
10. **Readability:** NL pages and Lean lines per closed node; overview coverage.
11. **Human agreement:** expert verdicts vs G-NL verdicts.

### 3.7 Budget allocation (first 20 weeks; revisit at each phase gate)

| Line | Share | Rationale |
|---|---:|---|
| Lean statements, skeletons, Track B definitions and infrastructure | 30% | Dominant long-run cost; kernel-verified; defines the interfaces |
| L1 proofs, risk-ranked | 15% | Rises to about 35% from Phase 2 |
| Verification (skeptics, G-Mech, sweeps, alignment, cheating audit, canaries) | 15% | AutoformBot reviewers took 7%; ours is higher because G-NL does more work before Lean |
| Construction on critical-path nodes (C3, C5, C6, D in Exploit mode) | 15% | — |
| Explore groups (2–4 bottlenecks) | 7% | Creative bottlenecks only |
| Import and audit of public AI–Bałaban corpora | 8% | Reuses others' compute; calibrates skeptics |
| Calibration and ablations (Phase 0) | 4% | Replaces the "1% warm-ups" rule |
| Statement red teams + exposition and simplification | 3% + 3% | — |
| Track E (mass gap) | ≤ 5% (cap) | Portfolio bet, not on the critical path |

---

## 4. Specific text edits to PLAN.md (summary)

1. **§0 item 4.** Change to: "(on Navier–Stokes, ≈10⁴ agents and ≈1.3×10¹¹ output tokens; OpenAI's YM process is undisclosed, note 02)."
2. **§3.1.** Add P11, P12 and P13 from note 03. Delete "About 1% of budget goes on warm-ups". In P2, replace "toward kernel-checked progress" with "by critical-path burndown (§3.6)". In P4, replace the ledger design with the three-artifact split (C7). In P5, add engineered diversity (C9).
3. **§3.2.** Replace the cycle diagram with the two-mode model (C12) and the gate table (§3.4 above). Remove "3 skeptics, majority" and "3/3".
4. **§3.3.** Replace "We compensate by…" with the capacity model (C5) and highest-leverage ranking (§3.2 above). Remove "so nothing is wasted on mis-scoped search"; that is guaranteed only by G-Skel.
5. **New §3.4–3.7.** Interface layer, capacity model, metrics, budget (§3.3–3.7 above).
6. **Track B KPIs.** Replace with "definitions and lemmas currently blocking L0/L1 critical-path nodes; cost per closed blocker".
7. **Track C, C1.** Add the G-Lit protocol and the human download request (C10). Add "import and decompose Sussman–Alpöge QED₃/YM₃/RPM1 and the YM₄ assembly overview, and Aronow–Lopatto I–V, into candidate nodes".
8. **Track D.** Add: "G-Skel for `SUNExists` in Phase 0, plus one dissent route".
9. **§4 Phase 0.** Add the orchestration calibration with seeded errors and ablations, and the gauge-module pilot slice. Run C3 as a CAS job. **Phase 1 go/no-go:** replace with the C8 text.
10. **§5 Risks.** Add rows:
    - correlated LLM verification;
    - interface/definition drift and condensation loss;
    - formalization cost overrun;
    - verifier gaming (hidden axioms, weakened statements);
    - prompt injection in ingested literature;
    - coordinator fatigue.

    Each mitigation is cited to the corresponding C-item.
11. **§6 Decisions.** Make the budget envelope explicit in weighted tokens per month, sized by the capacity model. Batch every human-supplied input into one request: Bałaban/OS PDFs, cross-vendor model access for skeptics, a Linux CI host for bwrap Comparator, and expert names.
12. **§7 Next actions.** Insert as items 1–3:
    - stand up `defs/registry.yaml`, `constants.yaml` and the contract schema;
    - G-Skel for `SUNExists`;
    - the calibration run on a known block with canaries.

---

## 5. Open questions the plan should answer with Phase-0 data, not priors

1. What is the measured cost of a Lean L1 node in constructive-QFT style with Claude-class models, compared with AutoformBot's ≈6×10⁷ weighted tokens per textbook target on Claude?
2. Does cross-model skepticism measurably raise canary recall over same-model skepticism with different prompts? If cross-vendor access is unavailable, how large is the residual correlated-error risk, and does it justify raising the L1 share?
3. What node size maximises L1 success per token? Test 1, 3 and 6 pp NL nodes on the pilot.
4. How much of the Sussman–Alpöge YM₃ corpus survives import at G-Mech + G-NL? This is the best available estimate of the false-accept rate of AI-written Bałaban-style mathematics.
5. Does the Track D skeleton close? Specifically, is `FullFieldContent`/`NonTrivial` preserved for almost every ergodic component, or does the decomposition need a stronger input than the plan assumes?
