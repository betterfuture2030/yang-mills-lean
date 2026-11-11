# 99 — Completeness critique of the Yang–Mills library

*Compiled 2026-11-05 by a completeness critic. I read `INDEX.md` and skimmed all eleven notes: summaries, key sections, open questions and residual concerns. I checked candidate omissions against `references.bib` and the notes by grep.*

**Verification method.** The shared web-search budget for this run was already used up when this pass began, so I ran **no open-ended searches**. Instead I fetched canonical pages directly: arXiv abstract pages and Crossref DOI records, plus three news sources (KITP, Woit, QRC). Every work below carries one of two tags:

- **[V]**: confirmed today by direct fetch of its arXiv or Crossref record.
- **[M]**: cited from memory. Its metadata must be checked before it enters the bibliography.

**Status check (2026-11-05).**
- No new committee statement has appeared. The KITP page's latest item is still the 3 Nov update.
- Woit's newest post (4 Nov) does not concern the YM claim.
- The OpenAI blog post still returns HTTP 403.

---

## Top 15 actions, in priority order

1. **(d) Find out whether OpenAI's Lean proof re-proves Bałaban or assumes him.** It might encode Bałaban's CMP theorems, or the unpublished SU(2) coupling-flow "Theorem 2", as hypotheses. OpenAI has precedent for both patterns:
   - `openai/math` uses `Published…` hypothesis structures;
   - `PrimeGaps186` declares project axioms.

   If the proof is conditional, our B0–B9 work packages are still on the critical path. If it is unconditional, the plan should switch to consuming OpenAI's construction for the gap. Make this the first item on the audit checklist for release day: run `#print axioms` and inspect every hypothesis structure. No note asks this question directly.
2. **(c) Fix the primary-source gap on Bałaban.** No one has read any Bałaban CMP paper. B2, the project's flagship early deliverable, rests on an unvetted secondhand transcription (Boston2026 / [68] in note 05). A human should download the following from Project Euclid (open access) and add them to `pdfs/`:
   - the 12 YM papers and their precursors;
   - MRS 1993;
   - OS I and OS II;
   - Osterwalder–Seiler 1978.

   Then check CMP 109 pp. 251, 259–260 and 267, and CMP 122 p. 355.
3. **(c) Add a workstream on the infrared step without a gap.** The step $T^4\to\mathbb R^4$ without a gap is the central unknown in OpenAI's claim and in any existence proof. No note is devoted to it; it appears only as lists of possibilities in note 02 §2.3 and note 11 §4. It should cover:
   - chessboard and RP bounds that are uniform in the volume (FILS 1978 is in the bibliography but barely used);
   - DLR/Gibbs compactness;
   - cluster expansions for gauge-invariant observables at a fixed physical scale;
   - OS4 and vacuum uniqueness without a gap;
   - O(4) restoration through reflection positivity. Alpöge's "RP trick" and the module "C/K" structure of Sussman–Alpöge YM₄ are the leads.
4. **(c) Replay the Lean artefacts locally.** No note has built anything: every sorry count, axiom count and Comparator claim is self-reported. Run a Linux `bwrap` sandbox and `lake comparator --paranoid` on:
   - OSforGFF;
   - OSreconstruction;
   - `lgt`;
   - `openai/math` family 215 `ClassicalON`.

   This is cheap. It validates the base layer the plan depends on, and it rehearses the release-day audit.
5. **(c) Do a deep-dive on family 215, the 2D O(3)/O(n) results.** It is the only public AI-generated, asymptotically free continuum limit with a gap: the "warm-up" for YM. Note 09 calls it "the key new item", but nobody has read the manuscripts' argument or built the Lean proof. Reconstruct the mechanism that is claimed to give decay at all β. Then decide whether it lifts to principal chiral and slab models, which is the Durhuus–Fröhlich environment.
6. **(c) Structurally read the public AI–Bałaban manuscripts.** The Sussman–Alpöge QED₃/YM₃ manuscripts (242, 857 and 1,201 pp.), the YM₄ module map, and Aronow–Lopatto's 1,479 pp. are available **now**; OpenAI's are not. For each, produce:
   - a theorem-dependency map against B0–B9: which Bałaban modules are re-proved, and which are cited;
   - a spot-check of one closed lemma;
   - a list of the definitions lost in condensation.
