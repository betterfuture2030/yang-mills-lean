# 09 — Mechanisms for the mass gap and confinement, assessed as proof strategies

*Workstream key:* `09-mass-gap-mechanisms` · *Compiled:* 2026-11-05 · *Sibling notes:* 01 (problem definition), 02 (OpenAI claim), 05 (Balaban), 07 (rigorous lattice results), 08 (constructive tools)

**Status tags used throughout**

| Tag | Meaning |
|---|---|
| **[T]** | Established theorem: peer-reviewed and accepted. |
| **[T-pre]** | Theorem in a preprint by credible authors that has not yet been widely checked. |
| **[C]** | Claimed but unverified: AI-generated, unrefereed, or not independently checked. |
| **[H]** | Heuristic: physics derivation, folklore or numerical evidence. Not a proof. |
| **[D]** | Disputed, or known to be false. |
| **[I]** | My own inference or assessment. Not stated by any source. |

Quotations are kept under 15 words. Everything else is paraphrase.

---

## Summary

1. **Two problems in one.** The Clay problem contains two problems of different kinds.
   - **Existence** is an *ultraviolet* problem: constructing the continuum limit with the OS/Wightman axioms. Asymptotic freedom makes it tractable in principle. The coupling becomes small at short distances, so multiscale renormalization-group methods can control it (Balaban; OpenAI's unreleased October 2026 claim, note 02).
   - **The mass gap** is an *infrared* problem. Dimensional transmutation forces the gap to be $m=C\Lambda$, with $\Lambda\simeq\mu\,e^{-8\pi^2/(b_0g^2(\mu))}$. This is non-analytic at $g=0$, so the gap is invisible at every order of perturbation theory. At the scale where it forms, the running coupling is $O(1)$ and there is no small parameter.
   - Every mechanism surveyed here is fundamentally about the IR problem. **None yields a rigorous 4D gap.**

2. **On a finite lattice the gap is trivial; uniformity is the whole problem.** For compact $G$ on a finite periodic lattice, the transfer matrix is a positivity-improving compact operator, so its spectrum has a gap [T]. The Clay content is a gap **uniform in the volume and in the lattice spacing along the asymptotic-freedom trajectory**. For the Wilson action this needs a lattice gap of at least $c\,a(\beta)\Lambda_L\sim c\,e^{-12\pi^2\beta/(11N^2)}\times$(power of $\beta$) as $\beta\to\infty$. Strong-coupling bounds of the form $m_{\rm lat}\gtrsim-\log\beta$ say nothing about this regime.

3. **On the lattice, confinement is downstream of a strong form of the gap.** Two conditional theorems [T] reduce Wilson's area law to exponential decay of correlations **uniformly in boundary conditions**, for groups with nontrivial center:
   - Durhuus–Fröhlich 1980, via slab σ-models;
   - Chatterjee 2021 (CMP).

   In 2025 Cao–Nissim–Sheffield [47] combined the Durhuus–Fröhlich reduction with Shen–Zhu–Zhu's Bakry–Émery/Langevin method. This proves area law in a strong-coupling, 't Hooft-scaled regime: $\beta<1/(8(d-1))$ for U(N) and SU(N), and roughly half that ($1/(16(d-1))-1/(8N(d-1))$) for SO(2N). It is a small-β regime, not "the whole" weak-coupling problem. *(Verifier: the original said "the whole 't Hooft regime" and implied both reductions were used; CNS's Thm 1.6 uses DF80 only.)* A single "strong gap" theorem at weak coupling would therefore give both the gap and confinement [I].

4. **Any 4D proof strategy must pass four rigorous sanity checks.**
   - It must fail for 4D U(1). That theory has a massless, deconfined Coulomb phase at weak coupling (Guth 1980; Fröhlich–Spencer 1982) [T].
   - It must not "prove" confinement for finite gauge groups at weak coupling in $d\ge3$. Those theories are gapped (4D: Adhikari–Cao, Ann. Probab. 2025 [49]) but have perimeter-law Wilson loops (Chatterjee 2020; Cao 2020; Forsström–Lenells–Viklund 2022 [135–137]) [T]. *(Verifier: the original credited both facts to Adhikari–Cao, who prove only the correlation decay.)*
   - It must not prove confinement for SO(3) either. SO(3) has trivial center and fails Wilson's criterion, at least at strong coupling (Nissim 2026) [T-pre]. SO(3) is a compact simple group, so a gap is still expected and is still part of the Clay statement. Only the *confinement* conclusion must fail there.
   - It must respect the θ=π anomaly. There, no trivially gapped vacuum is allowed (Gaiotto–Kapustin–Komargodski–Seiberg 2017) [H, physics-rigorous].

   A mechanism whose proof sketch uses only "compact gauge group plus asymptotic freedom" cannot work, because it would also wrongly prove a gap for 4D U(1) [I].

5. **Mechanisms with real rigorous content.**
   - (a) Strong-coupling cluster expansions (Osterwalder–Seiler) [T]. These give a gap and area law, but only far from the continuum.
   - (b) Polyakov's monopole mechanism for **3D abelian** gauge theory (Göpfert–Mack 1982) [T]: area law at all couplings via the Coulomb gas to sine-Gordon duality, the same technology as Debye screening (Brydges–Federbush). Chatterjee 2026 gives a short, self-contained proof of logarithmic confinement for 3D groups containing a central U(1) [T-pre]. The result itself is classical (Fröhlich 1979 with Glimm–Jaffe 1977).
   - (c) Center-symmetry and vortex conditional theorems [T]: Mack–Petkova, Tomboulis–Yaffe, Chatterjee, Durhuus–Fröhlich.
   - (d) Large-N mass generation in asymptotically free 2D models [T]: Gross–Neveu (Kopper–Magnen–Rivasseau 1995); the cutoff O(N) σ-model (Kopper 1999).
   - (e) Higgs-mechanism gaps [T]: Balaban–Brydges–Imbrie–Jaffe and successors. The mass there is classically visible, so this does not touch the pure-YM difficulty.
   - (f) Rigorous algebraic geometry behind the Seiberg–Witten prepotential [T]: Nekrasov–Okounkov, Nakajima–Yoshioka, Braverman–Etingof. This is not a QFT theorem.

6. **Heuristics with strong evidence but no rigorous foothold in 4D:**
   - Seiberg–Witten monopole condensation (N=2 softly broken to N=1);
   - dual superconductivity and abelian projection;
   - center-vortex dominance;
   - Gribov–Zwanziger;
   - holography (Witten 1998; Klebanov–Strassler);
   - the Feynman and Karabali–Kim–Nair (2+1)D Hamiltonian approach. Its string-tension prediction is about 1% off lattice at $N=\infty$, a 6σ discrepancy;
   - semiclassics on $\mathbb R^3\times S^1$ (Ünsal–Yaffe) and on $\mathbb R^2\times T^2$ with 't Hooft flux (Tanizaki–Ünsal). These give *controlled* weak-coupling derivations of a gap in locally 4D theories. Their link to $\mathbb R^4$ rests on an unproven "adiabatic continuity" conjecture.

7. **The most important new claim** for this workstream is OpenAI's `openai/math` family 215 [C]. It claims **uniform exponential decay for the 2D O(n) model, $n\ge3$, at every β**. The claim has a 60-line Comparator statement (`ClassicalON.lean`). It also has a full Lean proof development: about 115 files under `lean/OAI/Probability/ClassicalON/`, registered as a main result in `lean/formalization.yaml`. That catalogue gives the review status as `unchecked`, and we have not built or replayed it. *(Verifier: the original described only a "Lean statement". A formal proof is claimed, which makes the lattice statement potentially machine-checkable. It remains [C] until it is independently replayed.)* This is Polyakov's mass-generation conjecture for an asymptotically free model. It is also *similar in type* to the "uniform in environment" statement that Durhuus–Fröhlich needs. There is a caveat: the O(n) environments are scalar, ferromagnetic couplings $b_e\in[0,\beta]$, while the DF slab environments are matrix-valued twists $A_e,B_e\in U(N)$, which can frustrate. If the result is correct and extends to principal chiral models in a gauge-field environment, it would bear directly on 3D lattice confinement [I]. It is unreviewed.

8. **Ranking as routes to a rigorous 4D gap** [I]:
   1. Multiscale RG crossover, building on the (claimed) existence proof, ending in a strong-gap or cluster-expansion regime. Hard, but it is the only route that matches the structure of the problem.
   2. Conditional reductions plus a strong-gap theorem.
   3. Semiclassical islands plus continuity. This is a valuable milestone (a rigorous gap in a locally 4D non-abelian theory) but the continuity step has no known method.
   4. Hamiltonian/orbit-space geometry. 2+1D only for now.
   5. Large N. Rigorous only at strong 't Hooft coupling, separated from the continuum by a bulk transition. In any case Clay needs every $G$.
   6. Center vortices and dual superconductivity, as direct proofs.
   7. Gribov–Zwanziger. Gauge-variant.
   8. SUSY soft breaking and holography. No rigorous handle on either end.

---

## 1. Key definitions and statements

### 1.1 Asymptotic freedom and dimensional transmutation

**Beta function.** For pure YM with compact simple $G$, quadratic Casimir $C_A$ ($=N$ for SU(N)), in any mass-independent scheme:
$$\mu\frac{dg}{d\mu}=-\frac{b_0}{16\pi^2}g^3-\frac{b_1}{(16\pi^2)^2}g^5+O(g^7),\qquad b_0=\tfrac{11}{3}C_A,\quad b_1=\tfrac{34}{3}C_A^2 .$$
These coefficients come from Gross–Wilczek and Politzer [1,2]; $b_1$ was computed later. Both are scheme-independent. The perturbative computation is [T] within renormalized perturbation theory.

**RG-invariant scale.** Integrating the flow gives
$$\Lambda=\mu\,\exp\!\Big(-\frac{8\pi^2}{b_0g^2(\mu)}\Big)\Big(\frac{b_0g^2(\mu)}{16\pi^2}\Big)^{-b_1/(2b_0^2)}\big(1+O(g^2)\big),\qquad \frac{b_1}{2b_0^2}=\frac{51}{121}.$$

**Dimensional transmutation [H, standard].** The pure-YM continuum theory has no dimensionless parameter apart from θ. Every mass is a pure number times $\Lambda$: $m_{0^{++}}=c_{0^{++}}\Lambda$, $\sqrt\sigma=c_\sigma\Lambda$, and so on. Because $e^{-8\pi^2/(b_0g^2)}$ has all $g$-derivatives zero at $g=0$, **no finite order of perturbation theory can produce a gap**. A proof must be non-perturbative in the IR.

**Lattice form** (Wilson action, $\beta=2N/g_0^2$). Along the AF trajectory the lattice spacing is
$$a(\beta)\Lambda_L=\exp\!\big(-\tfrac{12\pi^2}{11N^2}\beta\big)\big(b_0g_0^2/16\pi^2\big)^{-51/121}(1+O(1/\beta)).$$
A continuum gap $m_{\rm phys}>0$ is equivalent to a lattice gap $m_{\rm lat}(\beta)=a(\beta)m_{\rm phys}$ that **decays no faster than** this as $\beta\to\infty$, uniformly in the volume (note 07, §1.4; note 05).

### 1.2 Mass gap: three formulations

For full statements and equivalences see note 01, §2.9.

- **Spectral (Clay).** OS reconstruction gives $(\mathcal H,H,\Omega)$ with $H\ge0$ and $H\Omega=0$. Gap: $\operatorname{spec}(H)\cap(0,\Delta)=\emptyset$, with $m=\sup\Delta<\infty$ (Jaffe–Witten [3]).
- **Euclidean clustering.** For local gauge-invariant $\mathcal O$ with $\langle\mathcal O\rangle=0$: $|\langle\mathcal O(x)\mathcal O(y)\rangle|\le C_{\mathcal O}e^{-m|x-y|}$. Under OS reconstruction, a uniform rate $m$ on a generating family of local fields is equivalent to the spectral gap on the corresponding cyclic subspace. Jaffe–Witten state clustering as a consequence of the gap.
- **Lattice transfer matrix.** On a lattice with reflection positivity (Wilson action, [Osterwalder–Seiler]), $T=e^{-aH_a}$ and the gap is $\|T|_{\Omega^\perp}\|\le e^{-am_{\rm lat}}$.
  - **Triviality caveat [T]:** on a finite torus, $T$ has a continuous strictly positive kernel on a compact space. By Perron–Frobenius the top eigenvalue is simple, so every finite volume has *some* gap.
  - Jaffe–Witten [3] stress two points. A gap uniform in the volume is the real target, and it may be essential for the infinite-volume limit. They also note that no present idea points toward it.

**Strong gap** (Chatterjee [44], Def. 2.3). There exist $K_1,K_2>0$, depending only on $(G,\beta,d)$, such that for every cube $B$, every boundary condition $\delta$, and all local $f,g$ supported on edges of $B$ with values in $[-1,1]$:
$$|\langle fg\rangle_{B,\delta}-\langle f\rangle_{B,\delta}\langle g\rangle_{B,\delta}|\le K_1e^{-K_2\,{\rm dist}(f,g)}.$$
Chatterjee notes it is unclear whether the physics expectation of a gap includes this strong, boundary-uniform version.

### 1.3 Confinement and its relation to the gap

**Area law (Wilson [4]).** For rectangular loops $R\times T$ in a representation acting nontrivially on the center:
$$|\langle W_\ell\rangle|\le Ce^{-\sigma RT}.$$
The weaker notion is $|\langle W\rangle|\le e^{-V(R)T}$ with $V(R)\to\infty$.

**Center symmetry.** Polyakov loops on $\mathbb R^3\times S^1_\beta$ carry $\mathbb Z(G)$ charge. Unbroken center symmetry is the standard confinement criterion. The magnetic dual is the 't Hooft loop and vortex free energy ('t Hooft 1978/79 [5,6]). With dynamical adjoint (zero N-ality) matter, only N-ality-$k\neq0$ string tensions are order parameters; these are the k-strings [Greensite 22].

**Gap and confinement are logically independent in general** [T, by examples]:
- Higgs phases are gapped but have a perimeter law ([BBIJ 70]; [Fradkin–Shenker 71]; [Osterwalder–Seiler 7] analyticity).
- Finite-group LGT at weak coupling is gapped and deconfined. The gap in 4D is due to Adhikari–Cao [49]. The perimeter law in $d\ge3$ is due to Chatterjee (for $\mathbb Z_2$) [135], Cao (finite groups) [136] and Forsström–Lenells–Viklund (finite abelian groups) [137]. In $d=2$ every lattice gauge theory has an area law.
- 4D U(1) at weak coupling is neither gapped nor confined [Guth 33; Fröhlich–Spencer 34].
- 3D U(1) is both [Göpfert–Mack 31].

The Clay problem asks only for the gap. Confinement is listed as a natural extension [3].

### 1.4 Existence (UV) versus gap (IR): what each mechanism addresses

| Mechanism | UV (existence) | IR (gap/confinement) | Note |
|---|---|---|---|
| Asymptotic freedom | **yes**: the reason a continuum limit should exist | explains *why a scale* exists (transmutation), not why the spectrum is gapped | §2.1 |
| Lattice Monte Carlo | evidence for both (scaling) | evidence for both | §2.2 |
| Strong-coupling expansion | no (lattice only) | yes, but far from continuum | §2.3 |
| Large N | no (planar theory still needs renormalization) | heuristic IR | §2.4 |
| Feynman / KKN (2+1) | partially (regularized Laplacian on orbit space) | yes (3D) | §2.5–2.6 |
| Polyakov / Göpfert–Mack | 3D abelian: UV trivial (super-renormalizable) | yes, rigorous in 3D U(1) | §2.7 |
| Dual superconductor / abelian projection | no | heuristic | §2.8 |
| Seiberg–Witten | no (SUSY QFT not constructed) | IR effective theory | §2.9 |
| Center vortices / center symmetry | no | conditional theorems | §2.10 |
| Gribov–Zwanziger | gauge-fixing/BRST (UV renormalizable action) | IR propagators (gauge-variant) | §2.11 |
| Holography | no | IR geometry | §2.12 |
| Semiclassics on $\mathbb R^3\times S^1$, $\mathbb R^2\times T^2$ | needs 4D UV (Balaban-type) | controlled weak-coupling IR | §2.13 |

---

## 2. Detailed findings, mechanism by mechanism

Each subsection gives four things:
- **(P)** the physics;
- **(R)** rigorous partial results;
- **(Req)** the precise statement a proof by this route would require;
- **(A)** my assessment of plausibility [I].

### 2.1 Asymptotic freedom and dimensional transmutation (Gross–Wilczek, Politzer)

**(P)** [1,2]. Non-abelian gauge theories are the unique 4D renormalizable theories (with suitable matter) whose coupling vanishes logarithmically in the UV. The IR coupling grows, and the "confinement scale" $\Lambda$ appears through transmutation. The hope behind every mass-gap story is that strong IR coupling produces a gap. That inference is itself heuristic: QED in 4D has a growing UV coupling and a massless photon; 4D U(1) LGT at strong *bare* coupling is confining but passes to a Coulomb phase.

**(R)**
- **Perturbative.** The β-function coefficients [T, renormalized perturbation theory].
- **Non-perturbative UV.** Balaban's 3D and 4D UV stability along the AF trajectory on a finite torus [T; note 05]. Magnen–Rivasseau–Sénéor's YM$_4$ with an infrared cutoff [T; 29].
- **Rigorous constructions of other AF theories** [T]:
  - the massive Gross–Neveu model (Gawędzki–Kupiainen [74]; Feldman–Magnen–Rivasseau–Sénéor [75]);
  - **dynamical mass generation** in large-N Gross–Neveu (Kopper–Magnen–Rivasseau [76]);
  - the cutoff large-N O(N) σ-model (Kopper [77]). Douglas's 2004 report cites it as the case where a gap "has been exhibited in a regulated version" of a σ-model, and treats σ-models as one of two YM-like analogue classes [8]. *(Verifier: the original said Douglas calls it "the closest rigorous gap". He does not use that phrase.)*
- **A dissent [D/H, minority].** Patrascioiu and Seiler argued for decades against AF in non-abelian σ-models and YM ("super-instantons", percolation arguments) [78,79]. The community does not accept this, but it is why Chatterjee writes "some dissent" [44].
- **Contrast [T].** φ⁴₄ is marginally trivial (Aizenman–Duminil-Copin [80]). AF is what makes a nontrivial 4D YM limit expected.

**(Req)** AF gives no direct route to a gap. What it enables is a **crossover theorem**. Run a rigorous RG from scale $a$ (coupling $g_0\to0$) up to the scale $L_*$ where the effective coupling reaches a value $g_*$. Then prove that the effective lattice theory at $L_*$ (with controlled irrelevant terms and large-field remainders) satisfies a strong-coupling criterion: Dobrushin uniqueness, a convergent polymer expansion, Bakry–Émery, or the strong gap of §1.2.

**The quantitative obstruction** (note 07 §4 [T/H]):
- Known strong-coupling criteria need $\beta_{\rm LQCD}\lesssim0.1$–$0.4$, which means $g_*^2$ very large.
- Weak-coupling RG control needs $g$ small.
- Lattice simulations show the physical crossover at $\beta_{\rm LQCD}\approx2.3$–$2.9$ for SU(2) and $5.7$–$6.5$ for SU(3).
- The proof must bridge this window, presumably by many RG steps with **non-perturbative but non-expansion-based** estimates.

**(A)** AF is necessary context for, and the backbone of, the most plausible route (RG crossover). As a "mechanism" it supplies no IR estimate. **High relevance, zero standalone power.**

### 2.2 Lattice Monte Carlo evidence

**(P/H)**
- **Creutz 1980 [9].** The first SU(2) Monte Carlo. The string tension in lattice units crosses smoothly from the strong-coupling form to the two-loop AF form. There is no phase transition in β for SU(2), which is consistent with confinement surviving into the continuum.
- **Morningstar–Peardon 1999 [10]** (SU(3), anisotropic improved lattices, continuum-extrapolated):
  - $0^{++}$: $1730(50)(80)$ MeV, with $r_0m_{0^{++}}=4.21(12)$;
  - $2^{++}$: $2400(25)(120)$ MeV;
  - $0^{-+}$: $2590(40)(130)$ MeV;
  - all using $r_0^{-1}=410(20)$ MeV.

  Chen et al. 2006 [11] update these with matrix elements.
- **Athenodorou–Teper 2021 [12]** (SU(N), $N=2,\dots,12$, continuum and then $N\to\infty$):
  - $M_{0^{++}}/\sqrt\sigma\approx3.41$ for SU(3) and $\approx3.07$ for SU(∞);
  - $M_{2^{++}}\simeq1.5M_{0^{++}}$;
  - SU(3) is "close to" SU(∞), with $O(1/N^2)$ corrections.
- **Large-N reviews** (Teper [13]; Lucini–Teper–Wenger [14]; Lucini–Panero [15]):
  - confinement persists as $N\to\infty$ at fixed $g^2N$;
  - k-string tensions lie between the sine law $\sin(\pi k/N)/\sin(\pi/N)$ and Casimir scaling;
  - flux tubes behave as effective bosonic strings (Lüscher term; Lüscher–Weisz [16]).
- **2+1D** [13,15]. All SU(N≥2) theories confine linearly. At large N, $\sqrt\sigma/(g^2N)=0.19755(34)-0.1200(29)/N^2$ (Lucini–Teper).
- **A caveat relevant to proofs** [15]. For the 4D Wilson action with **N ≥ 5**, a first-order **bulk** transition (no symmetry breaking) separates strong from weak bare coupling. For N<5 it is a crossover. So "no phase transition in β between strong coupling and the continuum" is **action-dependent**. A proof by analytic continuation from strong coupling must choose its action or avoid the claim [I].

**(R)** None. These are numerical. Certified bootstrap bounds at fixed β (Kazakov–Zheng; note 07 §2.12) could turn single numbers into theorems [I].

**(Req/A)** Lattice data are **oracles**, not proofs. Their value for a proof project:
- **Calibration:** any conjectured intermediate inequality, for example a lower bound on vortex free energy, can be tested numerically.
- **Falsification:** the KKN prediction was falsified at the 6σ level (§2.6).
- **Action choice:** see the bulk transition above.

### 2.3 Strong-coupling lattice gauge theory (included as the only unconditional 4D non-abelian gap)

**(R) [T]** ([46–48] are unrefereed arXiv preprints, so strictly [T-pre])
- **Osterwalder–Seiler 1978 [7].** They prove reflection positivity of the Wilson action at **all** β. For **small** β they prove a mass gap (exponential clustering) and Wilson's area law. They also prove that the Higgs and confinement regions are analytically connected. Seiler's LNP 159 [17] gives the full exposition. *(Verifier: the original put reflection positivity under "small β"; RP holds at all couplings.)*
- **Shen–Zhu–Zhu 2023 [45]** (CMP 400). Bakry–Émery/Langevin methods in the 't Hooft regime $|\beta|<1/(16(d-1))$ for SU(N), with action $N\beta\sum{\rm Re\,Tr}$; the threshold for SO(N) is $(N-2)/(32(d-1)N)$. They prove uniqueness of the infinite-volume measure, log-Sobolev/Poincaré inequalities and a mass gap.
- **Cao–Nissim–Sheffield 2025.** These are two separate papers with different methods.
  - [46] extends the area-law regime of OS78 for U(N), especially at large N. It uses an a-priori bound for the master loop equation.
  - [47] proves area law for $\beta<\beta^*_G$, with $\beta^*_{U(N)}=\beta^*_{SU(N)}=1/(8(d-1))$ and $\beta^*_{SO(N)}=1/(16(d-1))-1/(8N(d-1))$, for $G\in\{U(N),SU(N),SO(2N)\}$. It does this by verifying the DF80 slab-σ-model decay with Bakry–Émery. *(Verifier: the original merged the two papers and gave one threshold for all three groups.)*
- **Nissim 2025 [48].** The U(N) mass gap in the 't Hooft regime.
- **Lean.** Douglas's `lgt` repository formalizes a Dobrushin-type strong-coupling gap for U(n), with $\beta_W<1/(32n(d-1))$ (note 07 §2.13). Its zero-`sorry` status and the Comparator replay are self-reported.

**(A)** Strong coupling gives the first-rung Lean milestone and the *terminal* step of an RG-crossover proof. It cannot by itself approach the continuum: the correlation length stays $O(1)$ and analytic in β [7, note 07]. **Essential tool, not a route.**

### 2.4 't Hooft large N

**(P) ['t Hooft 18].** With $\lambda=g^2N$ fixed, diagrams are organized by surface topology. Planar diagrams dominate, $1/N$ plays the role of a string coupling, and mesons and glueballs become free, stable, infinitely many narrow states. Related heuristics:
- loop equations (Makeenko–Migdal [19]);
- large-N factorization and volume independence (Eguchi–Kawai [20]). This fails for pure YM on small tori because center symmetry breaks; Ünsal–Yaffe's double-trace deformation restores it [62].

Jaffe–Witten describe the suspected 4D gauge/string equivalence with string coupling $1/N$. They say it might explain the gap and confinement and give a starting point for a rigorous proof "for sufficiently large N". They also note no effective approach yet exists for the theory without fermions [3].

**(R) [T]**
- **2D YM.** Exact solvability and master field (Driver–Hall–Kemp, Driver–Gabriel–Hall–Kemp [21,22]; Lévy [21b]). Douglas–Kazakov's large-N phase transition [23]. 2D has no propagating gluons, so "gap" is not the issue.
- **Lattice, strong 't Hooft coupling:**
  - Chatterjee's SO(N) solution [50];
  - Basu–Ganguly [51];
  - Jafarov [52];
  - Cao–Park–Sheffield random surfaces [53];
  - Borga–Cao–Shogren-Knaak surface sums [54];
  - Shen–Smith–Zhu master loop equation [55];
  - Nissim, U(N) gap and large-N limit [48].
- **Gross–Witten [24]** (2D lattice). The $N\to\infty$ lattice theory has a **third-order transition** in λ. Strong-λ expansions therefore do not analytically continue to weak λ at $N=\infty$.
- **4D** (Lucini–Panero [15], citing Campostrini 1999). The large-N bulk transition is quoted at "0.3596(2)". Lucini–Panero attach this number to the bare 't Hooft coupling $\lambda_0$. In the usual Wilson normalization ($\beta=2N/g_0^2$, $\lambda_0=g_0^2N$), large-N bulk values are normally given as the inverse coupling $b=1/\lambda_0=\beta/(2N^2)\approx0.36$, i.e. $\lambda_0\approx2.8$. Check the convention against Campostrini before using the number [I]. *(Verifier: the original gave "bare $\lambda_0\approx0.36$" without this caveat.)*

**(Req)** Two possible statements:
- (i) A rigorous $N=\infty$ limit at **weak** 't Hooft coupling with a gap uniform in the lattice spacing, as an asymptotic solution [3];
- (ii) a gap for each finite $N$ obtained from (i) by a $1/N$ expansion with error control uniform in $a$.

**(A)** **Low as a Clay route.**
- Clay needs every compact simple G, including SU(2) and G₂.
- The $1/N$ expansion is expected to be asymptotic, not convergent.
- Every rigorous large-N result lives on the strong-coupling side of a transition that separates it from the continuum (Gross–Witten in 2D; bulk transition in 4D).

**Medium as a source of tools.** Loop equations, surface sums and the master-field philosophy may give **a priori bounds** usable inside an RG proof [I].

### 2.5 Feynman 1981 on (2+1)D YM and orbit-space geometry

**(P/H)** [Feynman 25, via Karabali–Kim–Nair 27, Orland 28, Nair 30]. Feynman's qualitative argument works in the Schrödinger picture on the gauge-orbit space $\mathcal C=\mathcal A/\mathcal G_*$:
- The relevant geometry of $\mathcal C$ is "small" in the long-wavelength directions.
- The potential energy cuts off the "escaping directions" where plane waves could give a continuous spectrum.
- The low-lying spectrum of the Laplacian on $\mathcal C$ should therefore be gapped, as for compact manifolds.

Supporting geometry:
- Singer showed the orbit space carries a natural Riemannian metric with interesting curvature [Singer 1981, cited by Clay as ref 44].
- Jaffe–Witten [3] cite this together with Simon's examples: quantum operators with discrete spectrum despite classically unbounded flat directions [Simon 26], such as $p_x^2+p_y^2+x^2y^2$.

The Clay text suggests the gap "could arise" from the quartic $(A\wedge A)^2$ term.

**(R)**
- **Simon 1983 [26] [T].** Flat valleys with a transverse confining potential give discrete spectrum. This is rigorous for finite-dimensional models such as spatially constant (zero-dimensional) YM.
- **Lüscher 1983 [57] [T/H].** On a small spatial torus the YM spectrum is computable by an effective Hamiltonian for the constant modes.
- **Counter-lesson, de Wit–Lüscher–Nicolai 1989 [58] [T].** In the supersymmetric matrix model, fermions cancel the zero-point lifting of flat directions and the spectrum is continuous. Flat-direction lifting is delicate and can fail.
- **Orland 1996 [28] [T-pre].** The Feynman metric makes the orbit space a complete Riemannian manifold. In **3+1D** there are configurations arbitrarily far from pure gauge with arbitrarily small potential energy, resembling long-wavelength gluons. Feynman's 2+1D intuition therefore does not transfer naively to 4D.
- **No** rigorous infinite-dimensional version exists. $\mathcal C$ is not compact (Nair [30] emphasizes this).

**(Req)** On a lattice-regularized $\mathcal C$, prove a spectral gap for $H=T+V$ that is uniform in volume and spacing. This needs a lower bound on the Laplacian on orbit space, for example via curvature in a Bakry–Émery/Lichnerowicz style, plus control of $V$. For 4D, Orland's small-potential directions must be beaten by dynamics, not geometry.

**(A)** **Low for 4D; medium as a 2+1D research programme.** The useful kernel is "curvature of orbit space gives a Poincaré inequality". It is formally the same idea that powers the strong-coupling Bakry–Émery results [45]. Note 07 explains why global convexity fails at large β; multiscale is the only hope.

### 2.6 Karabali–Kim–Nair Hamiltonian approach in 2+1D

**(P/H)** [27, 59, 30, 81]. Write $A=-\partial M\,M^{-1}$ with $M\in SL(N,\mathbb C)$ and $H=M^\dagger M$. The orbit-space volume element is then $e^{2c_A S_{\rm WZW}(H)}$. The kinetic term acting on wave functionals of the current $J=(c_A/\pi)\partial H H^{-1}$ produces a mass:
$$m=\frac{e^2c_A}{2\pi}\quad(c_A=N),\qquad \sigma_R=\frac{e^4c_Ac_R}{4\pi}.$$
Here $e^2$ is the dimensionful 3D coupling. The area law arises because, to leading order in $1/m$, the vacuum wave functional is a 2D Euclidean YM functional integral [27, eqs. 7.5–7.6].
- Leigh–Minic–Yelnikov [59] derive a glueball spectrum from Bessel-function zeros.
- Karabali–Nair–Yelnikov [81] compute corrections of −0.3% to −2.8% to σ.
- Nair's 2023 review [30] summarizes the programme.

**Lattice test.** The prediction gives $\sqrt\sigma/(g^2N)\to1/\sqrt{8\pi}\approx0.1995$ at large N. Lattice gives $0.19755(34)$. Bringoltz–Teper [60] find agreement within 3% for all N, but a **≈1%, ≈6σ discrepancy at N=∞**. Their abstract calls the analysis "remarkably accurate" yet "not exact". Lucini–Panero record that the theoretical foundations are "still under debate" [15].

**Latest status.** Nair, *Towards a proof of mass gap in 3d Yang–Mills theory* (Aug 2026) [82] [H, programme]. It reduces the gap to the operator inequality $T^2-mT\ge0$ on the gauge-invariant configuration space, with $m=e^2c_A/2\pi$, and then uses $V\ge0$. The author acknowledges several gaps:
- operator products and Green's functions are not fully regularized;
- positivity of the *renormalized* $V$ is assumed;
- the state saturating the bound is not physical, so the true gap should be larger.

He notes the method relies on 2D space, so it does not extend directly to 4D.

**(Req)** Three components, in order:
- (i) a rigorous construction of the 3D YM Hamiltonian on $L^2(\mathcal C,d\mu)$, compatible with the Euclidean construction (Balaban YM₃; the Sussman–Alpöge YM₃ claims, note 02);
- (ii) a rigorous version of the KKN change of variables and the regularized WZW measure;
- (iii) $T^2-mT\ge0$ as a form inequality, and $V_{\rm ren}\ge0$.

**(A)** **The most concrete heuristic gap mechanism in 3D, with a precise operator inequality to aim at.** It is a plausible *3D* milestone, especially with lattice regularization. It is irrelevant to 4D unless a 4D analogue appears (none known; cf. Karabali–Maj–Nair on $\mathbb{CP}^2$, not reviewed here). The 6σ discrepancy is a reminder that its approximations are not exact.

### 2.7 Polyakov's monopole mechanism and its rigorous versions

**(P) [Polyakov 1975/77; 35, 36].**
- In 3D compact U(1), and in the 3D SU(2) Georgi–Glashow model at weak coupling, monopole-instantons form a dilute Coulomb gas.
- Duality maps this to a dual-photon field $\sigma$ with a $\cos\sigma$ potential. The dual photon gets a Debye mass $m_\gamma^2\propto e^{-S_0}$, which is exponentially small in $1/g^2$, and Wilson loops obey an area law.
- In 4D, monopoles are particles, not instantons, so the mechanism does not apply directly. 4D compact U(1) has a confining strong-coupling phase and a Coulomb weak-coupling phase separated by a transition.

**(R) [T]**
- **Göpfert–Mack 1982 [31].** For 3D U(1) LGT with Villain action they prove positivity of the string tension (area law) for **all** couplings, via an exact duality to a $\mathbb Z$-valued model and a rigorous block-spin analysis. The quantitative coupling dependence is in the original; I could not access the full text.
- **Glimm–Jaffe 1977 [37].** Logarithmic confinement in 3D U(1).
- **Fröhlich 1979 [38].** Comparison inequalities ($\mathbb Z_N$ confinement implies SU(N)-Higgs confinement; U(1) confinement implies U(n) confinement).
- **Chatterjee 2026 [39] [T-pre].** A self-contained short proof that in 3D, any $G\subseteq U(n)$ containing all scalars $zI$ satisfies
$$|\langle W_\ell\rangle|\le n\,e^{-c(1+n\beta)^{-1}T\log(R+1)}$$
for all β. The method conditions on the G-factor and reduces to a 2D XY-type two-point function (Mermin–Wagner complex rotations). He explicitly leaves the upgrade to an area law open.
- **Brydges–Federbush 1980 [40].** Debye screening in the classical Coulomb gas via sine-Gordon: the same mathematics, cited by Jaffe–Witten as the model of a "duality transformation" producing a non-classical gap [3].
- **4D abelian contrast** [T]. Guth [33] and Fröhlich–Spencer [34] prove a Coulomb (massless, deconfined) phase in 4D U(1) at weak coupling. Fröhlich–Marchetti [41] construct monopole sectors in that phase.

**(Req)** For 4D non-abelian YM, the Polyakov route needs a **compactification** in which monopoles become instantons (§2.13): $\mathbb R^3\times S^1$ with center stabilization. Then one needs:
- (i) 4D UV control;
- (ii) a rigorous non-abelian Georgi–Glashow-type Coulomb-gas analysis, generalizing Göpfert–Mack to a $U(1)^{N-1}$ effective theory with monopole-instantons of finite size;
- (iii) continuity in $L$.

As far as I found, even the **3D SU(2) Georgi–Glashow** version of Polyakov's result is **not** rigorously proven [I; absence not exhaustively verified].

**(A)** **The only mechanism with a rigorous end-to-end proof in a non-trivial gauge theory** (3D U(1)). The technology (duality, sine-Gordon, multiscale Coulomb gas) is what any semiclassical-island proof will need. **High as a milestone source.** It is **not a direct 4D route**: the 4D abelian theory deconfines.

**Lean.** Chatterjee 2026 is an ideal early formalization target. The arXiv v2 PDF is 13 pages; the original note's "4 pages" was wrong. It exercises Wilson loops, conditioning, Haar measure on U(1) and XY-type estimates [I].

### 2.8 Dual superconductivity and abelian projection ('t Hooft–Mandelstam)

**(P/H)** [Mandelstam 42; 't Hooft 5, 43].
- The QCD vacuum would be a dual superconductor. Condensed magnetic monopoles squeeze chromo-electric flux into Abrikosov-like tubes.
- 't Hooft's **abelian projection** gauge-fixes to the Cartan torus $U(1)^{N-1}$. Monopoles appear at gauge-fixing singularities.
- **Lattice:**
  - in maximal abelian gauge (introduced by Kronfeld–Schierholz–Wiese [64]) the abelian-projected string tension dominates. This is "abelian dominance" (Suzuki–Yotsuyanagi [63]). The often-quoted figure of about 92% of the full SU(2) string tension, the ratio 0.92(4), comes from Bali–Bornyakov–Müller-Preussker–Schilling 1996 [63b]. Monopole contributions then give about 95% of the abelian string tension ("monopole dominance"; Greensite [22] §7.5). *(Verifier: the original attributed the 92% to [63,64].)*
  - disorder parameters for monopole condensation have been measured (Di Giacomo et al. [65]);
  - review: Ripka [66].

**Known problems** (Greensite review [22], §7.6):
- (i) Abelian projection gives **no area law for adjoint (zero N-ality) loops** at intermediate distances, contradicting Casimir scaling.
- (ii) It predicts $N-1$ independent flux-tube species, a point raised by Douglas–Shenker [67], which are not seen.
- (iii) At asymptotic distances, double-charged abelian loops must be screened by off-diagonal gluons, which a monopole Coulomb gas cannot reproduce.
- The results are **gauge-dependent**. Elitzur's theorem [68] [T] forbids local gauge-symmetry breaking, so "condensates" must be defined gauge-invariantly, for example via 't Hooft loops or disorder operators.

**(R)** Rigorous only in abelian settings (§2.7) and in the SW effective theory (§2.9, not rigorous).

**(Req)** A gauge-invariant definition of a monopole/disorder operator in 4D non-abelian LGT with a nonzero vacuum expectation value (or a 't Hooft-loop perimeter law), proven at weak coupling, plus a theorem that this implies the gap.

**(A)** **Low as a direct route.** It is gauge-dependent, its N-ality structure is wrong at large distances, and there is no rigorous foothold in 4D non-abelian theory. Its legitimate content survives in the rigorous center-symmetry and 't Hooft-loop framework (§2.10).

### 2.9 Seiberg–Witten: confinement by monopole condensation in N=2 SYM, and related work by Nekrasov and Douglas

**(P/H)** [Seiberg–Witten 32].
- For N=2 SU(2) SYM they find the exact low-energy effective action on the Coulomb branch (u-plane): the prepotential, the elliptic curve, and the monodromies with massless monopole and dyon points.
- Add the N=1-preserving perturbation $W=m\,{\rm Tr}\,\Phi^2$. Near the monopole point, the effective superpotential forces monopole condensation $\langle M\rangle\sim(-m\,u'(0)/\sqrt2)^{1/2}$. The dual photon acquires a mass by a *magnetic* Higgs mechanism, and electric charge is confined.
- The two surviving vacua (monopole and dyon points) realize the expected $\mathbb Z_4\to\mathbb Z_2$ breaking of N=1 SYM.
- SW themselves say pure N=1 SYM is "strongly believed" to have a gap. Their analysis is reliable for small $m$.
- **Douglas–Shenker 1995 [67].** For SU(N) the confining N=1 theory is effectively a broken $U(1)^{N-1}$ theory with a **spectrum of string tensions**, the origin of the sine law. They also find that the effective Lagrangian is inadequate for the usual large-N limit.

**(R)**
- The SW **prepotential** equals the sum over instantons, computed as equivariant integrals over instanton moduli. This is a rigorous mathematical theorem:
  - Nekrasov [83] (conjecture and physics derivation, noncommutative regularization);
  - Nekrasov–Okounkov [84] (random partitions), Nakajima–Yoshioka [85] (blowup) and Braverman–Etingof [86] (affine Lie algebras). These are usually credited as three independent proofs of Nekrasov's conjecture. *(Verifier: the original credited the rigorous proof only to [85,86]; the standard attribution includes [84].)*
  - Douglas's 2004 report calls this the simplest 4D result carrying "any of the physics of the mass gap" [8].
- **No QFT theorem exists**: N=2 SYM has not been constructed, and the soft-breaking flow is uncontrolled.
- **Douglas 2026 [87].** The SW solution for SU(2) is codified in **Lean 4 as theorems derived from a short list of named physical postulates**. The higher-genus SU(N) case is an axiomatized skeleton. Douglas frames this as a discipline for validating non-rigorous physics, including AI-generated physics, without claiming rigor.

**(Req)** Three steps would be needed:
- (i) construct N=2 SU(2) SYM (scalars and fermions; reflection positivity with fermions on the lattice is itself delicate) and prove its Coulomb-branch effective theory;
- (ii) prove the gap for small $m$;
- (iii) follow the soft-breaking deformations ($m\to\infty$, then gluino mass $\to\infty$) to pure YM without a phase transition.

Douglas's 2004 argument [8] is that a solution for a sufficiently general class of SUSY theories plus soft breaking "would in fact imply" the original problem. That is an RG heuristic [H].

**(A)** **Very low as a proof route.** It has more unconstructed fields than pure YM, and the softly broken limit is uncontrolled. **High as an exemplar** of a mechanism derived rather than modelled, and as a Lean methodology: postulates in a quarantined namespace, with machine-checked consequences (§4.3).

### 2.10 Center vortices and center symmetry

**(P/H)**
- **'t Hooft [5,6].** Electric and magnetic flux free energies on a twisted torus classify phases. Confinement corresponds to a perimeter law for the 't Hooft loop and vanishing free energy for thick center vortices.
- **Mack–Petkova [69, 69b] and Yaffe [70b].** Vortex condensation as the confinement mechanism.
- **Lattice:**
  - Del Debbio–Faber–Greensite–Olejník [72]: **center dominance** in maximal center gauge, where center-projected links carry the string tension;
  - de Forcrand–D'Elia [73]: removing vortices kills the string tension *and* chiral symmetry breaking *and* topological charge;
  - Kovács–Tomboulis [74b]: the vortex free energy tends to its confining value at weak coupling in SU(2).
- **Semiclassics.** On $\mathbb R^2\times T^2$ with 't Hooft flux, center vortices are fractional instantons and give a controlled confinement mechanism (Tanizaki–Ünsal [61]). Hayashi–Tanizaki [88] relate monopoles on $\mathbb R^3\times S^1$ to these vortices, unifying the two semiclassical pictures.

**(R) [T]: conditional theorems**
- **Mack–Petkova 1980 [69b].** A sufficient condition for confinement via vortex free energy.
- **Tomboulis–Yaffe 1985 [89].** Rigorous inequalities relating Wilson loops to electric flux and vortex free energies. Kovács–Tomboulis describe the vortex criterion as "rigorously known" to be necessary and sufficient [74b].
- **Durhuus–Fröhlich 1980 [90]**, as restated by Cao–Nissim–Sheffield [47, Thm 2.3]. Let $G\subseteq U(N)$ contain $zI$ for some $z\ne1$. In the height-1 slab σ-model on $\Lambda^{d-1}$, with action $N\beta\sum{\rm Re\,Tr}(Q_xA_eQ_y^{-1}B_e^{-1})$, suppose matrix-entry covariances decay exponentially **uniformly in the boundary fields $A,B$**. Then the $d$-dimensional theory has an area law.
- **Chatterjee 2021 [44].**
  - Thm 2.2: unbroken center symmetry (defined via Gibbs measures on slabs) implies $V(R)\to\infty$ for representations acting nontrivially on the center.
  - Thm 2.4: the strong gap (§1.2) implies unbroken center symmetry and the area law.
- **Nissim 2026 [91] [T-pre].** SO(3), with trivial center, fails Wilson's criterion at strong coupling.

**(D) Tomboulis 2007 [92].** He claims confinement for all couplings in 4D SU(2) via Migdal–Kadanoff-type bounding decimations and the vortex free energy. Ito–Seiler [93] identify a missing inequality, which is provable only where strong-coupling expansions converge. They also note a sanity problem: the argument does not visibly distinguish SU(2) from U(1), which deconfines. **Not accepted** (note 07 §2.11).

**(Req)** Either of two statements:
- (i) prove the DF slab-σ-model decay, or Chatterjee's strong gap, at **weak** coupling in 4D;
- (ii) prove a lower bound on the thick-vortex free energy (vortex condensation) at weak coupling.

**[I] A dimensional obstruction to (i) in 4D.** The DF slab model in $d=4$ is a **3D** G-valued σ-model at inverse temperature ≈ β. At large β, 3D σ-models with continuous symmetry order and are not gapped. DF's route is therefore intrinsically strong-coupling in 4D. Chatterjee's criterion is not slab-based and has no such obvious obstruction.

In **3D**, the slab model is a **2D** principal-chiral-type model in an environment. By Mermin–Wagner and asymptotic-freedom lore it should be gapped at all β. This is why the OpenAI O(n) claim (§2.15) matters.

**(A)**
- **Medium for confinement** given a gap: the reductions exist and are formalizable now.
- **Low-to-medium as a route to the gap itself.** The strong gap is strictly stronger than the Clay gap, and nobody knows whether it holds at weak coupling in 4D.

### 2.11 Gribov–Zwanziger

**(P/H)**
- **Gribov 1978 [94].** Faddeev–Popov gauge fixing in Coulomb/Landau gauge has copies. Restricting to the Gribov region Ω (positive Faddeev–Popov operator) modifies the IR: the gluon propagator is suppressed, $D(k)\sim k^2/(k^4+\gamma^4)$, and the ghost is enhanced.
- **Zwanziger [95, 96].** A local, renormalizable GZ action implementing the horizon condition, and an area-law argument from the fundamental modular region.
- **Kugo–Ojima [97].** A BRST-quartet confinement criterion.
- The gluon propagator **violates reflection positivity**. The gluon is not a physical particle, which is consistent with confinement [Vandersickel–Zwanziger 98].
- **Lattice:**
  - very large lattices give the **"decoupling"** solution: a finite, nonzero gluon propagator at $k=0$, and a ghost propagator whose IR exponent is much weaker than the predicted enhancement. This contradicts the original "scaling" GZ prediction $D(0)=0$ (Cucchieri–Mendes [99]; Bogolubsky et al. [100]);
  - the **refined** GZ action [101] reproduces decoupling;
  - the GZ action breaks BRST softly [98].

**(R) [T]**
- **Singer 1978 [102].** No continuous global gauge slice exists for non-abelian $G$ on $S^4$ (and $S^3$). The Gribov ambiguity is topological.
- **Dell'Antonio–Zwanziger 1991 [103].** Every gauge orbit meets the Gribov region. Convexity of Ω and boundedness in every direction are established in this line of work; I checked the title and metadata, not the full text.
- Existence of absolute minima of $\|A^g\|^2$ along orbits (the fundamental modular region), as recorded in [98].

**(Req)** A gauge-fixed construction (lattice Landau gauge with FMR restriction) in which one proves a gap for **gauge-invariant** correlators. Gauge-variant propagator behaviour neither implies nor is implied by the physical gap.

**(A)** **Low as a route.** Its core objects are gauge-variant, its predictions shifted under lattice scrutiny, and BRST is broken. **Useful technical facts:** Singer's theorem means global gauge fixing is impossible, which is why Balaban-type proofs gauge-fix locally in blocks. The boundedness and convexity of Ω are rigorous geometric inputs, potentially useful in Feynman-type orbit-space arguments [I].

### 2.12 Holography as heuristic (Witten 1998; Klebanov–Strassler; related)

**(P/H)**
- **Maldacena [104]; Gubser–Klebanov–Polyakov [105]; Witten [106].** The AdS/CFT dictionary.
- **Witten 1998 [107].**
  - The thermal phase transition of N=4 SYM is the Hawking–Page transition.
  - Compactifying D4-branes on a circle with antiperiodic fermions gives a proposed dual of large-N **non-SUSY 4D YM**. The area law follows because the warp factor is bounded below. The mass gap follows from discrete spectra of supergravity wave operators on the capped geometry.
  - **Witten himself** says it is not clear how to show asymptotic freedom. The 4D gauge-theory "mysteries" are encoded near a singularity of the string background where supergravity fails.
- **Gross–Ooguri [108].** This is analogous to strong-coupling lattice gauge theory: glueball masses scale with the compactification (cutoff) scale $T$. A true continuum limit needs control of string theory in a singular, Ramond–Ramond-charged background.
- **Glueball spectra from supergravity.** Csáki–Ooguri–Oz–Terning [109]; Brower–Mathur–Tan [110]. The ratios are roughly lattice-like, but the Kaluza–Klein modes do not decouple.
- **Klebanov–Strassler 2000 [111].**
  - The N=1 cascading $SU(N+M)\times SU(N)$ theory is dual to the warped deformed conifold.
  - Confinement and chiral symmetry breaking arise geometrically from the deformation.
  - They suggest that pure N=1 SYM may be dual to strings on this background at **small** $g_sM$, where supergravity is not valid.
  - Glueball spectra: Berg–Haack–Mück [112]; Dymarsky–Melnikov [113].
- **Further holographic diagnostics of confinement:**
  - flux-tube dynamics (Klebanov–Maldacena–Thorn [114]; this studies the static-quark string in **N=4 SYM**, a conformal, non-confining theory, so it is a diagnostic of flux-tube excitations and not of confinement);
  - entanglement entropy as a confinement probe (Klebanov–Kutasov–Murugan [115]);
  - θ-dependence at large N (Witten [116]).

**(R)** None for 4D gauge theory. Given the background, the spectral statements are rigorous ODE/Sturm–Liouville facts, but the duality is a conjecture.

**(Req)** A non-perturbative definition of the string theory and a proof of the duality, both far beyond present mathematics. Alternatively, holography could be used only to *guess* an effective description whose consequences are then proven independently.

**(A)** **Very low as a route.** As Jaffe–Witten note, it has made surprising progress for strongly coupled theories with matter but has no effective approach to pure YM [3]. **Value:** intuition for the mass gap as "geometry caps off", and for area law as a minimal surface with a tension floor.

### 2.13 Semiclassics and resurgence on $\mathbb R^3\times S^1$ and $\mathbb R^2\times T^2$ (Ünsal–Yaffe and successors)

**(P/H)**
- **Ünsal–Yaffe 2008 [62].** Add a double-trace deformation $\sum_k a_k|{\rm tr}\,\Omega^k|^2$ of Polyakov loops to SU(N) YM on $\mathbb R^3\times S^1_L$, keeping center symmetry unbroken at small $L$.
  - With $NL\Lambda\ll1$, the theory abelianizes to $U(1)^{N-1}$, with $m_W=2\pi/(NL)$.
  - Monopole-instantons, carrying $1/N$ of the instanton action, generate a dual-photon potential.
  - Hence a **mass gap** $m_\gamma^2\sim m_W^2\,(2\pi/g^2N)^3e^{-8\pi^2/(g^2N)}$ and linear confinement, analytically controlled.
  - No order parameter distinguishes small from large $L$, so they **conjecture continuity** to $\mathbb R^4$.
- **Ünsal [117].** In QCD(adj) and N=1 SYM, confinement comes from **magnetic bions** (monopole–anti-KK-monopole molecules). Ünsal states the extension to $\mathbb R^4$ is not known.
- Continuity of deconfinement physics: Poppitz–Schäfer–Ünsal [118].
- SW confinement and "Polyakov-like" bion confinement are continuously connected: Poppitz–Ünsal [119].
- **Resurgence:** trans-series, bions and renormalons (Argyres–Ünsal [120]; Dunne–Ünsal for $\mathbb{CP}^{N-1}$ [121]).
- **'t Hooft flux on $T^2$** (Yamazaki–Yonekura [122]; Tanizaki–Ünsal [61]; Poppitz–Wandler [123]). This gives 2D weak-coupling descriptions via $\mathbb{CP}^{N-1}$ fractional instantons and center vortices, with anomaly matching to 4D. Tanizaki–Ünsal **conjecture** adiabatic continuity.
- **Lattice support for continuity:** trace-deformed SU(3) "reconfinement" (Bonati et al. [124]); 2026 flux-tube studies in trace-deformed 3D SU(2) [125].

**(R)** None rigorous. The semiclassical regime is controlled in the physicist's sense: a small parameter and a dilute gas. No constructive treatment exists even for the 3D Georgi–Glashow analogue (§2.7).

**(Req)** A rigorous **milestone theorem** that would be a first: *"For deformed SU(N) YM on $\mathbb R^3\times S^1_L$ with $NL\Lambda$ sufficiently small, the theory exists (OS axioms in the $\mathbb R^3$ directions) and has a mass gap."* It needs:
- (i) 4D UV control on $\mathbb R^3\times S^1$, essentially Balaban (or the claimed OpenAI construction) with one compact direction;
- (ii) rigorous integration of the W-bosons and KK modes, giving an effective 3D theory;
- (iii) a Göpfert–Mack-type Coulomb-gas analysis with non-abelian monopole-instantons;
- (iv) for Clay, **continuity** in $L$ up to $\infty$. No technique is known that excludes phase transitions along a one-parameter family outside an analyticity domain of convergent expansions [I].

A further technical caution [I]: the double-trace term is non-local along $S^1$. Reflection positivity in the $\mathbb R^3$ directions should survive, but this needs checking.

**(A)**
- **Medium as a milestone**: the first rigorous gap in a locally 4D non-abelian gauge theory, likely Fields-level if achieved.
- **Low as a Clay route**, because of continuity.
- Strategically this is the most attractive "intermediate theorem" for an AI swarm. Each stage, (i) to (iii), has precedents.

### 2.14 Anomalies and generalized symmetries as constraints (not mechanisms)

**(H, physics-rigorous)**
- **Gaiotto–Kapustin–Komargodski–Seiberg [126].** At θ=π, a mixed 't Hooft anomaly between the $\mathbb Z_N$ one-form center symmetry and time reversal forbids a trivially gapped non-degenerate vacuum. At θ=0 the vacuum is (standardly assumed) gapped and trivial; the anomaly is silent there.
- **Aharony–Seiberg–Tachikawa [127].** The global form ($SU(N)$ vs $PSU(N)$, line operators) matters for which loops can confine.

**(A)** These are **constraints**, not mechanisms. A proposed Clay proof must be θ-specific (the Clay problem is θ=0) and must not prove a trivial gap at θ=π. Good **negative tests** for formal statements and AI-generated arguments [I].

### 2.15 Comparator theories: where a gap *has* been proven, or is now claimed

| System | Gap status | Mechanism | Lesson |
|---|---|---|---|
| Higgs models on unit lattice, weak coupling [70] | [T] | classical (Higgs) mass | gap visible classically; not the YM difficulty |
| Abelian Higgs, continuum-type multiscale [71b] | [T] | Higgs + RG | multiscale cluster properties are achievable |
| SU(2) YM–Higgs scaling limit (Chatterjee [134]) | [T] (PMP 7 (2026); note 07) | Higgs, Gaussian limit | free limit |
| Large-N Gross–Neveu [76] | [T] | dynamical mass generation (AF) | an AF transmuted gap is provable at large N |
| Cutoff large-N O(N) σ-model [77] | [T] | same | Douglas cites it as the regulated σ-model in which a gap "has been exhibited" [8] |
| O(N) linear σ-model on $\mathbb R^2$, large-N scaling (Delgadino–Smith 2026 [128]) | [T-pre] | large-N, mass $\sim e^{-c\beta}$ | stochastic-analysis route to transmuted mass |
| 2D O(3), O(4) exact masses (Hasenfratz–Maggiore–Niedermayer [129]) | [H] (integrability/TBA) | exact S-matrix | precise target values |
| **2D O(n), n≥3, all β (OpenAI `openai/math` family 215 [130])** | **[C]** | claimed proof of Polyakov's conjecture. A Lean statement and a claimed full Lean proof (~115 files) exist; the catalogue review status is `unchecked`; not replayed by us (note 04) | if correct, the first rigorous transmuted gap at finite N in an AF model |
| 3D U(1) [31] | [T] | Polyakov monopoles | duality and Coulomb gas |
| 4D U(1), weak coupling [33,34] | [T] **no gap** | Coulomb phase | the decisive negative test |

**About the OpenAI family-215 claim [C].** The Comparator challenge statement (`ClassicalON.lean`, 60 lines, which I read) has this shape:

> For every $n\ge3$ and $\beta>0$ there exist $A$ and $m>0$ such that, for **every finite** subgraph of $\mathbb Z^2$ with free boundary and **every** inhomogeneous coupling $b_e\in[0,\beta]$, the spin–spin correlation satisfies $0\le\langle\sigma_x\cdot\sigma_y\rangle\le Ae^{-m|x-y|}$.

The natural-language headline goes much further: a canonical massive continuum O(3) theory, a gap, and exact O(4) asymptotics $m_{\rm lat}\sim32e^{\pi/4-1/2}\sqrt\beta e^{-\pi\beta}$. That formula coincides with the Hasenfratz–Maggiore–Niedermayer value converted to lattice units (my check) [I]. *(Verifier: re-derived independently. HMN give $m/\Lambda_{\overline{MS}}=\sqrt{8/e}/\Gamma(3/2)$ for O(4); the standard-action lattice ratio is $\Lambda_{\overline{MS}}/\Lambda_L=\sqrt{32}\,e^{\pi/4}$; and $a\Lambda_L=\sqrt{\pi\beta}\,e^{-\pi\beta}$. Together these reproduce $32e^{\pi/4-1/2}\sqrt\beta e^{-\pi\beta}$, assuming the action is $\beta\sum\sigma\cdot\sigma$.)* The headline is **not** formalized. `lean/docs/215.md` says the infinite-volume limit and the O(4) gap claim are excluded (note 04).

**Status of the formal proof** (verifier, 2026-11-05):
- `lean/formalization.yaml` registers `OAI.ClassicalON.main` in `OAI/Probability/ClassicalON/Main.lean` as a main result with a Comparator config.
- That directory holds about 115 Lean files.
- The catalogue's review field reads `unchecked`.
- If the build and the Comparator replay succeed, the *finite-volume, uniform-in-environment lattice statement* would be machine-checked, modulo how faithfully the statement is written. That is stronger than an unformalized [C] claim. It still says nothing about the continuum headline.

Two features stand out for this workstream [I]:
- (a) The quantifier structure is uniform over volumes and over **inhomogeneous environments**. This is *similar in kind* to the uniformity the Durhuus–Fröhlich reduction needs (§2.10), but weaker in one important way. The environments here are scalar ferromagnetic couplings $b_e\in[0,\beta]$. DF needs uniformity over matrix-valued twists $Q_xA_eQ_y^{-1}B_e^{-1}$, which are not ferromagnetic. Correlation inequalities that need ferromagnetism (Ginibre/FKG-type) would not transfer directly. *(Verifier: the original said "exactly the kind of uniformity" DF needs. That overstates the match.)*
- (b) The mass must be exponentially small in β, as AF requires. Any correct proof has thus handled a dimensional-transmutation gap, the 2D prototype of the YM difficulty. Douglas reportedly described the 2D σ-model as the widely accepted "warm-up" for YM (SciAm, via note 02). *(Verifier: the original could be read as Douglas endorsing this particular proof.)*

### 2.16 Witten's (and Jaffe's) remarks in the Clay description, and Douglas's 2004 status report

**Jaffe–Witten [3]**, paraphrased:
1. QCD must exhibit the mass gap, confinement and chiral symmetry breaking at the quantum level, all very different from the classical theory. No convincing theoretical computation of any of the three exists for QCD itself, as opposed to simplified truncations.
2. Clustering (exponential decay) follows from the gap. Clustering may let results on $\mathbb R^4$ transfer to 4-manifolds, as heuristically for supersymmetric theories (Witten 1994 [132]).
3. Even with a construction on $T^4$, no current idea points to a gap uniform in volume, nor to the limit $T^4\to\mathbb R^4$. A uniform finite-volume gap may be fundamental to the infinite-volume limit.
4. Because the gap is not classically visible, a proof may require a non-classical change of variables or **duality**, as in Debye screening via sine-Gordon (Brydges–Federbush).
5. The gap might come from the quartic potential and orbit-space curvature (Feynman; Singer). Flat directions can still yield bound states (Simon).
6. The large-N/string duality might explain the gap and confinement and give a rigorous starting point for large N. Progress exists with matter (Maldacena), but there is none for pure YM. SUSY and string methods give other approaches with matter (Seiberg–Witten).
7. Weak existence via compactness alone is excluded unless properties of the limit, such as the gap and the axioms, are also established (their footnote 2).

**Douglas 2004 [8]**, paraphrased:
- No breakthrough had been made. The state of the art was Balaban and Magnen–Rivasseau–Sénéor.
- Two analogue classes: 2D σ-models on positively curved targets, not constructed to Clay standards but with a regulated large-N O(N) gap (Kopper); and 4D SUSY YM.
- Soft SUSY breaking could transfer a SUSY solution to pure YM (heuristic).
- Nekrasov's instanton derivation of SW is the simplest 4D result carrying mass-gap physics.
- N=4 integrability might reshape the problem.

### 2.17 Work by the shepherding-committee members bearing on mechanisms

The 2026 committee is Gross (chair), Douglas, Jaffe, Klebanov and Nekrasov (note 02). *(Verifier: the press coverage found in this pass names the five but describes the artifacts as still withheld. On 26 Oct 2026 the AGMAI asked OpenAI to release them.)*
- **Gross:** asymptotic freedom [1]; Gross–Witten large-N lattice transition [24]; Gross–Ooguri holographic large-N dynamics [108].
- **Douglas:**
  - Douglas–Shenker [67];
  - Douglas–Kazakov [23];
  - the 2004 Clay status report [8];
  - Lean formalization of the free-field OS axioms (Douglas–Hoback–Mei–Nissim [131]);
  - the SW solution as Lean theorems from explicit postulates [87];
  - the `lgt` Lean repository with a strong-coupling gap (note 07).
- **Jaffe:** the Clay description [3]; the Higgs mass gap (BBIJ [70]; BIJ [71b]).
- **Klebanov:** Klebanov–Strassler [111]; GKP [105]; KMT flux tubes [114]; KKM entanglement probe [115].
- **Nekrasov:** instanton counting [83] and Nekrasov–Okounkov [84]. These are the rigorous-mathematics end of the SW mechanism.

**[I]** The committee's centre of gravity is Balaban-style RG (existence) plus deep knowledge of the SUSY, holographic and large-N heuristics. None of those heuristics is a rigorous gap tool. A mass-gap proof would most likely be judged on **RG/IR estimates**, not on mechanism narratives.

---

## 3. What is proven vs open

| Statement | Status | Refs |
|---|---|---|
| β-function coefficients $b_0,b_1$; AF | [T] (perturbative) | 1,2 |
| Finite-volume lattice transfer matrix has a gap (Perron–Frobenius) | [T] (folklore-level, standard) | 7,17 |
| 4D lattice YM gap and area law at strong coupling | [T] (OS78, SZZ23); [T-pre] for the 2025 extensions 46–48, which are arXiv-only as of this check | 7,45,46,47,48 |
| 4D lattice YM gap at weak coupling (continuous non-abelian G) | **Open** | note 07 |
| 4D continuum YM mass gap (Clay) | **Open**; not claimed by OpenAI or the committee | 3, note 02 |
| 3D U(1) LGT area law at all couplings | [T] | 31 |
| 3D U(n)-type (central U(1)) log-confinement at all couplings | [T] (Fröhlich + Glimm–Jaffe); short proof [T-pre] | 37,38,39 |
| 3D non-abelian LGT (SU(N)) confinement or gap at all couplings | **Open** | — |
| 3D YM mass gap via KKN/Nair inequality | [H] programme | 27,82 |
| 4D U(1) has a massless deconfined phase | [T] | 33,34 |
| Finite gauge groups: gap at weak coupling (4D) | [T] (Ann. Probab. 2025) | 49 |
| Finite gauge groups: perimeter law at weak coupling ($d\ge3$) | [T] | 135,136,137 |
| SO(3) (trivial center) fails Wilson criterion at strong coupling | [T-pre] | 91 |
| Strong gap ⇒ area law (nontrivial center) | [T] | 44 |
| Slab σ-model gap (uniform in boundary) ⇒ area law | [T] | 90, 47 |
| Vortex free energy criteria ⇔ confinement | [T] (conditional) | 69b, 89 |
| Tomboulis: 4D SU(2) confinement at all couplings | [D] | 92,93 |
| Polyakov mechanism in 3D SU(2) Georgi–Glashow | [H]; rigorous proof not found | 36 |
| Deformed YM on $\mathbb R^3\times S^1$: gap at small L | [H] (controlled semiclassics) | 62 |
| Continuity of deformed/twisted YM to $\mathbb R^4$ | [H] conjecture; lattice support | 61,62,124 |
| SW: monopole condensation and confinement in softly broken N=2 | [H] | 32 |
| SW prepotential = instanton sum | [T] (mathematics) | 83–86 |
| Holographic gap and area law for large-N YM | [H] (supergravity regime, not YM) | 107,108 |
| GZ scaling IR propagators | [D] by lattice (decoupling observed); RGZ [H] | 99–101 |
| Every gauge orbit meets the Gribov region; Ω convex and bounded | [T] | 103 |
| No global continuous gauge slice (non-abelian) | [T] | 102 |
| Large-N GN and cutoff O(N) σ-model mass generation | [T] | 76,77 |
| 2D O(n≥3) exponential decay at all β (Polyakov conjecture) | **[C]**. OpenAI family 215; a Lean proof is claimed but has not been independently replayed | 130 |
| KKN string tension exact | [D] (≈1% off at N=∞, ≈6σ) | 60 |
| θ=π: no trivially gapped vacuum | [H, physics-rigorous anomaly argument] | 126 |

---

## 4. Relevance to a 4D YM existence + mass-gap proof and to Lean formalization

### 4.1 Mechanisms ranked as proof strategies [I]

| Rank | Route | Rigorous foothold | Theorem needed | Main obstruction | Plausibility |
|---|---|---|---|---|---|
| 1 | **RG crossover** (Balaban/OpenAI existence, then IR flow, then a strong-coupling terminal regime) | UV: Balaban [T], OpenAI [C]; terminal: OS, SZZ, CNS [T] | Uniform-in-volume control of the effective action from $g\ll1$ to $g_*$ in a cluster-expandable or strong-gap regime | The crossover window ($\beta_{\rm LQCD}\approx0.4\to6$ for SU(3)); large fields; non-convexity | Low but non-zero; the only route matching the problem's structure |
| 2 | **Strong gap ⇒ gap + confinement** | Chatterjee; DF [T] | Strong gap at weak coupling | Unknown whether true in 4D; DF slab version obstructed in 4D | Medium as a *reduction*; the gap itself is still open |
| 3 | **Semiclassical islands** (deformed $\mathbb R^3\times S^1$; twisted $T^2$) | Göpfert–Mack-type 3D tools [T] | Gap at small $L$ (milestone); continuity (Clay) | Non-abelian Coulomb gas; continuity unknown | Medium (milestone); low (Clay) |
| 4 | **Hamiltonian/orbit space** (Feynman, KKN, Nair) | Simon/Lüscher finite-dimensional [T] | $T^2-mT\ge0$ plus a renormalized $V\ge0$ (3D) | Regularization; no 4D analogue; Orland's flat directions | Medium (3D); very low (4D) |
| 5 | **Large N** | Strong-'t-Hooft-coupling theorems [T] | Weak-coupling master field with a gap | Bulk/GW transitions; asymptotic $1/N$; all $G$ needed | Low |
| 6 | **Center vortices / dual superconductor** (direct) | Conditional theorems [T] | Vortex condensation at weak coupling | No weak-coupling handle; gauge dependence (MAG) | Low |
| 7 | **Gribov–Zwanziger** | Gribov-region geometry [T] | Gauge-invariant gap from gauge-fixed IR | Gauge-variant objects; BRST breaking | Very low |
| 8 | **SUSY/SW + soft breaking; holography** | Instanton counting [T] (math only) | Construct N=2 SYM or string theory; control deformations | Everything | Very low |

### 4.2 A proof architecture suggested by the mechanisms [I]

The mechanisms point to a **three-layer** architecture. Each layer is a separately statable, separately checkable theorem.

- **(L1) UV layer.** Construction with uniform UV bounds along the AF trajectory. This is Balaban, or OpenAI's claim once released (notes 02, 05). Output: effective actions $S_k$ on blocked lattices at scales $L^k a$, with explicit small-field/large-field structure, valid while $g_k\le\bar g$.
- **(L2) Crossover layer.** **The missing mathematics.** Continue control past $\bar g$ to a scale where a strong-coupling criterion holds. Candidates:
  - (i) multiscale Bakry–Émery / log-Sobolev for effective actions (note 07 §4);
  - (ii) Chatterjee-type strong decay for the blocked theory, proven by a *finite-β* computer-assisted certificate at one scale, then propagated (in the spirit of Kazakov–Zheng bootstrap bounds) [speculative];
  - (iii) a Durhuus–Fröhlich-type reduction of 3D statements to 2D σ-model gaps, then feeding 3D results into a 4D argument through a dimensional-reduction step on $\mathbb R^3\times S^1$ [speculative].
- **(L3) IR layer.** From a strong-coupling criterion at scale $L_*$, deduce the continuum gap $m\ge c/L_*$ (OS, SZZ, CNS-type theorems [T]), and confinement through Chatterjee or DF [T] for groups with nontrivial center.

Mechanism heuristics serve as **guides to which observables to control in L2**:
- Polyakov loops and center symmetry (Chatterjee);
- 't Hooft loops and vortex free energies (Mack–Petkova, Tomboulis–Yaffe);
- orbit-space curvature (Feynman, KKN, Bakry–Émery).

Holography, SW and GZ do not identify a controllable quantity on the lattice.

### 4.3 Lean formalization recommendations [I]

1. **Make the gap statement non-vacuous.**
   - The finite-volume gap is trivial (Perron–Frobenius), so the formal statement must assert the gap for the infinite-volume, continuum theory: a uniform lower bound across volumes and along the AF trajectory.
   - The OpenAI `ClassicalON.lean` statement, ∀ finite subgraph ∀ environment ≤ β ∃ uniform $(A,m)$, is a good syntactic template for lattice-level uniformity (note 04).
   - For continuum statements, follow note 01's architecture.

2. **Add negative tests ("sanity theorems") to the project.** These are formally stated, ideally eventually proven, results that a proposed gap proof must not contradict:
   - (a) 4D U(1) has no gap at weak coupling [33,34]. Formalizing Fröhlich–Spencer is large, so start with the *statement*.
   - (b) Finite-group weak-coupling theories are gapped [49] but deconfined [135–137] (in $d\ge3$).
   - (c) Strong-coupling SO(3) fails the Wilson criterion [91].

   AI-generated arguments should be required to state which hypothesis (non-abelian, center, AF) blocks each counterexample (cf. Ito–Seiler's U(1) objection to Tomboulis).

3. **Early, cheap formalization targets that build the needed infrastructure:**
   - Chatterjee 2026, 3D log-confinement with central U(1), 13 pages [39];
   - Chatterjee 2021, strong gap ⇒ area law [44];
   - Durhuus–Fröhlich slab reduction [90] (via CNS's restatement [47]);
   - extending Douglas's `lgt` strong-coupling gap to SU(N) and to the CNS area-law regime.

   These give Wilson-loop, Gibbs-measure and conditioning libraries that any later gap proof needs.

4. **Medium targets (milestones):**
   - Göpfert–Mack (3D U(1), all β; about 60 journal pages of block-spin RG). This is the first formal proof of a non-perturbative gauge-theory area law at all couplings, and it exercises duality and Coulomb-gas RG.
   - The KKN/Nair 3D inequality, once a rigorous version exists.

5. **Quarantine physics postulates** in Douglas's style [87]. If mechanisms (SW effective action, monopole condensation, continuity) are encoded at all, do it as named axioms in a separate namespace. Use Comparator-style axiom audits to guarantee the main theorem does not import them (notes 03, 04).

6. **Use numerical oracles as tests, not proofs.** Lattice ratios ($M_{0^{++}}/\sqrt\sigma\approx3.4$ for SU(3); the KKN 1% discrepancy; k-string ratios) can serve as regression tests for heuristic modules, as Douglas uses an independent numerical oracle for SW [87].

### 4.4 Implications for organizing an AI swarm (approach only, per the user's framing) [I]

These are informed by notes 03/04 on OpenAI's agentic method.
- **Assign agents by layer (L1/L2/L3), not by mechanism.** Use mechanism experts as *critics*: each L2 attempt must say which mechanism-observable it controls and must pass the negative tests above.
- **Exploit conditional theorems as interfaces.** "Prove strong gap at scale $L_*$" is a crisp, formally statable sub-goal whose consequence (gap + area law) is already a theorem. Such interface statements are what make swarm decomposition verifiable.
- **Treat 2D and 3D milestones as calibration problems.** Examples: the 2D O(n) all-β decay (to be independently replayed from OpenAI's release), the 3D SU(N) area law via DF, and deformed YM on $\mathbb R^3\times S^1$. A pipeline that cannot do these is unlikely to do 4D.

---

## 5. Open questions and leads

1. **Audit OpenAI family 215** (2D O(n) all-β decay; Lean challenge `ClassicalON.lean`). Replay the Comparator check independently and read the natural-language proof for its IR mechanism. Does it use a Mermin–Wagner/complex-rotation argument plus multiscale RG, or a percolation argument (cf. Patrascioiu–Seiler's dissent)? It is the closest existing claimed analogue of a YM gap proof. *Verifier lead:* the Lean directory `lean/OAI/Probability/ClassicalON/` contains files named `ComplexWard.lean`, `RotationInequality.lean`, `IsingGinibre.lean`, `FinFKG.lean` and `CoarseExponential.lean`. The names suggest complex-rotation/Ward identities and ferromagnetic correlation inequalities. That is an inference from file names only; the files were not read.
2. **3D SU(N) lattice confinement at all β via Durhuus–Fröhlich.** Prove that 2D principal-chiral models in an arbitrary U(N) "twist environment" (the DF slab model) have exponential decay uniform in the environment. Check whether the family-215 method extends from O(n) to G-valued models with twisted couplings.
3. **Upgrade Chatterjee 2026** from log-confinement to an area law in 3D U(n) by combining Fröhlich's comparison with Göpfert–Mack. Chatterjee flags this.
4. **Rigorous 3D Georgi–Glashow Polyakov mechanism** (SU(2) plus adjoint Higgs, weak coupling): the non-abelian analogue of Göpfert–Mack and a stepping stone to deformed YM on $\mathbb R^3\times S^1$. Search the literature further to confirm it is open (my search was not exhaustive).
5. **Is Chatterjee's strong gap true for 4D SU(N) at weak coupling?** Test numerically: correlation decay under adversarial boundary conditions. If false, the "strong gap ⇒ confinement" interface must be replaced by a weaker one.
6. **Deformed YM on $\mathbb R^3\times S^1$** as a milestone theorem. Check reflection positivity of the double-trace term in the $\mathbb R^3$ directions, and the compatibility of Balaban-type UV control with one compact direction.
7. **What does OpenAI's existence proof control in the IR?** The committee asserts control "to infinite distances" without a gap (note 02). If true, the estimates used there (exponential decay of *something*?) might be the natural input to L2.
8. **Multiscale Bakry–Émery** for RG effective actions (note 07 §4). Can SZZ-type curvature arguments be run on blocked actions at intermediate coupling?
9. **Certified bootstrap at finite β** (Kazakov–Zheng-type SDP bounds made rigorous). Could a certified strong-decay bound at one β (in the crossover window), plus an RG propagation lemma, close L2? [speculative]
10. **KKN/Nair:** make $T^2-mT\ge0$ rigorous on a lattice-regularized orbit space in 2+1D. Identify which step uses 2D space essentially.
11. **Gribov-region geometry** (convex, bounded) as an input to orbit-space Poincaré inequalities [speculative].
12. **Bulk transitions:** for any analytic-continuation strategy, pick a lattice action (e.g. Wilson for SU(2)/SU(3), or improved actions) for which a crossover, not a first-order bulk transition, connects strong and weak coupling. Note that Clay requires all compact simple $G$, including large-N SU(N), where the Wilson action has a bulk transition.

---

## References

"verified" = existence confirmed this session via the arXiv API, the Crossref API, publisher metadata, or by fetching the document. The PDF column notes whether an arXiv PDF is in `library/pdfs`.

1. D. J. Gross, F. Wilczek, *Ultraviolet behavior of non-abelian gauge theories*, PRL 30 (1973) 1343. DOI 10.1103/PhysRevLett.30.1343. **verified**.
2. H. D. Politzer, *Reliable perturbative results for strong interactions?*, PRL 30 (1973) 1346. DOI 10.1103/PhysRevLett.30.1346. **verified**.
3. A. Jaffe, E. Witten, *Quantum Yang–Mills Theory* (Clay official problem description). https://www.claymath.org/wp-content/uploads/2022/06/yangmills.pdf. **verified** (fetched; text extracted).
4. K. G. Wilson, *Confinement of quarks*, PRD 10 (1974) 2445. DOI 10.1103/PhysRevD.10.2445. **verified**.
5. G. 't Hooft, *On the phase transition towards permanent quark confinement*, NPB 138 (1978) 1. DOI 10.1016/0550-3213(78)90153-0. **verified**.
6. G. 't Hooft, *A property of electric and magnetic flux in non-Abelian gauge theories*, NPB 153 (1979) 141. DOI 10.1016/0550-3213(79)90595-9. **verified**.
7. K. Osterwalder, E. Seiler, *Gauge field theories on a lattice*, Ann. Phys. 110 (1978) 440. DOI 10.1016/0003-4916(78)90039-8. **verified**.
8. M. R. Douglas, *Report on the Status of the Yang–Mills Millenium Prize Problem* (Clay, April 2004). Copy at https://ncatlab.org/nlab/files/Douglas-StatusOfYMMillenniumProb.pdf. **verified** (fetched; read in full).
9. M. Creutz, *Monte Carlo study of quantized SU(2) gauge theory*, PRD 21 (1980) 2308. DOI 10.1103/PhysRevD.21.2308. **verified**.
10. C. Morningstar, M. Peardon, *The glueball spectrum from an anisotropic lattice study*, PRD 60 (1999) 034509. arXiv:hep-lat/9901004. **verified**; PDF downloaded.
11. Y. Chen et al., *Glueball spectrum and matrix elements on anisotropic lattices*, PRD 73 (2006) 014516. arXiv:hep-lat/0510074. **verified**.
12. A. Athenodorou, M. Teper, *SU(N) gauge theories in 3+1 dimensions: glueball spectrum, string tensions and topology*, JHEP 12 (2021) 082. arXiv:2106.00364. **verified**; PDF downloaded. (SU(3) companion: arXiv:2007.06422, JHEP 11 (2020) 172, **verified**.)
13. M. Teper, *SU(N) gauge theories in 2+1 dimensions*, PRD 59 (1999) 014512. arXiv:hep-lat/9804008. **verified**. Also M. Teper, *Large N and confining flux tubes as strings — a view from the lattice*, arXiv:0912.3339. **verified**.
14. B. Lucini, M. Teper, U. Wenger, *Glueballs and k-strings in SU(N) gauge theories: calculations with improved operators*, JHEP 06 (2004) 012. arXiv:hep-lat/0404008. **verified**. Also B. Lucini, M. Teper, PRD 66 (2002) 097502, arXiv:hep-lat/0206027. **verified**.
15. B. Lucini, M. Panero, *SU(N) gauge theories at large N*, Phys. Rep. 526 (2013) 93. arXiv:1210.4997. **verified**; PDF downloaded.
16. M. Lüscher, P. Weisz, *Quark confinement and the bosonic string*, JHEP 07 (2002) 049. arXiv:hep-lat/0207003. **verified**.
17. E. Seiler, *Gauge Theories as a Problem of Constructive QFT and Statistical Mechanics*, Lecture Notes in Physics 159 (1982). DOI 10.1007/3-540-11559-5. **verified**.
18. G. 't Hooft, *A planar diagram theory for strong interactions*, NPB 72 (1974) 461. DOI 10.1016/0550-3213(74)90154-0. **verified**.
19. Yu. Makeenko, A. Migdal, *Exact equation for the loop average in multicolor QCD*, PLB 88 (1979) 135. DOI 10.1016/0370-2693(79)90131-X. **verified**.
20. T. Eguchi, H. Kawai, *Reduction of dynamical degrees of freedom in the large-N gauge theory*, PRL 48 (1982) 1063. DOI 10.1103/PhysRevLett.48.1063. **verified**.
21. B. Driver, B. Hall, T. Kemp, *Three proofs of the Makeenko–Migdal equation for Yang–Mills theory on the plane*, CMP 351 (2017) 741. arXiv:1601.06283. **verified**.
21b. T. Lévy, *The master field on the plane*, arXiv:1112.2452 (Astérisque 388, 2017). **verified** (arXiv API; the Astérisque venue is from memory and was not checked). *[Added by the verifier: §2.4 cites it, but the original list did not include it.]*
22. J. Greensite, *The confinement problem in lattice gauge theory*, Prog. Part. Nucl. Phys. 51 (2003) 1. arXiv:hep-lat/0301023. **verified**; PDF downloaded. (Also B. Driver, F. Gabriel, B. Hall, T. Kemp, CMP 352 (2017) 967, arXiv:1602.03905, **verified**.)
23. M. R. Douglas, V. A. Kazakov, *Large N phase transition in continuum QCD₂*, PLB 319 (1993) 219. arXiv:hep-th/9305047. **verified**.
24. D. J. Gross, E. Witten, *Possible third-order phase transition in the large-N lattice gauge theory*, PRD 21 (1980) 446. DOI 10.1103/PhysRevD.21.446. **verified**.
25. R. P. Feynman, *The qualitative behavior of Yang–Mills theory in 2+1 dimensions*, NPB 188 (1981) 479. DOI 10.1016/0550-3213(81)90005-5. **verified** (metadata; the paywalled text was not read, so the argument is reported via [27,28,30]). Clay's bibliography misprints the title as "quantitative".
26. B. Simon, *Some quantum operators with discrete spectrum but classically continuous spectrum*, Ann. Phys. 146 (1983) 209. DOI 10.1016/0003-4916(83)90057-X. **verified**. (Also I. M. Singer, *The geometry of the orbit space for non-abelian gauge theories*, Phys. Scripta 24 (1981) 817, DOI 10.1088/0031-8949/24/5/002, **verified**.)
27. D. Karabali, C. Kim, V. P. Nair, *Planar Yang–Mills theory: Hamiltonian, regulators and mass gap*, NPB 524 (1998) 661. arXiv:hep-th/9705087. **verified**; PDF downloaded. Also Karabali–Nair, NPB 464 (1996) 135, arXiv:hep-th/9510157, **verified**; Karabali–Kim–Nair, PLB 434 (1998) 103, arXiv:hep-th/9804132, **verified**; Karabali–Nair, arXiv:hep-th/9610002, **verified**.
28. P. Orland, *The metric on the space of Yang–Mills configurations*, arXiv:hep-th/9607134. **verified**. (Also P. Orland, PRD 74 (2006) 085001, arXiv:hep-th/0607013, **verified**.)
29. J. Magnen, V. Rivasseau, R. Sénéor, *Construction of YM₄ with an infrared cutoff*, CMP 155 (1993) 325. DOI 10.1007/BF02097397. **verified**.
30. V. P. Nair, *The Schrödinger representation and 3d gauge theories* (review), arXiv:2308.13926. **verified**.
31. M. Göpfert, G. Mack, *Proof of confinement of static quarks in 3-dimensional U(1) lattice gauge theory for all values of the coupling constant*, CMP 82 (1982) 545. DOI 10.1007/BF01961240. **verified** (metadata; full text not accessed; content per [39]).
32. N. Seiberg, E. Witten, *Electric–magnetic duality, monopole condensation, and confinement in N=2 supersymmetric Yang–Mills theory*, NPB 426 (1994) 19; erratum NPB 430 (1994) 485. DOI 10.1016/0550-3213(94)90124-4. arXiv:hep-th/9407087. **verified**; PDF downloaded. *(Verifier: full title restored from the PDF; arXiv metadata omits "Electric–magnetic duality".)*
33. A. Guth, *Existence proof of a nonconfining phase in four-dimensional U(1) lattice gauge theory*, PRD 21 (1980) 2291. DOI 10.1103/PhysRevD.21.2291. **verified**.
34. J. Fröhlich, T. Spencer, *Massless phases and symmetry restoration in abelian gauge theories and spin systems*, CMP 83 (1982) 411. DOI 10.1007/BF01213610. **verified**.
35. A. M. Polyakov, *Compact gauge fields and the infrared catastrophe*, PLB 59 (1975) 82. DOI 10.1016/0370-2693(75)90162-8. **verified**.
36. A. M. Polyakov, *Quark confinement and topology of gauge theories*, NPB 120 (1977) 429. DOI 10.1016/0550-3213(77)90086-4. **verified**.
37. J. Glimm, A. Jaffe, *Quark trapping for lattice U(1) gauge fields*, PLB 66 (1977) 67. DOI 10.1016/0370-2693(77)90615-3. **verified**.
38. J. Fröhlich, *Confinement in Z_n lattice gauge theories implies confinement in SU(n) lattice Higgs theories*, PLB 83 (1979) 195. DOI 10.1016/0370-2693(79)90684-1. **verified**.
39. S. Chatterjee, *A short proof of confinement in three-dimensional lattice gauge theories with a central U(1)*, arXiv:2602.00436 (2026; v2, 8 Jun 2026, 13 pp.). **verified**; PDF downloaded and content checked.
40. D. Brydges, P. Federbush, *Debye screening*, CMP 73 (1980) 197. DOI 10.1007/BF01197700. **verified**.
41. J. Fröhlich, P. A. Marchetti, *Soliton quantization in lattice field theories*, CMP 112 (1987) 343. DOI 10.1007/BF01217817. **verified**.
42. S. Mandelstam, *Vortices and quark confinement in non-Abelian gauge theories*, Phys. Rep. 23 (1976) 245. DOI 10.1016/0370-1573(76)90043-0. **verified**.
43. G. 't Hooft, *Topology of the gauge condition and new confinement phases in non-abelian gauge theories*, NPB 190 (1981) 455. DOI 10.1016/0550-3213(81)90442-9. **verified**.
44. S. Chatterjee, *A probabilistic mechanism for quark confinement*, CMP 385 (2021) 1007–1039. arXiv:2006.16229; DOI 10.1007/s00220-021-04086-y. **verified**; PDF in library. Thm 2.2, Def. 2.3 and Thm 2.4 were checked against the text.
45. H. Shen, R. Zhu, X. Zhu, *A stochastic analysis approach to lattice Yang–Mills at strong coupling*, CMP 400 (2023) 805–851. arXiv:2204.12737; DOI 10.1007/s00220-022-04609-1. **verified**; PDF in library.
46. S. Cao, R. Nissim, S. Sheffield, *Expanded regimes of area law for lattice Yang–Mills theories*, arXiv:2505.16585. **verified**; PDF in library.
47. S. Cao, R. Nissim, S. Sheffield, *Dynamical approach to area law for lattice Yang–Mills*, arXiv:2509.04688. **verified**; PDF in library (read: Thm 1.6, Thm 2.3).
48. R. Nissim, *U(N) lattice Yang–Mills in the 't Hooft regime*, arXiv:2510.22788. **verified**; PDF in library.
49. A. Adhikari, S. Cao, *Correlation decay for finite lattice gauge theories at weak coupling*, Ann. Probab. 53 (2025) 140–174. arXiv:2202.10375; DOI 10.1214/24-AOP1702. **verified**; PDF in library. The paper works in 4D only and proves exponential decay of gauge-invariant correlations. It does not prove a perimeter law.
50. S. Chatterjee, *Rigorous solution of strongly coupled SO(N) lattice gauge theory in the large N limit*, CMP 366 (2019) 203–268. arXiv:1502.07719; DOI 10.1007/s00220-019-03353-3. **verified**; PDF in library.
51. R. Basu, S. Ganguly, *SO(N) lattice gauge theory, planar and beyond*, arXiv:1608.04379. **verified**.
52. J. Jafarov, *Wilson loop expectations in SU(N) lattice gauge theory*, arXiv:1610.03821. **verified**.
53. S. Cao, M. Park, S. Sheffield, *Random surfaces and lattice Yang–Mills*, Comm. AMS 5 (2025) 774–896. arXiv:2307.06790; DOI 10.1090/cams/59. **verified** (PDF in library).
54. J. Borga, S. Cao, J. Shogren-Knaak, *Surface sums for lattice Yang–Mills in the large-N limit*, arXiv:2411.11676. **verified**. Also arXiv:2508.13827, **verified**.
55. H. Shen, S. A. Smith, R. Zhu, *A new derivation of the finite N master loop equation for lattice Yang–Mills*, arXiv:2202.00880. **verified**.
56. S. Chatterjee, *Yang–Mills for probabilists*, arXiv:1803.01950. **verified**; PDF in library.
57. M. Lüscher, *Some analytic results concerning the mass spectrum of Yang–Mills gauge theories on a torus*, NPB 219 (1983) 233. DOI 10.1016/0550-3213(83)90436-4. **verified**.
58. B. de Wit, M. Lüscher, H. Nicolai, *The supermembrane is unstable*, NPB 320 (1989) 135. DOI 10.1016/0550-3213(89)90214-9. **verified**.
59. R. G. Leigh, D. Minic, A. Yelnikov, *Solving pure Yang–Mills in 2+1 dimensions*, PRL 96 (2006) 222001. arXiv:hep-th/0512111. **verified**.
60. B. Bringoltz, M. Teper, *A precise calculation of the fundamental string tension in SU(N) gauge theories in 2+1 dimensions*, PLB 645 (2007) 383. arXiv:hep-th/0611286. **verified**.
61. Y. Tanizaki, M. Ünsal, *Center vortex and confinement in Yang–Mills theory and QCD with anomaly-preserving compactifications*, PTEP (2022). arXiv:2201.06166. **verified**; PDF downloaded.
62. M. Ünsal, L. G. Yaffe, *Center-stabilized Yang–Mills theory: confinement and large N volume independence*, PRD 78 (2008) 065035. arXiv:0803.0344. **verified**; PDF downloaded.
63. T. Suzuki, I. Yotsuyanagi, *Possible evidence for Abelian dominance in quark confinement*, PRD 42 (1990) 4257. DOI 10.1103/PhysRevD.42.4257. **verified**.
63b. G. S. Bali, V. Bornyakov, M. Müller-Preussker, K. Schilling, *Dual superconductor scenario of confinement: a systematic study of Gribov copy effects*, PRD 54 (1996) 2863. arXiv:hep-lat/9603012. **verified** (arXiv API; the abstract gives an abelian/non-abelian string-tension ratio of 0.92(4)). *[Added by the verifier.]*
64. A. Kronfeld, G. Schierholz, U.-J. Wiese, *Topology and dynamics of the confinement mechanism*, NPB 293 (1987) 461. DOI 10.1016/0550-3213(87)90080-0. **verified**.
65. A. Di Giacomo, B. Lucini, L. Montesi, G. Paffuti, *Colour confinement and dual superconductivity of the vacuum — I*, PRD 61 (2000) 034503. arXiv:hep-lat/9906024. **verified**.
66. G. Ripka, *Dual superconductor models of color confinement*, arXiv:hep-ph/0310102 (Springer LNP). **verified**.
67. M. R. Douglas, S. H. Shenker, *Dynamics of SU(N) supersymmetric gauge theory*, NPB 447 (1995) 271. arXiv:hep-th/9503163. **verified**.
68. S. Elitzur, *Impossibility of spontaneously breaking local symmetries*, PRD 12 (1975) 3978. DOI 10.1103/PhysRevD.12.3978. **verified**.
69. G. Mack, V. B. Petkova, *Comparison of lattice gauge theories with gauge groups Z₂ and SU(2)*, Ann. Phys. 123 (1979) 442. DOI 10.1016/0003-4916(79)90346-4. **verified**.
69b. G. Mack, V. B. Petkova, *Sufficient condition for confinement of static quarks by a vortex condensation mechanism*, Ann. Phys. 125 (1980) 117. DOI 10.1016/0003-4916(80)90121-9. **verified**.
70. T. Balaban, D. Brydges, J. Imbrie, A. Jaffe, *The mass gap for Higgs models on a unit lattice*, Ann. Phys. 158 (1984) 281. DOI 10.1016/0003-4916(84)90121-0. **verified**.
70b. L. G. Yaffe, *Confinement in SU(N) lattice gauge theories*, PRD 21 (1980) 1574. DOI 10.1103/PhysRevD.21.1574. **verified**.
71. E. Fradkin, S. Shenker, *Phase diagrams of lattice gauge theories with Higgs fields*, PRD 19 (1979) 3682. DOI 10.1103/PhysRevD.19.3682. **verified**.
71b. T. Balaban, J. Imbrie, A. Jaffe, *Effective action and cluster properties of the abelian Higgs model*, CMP 114 (1988) 257. DOI 10.1007/BF01225038. **verified**.
72. L. Del Debbio, M. Faber, J. Greensite, Š. Olejník, *Center dominance and Z₂ vortices in SU(2) lattice gauge theory*, PRD 55 (1997) 2298. arXiv:hep-lat/9610005. **verified**.
73. Ph. de Forcrand, M. D'Elia, *On the relevance of center vortices to QCD*, PRL 82 (1999) 4582. arXiv:hep-lat/9901020. **verified**.
74. K. Gawędzki, A. Kupiainen, *Gross–Neveu model through convergent perturbation expansions*, CMP 102 (1985) 1. DOI 10.1007/BF01208817. **verified**.
74b. T. G. Kovács, E. T. Tomboulis, *Computation of the vortex free energy in SU(2) gauge theory*, PRL 85 (2000) 704. arXiv:hep-lat/0002004. **verified**.
75. J. Feldman, J. Magnen, V. Rivasseau, R. Sénéor, *A renormalizable field theory: the massive Gross–Neveu model in two dimensions*, CMP 103 (1986) 67. DOI 10.1007/BF01464282. **verified**.
76. C. Kopper, J. Magnen, V. Rivasseau, *Mass generation in the large N Gross–Neveu model*, CMP 169 (1995) 121. DOI 10.1007/BF02101599. **verified**.
77. C. Kopper, *Mass generation in the large N nonlinear σ-model*, CMP 202 (1999) 89. arXiv:math-ph/9902020; DOI 10.1007/s002200050576. **verified**.
78. A. Patrascioiu, E. Seiler, *Super-instantons and the reliability of perturbation theory in non-Abelian models*, PRL 74 (1995) 1920. arXiv:hep-lat/9311019. **verified**. Also *Absence of asymptotic freedom in non-Abelian models*, arXiv:hep-th/0002153, **verified**.
79. E. Seiler, *The case against asymptotic freedom*, arXiv:hep-th/0312015. **verified**.
80. M. Aizenman, H. Duminil-Copin, *Marginal triviality of the scaling limits of critical 4D Ising and φ⁴₄ models*, Ann. Math. 194 (2021) 163. DOI 10.4007/annals.2021.194.1.3. **verified**.
81. D. Karabali, V. P. Nair, A. Yelnikov, *The Hamiltonian approach to Yang–Mills (2+1): an expansion scheme and corrections to string tension*, NPB 824 (2010) 387. arXiv:0906.0783. **verified**.
82. V. P. Nair, *Towards a proof of mass gap in 3d Yang–Mills theory*, arXiv:2608.10133 (2026). **verified** (abstract page and HTML read via fetch tool).
83. N. Nekrasov, *Seiberg–Witten prepotential from instanton counting*, ATMP 7 (2004) 831. arXiv:hep-th/0206161. **verified**. (Douglas [8] cites the ICM version, hep-th/0306211, Proc. ICM Beijing 2002, vol. 3, 477–496; **verified** by the verifier via the arXiv API.)
84. N. Nekrasov, A. Okounkov, *Seiberg–Witten theory and random partitions*, arXiv:hep-th/0306238. **verified**.
85. H. Nakajima, K. Yoshioka, *Instanton counting on blowup. I*, Invent. Math. (2005). arXiv:math/0306198; DOI 10.1007/s00222-005-0444-1. **verified**.
86. A. Braverman, P. Etingof, *Instanton counting via affine Lie algebras II: from Whittaker vectors to the Seiberg–Witten prepotential*, arXiv:math/0409441. **verified**.
87. M. R. Douglas, *Axioms for physical reasoning: codifying the Seiberg–Witten solution in Lean*, arXiv:2607.06379 (2026). **verified**; PDF in library.
88. Y. Hayashi, Y. Tanizaki, *Unifying monopole and center vortex as the semiclassical confinement mechanism*, PRL 133 (2024) 171902. arXiv:2405.12402. **verified**.
89. E. T. Tomboulis, L. G. Yaffe, *Finite temperature SU(2) lattice gauge theory*, CMP 100 (1985) 313. DOI 10.1007/BF01206134. **verified**. (Also E. T. Tomboulis, *'t Hooft loop in SU(2) lattice gauge theories*, PRD 23 (1981) 2371, DOI 10.1103/PhysRevD.23.2371, **verified**.)
90. B. Durhuus, J. Fröhlich, *A connection between ν-dimensional Yang–Mills theory and (ν−1)-dimensional non-linear σ-models*, CMP 75 (1980) 103. DOI 10.1007/BF01222514. **verified** (metadata; content via [47]).
91. R. Nissim, *Deconfinement for SO(3) lattice Yang–Mills at strong coupling*, arXiv:2605.16162 (2026). **verified**; PDF in library.
92. E. T. Tomboulis, *Confinement for all values of the coupling in four-dimensional SU(2) gauge theory*, arXiv:0707.2179. **verified**; PDF in library. **[D]**.
93. K. R. Ito, E. Seiler, *On the recent paper on quark confinement by Tomboulis*, arXiv:0711.4930. **verified**; PDF in library.
94. V. N. Gribov, *Quantization of non-Abelian gauge theories*, NPB 139 (1978) 1. DOI 10.1016/0550-3213(78)90175-X. **verified**.
95. D. Zwanziger, *Local and renormalizable action from the Gribov horizon*, NPB 323 (1989) 513. DOI 10.1016/0550-3213(89)90122-3. **verified**.
96. D. Zwanziger, *Fundamental modular region, Boltzmann factor and area law in lattice theory*, NPB 412 (1994) 657. DOI 10.1016/0550-3213(94)90396-4. **verified**.
97. T. Kugo, I. Ojima, *Local covariant operator formalism of non-Abelian gauge theories and quark confinement problem*, Prog. Theor. Phys. Suppl. 66 (1979) 1. DOI 10.1143/PTPS.66.1. **verified**.
98. N. Vandersickel, D. Zwanziger, *The Gribov problem and QCD dynamics*, Phys. Rep. 520 (2012) 175–251. arXiv:1202.1491; DOI 10.1016/j.physrep.2012.07.003. **verified**; PDF in library.
99. A. Cucchieri, T. Mendes, *What's up with IR gluon and ghost propagators in Landau gauge?*, PoS LAT2007:297. arXiv:0710.0412. **verified**.
100. I. L. Bogolubsky, E.-M. Ilgenfritz, M. Müller-Preussker, A. Sternbeck, *Lattice gluodynamics computation of Landau-gauge Green's functions in the deep infrared*, PLB 676 (2009) 69. arXiv:0901.0736. **verified**.
101. D. Dudal, J. Gracey, S. P. Sorella, N. Vandersickel, H. Verschelde, *A refinement of the Gribov–Zwanziger approach in the Landau gauge*, PRD 78 (2008) 065047. arXiv:0806.4348. **verified**.
102. I. M. Singer, *Some remarks on the Gribov ambiguity*, CMP 60 (1978) 7. DOI 10.1007/BF01609471. **verified**.
103. G. Dell'Antonio, D. Zwanziger, *Every gauge orbit passes inside the Gribov horizon*, CMP 138 (1991) 291. DOI 10.1007/BF02099494. **verified**.
104. J. Maldacena, *The large N limit of superconformal field theories and supergravity*, ATMP 2 (1998) 231. arXiv:hep-th/9711200. **verified**.
105. S. S. Gubser, I. R. Klebanov, A. M. Polyakov, *Gauge theory correlators from non-critical string theory*, PLB 428 (1998) 105. arXiv:hep-th/9802109. **verified**.
106. E. Witten, *Anti de Sitter space and holography*, ATMP 2 (1998) 253. arXiv:hep-th/9802150. **verified**.
107. E. Witten, *Anti-de Sitter space, thermal phase transition, and confinement in gauge theories*, ATMP 2 (1998) 505. arXiv:hep-th/9803131. **verified**; PDF downloaded.
108. D. J. Gross, H. Ooguri, *Aspects of large N gauge theory dynamics as seen by string theory*, PRD 58 (1998) 106002. arXiv:hep-th/9805129. **verified**; PDF downloaded.
109. C. Csáki, H. Ooguri, Y. Oz, J. Terning, *Glueball mass spectrum from supergravity*, JHEP 01 (1999) 017. arXiv:hep-th/9806021. **verified**.
110. R. C. Brower, S. D. Mathur, C.-I. Tan, *Glueball spectrum for QCD from AdS supergravity duality*, NPB 587 (2000) 249. arXiv:hep-th/0003115. **verified**.
111. I. R. Klebanov, M. J. Strassler, *Supergravity and a confining gauge theory: duality cascades and χSB-resolution of naked singularities*, JHEP 08 (2000) 052. arXiv:hep-th/0007191. **verified**; PDF downloaded.
112. M. Berg, M. Haack, W. Mück, *Glueballs vs. gluinoballs: fluctuation spectra in non-AdS/non-CFT*, arXiv:hep-th/0612224. **verified**.
113. A. Dymarsky, D. Melnikov, *Gravity multiplet on KS and BB backgrounds*, JHEP 05 (2008) 035. arXiv:0710.4517. **verified**.
114. I. R. Klebanov, J. Maldacena, C. B. Thorn, *Dynamics of flux tubes in large N gauge theories*, JHEP 04 (2006) 024. arXiv:hep-th/0602255. **verified**.
115. I. R. Klebanov, D. Kutasov, A. Murugan, *Entanglement as a probe of confinement*, NPB 796 (2008) 274. arXiv:0709.2140. **verified**.
116. E. Witten, *Theta dependence in the large N limit of four-dimensional gauge theories*, PRL 81 (1998) 2862. arXiv:hep-th/9807109. **verified**.
117. M. Ünsal, *Magnetic bion condensation: a new mechanism of confinement and mass gap in four dimensions*, PRD 80 (2009) 065001. arXiv:0709.3269. **verified**; PDF downloaded. (Also M. Ünsal, PRL 100 (2008) 032005, arXiv:0708.1772, **verified**.)
118. E. Poppitz, T. Schäfer, M. Ünsal, *Continuity, deconfinement, and (super) Yang–Mills theory*, JHEP 10 (2012) 115. arXiv:1205.0290. **verified**.
119. E. Poppitz, M. Ünsal, *Seiberg–Witten and "Polyakov-like" magnetic bion confinements are continuously connected*, JHEP 07 (2011) 082. arXiv:1105.3969. **verified**.
120. P. Argyres, M. Ünsal, *The semi-classical expansion and resurgence in gauge theories: new perturbative, instanton, bion, and renormalon effects*, JHEP 08 (2012) 063. arXiv:1206.1890. **verified**.
121. G. Dunne, M. Ünsal, *Resurgence and trans-series in quantum field theory: the CP(N−1) model*, JHEP 11 (2012) 170. arXiv:1210.2423. **verified**.
122. M. Yamazaki, K. Yonekura, *From 4d Yang–Mills to 2d CP^{N−1} model: IR problem and confinement at weak coupling*, JHEP 07 (2017) 088. arXiv:1704.05852. **verified**.
123. E. Poppitz, F. D. Wandler, *Gauge theory geography: charting a path between semiclassical islands*, JHEP 02 (2023) 014. arXiv:2211.10347. **verified**.
124. C. Bonati, M. Cardinali, M. D'Elia, M. Giordano, F. Mazziotti, *Reconfinement, localization and thermal monopoles in SU(3) trace-deformed Yang–Mills theory*, PRD 103 (2021) 034506. arXiv:2012.13246. **verified**.
125. C. Bonati, M. Caselle, A. Negro, D. Panfalone, L. Verzichelli, *Confining flux tube in the trace deformed (2+1)-dimensional SU(2) gauge theory*, arXiv:2606.20270 (2026). **verified** (metadata only). Also B. Dobozy, E. Poppitz, *Metamorphosis of fractional instantons on a twisted $T^4$ with a double-trace deformation: a numerical study*, arXiv:2606.22078 (2026; DOI 10.1103/xnjb-vl84), **verified** (metadata only).
126. D. Gaiotto, A. Kapustin, Z. Komargodski, N. Seiberg, *Theta, time reversal, and temperature*, JHEP 05 (2017) 091. arXiv:1703.00501. **verified**; PDF downloaded.
127. O. Aharony, N. Seiberg, Y. Tachikawa, *Reading between the lines of four-dimensional gauge theories*, JHEP 08 (2013) 115. arXiv:1305.0318. **verified**; PDF in library.
128. M. G. Delgadino, S. A. Smith, *Mass generation for the two dimensional O(N) linear sigma model in the large N limit*, arXiv:2601.19630 (2026). **verified**.
129. P. Hasenfratz, M. Maggiore, F. Niedermayer, *The exact mass gap of the O(3) and O(4) non-linear σ-models in d=2*, PLB 245 (1990) 522. DOI 10.1016/0370-2693(90)90685-Y. **verified**. Also P. Hasenfratz, F. Niedermayer, PLB 245 (1990) 529, DOI 10.1016/0370-2693(90)90686-Z, **verified**.
130. OpenAI, `openai/math` repository, family 215: *Exponential decay in two-dimensional classical O(n) models* (preprint dated Sept 23, 2026), scope doc `lean/docs/215.md` and Comparator challenge `lean/ComparatorChallenges/ClassicalON.lean` (60 lines; `theorem main : ExponentialDecay := by sorry`). The claimed proof lives in `lean/OAI/Probability/ClassicalON/` (about 115 files) and is registered in `lean/formalization.yaml`, whose `review: status: unchecked`. https://github.com/openai/math (repo created 2026-10-06). **verified**. The verifier re-fetched 215.md, ClassicalON.lean, the CONTENTS.md entry and formalization.yaml as data on 2026-11-05. The proof files were neither read nor built. **[C]**.
131. M. R. Douglas, S. Hoback, A. Mei, R. Nissim, *Formalization of QFT*, arXiv:2603.15770 (2026). **verified**; PDF in library. The scope is the 4D Euclidean free boson and the Glimm–Jaffe variant of the OS axioms. The abstract says the three initially assumed results have since been proven or avoided.
132. E. Witten, *Supersymmetric Yang–Mills theory on a four-manifold*, J. Math. Phys. 35 (1994) 5101. arXiv:hep-th/9403195. **verified**.
133. J. A. Minahan, K. Zarembo, *The Bethe-ansatz for N=4 super Yang–Mills*, JHEP 03 (2003) 013. arXiv:hep-th/0212208. **verified** (cited by [8]).
134. S. Chatterjee, *A scaling limit of SU(2) lattice Yang–Mills–Higgs theory*, Prob. Math. Phys. 7 (2026) 339–381. arXiv:2401.10507. **verified** (arXiv API journal-ref). *[Added by the verifier: §2.15 cited it without a number.]*
135. S. Chatterjee, *Wilson loops in Ising lattice gauge theory*, CMP 377 (2020) 307–340. arXiv:1811.09770; DOI 10.1007/s00220-020-03738-9. **verified** (arXiv API and Crossref). *[Added by the verifier.]*
136. S. Cao, *Wilson loop expectations in lattice gauge theories with finite gauge groups*, CMP 380 (2020) 1439–1505. arXiv:2001.05627; DOI 10.1007/s00220-020-03912-z. **verified** (arXiv API and Crossref). *[Added by the verifier.]*
137. M. P. Forsström, J. Lenells, F. Viklund, *Wilson loops in finite Abelian lattice gauge theories*, Ann. Inst. Henri Poincaré Probab. Stat. 58 (2022) 2129–2164. arXiv:2001.07453; DOI 10.1214/21-AIHP1227. **verified** (arXiv API and Crossref). *[Added by the verifier.]*

*Sibling-note cross-references:* 01-problem-definition (gap formulations), 02-openai-ym-claim (status of OpenAI's existence claim; committee), 03/04 (OpenAI methodology and repositories), 05-balaban-program (UV layer), 07-lattice-rigorous-results (detailed lattice theorems and thresholds), 08-constructive-qft-and-renormalization-tools.

---

## Verification log

*Adversarial verification pass, 2026-11-05. Method: arXiv API (export.arxiv.org, batch `id_list` queries), Crossref `works/<DOI>` lookups, text extraction (`pdftotext`) from the PDFs already in `library/pdfs`, fetches of the Clay PDF and of Douglas's 2004 report (nLab copy), and the `openai/math` GitHub API and raw files, all read as data. No new PDFs were added to the library and none were deleted.*

### A. Reference existence and metadata

- **arXiv IDs.** All 97 arXiv identifiers in the original list resolve, and title and authors match: 52 new-style and 45 old-style (`hep-th`, `hep-lat`, `hep-ph`, `math`, `math-ph`). This includes the 2026 items 2601.19630, 2602.00436, 2603.15770, 2605.16162, 2606.20270, 2606.22078, 2607.06379 and 2608.10133. No fabricated arXiv references were found.
- **DOIs.** All 56 DOIs in the original list resolve on Crossref, and title, journal, volume and pages match.
- **Non-arXiv URLs.** The Clay description PDF fetched and was read. Douglas 2004 fetched from nLab and was read in full (4 pp.). The `openai/math` repo exists (created 2026-10-06). `lean/docs/215.md`, `ClassicalON.lean` (60 lines), the CONTENTS.md entry for family 215 and `lean/formalization.yaml` were all read.
- **PDFs.** The 14 PDFs this note claims to have downloaded, plus 17 others it cites as "in library", were checked page 1 against their IDs. All match. No mis-ID'd files were found, so none were deleted.
- **Metadata corrections and additions.**
  - [32]: full published title restored ("Electric–magnetic duality, …"); erratum and DOI added.
  - [39]: page count is 13, not 4.
  - [44], [45], [50], [98]: journal volumes, pages and DOIs added.
  - [49]: now published (Ann. Probab. 53 (2025)); DOI added.
  - [53]: published in Comm. AMS 5 (2025); DOI added.
  - [14], [86], [120]: full titles.
  - [113]: journal reference.
  - [125]: title of Dobozy–Poppitz.
  - [130], [131]: scope descriptions corrected.
- **References added**, all verified: 21b (Lévy, cited in the text but missing from the list), 63b (Bali et al. 1996, the true source of "92%"), 134 (Chatterjee YM–Higgs, cited without a number), and 135–137 (finite-group perimeter-law papers).

### B. Claims checked against sources (most important first)

1. **Clay description (Jaffe–Witten).** Checked against the PDF text: the uniform-in-volume gap; "no present ideas point" toward it; the T⁴→R⁴ limit; Debye screening via sine-Gordon [6]; the quartic $(A\wedge A)^2$ potential; Singer [44] and Simon [43]; "for sufficiently large N"; "no effective approach to the gauge theory without fermions"; footnote 2 excluding weak existence; the bibliography's "quantitative behavior" misprint for Feynman. **Confirmed.**
2. **Douglas 2004.** "No breakthroughs"; state of the art is Balaban plus MRS; σ-models and SUSY YM as analogue classes; Kopper's regulated O(N) gap; soft breaking "would in fact imply" the original problem; Nekrasov's result as the simplest carrying "any of the physics of the mass gap"; N=4 integrability. **Confirmed.** **Corrected:** Douglas does not call Kopper's result "the closest rigorous gap".
3. **Chatterjee 2021 [44].** Thm 2.2 (unbroken center ⇒ $V(R)\to\infty$), Def. 2.3 (strong gap), Thm 2.4 (strong gap ⇒ unbroken center and area law), "some dissent [31]", and the remark that it is unclear whether physics expects the strong version. **Confirmed** verbatim-level against the text.
4. **Cao–Nissim–Sheffield [46,47].**
   - **Overstatement corrected.** The note said area law was proven "in the whole 't Hooft regime". [47] proves it for $\beta<\beta^*_G$, with $1/(8(d-1))$ for U(N) and SU(N) and a smaller SO(N) threshold, via DF80 plus Bakry–Émery. [47] itself says [46] covered a regime "not the entire 't Hooft regime".
   - **Conflation corrected.** [46] uses master-loop-equation a-priori bounds, not DF80 plus Bakry–Émery.
5. **Adhikari–Cao [49].**
   - **Corrected.** The paper proves 4D correlation decay only. The "deconfined" half of "gapped and deconfined" comes from Chatterjee 2020, Cao 2020 and Forsström–Lenells–Viklund 2022, now cited.
   - Added "$d\ge3$", since 2D theories always have an area law.
   - Status [T]: it is now published in Ann. Probab.
6. **Osterwalder–Seiler 1978.** **Corrected.** Reflection positivity holds at all β. Only the gap and area law are small-β results.
7. **Chatterjee 2026 [39].** Formula $|\langle W_\ell\rangle|\le n\exp\{-c(1+n\beta)^{-1}T\log(R+1)\}$; result classical (Fröhlich Cor. 2 with Glimm–Jaffe); Mermin–Wagner complex-rotation method; Villain action for Göpfert–Mack; area-law upgrade explicitly not pursued. **Confirmed.**
8. **Nissim SO(3) [91]; SZZ thresholds [45]; Nissim U(N) [48]; Kopper [77]; Delgadino–Smith [128].** **Confirmed** against the abstracts. Added the clarification that SO(3) is still in scope for the Clay gap.
9. **OpenAI family 215 [130].**
   - Statement shape (∀n≥3 ∀β>0 ∃A,m>0, ∀ finite subgraph, ∀ $b_e\in[0,\beta]$, $0\le\langle\sigma_x\cdot\sigma_y\rangle\le Ae^{-m|x-y|}$), 60 lines, preprint dated Sept 23 2026, headline O(3)/O(4) claims, and 215.md's exclusions. **Confirmed.**
   - **Understatement corrected.** A full Lean proof development is claimed: about 115 files, registered in `formalization.yaml` with `review: status: unchecked`. Status kept at [C] until it is independently replayed.
   - **Overstatement corrected.** The "exactly the kind of uniformity DF needs" claim ignored the fact that O(n) environments are scalar and ferromagnetic, whereas DF's are matrix twists.
   - The O(4) formula's agreement with HMN was re-derived independently.
   - The Douglas "warm-up" attribution was reworded: Douglas spoke of the σ-model, not this proof.
10. **KKN and lattice.** Checked: $m=e^2c_A/2\pi$ and $\sigma_R=e^4c_Ac_R/4\pi$ (KKN eqs. 7.5–7.6); Bringoltz–Teper's "within 3%", "~1%", "~6 sigma", "remarkably accurate … not exact"; the Lucini–Teper fit $0.19755(34)-0.1200(29)/N^2$; Lucini–Panero's "still under debate"; Karabali–Nair–Yelnikov's −0.3% to −2.8%. **Confirmed.**
11. **Lattice numbers.** Morningstar–Peardon 1730(50)(80), 2400(25)(120) and 2590(40)(130) MeV, $r_0^{-1}=410(20)$ MeV, $r_0m=4.21(12)$; Athenodorou–Teper 3.405(21) for SU(3) and 3.072(14) for SU(∞); bulk transition first-order for N≥5 and a crossover below. **Confirmed.** **Caveat added:** the large-N bulk value 0.3596(2) is very likely $b=1/\lambda_0$, not $\lambda_0$.
12. **Abelian dominance.** **Corrected.** The 92% figure comes from Bali et al. 1996 (0.92(4)), not Suzuki–Yotsuyanagi or KSW. Greensite §7.5–7.6 (objections) confirmed, including the Douglas–Shenker $N-1$ flux-tube point.
13. **Other confirmations.**
    - Seiberg–Witten: the $\langle M\rangle=(-mu'(0)/\sqrt2)^{1/2}$ formula and "strongly believed to generate a mass gap".
    - Ünsal–Yaffe: abstract, mass formula structure and "no order parameters" between small and large L.
    - Ünsal: "We currently do not know the extension to $\mathbb R^4$".
    - Tanizaki–Ünsal: continuity conjecture.
    - Ito–Seiler: "missing links", the abelian KT counter-argument and the "cannot distinguish non-abelian from abelian" remark.
    - Kovács–Tomboulis: "rigorously known … necessary and sufficient".
    - de Forcrand–D'Elia: SU(2) vortex removal.
    - Witten 1998: no demonstration of asymptotic freedom.
    - Gross–Ooguri: analogy to strong-coupling lattice.
    - Klebanov–Strassler: small $g_sM$.
    - Douglas 2026 [87] and Douglas et al. [131] scope.
    - Nair 2026: $T^2-mT$, renormalized-$V$ positivity assumed, $J_a$ not a physical state.
    - **Minor fix:** KMT [114] is about N=4 SYM, a non-confining theory.
14. **OpenAI YM context.** Press coverage found in this pass agrees on four points: OpenAI claims existence only, not the mass gap; the Lean formalization finished on 16 Oct; the artifacts are still withheld; the AGMAI asked for release on 26 Oct. The five-member committee is named in only one press table, so membership relies on note 02.
15. **Status tags.** CNS [46,47] and Nissim [48] are arXiv-only, so they are re-tagged [T-pre] in §2.3 and §3. The note's own tag scheme requires this; the original gave [T]. KMT [114] is now flagged as an N=4 (conformal) study.

### C. Residual concerns (not resolved in this pass)

- **Paywalled originals not read:** Göpfert–Mack [31], Durhuus–Fröhlich [90], Glimm–Jaffe [37], Fröhlich [38], Feynman [25], Simon [26], Tomboulis–Yaffe [89], Mack–Petkova [69,69b], Fröhlich–Marchetti [41] and Dell'Antonio–Zwanziger [103]. Their content is reported via secondary sources ([39], [47], Clay, Greensite). In particular:
  - the claim that Fröhlich–Marchetti "construct monopole sectors" in the 4D U(1) Coulomb phase was not checked;
  - the convexity and boundedness of the Gribov region is attributed to "this line of work" without a precise citation (Zwanziger 1982 is the usual source and is not listed).
- **Orland 1996 [28].** The 3+1D small-potential-directions claim lies in the truncated part of the abstract and was not re-read.
- **Nekrasov–Okounkov.** Treating it as a full proof follows the standard attribution but was not re-derived.
- **Lévy [21b].** The Astérisque venue is from memory.
- **"No rigorous 3D Georgi–Glashow Polyakov mechanism".** This remains an absence claim from a non-exhaustive search, as the author already flagged.
- **Lucini–Panero bulk value.** The $\lambda_0$ vs $1/\lambda_0$ convention for "0.3596(2)" should be confirmed against Campostrini (hep-lat/9809072, not fetched).
- **OpenAI family 215.** Whether the Lean proof builds and passes Comparator was **not** tested. The method hints come from file names only.
- **Sibling-note dependencies.** Several statements rest on sibling notes (02, 04, 07) and were only spot-checked: the `lgt` thresholds, the committee's "infinite distances" wording and Douglas's "warm-up" quote.
- **[I] arguments not checked by the verifier.** The dimensional obstruction to DF in 4D (§2.10) is the author's inference, and it looks sound: with $A=B=I$ the slab model is a 3D principal chiral model, which orders at large β. The proof-architecture and ranking sections (§4) are opinion and were not checked.
