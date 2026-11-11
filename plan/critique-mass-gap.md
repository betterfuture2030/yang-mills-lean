# Critique of PLAN.md v0.1: Track E (the mass gap)

*Reviewer lens: the mass gap only (Track E, rungs M8/M9, and the parts of §0, §3 and §4 that govern them). Written 2026-11-05.*

*Read in full: `plan/PLAN.md`, `PROBLEM.md`, `README.md`, notes 09 and 07, and note 99 (completeness critique). Read the relevant sections of notes 02, 03, 04, 05, 08, 10 and 11. Fetched externally: Tanizaki–Ünsal (arXiv:2201.06166, from the library PDF), Ebel–Kennedy–Rychkov (arXiv:2506.03247), Martinelli (mp_arc 98-545) and Grady (arXiv:1104.3331).*

*Tags follow note 09: [T] theorem; [T-pre] credible preprint; [C] claimed and unverified; [H] heuristic; [D] disputed; [I] my own inference. [M] means a figure quoted from memory that must be checked before use.*

---

## 0. Verdict in brief

1. **The framing is right.** Track E is a speculative portfolio kept off the critical path, behind sanity filters and with an obstruction red team. Keep all of that.

2. **E2 hides the hard part.** "Run the rigorous RG down to an intermediate scale, then verify a finite-size criterion" moves the crossover problem rather than solving it.
   - At the last scale where a Bałaban-type RG is controlled ($g_k\le\bar g$, with $\bar g$ small and not even explicit), the effective theory's correlation length in block units is about $\exp(1/(2b_0\bar g^2))$. No finite box can certify anything there.
   - The finite-size criterion can only be applied *after* an uncontrolled crossover of $O(1)$ RG steps at $g^2\in[1,25]$ (C1).