7. **(a/c) Add a perturbative-YM workstream.** Note 01's open question 5 proposes one and it was never run. The project's `ShortDistanceAF` clause (the $|x|^{-8}\log^{-2}$ fingerprint) and `AsymptoticScaling` constants ($b_0$, $b_1$) currently rest on a heuristic derivation in note 01 (residual concern 7). The missing references are listed in (a)-1 below.
8. **(b) Reconcile contradictions between notes.** See items (b)-1 to (b)-4: the prize statement, Woit's SU(5) guess, the OpenAI dates' sourcing, and whether subsequential limits count as "weak existence".
9. **(b) Relabel the draft Lean statement as "candidate, unaudited".** "Compiles" is not the same as "faithful", and the draft departs from Clay in **both** directions. See (b)-5.
10. **(a) Add a crossover (L2) literature.** Note 09 calls the crossover the "missing mathematics". Notes 08 and 09 propose computer-assisted certificates, but the bibliography has **zero** entries on rigorous complete RG trajectories or on computer-assisted proofs in RG and statistical mechanics. See (a)-3.
11. **(a) Cover the tensor-RG route.** Committee member Douglas's own review reportedly favours tensor-RG methods (Meurice seminar abstract, notes 01, 02 and 11), but the bibliography has **no** tensor-RG entries. See (a)-4.
12. **(a) Broaden the AI-methodology sources beyond OpenAI and Anthropic.** Note 03 §7 lacks the public DeepMind, Harmonic and human-crowd precedents. It also lacks the Liquid Tensor Experiment, the closest precedent for "a proof nobody can check, settled by formalization", which is Bauerschmidt's description of Bałaban. See (a)-5.
13. **(d) Prepare for release.** Pre-register our questions and run a timed checklist against the expected release (week of 9 Nov, "hopefully"). See (d).
14. **(c) Calibrate our own capacity.** The library has no estimate of what a Claude-based pipeline can sustain. The data points are OpenAI's about 10⁴ agents × 88 h and 130B tokens for NS, and Sussman–Alpöge's 61k raw pages for YM₄. The plan needs a budgeted architecture, not a copy of OpenAI's scale.
15. **(c, low) Audit the fermion, QCD and GUT parts.** This workstream is thin. It matters only if we audit OpenAI's full claim, not for pure YM. See (a)-7.

---

## (a) Important published works missing from the bibliography

These are ordered by relevance to the plan. "Absent" means grep found nothing in `references.bib`. "Mentioned" means the name appears in a note but has no bibliography entry.

### (a)-1 Perturbative YM theory: the AF/OPE clause of Jaffe–Witten and the `ShortDistanceAF` fingerprint
- **C. Becchi, A. Rouet, R. Stora, "Renormalization of gauge theories", Ann. Phys. 98 (1976) 287–321 [V].**
  - Status: absent; BRS(T) appears nowhere.
  - Why it matters: it is the standard foundation of "perturbative renormalization theory as described in textbooks", which Jaffe–Witten require agreement with. Slavnov–Taylor identities appear in note 08 only through Efremov–Guida–Kopper.
- **W. E. Caswell, "Asymptotic behavior of non-Abelian gauge theories to two-loop order", PRL 33 (1974) 244–246 [V],** with D. R. T. Jones, Nucl. Phys. B75 (1974) 531 [M].
  - Status: absent.
  - Why it matters: it is the source of $b_1=34N^2/(3(4\pi)^4)$, which is hard-coded in `Statement.lean` (`b1`, `AsymptoticScaling`).
- **J. C. Collins, A. Duncan, S. D. Joglekar, "Trace and dilatation anomalies in gauge theories", PRD 16 (1977) 438–449 [V].**
  - Status: absent.
  - Why it matters: the draft's AF fingerprint is built on the RG-invariant trace-anomaly operator $\Theta=(\beta(g)/2g)F^2$. Its normalization and RG invariance must be sourced, not derived in-note.
