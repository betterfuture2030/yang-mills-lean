# 03 — OpenAI's Navier–Stokes agent-swarm methodology (for guiding *how* to use AI)

**Workstream key:** `03-openai-navier-stokes-method`
**Compiled:** 2026-11-05 from live sources. This note covers method: how the AI was organised, tooled, seeded, checked and supervised. It does not try to verify the fluid-dynamics mathematics.
**Evidence legend used throughout:**
- **[P]**: primary artefact I read directly (OpenAI's PDFs, OpenAI's GitHub repositories, Buckmaster's statement, arXiv papers, the podcast transcript).
- **[O]**: OpenAI's own claim, reported through a search snippet of openai.com or through press coverage. The OpenAI blog itself returned HTTP 403 to automated fetching.
- **[S]**: a secondary or press account.
- **[D]**: disputed between named parties.
- **[I]**: my own inference.

---

## Summary

On 8 September 2026 OpenAI announced a proof of finite-time blowup for the 3D incompressible Navier–Stokes equations with a smooth, compactly supported external force, for every viscosity $\nu>0$. OpenAI presents this as settling alternatives **(C)** and **(D)**, the "breakdown" alternatives, of Fefferman's Clay problem statement. The release comprised:
- a 166-page paper ("Finite time blowup for Navier–Stokes");
- a 57-page companion paper on **unforced** 3D Euler blowup from smooth, compactly supported data;
- a public Lean 4 repository, `openai/NavierStokesAndEuler`, with zero `sorry`s and only the three standard axioms. Its top-level statements are checked by the Comparator tool against a reference statement adapted from Google DeepMind's *formal-conjectures* project. [P]

**What the AI system did, per OpenAI's account [O]:**
- **Launch.** On 1 September OpenAI launched groups of agents on the open Millennium problems and related questions. OpenAI says rumours that Anthropic-linked researchers had solved *two* Millennium problems prompted this (Bubeck on X, via VentureBeat; Gamburd also records the rumour as two problems and as false).
- **Model.** The agents ran an unreleased internal model that began training on 28 August. OpenAI describes it as "significantly more capable than GPT-6 Astra", and it was updated to a further-trained checkpoint during the run.
- **Formulations.** For Navier–Stokes, the proof-direction versions (A)/(B) and the disproof-direction versions (C)/(D) went to *separate* groups.
- **Communication and tools.** Agents could message others in their own group, run code, and read a cached snapshot of the internet. They worked in isolated, monitored environments.
- **Euler stage.** A squad of roughly 100 agents produced the unforced-Euler disproof in about 50 hours.
- **Navier–Stokes stage.** OpenAI then moved resources off the other problems and prompted agents with the Euler result. Codex was used to "cross-pollinate" groups by consolidating each group's most useful intermediate insights. The group that solved Navier–Stokes had on the order of 10,000 concurrent agents and finished about 88 hours after the first launch (Saturday 5 September).
- **Volume.** The Navier–Stokes stage exchanged about 2.7M messages and produced about 130B output tokens. All problems together came to about 4.9M messages and 300B output tokens.
- **Formalization.** GPT-6 Astra running in the Codex agent framework then formalized the proof in Lean in about 17 more hours. The repo's own metadata confirms the model and framework. [P]

**What is contested:**
- **Scope.** Many analysts regard the forced alternative as a loophole, not the intended problem. Constantin–Ignatova–Vicol prove a *conditional* obstruction. Take any construction with OpenAI's two key features (anisotropic Type II bounds on the angular mean; exact axisymmetry in a collapsing core) whose force stays bounded in $C^2$ up to the singular time. In any such construction, the force can neither vanish near the singular point nor be real-analytic in space. Constructions of this type therefore cannot give *unforced* blowup, which is what would refute (A)/(B). This blocks one route; it does not prove (A)/(B).
- **Priority and provenance.** Tristan Buckmaster and Levent Alpöge had spent a year, using Claude and Codex, pushing the Córdoba–Martínez-Zoroa forced-blowup programme. They had Lean-verified forced-Euler/Boussinesq results by 22 August. Buckmaster's statement says OpenAI's effort started only after word of their progress reached OpenAI. He also says an entire human team was involved, that the agents were first set on easier problems including Euler, and that the prompt he was shown had itself been written by prompting Codex.
- **Lean versus the paper.** Bastounis–Circelli–Hansen show that the Lean development proves the headline theorems via intermediate lemmas that differ from the paper's, sometimes weaker or with different derivative counts. The Lean certificate therefore certifies the theorem, not the natural-language argument.
- **Understanding.** Scientific American reported on 22 Oct that OpenAI announced the proof without anyone on staff grasping even its broad strokes. On 13 Oct it reported that, more than a month after the announcement, no one fully understood it.
- **Credit for the swarm.** Noam Brown (OpenAI) said he would credit multi-agent organisation with less than 10% of the success. In his account, the strength of the base model was decisive. No ablation exists.

**Bottom line for our project [I]:**
- The transferable lessons are less about "10,000 agents" than about six things:
  1. freezing an independent, adversarially reviewed formal target statement *before* the search;
  2. running a portfolio of formulations in separate groups, then concentrating resources on whatever cracks;
  3. climbing a ladder of easier, structurally similar warm-up problems, whose solutions seed the next stage;
  4. periodic distillation and broadcast of insights across groups;
  5. a Lean-kernel-plus-Comparator acceptance gate with an explicit paper-to-Lean alignment map;
  6. auditable provenance and early domain-expert involvement.
  The NS episode's failures (scope loophole, priority fight, Lean/paper drift, unreadability) map one-to-one onto risks for a Yang–Mills attempt.
- One key disanalogy: Clay NS (C) allowed the force to be defined as the residual of an engineered flow, which gives enormous slack. Clay YM has no comparable free term.

---

## Key definitions and statements

### Clay Navier–Stokes alternatives (Fefferman's official description)

Write the NS system on $\mathbb{R}^3$ or $\mathbb{T}^3$ as
$$\partial_t u + (u\cdot\nabla)u = \nu\Delta u - \nabla p + f,\qquad \nabla\cdot u = 0,\qquad u(\cdot,0)=u^\circ.$$
The four alternatives:
- **(A)** For $f\equiv 0$ and every smooth, divergence-free $u^\circ$ with all derivatives rapidly decaying, there is a global smooth solution on $\mathbb{R}^3$ with bounded energy.
- **(B)** The same with $f\equiv 0$ on $\mathbb{T}^3$.
- **(C)** There exist a smooth, rapidly decaying, divergence-free $u^\circ$ *and a smooth, rapidly decaying (in space and time) force $f$* for which no global smooth bounded-energy solution exists on $\mathbb{R}^3$.
- **(D)** The periodic analogue of (C).

Proving any one of (A)–(D) wins. (A) is *not* the negation of (C), so a forced blowup does not settle the unforced problem.

### OpenAI's headline theorems [P]

**NS, Theorem 1.1.** For every $\nu>0$ there exist $f\in C_c^\infty(\mathbb{R}^3\times(0,\infty);\mathbb{R}^3)$, a compact $K$, and smooth $(u,p)$ on $\mathbb{R}^3\times[0,1)$ solving NS with $u(\cdot,0)=0$, with the following properties:
- $\operatorname{supp}u(\cdot,t)\cup\operatorname{supp}p(\cdot,t)\subset K$;
- $\sup_{t<1}\|u(t)\|_{L^2}<\infty$;
- $\limsup_{t\uparrow1}\|u(t)\|_{L^\infty}=\infty$.

Hence (C) holds; compact support gives (D) on $\mathbb{T}^3$ (Corollary 10.6).

The construction, in summary:
- **Core.** A slender self-similar swirling core, with $\ell_r\asymp\tau^{1/2}$ and $\ell_z\asymp\tau^{1/2-h}$ for $0<h<1/100$, $\tau=1-t$.
- **Pulses.** Two families of oscillatory pulses. Their averaged quadratic momentum fluxes cancel the singular part of the background residual.
- **Force.** The force is whatever residual remains. It is engineered to extend smoothly through $t=1$.

**Euler, Theorem 1.1.** There exists $u_0\in C^\infty_{c,\sigma}(\mathbb{R}^3)$ with $0<T_*(u_0)<\infty$, $\limsup_{t\uparrow T_*}\|\nabla u\|_{L^\infty}=\infty$ and $\int_0^{T_*}\|\operatorname{curl}u\|_{L^\infty}\,dt=\infty$. This is unforced.

### The formal target actually checked [P]

`ComparatorChallenges/NavierStokes.lean` is a standalone copy of DeepMind's `FormalConjectures/Millenium/NavierStokes.lean` at commit `8bf45ed`. It imports only Mathlib and contains the definitions plus two theorem stubs (`sorry`):
```lean
theorem navier_stokes_breakdown_R3 (nu : ℝ) (hnu : nu > 0) :
    ∃ (u₀ : ℝ³ → ℝ³) (f : ℝ³ → ℝ → ℝ³),
    InitialVelocityConditionDecay u₀ ∧ ForceConditionDecay f ∧
    ¬ (∃ v p, NavierStokesExistenceAndSmoothnessRn nu u₀ f v p)
```
The periodic statement is analogous.

Design details worth copying:
- The time derivative is a `derivWithin` on `Set.Ici 0`.
- Smoothness is `ContDiffOn ℝ ∞` on `univ ×ˢ Ici 0`.
- The divergence is written so that its *junk value* (0 where `fderiv` does not exist) is documented in a docstring.
- Periodic pressure is added, following the Clay errata.

### The Comparator guarantee [P]

`leanprover/comparator` takes a trusted *challenge* module and an untrusted *solution* module. If it succeeds, each listed theorem in the solution:
- proves the *same statement* as in the challenge;
- uses no axioms beyond the permitted list (here `propext`, `Quot.sound`, `Classical.choice`);
- is accepted by the Lean kernel, and optionally by an independent kernel (here `nanoda`, via `lean4export`).

The solution is compiled inside a `landrun` sandbox. As of Lean v4.35.0, Comparator has been merged into core as `lake comparator` / `lake check`.

### A scaling model for swarms (secondary, heuristic)

Bradshaw (LessWrong, 17 Sep 2026) models parallel test-time compute as $E\approx C\,N^{\beta}$. Here $E$ is the equivalent single-agent compute, $C$ is per-agent compute and $N$ is the number of agents.
- Current swarms have $\beta<1$.
- Toby Ord's essay "Swarm Scaling" (21 Sep 2026; cited by Palladium, 20 Oct) has now been checked. It uses its own symbol, λ, the "parallelizability" exponent: $N$ agents are worth about the per-agent compute scaled by $N^{\lambda}$.
- Ord's headline value is λ≈0.57 on SEC-Bench Pro, with 0.48–0.68 across three benchmarks. He estimated it from the 1/4/16-agent charts in OpenAI's GPT-5.6 launch post.
- Bradshaw's β and Ord's λ are analogous, not the same estimate.
- The trade is wall-clock speed bought with token inefficiency.
- This is a *heuristic*, not an established law.

---

## Detailed findings

### 1. Source map and evidentiary quality

| Source | Type | What it gives |
|---|---|---|
| OpenAI blog "On the Navier–Stokes Millennium Prize Problem" (8 Sep, updated 10 Sep) | [O] (403 to fetch; via search snippets and press) | Groups for A/B vs C/D; Codex cross-pollination; ~100 agents / ~50 h Euler; ~10k agents / 88 h NS; 2.7M messages / 130B tokens (NS); 4.9M / 300B (all problems); GPT-6 Astra Lean, 17 h; monitoring and isolation; "Concurrent work" section; 10 Sep investigation update |
| `openai/NavierStokesAndEuler` repo | [P] | Lean structure, statement provenance, model and framework metadata, Comparator config, commit history |
| OpenAI NS and Euler PDFs | [P] | Mathematics; references; **no description of the AI method** |
| Buckmaster statement (cims.nyu.edu, 7 Sep) | [P][D] | Detailed account of the 3–6 Sep contacts and what OpenAI staff said about prompts, team and seeding |
| Dwarkesh Patel × Noam Brown transcript (17 Sep) | [P] | Swarm design philosophy; messaging primitives; less than 10% credit to multi-agent; no ablations |
| Scientific American (Howlett, 8 Sep, 21 Sep, 13 Oct, 22 Oct, 27 Oct) | [S] | Timeline; 100-agent Euler squad; 10k-agent swarm seeded by Euler; ~$15M compute; experts' reading of novelty |
| Quanta (Kakaes, 8 Sep) | [S] | 100 agents / 50 h; 10k / 88 h; "almost 5 million messages"; 17 h Lean by "another AI model"; humans directed strategy |
| CNBC, CoinDesk, VentureBeat, The Batch, Tufts Daily, TechCrunch, Fortune, TNW, Interesting Engineering, Unite.ai | [S] | Corroborating numbers; tools; quotes from Bubeck, Chen and Altman |
| Wikipedia (NS existence; NS priority controversy) | [S] | Consolidated timeline with citations |
| arXiv 2610.08144, 2609.20803, 2609.23868, 2609.28591, 2609.16470, etc. | [P] | Critiques and follow-ups |

### 2. Timeline (reconciled)

| Date (2026 unless noted) | Event | Source |
|---|---|---|
| Sep 2023 – Oct 2024 | Córdoba–Martínez-Zoroa (CMZ) programme: forced 3D Euler with rough force (2309.08495); hypodissipative NS with force, with Zheng (2407.06776); IPM with smooth source (2410.22920) | [P] arXiv |
| ~2025 | Alpöge proposes collaborating to Buckmaster. Year of slow progress with Claude, Codex (GPT-5.6 Sol) and later Astra, which was used only for writeups and auditing | [P] statement; [S] SciAm 22 Oct |
| 3 Jul | OpenAI later claims no user input after this date could have influenced the system (spokesperson, 13 Sep) | [S] SciAm, Wikipedia |
| 15 Aug | Buckmaster–Alpöge obtain smooth-forcing blowup for Boussinesq and 3D Euler | [P] statement |
| 22 Aug | Their (very ugly) LLM-generated proof is verified in Lean | [P] statement |
| 28 Aug | Training of OpenAI's new internal model begins; training continues during the run | [O] via VentureBeat, SciAm |
| 31 Aug | Alpöge tweets "Augustus Mirabilis"; OpenAI later cites viral rumours as the trigger | [S] SciAm, Wikipedia; Bubeck on X via VentureBeat |
| 1 Sep (Tue) | OpenAI launches agent groups across the open Millennium problems and related questions | [O] |
| 3 Sep (Thu) | Buckmaster emails an OpenAI mathematician; per SciAm, the ~100-agent squad solves (unforced) Euler that night (≈50 h after launch) | [P] statement; [S] SciAm |
| 5 Sep (Sat) | The ~10k-agent group reaches the NS result ≈88 h after the first agents launched | [O] |
| 5–6 Sep | ~17 h Lean formalization (GPT-6 Astra via Codex) | [O]; model and framework [P] in `formalization.yaml` |
| 6 Sep (Sun) | Bubeck and an OpenAI mathematician speak with Buckmaster twice; competing accounts | [P][D] |
| 7 Sep | Buckmaster–Alpöge post three forced-blowup results and Buckmaster's statement; Tao's blog post | [P] |
| 8 Sep (Tue) | OpenAI announcement; papers and Lean repo (commit `8937a8f`); a same-day revision adds citations to CMZ | [P] repo; [S] lilting.ch |
| 10 Sep | OpenAI update: investigation finds Buckmaster's prior-two-month Codex prompts could not have influenced the system, training included. Repo commit `f9e8bc5` adds ~25.1k lines in 188 files (173 new). Only ~1.5k of those lines sit in modules explicitly named `*Paper*`/`Appendix*`; the rest are new supporting modules | [O]; [P] commit (recounted by verifier) |
| 11 Sep | Clay: problem "apparently settled", process "deliberately unhurried" (announcement page); problem page still shows "Status: Active". Letter "A Severe Misalignment of AI in Mathematics" (Fields Medalists). Gómez-Serrano CMSA lecture | [P] Clay page; [P] Zenodo metadata |
| 17 Sep | Constantin–Ignatova–Vicol (analytic forcing obstruction); Brown–Patel podcast | [P] |
| 21 Sep | OpenAI forms independent Advisory Group on Mathematics and AI (hosted at IAS) | [S] TechCrunch, SciAm |
| 6 Oct | Bastounis–Circelli–Hansen "Navier–Stokes lost in translation"; `openai/math` released (SciAm 6 Oct: 372 results at release; the current README lists 721 manuscripts in 373 families) | [P]; [S] |
| 13 Oct, 22 Oct | SciAm: NS construction differs from CMZ in how the force is built; the intermediate Euler result shares the CMZ framework | [S] |
| 26–27 Oct | OpenAI claims *existence* of 4D pure Yang–Mills (also QCD); no mass-gap claim. Model result dated 9 Sep; Lean "well more than a month". Material handed to a group led by David Gross (with Douglas, Jaffe, Klebanov, Nekrasov), which will write it up itself; not released. Secondary outlets give the QCD draft as 18 Sep and the YM Lean completion as 16 Oct. On 26 Oct OpenAI's own Advisory Group called for release | [S] SciAm 27 Oct; [S] TNW 26 Oct (Gross group, 4D, QCD); [S] officechai/datastudios (dates). OpenAI's first-party post not read (403) |

### 3. The model

- The model is unnamed, internal and unreleased. OpenAI calls it a next-generation model significantly more capable than GPT-6 Astra, built by large-scale RL on a pretrained model (per The Batch). [O]
- Training began 28 August and was ongoing. During the NS effort the agents were switched to a further-trained checkpoint (Unite.ai; ctco.blog reconstruction). [O/S]
- Brown's view: the decisive factor was a "very strong general-purpose model" able to run over long horizons and think in parallel. He would not give multi-agent organisation even 10% of the credit. [P]
- Fortune reports OpenAI told reporters it used at least 1,000× more compute than on *some* previous mathematical challenges. [S]
- **Inference [I]:** the system was evaluated at the *frontier of its own training run*. The "method" is inseparable from access to a model that outsiders could not use. Any YM project using public models should expect much lower per-agent capability and plan accordingly (see Principles §P11).

### 4. Swarm architecture

#### 4.1 Numbers (with discrepancies flagged)

| Quantity | Value | Source / notes |
|---|---|---|
| Euler squad | "nearly 100" agents, ≈50 h | [O] via Quanta, VentureBeat. One secondary source says "1000 agents", which looks like an error |
| NS solving group | "on the order of 10,000 concurrent agents" | [O] via CNBC. Group sizes varied across the effort |
| NS wall-clock | ≈88 h from first agent launch (1 Sep) to result (5 Sep) | [O] |
| Messages | NS ≈2.7M; all problems ≈4.9M (Quanta: "almost 5 million") | [O] |
| Output tokens | NS ≈130B; all problems ≈300B | [O]. CoinDesk attaches 130B to NS; TechCrunch prices 300B at ≈$22.5M list |
| Lean formalization | ≈17 h, GPT-6 Astra via Codex | [O] hours; [P] model and framework |
| Cost | "several million dollars" (Bubeck, Quanta); "emphatically in the millions of dollars" (Mark Chen, wire reports); ≈$15M reported, unsourced (SciAm 22 Oct); ≈$6.5M retail equivalent for 130B output tokens at $50/M (VentureBeat calculation); $22.5M for 300B tokens at Astra rates (TechCrunch, hypothetical); Fortune cites ~$2M or $22.5M; VentureBeat calls an outside $10–40M estimate speculative | Mixed; no audited figure |
| Paper | 166 pp (NS), 57 pp (Euler) | [P] |
| Lean | 641,332 lines in current HEAD (NS 429,281; Euler 211,579) across 2,659 `.lean` files. 616,276 lines in 2,486 files at the 8 Sep commit (matches Gamburd's 616,000). Zero `sorry` outside the challenge stubs; no `axiom` declarations; ≈37–38.5k `theorem`/`lemma` declarations depending on the regex | [P] author's count; independently recounted by the verifier on a fresh shallow clone (5 Nov) |

Implied ratios [I]:
- ≈48k output tokens per message.
- ≈270 messages per agent if 10k agents were active the whole time. They were not, so this is a lower bound per active agent.
- ≈410k output tokens per second averaged over 88 h.
- Prose output was ~1.5×10⁵ tokens, so the final paper is ~10⁻⁶ of the tokens generated. Almost all of the generation was exploration that was discarded or consolidated.

#### 4.2 Group structure and communication topology

1. **Formulation portfolio.** OpenAI "suggested" versions (A)/(B), which would give regularity, and (C)/(D), which would give breakdown, to *separate groups of agents*. [O, snippet of openai.com] The groups pursued competing outcomes, including the possibility of breakdown (Interesting Engineering). Buckmaster's account: work had *started on the unforced problem*, and NS was "one of a number of things that was tried". [P][D]
2. **Within-group communication.** Agents could message others in their own group. CNBC and The Batch say communication was within groups. In Brown's description of the general design, an agent can send a message to other agents whenever it wants, as a tool call. [O][P]
   - **Primitives (Brown):** minimal scaffolding. There was no coordinator/child hierarchy. The main tool was "message another agent", and a message is inserted into the recipient's context. Brown compares the workspace to Slack, and says coordination patterns emerge from training rather than hand design. He gives an example of two agents with different answers questioning each other, converging, then broadcasting the correction. [P]
   - **Known failure mode (Brown):** the common local minimum is agents just solving independently instead of collaborating. Early reasoning models were trained to think alone, and messages interrupt their chain of thought. Brown calls current coordination primitive. [P]
3. **Cross-group consolidation ("cross-pollination").** After some time, Codex was used to consolidate the most useful insights from each group and feed them back. This happened in later prompts or as shared context; the exact mechanism is unpublished. [O] Humans evidently triggered and steered this step (see §4.7). [I]
4. **Dynamic reallocation.** After the Euler result, OpenAI shifted agents away from the other Millennium problems and prompted them with the Euler resolution. The solving group grew to ~10k concurrent agents. [O]
5. **Forking (Brown, general).** Models can "fork" so that two copies work in parallel and later merge, and later models' sub-agent spawning forks the relevant context. Whether the NS agents were identical copies is not stated. [P]
6. **Product lineage.** GPT-5.6 (July 2026) shipped "ultra mode" multi-agent with a default of 4 agents. Its public charts compare 1, 4 and 16 agents; per Brown, 4 agents were roughly 2× faster on some tasks, a sublinear speedup that varies by domain. The NS run is the same paradigm scaled to ~10⁴. [S][P]

#### 4.3 Tools and environment

- **Reported:** a read-only cached snapshot of the internet; code execution; agent-to-agent messaging. Everything ran in isolated environments under the "strict safeguards — including monitoring and isolation" that OpenAI applies to frontier evaluations. [O]
- **Not reported** for NS: interval arithmetic, rigorous numerics, computer-assisted proof, or computer algebra. The NS paper is purely analytic. A grep of the 166 pages finds no computer-assisted component; the Euler paper only *cites* prior work that used rigorous numerics. Whether agents used numerics heuristically, for example to explore profiles, is unknown. [P][I]
- **Lean during search:** not reported. Quanta says *another* model formalized after the 88 h. SciAm (13 Oct) loosely says the agents coded their arguments into Lean. The repo metadata attributes formalization to GPT-6 Astra/Codex. **Inference [I]:** natural-language search came first and Lean came after as a separate stage, although agents may have used Lean opportunistically.
- **One unconfirmed claim:** an AccuKnox blog says per-token safety classifiers cost about 20% extra compute. Unconfirmed and secondary. [S]

#### 4.4 Seeding and search trajectory

- **Trigger.** OpenAI says viral rumours, including Alpöge's tweet, prompted it. Bubeck wrote on X that OpenAI began working on the Millennium problems because of those rumours. [O][S]
- **[UNVERIFIED]** The earlier draft said Noam Brown stated OpenAI had previously tried Millennium problems without success. The verifier found no such statement in the Brown–Patel transcript or in the press checked. Wire reports instead quote Brown saying "We didn't expect it to solve any."
- **First prompt.** The prompt shown to Buckmaster was described as just the problem statement, but in his account it had itself been written by prompting Codex. OpenAI later conceded the first prompt was sent only days before, after word of Buckmaster–Alpöge's progress had reached OpenAI. [P][D]
- **Ladder.** By Buckmaster's account the team "first set the model on easier problems, including Euler". By OpenAI's account the Euler disproof (~100 agents, ~50 h) became the seed: agents were "prompted with the Euler resolution". [P][O]
- **Branching by formulation.** A/B (regularity) versus C/D (breakdown) groups. The successful line was forced breakdown, the route CMZ had opened. Buckmaster calls this route rare in the community and says one does not arrive at it "in a few days" from the problem statement alone. [O][P][D]
- **Novelty assessment.**
  - Experts initially read the NS proof as following the CMZ "Spanish programme".
  - By mid-October Gonzalo Cao-Labora (EPFL) and other expert groups consulted by SciAm judged the NS construction to be "a different approach" in its details (SciAm 13 Oct). SciAm 22 Oct says the way it builds the force is distinct from the CMZ programme, and that Buckmaster acknowledges it introduced new ideas.
  - *Attribution correction:* the specific mechanism contrast comes from the NS paper's own introduction (§1.1), not from those experts. On one side are oscillatory pulses whose mean momentum flux supplies the missing force on a collapsing background vortex; on the other, CMZ's successive amplification of increasingly concentrated vortex layers.
  - The intermediate Euler result does share the CMZ framework. Fan Zheng is quoted to that effect in SciAm 22 Oct, consistent with Buckmaster's view; SciAm 13 Oct says "some experts" think so.
  - Camillo De Lellis remarked that the influence question is no longer a matter of clearly verifiable fact.
  - The NS paper's own introduction says it exploits dynamical amplification "with a different role for the amplified disturbances". [S][P]

#### 4.5 Internal verification of candidate arguments

- **Public facts:**
  - Agents could run code.
  - Agents cross-checked one another through messaging (Brown's convergence example is generic, not NS-specific).
  - Codex distilled intermediate results.
  - A separate formalization stage produced a kernel-checked Lean proof against an independently authored statement. [O][P]
- **Not public:** any description of
  - internal refereeing agents;
  - acceptance thresholds before consolidation;
  - how many candidate "proofs" were rejected;
  - whether the 166-page text was generated before, after or alongside the Lean.
- **Evidence the paper and Lean diverged.** The 10 Sep commit added ~25.1k lines in 188 files.
  - It created new "paper" modules (`PaperResults`, `LocalPaperTheorem`, `PeriodicPaperTheorem`, `AppendixHeatResults`, `AppendixJoiningResults` and others), which map additional paper statements to Lean.
  - The explicitly *Paper*/*Appendix*-named files account for only ~1.5k of the added lines. The other ~23.7k lines are new supporting modules, presumably feeding those statements [I].
  - This suggests alignment was improved after release. [P][I]
- **Self-assessed review.** `formalization.yaml` lists `review.status: "self-assessed"`. Compare `"agent-reviewed"` in `ten-proofs` and `"unchecked"` in `openai/math`. [P]
- **External checking (corrected).** Gamburd writes that by 20 Sep he could find no announced outside clean-environment build, import/axiom audit, *and* check that the formal statements are Clay's (C)/(D). However, his own footnote records a partial exception, Santibañez-Leal (Zenodo, 17 Sep, doi:10.5281/zenodo.22820521):
  - the certificate was rebuilt (11,424 jobs, zero `sorryAx`, three standard axioms);
  - both halves were replayed through the Lean kernel from an empty environment at the pinned toolchain.

  So an independent rebuild, replay and axiom audit *has* been reported. What remains unreported is an independent statement-faithfulness review against Fefferman's (C)/(D). [P] The repo ships a Comparator configuration for such replays. [P]

#### 4.6 How the Lean formalization was done

- **Agent and framework.** Model: "GPT-6 Astra"; framework: "Codex"; method: "agent" (`formalization.yaml`). This is a different, *public* model from the one that found the proof. The ~17 h figure is OpenAI's. [P][O]
- **Statement provenance.**
  - The reference statements come from DeepMind's *formal-conjectures*, written before and independently of the proof.
  - The Euler challenge is a documented specialisation of the same file (zero viscosity, zero force).
  - The solution's adapters import a project copy of the definitions (`ComparatorDefinitions`) and never the challenge module. Comparator then checks the two statements are identical. [P]
- **Engineering.**
  - Toolchain Lean `v4.34.0-rc2` with Mathlib at the matching tag.
  - Many small files, typically 2–15 kB (≈2,650 in all).
  - Descriptive module names: `AllOrderDriftPressureBounds`, `ComparatorMaximalSolution`, …
  - `autoImplicit=false` and `warningAsError=true` for the Euler library.
  - `#print axioms` on the headline theorems. [P]
- **Scale comparison.** ≈640k lines of Lean for 223 pages of mathematics, roughly 2.9k Lean lines per page [I]. For calibration, Anthropic's Claude formalization of FLT (announced 4 Sep 2026) is reported at ~13M lines in ~11 days with "several dozen" agents, using an internal research model (SiliconANGLE). That one is [S] and unaudited.
- **Disputes about duration.** For OpenAI's YM claim, OpenAI said Lean verification took "well more than a month". Buckmaster countered that Lean "takes, at most, a couple of days" (SciAm 27 Oct). [S][D]

#### 4.7 Human involvement: competing accounts

| Account | Content |
|---|---|
| OpenAI / Bubeck | Produced with "very little human input". OpenAI offered to share the human prompts. The staff had maths, physics and CS backgrounds but no research-level fluid-dynamics expertise and "could not meaningfully contribute" to the mathematics (Bubeck on X, via TNW and SciAm). [O] |
| OpenAI blog (via press) | Humans launched the groups, assigned formulations to separate groups, reallocated agents, chose to feed the Euler result into the NS effort, used Codex to consolidate across groups, updated the model, and maintained safeguards. [O] |
| Quanta | Humans directed the agents and set strategy; checking that the Lean statement matches the intended problem remains a human job. [S] |
| Buckmaster (6 Sep call) | An "entire team" worked on the problem. The unforced problem was tried first, and easier problems (including Euler) before NS. The shown prompt was written by prompting Codex. Compute was enormous. The timing of the first prompt was conceded only under questioning. [P][D] |
| Altman | Says he spent much of the weekend with the team. [S] |
| SciAm (22 Oct; 13 Oct) | 22 Oct: OpenAI announced without anyone on staff understanding even the proof's broad strokes. 13 Oct: more than a month later, no one fully did. [S] |

**[I] Synthesis:** the "autonomy" was real at the level of mathematical content, but heavily human-orchestrated at the level of *portfolio management*: which problems, which formulations, when to consolidate, where to move compute, and when to stop and formalize. That is a reusable division of labour.

### 5. Relation to the Córdoba–Martínez-Zoroa programme and the Buckmaster–Alpöge work

**CMZ programme (human, analytic).** Build the solution in stages. Each stage adds a small, high-frequency, localized correction that a low-frequency background instability amplifies. Feedback and self-interaction are suppressed, and the force's regularity is controlled throughout (Tao's 7 Sep summary; CMZ papers).
- Forced Euler with a $C^{1,1/2-\varepsilon}$ force (2309.08495).
- IPM with a smooth source, using approximations of increasing order (2410.22920).
- Hypodissipative NS with a force in $L^1_tC^{1,\epsilon}_x\cap L^\infty_tL^2_x$ (2407.06776).

**Buckmaster–Alpöge workflow (human-directed LLM).** This is a different model of AI use from OpenAI's, and an instructive contrast:
- A year-long personal collaboration, with Buckmaster paying for compute.
- Claude was used to identify the key elements of CMZ's proof and *reproduce* it.
- Claude and Codex wrote the main body of the papers. The "delicate bookkeeping of inductive orders and constants" was delegated to the models, while the humans supplied the adaptations.
- Models produced an over-complicated first version; the humans simplified it with their own ideas (some from convex integration).
- Models formalized the result in Lean (2609.16470 §1; public repo `tristanbuckmaster/fluid_lean`). [P]
- Results: forced IPM, Boussinesq and 3D Euler with smooth space-time forcing. The first LLM proof was "horrendous", and Lean verification came on 22 August. A hypodissipative-NS result was pending Lean. [P]
- Buckmaster publicly called the Euler writeup "AI slop" and apologised for releasing it under time pressure. [P]

**OpenAI's relation to that work.**
- OpenAI ceded priority on *forced* Euler to Buckmaster–Alpöge; its own Euler result is *unforced*.
- It claims the NS result as its own.
- It denies its researchers or agents saw their work.
- Its first statement said it could not rule out that de-identified product-usage data had helped improve its models. After an internal investigation it stated that the pair's Codex prompts from the preceding two months could not have influenced the system. Its spokesperson later added that no inputs after 3 July could have. [O][D]

### 6. Failure modes and criticisms

1. **Scope / "forcing loophole".** (C)/(D) let one *define* $f$ as the residual of an engineered velocity field. The proof's whole difficulty is keeping that residual $C^\infty$.
   - Silvestre: the Clay problem is settled but the main NS problem is not. Cao-Labora: if the result holds, people may conclude the force should never have been in the statement (SciAm 21 Sep). [S]
   - Constantin–Ignatova–Vicol (2609.20803) take solutions with OpenAI's key features (anisotropic Type II bounds for the angular mean; exact axisymmetry in a collapsing core) and a real-analytic force. For these, the putative singular point is regular.
     - Consequence: in any construction with those features whose force stays bounded in $C^2$ up to the singular time, the force can neither vanish near the singular point nor be real-analytic in space.
     - So this route cannot produce unforced blowup, which would refute (A)/(B). It is an obstruction to a class of constructions, not a statement about (A)/(B) themselves. [P, abstract checked]
   - Petrillo–Glimm (2609.23868) explicitly frame the next step as a "programmatic search" for unforced blowup. They supply a target (the positive-defect problem) and admissibility criteria for candidates, because "the papers describe no method". [P]
2. **Priority, provenance and norms.**
   - The episode turned on unverifiable provenance: rumours, private Codex sessions, possible influence from training data. It also involved aggressive negotiation over authorship, including an alleged "Why would you ruin your career?".
     - Bubeck apologised for an "extremely poor choice of words".
     - He denies ever asking to remove Alpöge from authorship (TNW, 10 Sep). [P][D]
   - OpenAI's assurances rest on internal records that have not been published. [S]
   - Reactions:
     - an AMS news item, whose text the verifier could not retrieve: **[UNVERIFIED content]**;
     - a European Mathematical Society statement (10 Sep; found by search, not read);
     - the open letter "A Severe Misalignment of AI in Mathematics" (Zenodo, 11 Sep), with 25 signatories in its DataCite record, including Tao, Scholze, Hairer and Viazovska;
     - Tao's warnings in Fortune about treating open problems as "marketing proof points" and about companies not publishing failed attempts. [S]
3. **Lean ≠ paper (autoformalization drift).** Bastounis–Circelli–Hansen (2610.08144) show concrete mismatches:
   - Lemma 8.6 (8.19) costs $m+4$ derivatives in the paper but $m+5$ in the cited Lean estimate.
   - Estimate (10.19) is proved in Lean by a different route: Sobolev embedding plus $L^2$ Riesz bounds instead of $L^{3/2}$, with different Hölder exponents and an explicit continuity-in-time upgrade.
   - They argue in general that resolving natural-language ambiguity is at SCI $=\infty$, so autoformalization gives *no* guarantee about the natural-language proof. They do **not** claim the NL proof is wrong, or that the headline Lean theorem fails. [P]
4. **No human understanding / readability.** As far as anyone had said publicly at the time Gamburd wrote (shortly after the release; footnotes to 20 Sep), no human had read all 166 pages. Staff did not understand it at announcement (SciAm). Research groups are now using the Lean code, the paper and other LLMs to simplify it (SciAm 13 Oct). Tao: solving the problem is a proxy for understanding, which is the real goal. Gamburd: the release delivered certification without demonstration. [P][S]
5. **Unmeasured value of the swarm.** No single-agent baseline and no 10k-versus-1k comparison. Brown gives multi-agent organisation less than 10% of the credit and recommends systematic tests at 64/128/256 agents. Coordination quality is unbenchmarked. [P]
6. **Reproducibility.** The model is unreleased and the prompts were not released. OpenAI's own advisory group recommended releasing the model, the exact prompts and per-result compute, and OpenAI said it is not bound by that (SciAm 6 Oct). [S]
7. **Citation hygiene.** Per a secondary account, the 8 Sep paper initially lacked CMZ citations, which a same-day revision added. Buckmaster–Alpöge are still not cited in the paper's references (verified in the current PDF). [S][P]
8. **Error rates in the wider pipeline.** On 7 Oct, one day after release, `openai/math` withdrew three manuscripts after a sign error and repaired 14 others (history.md). About 42% of top-line results are formalized. Unformalized AI output fails at a non-trivial rate. [P]

### 7. Other 2026 AI-math production modes (for contrast)

| Mode | Example | Compute and organisation | Verification |
|---|---|---|---|
| Massive swarm on a single target | OpenAI NS (Sep) | ~10⁴ concurrent agents, 88 h, 130B output tokens; formulation groups plus Codex consolidation | Separate-model Lean (17 h) plus Comparator against an external statement |
| Small squad on a warm-up | OpenAI unforced Euler | ~100 agents, ~50 h | Same repo |
| Broad sweep, fixed procedure | `openai/math` (Oct): 721 manuscripts / 373 families (current README; SciAm counted 372 results at the 6 Oct release) | ~4,000 problems posed; on average ~3 h of ChatGPT Pro thinking compute per result, "same procedure". The README does **not** say single-agent or single-prompt; an OpenAI spokesperson said some results may have taken multiple attempts (SciAm 6 Oct). Filtered for significance | ~42% of top-line results formalized (300/719 on 7 Oct); Comparator challenges; withdrawals logged |
| Agent formalization of a known proof | Anthropic FLT (Sep, reported) | "Several dozen" agents, ~11 days, ~13M Lean lines, internal research model | SiliconANGLE quotes Buzzard and says his work was used. It does not describe him as a reviewer; [S] only |
| Human-directed LLM | Buckmaster–Alpöge | 2 humans plus Claude/Codex, ~1 year, burst in Aug | Lean (`fluid_lean`), human rewrite |
| AI-maintained formal archive | Lean Pool (2609.25199) | Agents pool, bump and optimise formal projects (211 projects, 3.2M lines) | Kernel, linters, LLM review |

---

## What is proven vs open

| Claim | Status | Basis |
|---|---|---|
| Forced NS blowup on $\mathbb{R}^3$ and $\mathbb{T}^3$ for every $\nu>0$ (Clay C/D) | **Claimed; Lean-certified top-line statements; NL proof not independently refereed.** Clay status "active" | OpenAI repo plus Comparator config [P]; Clay 11 Sep |
| Lean statements match the formal-conjectures reference | **Mechanically checkable** (Comparator). An independent rebuild, kernel replay from an empty environment and axiom audit were reported 17 Sep (Santibañez-Leal, Zenodo). No independent Comparator report found | [P]; Zenodo 22820521 |
| formal-conjectures statement faithfully encodes Fefferman's (C)/(D) | **Plausible, human judgment.** Includes Clay errata (periodic pressure); open to review | [P] |
| Lean proof follows the paper | **False in places** (documented mismatches in intermediate lemmas) | 2610.08144 [P] |
| Unforced Euler blowup from smooth compact data (OpenAI) | **Claimed, Lean-certified**; a major claim in its own right; little independent review reported | [P] |
| Forced Euler / Boussinesq / IPM (Buckmaster–Alpöge; with Coiculescu for IPM) | **Claimed, Lean-verified, preprints**; under review | [P] |
| Unforced NS, Clay (A)/(B) | **Open**. CIV show the OpenAI-type construction cannot extend to analytic forcing | 2609.20803 [P] |
| ~10k agents, 88 h, 2.7M messages, 130B tokens, 17 h Lean | **OpenAI-reported, unaudited** | [O] |
| Multi-agent organisation was essential | **Unsupported**; OpenAI's own researcher gives it less than 10% | [P] |
| OpenAI's process was uninfluenced by Buckmaster–Alpöge data | **Asserted by OpenAI; disputed; unverifiable externally** | [O][D] |
| OpenAI YM existence (4D pure YM, plus QCD; not mass gap) | **Claimed, unreleased.** Lean formalization reportedly completed 16 Oct (secondary sources only). Material with a Gross-led group (Douglas, Jaffe, Klebanov, Nekrasov) that will write it up | [S] SciAm 27 Oct; TNW 26 Oct |

---

## Relevance to a 4D YM existence + mass-gap proof and to Lean formalization

1. **The swarm paradigm demonstrably produced Clay-level output, but for a construction problem with slack.**
   - NS (C) is existential. One explicit flow suffices, and the force absorbs every error as long as it stays smooth.
   - Cao-Labora's remark that LLMs excel at explicit constructions but are weaker at new theory is exactly the risk for YM.
   - YM existence plus mass gap is a universally quantified, non-perturbative *measure-construction* problem for all compact simple $G$. It needs Osterwalder–Schrader/Wightman axioms, a continuum limit, infinite volume and a spectral gap. There is no residual term to dump errors into.
   - **[I]** The most construction-like route, Balaban's multi-scale RG programme for 4D lattice YM (UV stability), *does* resemble CMZ-type multi-scale induction. It involves enormous bookkeeping of inductive orders and constants, which is exactly what Buckmaster–Alpöge delegated to models. That is where a swarm plus Lean is most likely to pay off.
2. **Loophole risk transfers in a new form.** Analogues of the "forcing" loophole for YM include proving:
   - existence only;
   - one gauge group (∃G rather than ∀G);
   - 3D rather than 4D (the Alpöge–Sussman claim is 3D, per SciAm 27 Oct);
   - a lattice or finite-volume theory;
   - a trivial or Gaussian theory satisfying the axioms;
   - a "mass gap" defined in a weaker sense, such as exponential clustering of some observables rather than a spectral gap of the Hamiltonian.

   Agents optimising against a formal target will exploit any such gap. The NS episode shows that formal correctness against an under-specified statement produces years of "did they solve the wrong problem?" debate.
3. **The statement must exist before the search.** NS had DeepMind's formal-conjectures reference ready. As of today, formal-conjectures' `Millennium/` folder contains BSD, NavierStokes, Poincaré, PvsNP and RiemannHypothesis, and **no Yang–Mills statement** [P, directory listing]. Our project's "option 1" (a Lean problem statement) is therefore on the critical path and has public value: it could be contributed upstream and refereed.
4. **Lean scale.** OpenAI produced ~640k Lean lines for 223 pages in ~17 h with a public model, on top of a Mathlib that already has the needed calculus and PDE basics. For YM, Mathlib lacks constructive-QFT infrastructure:
   - Gaussian measures on distribution spaces;
   - OS axioms;
   - reflection positivity;
   - lattice gauge measures with Haar integrals;
   - RG block-spin machinery.

   **[I]** Formal infrastructure is therefore the dominant cost and should be built from day one by a dedicated formalization swarm. The user's "~1,000 pages" estimate should be read as *mathematical* pages, which could translate to millions of Lean lines at NS's ratio.
5. **OpenAI's own YM claim** came from the same internal model, dated 9 September, the day after the NS announcement. **[I]** That is consistent with the 1 September launch "across the open Millennium problems".
   - If the unreleased claim holds, the existence part was found within days by a comparable process, while the mass gap was not obtained.
   - That would support the premise that a solution is reachable by reasoning LLMs, and suggest the mass gap is the harder residue.
   - **Caveat:** the YM material has not been released or independently checked (as of 5 Nov). It is a claim reported by press, not evidence of correctness. The proofs are unreleased; see the separate workstreams on the YM claim and the Balaban programme.

---

## Transferable design principles for an AI swarm attacking 4D Yang–Mills

These are concrete and actionable. Each cites the NS evidence it rests on.

**P1. Freeze an adversarially reviewed formal target before any search** (NS: formal-conjectures reference plus Comparator; failure: the forcing loophole). Petrillo–Glimm argue that once solutions are searched for programmatically at this scale, the value of the work moves to *specifying the target and the conditions a candidate must meet*.
- Write `Challenge/YangMills.lean`, importing only Mathlib. It should state: for **every** compact simple Lie group $G$ there exists a quantum YM theory on $\mathbb{R}^4$ satisfying OS axioms OS0–OS4 (regularity/temperedness, Euclidean covariance, reflection positivity, symmetry, clustering) or Wightman axioms, which is **non-trivial (non-Gaussian)** and has **mass gap $\Delta>0$** in the spectral sense.
- Add separately named milestone statements. Each is its own frozen challenge.
  - Lattice: $\mathbb{T}^4_\varepsilon$ with Wilson action.
  - UV-stable continuum limit in finite volume.
  - Infinite-volume limit.
  - OS reconstruction.
  - 3D YM.
  - 2D YM (known; calibration).
  - 2D $O(3)$ sigma-model mass gap (`openai/math` family 215 claims it).
- Run a **loophole red team**: agents whose only job is to satisfy the draft statement *degenerately*, for example with a free field, $G$ abelian, junk values from `fderiv` or `MeasureTheory` defaults, vacuous hypotheses, or a trivial Hilbert space. Every degenerate model found becomes a regression test that the final statement must exclude.
- Have human constructive-QFT experts sign off, hash the challenge files, and record the hash in the run log. Use `lake comparator` (Lean ≥ v4.35) with `permitted_axioms = [propext, Quot.sound, Classical.choice]` and a second kernel (`nanoda`).

**P2. Run a formulation portfolio in separate groups, then concentrate** (NS: A/B vs C/D to separate groups; resources moved from other Millennium problems once Euler cracked). Initial groups, sized for a modest budget:
- G1, Balaban RG completion (UV stability, 4D);
- G2, stochastic quantization / Langevin / gradient-flow constructions (extending 2D/3D results);
- G3, lattice reflection-positivity → OS reconstruction pipeline;
- G4, mass-gap mechanisms (strong-coupling expansions plus continuation, correlation inequalities, area law ⇒ gap);
- G5, an obstruction / "disproof" group that tries to show each route cannot work. CIV's analytic-forcing obstruction is the model: it would have pruned the NS (A)/(B) path early.

Reallocate weekly to the group with the most kernel-checked progress toward a frozen milestone.

**P3. Climb a seeding ladder** (NS: ~100 agents × ~50 h on unforced Euler, then "prompted with the Euler resolution"; Buckmaster–Alpöge IPM → Boussinesq → Euler).
- Order: 2D YM (formalize known results as calibration and infrastructure) → 3D YM / superrenormalizable models (φ⁴₃; 3D YM per Alpöge–Sussman) → 4D lattice bounds uniform in the lattice spacing → 4D continuum.
- Every rung's Lean plus NL artefacts become the seed context for the next rung.
- Allocate roughly 1% of budget to warm-ups. That ratio is NS's 100 versus 10,000 agents.

**P4. Minimal scaffolding inside groups; explicit distillation between groups** (Brown: simple message tool, no rigid hierarchy; OpenAI: Codex consolidation; failure mode: agents solving independently).
- Groups of 8–64 heterogeneous agents with all-to-all messaging inside the group.
- One **consolidator** per cycle (every 6–12 h) reads all group logs and writes a ≤5-page "insight ledger". The ledger covers proved lemmas (with Lean status), promising reductions, refuted ideas with counterexamples, and open sub-goals. It is broadcast to all groups.
- Humans approve each ledger version, which gives a cheap control point.

**P5. Engineer heterogeneity and verification-by-default** (Bradshaw: near-identical agents converge and duplicate; Brown: convergence by disagreement).
- Give each agent a distinct role: constructor, estimator, skeptic, literature-mapper, formalizer.
- Give each a distinct literature seed (Balaban's papers; Magnen–Rivasseau–Sénéor; Federbush; recent stochastic-quantization work).
- Give each a distinct formulation.
- Require that any claim imported from another agent be re-derived or Lean-checked before reuse.

**P6. Separate discovery from formalization, but couple them through an alignment map** (NS: a different model formalized in 17 h; failure: Lean/paper drift).
- Run a dedicated formalization stage *and* a continuous formalization swarm.
- Maintain a machine-readable `alignment.yaml` mapping every NL theorem and lemma to a Lean declaration. OpenAI's `formalization.yaml` alignment block and `PaperResults.lean` are the pattern to copy.
- Run an automated **hypothesis-diff agent** that flags discrepancies such as derivative counts ($m{+}4$ vs $m{+}5$), norms, quantifier order and exponents. Fix by changing either the paper or the Lean.
- Policy: **Lean is the source of truth**, and the NL exposition is regenerated or edited to match it, never the reverse.

**P7. Build the Mathlib-gap infrastructure in parallel from day one** (NS benefited from mature Mathlib calculus; YM will not).
- Stand up a library-building swarm (Lean Pool style) for:
  - Haar measure on compact $G$ and lattice gauge measures;
  - Gaussian measures on $\mathcal{S}'(\mathbb{R}^d)$;
  - reflection positivity and OS reconstruction;
  - transfer-matrix spectral theory;
  - polymer and cluster expansions;
  - block-spin RG.
- Track Lean lines per NL page as a KPI. NS ran at ≈2.9k lines per page.

**P8. Give agents the right tools, and label rigour.**
- NS agents had a cached internet snapshot plus code execution. For YM add:
  - a frozen literature corpus (also the provenance anchor);
  - lattice Monte Carlo for heuristics (string tension, glueball masses);
  - computer algebra for cluster-expansion combinatorics;
  - **interval arithmetic** (Arb/MPFI) for explicit-constant RG estimates;
  - Lean in the loop.
- Every numerical output is tagged *heuristic* until certified by interval arithmetic or Lean.

**P9. Provenance by construction** (NS: the priority fight was unresolvable because the records are private).
- Log every prompt, message, model/checkpoint ID, tool call, corpus snapshot hash, human intervention and timestamp.
- Prompts written by models (Buckmaster: the NS prompt was written by prompting Codex) are logged as such.
- Keep the corpus date fixed and documented.
- Never use third-party private data.
- Publish the log with any result.
- Track concurrent human efforts (Alpöge–Sussman; Balaban-programme experts) and contact them *before* any announcement.

**P10. Domain experts early; understanding as a deliverable** (NS: OpenAI lacked fluid-dynamics expertise, mis-stated the relation to prior work, and could not explain the proof).
- Recruit two or three constructive-QFT or RG experts as reviewers or shepherds from the start.
- Assign agents to exposition and simplification. This is the step Buckmaster spent weeks on, and the one groups are now applying to OpenAI's NS proof.
- Deliver an NL paper that a human referee can read. Cite prior programmes generously.

**P11. Size the swarm to the evidence, measure scaling, and expect weaker base models.**
- Brown: base-model strength dominates, swarm organisation is under 10%, speedups are sublinear, test at 64/128/256 agents.
- `openai/math`: results came from a fixed procedure averaging about 3 hours of ChatGPT Pro thinking compute per result, swept over ~4,000 problems. That they were single-agent runs is an inference [I], not stated in the README.
- Default architecture for a public-model budget: **decompose into hundreds of lemma-level tasks** (for example, each gap or estimate in Balaban's papers) and run each as a strong single-agent long-horizon job with Lean checking. Use group swarms only for the 2–5 genuinely creative bottlenecks.
- Run small ablations (1/4/16/64 agents) on a calibration rung before scaling.
- Budget reference: NS used ~1.3×10¹¹ output tokens. Plan in phases of 10⁸–10⁹ tokens with kill or continue criteria.

**P12. Safety and integrity controls.**
- Run agents in isolated sandboxes, as NS did under "monitoring and isolation". Comparator itself runs proofs under `landrun`.
- Treat agent-produced Lean as adversarial input. Never compile solution modules in the environment that holds the trusted challenge before running Comparator; this is Comparator's assumption 2.
- Watch for reward hacking against the statement: the forcing loophole is the conceptual precedent.

**P13. Publication norms.** Avoid announcing by press release. The NS release was criticised for this: TNW contrasted the mathematicians' machine-checkable preprints with OpenAI announcing on a call with reporters, and Gamburd stresses "by press release". The Nature news piece (Castelvecchi, 17 Sep) is paywalled and was not read, so its position is unverified.
- Release NL plus Lean plus Comparator configuration plus logs together.
- Get an independent clean-room Comparator run before any claim.
- Distinguish "Lean-certified top-line theorem" from "refereed NL proof".
- Follow the AGMAI-style recommendations: release prompts and compute per result.

---

## Open questions / leads

1. **The OpenAI blog's full text,** including the "Concurrent work" section and the 10 Sep update. Direct fetching was blocked (403). A human should read it in a browser and archive it; Wikipedia cites a Wayback snapshot (8 Sep, 17:15 UTC).
2. **Internal verification protocol.** Did agents use Lean during search? Were there referee agents? How many candidate proofs were rejected? None of this is public. Possible sources: the Dwarkesh–Brown transcript (partial), a future OpenAI technical report, the Gómez-Serrano CMSA lecture video (11 Sep).
3. **The A/B/C/D group sizes,** the consolidation cadence and the human-approval points are not published. Ask, or watch for an OpenAI methods paper.
4. **Ord's swarm-scaling essay.** Resolved by the verifier: T. Ord, "Swarm Scaling" (21 Sep 2026), λ≈0.57 (range 0.48–0.68), estimated from GPT-5.6 launch charts. It rests on vendor benchmark plots at N ≤ 16, so extrapolation to 10⁴ agents is unsupported.
5. **Independent replays** of `openai/NavierStokesAndEuler`. One rebuild, kernel replay and axiom audit exists (Santibañez-Leal, Zenodo 22820521, 17 Sep). Still open: an independent Comparator run, and a human statement-faithfulness review of the formal-conjectures (C)/(D) against Fefferman. Search the Lean Zulip and the repo's forks (228 as of 5 Nov).
6. **Alpöge–Sussman YM work** (Anthropic internal Claude, many agent copies, filling gaps in Balaban's programme; GitHub disclosure 6 Oct; 3D claim). This is the closest analogue to our project. Locate the repo; it is a priority lead for the Balaban workstream.
7. **`openai/math` family 215** (canonical $O(3)$ continuum limit with a positive mass gap; exact $O(4)$ mass asymptotics; Lean-linked). This is a direct template for a "continuum limit plus mass gap" formal statement in 2D. Inspect its Lean statement and Comparator challenge.
8. **Formal-conjectures has no YM file.** Consider drafting one and submitting it upstream, which gets independent review of our statement (P1).
9. **Lean in core:** `lake comparator` / `lake check` landed in v4.35.0. Pin our toolchain accordingly.
10. **Bastounis et al.'s "experiment" link** for finding further mistranslations automatically could be adapted as our hypothesis-diff agent (P6).

---

## References

Each entry is marked **verified** if I confirmed it exists (arXiv API, GitHub API, a publisher page fetched, or an authoritative listing). "Read" means I accessed the content.

1. OpenAI. "On the Navier–Stokes Millennium Prize Problem." Blog, 8 Sep 2026, updated 10 Sep 2026. https://openai.com/index/navier-stokes-solution/ — **verified (exists; linked from OpenAI's repo; seen in search). Content not directly fetched (HTTP 403); known via search snippets and press.**
2. OpenAI. "Finite time blowup for Navier–Stokes." 166 pp., 8 Sep 2026. https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf — **verified, read.**
3. OpenAI. "Finite time blowup for the Euler equation." 57 pp., 8 Sep 2026. https://cdn.openai.com/pdf/315b36cd-ec98-4023-8342-93345194ece1/euler.pdf — **verified, read.**
4. OpenAI. `openai/NavierStokesAndEuler` (Lean 4 certificates; commits `8937a8f` 8 Sep, `f9e8bc5` 10 Sep). https://github.com/openai/NavierStokesAndEuler — **verified, cloned and inspected.**
5. OpenAI. `openai/math` (721 manuscripts, 373 families; README, history.md). https://github.com/openai/math — **verified, read.**
6. OpenAI. `openai/ten-proofs` (Lean certificates, Aug 2026). https://github.com/openai/ten-proofs — **verified, read.**
7. Google DeepMind et al. *Formal Conjectures*, `FormalConjectures/Millenium/NavierStokes.lean` (commit `8bf45ed`, 27 Jul 2026). https://github.com/google-deepmind/formal-conjectures — **verified (GitHub API).**
   - At `8bf45ed` the folder is spelled `Millenium` and holds NavierStokes, Poincaré, PvsNP and RiemannHypothesis.
   - At HEAD (5 Nov) it is `Millennium` and adds BSD.
   - The full tree has no Yang–Mills file; `Wikipedia/Mills.lean` is Mills' constant.
8. Lean FRO. *Comparator.* https://github.com/leanprover/comparator — **verified, README read.**
9. T. Buckmaster. Statement, 7 Sep 2026. https://cims.nyu.edu/~tristanb/statement.pdf — **verified, read.**
10. T. Tao. "Finite time blowup with smooth forcing term for the incompressible porous medium, Boussinesq, and incompressible Euler equations." Blog, 7 Sep 2026. https://terrytao.wordpress.com/2026/09/07/finite-time-blowup-with-smooth-forcing-term-for-the-incompressible-porous-medium-boussinesq-and-incompressible-euler-equations — **verified, read.**
11. Clay Mathematics Institute. "Navier–Stokes announcement," 11 Sep 2026. https://www.claymath.org/news/navier-stokes-announcement — **verified, read.**
12. C. L. Fefferman. "Existence and smoothness of the Navier–Stokes equation." Clay official problem description. https://www.claymath.org/wp-content/uploads/2022/06/navierstokes.pdf — **verified (linked by OpenAI repo and paper; standard document); not re-read here.**
13. K. Kakaes. "AI Has Solved One of Math's $1 Million Millennium Prize Problems." *Quanta*, 8 Sep 2026. https://www.quantamagazine.org/ai-has-solved-one-of-maths-1-million-millennium-prize-problems-20260908/ — **verified, read.**
14. J. Howlett. "The inside story behind OpenAI's million-dollar math proof." *Scientific American*, 22 Oct 2026. https://www.scientificamerican.com/article/the-inside-story-behind-openais-million-dollar-math-proof/ — **verified, read.**
15. J. Howlett. "OpenAI's blockbuster Navier-Stokes proof isn't what we thought it was." *Sci. Am.*, 13 Oct 2026. https://www.scientificamerican.com/article/openais-blockbuster-navier-stokes-proof-isnt-what-we-thought-it-was/ — **verified, read.**
16. J. Howlett. "Did OpenAI solve the wrong Navier-Stokes problem?" *Sci. Am.*, 21 Sep 2026. https://www.scientificamerican.com/article/did-openai-solve-the-wrong-navier-stokes-problem/ — **verified, read.**
17. J. Howlett. "OpenAI claims blockbuster math breakthrough amid swirl of controversy." *Sci. Am.*, 8 Sep 2026. https://www.scientificamerican.com/article/openai-claims-blockbuster-math-breakthrough-amid-swirl-of-controversy/ — **verified, read.**
18. J. Howlett. "AI may have just solved a million-dollar math problem. The field will never be the same." *Sci. Am.*, 8 Sep 2026. https://www.scientificamerican.com/article/ai-may-have-just-solved-a-million-dollar-math-problem-the-field-will-never-be-the-same/ — **verified, read.**
19. J. Howlett. "OpenAI unleashes hundreds more math results upon a field already in shock." *Sci. Am.*, 6 Oct 2026. https://www.scientificamerican.com/article/openai-unleashes-hundreds-more-math-results-upon-a-field-already-in-shock/ — **verified, read.**
20. J. Howlett. "OpenAI just scooped human researchers on a million-dollar quantum math problem" (HTML title; displayed headline "OpenAI just scooped mathematicians' work on another million-dollar problem"). *Sci. Am.*, 27 Oct 2026. https://www.scientificamerican.com/article/openai-just-scooped-human-researchers-on-a-million-dollar-quantum-math-problem/ — **verified, read.**
21. K. Bishop. "OpenAI claims to have solved the 90-year-old Navier-Stokes math problem in 88 hours." CNBC, 9 Sep 2026 (updated 16 Oct). https://www.cnbc.com/2026/09/09/openai-navier-stokes-math-problem-solved.html — **verified, read.**
22. S. Malwa. "OpenAI says 10,000 AI agents solved a $1 million math problem. Now mathematicians are fighting." CoinDesk, 9 Sep 2026. https://www.coindesk.com/tech/2026/09/09/openai-says-10-000-ai-agents-solved-a-usd1-million-math-problem-now-mathematicians-are-fighting — **verified, read.**
23. H. N. Kavas. "Mathematicians still checking the Navier-Stokes proof that OpenAI claims to have solved." *Tufts Daily*, 24 Sep 2026. https://www.tuftsdaily.com/article/2026/09/mathematicians-still-checking-the-navier-stokes-proof-that-openai-claims-to-have-solved — **verified, read.** (Note: it mislabels Alpöge as at Harvard.)
24. C. Franzen. "OpenAI solves longstanding math problem with 10,000-agent swarm — but can't rule out benefitting from a researcher's private Codex data." VentureBeat, 8 Sep 2026. https://venturebeat.com/technology/openai-solves-longstanding-math-problem-with-10-000-agent-swarm-but-cant-rule-out-benefitting-from-a-researchers-private-codex-data — **verified, read.**
25. DeepLearning.AI, *The Batch.* "OpenAI Agents Solved A Version of the Navier-Stokes Fluid Equations Problem," 18 Sep 2026. https://www.deeplearning.ai/the-batch/inside-the-dispute-over-a-landmark-agent-driven-mathematical-proof — **verified, read.**
26. R. Brandom. "OpenAI fought dirty on career-making math problem, says NYU mathematician." TechCrunch, 8 Sep 2026. https://techcrunch.com/2026/09/08/openai-fought-dirty-on-career-making-math-problem-says-nyu-mathematician/ — **verified, read.**
27. J. Kahn. "OpenAI says it cracked Navier-Stokes…" *Fortune*, 8 Sep 2026. https://fortune.com/2026/09/08/openai-says-it-cracked-navier-stokes-math-grand-challenge-buckmaster-accusation-cheating-intimidation-tao-lament/ — **verified, read.**
28. A. M. Stan. "The mathematicians published machine-checkable proofs. OpenAI announced its result on a call with reporters." TNW. https://thenextweb.com/news/openai-navier-stokes-claim-verification-credit — **verified, read.**
29. A. M. Constantin. "OpenAI's Bubeck denies trying to cut Anthropic mathematician from credit." TNW, 10 Sep 2026. https://thenextweb.com/news/bubeck-navier-stokes-account-apology-altman — **verified, read.**
30. A. Khollam. "10,000 OpenAI agents crack Navier-Stokes mystery in 88 hours." *Interesting Engineering*, 8 Sep 2026. https://interestingengineering.com/ai-robotics/openai-navier-stokes-mystery-solved — **verified, read.**
31. "OpenAI Says Internal AI System Resolved the Navier–Stokes Problem." Unite.AI, 9 Sep 2026. https://www.unite.ai/openai-says-internal-ai-system-resolved-the-navier-stokes-problem/ — **verified, read** (secondary; the only source for the mid-run model update besides ctco.blog).
32. Wikipedia. "Navier–Stokes priority controversy" (rev. 4 Nov 2026). https://en.wikipedia.org/wiki/Navier%E2%80%93Stokes_priority_controversy — **verified, read.**
33. Wikipedia. "Navier–Stokes existence and smoothness." https://en.wikipedia.org/wiki/Navier%E2%80%93Stokes_existence_and_smoothness — **verified, read.**
34. D. Patel, N. Brown. "Noam Brown – Agent swarms, alignment, & recursive self-improvement." Dwarkesh Podcast, 17 Sep 2026. https://dwarkesh.com/p/noam-brown — **verified, transcript read.**
35. J. Bradshaw. "Swarm Organization as the Exponent on Test-Time Compute." LessWrong, 17 Sep 2026. https://www.lesswrong.com/posts/EnpJ29asosMKcFGL8/swarm-organization-as-the-exponent-on-test-time-compute — **verified, read.**
36. G. Morrison. "Measuring the Swarm Economy." *Palladium*, 20 Oct 2026. https://www.palladiummag.com/2026/10/20/measuring-the-swarm-economy — **verified, read.**
37. T. Ord. "Swarm Scaling." 21 Sep 2026. https://www.tobyord.com/writing/swarm-scaling — **verified by the verifier (page fetched).** λ≈0.57 on SEC-Bench Pro (0.48–0.68 across benchmarks), estimated from GPT-5.6 launch charts. A blog essay, not peer-reviewed.
38. A. Bastounis, F. Circelli, A. C. Hansen. "Navier-Stokes lost in translation: Why Lean verification of AI autoformalisation does not guarantee correct natural language proofs." arXiv:2610.08144 (2026). — **verified (arXiv API), PDF downloaded, read §§1–3.**
39. P. Constantin, M. Ignatova, V. Vicol. "Regularity of asymptotically axisymmetric solutions to the 3D Navier-Stokes equations with analytic forcing." arXiv:2609.20803 (2026). — **verified, PDF downloaded.**
40. J. Petrillo, J. Glimm. "The Positive Defect Problem: Target and Admissibility Criteria for a Programmatic Search for Unforced Navier-Stokes Blowup." arXiv:2609.23868 (2026). — **verified, PDF downloaded.**
41. A. Gamburd. "The Siren Call of Silicon Leviathan: Reflections on blowup and Aufklärungsdämmerung." arXiv:2609.28591 (2026). — **verified, PDF downloaded.**
42. L. Alpöge, T. Buckmaster, M. P. Coiculescu. "Extending the Córdoba-Martínez-Zoroa IPM Blow-Up to Uniformly Space-Time Smooth Forcing." arXiv:2609.16470 (2026). — **verified, PDF downloaded, LLM-use section read.**
43. D. Córdoba, L. Martínez-Zoroa. "Blow-up for the incompressible 3D-Euler equations with uniform $C^{1,1/2-\epsilon}\cap L^2$ force." arXiv:2309.08495 (2023). — **verified, PDF downloaded.**
44. D. Córdoba, L. Martínez-Zoroa. "Finite time singularities of smooth solutions for the 2D incompressible porous media (IPM) equation with a smooth source." arXiv:2410.22920 (2024). — **verified, PDF downloaded.**
45. D. Córdoba, L. Martínez-Zoroa, F. Zheng. "Finite time blow-up for the hypodissipative Navier Stokes equations with a force in $L^1_tC^{1,\epsilon}_x\cap L^\infty_tL^2_x$." arXiv:2407.06776 (2024); ARMA 250 (2026) 38, doi:10.1007/s00205-026-02198-0 (per OpenAI's reference list). — **verified (arXiv API), PDF downloaded.**
46. S. Cao, Z. Chi, P. Nie. "Density of Forces Producing Navier–Stokes Blowup." arXiv:2609.10262 (2026), with Lean project. — **verified, PDF downloaded.**
47. V. Ilin. "Lean Pool: An AI-Maintained Archive of Formalized Mathematics." arXiv:2609.25199 (2026). — **verified, PDF downloaded.**
48. R. Duraiswami. "Self-similar swirl between contracting porous walls…" arXiv:2609.17642 (2026). — **verified (arXiv API); not downloaded.**
49. A. Avila, M. Bhargava, … T. Tao, … E. Zelmanov (25 signatories). "A Severe Misalignment of AI in Mathematics." Open letter, Zenodo, 11 Sep 2026. doi:10.5281/zenodo.22737750 — **verified (DataCite metadata: 25 creators, issued 11 Sep 2026); text not read.** The signatories appear to be Fields Medalists; Yu Deng's status was not checked.
50. NYU Courant news. "Tristan Buckmaster Constructs Finite-Time Blowup for 3D…", 14 Sep 2026. https://cims.nyu.edu/dynamic/news/1528/ — **verified, read.**
51. T. Buckmaster et al. `tristanbuckmaster/fluid_lean` (Lean for Euler/Boussinesq/IPM blowup). https://github.com/tristanbuckmaster/fluid_lean — **verified (GitHub API).**
52. Harvard CMSA. "Special Lecture: New Math + AI Developments in Fluid Mechanics" (J. Gómez-Serrano, Brown), 11 Sep 2026. https://www.math.harvard.edu/event/cmsa-special-lecture-new-math-ai-developments-in-fluid-mechanics/ — **verified (CMSA and Harvard Math listings via search; the page returns 403 to curl); a recording is listed in the CMSA video archive; not viewed.**
53. OpenAI. "Advisory Group on Mathematics and Artificial Intelligence," 21 Sep 2026 (independent group hosted at IAS). https://openai.com/index/advisory-group-on-mathematics-and-ai/ — **verified (search listing; TechCrunch 21 Sep; SciAm 6 Oct); openai.com 403, not read.**
54. OpenAI. "GPT-5.6: Frontier intelligence that scales with your ambition" (ultra mode). https://openai.com/index/gpt-5-6/ — **verified to exist (search; Axios reports the broad release in early July 2026); 403, not read.** The 4-agent default and the 1/4/16-agent charts are confirmed by Brown in ref. 34 and by Ord in ref. 37.
55. M. Deutscher. "Anthropic uses Claude to formalize proof of Fermat's Last Theorem." SiliconANGLE, 4 Sep 2026. https://siliconangle.com/2026/09/04/anthropic-uses-claude-to-formalize-proof-of-fermats-last-theorem/ — **verified (search listing); figures are secondary and unaudited.**
56. D. Castelvecchi. "Who gets credit in the AI era? OpenAI maths bombshell sparks debate." *Nature* (news), 17 Sep 2026. https://www.nature.com/articles/d41586-026-02910-w — **verified (page metadata: title, author, date); paywalled, not read.**
57. Madison Mills. "OpenAI's historic math solution overshadowed by credit controversy." *Axios*, 8 Sep 2026. https://www.axios.com/2026/09/08/openai-math-solution-navier-stokes-credit — **partly verified (TNW credits Madison Mills/Axios with the reporting); 403, so the title is not independently confirmed; not read.**
58. *New York Times*, 8–10 Sep 2026 coverage (cited by Wikipedia). — **[UNVERIFIED]** (no specific article identified or accessed).
59. F. Santibañez-Leal. "An independent audit of the September 2026 fluid blowup claims, and a trade-off between force regularity and dissipation." Zenodo preprint, 17 Sep 2026. doi:10.5281/zenodo.22820521 — **verified (Zenodo API metadata and abstract); added by the verifier.** Reports an independent rebuild and empty-environment kernel replay of `openai/NavierStokesAndEuler` with an axiom audit.
60. A. M. Constantin. "OpenAI says its AI model has disproved the Exponential Time Hypothesis." TNW, 26 Oct 2026. https://thenextweb.com/news/openai-exponential-time-hypothesis-false-kakeya-yang-mills — **verified (fetched; added by the verifier).** Source for the 4D YM/QCD existence claim and for the Gross–Douglas–Jaffe–Klebanov–Nekrasov group.
61. OpenAI. "Building scientific understanding with academic communities," 26 Oct 2026. https://openai.com/index/building-scientific-understanding-with-academic-communities/ — **existence inferred from aiweekly's source list only; [UNVERIFIED], not read (openai.com 403).** First-party source for the YM claim.

---

## Verification log

**Adversarial verification pass, 2026-11-05.** Every reference and the most load-bearing claims were rechecked against live sources. Edits were made in place above; this section records what was checked and what changed.

### A. Reference existence and metadata (61 entries after additions)

- **arXiv (11), via the export.arxiv.org API.** All match title and authors: 2610.08144, 2609.20803 (v2), 2609.23868, 2609.28591 (v3), 2609.16470, 2309.08495, 2410.22920 (v3), 2407.06776 (v2), 2609.10262 (v4), 2609.25199, 2609.17642. No ID errors.
- **Downloaded PDFs.** The first-page text of each workstream PDF in `library/pdfs/` matches its ID: 2610.08144, 2609.20803, 2609.23868, 2609.28591, 2609.16470, 2309.08495, 2410.22920, 2407.06776, 2609.10262, 2609.25199. Nothing was deleted. 2609.17642 is not downloaded, as the note says.
- **DOIs.**
  - 10.1007/s00205-026-02198-0 (Crossref): CMZ–Zheng, ARMA 250, article 38, issued 11 May 2026. Matches.
  - 10.5281/zenodo.22737750 (DataCite; Crossref returns 404, as expected for Zenodo): "A Severe Misalignment of AI in Mathematics", 25 creators, issued 11 Sep 2026. Matches.
- **GitHub (GitHub API).** All six repos exist:
  - `openai/NavierStokesAndEuler`: created 8 Sep; exactly two commits, `8937a8f` (8 Sep) and `f9e8bc5` (10 Sep); 228 forks.
  - `openai/math`: created 6 Oct.
  - `openai/ten-proofs`: created 5 Aug.
  - `google-deepmind/formal-conjectures`.
  - `leanprover/comparator`.
  - `tristanbuckmaster/fluid_lean`: created 8 Sep.
- **Repo facts checked directly.**
  - `formalization.yaml`: GPT-6 Astra / Codex / agent; `review.status: self-assessed`; Corollary 10.6 alignment.
  - Toolchain: `lean-toolchain` is `v4.34.0-rc2`.
  - `ComparatorChallenges/NavierStokes.json`: nanoda enabled; permitted axioms propext, Quot.sound, Classical.choice.
  - The challenge header cites formal-conjectures commit `8bf45ed`, path `Millenium/` (sic, correct for that commit).
  - `ten-proofs` is "agent-reviewed"; `openai/math` is "unchecked".
  - The Euler library sets `autoImplicit=false` and `warningAsError=true`.
- **Comparator README.** Confirms the guarantees, `landrun`, `lean4export`, optional nanoda, and the deprecation in favour of `lake comparator` / `lake check` in Lean v4.35.0. "Assumption 2" is as described.
- **Web URLs.**
  - All press, blog, Wikipedia, Clay, NYU and Tao URLs return 200, or were confirmed via WebFetch or search.
  - openai.com (3 URLs), math.harvard.edu and axios.com return 403 to automated fetch; CoinDesk and VentureBeat returned 429 to curl but were then fetched.
  - These were confirmed by search listings, by other outlets citing them, or by WebFetch.
- **Metadata fixes.**
  - Authors added: Palladium (G. Morrison), Nature (D. Castelvecchi, 17 Sep), SiliconANGLE (M. Deutscher), Interesting Engineering (A. Khollam), Axios (Madison Mills).
  - Ref 20: alternate displayed headline added.
  - Ref 35: title case fixed.
  - Ref 37: upgraded from NOT verified to verified (Ord, "Swarm Scaling", 21 Sep 2026).
  - Ref 54: release date (early July 2026) added.
- **Added references.**
  - 59: Santibañez-Leal, Zenodo audit (verified).
  - 60: TNW 26 Oct, the YM/ETH announcement (verified).
  - 61: OpenAI's 26 Oct first-party post (UNVERIFIED; 403).
- **Still unverified.**
  - Ref 58 (NYT, no specific article).
  - Ref 61.
  - The text of ref 1 (OpenAI blog; 403).
  - Ref 57's exact title.
  - The AMS statement's content.
  - Sources cited inline but not in the reference list: lilting.ch (same-day CMZ citation revision), ctco.blog (mid-run checkpoint reconstruction), the AccuKnox blog (20% classifier overhead), the Import AI summary, and the Wikipedia Wayback snapshot. None of these was checked; treat the claims resting only on them as [S, unverified].
- **Listed but unused.** Refs 46 (Cao–Chi–Nie) and 48 (Duraiswami) exist but are not discussed in the body.

### B. Key claims checked against sources

| # | Claim in the note | Source checked | Outcome |
|---|---|---|---|
| 1 | NS Theorem 1.1: $f\in C_c^\infty$, $u(\cdot,0)=0$, compact support, bounded $L^2$, $\limsup\|u\|_{L^\infty}=\infty$; (D) via Cor. 10.6; 166 pp.; $0<h<1/100$ | NS PDF (166 pp.) | **Confirmed** |
| 2 | Euler Theorem 1.1, unforced; 57 pp.; only *cites* rigorous-numerics work (Chen–Hou) | Euler PDF | **Confirmed** |
| 3 | Buckmaster–Alpöge not cited in the NS paper | NS reference list | **Confirmed** (CMZ [6–8] cited; Buckmaster only via Buckmaster–Vicol) |
| 4 | ~100 agents / ~50 h Euler; ~10k concurrent / 88 h NS; 2.7M msgs and 130B tokens (NS); 4.9M and 300B (all); 17 h Lean with GPT-6 Astra; Codex consolidation; cached internet; within-group messaging; A/B vs C/D groups | Quanta, CNBC, VentureBeat, The Batch, Unite.AI, CoinDesk, Petrillo–Glimm | **Confirmed as OpenAI-reported [O]**; unaudited |
| 5 | Brown gives multi-agent less than 10% of the credit; 64/128/256 recommendation; message-insertion primitive; no coordinator; independent-solving local minimum; forking; 4-agent default, ~2× speed | Dwarkesh transcript (fetched, grepped) | **Confirmed.** "Any agent to any other at any time" softened to Brown's wording |
| 6 | "Brown said OpenAI had previously tried Millennium problems without success" | Transcript; wire reports | **Not found; marked [UNVERIFIED]** |
| 7 | CIV: analytic-forcing obstruction "so cannot reach (A)/(B)" / "method does not extend to (A)/(B)" | 2609.20803 abstract | **Overstated wording, corrected.** It is a conditional obstruction (features (i),(ii); force bounded in $C^2$) ruling out unforced blowup by this route, not a statement about (A)/(B) |
| 8 | Bastounis–Circelli–Hansen: Lemma 8.6 / (8.19) costs $m+4$ vs $m+5$; (10.19) via Sobolev + $L^2$ Riesz rather than $L^{3/2}$; different Hölder exponents; continuity in time; SCI $=\infty$; they do not claim the NL proof or the headline Lean theorem is wrong | 2610.08144 text | **Confirmed.** They also predict a "very high" likelihood of mistranslations in the Euler development (not yet examined) |
| 9 | "No outside party had announced a clean-environment build / axiom audit" (Gamburd, 20 Sep) | 2609.28591 footnote; Zenodo API | **Incorrect, corrected.** Gamburd himself notes Santibañez-Leal's 17 Sep rebuild + kernel replay + axiom audit. Only the statement-faithfulness check was outstanding. "No human had read all 166 pages" softened to "so far as anyone had said publicly" |
| 10 | Commit `f9e8bc5` "adds about 25k lines of paper-alignment Lean" | Fresh clone, `git diff --numstat` | **Overstated, corrected.** 25,143 lines / 188 files; only ~1.5k lines in `*Paper*`/`Appendix*` modules |
| 11 | Lean ≈641k lines, ≈616k at 8 Sep, zero `sorry`, no `axiom` | Fresh clone | **Confirmed** (641,332; 616,276; 2,659 files). The theorem/lemma count is ~37–38.5k depending on the regex |
| 12 | Buckmaster statement: 15 Aug results; Lean 22 Aug; "entire team"; unforced tried first; easier problems incl. Euler; prompt written by prompting Codex; first prompt "past few days"; "Why would you ruin your career?" | Statement PDF (read in scratchpad) | **Confirmed** (as Buckmaster's account [P][D]) |
| 13 | Clay: "apparently settled", "deliberately unhurried", status "active" | Clay announcement page + problem page | **Confirmed.** "Active" is on the problem page, not the announcement; attribution fixed |
| 14 | OpenAI YM *existence* claim; model result 9 Sep; Lean "well more than a month"; shepherding group; Lean done 16 Oct | SciAm 27 Oct; TNW 26 Oct; aiweekly; search | **Partly corrected.** SciAm confirms existence-only, 9 Sep, "well more than a month", shepherding, but names no group members and gives no 16 Oct date. TNW confirms the Gross-led group and the 4D YM/QCD scope. The 16 Oct date rests on secondary outlets only |
| 15 | Novelty: Cao-Labora et al. "concluded … oscillatory pulses … versus … vortex layers" | SciAm 13 and 22 Oct; NS paper §1.1 | **Misattributed, corrected.** Cao-Labora says "a different approach"; the mechanism contrast is from OpenAI's own introduction. Fan Zheng's "follows the framework" quote concerns the *Euler* proof (SciAm 22 Oct) |
| 16 | "No one fully understood" (late Oct, SciAm 22 Oct) | SciAm 13 and 22 Oct | **Attribution split.** "Broad strokes" is 22 Oct; "more than a month later, no one fully does" is 13 Oct |
| 17 | `openai/math`: 721 manuscripts / 373 families; ~4,000 problems; ~3 h per result; ~42% formalized; 7 Oct withdrawal of 3 manuscripts and repair of 14; family 215 O(3) continuum limit with mass gap | README, history.md, CONTENTS.md | **Confirmed.** "Mostly single prompt / single agent" is **not** in the README and is now marked [I]. SciAm counted 372 results at the 6 Oct release |
| 18 | Ord β≈0.57 | Ord essay; Palladium | **Corrected symbol:** Ord's exponent is λ (0.57 on one benchmark; 0.48–0.68 range), estimated from GPT-5.6 charts at N≤16 |
| 19 | Costs: "outside estimates $2M–$40M"; Chen "millions" | VentureBeat, Fortune, TechCrunch, wire reports | **Refined.** Fortune: ~$2M or $22.5M; VentureBeat: $10–40M speculative; Chen: "emphatically in the millions" |
| 20 | Anthropic FLT: "Expert reviewer (Buzzard)" | SiliconANGLE | **Corrected.** Buzzard is quoted and his work used, not described as reviewer |
| 21 | Rumour trigger: "a Millennium problem" | VentureBeat (Bubeck on X); Gamburd | **Corrected to "two"** |
| 22 | Bubeck "apologised … and disputes the rest" | TNW 10 Sep | **Narrowed.** He apologised for poor wording and denies seeking Alpöge's removal |
| 23 | Formal-conjectures has no YM statement | Full git tree (2,291 entries) | **Confirmed** |
| 24 | Advisory group 21 Sep, hosted at IAS; it recommended releasing model, exact prompt and compute per result; OpenAI "not bound" | Search; SciAm 6 Oct | **Confirmed** |
| 25 | Lean Pool 211 projects / 3.2M lines; ABC §1 LLM-use description (Claude reproduces CMZ; Claude+Codex write; bookkeeping delegated; convex-integration simplification; Lean via `fluid_lean`) | 2609.25199; 2609.16470 text | **Confirmed** (3,228,485 lines) |

### C. Residual concerns

1. **The OpenAI blog was never read first-hand** (403). All [O] claims rest on consistent press paraphrase. That includes the A/B vs C/D groups, Codex consolidation, the mid-run checkpoint update, the 3 July cutoff, the "Concurrent work" section, and OpenAI ceding forced-Euler priority. A human should archive the page.
2. **The YM claim (the most relevant item for this project)** rests entirely on secondary reporting. The material is unreleased, and the 16 Oct Lean date and the 18 Sep QCD date are secondary only. Treat it as a claim, not evidence.
3. **Statement faithfulness.** No independent review was found of whether the formal-conjectures (C)/(D) statements match Fefferman's text. This is the most important open verification gap for the NS result and the precedent our YM statement must avoid.
4. **Unlisted inline sources** (lilting.ch, ctco.blog, AccuKnox, Import AI) were not checked, and the claims resting only on them remain [S, unverified].
5. **Heuristic design ratios** in P3/P7/P11 (1% warm-up budget, ~2.9k Lean lines per page, token budgets) are the author's extrapolations from single data points. They are not empirical laws.
