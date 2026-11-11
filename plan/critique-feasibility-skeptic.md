# Critique of PLAN.md v0.1: feasibility, honesty and risk (skeptic lens)

*Reviewer lens: a skeptical senior mathematician. I read `plan/PLAN.md`, `PROBLEM.md`, `README.md`,
`lean/YangMills/YangMills/{Statement,OpenProblems}.lean`, and in depth notes 02, 03, 04, 05, 10, 11
and 99, with targeted reads of 07 and 09. Live checks on 2026-11-05: (i) `git log` in the workspace
reports no commits on `master`; (ii) the `openai` GitHub org has no Yang–Mills repository yet (newest
repos are from 19–21 Oct); (iii) the Sussman–Alpöge repository was last pushed on 2 Nov and has no
LICENSE file, but its README grants use of the documents for any purpose and invites collaboration.
No file other than this report was modified.*

---

## 0. Verdict in eight lines

1. **Keep the architecture.** Bałaban UV, then a gapless IR step, under a ladder of frozen,
   adversarially reviewed Lean statements gated by Comparator. Every serious 2026 effort converges on
   it (note 11 §7.1).
2. **The schedule is a stretch target, not a forecast.** It is optimistic by about two orders of
   magnitude for Lean and about one for natural language (NL). At our scale I put the chance of a
   Comparator-checked M7 by week 60 at **≤1–3%**. Page one should say so.
3. **The premise is over-read.** It makes *OpenAI's* (still unknown) theorem true. It does not make
   our stronger `SUNExists` true, and `SUNExists` is not `ClayExistence`.
4. **The firewall is incoherent as written, and costly.** It leaks through "statement-level"
   findings, through Peter, through model upgrades and through the web. It also throws away the one
   resource that would make the timeline plausible. Replace it with an explicit post-release fork
   that Peter decides.
5. **There are no stop rules.** §5 relies on them as a mitigation but never defines them. I propose
   nine (§3 below).
6. **The plan drops P11–P13 of note 03.** These are the three principles on capacity calibration,
   integrity/safety and publication norms, i.e. the ones that bear on this lens. Restore them.
7. **The highest expected-value outputs are cheap and time-critical,** and should be the Phase 0–1
   product:
   - pre-register the statement *before* OpenAI's release;
   - a mechanical, firewall-safe release-day audit kit;
   - Linux replays of family 215 and the Douglas libraries;
   - the primary-source check on Bałaban's "Theorem 2";
   - a contribution to Sussman–Alpöge's open collaboration (QED₃, RPM1);
   - Mathlib-quality infrastructure, and Bałaban's foundational papers in Lean.
8. **Ethics.**
   - Contact Sussman–Alpöge before any Track C4/D work: Track D is essentially their YM₄ "C/K" modules.
   - Meet AGMAI pathway 2B disclosure by design.
   - Respect the committee's conflict-of-interest (COI) rules.
   - Never announce by press release.

---

## 1. Honest odds, and how to present them to Peter

### 1.1 Calibration evidence the plan does not confront