- **S. Hollands, C. Kopper, "The operator product expansion converges in perturbative field theory", arXiv:1105.3375, CMP 313 (2012) [V].**
  - Status: absent. Hollands appears only with his 2008 curved-space YM paper.
  - Why it matters: Jaffe–Witten explicitly ask for an OPE with the predicted singularities. This is the rigorous-perturbative state of the art for OPE convergence, which [CP-7] and any "OPE clause" in the Lean statement need.
- **C. Elliott, B. Williams, P. Yoo, "Asymptotic freedom in the BV formalism", arXiv:1702.05973, J. Geom. Phys. (2017) [V],** and **K. Costello, *Renormalization and Effective Field Theory*, AMS 2011 [M].**
  - Status: both absent.
  - Why they matter: they give a mathematically rigorous definition of the one-loop β-function and a proof of AF for YM in perturbation theory. They are the natural citation for formalizing "agreement with AF" as a theorem rather than a numeric fingerprint.

### (a)-2 Gauge-field geometry and finite-volume spectrum
- **K. Uhlenbeck, "Connections with $L^p$ bounds on curvature", CMP 83 (1982) 31–42 [V].**
  - Status: mentioned in notes 06 and 10; absent from the bibliography.
  - Why it matters: Uhlenbeck gauges are the continuum analogue of Bałaban's local gauges (note 06, lead 9). Uhlenbeck compactness is listed as a Lean target in note 10.
- **M. Lüscher, "Volume dependence of the energy spectrum in massive quantum field theories I", CMP 104 (1986) 177–206 [V].**
  - Status: absent. Only Lüscher 1983 (spectrum on a small torus) is present.
  - Why it matters: Jaffe–Witten say a uniform finite-volume gap "may play a fundamental role". Lüscher's finite-volume mass formulas are the standard bridge between torus spectra and infinite-volume masses, which is exactly the L3/IR layer.
- **J. Råde, YM heat flow in 2D/3D, J. reine angew. Math. (1992) [M].**
  - Status: absent.
  - Why it matters: it underlies the gradient-flow state spaces of Cao–Chatterjee and Charalambous–Gross.
- **P. Menotti, A. Pelissetto, "General proof of Osterwalder–Schrader positivity for the Wilson action", CMP 113 (1987) [M].**
  - Status: absent. My guessed DOI was wrong, so metadata is unverified.
  - Why it matters: it extends reflection positivity beyond the Osterwalder–Seiler setting. That is relevant to the regulator-independence/universality item on note 11's checklist.

### (a)-3 The L2 crossover, computer-assisted proof and finite-size criteria
Note 09 §4.2 and note 08 lead 7 propose a finite-β computer-assisted certificate at one scale, then propagation. None of the enabling literature is in the library:

- **A. Abdesselam, "A complete renormalization group trajectory between two fixed points", CMP 276 (2007) 727–772, math-ph/0610018 [V].**
  - Status: absent. Only Abdesselam–Rivasseau 1995 is present.
  - Why it matters: it is the only rigorous, non-hierarchical, *complete* RG trajectory from a UV to an IR fixed point. It is the closest existing template for an L2 crossover theorem.
- **O. E. Lanford III, "A computer-assisted proof of the Feigenbaum conjectures", Bull. AMS 6 (1982) 427–435 [V];** H. Koch, P. Wittwer, hierarchical non-Gaussian fixed point by computer-assisted proof, CMP 106 (1986) [M]; **J. Gómez-Serrano, "Computer-assisted proofs in PDE: a survey", arXiv:1810.00745 [V].**
  - Status: all absent.
  - Why they matter: they are the methodology base for any "certificate" step, and the survey connects to the NS/Euler context.
- Finite-size mixing and log-Sobolev criteria: Stroock–Zegarlinski (CMP 1992) [M; mentioned in a note, absent from the bibliography]; Martinelli–Olivieri (CMP 1994) [M; absent].
  - Status: only Dobrushin–Shlosman 1985 is present.
  - Why they matter: they are the rigorous mechanism that turns a finite-box computation into an infinite-volume gap. That makes them the natural partners of Shen–Zhu–Zhu-type Bakry–Émery arguments.
- T. Bałaban, *A low temperature expansion for classical N-vector models* II and III, CMP 182 (1996) and 196 (1998) [M].
  - Status: only part I is present.
  - Why they matter: this is Bałaban's own RG for an asymptotically free σ-model, the direct human precedent for family 215.
