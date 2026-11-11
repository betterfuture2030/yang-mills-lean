# 11 — The research frontier on rigorous Yang–Mills, 2023–2026

- **Workstream key:** `11-recent-frontier-2023-2026`
- **Compiled:** 2026-11-05.
- **Method.**
  - I swept the arXiv API systematically with about 40 queries over math-ph, math.PR, math.AP, hep-th, hep-lat, physics.gen-ph and math.GM, restricted to submissions from 2023-01-01 to 2026-11-05. Queries were by title, abstract and author, and covered: Yang–Mills, lattice gauge, Wilson loop, mass gap, area law, stochastic quantisation, Balaban, gradient flow, Osterwalder–Schrader, Millennium/Clay, plus key authors.
  - I checked metadata with the arXiv API, DOIs with Crossref, and repositories with the GitHub API. I checked Zenodo records with the Zenodo API.
  - I read primary PDFs with `pdftotext` for the passages cited. These were the claimed solutions, Bringmann–Cao–Hairer–Zhao, Deng–Shen, Cao–Nissim–Sheffield, Witten, Piazza–Shen, Douglas et al. and Nair.
  - Press, blog and committee pages were fetched live.
  - Companion notes, which I cross-reference rather than repeat: `01-problem-definition` (precise Clay statement), `02-openai-ym-claim` (OpenAI and the committee in detail), `04-openai-github-proofs` (Comparator and Lean hygiene), and `06-stochastic-quantization-2d-3d` (SQ in depth).
- **Status labels:**
  - **[THM]**: published, refereed theorem.
  - **[PREPRINT]**: arXiv, established authors, not yet refereed. Very likely correct, but not verified by us.
  - **[AI-PREPRINT]**: machine-written mathematics, supervised by credentialed humans, unrefereed. The authors themselves say it is not fully understood.
  - **[CLAIM]**: announced but not publicly checkable.
  - **[HEUR]**: physics-level or heuristic argument.
  - **[AI-ASSESSED: SUSPECTED ERROR]**: a claimed solution in which an AI agent located what it believes is a specific error or a hidden assumption of the conclusion.
  - **[AI-ASSESSED: DOES NOT ENGAGE KNOWN OBSTACLES]**: a claimed solution that, in an AI agent's reading, does not engage with the known obstacles.
  - **[NOT ASSESSED]**: the work was not read; no assessment is made.
  - *These labels are AI agents' assessments made while compiling this library. No human expert has reviewed them, and they are not refereed judgements of the cited work or its authors.*
  - **[OPEN]**: open problem.
  - **[I]**: my own inference.

---

## Summary

1. **No peer-reviewed construction of any non-Abelian Yang–Mills (YM) continuum theory exists in dimension d ≥ 3**, as of 5 Nov 2026. This holds even on a torus and even without a mass gap. Two papers from 2026 say so explicitly:
   - Douglas–Hoback–Mei–Nissim, March 2026 [65]: even 3D pure YM in the continuum is open.
   - Bringmann–Cao–Hairer–Zhao, 2 Nov 2026 [37]: a mass gap and confinement for 4D non-Abelian lattice gauge theories at **all** couplings is a long-standing open problem.

   The mass gap is not claimed by any credible party. That includes OpenAI and its shepherding committee [93, 94].
2. **d = 2 is finished, and the frontier has moved to Higgs fields and alternative constructions.**
   - The 2D YM measure on the **torus** being the unique invariant measure of the Langevin dynamic, with universality across Wilson, Villain and Manton actions, is a [THM] [1]. The 2D YM measure on general compact surfaces is classical (1990s). Lattice universality on **all** compact surfaces is only [PREPRINT] [23]. Several independent constructions now exist: Langevin/invariant measure, singular elliptic PDE, Morse theory, pseudo-coordinates [1, 23, 32, 33]. *(Verifier: corrected; the earlier wording labelled all-surface universality [THM].)*
   - On 2 Nov 2026, BCHZ gave the first construction of the **non-Abelian 2D Yang–Mills–Higgs (YMH) measure**, for all couplings, via stochastic quantisation (SQ) [37] [PREPRINT]. Variational methods now also reach 2D Abelian YMH [35].
3. **d = 3 has a local SQ theory and a growing set of AI-generated continuum claims.**
   - The 3D YMH Langevin dynamic is locally well-posed and gauge covariant, with a **unique** gauge-covariant renormalisation [38, 14] [THM].
   - The 3D Abelian lattice Langevin dynamic has a universal Gaussian scaling limit [34] [PREPRINT].
   - A regularity-structure model for the 3D YM Langevin equation has been built by multi-indices [29] [PREPRINT].
   - Two open, LLM-driven efforts claim 3D continuum results via Bałaban-style renormalisation group (RG) [AI-PREPRINT]:
     - Sussman–Alpöge: QED₃, and YM₃ with OS axioms for tr F² [89].
     - Aronow–Lopatto: the 3D SU(2) torus continuum limit of flowed Wilson loops [90].
   - Neither is refereed. The authors' confidence differs:
     - Sussman–Alpöge say they believe the QED₃ and YM₃ manuscripts are "essentially correct" but have not verified them.
     - Aronow–Lopatto say they are less confident than in their other work. They say the proof is beyond both their own understanding and Lean autoformalisation.
4. **Lattice YM at strong coupling has been pushed considerably.** The tools are Langevin dynamics with Bakry–Émery or log-Sobolev inequalities, master loop equations, and surface sums.
   - Mass gap, unique infinite-volume limit and large-N factorisation now hold in an explicit small-β 't Hooft regime (β below a dimension-dependent constant, uniformly in N) for SU(N), SO(N) and U(N) [40, 8, 19].
   - The area law holds there for groups with nontrivial centre [15, 17].
   - Deconfinement is proved for SO(3) at strong coupling [30].
   - The log-Sobolev inequality (LSI) holds in 2D at **all** couplings [36].
   - Logarithmic confinement holds in 3D for groups containing a central U(1) [22].

   None of this reaches the weak-coupling (continuum) regime in d = 4.
5. **In the established literature, scaling limits of non-Abelian LGT beyond d = 2 exist only when they are Gaussian.** This applies to YMH under a strong "abelianising" scaling, for SU(2) [7] and for any compact connected matrix Lie group G [26], in any d ≥ 2. A non-Gaussian limit is [OPEN]. The AI-preprint [90] claims one on T³, unverified.
6. **4D-relevant method development.**
   - Critical SPDE technology has made a first step: the 4D Anderson model needs renormalisation to arbitrarily high order [49]. Its authors explicitly name 4D YM as a target.
   - The RG side has new work on flow equations: Gross–Neveu [45], asymptotically free scalar flow solutions [47], and a hierarchical mass-gap proof [48].
   - New gauge-invariant lattice regularisations of chiral fermions appeared in Oct–Nov 2026 [62, 63]. They matter only for the "unified completion" side of OpenAI's claim.
7. **OpenAI's claim** is existence only, including fermions, QCD and a "unified completion of the Standard Model" (OpenAI's wording, quoted by Woit [100]) [93; note 02]. As of today it is **[CLAIM]**.
   - The committee's 3 Nov statement *hopes* to release the Lean proof "next week", i.e. the week of 9 Nov [94]. That is a hope, not a promise.
   - The 1147-page manuscript is held by the committee.
   - The closest public OpenAI artefacts are family 215 in `openai/math` [92] [CLAIM]. It contains the O(3) "canonical massive continuum limit" paper plus O(3)/O(4) companions. Douglas calls the 2D sigma model the classic "warm-up" [99].
     - The O(3) paper's abstract claims full (non-subsequential) convergence, the OS axioms, a nonzero connected four-point function, a unique vacuum and a positive gap. **It is not Lean-formalised.**
     - The family's Lean component (Comparator challenge `ClassicalON`) covers only a companion result [106]: exponential decay of spin correlations for the 2D classical O(n) model, n ≥ 3, at every temperature, with constants uniform over finite subgraphs. That would settle Polyakov's mass-generation conjecture at the lattice level. It is machine-checked per OpenAI, and we have not checked it.
     - *(Verifier: corrected; the earlier wording said only "self-labelled unchecked".)*
8. **Claimed full solutions of the Millennium problem (2023–2026)** are catalogued in §3, with about 20 items.
   - Every one I examined fails in one of a small number of recognisable ways. The commonest are:
     - (a) a strong-coupling (polymer) expansion applied in the weak-coupling continuum regime;
     - (b) "standing hypotheses" that assume uniform clustering, i.e. the mass gap;
     - (c) modifying the axioms or the definition of the theory.
   - The flagship arXiv example, 2506.00284, was **withdrawn by arXiv administrators**. Its key convergence bound is algebraically inverted (§3.2).
   - 2026 saw a surge of apparently AI-assisted claims on Zenodo and Preprints.org. A search-tool summary reported that some contain text addressed to AI referees. That is a hygiene hazard for any agent swarm.
9. **Expert commentary since Sept 2026** on what an OpenAI proof must contain (§4) converges on several points:
   - an explicit choice of observables and axioms;
   - full versus subsequential convergence;
   - the infrared step from T⁴ to ℝ⁴, which Bałaban did not do;
   - nontriviality, i.e. excluding a disguised free field, plus agreement with asymptotic freedom;
   - a bridge from Bałaban's effective actions to continuum Schwinger functions, which BCHZ say is unclear even in 2D;
   - statement fidelity of the Lean formalisation.

---

## 1. Key definitions and statements

### 1.1 Lattice Yang–Mills
Let $\Lambda\subset(\varepsilon\mathbb Z)^d$ be finite, with $E_\Lambda$ its oriented edges and $P_\Lambda$ its plaquettes. Let $G$ be a compact Lie group, with $Q:E_\Lambda\to G$ and $Q_{e^{-1}}=Q_e^{-1}$. The Wilson measure in the normalisation used by the probabilists' 't Hooft-regime papers [17, 40] is

$$d\mu_{\Lambda,\beta}(Q)=Z^{-1}\exp\Big(N\beta\sum_{p\in P_\Lambda}\operatorname{Re}\operatorname{Tr}(Q_p)\Big)\prod_{e}dQ_e ,\qquad Q_p=Q_{e_1}Q_{e_2}Q_{e_3}Q_{e_4}.$$

