# 07 — Rigorous lattice gauge theory results relevant to 4D Yang–Mills existence and mass gap

Workstream key: `07-lattice-rigorous-results` · Compiled 2026-11-05 · Status labels used throughout:

- **[T-pub]** established theorem, published in a refereed venue.
- **[T-pre]** theorem stated in a recent arXiv preprint by established researchers. It has not necessarily been refereed. I read the statement, not the full proof.
- **[G]** a classical claim in which later authors have identified a gap.
- **[D]** a disputed claim.
- **[C]** an extraordinary claim that has not been verified. Treat with strong scepticism.
- **[H]** folklore, heuristic, or numerical evidence; not a theorem.

Reference numbers `[n]` point to the list at the end. Where I describe the content of a paywalled classic (Osterwalder–Seiler, Göpfert–Mack, Fröhlich–Spencer, Durhuus–Fröhlich, Schor), the description comes from **secondary sources that I did read**: Chatterjee's survey [88], Cao–Nissim–Sheffield [58,61], Nissim [59,62], Garban–Sepúlveda [15] and Adhikari–Cao [32]. I say so where it matters.

---

## Summary

1. **On the lattice, the structural ingredients of "existence" hold at every coupling.** For any compact gauge group $G$, any dimension and any $\beta$, Wilson's lattice Yang–Mills measure has these properties:
   - it is reflection positive (Osterwalder–Seiler [2]);
   - it has a positive self-adjoint transfer matrix (Lüscher [4], OS [2]);
   - Elitzur's theorem holds [5];
   - there are universal two-sided bounds: decay is at least perimeter law [7], at most area law [6], and the static potential is concave [8].

   What is missing is control of the **continuum limit $\beta\to\infty$ in $d=4$**, together with the infinite-volume and uniqueness questions at large $\beta$.

2. **Mass gap and area law are proven only at strong coupling, and only in regimes bounded away from the scaling region.** For non-abelian continuous groups (SU(N), U(N), SO(N)) in $d=3,4$, every proven result on exponential clustering, area law or uniqueness of the infinite-volume Gibbs state sits in a small-$\beta$ window.
   - The classical window is Osterwalder–Seiler 1978 [2]: $\beta_W\lesssim c_d/N$.
   - Recent work enlarged it to the full 't Hooft regime, $\beta_W \lesssim c\,N$, i.e. $\beta_{tH}<1/(16(d-1))$ for SU(N). This came from three papers:
     - Shen–Zhu–Zhu [56] (2022/23), using Bakry–Émery, a log-Sobolev inequality, and Langevin dynamics;
     - Cao–Nissim–Sheffield [58] (2025), area law via the Durhuus–Fröhlich criterion [22], with $\beta_{tH}<1/(8(d-1))$;
     - Nissim [59] (2025) for U(N).
   - For SU(3) in $d=4$ the best proven window is $\beta_{\rm LQCD}<0.375$ for area law [58] and $<0.1875$ for the log-Sobolev inequality and gap [56]. Lattice QCD works at $\beta_{\rm LQCD}\approx 5.7$–$6.5$ [H].

3. **For pure lattice Yang–Mills with a continuous non-abelian group in $d\ge 3$, no rigorous result on correlation decay, area law or Gibbs uniqueness exists at large $\beta$.** That is the regime the continuum limit requires. *(Verifier correction.)* There is one exception for confinement in the weak, logarithmic sense. In $d=3$, any $G\subseteq U(n)$ containing the full central circle $\{zI\}$, U(n) included, has a logarithmically growing potential at **all** $\beta$ (Fröhlich [16], Cor. 2, with Glimm–Jaffe [11]; self-contained proof in Chatterjee [17]). The mechanism comes entirely from the abelian central U(1), not from non-abelian dynamics, and it says nothing about $d=4$, SU(N), area law or a gap.
   - Asymptotic freedom (perturbative, [H]) says the correlation length must grow like $\xi(\beta)\sim \exp\!\big(\tfrac{12\pi^2}{11N^2}\beta_{\rm LQCD}\big)$ times powers of $\beta$.
   - Strong-coupling methods give $\xi(\beta)=O(1)$ by construction. This is the central gap.

4. **Weak-coupling rigour exists only in four non-generic settings.**
   - (a) **Finite gauge groups.** These are gapped but deconfined at large $\beta$: Chatterjee [28], Cao [29], Forsström–Lenells–Viklund [30], Forsström [31], Adhikari–Cao [32].
   - (b) **U(1).** In 4D it is massless and deconfined at large $\beta$ (Guth [9], Fröhlich–Spencer [10]). Its continuum limit is the free Maxwell field (Gross [13], Driver [14]). In 3D it confines at all $\beta$ (Göpfert–Mack [12]).
   - (c) **Higgs models in the "complete breakdown" regime.** These give Gaussian/massive scaling limits (Chatterjee [65], Rajasekaran–Yakir–Zhou [66], Chatterjee–Yakir [67], Balaban–Brydges–Imbrie–Jaffe [68]).
   - (d) **Leading-order asymptotics of the free energy** (Chatterjee [63], Brennecke [64]), plus Balaban's ultraviolet stability programme [70–73]. Balaban's work is covered by another workstream.
   - None of these has a mechanism that transfers to continuous non-abelian groups at large $\beta$.

5. **Confinement and mass gap are logically distinct, and known examples separate them.**
   - Finite groups at weak coupling are gapped [32] but perimeter-law [28,29].
   - 4D U(1) at weak coupling is neither gapped nor confining [10].
   - SO(3), which has trivial centre, is gapped at strong coupling [56] but deconfining (Nissim 2026 [62]).
   - Conditional bridges exist: a *strong* mass gap (exponential decay under arbitrary boundary conditions) plus a nontrivial centre implies area law (Chatterjee 2021 [26]). A uniform mass gap of the slab σ-model implies area law (Durhuus–Fröhlich 1980 [22]).

6. **Disputed and unverified claims.**
   - Tomboulis 2007 [75] claimed confinement for 4D SU(2) at all couplings. Ito–Seiler [76,78] identified an unproved inequality at large $\beta$; Tomboulis replied [77]. It is not accepted as a proof [D].
   - A 2026 Fortschritte der Physik paper (Faizal–Shabir [80]) claims a complete reflection-positive construction with mass gap and confinement [C]. Nothing visible supports it beyond the abstract-level outline.
   - Older claims with identified gaps [G]:
     - perimeter-law lower bounds for trivial-centre groups (Glimm–Jaffe 1979; Seiler 1982), per Nissim [62];
     - extension of finite-abelian cluster expansions to non-abelian finite groups (Seiler 1982; Szlachányi–Vecsernyés 1989), per Borgs [35] and Adhikari–Cao [32].
   - The task text names an "Adhikari–Suzuki–Zhou–Zhuang" paper. **I could not find it** in arXiv author searches or on the web, so it is listed as unverified. The closest real works are Cao–Nissim–Sheffield's *dynamical* area-law paper [58] and Rajasekaran–Yakir–Zhou [66].

7. **Lean.** A Lean 4 + Mathlib lattice gauge theory library already exists: the `lgt` repo [90] by M. R. Douglas with F. Rajasekaran. It defines the U(n) Wilson action, the Yang–Mills Gibbs measure and the DLR property. It proves a strong-coupling mass gap via Dobrushin uniqueness for $\beta_W<1/(32n(d-1))$. Its README reports zero `sorry`s and a Lean FRO `comparator` kernel replay at commit `ec975bd`. Both claims are self-reported; the replay ran on macOS with the insecure sandbox shim. Douglas–Hoback–Mei–Nissim [89] formalized the 4D free field and the Glimm–Jaffe/OS axioms. These give a concrete, already-machine-checked base layer to build the project's Lean statement on.

---

## 1. Key definitions and statements

### 1.1 The model

Take $\Lambda\subset\mathbb Z^d$ finite (or a torus) and $G\subseteq U(n)$ a compact group with normalized Haar measure $\sigma$. A configuration is $U:\vec E(\Lambda)\to G$ with $U_{e^{-1}}=U_e^{-1}$. For a plaquette $p=e_1e_2e_3e_4$, write $U_p=U_{e_1}U_{e_2}U_{e_3}U_{e_4}$.

The **Wilson action** and measure are
$$
S_\Lambda(U)=\sum_{p\in P_\Lambda^+}\mathrm{Re}\,\mathrm{Tr}(I-U_p),\qquad
d\mu_{\Lambda,\beta}(U)=Z^{-1}e^{-\beta_W S_\Lambda(U)}\prod_{e\in E^+_\Lambda}d\sigma(U_e).
$$

The **Villain action** replaces $e^{\beta\,\mathrm{Re}\,\mathrm{Tr}\,U_p}$ by a heat kernel on $G$. For U(1) it is $\sum_{m\in\mathbb Z}e^{-\frac\beta2(\theta_p+2\pi m)^2}$; Göpfert–Mack [12] and Garban–Sepúlveda [15] use it. Results for one action do not automatically transfer to the other.

Infinite-volume states are DLR Gibbs measures on $G^{E(\mathbb Z^d)}$. At least one exists by compactness, but **uniqueness at large $\beta$ in $d\ge3$ is open** [88].

**Normalization conventions.** The literature mixes four of them, so all regimes below are converted:

| symbol | action | relation |
|---|---|---|
| $\beta_W$ ("Wilson/probabilist", OS [2], Chatterjee [26,88]) | $\beta_W\sum_p \mathrm{Re}\,\mathrm{Tr}(I-U_p)$ | — |
| $\beta_{\rm LQCD}$ (lattice QCD, SU(N)) | $\frac{\beta_{\rm LQCD}}{N}\sum_p \mathrm{Re}\,\mathrm{Tr}(I-U_p)$, $\beta_{\rm LQCD}=2N/g_0^2$ | $\beta_{\rm LQCD}=N\beta_W$ |
| $\beta_{tH}$ ('t Hooft; SZZ [56], CNS-dyn [58], Chatterjee large-N [44], Nissim [59]) | $N\beta_{tH}\sum_p \mathrm{Re}\,\mathrm{Tr}\,U_p$ | $\beta_W=N\beta_{tH}$, $\beta_{\rm LQCD}=N^2\beta_{tH}$ |
| $\beta_C$ (CNS-2025 [61]) | $2\beta_C\sum_p\mathrm{Re}\,\mathrm{Tr}\,U_p$ | $\beta_W=2\beta_C$ |

### 1.2 Observables and the target properties

- **Wilson loop.** $W_\ell=\chi_\pi(U_{e_1}\cdots U_{e_k})$ for a closed loop $\ell$ and a representation $\pi$ (usually the fundamental).
- **Static potential.** $V(R)=-\lim_{T\to\infty}T^{-1}\log\langle W_{\ell_{R,T}}\rangle$.
- **Wilson's confinement criterion.** $V(R)\to\infty$.
- **Area law.** $|\langle W_{\ell}\rangle|\le C_1e^{-C_2\,\mathrm{area}(\ell)}$ for rectangles ([88] Problem 4.1; [26] eq. (2.3)).
- **Perimeter law.** $\langle W_\ell\rangle \ge e^{-c|\ell|}$, which signals deconfinement.
- **Mass gap (lattice).** Exponential clustering of gauge-invariant local observables: $|\mathrm{Cov}(f,g)|\le C e^{-m\,\mathrm{dist}(f,g)}$. By reflection positivity this is equivalent to a spectral gap of the transfer matrix on the gauge-invariant sector [2,4].
- **Strong mass gap** (Chatterjee [26] Def. 2.3). *Terminology note (verifier):* Chatterjee's own name for this is "exponential decay of correlations under arbitrary boundary conditions". "Strong mass gap" is this note's shorthand. For every cube $B$, every boundary condition $\delta$ and all local $f,g$ with values in $[-1,1]$,
  $$|\langle fg\rangle_{B,\delta}-\langle f\rangle_{B,\delta}\langle g\rangle_{B,\delta}|\le K_1e^{-K_2\,\mathrm{dist}(f,g)},$$
  with constants depending only on $(G,\beta,d)$.

**Chatterjee's probabilistic formulation** ([88], Problems 5.1–5.2; this is the cleanest lattice-level statement of the Clay targets):

> **Problem 5.1 (lattice mass gap).** For compact non-abelian $G\subseteq U(N)$ and $d=4$, show that for every $\beta>0$ there is $\xi(\beta)\in(0,\infty)$ with
> $$\lim_{|x|\to\infty}\frac{\log f_\beta(x)}{|x|}=-\frac1{\xi(\beta)},\qquad f_\beta(x)=\mathrm{Cov}(W_{p_0},W_{p_x}),$$
> and moreover $\lim_{\beta\to\infty}\xi(\beta)=\infty$.
>
> **Problem 5.2 (continuum limit of rectangular loops).** Find $\epsilon(\beta)\to0$, $c(\beta)\to\infty$ and $d\neq0$ such that
> $$\log\langle W_{\gamma_{R/\epsilon,T/\epsilon}}\rangle=-c(R+T)-dRT+o(1).$$

Neither problem is solved in any regime that reaches $\beta\to\infty$. In 4D, Wilson's naive scaling has $\beta$ independent of the lattice spacing $\epsilon$. Physics expects $\beta\sim\log(1/\epsilon)$ [88].

### 1.3 Structural theorems valid at all $\beta$ (the "existence" scaffolding on the lattice)

- **Reflection positivity and transfer matrix** [T-pub]. The Wilson measure is OS-positive for reflections in lattice hyperplanes and, for gauge-invariant observables, in half-integer planes ([2] Thm 2.1; Glimm–Jaffe Thm 22.3.1; restated with proof sketch in Nissim [62], Lemma 3.15). Lüscher [4] built a self-adjoint, strictly positive transfer matrix. Hence for each fixed $\beta$ there is a lattice Hilbert space and Hamiltonian $H=-\log T\ge0$. The lattice mass gap is $\inf(\mathrm{spec}\,H\setminus\{0\})$ on gauge-invariant states.
- **Elitzur's theorem** [5] [T-pub]. Local gauge symmetry cannot break spontaneously, so non-gauge-invariant observables have zero expectation. The mass gap has to be phrased for gauge-invariant observables, e.g. plaquette–plaquette correlations.
- **Universal bounds on Wilson loops** [T-pub]:
  - Simon–Yaffe [7] prove $|\langle W_\gamma\rangle|\le e^{-c(\beta)|\gamma|}$ (decay at least like perimeter) for any gauge group; Garban–Sepúlveda [15], Cor. 7.2, describe it this way.
  - Seiler [6] proves the potential is at most linear, i.e. a reflection-positivity lower bound $\langle W\rangle\ge e^{-c\,\mathrm{area}}$ for rectangles (as cited in [44]).
  - Bachas [8] proves $V(R)$ is concave, so it is non-decreasing whenever bounded below ([62] §3.3).
- **Why the existence problem is not solved on the lattice.** All of the above are uniform in volume and hold at every finite $\beta$. They give a "lattice QFT" for each $\beta$. The Clay problem needs a limit $\beta\to\infty$ along the renormalization-group trajectory, with Schwinger functions converging to non-trivial OS-axiom-satisfying limits. Problem 5.2 is a lattice-observable version of that requirement.

### 1.4 Heuristic scale-setting [H]

Two-loop asymptotic freedom (perturbative, not proven) gives
$$a(g_0)\Lambda_L\simeq (b_0g_0^2)^{-b_1/(2b_0^2)}\,e^{-1/(2b_0g_0^2)},\qquad b_0=\frac{11N}{48\pi^2}.$$
With $\beta_{\rm LQCD}=2N/g_0^2$ this means $1/(2b_0g_0^2)=\frac{12\pi^2}{11N^2}\beta_{\rm LQCD}$, which is $\approx1.20\,\beta$ for SU(3) and $\approx2.69\,\beta$ for SU(2).

A continuum glueball mass $m_{\rm phys}>0$ therefore requires the lattice correlation length to grow like $\xi(\beta)=1/(m_{\rm phys}a)\propto\exp(\frac{12\pi^2}{11N^2}\beta_{\rm LQCD})$. Seiler and Patrascioiu dissent from the standard AF picture [79]; this is a minority view [H].

---

## 2. Detailed findings

### 2.1 Wilson (1974) [1] [T-pub for the definitions; H for confinement]

Wilson introduced the lattice action above, with exact lattice gauge invariance, and Wilson loops as order parameters. He argued that $\langle W\rangle\sim e^{-V(R)T}$ and that strong coupling gives an area law, the strong-coupling confinement mechanism. These arguments became theorems via Osterwalder–Seiler [2]. The naive classical continuum limit $\beta_W\propto\epsilon^{4-d}$ is formal; Chatterjee [63, §3] and [88, §3] carry out the Baker–Campbell–Hausdorff computation.

### 2.2 Osterwalder–Seiler (1978) [2] and Seiler's LNP 159 (1982) [3]

Content as reported by [26,44,56,59,62,88]; the primary text is paywalled.

- **Reflection positivity** of the Wilson action and a positive transfer matrix. This holds at all $\beta$, including with Higgs fields and Wilson fermions in their setting [T-pub].
- **Convergent cluster (high-temperature/character) expansion** at sufficiently small $\beta$, uniformly in volume. This gives:
  - the infinite-volume limit;
  - analyticity of Schwinger functions in $\beta$;
  - **exponential clustering, i.e. a mass gap, for any compact $G$** [T-pub].

  SZZ [56] note the proof is a sketch following Glimm–Jaffe–Spencer, made simpler by bounded fields. Uniqueness of the infinite-volume state should also follow [56].
- **Area law** at small $\beta$ for groups with nontrivial centre, for planar rectangular loops ([61] cites "[OS78, Theorem 5.1]"); Seiler extended it to general loops [44]. Fröhlich's comparison method [16] reproduces this in general $d$ [61].
- **Size of the window.** Tracking the constants for SU(N)/SO(N)/U(N), the OS condition becomes $\beta_{tH}<c_d/N^2$, i.e. $\beta_W< c_d/N$ (Nissim [59], Introduction; CNS [61], Fig. 1). The window **shrinks** as $N$ grows.
- **Higgs models.** OS also proved exponential decay in the "complete breakdown of symmetry" regime when the Higgs length is large relative to $\beta$. This is the classical input that Chatterjee–Yakir [67] extend.
- **Seiler's monograph** [3] (Springer LNP 159, 1982; Crossref lists the chapters "Lattice gauge theories", pp. 3–98, and "Continuum gauge quantum field theories", pp. 99–181). It is the standard reference for:
  - the expansions above;
  - confinement criteria;
  - Seiler's proposal ([88] cites Ch. 8) to formulate the continuum theory as a random field on loops, with Wilson-loop expectations as the basic objects.

  **[G] Caveats from later literature:**
  - The monograph's claim that the finite-abelian cluster expansions extend "without difficulty" to finite non-abelian groups is false, per Borgs [35, §7] as cited by Adhikari–Cao [32], footnote 1.
  - Its argument (with Glimm–Jaffe 1979 [25]) that trivial-centre groups have a perimeter-law **lower** bound at strong coupling has non-trivial gaps: the "tube" clusters do not dominate uniformly in loop size (Nissim [62], Remark 1.3 and §4).

Rigorous **strong-coupling particle spectrum** results [T-pub, content not checked by me]: Schor [85] on glueball spectroscopy; Faria da Veiga–O'Carroll–Schor [84] on baryons in strong-coupling lattice QCD. A recent preprint by Faria da Veiga and O'Carroll [83], without Schor, decomposes the Hilbert space by charge conjugation for SU(N) with $N\neq2$. It predicts, without proving, two distinct glueball gaps at small $\beta$.

### 2.3 Abelian theories: the decisive counterexamples and the only weak-coupling continuum limits

- **Guth (1980) [9] and Fröhlich–Spencer (1982) [10] — 4D U(1)** [T-pub]. At large $\beta$ the theory has a **perimeter law** $|\langle W_\gamma\rangle|\ge e^{-c(\beta)|\gamma|}$ (Garban–Sepúlveda [15], Thm 1.2, for the Villain action) and a massless phase (photon). At small $\beta$ the area law holds [2]. So there is a confinement–deconfinement transition, and an area law at small $\beta$ is **not** evidence of continuum confinement [88]. Chatterjee [88] calls Guth's argument an RG-based existence proof and FS82 the fully rigorous version. Per [15], FS82 states the infinite-volume limit for both Wilson and Villain interactions.

  Garban–Sepúlveda [15] (2021, [T-pre]) sharpen the Villain spin-wave estimate. Their bound is
  $$|\langle W_\gamma\rangle|\le \exp\!\Big(-\frac{C_{GFF}}{2\beta}(1+C\beta e^{-2\pi^2\beta})(|\gamma|+o(|\gamma|))\Big),$$
  and they improve the free-energy correction to match Guth's $e^{-\pi^2\beta}$ prediction.
- **Glimm–Jaffe (1977) [11] — 3D U(1)** [T-pub]. Quark trapping with a logarithmic potential at all $\beta$, via a McBryan–Spencer/Mermin–Wagner-type argument. It is reproduced for Villain in [15], Cor. 7.3: $|\langle W_\gamma\rangle|\le e^{-\frac{C}{2\beta}L\log H}$.
- **Göpfert–Mack (1982) [12] — 3D U(1), Villain action** [T-pub]. **Positive string tension (area law) for all $\beta$**, via Polyakov's monopole (Coulomb-gas) mechanism. It is the only **area-law** (positive string tension) theorem at all couplings for a continuous gauge group in $d\ge3$. *(Verifier correction: the original said "only confinement-at-all-couplings theorem". Logarithmic confinement at all $\beta$ is also proven in 3D for U(1) [11] and for groups containing a central U(1) [16,17]; see the next bullets.)* Physics predicts the string tension is exponentially small in $\beta$ [H]; I have not checked the form of the GM bound in the primary text.
- **Central U(1) in 3D.** For $G\subseteq U(n)$ containing all scalars $zI$, Fröhlich's comparison inequality [16] plus Glimm–Jaffe [11] gives log-confinement in 3D (Fröhlich [16], Cor. 2, per [17]). Chatterjee 2026 [17] gives a self-contained proof [T-pre]:
  $$|\langle W_\ell\rangle|\le n\exp\{-C(1+n\beta)^{-1}T\log(R+1)\}.$$
  **Discrepancy to note.** CNS [61], Introduction, state that GM82 plus Fröhlich [16] gives an area law for 3D U(N) at all $\beta$. Chatterjee [17] says such a combination would need extra work because of formulation and limit issues (Villain vs Wilson, among others), and does not pursue it. **Treat "3D U(N) area law at all β" as not carefully written down** [G/H].
- **Continuum limits.** Gross [13] (3D U(1)) and Driver [14] (4D U(1)) prove convergence to the free electromagnetic field [T-pub]. In 4D this is a Gaussian (trivial) limit with an effective coupling renormalization. Wilson-loop observables are too singular to survive the limit [15].

### 2.4 Confinement criteria, comparison inequalities and conditional theorems

- **Fröhlich (1979) [16]** [T-pub]. A Ginibre/Messager–Miracle-Solé–Pfister comparison: confinement in the $\mathbb Z_n$ (or U(1)) theory implies confinement in the SU(n)/U(n) theory with Higgs.
- **Mack–Petkova (1979, 1980) [18,19]; 't Hooft (1979) [20]; Yaffe (1980) [21].**
  - Mack–Petkova compare $\mathbb Z_2$ and SU(2), and give a vortex-condensation sufficient condition for confinement.
  - 't Hooft and Yaffe introduce the centre-vortex free energy (the 't Hooft loop) as an order parameter.
  - Borgs–Seiler [23] prove that 't Hooft's string tension is at most Wilson's (per Ito–Seiler [76], Remark 2.2(3)) [T-pub].
  - These vortex free-energy ratios are what Tomboulis targets (§2.11).
- **Durhuus–Fröhlich (1980) [22]** [T-pub]. Condition on the edges in two adjacent horizontal hyperplanes. The vertical edges of the height-1 slab then form a $(d-1)$-dimensional nonlinear σ-model with boundary fields $A,B$:
  $$S_{A,B}(Q)=N\beta\sum_{(x,y)}\mathrm{Re}\,\mathrm{Tr}(Q_xA_eQ_y^{-1}B_e^{-1}).$$
  **Theorem (DF80 Thms 1.2–1.3, as restated in [58] Thm 2.3).** Assume $G$ contains $zI$ with $z\neq1$. If the matrix-entry two-point functions of this σ-model decay exponentially, **uniformly in $A,B$**, then the $d$-dimensional lattice Yang–Mills theory satisfies the area law.

  The mechanism: the centre forces $E_{A,B}[(Q_x)_{ij}]=0$. A $T\times R$ Wilson loop then factorizes into $T$ two-point functions at distance $R$, which gives $e^{-cRT}$ up to a perimeter factor.
- **Borgs–Seiler (1983) [23,24]** [T-pub]. Lattice Yang–Mills at nonzero temperature, i.e. on cylinders. They give a rigorous proof of quark *deconfinement* at high temperature and study long-range order in Polyakov loops.
- **Chatterjee (2021) [26]: a probabilistic mechanism for quark confinement** [T-pub, CMP 385].
  - *Definition.* The theory has **unbroken centre symmetry** if, for some slab thickness $N$ and every boundary condition, every slab Gibbs measure is invariant under multiplying the first layer of vertical edges by a centre element.
  - *Theorem 2.2.* Unbroken centre symmetry implies confinement in Wilson's sense, $|\langle W_\ell\rangle|\le e^{-V(R)T}$ with $V(R)\to\infty$, for any irreducible representation that is nontrivial on the centre.
  - *Theorem 2.4.* The **strong mass gap** (Def. 2.3) implies unbroken centre symmetry **and the area law**.
  - Remark: the strong mass gap can be shown at small $\beta$ via Dobrushin–Shlosman [27].
  - Remark: finite-group theories are gapped in a weaker (fixed boundary condition) sense yet deconfining, so in them centre symmetry must break. Borgs [35] shows multiple Gibbs states.

  This is a clean **conditional reduction of confinement to a (strong) mass gap** for groups with nontrivial centre, at all $\beta$.

### 2.5 Finite gauge groups at weak coupling (the first 4D weak-coupling computations)

