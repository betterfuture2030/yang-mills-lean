# 08 — Constructive QFT toolkit and 4D non-perturbative renormalization

*Workstream key:* `08-constructive-qft-and-renormalization-tools` · *Compiled:* 2026-11-05 · *Scope:* constructive φ⁴₂/φ⁴₃, Gross–Neveu₂, Gawędzki–Kupiainen block-spin RG, the Brydges school (random-walk representation, Brydges–Yau, finite-range decompositions, Bauerschmidt–Brydges–Slade), polymer/cluster expansions, marginal triviality of φ⁴₄ (Aizenman–Duminil-Copin), regularity structures and PDE constructions of Φ⁴₃, Lüscher's gradient flow and the Lüscher–Weisz theorem, Wilson-loop renormalization, OS reconstruction for gauge theories, and Gribov/Singer obstructions.

**Status tags used throughout**

| Tag | Meaning |
|---|---|
| **[T]** | Established theorem, published in a refereed venue and (to my knowledge) accepted. |
| **[T-pert]** | Theorem *in perturbation theory*, valid to all orders or a stated order. It is not a non-perturbative statement. |
| **[P]** | Preprint with a complete claimed proof. Peer-review status unknown or pending. |
| **[C]** | Claimed but unverified or contested, or a construction whose completeness experts dispute. |
| **[H]** | Heuristic, folklore, numerical evidence, or my own analysis. |
| **[X]** | Known false, or a claim not accepted by the community. |