- S. Caracciolo, R. Edwards, A. Pelissetto, A. Sokal, asymptotic scaling in the 2D O(3) model at $\xi\sim10^5$, PRL (1995) [M].
  - Status: absent.
  - Why it matters: it is the numerical side of the Patrascioiu–Seiler dispute, which the library cites on one side only. It is needed to judge family 215's all-β claim.

### (a)-4 Tensor RG (the route a committee member reportedly favours)
- **M. Levin, C. P. Nave, "Tensor renormalization group approach to 2D classical lattice models", PRL 99 (2007) 120601 [V].**
- **T. Kennedy, S. Rychkov, "Tensor RG approach to high-temperature fixed point", J. Stat. Phys. 187 (2022) 33, arXiv:2107.11464 [V].** This is the first *rigorous* tensor-RG analysis.
- **Y. Meurice, R. Sakai, J. Unmuth-Yockey, "Tensor lattice field theory with applications to the renormalization group and quantum computing", Rev. Mod. Phys. 94 (2022) 025005, arXiv:2010.06539 [V].** Meurice is the author of the seminar abstract that is our only window on Douglas's *Nat. Rev. Phys.* view.

Why they matter: the committee's own framing may judge OpenAI's proof against a tensor-RG baseline. Our plan should at least know whether tensor RG gives a rigorous handle on the crossover, where it is a natural candidate.

### (a)-5 AI methodology for parts (b) and (c) of the request (process, not proof content)
- **B. Georgiev, J. Gómez-Serrano, T. Tao, A. Z. Wagner, "Mathematical exploration and discovery at scale", arXiv:2511.02864 [V]** (AlphaEvolve on 67 problems), with Novikov et al., AlphaEvolve, arXiv:2506.13131 [M].
  - Status: absent.
  - Why they matter: this is the most detailed public first-person account of large-scale LLM-guided search, including how evaluators get exploited. That failure mode is the analogue of a "scope loophole".
- **S. Bubeck et al., "Early science acceleration experiments with GPT-5", arXiv:2511.16072 [V].**
  - Status: absent.
  - Why it matters: it is OpenAI's own pre-swarm methodology record, with human-verified mathematical results. It is useful for the provenance and priority failure modes in note 03.
- **Y. Wang, …, T. Buckmaster, J. Gómez-Serrano, C.-Y. Lai, "Discovery of unstable singularities", arXiv:2509.14185 [V]** (DeepMind), and **J. Chen, T. Y. Hou, "Stable nearly self-similar blowup of the 2D Boussinesq and 3D Euler equations with smooth data I", arXiv:2210.07191 [V].**
  - Status: both absent; Chen–Hou is mentioned in notes.
  - Why they matter: they are the competing human and AI-assisted Euler/NS programmes behind note 03's priority discussion. Buckmaster is a co-author of the first.
- **T. Achim et al., "Aristotle: IMO-level automated theorem proving", arXiv:2510.01346 [V].**
  - Status: absent.
  - Why it matters: it is a hybrid informal/Lean prover design, relevant to note 03's P-principles on acceptance gates.
- **P. Scholze, "Liquid Tensor Experiment", Exp. Math. 31 (2022) 349–354 [V].**
  - Status: absent.
  - Why it matters: it is the canonical case of a proof its author could not get checked, settled by human-led formalization with a blueprint. That is exactly the situation of Bałaban's corpus.
- **T. Gowers, M. Nielsen, "Massively collaborative mathematics", Nature 461 (2009) 879–881 [V].**
  - Status: absent.
  - Why it matters: Polymath is the human-swarm precedent for consolidation ledgers and task decomposition.

### (a)-6 Unresolved bibliographic placeholder
- `Adhikarind` ("Adhikari–Suzuki–Zhou–Zhuang", note 07) is still a placeholder. The local PDF `pdfs/2509.04688.pdf` shows that the title "Dynamical approach to area law for lattice Yang–Mills" belongs to **Cao–Nissim–Sheffield**, so the task-text attribution is probably garbled.
- Recommendation: delete the placeholder, or re-search it once search budget is available.