- **Chatterjee (2020), Ising LGT [28]** [T-pub, CMP 377]. For 4D $\mathbb Z_2$ with action $\beta\sum_p\sigma_p$ there is a universal $\beta_0$ such that, for $\beta\ge\beta_0$ and any generalized loop with $\ell$ edges, $\ell_0$ of them corner edges,
  $$\Big|\langle W_\gamma\rangle_\beta-e^{-2\ell e^{-12\beta}}\Big|\le C_1\Big(e^{-2\beta}+\sqrt{\ell_0/\ell}\Big)^{C_2}.$$
  - Non-trivial behaviour happens exactly at $\ell\asymp e^{12\beta}$. The mechanism is a Poisson count of minimal vortices (six negative plaquettes around an edge).
  - Wilson loops are non-negative (Thm 4.2, via duality).
  - The infinite-volume limit exists and correlations decay exponentially at large $\beta$ (§5).

  This is a **perimeter law**, i.e. deconfinement.
- **Cao (2020) [29]** [T-pub, CMP 380] extends this to finite, possibly non-abelian, groups using Poisson approximation by Stein's method. **Forsström–Lenells–Viklund [30]** do finite abelian $\mathbb Z_n$ without duality or cluster expansion. **Forsström [31]** gives correlation decay for finite abelian groups. **Forsström–Viklund [33]** compute the free energy and the quark potential $V_\beta(R)$ in powers of $e^{-\beta}$ for $\mathbb Z_2$ LGT on $\mathbb Z^m$, $m\ge3$ (here $m$ is the lattice dimension), which yields a strong perimeter law. **Forsström–Viklund [34]** give random currents and a switching lemma for Ising LGT: Wilson loops are non-negative and increasing in $\beta$, with area law at small $\beta$ and exponential decay at small and large $\beta$.
- **Adhikari–Cao (2022/24) [32]** [T-pre; submitted to Ann. Probab.]. Let $G$ be finite, $d=4$, and $\Delta_G=\min_{g\neq1}\mathrm{Re}(\chi(1)-\chi(g))$. **If $\beta\ge(114+4\log|G|)/\Delta_G$**, then for conjugation-invariant functions $f_1,f_2$ of Wilson loops in boxes $B_1,B_2$ at $\ell^\infty$ distance $L$:
  $$|\mathrm{Cov}|\le 4(4\cdot10^{24}|G|^2)^{|B_1|+|B_2|}\|f_1\|_\infty\|f_2\|_\infty e^{-(\beta/2)\Delta_G(L-1)}.$$
  This is a **weak-coupling mass gap for non-abelian finite groups**.
  - The proof is a "swapping map" coupling of two independent copies.
  - The key difficulty is that non-abelian defects interact topologically: linked loops do not factorize, and Borromean-type multi-body interactions block a standard cluster expansion.
  - They say they could not reconstruct the cluster expansion claimed by Szlachányi–Vecsernyés [36] [G].
- **Random-surface / percolation picture.** Aizenman–Chayes–Chayes–Fröhlich–Russo [37] studied a random-surface model with a sharp area-to-perimeter transition. Duncan–Schweinhart [38] (2022) proved the exact identity "Wilson loop = probability the cycle is null-homologous in the plaquette random-cluster model" for Potts LGT, justifying an ACCFR claim, plus a sharp homological percolation transition at the self-dual point. Their 2026 paper [39] relates correlations to topology and proves exponential decay for slowly growing loops in 3D Ising LGT at all non-critical temperatures [T-pre].
- **Higgs analogues** [T-pre/pub]: Forsström–Lenells–Viklund [40,41], Adhikari [42], Forsström [43] (pure perimeter laws in the Higgs and confinement phases), Forsström [99] (Marcu–Fredenhagen ratio). Kennedy–King [96] and Fredenhagen–Marcu [97] give classical order parameters; the phase diagram is Fradkin–Shenker [98].

**Why this does not transfer to SU(N).** All these proofs rest on *discrete* defects: plaquettes with $U_p\neq1$ cost at least $\beta\Delta_G$. At large $\beta$ they become a dilute gas. For continuous groups the leading fluctuations are Gaussian "spin waves" with no energy gap. The U(1) case shows this produces massless behaviour unless something non-perturbative intervenes [10,15].

### 2.6 Large-N, gauge–string duality and master loop equations (strong coupling)

- **Chatterjee (2015/2019) [44]** [T-pub, CMP 366]. SO(N) with 't Hooft action $N\beta\sum\mathrm{Tr}\,Q_p$. There is $\beta_0(d)$ such that for $|\beta|\le\beta_0(d)$, along any increasing sequence of finite volumes $\Lambda_N\uparrow\mathbb Z^d$,
  $$\lim_N N^{-n}\langle W_{l_1}\cdots W_{l_n}\rangle=\sum_{X}w_\beta(X),$$
  an absolutely convergent sum over vanishing trajectories of a lattice string theory (Thm 3.1). Corollaries:
  - factorization;
  - an **area-law upper bound in the large-N limit**, $\lim_N|\langle W_l\rangle|/N\le(C(d)|\beta|)^{\mathrm{area}(l)}$ (Cor. 3.3);
  - analyticity.

  The engine is a finite-N master loop (Makeenko–Migdal / Schwinger–Dyson) equation (Thm 3.6), proved by Stein's exchangeable pairs. Uniqueness of solutions comes from a contraction argument.
- **Chatterjee–Jafarov [45]**: rigorous $1/N$ expansion for SO(N), with genus-$g$ surfaces at order $N^{-2g}$. **Jafarov [46]**: the SU(N) analogue, where in the large-N limit SU(N) at $2\beta$ matches SO(N) at $\beta$. **Basu–Ganguly [47]** (CPAM 2018): planar combinatorics via free probability and non-crossing partitions. They also construct an example showing **the area-law *lower* bound fails in general** in every dimension [T-pub].
- **New derivations of the master loop equation.** Shen–Smith–Zhu [48] use Langevin dynamics and Itô's formula for SO/U/SU(N). Abdelghani–Nissim [49] use integration by parts on $G$ and show the approaches are equivalent. Shen–Smith–Zhu [50] (2025) extend to Yang–Mills–Higgs, which requires open Wilson lines.
- **Surface sums.** Cao–Park–Sheffield [51] write Wilson-loop expectations as sums over embedded planar (or higher-genus) maps with Weingarten-function edge weights, **for every $N\ge1$, $\beta>0$, $d\ge2$**. This is an exact identity, not a convergence statement. Borga–Cao–Shogren-Knaak [52,53] give large-N surface sums with signed-Catalan weights via a peeling exploration. Park–Pfeffer–Sheffield–Yu [54] do the continuum 2D case. Lemoine [55] (2026, [T-pre]) gives an action-agnostic finite-N state-sum/spin-foam framework for U(N) with arbitrary smooth central plaquette actions; a companion claims a heat-kernel master field at strong coupling with an area law (not checked).

### 2.7 Stochastic analysis: the Bakry–Émery / log-Sobolev route (strong coupling, 't Hooft regime)

- **Shen–Zhu–Zhu (2022; CMP 400 (2023) 805) [56]** [T-pub]. 't Hooft action $S=N\beta\,\mathrm{Re}\sum_p\mathrm{Tr}\,Q_p$, all $d\ge2$.
  - *Assumption.* $K_S=\frac{N+2}{2}-1-8N|\beta|(d-1)>0$ for SU(N), i.e. **$|\beta_{tH}|<\frac1{16(d-1)}$**. For SO(N): $\frac{N+2}{4}-1-8N|\beta|(d-1)>0$, i.e. $|\beta_{tH}|<\frac1{32(d-1)}-\frac1{16N(d-1)}$.
  - *Results:*
    1. The Langevin SDE on $G^{E(\mathbb Z^d)}$ has a **unique** invariant measure and is exponentially ergodic in Wasserstein distance. Finite-volume measures with any boundary condition converge to it (Thm 1.2), so the infinite-volume Gibbs state is unique.
    2. The log-Sobolev inequality $\mu(F^2\log F^2)\le\frac{2}{K_S}\sum_e\mu(|\nabla_eF|^2)$ and the Poincaré inequality hold (Thm 1.4).
    3. Large-N concentration and factorization: $\mathrm{Var}(W_\ell/N)\le 4n(n-3)/(K_SN)$ for SU(N) (Cor. 1.5).
    4. **Mass gap** $\mathrm{Cov}(f,g)\le c_1 d(\mathfrak g)e^{-c_N d(\Lambda_f,\Lambda_g)}(\cdots)$ (Cor. 1.6). The rate $c_N$ may decay with N; the authors say this is not necessarily optimal.
  - *Mechanism.* Bakry–Émery $\mathrm{Ric}-\mathrm{Hess}\,S\ge K_S$. The Ricci curvature of SU(N) is $\frac{N+2}{2}-1$, of order N. The key lemma (Lemma 4.1) bounds the Hessian of the action by $8(d-1)N|\beta|$, not the naive $O(N^2)$. Decay of correlations follows Guionnet–Zegarlinski.
- **SZZ (2024) [57]**: Yang–Mills–Higgs with small $(\beta,\kappa)$ (compact Higgs) or small $(\beta,\kappa/m)$ (unbounded Higgs). Mass gap and large-N factorization [T-pre].
- **Cao–Nissim–Sheffield, "Dynamical approach to area law" (2025) [58]** [T-pre]. They apply Bakry–Émery to the DF80 slab σ-model on *vertices*, which improves the Hessian bound to $4(d-1)N\beta$. They verify the DF80 uniform σ-model mass gap and so obtain the **area law** (Thm 1.6) for:
  - $G=U(N),SU(N)$ with $\beta_{tH}<\frac1{8(d-1)}$;
  - even-dimensional special orthogonal groups, with $\beta_{tH}<\beta^*_{SO(N)}=\frac1{16(d-1)}-\frac1{8N(d-1)}$, where $N$ is the **matrix size** (Def. 1.4 of [58]). *Verifier note:* v2's Theorem 1.6 writes the group as "SO(2(N−1))", while Remark 1.7 and the abstract say SO(2N). The intended content is "SO(N) with N even", since a nontrivial centre is needed. Use Def. 1.4 with the actual matrix size.
  - Constants $C,c$ depend on $(\beta,d,N)$; the estimates are on the torus $\Lambda_L$, uniform in $L$, for rectangles of side $\le L/2$. [58] notes that the SZZ threshold is exactly half of theirs.

  U(N) is reduced to SU(N) by writing $U(N)\simeq U(1)\times SU(N)$ in the Haar sense and conditioning. The centre is essential, so SO(odd) is excluded.
- **Nissim (2025) [59]** [T-pre]. U(N) in the 't Hooft regime, $\beta_{tH}<\tilde\beta(d)$ (with $\beta^*=10^{-6d}$): mass gap, unique infinite-volume limit, large-N limit. The difficulty is that the Ricci curvature of U(N) is not uniformly positive. The fix is a random-environment SU(N) model driven by a U(1) field, analysed by a cluster expansion (conditional gap), then Langevin dynamics for the SU(N) marginal.
- **Piazza–Shen (Oct 2026) [60]** [T-pre]. The log-Sobolev inequality for **2D** SU(N) Wilson lattice Yang–Mills at **every fixed $\beta$**, uniformly in volume, via a two-scale disintegration. This is apparently the first all-coupling functional inequality for a non-abelian lattice gauge theory. The priority claim is this note's characterization, not the abstract's. It holds only in 2D, where the model is essentially solvable. The LSI constant depends on $\beta$ and $N$.
- **Continuum-dynamics neighbours** (other workstreams): Chevyrev–Qu–Shen [100], scaling limit of 3D U(1) lattice Langevin dynamics under weak-coupling scaling; Bringmann–Cao–Hairer–Zhao [101], 2D non-abelian Yang–Mills–Higgs measure via stochastic quantization.

### 2.8 Area law beyond Osterwalder–Seiler via master-loop contraction

- **Cao–Nissim–Sheffield, "Expanded regimes of area law" (2025) [61]** [T-pre]. For U(N) with action $2\beta_C\mathrm{Re}\,\mathrm{Tr}\,U_p$: **for all $d\ge2$ there is $\beta_0(d)>0$ such that for all $\beta_C\le\beta_0(d)$ and all $N\ge1$**,
  $$|\langle W_\ell\rangle|\le C_{1,d}C_N^{|\ell|}e^{-C_{2,d}\,\mathrm{area}(\ell)}$$
  (Thm 1.2 in arXiv v3; the original said Thm 1.1, which may be the v1 numbering). The threshold does not decay with N, whereas OS needs $\beta_C\lesssim c/N$. For bounded N the result falls back on [OS78, Thm 5.1]. Quantitatively (Thm 4.1), for large N
  $$|\langle W_\ell\rangle|\le 2|\ell|N^{|\ell|/4-1}\alpha^{\mathrm{area}(\ell)},\qquad \alpha=2\cdot10^{3d}\max(10^3d\beta,\ e^{-10^{-7}d^{-2}N}).$$
  - *Method.* The master loop equation is a linear inhomogeneous system $f^*=Gf^*+g$; prove $\|G\|\le1/2$ in a weighted norm that encodes area decay.
  - The obstruction is the $N^{-2}$ "merger" term. They handle it with a **truncated model** (at most $B$ copies of each plaquette, $N\beta\ll B\ll N$) and a "revival" operation that rescues explorations stuck in bad plaquettes.
  - OS78 corresponds to truncation level 0.

  Their Remark 1.4 ("Future directions"; Remark 1.7 in v3 is about the bootstrap) lists the obvious next step: reach $\beta_C\sim c_dN$, the full 't Hooft regime, which needs cancellations between signed surface weights. **The dynamical paper [58] reached the 't Hooft regime by a different route about 3.5 months later** (arXiv dates 22 May 2025 and 4 Sep 2025). In the $\beta_{tH}$ normalization, [61] covers $\beta_{tH}\lesssim 2\beta_0(d)/N$ and [58] covers $\beta_{tH}<1/(8(d-1))$. So [58] supersedes [61] for the *range of β* at large N. *Verifier nuance:* [61] v3, Remarks 1.1 and 1.3(4), states that its string-tension constant is better than [58]'s and that [58]'s constants depend poorly on N. So [61] is not superseded quantitatively. The master-loop technology of [61] is still the most "algebraic" route and plausibly the easiest to formalize.

