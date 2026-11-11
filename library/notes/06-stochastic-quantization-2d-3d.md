# 06 — Stochastic quantisation and the 2D/3D continuum Yang–Mills frontier

- **Workstream key:** `06-stochastic-quantization-2d-3d`
- **Compiled:** 2026-11-05 (live sources: arXiv API, Crossref, primary PDFs read via alphaXiv; see §7). **Adversarially verified:** 2026-11-05 (see the Verification log at the end)
- **Scope:** 2D Yang–Mills (YM) measure (exact-solvability and random-distribution constructions); stochastic quantisation (SQ) of YM and Yang–Mills–Higgs (YMH) in 2D and 3D; state spaces for 3D gauge orbits; the regularity-structures and paracontrolled machinery and why it stops at d = 4; the strongest current frontier results toward d = 3 and d = 4.
- **Status legend used below:** **[THM]** published, refereed theorem. **[PREPRINT]** arXiv, by established authors, not yet refereed (treat as very likely correct but unverified by us). **[CLAIM]** announced and not publicly checkable. **[HEUR]** heuristic, folklore or physics expectation. **[OPEN]** open problem.

---

## Summary

Stochastic quantisation realises a Euclidean field theory as the invariant measure of a Langevin stochastic PDE. For gauge theories it was proposed by Parisi and Wu in 1981 [1] precisely because it allows one to avoid choosing a gauge. Between 2018 and 2026 a group centred on Chandra, Chevyrev, Hairer and Shen (CCHS), with Bringmann, Cao, Chatterjee, Zhu and others, turned this into a rigorous programme in finite volume on the torus. The state of play on 5 Nov 2026 is as follows.

1. **d = 2, pure YM: essentially complete.** The 2D YM measure on surfaces has been constructed for decades by exact solvability [3–12]. Chevyrev realised it on T² as a random distributional 1-form [13]. CCHS built the gauge-covariant Langevin dynamic as a Markov process on a Polish space of gauge orbits [15]. Chevyrev–Shen proved that the YM measure is its **unique invariant measure**, that the Markov process on gauge orbits never blows up (global existence *on orbits*; global existence of the gauge-fixed SYM itself is not claimed, Remark 2.17 of [19]), and that lattice gauge theories (Wilson, Villain, Manton) are **universal**, i.e. all converge to it [19] **[THM, CPAM 2026]**. Several independent 2026 results followed: a gauge-fixed representation of the YM measure on the unit square with optimal regularity, obtained via rough Uhlenbeck compactness and a singular elliptic Coulomb-gauge PDE [30]; a construction plus lattice universality on compact surfaces of any genus [31]; and a Morse-theory construction [32] **[PREPRINT]**.
2. **d = 2, non-Abelian YMH: just constructed.** On 2 Nov 2026 Bringmann, Cao, Hairer and Zhao posted a 350-page construction of the non-Abelian YMH measure on T², for all fixed couplings, as the unique invariant measure of the Langevin dynamic [27] **[PREPRINT]**. The authors say (Remark 1.6, "to the best of our knowledge") it is the first example of a classical Euclidean QFT constructed *only* by SQ. It contains an explicit AI disclosure: GPT-6 Astra and GPT-5.6 Sol proved a handful of technical lemmas.
3. **d = 3: local theory only; the measure is not constructed.** CCHS constructed a nonlinear state space, local-in-time renormalised solutions, a unique gauge-covariant mass renormalisation, and a Markov process on gauge orbits that may blow up in finite time [16] **[THM, Invent. Math. 2024]**. Chevyrev–Shen proved uniqueness of that renormalisation [20] **[THM, ARMA 2026]**. Cao–Chatterjee gave a gradient-flow state space and a *conditional* tightness criterion [21, 22] **[THM]**. The 3D Abelian lattice Langevin dynamic has a Gaussian scaling limit [33] **[PREPRINT]**. **Global existence of 3D stochastic YM(H), an invariant measure, and hence any construction of the 3D non-Abelian YM measure all remain [OPEN].**
4. **d = 4: SPDE methods do not apply.** The YM Langevin equation is *scaling-critical* exactly at d = 4. Regularity structures, paracontrolled calculus and the flow-equation method all require subcriticality. At d = 4 there are infinitely many logarithmically divergent trees, and asymptotic freedom forces a bare coupling that vanishes logarithmically. Handling that needs a genuine multiscale renormalisation group (Balaban-type) analysis, which no SPDE method currently supplies. The main rigorous constructive inputs for non-Abelian YM in 4D remain Balaban's lattice ultraviolet-stability programme [62, 63] (his 3D analogue is [61]) and Magnen–Rivasseau–Sénéor's infrared-cutoff construction [64]; Abelian $U(1)_4$ is Gaussian (Driver [65b]). OpenAI's announced 4D existence proof (26 Oct 2026) is described by its shepherding committee as having Balaban's ideas "among the important elements" (BCHZ: "building in part on Balaban's work"); nothing public indicates SQ. It remains **[CLAIM]**: the 1,147 pages and the Lean files had not been released at the time of writing [73, 74].

**Bottom line for this project:** SQ is unlikely to be the *construction* route in 4D. It is the most powerful available tool for (a) gauge-orbit state spaces and gradient-flow-regularised Wilson-loop observables, (b) identifying limits and proving universality once a measure exists, and (c) proving functional inequalities (and hence mass gaps) via Bakry–Émery or Polchinski-type multiscale arguments. It also supplies the clearest formal language for gauge-invariant observables of rough connections, which matters for a Lean problem statement.

---

## 1. Key definitions and statements

### 1.1 The formal measure and gauge symmetry

Fix a compact Lie group $G$ with Lie algebra $\mathfrak g$, an Ad-invariant inner product on $\mathfrak g$, and the trivial bundle over $\mathbb T^d$. A connection is a $\mathfrak g$-valued 1-form $A=(A_1,\dots,A_d)$, with curvature
$$F_{ij}(A)=\partial_iA_j-\partial_jA_i+[A_i,A_j].$$
The formal YM measure is
$$\mu(\mathrm dA)=Z^{-1}\exp\Big(-\tfrac{1}{2g^2}\int_{\mathbb T^d}|F(A)|^2\Big)\,\mathcal DA .$$
Gauge transformations $g:\mathbb T^d\to G$ act by $A^g=\mathrm{Ad}_gA-(\mathrm dg)g^{-1}$. The physical state space is the orbit space $\mathcal O=\{A\}/\!\sim$, which is nonlinear when $G$ is non-Abelian. For YMH, one adds a Higgs field $\Phi$ valued in an orthogonal representation $V$, with energy
$$\int \tfrac12|F_A|^2+\tfrac12|D_A\Phi|^2+\tfrac14|\Phi|^4+\tfrac12\langle\Phi,M\Phi\rangle$$
(Setting 1.1 of [27]).

### 1.2 Langevin dynamic, the DeTurck–Zwanziger trick, gauge covariance

The Langevin equation $\partial_tA=-\mathrm d_A^*F(A)+\xi$, with $\xi$ space-time white noise, is **not parabolic**. The YM energy is constant along infinite-dimensional gauge orbits, so its Hessian has an infinite-dimensional kernel. Following Zwanziger [2], DeTurck and Donaldson, one adds a term $-\mathrm d_A\mathrm d_A^*A$ that is tangent to the orbit. This gives the stochastic YM (SYM) equation (equation (1.3) of [17]):
$$\partial_tA_i=\Delta A_i+[A_j,\,2\partial_jA_i-\partial_iA_j+[A_j,A_i]]+\xi_i\qquad(\text{schematically } \partial_tA=\Delta A+A\partial A+A^3+\xi).$$
**Formal gauge covariance.** If $B=A^g$ with $(\partial_tg)g^{-1}=\mathrm d_B^*(Z^g-Z)$, then $B$ solves the same equation driven by $\mathrm{Ad}_g\xi$. That noise has the same law as $\xi$ by Itô isometry when $g$ is adapted. Hence the projected process $[A(t)]$ on $\mathcal O$ should be Markov, and its invariant measure is "the" YM measure. This is the Parisi–Wu idea made concrete. Making it rigorous is the content of [15, 16].

### 1.3 Regularity, power counting, criticality

With parabolic scaling, white noise on $\mathbb R\times\mathbb T^d$ lies in $\mathcal C^{-(d+2)/2-\kappa}$, so $A\in\mathcal C^{1-d/2-\kappa}$ (no better). The products $A\partial A\in\mathcal C^{1-d-2\kappa}$ and $A^3$ are therefore analytically ill-defined for $d\ge2$. **Subcriticality**, the hypothesis of Hairer's theory [42] and of paracontrolled calculus [47], requires the nonlinearity to be more regular than the noise:
$$1-d>-\tfrac{d+2}{2}\iff d<4\qquad(\text{the same threshold for }A^3).$$
Equivalently, restore the coupling ($\partial_tA=\Delta A+gA\partial A+g^2A^3+\xi$) and rescale $A_\lambda(t,x)=\lambda^{(d-2)/2}A(\lambda^2t,\lambda x)$. The law of the noise is invariant, and the coupling becomes $g_\lambda=\lambda^{(4-d)/2}g$. At small scales ($\lambda\to0$) the nonlinearity switches off iff $d<4$; this is super-renormalisability in QFT language. **At d = 4 the classical scaling is exactly marginal.** Quantum corrections make it marginally irrelevant in the UV (asymptotic freedom): $\beta(g)=-b_0g^3+O(g^5)$ with $b_0=\tfrac{11}{3}\tfrac{C_2(G)}{16\pi^2}$, so $g^{-2}(\mu)\approx 2b_0\log(\mu/\Lambda)$ **[HEUR/perturbative, standard]**. The coupling flows to zero only logarithmically, and every order of perturbation theory produces log divergences. This is the precise sense in which 4D is beyond SPDE technology (§2.10).

### 1.4 Renormalisation and the gauge-covariant mass