| Data point | What it says | Source |
|---|---|---|
| OpenAI YM | NL proof dated 9 Sep, 8 days after the 1 Sep launch on the Millennium problems (YM's own start date is unpublished). Lean took another **37 days** by OpenAI's own account (over a month), on an internal model OpenAI describes as well beyond GPT-6 Astra. Even with the NL proof in hand and frontier resources, Lean took over 4× as long as discovery. | notes 02 §2.2, 03 §3 |
| OpenAI NS | ~10⁴ concurrent agents, 88 h, 1.3×10¹¹ output tokens for the NS stage. Noam Brown gives multi-agent organisation **<10%** of the credit; base-model strength dominated. | note 03 §4.1, §4.2 |
| Sussman–Alpöge (Claude-based, the closest analogue to us) | Two domain experts (one at Anthropic) over ~8 weeks (8 Sep → 5 Nov). Results: QED₃ (4,007 pp of raw output → 242 pp); YM₃ (~30k → 2,058 pp, unverified); YM₄ ~61k raw pages, ~20k closed. Their YM₄ Target Theorem A is marked unproved. **No Lean at all.** | notes 02, 05 §3.9, 11 §2.2; README checked live |
| Aronow–Lopatto | ~1,479 pp for the **3D torus alone**. The authors say it is beyond both their own understanding and autoformalisation. | note 11 §2.2 |
| Lean volume | YM-specific layer: 0.2–0.6M lines at human density, **1–4M** at AI density. The compact-Lie-group layer (15–40k / 50–200k lines) is absent everywhere. Wilson-action reflection positivity (RP) is not in Lean. | note 10 §4.2 |
| Our capacity | ~16 agents per workflow on public models. Saturated, that is roughly 10⁸ output tokens/day (my estimate: 16 × ~70 tok/s × 86,400 s). Matching the *NS-stage* token count alone would take **~3–4 years** of one saturated workflow. | plan §3.2; my arithmetic |

### 1.2 Probability table (subjective; to be re-estimated at each stop-rule checkpoint)

Budget tiers over a 12-month programme. The token-to-dollar conversion is order-of-magnitude only
(list prices of very roughly $15–75 per million output tokens; use the real rate).

- **T1 (shoestring):** ≤2×10⁹ output tokens (one workflow at ~10% duty); no paid experts; ~$10⁴–10⁵.
- **T2 (sustained):** 1–3×10¹⁰ tokens (1–3 saturated workflows); 2–3 paid expert consultants at
  5–10% time; ~$10⁵–2×10⁶.
- **T3 (NS-scale):** ~10¹¹ tokens plus experts; ~$10⁶–10⁷.

The "clean-room" rows assume the firewall stays up.

| Milestone | T1, 12 mo | T2, 12 mo | T2, 36 mo | T3, 12 mo | T3, 36 mo |
|---|---|---|---|---|---|
| Statement pre-registered + audit kit + Linux replays | 95% | 95% | – | 95% | – |
| M1 fully closed (incl. free-field consistency) | 50% | 85% | 95% | 90% | – |
| Dimock φ⁴₃ part I (small fields) Comparator-checked in Lean | 10% | 35% | 75% | 55% | 85% |
| Bałaban foundations [1]–[7] (CMP 95–102) in Lean | <2% | 5–10% | 30–45% | 20–30% | 60% |
| M4-audit: structural audit of Sussman–Alpöge YM₃_I with spot-checked lemmas | 40% | 80% | – | 90% | – |
| M4-Lean (3D T³ continuum limit, Comparator) | <1% | 2–5% | 10–20% | 10–20% | 30–45% |
| M7-NL (complete blueprint-level NL proof of *our* `SUNExists`, calibrated gates) | <1% | 2–5% | 8–15% | 10–20% | 25–40% |
| **M7-Lean, clean-room** | ≈0 | **≤1%** | **3–8%** | 2–5% | 10–25% |
| M7 via **Bridge** (prove `theirs ⇒ ours` in Lean after release) | conditional | conditional | conditional | conditional | – |
| M8 (3D mass gap) | <0.5% | <0.5% | ~1% | <1% | 1–2% |
| **M9 (4D mass gap)** | ≈0 | <0.1% | <0.5% | <0.2% | <1% |

**Bridge row.**
- If OpenAI's statement implies ours up to bookkeeping: 60–80% within 3 months at T2.
- If `ShortDistanceAF`, `FullFieldContent`, OS4 or E0′ must be added: ≤10–15% within 12 months,
  because those clauses force you back inside their construction.

**Why M7 clean-room is this low, even granting the premise:**
1. The best-equipped Claude pipeline (Sussman–Alpöge, with experts and likely more compute) has not
   finished the NL proof of a *weaker* target (Target Theorem A) after ~8 weeks.
2. Our M7 is *stronger* than that target (see C-2).
3. Lean adds 1–4M lines of missing infrastructure.
4. The base model, which by Brown's account dominates, is not OpenAI's.

**Upside factors:**
- ~20k closed pages of public YM₄ output;
- OpenAI's release, if it is consumed rather than firewalled;
- fast model improvement (which, however, is a contamination channel; see C-4).

### 1.3 Replacement text for the top of PLAN.md (insert as §0.0)

> **Honest odds (v0.2).** The existence programme is a long-shot option on top of a portfolio of
> durable deliverables, not a schedule. At a sustained budget of ~10¹⁰ tokens/year, the modal
> outcome after 12 months is:
> - a pre-registered, audited Lean statement of the problem (formal-conjectures has none);
> - a published, Comparator-replayed audit of OpenAI's release;
> - 10–30k lines of Mathlib-quality infrastructure (Haar bi-invariance, SU(N) facts,
>   Osterwalder–Seiler RP of the Wilson action, the transfer matrix, polymer expansions);
> - a Lean formalization of part of Dimock's φ⁴₃;
> - an audit contribution to the public 3D manuscripts;
> - a written analysis of Bałaban's coupling flow.
>
> A clean-room, Comparator-checked `SUNExists` within 12 months is ≤1%, and within 36 months 3–8%.
> The 4D mass gap is <0.5% at any budget we can afford; we pursue it only as a capped research
> portfolio. These numbers are re-estimated at each stop-rule checkpoint (§4.1) and reported in
> every status update.

---

## 2. Prioritized criticisms, each with a revision

### Critical

#### C-1. The phase table and gates are unrealistic and internally inconsistent

**Problem.** §4 schedules four things:
- M2 and M3 "frozen and proved" in weeks 2–8;
- M4 (3D on T³) in NL *and Lean* in weeks 8–20;
- M5–M6 in weeks 20–40;
- M7 with a Comparator pass in weeks 40–60.

The evidence in §1.1 puts the Lean critical path at 1–4M lines.

**The Phase 1 gate is self-defeating.** It reads "≥500 Lean lines/week with skeptic pass rate ≥70%".
At 500 lines/week, 1M lines takes ~2,000 weeks. The target is so low it would pass a failing
programme. Raw lines are also gameable, and a 70% "pass rate" rewards lax skeptics.

**Two further inconsistencies:**
- P3 says "about 1% of budget goes on warm-ups". Yet warm-ups M2→M4 occupy weeks 2–20 of 60,
  roughly 30% of wall-clock.
- M4 is not a "Euler warm-up". Euler was ~100 agents × 50 h, ~1% of NS (note 03 §4.1). The 3D
  manuscripts run to 1,479–2,058 pp, comparable in size to the 4D target.

**Revision.**
- Replace §4 with the table in §5 below, and label it **"stretch schedule; see §0.0 for odds"**.
- Replace the Phase 1 gate with stop rule SR3. Set the throughput target from the pilot: closed,
  Comparator-gated blueprint nodes per 10⁸ tokens, extrapolated to the M5–M7 node count. It must fit
  a 36-month horizon, or Lean for 4D is descoped.
- Replace "skeptic pass rate" with skeptic **recall on planted errors (≥90%) and precision** (M-2).
- Delete the "1% on warm-ups" clause from P3, or apply it honestly. M4 is not a warm-up.

#### C-2. The premise is over-read; M7 is mislabelled; M7 is harder than any public target

**Problem 1: the premise does not guarantee our theorem.** §0 item 1 says the existence theorem "is
true and provable at roughly 1,147 natural-language pages". The premise makes *OpenAI's* theorem
true. Its content (gauge groups, observables, full vs subsequential limit, OS4) is unknown (note 02
§1.2). Our `SUNExists N` (Statement.lean) demands much more:
- **`ShortDistanceAF`:** an exact limit, `λ⁸ log²(1/λ) S₂(D_λh₁, D_λh₂) → C ∫∫ h₁h₂|x−y|⁻⁸`.
  Sussman–Alpöge's Target Theorem A asks only that the two-point function be *comparable to*
  `d⁻⁸/log²(1/d)`, i.e. two-sided bounds (note 05 §3.9). An exact asymptotic is strictly harder.
- **`FullFieldContent`:** all 21 components of `tr F F`, versus `tr F²` only in Sussman–Alpöge's
  Theorem A.
- **`AsymptoticScaling`:** `1/g₀² − 2b₀ log(1/a) − (b₁/b₀) log log(1/a) → c`. This is **two-loop**
  control of the bare coupling in Bałaban's scheme, with summable O(g⁴) remainders (see C-7).
- **E0′ growth; cluster for every non-zero spatial `a`; all N ≥ 2 at once.** Bałaban's Theorem 2
  was stated for SU(2) (note 05 §1).

**Problem 2: M7 is mislabelled.** The M7 row reads "= `SUNExists` / `ClayExistence`", but
`ClayExistence` quantifies over *every* compact connected matrix group with simple Lie algebra,
including Spin(n), Sp(n) and the exceptional groups. That is a separate rung.

**Problem 3: smaller over-reads.**
- §0 item 3 (QCD) is outside the premise. The premise covers pure YM and its Lean only; QCD has no
  reported Lean (note 02 §1.2).
- The scope of the 1,147 pages is unknown (it may cover YM + QCD + GUT). The page-count calibration
  is circular (note 99 (b)-8).
- "About 5 weeks (1 Sep → 9 Sep NL, Lean by 16 Oct)": 1 Sep → 9 Sep is 8 days, and → 16 Oct is
  ~6.5 weeks. A 1 Sep start for YM is not public.
- Item 4's "not obtained even at OpenAI's scale": no source says YM used the NS-scale swarm
  (note 02, residual concerns). Say "not claimed".

**Revision, §0 items 1–4:**

> 1. OpenAI's (unreleased) existence theorem is true, and its proof is about 1,147 NL pages (scope
>    of the page count unknown). **Our `SUNExists` may be strictly stronger**: exact `ShortDistanceAF`
>    asymptotics, all 21 channels, two-loop `AsymptoticScaling`, all N ≥ 2. The premise does not
>    guarantee it until `theirs ⇒ ours` is proved.
> 2. If the release confirms ℝ⁴, the IR step can be done without a gap. (The committee's
>    infinite-distance wording is suggestive, not explicit; note 02, verifier log.)
> 3. (Delete the QCD inference, or move it to "outside the premise".)
> 4. The mass gap was not claimed by OpenAI or the committee.