### 2.9 Trivial centre: deconfinement is now a theorem at strong coupling

- **Nissim (May 2026) [62]** [T-pre]. For SO(3) and any $d\ge3$ there is $\beta^*(d)>0$ such that **for almost every $\beta\in(0,\beta^*)$, $\sup_RV(R)<\infty$**: the potential is bounded, Wilson's criterion fails, and the gluons screen the charge.
  - *Proof:*
    1. Exact identification of the leading cluster-expansion "tube" terms; the first nonzero order is $4|\ell|-16$ plaquettes, with a positive lower bound $(1/9)^{|\ell|}$.
    2. A complex-analysis lemma (Jensen, Harnack, Cartan) that lower-bounds an analytic function off a small exceptional set. This is the source of "almost every".
    3. Reflection-positivity concavity of $V$ [8].
  - Remark 1.3 documents the gap in the classical Glimm–Jaffe/Seiler argument [G].
  - Remark 1.5 stresses that extending this to weak coupling is out of reach.

### 2.10 Weak-coupling results for continuous non-abelian groups (the thin list)

- **Leading term of the free energy** [T-pub]. Chatterjee (JFA 2016) [63], Thm 2.1: for U(N) on $B_n$, as $n\to\infty$ and $g_0\to0$ jointly,
  $$F(B_n,g_0)-\tfrac12\big(d-1-\tfrac dn+\tfrac1{n^d}\big)N^2\log g_0^2\to(d-1)\log\frac{\prod_{j=1}^{N-1}j!}{(2\pi)^{N/2}}+N^2K_d,$$
  where $K_d$ is an axial-gauge Maxwell constant.
  - In 3D this gives the leading continuum free energy (Thm 2.2).
  - **In 4D it is only valid as $g\to0$ jointly** (Thm 2.3). It avoids phase-cell renormalization by using Gaussian behaviour at small scales and axial gauge.
  - Brennecke 2025 [64] [T-pre] computes $K_d$ explicitly.
  - This shows the theory is Gaussian at leading order at weak coupling. It says **nothing** about mass gap or asymptotic freedom.
- **Higgs-mechanism scaling limits** [T-pub/pre].
  - Chatterjee [65] (PMP 7 (2026)) treats SU(2) Yang–Mills–Higgs in any $d\ge2$, unitary gauge, with $\alpha g=c\epsilon$ and $g=O(\epsilon^{50d})$. A stereographic projection of the gauge field converges to a **massive Gaussian** field. The paper calls this the first construction of a scaling limit of a non-abelian LGT in $d>2$, and the first rigorous proof of Higgs mass generation *in such a theory*. The limit is free (Gaussian), and the paper says a non-Gaussian limit remains open. *(Verifier: the original said "first rigorous Higgs mass generation" without qualification, which overstates it given BBIJ [68] in the abelian case.)*
  - Rajasekaran–Yakir–Zhou [66] (2026) extend it to any compact connected $G$.
  - Chatterjee–Yakir [67] prove exponential decay for U(1) Higgs with $\alpha=m\beta$, any $m>0$, $\beta$ large, via the Glimm–Jaffe–Spencer expansion about a massive Gaussian. This extends OS78 and confirms part of the Fradkin–Shenker diagram [98].
  - Classical precursors: Balaban–Brydges–Imbrie–Jaffe [68], the mass gap for abelian Higgs on a unit lattice at weak coupling; Goswami [69].

  **Lesson:** in all these, the mass at weak coupling comes from the Higgs field, i.e. explicit symmetry breaking, not from non-abelian dynamics.
- **Balaban's renormalization group** [T-pub]. Ultraviolet stability of 3D and 4D lattice Yang–Mills on a finite torus along the asymptotic-freedom trajectory [70–72]; Dimock's exposition [73]. Magnen–Rivasseau–Sénéor [74] give a continuum construction with an infrared cutoff. No infinite-volume limit, no gauge-invariant observables in the limit, no gap. Covered by another workstream; listed here because it is the only rigorous weak-coupling control of continuous non-abelian LGT. **OpenAI's claimed 4D Yang–Mills existence proof reportedly builds on Balaban's approach** ([92]; press report, unverified). *Verifier detail from [92], fetched 2026-11-05:*
  - Announced 26 Oct 2026. The natural-language proof is dated 9 Sep 2026, a QCD extension 18 Sep 2026, and the Lean formalization of the existence part 16 Oct 2026. All dates are company-reported.
  - The claim is **existence only**; [92] does not mention a mass gap.
  - A physics group led by D. Gross (with Douglas, Jaffe, Klebanov, Nekrasov) is to write up the result. The AI artifacts had not been released, and [92] does not say anyone has verified the proof.

### 2.11 Disputed, gapped and unverified claims

- **Tomboulis (2007) [75] [D].** He claims confinement, a positive vortex free-energy order parameter and hence an area law, for 4D SU(2) at all $0<g<\infty$, with $g(a)\to0$ as $a\to0$ at fixed string tension. The method is Migdal–Kadanoff-type decimations that give upper and lower bounds, plus interpolation parameters $(\alpha,t)$ chosen to make each step exact.
  - **Ito–Seiler [76]**: the needed equality $\alpha(t^*)=\alpha_+(t^*)$ reduces to an inequality $A(\alpha)>A_+(\alpha)$ between derivatives of the free energies with and without flux. That inequality is easy only where the high-temperature expansion converges and is not proved at large $\beta$. A sanity check: the structure cannot distinguish U(1), which **does** deconfine in 4D [10], from SU(2) unless the convergence *rate* of the MK recursion is exploited.
  - **Tomboulis's reply [77]**: the inequality is used only at strong coupling.
  - **Ito–Seiler's rejoinder [78]** (2008): the gaps stand, and they say what would be needed.
  - A PoS follow-up by Seiler exists [104]: *Critical discussion of Tomboulis' approach to the confinement problem*, PoS(Confinement8)034. The conference was ConfinementVIII (2008); the PoS page is dated 12 Sep 2012. Existence verified; content not read.
  - **Status: not accepted; 4D SU(2) confinement at weak coupling remains open.**
- **Faizal–Shabir (2026) [80] [C].** Published in Fortschritte der Physik. It claims a complete construction of 4D SU(N) Yang–Mills from a reflection-positive lattice: transfer-operator gap, area law via polymer expansions, a multiscale analysis carrying them to the continuum, OS reconstruction, universality, and matching to the asymptotically free trajectory. The abstract reads as an outline. It contradicts the consensus that even lattice large-$\beta$ clustering is open, and I found no expert endorsement. Do not rely on it.
- **Nair (2026) [81] [H].** "Outlines of a proof" of a 3D mass gap via an eigenvalue inequality for the Laplacian on the gauge-invariant configuration space. This is a programme from a serious physicist, not a proof.
- **Seiler, "The case against asymptotic freedom" [79] [H, minority dissent].** It questions whether the non-abelian continuum limit has the standard asymptotically free form. Chatterjee [26] mentions "some dissent"; Ito–Seiler [76] cite this line of work.
- **Zhou–Reed–Hayes (2026) [82].** A survey of unknown provenance. Not used as a source.
- **Tlas (2026) [93] [T-pre, minor].** The pushforward of Haar measure by the Wilson action is approximately Gaussian, and the strong-coupling expansion is sketched from this.
- **"Adhikari–Suzuki–Zhou–Zhuang"** (named in the task). **Not found** in arXiv author searches or a web search; listed as unverified [102].

### 2.12 Computer-assisted / bootstrap bounds [H→T if certified]

Kazakov–Zheng [86,87] combine lattice Makeenko–Migdal loop equations, truncated at a maximal loop length, with positivity of Wilson-loop Gram matrices (reflection positivity). This gives **two-sided bounds on the plaquette expectation** for SU(∞) [86] and for finite N [87], plus string-tension estimates. The finite-N paper treats SU(2) with loops up to length 24. The "within 0.1% of Monte Carlo in the physically relevant range (3D and 4D)" figure is stated for that SU(2) work [87], not for SU(∞).

These are semidefinite-programming outputs. With exact or interval arithmetic and certified dual solutions, they become **rigorous computer-assisted inequalities at fixed $\beta$**, including in the physical weak-coupling window. That is the one existing technology that produces rigorous numbers at $\beta_{\rm LQCD}\approx6$. They are finite-$\beta$ statements, not uniform in $\beta$.

### 2.13 Lean formalizations of lattice gauge theory (existing)

- **`mrdouglasny/lgt` [90]** (Lean 4, Mathlib pinned at v4.29.0; Reservoir shows activity in Sept 2026).
  - Contents: U(n) Wilson LGT on $(\mathbb Z/N\mathbb Z)^d$ ($d\ge2$, $N\ge3$); plaquette action with gauge invariance; product Haar measure; Yang–Mills probability measure via `withDensity`; Gibbs specification and DLR identity; Dobrushin-condition verification.
  - Theorems `ym_mass_gap_exponential_decay` and `ym_mass_gap_rate_exists`: for $\beta_W<1/(32n(d-1))$, the connected plaquette–plaquette correlator decays like $\alpha^{(\mathrm{dist}-1)/2}$ with $\alpha<1$, with rate $m=-\tfrac12\log\alpha$.
  - The README reports zero `sorry`s and zero project axioms, with only `propext`, `Classical.choice` and `Quot.sound` in the axiom check. 2D Doeblin and RG "bridge" files are partial.
  - *Verifier additions (README re-fetched 2026-11-05):*
    - The authors are Michael R. Douglas (CMSA, Harvard) with Fred Rajasekaran.
    - The README reports a Lean FRO `comparator` check of both headline theorems at commit `ec975bd`: a kernel replay under the axiom whitelist. It ran on macOS with the official insecure `fake-landrun` shim, so the sandbox guarantee did not hold.
    - The Wilson action is $S=\beta\sum_p(n-\mathrm{Re\,Tr}\,U_p)$, i.e. the $\beta_W$ normalization.
    - The headline theorems need the Dobrushin machinery from the sibling repo `mrdouglasny/markov-semigroups`.
    - Reservoir lists the package as last updated 6 Sep 2026. It reports build failures on toolchains v4.33.0 through v4.36.0-rc1; the README pins v4.29.0.
  - The blueprint is cited in the README text as "Chatterjee 2026, Ch. 16". The README's reference list identifies it as **S. Chatterjee, *Gauge Theory Lecture Notes* (2026), Ch. 15–16**. I could not find a public copy, so it remains unverified [103].
- **Novickis (Zenodo 2026) [91]**: a self-reported Lean 4/Mathlib proof of a strong-coupling U(1) mass gap via a polymer expansion and transfer-matrix contraction (gap $\log(2/\beta)$). The author is an independent researcher. The record page shows v3 (4 Jun 2026) and notes a newer version exists. Not inspected.
- **Douglas–Hoback–Mei–Nissim [89]**: Lean 4 formalization of the 4D free scalar field satisfying the Glimm–Jaffe (OS-variant) axioms; later releases remove the assumed Minlos, nuclearity and Goursat results. This is the template for the OS-axiom layer.
- **Mathlib status** (checked in `Mathlib/LinearAlgebra/UnitaryGroup.lean`): it has `Matrix.unitaryGroup`, `Matrix.specialUnitaryGroup` and `Matrix.specialOrthogonalGroup` as algebraic objects. That file has no topology or compactness instances. A verifier grep of the vendored Mathlib (`lean/YangMills/.lake/packages/mathlib`) also found no `CompactSpace` instance for `unitaryGroup` anywhere. Haar measure exists in general measure theory. The Lie-group Riemannian geometry needed for Bakry–Émery (Ricci curvature of SU(N), Brownian motion on $G$, SDEs on manifolds) is essentially absent.

---

## 3. What is proven vs open

Normalizations follow §1.1. "Gap" means exponential clustering of gauge-invariant local observables.