- In the physics normalisation, $\beta_{\rm phys}=2N/g_0^2$ for SU(N).
- The continuum limit is $\varepsilon\to0$ with $g_0(\varepsilon)\to0$ along the asymptotic-freedom trajectory $g_0^{-2}\sim 2b_0\log(1/\varepsilon\Lambda_{\rm YM})$, where $b_0=11N/(48\pi^2)$. This is the **weak-coupling** regime. Strong-coupling results ($\beta$ small) say nothing directly about it.
- **Wilson loop.** For a loop $\ell=e_1\cdots e_n$, define $W_\ell=\operatorname{tr}(Q_{e_1}\cdots Q_{e_n})$, where $\operatorname{tr}=\frac1N\operatorname{Tr}$.
- **Area law** (Wilson's confinement criterion): $|\langle W_\ell\rangle|\le Ce^{-c\,\mathrm{area}(\ell)}$ for rectangular loops. The **perimeter law** is the same bound with the perimeter in place of the area.
- **Lattice mass gap:** exponential decay of connected correlations of local gauge-invariant observables, uniformly in volume. Equivalently, a spectral gap of the transfer matrix on the gauge-invariant Hilbert space obtained by Osterwalder–Seiler reflection positivity.
- **The obstruction.** Osterwalder–Seiler (1978) proved both at small $\beta$ for any $G$ (area law when the centre is nontrivial). The open problem is uniformity as $\beta\to\infty$ in d = 4.

### 1.2 Continuum targets
- **OS / Wightman.** The Clay problem requires a nontrivial theory on $\mathbb R^4$, for every compact simple $G$. It must satisfy axioms at least as strong as Streater–Wightman / Osterwalder–Schrader, with local gauge-invariant fields such as $\operatorname{Tr}F^2$, short-distance agreement with asymptotic freedom, and spectral gap $\Delta>0$ (note 01 gives the exact text). In particular:
  - weak existence through compactness alone is excluded unless the axioms and the gap are also proved (Jaffe–Witten footnote [102]);
  - the cluster property (unique vacuum) is part of the OS axioms.
- **Alternative notions of "a constructed YM theory" now in use.** They are not interchangeable [I]:
  - (i) a probability measure on a space of distributional connections modulo gauge, with Wilson-loop holonomies defined (Chevyrev 2D; Dang–Nohra);
  - (ii) the unique invariant measure of a gauge-covariant Langevin dynamic on a Polish space of gauge orbits (CCHS; Chevyrev–Shen; BCHZ);
  - (iii) the law of **gradient-flowed** observables: Yang–Mills heat-flow trajectories, or Wilson loops at positive flow time $t>0$, on the Cao–Chatterjee state space [41, 42]; this is used by Aronow–Lopatto [90];
  - (iv) OS-axiom Schwinger functions for selected gauge-invariant local composite fields (Sussman–Alpöge: $F_{\mu\nu}$ in QED₃, $\operatorname{tr}F^2$ and $\operatorname{tr}F_{jk}F_{\ell m}$ in YM₃ [89]).

  Only (iv), extended to a generating set of local fields, maps directly onto the Clay wording. (iii) needs a small-flow-time limit (composite-operator renormalisation) to produce $\operatorname{Tr}F^2(x)$.

### 1.3 Stochastic quantisation and criticality
The DeTurck-regularised Langevin equation is

$$\partial_t A=-d_A^*F_A-d_Ad_A^*A+\xi .$$

- It is **subcritical for d < 4 and critical at d = 4**: the coupling is dimensionless. Regularity structures and paracontrolled calculus need subcriticality.
- Deng–Shen's critical Anderson model is the first rigorous treatment of a d = 4 critical singular PDE that needs renormalisation to order $|\log\varepsilon|$ [49]. It is linear.

### 1.4 Master loop (Makeenko–Migdal) equations
- The master loop equations are Schwinger–Dyson identities, obtained via integration by parts on $G$ or via Itô's formula for the Langevin dynamic. They linearly relate $\langle W_\ell\rangle$ to deformed, split and merged loops [6, 13, 21].
- They drive the strong-coupling large-N results and the area-law bounds [15, 31]. Positivity-bootstrap numerics use them together with reflection positivity [hep-lat ref. 88].

### 1.5 The Durhuus–Fröhlich implication
This implication, used in [17], is classical (Durhuus–Fröhlich 1980). For $G$ with nontrivial centre, it says the following. Condition on the horizontal edges bounding a height-1 slab. If the resulting **(d−1)-dimensional nonlinear σ-model** has a mass gap uniform in volume and in **all** boundary fields, then Wilson's area law follows ([17], §2 and Prop. 3.2).
- This hypothesis is **not** the gauge theory's own mass gap. It is a separate, stronger-looking condition on an auxiliary model.
- So "mass gap ⇒ confinement" holds on the lattice only in this specific sense. *(Verifier: clarified; the earlier wording blurred the two gaps.)* For trivial centre (SO(3)), area law **fails** at strong coupling [30]. This is a reminder that confinement and mass gap are distinct properties.

---

## 2. Detailed findings by thread

### 2.1 d = 2: complete, and diversifying (cross-ref note 06)
- **Chevyrev–Shen** [1], [THM, CPAM 2026]:
  - The 2D YM measure on $\mathbb T^2$ is invariant for the renormalised Langevin dynamic. It has a gauge-fixed decomposition as a GFF plus an almost-Lipschitz remainder.
  - **Universality:** Wilson, Villain and Manton lattice theories all converge to it.
  - The mass renormalisation of the covariant dynamic is unique.
- **Dang–Nohra** [23] [PREPRINT]: the same universality on all compact surfaces of any genus with any area form, via pseudo-coordinates. Includes convergence of Segal amplitudes.
- **Further independent constructions** [PREPRINT]:
  - **Chevyrev–Klose–Mohamed** [32]: rough additive functions, a rough Uhlenbeck compactness, and a Coulomb gauge from a singular elliptic PDE.
  - **Chhaibi–Dang–Guedes Bonthonneau–Rivière–Tô** [33]: Morse gauges.
- **Exact formulas and large N:**
  - Lévy's combinatorial Wilson-loop formula and a short Makeenko–Migdal proof on surfaces [24];
  - Dahlqvist's large-N convergence on surfaces of genus ≥ 2 [25];
  - Park–Pfeffer–Sheffield–Yu's surface sums on the plane [3] [THM, PMP 2026];
  - Shen–Smith–Zhu's lattice-to-continuum convergence of the Makeenko–Migdal equations [13].
- **Higgs:**
  - **Bringmann–Cao–Hairer–Zhao (BCHZ)** [37], 350 pp., 2 Nov 2026: the first construction of the non-Abelian 2D YMH measure, at any fixed couplings. They build a gauge-covariant non-Markovian approximation and a covariant paracontrolled calculus, then use decay under deterministic YMH gradient flow to get uniform-in-time bounds. A strong-Feller/irreducibility argument then gives a unique invariant measure. The authors describe it as non-perturbative.
  - **Barashkov–Chandra–Chevyrev–Koller–Mohamed** [35]: Boué–Dupuis variational construction of 2D Abelian YMH. They describe it as the first interacting gauge theory built this way.
  - **Piazza–Shen** [36]: LSI for 2D SU(N) lattice YM at all β, uniform in volume, by a two-scale disintegration.
- **Relevance [I].** 2D is a sandbox for definitions. The 2D results define the template a 4D Lean statement must match: gauge orbit space, holonomies, universality.

### 2.2 d = 3: local theory, Abelian limits, and AI-generated continuum claims
- **CCHS 3D** [38], [THM, Invent. Math. 237 (2024)]: local-in-time solutions of 3D YMH SQ on a nonlinear state space, with a gauge-covariant mass renormalisation and a Markov process on gauge orbits up to blow-up.
- **Chevyrev–Shen** [14], [THM, ARMA 250 (2026)]: the renormalisation is unique. This identifies limits of other approximations, such as lattice dynamics.
- **Chevyrev–Qu–Shen** [34] [PREPRINT]: the 3D U(1) lattice Langevin dynamic in DeTurck gauge, under weak-coupling scaling, converges to the 1-form stochastic heat equation. The limit is universal across plaquette actions.
- **Sevostyanov** [29] [PREPRINT, 128 pp.]: a tree-free (multi-index, Otto et al.) regularity structure and model for 3D YM Langevin, with global stochastic estimates.
- **Cao–Chatterjee** [41, 42], arXiv 2021: [41] gives the state space of YM heat-flow trajectories, with a **conditional** construction under a "GFF-like" assumption [THM, CMP 405 (2024), art. 3]. [42] gives the heat flow with distributional initial data [THM, Comm. PDE 48 (2023) 209–251]. This is the gradient-flow-based definition track.
- **Chatterjee** [22], 2026 [PREPRINT, to appear]: a short self-contained proof that 3D Wilson LGT with $G\subseteq U(n)$ containing all scalar phases is confining with a logarithmic potential, at all β. The bound is $|\langle W\rangle|\le n\exp\{-c(1+n\beta)^{-1}T\log(R+1)\}$. This is classical in substance (Fröhlich comparison plus Glimm–Jaffe). It does **not** cover SU(n).
- **Nair** [76] [HEUR, hep-th, 11 pp.]: an outline of a 3D mass gap via an eigenvalue inequality for the Laplacian on gauge-orbit space, in the Karabali–Nair Hamiltonian framework. The author is explicit that regularisation issues remain.
- **Sussman–Alpöge** [89] [AI-PREPRINT, GitHub; repository public since 6 Oct 2026, last push 2 Nov]. The README states:
  - QED₃: a 242-page manuscript claiming a full construction, with OS axioms for $F_{\mu\nu}$.
  - YM₃: 857 + 1201 pages, claiming OS axioms for $\operatorname{tr}F^2$ and further fields.
  - YM₄: an unfinished manuscript from about 61k pages of "slop", of which about 20k is "closed".
  - Method: Claude generates; Codex condenses; parts are checked by hand. Alpöge says they have a YM₄ existence argument on $\mathbb R^4$, not just finite volume, and an RP-based trick to recover O(d) invariance.
  - Limitations, per Sussman's blog comments [100]: the limits are subsequential, and only specific observables are covered.
  - A new QCD₃ directory appeared [I: inferred from the repository listing].
- **Aronow–Lopatto** [90] [AI-PREPRINT; Hexagon preprint server 2610.00506–00512, 23–26 Oct 2026, labelled "primarily AI-generated" and "human understanding: no parts"]. P. Lopatto is a probabilist.
  - Claims: for the 3D SU(2) Wilson measure on a fixed torus, joint laws of finitely many **flowed Wilson loops** converge as $a\to0$ along lattice sizes $nM^k$. The limit is a unique measure on a Cao–Chatterjee-type state space.
  - Further claims: short-distance Gaussian (heat-smoothed GFF) asymptotics, and weak-coupling concentration on flat connections.
  - Method: Bałaban-style small-field multiscale RG, with the large-field complement controlled by reflection positivity and chessboard estimates.
  - **Not claimed:** OS axioms, infinite volume, mass gap. The authors say it is too complex for them to autoformalise or to fully understand.
- **Goldstein (repository owner; authors not stated in the README)** [91] [AI-PREPRINT, GitHub, Oct 2026]: an LLM completion of King's 1986 programme for 3D scalar QED (U(1) Higgs), with OS axioms claimed and a Lean library "in progress". *(Verifier: the README contains an instruction addressed to "AI agent[s]" asking them to cite the repository rather than any manuscript. It is benign, but it is another example of agent-directed text in this literature; see §3.1.)*
- **Status.** Non-Abelian 3D YM continuum existence remains **[OPEN]** in the refereed literature. If the AI-preprint claims are correct, they would close the torus case (Aronow–Lopatto) and the $\mathbb R^3$ case (Sussman–Alpöge). Nobody has verified them independently.

### 2.3 Lattice YM: mass gap, area law and large N at strong coupling
- **Shen–Zhu–Zhu (SZZ)** [40], [THM, CMP 2023], and **Shen–Zhu–Zhu YMH** [8] [PREPRINT]:
  - They use the Langevin dynamic on $G^{E}$ and the Bakry–Émery criterion, via the positive Ricci curvature of SU(N) and SO(N), for $\beta<\beta_0$ in 't Hooft normalisation.
  - The results are exponential ergodicity, a strictly positive mass gap, a unique infinite-volume measure, and large-N factorisation.
  - [8] extends this to bounded and unbounded Higgs fields.
- **Nissim** [19] [PREPRINT]: the same results for U(N), where the Ricci curvature is not uniformly positive. The proof writes U(N) as a U(1) random environment for SU(N) and combines cluster expansion with Langevin techniques.
- **Cao–Nissim–Sheffield** [15, 17] [PREPRINT]:
  - [15] gives area law in expanded regimes, improving Osterwalder–Seiler 1978 for large N. It reads the master loop equation as a linear inhomogeneous equation and introduces a truncated model to handle merger terms.
  - [17] observes that the SZZ dynamic yields the Durhuus–Fröhlich mass-gap hypothesis. This gives area law in an explicit 't Hooft regime, $\beta<1/(8(d-1))$ for U(N) and SU(N), and also covers SO(even).
- **Nissim** [30]: SO(3), with trivial centre, does **not** satisfy Wilson's criterion at strong coupling. This is a rigorous deconfinement theorem.
- **Lemoine** [28, 31] [PREPRINT]:
  - action-agnostic finite-N "universal dualities": a state sum, gauge/string expansion, spin-foam, and master loop equation on the coefficient side;
  - the large-N **heat-kernel** master field on $\mathbb Z^d$ at strong coupling: infinite-volume limits, factorisation, an all-order 1/N expansion, and an area-law upper bound.
- **Random surfaces:**
  - **Cao–Park–Sheffield** [4] [THM, to appear in CAMS]: Wilson loop expectations as sums over embedded planar maps, for any N, β and d, with Weingarten-function weights;
  - **Borga–Cao–Shogren-Knaak** [12, 16]: large-N surface sums with signed Catalan weights, and their cancellations.
- **Other results:**
  - Brennecke [20]: computes the constant $K_d$ in Chatterjee's leading-order free energy (J. Stat. Phys., to appear);
  - Tlas [27]: Gaussian concentration of the action under Haar measure;
  - Forsström [11]: perimeter laws and phase transitions for Abelian Higgs;
  - Malacan: Ursell functions;
  - Chevyrev–Garban [9]: the Villain action as a limit of Wilson and Manton actions on a "carpet graph", including the non-Abelian case;
  - **Adhikari–Cao** [43] [THM, Ann. Probab. 53 (2025) 140–174]: exponential decay of correlations at **weak** coupling, but only for **finite** gauge groups. There, large β is an ordered, frozen regime with no continuum limit, so it is not evidence about the Lie-group continuum regime. *(Verifier: added; [43] was listed but not discussed.)*
- **Relevance [I].**
  - All mass-gap results for compact **Lie** groups are at **strong coupling**, or for d = 2 at all couplings.
  - In 4D, a volume-uniform LSI at weak coupling would **imply** a lattice mass gap, via the SZZ/Piazza–Shen mechanism. The converse is not automatic.
  - The two-scale disintegration in [36] suggests a multiscale LSI route, analogous to Bauerschmidt-style multiscale Bakry–Émery [48]. It is the clearest "dynamical" lead toward a gap, but nobody has a mechanism for d = 4.
  - The Durhuus–Fröhlich implication gives area law from a uniform gap of the auxiliary (d−1)-dimensional slab σ-model (§1.5). It does **not** give area law from the YM gap itself. *(Verifier: corrected overstatement.)*

### 2.4 Higgs scaling limits and Abelian theories
- **Chatterjee** [7], [THM, PMP 7 (2026) 339–381]: in any d ≥ 2, SU(2) YMH in unitary gauge, with $\alpha g=c\varepsilon$ and $g=O(\varepsilon^{50d})$, has a massive **Gaussian** scaling limit. The author calls it the first scaling limit of a non-Abelian LGT above d = 2, and the first rigorous Higgs mass generation in such a theory.
- **Rajasekaran–Yakir–Zhou** [26] extend this to any compact connected matrix Lie group, in the "complete breakdown of symmetry" regime.
- **Chatterjee–Yakir** [18]: exponential decay for U(1) lattice Higgs at small mass, removing a large-mass hypothesis of Osterwalder–Seiler. The method is a Glimm–Jaffe–Spencer cluster expansion around a massive Gaussian, following Bałaban et al. 1984.
- These are "abelianising" limits. A non-Gaussian limit is **[OPEN]**, and the authors say so.

### 2.5 Renormalisation-group continuation (the "Bałaban line")
- **Bałaban's 1980s results** are covered in note 02, refs 37–41. The headline is ultraviolet stability, i.e. uniform bounds on effective actions on a fixed torus (3D; substantial progress in 4D). It is [THM] as published, but Bauerschmidt calls it incomplete and hard to verify [97], and the effective-action → continuum-observable bridge is missing (see below).
- **BCHZ's assessment** [37, §1.1], which I read: Bałaban's UV-stability theorem gives uniform estimates on effective coarse theories. Even in 2D it is unclear how those effective observables relate to the continuum theory, so his results cannot be compared directly with SQ constructions. They add that a better understanding of Bałaban might advance SQ. **This is the single most important technical warning for evaluating a Bałaban-based 4D claim [I].**
- **Dimock** (2023–2024): Gross–Neveu RG structural stability and correlation functions [52]. He also has earlier QED₃ UV stability (note 02, ref. 44).
- **Duch** [45, 46]: Gross–Neveu via the Polchinski flow equation (v3, Oct 2026, corrects errors), plus lecture notes on the flow-equation approach to singular SPDEs.
- **Kopper** [47]: UV asymptotically free solutions of the 4D scalar flow equations with non-polynomial boundary conditions, satisfying the OS growth condition. This is relevant as a template for AF control in a flow-equation framework.
- **Abdelghani–Bauerschmidt–Hofstetter–Zeitouni** [48]: infinite-volume limit, uniform LSI and **mass gap** for the hierarchical sinh-Gordon model, via multiscale RG plus LSI.
- **Bailleul–Chevyrev–Gubinelli** [5]: Wilson–Itô diffusions, a forward–backward SDE formulation of RG flow. It is proposed as a non-perturbative quantisation method that also applies to gauge theories (programmatic, 8 pp.).
- **Chevyrev–Gubinelli** [50]: a priori estimates ("large field problem") for coercive singular PDEs.
- **Benedetti–Chevyrev–Gurau** [51]: equivalence of path-integral and stochastic quantisation for scalar theories, via forest interpolation.
- **Gantumur** [53], [JHEP 07 (2026) 036]: a dynamical lattice regulator with exact SE(d) covariance and proven reflection positivity. Universality is conditional on a stated short-range hypothesis.
- **Open LLM programmes** (§2.2) and **OpenAI** all build on Bałaban, per the committee statement [93] and SciAm [97].

### 2.6 Critical (d = 4) analytic technology
- **Deng–Shen** [49] [PREPRINT]: the 4D elliptic Anderson model with coupling $\lambda|\log\varepsilon|^{-1/2}$. The Green's function converges to a Gaussian field.
- The technique is a truncated renormalised parametrix expanded to order $|\log\varepsilon|$, with new Hepp-tree multiscale bounds that balance log losses against factorial gains.
- The authors name $\Phi^4_4$ and YM as future targets.
- The proof of Thm 1.1 was **autoformalised in Lean 4, conditional on one external proposition**: Prop. 3.6, the main result of a cited companion paper [GR26]. Y. Jia and P. Liang (UC Berkeley) and the SAIR Foundation helped. ChatGPT 5.4 Pro contributed early ideas (a toy-model proof not included). ChatGPT 5.5 Pro helped complete two proof steps (Prop. 5.6, Steps 3 and 4(b)). **Relevance [I]:** this is a direct prototype of "infinitely many renormalisations at a critical dimension", which is exactly YM₄'s situation in SPDE form.

### 2.7 Chiral fermions and the "unified completion"
- **Craig** [62] [PREPRINT; GPT-6-Astra-assisted, with 16 Lean modules; note 02]: a gauge-invariant overlap-fermion measure for nonabelian chiral gauge theories, including the Standard Model, on admissible fields.
- **Witten** [63], 3 Nov 2026 [PREPRINT]: a variant in which the lattice gauge field is interpolated to the continuum and coupled to continuum chiral fermions; Hsu proposed the same idea independently. Witten notes that it is implementable in principle but not by Monte Carlo, because the chiral path integral is not positive. His acknowledgments credit Claude with help on many details.
- **Mastropietro** [64]: vanishing of the anomaly for a lattice chiral U(1) model at weak coupling.
- QCD is vectorlike, so none of this is needed for pure YM or QCD existence. It matters only for OpenAI's GUT claim.

### 2.8 Formalisation and AI in the frontier literature
**Formalisation:**
- **Douglas–Hoback–Mei–Nissim** [65]: a Lean 4 / Mathlib proof that the 4D free scalar field satisfies the Glimm–Jaffe (OS-variant) axioms. Its initial assumptions (Minlos, nuclearity, Goursat) have since been removed. §1.4 is a status report: 3D pure YM in the continuum is still open.
- **Douglas** [66]: a "named physical postulates" discipline, formalising Seiberg–Witten in Lean. Douglas argues it is the right standard for AI physics output.
- **Mei–Douglas** [67]: mechanical numerical and vacuity checks against bad Lean statements.

**AI disclosures in frontier papers** (now routine):
- BCHZ [37]: GPT-6 Astra and GPT-5.6 Sol proved **seven** named results: Props 3.55 and 3.59, and Lemmas 3.58, 5.26, 11.45, 11.46 and 11.55. The authors state AI was not used to generate new ideas. One further argument is marked as suggested by GPT-6 Astra. *(Verifier: corrected from "six named lemmas".)*
- Deng–Shen [49] (above).
- Piazza–Shen [36]: Claude used for literature search and formula checking.
- Witten [63]: Claude.
- Craig [62]: GPT-6 Astra, which he calls "essential". Note that Craig lists an **OpenAI** affiliation alongside KITP/UCSB.
- Aronow–Lopatto [90]: Claude, GPT-6 Astra and GPT-6.1 Sol wrote essentially everything.

**AI benchmarks:** Hairer co-authored *First Proof* [68], ten unpublished research questions with encrypted answers.

### 2.9 Surveys and expository sources
- **Chevyrev**, *Stochastic quantisation of Yang–Mills* [54], J. Math. Phys. 63 (2022), ICMP 2021. Still the standard SQ-YM survey.
- **Shen**, *A stochastic PDE approach to large N problems in QFT: a survey* [55], J. Math. Phys. 2022.
- **Chatterjee**, *Yang–Mills for probabilists* [56], 2018. The probabilists' problem list; no newer Chatterjee survey was found.
- **Cao–Sheffield**, *Fractional Gaussian forms and gauge theory: an overview* [10], 84 pp., 2024. Gives a Gaussian 1-form framework and open problems on scaling limits, including off-critical / non-Gaussian YM.
- **Douglas**, *The Yang–Mills Millennium problem*, Nat. Rev. Phys. 8 (2026) 86–97 [57]. Verified on Crossref; paywalled and not read. A seminar abstract says Douglas suggests tensor-RG methods "will be adequate", especially with duality arguments. The abstract is by Y. Meurice, Univ. of Iowa, 10 Feb 2026, and the verifier fetched it. This is secondhand only: the review itself was not read.
- **Hairer** [58]: *Probabilistic interpretation of QFTs*, 2025 (Liouville and Segal axioms, not YM).
- **Hairer's 2026 lectures:**
  - the Heilbronn Distinguished Lectures, Feb 2026 [59], on the probabilistic YM mass-gap formulation, gauge-covariant renormalisation, and $\Phi^4_3$ as a toy model for the YM dynamic. Seen only via search snippets; the page now returns 404, so [unverified];
  - a talk on SQ of gauge theories at the **Simons PPQFT annual meeting**, 30 Apr–1 May 2026 [60]. Verified page; speakers included Chatterjee, Hairer, Klebanov, Kupiainen, Seiberg and Sheffield.
- I found **no ICM or "Abel lecture" by Hairer on YM**. The ICM 2026 speaker list could not be confirmed from fetched pages.
- **BCHZ** [37], §1.1: the most up-to-date expert literature map, as of 2 Nov 2026.
- **Duch** [46]: flow-equation lecture notes.
- **Benedetti–Chevyrev–Gurau** [51]: pedagogical treatment of the path-integral/SQ equivalence.

---

## 3. Claimed solutions of the Millennium problem, 2023–2026: catalogue and credibility

### 3.1 Catalogue

| # | Date | Claim (venue) | What is claimed | Verdict | Main failure mode |
|---|---|---|---|---|---|
| C1 | 2023-07-03 (v7 2025-01) | A. P. C. Lim, *Positive mass gap of quantum YM fields*, arXiv:2307.00788 [72] | 4D Wightman theory for any compact simple G, with a mass gap from the quadratic Casimir | **[AI-ASSESSED: DOES NOT ENGAGE KNOWN OBSTACLES]** | Builds a Hilbert space as a countable sum of **non-separable** spaces indexed by irreps, with states given by surfaces. The abstract claims Wightman's axioms; the body says a "modified version". There are no local fields in the usual sense and no lattice link. Asymptotic freedom is invoked only formally [I]. The "gap" is put in through the Casimir |
| C2 | 2023-01-17 | P. Mondal, *A geometric approach to the YM mass gap*, arXiv:2301.06996 [74] | Gap from Bakry–Émery Ricci curvature of orbit space | **[HEUR]**, by the author's own description | Assumes the quantum theory exists. Regularised curvature positivity is not proved |
| C3 | 2024-04-16 | S. Farinelli, arXiv:2406.16881 (math.GM) [73] | Confinement for small bare coupling, **given** a mass gap | **[AI-ASSESSED: DOES NOT ENGAGE KNOWN OBSTACLES]** as a solution | Conditional on the gap, and it is the gap that is open. Lives in math.GM |
| C4 | 2025-03-06 (v3 2026-09) | S. Gauvin, arXiv:2503.15539 (physics.gen-ph) [75] | Gap certificates for **regulated** Hamiltonians, plus conditional continuum criteria | Honest partial; **not a solution** | The abstract itself lists the unproved 4D construction, fields and uniform gap |
| C5 | 2025-05-30 | D. C. Jacobsen, *A Constructive Proof of Existence and Mass Gap for Pure SU(3) YM in 4D*, arXiv:2506.00284 [70] | Full Clay solution for SU(3) via a 5D orbifold regulator and a "convergent polymer expansion" | **[AI-ASSESSED: SUSPECTED ERROR]**; v2 **withdrawn by arXiv admin** for not meeting quality standards | Strong-coupling expansion applied at weak coupling, with an inverted bound (§3.2) |
| C6 | 2025-06/07 | Y. Agawa, addendum to a claimed SU(N) gap proof, Cambridge Open Engage [85] | Fixes for quantum corrections and Gribov uniqueness | **Retracted by the author** | The author withdrew it as unvalidated |
| C7 | 2025-09-03 | P. Faria da Veiga, M. O'Carroll, arXiv:2509.03513 [77] | Charge-conjugation sectors and Elitzur-type results for 4D lattice SU(N); a "local mass term" in the Haar density | Legitimate **partial lattice** results, not a solution | No continuum. The gap discussion is heuristic ("expected") |
| C8 | 2026-03-02/04 | A. J. Maley, Zenodo 18836567 / 18860202, plus a "Lean audit" 20523056 [80] | OS axioms, Wightman reconstruction and gap for Spin, Sp and all exceptional groups, via a gradient-flow small-t limit | **[NOT ASSESSED]** | Not read; only the description was seen. |
| C9 | 2026-03-09 | J. C. Ayoub, Zenodo 18923521 [81] | The problem should be "retired" | **[AI-ASSESSED: DOES NOT ENGAGE KNOWN OBSTACLES]** | Philosophical, with no mathematics |
| C10 | 2026-04-11 | Han-Jun Lim, Zenodo 19511196 [78] | SU(3) existence and gap from a "rendering algebra" $M_3(\mathbb C)\otimes M_4(\mathbb C)$ | **[AI-ASSESSED: DOES NOT ENGAGE KNOWN OBSTACLES]** | A finite-dimensional algebra stands in for an infinite-dimensional QFT, and the gap is read off eigenvalues {3, 4, 7} |
| C11 | 2026-04 | Preprints.org 202604.0332 [86] | Claimed gap proof (per search summary) | Unread; HTTP 403 | — |
| C12 | 2026-04-28 | L. Kim, S. Kim, Zenodo 19852878 [83] | No-go theorems for a Gribov–Zwanziger class of approaches | Not a solution; **self-described limitations** | (Useful as a negative result, if correct) |
| C13 | 2026-05-28 | J. Carvalho et al. (with LLM "co-authors"), Zenodo 20432205 [84] | "Conditional Lean 4 exercises" | Explicitly **not a proof** | Hard parts axiomatised. This is the canonical conditional-formalisation pitfall |
| C14 | 2026-06-01 | Errante, Schultz, Hosain, Zenodo 20509758 [79] | SU(2) YM on a **spatial torus**, constructed as a continuum limit, has a gap | **[AI-ASSESSED: DOES NOT ENGAGE KNOWN OBSTACLES]** as stated | A gap in finite spatial volume is not the problem; uniformity in volume is. The continuum construction is asserted |
| C15 | 2026-06-08 | V. Logvinovich, Zenodo 20592714 [82] | Clay formulation "contradictory": Gribov copies plus Singer's theorem are said to force reflection-positivity violation | **[AI-ASSESSED: SUSPECTED ERROR]** [I] | Confuses gauge-fixed propagators, which need not be reflection positive, with gauge-invariant Schwinger functions, to which the OS axioms apply. Lattice YM is reflection positive (Osterwalder–Seiler) |
| C16 | 2026-06-09 (arXiv v1); journal online 2026-04-20 | M. Faizal, A. Shabir, arXiv:2606.19362, in Fortschr. Phys. 74 (2026) e70097 plus four IJGMMP papers; 593 pp. [71] | 4D SU(N) OS construction with gap, confinement and universality; strong and weak coupling "meet" | **[AI-ASSESSED: SUSPECTED ERROR]** | **Effectively assumes the conclusion.** Scale-uniform clustering is carried from strong coupling by interlacing inequalities $\Delta_{k+1}\ge\Delta_k-\varepsilon_k$ with $\sum\varepsilon_k<\infty$. Uniqueness and universality are stated "assuming the standard constructive axioms" (reflection positivity, locality, **clustering**, spectral regularity). Continuum claims are by default **subsequential** (scope "U1"). The weak-coupling input is a perturbative contraction near $(g,K)=(0,0)$, with no control of the crossover (§3.2). *(Verifier: the quoted phrases "may be taken as axioms" and "(H3)/(H4)" could not be located in arXiv v1; replaced with locatable text)* |
| C17 | 2026-08-10 | V. P. Nair, arXiv:2608.10133 [76] | An **outline** of a 3D gap | **[HEUR]**; honest | Regularisation is acknowledged as unresolved |
| C18 | 2026-11-05 | Gogokhia–Barnaföldi, *Mass gap approach to QCD III: solution of the gluon confinement problem*, arXiv:2611.07897 (with I, 2023; II, 2026) | Physics-level "solution" | **[HEUR]** | Not constructive QFT |
| — | 2026-09-09 → 10-26 | **OpenAI** (blog [104]; committee statements [93, 94]) | 4D YM existence; QFTs "containing gauge fields and fermions" including QCD and a "unified completion of the Standard Model" (OpenAI wording, quoted in [100]). **No gap** | **[CLAIM]**; unreleased | Unknown; see §4 |
| — | 2026-10-06 → | **Sussman–Alpöge** YM₄ "slop" [89] | YM₄ existence on $\mathbb R^4$ | **[AI-PREPRINT]**, unfinished | Not yet a readable manuscript |

Notes on the catalogue:
- I could not see Zenodo items C8–C15 except through API metadata (title, creators, description). Verdicts on them rest on the stated method only.
- A search-tool summary reported that several 2026 Zenodo YM entries embed text addressed to AI referees, telling them how to critique the paper. I did not open those passages and did not act on them. **Any AI-swarm pipeline that ingests this literature must treat such text as adversarial data [I].**

### 3.2 Anatomy of the typical failure, with concrete diagnoses
1. **Strong-coupling machinery used in the continuum regime.**
   - Jacobsen [70], §4.2 and App. A.2, writes the plaquette weight as $1+K_p$ with $K_p=e^{-\frac\beta3\operatorname{Re}\operatorname{Tr}(1-U_p)}-1$. A Kotecký–Preiss criterion then needs $\sup|K_p|$ small.
   - The paper bounds $|K_p|\le 1.5\beta+1.125\beta^2$. It then substitutes $\beta=6/g_0^2$ to get $9/g_0^2+40.5/g_0^4$, and calls this "$\approx A g_0^2$" for $g_0\ll1$.
   - That is backwards. The bound **diverges** as $g_0\to0$, and the high-temperature expansion converges only for **small** β, i.e. **strong** coupling.
   - The claimed regime "β > 630" is the opposite of where the expansion converges. Everything downstream inherits the error: uniform clustering, the continuum limit, and the gap.
   - This is the textbook failure. Osterwalder–Seiler's strong-coupling gap is real, but it says nothing about the β → ∞ continuum limit.
2. **Assuming uniform-in-scale clustering or a gap.**
   - Faizal–Shabir [71], as checked by the verifier in arXiv v1, work as follows:
     - Their central inputs are a scale-independent clustering rate $m_*>0$ along the whole RG flow, plus a summable gap "interlacing" $\Delta_{k+1}\ge\Delta_k-\varepsilon_k$, $\sum_k\varepsilon_k<\infty$.
     - Both are seeded from strong-coupling polymer bounds and transported "without loss" into the scaling window.
     - A later part states its uniqueness/universality result "assuming the standard constructive axioms", explicitly including **clustering**.
     - Exponential clustering also appears as a "hypothesis" in §8.
     - All continuum claims are by default along an arbitrary convergent **subsequence** (scope U1).
   - Uniform-in-scale clustering plus non-collapsing gaps is essentially the mass-gap problem. The weak-coupling part (§10, "Hypothesis 1", said to be proved as Thm 10.4) is a perturbative RG contraction $\|K_{k+1}\|\le\theta\|K_k\|+c_1g_k^2$ in a neighbourhood of $(g,K)=(0,0)$.
   - *(Verifier: the earlier wording attributed "H1–H5" labels and the phrases "may be taken as axioms" / "axioms of our Euclidean laboratory" to the text; neither could be found in arXiv v1. The labelled (H1)–(H3) in the PDF, in §12, concern the horizon projector, selector and Faddeev–Popov positivity. The substantive diagnosis stands; the quotes were removed.)*
   - It never controls the crossover from small $g$ (UV) to the strongly coupled IR, where the gap lives. Nor does it handle Bałaban's large-field problem [I].
   - Publication in a physics journal does not change this.
3. **Redefining the target.** Lim's "modified Wightman axioms" and non-separable Hilbert space; Han-Jun Lim's finite-dimensional algebra; gaps placed by fiat (Casimir eigenvalues).
4. **Finite-volume or fixed-cutoff gaps** (Gauvin, Errante et al., Faria da Veiga–O'Carroll). Any compactly regulated Hamiltonian has discrete spectrum. The content is **uniformity** in the cutoff and the volume.
5. **Heuristic geometry with no regularisation** (Mondal, Nair). Orbit-space curvature and Bakry–Émery positivity are the right intuition; compare the lattice Bakry–Émery results [40]. But in the continuum they need exactly the renormalisation control that is missing.
6. **Conditional or "audit" formalisations** (Carvalho, Maley). Lean files that axiomatise the analytic inputs prove nothing about YM. Compare Deng–Shen [49], which is honest about its single assumed proposition.
7. **Misreading gauge fixing as an obstruction** (Logvinovich). Gribov copies are a property of gauge-fixed formulations. The lattice theory is gauge invariant and reflection positive with no gauge fixing.

**Positive contrast [I].** The credible 2026 efforts share three features: Sussman–Alpöge, Aronow–Lopatto, and presumably OpenAI, per the committee's description.
- They (a) work at **weak coupling** with Bałaban's small-field/large-field multiscale RG.
- They (b) use reflection positivity only as a technical tool for large-field suppression or O(d) restoration, not as a source of a gap.
- They (c) state their limitations: subsequential limits, a finite torus, selected observables, no gap.

---

## 4. Expert commentary since Sept 2026: what an OpenAI YM proof would need to contain

**Primary and secondary statements.** Tags: [P] primary, [S] press, [C] blog or comment.

| Who | Point | Source |
|---|---|---|
| Shepherding committee (Douglas, Gross, Jaffe, Klebanov, Nekrasov) | First validate that the Lean definitions and problem statement match the standard ones, and that the formalisation matches the informal proof. Credits Bałaban's RG and Wilson's lattice. Says the proof followed the theory "to infinite distances" and found its "proper continuum limit". Confinement and mass gap remain open. Lean release hoped for the week after 3 Nov | [P] [93, 94, 95]; note 02 |
| AGMAI (Gowers, Hairer, Witten et al.) | No scientific reason to delay release once Lean is complete; release the natural-language and Lean outputs immediately | [P] [96] |
| R. Bauerschmidt (NYU) | Bałaban's papers are "not complete" and very hard to read, but completable [97]. Bałaban "basically did it", but nobody can tell whether the papers are correct [98]. Found the first O(3) paper "very reasonable" and the second "horrible" [99] | [S] [97, 98, 99] *(verifier: attribution split corrected)* |
| E. Sussman (Northwestern) | Clay needs 4D [97]. In blog comments [100]:<br>– The key in Bałaban is control through the continuum limit while keeping physical predictions, not compactness.<br>– Their own limits are subsequential, with all OS axioms claimed, including the linear-growth condition E0′.<br>– QED₃ includes a nonzero connected four-point function; YM₃ includes a short-distance calculation, a stress tensor and Wilson loops.<br>– Unknown whether OpenAI has full sequential convergence | [S] [97]; [C] [100] |
| J. Baez (comment on Woit's post) | A construction might produce a free or otherwise wrong theory, so it must be checked (e.g. with Wilson loops). A gap alone does not identify YM. The IR limit from T⁴ to ℝ⁴ is a separate major step that Bałaban did not complete | [C] [100] |
| "Prokhorov_tightness" / "thelastcontrarian" (pseudonymous commenters) | Compactness gives only subsequential limits. The Jaffe–Witten footnote excludes compactness-only existence. Asks for nontriviality, AF agreement, a stress tensor and an OPE | [C] [100] |
| M. Martins Costa (commenter) | Sussman–Alpöge treat specific observables only. The IR (Landau pole, confinement) is the hard part, which is why Bałaban worked in finite volume | [C] [100] |
| P. Woit | The headline is misleading because it omits the gap. Questions how OS positivity and reconstruction are handled. Says the meaning of "unified completion of the Standard Model" is unclear and explicitly declines to guess. A commenter mentions "simplest grand unified theory" language, source not identified. A public Lean release would allow fast checking | [C] [100] *(verifier: removed an incorrect "he guesses SU(5)"; note that Craig's companion [62] treats SU(5) with 10 ⊕ 5̄ [I])* |
| T. Buckmaster (NYU) | Disputes OpenAI's statement that Lean verification took over a month; says checking a Lean proof takes at most a couple of days | [S] [97] |
| M. Douglas (Harvard) | A major advance. The sigma model is the classic "warm-up" | [S] [97, 99] |
| BCHZ (Hairer et al.), 2 Nov | Footnote: OpenAI has announced a continuum construction building partly on Bałaban, but it is not public. Main text: even in 2D it is unclear how the observables of Bałaban's effective coarse theory relate to the continuum | [P] [37] |

**Synthesis: a checklist an OpenAI-type proof must satisfy before it counts as "existence" in the Clay sense [I].**
1. **Gauge group scope.** Every compact simple G, or a stated subset. The committee speaks of "pure YM"; the groups are not disclosed.
2. **Regularisation and limit.** Wilson LGT on $(a\mathbb Z/L\mathbb Z)^4$, with $a\to0$ along the AF trajectory. Is the convergence **full**, or only along a subsequence? The Jaffe–Witten footnote and the commenters make this the first question.
3. **UV stability à la Bałaban,** with small- and large-field regions, uniform in $a$ on a fixed torus. Is it re-proved in full, or cited?
4. **The bridge to observables.** A precise map from effective actions to Schwinger functions of gauge-invariant observables. BCHZ say this is unclear even in 2D. Which observables count?
   - smeared $\operatorname{Tr}F^2$ and other composite fields, which require composite-operator renormalisation;
   - smoothed or flowed Wilson loops, which need a $t\downarrow0$ limit to reach local fields;
   - bare Wilson loops, which in 4D need perimeter and corner renormalisation.
5. **Infinite volume, T⁴ → ℝ⁴.** This is the hardest point if there is no gap [I]. Without exponential clustering one needs volume-uniform local bounds (from chessboard and reflection positivity estimates?) and tightness, and the limit may not be unique.
   - Check whether OS4 (the cluster property, i.e. a unique vacuum) is proved, or only OS0–OS3.
   - The committee's "infinite distances" wording suggests the claim includes ℝ⁴. Alpöge says the same for theirs.
6. **Euclidean invariance.** Recovering full O(4) from hypercubic symmetry (Sussman–Alpöge use an RP trick).
7. **OS0′ regularity.** The linear-growth condition of OS II is needed for Wightman reconstruction (note 01).
8. **Nontriviality.** Non-Gaussian connected four-point functions, or a running coupling matching AF. This is essential because $\Phi^4_4$ is trivial (Aizenman–Duminil-Copin, cited in [65]).
9. **Short-distance agreement** with renormalised perturbation theory, with a stress tensor and OPE as Jaffe–Witten request.
10. **Universality, or at least independence** from regulator choices (Wilson vs Villain/heat-kernel actions). Desirable but not strictly Clay.
11. **Lean statement fidelity.** Which axiom system is encoded. How Schwartz space, tempered distributions and the gauge-invariant local fields are defined. That no custom axioms are used (Comparator / `#print axioms`; note 04). Mechanical vacuity checks [67].
12. **The mass gap is not claimed,** so neither the Clay prize criteria nor confinement are at stake. The committee says so explicitly.

---

## 5. Chronological table (2023 – 5 Nov 2026)

| Date (arXiv v1 / event) | Item | Status | Significance |
|---|---|---|---|
| 2023-01-17 | Mondal, geometric YM gap [74] | HEUR | Orbit-space Bakry–Émery heuristic |
| 2023-02-23 | Chevyrev–Shen, 2D invariant measure and universality [1] | THM (CPAM 2026) | 2D YM = unique invariant measure; lattice universality |
| 2023-02-28 | Bringmann–Rodnianski, gauge-covariant stochastic wave [ref. in text] | THM (PMP 2025) | Hyperbolic gauge SPDE |
| 2023-03-05 | Mastropietro, lattice chiral anomaly [64] | THM (AHP) | Rigorous RG for chiral lattice U(1) |
| 2023-05-03 | Park–Pfeffer–Sheffield–Yu, surface sums (plane) [3] | THM (PMP 2026) | Wilson loops as surface sums in 2D |
| 2023-05-12 | Bringmann–Cao, paracontrolled 2D SYM [2] | THM (Mem. AMS 319 (2026), no. 1624) | Second 2D local theory |
| 2023-07-03 | Lim, "positive mass gap" [72] | AI-ASSESSED: DOES NOT ENGAGE KNOWN OBSTACLES | Modified axioms |
| 2023-07-13 | Cao–Park–Sheffield, random surfaces [4] | THM (Comm. AMS 5 (2025) 774–896) | Finite-N gauge/string duality, any d |
| 2023-07-21 | Bailleul–Chevyrev–Gubinelli, Wilson–Itô diffusions [5] | PREPRINT | FBSDE RG programme, gauge-applicable |
| 2023-09-14 | Abdelghani–Nissim, master loop equation [6] | PREPRINT | Geometric derivation |
| 2024-01-19 | Chatterjee, SU(2) YMH scaling limit [7] | THM (PMP 2026) | First non-Abelian scaling limit above 2D (Gaussian) |
| 2024-01-24 | Shen–Zhu–Zhu, YMH Langevin [8] | PREPRINT | Gap at strong coupling with Higgs |
| 2024-01-25 | M. C. Lee, Axioms for quantum YM II [library] | PREPRINT | Minkowski axioms |
| 2024-03-27 | Duch, Gross–Neveu via Polchinski flow [45] | PREPRINT (v3 2026) | Flow-equation construction |
| 2024-04-15 | Chevyrev–Garban, Villain action [9] | THM (JSP 2025) | Villain as limit of Wilson/Manton |
| 2024-04-16 | Farinelli [73] | AI-ASSESSED: DOES NOT ENGAGE KNOWN OBSTACLES | Gap ⇒ confinement, conditional |
| 2024-06-27 | Cao–Sheffield, fractional Gaussian forms [10] | Survey | Gaussian 1-forms; open problems |
| 2024-11-18 | Borga–Cao–Shogren-Knaak, large-N surface sums [12] | PREPRINT | Catalan-weighted surfaces |
| 2024-12-19 | Shen–Smith–Zhu, MM equations lattice → continuum (2D) [13] | PREPRINT | Loop equations in continuum |
| 2025-01-24 | Hairer, probabilistic interpretation of QFT [58] | Expository | Liouville and Segal |
| 2025-02-20 | Guo–Li–Yang–Zhu, SU(3) bootstrap [88] | JHEP 2025 | Rigorous numerical plaquette bounds via positivity |
| 2025-03-04 | Chevyrev–Shen, uniqueness of 3D renormalisation [14] | THM (ARMA 2026) | Unique gauge-covariant mass counterterm |
| 2025-03-06 | Gauvin [75] | Partial / conditional | Regulated gap certificates |
| 2025-05-22 | Cao–Nissim–Sheffield, expanded area law [15] | PREPRINT | Beyond Osterwalder–Seiler 1978 |
| 2025-05-30 | Jacobsen [70] | AI-ASSESSED: SUSPECTED ERROR; withdrawn by arXiv | Inverted polymer bound |
| 2025-06/07 | Agawa addendum [85] | Retracted | — |
| 2025-09-03 | Faria da Veiga–O'Carroll [77] | Partial lattice | C-sectors, Elitzur |
| 2025-09-04 | Cao–Nissim–Sheffield, dynamical area law [17] | PREPRINT | Area law in whole 't Hooft regime |
| 2025-09-23 | Chatterjee–Yakir, U(1) Higgs [18] | PREPRINT | Bałaban-style cluster expansion |
| 2025-10-23 | Chevyrev–Gubinelli, large field problem [50] | PREPRINT | A priori bounds for singular PDE |
| 2025-10-26 | Nissim, U(N) 't Hooft regime [19] | PREPRINT | Gap and infinite-volume limit for U(N) |
| 2025-11-10 | Brennecke, free energy $K_d$ [20]; Duch lecture notes [46] | PREPRINT (JSP, to appear) | — |
| 2025-11-29 | Shen–Smith–Zhu, MM for YMH [21] | PREPRINT | Open Wilson lines needed |
| 2025-12-26 | Gantumur, dynamical lattice regulator [53] | JHEP 2026 | RP plus exact SE(d) covariance |
| 2026-01-12 | Douglas, *The YM Millennium problem* [57] | Review (Nat. Rev. Phys.) | Status survey (not read) |
| 2026-01-31 | Chatterjee, 3D confinement with central U(1) [22] | PREPRINT (to appear) | Log confinement at all β |
| 2026-02-05 | *First Proof* (Hairer et al.) [68] | Benchmark | AI research-level test |
| 2026-02-09 | Dang–Nohra, 2D universality on all surfaces [23] | PREPRINT | — |
| 2026-02-10/12 | Hairer, Heilbronn lectures [59] | Unverified | YM mass gap, probabilistic formulation |
| 2026-03-02/04 | Maley Zenodo claims [80] | NOT ASSESSED | — |
| 2026-03-09/11 | Lévy combinatorial formula [24]; Dahlqvist large N [25] | PREPRINT | 2D exact results |
| 2026-03-11 | Benedetti–Chevyrev–Gurau [51] | PREPRINT | PI ⇔ SQ equivalence |
| 2026-03-16 | Douglas–Hoback–Mei–Nissim, *Formalization of QFT* [65] | Lean artefact | 4D free field OS in Lean |
| 2026-03-25/26 | Rajasekaran–Yakir–Zhou [26]; Tlas [27] | PREPRINT | Gaussian YMH limits, any G |
| 2026-04-11 | Han-Jun Lim Zenodo [78] | AI-ASSESSED: DOES NOT ENGAGE KNOWN OBSTACLES | — |
| 2026-04-17 | Lemoine, universal dualities [28] | PREPRINT | Action-agnostic finite-N |
| 2026-04-30 / 05-01 | Simons PPQFT annual meeting [60] | Event | Hairer on SQ of gauge theories |
| 2026-05-14 | Sevostyanov, tree-free 3D YM model [29] | PREPRINT | Multi-index model |
| 2026-05-15 | Nissim, SO(3) deconfinement [30] | PREPRINT | Trivial centre ⇒ no area law |
| 2026-05-28 | Carvalho conditional Lean [84] | Not a proof | Conditional-formalisation pitfall |
| 2026-06-01 | Errante et al. Zenodo [79] | AI-ASSESSED: DOES NOT ENGAGE KNOWN OBSTACLES | — |
| 2026-06-08 | Logvinovich Zenodo [82] | AI-ASSESSED: SUSPECTED ERROR | — |
| 2026-06-09 | Faizal–Shabir, 593 pp. [71] (journal version online 2026-04-20) | AI-ASSESSED: SUSPECTED ERROR (published, Fortschr. Phys.) | Clustering effectively assumed |
| 2026-06-27 | Lemoine, heat-kernel master field on $\mathbb Z^d$ [31] | PREPRINT | Large N, strong coupling, area-law bound |
| 2026-07-07 | Douglas, Seiberg–Witten in Lean [66] | Lean artefact | Postulate discipline |
| 2026-07-11 | Deng–Shen, 4D Anderson [49] | PREPRINT (+ Lean, conditional) | First critical-SPDE renormalisation to order $\lvert\log\varepsilon\rvert$ |
| 2026-07-24 | Chevyrev–Klose–Mohamed [32] | PREPRINT | Rough Uhlenbeck compactness |
| 2026-07-27 | Chhaibi et al., Morse theory [33] | PREPRINT | Fourth 2D construction |
| 2026-08-10 | Nair, 3D gap outline [76] | HEUR | — |
| 2026-08-28 | Chevyrev–Qu–Shen, 3D Abelian Langevin limit [34] | PREPRINT | Universal Gaussian dynamic |
| 2026-09-09 | OpenAI: natural-language YM proof completed (per OpenAI) | CLAIM | — |
| 2026-09-15 | Abdelghani–Bauerschmidt–Hofstetter–Zeitouni [48] | PREPRINT | Hierarchical gap via RG + LSI |
| 2026-09-18 | OpenAI QCD (per OpenAI); Barashkov et al., 2D Abelian YMH [35] | CLAIM / PREPRINT | — |
| 2026-10-04 | OpenAI, 2D O(3) massive continuum limit [92] | CLAIM (O(3) paper not Lean-formalised; companion O(n) decay result Lean-formalised per OpenAI [106]) | AF plus gap "warm-up" |
| 2026-10-05 | Kopper, AF flow equations [47] | PREPRINT | OS-growth AF solutions |
| 2026-10-06 | Craig, chiral lattice measure [62]; Sussman–Alpöge repo public [89]; `openai/math` release | PREPRINT / AI-PREPRINT | — |
| 2026-10-12 | Goldstein (repo owner), scalar QED₃ repo [91] | AI-PREPRINT | King programme |
| 2026-10-16 | OpenAI: YM Lean formalisation completed (per OpenAI) | CLAIM | — |
| 2026-10-21 | Hsu, Standard Model on a bosonic lattice with continuum Weyl fermions [103] | PREPRINT | Same idea as Witten [63] |
| 2026-10-23/26 | Aronow–Lopatto, 3D SU(2) torus (Hexagon) [90] | AI-PREPRINT | Flowed-loop continuum limit on T³ |
| 2026-10-26 | OpenAI announcement; Woit post [100]; Piazza–Shen LSI [36]; AGMAI release call [96] | — / PREPRINT | — |
| 2026-10-27 | Committee statement 1 [93]; SciAm [97, 98] | P / S | Release plan |
| 2026-11-02 | **BCHZ, 2D non-Abelian YMH** [37] | PREPRINT | First non-Abelian YMH measure (2D) |
| 2026-11-03 | Committee 2nd statement and rules [94]; Witten, chiral lattice [63] | P / PREPRINT | Lean release "hopefully next week" |
| 2026-11-05 | Gogokhia–Barnaföldi III | HEUR | — |

---

## 6. What is proven vs open (5 Nov 2026)

| Statement | Status | Key refs |
|---|---|---|
| 2D YM measure on compact surfaces (measure: classical); universality of Wilson/Villain/Manton | THM (torus); PREPRINT (all genus) | [1, 23] |
| 2D YM Langevin dynamic: global, unique invariant measure = YM | THM | [1] |
| 2D non-Abelian YMH measure (all couplings) | PREPRINT (Nov 2026) | [37] |
| 3D YM(H) Langevin: local well-posedness, gauge covariance, unique renormalisation | THM | [38, 14] |
| 3D non-Abelian YM measure (even on T³) | **OPEN** in the refereed literature; AI-PREPRINT claims [89, 90] | — |
| 3D Abelian lattice Langevin → Gaussian dynamic | PREPRINT | [34] |
| 3D confinement (log potential) for G ⊇ central U(1), all β | THM (classical; new proof preprint) | [22] |
| 3D non-Abelian continuum mass gap | **OPEN** (HEUR outline) | [76] |
| Lattice gap and area law at strong coupling, any d, any G (centre needed for area law) | THM (Osterwalder–Seiler 1978); extended regimes PREPRINT | [15, 17, 19, 40] |
| Deconfinement for trivial-centre SO(3) at strong coupling | PREPRINT | [30] |
| LSI for 2D lattice SU(N) at all β | PREPRINT | [36] |
| 4D lattice non-Abelian gap / area law at **all** β | **OPEN** | [37] |
| Large-N lattice YM at strong coupling: limit, factorisation, 1/N, surface sums | THM / PREPRINT | [4, 12, 31, 40] |
| Non-Gaussian scaling limit of a non-Abelian LGT, d ≥ 3 | **OPEN** (Gaussian YMH limits are THM / PREPRINT) | [7, 26] |
| Bałaban UV stability on a fixed torus, d = 3, 4 | Published; regarded by experts as incomplete or unverified in 4D | note 02; [97] |
| Map from Bałaban's effective actions to continuum Schwinger functions | **OPEN** / unclear (BCHZ) | [37] |
| 4D YM existence on ℝ⁴ with OS/Wightman axioms | **CLAIM** (OpenAI: ℝ⁴ inferred from the committee's "infinite distances" wording [I]; Sussman–Alpöge slop, ℝ⁴ per Alpöge) | [89, 93] |
| Lattice weak-coupling correlation decay, **finite** gauge groups | THM | [43] |
| 4D YM mass gap | **OPEN**; no credible claim | [93] |
| 4D QCD existence | **CLAIM** (OpenAI) | [93] |
| Gauge-invariant lattice measure for chiral fermions (SM) | PREPRINT | [62, 63] |
| Critical d = 4 singular SPDE renormalisation (linear model) | PREPRINT | [49] |
| Lean: 4D free scalar field satisfies OS/Glimm–Jaffe from Mathlib only | Machine-checked (per authors) | [65] |
| Published or posted "full solutions" (Jacobsen, Faizal–Shabir, Lim, Zenodo set) | **AI-ASSESSED: SUSPECTED ERROR / DOES NOT ENGAGE KNOWN OBSTACLES** | §3 |

---

## 7. Relevance to a 4D YM existence + mass-gap proof and to Lean formalisation

1. **Which route reaches d = 4 [I].**
   - SQ is critical at d = 4. The frontier there is still linear: Deng–Shen [49].
   - Gaussian scaling limits [7, 26] avoid the problem by abelianising.
   - Strong-coupling methods cannot reach weak coupling.
   - The only route with 4D UV control is **Bałaban's multiscale RG**. Every serious 2026 effort converges on it: OpenAI per the committee, Sussman–Alpöge, Aronow–Lopatto, and the Goldstein repository on King's programme. Our plan should treat a Bałaban-type UV stability theorem as the backbone and budget for the effective-action → observable bridge that BCHZ flag.
2. **Pick observables early.**
   - Gradient-flowed observables are UV-finite and gauge invariant, with a ready state space [41, 42]; see Wilson loops or heat-flow trajectories at $t>0$. They make a clean intermediate theorem.
   - Clay needs local fields, so a second theorem is needed: the small-flow-time expansion / composite-operator renormalisation to $\operatorname{Tr}F^2(x)$.
   - The Lean statement should expose both layers. That would let us compare directly with whatever OpenAI releases [I].
3. **Infinite volume without a gap is the soft spot [I].** If OpenAI or Sussman–Alpöge reach ℝ⁴ by tightness, check whether OS4 (unique vacuum) is proved. Our Lean statement should demand it, consistent with the Jaffe–Witten exclusion of weak existence.
4. **Mass gap leads.** The frontier provides:
   - (a) the Durhuus–Fröhlich implication: a uniform gap of the auxiliary slab σ-model implies area law, for nontrivial centre [17] (not "YM gap ⇒ area law");
   - (b) LSI / Bakry–Émery at strong coupling [8, 19, 40], all couplings in 2D [36], and multiscale LSI in hierarchical models [48];
   - (c) master-loop and surface-sum representations [4, 15, 31];
   - (d) 3D log confinement with a central U(1) [22].

   None gives a mechanism at weak coupling in 4D. A uniform-in-volume LSI for 4D lattice SU(N) along the AF trajectory would imply a lattice gap. It is at least as hard as the gap, so it is a strengthening of the problem, not a route around it [I].
5. **Lean lessons from the frontier.**
   - (i) Conditional formalisation is widespread: Deng–Shen with one assumed proposition [49], and the Carvalho and Maley Zenodo items. Our rules (no custom axioms; `sorry` tracked) are necessary and correct.
   - (ii) Douglas et al. [65] show the analytic base (Minlos, nuclear spaces, OS for Gaussian fields) is now in Mathlib reach. That is the obvious seed for OS-axiom definitions.
   - (iii) Mechanical vacuity and numerical checks of statements [67] should be part of our statement-audit pipeline.
   - (iv) Comparator-style separation of challenge from solution (note 04).
6. **AI-orchestration lessons** (for the plan, not for the proof).
   - Frontier humans now use LLMs for bounded lemmas with disclosure: BCHZ, Deng–Shen, Witten, Piazza–Shen.
   - Fully machine-written efforts flag low human understanding: Aronow–Lopatto, Sussman–Alpöge. Sussman–Alpöge report that condensing slop loses implicit definitions. Our swarm should keep definitions explicit and machine-checkable at every condensation step [I].
   - Adversarial text in the claimed-solution literature (§3.1 note) argues for strict input sanitisation of agent context.

---

## 8. Open questions and leads

1. **When OpenAI's Lean statement appears** (expected week of 9 Nov), run the §4 checklist: gauge groups, ℝ⁴ vs T⁴, full vs subsequential, OS4, which fields, nontriviality, axioms used. Compare it with our option-1 statement.
2. **Sussman–Alpöge YM₃ (OS for tr F²):** the most checkable 3D claim. A targeted audit of the RP O(d) trick (RPM1) and the large-field estimates is a good first deep-dive for our swarm.
3. **Aronow–Lopatto:** why only the sequences $nM^k$? Can the flowed-loop measure be upgraded to OS Schwinger functions, and to infinite volume?
4. **The BCHZ bridge question:** produce a precise statement relating Bałaban effective actions to continuum observables, first in 2D where the answer is known [1], as a test case.
5. **Critical SPDE:** can the Deng–Shen machinery handle a nonlinear critical model ($\Phi^4_4$ is trivial; YM₄ is AF)? Watch Deng, Shen, Hairer and Gubinelli.
6. **Multiscale LSI:** can Piazza–Shen's two-scale disintegration [36] be iterated in 3D at weak coupling? The hierarchical sinh-Gordon result [48] is the model.
7. **The O(3) sigma model (OpenAI [92]):** an independent audit of the asymptotically free, massive continuum limit would be the best available proxy for judging OpenAI's 4D methods.
8. **Douglas Nat. Rev. Phys. review** [57]: obtain it (paywalled) and confirm its tensor-RG remark.
9. **Hexagon:** a new AI-preprint server (hexagonmath.org) with provenance labels. Track it for further YM/QFT items.
10. **Unverified items to recheck:**
    - the Heilbronn lecture page [59];
    - the Preprints.org claim [86];
    - Hsu's chiral-fermion paper: **located by the verifier**, arXiv:2610.29019 [103];
    - Witten's possible further comments.

---

## References

Verified = existence confirmed by arXiv API, Crossref DOI, GitHub API, Zenodo API, or a live page fetch (HTTP 200) in this session. "PDF" = a copy is in `library/pdfs/`.

**A. Frontier mathematics (arXiv; all verified via the arXiv API)**
1. Chevyrev, I.; Shen, H. *Invariant measure and universality of the 2D Yang–Mills Langevin dynamic.* arXiv:2302.12160; CPAM 79 (2026) 1973–2102, doi:10.1002/cpa.70043 (Crossref verified). PDF.
2. Bringmann, B.; Cao, S. *A para-controlled approach to the stochastic Yang–Mills equation in two dimensions.* arXiv:2305.07197; Mem. Amer. Math. Soc. 319 (2026), no. 1624, doi:10.1090/memo/1624 (Crossref verified by verifier). PDF.
3. Park, M.; Pfeffer, J.; Sheffield, S.; Yu, P. *Wilson loop expectations as sums over surfaces on the plane.* arXiv:2305.02306; PMP 7 (2026) 37–121, doi:10.2140/pmp.2026.7.37 (Crossref verified).
4. Cao, S.; Park, M.; Sheffield, S. *Random surfaces and lattice Yang–Mills.* arXiv:2307.06790; Comm. Amer. Math. Soc. 5 (2025) 774–896, doi:10.1090/cams/59 (Crossref verified by verifier). PDF.
5. Bailleul, I.; Chevyrev, I.; Gubinelli, M. *Wilson–Itô diffusions.* arXiv:2307.11580. PDF.
6. Abdelghani, O.; Nissim, R. *Geometric derivation of the finite N master loop equation.* arXiv:2309.07399.
7. Chatterjee, S. *A scaling limit of SU(2) lattice Yang–Mills–Higgs theory.* arXiv:2401.10507; PMP 7 (2026) 339–381, doi:10.2140/pmp.2026.7.339 (Crossref verified). PDF.
8. Shen, H.; Zhu, R.; Zhu, X. *Langevin dynamics of lattice Yang–Mills–Higgs and applications.* arXiv:2401.13299. PDF.
9. Chevyrev, I.; Garban, C. *Villain action in lattice gauge theory.* arXiv:2404.09928; J. Stat. Phys. 192(3), art. 38 (2025), doi:10.1007/s10955-025-03420-1 (Crossref verified by verifier).
10. Cao, S.; Sheffield, S. *Fractional Gaussian forms and gauge theory: an overview.* arXiv:2406.19321. PDF.
11. Forsström, M. P. *Pure perimeter laws for Wilson lines observables.* arXiv:2409.20085. Also: *Phase transitions in the charged compact abelian lattice Higgs model*, arXiv:2602.21679; Malacan, A. *Ursell functions in lattice gauge theory*, arXiv:2512.02322.
12. Borga, J.; Cao, S.; Shogren-Knaak, J. *Surface sums for lattice Yang–Mills in the large-N limit.* arXiv:2411.11676.
13. Shen, H.; Smith, S. A.; Zhu, R. *Makeenko–Migdal equations for 2D Yang–Mills: from lattice to continuum.* arXiv:2412.15422.
14. Chevyrev, I.; Shen, H. *Uniqueness of gauge covariant renormalisation of stochastic 3D Yang–Mills–Higgs.* arXiv:2503.03060; ARMA 250 (2026) 11, doi:10.1007/s00205-025-02163-3 (Crossref verified). PDF.
15. Cao, S.; Nissim, R.; Sheffield, S. *Expanded regimes of area law for lattice Yang–Mills theories.* arXiv:2505.16585. PDF.
16. Borga, J.; Cao, S.; Shogren-Knaak, J. *Surface sums in two-dimensional large-N lattice Yang–Mills: cancellations and explicit computations for general loops.* arXiv:2508.13827.
17. Cao, S.; Nissim, R.; Sheffield, S. *Dynamical approach to area law for lattice Yang–Mills.* arXiv:2509.04688 (read: Thm 1.6). PDF.
18. Chatterjee, S.; Yakir, O. *Correlation decay for U(1) lattice Higgs theory: the case of small mass.* arXiv:2509.19176.
19. Nissim, R. *U(N) lattice Yang–Mills in the 't Hooft regime.* arXiv:2510.22788. PDF.
20. Brennecke, C. *On the leading order term of the lattice Yang–Mills free energy.* arXiv:2511.07297 (J. Stat. Phys., to appear).
21. Shen, H.; Smith, S. A.; Zhu, R. *Makeenko–Migdal equations for lattice Yang–Mills–Higgs.* arXiv:2512.00570.
22. Chatterjee, S. *A short proof of confinement in three-dimensional lattice gauge theories with a central U(1).* arXiv:2602.00436. PDF.
23. Dang, N. V.; Nohra, E. *The Yang–Mills measure on compact surfaces as a universal scaling limit of lattice gauge models.* arXiv:2602.08591.
24. Lévy, T. *A combinatorial formula for Wilson loop expectations on compact surfaces.* arXiv:2603.08509.
25. Dahlqvist, A. *Large N limit of Wilson loops on orientable closed surfaces…* arXiv:2603.11374.
26. Rajasekaran, F.; Yakir, O.; Zhou, Y. *Gaussian limits of lattice Higgs models with complete symmetry breaking.* arXiv:2603.24555. PDF.
27. Tlas, T. *A concentration of measure phenomenon in lattice Yang–Mills.* arXiv:2603.25236.
28. Lemoine, T. *Universal dualities for Wilson loops in lattice Yang–Mills.* arXiv:2604.16252.
29. Sevostyanov, A. *A tree-free approach to 3D Yang–Mills Langevin dynamic…* arXiv:2605.14616.
30. Nissim, R. *Deconfinement for SO(3) lattice Yang–Mills at strong coupling.* arXiv:2605.16162. PDF.
31. Lemoine, T. *The heat-kernel master field on $\mathbb Z^d$ at strong coupling.* arXiv:2606.28945. PDF.
32. Chevyrev, I.; Klose, T.; Mohamed, A. *A PDE approach to the 2D Yang–Mills measure.* arXiv:2607.22236. PDF.
33. Chhaibi, R.; Dang, N. V.; Guedes Bonthonneau, Y.; Rivière, G.; Tô, T. D. *The Yang–Mills measure on surfaces via Morse theory.* arXiv:2607.24640.
34. Chevyrev, I.; Qu, Y.; Shen, H. *Scaling limit of the 3D abelian Yang–Mills Langevin dynamics.* arXiv:2608.27828. PDF.
35. Barashkov, N.; Chandra, A.; Chevyrev, I.; Koller, A.; Mohamed, A. *A variational approach for the 2D Abelian Yang–Mills–Higgs measure.* arXiv:2609.21972.
36. Piazza, J.; Shen, H. *Log-Sobolev inequality for 2D SU(N) lattice gauge theory at all couplings.* arXiv:2610.35286 (AI disclosure read). PDF.
37. Bringmann, B.; Cao, S.; Hairer, M.; Zhao, W. *Construction of the 2D non-Abelian Yang–Mills–Higgs measure via stochastic quantisation.* arXiv:2611.03640 (§1.1 and §1.3 read). PDF.
38. Chandra, A.; Chevyrev, I.; Hairer, M.; Shen, H. *Stochastic quantisation of Yang–Mills–Higgs in 3D.* arXiv:2201.03487; Invent. Math. 237 (2024) 541–696, doi:10.1007/s00222-024-01264-2. PDF.
39. Chandra, A.; Chevyrev, I.; Hairer, M.; Shen, H. *Langevin dynamic for the 2D Yang–Mills measure.* arXiv:2006.04987; Publ. Math. IHÉS 136 (2022) 1–147. PDF.
40. Shen, H.; Zhu, R.; Zhu, X. *A stochastic analysis approach to lattice Yang–Mills at strong coupling.* arXiv:2204.12737; CMP (2023), doi:10.1007/s00220-022-04609-1. PDF.
41. Cao, S.; Chatterjee, S. *A state space for 3D Euclidean Yang–Mills theories.* arXiv:2111.12813; Comm. Math. Phys. 405 (2024), art. 3, doi:10.1007/s00220-023-04870-y (Crossref verified by verifier). PDF.
42. Cao, S.; Chatterjee, S. *The Yang–Mills heat flow with random distributional initial data.* arXiv:2111.10652; Comm. PDE 48 (2023) 209–251, doi:10.1080/03605302.2023.2169937 (Crossref verified by verifier). PDF.
43. Adhikari, A.; Cao, S. *Correlation decay for finite lattice gauge theories at weak coupling.* arXiv:2202.10375; Ann. Probab. 53 (2025) 140–174, doi:10.1214/24-AOP1702 (Crossref verified by verifier). PDF.
44. Chatterjee, S. *A probabilistic mechanism for quark confinement.* arXiv:2006.16229; CMP (2021), doi:10.1007/s00220-021-04086-y. PDF.

**B. RG and analytic methods**
45. Duch, P. *Construction of Gross–Neveu model using Polchinski flow equation.* arXiv:2403.18562 (v3, Oct 2026). PDF.
46. Duch, P. *Lecture notes on the flow equation approach to singular stochastic PDEs.* arXiv:2511.07120.
47. Kopper, C. *Asymptotically free solutions of the scalar flow equations.* arXiv:2610.06165.
48. Abdelghani, O.; Bauerschmidt, R.; Hofstetter, M.; Zeitouni, O. *Mass gap for the hierarchical sinh-Gordon model.* arXiv:2609.17461. PDF.
49. Deng, Y.; Shen, H. *The four-dimensional Anderson model: a case study for critical SPDEs.* arXiv:2607.10105 (AI and Lean statements read; Lean repository github.com/sairmath/anderson4d_lean is cited in the paper but was not opened). PDF.
50. Chevyrev, I.; Gubinelli, M. *Large field problem in coercive singular PDEs.* arXiv:2510.20716.
51. Benedetti, D.; Chevyrev, I.; Gurau, R. *From path integral quantization to stochastic quantization: a pedestrian's journey.* arXiv:2603.10761.
52. Dimock, J. *Correlation functions for the Gross–Neveu model.* arXiv:2406.16799; Dimock, J.; Yuan, C. *Structural stability of the RG flow in the Gross–Neveu model.* arXiv:2303.07916.
53. Gantumur, T. *Rotationally invariant dynamical lattice regulators for Euclidean QFTs.* arXiv:2512.22072; JHEP 07 (2026) 036, doi:10.1007/JHEP07(2026)036 (Crossref verified).

**C. Surveys and expository sources**
54. Chevyrev, I. *Stochastic quantisation of Yang–Mills.* arXiv:2202.13359; J. Math. Phys. 63 (2022), doi:10.1063/5.0089431. PDF.
55. Shen, H. *A stochastic PDE approach to large N problems in quantum field theory: a survey.* arXiv:2208.02381; J. Math. Phys. (2022), doi:10.1063/5.0089851. PDF.
56. Chatterjee, S. *Yang–Mills for probabilists.* arXiv:1803.01950. PDF.
57. Douglas, M. R. *The Yang–Mills Millennium problem.* Nat. Rev. Phys. 8 (2026) 86–97, doi:10.1038/s42254-025-00909-2. Crossref verified; **not read** (paywalled). The tensor-RG remark is secondhand only. It comes from Y. Meurice's University of Iowa seminar abstract "Remarks about the Yang–Mills Millennium problem" (10 Feb 2026), https://physics.uiowa.edu/event/36209/0. The verifier fetched the page (HTTP 200) and confirmed the remark.
58. Hairer, M. *Probabilistic interpretation of quantum field theories.* arXiv:2501.14361.
59. Heilbronn Institute. *2026 Distinguished Lecture Series by Martin Hairer* (10–12 Feb 2026). **Not verified**: seen in search results only; the URLs returned 404.
60. Simons Foundation. *2026 Simons Collaboration on Probabilistic Paths to QFT Annual Meeting* (30 Apr – 1 May 2026). https://www.simonsfoundation.org/?p=39271 — verified (page fetched; speaker list read).
61. Chaban, I.; Nekrasov, N. *Lectures on gauge theories and many-body systems.* arXiv:2512.23099 (verified; peripheral).

**D. Chiral fermions and the lattice Standard Model**
62. Craig, N. *A gauge-invariant measure for lattice chiral fermions.* arXiv:2610.09093. PDF.
63. Witten, E. *A note on lattice definition of gauge theories with chiral fermions.* arXiv:2611.05051 (abstract and acknowledgments read). PDF.
64. Mastropietro, V. *Vanishing of the anomaly in lattice chiral gauge theory.* arXiv:2303.02790; Ann. Henri Poincaré 25 (2024) 1047–1081, doi:10.1007/s00023-023-01274-5 (Crossref verified by verifier).

**E. Formalisation and AI**
65. Douglas, M. R.; Hoback, S.; Mei, A.; Nissim, R. *Formalization of QFT.* arXiv:2603.15770 (§1.4 read). PDF.
66. Douglas, M. R. *Axioms for physical reasoning: codifying the Seiberg–Witten solution in Lean.* arXiv:2607.06379. PDF.
67. Mei, A.; Douglas, M. R. *Beyond LLM Judge: mechanical verification for agentic autoformalization.* arXiv:2610.20573.
68. Abouzaid, M.; Blumberg, A. J.; Hairer, M.; et al. *First Proof.* arXiv:2602.05192.
69. Barkeshli, M.; Douglas, M. R.; Freedman, M. H. *Artificial intelligence and the structure of mathematics.* arXiv:2604.06107.

**F. Claimed solutions (each existence-verified; status as in §3)**
70. Jacobsen, D. C. *A constructive proof of existence and mass gap for pure SU(3) Yang–Mills in four-dimensional space-time.* arXiv:2506.00284 (v2 = arXiv-admin withdrawal; v1 read, §4 and App. A). PDF (v1).
71. Faizal, M.; Shabir, A. *Reflection-positive construction of a four-dimensional SU(N) Yang–Mills theory with mass gap and confinement.* arXiv:2606.19362; Fortschr. Phys. 74 (2026) e70097, doi:10.1002/prop.70097 (Crossref verified). Contents, standing hypotheses and §10 hypothesis read. PDF.
72. Lim, A. P. C. *Positive mass gap of quantum Yang–Mills fields.* arXiv:2307.00788 (§1–2 read). PDF.
73. Farinelli, S. *Four dimensional quantum Yang–Mills theory for weak coupling strength: mass gap implies quark confinement.* arXiv:2406.16881.
74. Mondal, P. *A geometric approach to the Yang–Mills mass gap.* arXiv:2301.06996.
75. Gauvin, S. *Pinched multi affine geometry and confinement: describing the Yang–Mills mass gap.* arXiv:2503.15539.
76. Nair, V. P. *Towards a proof of mass gap in 3d Yang–Mills theory.* arXiv:2608.10133 (read). PDF.
77. Faria da Veiga, P. A.; O'Carroll, M. *On charge conjugation, correlations, Elitzur's theorem and the mass gap problem in lattice SU(N) Yang–Mills models in d = 4.* arXiv:2509.03513.
78. Lim, Han-Jun. *Yang–Mills mass gap from the rendering algebra R12.* Zenodo 19511196 (2026-04-11). Verified via the Zenodo API.
79. Errante, B.; Schultz, S.; Hosain, J. *Yang–Mills mass gap — complete proofs.* Zenodo 20509758 (2026-06-01). Verified via the Zenodo API.
80. Maley, A. J. *Yang–Mills mass gap for orthogonal and symplectic groups in four dimensions*, Zenodo 18836567; *… for the exceptional groups*, Zenodo 18860202; *AASC Yang–Mills Lean4 audit endpoint*, Zenodo 20523056. All verified via the Zenodo API.
81. Ayoub, J. C. *The recommended dissolution of the Yang–Mills mass gap problem.* Zenodo 18923521. Verified via the Zenodo API.
82. Logvinovich, V. *Topological obstruction to the Yang–Mills mass gap on ℝ⁴…* Zenodo 20592714. Verified via the Zenodo API.
83. Kim, L.; Kim, S. *Geometric obstructions to the proof of the Yang–Mills mass gap…* Zenodo 19852878. Verified via the Zenodo API.
84. Carvalho, J. et al. *Conditional Lean 4 formalization exercises around the Yang–Mills mass gap — Phases 1 & 2.* Zenodo 20432205. Verified via the Zenodo API.
85. Agawa, Y. *(Retracted) Quantum corrections and finite Gribov uniqueness in a non-local gauge theory: an essential addendum…* Cambridge Open Engage, https://www.cambridge.org/engage/coe/article-details/6873e33f23be8e43d6082975 — verified (page fetched).
86. Preprints.org manuscript 202604.0332 (claimed YM gap). **Not verified**: HTTP 403; known only from a search summary.
87. Gogokhia, V.; Barnaföldi, G. G. *The mass gap approach to QCD. III. Solution of the gluon confinement problem.* arXiv:2611.07897 (parts I and II: arXiv:2301.04561, 2605.21547). All three verified via the arXiv API.
88. Guo, Y.; Li, Z.; Yang, G.; Zhu, G. *Bootstrapping SU(3) lattice Yang–Mills theory.* arXiv:2502.14421; JHEP 12 (2025) 033.

**G. Open LLM-driven programmes and OpenAI artefacts**
89. Sussman, E.; Alpöge, L. *Yang–Mills-LLM-experiment* (GitHub; created 2026-10-06, last pushed 2026-11-02). https://github.com/ethanwsussman/Yang--Mills-LLM-experiment — verified (GitHub API; README read in full).
90. Aronow, P. M.; Lopatto, P. *The continuum limit of three-dimensional SU(2) lattice Yang–Mills theory on a torus I–V.* Hexagon preprints 2610.00506, 00509, 00510, 00511, 00512 (submitted 23 Oct, v1 dated 26 Oct 2026), https://hexagonmath.org/2610.00506v1 — verified (the verifier fetched all five pages; each is labelled "Primarily AI-generated text" and "Human understanding: no parts"; the provenance names Claude, GPT-6 Astra and GPT-6.1 Sol); repository https://github.com/pmaronow/3d-ym-torus — verified (GitHub API).
91. Goldstein, M. (repository owner) *Existence of scalar QED* (GitHub). https://github.com/marikgoldstein/scalar-qed-existence — verified (GitHub API; README read).
92. OpenAI (unnamed internal model). *The canonical massive continuum limit of the two-dimensional O(3) model* (4 Oct 2026). Companions in the same family 215: *An isolated particle pole for the two-dimensional O(3) spin field* (4 Oct); *Exact mass asymptotics for the two-dimensional O(4) lattice model* (5 Oct); *Sharp mass bounds for the two-dimensional O(4) model* (23 Sep). All in `openai/math/preprints`, https://github.com/openai/math — verified (GitHub API listing; `CONTENTS.md` abstracts read by the verifier). The repository README says results are at "different stages of verification" and that unformalised ones "could have issues". The O(3) continuum paper is **not** Lean-formalised; see [106] for what is.

**H. Committee, commentary and press**
93. Douglas, Gross (chair), Jaffe, Klebanov, Nekrasov. *Proof by OpenAI of the existence of quantum Yang–Mills theory — statement by the shepherding committee* (Oct 2026). https://www.kitp.ucsb.edu/sites/default/files/YM_working_group.pdf — verified (HTTP 200; content per note 02).
94. Same committee. *2nd statement* (3 Nov 2026). https://www.kitp.ucsb.edu/sites/default/files/2nd-Statement-About-Quantum-YangMills-Theory_Nov-3.pdf — verified (HTTP 200; content per note 02).
95. KITP. *Statement by the Yang–Mills Working Group — November 3, 2026 update.* https://www.kitp.ucsb.edu/statement-by-the-yangmills-working-group — verified (HTTP 200).
96. AGMAI statements (25–26 Oct 2026). https://agmai.org/ — verified (HTTP 200; content per note 02).
97. Howlett, J. (sole byline; edited by L. Billings; the verifier corrected this from "Howlett, J.; Hall, P."). *OpenAI just scooped human researchers on a million-dollar quantum math problem.* Scientific American, 27 Oct 2026. https://www.scientificamerican.com/article/openai-just-scooped-human-researchers-on-a-million-dollar-quantum-math-problem/ — verified (fetched).
98. Howlett, J.; Hall, P. *Dueling proofs from OpenAI and Anthropic astound scientists.* Scientific American, 27 Oct 2026. https://www.scientificamerican.com/article/dueling-proofs-from-openai-and-anthropic-astound-scientists/ — verified (fetched).
99. Hall, P.; Howlett, J. *The most exciting claims from OpenAI's heap of new proofs.* Scientific American, 8 Oct 2026. https://www.scientificamerican.com/article/the-most-exciting-claims-from-openais-heap-of-new-proofs/ — verified (fetched).
100. Woit, P. *Secret Unified Physics Slop* (Not Even Wrong, 26 Oct 2026, with updates and comments by Baez, Sussman and others). https://www.math.columbia.edu/~woit/wordpress/?p=15948 — verified (fetched; comment attributions as displayed on the blog).
101. Woit, P. *New Morning* (4 Nov 2026; notes Witten's chiral paper). https://www.math.columbia.edu/~woit/wordpress/?p=15979 — verified (fetched).
102. Jaffe, A.; Witten, E. *Quantum Yang–Mills theory* (Clay problem description). https://www.claymath.org/wp-content/uploads/2022/06/yangmills.pdf — verified (HTTP 200; content per note 01).

**I. Added by the verifier**
103. Hsu, S. D. H. *The Standard Model on a finite bosonic lattice with continuum Weyl fermions.* arXiv:2610.29019 (21 Oct 2026; 101 pp.). Verified via the arXiv API; this is ref. [17] of Witten [63].
104. OpenAI. *Working with academic communities to build scientific understanding* (blog, Oct 2026). https://openai.com/index/building-scientific-understanding-with-academic-communities/ — exists per the search index. Direct fetch returned HTTP 403. Its dates (9 Sep YM natural-language proof; 18 Sep QCD; 16 Oct Lean formalisation of YM existence) and the "unified completion of the Standard Model" wording are corroborated by Woit's verbatim quotation [100]. Verified=partial.
105. Craig, N. *Mathematical companion and Lean formalization for "A gauge-invariant measure for lattice chiral fermions".* Zenodo 23196062 (6 Oct 2026). Verified via the Zenodo API. It treats SU(5) with 10 ⊕ 5̄ and its restrictions to the four Standard Model global forms.
106. OpenAI (unnamed internal model). *Exponential decay in two-dimensional classical O(n) models* (23 Sep 2026), `openai/math/preprints/Exponential-decay-in-two-dimensional-classical-On-models-September-23-2026`. Lean scope per `lean/docs/215.md` and the Comparator challenge `ClassicalON.lean`: exponential decay of spin correlations at every β > 0 for n ≥ 3 on finite square-lattice subgraphs (free boundary), with uniform constants. The infinite-volume limit and the O(4) gap claim are not included. Verified (GitHub; scope doc read). Not independently checked.

*Not separately listed (cited in the text from other notes):* Bałaban's CMP papers 1984–1989, Magnen–Rivasseau–Sénéor 1993, Dimock's Bałaban exposition, Lüscher's chiral papers (all verified in note 02); M. C. Lee, *Axioms for quantum YM II*, arXiv:2401.13899 (in library); Bringmann, B.; Rodnianski, I., arXiv:2302.14271, PMP 6 (2025) 139–193, doi:10.2140/pmp.2025.6.139 (Crossref verified).

---

## Verification log

*Adversarial verification pass, 2026-11-05. Corrections above are marked "(Verifier: …)".*

### 1. Reference existence and metadata

- **arXiv (83 IDs).** All queried in batches via the arXiv API (`export.arxiv.org/api/query?id_list=…`). All 83 exist, and titles and authors match the note. No fabricated arXiv reference was found. Dates in §5 and §3.1 were cross-checked against the API `published` field. One row was fixed: Lévy is 2026-03-09, not 03-08. Hsu (arXiv:2610.29019) was found via Witten's bibliography and verified; it is added as [103].
- **DOIs on Crossref (22).** All resolve with matching title and authors: [1], [3], [7], [9], [14], [38], [39], [40], [44], [53], [54], [55], [57], [71], [88], Bringmann–Rodnianski, plus newly found DOIs for [2], [4], [41], [42], [43] and [64].
  - [9] now resolves; the earlier "not resolved" note was removed.
  - **Out-of-date "to appear" or "accepted" statuses corrected:** [2] Mem. AMS 2026; [4] Comm. AMS 2025; [41] CMP 2024; [42] Comm. PDE 2023, which the earlier text mis-described as "CMP accepted"; [43] Ann. Probab. 2025; [64] AHP 2024.
  - [71] Faizal–Shabir: the journal version was online on **20 Apr 2026**, before arXiv v1 (9 Jun 2026). Recorded in §3.1 and §5.
- **GitHub (6 repos).** Checked via the API:
  - ethanwsussman/Yang--Mills-LLM-experiment: created 2026-10-06, last push 2026-11-02. README read in full; page counts, workflow and ℝ⁴ claim confirmed. A `QCD3/` directory exists. The README also says RPM1 was completed by GPT-6 "Astra".
  - pmaronow/3d-ym-torus: created 2026-10-17. README read; "too complex for Lean autoformalisation or our own understanding" confirmed.
  - marikgoldstein/scalar-qed-existence, openai/math, sairmath/anderson4d_lean, mrdouglasny/seiberg-witten: all exist.
- **Zenodo (10 records)** via the API: 18836567, 18860202, 20523056, 18923521, 19511196, 19852878, 20432205, 20509758, 20592714, 23196062. All exist, with titles, creators and dates matching. Maley's "Lean audit" record is dated 2026-06-03.
- **Web pages, fetched by curl (HTTP 200) and read where it mattered:**
  - KITP statements 1 and 2 and the KITP update page;
  - AGMAI (members include Gowers, Hairer, Witten; 26 Oct release call confirmed);
  - the three SciAm articles (bylines and dates from the page JSON-LD);
  - Woit posts 15948 and 15979 (title "New Morning", 4 Nov);
  - the Clay PDF;
  - the Simons PPQFT page (speakers and Hairer talk title confirmed);
  - Cambridge Engage / Agawa (retracted by the author, v2 20 Jul 2025);
  - all five Hexagon pages;
  - the Iowa seminar page (now verified).
- **Still unverified:**
  - [59] Heilbronn lectures (search budget exhausted; no URL);
  - [86] Preprints.org 202604.0332 (HTTP 403);
  - [104] the OpenAI blog itself (HTTP 403). Its content is corroborated by Woit's quotation.
- **Library PDFs.** First-page identity checked for 40 cited PDFs. All match their IDs, so none was deleted. No new PDFs were downloaded.

### 2. Key claims checked against primary sources

| # | Claim | Result |
|---|---|---|
| 1 | BCHZ say the 4D non-Abelian lattice gap and confinement at all couplings is open; Bałaban's effective observables are unclear even in 2D; there is an OpenAI footnote | **Confirmed** (BCHZ §1.1 and fn. 5). The AI-disclosure count was **corrected**: seven results (two propositions, five lemmas), not "six lemmas" |
| 2 | Douglas et al.: 3D pure YM in the continuum is still open; the Minlos/nuclearity/Goursat assumptions have been removed | **Confirmed**. The same passage also says 2D YMH is still open as of Mar 2026, consistent with BCHZ being first |
| 3 | Cao–Nissim–Sheffield: area law for β < 1/(8(d−1)) for U(N)/SU(N), plus SO(even) | **Confirmed** (Def. 1.4, Thm 1.6). The **Durhuus–Fröhlich framing was corrected**: the hypothesis is a uniform gap of an auxiliary (d−1)-dimensional slab σ-model for all boundary fields, not the YM mass gap. §1.5, §2.3 and §7.4 were fixed |
| 4 | Jacobsen's inverted polymer bound | **Confirmed verbatim** (App. A.2–A.3): $1.5\beta+1.125\beta^2\to 9/g_0^2+40.5/g_0^4$ is called "$\approx Ag_0^2$", with "β > 630". arXiv-admin withdrawal of v2 confirmed |
| 5 | Faizal–Shabir "assume the conclusion" | **Substance confirmed, wording corrected.** The quoted phrases ("may be taken as axioms", "axioms of our Euclidean laboratory") and the H1–H5 = clustering/interlacing labelling **could not be found in arXiv v1**. The locatable evidence is now in the text: subsequential scope U1; a result stated "assuming the standard constructive axioms … clustering"; exponential clustering as a "hypothesis" in §8; and interlacing $\Delta_{k+1}\ge\Delta_k-\varepsilon_k$ |
| 6 | Chatterjee 3D: the $n\exp\{-c(1+n\beta)^{-1}T\log(R+1)\}$ bound | **Confirmed**; it is to appear in Adv. Nonlinear Stud. |
| 7 | Chatterjee SU(2) YMH: $\alpha g=c\varepsilon$, $g=O(\varepsilon^{50d})$, "first" claims, Gaussian | **Confirmed** |
| 8 | Deng–Shen: Lean conditional on one proposition; ChatGPT 5.4/5.5 Pro | **Confirmed**, with credit refined (Jia, Liang and the SAIR Foundation; Prop. 3.6 is from [GR26]) |
| 9 | OpenAI dates (9 Sep, 18 Sep, 16 Oct); committee membership; 1147 pp.; "infinite distances"; gap open | **Confirmed** (KITP PDFs; Woit's quotation of the OpenAI release). "Lean release promised for week of 9 Nov" was **corrected** to "hoped for 'next week'". "GUT" was replaced by OpenAI's own "unified completion of the Standard Model" |
| 10 | Expert quotes (§4) | Bauerschmidt's "basically did it" is from [98], not [97], and his O(3) "very reasonable" / "horrible" remarks are from [99]. **Corrected.** Buckmaster's point is that checking a Lean proof takes "at most a couple of days", **refined**. **Woit did not guess SU(5)**: he explicitly declines to guess, so this was **removed**. Baez, Sussman, "Prokhorov_tightness", "thelastcontrarian" and Martins Costa were all **confirmed** in the comment thread. [97]'s byline is Howlett alone, **corrected** |
| 11 | Witten: Hsu, Monte Carlo non-positivity, Claude | **Confirmed** |
| 12 | Craig: GPT-6 Astra, 16 Lean modules | **Confirmed**. Added: Craig lists an **OpenAI affiliation** |
| 13 | Aronow–Lopatto claims, non-claims, method and provenance | **Confirmed** |
| 14 | Lim "modified Wightman" | **Confirmed**, but the abstract claims Wightman's axioms and invokes AF, so the "no AF link" wording was softened |
| 15 | OpenAI O(3) artefact "self-labelled unchecked" | **Corrected.** The O(3) continuum paper is unformalised. The family's Lean component formalises 2D O(n), n ≥ 3, exponential decay at all temperatures on finite subgraphs [106]. That is a major claimed result in its own right (Polyakov's conjecture), and the note now flags it |
| 16 | "2D YM on any compact surface [THM] with universality" | **Corrected**: THM on the torus [1]; all-surface universality is PREPRINT [23] |
| 17 | RYZ "any compact G" | **Corrected** to compact connected matrix Lie group |
| 18 | "Uniform LSI would itself be the mass gap" / "equivalent in strength" | **Corrected** to "implies" |

### 3. Residual concerns

- Faizal–Shabir: the author may have quoted a different version (journal or IJGMMP companions). The verifier checked only arXiv v1 (593 pp. PDF in library). The diagnosis rests on the passages listed above.
- OpenAI material is self-reported. The blog is not directly fetchable, and nothing in the YM claim is publicly checkable until the Lean release. The ℝ⁴ scope of OpenAI's claim is an inference from committee wording.
- The note's §2.5 description of Bałaban's results relies on companion note 02; the verifier did not re-verify that here.
- The OpenAI 2D O(n) Lean claim [106] deserves its own audit with Comparator and `#print axioms`. If sound, it is a stronger datum about OpenAI's methods than the unformalised O(3) paper.
- Two references remain unverified ([59], [86]). The search-tool summary about AI-referee-directed text in Zenodo items (§3.1) was not re-verified, because the search budget was exhausted.
