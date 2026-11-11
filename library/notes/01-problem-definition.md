# 01 — The Precise Problem: Clay "Yang–Mills Existence and Mass Gap"

*Workstream key:* `01-problem-definition` · *Compiled:* 2026-11-05 · *Purpose:* backbone for a Lean 4 / Mathlib formal statement.
*Status labels used throughout:* **[THM]** established theorem · **[CLAIM]** claimed, unverified · **[HEUR]** folklore / heuristic / physics-level · **[FALSE]** known false or disputed · **[CP-n]** a choice point the formalizer must resolve explicitly.

---

## Summary

The official problem (Jaffe–Witten, Clay Mathematics Institute, 2000; read in full from the CMI PDF [1]) asks for a proof that, for **every compact simple gauge group G**, "a non-trivial quantum Yang–Mills theory exists on $\mathbb R^4$" with a **mass gap $\Delta>0$**, where "existence includes establishing axiomatic properties at least as strong as those cited in [45, 35]". Reference [45] in [1] is Streater–Wightman (*PCT, Spin and Statistics, and All That*, 1964) and [35] is the pair Osterwalder–Schrader I (CMP 31, 1973) **and** II (CMP 42, 1975). The text adds three further requirements that are not part of any standard axiom system and are stated only informally: (a) the local fields must correspond to the gauge-invariant local polynomials in the curvature $F$ and its covariant derivatives (e.g. $\operatorname{Tr}F_{ij}F_{kl}(x)$); (b) correlation functions must agree at short distances with asymptotic freedom (AF) and renormalized perturbation theory "as described in textbooks", including the existence of a stress tensor and an operator product expansion (OPE); (c) the mass gap is defined spectrally: $H$ has no spectrum in $(0,\Delta)$, the supremum $m$ of such $\Delta$ must be finite. A footnote explicitly excludes "weak existence" via compactness unless the limit's properties (axioms, gap) are also proved.

Michael Douglas's 2004 Clay status report [2] (read in full) restates the problem slightly differently (it omits "non-trivial"), identifies "existence" with establishing the Osterwalder–Schrader (OS) axioms for the continuum limit of correlation functions, identifies the "mass gap" with the fall-off of correlations, states the lattice is not essential, and records that the state of the art was Balaban and Magnen–Rivasseau–Sénéor. As of 2026-11-05 the problem is listed as unsolved by CMI [68]. OpenAI announced (26 Oct 2026) an AI-generated proof of **existence only** (including coupling to fermions), with a Lean formalization that OpenAI reportedly says was completed on 16 Oct 2026 (secondary sources [8]; the committee statement itself says only that OpenAI "is providing" a formalization, and records 16 Oct as the date Gross was asked to take custody of the proof). The proofs (1,147 pages) and the Lean statement are held by a shepherding committee (Gross (chair), Douglas, Jaffe, Klebanov, Nekrasov) whose **first stated objective is to check that the definitions and problem statement match standard ones** [4]. This is exactly the question this note addresses. **[CLAIM]** throughout: nothing has been released or independently checked. OpenAI does not claim the mass gap, and the committee states that confinement and the mass gap remain open [4]; the arXiv papers claiming a gap [59–61] have not been accepted by CMI or the community.