### (a)-7 Fermions, QCD and the GUT (low priority for pure YM; needed to audit OpenAI's full claim)
- Nielsen–Ninomiya (1981) [M]: mentioned only in a blog comment summarized in note 02; absent from the bibliography.
- Weingarten, QCD mass inequalities (PRL 1983) [M]: absent.
- Vafa–Witten, vector-like gauge theories (1984) [M]: absent.
- Kogut–Susskind Hamiltonian lattice gauge theory (1975) [M]: absent.
- Sharatchandra–Thun–Weisz, RP for staggered fermions (1981) [M]: absent.

Bałaban–O'Carroll–Schor (1989, 1991) is present. There is no note on lattice-fermion reflection positivity or on the chiral measure beyond note 11 §2.7.

---

## (b) Claims that are wrong, overstated or inconsistent

1. **"OpenAI will not seek the prize" (YM): notes 01 and 02 contradict each other, and both are partly wrong.**
   - Note 02's verifier says no source attributes the no-prize statement to YM, and that it concerned Navier–Stokes.
   - But Quantum Research Center, fetched today, says of YM: "has said it will not seek the prize".
   - Note 01 keeps the claim, but on QRC alone.
   - Correct status: one secondary source, unconfirmed by any primary, and immaterial because no gap is claimed. Fix both notes.
2. **Sourcing of the OpenAI dates is out of date in note 01.** Note 01 says the 9 Sep, 18 Sep and 16 Oct dates "come from [8] alone". Woit's 26 Oct post, fetched today, gives the same three dates, and note 02 says Woit quotes OpenAI verbatim. Update note 01.
3. **Woit and SU(5): notes 02 and 11 conflict.**
   - Note 11's verifier removed "he guesses SU(5)" and says Woit "explicitly declines to guess".
   - Woit's **2 Nov** post does speculate SU(5) (confirmed today). Note 02 is right.
   - Note 11's statement holds only for the 26 Oct post. Scope it to that date.
4. **Does a subsequential limit count as "weak existence"? The library has no single answer.**
   - Note 05 calls Sussman–Alpöge's subsequential limit "existence in the weak sense".
   - Note 11's checklist makes full-versus-subsequential "the first question".
   - Note 01 reads Jaffe–Witten's footnote 2 as excluding compactness *only when the limit's properties are not proved*.
   - The draft `Statement.lean` explicitly accepts subsequential limits.

   Choose one reading as a recorded choice point, because it decides both whether OpenAI's result counts and what our existence target is.
5. **The draft statement is described as if it were close to faithful; it is a candidate that has not been audited.** The INDEX and note 10 say Mathlib "suffices to state the problem, and the draft compiles". But the draft departs from Clay in **both** directions, per its own README and its definitions:
   - **Weaker.** The gap is proved only on the subspace generated by the 21 $\operatorname{tr}F_{\mu\nu}F_{\kappa\lambda}$ fields. That is the C-even sector, whereas Clay requires $\operatorname{spec}H\cap(0,\Delta)=\emptyset$ on all of $\mathcal H$.
   - **Stronger.** `IsWilsonLimit` requires a Wilson-lattice origin, while Douglas (2004) says the lattice is "not essential".
   - **Not equivalent.** `ShortDistanceAF` is one specific numeric fingerprint, not "agreement with renormalized perturbation theory".

   The library should state the direction of each deviation, and should not imply equivalence to Clay.
6. **The INDEX summary of note 07 overstates.** "Nothing is known at large β for continuous non-abelian groups in d≥3, apart from 3D log-confinement" ignores results the notes themselves list:
   - Bałaban's UV stability, which is weak coupling for SU(N) on a torus;
   - the Chatterjee and Brennecke free-energy asymptotics.

   Note 07's own wording is correct: "no correlation decay, area law or Gibbs uniqueness". Copy it into the INDEX.
