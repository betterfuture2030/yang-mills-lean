# 10 — Lean 4 / Mathlib infrastructure for stating and proving 4D Yang–Mills existence

*Workstream key:* `10-lean-mathlib-infrastructure` · *Compiled:* 2026-11-05 · *Scope:* what exists (and what does not) in Mathlib and adjacent Lean projects, as of late 2026, for (i) stating and (ii) eventually proving existence (and mass gap) of 4D quantum Yang–Mills theory with compact simple gauge group.

**Source tags used below.**

- **[Lc]** Declaration name *compiled*: I ran `#check` on it with the local Lean `v4.36.0-rc2` toolchain against the prebuilt oleans of the Mathlib checkout pinned by our project (`lean/YangMills/.lake/packages/mathlib`, commit `9d581dff`, committed 2026-10-27, "bump toolchain to v4.36.0-rc2"). This is the strongest evidence level. Nothing was built or written inside the project; the check file lived in the session scratchpad.
- **[L]** Read directly in that local Mathlib source tree (grep / file docstrings).
- **[G]** Read in primary source on GitHub (raw files, GitHub API trees, PR metadata).
- **[R]** README / self-report of a repository. I read it, but I did **not** build the project, so sorry/axiom counts are the authors' claims.
- **[I]** My own inference or estimate.

Mathlib size for calibration [L]: 2,349,087 lines / 99.2 MB of `.lean` source in `Mathlib/` (≈ 42 bytes per line). Byte sizes of other repositories below are converted to lines with this ratio, so line counts for external repos are **estimates (±25%)**.

---

## Summary

1. **Statement-level infrastructure is essentially available in Mathlib.** Our project's draft statement (`lean/YangMills/YangMills/{OS,Lattice,SU,Statement}.lean`, written by the problem-definition workstream) uses only Mathlib primitives: `SchwartzMap`, `ContinuousMultilinearMap`, `EuclideanSpace`, `LinearIsometryEquiv`, `Submodule.reflection`, `Matrix.specialUnitaryGroup`, `MeasureTheory.Measure.haarMeasure ⊤`, `Measure.pi`, `NormedSpace.exp`, `Filter.Tendsto`. The only non-Mathlib fact it needed, compactness of `SU(N)`, is proved locally in `SU.lean` (86 lines). Mathlib has **no** `CompactSpace (Matrix.unitaryGroup (Fin n) ℂ)` instance [Lc: instance synthesis fails].