For a space-time mollifier $\chi$ and $\xi^\varepsilon=\chi_\varepsilon*\xi$, the renormalised equation is
$$\partial_tA=\Delta A+A\partial A+A^3+\xi^\varepsilon+(C^\varepsilon_{\rm bphz}+\mathring C)A,$$
with $C^\varepsilon_{\rm bphz}\in L_G(\mathfrak g,\mathfrak g)$ (operators commuting with $\mathrm{Ad}$). Symmetry arguments force the counterterm to be a "mass" term, block-diagonal and Ad-equivariant (§4 of [16]; [17]). In **2D**, a cancellation makes $C^\varepsilon_{\rm bphz}$ converge to a finite limit. In **3D** it diverges like $\varepsilon^{-1}$ (Remark 1.10 of [17]). The mass term breaks gauge covariance at fixed $\varepsilon$, and so does the mollified noise, which breaks Itô isometry. **There is a unique bare mass $\check C$ for which the two defects cancel in the limit** and the limiting dynamic is gauge covariant in law (Thm 2.9 of [15]; Thm 1.9 of [16]). In the Abelian case $\check C=0$ is unique on $\mathbb T^d$ and the dynamic is linear (§1.4 of [17]); uniqueness uses that $\mathbb T^d$ is not simply connected and **fails on $\mathbb R^d$** (Remark 1.16 of [17]), and the Abelian SYM with $\check C=0$ has global solutions but no invariant probability measure (Remark 1.17 of [17]). Uniqueness of the gauge-covariant mass in the strongest sense (no other mass gives a Markov process on orbits) is proved in 2D by [19] (Thm 2.15/8.1) and in 3D by [20].

### 1.5 State spaces of gauge orbits

- **2D (CCHS [15]; Chevyrev [13]).** $\Omega^1_\alpha$ is a Banach space of distributional 1-forms controlled through line integrals ($|\int_\ell A|\lesssim|\ell|^\alpha$ with variation control). It embeds in $\mathcal C^{\alpha-1}$ and supports the GFF. The group $\mathfrak G^{0,\alpha}$ of (little) $\alpha$-Hölder gauge transformations acts on it; several lemmas need only $\alpha>1/2$ (Young integration), but the continuous group action and the orbit space are set up for $\alpha\in(\tfrac23,1]$ (Cor. 3.36, Def. 3.37 of [15]). The quotient $\mathcal O_\alpha=\Omega^1_\alpha/\mathfrak G^{0,\alpha}$ is **Polish** for $\alpha\in(\tfrac23,1)$, and holonomies (Wilson loops) are continuous functions on it.
- **3D (CCHS [16]).** Line integrals of the 3D GFF do not exist, so there is no line-integral space. $\mathcal S$ is a **nonlinear** complete metric space of distributions in $\mathcal C^\eta$, $\eta\in(-\tfrac12-\kappa,-\tfrac12)$, defined by controlling heat-flow quadratic terms $P_tX\cdot\nabla P_tX$ and heat-regularised line integrals. Gauge equivalence is *defined* via the deterministic DeTurck–YM flow: $X\sim Y$ iff their flows agree modulo smooth gauge. The quotient is only known to be separable and completely Hausdorff, not Polish. Gauge-invariant observables are **smoothened Wilson loops**: classical Wilson loops evaluated after running the YM flow for time $t>0$. Nonlinearity is unavoidable: no Banach space carrying the 3D GFF supports a continuous extension of the YM flow [18].
- **3D (Cao–Chatterjee [22], after Charalambous–Gross [23, 24]).** $\mathcal X$ is the space of all solutions of the YM heat flow on $(0,\infty)$ modulo gauge, topologised by regularised Wilson loops $W_{\ell,\chi,t}(X)=W_{\ell,\chi}(X(t))$. Caveat: [22] assumes $G$ is a finite product of groups from $\{T^n,U(n),SU(n),O(n),SO(2n+1)\}$, because it uses Sengupta's result that Wilson loops separate gauge orbits (Lemma 1.2, Remark 1.3 of [22]). CCHS's $\mathcal S/\!\sim$ embeds canonically into $\mathcal X$ (Remark 2.14 of [16]).

**Design note for Lean:** in every dimension above 2, the rigorous literature defines gauge-invariant observables of rough connections by gradient-flow smoothing. That is also Lüscher's flowed observables in lattice QCD, shown to be UV-finite in perturbation theory [67, 68]. A 4D Lean problem statement should probably quantify over flowed observables rather than bare Wilson loops (§4.3).

---

## 2. Detailed findings

### 2.1 2D YM via exact solvability (1989–2010)

- **Gross–King–Sengupta [3] and Driver [4] (1989), on the plane.** In axial gauge the curvature is a white noise, and holonomies solve SDEs. The holonomy around a simple loop is a $G$-valued Brownian motion run for a time proportional to the enclosed area. Driver proved lattice convergence and handled general loops via lassos. **[THM]**
- **Fine [5], Witten [6], Sengupta [7] (1991–97), on compact surfaces.** These give the partition function $Z=\sum_\rho d_\rho^{2-2\gamma}e^{-c_\rho T/2}$ (Migdal–Witten formula) and a construction via conditioned Brownian motions. **[THM]** for Fine's and Sengupta's rigorous work; Witten's 1991 derivation is physics-level (Migdal's lattice heat-kernel argument underlies it).
- **Lévy [8–10] (2003–2010).** A complete construction of the YM holonomy process on compact surfaces, including nontrivial bundles [9] and the axiomatics of Markovian holonomy fields [10]. Discrete approximations converge by *invariance under subdivision*, an exact-solvability property special to 2D pure YM. Surveys: [11, 12]. **[THM]**
- **What these constructions do and do not give.** They construct a stochastic process indexed by loops, not a measure on a space of connections. The SQ programme needs the latter. The exact-solvability tools (subdivision invariance, axial gauge killing all nonlinearity) **do not survive** the addition of a Higgs field or a third dimension. That is why non-Abelian 2D YMH was open until [27].

### 2.2 Chevyrev 2019: the 2D YM measure as a random distribution [13]

There is an $\Omega^1_\alpha$-valued random variable $A$ whose axis-path Wilson loops have the law of Lévy's YM measure, with $A\in\mathcal C^{\alpha-1}$ for all $\alpha<1$, i.e. GFF regularity. The method is lattice approximation plus **axial gauge on large scales and a Landau/Coulomb-type gauge on small scales**, with uniform bounds via rough-path estimates for $G$-valued random walks. It assumes $G$ simply connected for the gauge-fixed representation. **[THM, CMP 2019]**

### 2.3 CCHS 2D: Langevin dynamic for the 2D YM measure [15]

**Proven [THM, Publ. IHÉS 2022]:**
1. $\Omega^1_\alpha$ and the Polish orbit space $\mathcal O_\alpha$, with continuous holonomies.
2. Local well-posedness of the renormalised SYM in $\Omega^1_\alpha$ via regularity structures.
3. A "basis-free" (vector-valued) formalism for regularity structures.
4. Gauge covariance in law for the unique $\check C$ (DeTurck trick plus a coupling with time-dependent gauge transformations).
5. A canonical Markov process on $\mathcal O_\alpha\sqcup\{\text{cemetery}\}$, built from "generative probability measures" that restart along gauge orbits.

**Not proven there:** global existence and invariance of the YM measure (both settled later by [19]).

The predecessor is Shen's Abelian work [14]: lattice scalar QED on $\mathbb T^2$, short-time convergence, Ward-identity cancellations, and discrete regularity structures. Bringmann–Cao [25] re-proved CCHS's local well-posedness and gauge covariance with **paracontrolled calculus** and a coordinate-invariant treatment of vector-valued stochastic objects **[THM, Mem. AMS 2026]**.

### 2.4 Chevyrev–Shen: invariant measure and universality in 2D [19]