7. **The INDEX calls GN₂ "the only constructed asymptotically free renormalizable model".** Note 08 hedges this ("generally cited as") and lists constructed planar wrong-sign φ⁴₄ as an asymptotically free exception. Restore the hedge in the INDEX.
8. **The page-count calibration is circular.**
   - Note 05 estimates a Bałaban-route proof at 1,000–1,500 pages, "matching" OpenAI's 1,147.
   - Note 10's line estimate is "consistent with" the 1,147 pages.

   Both are partly anchored on the number they claim to confirm. The scope of the 1,147 pages is also unknown: it may cover YM, QCD and the GUT together. Do not cite these estimates as independent support for the user's premise of about 1,000 pages.
9. **"The Lean step for constructive QFT is the bottleneck" (note 02 §4(5)(i)) is a weak inference.**
   - It rests on OpenAI's self-reported 37 days from natural-language proof to Lean. That window overlaps the QCD (18 Sep) and ETH work.
   - It conflates OpenAI's claim about *producing* a formalization with Buckmaster's point about *checking* one.

   Mark it as speculative.
10. **"Theorem 2 was never published" is stated more firmly in places than its sourcing allows.** It rests on one unvetted transcription. The B2 framing in the INDEX ("the gap to close") should carry that caveat until action 2 is done.

---

## (c) Thin workstreams

| Workstream | Present coverage | What is missing | Priority |
|---|---|---|---|
| Primary texts (Bałaban, OS I/II, OS78, MRS, Seiler LNP, Glimm–Jaffe) | Bibliographic only; content secondhand | Human download and reading; page-level checks of the key theorems | **High** |
| IR / infinite volume without a gap | Lists of possibilities (02 §2.3, 11 §4 item 5) | A dedicated note on tools, obstacles and testable sub-goals (OS4 without a gap; uniqueness; O(4) restoration) | **High** |
| Local Lean replay | None; everything self-reported (04 D, 10) | Linux Comparator `--paranoid` runs on four repositories; an inventory of axioms and hypothesis structures | **High** |
| Family 215 / 2D O(n) as the gap testbed | Summaries (02, 04, 09, 11) | Reading the argument; Lean build; extension to principal chiral and slab models | **High** |
| Public AI–Bałaban manuscripts | Overview level (05 §3.9) | Module and dependency map against B0–B9; one lemma spot-check; a definitions ledger | **High** |
| Perturbative YM (AF fingerprint, OPE, stress tensor) | Proposed in 01 §6 item 5, never run | Sourced asymptotics and constants for the Lean clauses; see (a)-1 | Med-high |
| L2 crossover and computer-assisted methods | Architecture only (09 §4.2) | Literature; quantitative windows; a feasibility study for a certificate | Med-high |
| Tensor-RG route | Secondhand remark only | Literature, plus an assessment of whether rigorous tensor RG can reach a 4D gauge theory | Medium |
| Our own pipeline capacity and budget | P1–P13 principles (03) | A throughput and cost model for a Claude-based swarm; the Sussman–Alpöge data point analysed | Medium |
| AI methodology beyond OpenAI | 03 §7 table | See (a)-5 | Medium |
| Douglas, *Nat. Rev. Phys.* 8 (2026) 86–97 | Unread (paywall) | Obtain it through a library; it is the committee's own framing of "standard definitions" | Med-high |
| Fermions, QCD and GUT audit | 02 §2.3, 11 §2.7 | Lattice-fermion RP; chiral measure status; see (a)-7 | Low (for pure YM) |

---

## (d) Open factual questions about OpenAI's YM claim that matter for planning