Cross-references: note 01 (problem definition), note 02 (OpenAI claim; it reports that the claimed proof credits Balaban's RG), note 04 (OpenAI GitHub proofs), note 06 (stochastic quantization in 2D/3D). Material already covered in depth in 06 is only summarised here.

---

## Summary

Most rigorous constructions of interacting relativistic QFTs in d ≥ 3, and many in d = 2, follow the same pattern [H, synthesis]. *(Verifier: "every" was too strong. Exactly solvable 2D Yang–Mills constructions, correlation-inequality routes such as Brydges–Fröhlich–Sokal [8], matrix-model solutions [35] and SPDE/PDE tightness arguments [70] replace steps 2–3 with something else. RP still comes from a lattice in most of them.)* It has four steps:
1. Regularize in a way that keeps **reflection positivity (RP)** and the relevant internal symmetry exactly. A lattice is the usual choice; for gauge theories it is Wilson's lattice.
2. Run a **multiscale (renormalization-group) analysis**. This splits each effective action into a *local relevant/marginal part* and an *irrelevant remainder*. The remainder is stored as a **polymer activity** and controlled in carefully weighted norms.
3. Prove bounds uniform in the cutoffs, then prove convergence. Cluster or polymer expansions handle locality and the infinite-volume limit.
4. Reconstruct the Hilbert space with **Osterwalder–Schrader (OS)**.

This recipe produced φ⁴₂ and φ⁴₃, Yukawa₂, the 2D and 3D abelian Higgs models, and the massive Gross–Neveu model in 2D (GN₂). Apart from planar (large-N) and hierarchical models [31–34], GN₂ is generally cited as the only constructed *asymptotically free, strictly renormalizable* continuum QFT [19, 20, 24] [H, community view; Duch [24] describes it this way]. In 4D the recipe gives critical φ⁴₄ behaviour at weak coupling [28–30, 44]. Together with Aizenman–Duminil-Copin's theorem [62], these results show that φ⁴₄, the prototypical 4D theory that is **not** asymptotically free, comes out Gaussian (trivial) for every *single-component, nearest-neighbour ferromagnetic* lattice approximation (Ising or Griffiths–Simon class, any λ > 0). *(Verifier: ADC does not cover n-component O(n) models with n ≥ 2 at large coupling; for those only the weak-coupling RG results [44] are known.)* Asymptotic freedom (AF) is therefore not a technical convenience. Perturbatively it holds only for non-abelian gauge theories (Coleman–Gross [64], a one-loop theorem), so it is the only *known* route to a non-trivial 4D continuum limit [H: strongly supported, not a theorem; see §2.6].

For 4D Yang–Mills (YM), the established toolkit has three gaps:
- **A gauge-covariant multiscale decomposition.** Balaban's block averaging and local gauge fixing [110] is the only worked-out version. The finite-range decompositions of the Brydges school [40, 41] are not gauge covariant.
- **A large-field analysis for non-abelian curvature over infinitely many scales.** Balaban did this on a torus [110], in work that is published but very hard to verify.
- **Infrared control.** This means the infinite-volume limit and the mass gap. For compact *Lie* gauge groups, no existing method touches it in 4D outside the strong-coupling (small-β) regime: the Osterwalder–Seiler cluster expansion [101], and its later refinements such as Shen–Zhu–Zhu's Bakry–Émery / log-Sobolev route [136]. *(Verifier addition: for **finite** gauge groups, possibly non-abelian, Adhikari–Cao [135] prove exponential decay of correlations of gauge-invariant observables at **weak** coupling in 4D. This does not reach SU(N), but it is a weak-coupling decay theorem, so the original "only strong coupling" wording was too strong.)*

Two continuum-side tools matter for *defining finite observables*:
- **Lüscher's gradient flow.** Correlations of gauge fields evolved to flow time t > 0 are finite to all orders of perturbation theory after ordinary coupling renormalization [81, 83]. This gives smooth, renormalized, gauge-invariant probes: E(t), smeared Wilson loops, and a non-perturbative running coupling. The small-flow-time expansion recovers renormalized local composite fields such as tr F² and T_μν [84]. These are exactly what the Clay statement requires [15].
- **Wilson-loop renormalization.** Sharp loops carry a perimeter (linear) divergence plus cusp and intersection anomalous dimensions [95–99]. Smeared or flowed loops avoid all of these.

On the OS side, the safe architecture has four parts:
- The Wilson action is RP [101]. Lüscher built a strictly positive transfer matrix for it [102].
- Only gauge-invariant observables enter. Gauss's law then holds automatically, and the theorems of Strocchi and of Fröhlich–Morchio–Strocchi explain why gauge-variant positive-metric formulations fail [114–117].
- Global gauge fixing is avoided, because Singer's theorem [122] and Neuberger's lattice 0/0 result [127] show it cannot be both continuous and complete.
- Gauge fixing is local and used only in small-field regions (Balaban).

For Lean the most tractable "toolkit" targets are all finite-dimensional, so they can be formalized now:
- the RP of the Wilson action and the lattice transfer matrix;
- the strong-coupling mass gap;
- finite-range decompositions;
- polymer expansions with the Kotecký–Preiss criterion;
- the Wilson flow on a finite lattice;
- the hierarchical RG of the Bauerschmidt–Brydges–Slade book [46], which has a modular theorem structure suited to agent swarms.

OS reconstruction is not in Mathlib. *(Verifier correction: the original text said it was "still missing from Lean". That is out of date.)* A standalone Lean 4 package, `xiyin137/OSreconstruction` [137], self-reports a sorry-free, project-axiom-free OS → Wightman reconstruction for **scalar** fields, checked by Comparator against a Mathlib-only statement file. That report comes from the README and has not been rebuilt here. Other nearby formal work:
- Douglas et al.'s Lean proof of the OS axioms for the free field [131];
- the still-incomplete P(Φ)₂ project `pphi2`, which retains project axioms and does not formalize reconstruction;
- `mrdouglasny/lgt` [138], which self-reports a sorry-free, axiom-free strong-coupling exponential-decay ("mass gap") theorem for U(n) Wilson lattice gauge theory.

Gauge-field reconstruction, meaning a gauge-invariant composite or loop observable, is formalized nowhere.

---

## 1. Key definitions and statements

### 1.1 Osterwalder–Schrader axioms (Euclidean side)

Let μ be a probability measure on 𝒮′(ℝᵈ) with generating functional $Z(f)=\int e^{i\Phi(f)}\,d\mu(\Phi)$. The **Glimm–Jaffe form** of the OS axioms [12] has five parts:
- **OS0** analyticity: $z\mapsto Z(\sum_j z_j f_j)$ is entire.
- **OS1** regularity: $|Z(f)|\le \exp c(\|f\|_{L^1}+\|f\|_{L^p}^p)$ for some $1\le p\le 2$.
- **OS2** Euclidean invariance.
- **OS3** reflection positivity: $\sum_{i,j} c_i\bar c_j Z(f_i-\Theta f_j)\ge 0$ for $f_i$ supported in $\{x_0>0\}$, where Θ is time reflection.
- **OS4** ergodicity/clustering.

In the original Schwinger-function formulation [16], the $S_n$ are distributions on test functions that vanish, with all derivatives, at coinciding points. OS II added a growth condition needed for reconstruction. OS reconstruction then produces a Hilbert space, a positive self-adjoint Hamiltonian $H$, a unitary Poincaré representation and local fields satisfying Wightman's axioms [16]. The **mass gap** is $\inf(\operatorname{spec}H\setminus\{0\})>0$. Equivalently, truncated Euclidean correlations of the reconstructed observables decay exponentially in Euclidean time:
$$\langle O(t)\,O(0)\rangle^T=\int_{(0,\infty)} e^{-tE}\,d\mu_O(E).$$

**Gauge-theory caveat [T/H].** A measure on 𝒮′ for the potential $A_\mu$ is not gauge invariant and cannot serve as the object. One instead uses either:
- (i) Schwinger functions of *gauge-invariant* composite local fields, such as renormalized tr F² or $\operatorname{tr}F_{\mu\nu}F_{\rho\sigma}$; or
- (ii) loop functionals (Wilson loops), following Seiler [105] (see also Chatterjee [100]); or
- (iii) a measure on a space of distributional *gauge orbits*, as in Cao–Chatterjee (3D) [92] and Chandra–Chevyrev–Hairer–Shen [93].

Because OS uses only non-coincident points, the non-integrable short-distance singularity of, for example, $\langle\operatorname{tr}F^2(x)\operatorname{tr}F^2(0)\rangle\sim|x|^{-8}\times(\log)$ is not an obstruction in principle [H, standard].

**Clay requirement (Jaffe–Witten [15]).** Existence for every compact simple G on ℝ⁴ with mass gap Δ > 0. The axiomatic properties must be at least as strong as Wightman/OS. The text also requires three further things:
- local quantum fields corresponding to gauge-invariant local polynomials in F and its covariant derivatives, such as $\operatorname{Tr}F_{ij}F_{kl}(x)$;
- short-distance agreement with asymptotic freedom and perturbative renormalization, including a stress tensor and an operator product expansion (OPE);
- *weak existence via compactness alone does not count* (their footnote 2) unless other techniques establish the needed properties of the limit.

Jaffe–Witten also note that the Wilson lattice approximation is RP, and that few methods recover RP once a regularization has destroyed it.

### 1.2 Lattice Yang–Mills

On $(a\mathbb Z)^4\cap\Lambda$, a link variable is $U_{x,\mu}\in G$ (compact) and the plaquette product is $U_p$. The **Wilson action** is
$$S_W(U)=\beta\sum_p\Big(1-\tfrac1N\operatorname{Re}\operatorname{tr}U_p\Big),\qquad \beta=2N/g_0^2\ (G=SU(N)),$$
and the measure is $d\mu=Z^{-1}e^{-S_W}\prod_\ell dU_\ell$ with normalized Haar measure. Gauge transformations act by $U_{x,\mu}\mapsto h_xU_{x,\mu}h_{x+\hat\mu}^{-1}$. Physical observables are gauge-invariant functions, for example Wilson loops $W_\gamma=\operatorname{tr}\prod_{\ell\in\gamma}U_\ell$.

- **Elitzur** [113] [T]: expectations of gauge-*non*-invariant local observables equal those of their gauge averages, so local gauge symmetry cannot break spontaneously.
- **Osterwalder–Seiler** [101] [T]: the Wilson action is reflection positive. At strong coupling (small β) there is an area law and a mass gap.
- **Lüscher** [102] [T]: construction of a self-adjoint, strictly positive transfer matrix $T=e^{-aH}$ acting on gauge-invariant wave functions of the spatial links.

### 1.3 The multiscale RG map (Wilson, Gawędzki–Kupiainen, Brydges–Slade)

Decompose the covariance as $C=\sum_{j=1}^{N}C_j$, so that $\phi=\sum_j\zeta_j$ with independent $\zeta_j\sim\mathcal N(0,C_j)$. Then:
- $Z_0=e^{-V_0}$ and $Z_{j+1}(\phi)=\mathbb E_{C_{j+1}}[Z_j(\phi+\zeta)]$ (progressive integration).
- **Polymer ("circle-product") representation** [43, 46]: $Z_j(\phi)=\sum_{X\in\mathcal P_j(\Lambda)}e^{-V_j(\Lambda\setminus X,\phi)}K_j(X,\phi)$. Here $V_j$ is a *local polynomial* containing only relevant and marginal monomials. $K_j(X)$ is a non-perturbative remainder supported on polymers X, which are unions of scale-j blocks, and it factorizes over connected components.
- **Loc** projects onto local polynomials whose scaling dimension is at most d, i.e. the non-contracting terms. Choosing $V_{j+1}$ so that $K_{j+1}$ *contracts* is the core of the method.
- **Norms.** BBS use $T_\phi(h)$ seminorms, $\|F\|_{T_\phi(h)}=\sum_n\frac{h^n}{n!}\|D^nF(\phi)\|$. These are weighted by a large-field regulator, with two field scales: the fluctuation scale ℓ_j and the large-field scale h_j. For φ⁴, h_j grows like a negative power of the running coupling [46, Ch. 7–8].
- **Flow of the marginal coupling.** In the hierarchical φ⁴₄ case, at second order, $g_{j+1}=g_j-\beta_jg_j^2+O(g_j^3)$ [46, Prop. 5.3.1]. This dynamical system near a *non-hyperbolic* fixed point is handled abstractly in [45]. YM UV asymptotic freedom is the same system run in the opposite scale direction, with $g^{-2}_{k+1}\approx g^{-2}_k+2b_0\log L$ (perturbative) [H].
- **Polchinski (continuous) form** [48, 47]: with $\dot C_t=\partial_tC_t$,
  $$\partial_tV_t=\tfrac12\Delta_{\dot C_t}V_t-\tfrac12\langle\nabla V_t,\dot C_t\nabla V_t\rangle$$
  (signs depend on conventions). It is a well-posed PDE non-perturbatively only for *bounded* fields; see §2.8.

### 1.4 Finite-range decomposition (FRD)

A decomposition $C=\sum_j\Gamma_j$ with three properties:
- each $\Gamma_j$ is positive semidefinite;
- $\Gamma_j(x,y)=0$ when $|x-y|\ge \tfrac12L^j$;
- scaling bounds $|\nabla^\alpha\Gamma_j|\le c_\alpha L^{-(j-1)(d-2+|\alpha|)}$.

Because the fields $\zeta_j$ and $\zeta_j'$ are independent at distances beyond $L^j$, the expectation $\mathbb E_{\Gamma_j}$ factorizes over well-separated polymers.
- Brydges–Guadagni–Mitter [40] [T] proved existence for $(a-\Delta)^{-1}$ on $\mathbb Z^d$ (d ≥ 3), with a scaling limit, and presented it as an alternative to block spins.
- Bauerschmidt [41] [T] gave a simple general method using the finite propagation speed of the wave equation, with Chebyshev polynomials on the lattice.
- Brydges–Talarczyk and Brydges–Mitter [42] treat related positive-definite and continuum-convergence questions.

### 1.5 Polymer/cluster expansions

**Kotecký–Preiss** [53] [T]. Let polymers X carry activities w(X), with incompatibility meaning overlap. Suppose some $a\ge 0$ satisfies $\sum_{Y\not\sim X}|w(Y)|e^{a(Y)}\le a(X)$ for all X. Then $\log Z$ is an absolutely convergent sum over clusters, and correlations decay.

**BKAR forest formula** (Brydges–Kennedy, Abdesselam–Rivasseau) [39, 54] [T]. For smooth f of pair variables $x_\ell$:
$$f(\mathbf 1)=\sum_{\mathcal F\ \text{forest}}\int_{[0,1]^{\mathcal F}}\prod_{\ell\in\mathcal F}dh_\ell\Big(\prod_{\ell\in\mathcal F}\partial_{x_\ell}f\Big)(X^{\mathcal F}(h)),$$
where $X^{\mathcal F}_{ij}(h)$ is the minimum of $h$ along the forest path from i to j, or 0 if there is none. This turns "connectedness" into explicit tree sums. It underlies the Mayer and cluster expansions [38, 39], the "jungle" multiscale expansions [54], and Rivasseau's **loop vertex expansion** [55–57].

### 1.6 Marginal triviality (Aizenman–Duminil-Copin [62]) [T]

**Setting.** d = 4 with nearest-neighbour ferromagnetic coupling, *single-component (real scalar) spins*. Single-site measures lie in the Griffiths–Simon class. This class includes $e^{-\lambda\phi^4+b\phi^2}d\phi$ for *any* λ > 0, and the Ising model. Consider $T_{f,L}(\phi)=\Sigma_L^{-1/2}\sum_xf(x/L)\phi_x$ in the double limit $L\to\infty$, $R/L\to\infty$. Parameters may vary along subsequences.

**Theorem 1.2.** Every random field reachable this way whose two-point function decays at infinity is a **generalized Gaussian process**.

**Key estimate (improved tree-diagram bound, Thm 1.3/7.1):**
$$|U_4(x,y,z,t)|\le \frac{C}{B_L(\beta)^c}\sum_u\langle\sigma_u\sigma_x\rangle\langle\sigma_u\sigma_y\rangle\langle\sigma_u\sigma_z\rangle\langle\sigma_u\sigma_t\rangle .$$
Here $B_L$ is the bubble diagram truncated at distance L. Consequence: the renormalized coupling satisfies $g(\beta)\le C\,\log(1/|\beta-\beta_c|)^{-c}$.

**Method.** Random-current representation, the switching lemma, and a multiscale analysis of intersection clustering.

**Extension.** Panis [63] [P; arXiv v2 says it was accepted by *Ann. Probab.*] extends the result to reflection-positive long-range models of effective dimension ≥ 4.

*(Verifier: Theorem 1.2, Theorem 1.3/7.1 and the renormalized-coupling bound, Remark 6.8 / eq. (6.59), were all checked against the arXiv PDF.)*

### 1.7 Lüscher's gradient flow [80, 81]

The flow is
$$\partial_tB_\mu=D_\nu G_{\nu\mu},\qquad B_\mu|_{t=0}=A_\mu,\qquad G_{\mu\nu}=\partial_\mu B_\nu-\partial_\nu B_\mu+[B_\mu,B_\nu].$$
At leading order $B_{\mu,1}=K_t*A_\mu$ with the heat kernel $K_t$, so the smoothing radius is $\sqrt{8t}$. A damping term $\alpha_0D_\mu\partial_\nu B_\nu$ may be added; gauge-invariant observables do not depend on $\alpha_0$.

**Lüscher–Weisz theorem [81] [T-pert].** In any gauge theory with compact simple group, with any matter multiplet, to all loop orders: once the 4D theory is renormalized in the usual way, correlation functions of $B_\mu(t,x)$ at t > 0 are finite and need no further renormalization. The proof has four ingredients:
- a local (4+1)-dimensional field theory with a Lagrange multiplier $L_\mu$ and bulk ghosts $d,\bar d$;
- bulk counterterms are excluded because flow diagrams are retarded trees;
- boundary counterterms are restricted by power counting and then excluded by BRS symmetry;
- matter fields are allowed as long as they are not flowed.

Hieda–Makino–Suzuki [83] give an alternative proof that also covers the fermion flow. Gauge-invariant local fields and Wilson loops built from $B$ at t > 0 are therefore finite [81, §8.2].

**Key one-loop formula [80] [T-pert].** With $E=\tfrac14G^a_{\mu\nu}G^a_{\mu\nu}$:
$$\langle E\rangle=\frac{3(N^2-1)g^2}{128\pi^2t^2}\{1+\bar c_1g^2+O(g^4)\}.$$
For SU(3), $\langle E\rangle=\frac{3\alpha(q)}{4\pi t^2}\{1+k_1\alpha(q)+\dots\}$ with $q=1/\sqrt{8t}$ and $k_1=1.0978+0.0075N_f$ in the $\overline{\rm MS}$ scheme. The reference scale $t_0$ is defined by $t^2\langle E\rangle|_{t_0}=0.3$.

**Small-flow-time expansion [81, 84] [T-pert].** One writes $\mathcal O(t,x)=\sum_kc_k(t)\,\mathcal O_k^R(x)+O(t)$, with coefficients fixed by RG equations. Suzuki uses it to obtain the properly normalized energy–momentum tensor [84].

**Lattice [79, 80] [T].** On a finite lattice the Wilson flow $\dot V_t=-g_0^2\{\partial_{x,\mu}S_W(V_t)\}V_t$ has global, unique, smooth solutions for all real t. It is a diffeomorphism of field space whose Jacobian is expressible through the action along the flow ("trivializing maps").

### 1.8 Wilson-loop renormalization [95–99] [T-pert]

For $W(C)=\operatorname{tr}\mathcal P\exp\oint_CA$, with a cutoff regularization and a smooth, non-self-intersecting loop,
$$W_{\rm bare}(C)=e^{-\delta m\,L(C)}\,W_{\rm ren}(C),$$
where δm is linearly divergent in 4D (∝ g₀²/a) and vanishes in dimensional regularization [96, 97].
- A cusp of angle φ contributes an extra multiplicative factor governed by the cusp anomalous dimension $\Gamma_{\rm cusp}(\varphi,g)$. At one loop this is proportional to $C_F\alpha_s(\varphi\cot\varphi-1)$, with convention-dependent signs and normalization [95, 98]. It is known to three loops [99].
- Self-intersections lead to operator mixing [97].

By naive power counting the perimeter divergence is ∝ g²L/a in d = 4, ∝ g²L log a in d = 3 (where g² has mass dimension 1), and finite in d = 2 [H].

### 1.9 Gribov and Singer [121–128]

For Landau gauge $\partial\cdot A=0$, the Faddeev–Popov operator is $M(A)=-\partial\cdot D(A)$.
- The **Gribov region** is $\Omega=\{\partial\cdot A=0,\ M(A)>0\}$. It is convex, contains 0 in its interior, and is bounded in every direction.
- The **fundamental modular region** Λ is the set of absolute minima of $\|A^g\|^2$ along each orbit, and Λ ⊂ Ω.
- **Dell'Antonio–Zwanziger** [124] [T]: every gauge orbit passes inside the Gribov horizon.
- **Singer** [122] [T]: on a compact base such as S⁴ (or S³), with the based gauge group, there is no continuous choice of a unique representative on each orbit. The bundle 𝒜 → 𝒜/𝒢 is non-trivial because 𝒜 is contractible while 𝒢 is not.
- **Neuberger** [127] [T]: on the lattice, BRST gauge fixing that sums over all Gribov copies with the sign of det M gives 0/0. The signed count is a topological invariant that vanishes for compact groups.
- **Compact lattice gauge theory needs no gauge fixing at all**, because the Haar measure on the gauge group is normalizable.

### 1.10 Gauge invariance, Gauss's law and the physical spectrum

- **Strocchi** [115, 116] [T, axiomatic]. In a local, covariant, positive-metric formulation, Gauss's law forces triviality: of the electromagnetic field in the abelian case, or of the charges carried by locally generated states. Local covariant gauges therefore need indefinite metric (Gupta–Bleuler; Kugo–Ojima [118]). Positive-metric (OS/Wightman) constructions must work with gauge-invariant observables.
- **Fröhlich–Morchio–Strocchi** [114] [H/T-pert]. In Higgs theories, physical particles are created by gauge-invariant composite fields, and there is no gauge-variant order parameter. Maas [119] reviews lattice confirmations.

---

## 2. Detailed findings

### 2.1 φ⁴₂ and φ⁴₃: the template

**What is proven [T].**

**φ⁴₂ / P(φ)₂.** Constructed through Nelson's Markov-field route [7], Guerra–Rosen–Simon's lattice/statistical-mechanics methods [6], and the Glimm–Jaffe–Spencer cluster expansion. The latter gives the Wightman axioms, a positive mass gap and particle structure at weak coupling [5, 58]. Phase transitions and non-uniqueness hold at strong coupling [15, §6.3].

**φ⁴₃.** The super-renormalizable but non-trivially divergent case, with vacuum-energy, mass and wave-function renormalization at second and third order. The history runs as follows:
- **Glimm–Jaffe 1973** [1]: positivity, i.e. a lower bound uniform in the cutoff, of the renormalized finite-volume Hamiltonian. This was the decisive ultraviolet-stability estimate, obtained by phase-cell localization.
- **Feldman 1974** [2]: the finite-volume theory.
- **Feldman–Osterwalder 1976** [3]: the infinite-volume limit at weak coupling, the **Wightman axioms and a mass gap**.
- **Magnen–Sénéor 1976** [4]: the infinite-volume limit, independently.
- Later proofs by other routes:
  - Benfatto–Cassandro–Gallavotti–… [9]: multiscale ultraviolet stability;
  - Brydges–Fröhlich–Sokal [8]: skeleton inequalities, giving existence *and non-triviality*;
  - Brydges–Dimock–Hurd [10]: short-distance behaviour;
  - Dimock's three-part exposition of Balaban's RG for φ⁴₃ on a lattice torus [11]: small fields, large fields, convergence.

**Stochastic-quantization constructions** (details in note 06):
- **Hairer 2014** [67]: regularity structures give local-in-time dynamics on the torus.
- **Paracontrolled calculus** [68], **global dynamics** [69], **space-time localisation**, and a **variational method** (Barashkov–Gubinelli, based on Boué–Dupuis) [71].
- **Gubinelli–Hofmanová** [70] [T]. They start from lattice approximations of mesh ε and side M, and use a renormalized energy method in weighted spaces. They prove *tightness as ε → 0, M → ∞ at arbitrary positive coupling*. Every limit point is non-Gaussian, reflection positive, translation invariant and has stretched-exponential integrability. Hence all OS axioms hold **except rotation invariance and clustering**, plus Dyson–Schwinger equations.
- **Hairer–Steele** [72]: sub-Gaussian tails.
- **Duch–Hairer–Yi–Zhao 2025** [74] [P]. Global well-posedness of the *infinite-volume* Φ⁴₃ dynamic. At high temperature / small coupling, they characterize the measure as the unique invariant measure and prove **all OS axioms including rotations and exponential decay**.
- **Chandra–Moinat–Weber** [73]: a priori bounds throughout the full *sub-critical* regime (noise regularity emulating d < 4).
- **Duch–Gubinelli–Rinaldi** [75]: fractional Φ⁴₃ in the full sub-critical regime, using a truncated flow equation.

**Lessons that transfer to 4D YM.**
1. **RP comes from the lattice, never from the continuum method.** Gubinelli–Hofmanová obtain RP because their measures are limits of reflection-positive lattice Gibbs measures. The SPDE gives tightness, not positivity. Any YM construction should prove its estimates *about the Wilson lattice measure itself*, so that RP passes to the limit automatically.
2. **Rotation invariance is a separate theorem** and can be the last thing proved. Within the SPDE/PDE line, Gubinelli–Hofmanová's limit points lack it, and it arrived only with Duch–Hairer–Yi–Zhao, years later, at small coupling. *(Verifier: at weak coupling, Euclidean/Lorentz invariance of φ⁴₃ was already part of the classical Feldman–Osterwalder / Magnen–Sénéor Wightman-axiom results [3, 4]. The open case is rotation invariance at large coupling.)* For lattice YM, hypercubic symmetry forbids all non-O(4)-invariant gauge-invariant operators of dimension ≤ 4. This makes restoration of rotation invariance plausible by power counting [H]. It still has to be *proved*. Note 02 reports that a public Sussman–Alpöge manuscript mentions an "RP trick" for O(4) invariance [C, unverified here].
3. **Uniform bounds and compactness are not existence in the Clay sense** [15, fn. 2]. Gubinelli–Hofmanová give *limit points*. Uniqueness, or at least identification of the limit, needs an RG/cluster argument, which is the classical route [3, 4]. Duch–Hairer–Yi–Zhao give uniqueness only at small coupling.
4. **Sub-criticality is essential for regularity structures and paracontrolled methods.** The Chandra–Moinat–Weber bounds hold only up to d < 4. 4D YM is *critical*, i.e. scale invariant at the classical level, exactly like φ⁴₄ [73, 67]. These methods give 2D/3D YM–Higgs dynamics [93] but not a 4D YM construction.

### 2.2 Gross–Neveu₂: the constructed asymptotically free prototype

**Model.** N-component Dirac fermions in d = 2 with interaction $\lambda(\bar\psi\psi)^2$. It is strictly renormalizable (scaling critical) and asymptotically free for N ≥ 2 [18, 22, 24].

**What is proven.**
- **Gawędzki–Kupiainen 1985** [19] [T]: the massive GN₂ model through *convergent* perturbation expansions for effective actions in a block-spin RG, giving control of the UV limit.
- **Feldman–Magnen–Rivasseau–Sénéor 1986** [20] [T]: massive GN₂ constructed. It satisfies the OS axioms and is the **Borel sum of its renormalized perturbation series**.
- **Disertori–Rivasseau 2000** [22] [T]: a construction without cluster or Mayer expansions, by a continuous-scale tree expansion.
- **Dimock–Yuan 2023/24** [23] [T]: the BBS method transplanted to the *UV* problem of *massless* GN₂ on a torus, giving UV stability.
- **Duch 2024 (v3 Oct 2026)** [24] [P]. The Polchinski equation is posed as a well-posed PDE on a Banach space, built with a noncommutative-probability scale decomposition of the free fermion, and solved by a Banach fixed point. The main theorem, for N ≥ 2 and small renormalized coupling λ, gives:
  - convergence of the Schwinger functions as *both* the volume and UV cutoffs are removed;
  - Euclidean invariance;
  - **non-triviality**: the truncated 4-point function is fixed to be λ times the local quartic;
  - stretched-exponential clustering;
  - an explicit coupling of the interacting field to the free field.

  Duch remarks that he could not find an earlier reference proving the existence of *both* the infinite-volume and UV limits of GN correlations.
- **Dynamical mass generation** is the *massless, chirally symmetric* model. Kopper–Magnen–Rivasseau [21] [T] proved exponential decay of the two-point function. Their result needs **large N and a fixed UV cutoff**; Duch's literature review [24, §1.4] confirms both the decay and the fixed cutoff. *(Verifier: the further claim of "at least two pure phases (discrete chiral symmetry breaking)" could not be checked against the abstract or full text, because the paper is paywalled and the abstract is truncated online. Treat it as unverified.)* The full continuum massless GN₂ with dynamically generated mass is **open**.
- **Related.** The 3D GN model at large N (perturbatively non-renormalizable but renormalizable in 1/N) was constructed by de Calan–Faria da Veiga–Magnen–Sénéor [25]. Gawędzki–Kupiainen also treated a perturbatively non-renormalizable GN variant (*Renormalization of a non-renormalizable QFT*, NPB 262 (1985) 33; cited via [24], see [26]).

**Why fermions were easier, and what that means for YM.**
- **No large-field problem for fermions.** Grassmann integrals are bounded by Gram–Hadamard determinant bounds. Each RG step is then a *convergent* expansion [22, 24, 27]. Duch's method is aimed at theories formulated with *bounded* fields. He reports the general belief that the Polchinski equation is not useful non-perturbatively for bosonic theories, and says the large-field problem "seems intractable" in that approach [24, §1.2]. The exception is sine-Gordon up to the second threshold. *(Verifier: wording softened to match the source, checked against the arXiv v3 PDF.)*
- **Lattice YM is half-way.** Link variables lie in a compact group, so they are bounded. But the effective *curvature* variables are not small, and the small/large-field split is unavoidable (Balaban [110]). Duch's "bounded fields" methods might apply to a *link-variable* formulation if a gauge-covariant scale decomposition existed [H, lead].
- **Asymptotic freedom makes non-triviality subtle.** The bare coupling vanishes logarithmically while the theory stays non-trivial. Duch fixes this by imposing renormalization conditions on the *renormalized* 4-point function [24, Rmk 1.3, 1.9]. For YM the natural analogue is to fix a renormalized gradient-flow coupling at a reference scale (§2.9).
- **The mass in massive GN₂ is put in by hand.** The infrared is then trivial. YM forbids a mass term, so the infrared problem (the mass gap) cannot be avoided. The only rigorous analogue of "IR via dynamical mass generation" is the large-N, fixed-cutoff result [21]. Jaffe–Witten add that a gap uniform in finite volume may be essential for the infinite-volume limit [15].

### 2.3 Infrared φ⁴₄ and block-spin RG (Gawędzki–Kupiainen and successors)

**What is proven.**
- **Gawędzki–Kupiainen 1985** [28] [T]: block-spin RG control of weakly coupled *critical (massless) lattice φ⁴₄*. They prove **infrared asymptotic freedom**: the effective quartic coupling flows logarithmically to 0, and long-distance behaviour is Gaussian with logarithmic corrections.
- **Feldman–Magnen–Rivasseau–Sénéor 1987** [29] [T]: infrared φ⁴₄ by a phase-space expansion, with Borel summability.
- **Hara; Hara–Tasaki 1987** [30] [T]: control of the logarithmic corrections, in particular for the susceptibility and correlation length.
- **Bauerschmidt–Brydges–Slade 2014** [44] [T]: for the n-component model (n ≥ 1, small g), $\chi\sim A\,\varepsilon^{-1}(\log\varepsilon^{-1})^{(n+2)/(n+8)}$ [46, Thm 1.6.1]. Follow-up papers by other subsets of these authors and collaborators (Bauerschmidt–Slade–Tomberg–Wallace; Slade–Tomberg) give the correlation length and the critical two-point function $\sim A'|x|^{-2}$ [46, Thms 1.6.2–1.6.3].
- **Hierarchical models.** These are exactly solvable at the level of locality and serve as a laboratory. They include:
  - the hierarchical φ⁴₄ with *negative* coupling, a UV asymptotically free toy with a non-trivial continuum limit [31] [T]. *(Verifier: the hierarchical propagator is now confirmed from the indexed abstract, which says it was chosen "for pedagogical reasons", and from Summers [14].)*
  - the continuum limit of the hierarchical O(N) σ-model [32] [T].

  Whether the *Euclidean* 2D O(N) σ-model (N ≥ 3) has a mass gap and a continuum limit is **open**. It is the closest bosonic, asymptotically free, mass-generating toy model for 4D YM.
- **Planar theories.** 't Hooft [33] and Rivasseau [34] [T] constructed *planar* "wrong-sign" φ⁴₄. This is asymptotically free, and the planar restriction removes the instability. The noncommutative (Moyal) φ⁴₄ with harmonic term has a β-function vanishing to all orders at the self-dual point [35] [T-pert]. Its self-dual version is solvable and non-trivial (Grosse–Wulkenhaar [35]). *(Verifier: [T] downgraded to [T/C]. The GW abstract says the derivation of their non-linear integral equation rests on an assumption verified **numerically** for 0 < λ ≤ 1/π. The model is a matrix model on Moyal space, not an O(4)-invariant Euclidean QFT satisfying OS.)*

**Lessons.**
- The **IR problem of critical φ⁴₄ is the mirror image of the UV problem of 4D YM.** A single marginal coupling obeys $g_{j+1}=g_j-\beta g_j^2+\dots$ with β > 0 and decays like 1/(βj). Every scale must be controlled with remainders of order $g_j^3$, summed over *infinitely many* scales. The machinery is directly reusable:
  - the BBS structural-stability theorem for non-hyperbolic fixed points [45];
  - the tuning of relevant couplings by a stable-manifold or fixed-point argument [46, Ch. 6, 8];
  - remainder norms with coupling-dependent large-field scales [46, Ch. 7–8].
- **Gauge invariance simplifies the local part.** In pure YM the only marginal gauge-invariant local term is $\operatorname{tr}F^2$; the topological $\operatorname{tr}F\tilde F$ is a total derivative. No gauge-invariant relevant term exists apart from the vacuum energy. So the "Loc" space is essentially one-dimensional, simpler than φ⁴'s (g, ν, z, u) [H, standard power counting]. The price is that the RG map itself must preserve gauge invariance.

### 2.4 The Brydges school

- **Brydges–Fröhlich–Spencer 1982** [36] [T]. A random-walk representation of spin-system correlations (developing Symanzik's idea), with new correlation inequalities. Together with Aizenman's random currents it underlies the d > 4 triviality theorems [59, 60] and the skeleton inequalities [8].
- **Brydges–Yau 1990** [37] [T]. Perturbations of massless Gaussian fields that depend only on ∇φ. This introduced the polymer-activity / norm / Loc framework later systematized by BBS, and showed Gaussian large-scale behaviour.
  *Analogy for YM [H]:* gauge invariance forces the abelian part of the effective action to depend on A only through $F=dA$. This is a "gradient perturbation" with a constraint, structurally close to Brydges–Yau.
- **Brydges' Les Houches 1984 course on cluster expansions** [38] and the **Brydges–Kennedy forest formula** [39]: the standard references for convergent expansions about Gaussian measures.
- **Finite-range decompositions** [40–42] (§1.4).
- **Brydges–Slade "RG method I–V"** [43] (Gaussian integration and normed algebras; local polynomials; perturbative analysis; stability; one RG step) and **BBS 2014** [44]: the Euclidean |φ|⁴₄ and weakly self-avoiding walk results.
- **BBS LNM 2242 (2019)** [46] [T]. A self-contained ~250-page proof for the **hierarchical** 4D n-component |φ|⁴ model. Its main theorem (Thm 4.2.1) gives the susceptibility asymptotics, with the explicit logarithmic exponent (n+2)/(n+8). The proof is organized as follows:
  - Ch. 5: RG map and the perturbative flow $\Phi^{pt}$.
  - Ch. 6: flow equations, reducing the theorem to Thm 6.2.1.
  - Ch. 7: $T_\phi$ seminorms.
  - Ch. 8: the main RG-step estimates, Thms 8.2.4–8.2.5, and the global flow.
  - Ch. 9–10: their proofs.
  - Appendix A: what changes for the Euclidean model. Fields are only approximately constant on blocks, the remainder does not factorize over blocks, and an extra W term is needed at every step.
- **Bauerschmidt–Bodineau–Dagallier** [47]. The Polchinski equation as a stochastic-dynamics tool for log-Sobolev inequalities. It links to Föllmer processes and Boué–Dupuis, i.e. the Barashkov–Gubinelli variational method.

**What transfers.**
1. The **algebraic skeleton**: progressive integration, the circle product, the local/remainder split, Loc, and the RG step as a map (V, K) ↦ (V₊, K₊) with norm bounds. This transfers verbatim, provided a *gauge-covariant* analogue of the covariance decomposition exists.
2. The **FRD gap for YM.** For a gauge-fixed linearization (e.g. Feynman gauge, −Δδ_μν), an FRD exists trivially componentwise. But the background-field covariance $(-D_A^2)^{-1}$ changes from step to step, and FRD does not commute with gauge transformations.
   - Balaban avoided FRD altogether. He used *gauge-covariant block averaging* of links with axial gauge inside blocks and Landau-type gauge for fluctuations [110].
   - **Lead [H]:** Bauerschmidt's construction [41] needs only a nearest-neighbour self-adjoint operator and Chebyshev polynomials, since finite propagation speed comes from polynomial degree. The *lattice covariant Laplacian in a fixed background* $U$, $-\Delta_U$, therefore seems to admit an FRD into positive semidefinite, gauge-*covariant*, finite-range pieces. This is unverified. It would give a Brydges-style alternative to Balaban's averaging inside small-field regions.
3. The **dynamical-systems theorem for marginal flows** [45] is model-independent and can be reused for the YM coupling flow.
4. **What does not transfer.** The random-walk and random-current representations, and correlation inequalities in general. These exist only for scalar or abelian ferromagnets. Jaffe–Witten [15, §6.1] say explicitly that correlation-inequality methods often apply only to scalar bosons or abelian gauge theories.

### 2.5 Polymer and cluster expansions

- **High-temperature and cluster expansions** (Glimm–Jaffe–Spencer [58]) give exponential clustering and mass gaps at weak coupling for P(φ)₂.
- **The abstract polymer theory** (Kotecký–Preiss [53]) gives the cleanest convergence criterion, and it is ideal for formalization.
- **Forest formulas** [39, 54]: the multiscale "jungle" formula organizes phase-space (multiscale) cluster expansions, as in FMRS and the Rivasseau book [13].
- **The loop vertex expansion** [55–57] avoids cluster and Mayer expansions for φ⁴-type models. It gives constructive matrix models and "φ⁴ without tears", and it resums perturbation theory into convergent tree sums.
- **For lattice YM:**
  - Osterwalder–Seiler's strong-coupling expansion [101] [T] gives the area law and a mass gap for *small β*. *(Verifier correction: the original line called this "the one rigorous mass-gap theorem for 4D non-abelian lattice gauge theory". That is overstated.)*
    - At strong coupling there are later, independent proofs with explicit β-ranges. One is Shen–Zhu–Zhu [136]: Langevin dynamics plus Bakry–Émery/log-Sobolev, with |β| < 1/(16(d−1)) for SU(N) in 't Hooft scaling, which gives a mass gap for the infinite-volume measure.
    - Dobrushin-uniqueness proofs also exist. One of these is already formalized in Lean [138].
    - For **finite** (possibly non-abelian) gauge groups, Adhikari–Cao [135] prove exponential decay of gauge-invariant correlations at **weak** coupling (large β) in 4D.
    - What remains true is that for a compact **Lie** gauge group, no mass-gap theorem exists outside a strong-coupling window.
  - Balaban's "Cluster expansions" paper (RG approach II) [110] adapts polymer expansions to effective actions in the small-field approximation.

**Lessons.**
1. The *mass gap* in every constructed theory comes from convergent cluster expansions about a massive Gaussian or a strongly disordered state. In 4D YM the weak-coupling (continuum) regime has no massive Gaussian to expand around. The gap must arise from the RG flow reaching strong coupling at large scales. Nobody knows how to match a weak-coupling UV RG to a strong-coupling IR cluster expansion. **This is the core open problem** [H; consistent with 15, 100].
2. A rigorous and *formalizable* stepping stone is the lattice strong-coupling gap. In Lean it would exercise the polymer and RP machinery end to end (§4.3).

### 2.6 Triviality, and why non-triviality in 4D needs asymptotic freedom

**Theorems.**
- **Aizenman 1982 and Fröhlich 1982** [59, 60] [T]: Gaussian scaling limits of φ⁴/Ising for d > 4.
- **Aizenman–Graham** [61] [T]: d = 4 partial results on the renormalized coupling.
- **Aizenman–Duminil-Copin 2021** [62] [T]: **d = 4 for any λ** (§1.6).
- **Coleman–Gross 1973** [64] [T-pert, one loop]: no renormalizable 4D theory without non-abelian gauge fields is asymptotically free.
- **Gross–Wilczek and Politzer** [65]: AF of non-abelian gauge theory.

**Interpretation [H].** ADC covers all lattice regularizations of φ⁴₄ reachable by nearest-neighbour ferromagnetic approximation. With the perturbative evidence for QED₄, Yukawa₄ and others, it supports the folklore that every 4D QFT with a positive one-loop β-function is trivial. AF gauge theories escape. No general theorem says "non-trivial ⇒ AF" in 4D. The statement is a strongly supported heuristic, not a theorem.

A recent preprint (Ragin, arXiv:2610.12672 [134]) [C/H] explores interacting 4D φ⁴-like constructions that renormalize coefficients first rather than taking lattice cutoff limits. It does not contradict ADC, which concerns lattice limits. I have not assessed it.

**Lessons for YM.**
1. ADC's *method* (random currents) is unavailable for SU(N). Its *message* is that a 4D construction must exploit asymptotic freedom quantitatively.
2. **A non-triviality certificate for YM [H, my analysis].** In a free (Gaussian) Maxwell-type theory, $t^2\langle E(t)\rangle$ does not depend on t. In YM, $t\,\frac{d}{dt}\big(t^2\langle E(t)\rangle\big)\ne0$, by dimensional transmutation and running. Proving that this *t-dependence* survives the continuum limit, for example as $t^2\langle E(t)\rangle\to0$ like $1/\log(1/t)$ as t → 0 (AF), would be a gauge-invariant analogue of Duch's "non-zero 4-point function" condition and of ADC's renormalized coupling. It is a clean statement for both the informal proof and Lean.

### 2.7 Flow-equation (Polchinski) approaches

**Perturbative:**
- Polchinski 1984 [48]: a short proof of perturbative renormalizability.
- Keller–Kopper–Salmhofer, Müller [49], Kopper [49] (reviews).
- **Efremov–Guida–Kopper 2017** [50] [T-pert]: perturbative renormalization of SU(2) YM with flow equations, with gauge invariance restored through Slavnov–Taylor identities at zero IR cutoff.
- **GFERG** (Sonoda–Suzuki; Nagao–Suzuki 2025 [89]) [T-pert/H]: a gradient-flow exact RG that keeps gauge symmetry more manifest. Its one-loop β-function is correct, and its correspondence with Lüscher–Weisz is argued to hold to all orders.

**Non-perturbative:**
- Brydges–Kennedy [39] and Disertori–Rivasseau [22] (expansion-based).
- Duch [24] [P] (direct, fermions).
- Duch's flow-equation framework for singular SPDEs [76], which *does* solve a large-field problem for sub-critical bosonic models and was used for fractional Φ⁴₃ [75].

**Lesson.** For 4D YM, a non-perturbative Polchinski flow is not available. The obstacles are the large-field problem, gauge non-covariance of momentum cutoffs, and the loss of RP. The perturbative flow-equation proofs are valuable mainly as a *check* that a constructive scheme reproduces the standard renormalization constants.

### 2.8 Lüscher's gradient flow: finite continuum observables

**What is established.**
- **All-orders finiteness** [81, 83] [T-pert] (§1.7). The (4+1)-dimensional local-field-theory trick plus BRS symmetry is an elegant structural argument. Non-perturbatively it is supported by lattice numerics:
  - $\sqrt{8t_0}/r_0$ extrapolates to the continuum with $O(a^2)$ effects [80];
  - topological sectors separate dynamically as the lattice spacing shrinks [80, 94].
- **Lattice flow facts** [79, 80]:
  - existence, uniqueness and smoothness for all t on a finite lattice [T];
  - the flow map is a diffeomorphism, with a Jacobian proportional to the integrated Wilson action along the flow [T];
  - the transformed functional integral is dominated by smooth fields. **[H]** *(Verifier: this item was tagged [T]. Lüscher's own abstract [80] says theoretical and numerical studies "suggest" that the flowed field is smooth, so it is not a theorem.)*
- **Renormalized local operators** from the small-t expansion: the energy–momentum tensor [84] and chiral/fermion extensions [82]. Harlander–Shindler [90] review applications to the OPE.
- **A non-perturbative running coupling.** $g^2_{GF}(\mu)\propto t^2\langle E(t)\rangle$ at $\mu=1/\sqrt{8t}$ [80], with finite-volume versions [86, 87] and step scaling [88]. This is the cleanest gauge-invariant renormalized coupling for a rigorous statement of asymptotic freedom.
- **Smeared Wilson loops** [85] [H, numerical]: Narayanan–Neuberger found that flowed (smeared) loops have finite, non-trivial continuum limits on the lattice. Lüscher–Weisz §8.2 explains why perturbatively.
- **Rigorous continuum side (3D):**
  - L. Gross [91]: stability of the YM heat equation for finite action.
  - Cao–Chatterjee [92] [T, conditional]: YM heat flow (DeTurck gauge) from GFF-like random initial data on the 3D torus. *If* 3D YM behaves like the GFF at short distances, the theory can be defined as random distributional gauge orbits, with **regularized Wilson loops**. *(Verifier: the state-space paper is published in CMP 405 (2024). The construction of the 3D YM measure itself remains open; the result is conditional on the GFF-like hypothesis.)*
  - CCHS [93] [T]: a gauge-orbit state space built with DeTurck-type YM heat flows, used in stochastic quantization. The Markov process on orbits is defined up to a possible finite-time blow-up.

**How it plugs into a 4D construction [H, my synthesis].**
1. **Observables.** Define the continuum theory by Schwinger functions of flowed gauge-invariant local fields $\mathcal O(t,x)$ at fixed t > 0: E(t,x), $\operatorname{tr}G_{\mu\nu}G_{\rho\sigma}(t,x)$, flowed Wilson loops. These are *bounded smooth functionals* on the lattice. Their expectations are what an RG analysis can control uniformly in the lattice spacing a.
2. **Local fields required by Clay.** Obtain renormalized $\operatorname{tr}F^2(x)$ etc. as $t\to0$ limits of $\mathcal O(t,x)-\sum_kc_k(t)(\cdots)$, with $c_k(t)$ fixed by AF asymptotics. This is precisely the "agreement with AF and perturbative renormalization at short distances" in [15].
3. **RP subtlety.** A flowed field at $x_0>0$ depends on the gauge field in *all* of spacetime, through Gaussian heat-kernel tails, so it is not measurable with respect to the half-space σ-algebra. RP (OS3) therefore cannot be stated *for the flowed fields themselves*. Two remedies:
   - (a) Prove RP for the measure using sharp lattice observables, i.e. Wilson loops or plaquette functions in the half-space, and treat flowed fields as derived quantities whose Schwinger functions are reconstructed from the measure.
   - (b) Use the t → 0 limits (local fields), which *are* localized.

   Spatial-only flows preserve time-localization but break O(4). The Lüscher–Weisz finiteness proof uses the full symmetry and would need re-examination [H, lead].
4. **Lattice-to-continuum identification.** Lüscher–Weisz §8.4 [81] argues that lattice flowed correlators converge to the dimensional-regularization values up to finite coupling renormalization. Making that non-perturbative *is* a large part of the existence problem.

### 2.9 Renormalization of Wilson loops

**Established [T-pert].**
- Smooth simple loops renormalize multiplicatively through the perimeter term, with no further divergence after coupling renormalization (Dotsenko–Vergeles [96]; Brandt–Neri–Sato, all orders [97]).
- Cusps carry Γ_cusp (Polyakov [95]; Korchemsky–Radyushkin two-loop [98]; Grozin–Henn–Korchemsky–Marquard three-loop [99]).
- Intersections mix.

**Status.** Non-perturbative control of sharp Wilson loops in d ≥ 3 is **open**. Chatterjee [100, Problem 5.2] states the continuum problem precisely as a two-term expansion of rectangular loops, with a divergent perimeter coefficient c(β) and a finite string-tension coefficient d:
$$\log\langle W_{R/\epsilon,T/\epsilon}\rangle=-c(\beta)(R+T)-d\,RT+o(1).$$
He also notes that it is unproved whether the perimeter subtraction is even needed.

**Lessons.**
1. **Sharp loops are bad primary observables for a construction.** Their renormalization is non-local (perimeter and cusps) and the needed subtraction depends on the regularization. Prefer flowed or smeared loops or local operators.
2. **Sharp loops remain the right objects for confinement** (area law, static potential). Perimeter terms cancel in the force $V'(R)$, and Creutz-type ratios are finite [H, standard].
3. For OS in loop form (Seiler [105]), loops in the half-space are perfectly compatible with RP. This is one reason the loop formulation is attractive *on the lattice*.

### 2.10 OS reconstruction for gauge theories: specifics

**Established [T].**
- **The Wilson lattice measure is RP** [101]. Its transfer matrix is self-adjoint and strictly positive on gauge-invariant states [102]. Gauss's law is implemented by restricting to gauge-invariant wave functions of the spatial links. The Hamiltonian is $H=-a^{-1}\log T$.
- **Many improved actions are not reflection positive.** For example, actions with 1×2 rectangles; Lüscher–Weisz [103] analyse the resulting transfer matrix. Fredenhagen [104] treats real-time evolution in Euclidean lattice gauge theory. **Use the plain Wilson action, or another provably RP action, in a construction.**
- **Seiler's LNP 159** [105] gives a full treatment of lattice gauge theories as constructive QFT, and formulates the continuum problem through Wilson-loop functionals.
- **Fröhlich–Osterwalder–Seiler** [106] give an analytic-continuation theory for "virtual representations". This is an abstract analytic-continuation theorem of the kind used to reconstruct Lorentz boosts from Euclidean rotations.
- **Completed interacting gauge-theory constructions:**
  - the 2D abelian Higgs model, satisfying OS (Brydges–Fröhlich–Seiler [107]). In 2000 Jaffe–Witten called it the only complete example of an interacting gauge theory satisfying the axioms [15].
  - the 3D U(1) Higgs continuum limit (King [108]).
  - U(1)₃ (L. Gross) and U(1)₄ (Driver, a free theory) [109].
  - 2D YM (Driver, Gross–King–Sengupta, Lévy, and others; see [100]).
- **Elitzur, Strocchi and FMS** (§1.10).

**The 4D-YM OS checklist this implies [H].**
1. RP: inherited from the Wilson measure. The estimates must be about that measure, not about an auxiliary regularization.
2. Euclidean invariance: translations come from infinite volume. Rotations need a proof (hypercubic → O(4)).
3. Regularity and temperedness: Schwinger functions of the chosen gauge-invariant fields must be tempered distributions off the diagonal, with OS growth bounds.
4. Clustering and the mass gap: a *separate* infrared theorem. OS4 needs only clustering; Clay needs the gap.
5. Local fields: gauge-invariant composite operators renormalized consistently with asymptotic freedom (via flow, §2.8).
6. No ghosts, no BRST, no Gribov: the OS Hilbert space is automatically the physical, gauge-invariant one.

Points 1, 5 and 6 are *design choices* settled at the start. Points 2–4 are theorems.

### 2.11 Gribov/Singer obstructions and how constructive approaches avoid them

**Established [T].**
- Gribov copies exist in Landau and Coulomb gauges [121].
- No continuous complete gauge slice exists (Singer [122]; Narasimhan–Ramadas for SU(2) on S³ [123]).
- Every orbit enters Ω, and the fundamental modular region Λ is well defined (Dell'Antonio–Zwanziger [124]; review [126, 128]).
- Lattice BRST gives 0/0 (Neuberger [127]).

**Heuristic or contested [H/C].**
- The Gribov–Zwanziger local action [125] and its infrared consequences for gauge-*dependent* propagators. Its gluon propagator maximally violates (gauge-variant) positivity [128, §4]. This is irrelevant to OS for gauge-invariant observables.
- Whether integrating over Ω instead of Λ changes expectations is conjectured not to matter [128]. It is not proven.

**How constructive approaches avoid the obstruction.**
1. **Compact lattice gauge theory** never fixes a global gauge: Haar measure plus gauge-invariant observables.
2. **Balaban** fixes gauges *locally*, block by block and scale by scale: axial in blocks, Landau-type for fluctuations, and only in small-field regions. There the field is close to a pure gauge, and the gauge condition has a unique solution in a neighbourhood (inside Ω). In large-field regions no gauge fixing is needed. Their probability is shown to be tiny, because each large-field block costs about $e^{-c/g_k^2}$ [110]. *(Verifier: Jaffe–Witten §6.5 [15] only mentions "quantitative estimates on effects arising from large values of the gauge field". The $e^{-c/g_k^2}$ form is the standard description of Balaban's large-field bounds and is not stated in [15].)*
3. **Magnen–Rivasseau–Sénéor** [111] [T, limited scope]:
   - continuum SU(2) YM₄ with a fixed IR cutoff and no UV cutoff;
   - trivial topological sector and a regularized axial gauge;
   - axial-gauge positivity for large fields, a different gauge for small fields;
   - the gauge-restoring counterterms and the background-field effects are shown to be stabilizing for suitable momentum cutoffs;
   - Slavnov identities verified non-perturbatively.

   Its limits are that it works in the trivial sector only, the IR cutoff is not removed, the regularization is gauge-dependent, and (to my knowledge) RP is not established.
4. **Topology.** The space of lattice fields is connected. Topological sectors exist only for "admissible" (smooth-plaquette) fields [94]. Lüscher's flow study [80] shows that the sectors separate dynamically as a → 0. Any continuum construction on T⁴ has to sum over sectors, or show why one sector suffices. The question is resolved trivially if the construction is formulated as the a → 0 limit of the full lattice measure.

**Lesson.** The Gribov/Singer problem is a reason **not** to construct YM through a global continuum gauge-fixed functional integral. It does not obstruct a gauge-invariant lattice construction. It reappears, mildly, as the need for *local* gauge fixing in small-field regions within the RG.

### 2.12 Where 4D YM stands relative to the toolkit

- **Balaban 1983–89** [110] [T as published; C on completeness]:
  - propagators and averaging operations for lattice gauge fields;
  - regular-configuration spaces and gauge fixing;
  - 3D and 4D UV stability on a torus, with effective actions controlled uniformly in the lattice spacing;
  - coupling-constant renormalization in 4D, cluster expansions, and large-field R-operation bounds.

  Jaffe–Witten [15, §6.5] call the 3D work an important step toward the continuum limit on a compactified space-time, which must still be extended to expectations of gauge-invariant functions. They call the 4D extension a "qualitative breakthrough", including the analysis of AF and of large-field effects. Chatterjee [100] calls it UV stability, i.e. compactness (existence of convergent subsequences) of the effective theories. *(Verifier correction, aligned with note 02's own verifier log.)* Note 02 does **not** say the work is "regarded as essentially correct". It records mixed expert opinion: Bauerschmidt says Balaban "basically did it", but also calls the papers incomplete and extraordinarily hard to read, and says nobody can currently tell whether they are correct. Dimock's expositions [11] reconstruct the method for φ⁴₃, a model case, and scalar QED₃ (arXiv:1502.02946, in the library).
- **Federbush's phase-cell programme** [112], partial.
- **Chatterjee** [132] [T]: a Gaussian scaling limit of SU(2) lattice YM–Higgs in a degenerate regime. It is a "small step" and Gaussian.
- **OpenAI claim (Sept–Oct 2026)** [C]: existence (no mass gap) of 4D YM, and reportedly QCD, building on Balaban's ideas. The reported timeline is a natural-language YM proof on 9 Sep 2026 and a Lean formalization of pure-YM existence finished on 16 Oct 2026. Custody passed to the Gross-chaired shepherding committee (Douglas, Gross, Jaffe, Klebanov, Nekrasov), which credits Balaban's RG and lists the mass gap and confinement as open. As of 2026-11-05 **no theorem statement, Lean code or manuscript is public**. A Lean release was announced as expected around the week of 9 Nov (note 02; re-checked by web search on 2026-11-05, with no newer release found).
- **Claims not accepted.** Example: Farinelli, arXiv:1406.4177 [133] [X], claims a mass gap in a Coulomb-gauge Hamiltonian framework (17 versions). It is not accepted by the community and I have not assessed it. It is listed only as a caution about unrefereed claims.

---

## 3. What is proven vs open

| # | Statement | Status | Key refs |
|---|---|---|---|
| 1 | P(φ)₂: OS/Wightman axioms; mass gap at weak coupling; phase transition at strong coupling | **[T]** | [5–7, 58, 15] |
| 2 | φ⁴₃ weak coupling: infinite volume, Wightman axioms, mass gap | **[T]** | [1–4] |
| 3 | φ⁴₃ any positive coupling: limit points satisfy OS except rotation and clustering | **[T]** | [70] |
| 4 | φ⁴₃ small coupling: all OS axioms (incl. rotations) and exponential decay via SPDE | **[P]** | [74] |
| 5 | φ⁴₄ (single-component, n.n. ferromagnetic lattice, any λ): every scaling limit is Gaussian | **[T]** | [62] (d > 4: [59, 60]; long-range d_eff ≥ 4: [63] [P]) |
| 6 | φ⁴₄ weak coupling: precise logarithmic critical behaviour | **[T]** | [28–30, 44] |
| 7 | Non-trivial φ⁴₄ by *any* construction | **Open; believed false** [H] | [62, 15, 134] |
| 8 | Massive GN₂ (N ≥ 2): constructed, OS, Borel summable | **[T]** | [19, 20, 22] |
| 9 | GN₂ via a well-posed Polchinski PDE, both limits, non-trivial | **[P]** | [24] |
| 10 | Massless GN₂: dynamical mass generation in the continuum | **Open**; large N with fixed UV cutoff **[T]** | [21] |
| 11 | 2D O(N) σ-model (N ≥ 3): mass gap and continuum limit | **Open**; hierarchical version **[T]** | [32] |
| 12 | Planar wrong-sign φ⁴₄; self-dual noncommutative φ⁴₄ | **[T]** (planar); **[T/C]** (GW: one step rests on a numerically verified assumption; not an OS theory on ℝ⁴) | [33–35] |
| 13 | Gradient-flow fields finite at t > 0 to all orders | **[T-pert]** | [81, 83] |
| 14 | Same, non-perturbatively | **Open** (strong numerical evidence) [H] | [80, 85] |
| 15 | Smooth Wilson loops multiplicatively renormalizable; cusp anomalous dimension | **[T-pert]** | [95–99] |
| 16 | Non-perturbative continuum Wilson loops for non-abelian YM in d ≥ 3 | **Open** (3D conditional constructions **[P]**) | [100, 92] |
| 17 | Wilson action RP; strictly positive transfer matrix | **[T]** | [101, 102] |
| 18 | Lattice YM area law and mass gap at strong coupling (small β) | **[T]** | [101], [136] |
| 18a | Finite (possibly non-abelian) gauge groups, 4D, weak coupling: exponential decay of gauge-invariant correlations | **[T-pre]** (accepted, Ann. Probab.) | [135] |
| 19 | Balaban: UV stability of 3D and 4D lattice YM on a torus | **[T]** as published; completeness and verifiability debated **[C]** | [110], note 02 |
| 20 | MRS: SU(2) YM₄ Schwinger functions with fixed IR cutoff, trivial sector, regularized axial gauge | **[T]** (limited scope) | [111] |
| 21 | 4D YM existence on ℝ⁴ (any compact simple G) satisfying OS | **Open** in the literature; OpenAI claim **[C]** | [15], note 02 |
| 22 | 4D YM mass gap | **Open** (not claimed by OpenAI) | [15] |
| 23 | No continuous complete gauge slice (Singer); every orbit meets Ω | **[T]** | [122, 124] |
| 24 | Integrating over Ω equals integrating over Λ | **Conjecture** [H] | [128] |
| 25 | Lattice BRST global gauge fixing gives 0/0 | **[T]** | [127] |
| 26 | Local covariant gauges plus Gauss's law need indefinite metric (Strocchi) | **[T]** (axiomatic) | [115, 116] |
| 27 | 2D abelian Higgs (OS); 3D U(1) Higgs continuum; 2D YM | **[T]** | [107, 108, 100] |
| 28 | 3D YM–Higgs stochastic quantization: local solutions, gauge-covariant Markov process on orbits (up to possible finite-time blow-up), unique mass renormalization | **[T]** | [93] |
| 29 | 3D YM measure (non-abelian) | **Open** | [92, 93, 100] |
| 30 | "Non-trivial 4D QFT ⇒ asymptotically free" | **Heuristic**: Coleman–Gross [T-pert] plus ADC [T] for φ⁴ | [62, 64] |
| 31 | FRD of lattice −Δ, positive semidefinite, finite range | **[T]** | [40, 41] |
| 32 | Gauge-covariant FRD of $-\Delta_U$ in a background | **Unknown; lead** [H] | §2.4 |
| 33 | Non-hyperbolic RG flows (structural stability) | **[T]** | [45] |
| 34 | Lean: OS (Glimm–Jaffe) axioms for the 4D free field; P(Φ)₂ in progress | Formalized **[T]**; pphi2 partial, with project axioms remaining (Reservoir/README status, 2026-11-05) | [131] |
| 35 | Lean: OS → Wightman reconstruction (scalar fields) | Self-reported sorry-free and project-axiom-free; not in Mathlib; not rebuilt here **[R]** | [137] |
| 36 | Lean: strong-coupling exponential decay for U(n) Wilson LGT (Dobrushin) | Self-reported sorry-free and axiom-free **[R]** | [138] |

---

## 4. Relevance to a 4D YM existence + mass-gap proof and to Lean formalization

### 4.1 The architecture the toolkit points to [H, synthesis]

1. **Regularization.** Use the Wilson action on $(a\mathbb Z)^4$, on tori of side $L_{\rm phys}$. RP, gauge invariance and compactness of the links are exact.
2. **UV analysis (fixed physical volume).** Run a Balaban-type multiscale RG: gauge-covariant block averaging, a small/large-field split, local gauge fixing only in small-field regions, and a polymer representation of remainders in BBS-style norms.
   - The flow of the single marginal coupling is controlled by asymptotic freedom over infinitely many scales, using the abstract theorem of [45] in reverse scale direction.
   - Output: convergence, not just compactness, of expectations of *flowed* gauge-invariant observables as a → 0 at fixed volume, with a renormalized gradient-flow coupling fixed at a reference scale. Non-triviality is certified by the t-dependence of $t^2\langle E\rangle$ (§2.6).
3. **Local fields.** Obtain renormalized $\operatorname{tr}F^2$ and other local fields from the small-flow-time expansion. Check the AF short-distance asymptotics required by [15].
4. **Infinite volume.** Remove the IR cutoff. In all known constructions this needs *clustering*, i.e. a mass gap or at least decay of correlations, uniformly in volume [15, §6.5]. This is the hardest step and is untouched by the classical toolkit in 4D.
5. **OS reconstruction:**
   - RP is inherited from step 1.
   - Translations come from step 4.
   - Rotations require a separate proof (hypercubic → O(4)).
   - Temperedness and growth bounds come from steps 2–3.
6. **Mass gap.** No existing method applies to the continuum. The rigorous gap mechanisms known so far are:
   - expansions around massive or disordered states: strong-coupling lattice YM [101], with Bakry–Émery/Dobrushin variants [136, 138], and large-N fixed-cutoff GN [21];
   - for finite gauge groups only, low-temperature expansions around the ordered state at weak coupling [135].

   None of these controls a compact Lie group at weak coupling.

### 4.2 What to check in any claimed proof, including OpenAI's [H]

Derived from the toolkit:
- **Which regularization?** If it is not a reflection-positive lattice action, how is RP obtained?
- **Gauge-covariant multiscale decomposition.** Is it Balaban's averaging, or something new such as a covariant FRD?
- **Topology, gauge fixing and Gribov.** How are topological sectors and large-field regions handled? Where is gauge fixing used, and is it local only?
- **Observables.** Which observables are proven to converge: Wilson loops, flowed fields, local tr F²? Convergence or only subsequential limits (Clay footnote 2)?
- **Rotation invariance.** How is it proven?
- **Infinite volume.** How is it obtained without a mass gap? Through translation-invariant subsequential limits only? Uniqueness?
- **Non-triviality.** Which quantity is shown to be non-Gaussian?
- **Asymptotic freedom.** Do the short-distance asymptotics of local composite fields match AF, as Jaffe–Witten require?

### 4.3 Lean formalization: toolkit modules, ordered by tractability

| Module | Content | Size / difficulty | Notes |
|---|---|---|---|
| F1 | Finite-dimensional Gaussian integration; FRD by Chebyshev polynomials [41] | Moderate | Pure linear algebra and probability. A good first agent task. |
| F2 | Polymer expansions: Kotecký–Preiss [53]; BKAR forest formula [39, 54] | Moderate | Combinatorics plus analysis. Reusable everywhere. |
| F3 | Wilson lattice gauge theory on a finite lattice: Haar measure on compact G, gauge invariance, Elitzur, **RP of the Wilson action**, **positive transfer matrix** [101, 102] | Moderate | Finite-dimensional. Mathlib has Haar measure. Gives formal OS3 at the lattice level. |
| F4 | **Strong-coupling mass gap and area law** for lattice YM [101] | Moderate–large | A genuine (lattice) mass-gap theorem in Lean, exercising F2 and F3. Recommended pilot for an agent swarm. *(Verifier: the exponential-decay half already exists, self-reported, via Dobrushin uniqueness in `mrdouglasny/lgt` [138], for U(n) and β < 1/(32n(d−1)). Reuse it. The new work would be the area law, the Osterwalder–Seiler cluster-expansion route, and a transfer-matrix **spectral** gap rather than correlation decay.)* |
| F5 | Wilson flow on a finite lattice: existence, uniqueness, diffeomorphism, Jacobian formula [79] | Moderate | ODE on a compact manifold $G^{\#\text{links}}$. |
| F6 | **BBS hierarchical RG** end to end [46] | Large (~250 pp.) | Self-contained, with explicit modular interfaces (Thms 8.2.4–8.2.5, the flow theorem, [45]). The best rehearsal of an AF-type marginal flow with remainder norms. |
| F7 | GN₂ via a Banach fixed point [24] | Large | A complete critical asymptotically free continuum construction with a fixed-point proof. Its formal structure is closer to Lean than cluster expansions. |
| F8 | OS reconstruction theorem (OS 1973/75) | Large, but partly done | Not in Mathlib. *(Verifier: `xiyin137/OSreconstruction` [137] self-reports a sorry-free, project-axiom-free distributional OS → Wightman reconstruction for **scalar** fields, Comparator-checked against a Mathlib-only statement file. Building on it would cut F8 to the gauge-invariant-observable / composite-field adaptation. Rebuild and audit before relying on it.)* Douglas et al. formalized the Euclidean OS (Glimm–Jaffe) axioms for the 4D free field [131]. The pphi2 package targets P(Φ)₂ on ℝ², with project axioms remaining, and its README says it does not formalize the reconstruction step. |
| F9 | Lüscher–Weisz all-orders finiteness | Very large detour | Formalizing all-orders perturbative renormalization is probably not worth it. A constructive proof should establish non-perturbative finiteness of flowed observables directly. |

**AI-workflow implications [H].** BBS-type proofs suit parallel agents because each RG step is a *lemma with a contract*. Inputs are (V, K) in a stated domain with stated norms; outputs are (V₊, K₊) with stated bounds; constants are explicit. The global flow is then a separate dynamical-systems theorem. Balaban's papers lack this explicit modularity, which is one reason they are hard to verify. A formalization effort, or a review of an AI-generated proof, should first *re-express* the Balaban-type argument in BBS-style contracts.

Formalizing F3–F5 early would also give machine-checked lattice-level RP, a transfer matrix, and a strong-coupling gap. These are the parts of any YM proof that are easiest to state precisely and least likely to be in dispute.

---

## 5. Open questions and leads

1. **Gauge-covariant finite-range decomposition.** Does Bauerschmidt's Chebyshev / finite-propagation construction [41] apply to the lattice covariant Laplacian $-\Delta_U$, and to the gauge-field Hessian in background-field gauge, giving positive semidefinite, gauge-covariant, finite-range pieces with uniform scaling bounds in small-field regions? If yes, could BBS norms replace Balaban's averaging? [H; high-value, checkable.]
2. **Non-triviality certificate.** Prove, in any lattice-to-continuum scheme, that $t\frac{d}{dt}(t^2\langle E(t)\rangle)\neq0$, or that $t^2\langle E\rangle\to0$ logarithmically as t → 0. Relate this to Lüscher's one-loop formula [80].
3. **RP and flowed observables.** Formulate OS for a gauge-orbit measure (CCHS/Cao–Chatterjee style state spaces) so that RP is stated on a half-space σ-algebra and flowed fields enter only as derived observables. Do the 3D state spaces [92, 93] carry a natural reflection structure?
4. **Rotation invariance from hypercubic symmetry.** Find a rigorous mechanism: irrelevance of dimension-6 operators plus uniqueness of the limit, or an RP-based trick (note 02 reports Sussman–Alpöge mention one; obtain and read it).
5. **Bounded-field flow equations for links.** Can Duch's Banach fixed-point formulation of the Polchinski equation [24] be adapted to compact link variables, given a gauge-covariant scale decomposition (lead 1)?
6. **IR problem toys.** The 2D O(N) σ-model mass gap is open and AF and bosonic. It is the cleanest testbed for "UV RG + IR mass generation". Kopper–Magnen–Rivasseau's large-N GN [21] is the only rigorous dynamical-mass example. Can its mechanism (auxiliary field + 1/N) be imported to large-N YM or the σ-model?
7. **Strong-coupling ↔ weak-coupling matching.** Is there any rigorous interpolation, for example finite-volume Lüscher-type step scaling [88] turned into a computer-assisted proof, between the AF regime and the Osterwalder–Seiler cluster-expansion regime?
8. **Topology.** In a Balaban-type construction on T⁴, how are large-field configurations near instantons treated? Does the limit include all sectors with the correct θ = 0 weighting? Lüscher's admissibility [94] and dynamical separation [80] are the starting points.
9. **Clay footnote 2.** In each claimed construction, is convergence proven, or only compactness? Duch's remark about GN₂ [24] shows that even "classical" constructions should be re-audited on this point.
10. **Lean infrastructure.** Coordinate with these projects rather than duplicating the Gaussian-measure, nuclear-space, reconstruction and lattice-gauge foundations:
    - the Douglas et al. `OSforGFF` / `gaussian-field` / `pphi2` ecosystem [131];
    - `xiyin137/OSreconstruction` [137];
    - `mrdouglasny/lgt` [138].

    See note 10 for the self-reported axiom and sorry counts.

---

## References

Verification legend: **V** = existence and bibliographic data confirmed live, via the arXiv API, Crossref DOI lookup, a publisher, Numdam or Clay page, or the author's hosted PDF. **V(part)** = partially confirmed (some bibliographic detail from memory, noted). **U** = recalled but not independently confirmed. "PDF" = present in `library/pdfs/` (files downloaded by this workstream are marked *dl08*).

1. J. Glimm, A. Jaffe, *Positivity of the φ⁴₃ Hamiltonian*, Fortschr. Phys. 21 (1973) 327–376. doi:10.1002/prop.19730210702 — **V**
2. J. Feldman, *The λφ⁴₃ field theory in a finite volume*, CMP 37 (1974) 93–120. doi:10.1007/BF01646205 — **V**
3. J. Feldman, K. Osterwalder, *The Wightman axioms and the mass gap for weakly coupled (φ⁴)₃ quantum field theories*, Ann. Phys. 97 (1976) 80–135. doi:10.1016/0003-4916(76)90223-2 — **V**
4. J. Magnen, R. Sénéor, *The infinite volume limit of the φ⁴₃ model*, Ann. IHP A 24 (1976) 95–159. Numdam AIHPA_1976__24_2_95_0 — **V**
5. J. Glimm, A. Jaffe, T. Spencer, *The Wightman axioms and particle structure in the P(φ)₂ quantum field model*, Ann. Math. 100 (1974) 585–632. doi:10.2307/1970959 — **V**
6. F. Guerra, L. Rosen, B. Simon, *The P(φ)₂ Euclidean QFT as classical statistical mechanics*, Ann. Math. 101 (1975) 111–189 (I) and 191ff (II). doi:10.2307/1970988, 10.2307/1970989 — **V**
7. E. Nelson, *Construction of quantum fields from Markoff fields*, J. Funct. Anal. 12 (1973) 97–112. doi:10.1016/0022-1236(73)90091-8 — **V**
8. D. Brydges, J. Fröhlich, A. Sokal, *A new proof of the existence and nontriviality of the continuum φ⁴₂ and φ⁴₃ quantum field theories*, CMP 91 (1983) 141–186. doi:10.1007/BF01211157 — **V**
9. G. Benfatto, M. Cassandro, G. Gallavotti, F. Nicolò, E. Olivieri, E. Presutti, E. Scacciatelli, *Ultraviolet stability in Euclidean scalar field theories*, CMP 71 (1980) 95–130, doi:10.1007/BF01197916; and *Some probabilistic techniques in field theory*, CMP 59 (1978) 143–166, doi:10.1007/BF01614247 — **V**
10. D. Brydges, J. Dimock, T. R. Hurd, *The short distance behavior of (φ⁴)₃*, CMP 172 (1995) 143–186. doi:10.1007/BF02104514 — **V**
11. J. Dimock, *The renormalization group according to Balaban I (small fields), II (large fields), III (convergence)*: arXiv:1108.1335 (RMP 25, doi:10.1142/S0129055X13300100), arXiv:1212.5562 (JMP, doi:10.1063/1.4821275), arXiv:1304.0705 (AHP, doi:10.1007/s00023-013-0303-3); also *Nonperturbative renormalization of scalar QED in d = 3*, arXiv:1502.02946 — **V**, PDF (pre-existing)
12. J. Glimm, A. Jaffe, *Quantum Physics: A Functional Integral Point of View*, 2nd ed., Springer 1987. doi:10.1007/978-1-4612-4728-9 — **V**
13. V. Rivasseau, *From Perturbative to Constructive Renormalization*, Princeton UP 1991 (incl. ch. III.5, *The ultraviolet problem in non-abelian gauge theories*). doi:10.1515/9781400862085 — **V**
14. S. J. Summers, *A perspective on constructive quantum field theory*, arXiv:1203.3991 — **V**, PDF (pre-existing)
15. A. Jaffe, E. Witten, *Quantum Yang–Mills theory* (Clay Millennium problem description), https://www.claymath.org/wp-content/uploads/2022/06/yangmills.pdf — **V** (PDF read: §4 problem, §6 perspective, footnotes 1–2)
16. K. Osterwalder, R. Schrader, *Axioms for Euclidean Green's functions*, CMP 31 (1973) 83–112, doi:10.1007/BF01645738; *II*, CMP 42 (1975) 281–305, doi:10.1007/BF01608978 — **V**
17. A. Jaffe, *Reflection positivity then and now*, arXiv:1802.07880 — **V**, PDF (pre-existing)
18. D. Gross, A. Neveu, *Dynamical symmetry breaking in asymptotically free field theories*, PRD 10 (1974) 3235–3253. doi:10.1103/PhysRevD.10.3235 — **V**
19. K. Gawędzki, A. Kupiainen, *Gross–Neveu model through convergent perturbation expansions*, CMP 102 (1985) 1–30. doi:10.1007/BF01208817 — **V**
20. J. Feldman, J. Magnen, V. Rivasseau, R. Sénéor, *A renormalizable field theory: the massive Gross–Neveu model in two dimensions*, CMP 103 (1986) 67–103, doi:10.1007/BF01464282; *Massive Gross–Neveu model: a rigorous perturbative construction*, PRL 54 (1985) 1479, doi:10.1103/PhysRevLett.54.1479 — **V**
21. C. Kopper, J. Magnen, V. Rivasseau, *Mass generation in the large N Gross–Neveu model*, CMP 169 (1995) 121–180. doi:10.1007/BF02101599 — **V** (content from the indexed abstract and Duch's summary)
22. M. Disertori, V. Rivasseau, *Continuous constructive fermionic renormalization*, AHP 1 (2000) 1–57. arXiv:hep-th/9802145 — **V**
23. J. Dimock, C. Yuan, *Structural stability of the RG flow in the Gross–Neveu model*, Ann. Henri Poincaré 25 (2024) 5113–5186, doi:10.1007/s00023-024-01427-0; arXiv:2303.07916 — **V** (journal data now Crossref-confirmed)
24. P. Duch, *Construction of Gross–Neveu model using Polchinski flow equation*, arXiv:2403.18562 (v3, 15 Oct 2026) — **V**, PDF (pre-existing)
25. C. de Calan, P. A. Faria da Veiga, J. Magnen, R. Sénéor, *Constructing the three-dimensional Gross–Neveu model with a large number of flavor components*, PRL 66 (1991) 3233. doi:10.1103/PhysRevLett.66.3233 — **V**
26. K. Gawędzki, A. Kupiainen, *Asymptotic freedom beyond perturbation theory*, in K. Osterwalder, R. Stora (eds.), *Critical Phenomena, Random Systems, Gauge Theories* (Les Houches XLIII, 1984), North-Holland 1986, pp. 185–293 — **V(part)** (two independent citing works agree; page end 293, not 294; no publisher record found). Related items: *Renormalization of a non-renormalizable quantum field theory*, NPB 262 (1985) 33–48, doi:10.1016/0550-3213(85)90062-8 — **V** (Crossref); *Rigorous renormalization group — asymptotic freedom and non-Gaussian fixed points*, Physica A 124 (1984) 455–463, doi:10.1016/0378-4371(84)90261-9 — **V**
27. M. Salmhofer, C. Wieczerkowski, *Positivity and convergence in fermionic quantum field theory*, J. Stat. Phys. 99 (2000) 557–586, doi:10.1023/A:1018661110470; arXiv:math-ph/9909002 — **V** (Crossref)
28. K. Gawędzki, A. Kupiainen, *Massless lattice φ⁴₄ theory: rigorous control of a renormalizable asymptotically free model*, CMP 99 (1985) 197–252. doi:10.1007/BF01212281 — **V**
29. J. Feldman, J. Magnen, V. Rivasseau, R. Sénéor, *Construction and Borel summability of infrared Φ⁴₄ by a phase space expansion*, CMP 109 (1987) 437–480. doi:10.1007/BF01206146 — **V**
30. T. Hara, *A rigorous control of logarithmic corrections in four-dimensional φ⁴ spin systems I*, J. Stat. Phys. 47 (1987) 57–98, doi:10.1007/BF01009035; T. Hara, H. Tasaki, *… II*, 47 (1987) 99–121, doi:10.1007/BF01009036 — **V**
31. K. Gawędzki, A. Kupiainen, *Non-trivial continuum limit of a φ⁴₄ model with negative coupling constant*, NPB 257 (1985) 474–504. doi:10.1016/0550-3213(85)90359-1 — **V** (hierarchical propagator confirmed from indexed abstract)
32. K. Gawędzki, A. Kupiainen, *Continuum limit of the hierarchical O(N) non-linear σ-model*, CMP 106 (1986) 533–550. doi:10.1007/BF01463394 — **V**
33. G. 't Hooft, *Rigorous construction of planar diagram field theories in four dimensional Euclidean space*, CMP 88 (1983) 1–25. doi:10.1007/BF01206876 — **V**
34. V. Rivasseau, *Construction and Borel summability of planar 4-dimensional Euclidean field theory*, CMP 95 (1984) 445–486. doi:10.1007/BF01210833 — **V**
35. H. Grosse, R. Wulkenhaar, *Self-dual noncommutative φ⁴-theory in four dimensions is a non-perturbatively solvable and non-trivial QFT*, CMP 329 (2014) 1069–1130, arXiv:1205.0465; M. Disertori, R. Gurau, J. Magnen, V. Rivasseau, *Vanishing of beta function of non commutative Φ⁴₄ theory to all orders*, PLB 649 (2007) 95, arXiv:hep-th/0612251 — **V**
36. D. Brydges, J. Fröhlich, T. Spencer, *The random walk representation of classical spin systems and correlation inequalities*, CMP 83 (1982) 123–150. doi:10.1007/BF01947075 — **V**
37. D. Brydges, H.-T. Yau, *Grad φ perturbations of massless Gaussian fields*, CMP 129 (1990) 351–392. doi:10.1007/BF02096987 — **V**
38. D. Brydges, *A short course on cluster expansions*, in *Phénomènes critiques, systèmes aléatoires, théories de jauge* (Les Houches XLIII, 1984), North-Holland 1986, pp. 129–183 (PDF on the author's UBC page) — **V**
39. D. Brydges, T. Kennedy, *Mayer expansions and the Hamilton–Jacobi equation*, J. Stat. Phys. 48 (1987) 19–49. doi:10.1007/BF01010398 — **V**
40. D. Brydges, G. Guadagni, P. K. Mitter, *Finite range decomposition of Gaussian processes*, J. Stat. Phys. 115 (2004) 415–449. arXiv:math-ph/0303013, doi:10.1023/B:JOSS.0000019818.81237.66 — **V**, PDF *dl08*
41. R. Bauerschmidt, *A simple method for finite range decomposition of quadratic forms and Gaussian fields*, PTRF 157 (2013) 817–845. arXiv:1206.2212 — **V**, PDF *dl08*
42. D. Brydges, P. K. Mitter, *On the convergence to the continuum of finite range lattice covariances*, arXiv:1112.0671; D. Brydges, A. Talarczyk, *Finite range decompositions of positive-definite functions*, JFA 236 (2006) 682–711, doi:10.1016/j.jfa.2006.03.008 — **V** (both; second now Crossref-confirmed)
43. D. Brydges, G. Slade, *A renormalisation group method I–V*, J. Stat. Phys. (2015): arXiv:1403.7244, 1403.7253, 1403.7252 (III, with Bauerschmidt), 1403.7255, 1403.7256 — **V**
44. R. Bauerschmidt, D. Brydges, G. Slade, *Scaling limits and critical behaviour of the 4-dimensional n-component |φ|⁴ spin model*, J. Stat. Phys. 157 (2014) 692–742. arXiv:1403.7424 — **V**
45. R. Bauerschmidt, D. Brydges, G. Slade, *Structural stability of a dynamical system near a non-hyperbolic fixed point*, AHP 16 (2015) 1033–1065. arXiv:1211.2477 — **V**
46. R. Bauerschmidt, D. Brydges, G. Slade, *Introduction to a renormalisation group method*, LNM 2242, Springer 2019. arXiv:1907.05474, doi:10.1007/978-981-32-9593-3 — **V**, PDF *dl08*
47. R. Bauerschmidt, T. Bodineau, B. Dagallier, *Stochastic dynamics and the Polchinski equation: an introduction*, Probab. Surv. 21 (2024) 200–290. arXiv:2307.07619 — **V**, PDF *dl08*
48. J. Polchinski, *Renormalization and effective Lagrangians*, NPB 231 (1984) 269–295. doi:10.1016/0550-3213(84)90287-6 — **V**
49. V. F. Müller, *Perturbative renormalization by flow equations*, RMP 15 (2003) 491, arXiv:hep-th/0208211; C. Kopper, *Renormalization theory based on flow equations*, arXiv:hep-th/0508143 — **V**
50. A. N. Efremov, R. Guida, C. Kopper, *Renormalization of SU(2) Yang–Mills theory with flow equations*, JMP 58 (2017), doi:10.1063/1.5000041, arXiv:1704.06799 — **V**
51. G. Gallavotti, *Renormalization theory and ultraviolet stability for scalar fields via renormalization group methods*, RMP 57 (1985) 471–562. doi:10.1103/RevModPhys.57.471 — **V**
52. A. Giuliani, V. Mastropietro, S. Rychkov, *Gentle introduction to rigorous renormalization group: a worked fermionic example*, JHEP 2021, 026. arXiv:2008.04361 — **V**
53. R. Kotecký, D. Preiss, *Cluster expansion for abstract polymer models*, CMP 103 (1986) 491–498. doi:10.1007/BF01211762 — **V**
54. A. Abdesselam, V. Rivasseau, *Trees, forests and jungles: a botanical garden for cluster expansions*, in LNP 446 (1995) 7–36, doi:10.1007/3-540-59190-7_20; arXiv:hep-th/9409094 — **V**, PDF *dl08*
55. V. Rivasseau, *Constructive matrix theory*, JHEP 0709:008 (2007). arXiv:0706.1224 — **V**
56. J. Magnen, V. Rivasseau, *Constructive φ⁴ field theory without tears*, AHP 9 (2008) 403–424. arXiv:0706.2457 — **V**, PDF *dl08*
57. V. Rivasseau, Z. Wang, *How to resum Feynman graphs*, AHP, doi:10.1007/s00023-013-0299-8. arXiv:1304.5913 — **V**
58. J. Glimm, A. Jaffe, T. Spencer, *The particle structure of the weakly coupled P(φ)₂ model and other applications of high temperature expansions*, in *Constructive Quantum Field Theory*, LNP 25 (1973). doi:10.1007/BFb0113086 — **V**
59. M. Aizenman, *Geometric analysis of φ⁴ fields and Ising models I, II*, CMP 86 (1982) 1–48. doi:10.1007/BF01205659 — **V**
60. J. Fröhlich, *On the triviality of λφ⁴_d theories and the approach to the critical point in d ≥ 4 dimensions*, NPB 200 (1982) 281–296. doi:10.1016/0550-3213(82)90088-8 — **V**
61. M. Aizenman, R. Graham, *On the renormalized coupling constant and the susceptibility in φ⁴₄ field theory and the Ising model in four dimensions*, NPB 225 (1983) 261–288. doi:10.1016/0550-3213(83)90053-6 — **V**
62. M. Aizenman, H. Duminil-Copin, *Marginal triviality of the scaling limits of critical 4D Ising and φ⁴₄ models*, Ann. Math. 194 (2021) 163–235. arXiv:1912.07973, doi:10.4007/annals.2021.194.1.3 — **V**, PDF *dl08*
63. R. Panis, *Triviality of the scaling limits of critical Ising and φ⁴ models with effective dimension at least four*, arXiv:2309.05797 (v2: accepted, Ann. Probab.) — **V**
64. S. Coleman, D. J. Gross, *Price of asymptotic freedom*, PRL 31 (1973) 851–854. doi:10.1103/PhysRevLett.31.851 — **V**
65. D. J. Gross, F. Wilczek, PRL 30 (1973) 1343, doi:10.1103/PhysRevLett.30.1343; H. D. Politzer, PRL 30 (1973) 1346, doi:10.1103/PhysRevLett.30.1346 — **V**
66. J. Fröhlich, B. Simon, T. Spencer, *Infrared bounds, phase transitions and continuous symmetry breaking*, CMP 50 (1976) 79–95, doi:10.1007/BF01608557; J. Fröhlich, R. Israel, E. Lieb, B. Simon, *Phase transitions and reflection positivity I* (1978; Springer reprint doi:10.1007/978-3-662-10018-9_13) — **V**
67. M. Hairer, *A theory of regularity structures*, Invent. Math. 198 (2014) 269–504. arXiv:1303.5113, doi:10.1007/s00222-014-0505-4 — **V**, PDF (pre-existing)
68. M. Gubinelli, P. Imkeller, N. Perkowski, *Paracontrolled distributions and singular PDEs*, arXiv:1210.2684; R. Catellier, K. Chouk, *Paracontrolled distributions and the 3-dimensional stochastic quantization equation*, arXiv:1310.6869 — **V**
69. J.-C. Mourrat, H. Weber, *The dynamic Φ⁴₃ model comes down from infinity*, CMP (2017), arXiv:1601.01234; S. Albeverio, S. Kusuoka, arXiv:1711.07108; A. Moinat, H. Weber, arXiv:1811.05764 — **V**
70. M. Gubinelli, M. Hofmanová, *A PDE construction of the Euclidean Φ⁴₃ quantum field theory*, CMP 384 (2021) 1–75, doi:10.1007/s00220-021-04022-0; arXiv:1810.01700 — **V** (journal data now Crossref-confirmed), PDF *dl08*
71. N. Barashkov, M. Gubinelli, *A variational method for Φ⁴₃*, Duke Math. J. 169 (2020) 3339–3415. arXiv:1805.10814 — **V**
72. M. Hairer, R. Steele, *The Φ⁴₃ measure has sub-Gaussian tails*, J. Stat. Phys. 186 (2022), doi:10.1007/s10955-021-02866-3. arXiv:2102.11685 — **V**
73. A. Chandra, A. Moinat, H. Weber, *A priori bounds for the Φ⁴ equation in the full sub-critical regime*, arXiv:1910.13854 — **V**
74. P. Duch, M. Hairer, J. Yi, W. Zhao, *Ergodicity of infinite volume Φ⁴₃ at high temperature*, arXiv:2508.07776 — **V**, PDF *dl08*
75. P. Duch, M. Gubinelli, P. Rinaldi, *Parabolic stochastic quantisation of the fractional Φ⁴₃ model in the full subcritical regime*, arXiv:2303.18112; P. Duch, W. Dybalski, A. Jahandideh, *Stochastic quantization of two-dimensional P(Φ) QFT*, AHP (2024), arXiv:2311.04137 — **V**
76. P. Duch, *Flow equation approach to singular stochastic PDEs*, PMP 6 (2025) 327–437, arXiv:2109.11380; *Renormalization of singular elliptic stochastic PDEs using flow equation*, PMP 6 (2025) 111–138, doi:10.2140/pmp.2025.6.111, arXiv:2201.05031 — **V**
77. A. Kupiainen, *Renormalization group and stochastic PDEs*, arXiv:1410.3094 — **V**
78. F. C. De Vecchi, L. Fresta, M. Gubinelli, *A stochastic analysis of subcritical Euclidean fermionic field theories*, arXiv:2210.15047 — **V**
79. M. Lüscher, *Trivializing maps, the Wilson flow and the HMC algorithm*, CMP 293 (2010) 899–919. arXiv:0907.5491 — **V**
80. M. Lüscher, *Properties and uses of the Wilson flow in lattice QCD*, JHEP 1008:071 (2010). arXiv:1006.4518 — **V** (full text read), PDF (pre-existing)
81. M. Lüscher, P. Weisz, *Perturbative analysis of the gradient flow in non-abelian gauge theories*, JHEP 1102:051 (2011). arXiv:1101.0963 — **V** (full text read), PDF *dl08*
82. M. Lüscher, *Chiral symmetry and the Yang–Mills gradient flow*, JHEP 04 (2013) 123. arXiv:1302.5246 — **V**
83. K. Hieda, H. Makino, H. Suzuki, *Proof of the renormalizability of the gradient flow*, NPB (2017). arXiv:1604.06200, doi:10.1016/j.nuclphysb.2017.02.017 — **V**
84. H. Suzuki, *Energy–momentum tensor from the Yang–Mills gradient flow*, PTEP 2013 (2013) 083B03, doi:10.1093/ptep/ptt059; Erratum PTEP 2015 079201, doi:10.1093/ptep/ptv094; arXiv:1304.0533 — **V** (corrected: the DOI previously listed, ptv094, is the 2015 erratum, not the article), PDF *dl08*
85. R. Narayanan, H. Neuberger, *Infinite N phase transitions in continuum Wilson loop operators*, JHEP 0603:064 (2006). arXiv:hep-th/0601210 — **V**
86. Z. Fodor, K. Holland, J. Kuti, D. Nógrádi, C. H. Wong, *The Yang–Mills gradient flow in finite volume*, arXiv:1208.1051 — **V**
87. P. Fritzsch, A. Ramos, *The gradient flow coupling in the Schrödinger functional*, JHEP 1310 (2013) 008. arXiv:1301.4388 — **V**
88. M. Lüscher, *Step scaling and the Yang–Mills gradient flow*, JHEP 06 (2014) 105. arXiv:1404.5930 — **V**
89. S. Nagao, H. Suzuki, *Yang–Mills β function in the gradient flow exact renormalization group*, arXiv:2508.16828 — **V**
90. R. Harlander, A. Shindler, *Recent applications of the gradient flow*, arXiv:2609.07940 — **V**
91. L. Gross, *Stability of the Yang–Mills heat equation for finite action*, arXiv:1711.00114 — **V**
92. S. Cao, S. Chatterjee, *The Yang–Mills heat flow with random distributional initial data*, arXiv:2111.10652; *A state space for 3D Euclidean Yang–Mills theories*, CMP 405 (2024), doi:10.1007/s00220-023-04870-y, arXiv:2111.12813 — **V**, PDFs (pre-existing)
93. A. Chandra, I. Chevyrev, M. Hairer, H. Shen, *Langevin dynamic for the 2D Yang–Mills measure*, PIHES 136 (2022), arXiv:2006.04987; *Stochastic quantisation of Yang–Mills–Higgs in 3D*, Invent. Math. 237 (2024) 541–696, arXiv:2201.03487; I. Chevyrev, H. Shen, *Uniqueness of gauge covariant renormalisation of stochastic 3D YMH*, ARMA 250 (2026), arXiv:2503.03060; I. Chevyrev, *Stochastic quantisation of Yang–Mills* (review), JMP 63 (2022), arXiv:2202.13359 — **V**, PDFs (pre-existing)
94. M. Lüscher, *Topology of lattice gauge fields*, CMP 85 (1982) 39–48. doi:10.1007/BF02029132 — **V**
95. A. M. Polyakov, *Gauge fields as rings of glue*, NPB 164 (1980) 171–188. doi:10.1016/0550-3213(80)90507-6 — **V**
96. V. S. Dotsenko, S. N. Vergeles, *Renormalizability of phase factors in non-abelian gauge theory*, NPB 169 (1980) 527–546. doi:10.1016/0550-3213(80)90103-0 — **V**
97. R. A. Brandt, F. Neri, M. Sato, *Renormalization of loop functions for all loops*, PRD 24 (1981) 879–902. doi:10.1103/PhysRevD.24.879 — **V**
98. G. P. Korchemsky, A. V. Radyushkin, *Renormalization of the Wilson loops beyond the leading order*, NPB 283 (1987) 342–364. doi:10.1016/0550-3213(87)90277-X — **V**
99. A. Grozin, J. M. Henn, G. P. Korchemsky, P. Marquard, *The three-loop cusp anomalous dimension in QCD*, PRL 114 (2015) 062006. arXiv:1409.0023 — **V**
100. S. Chatterjee, *Yang–Mills for probabilists*, arXiv:1803.01950 — **V** (full text read), PDF (pre-existing)
101. K. Osterwalder, E. Seiler, *Gauge field theories on a lattice*, Ann. Phys. 110 (1978) 440–471. doi:10.1016/0003-4916(78)90039-8 — **V**
102. M. Lüscher, *Construction of a selfadjoint, strictly positive transfer matrix for Euclidean lattice gauge theories*, CMP 54 (1977) 283–292. doi:10.1007/BF01614090 — **V**
103. M. Lüscher, P. Weisz, *Definition and general properties of the transfer matrix in continuum limit improved lattice gauge theories*, NPB 240 (1984) 349–361. doi:10.1016/0550-3213(84)90270-0 — **V**
104. K. Fredenhagen, *On the existence of the real time evolution in Euclidean lattice gauge theories*, CMP 101 (1985) 579–587. doi:10.1007/BF01210746 — **V**
105. E. Seiler, *Gauge Theories as a Problem of Constructive Quantum Field Theory and Statistical Mechanics*, LNP 159, Springer 1982. doi:10.1007/3-540-11559-5 — **V**
106. J. Fröhlich, K. Osterwalder, E. Seiler, *On virtual representations of symmetric spaces and their analytic continuation*, Ann. Math. 118 (1983) 461–489. doi:10.2307/2006979 — **V**
107. D. Brydges, J. Fröhlich, E. Seiler, *On the construction of quantized gauge fields I*, Ann. Phys. 121 (1979) 227–284, doi:10.1016/0003-4916(79)90098-8; *III*, CMP 79 (1981) 353–399, doi:10.1007/BF01208500 — **V**
108. C. King, *The U(1) Higgs model I*, CMP 102 (1986) 649–677. doi:10.1007/BF01221651 (II. *The infinite volume limit*: CMP 103 (1986) 323–349, doi:10.1007/BF01206942) — **V**
109. L. Gross, *Convergence of U(1)₃ lattice gauge theory to its continuum limit*, CMP 92 (1983) 137–162, doi:10.1007/BF01210842; B. Driver, *Convergence of the U(1)₄ lattice gauge theory to its continuum limit*, CMP 110 (1987) 479–501, doi:10.1007/BF01212424; B. Driver, *YM₂: continuum expectations, lattice convergence, and lassos*, CMP 123 (1989) 575–616, doi:10.1007/BF01218586; L. Gross, C. King, A. Sengupta, Ann. Phys. 194 (1989) 65–112, doi:10.1016/0003-4916(89)90032-8; T. Lévy, *Yang–Mills measure on compact surfaces*, arXiv:math/0101239 — **V**
110. T. Balaban: *Ultraviolet stability of three-dimensional lattice pure gauge field theories*, CMP 102 (1985) 255–275, doi:10.1007/BF01229380; *Renormalization group approach to lattice gauge field theories I*, CMP 109 (1987) 249–301, doi:10.1007/BF01215223; *II. Cluster expansions*, CMP 116 (1988) 1–22, doi:10.1007/BF01239022; *Large field renormalization I, II*, CMP 122 (1989) 175–202 and 355–392, doi:10.1007/BF01257412, 10.1007/BF01238433. Full series list in [100] and note 02. — **V**
111. J. Magnen, V. Rivasseau, R. Sénéor, *Construction of YM₄ with an infrared cutoff*, CMP 155 (1993) 325–383. doi:10.1007/BF02097397 (preprint mp_arc 92-38, abstract read) — **V**
112. P. Federbush, *A phase cell approach to Yang–Mills theory* (series), e.g. CMP 107 (1986) 319–329, doi:10.1007/BF01209397; CMP 114 (1988) 317–343, doi:10.1007/BF01225039 — **V**
113. S. Elitzur, *Impossibility of spontaneously breaking local symmetries*, PRD 12 (1975) 3978. doi:10.1103/PhysRevD.12.3978 — **V**
114. J. Fröhlich, G. Morchio, F. Strocchi, *Higgs phenomenon without symmetry breaking order parameter*, NPB 190 (1981) 553–582, doi:10.1016/0550-3213(81)90448-X; PLB 97 (1980) 249, doi:10.1016/0370-2693(80)90594-8 — **V**
115. F. Strocchi, *Gauge problem in quantum field theory*, Phys. Rev. 162 (1967) 1429, doi:10.1103/PhysRev.162.1429; *II*, Phys. Rev. 166 (1968) 1302; *Local and covariant gauge quantum field theories…*, PRD 17 (1978) 2010, doi:10.1103/PhysRevD.17.2010 — **V**
116. R. Ferrari, L. E. Picasso, F. Strocchi, *Some remarks on local operators in quantum electrodynamics*, CMP 35 (1974) 25–38. doi:10.1007/BF01646452 — **V**
117. F. Strocchi, *An Introduction to Non-Perturbative Foundations of Quantum Field Theory*, OUP 2013, doi:10.1093/acprof:oso/9780199671571.001.0001; F. Strocchi, *Symmetry Breaking*, Lecture Notes in Physics, Springer (1st ed. 2005, chapter DOIs 10.1007/10981788_*; 2nd ed. 2008, doi:10.1007/978-3-540-73593-9) — **V** (book-level DOIs Crossref-confirmed; LNP volume numbers not checked)
118. T. Kugo, I. Ojima, *Local covariant operator formalism of non-abelian gauge theories and quark confinement problem*, PTP Suppl. 66 (1979) 1–130. doi:10.1143/PTPS.66.1 — **V**
119. A. Maas, *Brout–Englert–Higgs physics: from foundations to phenomenology*, PPNP 106 (2019) 132–209. arXiv:1712.04721 — **V**
120. S. Hollands, *Renormalized quantum Yang–Mills fields in curved spacetime*, RMP 20 (2008) 1033–1172. arXiv:0705.3340 — **V**
121. V. N. Gribov, *Quantization of non-Abelian gauge theories*, NPB 139 (1978) 1–19. doi:10.1016/0550-3213(78)90175-X — **V**
122. I. M. Singer, *Some remarks on the Gribov ambiguity*, CMP 60 (1978) 7–12. doi:10.1007/BF01609471 — **V**
123. M. S. Narasimhan, T. R. Ramadas, *Geometry of SU(2) gauge fields*, CMP 67 (1979) 121–136. doi:10.1007/BF01221361 — **V**
124. G. Dell'Antonio, D. Zwanziger, *Every gauge orbit passes inside the Gribov horizon*, CMP 138 (1991) 291–299. doi:10.1007/BF02099494 — **V**
125. D. Zwanziger, *Local and renormalizable action from the Gribov horizon*, NPB 323 (1989) 513–544. doi:10.1016/0550-3213(89)90122-3 — **V**
126. P. van Baal, *Gribov ambiguities and the fundamental domain*, arXiv:hep-th/9711070 — **V**
127. H. Neuberger, *Nonperturbative BRS invariance and the Gribov problem*, PLB 183 (1987) 337–340. doi:10.1016/0370-2693(87)90974-9 — **V**
128. N. Vandersickel, D. Zwanziger, *The Gribov problem and QCD dynamics*, Phys. Rep. (2012). arXiv:1202.1491, doi:10.1016/j.physrep.2012.07.003 — **V** (relevant sections read), PDF *dl08*
129. J. Zinn-Justin, D. Zwanziger, *Ward identities for the stochastic quantization of gauge fields*, NPB 295 (1988) 297–331. doi:10.1016/0550-3213(88)90358-6 — **V**
130. K. Symanzik, *Schrödinger representation and Casimir effect in renormalizable quantum field theory*, NPB 190 (1981) 1–44. doi:10.1016/0550-3213(81)90482-X — **V**
131. M. R. Douglas, S. Hoback, A. Mei, R. Nissim, *Formalization of QFT* (OS/Glimm–Jaffe axioms for the 4D free field in Lean 4), arXiv:2603.15770; Lean packages `OSforGFF` and `pphi2` (reservoir.lean-lang.org/@mrdouglasny), status read 2026-11-05 — **V**, PDF (pre-existing)
132. S. Chatterjee, *A scaling limit of SU(2) lattice Yang–Mills–Higgs theory*, PMP 7 (2026) 339–381. arXiv:2401.10507 — **V**, PDF (pre-existing)
133. S. Farinelli, *Renormalized four dimensional quantum Yang–Mills theory and mass gap*, arXiv:1406.4177 (v17) — **V** (existence); claim **[X]**: not accepted, not assessed
134. A. Ragin, *Could four-dimensional φ⁴ theory exist beyond the usual triviality arguments?*, arXiv:2610.12672 — **V** (existence); content **[C/H]**, not assessed
135. A. Adhikari, S. Cao, *Correlation decay for finite lattice gauge theories at weak coupling*, arXiv:2202.10375 (v3: accepted, Ann. Probab.) — **V** (arXiv API; abstract read). *Added by verifier.*
136. H. Shen, R. Zhu, X. Zhu, *A stochastic analysis approach to lattice Yang–Mills at strong coupling*, CMP 400 (2023) 805–851, doi:10.1007/s00220-022-04609-1; arXiv:2204.12737 — **V** (arXiv API + Crossref; abstract read), PDF (pre-existing). *Added by verifier.*
137. GitHub user `xiyin137` (attributed to Xi Yin in note 10; authorship not independently confirmed), `xiyin137/OSreconstruction`: Lean 4 formalization of the Osterwalder–Schrader reconstruction theorem, https://github.com/xiyin137/OSreconstruction (repo created 2026-02-13, last push 2026-11-03 per the GitHub API; README read 2026-11-05) — **V** (existence); sorry/axiom claims **[R]**, self-reported, not rebuilt. *Added by verifier.*
138. `mrdouglasny/lgt` (Douglas, Rajasekaran per note 10): Lattice gauge theory in Lean 4 (strong-coupling exponential decay for U(n) Wilson LGT via Dobrushin uniqueness), https://github.com/mrdouglasny/lgt (README read 2026-11-05) — **V** (existence); sorry/axiom claims **[R]**, self-reported. *Added by verifier.*

---

## Verification log

*Adversarial verification pass, 2026-11-05. Working assumption: references may be hallucinated and results overstated.*

### A. Reference existence and metadata

- **arXiv IDs.** All 80 distinct IDs cited in the note were batch-queried through the arXiv API, and all 80 resolve. Title and first authors match the note in every case, so no mis-identified arXiv ID was found. This includes the post-2025 items: 2508.07776, 2508.16828, 2603.15770, 2609.07940, 2610.12672, and 2403.18562 v3, which is dated 2026-10-15.
- **DOIs.** All 98 distinct DOIs were resolved individually against Crossref `/works/<DOI>`, and all 98 resolve. Title, authors, journal, volume and pages agree with the note.
- **Other identifiers.** Also confirmed:
  - the Numdam record for [4];
  - the Clay problem PDF [15], downloaded and read in full;
  - Brydges' Les Houches PDF on the UBC server [38];
  - the mp_arc 92-38 abstract for [111].
- **Corrections and upgrades.**
  - [84] Suzuki: the listed DOI `10.1093/ptep/ptv094` is the **2015 erratum**. The article is PTEP 2013, 083B03, `doi:10.1093/ptep/ptt059`. Both are now given.
  - [23] Dimock–Yuan: journal data added (AHP 25 (2024) 5113–5186, `doi:10.1007/s00023-024-01427-0`). One SUNY faculty page lists the same title in RMP 37 (2025); Crossref gives AHP, which is retained.
  - [26] Gawędzki–Kupiainen Les Houches notes: changed from U to V(part). The page range is 185–293, not 294, and the editors are Osterwalder–Stora. This comes from secondary citations only. The NPB 262 (1985) 33–48 paper is now **V** (`doi:10.1016/0550-3213(85)90062-8`).
  - [27] Salmhofer–Wieczerkowski: U → **V** (`doi:10.1023/A:1018661110470`, arXiv:math-ph/9909002).
  - [42] Brydges–Talarczyk: V(part) → **V** (`doi:10.1016/j.jfa.2006.03.008`).
  - [70] Gubinelli–Hofmanová: V(part) → **V** (CMP 384 (2021) 1–75, `doi:10.1007/s00220-021-04022-0`).
  - [108] King II: DOI added (`10.1007/BF01206942`).
  - [117] Strocchi: book-level DOIs added; the second edition of *Symmetry Breaking* is `10.1007/978-3-540-73593-9`.
  - [31]: the hierarchical nature of the model, previously "from memory", is now confirmed.
  - Minor metadata added to [50], [54], [63] (accepted, Ann. Probab.), [72], [76] and [92] (state-space paper: CMP 405 (2024)).
- **Nothing fabricated.** No reference was found to be fabricated, so none was removed.
- **Remaining partial items.** [26]: the Les Houches page range is not publisher-confirmed. [117]: LNP volume numbers not checked.
- **New references added.** [135] Adhikari–Cao, [136] Shen–Zhu–Zhu, [137] `xiyin137/OSreconstruction`, [138] `mrdouglasny/lgt`. Each was verified through the arXiv API, Crossref or the GitHub API.
- **PDF library.**
  - All 12 *dl08* PDFs were checked: math-ph_0303013, 1206.2212, 1907.05474, 2307.07619, hep-th_9409094, 0706.2457, 1912.07973, 1810.01700, 2508.07776, 1101.0963, 1304.0533 and 1202.1491.
  - 19 further pre-existing PDFs cited by this note were also checked.
  - In every file the first-page title matches the ID. No file was deleted.
  - No new PDFs were downloaded into `library/pdfs`. The Clay PDF was read from a scratch copy only.

### B. Key claims checked against sources

1. **ADC marginal triviality [62].** Checked against the arXiv PDF: Theorem 1.2, Theorems 1.3/7.1, the Griffiths–Simon setting, and the bound $g(\beta)\le\log(1/|\beta-\beta_c|)^{-c}$ (Remark 6.8). **Corrected an overstatement.** The phrases "every lattice approximation of the standard type" and "every standard lattice approximation" now say *single-component, nearest-neighbour ferromagnetic*. O(n) with n ≥ 2 at large coupling is not covered.
2. **"Osterwalder–Seiler is the one rigorous mass-gap theorem for 4D non-abelian LGT."** **Corrected.** Shen–Zhu–Zhu [136] (CMP 2023) prove a mass gap at strong coupling with an explicit β-range. Adhikari–Cao [135] prove exponential decay of correlations at **weak** coupling for finite, possibly non-abelian, gauge groups. Both abstracts were read. The corrected claim is that no gap is known for compact *Lie* groups outside a strong-coupling window. The fix is applied in the Summary, §2.5, §4.1 and the table (row 18a).
3. **Balaban [110].** Chatterjee [100] (PDF read) and Jaffe–Witten §6.5 [15] (PDF read) both confirm UV stability in 3D and 4D on a torus, meaning compactness or subsequences, not convergence of correlations. **Corrected two points:**
   - The note's paraphrase of note 02 ("regarded as essentially correct") was itself something note 02's verifier had softened. The text now records the mixed opinion: Bauerschmidt says "basically did it", but also that the papers are incomplete, extraordinarily hard to read, and that nobody can currently tell whether they are correct.
   - The Jaffe–Witten "extend to expectations" sentence refers to the 3D work. The 4D work is their "qualitative breakthrough".
   - Separately, the $e^{-c/g_k^2}$ large-field cost was mis-attributed to [15, §6.5]; it is now attributed to [110] alone.
4. **Lüscher–Weisz [81].** The abstract confirms all-orders finiteness for any matter multiplet once the 4D theory is renormalized [T-pert]. **Lüscher 2010 [80]** (PDF): the one-loop prefactor $128\pi^2t^2$, $k_1=1.0978+0.0075N_f$ and $t^2\langle E\rangle|_{t_0}=0.3$ are all confirmed. **Corrected one tag:** "the transformed functional integral is dominated by smooth fields" goes from [T] to [H], because Lüscher's abstract says the studies only "suggest" smoothness.
5. **Gubinelli–Hofmanová [70] and Duch–Hairer–Yi–Zhao [74].** Both abstracts confirm the note. GH give tightness at any positive coupling, with RP and translation invariance but without rotations or clustering. DHYZ give all OS axioms, including rotations and exponential decay, at small coupling [P]. **Clarified** that rotation invariance at weak coupling was already classical [3, 4].
6. **Duch GN₂ [24].** Checked against the v3 PDF. Theorem 1.1 holds for N ≥ 2 and λ ∈ (0, λ*]. It covers both limits, Euclidean invariance, non-triviality through the truncated 4-point renormalization condition, and stretched-exponential decay (Remark 1.4 says exponential decay is true but not proved there). Duch's remark that no earlier reference proves both limits is also confirmed. **Softened** the paraphrase about the large-field problem to match his wording: it is "generally believed" and "seems intractable" for bosonic theories.
7. **Older constructions.** FMRS 1986 [20] (OS axioms and Borel sum, from the indexed abstract), MRS 1993 [111] (mp_arc abstract, all listed details confirmed) and Gawędzki–Kupiainen 1985 [19] are confirmed. **KMR [21]:** large N, fixed UV cutoff and exponential decay are confirmed via Duch's review. "At least two pure phases" is **unverified** and is flagged in the text.
8. **Clay description [15].** Read in full. Footnote 2 (exclusion of weak existence), §6.1 (correlation inequalities only for scalar bosons or abelian gauge theories), §6.4 (the 2D abelian Higgs model as "the only complete example" of an interacting gauge theory satisfying the axioms), the remark on a uniform finite-volume gap, the Wilson-RP remark and the Balaban paragraph all match the note.
9. **OpenAI claim.** This was cross-checked against note 02 and a live web search on 2026-11-05. The claim covers existence only, with no mass gap. A Lean formalization of pure-YM existence was reportedly finished on 16 Oct 2026 and is held by the Gross-chaired committee. Nothing is public. The text has been made precise and adds no new claim.
10. **Lean status.** **Corrected a factual error.** The Summary and F8 said OS reconstruction is "still missing from Lean". `xiyin137/OSreconstruction` exists (GitHub API: created 2026-02-13, pushed 2026-11-03), and its README claims a sorry-free, project-axiom-free scalar OS → Wightman reconstruction, Comparator-checked. It is not in Mathlib. **Also:** `mrdouglasny/lgt` already self-reports a sorry-free strong-coupling exponential-decay theorem for U(n) Wilson LGT, which bears directly on F4. Both are marked **[R]** (self-reported, not rebuilt). The pphi2 README confirms that it does not formalize reconstruction and still carries project axioms.
11. **Other corrections.**
   - Grosse–Wulkenhaar [35] goes from [T] to [T/C]. Their abstract says one step rests on a numerically verified assumption, and the model is not an OS theory on ℝ⁴.
   - Cao–Chatterjee [92] goes from [P] to "[T, conditional]". The state-space paper is published, and the construction is conditional on GFF-like behaviour.
   - CCHS [93]: the Markov process is defined up to a possible finite-time blow-up.
   - The Summary's "every rigorous construction follows this pattern" is softened to "most", with exceptions named. GN₂ as "the only AF strictly renormalizable construction" and "AF is the only route" are tagged [H].
12. **Spot-checks that passed without change.**
   - BBS book [46] theorem numbers: Thms 1.6.1–1.6.3, Thm 4.2.1, Prop. 5.3.1 ($g_{pt}=g-\beta g^2$), Thms 6.2.1, 8.2.4–8.2.5, and Appendix A "Extension to Euclidean models".
   - BGM [40] and Bauerschmidt [41] FRD abstracts.
   - Chatterjee [100] Problem 5.2, including his remark that the need for the perimeter subtraction is unproved.
   - Panis [63]; Ragin [134] (its abstract itself says the interacting finite-N family is open); Harlander–Shindler [90]; Nagao–Suzuki [89] (the all-orders statement is "argued"); Hieda–Makino–Suzuki [83]; Chatterjee [132].

### C. Residual concerns

- [21] KMR: "two pure phases" remains unverified. The paper is paywalled and its abstract is truncated online.
- [50] Efremov–Guida–Kopper: the abstract does not mention Slavnov–Taylor identities. The note's claim that gauge invariance is restored through STIs at zero IR cutoff is plausible but was not checked against the full text.
- [26]: the Les Houches page range comes only from secondary citations.
- §1.3 and §2.3: the "Loc space is essentially one-dimensional for pure YM" argument and the gauge-covariant FRD lead (§2.4, lead 1) are the author's own heuristics [H]. They are untested and should not be cited as known.
- [137] and [138] are self-reported Lean artefacts. Before the project relies on them, someone must rebuild them and run `#print axioms` and Comparator locally.
- The status of [23]'s journal, AHP versus RMP, conflicts across web listings. Crossref says AHP.