**Proven [THM, CPAM 2026]** for any connected compact $G$ and the trivial bundle over $\mathbb T^2$:
- (Thm 2.16) The YM measure $\mu$ (Lévy's) gives full mass to $\mathcal O_\alpha$. It is the **unique invariant probability measure** of the CCHS Markov process $X$, has full support, and $X$ is **reversible** with respect to $\mu$.
- (Cor 2.19) $X$ **never blows up**: global existence on orbits. (Remark 2.17: no claim is made about global existence or an invariant measure for the unprojected SYM itself.) Part 1 of Thm 2.16, the existence of $\mu$ on $\mathcal O_\alpha$ (for simply connected $G$), is essentially due to [13]; the new content is the invariance/uniqueness part.
- (Cor 2.21) **Gauge-fixed decomposition.** $\mu=\mathrm{Law}[\Psi+B]$ with $\Psi$ a GFF and $|B|_{\mathcal C^{1-\kappa}}$ having all moments. The YM measure is rigorously a perturbation of the GFF.
- (Cor 2.26, Thm 2.12) **Universality.** A broad class of lattice actions, including Wilson, Manton and Villain, has $\mu$ as its scaling limit. This is derived from universality of the *dynamics* plus uniqueness of the invariant measure; the authors describe it as, to their knowledge, the first example of universality of a measure proved via uniqueness of the dynamic. (The Villain case on $\mathbb T^2$ was already known from Lévy [9]; Driver [4] had related results on the plane.)
- (Thm 2.15/8.1) **Uniqueness of the gauge-covariant mass.** For any $C\neq\bar C$ there is a loop $\ell$ such that, for every sufficiently small $t>0$, some smooth $\tilde g$ (depending on $t$) gives $|\mathbb E W_\ell(\mathrm{SYM}_t(C,0))-\mathbb E W_\ell(\mathrm{SYM}_t(C,0^{\tilde g}))|\gtrsim t^2$ (Thm 2.15; Thm 8.1 states it with a constant $\sigma t^2$). For $C=\bar C$ the difference is $O(t^M)$ for every $M$. Corollary 8.3: $\bar C$ is the only mass for which generative probability measures give a Markov process on orbits. The proof combines Euler estimates for singular SPDEs, Young ODEs for holonomies, and sub-Riemannian geometry to build the gauge transformations. The authors expect this intrinsic, geometric identification of limits to generalise to 3D better than direct counterterm computation.

**Technique.** Discrete regularity structures for lattice dynamics, lattice gauge-fixing, and **Bourgain's invariant-measure argument** [66]. The last requires strong moment bounds on the measure (Thm 9.1, via rough-path Gaussian estimates for random walks on $G$).

**Why it stops at 2D pure YM.** The moment bounds come from **exact solvability**. Extending them to 3D, or to YMH, is explicitly flagged as open (§1.2 of [19]).

### 2.5 2026 wave of new 2D constructions [PREPRINT]

- **Chevyrev–Klose–Mohamed [30].** "Rough additive functions" extend rough paths to line integrals of distributional 1-forms. They prove a **rough Uhlenbeck compactness** theorem by solving a singular elliptic Coulomb-gauge PDE with regularity structures, and obtain a gauge-fixed representation of the (already constructed) YM measure on the unit square with optimal regularity. This is a new representation, not an independent construction of the measure; the authors expect it to extend to more general surfaces. Uhlenbeck gauge-fixing is also a pillar of 4D analytic work.
- **Dang–Nohra [31].** The YM measure as a random distributional 1-form on compact surfaces of any genus and smooth area form (via "pseudo-coordinates"), with universality of Wilson, Manton and Villain lattice models on all compact surfaces, and convergence of correlation functions and Segal amplitudes.
- **Chhaibi–Dang–Guedes Bonthonneau–Rivière–Tô [32].** A "Morse gauge" giving a direct continuum construction, and recovery of the Migdal–Witten–Lévy formulas.
- **Barashkov–Chandra–Chevyrev–Koller–Mohamed [29].** First construction of an *interacting gauge theory* by the Boué–Dupuis variational method: 2D Abelian YMH with polynomial potential. It integrates out the Higgs field, proves gauge covariance, and gives a large-deviation principle in the semiclassical limit.
- **Bringmann–Cao [26].** Global well-posedness of the 2D stochastic Abelian–Higgs equations via covariant stochastic objects and a covariant monotonicity formula (Hamilton-inspired).
- **Chandra–Chevyrev [28] [THM, CMP 2024].** A loop expansion for the gauge-field marginal of lattice Abelian Higgs, and **UV stability in Chevyrev's Hölder–Besov norms**. This is a template for turning lattice estimates into continuum-norm moment bounds.

### 2.6 Bringmann–Cao–Hairer–Zhao: 2D non-Abelian YMH measure [27] [PREPRINT, 2 Nov 2026]

**Claimed result (Thm 1.5/2.38).** For any connected compact $G$, orthogonal representation $V$ and G-invariant mass $M$, at **any fixed couplings**, the stochastic YMH flow on $\mathbb T^2$ is globally well-posed as a Markov process on $\mathcal O^{\rm YMH}_\kappa=(\Omega^1_{1-\kappa}\times\mathcal C^{-\kappa})/\mathfrak G^{1-\kappa}$. It obeys uniform-in-time bounds and has a **unique invariant measure $\mu_{\rm YMH}$**, under which the gauge-minimised norm has all moments. Wilson loops are jointly continuous on the state space. The authors (Remark 1.6) call the invariant measure a "natural candidate" for the non-Abelian YMH measure and, to the best of their knowledge, the first classical Euclidean QFT constructed only by stochastic quantisation. Pure YM is the special case $V=\{0\}$ (Remark 1.3). Existence of $\mu_{\rm YMH}$ is by Krylov–Bogoliubov; uniqueness is by strong Feller plus topological irreducibility on the Polish space $\mathcal O^{\rm YMH}_\kappa$ (Thm 2.38). Status: **not yet refereed**; verified by us only at the level of statements.

**Technique** (§1.2 and §2 of the paper):
1. **Infinitesimal DeTurck gauge.** Split $A=B+C$ with $B$ solving the *deterministic YM gradient flow without DeTurck term*, so that its curvature obeys monotonicity. The DeTurck trick is applied only to the rough part $C$.
2. **Covariant Schauder theory.** Pointwise covariant heat-kernel bounds for $\partial_t-\Delta_B-2\,\mathrm{ad}(F_B)$, with constants depending only on $F_B$, which is gauge invariant (these hold for general $d\ge2$). On top of this they build a full **covariant paracontrolled calculus**: Littlewood–Paley pieces, paraproducts and commutators.
3. **A gauge-covariant, non-Markovian smooth approximation.** The noise is covariantly mollified. The price is that the Markov property must be recovered by proving gauge equivalence with the CCHS process, which requires explicit counterterm computations.
4. **Global iteration.** Rough stochastic objects are periodically absorbed into the smooth background. The energy increase of order $\tau^{-1}$ per step is balanced against the decrease from the YM flow's monotonicity formula. Near Yang–Mills connections, where monotonicity gives no decay, they use a **decay mechanism**: YM connections with large curvature are unstable, and noise pushes the dynamic along unstable directions that lower the energy.
5. A supermartingale-type moment lemma (Prop. 3.55) yields uniform-in-time bounds. Krylov–Bogoliubov gives existence. **Strong Feller plus a new, simpler irreducibility argument** give uniqueness.

**Explicitly 2D-specific ingredients.** Prop 2.8 (the heat kernel near YM connections, where 2D YM connections have covariantly constant curvature; Remark 2.9). The identity that the curl and divergence of the covariant stochastic object have the same law in 2D (around (2.56)). Remark 2.22 suggests that a **covariant theory of regularity structures** "may be useful" for progress on global well-posedness in 3D (a suggestion, not a claim that it is necessary).

**AI disclosure (§1.3).** The authors began in April 2025 and had the main ideas by February 2026, without AI assistance for idea generation (they do credit 2025 conversations with ChatGPT about existing differential-geometry tools as helpful). "GPT-6 Astra" and "GPT-5.6 Sol" proved a few listed lemmas: Prop 3.55, Lem 3.58, Prop 3.59, Lem 5.26, and Lem 11.45, 11.46, 11.55. These were generated one at a time and reviewed by the authors; the supermartingale lemma was AI-suggested, based on Pemantle–Rosenthal and Douc et al. ChatGPT and Claude were used for exposition, literature search and proofreading. Footnote 5 notes OpenAI's announcement of a rigorous continuum limit of a 4D YM theory "building in part on Balaban's work", and that, as of writing, the proof was not public.

### 2.7 Three dimensions

**CCHS 3D [16] [THM, Invent. Math. 237 (2024)].** For YMH on $\mathbb T^3$:
- **Thm 1.2:** the nonlinear state space $\mathcal S$ and extension of gauge equivalence to it; orbit space $\mathcal O$ separable and completely Hausdorff; a continuous action of $\mathfrak G^\varrho$, $\varrho\in(\tfrac12,1)$; and a key bound on gauge transformations relating two equivalent elements.
- **Thm 1.7:** local renormalised solutions with mass counterterms of the form $(C^\varepsilon_{\rm YM})^{\oplus3}\oplus C^\varepsilon_{\rm Higgs}$.
- **Thm 1.9:** a **unique** $\mathring C_A$, independent of the mollifier, giving gauge covariance in law, and a unique Markov process on $\mathcal O$ **up to possible finite-time blow-up**.

The novelties beyond 2D are as follows:
- Symmetry-preserving BPHZ is formalised (§4).
- Restarting the equation needs a generalised Da Prato–Debussche trick.
- Gauge covariance is proved via a small-noise-limit symmetry argument (after [46]) rather than explicit constants, which are not computable in 3D.

**Chevyrev–Shen [20] [THM, ARMA 2026].** The gauge-covariant mass renormalisation in 3D is unique (with a Higgs field). The corollary that only this renormalisation yields a Markov process on $\mathcal S/\!\sim$ is stated informally; the authors point to the 2D version [19, Cor. 8.3] and do not reproduce the precise 3D statement. This matters for identifying lattice limits, as it did in 2D. They also strengthen the state spaces so that line integrals in Wilson-loop short-time expansions are controlled.

**Chevyrev [18] [THM, SPDEA 12 (2024)].** Norm inflation for a nonlinear heat equation with Gaussian data. Consequence (§3.1.1 of [17]): no Banach space carrying the 3D GFF admits a continuous extension of the YM flow, so **nonlinear state spaces are unavoidable**.

**Cao–Chatterjee [21, 22] [THM, Comm. PDE 2023; CMP 2024].**
- [21]: local solutions of the YM heat flow (DeTurck gauge) from random distributional data including the 3D GFF, by a Bourgain / Da Prato–Debussche decomposition.
- [22]: the state space $\mathcal X$ (§1.5), and:
  - (Thm 1.6) **tightness criterion:** if $S_{\rm YM}(X_n(t))$ is tight for every $t>0$, then a subsequence of the laws converges on $\mathcal X$;
  - (Thm 1.12) under explicit **"GFF-like" assumptions** (translation invariance, $L^2$ regularity, tail bounds and approximate Wick 4-point bounds), $\sup_n\mathbb E S_{\rm YM}(X_n(t))<\infty$;
  - (Thm 1.16) existence of a **"gauge-invariant free field"**;
  - (Conj. 1.8/1.13) *some* suitable sequence of approximations to the YM measure (e.g. lattice or Fourier truncations, Remark 1.14) satisfies the tightness condition, respectively these assumptions. **Unproven: that conjecture is exactly the missing input for 3D YM via this route [OPEN].**
  - (Remark 1.15) **in 4D the "probabilistic smoothing" behind local existence of the YM flow from GFF data breaks down.** This is an independent confirmation of the 4D barrier on the state-space side.

**Chevyrev–Qu–Shen [33] [PREPRINT, Aug 2026].** For 3D $U(1)$ lattice YM (Wilson, Manton, Villain actions) under weak-coupling scaling in DeTurck gauge, the rescaled Langevin dynamic converges to the 1-form stochastic heat equation, independently of the action. The authors present it as a first step towards a 3D analogue of [19], restricted to the Abelian case. The limit is Gaussian, as expected for $U(1)$ (compare Gross [65] for the measure).

**Sevostyanov [34] [PREPRINT, single author, unassessed].** Builds a regularity structure and a model for 3D stochastic YM with the Otto et al. multi-index approach [69]. This reproduces, by a different route, a sub-step that CCHS obtained via BPHZ [43–45]. It does not construct the 3D measure.

**What is missing for the 3D YM measure via SQ [OPEN]:**
- **(a) Global-in-time, uniform-in-time bounds for 3D SYM(H) ("coming down from infinity").** In $\Phi^4_3$ these follow from the coercive cubic damping [48, 49]. YM energy is **non-coercive along gauge orbits**, so BCHZ's 2D gradient-flow/decay strategy would have to be lifted to 3D, possibly with covariant regularity structures (Remark 2.22 of [27]). Alternatively:
- **(b) A Bourgain-type route.** Use moment bounds on lattice 3D YM measures in CCHS/Cao–Chatterjee norms, which might be extracted from Balaban's 3D UV stability [61]. Then combine them with CS-style universality and uniqueness of the gauge-covariant mass [20].
- **(c) Infinite volume, nontrivial bundles and reflection positivity:** all untouched.

### 2.8 Lattice Langevin dynamics: mass gap and loop equations at fixed lattice spacing

Shen–Zhu–Zhu [35] **[THM, CMP 2023]** treat lattice YM in any $d\ge2$ at **strong coupling**, with 't Hooft scaling $\beta N$ and explicit thresholds: $|\beta|<\frac{N-2}{32(d-1)N}$ for $SO(N)$, $|\beta|<\frac1{16(d-1)}$ for $SU(N)$. Bakry–Émery curvature bounds for the Langevin dynamic on $G^{E}$ give:
- exponential ergodicity;
- a unique infinite-volume measure;
- log-Sobolev and Poincaré inequalities;
- factorisation of Wilson loops at large $N$;
- **exponential decay of correlations (a lattice mass gap)**.

Extensions:
- YMH: [36] **[PREPRINT]**.
- Master loop and Makeenko–Migdal equations: [37, 38].
- Wilson's area law in the 't Hooft regime: Cao–Nissim–Sheffield [39] **[PREPRINT]**. It verifies the Durhuus–Fröhlich mass-gap condition and covers $G\in\{U(N),SU(N),SO(2N)\}$, which have nontrivial centre.

All of this is **at fixed lattice spacing and strong coupling**, the opposite of the continuum limit, which is weak coupling. These results nonetheless show that SQ-based functional inequalities can deliver mass gaps. A continuum version would plausibly require a multiscale (Polchinski-flow) Bakry–Émery argument [55, 56] **[HEUR]**.

Related Gaussian scaling limits: Chatterjee [40] for $SU(2)$ lattice YMH in all $d\ge2$. That paper uses a fundamental Higgs with degenerate (frozen-length) potential and unitary gauge, and takes $g=O(\varepsilon^{50d})$, Higgs length $\alpha\to\infty$, $\alpha g=c\varepsilon$; the limit is a massive Gaussian field. Rajasekaran–Yakir–Zhou [41] do the same for any compact connected matrix Lie group $G$ in the complete-symmetry-breaking regime. These limits are Gaussian ("abelianised"), i.e. trivial as interacting theories.

### 2.9 The analytic machinery, and why it is subcritical-only

- **Regularity structures** [42] with algebraic renormalisation [43], the analytic BPHZ theorem [44], renormalised equations [45], geometric/covariant extensions [46, 70], and diagram-free spectral-gap BPHZ [82]. The theory solves *locally subcritical* SPDEs: only finitely many trees have negative degree, so there are finitely many counterterms.
- **Paracontrolled calculus** [47], now with covariant versions [26, 27].
- **Flow-equation (Polchinski) approach** to SPDEs: Duch [51, 53], after Kupiainen's RG-for-SPDE [54]. It covers the full subcritical regime.
- **Variational (Boué–Dupuis)** [50, 29] and **PDE energy methods** [48, 49, 80] for measures and global bounds.

**Why d = 4 is out of reach for current SPDE methods [HEUR, but widely accepted; cf. Remark 1.15 of [22]]:**
1. **Criticality.** By §1.3 every additional order of the nonlinearity has the same scaling degree. Infinitely many trees are (log-)divergent, so the "finitely many counterterms" hypothesis behind BPHZ fails.
2. **Coupling renormalisation.** The divergences are not absorbable in a mass term. They renormalise the coupling, and, depending on the gauge choice, the field strength too. Their resummation is the $\beta$-function, so the bare coupling must run, $g_\varepsilon^2\approx(2b_0\log(1/\varepsilon\Lambda))^{-1}\to0$.
3. **No perturbative control at large scales.** Asymptotic freedom gives smallness only in the UV. At unit scale the effective coupling is $O(1)$ (dimensional transmutation), so a non-perturbative large-field analysis is needed: Balaban's small-field/large-field decomposition, gauge-covariant block averaging and background fields [61–63].
4. **Sign matters, which power counting cannot see.** For $\Phi^4_4$, where the coupling is marginally irrelevant and the theory is not asymptotically free, Aizenman–Duminil-Copin [58] [THM, Annals 2021] prove that the scaling limits of $\lambda\phi^4$ fields on $\mathbb R^4$ are Gaussian. Their result covers lattice UV cutoffs, with infinite volume and vanishing lattice spacing (it also covers nearest-neighbour 4D Ising-type models at or near criticality). This is a theorem about that class of lattice approximations, not about every conceivable regularisation. Any 4D YM method must use the sign of $b_0$.

**Critical examples where something *has* been done (analogies, not YM results):**
- **Duch [52] [PREPRINT, v3 Oct 2026].** A *new* construction of the massive 2D **Gross–Neveu model** on the plane, which is fermionic, asymptotically free and scaling-critical. It solves the Polchinski equation as a well-posed PDE on a Banach space via a fixed point. The model itself was first constructed by Gawędzki–Kupiainen (1985) and Feldman–Magnen–Rivasseau–Sénéor (1986) via discrete RG (as cited in §1 of [52]; not separately listed here), so the novelty is the method. The paper proves convergence of Schwinger functions (both UV and infinite-volume limits) and gives a coupling between free and interacting fields. The method is designed for bounded fields: fermions; sine-Gordon is stated as an *expected* application, not done. It is the closest existing template for an SPDE-flavoured treatment of an asymptotically free theory.
- **Caravenna–Sun–Zygouras [57] [THM, Invent. 2023].** The critical 2D stochastic heat flow: a nontrivial, non-Gaussian limit at a critical dimension, with disorder strength tuned to vanish like $(\log N)^{-1/2}$ with a second-order log correction. This is structurally akin to a logarithmically running bare coupling **[analogy is HEUR]**.
- **Kopper [59] [PREPRINT, Oct 2026].** Asymptotically free solutions of 4D *scalar* flow equations with nonpolynomial boundary conditions. Unassessed by us; relevant as a 4D flow-equation result.
- **Chandra–Hairer–Shen [81].** The dynamical sine-Gordon model in the full subcritical regime, i.e. right up to the critical threshold. It shows how the number of counterterms explodes as criticality is approached.

### 2.10 Status in 4D and the OpenAI announcement (context only; see the dedicated workstreams)

- **Rigorous.**
  - $U(1)_4$ lattice converges to the free field (Driver [65b]).
  - Balaban's lattice RG: UV stability of effective actions in a finite box in 3D ([61] is the main theorem of a 1984–85 series) and major steps towards UV stability in 4D [62, 63] (BCHZ describe the 4D work as "progress towards" UV stability). It does not relate effective-action observables to a continuum measure (BCHZ [27] stress this even in 2D).
  - Magnen–Rivasseau–Sénéor: YM₄ with an infrared cutoff [64].
- **[CLAIM] OpenAI (announced 26 Oct 2026).** Existence of 4D quantum YM, including coupling to fermions. The shepherding committee (Douglas, Gross (chair), Jaffe, Klebanov, Nekrasov) [73] states:
  - **Balaban's ideas were among the important elements**;
  - **confinement and the mass gap remain open**;
  - OpenAI is providing a Lean formalisation;
  - the committee will first check that the definitions and problem statement are standard, release the Lean proof, then later the 1,147 pages.

  The committee statement (2 pp., PDF dated 27 Oct 2026, re-read for this verification) also records the following:
  - OpenAI asked Gross on 16 Oct to take custody of the proof.
  - The committee states that it acts for the academic community and has no responsibility to OpenAI.
  - The proof is described as following the theory to infinite distances and proving existence of its "proper continuum limit".

  Press reports relay OpenAI's own dates: a natural-language pure-YM proof on 9 Sep 2026, QCD on 18 Sep, and the YM Lean formalisation completed 16 Oct 2026. These are OpenAI's statements and are not independently checked. Press also reports an advisory group's 26 Oct call for release (secondary sources only). No public document gives the gauge groups, the axioms (OS/Wightman) or non-triviality. As of 5 Nov 2026 the public openai/math repository's CONTENTS index contains no Yang–Mills entry (checked). **Nothing indicates any use of stochastic quantisation.** As of the BCHZ posting (2 Nov 2026) the proof was not public [27, fn. 5].

---

## 3. What is proven vs open

| Dim | Statement | Status | Key refs |
|---|---|---|---|
| 2 | YM holonomy process on compact surfaces (any $G$, any bundle) | **THM** | [3–10] |
| 2 | YM measure on $\mathbb T^2$ as random distributional 1-form, GFF regularity ($G$ simply connected) | **THM** | [13] |
| 2 | SYM local well-posedness; Polish orbit space; gauge-covariant Markov process on orbits | **THM** | [15, 25] |
| 2 | YM measure = unique invariant measure of the SYM orbit process; global existence (on orbits); reversibility; GFF + $\mathcal C^{1-\kappa}$ decomposition; universality (Wilson/Villain/Manton) on $\mathbb T^2$ | **THM** (CPAM 2026) | [19] |
| 2 | YM measure on all compact surfaces + lattice universality [31]; optimal-regularity gauge-fixed representation on the unit square via rough Uhlenbeck/Coulomb gauge [30]; Morse-theory construction [32] | **PREPRINT** | [30–32] |
| 2 | Abelian Higgs measure (lattice RG); 3D Abelian Higgs continuum limit (King 1986) | **THM** (1979–81; 1986) | BFS, King, cited in [19, 27] (not separately listed) |
| 2 | Global well-posedness, stochastic Abelian–Higgs | **PREPRINT** | [26] |
| 2 | Abelian YMH via variational method | **PREPRINT** | [29] |
| 2 | **Non-Abelian YMH measure, all fixed couplings, unique invariant measure of SYMH** | **PREPRINT** (Nov 2026; 350 pp; not yet refereed) | [27] |
| 2 | Infinite volume ($\mathbb R^2$) via SQ; nontrivial bundles via SQ | **OPEN** | [17, 19] |
| 3 | Nonlinear state space; local renormalised SYMH; unique gauge-covariant mass; Markov process on orbits up to blow-up | **THM** (Invent. 2024) | [16] |
| 3 | Uniqueness of gauge-covariant renormalisation (strong form) | **THM** (ARMA 2026) | [20] |
| 3 | YM heat flow from GFF-like data; state space $\mathcal X$; tightness *conditional* on GFF-like bounds | **THM** (conditional input) | [21, 22] |
| 3 | Some approximating sequence (lattice / Fourier truncation) of 3D YM satisfies the Cao–Chatterjee GFF-like hypotheses | **OPEN** (Conj. 1.8/1.13) | [22] |
| 3 | $U(1)$ lattice Langevin → 1-form SHE (Gaussian) | **PREPRINT** | [33] |
| 3 | Global existence of 3D SYM(H); invariant measure; **construction of 3D non-Abelian YM measure (even on $\mathbb T^3$)** | **OPEN** | [16, 17, 19] |
| 3 | Balaban: UV stability of 3D lattice YM effective actions (finite volume) | **THM** (1985; not linked to a continuum measure) | [61] |
| any | Lattice YM strong coupling: unique infinite-volume measure, LSI, lattice mass gap (via Langevin/Bakry–Émery) | **THM** | [35] |
| 4 | SPDE solution theory for 4D SYM | **OPEN; no known method** (critical) | §2.9 |
| 4 | $\Phi^4_4$ scaling limits Gaussian (lattice-cutoff $\lambda\phi^4$, infinite volume) | **THM** | [58] |
| 4 | Balaban 4D RG programme (effective actions, small/large field) | **THM** for the published steps (UV stability of effective actions/partition function in finite volume). Generally regarded as **incomplete** as a construction: no continuum Schwinger functions, no infinite volume; long and rarely independently re-checked. That assessment is **[HEUR]**. | [62, 63] |
| 4 | Existence of 4D quantum YM (OpenAI) | **CLAIM**, unreleased, under committee review | [73, 74] |
| 4 | Mass gap / confinement | **OPEN** (committee states this explicitly) | [73] |

---

## 4. Relevance to a 4D YM existence + mass-gap proof and to Lean formalisation

### 4.1 Where SQ cannot help (be realistic)

SQ does not supply UV control in 4D. Any 4D construction needs a multiscale RG with a running coupling and large-field control (Balaban-type). Equivalently, an SPDE theory would have to *contain* that RG, in the style of Duch's critical Gross–Neveu construction [52], extended to bosonic gauge fields with gauge covariance. No such theory exists. Treat "SQ construction of 4D YM" as a research-grade long shot.

### 4.2 Where SQ is directly useful downstream of a construction

1. **Identification and universality.** CS [19] proved universality of the 2D measure from uniqueness of the dynamic and of the gauge-covariant mass. In 4D, once a measure exists, a Langevin uniqueness argument could identify limits of different lattice actions or regularisations. This is relevant to checking that a claimed construction (e.g. OpenAI's) defines *the* YM theory and not a regularisation artefact.
2. **Reflection positivity by inheritance [HEUR / proposed strategy].** RP holds for Wilson lattice measures (Osterwalder–Seiler [77]), and RP is preserved under weak limits of suitable observables. Universality of the limit could then transfer RP to limits of other lattice actions. This has not been carried out for gauge theories via SQ.
3. **Mass gap via functional inequalities.** SZZ [35] obtained a lattice mass gap from Bakry–Émery for the Langevin dynamic, at strong coupling. The continuum, weak-coupling analogue would be a **multiscale Bakry–Émery / Polchinski-flow** criterion [55, 56] organised along Balaban's scales. This is a concrete, if hard, mass-gap strategy that shares infrastructure with a Balaban-type construction.
4. **Dyson–Schwinger / Makeenko–Migdal identities** derived from Langevin integration by parts [37, 38]. These could provide checks, or a nontriviality proof, for a 4D construction (Baez's point that existence must rule out a free theory).
5. **State spaces and observables.** Gradient-flow-smoothened Wilson loops [16, 22] are the canonical observables of rough gauge fields. They match Lüscher's flowed observables [67, 68], which are UV-finite in perturbation theory in 4D. **Recommendation:** a 4D Lean problem statement should define Schwinger functions of *flowed* gauge-invariant fields at positive flow time, plus their $t\downarrow0$ behaviour, rather than requiring bare holonomies, which do not exist for GFF-regularity fields when $d\ge3$.

### 4.3 Lean formalisation notes

**Infrastructure we can likely build on.** Mathlib has Haar measure, Lie groups (basic), manifolds, Fourier analysis on tori, and the Schwartz space. The external Mathlib-based project of Degenne–Ledvinka–Marion–Pfaffelhuber [71] adds Kolmogorov extension, Kolmogorov–Chentsov, **Gaussian measures on Banach spaces** and **Brownian motion**. Coelho [72] reports a machine-checked $L^2$ Itô calculus **[PREPRINT]**. *Exact Mathlib coverage of distributions, Hölder–Besov spaces and principal bundles should be checked in the Lean workstream; we have not verified it here.*

**Missing for this area:**
- negative-regularity Hölder–Besov spaces;
- Young and rough integration (holonomies for $\alpha>1/2$);
- white noise as a distribution;
- mild solutions of parabolic SPDEs;
- regularity structures or paracontrolled calculus;
- Markov ergodic theory on Polish spaces (strong Feller + irreducibility ⇒ uniqueness; Krylov–Bogoliubov);
- compact-Lie-group heat kernels and Brownian motion on $G$ (Peter–Weyl);
- connections and gauge actions on (trivial) bundles;
- Uhlenbeck gauge fixing.

**Suggested formal milestones**, as statement-level targets that test definitions before any 4D attempt:
1. Finite-lattice YM: the measure on $G^{E}$ with Wilson action and its Langevin SDE. State the SZZ strong-coupling exponential decay of correlations [35], for $SO(N)$/$SU(N)$ with the explicit $|\beta|$ thresholds of [35]. The infinite-volume statement needs an infinite-product-measure layer. This is finite-dimensional and a realistic proof target, which makes it a good first "mass gap" formal statement.
2. The Abelian toy model (§1.4 of [17]). SYM is linear, $\check C=0$ is the unique gauge-covariant mass on $\mathbb T^d$ (not on $\mathbb R^d$), and the argument uses the observable $e^{i\int A_1}$ with the large gauge transformation $B(0)=(2\pi,0,\dots,0)$. Small, self-contained and fully provable.
3. Definitions of $\Omega^1_\alpha$, $\mathfrak G^\alpha$ and $\mathcal O_\alpha$, and the statement of CS Thm 2.16 (unique invariant measure) as a `sorry`-ed theorem. This forces a good API for gauge orbits of rough connections.
4. Cao–Chatterjee's $\mathcal X$ and regularised Wilson loops as definitions. This is a candidate for the observables layer of the 4D problem statement (cf. §4.2.5).

### 4.4 Lessons for an AI-agent workflow (from [27])

In the most recent major SQ result, frontier models proved **self-contained, literature-anchored technical lemmas**: supermartingale moment bounds and a few estimates, each one at a time and each human-reviewed. They did not generate the architecture. For our swarm this suggests the following:
- decompose into lemma-sized subgoals with precise hypotheses;
- attach the closest literature precedent to each lemma;
- send these to prover agents, with Lean statements where feasible;
- keep architectural choices with lead agents/humans (gauge choice, iteration scheme, which quantity is monotone);
- verify each returned lemma independently.

---

## 5. Open questions / leads

1. **3D global bounds.** Can the BCHZ 2D mechanism (YM-flow monotonicity + decay near YM connections + covariant local theory) be lifted to $\mathbb T^3$ with a *covariant regularity-structures* theory (Remark 2.22 of [27])? Which 2D-specific identities (Prop 2.8; curl/div equality in law) have 3D substitutes?
2. **Balaban → Cao–Chatterjee hypotheses.** Can Balaban's 3D UV stability [61] be converted into the "GFF-like" moment and approximate-Wick bounds of Thm 1.12 in [22]? Or into CCHS $\mathcal S$-norm moment bounds? With [20] (unique gauge-covariant mass) and a CS-style Bourgain argument [19], this would construct the 3D YM measure. This is probably the most direct 3D route; [28] is the 2D Abelian template.
3. **Criticality.** Can Duch's Polchinski-flow-as-Banach-PDE method [52] (critical, asymptotically free, bounded fields) be adapted to lattice gauge fields? Link variables are bounded because $G$ is compact, but the large-field problem concerns plaquettes far from $\mathbb 1$. What replaces "bounded field" there? (Speculative.)
4. **SQ + RG hybrid.** Formulate the 4D YM Langevin dynamic with a scale-dependent running coupling $g_\varepsilon$ and track the infinitely many log-divergent trees as an RG flow of finitely many marginal couplings. This would be a "critical regularity structures" theory. Is there any toy critical SPDE (e.g. CSZ's critical SHF [57] or dynamical sine-Gordon at $\beta^2=8\pi$ [81]) where this has been done for the *dynamic*?
5. **Multiscale Bakry–Émery for gauge theories.** Can the Bauerschmidt–Bodineau Polchinski-flow LSI method [55, 56] be made gauge covariant? Can it be organised on Balaban's block-spin scales to give a continuum spectral gap (mass gap) at weak coupling? Even in 2D YMH, a continuum mass gap via SQ appears open.
6. **Universality as a verification tool.** If OpenAI's 4D construction is released, can an SQ-style uniqueness argument check that different lattice actions give the same limit, and that the limit is non-Gaussian (e.g. via Makeenko–Migdal/Dyson–Schwinger identities)?
7. **Infinite volume.** All SQ YM results are on tori. Infinite-volume SQ for $\Phi^4_3$ exists [49, 80]. What is the gauge-theory analogue, even in 2D?
8. **Nontrivial bundles / topology.** SQ is only for trivial bundles. In 4D, instanton sectors matter for the physics, though not for the Clay statement.
9. **Uhlenbeck compactness in rough form.** CKM's rough Uhlenbeck compactness [30] in 2D. Is there a 3D or 4D probabilistic version usable on gradient-flowed fields? Uhlenbeck gauges are also Balaban's local gauges.
10. **Lean statement design.** Settle whether the 4D problem statement should use flowed observables (§4.2.5). Prototype the SZZ lattice mass-gap statement and the Abelian $\check C=0$ theorem as early formal deliverables.
11. **Watch list (2026 preprints to re-check for refereeing/errata):** [26, 27, 29–34, 52, 59]. For [34], verify its claims against CCHS before relying on it.

---

## 6. PDFs downloaded to `library/pdfs/` (this workstream)

2611.03640, 2006.04987, 2201.03487, 2302.12160, 2503.03060, 1808.09196, 2111.12813, 2111.10652, 2202.13359, 2608.27828, 2305.07197, 2403.18562, 2607.22236, 1303.5113, math_0101239 (all open-access arXiv; filenames `<id>.pdf` with `/` → `_`).

---

## 7. References

All entries were checked against the arXiv API, Crossref, or a primary document unless the "verified" note says otherwise. "Verified (bib.)" means existence was confirmed via bibliographies of refereed papers read here, because a direct DOI lookup failed.

1. G. Parisi, Y.-S. Wu, *Perturbation theory without gauge fixing*, Sci. Sinica 24 (1981) no. 4, 483–496. — verified (bib.; cited in [15, 17, 27]). [Corrected: the DOI 10.1360/ya1981-24-4-483 given in CCHS's bibliography returns 404 at doi.org and is absent from Crossref (checked 5 Nov 2026); citation kept, DOI dropped.]
2. D. Zwanziger, *Covariant quantization of gauge fields without Gribov ambiguity*, Nucl. Phys. B 192 (1981) 259–269. DOI 10.1016/0550-3213(81)90202-9. — verified
3. L. Gross, C. King, A. Sengupta, *Two dimensional Yang–Mills theory via stochastic differential equations*, Ann. Phys. 194 (1989) 65–112. DOI 10.1016/0003-4916(89)90032-8. — verified
4. B. K. Driver, *YM₂: continuum expectations, lattice convergence, and lassos*, CMP 123 (1989) 575–616. DOI 10.1007/BF01218586. — verified
5. D. S. Fine, *Quantum Yang–Mills on a Riemann surface*, CMP 140 (1991) 321–338. DOI 10.1007/BF02099502. — verified
6. E. Witten, *On quantum gauge theories in two dimensions*, CMP 141 (1991) 153–209. DOI 10.1007/BF02100009. — verified
7. A. Sengupta, *Gauge theory on compact surfaces*, Mem. AMS 126 (1997) no. 600. DOI 10.1090/memo/0600. — verified
8. T. Lévy, *Yang–Mills measure on compact surfaces*, Mem. AMS 166 (2003) no. 790. arXiv:math/0101239; DOI 10.1090/memo/0790. — verified
9. T. Lévy, *Discrete and continuous Yang–Mills measure for non-trivial bundles over compact surfaces*, PTRF 136 (2006) 171–202. arXiv:math-ph/0501014; DOI 10.1007/s00440-005-0478-8. — verified
10. T. Lévy, *Two-dimensional Markovian holonomy fields*, Astérisque 329 (2010). arXiv:0804.2230; DOI 10.24033/ast.785. — verified
11. T. Lévy, *Two-dimensional quantum Yang–Mills theory and the Makeenko–Migdal equations* (2020 survey). arXiv:1912.06246. — verified
12. T. Lemoine, *Two-dimensional Yang–Mills theory via integrable probability* (Bull. AMS, to appear, per arXiv v2 comment). arXiv:2508.16162. — verified
13. I. Chevyrev, *Yang–Mills measure on the two-dimensional torus as a random distribution*, CMP 372 (2019) 1027–1058. arXiv:1808.09196; DOI 10.1007/s00220-019-03567-5. — verified
14. H. Shen, *Stochastic quantization of an Abelian gauge theory*, CMP 384 (2021) 1445–1512. arXiv:1801.04596; DOI 10.1007/s00220-021-04114-x. — verified
15. A. Chandra, I. Chevyrev, M. Hairer, H. Shen, *Langevin dynamic for the 2D Yang–Mills measure*, Publ. Math. IHÉS 136 (2022) 1–147. arXiv:2006.04987; DOI 10.1007/s10240-022-00132-0. — verified
16. A. Chandra, I. Chevyrev, M. Hairer, H. Shen, *Stochastic quantisation of Yang–Mills–Higgs in 3D*, Invent. Math. 237 (2024) 541–696. arXiv:2201.03487; DOI 10.1007/s00222-024-01264-2. — verified
17. I. Chevyrev, *Stochastic quantisation of Yang–Mills* (survey), J. Math. Phys. 63 (2022) 091101. arXiv:2202.13359; DOI 10.1063/5.0089431. — verified
18. I. Chevyrev, *Norm inflation for a non-linear heat equation with Gaussian initial conditions*, Stoch. PDE: Anal. Comp. 12 (2024) 1745–1768 (online 2023). arXiv:2205.14350; DOI 10.1007/s40072-023-00317-6. — verified
19. I. Chevyrev, H. Shen, *Invariant measure and universality of the 2D Yang–Mills Langevin dynamic*, CPAM 79 (2026) no. 8, 1973–2102. arXiv:2302.12160; DOI 10.1002/cpa.70043. — verified
20. I. Chevyrev, H. Shen, *Uniqueness of gauge covariant renormalisation of stochastic 3D Yang–Mills–Higgs*, ARMA 250 (2026) no. 1, art. 11 [corrected from "no. 11"]. arXiv:2503.03060; DOI 10.1007/s00205-025-02163-3. — verified
21. S. Cao, S. Chatterjee, *The Yang–Mills heat flow with random distributional initial data*, Comm. PDE 48 (2023) 209–251. arXiv:2111.10652; DOI 10.1080/03605302.2023.2169937. — verified
22. S. Cao, S. Chatterjee, *A state space for 3D Euclidean Yang–Mills theories*, CMP 405 (2024) 3. arXiv:2111.12813; DOI 10.1007/s00220-023-04870-y. — verified
23. N. Charalambous, L. Gross, *The Yang–Mills heat semigroup on three-manifolds with boundary*, CMP 317 (2013) 727–785. DOI 10.1007/s00220-012-1558-0. — verified
24. L. Gross, *The Yang–Mills heat equation with finite action in three dimensions*, Mem. AMS 275 (2022) no. 1349. DOI 10.1090/memo/1349. — verified
25. B. Bringmann, S. Cao, *A para-controlled approach to the stochastic Yang–Mills equation in two dimensions*, Mem. AMS 319 (2026) no. 1624. arXiv:2305.07197; DOI 10.1090/memo/1624. — verified
26. B. Bringmann, S. Cao, *Global well-posedness of the stochastic Abelian–Higgs equations in two dimensions*. arXiv:2403.16878. — verified (preprint)
27. B. Bringmann, S. Cao, M. Hairer, W. Zhao, *Construction of the 2D non-Abelian Yang–Mills–Higgs measure via stochastic quantisation* (350 pp., 2 Nov 2026). arXiv:2611.03640. — verified (preprint; read §§1–2, 12)
28. A. Chandra, I. Chevyrev, *Gauge field marginal of an Abelian Higgs model*, CMP 405 (2024) 143. arXiv:2207.05443; DOI 10.1007/s00220-024-05008-4. — verified
29. N. Barashkov, A. Chandra, I. Chevyrev, A. Koller, A. Mohamed, *A variational approach for the 2D Abelian Yang–Mills–Higgs measure* (2026). arXiv:2609.21972. — verified (preprint)
30. I. Chevyrev, T. Klose, A. Mohamed, *A PDE approach to the 2D Yang–Mills measure* (2026). arXiv:2607.22236. — verified (preprint)
31. N. V. Dang, E. Nohra, *The Yang–Mills measure on compact surfaces as a universal scaling limit of lattice gauge models* (2026). arXiv:2602.08591. — verified (preprint)
32. R. Chhaibi, N. V. Dang, Y. Guedes Bonthonneau, G. Rivière, T. D. Tô, *The Yang–Mills measure on surfaces via Morse theory* (2026). arXiv:2607.24640. — verified (preprint)
33. I. Chevyrev, Y. Qu, H. Shen, *Scaling limit of the 3D abelian Yang–Mills Langevin dynamics* (2026). arXiv:2608.27828. — verified (preprint)
34. A. Sevostyanov, *A tree-free approach to 3D Yang–Mills Langevin dynamic. Analytic estimates and the existence of a model for a regularity structure* (2026). arXiv:2605.14616. — verified exists; claims unassessed
35. H. Shen, R. Zhu, X. Zhu, *A stochastic analysis approach to lattice Yang–Mills at strong coupling*, CMP 400 (2023) 805–851. arXiv:2204.12737; DOI 10.1007/s00220-022-04609-1. — verified
36. H. Shen, R. Zhu, X. Zhu, *Langevin dynamics of lattice Yang–Mills–Higgs and applications*. arXiv:2401.13299. — verified (preprint)
37. H. Shen, S. A. Smith, R. Zhu, *A new derivation of the finite N master loop equation for lattice Yang–Mills*. arXiv:2202.00880. — verified
38. H. Shen, S. A. Smith, R. Zhu, *Makeenko–Migdal equations for 2D Yang–Mills: from lattice to continuum*. arXiv:2412.15422. — verified (preprint)
39. S. Cao, R. Nissim, S. Sheffield, *Dynamical approach to area law for lattice Yang–Mills*. arXiv:2509.04688. — verified (preprint)
40. S. Chatterjee, *A scaling limit of SU(2) lattice Yang–Mills–Higgs theory*, Prob. Math. Phys. 7 (2026) 339–381. arXiv:2401.10507; DOI 10.2140/pmp.2026.7.339. — verified
41. F. Rajasekaran, O. Yakir, Y. Zhou, *Gaussian limits of lattice Higgs models with complete symmetry breaking* (2026). arXiv:2603.24555. — verified (preprint)
42. M. Hairer, *A theory of regularity structures*, Invent. Math. 198 (2014) 269–504. arXiv:1303.5113; DOI 10.1007/s00222-014-0505-4. — verified
43. Y. Bruned, M. Hairer, L. Zambotti, *Algebraic renormalisation of regularity structures*, Invent. Math. 215 (2019) 1039–1156. arXiv:1610.08468; DOI 10.1007/s00222-018-0841-x. — verified
44. A. Chandra, M. Hairer, *An analytic BPHZ theorem for regularity structures*. arXiv:1612.08138. — verified
45. Y. Bruned, A. Chandra, I. Chevyrev, M. Hairer, *Renormalising SPDEs in regularity structures*, JEMS 23 (2021) 869–947. arXiv:1711.10239; DOI 10.4171/jems/1025. — verified
46. Y. Bruned, F. Gabriel, M. Hairer, L. Zambotti, *Geometric stochastic heat equations*, JAMS 35 (2022) 1–80. arXiv:1902.02884; DOI 10.1090/jams/977. — verified
47. M. Gubinelli, P. Imkeller, N. Perkowski, *Paracontrolled distributions and singular PDEs*, Forum Math. Pi 3 (2015) e6. arXiv:1210.2684; DOI 10.1017/fmp.2015.2. — verified
48. J.-C. Mourrat, H. Weber, *The dynamic Φ⁴₃ model comes down from infinity*, CMP 356 (2017) 673–753. arXiv:1601.01234; DOI 10.1007/s00220-017-2997-4. — verified
49. M. Gubinelli, M. Hofmanová, *A PDE construction of the Euclidean Φ⁴₃ quantum field theory*, CMP 384 (2021) 1–75. arXiv:1810.01700; DOI 10.1007/s00220-021-04022-0. — verified (OS axioms except rotation invariance and clustering)
50. N. Barashkov, M. Gubinelli, *A variational method for Φ⁴₃*, Duke Math. J. 169 (2020). arXiv:1805.10814; DOI 10.1215/00127094-2020-0029. — verified
51. P. Duch, *Flow equation approach to singular stochastic PDEs*, Prob. Math. Phys. 6 (2025) 327–437. arXiv:2109.11380; DOI 10.2140/pmp.2025.6.327. — verified
52. P. Duch, *Construction of Gross–Neveu model using Polchinski flow equation*. arXiv:2403.18562. — verified (preprint, v3)
53. P. Duch, *Lecture notes on the flow equation approach to singular stochastic PDEs*. arXiv:2511.07120. — verified
54. A. Kupiainen, *Renormalization group and stochastic PDEs*, Ann. Henri Poincaré 17 (2016) 497–535. arXiv:1410.3094; DOI 10.1007/s00023-015-0408-y. — verified (arXiv ID now checked)
55. R. Bauerschmidt, T. Bodineau, B. Dagallier, *Stochastic dynamics and the Polchinski equation: an introduction*, Probab. Surveys 21 (2024) 200–290. arXiv:2307.07619; DOI 10.1214/24-PS27. — verified
56. R. Bauerschmidt, T. Bodineau, *Log-Sobolev inequality for the continuum sine-Gordon model*, CPAM 74 (2021). arXiv:1907.12308; DOI 10.1002/cpa.21926. — verified
57. F. Caravenna, R. Sun, N. Zygouras, *The critical 2d stochastic heat flow*, Invent. Math. 233 (2023) 325–460. arXiv:2109.03766; DOI 10.1007/s00222-023-01184-7. — verified
58. M. Aizenman, H. Duminil-Copin, *Marginal triviality of the scaling limits of critical 4D Ising and φ⁴₄ models*, Ann. Math. 194 (2021) 163–235. arXiv:1912.07973; DOI 10.4007/annals.2021.194.1.3. — verified
59. C. Kopper, *Asymptotically free solutions of the scalar flow equations* (Oct 2026). arXiv:2610.06165. — verified (preprint; abstract only)
60. S. Chatterjee, *Yang–Mills for probabilists*. arXiv:1803.01950. — verified
61. T. Balaban, *Ultraviolet stability of three-dimensional lattice pure gauge field theories*, CMP 102 (1985) 255–275. DOI 10.1007/BF01229380. — verified (Crossref; = [Bal85d] in [27], main theorem of the 1984–85 3D series)
62. T. Balaban, *Renormalization group approach to lattice gauge field theories I* (4D, small fields, coupling renormalization), CMP 109 (1987) 249–301. DOI 10.1007/BF01215223. — verified
63. T. Balaban, *Large field renormalization II*, CMP 122 (1989) 355–392. DOI 10.1007/BF01238433. — verified
64. J. Magnen, V. Rivasseau, R. Sénéor, *Construction of YM₄ with an infrared cutoff*, CMP 155 (1993) 325–383. DOI 10.1007/BF02097397. — verified
65. L. Gross, *Convergence of U(1)₃ lattice gauge theory to its continuum limit*, CMP 92 (1983) 137–162. DOI 10.1007/BF01210842. — verified
65b. B. K. Driver, *Convergence of the U(1)₄ lattice gauge theory to its continuum limit*, CMP 110 (1987) 479–501. DOI 10.1007/BF01212424. — verified
66. J. Bourgain, *Periodic nonlinear Schrödinger equation and invariant measures*, CMP 166 (1994) 1–26. DOI 10.1007/BF02099299. — verified
67. M. Lüscher, *Properties and uses of the Wilson flow in lattice QCD*, JHEP 08 (2010) 071. arXiv:1006.4518; DOI 10.1007/JHEP08(2010)071. — verified
68. M. Lüscher, P. Weisz, *Perturbative analysis of the gradient flow in non-abelian gauge theories*, JHEP 02 (2011) 051. arXiv:1101.0963; DOI 10.1007/JHEP02(2011)051. — verified
69. P. Linares, F. Otto, M. Tempelmayr, *The structure group for quasi-linear equations via universal enveloping algebras*, Comm. AMS 3 (2023). arXiv:2103.04187. — verified
70. M. Hairer, H. Singh, *Regularity structures on manifolds and vector bundles*. arXiv:2308.05049. — verified
71. R. Degenne, D. Ledvinka, E. Marion, P. Pfaffelhuber, *Formalization of Brownian motion in Lean*. arXiv:2511.20118. — verified
72. R. Coelho, *A machine-checked Itô calculus for Brownian motion*. arXiv:2606.15089. — verified (preprint)
73. M. R. Douglas, D. J. Gross (chair), A. Jaffe, I. R. Klebanov, N. Nekrasov, *Proof by OpenAI of the Existence of Quantum Yang–Mills theory — statement by the shepherding committee* (Oct 2026), https://www.kitp.ucsb.edu/sites/default/files/YM_working_group.pdf. — verified (read directly; 2 pp., created 27 Oct 2026)
74. OpenAI, *Working with academic communities to build scientific understanding* (26 Oct 2026), https://openai.com/index/building-scientific-understanding-with-academic-communities/. — exists (URL and date 26 Oct 2026 given in the bibliography of [27] as [Ope26]; corroborated by several press reports); not read directly (HTTP 403 again on 5 Nov 2026); content known only via [27, 73] and press
75. M. R. Douglas, *The Yang–Mills Millennium problem*, Nat. Rev. Phys. 8 (2026) no. 2, 86–97. DOI 10.1038/s42254-025-00909-2. — verified (Crossref; also cited in [73]); not read
76. A. Jaffe, E. Witten, *Quantum Yang–Mills theory*, in *The Millennium Prize Problems*, Clay Math. Inst. (2006) 129–152. — verified (bib.; cited in [17])
77. K. Osterwalder, E. Seiler, *Gauge field theories on a lattice*, Ann. Phys. 110 (1978) 440–471. DOI 10.1016/0003-4916(78)90039-8. — verified (Crossref; also cited in [27])
78. A. Dahlqvist, T. Lemoine, *Large N limit of Yang–Mills partition function and Wilson loops on compact surfaces*, Prob. Math. Phys. 4 (2023) 849–890. arXiv:2201.05882. — verified
79. S. Albeverio, S. Kusuoka, *The invariant measure and the flow associated to the Φ⁴₃-quantum field model*. Ann. Sc. Norm. Super. Pisa Cl. Sci. (5) 20 (2020) 1359–1427. arXiv:1711.07108; DOI 10.2422/2036-2145.201809_008. — verified (arXiv API)
80. P. Duch, M. Hairer, J. Yi, W. Zhao, *Ergodicity of infinite volume Φ⁴₃ at high temperature*. arXiv:2508.07776. — verified (preprint)
81. A. Chandra, M. Hairer, H. Shen, *The dynamical sine-Gordon model in the full subcritical regime*. arXiv:1808.02594. — verified
82. M. Hairer, R. Steele, *The BPHZ theorem for regularity structures via the spectral gap inequality*, ARMA 248 (2024). arXiv:2301.10081; DOI 10.1007/s00205-023-01946-w. — verified

**Press and secondary items consulted for §2.10 context only (not relied on for mathematics):**
- quantumresearch.center article on the OpenAI claim: https://quantumresearch.center/news/articles/openai-yang-mills-existence/
- aiweekly.co alert on OpenAI handing proofs to reviewers: https://aiweekly.co/alerts/openai-hands-eth-kakeya-yang-mills-proofs-to-reviewers
- Wikipedia, "Yang–Mills existence and mass gap": https://en.wikipedia.org/wiki/Yang%E2%80%93Mills_existence_and_mass_gap
- unite.ai report (26 Oct 2026), used for OpenAI's stated dates: https://www.unite.ai/openai-says-its-models-produced-three-proofs-in-math-cs-and-physics/
- ForkLog report (27 Oct 2026), same dates: https://forklog.com/en/?p=105875

---

## Verification log

**Adversarial verification pass, 2026-11-05.** It assumed possible hallucination or overstatement and checked the note against live sources.

### A. Reference existence and metadata (83 entries: 1–82 plus 65b)

- **arXiv IDs (61 in the original note, plus arXiv:1410.3094 added for [54]).** All queried via the arXiv API (export.arxiv.org, batches of ~20). Every ID resolves, and title and authors match the note. No fabricated arXiv references were found.
- **DOIs (~50).** Queried via api.crossref.org; titles, authors and venues match. One exception:
  - Ref [1] Parisi–Wu, DOI 10.1360/ya1981-24-4-483. It is not in Crossref and doi.org returns 404. The DOI is copied from the CCHS bibliography. **DOI removed, citation kept** (bibliographic verification).
- **URLs.**
  - [73] KITP committee statement. Fetched and text extracted: 2 pp., title, five members with Gross as chair, PDF date 27 Oct 2026. Every claim attributed to it in §2.10 was re-checked: Balaban "among the important elements"; confinement and mass gap "remain very important open challenges"; Lean formalisation being provided; release order Lean first, then the 1,147-page proofs; OpenAI asked Gross on 16 Oct.
  - [74] OpenAI page. HTTP 403. Its existence, URL and date (26 Oct 2026) are confirmed via [27]'s bibliography entry [Ope26] and several press reports.
  - Press URLs: quantumresearch.center and aiweekly.co confirmed live; unite.ai and forklog added.
- **Metadata corrections:**
  - [20]: "no. 11" corrected to vol. 250, no. 1, art. 11.
  - [18]: SPDEA year corrected to 12 (2024), 1745–1768 (online 2023); the in-text tag in §2.7 was fixed too.
  - [19]: added CPAM 79 (2026) no. 8, 1973–2102.
  - [35]: added CMP 400 (2023) 805–851.
  - [24]: added Mem. AMS vol. 275 (2022).
  - [6]: added pages 153–209.
  - [17]: added article number 091101.
  - [43]: added pages and DOI 10.1007/s00222-018-0841-x.
  - [48]: added pages 673–753.
  - [54]: added arXiv:1410.3094 (verified).
  - [58]: added pages 163–235.
  - [67], [68]: added JHEP DOIs.
  - [79]: added journal (Ann. SNS Pisa 20 (2020)) and DOI.
  - [82]: added DOI 10.1007/s00205-023-01946-w.
  - [75]: now Crossref-verified.
  - [12]: "to appear in Bull. AMS" confirmed from the arXiv v2 comment.
- **PDFs.** The 15 PDFs listed in §6 were checked by first-page text. All match their IDs, so none were deleted and none were re-downloaded.

### B. Mathematical and factual claims checked against primary text

1. **BCHZ [27]** (read from the local PDF).
   - Confirmed: 350 pp.; v1 posted 2 Nov 2026; Thm 1.5 and Thm 2.38; Setting 1.1 (connected compact $G$, orthogonal $V$, $G$-invariant $M$); any fixed couplings; Krylov–Bogoliubov existence; strong Feller plus irreducibility for uniqueness; Prop 2.8 and Remark 2.9 are 2D-specific.
   - AI disclosure confirmed verbatim in substance, including the lemma list (Prop 3.55, Lem 3.58, Prop 3.59, Lem 5.26, Lem 11.45, 11.46, 11.55), "one at a time", and the [PR99, DFMS04] basis for §3.5.
   - Footnote 5 confirmed.
   - **Corrected:** Remark 1.6 is a "to the best of our knowledge" claim about a *classical* Euclidean QFT. Remark 2.22 says covariant regularity structures "may be useful" for 3D, not "may be needed".
2. **Chevyrev–Shen 2D [19].**
   - Confirmed: Thms 2.12, 2.15, 2.16; Cors 2.19, 2.21, 2.26; Thm 9.1 needs $G$ simply connected; §1.2 open-problem statements.
   - **Corrected/qualified:**
     - Global existence holds for the *orbit* process. The authors make no claim for unprojected SYM (Remark 2.17).
     - Part 1 of Thm 2.16 is essentially [13].
     - The Villain universality on $\mathbb T^2$ was already known [9].
     - In Thm 2.15 the gauge transformation depends on $t$.
3. **CCHS 2D [15].** **Corrected:** the orbit space $\mathcal O_\alpha$ and the continuous group action use $\alpha\in(2/3,1]$, and Polishness holds for $\alpha\in(2/3,1)$. The note had said "$\alpha>1/2$".
4. **CCHS 3D [16].** Confirmed: Thms 1.2, 1.7, 1.9 (the $\eta$ range, $\varrho\in(1/2,1)$, separable completely Hausdorff orbit space, unique $\mathring C_A$, Markov process up to blow-up); Remark 2.14 of [16].
5. **Chevyrev–Shen 3D [20].** Confirmed from the abstract and §1. **Qualified:** the "only Markov renormalisation" corollary is stated informally in 3D.
6. **Cao–Chatterjee [21, 22].** Confirmed: Thms 1.6, 1.12, 1.16; Remark 1.15 (4D probabilistic smoothing breaks down). **Corrected/added:**
   - Conjectures 1.8 and 1.13 concern *some* approximating sequence, not specifically lattice YM.
   - [22] restricts $G$ to products of $T^n,U(n),SU(n),O(n),SO(2n+1)$.
7. **Chevyrev survey [17].** Confirmed: eq. (1.3); Remark 1.10 (2D cancellation; 3D divergence of order $\varepsilon^{-1}$); §1.4 Abelian $\check C=0$; the Banach-space obstruction. **Added:** Abelian uniqueness fails on $\mathbb R^d$.
8. **Duch [52].** **Corrected:**
   - It is a *new* construction of the massive GN model on the plane. GN was first built by Gawędzki–Kupiainen (1985) and FMRS (1986).
   - Sine-Gordon is an expected extension, not done.
9. **Aizenman–Duminil-Copin [58].** **Qualified** to the class of lattice-cutoff $\lambda\phi^4$ approximations (and 4D Ising-type models) actually covered.
10. **SZZ [35], CNS [39], Chatterjee [40], RYZ [41], Chevyrev–Qu–Shen [33], CKM [30], Dang–Nohra [31], CDGRT [32], BCCKM [29], Bringmann–Cao [25, 26], Sevostyanov [34], Kopper [59], Coelho [72], DLMP [71].** Abstracts checked against the note's descriptions. **Corrected:**
    - [30] is a gauge-fixed *representation* (unit square), not an independent construction. Summary and table fixed.
    - [33] is framed by its authors as a first step, not "the first result".
    - [40] scaling regime made precise.
    - [35] thresholds added.
    - [39] group restriction added.
11. **OpenAI / committee claims.**
    - Announcement on 26 Oct 2026: confirmed via the [27] bibliography and press.
    - "Balaban-based" softened to the committee's and BCHZ's wording: Balaban "among the important elements", "building in part".
    - The dates 9 Sep (YM), 18 Sep (QCD) and 16 Oct (Lean done) are OpenAI's own claims as relayed by press.
    - Mass gap and confinement are explicitly open per the committee.
    - No Yang–Mills entry in the public openai/math CONTENTS index as of 5 Nov 2026 (checked via GitHub).
12. **Balaban.**
    - [61] is the main theorem of the 1984–85 3D series (BCHZ's [Bal85d]).
    - The 4D work [62, 63] is described by BCHZ as "progress towards" UV stability. The table's "completeness disputed" was replaced by a more careful **[HEUR]** assessment ("generally regarded as incomplete as a construction").
    - The 4D reference range in the Summary was corrected from [61–63] to [62, 63], since [61] is 3D.
13. **Power counting (§1.3).** Re-derived by hand: subcriticality iff $d<4$ for both $A\partial A$ and $A^3$; $g_\lambda=\lambda^{(4-d)/2}g$; $b_0=\tfrac{11}{3}C_2(G)/16\pi^2$; $g^{-2}(\mu)\approx2b_0\log(\mu/\Lambda)$. All correct.
14. **Tagging.** "Universally accepted" became "widely accepted". RP-by-inheritance (§4.2.2) and the multiscale Bakry–Émery suggestion (§2.8) were tagged **[HEUR]**. Witten 1991 was flagged as physics-level within the [THM] row.

### C. Residual concerns

- [27] BCHZ (350 pp., posted 3 days before this check) is unrefereed. We verified statements, not proofs. Seven lemmas were AI-proved and author-reviewed, so they deserve independent scrutiny.
- [34] Sevostyanov's claims are unassessed. Its relation to CCHS's BPHZ step is our reading, not the author's statement.
- [59] Kopper: only the abstract was read.
- [74] could not be read directly (HTTP 403). The OpenAI dates rest on press relaying OpenAI's own statements. The gauge group, axioms (OS/Wightman), infinite volume and non-triviality of the 4D claim are all publicly unspecified.
- Several entries are marked "verified (bib.)", meaning existence was confirmed via bibliographies of refereed papers rather than by DOI: [1] (DOI unresolvable), [76], [77] (now Crossref-confirmed). Citations of Gawędzki–Kupiainen, FMRS, BFS and King appear in the text only as cited in [52], [19] and [27]; they are not in the reference list.
- Mathlib coverage claims in §4.3 were not re-verified here and are deferred to the Lean workstream, as the note already says.