1. **Is the proof conditional?** Are Bałaban's theorems, or anything else, entered as `axiom`s or as `Published…`-style hypotheses? This decides whether existence is actually done, which in turn decides our critical path. See action 1.
2. **What is the exact statement?**
   - gauge groups: all compact simple $G$, $SU(N)$, or $SU(2)$/$SU(3)$ only (Bałaban's Theorem 2 was SU(2));
   - $T^4$ or $\mathbb R^4$, and what "infinite distances" means;
   - full or subsequential limit, and is it unique;
   - is OS4 (clustering, unique vacuum) proved without a gap;
   - is the OS II linear-growth condition E0′ proved.
3. **Which observables, and is "Yang–Mills" pinned down?**
   - smeared $\operatorname{tr}F^2$ alone, all 21 components, or Wilson loops;
   - is short-distance AF agreement proved;
   - is non-triviality proved;
   - are the OPE and the stress tensor claimed.
4. **How large and how reusable is the trusted base?**
   - Is the challenge file Mathlib-only, or a bespoke definitional tree? OpenAI's CM Hodge challenge had 262 definition files.
   - Which Lean and Mathlib versions? Our pin is v4.36.0-rc2.
   - What is the licence?
   - Is the solution a monolithic certificate, like ten-proofs (about 548k lines, no comments)? If so, reusing it for gap work may be impractical, and we should plan to re-derive it.
5. **What do the 1,147 pages cover?** YM only, or YM + QCD + GUT? When will they be released (no date given)? Will the committee release its own assessment first?
6. **Does the committee have its own reference statement?**
   - Is `math-commons/yang-mills` (private; rev `03bb758`; cited by Douglas's `os-reconstruction` README) the committee's benchmark statement?
   - Will it be published, so that our option-1 statement can be compared with it directly?
7. **Do the conflict-of-interest rules affect our dependencies?** The Rules bar members from outside research on YM/QCD existence. Douglas maintains `OSforGFF`, `lgt` and `os-reconstruction`; the last was created 3 Nov, the same day as the Rules. Will these public libraries stay maintained? Pin them by commit now.
8. **What was the process?** Was a swarm used for YM? What model, agent count, compute and attempts, and was there internal Lean use during the search? This would calibrate our budget (AGMAI pathway 2B asks for exactly this).
9. **Is OpenAI attempting the gap now?** Family 215's O(n) and O(4) gap claims suggest capability interest. The answer decides whether our gap work is a race, a complement, or downstream consumption.
10. **When is the release, and in what form?** The committee "hopes" for the week of 9 Nov, with one day's notice. Is it statement first, or statement and proof together? Is it Comparator-replayable?
11. **Which sources did the model see?** Did it see unpublished or semi-public Bałaban-programme material? The Sussman–Alpöge repository became public on 6 Oct, after the 9 Sep proof. Attribution affects which components we can treat as established prior art.
12. **Primary-source confirmation.** The OpenAI blog post still returns HTTP 403, so all wording attributed to OpenAI, including "subproblem", "unified completion" and "will not seek the prize", remains secondhand. A human should archive the page.

---

## Sources fetched for this critique (2026-11-05)

**News pages:**
- KITP Yang–Mills working-group page: latest item still the 3 Nov update; frames the result as QCD existence, with YM existence as a "subproblem".
- Woit, *Not Even Wrong* front page: posts of 26 Oct and 2 Nov; the 4 Nov post contains no YM news.
- Quantum Research Center, 28 Oct article: the prize statement for YM; the three dates; no scope document for YM.
- OpenAI blog post: HTTP 403.

**Verified records:**
- arXiv abstract pages: 2107.11464, 1105.3375, 1702.05973, 2511.02864, 2509.14185, 2511.16072, 2510.01346, math-ph/0610018, 2010.06539, cond-mat/0611687, 1810.00745, 2210.07191.
- Crossref DOI records: 10.1007/BF01947069 (Uhlenbeck), 10.1007/BF01211589 (Lüscher 1986), 10.1016/0003-4916(76)90156-1 (BRS), 10.1103/PhysRevLett.33.244 (Caswell), 10.1103/PhysRevD.16.438 (Collins–Duncan–Joglekar), 10.1090/S0273-0979-1982-15008-X (Lanford), 10.1080/10586458.2021.1926016 (Scholze), 10.1038/461879a (Gowers–Nielsen).

**Local files:**
- `pdfs/2509.04688.pdf` and `pdfs/2505.16585.pdf`, title pages (Cao–Nissim–Sheffield).
- `lean/YangMills/YangMills/Statement.lean` and `README.md`, for item (b)-5.

**[M] items still to verify:** Jones 1974; Costello 2011; Råde 1992; Menotti–Pelissetto 1987; Koch–Wittwer 1986; Stroock–Zegarlinski 1992; Martinelli–Olivieri 1994; Bałaban N-vector II and III; Caracciolo et al. 1995; Novikov et al. (AlphaEvolve); Nielsen–Ninomiya; Weingarten; Vafa–Witten; Kogut–Susskind; Sharatchandra–Thun–Weisz.