This note writes out, in precise form: the Wightman (Gårding–Wightman) axioms and Wightman-function axioms with the reconstruction theorem; the OS axioms E0–E4 (1973), the error in OS I (Lemma 8.8, with OS II's explicit counterexample), OS II's linear growth condition E0′ and the corrected reconstruction theorem; the Glimm–Jaffe measure axioms OS0–OS4 (and why OS1 **fails** for dimension-4 composite fields like $\operatorname{Tr}F^2$ in 4D); Haag–Kastler nets; Seiler / Fröhlich–Osterwalder–Seiler Wilson-loop formulations; Chatterjee's probabilistic problems; and Lee's gauge-theory axioms. It gives an exact operator-theoretic and an exact Euclidean characterization of the mass gap (with proof sketch), identifies the minimal faithful field content implied by Jaffe–Witten's footnote (identity plus the **21 components of $\operatorname{Tr}F_{\mu\nu}F_{\rho\sigma}$**, decomposing under $SO(4)$ as $(0,0)^{\oplus2}\oplus(1,1)\oplus(2,0)\oplus(0,2)$), and enumerates 26 choice points [CP-1]–[CP-26]. The central recommendation for Lean is to state the problem in **Euclidean OS form with E0′**, a **Euclidean mass-gap predicate**, and a **short-distance AF "fingerprint"**, and to prove separately (as bridge theorems) the OS reconstruction and the Euclidean-gap ⇔ Hamiltonian-gap equivalence.

---

## 1. Primary sources and what they literally say

### 1.1 Jaffe–Witten, "Quantum Yang–Mills Theory" (official description) [1]

Read in full (14 pp., CMI PDF). Section structure: 1 The Physics of Gauge Theory; 2 Quest for Mathematical Understanding; 3 Quantum Fields; 4 The Problem; 5 Comments; 6 Mathematical Perspective (6.1 Methods, 6.2 Scalar fields, 6.3 Large coupling, 6.4 Yukawa and abelian gauge theory, 6.5 Yang–Mills theory, 6.6 Further remarks); References [1]–[50].

Content relevant to a formal statement (paraphrased; section numbers refer to [1]):

* **Classical data (§1).** $G$ compact; connection $A$; curvature $F=dA+A\wedge A$; Yang–Mills equations $d_AF=0=d_A{*F}$; Lagrangian $L=\frac{1}{4g^2}\int \operatorname{Tr}F\wedge *F$ where Tr is an invariant quadratic form on $\mathfrak g$. **No θ-term appears.**
* **Physics targets (§1).** For QCD three properties: mass gap, quark confinement, chiral symmetry breaking. Only the first is part of the problem; the others are listed as "natural extensions" (§5).
* *(Citation numbers prefixed "JW" in this subsection are Jaffe–Witten's own reference numbers, not this note's: JW[45] = Streater–Wightman (our [10]); JW[35] = OS I+II (our [12, 13]); JW[24] = Haag, *Local Quantum Physics* (our [18]); JW[13] = Fröhlich–Osterwalder–Seiler (our [40]); JW[33] = Nelson, Proc. Symp. Pure Math. XXIII (not our [24]); JW[36] = Osterwalder–Seiler 1978 (our [25]).)*
* **Quantum fields (§3).** A quantum field is an operator-valued generalized function obeying axioms; Gårding–Wightman axioms for $\mathbb R^4$ with Minkowski signature are cited as JW[45]; Haag and Kastler's "related scheme" is cited via JW[24], which is Haag's book. Requirements listed: Hilbert space $\mathcal H$ carrying a unitary representation of the Poincaré group; $H$ and $\vec P$ generators; positive energy $0\le H$; Poincaré-invariant vacuum $\Omega$ **unique up to phase**; gauge-invariant functions of the fields act on $\mathcal H$ and transform covariantly; spacelike-separated fields commute. Euclidean history: Wightman's analytic continuation, Symanzik, Nelson's Markov fields (JW[33]), OS reflection positivity JW[35], see also Fröhlich–Osterwalder–Seiler JW[13]. The end of §3 says one hopes future axiom sets will include OPE and a local stress tensor — i.e. JW regard these as **not** part of the existing axiom sets.
* **The Problem (§4).** One should define a QFT "in the above sense" whose local quantum field operators are in correspondence with gauge-invariant local polynomials in $F$ and its covariant derivatives, e.g. $\operatorname{Tr}F_{ij}F_{kl}(x)$. **Footnote 1**: there is no natural 1–1 correspondence (renormalization subtleties); one expects classical differential polynomials of dimension $\le d$ to correspond to local quantum operators of dimension $\le d$. Correlation functions should agree at short distances with AF and perturbative renormalization theory as in textbooks, including existence of a stress tensor and an OPE with prescribed local singularities. Mass gap: $H\Omega=0$; spectrum of $H$ in $[0,\infty)$; a mass gap $\Delta$ means no spectrum of $H$ in $(0,\Delta)$; the supremum of such $\Delta$ is the mass $m$, and "we require $m<\infty$".
* **Official statement (§4, italicized).** For any compact simple $G$, prove that "a non-trivial quantum Yang–Mills theory exists on $\mathbb R^4$" with mass gap $\Delta>0$; existence includes axiomatic properties "at least as strong as those cited in [45, 35]" (JW numbering: Streater–Wightman; OS I and II).
* **Comments (§5).** Mass gap ⇒ clustering: for $C<\Delta$ and local $\mathcal O(\vec x)=e^{-i\vec P\cdot\vec x}\mathcal O e^{i\vec P\cdot\vec x}$ with $\langle\Omega,\mathcal O\Omega\rangle=0$, $|\langle\Omega,\mathcal O(\vec x)\mathcal O(\vec y)\Omega\rangle|\le e^{-C|\vec x-\vec y|}$ for large $|\vec x-\vec y|$. A uniform gap for finite-volume approximations "may play a fundamental role" in the infinite-volume limit. Extensions (not required): isolated one-particle state (upper gap), confinement, other AF gauge theories with matter, arbitrary 4-manifolds.
* **§6.5.** Reflection positivity holds for Wilson's lattice action (JW[36] = Osterwalder–Seiler 1978, our [25]); regularizations that break RP are problematic; **"Establishing a quantum mechanical Hilbert space is part of the solution."** New ideas are needed for a gap uniform in volume, which would presumably enable $\mathbb T^4\to\mathbb R^4$.
* **Footnote 2 (§6.5).** Weak existence (compactness) is specifically excluded as a solution of the existence part unless other techniques establish properties of the limit (mass gap, axioms).

### 1.2 Douglas, "Report on the Status of the Yang–Mills Millenium Prize Problem" (April 2004) [2]

Read in full (4 pp., nLab-hosted copy; PDF metadata shows creation March 2005). Key points:

* Restates the problem without the word "non-trivial".
* Defines lattice YM concretely: graph Γ (e.g. $\mathbb Z^4\subset\mathbb R^4$), $G$-valued link variables, plaquette curvature (minus the trace of the holonomy minus identity), action = sum of squared curvatures, partition function $Z[\gamma,g^2,G]=\int\prod dU_i\,e^{-S}$ with Haar measure.
* Existence = whether the limit over larger subgraphs can be defined (with renormalization); in the limit $g^2\to0$, large γ, the lattice choice should not matter, and expectation values should converge to continuum correlation functions with Euclidean invariance and the other properties formalized in the **OS axioms**, which provide sufficient conditions for constructing a Hilbert space and operator interpretation. "Establishing these axioms is the 'existence' part"; the gap concerns fall-off of correlations.
* Starting from lattice YM is "not essential"; the theory might even be defined without taking limits.
* No breakthroughs reported; state of the art: Balaban and Magnen–Rivasseau–Sénéor. Related progress: 2D sigma models (Kopper's regulated O(N) gap), SUSY gauge theory (Seiberg–Witten, Nekrasov), integrability of N=4 SYM. Heuristic: solving a sufficiently general class of SUSY theories with soft breaking would imply the original problem **[HEUR]**.

### 1.3 The 2026 context (relevant to "is the statement right?")

* **Douglas, Nat. Rev. Phys. 8, 86–97 (2026)** [3] — "The Yang–Mills Millennium problem" (DOI verified via Crossref; paywalled; not read). A secondary source says it suggests a tensor-renormalization-group route may suffice **[unverified content]**.
* **Shepherding committee statement (Oct 2026)** [4] — read in full (2 pp.). Members: Douglas, Gross (chair), Jaffe, Klebanov, Nekrasov. Says: OpenAI proved existence of quantum YM "including coupling to fermions"; the work builds on Wilson's lattice and on Balaban's RG, which "enabled OpenAI to follow the theory all the way to infinite distances" and prove a proper continuum limit; **confinement and the mass gap remain open**; OpenAI is providing a Lean formalization; the committee's **first objective** is to check that definitions and the problem statement correspond to standard ones and that the formalization aligns with the informal treatment; they will then release the Lean proof, later the 1,147-page LLM proofs with an assessment. It also says that Gross was asked by OpenAI on 16 Oct to assume custody of the proof, that the committee wants to be convinced of correctness before release, and that it has "no responsibility to OpenAI". Status: **[CLAIM]**, unpublished as of 2026-11-05.
* **OpenAI announcement (26 Oct 2026)** [5] — direct fetch returned HTTP 403; content known only from secondary sources [7, 8, 66]. The dates come from [8] alone: natural-language YM existence proof 9 Sep, QCD 18 Sep, Lean formalization finished 16 Oct. [8] also says there is no scope document for the YM formalization (unlike OpenAI's ETH result, announced in the same post), and that OpenAI has said it will not seek the Millennium Prize. [7] confirms the claim is existence-only, with the mass gap open, but gives none of these dates. AGMAI [6] mentions a "completion of the Standard Model" alongside YM and QCD. **[CLAIM]**; primary page not read (HTTP 403 on 2026-11-05, both for the author and for this verifier).
* **AGMAI** [6] (Charles, De Lellis, Gowers, Hairer, Srivastava, Tillmann, Vakil, **Witten**, Wood) on 26 Oct 2026 called for immediate release of the natural-language and Lean outputs. Note Witten co-authored the Clay statement.
* **Sussman–Alpöge repository** [52] (public; per [7] Alpöge is an Anthropic employee): Claude-generated manuscripts, condensed with Codex, claiming OS axioms for $F_{\mu\nu}$ in QED$_3$ (242 pp.), for $\operatorname{tr}F^2$ in YM$_3$ (YM3_I, 857 pp.) and for $\operatorname{tr}F_{jk}F_{\ell m}$ plus extensions (YM3_II, 1,201 pp.). The YM$_4$ manuscript is unfinished. The README nevertheless says the authors "appear to have" a YM$_4$ existence argument on $\mathbb R^4$, in about 61k pages of unvetted raw LLM output (about 20k pages "closed"), which they call not understandable as is. **[CLAIM]**, explicitly tentative and not vetted (README disclaimer, checked 2026-11-05). Important for us because it targets **exactly** the field content discussed in §2.8 below.
* **Candidate Lean statements.** (i) `lean-dojo/LeanMillenniumPrizeProblems` [53] marks its own YM statement **"Statement incomplete, not a valid target"**: Poincaré group arbitrary and unrelated to the Hamiltonian, connection and curvature stored independently, Lie algebra without bracket, unbounded Hamiltonian tied to a bounded operator, satisfiable by a 2-dimensional toy model; an earlier vacuum-uniqueness axiom made the structure uninhabited (fixed Sept 2026). (ii) `AIdevsmartdata/yang-mills-lean-statement` v1.1 (2026-10-25) [54]: three variants (lattice-route A, OS-kernel + "YM fingerprint" B, and A+B); fields = the 21 components of $\operatorname{Tr}F_{\mu\nu}F_{\rho\sigma}$; gap = exponential decay of truncated correlations; OS reconstruction passed as a hypothesis; AF constants (e.g. $b_1/b_0^2=102/121$) checked by SymPy, not Lean; "guards" against trivial/free/conformal/decoupled models. Unreviewed by experts; the README says the code and texts were written by Claude agents under the author's direction. Its own Limitation 3 says that in variant B the gap covers only the sector generated by the 21 components (C-even), and there is no OPE. That is exactly the "one-channel" weakness flagged in §2.9. Limitation 4 says B identifies $G$ only up to $\dim G$, for example Spin(7) vs Sp(6). §3.4 draws lessons from both: lean-dojo's statement is a cautionary example, and [54] is an earlier candidate whose main design elements our statement shares.

---

## 2. Key definitions and statements (precise)

### 2.1 Conventions

* Minkowski space $M=\mathbb R^4$, metric $\eta=\mathrm{diag}(+1,-1,-1,-1)$, $x\cdot y=x^0y^0-\vec x\cdot\vec y$. Forward cone $V_+=\{p:p^0>|\vec p|\}$, closure $\bar V_+$. Restricted Poincaré group $\mathcal P_+^\uparrow=\mathbb R^4\rtimes L_+^\uparrow$; for pure YM all gauge-invariant local fields are integer-spin tensors, so $L_+^\uparrow$ (not $SL(2,\mathbb C)$) suffices **[CP-14]**. (KQR [23] use the opposite signature; conventions must be fixed once.)
* Euclidean space $\mathbb R^4\ni x=(x^0,\vec x)$, $x^0=\tau$ Euclidean time; time reflection $\theta(x^0,\vec x)=(-x^0,\vec x)$; $\mathbb R^4_+=\{x^0>0\}$.
* $\mathcal S(\mathbb R^{k})$ Schwartz space with norms $|f|_p=\sup_{x,\,|\alpha|\le p}(1+|x|^2)^{p/2}|D^\alpha f(x)|$; $\mathcal S'$ tempered distributions.
* ${}^0\mathcal S(\mathbb R^{4n})=\{f\in\mathcal S(\mathbb R^{4n}):\ f$ and all derivatives vanish wherever $x_i=x_j$ for some $i\neq j\}$ (OS; confirmed in [23, §2.2, §9.2.2]).
* ${}^+\mathcal S(\mathbb R^{4n})=\{f\in\mathcal S(\mathbb R^{4n}):\ \operatorname{supp}f\subset\{0<x_1^0<x_2^0<\dots<x_n^0\}\}$.
* $(\Theta f)(x_1,\dots,x_n)=f(\theta x_1,\dots,\theta x_n)$; $f^*(x_1,\dots,x_n)=\overline{f(x_n,\dots,x_1)}$ (with conjugation of field labels when fields are not real).
* Wick rotation convention (with $U(a)=e^{iP\cdot a}$, mostly-minus metric): $S_n(x_1,\dots,x_n)=W_n((ix_1^0,\vec x_1),\dots,(ix_n^0,\vec x_n))$ for $x_1^0<\dots<x_n^0$, extended by symmetry. (Derived here from the spectral condition; other books use $-i$ with reversed ordering. **[CP-13]**: fix and prove consistency.)

### 2.2 Wightman (Gårding–Wightman) axioms for a finite family of tensor fields

Data: a separable complex Hilbert space $\mathcal H$; a strongly continuous unitary representation $U$ of $\mathcal P_+^\uparrow$; a unit vector $\Omega$; a dense subspace $D\subset\mathcal H$; a finite index set $J$ of field components with an involution $j\mapsto j^*$, and a finite-dimensional representation $S$ of $L_+^\uparrow$ on $\mathbb C^J$; for each $j\in J$ and $f\in\mathcal S(\mathbb R^4)$ an operator $\varphi_j(f):D\to D$.

* **W0 (relativistic QM, spectrum, vacuum).** $U(a,1)=e^{iP\cdot a}$; the joint spectrum of $(P^0,\vec P)$ lies in $\bar V_+$; $U(a,\Lambda)\Omega=\Omega$; the $U$-invariant vectors are exactly $\mathbb C\Omega$ (uniqueness of vacuum; some authors separate this).
* **W1 (fields as operator-valued tempered distributions).** $\Omega\in D$, $U(a,\Lambda)D\subset D$, $\varphi_j(f)D\subset D$; $f\mapsto\langle\Psi,\varphi_j(f)\Phi\rangle$ is a tempered distribution for $\Psi,\Phi\in D$; $\varphi_j(f)^*\supseteq\varphi_{j^*}(\bar f)$ on $D$.
* **W2 (covariance).** $U(a,\Lambda)\varphi_j(f)U(a,\Lambda)^{-1}=\sum_k S(\Lambda^{-1})_{jk}\varphi_k(f_{(a,\Lambda)})$ on $D$, $f_{(a,\Lambda)}(x)=f(\Lambda^{-1}(x-a))$.
* **W3 (local commutativity).** If $\operatorname{supp}f$ and $\operatorname{supp}g$ are spacelike separated, $[\varphi_j(f),\varphi_k(g)]=0$ on $D$ (bosonic fields; for pure YM no fermions).
* **W4 (cyclicity).** $\mathrm{span}\{\varphi_{j_1}(f_1)\cdots\varphi_{j_n}(f_n)\Omega\}$ is dense in $\mathcal H$.

Sources: Streater–Wightman [10, Ch. 3]; Summers [32, §1] gives the same list for a scalar field and notes uniqueness of vacuum is "posited for convenience" since one can decompose otherwise. **[THM]-level standard definitions.**

### 2.3 Wightman functions and the reconstruction theorem

$W_{j_1\dots j_n}(x_1,\dots,x_n)=\langle\Omega,\varphi_{j_1}(x_1)\cdots\varphi_{j_n}(x_n)\Omega\rangle$ satisfy:

* **R0** $W_n\in\mathcal S'(\mathbb R^{4n})$, $W_0=1$.
* **R1** Poincaré covariance (with the matrices $S$).
* **R2** Spectral condition: writing $W_n(x)=\mathcal W_n(\xi_1,\dots,\xi_{n-1})$, $\xi_k=x_k-x_{k+1}$, and $\mathcal W_n(\xi)=\int e^{-i\sum_k p_k\cdot\xi_k}\,\widehat{\mathcal W}_n(p)\,dp$, one has $\operatorname{supp}\widehat{\mathcal W}_n\subset\bar V_+^{\,n-1}$.
* **R3** Hermiticity $\overline{W_{j_1\dots j_n}(x_1,\dots,x_n)}=W_{j_n^*\dots j_1^*}(x_n,\dots,x_1)$.
* **R4** Local commutativity: $W$ symmetric under exchange of adjacent arguments $x_p,x_{p+1}$ (with labels) on test functions supported where $(x_p-x_{p+1})^2<0$ (mostly-minus).
* **R5** Positivity: $\sum_{n,m}W_{n+m}(f_n^*\otimes f_m)\ge0$ for all terminating sequences $(f_0,f_1,\dots)$, $f_n\in\mathcal S(\mathbb R^{4n})\otimes\mathbb C^{J^n}$.
* **R6** Cluster property: $W_{n+m}(x_1,\dots,x_n,x_{n+1}+\lambda a,\dots,x_{n+m}+\lambda a)\to W_nW_m$ as $\lambda\to\infty$ for spacelike $a$ (distributionally).

**Wightman reconstruction theorem [THM]** (Streater–Wightman Thm 3-7 [10]; restated in [23]): a sequence satisfying R0–R5 determines a Wightman theory (W0–W4 except vacuum uniqueness) with these VEVs, unique up to unitary equivalence; R6 holds iff the vacuum is unique. KQR [23, Remark 2.2] note hermiticity follows from positivity.

### 2.4 Osterwalder–Schrader axioms: OS I (1973), its error, OS II (1975)

Schwinger distributions $S_n$ (labels suppressed; for tensor fields carry indices and $SO(4)$ or $O(4)$ representation matrices as in [23, §2.2]).

* **E0 (distributions).** $S_0=1$; $S_n\in{}^0\mathcal S'(\mathbb R^{4n})$, i.e. continuous on ${}^0\mathcal S$ — **the Schwinger functions are never evaluated at coincident points**. (KQR [23, Remark 2.4]: from E0 plus RP and rotation invariance one deduces real-analyticity off the diagonal and, by OS II, power-law bounds; alternatively one can posit real-analyticity and the bound $|S_n|\le C(1+\max_{i\neq j}(|x_i-x_j|^{-1},|x_i-x_j|))^p$.)
* **E1 (Euclidean covariance).** $S_n(f_{(a,R)})=S_n(f)$, $f_{(a,R)}(x)=f(R^{-1}(x_1-a),\dots,R^{-1}(x_n-a))$, for $(a,R)\in\mathbb R^4\rtimes SO(4)$ (with representation matrices for tensors). **[CP-3]** whether $O(4)$ (including reflections) is imposed.
* **E2 (reflection positivity).** For every terminating sequence $f=(f_0,f_1,\dots)$ with $f_n\in{}^+\mathcal S(\mathbb R^{4n})$: $\ \sum_{n,m}S_{n+m}(\Theta f_n^*\otimes f_m)\ge0$. (Supports guarantee the argument lies in ${}^0\mathcal S$.)
* **E3 (symmetry).** $S_n(f^\pi)=S_n(f)$ for all permutations $\pi$ (bosonic).
* **E4 (cluster).** For spatial $a=(0,\vec a)$: $\lim_{\lambda\to\infty}\sum_{n,m}\big[S_{n+m}(\Theta f_n^*\otimes (f_m)_{(\lambda a)})-S_n(\Theta f_n^*)S_m(f_m)\big]=0$. (OS I also mention a stronger E4′.)

**OS I claimed** E0–E4 ⇔ Wightman R0–R6. **[FALSE]** as proved: OS I's Lemma 8.8 asserted that a function holomorphic and separately a Fourier–Laplace transform of a tempered distribution in each variable is jointly such a transform; OS II give the counterexample $S_2(y_1,y_2)=e^{-y_1y_2}$ (whose continuation $e^{x_1x_2}$ is not tempered) [23, §9.2.1]. Glaser (1974) [20] analysed the equivalence question further.

**OS II [13] fixes this in two ways [THM]:**

1. *Equivalence theorem with Ě0*: a stronger continuity of $S_n$ in a topology defined through Fourier–Laplace transforms ("Ě0") plus E1–E3 is **equivalent** to R0–R5. Ě0 is essentially temperedness of the Wightman distributions in disguise and is hard to verify [23, §9.2.1].
2. *Linear growth condition* **E0′**: there exist $s\in\mathbb N$ and constants $\sigma_n$ with $\sigma_n\le\alpha(n!)^\beta$ for some $\alpha,\beta$, such that
$$|S_n(f)|\le\sigma_n\,|f|_{n\cdot s}\qquad\forall n,\ \forall f\in{}^0\mathcal S(\mathbb R^{4n}).$$
(Exactly as reproduced in [23, eq. (9.18)].) The **order** of the Schwartz norm may grow only **linearly** in $n$ and the constants only **factorially**. Theorem: **E0′ + E1 + E2 + E3 ⇒ R0–R5**, with the $S_n$ being the Euclidean restrictions of the analytically continued $W_n$; with E4, also R6. Wightman distributions obtained this way satisfy an additional growth bound. The appendix to OS II (by S. Summers) shows E0′ follows from the product-test-function bound $|S_n(f_1\otimes\cdots\otimes f_n)|\le\sigma_n\prod_i|f_i|_r$ with $S_n\in\mathcal S'(\mathbb R^{4n})$ [23, eq. (9.19)] — the form typically verified in constructive models (e.g. Glimm–Jaffe–Spencer for Wick powers in weakly coupled $P(\phi)_2$).

**Converse direction [THM]:** a Wightman theory yields Schwinger functions satisfying E0–E4 (OS I, correct part), but **E0′ is not known to follow from the Wightman axioms** [23, §9.2.2]. So E0′ is sufficient, not necessary. Zinoviev (1995) [21] gives a different sufficient condition (E5), judged by KQR to be about as hard to verify as Ě0. Whether E0–E4 alone (no growth condition) imply Wightman axioms is **open**. Schlingemann [22, §1] says the analytic-continuation theorem "might be true" for the ordinary $\mathcal S$-topology but has no correct proof. KQR [23] bypass linear growth in a different setting. From their **Euclidean CFT axioms**, which include a convergent OPE and conformal invariance and are therefore much stronger than E0–E4, they derive Wightman properties (temperedness, spectral condition, positivity) for **2-, 3- and 4-point functions only**. This does not settle the general E0–E4 question.

**Important structural fact for YM:** the OS framework requires nothing at coincident points; composite-operator contact terms (which are scheme-dependent) never enter the axioms. The Wightman distributions produced by reconstruction are nonetheless full tempered distributions on $\mathbb R^{4n}$ (boundary values of analytic functions).

### 2.5 OS reconstruction (what one actually obtains)

From E0′, E1–E4 [THM, OS II; review in 23, §9]:
* $\mathcal H$ = completion of terminating sequences in ${}^+\mathcal S$ modulo null vectors of the RP form $\langle F,G\rangle=\sum_{n,m}S_{n+m}(\Theta f_n^*\otimes g_m)$; $\Omega$ = class of $(1,0,0,\dots)$.
* Euclidean time translations $(\tau_tg)(x)=g(x_1-te_0,\dots)$, $t\ge0$, descend to a strongly continuous contraction semigroup $e^{-tH}$ with $H=H^*\ge0$, $H\Omega=0$; spatial translations and rotations in the $\vec x$-space give unitary operators; boosts arise from "virtual representations" (Fröhlich–Osterwalder–Seiler [40], Klein–Landau).
* Fields: the Wightman fields $\varphi_j$ whose VEVs are the continued $S_n$; locality from E3 + analyticity.

### 2.6 Glimm–Jaffe measure axioms OS0–OS4 and their failure for $\operatorname{Tr}F^2$

GJ [11, §6.1] (verified via [34], which formalized them in Lean for the free field): $\mu$ a Borel probability measure on $\mathcal D'(\mathbb R^d)$ (or $\mathcal S'$), $S\{f\}=\int e^{i\phi(f)}d\mu$.
* **OS0** $z\mapsto S\{\sum_j z_jf_j\}$ entire on $\mathbb C^N$.
* **OS1** $\exists p\in[1,2],c>0$: $|S\{f\}|\le\exp\big(c(\|f\|_{L^1}+\|f\|_{L^p}^p)\big)$ (for complex $f$); if $p=2$, the two-point Schwinger function must be locally integrable.
* **OS2** invariance under the Euclidean group **including reflections**.
* **OS3** $\langle\Theta A,A\rangle_{L^2(\mu)}\ge0$ for $A=\sum_k c_ke^{\phi(f_k)}$, $\operatorname{supp}f_k\subset\mathbb R^d_+$.
* **OS4** ergodicity of time translations.
nLab cites GJ Thm 6.1.5 (p. 98, 1981 ed.) for the statement that a measure satisfying "the axioms" yields Wightman fields whose Schwinger functions are its moments. nLab does **not** separate OS0–OS3 from OS4 and does not mention vacuum uniqueness. The common reading, that OS0–OS3 give Wightman fields and OS4 ⇔ unique vacuum, is standard but was **not confirmed against GJ directly** [UNVERIFIED split]. KQR [23, fn. 80–81] note that measure-type axioms reduce the product-test-function bound (9.19) to a growth estimate on $S\{f\}$, making recovery of Wightman axioms "relatively trivial". Note that KQR fn. 81 describes GJ's list as OS0–OS5. Numbering conventions differ across papers (e.g. some use OS0–OS5) — always restate.

**Derived here (rigorous sketch, should be double-checked by the analysis workstream): OS1 is incompatible with a scalar field of short-distance dimension 4 in $d=4$.** Let $\phi=\operatorname{Tr}F^2$ (or the RG-invariant combination) with two-point function behaving like $c|x|^{-8}\log^{-2}(1/|x|)$ near 0 [HEUR, §2.8(c)]. Take real $g\in C_c^\infty$, $g_\varepsilon(x)=g(x/\varepsilon)$. Cauchy's estimate applied to the entire function $z\mapsto S\{-izg_\varepsilon\}$ with radius $r=\varepsilon^{-4/p}$ and OS1 give $S_2(g_\varepsilon\otimes g_\varepsilon)\le 2r^{-2}e^{c(a+b)}=O(\varepsilon^{8/p})$, since $\|g_\varepsilon\|_1,\|g_\varepsilon\|_p^p=O(\varepsilon^4)$. But the spectral (Källén–Lehmann-type) representation gives $S_2(g_\varepsilon\otimes g_\varepsilon)\asymp\log^{-2}(1/\varepsilon)$, which decays far slower than $\varepsilon^{8/p}$ ($8/p\ge4$). Contradiction. (Already the free-field Wick square $:\phi^2:$ in $d=4$, dimension 2, has a non-integrable $|x|^{-4}$ two-point function.) *Verifier's check (2026-11-05):* the Cauchy-estimate and scaling steps are correct. The contradiction follows from any positive spectral measure with $\hat S_2(p)\gtrsim p^4/\log^2p$ at large $p$; any positive polynomial contact term only makes $S_2(g_\varepsilon\otimes g_\varepsilon)$ larger. The premise is still the **heuristic** AF short-distance law, so the conclusion is a derived claim, not a theorem. A separate sanity check: the 4D GFF gives $O(\varepsilon^6)\le O(\varepsilon^{4})$ and is consistent with OS1 at $p=2$, as it must be. **Consequence [CP-12]:** the GJ measure formulation, the one formalized in Lean so far [34, 35], cannot be used verbatim for the YM field content; one needs OS E0′ (Schwartz norms, which see derivatives) or a modified OS1 with negative-order Sobolev norms. A measure formulation additionally forces a choice of coincident-point (contact-term) definitions for products like $\phi(f_1)\phi(f_2)$ with overlapping supports — a scheme choice the OS formulation avoids.

### 2.7 Haag–Kastler (algebraic) axioms

A net $\mathcal O\mapsto\mathfrak A(\mathcal O)$ of unital C*-algebras indexed by double cones (or bounded open sets) in $M$ [17, 18; also 22, §1]:
* **HK1 Isotony** $\mathcal O_1\subset\mathcal O_2\Rightarrow\mathfrak A(\mathcal O_1)\subset\mathfrak A(\mathcal O_2)$; quasi-local algebra $\mathfrak A=\overline{\bigcup\mathfrak A(\mathcal O)}$.
* **HK2 Locality** $\mathcal O_1$ spacelike to $\mathcal O_2$ ⇒ $[\mathfrak A(\mathcal O_1),\mathfrak A(\mathcal O_2)]=0$.
* **HK3 Covariance** $\alpha:\mathcal P_+^\uparrow\to\operatorname{Aut}\mathfrak A$ with $\alpha_{(a,\Lambda)}\mathfrak A(\mathcal O)=\mathfrak A(\Lambda\mathcal O+a)$.
* **HK4 Vacuum** an $\alpha$-invariant state $\omega$ whose GNS representation carries a positive-energy unitary implementation; usually $\omega$ pure / $\Omega$ unique invariant vector. Optional: weak additivity, time-slice, Haag duality, split property.
Mass gap: spectrum of the translation subgroup $\subset\{0\}\cup\{p^2\ge m^2,p^0>0\}$.

Relations: Wightman fields ⇒ HK net requires extra hypotheses (e.g. spectral projections of smeared fields must commute; Driessler–Summers–Wichmann [31], Borchers–Yngvason) — **open in general**. HK nets ⇒ point-like fields is also non-trivial. Schlingemann [22] gives a C*-algebraic OS reconstruction from *Euclidean nets* $(\mathfrak A_E,\alpha,\eta)$ with an E(d)-covariant, locally commutative (on disjoint regions) isotonous net and an RP functional, producing a Haag–Kastler net **provided time-zero algebras are non-trivial** (condition (TZ)) — a condition that excludes some generalized free fields and is not known for 4D YM. JW mention HK but cite only JW[45, 35] (SW; OS I+II) as the required standard **[CP-17]**.

### 2.8 What makes the theory "Yang–Mills"

**(a) The gauge group [CP-2].** "Compact simple gauge group": compact Lie group with simple (hence non-abelian) Lie algebra. Simply connected representatives: $SU(N)$ ($N\ge2$), $Spin(N)$ ($N=3$ or $N\ge5$; $Spin(4)$ is not simple; low-rank coincidences $Spin(3)\cong SU(2)$, $Spin(5)\cong Sp(2)$, $Spin(6)\cong SU(4)$), $Sp(N)$ ($N\ge1$), exceptional $G_2,F_4,E_6,E_7,E_8$, and their quotients by central subgroups. Correlators of **local** gauge-invariant operators on $\mathbb R^4$ are believed to depend only on $\mathfrak g$ (and θ); the global form affects line operators and θ-periodicity (Aharony–Seiberg–Tachikawa [41]) **[HEUR]**. A formalizer may quantify over compact connected Lie groups with simple Lie algebra, or directly over compact simple Lie algebras.

**(b) Field content [CP-5].** JW require local fields in correspondence with gauge-invariant local polynomials in $F$ and $D_AF$. **Observation (derived here, elementary):** for simple $\mathfrak g$ the invariant symmetric bilinear forms are one-dimensional (multiples of the Killing form) and $\operatorname{Tr}F=0$, so the classical gauge-invariant local polynomials of mass dimension $\le4$ are exactly the span of $1$ and the **21 components** $\operatorname{Tr}F_{\mu\nu}F_{\rho\sigma}$ (no dimension 1–3 invariants exist). Since $\operatorname{Tr}F_{\mu\nu}F_{\rho\sigma}$ is symmetric under $(\mu\nu)\leftrightarrow(\rho\sigma)$, it lies in $\mathrm{Sym}^2(\Lambda^2\mathbb R^4)$; with $\Lambda^2=(1,0)\oplus(0,1)$ (self-dual/anti-self-dual) under $SO(4)\cong(SU(2)\times SU(2))/\mathbb Z_2$:
$$\mathrm{Sym}^2(\Lambda^2)=\underbrace{(2,0)\oplus(0,2)}_{5+5}\ \oplus\ \underbrace{(0,0)\oplus(0,0)}_{1+1}\ \oplus\ \underbrace{(1,1)}_{9}\quad(=21).$$
The two scalars are $\operatorname{Tr}F_\pm^2$, i.e. combinations of the action density $\operatorname{Tr}F\wedge*F$ and the **pseudoscalar topological density** $\operatorname{Tr}F\wedge F$; $(1,1)$ is the traceless symmetric tensor (classically the stress tensor); $(2,0)\oplus(0,2)$ are "Weyl-like" tensors. Improper $O(4)$ elements swap $(a,b)\leftrightarrow(b,a)$. By JW footnote 1, the **minimal faithful reading at dimension ≤4** is: the quantum theory possesses a 22-dimensional space of local fields of dimension ≤4 (identity + these 21), transforming as above, with quantum mixing only into lower dimension (here: $\operatorname{Tr}F^2$ may mix with $\Lambda^4\cdot1$, i.e. vacuum subtraction). The **strong reading** is the full infinite graded family (dimension 6 includes $f^{abc}FFF$, and for groups with a cubic Casimir $d^{abc}FFF$; plus derivatives), with a filtration-preserving correspondence.

**(c) Short-distance behaviour / asymptotic freedom [CP-7].** JW: agreement with AF and perturbative renormalization "as described in textbooks", including a stress tensor and an OPE with prescribed singularities. Standard physics **[HEUR, well established in perturbation theory]**: $\beta(g)=-b_0g^3-b_1g^5+\dots$, $b_0=\frac{11}{3}\frac{C_A}{16\pi^2}$, $b_1=\frac{34}{3}\frac{C_A^2}{(16\pi^2)^2}$ (pure YM, $C_A$ = adjoint Casimir), so $b_1/b_0^2=102/121$ for every $G$; running coupling $g^{-2}(\mu)=b_0\log(\mu^2/\Lambda^2)+(b_1/b_0)\log\log(\mu^2/\Lambda^2)+o(1)$; trace anomaly $T^\mu{}_\mu\propto(\beta(g)/g)\operatorname{Tr}F^2$ (Gross–Wilczek, Politzer [62]). **Heuristic consequence (derived here; needs checking by the perturbative workstream):** with the geometric normalization ($F=dA+A\wedge A$, action $\frac1{4g^2}\int\operatorname{Tr}F\wedge*F$) one has $F=gF_{\rm can}$, and $\operatorname{Tr}F^2$ is RG-invariant at leading order, so its connected two-point function should behave as
$$\langle\operatorname{Tr}F^2(x)\,\operatorname{Tr}F^2(0)\rangle_T\ \sim\ \frac{c\,\dim G}{|x|^8\,\big(b_0\log\frac{1}{x^2\Lambda^2}\big)^2}\qquad(x\to0),$$
with $c$ a free-field Wick constant depending on the normalization of Tr. Formalization options: (i) a "fingerprint" of leading asymptotics of 2- and 3-point functions of the 21 components; (ii) all-$n$ leading-log asymptotics; (iii) existence of an OPE with AF coefficient functions and a conserved symmetric stress tensor with correct Ward identities and trace anomaly. Note the internal tension in [1]: §3 says OPE and stress tensor are *not* in existing axiom sets, while §4 lists them among predictions to be matched **[CP-18]**. Formalizing "textbook predictions" fully would require formalizing renormalized perturbative YM (BRST, BPHZ) — very large.

**(d) Non-triviality [CP-8].** Not defined in [1]. Candidate definitions, in increasing strength: (1) $\mathcal H\neq\mathbb C\Omega$ — already implied by JW's "$m<\infty$"; (2) some truncated $n\ge3$ Schwinger function of a field is non-zero — **insufficient**, since composite fields of free theories are non-Gaussian; (3) not unitarily equivalent to a theory of Wick polynomials of free (or generalized free) fields; (4) the AF log corrections of (c) — these cannot be produced by composites of free massive (e.g. Proca) fields, whose correlators are pure powers at short distance; (5) non-trivial scattering (Haag–Ruelle; requires isolated one-particle states, not required by JW). **Observation:** with the gap present, a generalized free field for $\operatorname{Tr}F^2$ could mimic any positive two-point function, including the AF one; so a fingerprint must involve at least the **3-point function or OPE**, or the joint structure of several components (e.g. the stress tensor Ward identity), to exclude generalized-free models. Recommend (4)+3-point structure.

### 2.9 The mass gap: exact formulations and equivalences

**Definition (JW, operator form).** $\sigma(H)\cap(0,\Delta)=\emptyset$ for some $\Delta>0$; with uniqueness of the vacuum (W0), $H\ge\Delta$ on $\Omega^\perp$. Mass $m:=\sup\{\Delta\}$, required $m<\infty$.

**Proposition A [THM, elementary].** In a Wightman theory with unique vacuum, TFAE for $\Delta>0$: (i) $\sigma(H)\subset\{0\}\cup[\Delta,\infty)$ and $\ker H=\mathbb C\Omega$; (ii) the joint spectrum $\sigma(P)\subset\{0\}\cup\{p:p^2\ge\Delta^2,\ p^0>0\}$ with $\{0\}$ of multiplicity one; (iii) the mass operator $M=(P^\mu P_\mu)^{1/2}$ restricted to $\Omega^\perp$ has spectrum in $[\Delta,\infty)$. *Proof sketch:* $\sigma(P)$ is $L_+^\uparrow$-invariant. (ii)⇒(i): $p^0\ge\sqrt{\Delta^2+|\vec p|^2}\ge\Delta$. (i)⇒(ii): if $p\in\sigma(P)$ with $0<p^2<\Delta^2$, boosting to $(\sqrt{p^2},\vec0)$ puts $\sqrt{p^2}\in\sigma(H)\cap(0,\Delta)$; if $p\neq0$ with $p^2=0$, boosts give points with arbitrarily small $p^0>0$. ∎

**Proposition B (Euclidean characterization) [THM, elementary given OS reconstruction].** In the OS-reconstructed theory, for $F=(f_n)$, $f_n\in{}^+\mathcal S$, $\langle\Psi_F,e^{-tH}\Psi_F\rangle=\sum_{n,m}S_{n+m}(\Theta f_n^*\otimes\tau_tf_m)$ and $\langle\Omega,\Psi_F\rangle=\sum_mS_m(f_m)$. For $m_0>0$ TFAE:
1. $H\ge m_0$ on $\Omega^\perp$ (gap $\ge m_0$ and unique vacuum);
2. for all $F$: $\ \Gamma_F(t):=\langle\Psi_F,e^{-tH}\Psi_F\rangle-|\langle\Omega,\Psi_F\rangle|^2\le\|\Psi_F\|^2e^{-m_0t}$ for all $t\ge0$;
3. for all $F$ in some set whose vectors $\Psi_F$ are **total** in $\mathcal H$, there is $C_F<\infty$ with $\Gamma_F(t)\le C_Fe^{-m_0t}$ for all $t\ge0$.

*Proof sketch:* $\Gamma_F(t)=\int e^{-t\lambda}d\mu_\psi(\lambda)$, $\psi=\Psi_F-\langle\Omega,\Psi_F\rangle\Omega$. If $\mu_\psi([0,m_0-\epsilon])=\delta>0$ then $\Gamma_F(t)\ge\delta e^{-(m_0-\epsilon)t}$, contradicting 3 for large $t$; hence $E_H([0,m_0))\psi=0$. This is linear in ψ, so it extends to the span and closure, i.e. to $\Omega^\perp$. ∎ **Key subtlety:** constants may depend on $F$, but $F$ must range over a total set of vectors in the **whole** reconstructed $\mathcal H$ — multi-point products, not just single fields. Exponential decay of a single two-point function $\langle\mathcal O(x)\mathcal O(0)\rangle_T$ only bounds the spectrum in the cyclic subspace of $\mathcal O$ ("one channel"). Chatterjee's Problem 5.1 (plaquette–plaquette decay) [28] and the AIdevsmartdata `HasMassGap` predicate [54] should be checked against this. *(Verified 2026-11-05: [54]'s README, Limitation 3, concedes that in its variant B the gap covers only the sector generated by the 21 components; Problem 5.1 in [28] concerns a single plaquette–plaquette correlation.)*

**Proposition C (spatial clustering) [THM].** Gap ⇒ exponential clustering in spacelike directions with rate up to $m$ (Araki–Hepp–Ruelle 1962 [29]; Fredenhagen's local-algebra cluster theorem 1985 [30]). JW's eq. (2) uses *sharp-time* local operators $\mathcal O(\vec x)$, which may not exist in an interacting 4D theory; read it with time-smeared or bounded local operators **[CP-11]**.

**Finite volume.** On $\mathbb T^3\times\mathbb R$ the gauge theory has additional superselection structure ('t Hooft electric flux sectors, center symmetry) **[HEUR]**; JW only suggest a uniform finite-volume gap as a tool.

---

## 3. Detailed findings

### 3.1 Clause-by-clause reading of the official statement

| Clause in [1] | Precise mathematical content | Status of meaning |
|---|---|---|
| "for any compact simple gauge group G" | ∀ compact Lie group with simple Lie algebra | clear up to global form [CP-2] |
| "a … quantum Yang–Mills theory" | QFT with local fields ↔ gauge-invariant polynomials in $F$, $D_AF$ (§4 + fn. 1) | dimension-filtered correspondence; minimal = 21 components [CP-5] |
| "non-trivial" | undefined | [CP-8] |
| "exists on $\mathbb R^4$" | infinite volume; Minkowski via Wightman or Euclidean via OS | [CP-1], [CP-12] |
| "axiomatic properties at least as strong as [45, 35]" (JW numbering) | Wightman (SW) and OS I+II | does OS I's E0–E4 suffice? Only E0′ (OS II) yields Wightman [CP-1] |
| short-distance AF, stress tensor, OPE (§4 prose) | asymptotic agreement with RG-improved perturbation theory | informal; stress tensor/OPE status ambiguous [CP-7], [CP-18] |
| "mass gap Δ>0" | $\sigma(H)\cap(0,\Delta)=\emptyset$ | clear; uniqueness of vacuum from W0 [CP-9], [CP-10] |
| "we require m<∞" | $H\neq0$ on $\Omega^\perp$, i.e. $\mathcal H\ne\mathbb C\Omega$ | clear |
| footnote 2 (no weak existence) | must prove properties of the limit | clear; uniqueness of limit not required [CP-12] |
| θ, coupling | not mentioned; Lagrangian has no θ-term | θ=0 natural; no coupling parameter after dimensional transmutation [CP-3], [CP-4] |

### 3.2 Choice points for the formalizer

* **[CP-1] Which axiom system certifies "existence"?** Options: (a) Wightman W0–W4 directly; (b) OS E0′+E1–E4 (implies (a) by OS II); (c) OS E0–E4 only (literal reading of "[35]" could be argued, but not known to imply Wightman — **do not use**); (d) Ě0 + E1–E4 (equivalent to (a), hard to verify). Recommendation: state (b) in Lean, prove (b)⇒(a) separately.
* **[CP-2] Gauge group class** (connected? simply connected? Lie algebra only?). Recommendation: compact connected Lie group with simple Lie algebra; provide a faithful unitary representation only inside construction proofs, not in the statement.
* **[CP-3] θ-angle and $SO(4)$ vs $O(4)$.** At θ=0 parity/time reversal hold and full $O(4)$ covariance (with the pseudoscalar $\operatorname{Tr}F\wedge F$ transforming by the determinant) can be imposed; the problem does not state θ.
* **[CP-4] No coupling parameter.** Quantum YM has one scale Λ (dimensional transmutation); state existence of *a* theory; any Λ>0 obtained by rescaling. Do not quantify over $g$.
* **[CP-5] Field content** (minimal 21+1 vs full graded family vs including stress tensor as a separate conserved field).
* **[CP-6] Normalization of composite fields.** Quantum $\operatorname{Tr}F^2$ is defined only up to finite renormalization and mixing with $\Lambda^4\cdot1$; fix normalization via short-distance asymptotics (RG-invariant normalization).
* **[CP-7] Form of the AF requirement** (2-point leading log; 2- and 3-point; all-$n$; OPE).
* **[CP-8] Non-triviality** (see §2.8(d); recommend AF logs + 3-point/OPE structure).
* **[CP-9] Gap formulation and its Hilbert space.** The gap is on the Hilbert space generated by the chosen fields; a smaller field set generates a possibly smaller space, so a gap on it is a weaker statement. Use Prop. B with a total set.
* **[CP-10] Vacuum uniqueness / clustering** (OS E4 vs GJ OS4 ergodicity; include uniqueness).
* **[CP-11] Point-like vs bounded vs extended observables.** JW ask for local fields. Sharp Wilson loops are expected to need renormalization in the 4D continuum **[HEUR]**: perimeter and cusp divergences are standard perturbative lore. Chatterjee's Problem 5.2 [28] builds in a counterterm $c(\beta)(R+T)$, but Chatterjee says explicitly that it is not clear the counterterm is needed. Smeared loops via gradient/heat flow (Lüscher [42]; Cao–Chatterjee [43]; L. Gross [49]) are bounded and gauge-invariant but non-local. On gauge potentials, Summers [32, §3.7] reports Strocchi-type no-go results: under various reasonable assumptions, a Hilbert-space (positive-metric) framework is inconsistent with the potential being covariant, with it satisfying Einstein causality, and with Maxwell's equations holding. These are stated for the electromagnetic case with references to Strocchi's monograph. Gupta–Bleuler (an indefinite metric) is the consistent alternative, which is why Lee [36] uses an indefinite metric.
* **[CP-12] Euclidean framework flavour** (distributional OS on ${}^0\mathcal S$ vs measure on $\mathcal S'$ à la GJ — the latter's OS1 fails for $\operatorname{Tr}F^2$, §2.6).
* **[CP-13] Conventions** (signature, Wick-rotation sign, time ordering in ${}^+\mathcal S$, Fourier conventions).
* **[CP-14] Covering group / spinors** — unnecessary for pure YM; needed if fermions are added (QCD, as in the OpenAI claim).
* **[CP-15] Scalar vs tensor OS theorem.** OS I/II treat one hermitian scalar field; the tensor/multi-field version (KQR [23, §2.2]) is standard but the reconstruction proof must be (re)done/formalized for it.
* **[CP-16] Linear growth uniformity.** E0′ needs bounds for **all** $n$ with order $\le ns$ and constants $\le\alpha(n!)^\beta$ — a demanding requirement on composite-operator renormalization in a constructive proof.
* **[CP-17] Haag–Kastler** (not required by JW; adding it is a stronger statement).
* **[CP-18] Stress tensor / OPE required or optional.**
* **[CP-19] Test-function space** ($\mathcal S$ vs $\mathcal D$) — JW cite SW, which uses $\mathcal S$.
* **[CP-20] Δ is existential** — no requirement on its value or on $m/\Lambda$.
* **[CP-21] Method-independence.** The statement must not presuppose the Wilson lattice route (Douglas: lattice "not essential"); contrast [54]'s variant A, which bakes in Wilson lattice measures.
* **[CP-22] Identification of $G$ from data.** Leading-log data identify only combinations like $\dim G$ and $C_A$; $B_n$ and $C_n$ algebras have equal dimension. A full identification needs more invariants (e.g. structure of dimension-6 operators, or $C_A/\dim G$ via normalized 3-point functions) [54, limitation 4].
* **[CP-23] Uniqueness of the theory** — not required by JW.
* **[CP-24] Real vs complex fields / conjugation map** — choose a real basis for the 21 components; $\dagger$ includes reflection of tensor indices in OS [23, eq. (2.20)].
* **[CP-25] Separability** of $\mathcal H$ (standard in SW; automatic from countable test-function data).
* **[CP-26] Units / normalization of Tr** — irrelevant after transmutation, but constants in the fingerprint depend on it.

### 3.3 Weaker and stronger variants (catalogue)

| Variant | Content | Relation to Clay |
|---|---|---|
| Wightman (SW) [10] | §2.2–2.3 | required standard (JW[45]) |
| OS I E0–E4 [12] | §2.4 | not known sufficient; OS I's equivalence proof wrong |
| OS II E0′+E1–E4 [13] | §2.4 | sufficient; implies Wightman |
| OS II Ě0 [13] | Laplace-transform continuity | equivalent to Wightman |
| Zinoviev E5 [21] | inverse-Laplace limits | alternative sufficient condition |
| Glimm–Jaffe OS0–OS4 [11] | measure on $\mathcal D'$/$\mathcal S'$ | stronger; OS1 fails for dim-4 composites (§2.6) |
| Nelson Markov fields [24] | Markov property instead of RP | historical; RP is the usable condition |
| Haag–Kastler [17, 18] | nets of C*-algebras | different; not literally required |
| Schlingemann Euclidean nets [22] | E(d)-covariant nets + RP functional ⇒ HK net under (TZ) | accommodates Wilson-loop algebras; (TZ) unproven for YM |
| Seiler / Fröhlich–Osterwalder–Seiler loop axioms [26, 40] | OS-type axioms for Wilson-loop expectations (Seiler LNP 159, Ch. 8; content known here secondhand via [22, 28, 32, 36]) | natural for gauge theory but not "local fields"; 4D sharp loops need renormalization |
| Osterwalder–Seiler lattice [25, 26, 27] | Wilson action on $\varepsilon\mathbb Z^4$, Haar measure, RP, positive self-adjoint transfer matrix (Lüscher), strong-coupling gap and area law | regularized problem; continuum limit open |
| Chatterjee [28] | Problem 4.1 area law ∀β; 5.1 lattice exponential decay of plaquette correlations with $\xi(\beta)<\infty$, $\xi(\beta)\to\infty$; 5.2 continuum Wilson-loop limit with perimeter counterterm | probabilistic proxies; 5.1 is a one-channel lattice statement |
| Lee gauge axioms [36, 37] | Schwinger functions under gauge fixing (indefinite metric), counterterms, renormalized co-location to gauge-invariant composites; RP/cluster imposed only on gauge-invariant ones; growth bound $K^m m!\prod\|f_l\|$ | proposal, several proofs left as stubs ("dd") in the arXiv version read |
| Cao–Chatterjee state space [43]; Chevyrev [44, 46]; CCHS [45] | measures on orbit spaces of distributional connections, via YM heat flow / stochastic quantization | 2D/3D; possible substrate for Euclidean YM measure |
| Gradient-flow observables [42] | flowed $\operatorname{Tr}F^2_t$, flowed Wilson loops | finite, gauge-invariant; non-local at scale $\sqrt{8t}$ |

### 3.4 Lessons from existing formal-statement attempts

1. **Tie the symmetry group to the dynamics.** lean-dojo's statement [53] failed because the Poincaré group and the Hamiltonian were unrelated abstract data and the statement was satisfiable by a toy model. In an OS formulation, $H$ is *defined* from the Schwinger functions (time translations), which removes this failure mode.
2. **Guard against trivial witnesses.** Unit-test the formal statement against: the trivial theory; GFF and its Wick polynomials; generalized free fields with gap; free Proca composites; decoupled sums; 2D YM local sector; conformal theories [54]. Each must **fail** the statement (or a named clause).
3. **Comparator checks statement identity, not meaning.** `leanprover/comparator` [55] checks that a solution proves the same statement as the challenge file and uses only the permitted axioms. Its README warns that many challenges with *definition holes* (definitions the solver fills in) "can be gamed without additional oversight". More generally, Comparator checks that statements are identical, not that they are faithful, so human review of the challenge's definitions is unavoidable. This is precisely the committee's first objective [4].
4. **Douglas et al.'s experience** [34]: definitions were repeatedly wrong (e.g. a conditionally convergent Fourier integral for the covariance); remedy: unit-test definitions by proving auxiliary consequences.

---

## 4. What is proven vs open

| Statement | Status | Source |
|---|---|---|
| Wightman reconstruction (R0–R6 ⇔ W0–W4) | [THM] | SW [10] |
| OS I equivalence via Lemma 8.8 | [FALSE] (counterexample $e^{-y_1y_2}$) | OS II [13]; KQR [23] |
| E0′+E1–E3 ⇒ R0–R5 (+E4 ⇒ R6) | [THM] | OS II [13] |
| Ě0+E1–E3 ⇔ R0–R5 | [THM] | OS II [13] |
| Wightman ⇒ E0–E4 | [THM] | OS I (correct direction) |
| Wightman ⇒ E0′ | open / not known | KQR [23, §9.2.2] |
| E0–E4 alone ⇒ Wightman | open | Schlingemann [22] ("might be true", no proof); KQR [23] derive Wightman properties of 2-, 3- and 4-point functions from the much stronger Euclidean **CFT** axioms (with OPE). That is a different hypothesis set and not a resolution |
| Real-analyticity of $S_n$ off diagonal from OS axioms | [THM] | OS II, Glaser [20] (per [23]) |
| Euclidean nets + RP + (TZ) ⇒ Haag–Kastler net | [THM] | Schlingemann [22] |
| Wightman fields ⇒ HK net in general | open (needs extra hypotheses) | DSW [31] |
| Gap ⇔ joint-spectrum gap ⇔ Euclidean decay on a total set (Props A, B) | [THM] (elementary) | this note; standard spectral theory |
| Gap ⇒ exponential spacelike clustering | [THM] | AHR [29]; Fredenhagen [30] |
| GJ OS1 incompatible with dimension-4 scalar composites in 4D | derived here (sketch) | §2.6 |
| Lattice YM: RP, transfer matrix | [THM] | Osterwalder–Seiler [25]; Lüscher [27] |
| Lattice YM: gap and area law at strong coupling | [THM] | Osterwalder–Seiler [25] |
| Lattice 4D non-abelian: gap/area law at weak coupling | open | [28] Problems 4.1, 5.1 |
| Balaban: UV stability of 4D lattice YM in finite volume (torus), uniform in lattice spacing | [THM] (as published, in a series of papers 1984–89 of which [38] is one; the series ended "before exact Schwinger functions were constructed", per Summers) | [38]; Summers [32, §3.7]; Dimock [50] |
| MRS: YM$_4$ with infrared cutoff | [THM] as published, **limited scope**: a gauge-fixed construction with an IR cutoff in finite volume. It does not give gauge-invariant OS Schwinger functions, a Hilbert space or infinite volume. Schlingemann [22] calls it "claimed". Rivasseau [47] (2000), a co-author, still lists finite-volume YM$_4$ correlation functions in a standard gauge (e.g. Landau) as an open problem | [39]; [22]; [47] |
| 2D YM constructed; 2D abelian Higgs OS axioms (except clustering) | [THM] | [32, §3.7]; BFS (JW ref [7]) |
| 3D YM(-Higgs): local stochastic-quantization dynamics, state spaces | [THM] partial; no OS construction | [43, 44, 45, 46] |
| Nontrivial Wightman QFT in 4D (any) | open: [1] says none was known in 2000, and no accepted example exists as of 2026-11-05 (the OpenAI claim, if verified, would be the first) | [1]; CMI YM page lists the problem as unsolved (checked 2026-11-05) |
| OpenAI: existence of 4D YM (+fermions), continuum & infinite volume | [CLAIM], unpublished, under review | [4, 5, 6] |
| Mass gap for 4D YM | open; not claimed by OpenAI | [4] |
| Sussman–Alpöge QED$_3$/YM$_3$ OS axioms; YM$_4$ existence "slop" | [CLAIM], tentative, LLM-written, not vetted | [52] |
| OpenAI `openai/math` family 215: 2D O(3) σ-model continuum limit with OS axioms and a gap on all of $\Omega^\perp$ | [CLAIM], unreviewed (manuscript catalogue entry only) | [57] |
| Various arXiv "proofs" of existence + gap (2014, 2025, 2026) | [CLAIM], not accepted | [59, 60, 61] |
| GJ axioms for 4D GFF, formalized in Lean (0 sorry per README) | [THM] (machine-checked) | [34, 35] |
| Spectral gap undecidable for general lattice Hamiltonians | [THM] (not applicable to a fixed theory) | [48] |
| Any reviewed Lean statement of the Clay YM problem | none exists | [53, 54] |

---

## 5. Relevance to a 4D YM existence + mass-gap proof and to Lean formalization

### 5.1 Recommended statement architecture

The Euclidean OS route is both mathematically canonical for constructive proofs (lattice → RG → continuum Schwinger functions) and the most formalizable (Douglas et al. [34, §3] say Mathlib "currently lacks a sufficiently developed theory of operators on Hilbert spaces", and chose the GJ measure framework partly for that reason). Proposed layering:

* **L0 infrastructure:** $\mathcal S(\mathbb R^{4n})$, the subspaces ${}^0\mathcal S$, ${}^+\mathcal S$, Schwartz seminorms, $\Theta$, $f^*$, Euclidean group actions on tensor-valued test functions, finite-dimensional $O(4)$/$SO(4)$ representations (check Mathlib/PhysLean availability — Lean workstream).
* **L1 data:** a finite (minimal) or graded (strong) index set of real field components with an $O(4)$ representation; Schwinger functionals $S_n^{(j_1..j_n)}\in({}^0\mathcal S)'$.
* **L2 axioms:** E0′ (linear growth), E1, E2 (RP as positivity of a Hermitian form), E3, E4.
* **L3 Yang–Mills identification:** (i) field content ≅ $\mathrm{Sym}^2(\Lambda^2)$ at dimension ≤4 (21 components) with the transformation law of §2.8(b); (ii) AF fingerprint (2- and 3-point leading-log asymptotics with $G$-dependent constants; $b_1/b_0^2=102/121$ in log-log corrections); (iii) optional stress tensor/OPE.
* **L4 gap:** Euclidean mass-gap predicate of Prop. B over *all* positive-time sequences, plus $m<\infty$ (non-trivial spectrum).
* **L5 theorem:** ∀ G compact simple, ∃ data satisfying L2–L4.
* **Bridges (separate theorems):** OS reconstruction (tensor version) ⇒ Wightman W0–W4; Prop. B ⇒ JW's spectral gap; Prop. A; optionally AHR/Fredenhagen clustering.

Sketch (not compiled; placeholder names):

```lean
-- SKETCH ONLY. Placeholder names; not Mathlib API.
structure FieldContent where
  ι : Type
  [fin : Fintype ι]
  rep : O4 →* ((ι → ℝ) ≃ₗ[ℝ] (ι → ℝ))      -- SO4 if θ ≠ 0  [CP-3]

structure Schwinger (C : FieldContent) where
  S : (n : ℕ) → (Fin n → C.ι) → (ZeroDiagSchwartz n →L[ℂ] ℂ)   -- E0
  S0 : S 0 Fin.elim0 = constOne

def LinearGrowth (F : Schwinger C) : Prop :=                      -- E0′
  ∃ (s : ℕ) (α β : ℝ), ∀ n idx f,
    ‖F.S n idx f‖ ≤ α * (n.factorial : ℝ) ^ β * schwartzNorm (n * s) f

def osForm (F) (G H : PosTimeSeq C) (t : ℝ) : ℂ :=               -- Σ S(Θ g*⊗τ_t h)
  ...

structure OS (F : Schwinger C) : Prop where
  growth : LinearGrowth F
  cov    : EuclidCovariant F            -- E1
  rp     : ∀ G, 0 ≤ (osForm F G G 0).re ∧ (osForm F G G 0).im = 0   -- E2
  symm   : PermSymmetric F              -- E3
  clus   : Clusters F                   -- E4

def EuclideanMassGap (F) (m : ℝ) : Prop :=                         -- Prop. B(3)
  ∀ G : PosTimeSeq C, ∃ K, ∀ t ≥ 0,
    (osForm F G G t).re - ‖vacOverlap F G‖ ^ 2 ≤ K * Real.exp (-m * t)

def ClayYM (G : CompactSimpleLieGroup) : Prop :=
  ∃ (C : FieldContent) (F : Schwinger C),
    OS F ∧ IsSym2Lambda2 C ∧ AFFingerprint G F ∧ NonGeneralizedFree F ∧
    (∃ m > 0, EuclideanMassGap F m) ∧ NontrivialSpectrum F
```

### 5.2 Implications for the proof strategy (from the definition side)

* A constructive proof must deliver, for **all n**, E0′-type bounds on composite-operator Schwinger functions — a uniformity in $n$ that RG/cluster-expansion methods give in superrenormalizable models but which is a serious extra burden in 4D [CP-16].
* RP must be **preserved** through the regularization (Wilson lattice gives it; most continuum regularizations do not [1, §6.5]); the Hilbert space must be constructed, not assumed.
* Because the OS axioms ignore coincident points, the proof never needs to fix contact terms of $\operatorname{Tr}F^2$ products — a real simplification versus a GJ-measure approach.
* The gap must be shown on the full reconstructed space (Prop. B with multi-point $F$), or via a transfer-matrix gap uniform in lattice spacing and volume.
* The existence claim by OpenAI (if confirmed) would cover L1–L3 (likely in some variant) but not L4; our formal statement should be designed so an existence-only result is a clean sub-theorem (L5 without the gap clause).

---

## 6. Open questions / leads

1. **Obtain the OpenAI Lean statement** when released; compare against §5.1 clause-by-clause; run Comparator only after definitional review [4, 55].
2. **Read OS II in the original** (Project Euclid blocked automated access) to confirm exact E0′ wording, the Ě0 topology, and the Summers appendix; and GJ Thm 6.1.5 exact hypotheses.
3. **Read Seiler LNP 159 Ch. 8** (Wilson-loop axioms) and Fröhlich 1979 Cargèse notes; decide whether a loop-based variant should be a secondary target.
4. **Read Douglas, Nat. Rev. Phys. 2026** [3] for his current framing; note the TRG suggestion.
5. **Perturbative workstream:** fix the exact short-distance asymptotics (constants, log powers, normalization) of 2- and 3-point functions of the 21 components; verify the heuristic $|x|^{-8}\log^{-2}$ law and the trace-anomaly normalization; decide which quantities identify $G$ uniquely [CP-22].
6. **Tensor-field OS reconstruction:** locate or write a complete proof for multi-component tensor fields with $O(4)$ covariance (KQR [23, App. B] treat higher-point CFT case).
7. **Does E0′ hold for lattice-derived YM correlators?** Check whether Balaban-type bounds yield product-test-function bounds (OS II appendix form) uniformly in $n$.
8. **Sussman–Alpöge YM$_3$ manuscripts** [52]: extract their precise definitions of $\operatorname{tr}F^2$ Schwinger functions and OS verification as a template for 4D.
9. **Mathlib/PhysLean gap analysis:** Schwartz spaces on $\mathbb R^{4n}$, ${}^0\mathcal S$, $O(4)$ representation theory, Lorentz group, semigroups/self-adjoint operators — Lean workstream.
10. **Lee's gauge axioms** [36, 37]: monitor completion; they address gauge-fixed fields and renormalized co-location, possibly useful for intermediate lemmas.
11. **Global form of G and θ:** decide whether the formal statement quantifies over Lie algebras (local physics) and fixes θ=0.
12. Press reports suggest statement-match disputes also arose around OpenAI's Navier–Stokes claim (forcing conditions) — unverified here, but it reinforces the case for a public, reviewed formal statement *before* any proof is evaluated. (Related and verified: lean-dojo's README [53] shows that its own Navier–Stokes disjunction is provable outright from zero force plus scaling, which is a statement-design failure of exactly this kind.)
13. **`openai/math` family 215** [57] (added by verifier): the catalogue entry claims a canonical continuum limit of the 2D nearest-neighbour O(3) model. The claim covers OS axioms, a unique vacuum, a non-zero connected 4-point function, and a positive Hamiltonian gap "on that entire complement", including rotation-invariant local-observable sectors. **[CLAIM]**, unreviewed. If sound, its gap formulation (full $\Omega^\perp$, not one channel) is a concrete template for Prop. B / L4, and the σ-model is Douglas's [2] closest lower-dimensional analogue of YM$_4$. Read the manuscript and its Lean status.

---

## 7. References

Verified = existence confirmed via arXiv abs page, Crossref DOI lookup, publisher/official page, or (where noted) citation in an already verified primary source. "Read" indicates content was consulted directly.

1. A. Jaffe, E. Witten, *Quantum Yang–Mills Theory*, official CMI problem description (2000); in *The Millennium Prize Problems* (J. Carlson, A. Jaffe, A. Wiles eds.), CMI/AMS 2006, pp. 129–152 [page range not confirmed; book and chapter confirmed via catalog records]. https://www.claymath.org/wp-content/uploads/2022/06/yangmills.pdf — **verified, read in full** (re-read by verifier 2026-11-05).
2. M. R. Douglas, *Report on the Status of the Yang–Mills Millenium Prize Problem*, April 2004. https://ncatlab.org/nlab/files/Douglas-StatusOfYMMillenniumProb.pdf — **verified, read in full** (re-read by verifier 2026-11-05; PDF metadata 23 Mar 2005).
3. M. R. Douglas, *The Yang–Mills Millennium problem*, Nat. Rev. Phys. 8, 86–97 (2026). DOI 10.1038/s42254-025-00909-2 (online 12 Jan 2026) — **verified (Crossref); not read** (paywalled).
4. M. R. Douglas, D. J. Gross (chair), A. Jaffe, I. R. Klebanov, N. Nekrasov, *Proof by OpenAI of the Existence of Quantum Yang–Mills theory — Statement by the shepherding committee*, Oct 2026. https://www.kitp.ucsb.edu/sites/default/files/YM_working_group.pdf — **verified, read in full** (re-read by verifier 2026-11-05; 2 pp.; PDF created 27 Oct 2026).
5. OpenAI, *Working with academic communities to build scientific understanding* (Oct 2026). https://openai.com/index/building-scientific-understanding-with-academic-communities/ — **[UNVERIFIED]**: HTTP 403 again on 2026-11-05, and a web search did not surface this URL from a reliable source. The *announcement itself* is confirmed by [6, 7, 8]; the exact title and URL are not.
6. Advisory Group on Mathematics and AI (AGMAI), statement of 26 Oct 2026. https://agmai.org/ — **verified (fetched 2026-11-05)**. Members: Charles, De Lellis, Gowers, Hairer, Srivastava, Tillmann, Vakil, Witten, Wood. There is also a 25 Oct statement recommending that labs stop designating particular mathematicians to receive AI output.
7. Scientific American, *Dueling proofs from OpenAI and Anthropic astound scientists* (27 Oct 2026). https://www.scientificamerican.com/article/dueling-proofs-from-openai-and-anthropic-astound-scientists/ — **verified (fetched; secondary)**.
8. Quantum Research Center, *OpenAI claims a proof that Yang–Mills theory exists* (28 Oct 2026). https://quantumresearch.center/news/articles/openai-yang-mills-existence/ — **verified (fetched; secondary)**.
9. Clay Mathematics Institute, *Rules for the Millennium Prize Problems* (adopted 26 Sep 2018). https://www.claymath.org/millennium-problems/rules/ — **verified (fetched 2026-11-05)**. A solution must appear in a Qualifying Outlet, at least two years must pass after publication, and it must have general acceptance.
10. R. F. Streater, A. S. Wightman, *PCT, Spin and Statistics, and All That*, Benjamin 1964; Princeton Landmarks 2000, ISBN 978-0-691-07062-9 — **verified (catalog/citations); not read directly**.
11. J. Glimm, A. Jaffe, *Quantum Physics: A Functional Integral Point of View*, 2nd ed., Springer 1987. DOI 10.1007/978-1-4612-4728-9 — **verified (Crossref); axioms read via [34]**.
12. K. Osterwalder, R. Schrader, *Axioms for Euclidean Green's functions*, CMP 31, 83–112 (1973). DOI 10.1007/BF01645738 — **verified; content via [23]**.
13. K. Osterwalder, R. Schrader, *Axioms for Euclidean Green's functions II* (with an appendix by S. Summers), CMP 42, 281–305 (1975). DOI 10.1007/BF01608978 — **verified** (Crossref; the Summers appendix is confirmed by the Project Euclid listing and by Summers' own publication list); content via [23].
14. A. S. Wightman, *Quantum field theory in terms of vacuum expectation values*, Phys. Rev. 101, 860–866 (1956). DOI 10.1103/PhysRev.101.860 — **verified**.
15. A. S. Wightman, L. Gårding, *Fields as operator-valued distributions in relativistic quantum theory*, Arkiv för Fysik 28, 129–184 (1964) — **verified (bibliographic)** via two independent citing works: Summers [32, ref. 203] gives pp. 129–184 with author order Wightman–Gårding, and Douglas et al. [34, ref. 35] give pp. 129–189 with order Gårding–Wightman. The end page is therefore uncertain (129–184 is more likely). No DOI; not read.
16. A. S. Wightman, *How it was learned that quantized fields are operator-valued distributions*, Fortschr. Phys. 44, 143–178 (1996). DOI 10.1002/prop.2190440204 — **verified**.
17. R. Haag, D. Kastler, *An algebraic approach to quantum field theory*, J. Math. Phys. 5, 848–861 (1964). DOI 10.1063/1.1704187 — **verified**.
18. R. Haag, *Local Quantum Physics*, 2nd ed., Springer 1996. DOI 10.1007/978-3-642-61458-3 — **verified**.
19. N. N. Bogolubov, A. A. Logunov, A. I. Oksak, I. T. Todorov, *General Principles of Quantum Field Theory*, Kluwer 1990. DOI 10.1007/978-94-009-0491-0 — **verified**.
20. V. Glaser, *On the equivalence of the Euclidean and Wightman formulation of field theory*, CMP 37, 257–272 (1974). DOI 10.1007/BF01645941 — **verified**.
21. Yu. M. Zinoviev, *Equivalence of Euclidean and Wightman field theories*, CMP 174, 1–27 (1995). DOI 10.1007/BF02099461; arXiv:hep-th/9408009 — **verified** (Crossref and arXiv; arXiv's journal-ref says pp. 1–28, Crossref 1–27; arXiv's DOI field points to a related LNP proceedings chapter, 10.1007/3-540-59190-7_25); PDF downloaded and content-checked.
22. D. Schlingemann, *From Euclidean field theory to quantum field theory*, Rev. Math. Phys. 11, 1151–1178 (1999). arXiv:hep-th/9802035, DOI 10.1142/S0129055X99000362 — **verified, read; PDF downloaded**.
23. P. Kravchuk, J. Qiao, S. Rychkov, *Distributions in CFT II. Minkowski space*, JHEP 08 (2021) 094. DOI 10.1007/JHEP08(2021)094; arXiv:2104.02090 — **verified, read (§2, §9); PDF downloaded**. Note: KQR use the $-{+}{+}{+}$ signature.
24. E. Nelson, *Construction of quantum fields from Markoff fields*, J. Funct. Anal. 12, 97–112 (1973). DOI 10.1016/0022-1236(73)90091-8 — **verified**.
25. K. Osterwalder, E. Seiler, *Gauge field theories on a lattice*, Ann. Phys. 110, 440–471 (1978). DOI 10.1016/0003-4916(78)90039-8 — **verified**.
26. E. Seiler, *Gauge Theories as a Problem of Constructive Quantum Field Theory and Statistical Mechanics*, Lecture Notes in Physics 159, Springer 1982. DOI 10.1007/3-540-11559-5 — **verified; content secondhand**.
27. M. Lüscher, *Construction of a selfadjoint, strictly positive transfer matrix for Euclidean lattice gauge theories*, CMP 54, 283–292 (1977). DOI 10.1007/BF01614090 — **verified**.
28. S. Chatterjee, *Yang–Mills for probabilists* (2018). arXiv:1803.01950 — **verified, read; PDF in library**.
29. H. Araki, K. Hepp, D. Ruelle, *On the asymptotic behaviour of Wightman functions in space-like directions*, Helv. Phys. Acta 35, 164–174 (1962) — **verified (bibliographic: University of Michigan Deep Blue record and citing works); not read**.
30. K. Fredenhagen, *A remark on the cluster theorem*, CMP 97, 461–463 (1985). DOI 10.1007/BF01213409 — **verified**.
31. W. Driessler, S. J. Summers, E. H. Wichmann, *On the connection between quantum fields and von Neumann algebras of local operators*, CMP 105, 49–84 (1986). DOI 10.1007/BF01212341 — **verified**.
32. S. J. Summers, *A perspective on constructive quantum field theory* (2012/2016). arXiv:1203.3991 — **verified, read (§1, §3.7, §8); PDF in library**.
33. A. Jaffe, *Reflection positivity then and now* (2018). arXiv:1802.07880 — **verified; PDF downloaded; not read in detail**.
34. M. R. Douglas, S. Hoback, A. Mei, R. Nissim, *Formalization of QFT* (2026). arXiv:2603.15770 — **verified, read (§1–5, App. B.5); PDF downloaded**.
35. S. A. Cherkis, M. R. Douglas, S. Hoback, A. Mei, R. Nissim, *OSforGFF* (Lean 4 repo, v3.2, Aug 2026). https://github.com/mrdouglasny/OSforGFF — **verified** (GitHub README checked 2026-11-05: authors as listed; v3.2; "0 sorries, 0 axioms"; GJ OS0–OS4 for the GFF in $d\ge2$, including $d=4$).
36. M. C. Lee, *Axioms for Quantum Yang–Mills Theories — 1. Euclidean Axioms* (2021–2025). arXiv:2112.08575 — **verified, read; PDF downloaded**.
37. M. C. Lee, *Axioms for Quantum Yang–Mills Theories — 2. Minkowski Axioms* (2024). arXiv:2401.13899 — **verified; PDF downloaded; not read**.
38. T. Bałaban, *Renormalization group approach to lattice gauge field theories I. Generation of effective actions in a small field approximation and a coupling constant renormalization in four dimensions*, CMP 109, 249–301 (1987). DOI 10.1007/BF01215223 — **verified** (Crossref; full title per JW ref. [3]). This is one paper of a multi-paper series. Summers [32] points to Bałaban, *Large field renormalization II*, CMP 122, 355–392 (1989) for the full list [series end-paper verified only via Summers' bibliography].
39. J. Magnen, V. Rivasseau, R. Sénéor, *Construction of YM$_4$ with an infrared cutoff*, CMP 155, 325–383 (1993). DOI 10.1007/BF02097397 — **verified (Crossref)**. Abstract not accessed (paywalled); its scope is described from [22] and [47].
40. J. Fröhlich, K. Osterwalder, E. Seiler, *On virtual representations of symmetric spaces and their analytic continuation*, Ann. Math. 118, 461–489 (1983). DOI 10.2307/2006979 — **verified**.
41. O. Aharony, N. Seiberg, Y. Tachikawa, *Reading between the lines of four-dimensional gauge theories*, JHEP 08 (2013) 115. DOI 10.1007/JHEP08(2013)115; arXiv:1305.0318 — **verified; PDF downloaded**.
42. M. Lüscher, *Properties and uses of the Wilson flow in lattice QCD*, JHEP 08 (2010) 071. DOI 10.1007/JHEP08(2010)071; arXiv:1006.4518 — **verified; PDF downloaded**.
43. S. Cao, S. Chatterjee, *A state space for 3D Euclidean Yang–Mills theories* (2021). arXiv:2111.12813 — **verified; PDF in library**.
44. I. Chevyrev, *Yang–Mills measure on the two-dimensional torus as a random distribution*, CMP 372, 1027–1058 (2019). DOI 10.1007/s00220-019-03567-5; arXiv:1808.09196 — **verified**.
45. A. Chandra, I. Chevyrev, M. Hairer, H. Shen, *Stochastic quantisation of Yang–Mills–Higgs in 3D*, Invent. Math. 237, 541–696 (2024). DOI 10.1007/s00222-024-01264-2; arXiv:2201.03487 — **verified**.
46. I. Chevyrev, *Stochastic quantisation of Yang–Mills*, J. Math. Phys. 63 (2022). DOI 10.1063/5.0089431; arXiv:2202.13359 — **verified**.
47. V. Rivasseau, *Constructive field theory and applications: perspectives and open problems*, J. Math. Phys. 41, 3764–3775 (2000). DOI 10.1063/1.533326; arXiv:math-ph/0006017 — **verified; PDF in library** (§II.1.2 read by verifier).
48. T. Cubitt, D. Perez-Garcia, M. M. Wolf, *Undecidability of the spectral gap*, Forum Math. Pi 10 (2022) e14. DOI 10.1017/fmp.2021.15; arXiv:1502.04573 — **verified**.
49. L. Gross, *Stability of the Yang–Mills heat equation for finite action* (2017). arXiv:1711.00114 — **verified**.
50. J. Dimock, *The renormalization group according to Balaban — I. Small fields*, Rev. Math. Phys. 25 (2013). DOI 10.1142/S0129055X13300100; arXiv:1108.1335 — **verified**.
51. S. Chatterjee, *A probabilistic mechanism for quark confinement*, CMP (2021). DOI 10.1007/s00220-021-04086-y; arXiv:2006.16229 — **verified**.
52. E. Sussman, L. Alpöge, *Yang–Mills LLM experiment* (GitHub repo, created 2026-10-06). https://github.com/ethanwsussman/Yang--Mills-LLM-experiment — **verified (README fetched 2026-11-05)**. The middle initial "W." in the original entry was inferred from the GitHub username and has been dropped.
53. lean-dojo, *LeanMillenniumPrizeProblems* (GitHub). https://github.com/lean-dojo/LeanMillenniumPrizeProblems — **verified (README fetched 2026-11-05)**.
54. K. Rémondière (code and text by Claude agents under his direction), *yang-mills-lean-statement* v1.1.0 (2026-10-25; Zenodo doi:10.5281/zenodo.23650415, which resolves (HTTP 302)). https://github.com/AIdevsmartdata/yang-mills-lean-statement — **verified (README fetched 2026-11-05)**.
55. Lean FRO, *comparator* (GitHub). https://github.com/leanprover/comparator — **verified (GitHub API and README fetched 2026-11-05)**.
56. OpenAI, *ten-proofs* (Lean 4 formalizations for "Ten advances in mathematics and theoretical computer science"; created 2026-08-05). https://github.com/openai/ten-proofs — **verified (README fetched 2026-11-05)**.
57. OpenAI, *math* (721 manuscripts in 373 families from an unnamed internal model, about 42% of top-line results formalized; created 2026-10-06). https://github.com/openai/math — **verified (README and CONTENTS.md fetched 2026-11-05)**. It contains no YM$_4$ manuscript; family 215 (2D O(3) model) is relevant (§6, item 13).
58. M. R. Douglas, *Axioms for physical reasoning: codifying the Seiberg–Witten solution in Lean* (2026). arXiv:2607.06379 — **verified; PDF downloaded; not read**.
59. S. Farinelli, *Renormalized four dimensional quantum Yang–Mills theory and mass gap* (2014). arXiv:1406.4177 — **verified (metadata); claimed proof, not accepted**.
60. D. C. Jacobsen, *A constructive proof of existence and mass gap for pure SU(3) Yang–Mills in four-dimensional space-time* (2025). arXiv:2506.00284 — **verified (metadata); claimed proof, not accepted**.
61. M. Faizal, A. Shabir, *Reflection-positive construction of a four-dimensional SU(N) Yang–Mills theory with mass gap and confinement*, Fortschr. Phys. 74 (2026) e70097. arXiv:2606.19362 — **verified (metadata); claimed, not accepted by CMI**.
62. D. J. Gross, F. Wilczek, *Ultraviolet behavior of non-abelian gauge theories*, Phys. Rev. Lett. 30, 1343–1346 (1973), DOI 10.1103/PhysRevLett.30.1343; H. D. Politzer, *Reliable perturbative results for strong interactions?*, Phys. Rev. Lett. 30, 1346–1349 (1973), DOI 10.1103/PhysRevLett.30.1346 — **verified (Crossref; also JW refs. [21], [38])**.
63. K. G. Wilson, *Confinement of quarks*, Phys. Rev. D 10, 2445–2459 (1974). DOI 10.1103/PhysRevD.10.2445 — **verified (Crossref)**. JW instead cite Wilson's Erice lectures "Quarks and strings on a lattice" (JW[48]).
64. J. Glimm, A. Jaffe, T. Spencer, *The Wightman axioms and particle structure in the $P(\phi)_2$ quantum field model*, Ann. Math. 100, 585–632 (1974). DOI 10.2307/1970959 — **verified (Crossref; JW ref. [19]; KQR ref. [88])**.
65. D. Brydges, J. Fröhlich, E. Seiler, *On the construction of quantized gauge fields* I: Ann. Phys. 121, 227–284 (1979), DOI 10.1016/0003-4916(79)90098-8; II: CMP 71, 159–205 (1980), DOI 10.1007/BF01197918; III: CMP 79, 353–399 (1981), DOI 10.1007/BF01208500 — **verified (Crossref; JW ref. [7])**.
66. Wikipedia, *Yang–Mills existence and mass gap* (accessed 2026-11-05). https://en.wikipedia.org/wiki/Yang%E2%80%93Mills_existence_and_mass_gap — **verified (secondary)**.
67. V. Ilin, B. Nugent, *Sorries are not the hard part: an expert-review case study of a semi-autonomous formalization* (2026). arXiv:2606.13925 — **verified (metadata); not read; lead for statement review practice**.
68. Clay Mathematics Institute, *Yang–Mills & the Mass Gap* (problem page). https://www.claymath.org/millennium/yang-mills-the-maths-gap/ — **verified (fetched 2026-11-05; added by verifier)**: the problem is listed as unsolved and OpenAI is not mentioned.

---

## Verification log

*Adversarial verification pass, 2026-11-05 (workstream `01-problem-definition`). The verifier re-read the primary sources rather than trusting the author's summary.*

### What was checked

**References (68 total; 67 original + 1 added).**

* **arXiv IDs.** All 25 arXiv IDs were checked with the arXiv API (`export.arxiv.org/api/query`). Every ID resolves, with title and authors matching the note: hep-th/9408009, hep-th/9802035, 2104.02090, 1803.01950, 1203.3991, 1802.07880, 2603.15770, 2112.08575, 2401.13899, 1305.0318, 1006.4518, 2111.12813, 1808.09196, 2201.03487, 2202.13359, math-ph/0006017, 1502.04573, 1711.00114, 1108.1335, 2006.16229, 2607.06379, 1406.4177, 2506.00284, 2606.19362, 2606.13925.
* **DOIs.** All 20 DOIs in the original note were checked with Crossref (`api.crossref.org/works/<DOI>`), plus 4 more checked by the verifier. All resolve, with title, authors, venue, volume, pages and year matching the note. Crossref bibliographic queries supplied missing DOIs for Zinoviev (CMP 174), GJS (Ann. Math. 100), BFS I–III, Gross–Wilczek, Politzer and Wilson.
* **Books.** The Streater–Wightman ISBN was checked via Open Library.
* **URLs.** The following were fetched: the CMI JW PDF (14 pp.), the nLab-hosted Douglas 2004 PDF (4 pp.), the KITP committee statement (2 pp.), AGMAI, Scientific American, Quantum Research Center, the CMI rules page, the CMI YM page, Wikipedia, and the nLab OS-theorem page. On GitHub, the API metadata and READMEs were fetched for: Sussman–Alpöge, lean-dojo, AIdevsmartdata, comparator, openai/ten-proofs, openai/math (including CONTENTS.md), and OSforGFF.
* **Library PDFs.** For all 20 locally present PDFs cited by this note, the first-page text was extracted and matches the expected paper. **No mis-ID'd PDF was found and none was deleted.** Five cited arXiv papers have no local PDF: 1502.04573, 1711.00114, 1406.4177, 2506.00284 and 2606.13925. They are not required.

**Key claims checked against sources.**

1. *JW official statement.* The wording is confirmed: "non-trivial", "at least as strong as those cited in [45, 35]". JW[45] = SW and JW[35] = OS I **and** II, both confirmed in JW's bibliography. Also confirmed from the text:
   - the field-correspondence requirement and footnote 1;
   - the AF/stress-tensor/OPE paragraph;
   - $m<\infty$;
   - footnote 2, which excludes weak existence;
   - "Establishing a quantum mechanical Hilbert space is part of the solution";
   - the absence of a θ-term in eq. (1);
   - the §3 remark that OPE and stress tensor are not part of the existing axiom sets.
2. *Douglas 2004.* Confirmed: the problem is restated without "non-trivial"; existence is identified with establishing the OS axioms; the lattice is "not essential"; the state of the art is Balaban and MRS; Kopper's regulated O(N) gap; the SUSY-with-soft-breaking heuristic.
3. *Committee statement.* Confirmed: the members, with Gross as chair; existence "including coupling to fermions"; Balaban's RG as an ingredient; confinement and gap stated as open; the Lean formalization "being provided"; the first objective, a definitions and statement check; 1,147 pages. **Added:** OpenAI asked Gross on 16 Oct to take custody.
4. *OpenAI dates and scope.* The dates 9 Sep (YM), 18 Sep (QCD) and 16 Oct (Lean) were confirmed only in secondary source [8]; [7] confirms existence-only with the gap open. All of this remains **[CLAIM]**. The primary OpenAI page is still inaccessible (HTTP 403), so [5] is marked [UNVERIFIED].
5. *OS I error.* Confirmed in KQR §9.2.1: Lemma 8.8 is wrong, with counterexample $e^{-y_1y_2}$ (continuation $e^{x_1x_2}$). Also confirmed:
   - Ě0 is near-equivalent to assuming temperedness and is hard to verify;
   - E0′ appears as KQR eq. (9.18), with the exact form reproduced correctly;
   - E0′ is "not known to follow from Wightman axioms";
   - the appendix bound (9.19) is confirmed;
   - Zinoviev's E5 is judged about as hard as Ě0;
   - the OS II appendix is by S. Summers (Project Euclid record).
6. *Schlingemann.* Confirmed: the "might be true" remark for the ordinary $\mathcal S$-topology, and that condition (TZ) excludes generalized free fields with non-$L^1$ mass distribution.
7. *GJ axioms.* OS0–OS4 and the OS1 form were confirmed against [34] and nLab, including the local-integrability rider for $p=2$. Problem found: nLab gives Thm 6.1.5 but **not** the "OS4 ⇔ unique vacuum" split. That attribution has been corrected and marked unverified.
8. *Chatterjee [28].* Problems 4.1 (area law), 5.1 (gap via plaquette correlations with $\xi(\beta)$) and 5.2 (continuum limit with counterterm $c(R+T)$) are confirmed. Also confirmed: Osterwalder–Seiler proved the area law at small β. **Added:** Chatterjee doubts the counterterm is necessary.
9. *Summers [32].*
   - BFS: the 2D abelian Higgs model satisfies all OS axioms except clustering (confirmed).
   - Balaban: the UV stability series "came to an end before exact Schwinger functions were constructed" (confirmed).
   - "posited for convenience", on vacuum uniqueness, is confirmed.
   - The gauge-potential no-go is confirmed, but as a Strocchi-type result under assumptions. Corrected.
10. *2026 repositories.* The following were confirmed against the READMEs:
    - Sussman–Alpöge: page counts 242, 857 and 1,201, and the disclaimer.
    - lean-dojo: "Statement incomplete, not a valid target", together with the exact defect list and the September 2026 vacuum-uniqueness fix.
    - AIdevsmartdata: v1.1.0 dated 2026-10-25; 21 components; $-102/121$; SymPy; OS reconstruction as a named hypothesis; guards; Claude-written; unreviewed.
    - OSforGFF: v3.2, 0 sorries, authors as listed.
11. *Douglas et al. [34].* Confirmed: definitions, including the OS axioms, were initially wrong, with the conditionally convergent covariance Fourier integral as an example.
12. *Lee [36].* Confirmed: "Proof. dd" stubs are present in v12, and the growth bound has the form $K^m m!\prod\|f_l\|$.
13. *Mathematics derived in the note, re-derived by the verifier.*
    - $b_1/b_0^2=(34/3)/(121/9)=102/121$ is correct.
    - $\mathrm{Sym}^2(\Lambda^2)=(2,0)\oplus(0,0)\oplus(0,2)\oplus(0,0)\oplus(1,1)$ has dimension $5+1+5+1+9=21$, which is correct.
    - The two-loop running-coupling formula is correct.
    - Prop. A (boost argument) is correct.
    - Prop. B is correct: the closed subspace killed by $E_H([0,m_0))$ contains the $\Omega^\perp$-projections of a total set.
    - The OS1-failure argument is logically correct given its heuristic premise.

### Corrections applied (in place)

* **Summary.**
  - Reworded "Lean formalization completed 16 Oct". The date is a secondary-source report of OpenAI's statement, and the committee uses 16 Oct for the custody request.
  - Replaced "The mass gap is not claimed by anyone credible" with sourced wording: OpenAI does not claim it, the committee says it is open, and the arXiv gap claims are not accepted.
* **§1.1 citation collision fixed.** JW's own reference numbers ([45], [35], [24], [13], [36]) collided with this note's numbering; for example, the note's [35] is the OSforGFF repo and its [24] is Nelson. JW numbers are now prefixed "JW" and mapped to this note's numbers. Also, JW[24] is Haag's book, not the Haag–Kastler paper.
* **§1.3 OpenAI bullet.** It now states which source gives which date; adds "will not seek the prize" [8] and AGMAI's "completion of the Standard Model".
* **§1.3 Sussman–Alpöge.** "YM$_4$ unfinished sketch" was an understatement. The README says the authors "appear to have" a YM$_4$ existence argument in about 61k pages of unvetted raw output.
* **§1.3 / §2.9 AIdevsmartdata.** Recorded its own Limitation 3: the variant-B gap covers only the sector generated by the 21 components. This confirms the note's one-channel concern.
* **§2.4 KQR.** The CFT result covers 2-, 3- and 4-point functions and is derived from Euclidean **CFT** axioms with a convergent OPE. It is not an E0–E4 ⇒ Wightman result.
* **§2.6.** The GJ Thm 6.1.5 / OS4 attribution was corrected, and the verifier's check of the OS1-failure argument was appended.
* **[CP-11].** The ill-definedness of sharp Wilson loops is relabelled [HEUR], Chatterjee's own doubt is noted, and the Summers/Strocchi no-go is stated with its hypotheses.
* **§3.4 item 3.** Comparator's caveat concerns *definition-hole* challenges, and its scope is statement identity, not faithfulness.
* **§5.1.** [34] says Mathlib lacks "a sufficiently developed theory of operators on Hilbert spaces". It does not say "unbounded-operator theory".
* **§4 table.**
  - MRS: scope narrowed (gauge-fixed, IR cutoff, finite volume, no gauge-invariant OS data). Supported by [22], which calls it "claimed", and [47], which still lists finite-volume standard-gauge YM$_4$ as open.
  - Balaban: the row now notes the multi-paper series.
  - "E0–E4 alone ⇒ Wightman": the row is clarified.
  - "Nontrivial 4D Wightman QFT": the row now says "open as of [1]; none accepted as of 2026-11-05".
  - Added a row for the openai/math O(3) claim.
* **References.**
  - [1]: page range flagged as unconfirmed.
  - [5]: marked [UNVERIFIED].
  - [13]: Summers appendix confirmed.
  - [15]: upgraded from verified=false to verified (bibliographic) via [32] and [34]; the page discrepancy is noted.
  - [21]: added DOI 10.1007/BF02099461; noted the arXiv DOI-field and page discrepancies.
  - [22]: added pages.
  - [29]: added pages 164–174.
  - [38]: full title, plus a series note.
  - [52]: dropped the unverified middle initial.
  - [62]–[65]: upgraded from "verified via citation" to Crossref-verified, with DOIs.
  - Added DOIs to [23], [41], [42], [44]–[48], [50], [51].
  - Added [68], the CMI problem page.
* **§6.** Added lead 13 (openai/math family 215) and the verified lean-dojo Navier–Stokes triviality note.

### Residual concerns (not resolved)

1. **The OpenAI primary announcement [5] could not be read.** All OpenAI-specific dates rest on one secondary outlet [8]. Re-check when the page is accessible, or when the committee releases the Lean statement.
2. **[1] page range.** "pp. 129–152" in the 2006 AMS/CMI book is unconfirmed; only the book and chapter are confirmed.
3. **[15] Gårding–Wightman.** The end page (184 vs 189) and the author order differ between the two citing sources.
4. **The GJ OS0–OS3 / OS4 split** and the exact hypotheses of GJ Thm 6.1.5 still need checking against the GJ book itself (open question 2 in §6).
5. **MRS [39] abstract not accessed.** The scope statement is inferred from [22] and [47]. "Gauge-fixed, IR cutoff, finite volume" should be confirmed from the paper.
6. **Content of Douglas, Nat. Rev. Phys. [3].** The TRG remark remains unverified.
7. **Derived results remain derived.** Prop. A and Prop. B, the 21-component field content, the OS1-failure argument and the $|x|^{-8}\log^{-2}$ asymptotics were checked for internal consistency only. They are this note's own derivations (Props A/B elementary; the others heuristic in their premises) and should be confirmed by the analysis and perturbative workstreams before the Lean statement relies on them.
8. **Uncited specifics.** The SW theorem number (Thm 3-7) and the claim that Osterwalder–Seiler [25] proved a *mass gap* at strong coupling were not checked against the original texts; only the area law was confirmed, via [28]. Both are standard, but neither was verified here.
9. **Secondary sources disagree on release status.** One low-quality blog claims that OpenAI's Lean files are public. The committee and AGMAI say nothing has been released. The committee/AGMAI position is the one adopted here.