2. **Mathlib (Oct 2026) is much stronger in analysis than in 2024–25.** It now contains `TemperedDistribution`, distributions on open sets (`Distribution`, `TestFunction`), Fourier transforms on 𝓢, 𝓢′ and L² (Plancherel), Sobolev/Bessel-potential spaces, `GroupLieAlgebra` (the Lie algebra of a Lie group), covariant derivatives on vector bundles, GNS for C*-algebras, RKHS (Moore's theorem), standard subspaces, Gaussian measures on Banach spaces, Gaussian processes, Brownian motion, Prokhorov's theorem, Lévy continuity, and infinite products of probability measures [Lc/L]. **The Kolmogorov extension theorem was merged into Mathlib master on 2026-11-05** (PR #44909, by Degenne and Pfaffelhuber), *after* our pin [G].

3. **Mathlib gaps that matter for a QFT proof** [L, confirmed by grep]:
   - nuclear spaces, Bochner's theorem, Minlos's theorem, the Schwartz kernel theorem, and a measurable structure on 𝓢′ (the last is open PR #45494);
   - a `CompleteSpace` instance for 𝓢;
   - spectral theorem for unbounded self-adjoint operators, spectral measures, Stone's theorem, C₀-semigroups;
   - several complex variables (Osgood, Hartogs, tube domains, edge-of-the-wedge);
   - the Lorentz group and Minkowski space;
   - SU(n) as a Lie group (no charts on any matrix group except GL via units and the circle), closed-subgroup theorem, smooth Lie-group exponential (open PR #37932);
   - bi-/inversion-invariance of Haar measure on *non-abelian* compact groups (not even as an instance), Peter–Weyl, characters of compact groups;
   - principal bundles, connections, curvature (open PRs #30121, #38374, #45069);
   - anything lattice-gauge-theoretic, reflection positivity, transfer matrices, cluster/polymer expansions, renormalization group.

4. **The adjacent ecosystem has filled many generic constructive-QFT gaps in 2026, mostly with AI assistance.**
   - **M. R. Douglas and collaborators:**
     - `OSforGFF`: massive free field satisfies all OS axioms for every d ≥ 2, reported 0 sorry / 0 axiom, Comparator-checked.
     - `bochner`: Bochner and Minlos theorems.
     - `gaussian-field`: nuclearity of 𝓢 via Hermite functions; Gaussian measures on duals of nuclear spaces; a Schwartz kernel theorem (`schwartz_nuclear_extension`, now in `GeneralResults/NuclearExtensionComplex.lean` on `main`; the README still mentions a former `extension` branch, which no longer exists — *verifier correction*).
     - `pphi2`: P(φ)₂ construction, **still 26 project axioms** (headline `pphi2_existence` rests on 5 of them).
     - `lgt`: strong-coupling lattice Yang–Mills correlation decay, 0 sorry, Comparator-accepted.
     - `hille-yosida`, `reflection-positivity`, `spectral-positivity` (Jentzsch), `markov-semigroups` (Dobrushin).
   - **Xi Yin's `OSreconstruction`:** distributional OS↔Wightman reconstruction in both directions for **scalar** fields in any dimension d+1 ≥ 2. Reported 0 sorry / 0 project axioms. It is checked by Comparator against a single Mathlib-only definitions file. It is about 350k lines.
   - **Physlib** (PhysLean, formerly HepLean, now `leanprover-community/physlib`):
     - `LorentzGroup`, `minkowskiMatrix`;
     - `su(n)` as a real Lie algebra with its Killing form;
     - in the lightly reviewed `PhyslibAlpha` tier, an unbounded spectral theorem via the Cayley transform, plus Stone's theorem (≈24k lines).

5. **Tooling is mature.**
   - The Lean FRO **Comparator** has been merged into core as `lake comparator` / `lake check` (Lean ≥ v4.35.0). I confirmed it is present in our v4.36.0-rc2 toolchain [L: `lake comparator --help`].
   - It sandboxes with `bwrap`, which is Linux-only. Its `--paranoid` flag also replays proofs through `leanchecker-paranoid`, `lean4lean`, `nanoda`, `con-leche` and `con-ron`.
   - Blueprint tooling (`leanblueprint`, `LeanArchitect`), `formalization.yaml` project cards and the `math-commons/formalization-assurance` conventions supply the review layer.

6. **OpenAI's build setups.**
   - **`openai/ten-proofs`:**
     - Lean 4.32.0, mathlib `v4.32.0`, Comparator pulled in as a Lake dependency.
     - Ten monolithic single-file proofs totalling ≈ 21.6 MB (≈ 515k lines).
     - Short Mathlib-only challenge files; `enable_nanoda: true`.
     - Status `agent-reviewed`, produced by "Astra (OpenAI)" in the Codex framework over one week.
   - **`openai/math`:**
     - Lean 4.34.1, Mathlib pinned to a commit.
     - About 29 direct non-Mathlib dependencies pinned to commits (including build tooling: checkdecls, doc-gen4, LeanArchitect). 23 of them carry a forward-port patch, applied by custom Lakefile code.
     - *Verifier correction:* the per-area recursive trees under `lean/OAI/` are untruncated. They hold ≈ 1.78 GB of `.lean` in 162,413 files, about 18× Mathlib's 99.2 MB. At Mathlib's bytes-per-line ratio that is ≈ 42M lines, though part of it is machine-generated certificate data. The author's figure of "≥ 474 MB / ≥ 53,554 files" was a correct but loose lower bound taken from a truncated listing.

7. **Size of what is missing** (detailed table in §4). All of the following are [I] estimates:
   - *Statement:* 0–3k further lines.
   - *Generic constructive-QFT layer:* largely exists externally, but on five different Lean versions and three incompatible encodings of "distribution space". Unification and forward-porting cost is roughly weeks of agent time, not new mathematics.
   - *Compact Lie group layer* (SU(N) as a manifold, exp/log/BCH, Haar bi-invariance, Peter–Weyl, heat kernel on G): ≈ 15–40k human-quality lines, absent everywhere I looked.
   - *YM-specific layer* (lattice RG à la Bałaban, gauge fixing, small/large-field and polymer expansions, uniform multiscale bounds, continuum limit of gauge-invariant composite fields, O(4) restoration, Wilson-action reflection positivity, non-triviality): no public Lean exists beyond strong-coupling `lgt`. This is ≈ 0.2–0.6M lines at human density, or ≈ 1–4M lines at the AI densities observed in `OSreconstruction` and `ten-proofs`. That range is consistent with OpenAI's reported 1,147-page natural-language proof. The page count is confirmed in the committee's first statement, but the committee does not say what the 1,147 pages cover; its statement also claims existence "including coupling to fermions". So this calibration is weak.
   - *The mass gap* has no estimate, because it is open mathematics.

---

## 1. Key definitions and statements (what the formal problem needs)

### 1.1 Mathematical objects

Euclidean Yang–Mills on $\mathbb R^4$ with compact simple gauge group $G \subset U(d)$, in the form used by our draft statement:

- **Test functions:** $\mathcal S(\mathbb R^4,\mathbb C^\iota)$, where $\iota$ indexes field components; for the composite fields $T_{\mu\nu\kappa\lambda}=\operatorname{tr}F_{\mu\nu}F_{\kappa\lambda}$ we have $\iota = (\mathrm{Fin}\,4)^4$.
- **Schwinger functions:** $S_n:\mathcal S(\mathbb R^4,\mathbb C^\iota)^{\times n}\to\mathbb C$, continuous and multilinear. In Lean: `ContinuousMultilinearMap ℂ (fun _ : Fin n => TestFn ι) ℂ`.
- **OS axioms:** normalization; E0′ linear growth $|S_n(f_1,\dots,f_n)| \le \alpha\,(n!)^\beta\prod_k \|f_k\|_{ns}$; reality; Euclidean covariance under $O(4)\ltimes\mathbb R^4$ through a finite-dimensional representation $\rho$; permutation symmetry; reflection positivity of the form $B(F,F)=S(\Theta F^*\cdot F)$ on ordered positive-time polynomials; clustering.
- **Lattice definition:**
  - lattice $\Lambda_L=(\mathbb Z/(L+1))^4$, links $\ell=(x,\mu)$, link variables $U_\ell\in G$;
  - Wilson action $S(U)=\beta\sum_{p}\big(1-\tfrac1d\operatorname{Re}\operatorname{tr}\pi(U_p)\big)$;
  - Gibbs measure $d\mu_{L,\beta}=Z^{-1}e^{-S(U)}\prod_\ell dU_\ell$ with normalized Haar $dU$;
  - continuum limit $a\to0$, $aL\to\infty$, $\beta\to\infty$ (optionally along two-loop asymptotic scaling), with finite renormalization $Z$ of the composite fields, evaluated on test functions with disjoint supports.
- **Mass gap (Euclidean form):**
  $$|B_T(F,T_tG)|\le e^{-mt}B_T(F,F)^{1/2}B_T(G,G)^{1/2},\qquad t \ge 0,$$
  on the OS pre-Hilbert space, where $B_T$ is the truncated form. This is equivalent, after OS reconstruction, to $\operatorname{spec}H\subset\{0\}\cup[m,\infty)$. It deliberately avoids the unbounded spectral theorem, which Mathlib lacks (§2.7).

### 1.2 Core Mathlib types (exact signatures, [Lc]/[L])

- **Schwartz space.** `SchwartzMap E F` (notation `𝓢(E, F)`, scoped `SchwartzMap`).
  - It is the space of smooth `f : E → F` with $\sup_x \|x\|^k\|D^n f(x)\|<\infty$ for every $k,n$.
  - Topology comes from `schwartzSeminormFamily`. Instances: `instLocallyConvexSpace`, `instFirstCountableTopology`, `T3Space`. There is **no** `CompleteSpace 𝓢(E,F)` instance [L, grep].
- **Tempered distributions.** `abbrev TemperedDistribution := 𝓢(E, ℂ) →Lₚₜ[ℂ] F`, i.e. complex Schwartz test functions with the topology of *pointwise convergence* (`PointwiseConvergenceCLM`, the weak-* topology). Notation `𝓢'(E, F)`.
- **Distributions on open sets.** `abbrev Distribution := 𝓓^{n}(Ω, ℝ) →L_c[ℝ] F`.
  - Test functions are *real*, from `TestFunction Ω F n`, with the LF topology as an inductive limit of `ContDiffMapSupportedIn`.
  - Complex distributions are $F=\mathbb C$ as a real vector space. The docstring explicitly lists the Schwartz kernel theorem as a long-term goal.
- **Lie algebras.** `class LieAlgebra.IsSimple` with fields `eq_bot_or_eq_top : ∀ I : LieIdeal R L, I = ⊥ ∨ I = ⊤` and `non_abelian : ¬IsLieAbelian L`. `killingForm : LinearMap.BilinForm R L := LieModule.traceForm R L L`.
- **Matrix groups.**
  - `Matrix.specialUnitaryGroup n α : Submonoid (Matrix n n α) := unitaryGroup n α ⊓ MonoidHom.mker detMonoidHom`, with `Group` and `StarMul` instances.
  - `Matrix.unitaryGroup n α := unitary (Matrix n n α)`; `IsTopologicalGroup (unitary R)` and `isClosed_unitary`; `entry_norm_bound_of_unitary` (root namespace).
- **Lie groups.** `class LieGroup (I : ModelWithCorners 𝕜 E H) (n : ℕ∞ω) (G)`. `GroupLieAlgebra I G := TangentSpace I (1 : G)`, with the bracket from `mulInvariantVectorField` and instance `LieAlgebra 𝕜 (GroupLieAlgebra I G)`. This needs `C^3` over ℝ/ℂ.
- **Unbounded operators.** `LinearPMap` (notation `E →ₗ.[𝕜] F`), `LinearPMap.adjoint` (notation `T†`), `LinearPMap.IsClosed`, `IsClosable`, `closure`, `LinearPMap.isSelfAdjoint_def : IsSelfAdjoint A ↔ A† = A`, `IsSelfAdjoint.isClosed`, `IsSelfAdjoint.dense_domain`.

---

## 2. Detailed findings by area

### 2.1 Schwartz space, distributions, Fourier analysis, Sobolev spaces

**Present in Mathlib** (`Mathlib/Analysis/Distribution/*`, about 7.1k lines, and `Mathlib/Analysis/Fourier/*`, about 4.4k lines) [Lc]:

- **Schwartz space.**
  - `SchwartzMap`, `SchwartzMap.seminorm`, `schwartzSeminormFamily`.
  - Pullback and composition maps: `SchwartzMap.compCLM`, `SchwartzMap.compCLMOfContinuousLinearEquiv`, `SchwartzMap.compSubConstCLM` (translation, used by our `OS.lean`), `SchwartzMap.postcompCLM`.
  - `SchwartzMap.integralCLM`; `SchwartzMap.fderivCLM` and line derivatives.
  - `SchwartzMap.denseRange_toLpCLM`: 𝓢 is dense in $L^p$, $p<\infty$.
- **Fourier on 𝓢.**
  - `SchwartzMap.fourierTransformCLM : 𝓢(V,E) →L[𝕜] 𝓢(V,E)`, with the typeclass interface `FourierTransform`, `FourierPair`, notation `𝓕` / `𝓕⁻`.
  - Plancherel and Parseval for Schwartz functions (`integral_sesq_fourier_fourier`, `inner_fourier_toL2_eq`).
  - Fourier interchanges with derivatives.
- **Fourier on $L^2$.** `MeasureTheory.Lp.fourierTransformₗᵢ : Lp F 2 ≃ₗᵢ[ℂ] Lp F 2`, with `norm_fourier_eq` and `inner_fourier_eq`. This is the L² Fourier–Plancherel isometry, obtained by density of 𝓢.
- **Tempered distributions.**
  - `TemperedDistribution` and embeddings: `SchwartzMap.toTemperedDistributionCLM`, `MeasureTheory.Measure.toTemperedDistribution` (for `μ.HasTemperateGrowth`), `Function.HasTemperateGrowth.toTemperedDistribution`, `MeasureTheory.Lp.toTemperedDistributionCLM` (injective: `ker_toTemperedDistributionCLM_eq_bot`).
  - Operations: multiplication `TemperedDistribution.smulLeftCLM`, derivatives (`instLineDeriv`, `derivCLM`), Laplacian, Fourier transform (`fourier_apply : 𝓕 f g = f (𝓕 g)`), `TemperedDistribution.delta`, and `fourier_delta_zero`.
- **Fourier multipliers.** `SchwartzMap.fourierMultiplierCLM`, `TemperedDistribution.fourierMultiplierCLM`.
- **Sobolev spaces.**
  - `TemperedDistribution.besselPotential` (the operator $(1-(2\pi)^{-2}\Delta)^{s/2}$), `TemperedDistribution.MemSobolev s p`, and the bundled `BesselPotentialSpace` (in `Mathlib/Analysis/FunctionalSpaces/BesselPotentialSpace.lean`).
  - `memSobolev_two_iff_fourier`, plus the Gagliardo–Nirenberg–Sobolev inequality (`Mathlib/Analysis/FunctionalSpaces/SobolevInequality.lean`).
- **Supports.** `dsupport` (support of a distribution) and `dsupport_delta`.
- **Discrete Fourier on $\mathbb Z/N$** (`ZMod.dft`, with inversion `ZMod.dft_dft`) and multidimensional Fourier series on tori (file `Mathlib/Analysis/Fourier/AddCircleMulti.lean`; this is a file name, not a declaration). Both are useful for lattice propagators.

**Missing** [L, grep]:

- nuclearity of 𝓢 (no `nuclear` anywhere in Mathlib);
- the Schwartz kernel theorem;
- Hermite functions (only Hermite *polynomials* exist);
- completeness / Fréchet instance of 𝓢;
- tensor products of Schwartz spaces;
- Paley–Wiener theorems;
- Laplace transforms of distributions;
- heat kernels and Green's functions of $-\Delta+m^2$.

**External coverage** [R]:

- `mrdouglasny/gaussian-field` provides:
  - `DyninMityaginSpace (SchwartzMap D ℝ)` via a Hermite basis and an isomorphism with the Köthe sequence space `RapidDecaySeq` (≈8k lines);
  - Pietsch `NuclearSpace` with `DyninMityaginSpace.toNuclearSpace`;
  - `NuclearTensorProduct`;
  - Schwartz tensor products (`schwartzTensorEquiv`);
  - a Schwartz kernel theorem `schwartz_nuclear_extension` (`GeneralResults/NuclearExtensionComplex.lean`, 78 KB ≈ 1.9k lines; ≈ 2.7k lines with the two other `NuclearExtension.lean` files). *Verifier correction:* this is now on `main`, inside the default build target, for which the README reports 0 axioms / 0 sorries. The README text still refers to an `extension` branch, which no longer exists (GitHub API, 2026-11-06 UTC). The README separately lists WIP modules outside the default build (`Cylinder/`: 3 axioms; `SchwartzFourier/`: 1 axiom).
- `OSreconstruction/SCV/` provides Paley–Wiener, Fourier–Laplace representation, Bochner tube theorem and distributional edge-of-the-wedge (about 47k lines in all).
- PhyslibAlpha has `Mathematics/Distribution/*` utilities (time slices, translations, Schwartz density).

### 2.2 Nuclear spaces, Bochner–Minlos, measures on 𝓢′

**Mathlib** has:

- characteristic functions on inner-product spaces, `MeasureTheory.charFun`, and on Banach spaces via the dual, `MeasureTheory.charFunDual (μ) (L : StrongDual ℝ E)`;
- uniqueness: `Measure.ext_of_charFun`, `Measure.ext_of_charFunDual`;
- Lévy's continuity theorem in finite dimensions: `ProbabilityMeasure.tendsto_iff_tendsto_charFun`, `isTightMeasureSet_of_tendsto_charFun`;
- `WeakDual`, `WeakBilin`, Banach–Steinhaus (`Analysis/Normed/Operator/BanachSteinhaus.lean`), `BarrelledSpace`, `WithSeminorms`, `LocallyConvexSpace` [Lc].

**Missing in Mathlib:**

- Bochner's theorem on $\mathbb R^n$, i.e. continuous positive-definite ⇒ Fourier transform of a measure (no hits for "Bochner's theorem" or `PositiveDefinite`);
- Minlos's theorem;
- Sazonov's theorem;
- nuclear spaces and operators (open PRs #42278 "Nuclear space" and #42197 "define nuclear operator", both by `mpacholski`; #42127 adds the projective tensor product topology) [G];
- any `MeasurableSpace` on `WeakDual`/𝓢′.

Open PR **#45494** (`chenle02`, updated 2026-10-30) adds `WeakDual.cylinderMeasurableSpace`, i.e. the σ-algebra generated by evaluations. It also proves that finite measures are determined by their finite-dimensional marginals (`ext_of_forall_finset_map_eq`) [G].

**External** [R]:

- **`mrdouglasny/bochner`** (`lean-toolchain` v4.33.0-rc1; the README's "requires v4.28.0-rc1" is stale — *verifier correction*; ≈ 446 KB of `.lean` ≈ 11k lines by byte estimate, while the README states ≈ 8.3k lines for the three core libraries). It provides:
  - `bochner_theorem` in finite dimensions, proved via Gaussian regularization, Fejér averaging, the Schur product theorem, Prokhorov and `Measure.ext_of_charFun`, avoiding Riesz–Markov–Kakutani;
  - Minlos (`minlos_theorem`): for `[IsHilbertNuclear E] [SeparableSpace E]`, a continuous positive-definite normalized Φ has a unique probability measure on `WeakDual ℝ E` with that characteristic functional;
  - the bridge `isHilbertNuclear_of_nuclear` (Pietsch ⇒ Hilbert-nuclear).
  
  It depends on `kolmogorov_extension4`. The core libraries are reported at 0 sorry / 0 axiom. Its `Test/` white-noise example still uses axioms for Schwartz properties.
- **`OSforGFF`** builds `FieldConfiguration d := WeakDual ℝ (SchwartzMap (SpaceTime d) ℝ)`, with the cylinder σ-algebra supplied by `bochner`.
- A fork, **`or4nge19/OSforGFF`**, avoids Minlos altogether: finite-dimensional Gaussians, then Kolmogorov extension, then pushforward [R, OSforGFF README; also stated in arXiv:2603.15770].

**Consequence for us [I].** Three incompatible encodings of "the space of field configurations / distributions" are in use:

| Encoding | Used by |
|---|---|
| (a) `TemperedDistribution E F` (complex test functions, pointwise topology) | Mathlib |
| (b) `WeakDual ℝ 𝓢(E, ℝ)` with the bochner cylinder σ-algebra | OSforGFF / bochner / gaussian-field |
| (c) multilinear Schwinger functions on test functions (our statement) vs. distributions on configuration space `𝓢((ℝ^{d+1})^n)` | (c) appears in OSreconstruction |

Passing from (c)-multilinear to (c)-configuration-space is exactly the **Schwartz kernel theorem** (nuclearity). This is the single most important bridge lemma if we want to feed our `Schwinger` structure into OSreconstruction.

### 2.3 Haar measure, compact groups, representation theory

**Mathlib** [Lc/L]:

- `MeasureTheory.Measure.haarMeasure (K₀ : PositiveCompacts G)`, normalized so that `haarMeasure_self` gives $\mu(K_0)=1$;
- `MeasureTheory.Measure.haar`, `IsHaarMeasure`, `haarMeasure_unique`;
- `isMulInvariant_eq_smul_of_compactSpace`: uniqueness up to scalar on compact groups;
- `isHaarMeasure_eq_of_isProbabilityMeasure`;
- inner regularity and regularity instances for Haar measures on compact groups;
- the modular character (`MeasureTheory/Group/ModularCharacter.lean`);
- Haar on quotients and disintegration;
- `Measure.pi` (finite products).

So `haarMeasure ⊤` is the normalized Haar measure on a compact group: our `Lattice.lean` uses `Measure.haarMeasure ⊤`.

**Gaps checked by compiling** [Lc]:

- `IsProbabilityMeasure (Measure.haarMeasure ⊤)` is **not** an instance, though $\mu(\text{univ})=1$ follows from `haarMeasure_self`.
- `IsMulRightInvariant (haarMeasure ⊤)` on a compact group is **not** synthesized.
- Inversion invariance (`IsHaarMeasure.isInvInvariant_of_regular`) is only proved for **commutative** groups.

Left- and right-invariance together are exactly what gauge invariance of the Wilson measure needs ($U_\ell\mapsto g_xU_\ell g_y^{-1}$). This is a small but real gap [I: ~100–300 lines via triviality of the modular character on compact groups].

**Representation theory** [L]:

- *Present:* `Representation`, `FDRep`, characters and orthogonality for **finite** groups (`RepresentationTheory/Character.lean`, `FinGroupCharZero.lean`), Maschke; continuous representations `ContRepresentation` and `TopRep`, which have only coinduction and invariants infrastructure.
- *Missing:* Peter–Weyl, Schur orthogonality for compact groups, characters of SU(N), class functions, and the heat kernel on G. These are central to strong-coupling/character expansions, to 2D YM, and to Bałaban-style analysis near the identity.

### 2.4 Lie groups, Lie algebras, SU(N)

**Lie algebras** (`Mathlib/Algebra/Lie`, ≈19k lines) [Lc]:

- simplicity, semisimplicity and Killing structures: `LieAlgebra.IsSimple`, `IsSemisimple`, `HasTrivialRadical`, `IsKilling`, `killingForm`;
- Cartan subalgebras, Engel's and Lie's theorems, weights and root spaces;
- `LieAlgebra.IsKilling.isSimple_iff_isIrreducible`: simple ⟺ irreducible root system;
- root systems (`RootPairing`, `CartanMatrix`, Weyl group, Geck construction);
- classical algebras over commutative rings: `LieAlgebra.SpecialLinear.sl`, `Symplectic.sp`, `Orthogonal.so`, `so'`, types B/D;
- universal enveloping algebra; Serre construction.

There is **no** `su(n)` (compact real form) in Mathlib.

**Lie groups** (`Mathlib/Geometry/Manifold`, ≈34k lines):

- `LieGroup I n G`, `LieAddGroup`, `ModelWithCorners`, `ContMDiff`, `IsManifold`, `VectorField.mlieBracket`;
- `GroupLieAlgebra I G` (tangent space at 1 with left-invariant-vector-field bracket, `C^3`);
- `LeftInvariantDerivation` (an alternative Lie algebra);
- instances: `Rˣ` for complete normed algebras (so `GL_n`), `Circle`, products [L].

**Missing** [L, grep; PR search via `gh`]:

- any manifold structure on `Matrix.unitaryGroup` or `specialUnitaryGroup`;
- the closed-subgroup (Cartan) theorem;
- the Lie group exponential map (open PR **#37932** "Exponential map of Lie group is smooth");
- Baker–Campbell–Hausdorff;
- the correspondence between `GroupLieAlgebra` of SU(N) and traceless skew-Hermitian matrices;
- compactness of U(n)/SU(n) as an instance;
- connectedness of SU(n) (`Unitary.instLocallyPathConnectedSpace` exists for C*-algebra unitaries) [Lc].

The matrix exponential is available as `NormedSpace.exp` with `MatrixExponential.lean` [Lc]. Our statement defines $\mathfrak g$ concretely as $\{X : \forall t, \exp(tX)\in\pi(G)\}$, with simplicity as `IsSimpleMatrixLieAlgebra`. This sidesteps the missing manifold structure, which I consider a sound design choice [I].

**Physlib** [G]:

- `Physlib/Mathematics/Groups/SpecialUnitary/LieAlgebra/*` (≈2.3k lines) defines `SULieAlgebra n R`:
  - traceless Hermitian matrices with bracket $i[x,y]$;
  - the adjoint representation of `unitaryGroup` (`SULieAlgebra.conj`);
  - the complexification ≅ traceless complex matrices; `finrank = n²−1`;
  - Gell-Mann matrices;
  - `SULieAlgebra.killingForm_eq_trace`: the Killing form of the complexification is $-2n\,\mathrm{tr}(AB)$.
- These are the most useful existing su(N) facts. They live in a downstream library, not in Mathlib.

### 2.5 Bundles, connections, curvature (continuum gauge fields)

**Mathlib** has:

- `FiberBundle`, `VectorBundle`, `ContMDiffVectorBundle`, smooth sections;
- the tangent bundle, Riemannian bundles, local frames, tensoriality;
- `CovariantDerivative` / `IsCovariantDerivativeOn`: Koszul connections on vector bundles, with differences of connections as End-valued 1-forms, torsion and Levi-Civita [L].

**Missing:**

- curvature (open PR **#45069** "Riemann curvature of a covariant derivative", updated 2026-10-20);
- principal bundles and connection 1-forms (open PRs **#30121**, **#38374**) [G];
- gauge transformations, Chern–Weil, Sobolev connections, Uhlenbeck compactness, Yang–Mills functional.

**PhyslibAlpha** `ClassicalFieldTheory/GaugeTheory/*` (77 files, ≈31k lines) has local, coordinate-level gauge data: Maurer–Cartan, field strength, gauge action, matter fields and covariant derivatives in matrix representations [G].

For a lattice-based proof, continuum bundle geometry is probably needed only for the classical-field and small-field analysis, e.g. interpolating lattice configurations by continuum connections, as in Bałaban's averaging/gauge-fixing operations [I].

### 2.6 Lorentz group and Minkowski space

**Mathlib:** nothing. Every grep hit for "Lorentz" or "Minkowski" refers to the Minkowski inequality or convex bodies [L].

**Physlib** (core, reviewed tier, ≈29k lines under `Relativity/`) provides [G]:

- `minkowskiMatrix : Matrix (Fin 1 ⊕ Fin d) (Fin 1 ⊕ Fin d) ℝ`;
- `LorentzGroup d` as a `Set` of matrices with `Group` and `TopologicalSpace` instances, closedness, the proper/orthochronous/restricted subgroups, boosts and rotations;
- the Lorentz algebra and its exponential map;
- Lorentz tensors in index notation (arXiv:2411.07667).

**OSreconstruction** instead defines a self-contained `ConnectedLorentz d` (subtype of matrices with $L^\top\eta L=\eta$, $\det L=1$, $L_{00}\ge1$), the complex Lorentz group, forward tubes and permuted extended tubes. It does this directly in its Mathlib-only `Definitions.lean`, so that the Comparator challenge depends on nothing but Mathlib [G]. That pattern is the right one for a trusted statement file [I].

### 2.7 Hilbert spaces and operator theory

**Mathlib has** [Lc/L]:

- inner-product spaces, `HilbertBasis`, `OrthonormalBasis`, $L^2$ and `lp`, tensor products of inner-product spaces;
- **bounded** spectral theory:
  - finite-dimensional `LinearMap.IsSymmetric.eigenvectorBasis`;
  - compact self-adjoint operators: eigenspaces span, with an eigenvector basis in open PR #45543;
  - the continuous functional calculus `cfc` / `cfcₙ` for C*-algebras, with `CFC.exp`/`CFC.log` and order properties;
  - the Rayleigh quotient and spectral radius;
- the Fuglede–Putnam theorem; the weak operator topology (`ContinuousLinearMapWOT`, notation `E →WOT[𝕜] F`);
- the **GNS construction** (`PositiveLinearMap.GNS`, `gnsStarAlgHom`); the cyclic vector is still a TODO in the file;
- **RKHS** (`RKHS`, `RKHS.OfKernel`, Moore's theorem): positive-semidefinite kernels give Hilbert spaces. This is exactly the abstract step from reflection positivity to the physical Hilbert space;
- **`StandardSubspace`** (beginnings of Tomita–Takesaki; Tomita's theorem is still a TODO);
- the mean ergodic theorem;
- unbounded operators: `LinearPMap.adjoint`, closedness, closability, closure, `IsSelfAdjoint` for `LinearPMap` via its `Star` instance; self-adjoint operators are closed and densely defined.

**Missing in Mathlib** [L]:

- `IsEssentiallySelfAdjoint`;
- spectrum/resolvent of unbounded operators;
- spectral measures / projection-valued measures;
- the Borel functional calculus;
- the spectral theorem for bounded self-adjoint operators (an explicit "TODO" in `InnerProductSpace/Spectrum.lean`);
- the unbounded spectral theorem;
- Stone's theorem; C₀-semigroups and Hille–Yosida;
- trace-class and Hilbert–Schmidt operators;
- Fock space (no hits).

**External** [R/G]:

- **PhyslibAlpha `ProbabilisticTheory/HilbertSpace/Unbounded/`** (48 files, ≈24k lines, author Tom Ole Diem):
  - `unboundedSpectralTheorem` via the Cayley transform (`CayleySpectralData/SpecTheorem.lean`);
  - `maximalSpectralIntegral_isSelfAdjoint`;
  - `StrongUnitaryOneParameterGroup`;
  - `expUnitaryGroup`;
  - `stoneCandidateGenerator_reconstruction`, i.e. Stone's theorem, reconstruction direction;
  - essential spectrum, Weyl's criterion, Nelson analytic vectors.
  
  The files I downloaded contain 0 `sorry` and 0 `axiom` [G: grep of raw files]. However, PhyslibAlpha has a **lighter, one-look review**, and its maintainers say they will not maintain contributions that break [R: physlib README].
- **`mrdouglasny/hille-yosida`:** C₀-semigroups, the Hille–Yosida resolvent theorem, Bernstein's theorem, and BCR 4.1.13 (semigroup Bochner on $[0,\infty)\times\mathbb R^d$), reported 0 axioms / 0 sorry. This is exactly the tool that turns OS reflection-positive time translations into $e^{-tH}$.
- **`spectral-positivity`:** Jentzsch's theorem for compact self-adjoint positivity-improving operators (simple top eigenvalue with a gap). Extracted from pphi2's transfer-matrix gap.
- **`oliver-butterley/SpectralThm`:** the spectral theorem for bounded normal operators, listed as ongoing in `lean-index-qft`.

### 2.8 Probability: Gaussian measures, Kolmogorov extension, tightness, Gibbs measures

**Mathlib** [Lc/L]:

- **Gaussian measures:**
  - `ProbabilityTheory.gaussianReal`, `multivariateGaussian`, `stdGaussian`;
  - `IsGaussian` on Banach spaces (every continuous linear form pushes forward to a real Gaussian), `isGaussian_iff_charFunDual_eq`;
  - **Fernique's theorem**;
  - `IsGaussianProcess`, with independence from zero covariance.
- **Brownian motion:** `IsPreBrownianReal`, `IsBrownianReal`, the Kolmogorov–Chentsov condition `IsKolmogorovProcess`.
- **Products and projective families:**
  - `Measure.infinitePi`, built via Ionescu-Tulcea `ProbabilityTheory.Kernel.traj` and Carathéodory;
  - `IsProjectiveMeasureFamily`, `IsProjectiveLimit` (uniqueness).
- **Weak convergence and tightness:**
  - `ProbabilityMeasure`, the Lévy–Prokhorov metric, the portmanteau theorem;
  - `IsTightMeasureSet`;
  - Prokhorov: `isCompact_closure_of_isTightMeasureSet`, and `isTightMeasureSet_of_isCompact_closure` in second-countable complete metric spaces.
- **Martingales, kernels, conditional expectations:** `condExp`, disintegration, `CondVar`.
- **Inequalities:** the four-functions (Ahlswede–Daykin) inequality.
- **Riesz–Markov–Kakutani.**

**Kolmogorov extension.**

- *Not* in our pinned Mathlib. `BrownianMotion/GaussianProjectiveFamily.lean` still says "Kolmogorov's extension theorem (not in Mathlib yet)" [L].
- It **is** now in master: PR **#44909** (Degenne, co-author Pfaffelhuber), bors-closed as merged on **2026-11-05 13:38 UTC**. It adds `MeasureTheory/Constructions/KolmogorovExtension.lean` with `projectiveLimit P hP`, `isProjectiveLimit_projectiveLimit` (the Kolmogorov extension theorem), and finite/probability-measure instances. It also adds a compact-system σ-additivity lemma (`addContent_iUnion_eq_sum_of_innerRegular`) [G: PR file list].
- *Action [I]:* bump our Mathlib pin to a commit on or after 2026-11-05 to get it.

**Missing:**

- Gibbs measures, the DLR equations, Dobrushin uniqueness;
- the FKG lattice condition, Griffiths/GKS, Brascamp–Lieb;
- hypercontractivity, the log-Sobolev inequality;
- Wick/Isserlis theorems for Gaussians;
- cluster/polymer expansions;
- large-deviation and Laplace-method estimates in many variables [L, grep].

**External:**

- `markov-semigroups` (≈46k lines): Poincaré, LSI, Holley–Stroock, Bakry–Émery, Brascamp–Lieb (from two analytic axioms), Ornstein–Uhlenbeck, Dobrushin uniqueness with exponential decay, Dobrushin–Zegarliński [R]. *Verifier note:* this library is **not** axiom-free. Its README lists 8 postulated textbook axioms (among them Otto–Reznikoff LSI, Helffer–Sjöstrand, Herbst MGF and Stroock–Varopoulos) and 2 `sorry`s in `Euclidean.lean`. lgt's headline theorems are axiom-clean, so they do not use those axioms.
- `gaussian-field`: Wick recursion, FKG on lattices, lattice Gaussian measures [R].
- `gaussian-hilbert`: Wiener chaos [R]. *Verifier correction:* its Bonami–Beckner–Nelson hypercontractive bound is still a **placeholder axiom** (`ouSemigroupAct_eLpNorm_hypercontractive`), per its README.
- `YaelDillies/gibbs-measure` (listed in `lean-index-qft`).
- `lgt` defines Yang–Mills as a `GibbsSpec` with the DLR identity `ymMeasure_isGibbs` [R].

### 2.9 Several complex variables / analytic continuation (needed for OS reconstruction)

**Mathlib** has one-variable Cauchy theory, analytic functions on Banach spaces (`AnalyticOnNhd`, power series), and `DifferentiableOn ℂ` for maps on $\mathbb C^n$. It has no Osgood/Hartogs, tube domains, Bochner's tube theorem or edge-of-the-wedge [L: grep "Osgood", "Hartogs", "tube domain", "edge of the wedge" all empty].

`OSreconstruction/SCV/` (83 files, ≈47k lines) supplies [G: file tree]:

- `Osgood.lean`, `IdentityTheorem.lean`, `BochnerTubeTheorem.lean`, `EdgeOfWedge.lean`;
- distributional edge-of-the-wedge (`DistributionalEOW*`);
- Paley–Wiener (`PaleyWiener*`), Fourier–Laplace representation, Laplace transforms of Schwartz functions;
- Euclidean Weyl lemma variants.

`ComplexLieGroups/` (≈18k lines) supplies the Bargmann–Hall–Wightman and Jost-point machinery.

### 2.10 Existing QFT formalizations (status as reported)

| Project | Content | Status (as reported) | Lean/Mathlib | Size |
|---|---|---|---|---|
| `mrdouglasny/OSforGFF` (Cherkis, Douglas, Hoback, Mei, Nissim) | Massive GFF as `ProbabilityMeasure (WeakDual ℝ 𝓢(ℝ^d,ℝ))`; `SatisfiesAllOS` (OS0 analyticity, OS1 regularity, OS2 Euclidean invariance, OS3 RP, OS4 clustering + ergodicity), d = 2, 3, 4, 5 and general d ≥ 2 | 0 sorry, 0 axioms; `Guardrails.lean` freezes the axiom footprint; `leanchecker` replay in CI; separate `OSforGFF-comparator` repo [R] | v4.33.0-rc1 [G: lakefile] | ≈1.6 MB / ≈ 40k lines total; README says ≈25.5k on-graph |
| `xiyin137/OSreconstruction` | Distributional E′→R′ (`os_to_wightman`, plus an OS-II quantitative/uniqueness version) and R→E (`wightman_to_os_axioms`) for scalar fields, spacetime d+1, zero-diagonal Euclidean tests | "no `sorry`, and no project axioms"; Comparator challenge `Definitions.lean` (497 lines, Mathlib-only); operator/GNS reconstruction explicitly **not** an endpoint [R/G] | v4.35.0-rc4 (package `lean-toolchain` and package README; the repo-root README's "4.33.0-rc1" is stale); depends on gaussian-field at a pinned commit | 14.8 MB ≈ 350k lines (Wightman 278k, SCV 47k, ComplexLieGroups 18k) [verifier re-computed from git tree] |
| `mrdouglasny/pphi2` | P(φ)₂ via lattice, transfer matrix, Jentzsch gap, tightness, Ward identity | **26 project axioms**, 0 sorry (2026-10-08); headline `pphi2_existence` rests on 5 axioms incl. `pphi2_limit_exists`. *Verifier correction:* the author wrote "three axioms found false". `AXIOM_AUDIT.md` in fact records at least four axioms removed as false as stated: `latticeInteraction_convex` (Feb), `spectral_gap_uniform` and `spectral_gap_lower_bound` (2026-07-12), and `nelson_exponential_estimate_master_bounded` (2026-10-08). Further axioms were *restated* after their unrestricted forms were found false, e.g. the Layer-A Lee–Yang axiom [R] | v4.30.0 [G: lean-toolchain] | 4.7 MB ≈ 112k lines |
| `xiyin137/Phi4` | φ⁴₂ along Glimm–Jaffe | 21 theorem-level `sorry`, 13 `…Model` assumption classes, 45 `gap_*` frontiers (Mar 2026) [R] | v4.28.0 [G] | ≈26k lines |
| `mrdouglasny/lgt` (Douglas, Rajasekaran) | U(n) Wilson LGT on $(\mathbb Z/N)^d$; strong-coupling ($\beta<1/(32n(d-1))$) exponential decay of plaquette correlations (`ym_mass_gap_exponential_decay`) via Dobrushin | 0 sorry / 0 axioms for headline theorems; Comparator accepted (unsandboxed macOS shim) [R] | v4.29/4.30 | ≈11k lines + markov-semigroups ≈46k |
| `leanprover-community/physlib` | Relativity, Wick contractions, perturbation-theory algebra, anomaly cancellation; `LatticeQFT/Basic.lean` is a **stub** [G] | core reviewed; Alpha lightly reviewed | v4.35.0 | ≈19.8 MB ≈ 470k lines in total |
| `mrdouglasny/seiberg-witten` (arXiv:2607.06379) | Physics inputs as explicit named postulates H0–H7, carried as hypotheses in theorem types; machine-checked consequences | *Verifier correction:* the author called these "named axioms". The README says the postulates are **not** Lean axioms. The trusted base is the three standard axioms plus a short named list of classical-mathematics axioms, tracked per theorem; the library is sorry-free [R] | v4.30.0 | ≈12k lines |
| `lean-dojo/LeanMillenniumPrizeProblems` | YM statement `MillenniumYangMills.ClayYangMills` in `Problems/YangMills/Millennium.lean`. *Verifier correction:* the author's name `YangMillsExistenceAndMassGap` does not occur in the current file | marked "Statement incomplete, not a valid target": the gauge field stores connection and curvature independently, the Lie algebra has no bracket, the Poincaré group is arbitrary, and a 2D toy model satisfies the statement [R: Reservoir page and repo README, both read] | v4.31.0 | – |
| private `math-commons/yang-mills` (rev `03bb758`) | Inhabits OSreconstruction's corrected input with the GFF and a Wick-square Proca field; vendors its records | **private; unverifiable** [R: OSreconstruction README] | – | – |

Several other public "Yang–Mills in Lean" repos (e.g. `Cloudhabil/yang-mills-lean4`, `garygitton/yang-mills-millennium-problem`, and Zenodo "audit" archives) make claims that I did not vet. Prior Zulip and Reservoir reviews flag several of them as conditional or unsound. **They are not relied on here.**

### 2.11 Tooling

- **Comparator.**
  - `leanprover/comparator` is archived; its README says it was merged into core as of **v4.35.0**. In our toolchain, `lake comparator --help` documents its inputs [L]:
    - a `comparator.json` with `challenge_module`, `solution_module`, `theorem_names`, `permitted_axioms` (deliberately *not* defaulted), optional `definition_names` and `external_kernels`;
    - exit codes 0 / 1 / 2.
  - It establishes, for each named theorem: same statement as the challenge, no axioms outside the whitelist, and kernel acceptance.
  - The project is treated as untrusted. It is built and exported inside a **`bwrap` sandbox (Linux)**, `.olean`s are never loaded into Lake's address space, and there is no network after dependency resolution.
  - `--paranoid` additionally runs `leanchecker-paranoid`, `lean4lean` (arXiv:2403.14064), `nanoda`, `con-leche` and `con-ron`. `lake check` replays a whole project.
  - Caveats: definition holes can be gamed, and the challenge statement itself must be reviewed by humans.
  - On macOS, the sandboxed mode is unavailable; projects use `--inadvisably-no-sandbox` / "development" mode. Its results carry no isolation guarantee [R: OSreconstruction comparator README, lgt README].
  - *Verifier note:* the archived standalone Comparator sandboxed with **`landrun`**, not `bwrap`. The lgt check used it on macOS through the insecure `fake-landrun.sh` shim, and lgt's README itself says the sandbox guarantee therefore does not hold. Only the core `lake comparator` / `lake check` use `bwrap`, which I confirmed with `--help` in v4.36.0-rc2. `lake check` replays the project's **default build targets**.
- **Blueprints.**
  - `PatrickMassot/leanblueprint`: a plasTeX plugin with `\lean{}`, `\leanok`, `\uses{}`, a dependency graph, `leanblueprint checkdecls`, and a GitHub Pages CI template.
  - `hanwenzhu/LeanArchitect`: `@[blueprint]` attributes extract statements, proofs and dependencies from Lean, mark nodes ready when sorry-free, and feed leanblueprint. It is used as a dependency of `openai/math`, together with `checkdecls` and `doc-gen4` [G: openai/math lakefile].
- **Assurance conventions.** `math-commons/formalization-assurance` (created by the `math-commons` organization, whose public repos are `formalization-assurance`, `graphons` and `s6-moduli`; the last says it accompanies `alpo.ge/s6.pdf`, which links the organization to Alpöge's work only through that one repo) separates three questions:
  - *verification* (kernel plus a generated axiom certificate);
  - *assumption review* (per-axiom vetting records with captured model prompts and replies, strictness L0–L3);
  - *validation* (faithfulness index, "object contracts" with anti-degeneracy clauses, and a categorical "spec has exactly one model" certificate).
  
  It also covers `formalization.yaml` and a Comparator protocol, and states the rule that **"proved ≠ faithful"** [G].
- **`formalization.yaml`.** The Mathlib-Initiative project-card schema, used by `openai/ten-proofs` (v0.3) and `openai/math` (v0.4).
- **Discovery.** `mrdouglasny/lean-index-qft` is a searchable index of about 151,691 topic-matched declarations across 113 repositories relevant to constructive QFT [R]. It is the fastest way to find existing lemmas before writing new ones.

### 2.12 OpenAI build setups (for AI-workflow lessons; details of the proofs are in note 04)

**`openai/ten-proofs`** (created 2026-08-05) [G]:

- **Build:**
  - `lean-toolchain` is `leanprover/lean4:v4.32.0`;
  - `lakefile.toml` requires `mathlib` at `v4.32.0` and `Comparator` (git, `v4.32.0`);
  - one `lean_lib` per result, plus a `ComparatorChallenges` library.
- **Shape of the proofs:**
  - Each result is a **single monolithic file**: from `MulticolorTriangleRamsey.lean` at 0.13 MB up to `GapCVP.lean` at 5.3 MB, ≈21.6 MB in all. I downloaded `NonSoficGroup.lean`: 34,440 lines, about 1,045 theorems/lemmas, 0 `sorry`, 0 `axiom`.
  - Challenge files are short and Mathlib-only. `D_NonSoficGroup.lean` is 1.1 KB: it defines soficity from scratch, then states `∃ G, Group.IsFinitelyPresented G ∧ ¬ Sofic G := by sorry`.
- **Checking:** JSON configs whitelist `propext`, `Quot.sound`, `Classical.choice` and set `enable_nanoda: true`.
- **Provenance:** `formalization.yaml` records status `agent-reviewed`, method `agent`, models "Astra (OpenAI)", framework "Codex", wall time "1 week".

**`openai/math`** (created 2026-10-06) [G]:

- **Pinning:**
  - `lean/lean-toolchain` is `v4.34.1`; Mathlib is pinned by commit (`d13f23b…`).
  - About 29 external libraries are pinned by **full commit hash**, including Carleson, PrimeNumberTheoremAnd, StrongPNT, sphere-eversion, Rellich–Kondrachov, TauCeti, gromov, ClassFieldTheory and about a dozen `lana-agents/*` repos.
- **Forward-porting:** a `patches/` directory holds `<lib>-lean4341.patch` files, up to ≈ 2.0 MB each (the largest is PrimeNumberTheoremAnd). *Verifier correction:* there are 23 patch files, so not every dependency has one; e.g. checkdecls, doc-gen4, LeanArchitect, PrimeCert, leancert and TauCeti have none. `lakefile.lean` contains custom Lake code that checks out the pinned commit and applies the patch with `git apply --check` before resolution.
- **Organization and size:** one `OAI` library split into area sub-libraries. A note in the repo warns that building the whole library can exhaust Linux `vm.max_map_count` (the suggested workaround is `-DMMAP=OFF`).
- **Catalogue:** `formalization.yaml` v0.4 lists 208 headline declarations, each with a `comparator_config` (verifier recount). The README says "~42%" of top-line results are formalized. The exact "300 / 719" comes from `history.md` (2026-10-07 entry), not the README. Since then the 2026-10-26 entry added two new formalized manuscripts and a Hodge-CM formalization, and the README now counts 721 manuscripts in 373 families (*verifier correction of attribution*).
- **Size (verifier addition):** `lean/OAI/` holds ≈ 1.78 GB of `.lean` in 162,413 files, from untruncated per-area recursive trees. The largest areas are Analysis (516 MB), Combinatorics (374 MB), NumberTheory (156 MB) and MathematicalPhysics (120 MB). Some of this is machine-generated certificate data, e.g. `MathematicalPhysics/Transonic/Certificates/Jet*.lean` at ≈ 0.6 MB each. The `OAI/MathematicalPhysics/` directory includes Navier–Stokes sub-results, Fock-space operators, a Heisenberg model and others.
- **Statement style:** physics/PDE statements (e.g. `OAI/Analysis/VlasovMaxwell/Model.lean`) are written as an elementary, Mathlib-only `Model.lean`: hand-rolled `divergence`/`curl` via `fderiv`, explicit `Datum`/`Solution` structures, then a `Main.lean` headline theorem.

**Lessons [I]:**

1. Trusted statements should be short, Mathlib-only and elementary. Proof code can be enormous and machine-generated.
2. Reuse of community libraries at scale requires commit pinning plus forward-port patches.
3. Sandboxed Comparator on Linux CI, with an external kernel, is the acceptance gate.
4. Expect proof volume of order $10^4$–$10^5$ lines per paper-length result.

### 2.13 Footprint of our current draft statement

From `lean/YangMills/YangMills/*.lean` (853 lines in total at time of reading; read-only inspection):

- `OS.lean`: `E4 := EuclideanSpace ℝ (Fin 4)`; `O4 := E4 ≃ₗᵢ[ℝ] E4`; time reflection via `Submodule.reflection`; `TestFn ι := 𝓢(E4, ι → ℂ)`; `Schwinger` as a family of `ContinuousMultilinearMap`s; Euclidean action via `SchwartzMap.compCLM`/`compSubConstCLM`/`postcompCLM`; Schwartz norms via `SchwartzMap.seminorm`; RP and truncated RP forms on finite polynomials of monomials; Euclidean `HasMassGap`; `NonTrivial` via the fourth cumulant.
- `Lattice.lean`: `GaugeGroup d G` (faithful continuous unitary representation); `GaugeGroup.lieAlgebra` via `NormedSpace.exp`; `IsSimpleMatrixLieAlgebra`; periodic lattice, plaquettes, Wilson action; `Measure.haarMeasure ⊤` and `Measure.pi`; lattice field strength and composite fields; `tensorRep` of O(4) via `Matrix.kroneckerMap`; `IsWilsonLimit`.
- `Statement.lean`: `IsYangMillsTheory`, `ExistsWithMassGap`, `ClayYangMills`, `SUNExists` with two-loop `AsymptoticScaling`.

All of these elaborate against Mathlib alone. The project's `.lake/build` contains a built `YangMills.olean`. That shows the files compiled at some point; I did not rebuild them.

---

## 3. What is proven vs open (infrastructure status table)

| Item | Status | Where | Evidence |
|---|---|---|---|
| Schwartz space, Fourier on 𝓢/𝓢′/L², Plancherel | **Established (in Mathlib)** | Mathlib | [Lc] |
| Tempered distributions, derivatives, δ, Sobolev $H^{s,p}$ | **Established** | Mathlib | [Lc] |
| Distributions on open sets with LF topology | **Established** (thin API) | Mathlib | [L] |
| Completeness of 𝓢 as an instance | **Missing** | – | [L grep] |
| Nuclearity of 𝓢 | Claimed proved | gaussian-field; Mathlib PR #42278 open | [R/G] |
| Schwartz kernel theorem | Claimed proved | gaussian-field `main` (`GeneralResults/NuclearExtensionComplex.lean`; former `extension` branch is gone) | [R/G] |
| Bochner (ℝⁿ), Minlos | Claimed proved | `bochner` | [R] |
| Cylinder σ-algebra on weak dual | Open PR | Mathlib #45494; `bochner` | [G] |
| Kolmogorov extension | **Established in master 2026-11-05**; not in our pin | Mathlib #44909 | [G] |
| Gaussian measures (Banach), Fernique, Brownian motion | **Established** | Mathlib | [Lc] |
| Prokhorov, Lévy continuity (finite-dim) | **Established** | Mathlib | [Lc] |
| Haar measure; uniqueness; normalized Haar on compact groups | **Established** | Mathlib | [Lc] |
| Bi-invariance / inversion invariance of Haar on non-abelian compact groups | **Missing** (no instance) | – | [Lc] |
| Peter–Weyl, compact-group characters | **Missing** | – | [L] |
| Simple / semisimple / Killing Lie algebras, root systems | **Established** | Mathlib | [Lc] |
| su(n) Lie algebra, Killing form = −2n tr | Established downstream | Physlib | [G] |
| SU(n) as Lie group (charts), exp map, closed-subgroup theorem | **Missing** (exp PR #37932 open) | – | [L/G] |
| Compactness of SU(n) | Proved locally in our repo; not in Mathlib | `SU.lean` | [Lc] |
| Covariant derivatives on vector bundles | **Established** | Mathlib | [L] |
| Curvature, principal bundles | Open PRs | Mathlib #45069, #30121, #38374 | [G] |
| Lorentz group, Minkowski metric | Established downstream | Physlib; OSreconstruction (self-contained) | [G] |
| Unbounded adjoint, closed, self-adjoint | **Established** (basic) | Mathlib | [Lc] |
| Unbounded spectral theorem, Stone | Claimed proved, light review | PhyslibAlpha | [G/R] |
| C₀-semigroups, Hille–Yosida, BCR Bochner | Claimed proved | `hille-yosida` | [R] |
| GNS (C*), RKHS / Moore | **Established** | Mathlib | [Lc] |
| Jentzsch / Perron–Frobenius for operators | Claimed proved | `spectral-positivity` | [R] |
| Abstract reflection positivity, chessboard | Claimed proved | `reflection-positivity` | [R] |
| Several complex variables, EOW, BHW | Claimed proved | OSreconstruction | [R/G] |
| OS ⇄ Wightman (scalar, distributional) | Claimed proved, Comparator-checked | OSreconstruction | [R] |
| Operator (GNS) reconstruction from OS | **Not an endpoint** anywhere public | – | [R] |
| GFF satisfies OS (all d ≥ 2) | Claimed proved, Comparator-checked | OSforGFF | [R] |
| P(φ)₂ existence | **Open in Lean** (26 axioms) | pphi2 | [R] |
| Lattice YM strong-coupling correlation decay | Claimed proved | lgt | [R] |
| Wilson-action reflection positivity (Osterwalder–Seiler) | **Missing** in Lean (classical theorem) | – | [I, not found] |
| Lattice RG / Bałaban multiscale bounds, gauge fixing, polymer expansions | **Missing** in Lean | – | [I, not found] |
| Continuum YM₄ existence | **Open** (OpenAI claim unreleased; the committee's 2026-11-03 statement says the Lean proof will be released "hopefully next week", with one day's notice; see note 02) | – | [P: committee PDFs, re-read by verifier] |
| YM₄ mass gap | **Open mathematics** | – | – |

---

## 4. Relevance to a 4D YM existence + mass-gap proof and to Lean formalization

### 4.1 Recommended architecture [I]

1. **Trusted statement repository.** Keep `lean/YangMills/YangMills/{OS,Lattice,SU,Statement}.lean` Mathlib-only and short, like `OSReconstructionAudit/Definitions.lean` and OpenAI's `Model.lean` files. Add a `ComparatorChallenges/` module whose theorem bodies are `sorry`, a `comparator.json` with the three-axiom whitelist, and run `lake comparator --paranoid` on Linux CI (bwrap).
2. **Bump Mathlib** to a commit on or after 2026-11-05 to get `MeasureTheory.projectiveLimit`. Track PRs #45494 (weak-dual σ-algebra), #42278 (nuclear spaces), #37932 (Lie exp), #45069/#38374 (curvature, principal bundles).
3. **Vendor external libraries by commit plus a forward-port patch,** following the `openai/math` pattern. Candidates: gaussian-field, bochner, OSforGFF pieces, hille-yosida, reflection-positivity, spectral-positivity, markov-semigroups, OSreconstruction, and the needed PhyslibAlpha files. Their `lean-toolchain` files, as re-checked by the verifier, are: hille-yosida v4.29.0; RP, spectral-positivity, markov-semigroups and lgt v4.30.0; gaussian-field, bochner and OSforGFF v4.33.0-rc1; OSreconstruction v4.35.0-rc4; physlib v4.35.0. Ours is v4.36.0-rc2. Note that markov-semigroups and gaussian-hilbert still contain axioms (§2.8).
4. **Bridge lemmas** are the first concrete proof-side deliverables:
   - (a) `Schwinger ι` (multilinear) ⇄ configuration-space distributions, via the Schwartz kernel theorem;
   - (b) our `OSAxioms` restricted to the **scalar** O(4)-invariant composite field $\operatorname{tr}F_{\mu\nu}F_{\mu\nu}$ ⇒ `OSReconstructionAudit.OS` plus `arityLinearGrowth`, so that OSreconstruction yields a Wightman theory for that scalar field;
   - (c) a tensor/spinor-covariant extension of OSreconstruction for the full $T_{\mu\nu\kappa\lambda}$;
   - (d) the Euclidean `HasMassGap` ⇒ an operator gap via hille-yosida plus the PhyslibAlpha spectral theorem. This is optional, since the statement is already Euclidean.
5. **Gaps to build ourselves** (no source found):
   - compact-group Haar bi-invariance;
   - SU(N) charts / Lie group structure;
   - Peter–Weyl and characters;
   - Osterwalder–Seiler reflection positivity of the Wilson action;
   - the transfer matrix as a positive trace-class operator on $L^2(G^{\text{links}})$;
   - Bałaban/RG machinery (gauge fixing, block averaging, small/large field decomposition, random-walk propagator expansions, cluster/polymer expansions with analytic estimates in many variables);
   - continuum-limit tightness for gauge-invariant composite fields;
   - O(4) restoration; non-triviality; asymptotic scaling.

### 4.2 Size estimate of missing infrastructure [I]

Calibration points [G/R]:

- Mathlib ≈ 2.35M lines, growing about 300k lines/year (figure from arXiv:2603.15770).
- OSreconstruction ≈ 350k lines: a classical reconstruction theorem of roughly 100 pages including SCV background, at AI density.
- ten-proofs ≈ 515k lines for ten paper-length results, i.e. about 50k lines per paper.
- OSforGFF + bochner + Schwartz nuclearity ≈ 50–60k lines for the free field.
- pphi2 ≈ 112k lines and *still* 26 axioms for P(φ)₂.
- lgt + markov-semigroups ≈ 57k lines for strong-coupling decay.
- OpenAI's YM natural-language proof: 1,147 pages (committee statement; note 02). The verifier re-read the committee PDF and confirmed the number, but the statement does not say whether the pages cover pure YM only or also the claimed coupling to fermions.
- openai/math: ≈ 1.78 GB of `.lean` for ≈ 300 formalized top-line results (verifier addition). That is about 6 MB, or ≈ 140k lines, per result, far denser than ten-proofs' ≈ 50k lines per paper. Part of the volume is generated certificate data, so this figure is an upper bracket, not a typical density.

| Layer | Status | Estimated new Lean (human-quality) | At observed AI density |
|---|---|---|---|
| Statement (Euclidean, as drafted) | Done; review only | 0–1k | – |
| Statement extras (Minkowski/Wightman form, Comparator challenge, sanity/anti-vacuity lemmas) | Partly done | 1–3k | 3–10k |
| Generic CQFT layer (nuclearity, Minlos, Kolmogorov, Gaussian fields, RP, semigroups, Jentzsch, spectral theorem, SCV, OS reconstruction) | Mostly exists externally | Unification/porting: 5–20k glue | weeks of agent time |
| Bridges (a)–(c) above | Missing | 5–20k | 20–100k |
| Compact Lie group layer (SU(N) manifold, exp/log/BCH, Haar bi-invariance, Peter–Weyl, characters, heat kernel) | Missing | 15–40k | 50–200k |
| Lattice YM basics (gauge invariance, Wilson loops, Wilson RP, transfer matrix, finite-volume bounds) | Partly (lgt) | 5–15k | 20–60k |
| Multiscale RG / UV stability / IR control / continuum limit / O(4) restoration / non-triviality | **Nothing exists** | 200–600k | 1–4M |
| Mass gap | Open mathematics | n/a | n/a |

The last full row extrapolates 1–3k AI-density lines per natural-language page (the OSreconstruction and ten-proofs ratios) to 1,000–1,500 pages. The human-quality column assumes a 5–10× compression, based on how Mathlib-quality code compares with machine output. Both factors are rough guesses.

### 4.3 Methodological lessons for the AI workflow

**From Douglas et al. (arXiv:2603.15770, §5)** [read in the PDF]:

- Hand-code the core definitions and axioms first.
- Then work by backward chaining: when an agent stalls, it proposes a general, textbook-style "helper lemma", and this is temporarily recorded as an `axiom` that is tracked for later discharge.
- Validate every helper axiom by cross-model review and numerical spot checks.
- Prefer helper lemmas stated without project-specific types. This reduced false conjectures.
- Write unit-test lemmas for each new definition. Definitions were wrong several times; the free covariance was first defined by a conditionally convergent Fourier integral.

**From pphi2:** at least four helper axioms were later found **false as stated** and removed, and several more were restated after their unrestricted forms were refuted (per `AXIOM_AUDIT.md`; *verifier correction* of "three"). Some refutations came from the agents' own cross-model reviews, e.g. Gemini/Codex verdicts recorded in the audit. Axiom vetting is not optional.

**From math-commons:** keep verification, assumption review and validation as separate artifacts.

**From OpenAI:** a Mathlib-only challenge, kernel replay through a second kernel, and machine-generated `formalization.yaml` counts.

---

## 5. Open questions / leads

1. **Exact OpenAI statement.** When the shepherding committee releases the Lean YM proof (expected around 2026-11-09 to 11-13; note 02), diff its trusted definitions against ours. In particular check: test-function space, field content (Wilson loops or composite fields), torus or $\mathbb R^4$, subsequential or full limit, how it encodes the lattice ↔ continuum link, and which external libraries it vendors.
2. **Does OSreconstruction accept our Schwinger family?** Its `OS` structure uses zero-diagonal Schwartz tests on configuration space and an arity-linear growth bound. Ours uses multilinear Schwinger functions with disjoint supports and an E0′-type bound. Write bridge (a)/(b) and check that our `OS.Growth` implies `arityLinearGrowth`.
3. **Inhabitedness and vacuity.** OSreconstruction found two defects in its *own* earlier statements.
   - Its old forward-tube growth clause was unsatisfiable for the free field.
   - Its old fixed-order Euclidean growth condition forces Schwartz order zero. The trivial field satisfies it, but it excludes the massive free field in spatial dimension 3 (`gffOS_no_linearGrowth`, formalized in the private companion repo).
   
   *Verifier precision:* the author's phrase "satisfied only by trivial theories" overstated what the README shows. Our `OSAxioms ∧ NonTrivial ∧ IsWilsonLimit` needs analogous sanity theorems, e.g. that the GFF or Wick powers satisfy `OSAxioms` but not `IsWilsonLimit`. The repo already has a `Sanity.lean`; extend it.
4. **Is Schwartz-space completeness really missing upstream?** Check Mathlib master after Oct 27, and how gaussian-field and bochner obtain it (Banach–Steinhaus is needed for kernel/Minlos arguments).
5. **Haar bi-invariance on compact groups.** Check whether `lgt` already proves it (its gauge-invariance lemmas need it) and whether it is upstreamable.
6. **SU(N) as a Lie group.** Is anyone upstreaming charts on closed matrix subgroups? Search Zulip, `lean-index-lie` and TauCeti roadmaps.
7. **PhyslibAlpha spectral theorem trust level.** Build it, run `lake check`/Comparator on `unboundedSpectralTheorem` and `stoneCandidateGenerator_reconstruction`, and record the result.
8. **Private `math-commons/yang-mills`.** The OSreconstruction README says access is available on request. It reportedly inhabits the reconstruction input with GFF and Proca Wick-square fields, and may be the closest existing artifact to our needs.
9. **Reflection positivity of the Wilson action in Lean.** Not found anywhere. It is a natural, self-contained first target. It would combine lgt's lattice and measure definitions with the `reflection-positivity` abstract template.
10. **Navier–Stokes swarm and OpenAI orchestration.** Note 03 covers the orchestration. The infrastructure-relevant question is whether OpenAI's YM Lean vendored the Douglas/Yin libraries or rebuilt them; the dependency list of the release will show this.

---

## 6. References

Verification flag meanings: **verified = yes** means I confirmed existence via the arXiv API, Crossref, GitHub API or raw source, or local compilation. Repository sorry/axiom counts remain self-reported unless marked [Lc].

1. The mathlib Community, *The Lean Mathematical Library*, CPP 2020. arXiv:1910.09336; DOI 10.1145/3372885.3373824. — verified (arXiv API + Crossref).
2. Mathlib source, `leanprover-community/mathlib4` commit `9d581dfff2e41de989072ea63abf3daf69311520` (2026-10-27), local checkout at `lean/YangMills/.lake/packages/mathlib`; https://github.com/leanprover-community/mathlib4 — verified (local source + compiled `#check`).
3. Mathlib docs, `Mathlib.Analysis.Distribution.TemperedDistribution`: https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Distribution/TemperedDistribution.html — verified (fetched).
4. Mathlib PR #44909, *feat(MeasureTheory): the Kolmogorov extension theorem* (R. Degenne, co-author P. Pfaffelhuber), merged 2026-11-05: https://github.com/leanprover-community/mathlib4/pull/44909 — verified (GitHub API, file list).
5. Mathlib PR #45494, *the cylinder σ-algebra on the weak dual* (open): https://github.com/leanprover-community/mathlib4/pull/45494 — verified.
6. Mathlib PRs #42278 *Nuclear space*, #42197 *define nuclear operator*, #42127 *projective locally convex tensor product* (open): https://github.com/leanprover-community/mathlib4/pull/42278 , /pull/42197 , /pull/42127 — verified (GitHub search API).
7. Mathlib PRs #37932 *Exponential map of Lie group is smooth*; #30121 *principal fiber bundle core*; #38374 *Principal Bundles, Connection 1-forms and the Frame Bundle*; #45069 *Riemann curvature of a covariant derivative*; #45543 *eigenvectorBasis for compact self-adjoint operators* (all open): https://github.com/leanprover-community/mathlib4/pulls — verified (gh search).
8. L. de Moura, S. Ullrich, *The Lean 4 Theorem Prover and Programming Language*, CADE-28 (LNCS), 2021. DOI 10.1007/978-3-030-79876-5_37 — verified (Crossref).
9. M. R. Douglas, S. Hoback, A. Mei, R. Nissim, *Formalization of QFT*, arXiv:2603.15770 (2026). — verified (arXiv API; PDF read; already in library/pdfs).
10. `mrdouglasny/OSforGFF` (Cherkis, Douglas, Hoback, Mei, Nissim): https://github.com/mrdouglasny/OSforGFF — verified (README, `OS/Axioms.lean`, `Spacetime/Basic.lean`, lakefile read).
11. `mrdouglasny/bochner` (Bochner and Minlos theorems): https://github.com/mrdouglasny/bochner — verified (README; tree sizes). Its toolchain is v4.33.0-rc1; the README's v4.28.0-rc1 is stale.
12. `mrdouglasny/gaussian-field`: https://github.com/mrdouglasny/gaussian-field — verified (README; tree sizes; branch list; the kernel-theorem file is on `main`).
13. `mrdouglasny/pphi2`: https://github.com/mrdouglasny/pphi2 — verified (README and `AXIOM_AUDIT.md`, re-read by verifier).
14. `mrdouglasny/lgt` (Douglas, Rajasekaran): https://github.com/mrdouglasny/lgt — verified (README, lakefile).
15. `mrdouglasny/hille-yosida`, `reflection-positivity`, `spectral-positivity`, `markov-semigroups`, `gaussian-hilbert`: https://github.com/mrdouglasny — verified (READMEs via `gh api`).
16. `mrdouglasny/lean-index-qft` (topic index of constructive-QFT Lean declarations): https://github.com/mrdouglasny/lean-index-qft — verified (README).
17. `xiyin137/OSreconstruction`: https://github.com/xiyin137/OSreconstruction — verified (README, `verification/comparator/Definitions.lean`, comparator README, lakefile, file tree).
18. `mrdouglasny/OSreconstruction-comparator` and `mrdouglasny/OSforGFF-comparator`: https://github.com/mrdouglasny — verified (listed via GitHub API).
19. `xiyin137/Phi4`: https://github.com/xiyin137/Phi4 — verified (README).
20. `leanprover-community/physlib` (formerly HEPLean/PhysLean): https://github.com/leanprover-community/physlib — verified (GitHub API redirect from HEPLean/PhysLean; README; raw files `Relativity/LorentzGroup/Basic.lean`, `MinkowskiMatrix.lean`, `SpecialUnitary/LieAlgebra/*`, `PhyslibAlpha/.../Unbounded/*`, `LatticeQFT/Basic.lean`).
21. J. Tooby-Smith, *HepLean: Digitalising high energy physics*, arXiv:2405.08863 (2024). — verified (arXiv API; PDF downloaded).
22. J. Tooby-Smith, *Formalization of physics index notation in Lean 4*, arXiv:2411.07667 (2024). — verified (arXiv API; PDF downloaded).
23. J. Tooby-Smith, *Digitalizing Wick's theorem*, arXiv:2505.07939 (2025). — verified (arXiv API; PDF downloaded).
24. R. Degenne, D. Ledvinka, E. Marion, P. Pfaffelhuber, *Formalization of Brownian motion in Lean*, arXiv:2511.20118 (2025). — verified (arXiv API; PDF downloaded).
25. `RemyDegenne/kolmogorov_extension4`: https://github.com/RemyDegenne/kolmogorov_extension4 — verified (Reservoir listing; GitHub tree).
26. Lean FRO, `leanprover/comparator` (archived; merged into core as `lake comparator`/`lake check`): https://github.com/leanprover/comparator — verified (README fetched; `lake comparator --help` in local v4.36.0-rc2).
27. M. Carneiro, *Lean4Lean: Verifying a Typechecker for Lean, in Lean*, arXiv:2403.14064. — verified (arXiv API; already in library/pdfs).
28. P. Massot, `leanblueprint`: https://github.com/PatrickMassot/leanblueprint — verified (README).
29. H. Zhu, `LeanArchitect`: https://github.com/hanwenzhu/LeanArchitect — verified (README).
30. OpenAI, `openai/ten-proofs`: https://github.com/openai/ten-proofs — verified (README, formalization.yaml, lakefile, challenges, file sizes; NonSoficGroup.lean downloaded and counted).
31. OpenAI, `openai/math`: https://github.com/openai/math — verified (README, history.md, `lean/lakefile.lean`, `lake-manifest.json`, `formalization.yaml`, patches listing). The verifier also took untruncated per-area tree listings of `lean/OAI/`.
32. `math-commons/formalization-assurance`: https://github.com/math-commons/formalization-assurance — verified (README and tree).
33. `lean-dojo/LeanMillenniumPrizeProblems`: https://github.com/lean-dojo/LeanMillenniumPrizeProblems ; Reservoir page https://reservoir.lean-lang.org/@lean-dojo/problems — verified (Reservoir page fetched; the verifier also read the repo README and `Problems/YangMills/Millennium.lean`, whose headline is `MillenniumYangMills.ClayYangMills`).
34. K. Osterwalder, R. Schrader, *Axioms for Euclidean Green's functions*, Commun. Math. Phys. 31 (1973). DOI 10.1007/BF01645738 — verified (Crossref).
35. K. Osterwalder, R. Schrader, *Axioms for Euclidean Green's functions II*, Commun. Math. Phys. 42 (1975). DOI 10.1007/BF01608978 — verified (Crossref).
36. J. Glimm, A. Jaffe, *Quantum Physics: A Functional Integral Point of View*, 2nd ed., Springer 1987. DOI 10.1007/978-1-4612-4728-9 — verified (Crossref).
37. L. Becker, M. I. de Frutos-Fernández, L. Diedering, F. van Doorn, S. Gouëzel, A. Jamneshan, et al., *A blueprint for the formalization of Carleson's theorem on convergence of Fourier series*, arXiv:2405.06423 — verified (arXiv API; PDF downloaded). Calibration example of a large analysis formalization.
38. M. R. Douglas, *Axioms for physical reasoning: codifying the Seiberg–Witten solution in Lean*, arXiv:2607.06379 (2026). — verified (arXiv API; already in library/pdfs).
39. N. Craig, *A gauge-invariant measure for lattice chiral fermions*, arXiv:2610.09093 (2026). — verified (arXiv API; already in library/pdfs; Lean-companion details in note 02).
40. `oliver-butterley/SpectralThm` (bounded normal spectral theorem, ongoing; maintainers O. Butterley, Y. Tanimoto): https://github.com/oliver-butterley/SpectralThm — verified (GitHub API and README read by the verifier).
41. `or4nge19/OSforGFF` (Minlos-free construction by Matteo Cipollina): https://github.com/or4nge19/OSforGFF — verified. *Verifier upgrade:* the repo exists (GitHub API; owner name Matteo Cipollina; toolchain v4.28.0). Its README describes the pipeline from finite-dimensional Gaussians through Kolmogorov extension and nuclear support to a pushforward to `WeakDual`.
42. Private `math-commons/yang-mills` (rev `03bb758`) — **verified = false**. It is mentioned in the OSreconstruction package README. The GitHub API returns 404, consistent with a private repo.

---

## Verification log

*Adversarial verification pass, 2026-11-05 (US time; GitHub/arXiv queries ran 2026-11-06 UTC).* The verifier edited the note in place, and each in-text correction carries the label "verifier correction", "verifier note" or "verifier addition". The web-search budget for this run was exhausted before any search was made. All checks below therefore used direct primary sources: the arXiv API, Crossref, the authenticated GitHub API (`gh`), WebFetch of the KITP committee PDFs and the Reservoir page, and local compilation.

### References checked (42 of 42)

- **arXiv (10).** The arXiv API returned titles and authors that match the note for all ten IDs:
  - 1910.09336, 2603.15770, 2405.08863, 2411.07667, 2505.07939;
  - 2511.20118, 2403.14064, 2405.06423, 2607.06379, 2610.09093.
  
  All ten PDFs are present in `library/pdfs`, and the arXiv ID on each first page matches its file name. No PDF was mis-ID'd, none was deleted and none was downloaded.
- **DOIs (5).** Crossref confirms all five. CPP 2020 pp. 367–381; CADE-28 LNCS pp. 625–635; CMP 31 (1973) 83–112; CMP 42 (1975) 281–305; Glimm–Jaffe, Springer 1987.
- **Mathlib PRs (10).** GitHub API confirms titles, authors and state.
  - #44909 is Bors-merged. Its squash commit `c6d1307d6b` landed on 2026-11-05 at 13:31 UTC, and the PR was closed at 13:38 UTC. The commit is co-authored by Degenne and Pfaffelhuber.
  - The new file declares `MeasureTheory.projectiveLimit`, `isProjectiveLimit_projectiveLimit` and the finite/probability instances, together with `addContent_iUnion_eq_sum_of_innerRegular`.
  - #45494 (chenle02), #42278/#42197/#42127 (mpacholski), #37932/#30121/#38374 (idontgetoutmuch), #45069 (korbonits) and #45543 (TJHeeringa) are all open.
- **GitHub repositories (31 cited).** All exist except the private `math-commons/yang-mills`, which returns 404 as expected. Owner names were confirmed: xiyin137 is Xi Yin, mrdouglasny is Michael R. Douglas, or4nge19 is Matteo Cipollina and chenle02 is Le Chen. `HEPLean/PhysLean` redirects to `leanprover-community/physlib`. `leanprover/comparator` is archived.
- **URLs.** The Mathlib docs page and the Reservoir page both return HTTP 200.
- **Status upgrades.** Ref. 41 (or4nge19/OSforGFF) and ref. 40 (SpectralThm) were upgraded from unverified/not-read to verified. Ref. 42 remains unverifiable because the repo is private.
- **Fabricated references found: none.**

### Key claims checked against sources

1. **Local pin and compilation.** `lake-manifest.json` gives mathlib `9d581dff…`, committed 2026-10-27 as "bump toolchain to v4.36.0-rc2". The toolchain is v4.36.0-rc2, the draft statement is 853 lines and `SU.lean` is 86 lines, all **confirmed**. The verifier re-ran `#check` on 23 of the listed declarations against the pinned oleans, and all resolved. One name sits in the root namespace rather than `MeasureTheory`: `isCompact_closure_of_isTightMeasureSet`; the note did not give a namespace, so this needs no change. Instance probes confirmed four behaviours:
   - `CompactSpace (Matrix.unitaryGroup (Fin n) ℂ)` fails to synthesize;
   - `IsProbabilityMeasure`, `IsMulRightInvariant` and `IsInvInvariant` all fail for `haarMeasure ⊤` on a compact non-abelian group;
   - `IsMulLeftInvariant` succeeds;
   - `IsHaarMeasure.isInvInvariant_of_regular` is stated only in a `CommGroup` section.
2. **Mathlib gaps** were confirmed by grep:
   - no `nuclear` anywhere;
   - no `CompleteSpace` instance for 𝓢;
   - no Lorentz group or Minkowski space;
   - `GaussianProjectiveFamily.lean` says Kolmogorov extension is "not in Mathlib yet";
   - `InnerProductSpace/Spectrum.lean` has a TODO for spectral theory of bounded self-adjoint operators;
   - `GelfandNaimarkSegal.lean` has a cyclic-vector TODO;
   - the standard-subspace file has a Tomita TODO;
   - the `Distribution.lean` docstring mentions the Schwartz kernel theorem.
   
   Mathlib's size of 2,349,087 lines / 99.2 MB was reproduced exactly.
3. **Comparator.** The archived README says it was merged into core as of v4.35.0. Local `lake comparator --help` and `lake check --help` confirm `bwrap`, the `--paranoid` checker list (leanchecker-paranoid, lean4lean, nanoda, con-leche, con-ron), the config fields and the exit codes 0/1/2. *Added:* the standalone tool used `landrun`, so lgt's Comparator acceptance was obtained with the insecure macOS shim.
4. **OSreconstruction.** Confirmed: no `sorry`, no project axioms, a Comparator challenge, `Definitions.lean` of 497 lines, toolchain v4.35.0-rc4, a gaussian-field dependency and 14.81 MB of `.lean` (recomputed). Also confirmed: zero-diagonal Euclidean tests, operator/GNS reconstruction "not an endpoint", and the private `math-commons/yang-mills` at rev `03bb758` with GFF and Proca Wick-square inhabitants. *Precision added* on the earlier vacuity issue (§5, item 3).
5. **OSforGFF.** Confirmed: works for any d ≥ 2, 0 sorries and 0 axioms, about 25.5k on-graph lines, `Guardrails.lean`, toolchain v4.33.0-rc1, and authors Cherkis, Douglas, Hoback, Mei and Nissim. A separate OSforGFF-comparator repo runs Comparator with the NanoDa kernel. The Minlos-free fork by Cipollina is confirmed.
6. **pphi2.** Confirmed: 26 axioms and 0 sorries as of 2026-10-08, with `pphi2_existence` resting on 5 named axioms including `pphi2_limit_exists`. **Corrected:** "three axioms found false" is an undercount; at least four were removed as false as stated, and others were restated. Its Lean version is v4.30.0, not "not stated".
7. **lgt.** Confirmed: coupling β < 1/(32n(d−1)), the theorems `ym_mass_gap_exponential_decay` and `ym_mass_gap_rate_exists`, 0 sorries and 0 project axioms, Douglas with Rajasekaran, toolchain v4.30.0, and Comparator accepted at `ec975bd` using `fake-landrun.sh`.
8. **openai/ten-proofs.** Confirmed: v4.32.0, mathlib `v4.32.0` and Comparator `v4.32.0` as dependencies, 21.59 MB across ten monolithic files (0.13–5.3 MB), the 1,117-byte `D_NonSoficGroup.lean` challenge, `enable_nanoda: true`, and provenance "agent-reviewed / Astra (OpenAI) / Codex / 1 week".
9. **openai/math.** Confirmed: v4.34.1, Mathlib `d13f23b…`, created 2026-10-06, 208 `comparator_config` entries, the `vm.max_map_count` / `-DMMAP=OFF` note, and the VlasovMaxwell `Model.lean` style with hand-rolled `divergence` and `curl`. **Corrected:**
   - The size is ≈ 1.78 GB in 162k files, about 18× Mathlib, not "≥ 474 MB, ≥ 4×".
   - There are 23 patch files, not one per dependency.
   - "300 / 719" comes from `history.md` (2026-10-07), not the README.
10. **OpenAI YM committee.** WebFetch of the KITP PDFs plus `pdftotext` confirm the committee members, the "1147-page LLM proofs", that confinement and the mass gap remain open, that OpenAI is providing a Lean formalization, and that Gross was asked to take custody on 16 Oct. The 2026-11-03 statement says the Lean proof will be released "hopefully next week", announced a full day in advance. This is consistent with the note's "expected around 2026-11-09 to 11-13". The YM existence claim itself remains **unreleased and unverified**.
11. **Douglas et al., arXiv:2603.15770.** Confirmed in the PDF text:
    - Mathlib grows "about 300K lines/year";
    - the backward-chaining helper-lemma axioms, cross-validation by other models (Claude, Gemini, GPT) and numerical spot checks;
    - textbook-style lemmas free of project-specific types reduced false conjectures;
    - unit tests;
    - the conditionally convergent Fourier-integral definition of the covariance, later replaced by a Bessel-function form.
12. **Physlib.** Confirmed:
    - `SULieAlgebra.killingForm_eq_trace`, with Killing form $-2n\,\mathrm{tr}(AB)$ on the complexification;
    - `unboundedSpectralTheorem` (a `lemma`) in `CayleySpectralData/SpecTheorem.lean`, authored by Tom Ole Diem;
    - the `Unbounded/` directory: 48 files, 0.99 MB ≈ 24k lines;
    - `LatticeQFT/Basic.lean` is a stub;
    - toolchain v4.35.0;
    - 19.8 MB in 1,613 `.lean` files;
    - the PhyslibAlpha "one-look" review and its policy that broken contributions are not maintained.
13. **Other corrections:**
    - gaussian-field's `extension` branch no longer exists; the kernel theorem is on `main`.
    - The bochner toolchain is v4.33.0-rc1.
    - gaussian-hilbert still has one placeholder axiom, for hypercontractivity.
    - markov-semigroups postulates 8 textbook axioms.
    - seiberg-witten's physics postulates are hypotheses, not Lean axioms.
    - The LeanMillennium headline is `MillenniumYangMills.ClayYangMills`.
    - `AddCircleMulti` is a file name.
14. **§1.1 mathematical content** was not changed. The Euclidean mass-gap formulation via the truncated reflection-positivity form, and its equivalence to $\operatorname{spec}H\subset\{0\}\cup[m,\infty)$ after OS reconstruction, is standard: it is a bound on $e^{-tH}$ restricted to $\Omega^\perp$ on a dense set. It requires the bound for *all* $F,G$ in the positive-time algebra.

### Residual concerns

- Every sorry/axiom count for external repositories is still **self-reported**. The verifier rebuilt none of them; only `#print axioms` on a local build would settle them. Note in particular that OSforGFF calls bochner and gaussian-field "axiom-free" for its import path, while gaussian-field's WIP `Cylinder/` module (3 axioms) is outside its default build.
- External repos are moving fast; the verifier saw pushes on 2026-11-02 and 11-03. Branch names, file paths and toolchains can go stale within days, as the gaussian-field and bochner README drift shows. Pin by commit hash before relying on any of them.
- The line counts in §4.2 come from byte sizes, and the AI-density extrapolation stays a rough inference. The new openai/math data point (≈ 140k lines per formalized result, including certificates) suggests the upper end of the "1–4M lines" range is not conservative.
- The private `math-commons/yang-mills` repository cannot be inspected.
- The web-search budget was exhausted, so no secondary-press cross-check was possible in this pass. The OpenAI blog post itself was not re-fetched; note 02 records that it returns 403.