3. **New obstruction [I]: every criterion that is uniform over all volumes and all boundary conditions is capped at $O(1)$ bare coupling in $d=4$, and very likely also in $d=3$.**
   - This covers Dobrushin's condition, Dobrushin–Shlosman complete analyticity, Stroock–Zegarlinski all-volume log-Sobolev, single-scale Bakry–Émery, and Durhuus–Fröhlich environment-uniform decay.
   - **Mechanism in 4D.** A height-one slab of vertical links with every other link frozen to $I$ is *exactly* the 3D O(4) model at $\beta_{O(4)}=\beta_{\rm LQCD}$ (for SU(2)). That model orders at large β.
   - **Mechanism in 3D.** A frustrated "XY-reducing" boundary environment turns the 2D slab model into a KT-type model with power-law decay.
   - **Consequence.** E2 must use criteria restricted to **cubes** (Martinelli 1998; Chatterjee's cube-based strong gap). E4's plan to extend family 215 to the DF slab models aims at a statement that is plausibly *false* at large β (§2, C2–C3).

4. **E3 lumps together islands of very different difficulty.**
   - On $\mathbb R^2\times T^2$ with 't Hooft flux the perturbative spectrum is *completely gapped* (Tanizaki–Ünsal §2.2). A *lattice* theorem there (weak-coupling exponential clustering, uniform in β) looks feasible now with Balaban–Brydges–Imbrie–Jaffe-type technology. It would be the first weak-coupling clustering theorem for a continuous non-abelian 4D-geometry lattice gauge theory.
   - The center-stabilized $\mathbb R^3\times S^1$ case needs a rigorous non-abelian Polyakov Coulomb gas, which is open even for 3D Georgi–Glashow.
   - Continuity to $\mathbb R^4$ has no known method.

5. **E1 ("3D first") is sensible for crossover research, but the plan overclaims and misses prerequisites.**
   - YM₃ *has* a UV problem; it is super-renormalizable, not absent.
   - The 3D IR problem is not "the same": the running is power-law and the scaling target is $m_{\rm lat}\gtrsim c/\beta$, not $e^{-c\beta}$.
   - 3D U(1) is *gapped*, so the main 4D sanity filter does not discriminate in 3D.
   - The ladder has no 3D infinite-volume rung.

6. **Track E has no frozen statements and no bridge lemma.** That violates the plan's own principle P1. Nothing connects a lattice clustering result to `HasMassGap`.

7. **The cheap, certain-value Lean deliverables that note 09 §4.3 recommends are missing.** These are: `lgt`→SU(N), Chatterjee 2021, the DF reduction, Chatterjee 2026, negative tests, and replays of `lgt` and family 215. They are also Track B infrastructure.

8. **"Interval-arithmetic, Lean-checked" collides with the acceptance gate.**
   - `native_decide` introduces `Lean.ofReduceBool`, which a three-axiom Comparator gate rejects.
   - The best computer-assisted rigorous RG in 2026 (Ebel–Kennedy–Rychkov) certifies only $\beta\le0.12$ of the 2D Ising high-temperature phase ($\beta_c\approx0.44$). That is a sobering calibration point.

9. **The sanity filters are incomplete and partly non-operational.** Add:
   - Banks–Zaks: $b_0>0$ is not sufficient;
   - the 2D XY and θ=π analogues;
   - the inverted U(1) filter in 3D;
   - the all-volume cap.

   Encode the cheap ones as Lean negative tests.

10. **Missing ideas.** Tensor RG (which has a rigorous, computer-assisted line), Hamiltonian/Kogut–Susskind plus quantum-many-body gap stability, a precise account of what RP chessboards can and cannot do, Fröhlich–Spencer multiscale, step-scaling couplings, multiscale Bakry–Émery, and OpenAI's own IR control. Each is given a disposition in §5.

---

## 1. What must be kept

| Keep | Why |
|---|---|
| "Research portfolio, explicitly speculative; not on the critical path" (§2 Track E; §5 last row) | Consistent with every source. The gap is open and not claimed by OpenAI or the committee (notes 02, 09, 11). |
| The sanity filters (4D U(1); no confinement for finite groups or SO(3); θ=π) | They are the right *kind* of filter (note 09 summary item 4; note 07 §5.2(c)). Ito–Seiler's U(1) objection to Tomboulis shows they bite (note 07 §2.11). Extend them (C9). |
| E5, the obstruction red team modelled on Constantin–Ignatova–Vicol | This is the most valuable NS lesson for an open problem (note 03 §6.1; P2 group G5). §2 C2–C3 show it already pays: two obstructions fall out of a desk review. |
| The 3D-first instinct (E1) | 3D is the right place to test crossover ideas (power-law running; Bałaban 3D UV; DF not dimensionally obstructed at strong coupling). Reshape it with a 4D-liftability gate (C4). |
| Replay family 215 (E4) | It is the only [C] transmuted-gap proof in an asymptotically free model with a Lean development (notes 04 §3.3, 09 §2.15). Cheap and informative. Move it to Phase 0 (C7). |
| Interval arithmetic in the toolset; "heuristic until certified" tagging (P8) | Correct discipline. Make the certificate path compatible with the gate (C8). |
| "Monthly kill/continue" | Keep the idea of kill criteria, but tie them to artefacts and budget, not the calendar (§6). |
| §0 item 4: "The gap needs new mathematics" | Matches Jaffe–Witten ("no present ideas point" toward a uniform gap; note 09 §2.16). |

---

## 2. Prioritized criticisms, each with a concrete revision

### C1 (critical). E2 relocates the crossover; it does not address it

**What is wrong.** E2 reads: "Run the rigorous RG down to an intermediate scale. Then verify a Dobrushin–Shlosman / Bakry–Émery-type finite-volume mixing condition for the effective lattice theory." This contains three gaps.

1. **The window problem.**
   - The rigorous RG (Bałaban; Dimock's framework) controls $g_k\le\bar g$ for *some* small, non-explicit $\bar g$ (note 05 §2.4, §5.1).
   - At that scale the theory is still weakly coupled. Its correlation length in units of the block is $\xi_{\rm eff}\sim\exp(1/(2b_0\bar g^2))$ [H]. A finite box would have to exceed this, which is impossible.
   - So the criterion can only bite after the coupling has been carried from $\bar g$ to $g_*=O(1)$. That carrying is the "missing mathematics" of note 09 §2.1 and §4.2 (L2) and note 07 §4 / lead 7.
   - Lattice data make the shape concrete. For SU(2) the 0⁺⁺ correlation length is about one lattice spacing near $\beta_{\rm LQCD}\approx2.4$ [M: $a\sqrt\sigma\approx0.27$, $m_{0^{++}}/\sqrt\sigma\approx3.7$]. The best proven criteria stop at $\beta_{\rm LQCD}\le0.17$, where $\xi\approx0.08$ lattice spacings. In physical units the window is only about 3–4 factor-2 blockings wide [I]. In coupling it spans a factor of about 15 (note 07 §4).
   - **The problem is not iterating many controlled steps. It is controlling a few steps in which nothing is small.**

2. **Explicit constants.**
   - Computer-assisted matching needs $\bar g$ to be **explicit** and not absurdly small, so the UV RG must be redone with explicit constants.
   - Nothing in the constructive literature for 4D gauge theory does this. Bałaban, Dimock and Bauerschmidt–Brydges–Slade all work "for $g$ sufficiently small".
   - The plan does not list this cost.

3. **The effective theory is not a specification.**
   - Bałaban's effective actions are defined on small-field regions, with gauge fixing on blocks and separate large-field bounds (note 05 §2.3). That is not a quasi-local Gibbs specification on coarse links.
   - Block-spin images of Gibbs measures can be **non-Gibbsian** (van Enter–Fernández–Sokal 1993).
   - Dobrushin–Shlosman/Martinelli–Olivieri criteria apply to (quasi-)local specifications, so Gibbsianness and quasi-locality of the coarse measure at $g_*$ are proof obligations.

**Revision (replace the E2 row).**

> **E2 — Crossover interface and terminal criteria.** E2 is split into three parts.
> - **E2-int.** Freeze the "matching lemma" (note 07 lead 7) as a Lean `Prop` with three named hypotheses:
>   - (H_UV) control from $a$ to $L_k$ with explicit $\bar g$;
>   - (H_X) a crossover from $\bar g$ to $g_*$ in a stated norm, including Gibbsianness and quasi-locality of the coarse measure;
>   - (H_IR) a cube-restricted mixing criterion at $g_*$ (see C2).
>
>   Prove H_IR ⇒ continuum gap through the bridge lemma (C6). H_X is the open problem and is labelled as such.
> - **E2-cal.** A computer-assisted calibration on the *bare* action and on 2D tensor RG (C8, §6 E1.B).
> - **E2-lab.** Heuristic (Monte Carlo) measurement of the window: how many blockings, which effective couplings, and whether a cube-restricted criterion is numerically satisfied at accessible box sizes, under adversarial boundary conditions.
>
> First milestone: the frozen E2-int statement plus an E2-lab report. *Not*: "feasibility study: what box size?"

### C2 (critical). All-volume finite-size criteria are capped at $O(1)$ coupling in $d=4$ (and, heuristically, in $d=3$). E2 must be cube-restricted [I]

**What is wrong.** The plan names "Dobrushin–Shlosman / Bakry–Émery-type" criteria. The standard forms of these are uniform over **all** finite volumes $\Lambda$ and all boundary conditions:
- Dobrushin's condition;
- DS complete analyticity (CA);
- Stroock–Zegarlinski's all-volume LSI, which they prove equivalent to CA;
- single-scale Bakry–Émery, which gives an LSI for every Λ and every boundary condition, and hence CA.

In 4D these cannot hold beyond an $O(1)$ bare coupling.

**Obstruction O1 ($d=4$; rigorous up to the value of the constant) [I].**
- *Setup.* Take SU(2) with the Wilson action $\beta_W\sum_p{\rm Re\,Tr}(I-U_p)$. Let $\Lambda_M$ be the vertical links $((x,0),(x,1))$ for $x\in[-M,M]^3$. Freeze every other link to $I$.
- *Reduction.* Each horizontal edge $(x,y)$ lies in exactly one plaquette containing two $\Lambda$-links, with $U_p=Q_xQ_y^{-1}$. So the conditional law is $\propto\exp(\beta_W\sum{\rm Re\,Tr}\,Q_xQ_y^{-1})=\exp(2\beta_W\sum q_x\cdot q_y)$. This is the **3D O(4) model** at $\beta_{O(4)}=2\beta_W=\beta_{\rm LQCD}$, with pinned lateral boundary.
- *Ordering.* That model has spontaneous magnetization at large β (Fröhlich–Simon–Spencer 1976 infrared bound, itself a reflection-positivity argument). Monte Carlo puts the transition at $\beta_{O(4)}\approx0.936$ (Kanaya–Kaya PRD 51 (1995), value as quoted by Grady arXiv:1104.3331 [M]).
- *Conclusion.* Above the threshold the infinite-slab sub-specification depends on the lateral boundary condition. That contradicts CA, which forces uniqueness for every sub-specification. Hence:
  - **no all-volume criterion can hold for 4D SU(2) beyond $\beta_{\rm LQCD}\approx0.94$** (the heuristic value; the rigorous cap sits at the FSS threshold, which should be computed);
  - that is about 2.5× *below* the start of the scaling window (≈2.3);
  - it is about 5.6× *above* the CNS area-law threshold (0.167; note 07 §4).
- This is the note 09 §2.10 [I] "dimensional obstruction to DF", made quantitative and widened from DF to every all-volume criterion.
- *Caveat.* O1 concerns *conditional* measures on thin sets, not the bulk. It does **not** imply a bulk transition. Grady 2011 draws the same O(4) layer picture and claims an SU(2) bulk transition at β≈3.18; that is [D], against the Monte Carlo consensus of no transition.

**Obstruction O2 ($d=3$, environment-uniform criteria; heuristic, physics-standard) [I].**
- *Setup.* For 3D lattice gauge theory the DF slab model is 2D, with coupling ${\rm Re\,Tr}(Q_xA_eQ_y^{-1}B_e^{-1})$ (CNS Thm 2.3, note 09 §2.10). Choose $A_e=p_e$ and $B_e=p_e^{-1}$, with $p_e=\exp(\alpha_e\mathbf i)$ for a fixed imaginary unit quaternion $\mathbf i$. The edge map $q\mapsto p_eqp_e$ is then a simple rotation of the plane ${\rm span}\{1,\mathbf i\}$ that fixes ${\rm span}\{\mathbf j,\mathbf k\}$.
- *Ground states.* Put non-zero flux through the plaquettes of the first plane (for example π-flux, where the Hofstadter top eigenvalue is $2\sqrt2<4$). Then:
  - the energy is minimized *only* by constant spins on the unit circle of the unfrustrated plane;
  - out-of-plane modes are massive;
  - the low-temperature model is an **XY model**, with KT quasi-long-range order and power-law decay (rigorous for the pure XY model by Fröhlich–Spencer 1981).
- *Conclusion.* The DF hypothesis, exponential covariance decay **uniform in $(A,B)$**, therefore fails at large β in $d=3$, and 3D CA fails with it.
- *Correction to note 09.* Note 09 §2.10 [I] expected the 3D slab model to be "gapped at all β by Mermin–Wagner and AF lore". That overlooks frustration: Mermin–Wagner forbids long-range order, not quasi-long-range order.
- *Effect on the plan.* This undercuts E4 as written (C3).

**What survives.** Criteria restricted to **regular volumes (cubes)**. Martinelli (mp_arc 98-545, 1998) gives finite-size conditions for exponential decay of covariances for finite-range models with compact spin space. It explicitly treats both the completely-analytic case and the case where decay holds only on regular volumes. Chatterjee's strong gap (note 09 §1.2) is also cube-based. Neither O1 nor O2 applies to cubes: the interior links of a cube are free, so no frozen-face layer forms.

**Revision.**
- In E2, replace "Dobrushin–Shlosman / Bakry–Émery-type finite-volume mixing condition" with: "a **cube-restricted** strong-mixing criterion (Martinelli 1998 type; Chatterjee strong gap). All-volume criteria (Dobrushin, DS-CA, SZ all-volume LSI, single-scale Bakry–Émery, DF-uniform) are capped at $O(1)$ bare coupling by O1/O2 and are used only as terminal criteria deep in the strong-coupling regime."
- Add O1 and O2 to the E5 ledger (§6). Tasks:
  - prove the O1 reduction in Lean (the conditional-measure identity is cheap);
  - compute the rigorous FSS threshold;
  - check O2 numerically and against the literature. This is likely folklore among experts; find out whether Chatterjee chose cubes for this reason.

### C3 (major). E4 misstates the reductions and targets a plausibly false generalization

**What is wrong.**
1. "Durhuus–Fröhlich and Chatterjee reduce area law **and gap** to a strong decay statement." In fact they reduce **area law** to (a) environment-uniform slab decay (DF) or (b) the boundary-uniform strong gap (Chatterjee Thm 2.4). Neither reduces the *gap* to anything; the strong gap *is* a strengthened gap (note 09 §1.2, §2.10).
2. "Test whether family 215 generalizes to the slab σ-models":
   - In 4D the slab model is 3D and orders (O1). DF is intrinsically strong-coupling there.
   - In 3D, environment-uniform decay is plausibly false (O2).
   - Family 215's environments are scalar ferromagnetic couplings $b_e\in[0,\beta]$; DF's are matrix twists (note 09 §2.15(a)). For SU(2), the DF slab model is exactly the **2D O(4) model in an SO(4) background connection**. 215 (with $n=4$) is its unfrustrated special case.
   - File names in 215 (`IsingGinibre`, `FinFKG`, `ComplexWard`, `RotationInequality`, `CoarseExponential`; note 09 §5 lead 1) suggest ferromagnetic correlation inequalities, which do not survive frustration.

**Revision (replace the E4 row).**

> **E4 — Conditional reductions and the 2D calibration.**
> - (a) Lean-formalize the *true* reductions now: DF/CNS Thm 2.3 ⇒ area law; Chatterjee strong gap ⇒ area law.
> - (b) Family 215:
>   - replay with `lake comparator --paranoid` (nanoda was off; note 04 §3.3);
>   - audit the 60-line statement;
>   - write a mechanism memo. Where is $n\ge3$ used? Where is ferromagnetism used? What is `CoarseExponential` (a Simon–Lieb-type finite-size bootstrap?)?
> - (c) Research question, replacing "generalize to slab models": an **annealed** DF reduction. That is, decay for environments typical under the gauge measure, with large-deviation control of XY-reducing environments. The uniform version is obstructed (O1, O2).
>
> First milestone: (a) and (b) in Phase 0–1.

### C4 (major). E1: "no UV problem, the same IR problem" overclaims; prerequisites and liftability are missing

**What is wrong.**
1. **UV.** YM₃ is super-renormalizable, not UV-trivial.
   - Bałaban's 3D UV stability is on a finite torus.
   - No refereed continuum YM₃ exists. Sussman–Alpöge (857 + 1,201 pp.) and Aronow–Lopatto are [C] (note 11 §2.2).
   - The M8 table entry and the E1 text repeat the overclaim.
2. **IR.** The 3D coupling is dimensionful.
   - The dimensionless coupling grows like a power, $e^2L$, so there is no marginal flow and no $e^{-1/g^2}$ transmutation.
   - The lattice scaling target is $m_{\rm lat}(\beta)\gtrsim c/\beta$, not $\gtrsim e^{-c\beta}$.
   - This makes 3D a better *testbed* for crossover bookkeeping, but it is a different problem.
3. **Missing prerequisite.** A continuum 3D gap needs YM₃ on $\mathbb R^3$, i.e. a 3D analogue of M7. The ladder has only M4 (T³).
4. **Liftability.** The mechanisms that work in 3D are 3D-specific:
   - Durhuus–Fröhlich at strong coupling (the 2D slab model);
   - KKN/Nair, which uses 2D space;
   - the Polyakov/Göpfert–Mack monopole-instanton gas.

   **Compact U(1) is gapped in 3D** (Göpfert–Mack), so filter F1 ("must fail for U(1)") does not discriminate there. A 3D success is therefore weak evidence for 4D.

**Revision.** Replace M8 with three rungs:
- **M8a**, lattice 3D: $\exists\,c>0$, $\forall\beta\ge\beta_0$, cube-uniform exponential clustering of gauge-invariant local observables for 3D SU(2) Wilson lattice gauge theory, with rate $\ge c/\beta$.
- **M8b**, YM₃ on $\mathbb R^3$ (existence, OS axioms).
- **M8c**, the continuum 3D gap.

Add to E1:

> **Every E1 result must carry a "4D-liftability memo".** It must say which step uses $d=3$, and what replaces it in $d=4$. Mechanisms tied to $d=3$ (KKN, Polyakov monopole-instantons) are pursued only as standalone 3D results and receive no 4D credit. Priority goes to crossover arguments whose only dimension dependence is power-law versus logarithmic running.

### C5 (major). E3: the semiclassical islands differ by orders of magnitude in difficulty; pick the tractable one

**What is wrong.** "A rigorous gap on $\mathbb R^3\times S^1_L$ (center-stabilized) or $\mathbb R^2\times T^2$ with 't Hooft flux at small L" treats the two as alternatives of similar difficulty. They are not.

| Island | Source of the gap | Classically visible? | Hard parts | Realism |
|---|---|---|---|---|
| **$\mathbb R^2\times T^2_L$, 't Hooft flux** (Yamazaki–Yonekura; Tanizaki–Ünsal) | Twisted holonomies Higgs SU(N)→$\mathbb Z_N$. "The perturbative fluctuations are completely gapped" (TU §2.2, eq. 2.19), with mass ∝ $2\pi/(NL)$. Center vortices (fractional instantons, action $8\pi^2/(g^2N)$) restore the 2D $\mathbb Z_N^{[1]}$ symmetry and give the area law | **Gap: yes** (tree level). Confinement: no | Infinite volume in $\mathbb R^2$ with non-abelian large fields; gauge fixing around the twisted vacuum; a dilute **short-range** vortex gas (vortex interactions are mediated by massive fields), which is a standard cluster expansion. Passes F1: U(1) admits no such isolated vacuum, and its holonomy scalars stay massless [I] | **Lattice version: medium-high, now. Continuum version: medium, after M5 and Track D step 1** |
| **$T^3_L\times\mathbb R$, twisted box** (Lüscher 1983; 't Hooft; van Baal [M]) | Isolated classical vacua in each electric-flux sector; tree-level gap ∝ $1/L$ | Yes | Continuum on $T^3\times\mathbb R$ (M6 with $T\to\infty$) plus semiclassical spectral analysis of a finite-dimensional effective Hamiltonian (Simon 1983) | Lattice version at fixed spatial size is near-standard. **The continuum version is a corollary candidate of M6** (note 05 §5.1(c)) |
| **$\mathbb R^3\times S^1_L$, center-stabilized** (Ünsal–Yaffe) | W-bosons are massive, but the Cartan photons are massless perturbatively. The gap comes from monopole-instantons, $m_\gamma\sim e^{-8\pi^2/(g^2N)}$ | **No**: genuinely non-perturbative | A long-range (3D Coulomb) non-abelian monopole gas, open even for 3D Georgi–Glashow (note 09 §2.7). The double-trace term is built from bare Polyakov loops, which carry linear (perimeter-type) divergences, so the deformation needs its own renormalization [I; cf. note 08 §1.8]. RP in the $\mathbb R^3$ directions is fine because the term is fibre-local [I] | Low–medium (Fields-level) |
| $\mathbb R^3\times S^1_L$, undeformed, small L | Deconfined. The electric mass is perturbative; the magnetic mass ∝ $g^2T$ **is the 3D YM gap** | No | Same as E1 | Not an island; it reduces to E1 |
| Continuity in L up to ℝ⁴ | None known | — | No method excludes transitions outside the analyticity domain of convergent expansions (note 09 §2.13 (iv)) | ≈0. **Non-goal** |

**Revision (replace the E3 row).**

> **E3 — Islands, ordered by tractability.**
> - **E3a (start now).** *Lattice* twisted-island theorem: SU(N) Wilson lattice gauge theory on $\mathbb Z^2\times(\mathbb Z_n)^2$ with 't Hooft flux. For $\beta\ge\beta_0(n,N)$, gauge-invariant local observables cluster exponentially with rate $\ge c/(Nn)$, **uniformly in β and in the $\mathbb Z^2$ volume**. Template: Bałaban–Brydges–Imbrie–Jaffe 1984 (Higgs mass gap on a unit lattice) and Chatterjee–Yakir. Scope note: "classically visible gap; not the transmuted gap."
> - **E3b (after M6).** Twisted $T^3_L\times\mathbb R$ continuum Hamiltonian gap at small L.
> - **E3c (after M5 + Track D step 1).** The continuum $\mathbb R^2\times T^2$ island.
> - **E3d (Tier 3, only after a rigorous 3D Georgi–Glashow Polyakov theorem).** Center-stabilized $\mathbb R^3\times S^1$.
> - **Continuity is a non-goal.** Only obstruction work.

### C6 (major). P1 is not applied to Track E: there are no frozen statements and no bridge to M0

**What is wrong.** Every other rung is frozen and reviewed before search. Track E has "M8 statement and the best strategies", "feasibility study", and "rigorous gap in a locally 4D nonabelian theory".

Several concrete hazards follow:
- The finite-volume gap is trivial by Perron–Frobenius (note 09 §1.2). A gap statement that is not uniform in volume is vacuous.
- A lattice gap at fixed β (Chatterjee Problem 5.1) is much weaker than the continuum gap. The latter needs $\liminf_{\beta\to\infty}m_{\rm lat}(\beta)/a(\beta)>0$ (note 07 §5.2).
- "Gap" for islands, lattice and finite volume must carry scope notes, or the project will repeat the family-215 "(Lean) link on an unformalized headline" pattern (note 04 §1 item 5).

**Revision (add to §1 and to Track E).**

> **E0.2 — Frozen gap-ladder statements.** Each gets a red team, a scope note in the `lean/docs/NNN.md` style, and a hash in `FREEZE.log`.
>
> Quantifier template: OpenAI's `ClassicalON.lean` (∀ finite volume, ∀ environment, ∃ uniform constants; note 09 §4.3 item 1).
>
> The statements:
> - `LatticeClustering G d β` (cube-uniform);
> - `StrongGap G d β` (Chatterjee Def. 2.3);
> - `CubeStrongMixing` (Martinelli 1998 form);
> - `SlabUniformDecay` (DF/CNS Thm 2.3);
> - `ScalingGap`. Here $a(\beta)$ is the **trajectory produced by the existence construction** (Tracks C/D, or OpenAI's released statement), not the perturbative formula;
> - M8a/M8c;
> - E3a/E3b.
>
> **E0.3 — Bridge lemma.** `UniformRenormalizedClustering ⇒ HasMassGap`. If the renormalized, smeared lattice fields of an `IsWilsonLimit` sequence cluster at rate $m\,a(\beta)$, uniformly in volume and β, then the limit satisfies `HasMassGap m`, including vacuum uniqueness. This is independent of existence, provable now, and it makes every E result plug into M0.

### C7 (major). The cheap, certain-value formal deliverables are missing

**What is wrong.** Note 09 §4.3 items 2–3 and note 07 §5.3 list early targets that build exactly the Gibbs-measure, Wilson-loop and conditioning libraries any gap proof needs. They also feed Track B's M2. None appears in the plan.

**Revision (add E0 to Track E, budgeted under Track B).**
- **E0.1, replays.** `lgt` and the `markov-semigroups` axiom audit: `markov-semigroups` postulates 8 axioms, which `lgt`'s headline theorems avoid (note 10 §2.8). Also family 215 `ClassicalON`. Run on Linux with bwrap and `--paranoid`.
- **E0.4, negative tests.**
  - The free Maxwell field (via OSforGFF) fails `HasMassGap`.
  - Lemma: the finite-volume transfer-matrix gap holds at every β. This guards against vacuous statements.
  - Statements only: 4D U(1) Coulomb phase (Guth; Fröhlich–Spencer 1982), 2D XY power law, finite-group gap with perimeter law, SO(3) deconfinement.
  - The O1 reduction lemma.
- **E0.5, cheap wins.**
  - `lgt` Dobrushin gap generalized to SU(N) and to closed subgroups (the `HasGaugeTrace` hook);
  - Chatterjee 2021 (strong gap ⇒ area law);
  - DF/CNS reduction;
  - Chatterjee 2026 3D log-confinement (13 pp.).

### C8 (major). "Computer-assisted, Lean-checked" needs a certificate architecture and a calibration run

**What is wrong.**
1. **The gate.** The acceptance gate allows only `propext`, `Classical.choice` and `Quot.sound`. Lean's fast evaluation route, `native_decide`, adds `Lean.ofReduceBool`, which the gate rejects (note 04 §2.2, design rule 7). Kernel-only arithmetic (GMP-accelerated `Nat`) is orders of magnitude slower than Arb [I].
2. **OpenAI's precedent is to *not* Lean-check heavy numerics.** PrimeGaps186 declares its numerical bounds as project axioms, backed by a Python/FLINT certificate (note 04 §3.5).
3. **Calibration.** The most advanced rigorous computer-assisted RG for lattice models is Ebel–Kennedy–Rychkov (arXiv:2506.03247, v2 June 2026). Its tensor-RG "2x1 map" uses interval arithmetic and a finite "bounding box" of 63 sectors.
   - It certifies the 2D Ising high-temperature phase for $\beta\le0.12$, against $\beta_c\approx0.44$. That is "roughly one quarter". It also falls *below* the best optimized cluster expansion (0.151).
   - The authors call a computer-assisted RG framework for lattice models "always … a dream".
   - Dobrushin–Kolafa–Shlosman (CMP 102, 1985) is the precedent for a computer-assisted DS finite-volume criterion, on the 2D Ising antiferromagnet.
   - The 4D gauge crossover sits 14–35× beyond the proven thresholds in β (note 07 §4).
4. **Box sizes** (§3.2): order 10³–10⁴ SU(N) link variables per box in 4D. Direct rigorous integration is out of the question.

**Revision (add to P8 and E2).**

> **Certificate architecture.**
> - The untrusted search produces rational certificates: dual SDP solutions, interval enclosures written as rational inequalities, contraction constants.
> - Lean checks them with kernel arithmetic only. `native_decide` and `ofReduceBool` are banned.
> - Where kernel checking is infeasible, a rung may use the PrimeGaps186 honest-axiom pattern: declared `NumericAxiom`s with two independent implementations (Arb plus a second library), listed in the Comparator config and labelled `proved-conditionally`. No such axiom may reach M0.
>
> **Calibration experiment E1.B (Phase 1).** AI-guided optimization of the EKR 2x1 map, using the reweighting matrices and softer disentanglers the authors list as improvements. The evaluator is their interval code, re-implemented independently. Goal: push the certified Ising basin from 0.12 toward 0.3.

### C9 (moderate). The sanity filters are incomplete and partly non-operational

**What is wrong.**
- **Missing filter: "compact non-abelian + AF" is not enough.** Banks–Zaks theories, such as SU(3) with enough fundamental flavours, are asymptotically free (b₀>0) yet flow to an IR fixed point and are gapless. A crossover argument that uses only "b₀>0 drives g up" would prove a false gap there.
- **Missing 2D analogues for the family-215 line.** Any O(n) argument must fail for $n=2$ (KT). Any extension with a θ-term must fail at θ=π (O(3) at θ=π is gapless; Haldane/Affleck) [H].
- **3D.** F1 is inverted, since 3D U(1) is gapped (C4). 3D filters are: non-compact free Maxwell, and many-flavour QED₃ (conformal) [H].
- **θ=π (4D).** The Wilson measure is real and positive at θ=0. Lattice θ-terms are complex weights, so most probabilistic arguments are silent there. The filter is mostly vacuous unless it is made operational.
- **Not encoded.** None of the filters is a Lean test.

**Revision (replace the filter list).**

> **Every E argument must state, in a filter table, the step that fails for:**
> - **F1**, 4D U(1). For an RG-crossover argument this is the crossover step, because U(1) is IR-free (Ito–Seiler).
> - **F2**, finite G (area-law claims only; perimeter law at weak coupling).
> - **F3**, SO(3) (confinement claims only).
> - **F4**, Banks–Zaks / conformal-window QCD, the case where b₀>0 is not enough. This can be checked against OpenAI's fermionic pipeline once it is released.
> - **F5**, 2D: $n=2$ XY, and O(3) at θ=π.
> - **F6**, 3D: free Maxwell and conformal QED₃.
> - **F7**, the all-volume cap (O1/O2): no all-volume criterion may be claimed at $\beta_{\rm LQCD}\gtrsim1$.
> - **F8**, θ=π, operational form: say where real positivity of the measure (RP) is used.
>
> F1 (free-Maxwell part), F7 (O1 reduction) and the finite-volume-triviality guard become Lean regression tests (E0.4).

### C10 (moderate). Important ideas are missing from the portfolio

Dispositions are given in §5. The main omissions:
- tensor RG, which has a rigorous and computer-assisted line, not just "Douglas reportedly favours it";
- Hamiltonian/Kogut–Susskind formulations and quantum-many-body gap stability;
- the precise role of RP chessboards, which help with large fields and obstructions but give only *upper* bounds on masses;
- the Fröhlich–Spencer/Göpfert–Mack defect-gas multiscale;
- multiscale Bakry–Émery (Bauerschmidt–Bodineau);
- step scaling;
- fixed-point actions (with a universality caveat);
- OpenAI's own IR control.

### C11 (moderate). The organization, metrics and budget of Track E

**What is wrong.**
1. **The routes E1–E5 mix four axes**: dimension (E1), method (E2), geometry (E3), reduction (E4) and process (E5). Note 09 §4.4 recommends organizing by **layer/interface** (L1 UV, L2 crossover, L3 terminal), with mechanisms used as *critics*.
2. **P2's reallocation rule rewards the wrong thing for E.** It reallocates "weekly toward kernel-checked progress". Applied to E, this either starves E or pushes it toward cheap but irrelevant Lean lemmas (Goodhart).
3. **No budget share is stated**, and "monthly" kill/continue has no measurable signals.
4. **"Kill or certify each E-route monthly" (E5).** A route cannot be "certified".

**Revision.**
- Organize Track E by tier and interface (§6).
- E-specific progress metrics:
  - frozen interface statements;
  - certified threshold improvements;
  - obstructions proved;
  - numerical falsifications;
  - conditional theorems with crisp hypotheses.
- Track E ≤ 10% of tokens until a Tier-2 milestone lands. Tier 0 is charged to Track B.
- E5 maintains an **obstruction ledger**. Every candidate must say which ledger entries it evades before it receives proof budget.

### C12 (moderate). §0 item 4 overclaims, and the firewall needs a Track-E-specific decision

**What is wrong.**
1. "The mass gap was not obtained even at OpenAI's scale (about 10⁴ concurrent agents and about 10¹¹ tokens per problem on Navier–Stokes)" imports *NS* figures into a YM claim. Nobody knows whether, or how hard, OpenAI attempted the gap (note 99 (d) items 8–9). Family 215's O(n)/O(4) gap work suggests interest.
2. The independence firewall is right for existence. But the most natural L2 input is precisely *what OpenAI controls "to infinite distances" without a gap* (note 09 §5 lead 7; note 02 §2.3 item 2). Since the user takes OpenAI's existence proof as correct, a gap theorem conditional on its *released statement* is a legitimate result of our own.

**Revision.**
- §0 item 4 becomes: "The mass gap is not claimed by OpenAI or the committee. We do not know whether it was attempted. We treat it as a research bet."
- Add to §6 (decisions for Peter): "May Track E import OpenAI's released *theorem statements* as `Published…`-style hypotheses now, and read their IR estimates as cited literature after release? Tracks B–D stay firewalled either way."

### C13 (minor). Interplay with Track D

- `HasMassGap` includes vacuum uniqueness (PROBLEM.md §3.4). A Track-E success therefore *subsumes* D4, the ergodic decomposition.
- Separately, D4's claim that RP survives "for almost every component" is not automatic. RP is preserved under mixtures, not inherited by components. Flag this to the Track D reviewer [I].

### C14 (minor). Actions and universality

- Several E routes naturally use non-Wilson actions or boundary conditions:
  - twisted boundary conditions;
  - fixed-point "perfect" actions (Hasenfratz–Niedermayer 1994), which keep the RG flow in a parametrized family, an attractive property for computer-assisted matching;
  - the Kogut–Susskind anisotropic limit;
  - heat-kernel actions.
- `IsWilsonLimit` and `SUNExistsWithMassGap` pin the Wilson action (PROBLEM.md C5). So each such route needs either a universality lemma or an explicit note that it targets `ClayYangMills` (existential representation) only through a separate identification. Bulk transitions for N≥5 (note 09 §2.2) make the choice of action a real decision.

---

## 3. E2 feasibility, answering the plan's own questions

### 3.1 Is the idea sound in principle?

**Yes, as architecture.** It is the L1/L2/L3 architecture of note 09 §4.2, and it is the only route that matches the structure of the problem (note 09 ranking #1).

**No, as written.** The difficulty sits in L2 (C1), and the named criteria are of the capped all-volume type (C2).

**One genuinely positive fact [T].** For finite-range models with compact spins, complete analyticity, and its regular-volume analogue, is *equivalent* to a finite-volume condition holding for *some* finite box (Dobrushin–Shlosman 1985/1987; Martinelli 1998). So if a cube-mixing property holds at $g_*$, a finite certificate *exists*. What is in question is its size and cost, not its existence. This semi-decidability contrasts with quantum Hamiltonians, where the spectral gap is undecidable in general (Cubitt–Pérez-García–Wolf 2015). Any finite-size *Hamiltonian* gap test therefore needs model structure: frustration-freeness, positivity, or RP.

### 3.2 Which finite-size criteria apply to lattice gauge theories?

| Criterion | Applies to LGT? (gauge invariance, specification) | Cap / status |
|---|---|---|
| Dobrushin single-site (links as spins) | Yes. `lgt` does this; Gibbs states of a gauge-invariant specification are automatically locally gauge-invariant (DLR plus invariance of $\mu_\Lambda^\omega$), so no gauge fixing is needed | $\beta_W<1/(32n(d-1))$ in `lgt`; all-volume, so capped by O1/O2 |
| Dobrushin–Shlosman CV / complete analyticity (1985, 1987) | Yes formally: finite-range plaquette interactions, compact link spins. Wasserstein influences must use gauge-invariant observables or a quotient metric | **All-volume: capped (O1 in 4D at $\beta_{\rm LQCD}\approx0.94$ for SU(2); O2 in 3D)** |
| Stroock–Zegarlinski (all-volume LSI ⇔ CA; compact-manifold spins, JFA 1992) | Yes; this is the logic behind SZZ | Capped, same as CA |
| Single-scale Bakry–Émery ($\mathrm{Ric}-\mathrm{Hess}\,S\ge K$) | Yes (SZZ, CNS). It is a *pointwise* local matrix inequality, so it is cheap to verify by interval branch-and-bound | Hessian ∝ $N\beta d$ against Ricci ∝ $N/2$ caps it at the 't Hooft regime (note 07 §4); it also implies CA, so the O1 cap applies too |
| **Martinelli 1998 / Martinelli–Olivieri 1994: cube-restricted strong mixing** | Yes, for compact spin spaces (check the continuous-spin details) | **Not obstructed by O1/O2. The only class that could reach the scaling regime** |
| Chatterjee strong gap (cubes, arbitrary boundary conditions) | Designed for LGT | Unknown at weak coupling (Chatterjee: unclear whether physics expects it); test numerically (E1.C) |
| DF slab, uniform in environment | Designed for LGT | Obstructed: O1 (4D, rigorous), O2 (3D, heuristic). Annealed version open |
| Simon–Lieb / Lieb / Aizenman–Simon finite-size bootstraps | Need GKS/Ginibre ferromagnetic inequalities: available for $\mathbb Z_2$/U(1) and O(n), **not for SU(N)** | Not applicable to non-abelian gauge theories. Possibly 215's `CoarseExponential` |
| RP chessboard estimates (Fröhlich–Israel–Lieb–Simon 1978) | Yes (Wilson action is RP) | Control *probabilities of bad events* uniformly in volume (large fields), and give infrared bounds proving *order* (O1). They give only **upper** bounds on masses: ⟨A,T_tA⟩ is completely monotone, so finite-t data bound the gap from above |
| Rigorous tensor RG (Kennedy–Rychkov 2022, 2024; Ebel 2024 3D; EKR 2025) | Gauge models have exact character-expansion tensor formulations (Liu–Meurice et al. 2013 [M]) | Certified only near the high-temperature fixed point; 2D Ising ≤ 27% of the high-T phase |
| Knabe / Gosset–Mozgunov local gap thresholds | Hamiltonian, frustration-free only | Kogut–Susskind is not frustration-free; only its strong-coupling limit (the Casimir Hamiltonian $\sum E^2$) is. Useful only for strong-coupling Hamiltonian gaps |

### 3.3 Box sizes and cost [I, order of magnitude]

**Size of the box.** The DS-type condition is roughly $\sum_{y\in\partial V}\alpha_y<|V|$, where $\alpha_y$ is the summed interior disagreement caused by changing boundary site $y$. With a per-boundary-link influence $\bar\alpha=O(1)$ at intermediate coupling, a cube needs side $L_0\gtrsim2d\,\bar\alpha$. That is $L_0\approx8$ in $d=4$ for $\bar\alpha\approx1$, or more if the worst-case boundary condition lengthens the influence range.

| $d$ | $L_0$ | link variables $dL_0^d$ | real dimension, SU(2) | real dimension, SU(3) |
|---|---|---|---|---|
| 4 | 4 | 1,024 | ~3×10³ | ~8×10³ |
| 4 | 8 | 16,384 | ~5×10⁴ | ~1.3×10⁵ |
| 3 | 6 | 648 | ~2×10³ | ~5×10³ |
| 2 (σ-model) | 16 | 256 spins | 768 (O(4)) | — |

**Why direct verification is impossible.** The influences are suprema, over a boundary-condition space of comparable dimension, of Wasserstein distances between measures on these spaces.

**What can work.** Only *structured* certificates:
- (i) expansions with finitely many computed terms plus rigorous tails, which is strong-coupling only;
- (ii) explicit couplings or disagreement percolation (van den Berg–Maes), which reduce to small-block influences;
- (iii) pointwise convexity (Bakry–Émery), which is capped;
- (iv) RG with bounding boxes (EKR), which is 2D/3D and near trivial fixed points for now;
- (v) SDP/bootstrap positivity (Kazakov–Zheng), which bounds expectations, not decay.

**Tensor-RG cost.** HOTRG costs scale like $D^{4d-1}$ [M], i.e. $D^{15}$ in 4D. Certified interval versions are prohibitive in 4D, feasible in 2D and marginal in 3D.

**Verdict.**
- In the next 1–2 years, computer assistance can plausibly deliver:
  - (a) improved *all-volume* strong-coupling thresholds, still below the O1 cap;
  - (b) a 2D tensor-RG basin extension (calibration);
  - (c) possibly a cube-restricted certificate for **3D** SU(2) at some β above the all-volume cap. That would be a methodological first.
- A 4D weak-coupling certificate is not plausible on this horizon without a structural L2 idea.
- Fund E2 as calibration and interface work, with the kill criteria of §6.

---

## 4. Semiclassical islands: is "rigorous milestone" realistic?

- **Yes for E3a** (the lattice twisted $\mathbb R^2\times T^2$ theorem), and for E3b/E3c once Tracks C/D deliver. The tree-level gap makes the IR a massive problem of Bałaban–Brydges–Imbrie–Jaffe type, and vortices are a dilute short-range gas.
  - The deliverable must be labelled "classically visible gap". It passes F1 for a non-abelian reason: clock-and-shift holonomies cannot commute.
  - Its real value is infrastructure: the first weak-coupling cluster expansion for a continuous non-abelian lattice gauge theory around a non-trivial classical vacuum, uniform as β→∞.
- **Not yet for the center-stabilized $\mathbb R^3\times S^1$ case.** Its prerequisite, a rigorous 3D Georgi–Glashow Polyakov mechanism, is open (note 09 §2.7, §5 lead 4).
- **No for continuity** (note 09 §2.13).

---

## 5. Missing ideas: assessment and disposition

| Idea | What it offers / status | Disposition |
|---|---|---|
| **Family 215** ([C]; `ClassicalON`, about 115 Lean files, review `unchecked`, nanoda off; note 04 §3.3) | The only claimed transmuted gap in an AF model with a Lean proof. Probably uses ferromagnetic tools (file names) | **Top calibration rung (the "Euler" of the gap).** Phase 0 replay and statement audit; Phase 1 mechanism memo; O2 test. Check the licence before reusing code |
| **Tensor RG** (Levin–Nave; Kennedy–Rychkov J. Stat. Phys. 2022 and AHP 2024; Ebel AHP 2024 (3D); Ebel–Kennedy–Rychkov 2025/26) | The most mature rigorous, computer-assisted RG. Gauge-invariant by construction; exposes its truncation errors. Douglas's reported preference remains unverified (notes 02, 99) | E1.B calibration in 2D; candidate L2 engine in 2D/3D. Low for certified 4D work (cost $D^{O(d)}$; the weak-coupling start needs large bond dimension) |
| **Hamiltonian / Kogut–Susskind (1975), transfer matrix (Lüscher 1977)** | The gap *is* a spectral property, and operator inequalities (KKN/Nair $T^2-mT\ge0$) live here. Strong coupling is a local perturbation of the frustration-free Casimir Hamiltonian, so quantum-many-body stability (Bravyi–Hastings–Michalakis 2010; Fröhlich–Pizzo Lie–Schwinger 2020 [M]) plausibly gives a volume-uniform strong-coupling Hamiltonian gap [I] | A small E-Ham lab: exact diagonalization of the 2+1 Kogut–Susskind Hamiltonian in a truncated representation basis to *test* lattice KKN inequalities (kill if false). Optional Hamiltonian strong-coupling theorem. Caveats: the anisotropic limit needs universality (C14); Cubitt–Pérez-García–Wolf rules out generic finite-size gap tests |
| **RP chessboard bounds** | Uniform-in-volume suppression of large fields (Aronow–Lopatto use it; note 11 §2.2). Infrared bounds prove *order*; this is the engine of O1 | Tool for Track D and for E2's bad-block control. Record in E5 that RP and chessboards cannot alone give a gap *lower* bound |
| **Fröhlich–Spencer multiscale** (KT 1981; 4D U(1) 1982), Göpfert–Mack, Brydges–Federbush | The only rigorous IR analyses of defect gases with screening | Prerequisite toolkit for E3d and for rigorous versions of F1, F5 and O2. Formalize Göpfert–Mack only if E3d is funded |
| **Multiscale Bakry–Émery / Polchinski-flow LSI** (Bauerschmidt–Bodineau; Bauerschmidt–Dagallier; the hierarchical sinh-Gordon gap of Abdelghani–Bauerschmidt–Hofstetter–Zeitouni; the Piazza–Shen 2D two-scale disintegration; notes 06, 07, 11) | The clearest dynamical lead toward a gap; not gauge-covariant yet | Primary Tier-3 L2 candidate. First target: a gauge-covariant 2D lattice gauge theory version, all β, reproducing Piazza–Shen by the multiscale route |
| **Large N** | Rigorous only at strong 't Hooft coupling. Gross–Witten and bulk transitions separate it from the continuum. Clay needs every G (note 09 §2.4) | No dedicated group. Impose uniform-in-N checks on E2 bounds. Use master-loop and certified bootstrap bounds as L2 *a priori* inputs. Twisted Eguchi–Kawai (Gonzalez-Arroyo–Okawa) is a conceptual N=∞ continuity mechanism only (low) |
| **Step scaling / finite-volume running coupling** (Schrödinger functional; gradient-flow coupling; note 08 [86–88]) | A non-perturbative, gauge-invariant *coordinate* along the crossover | Use as the crossover coordinate in the E1.C lab. A finite-volume crossover statement is a possible E2-int variant |
| **Fixed-point (perfect) actions** (Hasenfratz–Niedermayer 1994) | Keep blocked actions in a parametrized family | Consider for E2 matching; needs a universality lemma (C14) |
| **Certified bootstrap** (Kazakov–Zheng; note 07 §2.12) | Rigorous fixed-β numbers inside the scaling window if certified | Sanity anchors and oracle, not a gap route. Share the Lean SDP certificate checker with E1.B |
| **OpenAI's IR control** | Unknown until release | Write E2-int's (H_UV) and (H_X) so they can take OpenAI's released statements as `Published…` hypotheses (C12) |

---

## 6. Proposed Track E portfolio (replacement text) with kill criteria

**Budget.** Track E ≤ 10% of tokens until one Tier-2 milestone lands. Tier 0 is charged to Track B because it is infrastructure. Two triggers raise the share to 15–25%, following the NS precedent of concentrating after Euler cracked (note 03 §4.2):
- a Tier-2 success;
- an OpenAI release with explicit uniform IR estimates at $O(1)$ coupling.

**Human.** One Track-E referee drawn from probability or constructive QFT (lattice gauge theory, LSI, RG). Track E is where taste matters most (P10).

**Tier 0: foundations (Phases 0–1; no kill; capped at about 2% of tokens).**
- E0.1: replays (`lgt`, `markov-semigroups` audit, `ClassicalON`).
- E0.2: frozen gap-ladder statements and scope notes (C6).
- E0.3: the bridge lemma `UniformRenormalizedClustering ⇒ HasMassGap` (C6).
- E0.4: negative tests and the O1 reduction (C7, C9).
- E0.5: cheap wins (`lgt`→SU(N), Chatterjee 2021, the DF/CNS reduction, Chatterjee 2026) (C7).

**Tier 1: calibration rungs ("Euler" for the gap; Phases 1–2; about 4%).**

| ID | Deliverable | Kill / downgrade criterion (measurable) |
|---|---|---|
| E1.A | Family 215: statement audit, replay, mechanism memo, frustrated-O(4) test of O2 | Downgrade the DF line to "annealed only" if the replay fails or the statement is loophole-ridden; or if the memo shows essential use of Ginibre/FKG/Ising embedding; or if numerics confirm KT behaviour in XY-reducing environments |
| E1.B | Computer-assisted calibration: (i) EKR 2x1 basin for 2D Ising pushed beyond 0.12; (ii) 4D/3D SU(2) all-volume thresholds beyond SZZ 0.083 / CNS 0.167 (β_LQCD), certified by kernel-checked rational certificates | **Kill E2-cal** if (i) fails to exceed β=0.2 (beyond the optimized cluster expansion's 0.151) within 10⁸ tokens; or (ii) gives less than a 2× improvement; or kernel-checking one certificate takes more than about 10³ CPU-hours |
| E1.C | Falsification lab (heuristic-tagged): (a) Chatterjee strong gap under *adversarially optimized* cube boundary conditions, 4D SU(2), β_LQCD ∈ [1, 2.6]; (b) blocked-action Gibbsianness diagnostics and effective slab ordering; (c) lattice KKN/Nair inequality by 2+1 Kogut–Susskind exact diagonalization; (d) a numerical check of the O1 threshold | **Retire the strong-gap interface** if (a) shows non-uniform decay. Then the L3 terminal must use bulk-only criteria. Retire the KKN line if (c) is violated on small lattices |

**Tier 2: milestone theorems (Phases 2–4; entry by gate).**

| ID | Deliverable | Gate / kill |
|---|---|---|
| E2.A | **Lattice twisted-island theorem** (C5, E3a). Weak-coupling clustering, uniform in β and volume | Start in Phase 1. Kill if, after 3 cycles, no polymer decomposition handles the vortex/large-field sectors, or if numerics contradict the $c/(Nn)$ rate |
| E2.B | Twisted $T^3_L\times\mathbb R$ continuum gap (E3b) | Enters when M6 lands |
| E2.C | Continuum $\mathbb R^2\times T^2$ island (E3c) | Enters when M5 and Track D step 1 land |
| E2.D | M8a for 3D SU(2) at one β above the all-volume cap, via a cube-restricted certificate (Martinelli 1998) | Enters only if E1.B passes |

**Tier 3: moonshots (≤ 3% per quarter; red-teamed).**
- E3.A: the L2 crossover lemma, in 3D then 4D. Approaches: multiscale Bakry–Émery made gauge-covariant, rigorous tensor RG, a finite-volume step-scaling formulation, and master-loop *a priori* bounds.
- E3.B: annealed DF.
- E3.C: center-stabilized $\mathbb R^3\times S^1$, after a rigorous 3D Georgi–Glashow result.
- E3.D: continuity, obstruction work only.

**Entry gate for any Tier-3 proof budget.** A candidate needs:
- a frozen interface `Prop`;
- a completed filter table F1–F8;
- an obstruction-ledger check;
- a failed numerical falsification attempt;
- critic sign-off.

**E5: obstruction ledger (cross-cutting, updated every cycle).**

| # | Obstruction | Status |
|---|---|---|
| O1 | All-volume criteria capped in 4D (3D O(4) slab) | [I]; rigorous up to the constant |
| O2 | Environment-uniform DF fails in 3D (XY-reducing environments) | [I/H] |
| O3 | Single-scale Bakry–Émery capped at the 't Hooft regime | [T]; note 07 §4 |
| O4 | The step that fails for U(1) must be identified; for an RG crossover it is the crossover itself | Ito–Seiler |
| O5 | Banks–Zaks: b₀>0 is insufficient | [H] |
| O6 | Bulk/Gross–Witten transitions block analytic continuation from strong coupling for N≥5 / N=∞ | [H/T] |
| O7 | No generic finite-size gap test for quantum Hamiltonians | [T]; Cubitt–Pérez-García–Wolf |
| O8 | RP and convexity give only upper bounds on masses | [T] |
| O9 | Renormalized measures may be non-Gibbsian | [T]; van Enter–Fernández–Sokal |
| O10 | Orland's flat directions defeat 4D orbit-space geometry | [T-pre] |
| O11 | No continuity method outside convergent-expansion domains | [I] |

**AI orchestration specific to Track E (from notes 03 and 04).**
- **Groups by interface, not by mechanism.** Use groups of 4–8 agents with these roles:
  - constructor;
  - estimator;
  - **falsifier**, who runs numerics, including evolutionary search for adversarial boundary conditions and environments. The evaluator must be an independent estimator; heed Georgiev–Gómez-Serrano–Tao–Wagner's warning about evaluator exploitation;
  - **obstruction prover**, the Constantin–Ignatova–Vicol role (note 03 §6, item 1);
  - formalizer.
- **Few strong long-horizon agents instead of large swarms.** Brown credits multi-agent organization with less than 10% of the NS success; base-model strength dominates (note 03 P11).
- **Swarm-style search with rigorous evaluators** is the right tool for E1.B. The objective is certified basin size or threshold; the evaluator is interval code.
- **Adopt OpenAI's repository discipline.**
  - `ClassicalON`'s quantifier template;
  - per-statement scope notes;
  - `Published…` hypotheses for conditional chains (for example `OpenAIExistence → H_X → HasMassGap`);
  - the PrimeGaps186 honest-axiom pattern for numerics, never reaching M0;
  - `--paranoid` replays.
- **Avoid the family-215 anti-pattern.** Never attach a "mass gap" label to a lattice-only, island or finite-volume result (note 04 §1 item 5).
- **The insight ledger carries the obstruction ledger and the filter matrix**, so refuted ideas propagate across groups (P4).

---

## 7. Drop-in text replacements for PLAN.md

1. **§0 item 4:**

   > "The mass gap is not claimed by OpenAI or the committee, and we do not know whether it was attempted. It needs new mathematics (Jaffe–Witten). We treat it as a research bet."

2. **§1 table, M8 row:** replace it with three rows.

   | Rung | Formal target | Status | Role |
   |---|---|---|---|
   | M8a | 3D SU(2) lattice gauge theory: cube-uniform clustering with rate ≥ c/β for β ≥ β₀ | to state | 3D lattice proving ground |
   | M8b | YM₃ on ℝ³: OS axioms (cf. the Sussman–Alpöge claims) | to state | prerequisite for M8c |
   | M8c | 3D continuum gap | to state | 3D proving ground |

   Also add a row **"E-ladder (E0.2): LatticeClustering, StrongGap, CubeStrongMixing, SlabUniformDecay, ScalingGap, island statements: to state; interfaces for Track E."**

3. **§2 Track E:** replace the filter list with F1–F8 (C9), and replace the E1–E5 table with the tiers of §6, together with the revised E1–E4 rows of C1, C3, C4 and C5.

4. **§4 phase table, last row:**

   > "∞ | parallel | Tier 0 in Phases 0–1 (Track B budget); Tier 1 in Phases 1–2; Tier 2 gated on M5/M6; Tier 3 ≤ 3% per quarter | kill criteria per §6 table, evaluated per cycle, not monthly."

5. **§5 risks, add:**

   | Risk | Mitigation |
   |---|---|
   | Gap work Goodharts on Lean line counts | E-specific metrics (C11) |
   | Computer-assisted bounds cannot pass the 3-axiom gate | Certificate architecture (C8) |
   | A plausible but false reduction is pursued (e.g. uniform DF) | Obstruction ledger plus falsification lab before proof budget |

6. **§6 decisions for Peter, add:** whether Track E may import OpenAI's released *statements* as hypotheses now, and read their IR estimates after release (C12).

7. **§7 next actions, add:**
   - Replay `lgt` and `ClassicalON` under `--paranoid`.
   - Freeze `LatticeClustering`/`StrongGap`/`ScalingGap`.
   - Write the O1 reduction lemma.
   - Start the E1.C numerics for O1/O2 and adversarial strong-gap tests.

---

## 8. Claims in this critique that must be verified before they are relied on

- **O1.** The exact conditional-measure reduction is elementary. The rigorous ordering threshold of the 3D O(4) model (FSS constant) still needs computing. β_c≈0.936 is quoted secondhand [M].
- **O2.** KT behaviour of the frustrated O(4) slab model is heuristic. A rigorous proof would need a Fröhlich–Spencer-type argument with massive extra modes. Also check whether the obstruction is folklore, for example why Chatterjee's strong gap is cube-based.
- **E3a feasibility** is my assessment from the Tanizaki–Ünsal tree-level gap and the BBIJ template [I]. Two specific issues remain to check: gauge fixing around the twisted vacuum, and the treatment of vortices as large-field polymers.
- **Martinelli 1998 for continuous compact spins** (the abstract says "compact spin space"), and its equivalence statements for regular volumes.
- **Lattice numbers [M].** SU(2) $a\sqrt\sigma$ at β≈2.4; $m_{0^{++}}/\sqrt\sigma\approx3.7$; the HOTRG cost exponent; van Baal's twisted-box details; Fröhlich–Pizzo's applicability to unbounded on-site terms.
- **Renormalization of the double-trace Polyakov-loop deformation** [I].

---

## References (beyond those already in notes 05–11)

- Ebel, Kennedy, Rychkov, *Tensor Renormalization Group Meets Computer Assistance*, arXiv:2506.03247 (v2, 22 Jun 2026). Fetched and read: Ising certified for β ≤ 0.12 (β_c ≈ 0.44); optimized cluster expansion 0.151; interval arithmetic; 63 sectors.
- Kennedy, Rychkov, J. Stat. Phys. 187 (2022) 33, arXiv:2107.11464; Ann. Henri Poincaré 25 (2024) 773, arXiv:2210.06669. Ebel, Ann. Henri Poincaré (2024), arXiv:2401.04229. All via the EKR reference list.
- Dobrushin, Kolafa, Shlosman, *Phase diagram of the two-dimensional Ising antiferromagnet (computer-assisted proof)*, CMP 102 (1985) 89–103 (via the EKR reference list).
- Dobrushin, Shlosman, *Completely analytical Gibbs fields* (1985); *Completely analytical interactions: constructive description*, J. Stat. Phys. 46 (1987) 983 (via the EKR reference list; note 07 [27]).
- F. Martinelli, *An elementary approach to finite size conditions for the exponential decay of covariances in lattice spin models*, mp_arc 98-545 (1998). Abstract fetched.
- Martinelli, Olivieri, CMP 161 (1994) 447 and 487 [M]. Stroock, Zegarlinski, CMP 144 (1992) 303; JFA 104 (1992) 299 [M].
- van Enter, Fernández, Sokal, J. Stat. Phys. 72 (1993) 879 [M].
- Fröhlich, Simon, Spencer, CMP 50 (1976) 79 [M]. Fröhlich, Israel, Lieb, Simon, CMP 62 (1978) 1 [M]. Fröhlich, Spencer, CMP 81 (1981) 527 [M].
- Cubitt, Pérez-García, Wolf, *Undecidability of the spectral gap*, Nature 528 (2015) 207 [M].
- Tanizaki, Ünsal, arXiv:2201.06166. Library PDF; §2.2 "perturbative fluctuations are completely gapped", mass formula (2.19).
- M. Grady, arXiv:1104.3331 (2011). Abstract fetched; O(4) layer mapping; bulk-transition claim [D].
- Kogut, Susskind, PRD 11 (1975) 395 [M]. Bravyi, Hastings, Michalakis, J. Math. Phys. 51 (2010) 093512 [M]. Banks, Zaks, NPB 196 (1982) 189 [M]. Hasenfratz, Niedermayer, NPB 414 (1994) 785 [M]. Gonzalez-Arroyo, Okawa, PRD 27 (1983) 2397 [M]. Simon, Ann. IHP 38 (1983) 295 [M]. Kanaya, Kaya, PRD 51 (1995) 2404 (value as quoted by Grady).
