# Review of PLAN.md v0.1: the constructive-QFT route to existence (Tracks C and D)

*Reviewer lens: constructive QFT and the mathematical route to existence. Date: 2026-11-05.*

**What I read.**
- In full: `plan/PLAN.md`, `PROBLEM.md`, `README.md`, notes 05 and 08.
- The relevant sections of notes 01, 02, 06, 07, 09, 11 and 99, plus the calibration data in notes 03 and 04.
- The frozen statement files `lean/YangMills/YangMills/{Statement,Lattice,OS}.lean`.
- Online, today: the Sussman–Alpöge repository README and the README of its "RP O(d) trick (RP1)" folder.

**Tags.**
- [N05 §x]: a library note and its section.
- [A]: my own analysis. I checked it for internal consistency only; nobody has refereed it.
- [M]: a reference I cite from memory. Check its metadata before it goes into `references.bib`.

---

## 0. Verdict

**Track C** (the Balaban backbone) is the right choice.
- Its first four items are sound.
- C5–C6 squeeze the genuinely new mathematics into three bullets. That mathematics is:
  - composite-operator sources carried through infinitely many marginal scales;
  - the bridge from effective actions to the observables that Lean actually tests;
  - convergence that includes large fields.
- The ladder spends its second-largest block (M4, the full YM₃ continuum limit) on a rung that does not exercise the 4D-specific difficulty, which is the marginal running coupling.

**Track D**, as written, does not prove the frozen M7, for three reasons.
1. Its ergodic-decomposition step produces Schwinger functions that are not Wilson limits *as `IsWilsonLimit` is formalized*.
2. Its O(4) step is sensitive to the infrared. The only public candidate mechanism, the Sussman–Alpöge RPM1 theorem, has hypotheses that our limits are not known to satisfy.
3. Steps 2–3 take the infinite-volume limit of the wrong object.

**The premise does not cover our statement.** "OpenAI's existence proof is correct" does not imply that *our* `SUNExists` is provable without new infrared mathematics. That statement bundles:
- pointwise clustering;
- full O(4) covariance;
- periodic-torus identification of the *same* state;
- 21-channel field content;
- two-loop asymptotic scaling.

**The fix is mostly re-cutting.**
- Separate the clauses an ultraviolet analysis plus compactness can deliver from the two genuinely infrared clauses, O(4) and cluster.
- Gate the final form of M7 on the A4 statement comparison.
- Add a T³_ℓ×ℝ rung.
- Replace M4 with a 4D bounded-field rung.

---

## 1. Direct answers to the questions asked

**Is C1–C6 the right decomposition?**
- C1–C3 are right, with two corrections:
  - C3 must be two-loop, because `SUNExists` hard-codes two-loop scaling.
  - C3 cannot start before CMP 95–102 are blueprinted.