**Revision, ladder.** Split M7 into four rungs:
- **M7a** `SUNExists 2` with two-sided AF bounds;
- **M7b** the full `SUNExists 2`;
- **M7c** `∀ N ≥ 2`;
- **M7d** `ClayExistence`.

Freeze each separately. Do not change M0.

#### C-3. The scale comparison is understated, and the "compensations" do not compensate

**Problem.**
- 16 agents versus ~10,000 is a factor of 625 (~2.8 orders of magnitude), not "one to two".
- Per-agent capability is also lower, and by Brown's account it dominates.
- Ord's λ≈0.57 was estimated only for N ≤ 16; extrapolation is unsupported (note 03, open question 4).

The three compensations in §3.3 do not shrink the proof:
- Narrow frozen targets prevent waste, but the theorem fixes the volume of correct mathematics.
- Lean gates *add* cost: 10–100× NL per page.
- Heavy reuse is real leverage, but most of it (OpenAI's release) is firewalled away.

**Revision, §3.3:**

> OpenAI's NS run used ~10⁴ concurrent agents (~625× our 16) and 1.3×10¹¹ output tokens in 88 h on
> a stronger internal model. Base-model strength, not orchestration, was decisive (Brown). Our
> compensations (narrow targets, reuse, Lean gates) reduce waste but not the size of the proof. The
> realistic horizon for M7 at our scale is multi-year, with low probability (§0.0). We therefore
> (i) measure our capacity in Phase 0 (P11), (ii) default to single-agent, long-horizon,
> lemma-level jobs with Lean checking, reserving group swarms for 2–5 genuine bottlenecks, and
> (iii) treat reuse of public corpora, including OpenAI's release if Peter chooses, as the main lever.

#### C-4. The independence firewall is incoherent and of limited value as written

**Problem: the firewall leaks.**
1. **Statement-level findings carry method information.** Examples: "their observable is flowed
   Wilson loops", "their limit is volume-first subsequential", "Bałaban's Theorem 2 enters as a
   `Published…` hypothesis". Each one points at the architecture.
2. **The human channel.** Peter is the single operator of every swarm. If he reads the release,
   every later intervention is contaminated.
3. **The model channel.** Over a 60-week plan, model upgrades may be trained on OpenAI's release and
   on its commentary. Claude's training cutoff (June 2026) predates the 9 Sep proof, so current
   agents are clean; future ones may not be.
4. **The web channel.** Agents with search will meet discussion of the proof.

**Problem: the firewall's value is limited under the premise.** The premise *says* their proof is
correct. An independent proof then adds:
- robustness against correlated error (Craig's "second construction" lesson, note 02 §2.2);
- readability and understanding;
- an architecture we control for gap work.

Only the first needs a clean room. The other two are better served by *studying* the release, the
way Mathlib re-proves theorems. Meanwhile the firewall forbids the single largest lever on the
timeline.

**Revision.** Replace the "Independence policy" paragraph:

> **Independence policy (v0.2).**
>
> *Definitions.*
> - **Clean-room:** no artefact in the proof tree derives from OpenAI's release. Attested by
>   provenance logs and by a published dependency-graph comparison.
> - **Bridge:** our frozen statement, proved in Lean from OpenAI's released theorem plus our own
>   bridge lemmas. Labelled "conditional on OpenAI's certificate".
> - **Consume:** we study the release and produce a re-derived, simplified, human-readable proof and
>   a Lean refactor. Labelled "independent re-derivation", never "independent discovery".
>
> *Phase I (until release + 14 days):* clean-room by necessity, since nothing is public.
>
> *At release + 14 days (stop rule SR0), Peter chooses the mix.* Default: Bridge and Consume for
> existence and gap work. Clean-room only for components where independence has specific value
> (e.g. the IR step, or Bałaban's coupling flow), at a capped budget.
>
> *Leakage controls for clean-room work:*
> - separate repositories and sessions;
> - no web access; corpus frozen and hashed **before** release;
> - model IDs pinned and logged;
> - Peter does not read solution modules or the NL proof; if he does, it is logged and affected
>   artefacts lose the clean-room label;
> - audit findings cross the wall only as one of three verdicts: `theirs ⇒ ours`, `ours ⇒ theirs`,
>   or a list of clause-level differences, written by the audit lead.
>
> *Audit protocol (firewall-safe):* read only the challenge/definition files and the Comparator
> configs. Treat solution modules as black boxes: build, Comparator, `#print axioms`, scan for
> hypothesis structures in statement types (C-8/M-8).

#### C-5. Stop rules are cited as a mitigation but never defined

**Problem.** §5 lists "stop rules" against compute and budget risk, but none exists. The only gates
are §4's go/no-go cells, and the Phase 1 gate is non-binding (C-1).

**Revision.** Add §4.1 with SR0–SR8 (§3 below).

#### C-6. Pre-registration is mis-ordered, and the freeze has no anchor

**Problem.**
- **Freeze order.** Phase 0 freezes "Statement v1.0 ... after expert review and OpenAI comparison".
  Freezing *after* seeing their statement removes most of the scientific value of our statement. It
  can no longer serve as an independent yardstick for theirs, and it invites tuning toward theirs.
- **No anchor.** The workspace git repository has **no commits**, so `plan/FREEZE.log` hashes and
  P9 provenance are unanchored.
- **No sandbox on this machine.** It runs macOS (Darwin), where `lake comparator` cannot sandbox
  (bwrap is Linux-only). macOS runs are "development mode" with no isolation guarantee (note 10
  §2.11).

**Revision, Phase 0:**

> Within days, and before OpenAI's release:
> 1. Make the initial git commit.
> 2. Freeze statement **v0.3** (current v0.2 plus the C-2 rung splits) and SHA-256 it.
> 3. Anchor the hash externally: a commit to a remote, plus OpenTimestamps or a Zenodo deposit,
>    public or embargoed as Peter decides.
> 4. After release, produce v1.0 with a published diff from v0.3. Each change is justified, and
>    where definitions change, an equivalence is proved.
> 5. The Comparator gate counts only on Linux CI (bwrap, `--paranoid`, JSON reports kept).

#### C-7. C3 ("the missing 4D coupling flow") is premature, under-scoped, and oversold

**Problem 1: no primary sources.** Nobody in the project has read a Bałaban CMP paper (note 05 §0;
the bot walls block agents). The claim that Theorem 2 was never published rests on two sources:
Dimock's "missing paper" remark, and one unvetted 2026 transcription [68] (note 99 (b)-10).

**Problem 2: it is not small.** §7 calls it "small, decisive and computable". Note 05 sizes it at
50–150 pp, and it needs the whole small-field apparatus:
- nonlinear block averaging (CMP 98);
- regular configurations and axial gauge in blocks (CMP 99);
- background-field propagators (CMP 99b);
- the variational problem (CMP 102b).

**Problem 3: one loop is not enough.** `SUNExists` contains two-loop `AsymptoticScaling` with a
convergent constant. That requires:
- (a) b₀ exactly;
- (b) the scheme-universal b₁ proved *in Bałaban's scheme*: a two-loop computation with block
  propagators, which no paper contains;
- (c) per-step remainders O(g_k⁴), which are summable because Σ g_k⁴ ~ Σ k⁻².

C3 as written stops at one loop.

**Problem 4: its value depends on the release.** If OpenAI's Lean takes Bałaban's theorems as
`Published…`-style hypotheses or axioms (note 99 action 1), then C3 plus formalized Bałaban would
*discharge hypotheses of the accepted proof*. That is far more valuable than a clean-room re-proof.

**Revision, C3:**

> **C3 (gated).**
> - C3.0 (human; week 1): download CMP 95–122 and precursors from Project Euclid. Check CMP 109
>   pp. 251 and 259–260 (Theorem 2), p. 267, and CMP 122 p. 355. Record the exact status of the
>   coupling flow and of the lower bound.
> - C3.1: one-loop b₀ in Bałaban's scheme, with explicit remainder bounds.
> - C3.2: two-loop b₁ and summable remainders, as required by `AsymptoticScaling`. Alternatively,
>   move `AsymptoticScaling` to rung M7b.
> - C3.3: fixed-point choice of g₀(N) with the marginal direction; lower stability bound.
> - Budget ≤5% until stop rule SR2. Re-prioritize after the release audit determines whether
>   Bałaban enters OpenAI's proof as a hypothesis.

### Major

#### M-1. P11–P13 from note 03 are missing

**Problem.** The plan adopts P1–P10 and silently drops three principles:
- **P11:** size the swarm to the evidence; run 1/4/16/64-agent ablations; default to single-agent
  lemma jobs.
- **P12:** sandboxing; treat agent Lean as adversarial input; watch for reward hacking against the
  statement.
- **P13:** publication norms.

These carry most of the feasibility and integrity content.

**A live integrity hazard is unaddressed.** The claimed-solution literature contains text addressed
to AI referees, and the Goldstein repository contains agent-directed instructions (note 11 §3.1,
§2.2). Our literature-mapper agents will ingest exactly this material.

**Revision.** Add the following to §3.1:

> **P11. Measure before scaling.** In Phase 0, run a capacity calibration on ~20 known lemmas from
> Dimock φ⁴₃ I. Measure tokens per accepted node, Lean lines per agent-hour, wall-clock, and
> false-acceptance rate on planted errors, at 1, 4 and 16 agents. All schedule numbers are derived
> from these measurements and refreshed monthly.
>
> **P12. Integrity.**
> - Agents run sandboxed.
> - Agent-produced Lean is untrusted; it is never compiled in the environment holding the challenge
>   before Comparator runs.
> - Untrusted text (web, Zenodo, preprints, third-party repos) is quarantined. It is ingested only
>   by read-only agents with no write access to statement or ledger repositories, and imperative
>   text addressed to agents is stripped and logged.
> - A loophole red team runs against every rung statement.
>
> **P13. Publication norms.**
> - NL, Lean, Comparator configs and logs are released together.
> - An independent clean-machine Comparator run is required before any claim.
> - "Lean-certified top-line theorem" is kept distinct from "refereed NL proof".
> - AGMAI pathway 2B disclosure (model, prompts, traces, attempts, compute, cost, failed problems,
>   problem selection) is made at release.
> - No press release.

#### M-2. The verification gates are mis-specified

**Problem.**
1. **Inconsistent quorum.** §3.2's pipeline says "3 skeptics, majority", but gate G-NL says
   "3/3 skeptic sign-off".
2. **Correlated skeptics.** Same-family skeptics share failure modes. In pphi2, at least four helper
   axioms were found false as stated, some only by cross-model review (note 10 §4.3). `openai/math`
   withdrew 3 manuscripts and revised 14 within a day (note 03 §6).
3. **Node-level hole in G-Lean.** "No `sorry` in the node" lets a node pass while its dependencies
   still contain `sorry`.
4. **Node statements are unreviewed.** Every node statement is agent-authored. The junk-value and
   trivial-bound hazards recur at every node, not just at rungs. Note 05 §5.4: `Z_N ≤ 1` holds
   trivially for compact G, so a faithful node must compare to the Gaussian normalization.
5. **Per-node Lean blocks discovery.** Requiring Lean before a ledger entry makes formalization the
   rate limiter of discovery. OpenAI separated the two stages (note 03 §4.3).

**Revision, §3.2 gates:**

> **G-NL:** at least 2 of 3 heterogeneous skeptics (different prompts and literature seeds; cross-vendor
> where available). Skeptic recall is measured monthly on planted errors (sign flips, quantifier
> swaps, dropped hypotheses, wrong derivative counts); below 90%, SR4 triggers.
>
> **G-Lean:** no `sorry`/`axiom` in the *transitive closure*. Each node statement carries a
> fidelity review (junk values, trivial bounds, weaker-than-NL), recorded in `alignment.yaml` with
> status `proved | weaker | stronger | different-proof`.
>
> NL-verified nodes may enter the ledger before Lean, with status `NL-calibrated`. No rung closes
> with any `NL-calibrated` ancestor, and no node may have more than *k* such ancestors.
>
> Verification effort is risk-tiered: nodes closed in Lean need no NL skeptic quorum. Skeptic effort
> goes to statement fidelity and to unformalized nodes.

#### M-3. The human-expert gate is unrealistic for proofs, and the plan ignores COI and cost

**Problem 1: experts cannot check the proofs.**
- G-Human ("expert spot-check at rung boundaries") assumes experts can check 1,000-page AI proofs.
  Bauerschmidt says nobody can currently tell whether even Bałaban's own papers are correct
  (note 02 §2.5). He was similarly dismissive of most of OpenAI's 2D sigma-model papers.
- The pool is tiny, and the committee's Rules bar its members (Douglas, Gross, Jaffe, Klebanov,
  Nekrasov), and anyone who joins their group, from outside existence research (note 02 §1.3).
- Experts are busy, and the committee itself is unpaid.

**Problem 2: Peter's approvals are misplaced.** P4 has Peter "approve ledger versions at milestones".
These are mathematical approvals he is not positioned to give, and waiting on him is a known
bottleneck.

**Revision.**

> **G-Human** applies to *statements and architecture*: every frozen rung statement, every interface
> lemma between tracks, and the blueprint graph. It does not apply to proofs, which the kernel checks.
>
> Experts are paid consultants (honoraria budgeted in the tier), not committee members or affiliates.
>
> Peter approves scope, budget, contacts and publication only, collected in one decision sheet per
> phase (§6).

#### M-4. The ethics and community section is missing

**Problem: Sussman–Alpöge.** The plan borrows heavily from their public work:
- the volume-first subsequential ergodic-component architecture;
- the RP trick for O(4);
- the YM₃ manuscripts as "literature to verify".

Track D is essentially their YM₄ modules C (continuum limits by compactness) and K (components and
clustering), whose target their own overview marks unproved. Their README (checked live):
- permits use of the documents for any purpose;
- invites contributions in formalization, verification, restructuring and exposition;
- proposes experimental-physics-style credit;
- warns against a race to rush out or digest raw output;
- notes that other groups are already making progress off their arguments.

Alpöge works at Anthropic and our pipeline runs on Claude. This is an overlap to disclose, not hide.
The NS episode (note 03 §5–6) shows how quickly an uncredited parallel effort becomes a priority
dispute.

**Problem: AGMAI and the committee.** AGMAI's stance (immediate release, pathway 2B disclosure, no
designated shepherds) is the community norm our project will be judged by. The committee's
first-stage task, checking definitions against standard ones, is exactly where our pre-registered
statement is useful to them.

**Revision.** Add §6.5:

> **Community and ethics.**
> 1. Before starting C4 or Track D, contact Sussman–Alpöge. Offer verification and formalization
>    contributions (QED₃ structural audit, RPM1 in Lean, a definitions ledger for YM₃_I). Agree
>    credit on their collaboration model. Disclose our Claude use and our firewall policy. Ask about
>    YM₄ status to avoid duplication.
> 2. Contact Dimock as the only modern re-deriver of Bałaban's method (scoping C3), and
>    Aronow–Lopatto (3D torus audit).
> 3. Send the committee our pre-registered statement and audit checklist as a public contribution.
>    Request no unreleased material: that preserves independence and avoids the information
>    asymmetry AGMAI criticised.
> 4. Meet AGMAI 2B disclosure by design. Raw output goes to Zenodo or Hexagon with provenance
>    labels; arXiv only for human-vetted manuscripts with AI-use disclosure and human authors taking
>    responsibility.
> 5. No prize framing, no press release, and no claim before an independent Linux Comparator run.
> 6. Pin Douglas-maintained dependencies (OSforGFF, lgt, os-reconstruction) by commit now; COI rules
>    may affect their maintenance (note 99 (d)-7).
> 7. Release infrastructure (Mathlib PRs) continuously; do not sit on results.

#### M-5. M4 is on the critical path as a "warm-up", and M3 calibrates the wrong thing

**Problem.**
- **M4.** The 4D proof does not logically need the 3D result. What it shares is machinery:
  averaging, propagators, gauge fixing. Putting M4 in Lean on the critical path (Phase 2) delays 4D
  by months, for an artefact that two public groups have already produced in NL.
- **M3.** 2D YM on T² is exactly solvable (Migdal invariance of the heat-kernel action). It
  exercises Peter–Weyl, characters and heat kernels, which are missing from Mathlib (note 10 §2.3),
  but none of the RG estimates C-track needs. The real C-track calibration is C2.

**Revision.**
- Recast M4 as two items:
  - **M4-audit** (parallel, high value): structural audit of Sussman–Alpöge QED₃ → YM₃_I and
    Aronow–Lopatto. Deliverables: dependency maps against B0–B9, spot-checked lemmas, a definitions
    ledger, and RPM1 in Lean.
  - **M4-Lean**: optional, decided at SR3.
- Make M3 optional infrastructure (characters and the heat kernel on SU(2)), off the gate path.
- Promote **"Bałaban foundations in Lean"** ([1]–[7], CMP 95–102, ~215 CMP pp) to a named rung,
  **M2.5**. Every Bałaban-route proof uses these papers as black boxes (note 05 §3.3), OpenAI's
  presumably included. Formal verification de-risks all of them, and is clean-room by construction
  (pre-2026 literature).

#### M-6. Track D understates specific technical risks

**Problem.**
1. **Gibbs states.** Step 3 builds infinite-volume Gibbs states "by compactness of G (DLR)" for the
   *effective* theory at ℓ₀. Bałaban's effective actions are polymer-represented with a
   small/large-field split. They are not a finite-range specification, and RP of an effective
   gauge-fixed, block-averaged measure is not automatic. Take limits of the *original* Wilson
   measures instead, which are tight by compactness and RP by Osterwalder–Seiler, and use RG only
   for volume-uniform bounds.
2. **Volume uniformity.** Bałaban works on a fixed torus. In infinite volume, large-field regions
   occur with positive density, so every constant must be re-derived as extensive and
   volume-independent.
3. **Ergodic decomposition.** Whether RP, O(4) invariance and `ShortDistanceAF` pass to almost every
   ergodic component is a theorem, not a formality:
   - the decomposition must use an invariant σ-algebra compatible with time reflection;
   - rotation invariance of components is not automatic;
   - a limit statement can hold for a mixture without holding componentwise.
4. **Lean.** Choquet/ergodic decomposition for measures on 𝓢′ is absent from Mathlib.

**Revision.**
- Rewrite step 3 as above.
- Add D0, a two-week desk study listing each property needed per component, with a proof sketch or
  "open".
- Credit Sussman–Alpöge's module structure explicitly in the track header.
- Add these risks to §5.

#### M-7. Track E needs a budget cap, and E2 needs numbers

**Problem.** E2 proposes a computer-assisted (Lean-checked) finite-volume mixing certificate for the
effective theory. For 4D SU(3), the best rigorous windows are β < 0.1875 (LSI and gap) and
β < 0.375 (area law), while the scaling region is β ≈ 5.7–6.5 (note 07 §2). That is a 15–30×
extrapolation, after a nonperturbative crossover with no control.

The state space is SU(3)^{4L⁴}, with 32L⁴ real dimensions (≈131k at L = 8). Interval-arithmetic
mixing certificates in that dimension are far beyond any existing computer-assisted proof (note 99
(a)-3 lists the missing literature). Meanwhile E4's replay of family 215 is cheap and also
rehearses the release audit (note 99 actions 4–5).

**Revision.**
- Track E capped at ≤10% of budget.
- E2 begins as a 2-week desk study with a kill criterion: no concrete finite-volume condition plus a
  box size within reach of certification means kill.
- Move the E4 replay (`ClassicalON`, `lake comparator --paranoid` on Linux) to Phase 0.
- Keep E1/E3 at statement level until a sub-lemma passes the sanity filters.

#### M-8. The release-day audit should be mechanical and firewall-safe, and should open a Bridge track

**Problem.** A4 is described in one paragraph. It omits the first question on note 99's list: is
OpenAI's proof conditional (`Published…` hypotheses, project axioms)? It also omits licence terms
(which govern any reuse), the trusted-base size, and the fact that the statement diff alone can
yield a Comparator-checked M7 via `theirs ⇒ ours`.

**Revision.** Replace A4 with:

> **A4. Release audit (T+0 to T+14 days; scripted in Phase 0 and rehearsed on family 215).**
> 1. Linux bwrap `lake comparator --paranoid --json` on a clean machine.
> 2. `#print axioms`; scan statement types for hypothesis structures; inventory definition holes;
>    measure trusted-base size; check licence.
> 3. Clause-by-clause diff against our v0.3 (note 04 §6.2 checklist).
> 4. Attempt Lean proofs of `theirs ⇒ ours` and `ours ⇒ theirs`; otherwise write a gap analysis.
> 5. Publish the audit.
> 6. Feed SR0.
>
> Solution modules are black boxes throughout (C-4).

### Minor

- **m-1. Factual and wording fixes.**
  - M0 status "drafted and reviewed" → "drafted; AI-reviewed (20 agents); no human review;
    candidate" (note 99 (b)-5, (b)-9).
  - "Lean by 16 Oct" → "per OpenAI (secondary reports); the committee says OpenAI is providing a
    formalization" (note 04 §3.10).
  - §3.3 "one to two orders of magnitude" → "~2.5–3 orders in concurrency, plus a model gap".
  - "Comparator ... is the acceptance gate" → "... on Linux CI".
- **m-2. KPIs.** "Lean lines per NL page" is gameable and penalizes good proofs. Replace with four
  measures:
  - critical-path blueprint nodes closed (transitively sorry-free, Comparator-gated) per week and
    per 10⁸ tokens;
  - planted-error recall;
  - cost per accepted node;
  - open `NL-calibrated` debt.
  P2's "reallocate toward kernel-checked progress" should use critical-path nodes. Raw line counts
  bias effort toward easy infrastructure.
- **m-3. M1 split.**
  - **M1a:** `su_connected` and `su_lieAlgebra_simple` (Phase 0).
  - **M1b:** `os_nonTrivial_fullField_consistent`, rated "large" in PROBLEM.md §6 (Gaussian
    measures on 𝓢′, Wick products; the field is massless and vector-valued, whereas OSforGFF is the
    massive scalar). Phase 1–2.
- **m-4. Track B scope.** Define "core" for Phase 1:
  - Phase 1: Haar bi-invariance on compact groups, SU(N) facts, Wilson measure and gauge invariance,
    Osterwalder–Seiler RP, the transfer matrix (note 10 §4.1, item 5).
  - Phase 2: Kotecký–Preiss and random-walk expansions.
  - Gauge fixing and the variational problem only after the C2 pilot.
  Size each with note 10 §4.2.
- **m-5. C1 transcription.** Agents cannot fetch Project Euclid, so a human must. OCR of 1980s CMP
  math is error-prone: use two independent transcriptions plus an equation-level diff. Start with
  the ~184 CMP pp of the 4D series (CMP 109, 116, 119, 122 I–II) only after C3.0 confirms the scope.
- **m-6. Provenance and definitions.**
  - Log and pin model IDs, since upgrades are a contamination channel (C-4).
  - Add a **definitions ledger** next to the insight ledger. Sussman–Alpöge's known failure mode is
    that explicit definitions become implicit after condensation (note 02 §4(5)(ii)).

---

## 3. Proposed stop rules (new §4.1)

| ID | Trigger / checkpoint | Rule |
|---|---|---|
| SR0 | Release + 14 days | Decide the Clean-room / Bridge / Consume mix (C-4). If their Lean is unconditional and `theirs ⇒ ours` is proved, stop clean-room existence work beyond a capped "independence for its own sake" line, *if* Peter wants one. |
| SR1 | End of week 2 | If the primary text does not confirm the Theorem-2 gap, re-scope C3 before spending more than 5% of budget. |
| SR2 | Week 8, or 5×10⁸ tokens on C3 | No calibrated derivation of b₀ in Bałaban's scheme with stated remainder bounds → suspend 4D Track C; continue infrastructure and audits. |
| SR3 | Week 12 (pilot) | Measure closed nodes per 10⁸ tokens on Dimock φ⁴₃ I. If extrapolation to the M5–M7 node count exceeds 36 months at the funded tier, descope Lean for M5–M7. Re-plan as NL + audits + foundations. |
| SR4 | Continuous | Planted-error recall below 90%, or an expert finds an error in a gate-accepted node → freeze acceptances; re-audit the downstream closure. |
| SR5 | Monthly | Hard spend cap. If 50% of budget is spent with no rung beyond M2 Comparator-closed, stop and report. |
| SR6 | Monthly | Track E ≤10% of budget. Kill a route immediately if it fails a sanity filter, or after 2 cycles without a frozen sub-lemma statement. |
| SR7 | Event | If Sussman–Alpöge or another open group posts a complete YM₄ manuscript, switch Tracks C/D from production to verification and contribution. |
| SR8 | Event | A detected firewall breach marks the affected artefacts non-clean-room. No independence claim for them. |

---

## 4. Cheaper, high-value deliverables (ranked by value per cost)

| # | Deliverable | Cost | Why valuable, even if OpenAI is right | When |
|---|---|---|---|---|
| 1 | Pre-registered, timestamped Lean YM statement (v0.3), labelled candidate, with known deviations from Clay in both directions; offered upstream to formal-conjectures (no YM file exists) | days | The yardstick for judging OpenAI's statement, which is the committee's own first task; value peaks before release | now |
| 2 | Release audit kit (A4), scripted and rehearsed | 1–2 weeks | First credible public audit; answers whether the proof is conditional | Phase 0 |
| 3 | Linux `--paranoid` replays of family 215 `ClassicalON`, OSforGFF, OSreconstruction, lgt | days | Validates our base layer. `ClassicalON` claims Polyakov's conjecture at lattice level; if it is right, that is major, and if wrong, important | Phase 0 |
| 4 | Primary-source check of Bałaban (Theorem 2, lower bound) | days (human) | Gates C3; nobody has done it (note 99 action 2) | week 1 |
| 5 | Contribution to the Sussman–Alpöge collaboration: QED₃ (242 pp) structural audit, RPM1 (RP O(d) trick) in Lean, YM₃_I definitions ledger | weeks–months | The authors ask for exactly this. It is the most checkable 3D claim (note 11 §8, lead 2). Credit is shared | Phase 1 |
| 6 | Mathlib PRs: Haar bi-invariance (non-abelian compact), SU(N) connected and su(n) simple, Osterwalder–Seiler RP of the Wilson action, transfer matrix | weeks each | Durable public goods; none exists (note 10 §3) | Phase 1 |
| 7 | Dimock φ⁴₃ part I (52 pp) in Lean | 3–6 months | The first formal verification of a Bałaban-method RG result; calibrates SR3 | Phases 1–2 |
| 8 | Bałaban foundations [1]–[7] in Lean (M2.5) | 6–24 months | De-risks every Bałaban-route proof, OpenAI's included; clean-room by construction | Phase 2+ |
| 9 | Coupling-flow note (C3.1, C3.2) as a readable paper | 1–3 months | Fills a documented gap, or confirms OpenAI's proof fills it; "understanding as a deliverable" | after SR1 |
| 10 | Bridge: `theirs ⇒ ours` in Lean | weeks to months | Certifies that OpenAI's theorem means the community's statement | after release |

---

## 5. Replacement for §4 (stretch schedule; odds in §0.0)

| Phase | Weeks | Deliverables | Exit / stop rule |
|---|---|---|---|
| 0 | 0–2 | Initial commit. v0.3 frozen and externally timestamped before release. Linux Comparator CI. Replay kit run on items 3 of §4. Primary Bałaban PDFs obtained (C3.0). Capacity calibration (P11). Decision sheet answered (§6). M1a. | SR1; replays done; hash anchored |
| R | release + 0–14 days | A4 audit published; Bridge attempt | **SR0** |
| 1 | 2–12 | M2 statements, plus Wilson RP and transfer matrix in Lean (Mathlib quality). Dimock φ⁴₃ I pilot. C3.1 (and C3.2 scoping). M4-audit with Sussman–Alpöge, if agreed. Track B Phase-1 scope (m-4). | SR2 (week 8), **SR3 (week 12)** |
| 2 | 12–26 | φ⁴₃ I closed; M1b; M2.5 blueprint and first modules; YM₃_I structural audit; C3 written up; D0 desk study | SR3 re-evaluated; SR5 |
| 3 | 26–52 | Per SR0/SR3: either clean-room M5 NL plus Lean for averaging and propagators, or Consume/Bridge (readable re-derivation, Lean refactor, gap-adjacent work) | SR5 |
| Long | 52+ | M6–M7 only if SR3 passes; multi-year horizon | quarterly odds update |
| E | parallel, ≤10% | E4 replay (Phase 0), E5 obstruction red team, E1/E3 statements, E2 desk study | SR6 |

---

## 6. Replacement for §6: one consolidated decision sheet for Peter (single ask)

1. **Budget tier** (T1/T2/T3) and a hard monthly cap.
2. **Independence definition** and the post-release default (Clean-room / Bridge / Consume).
3. **Pre-registration:** publish statement v0.3 (public repo, Zenodo, formal-conjectures PR), or
   timestamp it privately?
4. **Contacts allowed:** Sussman–Alpöge, Dimock, Aronow–Lopatto, the committee (send the statement,
   request nothing), Lean Zulip; paid consultants and honorarium budget.
5. **Human-only tasks:**
   - download Bałaban CMP 95–122, the precursors, MRS 1993, OS I/II and Osterwalder–Seiler 1978
     from Project Euclid;
   - obtain Douglas, *Nat. Rev. Phys.* 8 (2026) 86–97;
   - archive OpenAI's 26 Oct post in a browser.
6. **A Linux machine or CI** for bwrap Comparator.
7. **Peter's own reading of the OpenAI release:** yes (and Clean-room labels lapse) or no.
8. **Model pinning:** pin current model IDs for clean-room work, or accept upgrades with logging.
9. **Disclosure commitment:** AGMAI pathway 2B at release.

---

## 7. What must be kept (excellent)

- **§0's structure** (what the premise buys / does not buy). Keep it, with the content fixed (C-2).
- **The frozen-statement ladder.** SHA-256 freeze, per-rung adversarial review, inhabitants and
  counter-inhabitants, degenerate witnesses as regression tests. The v0.1 cluster bug (`a = 0`
  admitted, collapsing the Hilbert space) is concrete proof that this process works.
- **Comparator with only the three standard axioms** as the acceptance gate (on Linux).
  `alignment.yaml` plus a hypothesis-diff agent, a direct answer to the NS m+4/m+5 drift.
- **"Literature to verify, not to trust"** for all AI manuscripts. Tagging numerics `heuristic`
  until certified.
- **Track B's insight** that at fixed spacing everything is a finite-dimensional integral over
  `G^{links}`, which is Lean's comfort zone.
- **C2 (Dimock φ⁴₃) as the pilot**: the cleanest instance of the method.
- **C3 as a concrete, well-posed target.** Keep it, gated by C3.0.
- **Track E's sanity filters** (fail for 4D U(1); no confinement for finite groups or SO(3); respect
  θ = π), the E5 obstruction red team (the Constantin–Ignatova–Vicol move), monthly kill/continue,
  and the mass gap explicitly off the critical path.