| # | Statement | Group(s), d | Regime | Status | Source |
|---|---|---|---|---|---|
| 1 | Reflection positivity, positive transfer matrix | any compact $G$, any $d$ | all $\beta$ | T-pub | [2,4] |
| 2 | Elitzur (no local gauge symmetry breaking) | any | all $\beta$ | T-pub | [5] |
| 3 | Perimeter-law *upper* bound $\lvert\langle W\rangle\rvert\le e^{-c\lvert\gamma\rvert}$ | any | all $\beta$ | T-pub | [7] (via [15]) |
| 4 | Linear upper bound on $V(R)$; concavity of $V$ | any | all $\beta$ | T-pub | [6,8] |
| 5 | Convergent cluster expansion, gap, infinite-volume limit, analyticity | any compact $G$ | $\beta_W\le c(G,d)$; for SU/SO/U(N) $\beta_W\lesssim c_d/N$ | T-pub | [2,3,59] |
| 6 | Area law (centre nontrivial) | SU(N), U(N), … | $\beta_W\le c(G,d)$ | T-pub | [2,3] |
| 7 | Strong mass gap (all boundary conditions) | any | small $\beta$ (Dobrushin–Shlosman) | T (stated as known in [26]) | [26,27] |
| 8 | Unique infinite-volume state, LSI, gap, large-N factorization | SU(N), SO(N), $d\ge2$ | $\beta_{tH}<1/(16(d-1))$ (SU); $<\frac1{32(d-1)}-\frac1{16N(d-1)}$ (SO) | T-pub | [56] |
| 9 | Same (gap, unique limit, large N) | U(N) | $\beta_{tH}<\tilde\beta(d)$ | T-pre | [59] |
| 10 | Area law | U(N), SU(N); SO(even) | $\beta_{tH}<1/(8(d-1))$; SO($N$), $N$ even: $<\frac1{16(d-1)}-\frac1{8N(d-1)}$ ($N$ = matrix size) | T-pre | [58] (+DF80 [22]) |
| 11 | Area law uniform in N | U(N) | $\beta_C\le\beta_0(d)$ | T-pre (β-range superseded for large N by #10; better string-tension constant than #10) | [61] |
| 12 | Large-N Wilson loops = string trajectory sums; large-N area upper bound | SO(N), SU(N) | $\lvert\beta_{tH}\rvert\le\beta_0(d)$ | T-pub/pre | [44,45,46] |
| 13 | Area-law *lower* bound can fail | SO(N) | strong coupling | T-pub | [47] |
| 14 | Strong mass gap ⇒ unbroken centre symmetry ⇒ area law | centre nontrivial | any $\beta$ (conditional) | T-pub | [26] |
| 15 | Uniform slab σ-model gap ⇒ area law | centre nontrivial | any $\beta$ (conditional) | T-pub | [22] |
| 16 | Deconfinement: $\sup_R V(R)<\infty$ | SO(3), $d\ge3$ | a.e. $\beta\in(0,\beta^*(d))$ | T-pre | [62] |
| 17 | Perimeter-law lower bound for trivial-centre groups (classical claim) | SO(3)-type | strong coupling | **G** (gaps per [62]) | [25,3] |
| 18 | Leading Wilson-loop asymptotics $e^{-2\ell e^{-12\beta}}$; perimeter law | $\mathbb Z_2$, $d=4$ | $\beta\ge\beta_0$ | T-pub | [28] |
| 19 | Leading Wilson-loop asymptotics | finite $G$ (incl. non-abelian), $d=4$ | large $\beta$ | T-pub/pre | [29,30,33] |
| 20 | Gap at **weak** coupling | finite $G$ (non-abelian ok), $d=4$ | $\beta\ge(114+4\log\lvert G\rvert)/\Delta_G$ | T-pre | [32] |
| 21 | Non-uniqueness / translation-symmetry breaking at intermediate coupling | certain finite-group 4D LGTs | — | T-pub (content via [26,32]) | [35] |
| 22 | Area law at small $\beta$; perimeter law and massless photon at large $\beta$ | U(1), $d=4$ | small / large $\beta$ | T-pub | [2,9,10] |
| 23 | Continuum limit = free Maxwell field | U(1), $d=3,4$ | weak-coupling scaling | T-pub | [13,14] |
| 24 | Area law at **all** $\beta$ | U(1), $d=3$ (Villain) | all $\beta$ | T-pub | [12] |
| 25 | Log confinement at all $\beta$ | $G\supseteq\{zI\}$ (e.g. U(n)), $d=3$, Wilson action | all $\beta$ | T-pub/pre | [11,16,17] |
| 26 | Area law at all $\beta$ | U(N), $d=3$ | all $\beta$ | **H/G** (asserted in [61]; [17] says not carefully done) | [12,16,17,61] |
| 27 | Deconfinement at high temperature | SU(N) at finite temperature | high $T$ | T-pub | [23,24] |
| 28 | Leading-order free energy as $g\to0$ | U(N), $d=3$; $d=4$ only with $g\to0$ jointly | weak | T-pub (+[64] T-pre) | [63,64] |
| 29 | Massive Gaussian scaling limit (Higgs mechanism) | SU(2) [65]; any compact connected $G$ [66] | $g=O(\epsilon^{50d})$, $\alpha g=c\epsilon$ | T-pub/pre | [65,66] |
| 30 | Weak-coupling gap with Higgs (complete breakdown) | U(1) Higgs | $\alpha=m\beta$, $\beta$ large | T-pre | [67,68,69] |
| 31 | UV stability on finite torus | SU(N), $d=3,4$ | AF trajectory | T-pub (long, complex; see other note) | [70–73] |
| 32 | LSI at **all** $\beta$ | SU(N), $d=2$ | all $\beta$ | T-pre | [60] |
| 33 | Machine-checked strong-coupling gap | U(n), $d\ge2$ | $\beta_W<1/(32n(d-1))$ | Lean, self-reported 0 sorry | [90] |
| 34 | Confinement for all couplings | SU(2), $d=4$ | all $\beta$ | **D** | [75–78] |
| 35 | Full 4D YM construction with gap and confinement | SU(N) | — | **C** | [80] |
| **36** | **Gap (exponential clustering) at large $\beta$** | **any continuous non-abelian $G$, $d=3,4$** | **$\beta\to\infty$** | **OPEN** | [88] Prob. 5.1 |
| **37** | **Area law / confinement at large $\beta$** | **SU(N), $d=3,4$** | **$\beta\to\infty$** | **OPEN** | [88] Prob. 4.1 |
| **38** | **Uniqueness of the infinite-volume Gibbs state at large $\beta$** | **any non-abelian continuous $G$, $d\ge3$** | **large $\beta$** | **OPEN** | [88] |
| **39** | **$\xi(\beta)\to\infty$ at the AF rate; Problem 5.2 continuum limit** | **SU(N), $d=4$** | **$\beta\to\infty$** | **OPEN** | [88] |

---

## 4. The strong/weak coupling gap, quantitatively

**Best proven thresholds vs. physical couplings, $d=4$** (conversions $\beta_{\rm LQCD}=N^2\beta_{tH}=N\beta_W$):

| result | SU(2): $\beta_{\rm LQCD}$ threshold | SU(3): $\beta_{\rm LQCD}$ threshold |
|---|---|---|
| Lean `lgt` (U(n) analogue, Dobrushin; $\beta_W<1/(32n(d-1))$) [90] | $<2/192\approx0.0104$ | $<3/288\approx0.0104$ |
| SZZ gap/LSI, $\beta_{tH}<1/48$ [56] | $<0.083$ | $<0.1875$ |
| CNS area law, $\beta_{tH}<1/24$ [58] | $<0.167$ | $<0.375$ |
| typical lattice-QCD scaling window [H] | $\approx2.3$–$2.9$ | $\approx5.7$–$6.5$ |

The factor of roughly 14–35 in $\beta$ understates the gap. That range covers both groups and both results: about 14–17 against the area-law threshold and 28–35 against the gap threshold. (Verifier recomputation; the original said 15–30.) In the proven window the correlation length is $O(1)$ and analytic in $\beta$, and the methods are perturbations of the $\beta=0$ product measure. The continuum needs $\xi(\beta)\gtrsim\exp(\frac{12\pi^2}{11N^2}\beta_{\rm LQCD})$ [H], i.e. control **uniformly as $\beta\to\infty$**.

Physics also expects intervening phenomena, such as the roughening of the strong-coupling string and bulk crossovers [H]. Any strong-coupling expansion therefore has a finite radius of convergence below the scaling region.

**Why each method stops.**

- **Cluster/polymer expansions** [2,59,61,62]. They need a small activity per plaquette, $e^{\beta\,\mathrm{Re}\,\mathrm{Tr}U_p}-1$ small, which is intrinsically a small-$\beta$ statement. The master-loop contraction [61] tolerates truncation level about $N$ but still needs $\beta_C\ll1$. Reaching $\beta_C\sim N$ requires exploiting sign cancellations ([61], Remark 1.7).
- **Bakry–Émery** [56,58,59]. It needs $\mathrm{Hess}\,S<\mathrm{Ric}(G)\approx N/2$. The Hessian grows like $N\beta_{tH}d$, so it can never exceed the 't Hooft regime. At large $\beta$ the measure concentrates near flat connections, a highly non-convex set modulo gauge, so curvature-based convexity must fail globally. A multiscale version (log-Sobolev for effective actions after RG blocking) is the natural but undeveloped continuation. Its models are Bauerschmidt–Bodineau for continuum Sine-Gordon and Bauerschmidt–Dagallier for $\varphi^4_2,\varphi^4_3$, both cited in [56]. *(Verifier: the original attributed the $\varphi^4$ result to Bauerschmidt–Bodineau.)* Piazza–Shen's two-scale disintegration in 2D at all $\beta$ [60] is a first hint.
- **Defect gases** [28–33]. They need a positive minimum excitation energy $\Delta_G$, which fails for continuous groups.
- **Spin-wave / Gaussian methods** [10,13–15,63,65]. They work when the limit is Gaussian: abelian, Higgsed, or leading-order. Non-abelian confinement and the gap are non-perturbative, beyond Gaussian.
- **Conditional reductions** [22,26]. These move the burden onto proving a *uniform-in-boundary-conditions* mass gap at large $\beta$, which is exactly the open problem. They are still valuable: one theorem (a strong gap for SU(N)) would give both the gap and confinement.
- **RG decimation** (Tomboulis [75]; Balaban [70–73]). This is the only class aimed at large $\beta$. Balaban controls the UV on bounded volumes. Tomboulis's claimed infrared control is disputed. The missing piece in every version is **infrared control: flowing from weak coupling at short scales to a strong-coupling (cluster-expandable) regime at large scales**, uniformly in volume.

---

## 5. Relevance to a 4D YM existence + mass-gap proof and to Lean formalization

### 5.1 For existence

- The lattice theory at fixed $\beta$ already satisfies lattice versions of the OS axioms (positivity, symmetries, clustering at small $\beta$) [2,4]. An existence proof via lattice regularization needs uniform estimates along $\beta(a)\to\infty$, which is Balaban's territory [70–73], plus:
  - (i) an infinite-volume limit;
  - (ii) a choice of gauge-invariant smeared observables that survive the limit (Wilson loops do not [15]; candidates are gradient-flowed or smoothed loops, as in Cao–Chatterjee's state-space work [105] and other notes);
  - (iii) verification of OS axioms in the limit, rotational invariance included.
- OpenAI's claim reportedly builds on Balaban [92]. The claim is existence only, with no mass gap; the artifacts are unreleased, and it was unverified as of [92]. The lattice definitions, Haar-measure integrals, gauge fixing and block-spin maps in this note are therefore the **objects any verification will manipulate**. A Lean statement layer should be designed to be compatible with Balaban-style lattice RG, not only with continuum stochastic quantization.

### 5.2 For mass gap

Mass gap in the continuum requires $\liminf_{\beta\to\infty}m(\beta)/a(\beta)>0$, which is **strictly stronger than Problem 5.1**. Useful structural facts:

- (a) The gap is a property of the gauge-invariant sector of the transfer matrix. Reflection positivity turns clustering into a spectral gap at every $\beta$.
- (b) For centre-nontrivial groups, a *strong* gap also gives confinement [26]. A proof strategy can aim for that single target.
- (c) Any purported proof must pass **counterexample filters**:
  - it must fail for 4D U(1) (massless [10]);
  - it must distinguish SO(3), which has a gap but no confinement [56,62];
  - if it proves area law, it must fail for finite groups at large $\beta$ (perimeter law [28,29]), even though those groups are gapped [32].

  These filters are cheap to encode as test cases for an AI proof-search swarm. A candidate argument that never uses non-abelianness, continuity and the centre in the right combination is wrong (cf. Ito–Seiler's U(1) objection to Tomboulis [76]).

### 5.3 For Lean

Concrete, staged formalization targets, from most to least feasible:

1. **Statement layer.**
   - Build on `lgt` [90]: lattice, $G^{E}$, Wilson action, Haar product measure, Gibbs specification, DLR.
   - Add the definitions of area law, Wilson's criterion, strong mass gap ([26] Def. 2.3), centre symmetry ([26] Def. 2.1), and Chatterjee's Problems 4.1, 5.1 and 5.2 as Lean `Prop`s. Problem 5.1 needs infinite-volume Gibbs measures; the DLR machinery exists in [90].
   - Generalize from U(n) to closed subgroups $G\subseteq U(n)$ (the `HasGaugeTrace` hook), in particular SU(N).
2. **All-$\beta$ structural theorems.** Reflection positivity [2], Elitzur [5], the Seiler and Bachas inequalities [6,8], and the perimeter upper bound [7]. These are finite-dimensional integral identities and inequalities; their natural home is a Mathlib-style library.
3. **Conditional theorems.** DF80 ⇒ area law [22,58] needs only conditioning, Fubini, centre invariance and a matrix-entry expansion. Strong gap ⇒ area law [26] additionally needs compactness and weak limits of Gibbs measures (Prokhorov on compact products). These are high-value because they reduce future targets.
4. **Strong-coupling theorems with explicit constants.** Already done for the U(n) gap via Dobrushin [90]. Next targets are the OS-style cluster expansion with an area law, and the CNS master-loop contraction [61]: combinatorial strings, a weighted-norm contraction, and explicit constants such as $10^{3d}$.
5. **Finite-group weak-coupling results** [28,32]. These use discrete exterior calculus, duality, Poisson/Stein approximation and swapping maps. They are combinatorial and therefore Lean-friendly. They are the only rigorous 4D weak-coupling theorems, and good "stress tests" for a large-$\beta$ toolkit.
6. **Bakry–Émery / Langevin** [56,58,59]. This requires Riemannian geometry of compact Lie groups, Brownian motion on $G$ and Γ₂ calculus, none of which is in Mathlib. A purely finite-dimensional Bakry–Émery ⇒ log-Sobolev theorem on compact manifolds would be a substantial but self-contained Mathlib project.
7. **Certified bootstrap bounds** [86,87]. An SDP-certificate checker in Lean, with rational dual certificates, could turn Kazakov–Zheng-type bounds at physical $\beta$ into machine-checked lattice inequalities. They are not uniform in $\beta$, but they are useful as sanity anchors for any RG-based argument.

---

## 6. Open questions and leads

1. **Close the "3D U(N) area law at all β" discrepancy** between [61] and [17]. Does Göpfert–Mack (Villain U(1)) plus Fröhlich's comparison give an area law for the *Wilson* action in 3D U(N)? A careful write-up, or a Lean formalization, would settle a basic fact.
2. **Strong mass gap at intermediate β.** Can the SZZ/CNS Bakry–Émery argument, which only needs uniform-in-boundary convexity of the slab σ-model, be pushed beyond $\beta_{tH}=1/(8(d-1))$ by:
   - using the actual Hessian structure near the identity (curvature of the action on the gauge orbit space) instead of worst-case bounds; or
   - a multiscale (renormalized) log-Sobolev argument after Balaban-type blocking?
3. **Master-loop cancellations** ([61] Remark 1.7). Find a norm in which the signed surface sums contract for $\beta_C\sim N$. This would unify [44,61] with [58], and possibly extend to the area law at fixed N beyond OS.
4. **Trivial-centre deconfinement for all $\beta$ in the strong-coupling interval and a perimeter-law lower bound** ([62] Remark 1.2). This needs ruling out complex zeros of $\langle W\rangle(\beta)$ near the real interval.
5. **Non-abelian weak coupling for finite groups → continuous groups.** Is there a family $G_k\to SU(2)$ (e.g. binary polyhedral or large finite subgroups) where the Adhikari–Cao mechanism [32] degrades in a controlled way? The deconfinement of finite groups at large $\beta$ suggests no, but the *gap* part might give insight.
6. **Large-$\beta$ uniqueness of Gibbs states** in $d\ge3$ for SU(2). This is open even without a gap. Chatterjee's centre-symmetry theorem [26] needs uniqueness on slabs with arbitrary boundary conditions.
7. **Rigorous RG infrared step.** The common missing link in Tomboulis [75] and Balaban [70–73] is a theorem that, after enough blocking steps, the effective lattice action lies in the convergence domain of a strong-coupling expansion (OS [2], SZZ [56], CNS [58]), uniformly in volume. Formulate this "matching lemma" precisely as a Lean `Prop`. It is the natural interface between Balaban-type UV control and the strong-coupling results catalogued here.
8. **Verify the Lean `lgt` repo** [90] independently: build it, `#print axioms`, and audit the definitions against [2,26]. Decide whether to adopt it as the project's base layer. Obtain the blueprint source, which the README's reference list names as S. Chatterjee, *Gauge Theory Lecture Notes* (2026), Ch. 15–16 [103]; no public copy was found.
9. **Locate or rule out "Adhikari–Suzuki–Zhou–Zhuang"** [102] with the user or orchestrator. It may be a garbled reference to [58] or [66]. The verifier re-checked the arXiv API: Arka Adhikari's full listing has no co-authors named Suzuki, Zhou or Zhuang, and "Adhikari AND Zhuang" returns nothing.
10. **Track** Lemoine's companion paper (heat-kernel master field, area law) [55], Rajasekaran–Yakir–Zhou [66], Piazza–Shen [60] for any extension to $d=3$, and the Faria da Veiga–O'Carroll two-gap prediction [83].

---

## 7. References

`verified=true` means existence and bibliographic data confirmed via the arXiv abstract page or API, a Crossref DOI record, or a fetched primary page. Content summaries of paywalled classics come from the secondary sources stated in the text.

1. K. G. Wilson, *Confinement of quarks*, Phys. Rev. D 10 (1974) 2445–2459. DOI 10.1103/PhysRevD.10.2445. verified=true.
2. K. Osterwalder, E. Seiler, *Gauge field theories on a lattice*, Ann. Phys. 110 (1978) 440–471. DOI 10.1016/0003-4916(78)90039-8. verified=true (content via secondary sources).
3. E. Seiler, *Gauge Theories as a Problem of Constructive Quantum Field Theory and Statistical Mechanics*, Lecture Notes in Physics 159, Springer 1982. DOI 10.1007/3-540-11559-5 (ISBN 9783540115595). verified=true.
4. M. Lüscher, *Construction of a selfadjoint, strictly positive transfer matrix for Euclidean lattice gauge theories*, Commun. Math. Phys. 54 (1977) 283–292. DOI 10.1007/BF01614090. verified=true.
5. S. Elitzur, *Impossibility of spontaneously breaking local symmetries*, Phys. Rev. D 12 (1975) 3978–3982. DOI 10.1103/PhysRevD.12.3978. verified=true.
6. E. Seiler, *Upper bound on the color-confining potential*, Phys. Rev. D 18 (1978) 482–483. DOI 10.1103/PhysRevD.18.482. verified=true.
7. B. Simon, L. Yaffe, *Rigorous perimeter law upper bound on Wilson loops*, Phys. Lett. B 115 (1982) 145–147. DOI 10.1016/0370-2693(82)90815-2. verified=true.
8. C. Bachas, *Concavity of the quarkonium potential*, Phys. Rev. D 33 (1986) 2723–2725. DOI 10.1103/PhysRevD.33.2723. verified=true.
9. A. H. Guth, *Existence proof of a nonconfining phase in four-dimensional U(1) lattice gauge theory*, Phys. Rev. D 21 (1980) 2291–2307. DOI 10.1103/PhysRevD.21.2291. verified=true.
10. J. Fröhlich, T. Spencer, *Massless phases and symmetry restoration in abelian gauge theories and spin systems*, Commun. Math. Phys. 83 (1982) 411–454. DOI 10.1007/BF01213610. verified=true.
11. J. Glimm, A. Jaffe, *Quark trapping for lattice U(1) gauge fields*, Phys. Lett. B 66 (1977) 67–69. DOI 10.1016/0370-2693(77)90615-3. verified=true.
12. M. Göpfert, G. Mack, *Proof of confinement of static quarks in 3-dimensional U(1) lattice gauge theory for all values of the coupling constant*, Commun. Math. Phys. 82 (1982) 545–606. DOI 10.1007/BF01961240. verified=true.
13. L. Gross, *Convergence of U(1)₃ lattice gauge theory to its continuum limit*, Commun. Math. Phys. 92 (1983) 137–162. DOI 10.1007/BF01210842. verified=true.
14. B. K. Driver, *Convergence of the U(1)₄ lattice gauge theory to its continuum limit*, Commun. Math. Phys. 110 (1987) 479–501. DOI 10.1007/BF01212424. verified=true.
15. C. Garban, A. Sepúlveda, *Improved spin-wave estimate for Wilson loops in U(1) lattice gauge theory*, arXiv:2107.04021 (2021). verified=true.
16. J. Fröhlich, *Confinement in Z_n lattice gauge theories implies confinement in SU(n) lattice Higgs theories*, Phys. Lett. B 83 (1979) 195–198. DOI 10.1016/0370-2693(79)90684-1. verified=true.
17. S. Chatterjee, *A short proof of confinement in three-dimensional lattice gauge theories with a central U(1)*, arXiv:2602.00436 (2026). verified=true.
18. G. Mack, V. B. Petkova, *Comparison of lattice gauge theories with gauge groups Z2 and SU(2)*, Ann. Phys. 123 (1979) 442–467. DOI 10.1016/0003-4916(79)90346-4. verified=true.
19. G. Mack, V. B. Petkova, *Sufficient condition for confinement of static quarks by a vortex condensation mechanism*, Ann. Phys. 125 (1980) 117–134. DOI 10.1016/0003-4916(80)90121-9. verified=true.
20. G. 't Hooft, *A property of electric and magnetic flux in non-Abelian gauge theories*, Nucl. Phys. B 153 (1979) 141–160. DOI 10.1016/0550-3213(79)90595-9. verified=true.
21. L. G. Yaffe, *Confinement in SU(N) lattice gauge theories*, Phys. Rev. D 21 (1980) 1574–1590. DOI 10.1103/PhysRevD.21.1574. verified=true.
22. B. Durhuus, J. Fröhlich, *A connection between ν-dimensional Yang–Mills theory and (ν−1)-dimensional, non-linear σ-models*, Commun. Math. Phys. 75 (1980) 103–151. DOI 10.1007/BF01222514. verified=true (content via [58]).
23. C. Borgs, E. Seiler, *Lattice Yang–Mills theory at nonzero temperature and the confinement problem*, Commun. Math. Phys. 91 (1983) 329–380. DOI 10.1007/BF01208780. verified=true.
24. C. Borgs, E. Seiler, *Quark deconfinement at high temperature: a rigorous proof*, Nucl. Phys. B 215 (1983) 125–135. DOI 10.1016/0550-3213(83)90270-5. verified=true. Crossref gives only the main title; INSPIRE gives the full title with subtitle.
25. J. Glimm, A. Jaffe, *Charges, vortices and confinement*, Nucl. Phys. B 149 (1979) 49–60. DOI 10.1016/0550-3213(79)90156-1. verified=true.
26. S. Chatterjee, *A probabilistic mechanism for quark confinement*, Commun. Math. Phys. 385 (2021) 1007–1039. arXiv:2006.16229; DOI 10.1007/s00220-021-04086-y. verified=true. PDF downloaded.
27. R. L. Dobrushin, S. B. Shlosman, *Constructive criterion for the uniqueness of Gibbs field*, in Statistical Physics and Dynamical Systems (Birkhäuser 1985) 347–370. DOI 10.1007/978-1-4899-6653-7_20. verified=true.
28. S. Chatterjee, *Wilson loops in Ising lattice gauge theory*, Commun. Math. Phys. 377 (2020) 307–340. arXiv:1811.09770; DOI 10.1007/s00220-020-03738-9. verified=true. PDF downloaded.
29. S. Cao, *Wilson loop expectations in lattice gauge theories with finite gauge groups*, Commun. Math. Phys. 380 (2020) 1439–1505. arXiv:2001.05627; DOI 10.1007/s00220-020-03912-z. verified=true. PDF downloaded.
30. M. P. Forsström, J. Lenells, F. Viklund, *Wilson loops in finite Abelian lattice gauge theories*, Ann. Inst. H. Poincaré Probab. Stat. 58 (2022) 2129–2164. arXiv:2001.07453; DOI 10.1214/21-AIHP1227. verified=true.
31. M. P. Forsström, *Decay of correlations in finite Abelian lattice gauge theories*, arXiv:2104.03752. verified=true.
32. A. Adhikari, S. Cao, *Correlation decay for finite lattice gauge theories at weak coupling*, arXiv:2202.10375 (v3 2024). verified=true. PDF downloaded.
33. M. P. Forsström, F. Viklund, *Free energy and quark potential in Ising lattice gauge theory via cluster expansion*, arXiv:2304.08286. verified=true.
34. M. P. Forsström, F. Viklund, *Current expansion and couplings for Ising lattice gauge theory*, arXiv:2502.19942. verified=true.
35. C. Borgs, *Translation symmetry breaking in four dimensional lattice gauge theories*, Commun. Math. Phys. 96 (1984) 251–284. DOI 10.1007/BF01240222. verified=true (content via [26,32]).
36. K. Szlachányi, P. Vecsernyés, *Cluster expansion in terms of knots in gauge theories with finite non-Abelian gauge groups*, J. Math. Phys. 30 (1989) 2156–2159. DOI 10.1063/1.528218. verified=true.
37. M. Aizenman, J. T. Chayes, L. Chayes, J. Fröhlich, L. Russo, *On a sharp transition from area law to perimeter law in a system of random surfaces*, Commun. Math. Phys. 92 (1983) 19–69. DOI 10.1007/BF01206313. verified=true.
38. P. Duncan, B. Schweinhart, *Topological phases in the plaquette random-cluster model and Potts lattice gauge theory*, arXiv:2207.08339. verified=true.
39. P. Duncan, B. Schweinhart, *A topological formula for Potts lattice gauge theory correlations*, arXiv:2607.02434 (2026). verified=true.
40. M. P. Forsström, J. Lenells, F. Viklund, *Wilson loops in the abelian lattice Higgs model*, Prob. Math. Phys. 4 (2023) 257–329. arXiv:2107.03718; DOI 10.2140/pmp.2023.4.257. verified=true.
41. M. P. Forsström, J. Lenells, F. Viklund, *Wilson lines in the lattice Higgs model at strong coupling*, arXiv:2211.03424. verified=true.
42. A. Adhikari, *Wilson loop expectations for non-abelian gauge fields coupled to a Higgs boson at low and high disorder*, arXiv:2111.07540. verified=true.
43. M. P. Forsström, *Pure perimeter laws for Wilson lines observables*, arXiv:2409.20085. verified=true.
44. S. Chatterjee, *Rigorous solution of strongly coupled SO(N) lattice gauge theory in the large N limit*, Commun. Math. Phys. 366 (2019) 203–268. arXiv:1502.07719; DOI 10.1007/s00220-019-03353-3. verified=true. PDF downloaded.
45. S. Chatterjee, J. Jafarov, *The 1/N expansion for SO(N) lattice gauge theory at strong coupling*, arXiv:1604.04777. verified=true.
46. J. Jafarov, *Wilson loop expectations in SU(N) lattice gauge theory*, arXiv:1610.03821. verified=true.
47. R. Basu, S. Ganguly, *SO(N) lattice gauge theory, planar and beyond*, Commun. Pure Appl. Math. 71 (2018) 2016–2064. arXiv:1608.04379; DOI 10.1002/cpa.21788. verified=true.
48. H. Shen, S. A. Smith, R. Zhu, *A new derivation of the finite N master loop equation for lattice Yang–Mills*, arXiv:2202.00880. verified=true.
49. O. Abdelghani, R. Nissim, *Geometric derivation of the finite N master loop equation*, arXiv:2309.07399. verified=true.
50. H. Shen, S. A. Smith, R. Zhu, *Makeenko–Migdal equations for lattice Yang–Mills–Higgs*, arXiv:2512.00570. verified=true.
51. S. Cao, M. Park, S. Sheffield, *Random surfaces and lattice Yang–Mills*, arXiv:2307.06790. verified=true. PDF downloaded.
52. J. Borga, S. Cao, J. Shogren-Knaak, *Surface sums for lattice Yang–Mills in the large-N limit*, arXiv:2411.11676. verified=true.
53. J. Borga, S. Cao, J. Shogren-Knaak, *Surface sums in two-dimensional large-N lattice Yang–Mills: cancellations and explicit computations for general loops*, arXiv:2508.13827. verified=true.
54. M. Park, J. Pfeffer, S. Sheffield, P. Yu, *Wilson loop expectations as sums over surfaces on the plane*, Prob. Math. Phys. 7 (2026) 37–121. arXiv:2305.02306; DOI 10.2140/pmp.2026.7.37. verified=true.
55. T. Lemoine, *Universal dualities for Wilson loops in lattice Yang–Mills*, arXiv:2604.16252 (2026). verified=true.
56. H. Shen, R. Zhu, X. Zhu, *A stochastic analysis approach to lattice Yang–Mills at strong coupling*, Commun. Math. Phys. 400 (2023) 805–851. arXiv:2204.12737; DOI 10.1007/s00220-022-04609-1. verified=true. PDF downloaded.
57. H. Shen, R. Zhu, X. Zhu, *Langevin dynamics of lattice Yang–Mills–Higgs and applications*, arXiv:2401.13299. verified=true.
58. S. Cao, R. Nissim, S. Sheffield, *Dynamical approach to area law for lattice Yang–Mills*, arXiv:2509.04688 (2025). verified=true. PDF downloaded.
59. R. Nissim, *U(N) lattice Yang–Mills in the 't Hooft regime*, arXiv:2510.22788 (2025). verified=true. PDF downloaded.
60. J. Piazza, H. Shen, *Log-Sobolev inequality for 2D SU(N) lattice gauge theory at all couplings*, arXiv:2610.35286 (2026). verified=true.
61. S. Cao, R. Nissim, S. Sheffield, *Expanded regimes of area law for lattice Yang–Mills theories*, arXiv:2505.16585 (2025; v3 26 Sep 2025). verified=true. PDF downloaded (v3). In v3 the main theorem is Thm 1.2 and the future-directions remark is Remark 1.4.
62. R. Nissim, *Deconfinement for SO(3) lattice Yang–Mills at strong coupling*, arXiv:2605.16162 (2026). verified=true. PDF downloaded.
63. S. Chatterjee, *The leading term of the Yang–Mills free energy*, J. Funct. Anal. 271 (2016) 2944–3005. arXiv:1602.01222; DOI 10.1016/j.jfa.2016.04.032. verified=true. Theorems 2.1–2.3 checked against the arXiv text.
64. C. Brennecke, *On the leading order term of the lattice Yang–Mills free energy*, arXiv:2511.07297 (2025). verified=true.
65. S. Chatterjee, *A scaling limit of SU(2) lattice Yang–Mills–Higgs theory*, Prob. Math. Phys. 7 (2026) 339–381. arXiv:2401.10507; DOI 10.2140/pmp.2026.7.339. verified=true. PDF downloaded.
66. F. Rajasekaran, O. Yakir, Y. Zhou, *Gaussian limits of lattice Higgs models with complete symmetry breaking*, arXiv:2603.24555 (2026). verified=true.
67. S. Chatterjee, O. Yakir, *Correlation decay for U(1) lattice Higgs theory: the case of small mass*, arXiv:2509.19176 (2025). verified=true.
68. T. Balaban, D. Brydges, J. Imbrie, A. Jaffe, *The mass gap for Higgs models on a unit lattice*, Ann. Phys. 158 (1984) 281–319. DOI 10.1016/0003-4916(84)90121-0. verified=true.
69. A. Goswami, *Mass gap in weakly coupled abelian Higgs on a unit lattice*, Ann. Henri Poincaré 20 (2019) 3955–3996. arXiv:1811.00422; DOI 10.1007/s00023-019-00840-0. verified=true.
70. T. Bałaban, *Renormalization group approach to lattice gauge field theories I. Generation of effective actions in a small field approximation and a coupling constant renormalization in four dimensions*, Commun. Math. Phys. 109 (1987) 249–301. DOI 10.1007/BF01215223. verified=true.
71. T. Bałaban, *Renormalization group approach to lattice gauge field theories II. Cluster expansions*, Commun. Math. Phys. 116 (1988) 1–22. DOI 10.1007/BF01239022. verified=true.
72. T. Bałaban, *Convergent renormalization expansions for lattice gauge theories*, Commun. Math. Phys. 119 (1988) 243–285. DOI 10.1007/BF01217741. verified=true.
73. J. Dimock, *The renormalization group according to Balaban I–III* (I. Small fields, Rev. Math. Phys., DOI 10.1142/S0129055X13300100; II. Large fields, J. Math. Phys., DOI 10.1063/1.4821275; III. Convergence, Ann. Henri Poincaré, DOI 10.1007/s00023-013-0303-3). arXiv:1108.1335, arXiv:1212.5562, arXiv:1304.0705. verified=true. DOIs are from arXiv metadata.
74. J. Magnen, V. Rivasseau, R. Sénéor, *Construction of YM₄ with an infrared cutoff*, Commun. Math. Phys. 155 (1993) 325–383. DOI 10.1007/BF02097397. verified=true.
75. E. T. Tomboulis, *Confinement for all values of the coupling in four-dimensional SU(2) gauge theory*, arXiv:0707.2179 (2007). verified=true. PDF downloaded. [Disputed]
76. K. R. Ito, E. Seiler, *On the recent paper on quark confinement by Tomboulis*, arXiv:0711.4930 (2007). verified=true. PDF downloaded.
77. E. T. Tomboulis, *Reply to arXiv:0711.4930 by Ito and Seiler*, arXiv:0712.2620 (2007). verified=true.
78. K. R. Ito, E. Seiler, *Further discussion of Tomboulis' approach to the confinement problem*, arXiv:0803.3019 (2008). verified=true.
79. E. Seiler, *The case against asymptotic freedom*, arXiv:hep-th/0312015 (2003). verified=true.
80. M. Faizal, A. Shabir, *Reflection-positive construction of a four-dimensional SU(N) Yang–Mills theory with mass gap and confinement*, Fortschr. Phys. 74 (2026) e70097. arXiv:2606.19362; DOI 10.1002/prop.70097. verified=true (existence only; claims unverified, [C]).
81. V. P. Nair, *Towards a proof of mass gap in 3d Yang–Mills theory*, arXiv:2608.10133 (2026). verified=true.
82. E. Zhou, M. Reed, C. Hayes, *Lattice gauge theory and Wilson-loop confinement: a statistical-mechanical survey*, arXiv:2605.02156 (2026). verified=true (existence; provenance unclear; not used as a source).
83. P. A. Faria da Veiga, M. O'Carroll, *On charge conjugation, correlations, Elitzur's theorem and the mass gap problem in lattice SU(N) Yang–Mills models in d=4 dimensions*, arXiv:2509.03513 (2025). verified=true.
84. P. A. Faria da Veiga, M. O'Carroll, R. Schor, *Existence of baryons, baryon spectrum and mass splitting in strong coupling lattice QCD*, Commun. Math. Phys. 245 (2004) 383–405. DOI 10.1007/s00220-003-1022-2. verified=true.
85. R. Schor, *Glueball spectroscopy in strongly coupled lattice gauge theories*, Commun. Math. Phys. 92 (1984) 369–395. DOI 10.1007/BF01210727. verified=true (content not read).
86. V. Kazakov, Z. Zheng, *Bootstrap for lattice Yang–Mills theory*, Phys. Rev. D 107 (2023) L051501. arXiv:2203.11360. verified=true.
87. V. Kazakov, Z. Zheng, *Bootstrap for finite N lattice Yang–Mills theory*, JHEP 03 (2025) 099. arXiv:2404.16925; DOI 10.1007/JHEP03(2025)099. verified=true.
88. S. Chatterjee, *Yang–Mills for probabilists*, arXiv:1803.01950, in Probability and Analysis in Interacting Physical Systems, Springer Proc. Math. Stat. (2019) 1–16. DOI 10.1007/978-3-030-15338-0_1. verified=true. PDF present in library. Problems 4.1, 5.1 and 5.2 checked against the text.
89. M. R. Douglas, S. Hoback, A. Mei, R. Nissim, *Formalization of QFT*, arXiv:2603.15770 (2026). verified=true.
90. M. R. Douglas, with F. Rajasekaran (GitHub `mrdouglasny`), *lgt — Lattice Gauge Theory in Lean 4*, https://github.com/mrdouglasny/lgt. The repo was created 2026-04-11. README re-fetched by the verifier 2026-11-05. Reservoir: https://reservoir.lean-lang.org/@mrdouglasny/LGT (last updated 2026-09-06). verified=true for existence. The zero-sorry claim and the comparator check are README self-reports; no one in this project has built it.
91. A. Novickis, *A machine-checked proof of the strong-coupling mass gap in U(1) lattice gauge theory*, Zenodo record 20547755 (v3, 2026-06-04; a newer version exists). https://zenodo.org/records/20547755. verified=true (existence; claims unverified).
92. Unite.AI, *OpenAI says its models produced three proofs in math, CS and physics* (2026-10-26). https://www.unite.ai/openai-says-its-models-produced-three-proofs-in-math-cs-and-physics/. verified=true (article exists and was re-fetched). Content per the article: the claim is existence only, with no mass gap; it "builds on Balaban's approach"; Lean formalization dated 16 Oct 2026; a Gross-led group is to write it up. The reported claims are unverified.
93. T. Tlas, *A concentration of measure phenomenon in lattice Yang–Mills*, arXiv:2603.25236 (2026). verified=true.
94. D. Brydges, J. Fröhlich, E. Seiler, *On the construction of quantized gauge fields. I. General results*, Ann. Phys. 121 (1979) 227–284. DOI 10.1016/0003-4916(79)90098-8. verified=true. (Background; not cited in the text.)
95. C. King, *The U(1) Higgs model. I. The continuum limit*, Commun. Math. Phys. 102 (1986) 649–677. DOI 10.1007/BF01221651. verified=true. Crossref gives only the short title "The U(1) Higgs model". (Background; not cited in the text.)
96. T. Kennedy, C. King, *Spontaneous symmetry breakdown in the abelian Higgs model*, Commun. Math. Phys. 104 (1986) 327–347. DOI 10.1007/BF01211599. verified=true.
97. K. Fredenhagen, M. Marcu, *Charged states in Z2 gauge theories*, Commun. Math. Phys. 92 (1983) 81–119. DOI 10.1007/BF01206315. verified=true.
98. E. Fradkin, S. H. Shenker, *Phase diagrams of lattice gauge theories with Higgs fields*, Phys. Rev. D 19 (1979) 3682–3697. DOI 10.1103/PhysRevD.19.3682. verified=true.
99. M. P. Forsström, *The phase transition of the Marcu–Fredenhagen ratio in the abelian lattice Higgs model*, arXiv:2401.09163; and *Phase transitions in the charged compact abelian lattice Higgs model*, arXiv:2602.21679. verified=true.
100. I. Chevyrev, Y. Qu, H. Shen, *Scaling limit of the 3D abelian Yang–Mills Langevin dynamics*, arXiv:2608.27828 (2026). verified=true.
101. B. Bringmann, S. Cao, M. Hairer, W. Zhao, *Construction of the 2D non-Abelian Yang–Mills–Higgs measure via stochastic quantisation*, arXiv:2611.03640 (2026). verified=true.
102. "Adhikari–Suzuki–Zhou–Zhuang" (named in the task, on lattice Yang–Mills). **Not found** in arXiv author searches or a web search. verified=false.
103. S. Chatterjee, *Gauge Theory Lecture Notes* (2026), Ch. 15–16. This is how the `lgt` README's reference list names the blueprint its text calls "Chatterjee 2026, Ch. 16". **No public copy found** in a web search; it may be unpublished course notes. verified=false.
104. E. Seiler, *Critical discussion of Tomboulis' approach to the confinement problem*, PoS(Confinement8)034, from the VIIIth Conference Quark Confinement and the Hadron Spectrum (2008; PoS page dated 2012-09-12). https://pos.sissa.it/077/034. verified=true (existence and metadata via the PoS page; content not read). *Added by verifier.*
105. S. Cao, S. Chatterjee, *A state space for 3D Euclidean Yang–Mills theories*, Commun. Math. Phys. 405 (2024). DOI 10.1007/s00220-023-04870-y. verified=true (Crossref). *Added by verifier*, because §5.1 cites this work by name without a number.

---

## Verification log

Adversarial verification on 2026-11-05 (verifier pass, workstream `07-lattice-rigorous-results`).

### A. Bibliographic checks

- **arXiv.** All 62 arXiv identifiers in the reference list were queried in two batches through the arXiv API. That covers refs 15, 17, 26, 28–34, 38–55, 56–67, 69, 73 (×3), 75–83, 86–89, 93, 99 (×2), 100 and 101. **Every ID resolves, and the title and authors match the note.** No mis-ID'd arXiv reference was found.
- **DOIs.** 48 DOIs were checked against Crossref. All resolve, and title, authors, journal, volume and pages match the note. Three needed retries; all three resolve:
  - 10.2140/pmp.2026.7.37 failed on the first attempt.
  - 10.1103/PhysRevD.21.1574 returns a MathML-encoded title.
  - 10.1007/BF01222514 returns a garbled-character title.
- **DOIs added.** Crossref bibliographic search found DOIs the note lacked: [28] 10.1007/s00220-020-03738-9; [30] 10.1214/21-AIHP1227 (AIHP 58 (2022) 2129–2164); [44] 10.1007/s00220-019-03353-3; [47] 10.1002/cpa.21788; [63] 10.1016/j.jfa.2016.04.032; [87] 10.1007/JHEP03(2025)099; [88] 10.1007/978-3-030-15338-0_1. Dimock I–III DOIs [73] came from arXiv metadata.
- **URLs.**
  - [90] GitHub API and raw README: exists; created 2026-04-11.
  - [90] Reservoir: last updated 2026-09-06, matching "activity in Sept 2026".
  - [91] Zenodo: v3, 2026-06-04, independent researcher; a newer version exists.
  - [92] Unite.AI: exists, dated 2026-10-26, content re-read.
  - [104] PoS 077/034: exists.
  - Seiler LNP 159 chapter page ranges [3] were confirmed via Crossref chapter DOIs.
- **PDF integrity.** The 14 PDFs this note downloaded, plus 1803.01950, were opened with `pdftotext`. Each first page carries the expected arXiv ID and title. **No PDF was deleted.**
- **Unverifiable items.**
  - [102] "Adhikari–Suzuki–Zhou–Zhuang" is still not found. The verifier re-checked Arka Adhikari's full arXiv author listing and the query `au:Adhikari AND au:Zhuang`. It is probably a garbled or fabricated name from the task text; verified=false.
  - [103] is now *identified* as S. Chatterjee, *Gauge Theory Lecture Notes* (2026), Ch. 15–16 (the `lgt` README's reference list). No public copy was found; still verified=false.
- **Added references.** [104] Seiler PoS follow-up on Tomboulis, replacing an uncited mention. [105] Cao–Chatterjee state-space paper, which was named in §5.1 without a number.

### B. Mathematical and factual claims checked against primary text

Each claim was checked against the arXiv PDF text or abstract.

1. **SZZ [56] thresholds.** Assumption 1.1 / eq. (1.3) gives $|\beta|<1/(16(d-1))$ for SU(N) and $<1/(32(d-1))-1/(16N(d-1))$ for SO(N). Corollary 1.5 gives the variance bound $4n(n-3)/(K_SN)$. Corollary 1.6 gives the mass gap, with rate $c_N$ depending on $K_S,N,d$. **Confirmed.**
2. **CNS dynamical [58] area law.** Def. 1.4 / Thm 1.6 give $\beta^*_{SU(N)}=\beta^*_{U(N)}=1/(8(d-1))$ and $\beta^*_{SO(N)}=1/(16(d-1))-1/(8N(d-1))$. The Hessian bound is $4(d-1)N\beta$, and the DF80 restatement is Thm 2.3 with $zI\in G$, $z\neq1$. **Confirmed.** *Corrected* the SO indexing: $N$ is the matrix size, and v2's theorem statement has an inconsistent "SO(2(N−1))". Added that SZZ's threshold is exactly half of CNS's.
3. **CNS expanded [61].** Uniform-in-N $\beta_0(d)$; the Thm 4.1 constant $\alpha=2\cdot10^{3d}\max(10^3d\beta,e^{-10^{-7}d^{-2}N})$; the action is $\exp(2\beta\,\mathrm{Re\,Tr}\,U_p)$; [61] cites [OS78, Thm 5.1]. **Confirmed.** *Corrected* theorem and remark numbering for v3 (Thm 1.2; Remark 1.4, not 1.7). *Softened* "[58] supersedes [61]": [61] itself says its string-tension constant is better.
4. **Chatterjee 2021 [26].** Def. 2.1 (centre symmetry), Thm 2.2 (unbroken centre gives $|\langle W\rangle|\le e^{-V(R)T}$ with $V\to\infty$), Def. 2.3, and Thm 2.4 (decay under arbitrary boundary conditions gives unbroken centre symmetry **and** the area law). **Confirmed.** Added a terminology note: "strong mass gap" is this note's label, not Chatterjee's.
5. **Adhikari–Cao [32].** Threshold $\beta\ge(114+4\log|G|)/\Delta_G$; covariance bound $4(4\cdot10^{24}|G|^2)^{|B_1|+|B_2|}\cdots e^{-(\beta/2)\Delta_G(L-1)}$; footnote 1 on Borgs §7 contradicting Seiler's monograph; footnote 2 on not reconstructing Szlachányi–Vecsernyés. **Confirmed.** "Submitted to Ann. Probab." is printed on the PDF.
6. **Chatterjee Ising [28], Thm 1.1.** The $e^{-2\ell e^{-12\beta}}$ formula and its error term, non-negativity (Thm 4.2), and decay of correlations with the infinite-volume limit (§5). **Confirmed.**
7. **Nissim SO(3) [62].** Thm 1.1 holds for a.e. $\beta\in(0,\beta^*(d))$, $d\ge3$, with $\sup_RV(R)<\infty$. The tube order is $4|\ell|-16$; the lower bound $m=(1/9)^{|\ell|}$; Jensen/Harnack/Cartan arguments; Lemma 3.15 is reflection positivity; Remarks 1.2, 1.3 and 1.5 are as described. **Confirmed.**
8. **Nissim U(N) [59].** $\beta^*=10^{-6d}$ and $\tilde\beta(d)\le\beta^*$. The introduction states the OS condition as $\beta<c_d/N^2$ in 't Hooft scaling. **Confirmed.**
9. **Garban–Sepúlveda [15].** The main bound (abstract / Thm 1.3); Thm 1.2 is the Guth/FS82 perimeter-vs-area transition; Cor. 7.2 recovers Simon–Yaffe; Cor. 7.3 is the Glimm–Jaffe 3D log bound. **Confirmed.**
10. **Chatterjee 2026 [17].** The bound $n\exp\{-C(1+n\beta)^{-1}T\log(R+1)\}$; history via Fröhlich Cor. 2; an explicit statement that combining GM82 with Fröhlich to get a 3D U(n) area law "would require additional technology" and was not pursued. **Confirmed.** CNS [61] does assert the 3D U(N) area law at all $\beta$, so the discrepancy recorded in §2.3 is real.
11. **Chatterjee "YM for probabilists" [88].** Problems 4.1, 5.1 and 5.2 are as transcribed; Gibbs-state uniqueness at large $\beta$ is unknown in $d>2$; Seiler Ch. 8 is cited. **Confirmed.**
12. **Chatterjee JFA 2016 [63].** Thms 2.1–2.3, including the 4D joint $g\to0$ restriction. **Confirmed.**
13. **Ito–Seiler [76].** The equality $\alpha(t^*)=\alpha_+(t^*)$ reduces to the unproved inequality (3.5) $A(\alpha)>A_+(\alpha)$, and the U(1) objection appears. Remark 2.2(3) cites Borgs–Seiler for 't Hooft string tension ≤ Wilson string tension. **Confirmed.**
14. **Higgs scaling limits [65,66,67].** Abstracts match. *Corrected* the overstatement "first rigorous Higgs mass generation" to "in such a (non-abelian, $d>2$) theory".
15. **Lean `lgt` [90].** The README confirms $\beta<1/(32n(d-1))$, the decay $\alpha^{(\mathrm{dist}-1)/2}$, $m=-\tfrac12\log\alpha$, zero sorries, the axiom footprint, Mathlib/Lean v4.29.0, and partial 2D and Bridge files. *Added* the co-author (Rajasekaran), the comparator check, the dependency on `markov-semigroups`, and Reservoir build failures on newer toolchains.
16. **OpenAI claim [92].** The note's "reportedly builds on Balaban's approach" is accurate per the article. *Added* that the claim is existence only (no mass gap), the company-reported dates (NL proof 9 Sep, Lean 16 Oct, announcement 26 Oct 2026), and that the artifacts are unreleased and the proof unverified.
17. **Mathlib.** The vendored `Mathlib/LinearAlgebra/UnitaryGroup.lean` was inspected. `unitaryGroup`, `specialUnitaryGroup` and `specialOrthogonalGroup` are confirmed as submonoids, with no topology. A repo-wide grep found no `CompactSpace` instance for unitary groups.
18. **Arithmetic.**
    - Normalization conversions $\beta_{LQCD}=N\beta_W=N^2\beta_{tH}$ and $\beta_W=2\beta_C$: recomputed and correct.
    - AF exponent $12\pi^2/(11N^2)$ ≈ 1.196 for SU(3) and 2.69 for SU(2): correct.
    - Threshold table entries (0.0104, 0.083, 0.1875, 0.167, 0.375): correct.
    - "Factor 15–30": corrected to ≈14–35.

### C. Overstatements corrected (proven vs claimed vs heuristic)

- **Summary item 3.** "No rigorous result about … confinement … for any continuous non-abelian group in $d\ge3$ at large β" was **false as written**: 3D U(n) has proven log confinement at all β [16,17]. It is restricted to pure YM area law, gap and uniqueness, with the central-U(1) exception made explicit.
- **§2.3.** Göpfert–Mack was called "the only confinement-at-all-couplings theorem". Corrected to the only *area-law* theorem at all couplings.
- **§2.10.** The Higgs mass-generation priority claim is now qualified.
- **§2.7.** The Piazza–Shen "first" claim is marked as this note's characterization.
- **§2.8.** "[58] supersedes [61]" is now qualified.
- **Smaller fixes.**
  - §2.2: [83] is by Faria da Veiga–O'Carroll, not "their" three-author group.
  - §2.12: the 0.1% figure belongs to the SU(2) finite-N paper.
  - §4: the φ⁴ LSI is Bauerschmidt–Dagallier, not Bauerschmidt–Bodineau.
  - §2.5: in [33], $m$ is the lattice dimension.

### D. Residual concerns (not resolved by this pass)

- **Paywalled classics** (OS78, Göpfert–Mack, Fröhlich–Spencer, Durhuus–Fröhlich, Borgs, Schor, Bałaban) were verified bibliographically only. Content claims about them still rest on the secondary sources named in the note.
- **Faizal–Shabir [80]** is a published paper (Fortschr. Phys.) whose abstract claims a full 4D construction with gap and confinement. The [C] label stands, but the verifier did not audit the paper itself; another workstream holds its PDF.
- **Kazakov–Zheng [86,87]** describe their SDP bounds as "rigorous". Whether the published numbers come with certified (exact or interval) dual certificates was not checked. The note's [H→T if certified] label is the appropriate caution.
- **Durhuus–Fröhlich 1980** is cited by the CNS restatement. Its exact hypotheses (Wilson vs. general actions, boundary-field class) were not checked in the primary text.
- **The `lgt` repo** has not been built locally. The "zero sorry" and comparator claims are self-reported, and Reservoir reports build failures on newer toolchains.
- **[43] Forsström** ("pure perimeter laws in the Higgs and confinement phases") and **[34] Forsström–Viklund**: only titles and abstracts were checked, not the detailed claims.
- **OpenAI.** All dates and scope come from a press article [92], not from an OpenAI primary document or a refereed source.