- C5 and C6 are under-decomposed. They are missing:
  - the composite-operator flow of the four O(4) channels;
  - the ℝ operation (Balaban's large-field renormalization) for source terms;
  - the E0′ short-distance bounds;
  - a perturbative workstream that supplies coefficients.
- O(4) restoration sits in the wrong rung: on T⁴ it is meaningless beyond short distances.
- "Cauchy-in-N" is stronger than M0 needs, because subsequential limits are allowed.

**Is the Track D hypothesis sound?**
- Step 1 is sound only in the form "local bounds uniform in the torus size". That form is an unchecked property of Balaban's estimates; it is open question 3 of [N05 §6].
- Step 2 overclaims. The effective theory at ℓ₀ is neither local nor RP in the Osterwalder–Seiler sense.
- Step 3 is right only if it is applied to the *fine* Wilson measure. "Commute" is false without uniqueness; what you actually get is a diagonal subsequence, and that is all `IsWilsonLimit` needs.
- Step 4 has four gaps:
  - it needs a measure space, and none is specified;
  - it preserves RP, but only under a specific conditioning argument;
  - it does not preserve `IsWilsonLimit`;
  - it needs O(4) *first*.
- Details are in C-1 to C-4.

**What are the real obstacles?**
1. O(4) at distances ≳ ℓ₀.
2. Vacuum uniqueness for the periodic-torus limit.
3. Volume-uniform locality of Balaban's large-field and ℝ-operation estimates.
4. Composite-operator renormalization of dimension-4 sources through all scales.

Large-field regions in infinite volume are *not* an obstacle in themselves. They have positive density but small activity, and a volume-uniform polymer gas handles them, provided obstacle 3 holds.

**Do `ShortDistanceAF` and `FullFieldContent` follow from perturbative dominance?**
- Yes in principle [A]. Both are short-distance statements. With volume-uniform local UV bounds, a crude infrared bound from the compactness of G suffices, and one-loop running is enough for the leading term.
- They need machinery the plan does not budget:
  - a composite-operator RG for each channel;
  - a perturbative computation of the leading kernels and anomalous dimensions;
  - for `FullFieldContent`, the observation that tree-level conformality makes the leading 21×21 kernel block-diagonal. "Four channels" is not literally enough for "every v".
- Details are in C-6.

**Are there better orders or alternative routes?**
- Use gradient-flow observables as an intermediate layer.
- Adopt Dimock-style staging: bounded fields first.
- Write every RG step as a BBS-style contract.
- Try chessboard/RP large-field control (Aronow–Lopatto) as an alternative to the ℝ operation.
- Do **not** use MRS, phase cell or stochastic quantization as the main 4D route. Each has narrower uses, listed in C-15.

**What is the right first rung after M2/M3?**
- Not M4 as defined.
- The first rung should be **M4★: the 4D small-field (bounded-field) multiscale RG on T⁴, carrying the running coupling and a Θ-source**. Its acceptance tests are two-loop scaling and the ⟨ΘΘ⟩ fingerprint inside the bounded-field model.
- Run a cheap 4D Gaussian composite-field calibration (M3½) beside it. See C-8.

---

## 2. Criticisms, in priority order

### C-1 [Critical] Track D's ergodic-decomposition route cannot prove the frozen M7, and the premise does not cover M7

**The problem.** `IsYangMillsTheoryAlong` demands two things of the **same** `S` [Statement.lean, Lattice.lean]:
- `OS.Cluster`, which is pointwise spatial clustering;
- `IsWilsonLimit`, which says S is the limit of **periodic-torus** Wilson Schwinger functions with Haar measure.

Limits of periodic tori are translation-invariant **mixtures**. If the vacuum is not unique, S fails `Cluster`. Its ergodic components may satisfy `Cluster`, but nothing makes a component a periodic-torus limit: no conditioning or boundary condition is allowed in `IsWilsonLimit`, and the torus size cannot select a pure phase. Low-temperature Ising illustrates this: every periodic subsequence gives ½(μ⁺+μ⁻).

So D4 "shows RP, covariance, NonTrivial, FullFieldContent and ShortDistanceAF survive for almost every component". It silently drops the one clause that pins the theory down as Yang–Mills.

The Alpöge–Sussman target that the plan cites as "this shape" is stated *for an ergodic component* ("an ergodic component of a volume-first subsequential … limit", [N05 §3.9]). It is therefore strictly weaker than our M7 on identification. It is also weaker on field content, since it covers the action density only, and it is marked "remains unproved".

**Why it matters.** Under the frozen statement, M7 is equivalent to proving vacuum uniqueness for the periodic-torus limit. No gapless method for this is known:
- Jaffe–Witten say the strong route "seems to need a mass gap or at least uniform decay" [N05 §5.1(b)].
- Uniqueness of large-β Gibbs states for SU(2) in d ≥ 3 is open even without a gap [N07 §6, Q6].

The premise guarantees only that *OpenAI's* (unreleased) statement is provable. Whether that statement contains E4, full O(4) and periodic-torus identification of the same state is exactly what A4 will reveal.

**Revision.**
- Replace §0 item 2's conclusion with: "OpenAI reached infinite volume without a gap; *which* infinite-volume clauses their theorem contains (E4? O(4)? identification of the same state?) is unknown until A4. Our M7 as frozen may be strictly stronger."
- Re-cut M7 into three rungs:
  - **M7a**: everything except O(4) and cluster;
  - **M7b**: adds O(4);
  - **M7c**: adds cluster.
- Make A4 a **gate** for freezing M7c's final form. Pick one of two options, and record whichever is chosen in `PROBLEM.md §5`:
  - (i) keep `Cluster ∧ IsWilsonLimit` and treat M7c as research-level infrared work, on par with Track E;
  - (ii) freeze a red-teamed variant, `IsWilsonComponent`: S is the Schwinger function of an ergodic component, in a *specified* decomposition, of a Wilson limit. Record it explicitly as a weakening of v0.2, and red-team it for cherry-picking loopholes.

### C-2 [Critical] O(4) restoration is misplaced, under-specified and infrared-sensitive

**Misplaced.** C6 puts O(4) restoration on T⁴ ("dimension ≥ 6 terms vanish up to logarithms"). A torus has no O(4). What *can* be proved there, from the ultraviolet analysis alone, is O(4) covariance **asymptotically at short distances** (separations ≪ ℓ₀, where g is small).

**Infrared-sensitive** [A]. At separations ≳ ℓ₀, correlations are fixed by the strongly coupled effective lattice theory at spacing ℓ₀. Two ingredients are needed:
- UV universality: rotated and unrotated lattices give the same continuum specification at scale ℓ.
- A selection or uniqueness argument for the infinite-volume state.

UV universality is itself hard. Balaban's averaging is tied to the lattice, so a rotated fine lattice cannot be blocked onto an unrotated coarse one.

Precedent supports this. Gubinelli–Hofmanová's lattice Φ⁴₃ limit points lack rotation invariance. It arrived only via uniqueness at small coupling (Duch–Hairer–Yi–Zhao), and it remains open at large coupling [N08 §2.1, lesson 2]. In every gapless lattice construction we have (U(1)₃, U(1)₄), O(4) came from *identifying* the limit explicitly, not from a soft argument [N05 §3.7].

**The RP trick does not apply as stated.** RPM1's Theorem A (Sussman–Alpöge repository, RP1 README, fetched today) assumes three things of a *random distribution* μ on 𝒮′:
1. a moment bound ∫e^{F(χ)}dμ ≤ e^{C(‖χ‖₁+‖χ‖₂²)};
2. translation invariance;
3. RP across every hyperplane x_j=0 and x_j±x_k=0, together with their translates.

It concludes O(d) invariance. Our setting fails on three counts:
- **(a) The moment bound fails.** Dimension-4 composites in 4D violate this OS1-type bound: the kernel |x|⁻⁸ is not locally integrable [N01, summary]. Smeared tr F² is not even a random variable with finite variance, so μ does not exist for M0's fields.
- **(b) Diagonal RP is not inherited [A].** On the periodic torus (ℤ/M)⁴, the swap x₀↔x₁ fixes {x₀=x₁} pointwise. It maps the second separating set {x₀−x₁ ≡ M/2} to itself by a shift, not pointwise. As far as I can see, the standard periodic-torus RP proof therefore does not cover diagonal reflections. Diagonal RP of a periodic-torus limit then needs an infrared input of its own, such as uniqueness, or agreement with limits taken from symmetric free-boundary or diagonally periodic volumes.
- **(c) A sanity filter must be passed.** Any such theorem must not prove the open large-coupling rotation invariance of Gubinelli–Hofmanová Φ⁴₃ limits without also using diagonal RP that those limits are not known to have.

There is also a counter-model for coordinate RP alone [A]. The Gaussian field with covariance Ĉ(k)=∏ⱼ(kⱼ²+1)⁻¹ is translation-invariant, hypercubic and RP across coordinate planes, but not rotation-invariant. It fails diagonal RP, because its diagonal "transfer function" oscillates. This is consistent with RPM1 needing diagonal planes, and it shows how much weight (b) carries.

**O(4) must come before cluster.** In the Lean form, `Cluster` translates B *spatially*. In the reconstructed theory, S(ΘA*·T_{λa}B) = ⟨AΩ, e^{iλa·P}BΩ⟩. Its convergence needs the spectral measure of P on Ω⊥ to have Fourier transform vanishing at infinity. Vacuum uniqueness alone does not give this; with Lorentz covariance, the spectrum condition plus Riemann–Lebesgue (Araki–Hepp–Ruelle) does [N01, Prop. C]. So M7c presupposes M7b.

**Revision.**
- Delete the O(4) bullet from C6. Put "asymptotic O(4) covariance at short distances" into M6/M7a.
- Make **M7b (O(4) on ℝ⁴)** its own rung with its own risk entry.
- Add task **D-RP (week 0–4)**: a structural read of RPM1/RP1O1, including:
  - where diagonal RP comes from in their 3D setting;
  - which field the moment bound is applied to;
  - tests on the product-covariance Gaussian and on Φ⁴₃.
  Note 11 §8 Q2 already recommends this audit, and the plan omits it.
- List the candidate routes explicitly and kill or continue each monthly, as in E5:
  1. UV universality plus uniqueness;
  2. an RP mechanism whose hypotheses are actually inherited;
  3. Ward identities for a renormalized symmetric stress tensor. The Caracciolo–Curci–Menotti–Pelissetto lattice EMT approach [M] is an example. Its integrated insertion is itself infrared-sensitive.
  4. whatever A4 reveals.

### C-3 [Critical] Track D steps 2–3 take the infinite-volume limit of the wrong object, and "commute" is false

**The effective theory is not local, Gibbsian or RP.**
- The effective theory at ℓ₀ is a positive marginal density, represented as a sum over large/small-field histories.
- It is not "a local, gauge-invariant, reflection-positive effective *action*".
- Its interactions crossing a reflection plane are not of the Osterwalder–Seiler form A + ΘA + Σ CᵢΘCᵢ. RP holds for the *measure*, inherited from the fine measure, for planes between blocks and for a reflection-covariant averaging map. It does not hold for the action.
- Block-spin images of Gibbs measures can be **non-Gibbsian**: van Enter–Fernández–Sokal, J. Stat. Phys. 72 (1993) 879 [M]. "DLR Gibbs states of the effective theory" may therefore not even be defined.

**The limits do not commute.** "Continuum limits commute with the volume limit because the UV bounds are uniform" would require a unique limit. Uniform bounds give tightness and diagonal subsequences, and that is exactly what `IsWilsonLimit` allows: the prover chooses a_k, L_k, β_k and Z_k jointly [Lattice.lean].

**Revision.** Replace steps 1–3 with:

> D0 (volume-uniform locality). Prove that for every observable supported in a bounded region, the RG from ε to ℓ₀ gives bounds that are uniform in ε **and in the torus size**. The bounds cover the generating function of the vacuum-subtracted composite fields, analytic in sources on a polydisc of ε- and L-independent radius.
>
> The integral over the coarse field at ℓ₀ is never expanded. Effective observables there are local functions on the compact space G^{links}, so crude sup-norm bounds suffice.
>
> D1. At each ε, infinite-volume limit points of the **fine** periodic Wilson measures exist by compactness of G^{links}. They are translation-invariant Gibbs states for the Wilson specification and RP for lattice hyperplanes.
>
> A diagonal subsequence (a_k, L_k, β_k, Z_k) then gives ℝ⁴ Schwinger functions satisfying E0′, Real, Symmetric, RP and hypercubic covariance, plus all UV clauses (C-6). This is rung **M7a**. It makes no claim about commuting limits or uniqueness.

**Make D0 explicit and early.** It is note 05's open question 3 ("does the ℝ operation localize?") and the prerequisite for everything in Track D. Its proof must check that Balaban's constants E± and polymer bounds do not depend on the torus exponent M. Its formulation is the D0 statement above.

### C-4 [High] Ergodic decomposition needs a state space, a σ-algebra, an RP argument and a field-recovery argument; the plan specifies none of them

**There is no measure to decompose.** The M0 fields cannot carry the decomposition. Schwinger functions at disjoint supports are *not* moments of a random field: the variance of smeared Θ diverges as a⁻⁴. A measure is needed on a space where the regulated observables are honest random variables. Two candidates:
- the projective system of Balaban block fields at the L-adic scales ℓ₀L^{−m}, which lives on compact spaces and is consistent because averaging composes;
- the law of flowed fields at flow times t > 0.

**RP is preserved, by a specific argument** [A; standard in spirit, cf. Glimm–Jaffe Ch. 19 and Fröhlich, BAMS 1978, both M]. Let I be the σ-algebra of time-translation-invariant events.
- By invariance, I lies (mod null sets) in both the future and the past tail σ-algebras. Θ maps I to itself.
- RP gives ⟨f∘Θ, f⟩ ≥ 0 for every f ∈ L²(I). The involution f ↦ f∘Θ therefore has no −1 eigenvectors, so Θ acts trivially on I.
- Hence, for A ∈ I and F future-measurable, E[1_A·Θ(F̄)·F] = E[Θ(1_A F̄)·(1_A F)] ≥ 0.

So conditioning on I, or on any sub-σ-algebra such as the ℝ⁴-invariant one, preserves RP.

**Covariance is not automatically preserved.** Time-ergodic components need not be spatially translation-invariant or rotation-invariant. Everything below depends on O(4) of the mixture first:
- With O(4) of the mixture, the spectrum condition H ≥ |P| applies.
- The OS map is isometric on I-measurable functions (because Θ acts trivially).
- Together these give I_t = I_{ℝ⁴}, so components are translation-invariant and RP for every hyperplane.
- Their own O(4) then needs a separate lemma ("RP across all hyperplanes plus translation invariance ⇒ O(4)").

Decomposition therefore does not sidestep C-2; it presupposes it. The Wightman-level literature warns too: extremal decompositions need not have unique vacua and need not be unique (Borchers–Yngvason 1975; Hegerfeldt, CMP 45 (1975) [M]).

**Field recovery per component has a workable mechanism** [A].
- Regulate first, with flow time t or block scale. Condition. Then remove the regulator.
- Component fluctuations of a regulated short-distance observable X are controlled by the Cesàro-averaged *long-range* covariance lim_R avg_{|a|<R} Cov(X, X∘T_a).
- The near-diagonal UV singularity carries relative weight → 0 as R → ∞, so it does not contribute.
- The long-range part is bounded by blocked (bounded) observables at ℓ₀.
- With summable bounds along λ_n = 2⁻ⁿ and Borel–Cantelli, `NonTrivial`, `ShortDistanceAF` and `FullFieldContent` hold for almost every component.

**E0′ for components** needs measure-level exponential-moment bounds, with constants that may depend on the component.

**Revision.** Rewrite D4 as:

> D4 (only if A4 or C-1(ii) selects the component formulation). State space: the projective system of block fields, or flowed fields.
>
> Decompose with respect to I_{ℝ⁴}, after M7b. Prove:
> - (i) RP of components via the Θ-triviality lemma;
> - (ii) translation invariance and all-hyperplane RP of components;
> - (iii) O(4) of components;
> - (iv) component-wise recovery of local-field Schwinger functions by regulate–condition–remove;
> - (v) UV clauses for almost every component via long-range-covariance bounds;
> - (vi) E0′ for components.

### C-5 [High] C5 ("UV stability with sources") underestimates composite-operator renormalization

**The sources are not small.** The M0 fields are `latticeT`, products of clover field strengths at one site. The renormalization Z_k diverges like a⁻⁴g₀⁻² times logs [Lattice.lean docstring], and there is an ε⁻⁴-size vacuum subtraction. The four O(4) channels flow differently [A]:
- **Θ (trace anomaly).** ∫JΘ = −2b₀ Σ_p J(x_p) Re tr(1−U_p) + …: an O(J) *position-dependent shift of 1/g₀²*, i.e. a local change of Λ. C5a is therefore an **inhomogeneous-coupling** version of C3. This is a pleasant structural point: it ties the Θ-source to the coupling flow.
- **Traceless T_μν.** The source is a metric/anisotropy deformation: an O(h) relative change of directional plaquette couplings, which Karsch-type anisotropy renormalization covers [M]. Hypercubic sub-irreps (6 + 3) carry separate finite Z's, which must be tuned for asymptotic O(4).
- **(2,0)⊕(0,2).** A genuine composite flow with a non-zero one-loop anomalous dimension. It is *not* a deformation of the action.
- **tr FF̃.** The topological density: finite multiplicative renormalization; contact terms are irrelevant at disjoint supports.

**Large-field regions are the hard part.** The source term contains the divergent vacuum subtraction. In regions left unintegrated (large fields), crude bounds give e^{O(|J|ε⁻⁴)}. The source term therefore needs its own **ℝ operation**, exactly as the coupling counterterms do in CMP 122 [N05 §3.2, item 7]. "Analytic dependence on sources" does not deliver this by itself.

**Revision.** Replace C5 with:

> C5a: Θ-source = inhomogeneous running coupling (extends C3).
> C5b: T_μν-source = anisotropy/metric deformation, with Ward-identity normalization.
> C5c: (2,0)⊕(0,2) composite flow, with its one-loop anomalous dimension (from the P-track).
> C5d: topological density.
> C5e: ℝ operation for source terms in large-field regions.
> C5f: short-distance bounds with n insertions at arbitrary separations, needed for the E0′ extension across diagonals [N01, CP-16]. Template: Brydges–Dimock–Hurd for φ⁴₃, CMP 172 (1995).

Freeze M5 as the D0-style generating-functional statement. Do **not** freeze it as partition-function stability: Z_N ≤ 1 holds trivially, so that form is vacuous [N05 §5.4].

### C-6 [High] Would `ShortDistanceAF`, `FullFieldContent` and `NonTrivial` follow from perturbative dominance? Yes, but the plan omits the machinery and has no perturbative workstream

**`ShortDistanceAF`** [A].
- The fingerprint is internally consistent. ⟨ΘΘ⟩ ≈ (b₀g²(|x|)/2)²·⟨F_c²F_c²⟩_free gives C/(|x|⁸ log²(1/|x|)). For any fixed normalization of the scalar channel, the log² survives: the x-independent factor (g(μ)/β(g(μ)))² drops out of the asymptotics, so the existential Z_k cannot defeat it.
- One-loop running with relative error o(1) suffices. The per-step remainders are O(g²), and Σ_{j≤k} g_j² = O(log k) = o(k).
- The infrared remainder is O(1) in Λ units. Given D0, effective observables at ℓ₀ are bounded on a compact space. This is negligible against λ⁻⁸/log².
- What is needed:
  - C5a;
  - the leading two-insertion loop at scale |x| in the block scheme, with convergence of the multiscale propagator sum to the continuum |x|⁻⁸ kernel, which carries the precise constant C;
  - D0.

**`FullFieldContent`** [A].
- "Four O(4) channels" is correct for irreducible representations. The clause, however, quantifies over every v in the 21-dimensional space, and an O(4)-covariant two-point function *can* couple a scalar to a symmetric tensor through x_μx_ν.
- The rescue: at tree level, free YM is N²−1 free conformal Maxwell fields. Two-point functions of quasi-primaries in different representations vanish, so the leading reflected 21×21 kernel is block-diagonal and positive in each block.
- Channels then carry different log powers: the scalar ~log⁻², the stress tensor ~log⁰, and so on. A two-point function vanishing identically in direction v must vanish order by order in the log expansion, which forces v = 0.
- Two inputs are needed:
  - the one-loop anomalous dimensions of all four channels;
  - the same free-Maxwell 21×21 computation that M1's `os_nonTrivial_fullField_consistent` needs. Share it.

**`NonTrivial`.** The connected 4-point function of composites at leading order is the one-loop box of free composites, ~g⁸(λ)λ⁻¹⁶, against an O(1) infrared remainder. So `NonTrivial` follows the same way.

**Revision.**
- Add a **P-track (perturbative YM, certified)**, which note 99 action 7 already asks for. It should deliver:
  - b₀ and b₁ in *our* block scheme;
  - one-loop anomalous dimensions of the four channels;
  - the leading kernels and the constant C;
  - the block-diagonality and nondegeneracy check;
  - the trace-anomaly normalization (Collins–Duncan–Joglekar, PRD 16 (1977)).
- Use SymPy/Sage plus Lean-checked lattice Fourier sums.
- It sits on the critical path of C3, C5 and C6, and it also audits the M0 fingerprint (note 01's residual concern 7).

### C-7 [High] `SUNExists` hard-codes two-loop scaling, but C3 plans one loop

**The problem.** `AsymptoticScaling` requires
1/g₀² − 2b₀log(1/a) − (b₁/b₀)log log(1/a) → c [Statement.lean].
The recursion x_{k+1} = x_k + 2b₀log L + 2b₁log L/x_k + O(x_k⁻²) gives x_k = 2b₀k log L + (b₁/b₀)log k + c + o(1) [A].

Two things are therefore required:
- the scheme's g² coefficient equals the universal b₁ (a two-loop computation in a block-spin, background-field, nonlinear-averaging scheme);
- the O(g⁴) remainders per step are summable.

Balaban's announced Theorem 2 gives only two-sided bounds with *unequal* constants β, β′ [N05 §2.4]. C3 as written ("one-loop term … recover b₀") cannot discharge `SUNExists`.

**Revision.** Decide before M7 is frozen.
- **(a)** Add **C3b**: the two-loop coefficient in our scheme, with remainders O(g_k⁴) in Δ(g⁻²).
- **(b)** Or weaken `AsymptoticScaling` to one loop, β/(2N log(1/a)) → 2b₀. Keep the two-loop version as a separate stronger rung.

The current label "the reported scope of OpenAI's claim" is our guess, not a sourced fact [N02 §3]. Do not let it force (a).

### C-8 [High] The ladder is mis-ordered: M4 (full YM₃) is not a warm-up. Here is the right first rung after M2/M3

**Why M4 is not a warm-up.**
- The AI-written YM₃ manuscripts run 1,479 pages (torus only, Aronow–Lopatto) and 2,058 pages (Sussman–Alpöge). OpenAI's entire 4D proof is 1,147 pages [N05 §3.9].
- YM₃ is super-renormalizable. It has no marginal coupling and no coupling renormalization [N05 §2.2], so it does not exercise C3, C5a or the fingerprint, which are the 4D-specific risks.
- The Navier–Stokes analogy fails. Euler took about 100 agents and about 50 hours, against about 10⁴ agents for NS [N03]. A YM₃ rung is comparable in size to the target.
- The plan's "~1% of budget on warm-ups" (P3) is inconsistent with M4.

**Revision.** Make the first rung after M2/M3 **M4★, "4D bounded-field RG on T⁴"**, defined as follows.
- Model: Dimock's staging. Scalar QED₃ was done first in a bounded-field approximation (arXiv 1502.02946, 1512.04373) and only then with full large-field control (2009.01156) [N05 §3.5]. Balaban's own CMP 109 is the small-field step.
- Content: the modified model in which large-field configurations are excluded by characteristic functions. Prove, for all scales:
  - BBS-style single-step contracts, (V,K) ↦ (V₊,K₊) with explicit norms [N08 §4.3];
  - the coupling flow (C3a/b);
  - the Θ-source (C5a).
- Acceptance tests: two-loop scaling (or one-loop, per C-7) and the ⟨ΘΘ⟩ fingerprint *within the model*.
- It is 4D, contains every novel UV ingredient except large fields, and runs in parallel with the large-field work (C-11).
- Parametrize the gauge-geometric modules (CMP 89, 95, 96, 98, 99a, 99b, 102b) by dimension d from day one. YM₃ then becomes a cheap instantiation, not a separate project.

**M3½ (cheap, parallel).** The Gaussian (noncompact) U(1)₄ lattice field converging to free-Maxwell **composite** correlations of all 21 channels, with the diagonal limit a_k → 0, a_kL_k → ∞. It calibrates:
- the Lean definitions of `IsWilsonLimit`-style convergence, the 21-channel Z_k and the vacuum subtraction;
- the infinite-volume limit without a gap, where O(4) and cluster come from explicit identification;
- the canonical **counter-inhabitant of `ShortDistanceAF`**: no log².

It shares its algebra with M1. Compact U(1)₄ (Driver 1987) is a stretch goal.

**Demote M4 to "M4-lite"**: YM₃ UV stability with sources on T³, as a dimension-3 instantiation of the shared modules. Use the AI YM₃ manuscripts only as literature to verify.

**Optional AF rehearsal.** The UV continuum limit of the 2D O(N) σ-model on a small torus (N ≥ 3). It has a marginal AF coupling, a compact nonlinear target and a large/small-field split. Balaban's N-vector series is the human precedent. OpenAI used this model as its own warm-up (family 215; [N02 §2.3 item 5], [N99 action 5]). It rehearses C3/C6 far more cheaply than YM₃.

### C-9 [High] A missing rung: YM on T³_ℓ × ℝ at small ℓ, the first place a genuine Hilbert space, a unique vacuum and a gap appear

**The proposal** [A; the idea is note 05 §5.1(c) and §6 Q7]. For ℓ ≪ Λ⁻¹, the RG from ε to ℓ is perturbative. At scale ℓ the effective theory is a 1D chain whose positive transfer kernel acts on gauge-invariant functions of the spatial holonomies, a compact space. Perron–Frobenius then gives a unique vacuum. A **Doeblin minorization**, uniform in ε, of the two-step kernel gives a uniform transfer-matrix gap:
- small fields: from Balaban's lower density bound χ_k e^{−g⁻²A−E|T|} ≤ ρ_k [N05 §2.4];
- large coarse fields: from small fluctuations around smooth interpolations.

**What this buys.**
- A full OS theory in the time direction (RP, unique vacuum, `HasMassGap`) for a locally 4D nonabelian continuum theory. No rigorous version is known [N05 §5.1(c)].
- D0 is tested in one direction only.
- The A3 bridges (OS reconstruction, gap ⇔ spectrum) are exercised on a real interacting theory.
- It overlaps Track E's E3.

**Revision.** Insert **M6.5: SU(N) YM on T³_ℓ × ℝ, small ℓ: OS in the time direction, unique vacuum, mass gap uniform in the lattice spacing**, between M6 and M7a.

### C-10 [Medium-high] Ordering inside C1/C3, and primary sources

**The problems.**
- "Compute the one-loop term in Balaban's scheme" presupposes the *scheme*. That means the averaging (CMP 98), regular configurations and gauge fixing (CMP 99a), the variational problem (CMP 102b), the propagators (CMP 95, 96, 99b) and the small-field expansion of CMP 109.
- §7 action 4 starts at CMP 109/116/119/122 and skips the foundations that the 2026 AI manuscripts cite as black boxes [N05 §3.3].
- Nobody on the project has read any Balaban primary text [N05 §0], [N99 action 2].
- C3 is "decisive" only for our *understanding*. Universality fixes b₀, so the computation cannot come out differently. The real risks lie in remainders and in defining the coupling inside the nonlinear scheme.

**Revision.**
- Phase 0 starts with **a human download of CMP 89–122 from Project Euclid**, then interface statements for CMP 95–102, then CMP 109.
- Split C3:
  - **C3a**: b₀ and b₁ for constant-curvature and plane-wave backgrounds, symbolic plus interval arithmetic, in weeks;
  - **C3b**: remainder bounds inside the small-field machinery, in months, as part of M4★.
- State explicitly that the scheme is **ours**. Keep Balaban's essentials: gauge-covariant averaging, local gauge fixing only on small fields, none on large fields. Choose the averaging, the soft-versus-sharp constraints and the norms for verifiability. Independence argues for this too.
- Pose the counterterm and coupling problem as Dimock's boundary-value fixed point [N05 §2.5], extended with the BBS non-hyperbolic flow theorem (Ann. H. Poincaré 16 (2015) 1033; [N08 §2.3]).

### C-11 [Medium] Large-field control: evaluate the chessboard/RP alternative, which also gives volume uniformity

**The problem.** The ℝ operation (CMP 122) is the hardest part of Balaban to verify [N05 §3.2 item 7; N11 §4]. Aronow–Lopatto handle the large-field complement in 3D with **reflection positivity and chessboard estimates** [N05 §3.9; N11 §2.2]. Chessboard bounds live on periodic tori and are uniform in the torus size. That is exactly what D0 needs.

**Revision.** Add **C-LF**: a comparison study, in weeks 2–8, of the ℝ operation against chessboard/RP large-field control at the scales of a marginal running coupling. Run it on M4★'s complement.
- Deliverable: a frozen lemma interface that either route can satisfy.
- Fröhlich–Israel–Lieb–Simon 1978 is in the bibliography but barely used [N99 action 3].

### C-12 [Medium] The schedule and the Lean throughput are inconsistent with the deliverables

**The arithmetic.**
- OpenAI's NS formalization is 641k Lean lines for 223 natural-language pages, about 2,900 lines per page [N03].
- The plan's Phase 1 gate is 500 lines per week.
- At that rate, M4 alone (about 1,500 pp) takes decades, and Phase 2 allots it 12 weeks.

**Revision.**
- Set KPIs by size: the target total of lines ÷ weeks available, tracked per blueprint node.
- Make "Lean: interfaces plus novel modules first; shared foundations via Track B" explicit.
- Accept that only M4★, M5 and M6 are Lean-complete before M7.
- Replace the "skeptic pass rate ≥ 70%" gate, which is gameable, with "fraction of frozen nodes closed in Lean with no `sorry`".

### C-13 [Medium] Statement hygiene for intermediate rungs; use conditional milestones the way OpenAI's repositories do

**Revision.**
- Freeze M5 and M6 in non-vacuous form, as in C-5.
- For the early checkable artefacts, adopt the `Published…` hypothesis-structure pattern from `openai/math` [N04]. Example: "M6 conditional on a `BalabanTheorem1` structure", with the coupling-window hypothesis explicit.
- These are **never** top-level Comparator targets. They let C6 work start before C3b/C5e are discharged, and every such hypothesis is tracked in `alignment.yaml`.

### C-14 [Medium] Gauge-group generality is missing from Tracks C and D

**The problem.** `ClayExistence` quantifies over every compact simple G, but Theorem 2 is announced only for SU(2), "superficially" [N05 §2.1].

**Revision.** Add rungs in order: SU(2), then SU(N), then general G. Use b₀ = 11C₂(G)/(48π²) and audit every use of SU(2)-specific facts. `SUNExists` is the realistic target; `ClayExistence` is a later rung.

### C-15 [Medium] Alternative routes: what to adopt and what not

| Route | Verdict | Use |
|---|---|---|
| **Gradient-flow observables** | **Adopt as an intermediate layer.** Flowed E(t,x) at t > 0 is a bounded, smooth, UV-finite functional. Sources then enter at scale √t, not at ε, so no Z_k is needed. | **M6-flow**: continuum limit of flowed correlations on T⁴, with the non-triviality certificate t·d/dt(t²⟨E⟩) ≠ 0 [N08 §2.6, §2.8]. The t → 0 limit to local fields then *is* the composite-operator problem. Caveat: flowed fields are not half-space measurable, so OS/RP must stay on local or sharp lattice fields [N08 §2.8 point 3]. Also the natural state space for C-4. |
| **Dimock style** | **Adopt.** Bounded-field staging, Banach fixed point for counterterms, BBS contracts. | M4★ (C-8), C3 (C-10). |
| **MRS (1993)** | **Not the main route.** Continuum with an IR cutoff, regularized axial gauge, no RP; Jaffe–Witten note that few methods recover RP [N08 §1.1]. | Independent cross-check of perturbative coefficients and Slavnov identities in the P-track. |
| **Federbush phase cell** | **Do not use.** Incomplete, with no modern exposition [N05 §3.7]. | None. |
| **Stochastic quantization** | **Not for 4D construction or universality.** The equation is critical at d = 4 and has no solution theory [N06 §2.9, §4.1]. | M3 (Chevyrev–Shen universality), M4-lite (Cao–Chatterjee state space; note 06 lead 2), the vocabulary of gauge orbits, and Track E's multiscale Bakry–Émery. |
| **Duch's bounded-field Polchinski flow** | Speculative. Link variables are bounded, but plaquettes far from 1 are the large-field problem [N08 §2.2]. | Watch only. |
| **Gauge-covariant FRD (Bauerschmidt's Chebyshev construction for −Δ_U)** | A checkable lead [N08 §2.4, §5 Q1]. | Week-scale feasibility study as an alternative to averaging *inside* small-field regions. |
| **Tensor RG** | Not for existence. | Track E crossover, if anywhere. |

### C-16 [Medium] Apply the Navier–Stokes "obstruction" move to Track D, not only to Track E

**Revision.** Add **D-RT (infrared red team)**. Every Track D argument for E4 or O(4) must fail on:
- low-temperature Ising/φ⁴ periodic limits (½(μ⁺+μ⁻));
- lattice gauge theory at the bulk first-order point of mixed fundamental–adjoint actions (Bhanot–Creutz [M]), where there is phase coexistence;
- the product-covariance Gaussian (for O(4) arguments that use only coordinate RP).

It must also not prove open rotation invariance for large-coupling Φ⁴₃ limits without using hypotheses those limits lack. These are the infrared analogues of note 09's U(1), SO(3) and θ = π filters. They are cheap to encode.

### C-17 [Low] Smaller items

- **Topology on T⁴.** Instanton sectors are absorbed in the large-field analysis. Say so in C5e/C6 [N08 §5 Q8].
- **Flat-connection moduli at the last step.** On T⁴ the final integral is over a compact space, so it is fine. State it, since Lüscher's toron dynamics makes the final step non-Gaussian [N05 §6 Q7].
- **E0′.** This needs extension of S_n across diagonals with Schwartz order linear in n. Make it an explicit C5f/C6 item, not only an A3 "bridge" [N01, CP-16].
- **Track D language.** "Run the RG in infinite volume" should read "uniformly in the torus size". The RG is not defined on ℤ⁴, where extensive quantities are infinite.
- **BCHZ warning.** Cite it in C6: "even in 2D it is unclear how Balaban's effective observables relate to the continuum" [N11 §2.5]. The bridge to observables must be a named module, not an implicit step.

---

## 3. What is excellent and must be kept

1. **The frozen ladder.** It includes adversarial statement review per rung, SHA freeze, Comparator with the three standard axioms, and degenerate witnesses turned into regression tests. This process caught the a = 0 cluster bug, and it is exactly what Track D's restatement (C-1) needs.
2. **The Wilson lattice as the regularization.** RP is exact and passes to the limit [N08 §2.1 lesson 1]. Only gauge-invariant observables are used, and gauge fixing is local and confined to small-field regions, so Gribov/Singer never arises [N08 §2.11].
3. **Isolating Balaban's unpublished Theorem 2** as the concrete published gap, and scheduling it early. Keep C3, upgraded per C-7 and C-10.
4. **Making Track D explicit as a hypothesis, with stated risks.** Its spine (volume-uniform UV bounds up to ℓ₀, then compactness) is right, once it is applied to the fine measure (C-3).
5. **The independence firewall and the statement-level A4 audit.** Under C-1, A4 also becomes the gate that tells us which infrared clauses are achievable without a gap. Comparing statements is allowed through the firewall.
6. **Track B's finite-dimensional infrastructure from day one.** That covers Haar measure, RP and the transfer matrix, polymer expansions, the Banach fixed point, and Gaussian and random-walk expansions.
7. **The honest framing of the mass gap as a portfolio bet,** together with Track E's sanity filters.
8. **`alignment.yaml` and the hypothesis-diff agent.** The Navier–Stokes m+4 versus m+5 mismatch shows why this matters.
9. **Treating the AI YM₃ manuscripts as literature to verify, not to trust.**

---

## 4. Proposed replacement text

### 4.1 Ladder (replaces rows M4–M7 of §1)

| Rung | Formal target | Role |
|---|---|---|
| M3½ | Gaussian U(1)₄ lattice → free-Maxwell composites (21 channels; diagonal volume limit); `¬ShortDistanceAF` regression | Calibrates the observable layer and `IsWilsonLimit`; shares algebra with M1 |
| M4★ | 4D bounded-field RG on T⁴: BBS-contract single step; coupling flow (C3a/b); Θ-source (C5a); two-loop (or one-loop) scaling; ⟨ΘΘ⟩ fingerprint in the model | First rung carrying the marginal-coupling risk |
| M4-lite | YM₃ UV stability with sources on T³ (dimension instantiation of the shared modules) | Gauge geometry; optional |
| M5 | 4D generating functional of vacuum-subtracted composites: analytic in sources on an ε- and L-independent polydisc; full large-field control (C5e; ℝ operation or chessboard, C-11); D0 locality | Core of existence |
| M6 | T⁴: subsequential continuum limit of composite correlations; `NonTrivial`, `FullFieldContent`, `ShortDistanceAF`; E0′ on T⁴; asymptotic O(4) at short distances | Finite volume (Cauchy-in-N optional: M6⁺) |
| M6-flow | Optional side rung: flowed observables on T⁴ (continuum limit; t²⟨E⟩ certificate) | Early publishable 4D result |
| M6.5 | T³_ℓ×ℝ, small ℓ: OS in time, unique vacuum, `HasMassGap` uniform in ε | First genuine Hilbert space and gap |
| M7a | ℝ⁴: all of `IsYangMillsTheoryAlong` except O(4) (hypercubic only) and `Cluster` | Achievable by UV + D0 + compactness |
| M7b | ℝ⁴: plus full O(4) | Infrared risk; route chosen after D-RP and A4 |
| M7c | ℝ⁴: plus `Cluster` (= `SUNExists`), or the A4-gated `IsWilsonComponent` variant | Infrared risk; needs M7b |

### 4.2 Track D (replaces §2 Track D)

> **Track D: infinite volume without a gap.**
>
> - **D0 (volume-uniform locality).** Bounds on generating functionals of local observables, uniform in ε and in the torus size, for the RG from ε to ℓ₀. Includes M-independence of Balaban's constants and localization of the ℝ operation, or of the chessboard alternative.
> - **D1.** Infinite-volume limit points of the **fine** periodic Wilson measures at each ε; a diagonal subsequence gives M7a. No claim about commuting limits or uniqueness.
> - **D-RP.** Audit RPM1/RP1O1. Check the moment-bound and diagonal-RP preconditions against our limits; run the product-Gaussian and Φ⁴₃ tests.
> - **D2 (O(4), M7b).** Candidate routes:
>   1. UV universality plus uniqueness;
>   2. an RP mechanism with inherited hypotheses;
>   3. stress-tensor Ward identities;
>   4. what A4 reveals.
>
>   Kill or continue monthly.
> - **D3 (cluster, M7c).** Either vacuum uniqueness for the periodic limit, or, if A4 / C-1(ii) selects it, the component formulation via C-4 (i)–(vi).
> - **D-RT.** The infrared red team of C-16.
>
> **Risk.** M7b and M7c may need new infrared mathematics. Nothing in the premise guarantees them in *our* form.

### 4.3 Track C (replaces C5–C6; C1–C4 amended per C-8 and C-10)

> - **C5.** Sources and composite operators. C5a: Θ as an inhomogeneous coupling. C5b: T_μν as anisotropy, with Ward normalization. C5c: (2,0)⊕(0,2) composite flow. C5d: topological density. C5e: ℝ operation for source terms. C5f: n-insertion short-distance bounds for E0′.
> - **C6.** Bridge from effective densities to lattice Schwinger functions (the named module that answers BCHZ). Subsequential limits on T⁴. `ShortDistanceAF`, `NonTrivial` and `FullFieldContent` via one-loop dominance plus D0 plus the P-track kernels. Asymptotic O(4) at short distances, including tuning of the hypercubic sub-irrep Z's. Cauchy-in-N, including large-field convergence, moves to M6⁺ (needed only for uniqueness or universality).
> - **P-track** (new, critical path). b₀ and b₁ in our scheme; one-loop anomalous dimensions of the four channels; the leading 21×21 kernel (block-diagonal by tree-level conformality, shared with M1); the constant C; trace-anomaly normalization; Lean-checked symbolic certificates.

### 4.4 Next actions (amends §7)

Change item 3 to:

> Download Balaban CMP 89–122. Blueprint the interfaces of CMP 95–102. Start C3a (b₀ and b₁ in our scheme, symbolic) and the P-track. Freeze the M4★ and M3½ statements.

Add:

> - D-RP (the RPM1 audit) and D0 formulation, weeks 0–4.
> - Decide C-7 (one-loop or two-loop `AsymptoticScaling`) before any M7 freeze.

---

## 5. Sources consulted this session (beyond the library notes)

- Sussman–Alpöge repository, README: [github.com/ethanwsussman/Yang--Mills-LLM-experiment](https://github.com/ethanwsussman/Yang--Mills-LLM-experiment)
- RP O(d) trick folder and the RPM1 Theorem A statement: [RP1 README](https://raw.githubusercontent.com/ethanwsussman/Yang--Mills-LLM-experiment/main/RP%20O(d)%20trick%20(RP1)/README.md)
- On decompositions of Wightman functionals (extremal ≠ unique vacuum; non-uniqueness of decompositions; Hegerfeldt 1975; Borchers–Yngvason 1975; Vasil'ev 1969), via [dml.cz WSAA 1978 survey](https://dml.cz/bitstream/handle/10338.dmlcz/701131/WSAA_06-1978-1_26.pdf)
- Fröhlich, *The pure phases (harmonic functions) of generalized processes*, Bull. AMS 1978: [projecteuclid](https://projecteuclid.org/journals/bulletin-of-the-american-mathematical-society/volume-84/issue-2/The-pure-phases-harmonic-functions-of-generalized-processes-or/bams/1183540509.pdf)
- Fröhlich–Israel–Lieb–Simon, CMP 62 (1978): [doi.org/10.1007/BF01940327](https://doi.org/10.1007/bf01940327)

Cited from memory and to be verified before use, tagged [M] above:
- van Enter–Fernández–Sokal, J. Stat. Phys. 72 (1993);
- Georgii, *Gibbs Measures and Phase Transitions*, Chs. 7 and 14;
- Glimm–Jaffe Ch. 19;
- Caracciolo–Curci–Menotti–Pelissetto (lattice EMT), Ann. Phys. 1990;
- Karsch, Nucl. Phys. B205 (1982);
- Bhanot–Creutz (mixed-action first-order transition).