- **P9 provenance by construction** (strengthened by C-6 and m-6). The §6.4 rule of no publicity
  before a Comparator-checked rung *and* human review (complemented by M-4 item 7).

---

## 8. Sources used

- **Notes:**
  - 02 §§1.2–1.3, 2.2, 2.5 and residual concerns (claim scope, dates, committee Rules/COI, AGMAI,
    Sussman–Alpöge figures);
  - 03 §§3, 4.1–4.7, 6, P1–P13 (NS swarm numbers, Brown <10%, Ord λ, P11–P13);
  - 04 §§3.8–3.10, 6.1–6.2 (Comparator guarantees, audit checklist, `Published…` hypotheses);
  - 05 §§0, 1, 3.1, 3.3–3.4, 3.9, 5.1–5.4 (Bałaban corpus, Theorem 2 status, B0–B9 sizes, `Z_N` trap);
  - 07 §2 (proven strong-coupling windows vs the scaling region);
  - 09 summary (sanity filters, ranking of routes);
  - 10 §§2.10–2.11, 3, 4.1–4.3 (Lean gaps and sizes, macOS sandbox caveat, pphi2 false axioms);
  - 11 §§2.2, 3.1, 7–8 (3D AI preprints, prompt-injection hazard, leads);
  - 99 actions 1–6 and 14; items (b)-4, (b)-5, (b)-8, (b)-10 and (d)-7.
- **Project files:**
  - `PROBLEM.md` §§3.5, 6;
  - `lean/YangMills/YangMills/Statement.lean` (`ShortDistanceAF`, `FullFieldContent`,
    `AsymptoticScaling`, `SUNExists`, `ClayExistence`);
  - `OpenProblems.lean` (current `sorry` inventory).
- **Live checks (2026-11-05):**
  - workspace `git log` (no commits);
  - GitHub API: `openai` org repos (no YM repo); `ethanwsussman/Yang--Mills-LLM-experiment`
    (last push 2026-11-02; no LICENSE file; README grants use for any purpose, invites
    collaboration, describes credit model and status).
