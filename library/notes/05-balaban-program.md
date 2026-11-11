# 05 — Balaban's renormalization-group program for lattice Yang–Mills (and related constructive gauge theory)

*Workstream key:* `05-balaban-program` · *Compiled:* 2026-11-05 · *Status of sources:* see the access caveat in §0.

---

## 0. Access caveat (read first)

Balaban's own CMP papers (1982–1989) are open-access on Project Euclid, and two of them are also in the University of Michigan Deep Blue repository. In this session both sites sat behind bot-detection walls (Incapsula / Cloudflare). I did not try to get around them. So **I did not read the full text of any Balaban gauge-theory paper**. Everything below about what those papers contain comes from:

1. publisher metadata (Crossref) and abstracts (OSTI/ETDEWEB records of CMP 109 and CMP 122 I and II, quoted in paraphrase);
2. expert secondary accounts that I did read in full: Dimock's arXiv expositions and his 2013 ETH slides; Jaffe–Witten's Clay problem description; Rivasseau (2000); Douglas (2004); Summers (2012); Chatterjee (2018); Balaban–Imbrie–Jaffe CMP 114 (full text, author-hosted);
3. 2026 AI-assisted manuscripts that cite Balaban theorem-by-theorem (Aronow–Lopatto; Alpöge–Sussman), which are unvetted.

**Action item for the project:** a human should download the 12 YM papers and 5 precursor papers from Project Euclid (all free) and add them to `library/pdfs/`. Then the reconstructed statement in §2.4 should be checked against the actual text of Theorem 1 in CMP 109 (pp. 259, 267) and CMP 122 II (p. 355), and of Theorem 2 in CMP 109 (pp. 259–260).

*Verifier addition (2026-11-05):* a public ledger file in [68] contains page-cited verbatim transcriptions of CMP 109 and CMP 122 I–II. Those are the papers its author says he downloaded. §2.4 now uses them. They are **secondhand transcriptions from an unvetted source**, not primary reading.

---

## 1. Summary

* **What Balaban did.** Between 1984 and 1989 Tadeusz Bałaban published 12 papers in *Commun. Math. Phys.* on pure non-abelian lattice gauge theory: **399 journal pages** in total. They rest on about 150 more pages of precursors: scalar QED in d = 2, 3, and lattice Green's functions. The papers build a rigorous multiscale block-spin renormalization group (RG) for the **Wilson lattice action on a torus of fixed physical size**. Its main ingredients are:
  * gauge-covariant nonlinear block averaging;
  * local axial and Landau gauge fixing on "regular" (small-field) configurations;
  * a nonlinear variational problem that produces smooth background fields;
  * multiscale propagators in background fields, controlled by random-walk expansions;
  * cluster/polymer expansions;
  * a split of every scale into small-field and large-field regions;
  * in 4D, a "large-field renormalization" (the ℝ operation) and coupling-constant renormalization driven by asymptotic freedom.
* **What he proved (status: established as published, though never independently re-derived in full for 4D).** **Ultraviolet (UV) stability** for pure YM on 3D and 4D toroidal lattices. The effective actions produced by iterating the RG have a controlled representation, with bounds uniform in the lattice spacing ε → 0. A stability bound on the partition function follows. **In 4D the published theorem is conditional** *(verifier correction)*: it assumes that the whole sequence of running couplings g₀, …, g_K stays in an interval ]0, γ] with γ small. The companion statement that a bare coupling g₀(ε) can be chosen to make this true (asymptotic freedom inside the construction; "Theorem 2" of CMP 109, stated for SU(2)) was announced with its proof deferred, and was never published. Dimock's 2013 summary lists the 4D results as "bounds on effective densities for RG flow" and an **upper** stability bound. He adds an explicit caveat: a paper on the coupling-constant flow in second-order perturbation theory is **missing**. An unvetted 2026 analysis [68] transcribes Balaban's own 1989 remark (CMP 122, p. 355) that the proof of Theorem 2 "has not been published yet" (§3.4). The verifier read this transcription, not the primary page.
* **What he did not prove.** None of the following exist in Balaban's work:
  * correlation functions of gauge-invariant observables;
  * convergence (as opposed to bounds or compactness) of anything as ε → 0;
  * infinite volume;
  * the Osterwalder–Schrader (OS) axioms, including restoration of O(4) symmetry;
  * a mass gap.

  The program stopped at the partition function in finite volume. Rivasseau's open-problem list in 2000 included simply "simplify and rewrite Balaban's results".
* **Related constructive gauge theory.**
  * *Balaban–Imbrie–Jaffe (abelian Higgs, d = 2, 3):* a unit-lattice mass gap (with Brydges), plus an effective action and decoupling. The final continuum mass-gap step never appeared.
  * *King:* U(1) Higgs, continuum and infinite-volume limits in d = 2, 3, with all OS axioms except ergodicity and regularity.
  * *Gross and Driver:* U(1)₃ and U(1)₄ lattice theories converge to the free field.
  * *Gross–King–Sengupta:* 2D YM via stochastic differential equations.
  * *Federbush, "phase cell" I–VI:* incomplete.
  * *Magnen–Rivasseau–Sénéor (1993):* SU(2) YM₄ in the continuum with an infrared cutoff and a regularized axial gauge, with Slavnov identities proved nonperturbatively. The published abstract says it provides "the basis for" a rigorous construction and outlines it in one paper; Rivasseau later called it "a less advanced attempt". Not continued.
  * *Dimock (2002–2022):* the only sustained modern re-derivation of Balaban's method. It gives two-sided UV stability on T³ for φ⁴₃ (183 arXiv pp, three papers) and QED₃ (about 220 arXiv pp in three papers, plus a 16-pp overview). Scalar QED₃ is treated only in a bounded-field approximation (85 pp). *(Verifier correction: an earlier draft credited two-sided UV stability to scalar QED₃ as well.)* That is roughly 400 arXiv pages for theories much simpler than YM₄.
* **2026 landscape (all unverified).** Three things happened this autumn.
  * The OpenAI shepherding committee (Gross as chair; Douglas, Jaffe, Klebanov, Nekrasov) wrote that "Balaban's ideas were among the important elements" in OpenAI's claimed proof that 4D YM exists. The committee says these ideas let OpenAI follow the theory "all the way to infinite distances" and prove its continuum limit exists. That proof runs to **1147 pages** of LLM output. OpenAI's press release, as quoted by Woit [69] and press coverage, says the Lean formalization was finished on 16 Oct 2026. In the committee statement, 16 Oct is the date Gross was asked to take custody of the proof. The Lean files have not been released. The committee states that confinement and the mass gap remain open, and no mass gap is claimed.
  * Alpöge and Sussman, using Claude, posted a manuscript explicitly aimed at finishing Balaban's program:
    * QED₃: 242 pp;
    * YM₃: 857 + 1201 pp;
    * YM₄: unfinished. Their own overview says the "Target Theorem A" (an SU(2) action-density limit on ℝ⁴ with O(4) invariance, reflection positivity and inverse-square clustering, but **no mass gap**) "remains unproved". In the README, Alpöge adds that they "(appear to) have" an ℝ⁴ existence argument, but only in raw, unchecked form (about 61k pages of output).
  * Aronow and Lopatto posted an AI-written five-part, roughly 1,479-page continuum limit for SU(2) YM₃ on T³ (flowed Wilson loops), "in the tradition of Bałaban".
* **Page-count lesson.** Balaban's UV stability alone fills about 400 dense CMP pages, roughly 600–800 modern pages. Adding correlation functions, the continuum limit, OS axioms and an infrared argument makes **≈1,000–1,500 pages** a credible size for a Balaban-route 4D existence proof. That matches OpenAI's 1147 pages and the AI-written 3D manuscripts. The mass gap lies outside Balaban's toolkit.

---

## 2. Key definitions and statements

### 2.1 Lattice Yang–Mills on a torus

Fix a compact Lie group $G$. It is simple for the Clay problem. Dimock's slides describe Balaban's YM setting as a compact semisimple $G$, and Summers notes that SU(2) is usually taken where group details matter. As transcribed by [68], CMP 109 states its coupling-flow Theorem 2 for SU(2) only, calling the restriction "superficial". (Verifier addition; not checked against the primary text.) Fix a large odd integer $L$ (the block size) and integers $N$ (UV) and $M$ (volume). The lattice is the torus
$$\mathbb{T}^{-N}_{M}=(L^{-N}\mathbb{Z}/L^{M}\mathbb{Z})^{d},\qquad \varepsilon=L^{-N},\quad \text{side } L^{M},$$
with $d=3$ or $4$. A configuration assigns $U(b)\in G$ to each oriented bond $b$, with $U(-b)=U(b)^{-1}$. The plaquette holonomy is $U(\partial p)=\prod_{b\in\partial p}U(b)$. The Wilson action, up to normalization conventions, is
$$S_{g}(U)=\frac{1}{g^{2}}\sum_{p}\operatorname{Re}\operatorname{tr}\bigl(1-U(\partial p)\bigr),\qquad Z_{N}=\int e^{-S_{g_0}(U)}\prod_b dU(b),$$
with $dU$ the Haar measure. Gauge transformations act as $U(x,y)\mapsto h(x)U(x,y)h(y)^{-1}$. The physically meaningful objects are expectations of **gauge-invariant** observables: Wilson loops, plaquette or action densities, and gradient-flowed observables.

Reflection positivity of the Wilson measure, for reflections in lattice hyperplanes, is a theorem (Osterwalder–Seiler 1978, [54]). It is the main reason the lattice route is preferred: it hands one a Hilbert space and a transfer matrix.

**Faithfulness warning for formal statements.** For compact $G$ and Wilson action $S\ge 0$, the trivial bound $Z_N\le 1$ holds with normalized Haar measure. "UV stability" is therefore meaningful only **relative to the Gaussian (free) normalization**, or equivalently as a structural statement about effective actions. Any Lean statement of Balaban's theorem must avoid a trivially true formulation (§5.4).

### 2.2 Block-spin RG à la Balaban (schematic)

Balaban first rescales to a unit lattice $\mathbb{T}^{0}_{M+N}$, turning the UV problem into an infrared problem with tiny couplings. One RG step then has three parts:

1. **Averaging.** A coarse field $V$ lives on bonds of the $L$-lattice. It is tied to the fine field by a gauge-covariant averaging $V=\mathcal{Q}(U)$, enforced either by a δ-function or by a Gaussian approximation to one.
   * In the abelian case, $\mathcal Q$ is a linear average of $A$ along families of paths between blocks (Dimock's eq. (9) in [38]).
   * In the non-abelian case, Balaban's "averaging operations" [3] average logarithms of parallel transports relative to a reference transport. An AI-written 2026 paper's reference annotation cites eq. (15), p. 19 of [3] for this construction.
2. **Partial gauge fixing.** Axial (maximal-tree) gauge is imposed inside each block, $\delta(\tau U)$, which makes the fluctuation integral nondegenerate.
3. **Rescaling** back to the unit lattice.

In $d=4$ the classical Wilson action is scale invariant (marginal). Only quantum corrections change the coupling. With the continuum normalization $\frac{1}{4g^2}\int F^aF^a$ and the universal one-loop coefficient $b_0=\frac{11\,C_2(G)}{48\pi^2}>0$, one step toward the infrared gives
$$g_{k+1}^{-2}=g_k^{-2}-2b_0\log L+O(g_k^{2})\quad(\text{asymptotic freedom, read in the infrared direction}).$$
To reach a prescribed small coupling $g$ at unit scale after $N$ steps, the **bare coupling must vanish logarithmically**:
$$g_0(N)^{-2}=g^{-2}+2b_0N\log L+O(\log N).$$
This *coupling-constant renormalization* is the 4D novelty in [8]. The displayed formula is the standard perturbative expectation. Balaban's rigorous version is the two-sided logarithmic bound (0.31) of Theorem 2 in [8], whose proof was never published (§3.4). By contrast, in the superrenormalizable models (φ⁴₃, QED₃, YM₃) the dimensionless coupling grows by a factor $L^{1/2}$ per step. In Dimock's QED₃, for example, $e_k=L^{k/2}e_0$ with $e_0=L^{-N/2}e$, so the coupling is exponentially small at fine scales. Their only counterterms are a vacuum energy and a mass. Gauge invariance of the Wilson action forbids a gauge-field mass counterterm.

### 2.3 The small-field / large-field decomposition

At step $k$, the current small-field region is cut into cubes of side $M_0=L^{m}$. In each cube one requires the field to be "small" at a level $p(g_k)=(-\log g_k)^{p}$: plaquette variables close to $1$, or $|dA|\le p(g_k)$ in the abelian notation of [38]. One then inserts
$$1=\sum_{\Omega}\zeta(\Omega^{c})\,\chi(\Omega),$$
where $\chi(\Omega)$ enforces the bounds everywhere in $\Omega$ and $\zeta(\Omega^c)$ forces a violation somewhere in each cube of $\Omega^c$.

* **Large-field cubes** are suppressed by $e^{-c\,p(g_k)^2}=O(g_k^{n})$ for every $n$.
* **Small-field regions** are expanded around a background field: the minimizer of the action subject to the block constraint, which is the variational problem of [7]. The fluctuation integral is then turned into a local polymer expansion
  $$\sum_X E_k(X),\qquad \|E_k(X)\|\le g_k^{\alpha}e^{-\kappa d_M(X)}$$
  ("tree decay"), using random-walk expansions of the multiscale propagators [1, 2, 5, 13] and a cluster expansion [9].

Iterating produces nested histories $\Omega_1\supset\Omega_2\supset\cdots$. The effective density is a sum over these histories, and the leading action in the current small-field region has the same form as the bare one, with coupling $g_k$ [28–30, 37, 38].

**Gauge geometry** ([4, 7], as described by Jaffe–Witten and in Dimock's QED papers):

* Gauges are chosen locally in "phase cells". Fluctuation integrals use axial gauge, which has good positivity but poor UV behaviour. Background fields use Landau gauge, which has good decay and regularity.
* Gauge changes are made patch by patch, with small mismatches on overlaps. This avoids building up nonlocal effects. (The Balaban–Imbrie–Jaffe abelian Higgs paper [24] describes exactly this mechanism.)
* Large-field regions need **no gauge fixing at all**, because the Haar measure of a compact group is finite. This is why the Gribov problem never arises in Balaban's approach.
* Sobolev and Hölder norms of the minimizers control the "geometric" (non-abelian) effects.

### 2.4 Balaban's 4D theorem: reconstructed statement (not checked against the primary text; corrected by the verifier to its conditional form)

This is a **reconstruction**. It is assembled from the CMP 109/122 abstracts (OSTI), Dimock [31], Jaffe–Witten [56], Rivasseau [58], Summers [59] and Chatterjee [60]. The verifier also used the page-cited transcriptions of CMP 109 and CMP 122 II in [68], which are secondhand and unvetted:

> **(Balaban, UV stability of 4D pure lattice gauge theory, 1987–89; conditional form.)** Let $G$ be a compact (semisimple) Lie group, $L$ large, and the torus side fixed. There is a $\gamma>0$, existential and depending on all other constants, with the following property. **Suppose** the sequence of effective couplings $g_0,g_1,\dots,g_K$, generated from the bare coupling by the RG recursion $g_k^{-2}=g_{k+1}^{-2}+\beta_{k+1}(g_k)$, lies in $]0,\gamma]$. Then, with suitable vacuum-energy counterterms, for every $k\le K$ the effective densities $\rho_k$ have the large/small-field representation of §2.3. Their polymer activities, background-field operators and large-field factors are bounded **uniformly in the number of steps** (equivalently, in $\varepsilon$). In particular (as transcribed by [68] from [12], p. 355) $\chi_k\,e^{-g_k^{-2}A(U_k)-E_-|T_\eta|}\le\rho_k\le e^{E_+|T_\eta|}$, with $E_\pm$ independent of $k$, $T_\eta$ and $U_k$. CMP 109's "Theorem 1" [8] is the small-field version. CMP 122 II restates the same conditional hypothesis on p. 355 [12] for the full effective densities, whose form is set out in Sect. 2 of CMP 119 [10]. Balaban calls this the main result of his non-abelian series.
>
> **Not proved (stated only).** CMP 109's "Theorem 2" (for SU(2)) says the hypothesis can be met: for small $g$ there is $g_0(\varepsilon,g)$ with $g_K=g$, all $g_k\le\gamma$, and two-sided bounds $g^{-2}+\beta\log(L^k\varepsilon)^{-1}\le g_k^{-2}\le g^{-2}+\beta'\log(L^k\varepsilon)^{-1}$. Its proof, by second-order perturbative calculation, was deferred to "a separate paper". In 1989 Balaban still described it as "not published yet", and no later 4D gauge paper by him appears in zbMATH (per [68]). *Verifier correction:* an earlier version of this note folded the existence of $g_0(N)$ into the theorem. That overstated what is proved.

The individual pieces, as the abstracts describe them:

* **CMP 109 [8].** Restricted to the small-field regime: localized effective actions built via cluster expansions over single RG steps; β-functions; coupling-constant renormalization through a recursive system of RG equations.
* **CMP 122 I [11].** Constructs the ℝ operation for expressions tied to large-field regions, which "removes the main obstacle" to 4D UV stability.
* **CMP 122 II [12].** Concludes the bounds on ℝ, completing the proof of 4D UV stability "as formulated in Theorem 1". According to [68]'s transcription, Theorem 1 is stated on p. 355 of [12] itself. It is the conditional theorem above, with the same hypothesis as Theorem 1 of [8]. The form of the densities it refers to is described in Sect. 2 of CMP 119 [10], so the original draft's guess of CMP 119 was half right.
* **Caveats.**
  * Dimock [31] lists only an *upper* stability bound for YM₃,₄. The density bound transcribed above does, however, contain a small-field lower bound (with the characteristic function $\chi_k$). Whether this gives a two-sided bound on $Z_N/Z_N^{\rm free}$ comparable to Dimock's QED₃ result is not settled by any source read here.
  * Dimock [31] also flags the missing paper on the second-order perturbative coupling flow.
  * Boston [68], unvetted, transcribes Balaban's own pages (CMP 109 pp. 259–260; CMP 122 p. 355). On that transcription, the 4D bound is proved under the hypothesis that every effective coupling stays below γ. The discharging "Theorem 2" was announced in 1987 (CMP 109) and was still unpublished in 1989 by Balaban's own statement.

  Both caveats point at the same gap: **nobody has published a proof that Balaban's specific RG reproduces $b_0>0$ with controlled remainders, so that the running coupling provably stays in the small-coupling window.**

### 2.5 For comparison: Dimock's model theorems (established)

* **φ⁴₃ via Balaban [28–30].** For λ, μ̄ > 0 there are counterterms $\varepsilon^N,\mu^N$ with $e^{-c\,\mathrm{Vol}}\le Z_{M,N}/Z_{M,N}(0)\le e^{c\,\mathrm{Vol}}$ for all $M, N$. The upper bound is originally Glimm–Jaffe 1973; Balaban 1983 [17] proved both bounds.
* **QED₃ [37, 38].** For $\bar m>0$ and small $e$, one can fix the gauge and choose counterterms so that $K_-\le Z_N(e)/Z_N(0)\le K_+$ uniformly in $N$, on the unit torus. The proof file [37] shows $\tfrac12\le Z/Z_0\le\tfrac32$.
* **Renormalization as dynamics.** Dimock's key simplification: the counterterm-fixing problem is posed as a boundary-value problem for the discrete flow $\{\varepsilon_k,m_k,E_k\}$ and solved by a contraction-mapping fixed point in a Banach space of sequences. This uses "zeroth-order perturbation theory" [31, 38]. The trick relies on there being *no marginal terms* [38, §5]. It does **not** transfer directly to YM₄, whose coupling is marginal. There one needs at least an explicit one-loop computation.

### 2.6 The target (Clay; Jaffe–Witten [56])

The Clay problem asks: for any compact simple $G$, prove that a non-trivial quantum YM theory exists on $\mathbb{R}^4$ and has a mass gap $\Delta>0$. Existence includes establishing axiomatic properties at least as strong as Streater–Wightman / Osterwalder–Schrader.

Footnote 2 of [56] **excludes weak existence (compactness) as a solution**, unless other techniques are also used to establish properties of the limit, such as the mass gap and the axioms. This matters directly here. Chatterjee [60] notes that "ultraviolet stability" in phase-cell renormalization usually means existence of convergent subsequences.

---

## 3. Detailed findings

### 3.1 The Balaban corpus, with page counts (Crossref-verified)

| # | Paper | Journal | Pages | Role |
|---|---|---|---|---|
| [13] | Regularity and decay of lattice Green's functions | CMP 89 (1983) 571–597 | 27 | Random-walk expansions, decay and regularity of block-constrained Green's functions |
| [14–16] | (Higgs)₂,₃ quantum fields in a finite volume I–III | CMP 85 (1982) 603–626; 86 (1982) 555–594; 88 (1983) 411–445 | 24 + 40 + 35 = 99 | Scalar QED, d = 2, 3: the first large/small-field RG; UV stability |
| [17] | UV stability in field theory: the φ⁴₃ model | Birkhäuser 1983, 297–319 | 23 | φ⁴₃, upper and lower bounds |
| [1] | Propagators and renormalization transformations for lattice gauge theories I | CMP 95 (1984) 17–40 | 24 | Gauge-field propagators with block constraints (axial/Landau) |
| [2] | … II | CMP 96 (1984) 223–250 | 28 | Multistep propagators |
| [3] | Averaging operations for lattice gauge theories | CMP 98 (1985) 17–51 | 35 | Nonlinear gauge-covariant block averaging |
| [4] | Spaces of regular gauge field configurations on a lattice and gauge fixing conditions | CMP 99 (1985) 75–102 | 28 | Small-field configurations; local gauge fixing with bounds |
| [5] | Propagators for lattice gauge theories in a background field | CMP 99 (1985) 389–434 | 46 | Non-abelian background-field Green's functions; Hölder bounds |
| [6] | UV stability of three-dimensional lattice pure gauge field theories | CMP 102 (1985) 255–275 | 21 | **YM₃ UV stability** |
| [7] | The variational problem and background fields in RG method for lattice gauge theories | CMP 102 (1985) 277–309 | 33 | Constrained minimizers (background fields) |
| [8] | RG approach to lattice gauge field theories I: effective actions in a small-field approximation and coupling-constant renormalization in four dimensions | CMP 109 (1987) 249–301 | 53 | 4D small-field flow; β-functions |
| [9] | … II: Cluster expansions | CMP 116 (1988) 1–22 | 22 | Cluster expansion per RG step |
| [10] | Convergent renormalization expansions for lattice gauge theories | CMP 119 (1988) 243–285 | 43 | Assembling the convergent expansion |
| [11] | Large field renormalization I: the basic step of the ℝ operation | CMP 122 (1989) 175–202 | 28 | Renormalizing large-field contributions |
| [12] | Large field renormalization II: localization, exponentiation, and bounds for the ℝ operation | CMP 122 (1989) 355–392 | 38 | Completes 4D UV stability |

**Totals.**

* YM series [1]–[12]: **399 CMP pages** (12 papers; 11 of them listed by Rivasseau as the YM₄ reference set, plus [6]).
* Precursors [13]–[17]: about 150 pages.
* Expository and review pieces [18]–[20]: 11 + 57 + 14 pages.
* Balaban–Imbrie–Jaffe / Balaban–Brydges–Imbrie–Jaffe Higgs work [22]–[24]: 39 + 31 + 59 pages.
* Balaban–O'Carroll–Schor fermion operators [26, 27]: 15 + 10 pages.

The whole Balaban-centred gauge corpus is therefore **≈ 800 journal pages**.

Discrepancies noted:

* Dimock's bibliography gives CMP 85 as pp. 603–636; Crossref says 603–626.
* One OSTI record gives Large Field Renormalization II as CMP 120:575–612; Crossref says 122(3):355–392. I trust Crossref in both cases.

A 1980s CMP page is dense. Very roughly, one CMP page equals 1.3–1.7 pages of a modern 11-pt arXiv layout; this is my estimate, not measured. On that basis the YM series is about 550–700 modern pages.

### 3.2 Architecture of the method (what each module must deliver)

The method decomposes into these modules (my synthesis from [24, 28–31, 36–38, 56]):

1. **Linear analysis.**
   * Block-constrained Laplacians and their gauge-field versions.
   * Green's functions $G_k=(\Delta+\sum_j a_jQ_j^{T}Q_j\ldots)^{-1}$ with exponential decay and derivative bounds of order < 2.
   * Multiscale versions $G_{k,\Omega}$ adapted to the history of small-field regions, with "soft boundary conditions" between regions [31].
   * Random-walk expansions $G=\sum_\omega\prod K_j$ over chains of overlapping multiscale blocks [13, 1, 2, 5, 26, 27, 36].
2. **Gauge geometry.**
   * Regular configurations, whose plaquettes are all close to 1 on a block, admit local gauge transformations to small Lie-algebra-valued potentials with pointwise and Hölder bounds controlled by $\|dA\|_\infty$ [4]. Dimock's abelian Lemmas 16–17 in [36] are "abelian versions of non-abelian results proved by Balaban".
   * Axial and Landau gauges on restricted orbits each have unique representatives [36, §3.6].
3. **Nonlinear background fields.** Existence, uniqueness, analyticity and regularity of the minimizer of the Wilson action subject to $\mathcal Q(U)=V$, for small-field $V$ [7]. Goswami (2022) [62] re-derived this module for 2D nonlinear sigma models.
4. **Background-field propagators** and their random-walk expansions [5].
5. **Fluctuation integration.**
   * Expand around the background field.
   * Pass to ultralocal Gaussians via $C^{1/2}$ and random-walk localization.
   * Mayer and cluster expansions [9, 24].
   * Gaussian normalization factors (determinants) written as $\exp(\sum_X E^{\det}(X))$ [24, 38].
6. **Renormalization (extraction of relevant and marginal parts).**
   * In 3D, only the vacuum energy (plus the mass in QED/φ⁴).
   * In 4D, also the coupling constant: the β-function recursion [8].
   * Irrelevant remainders contract under the reblocking operator $\mathcal L$.
7. **Large-field control.**
   * Large-field cubes give tiny factors.
   * In 4D the ℝ operation renormalizes large-field expressions too [11, 12]. My interpretation, not verified against the text: with only logarithmic margins in 4D, counterterms inserted everywhere cannot simply be left unrenormalized inside large-field regions.
8. **Convergence of the sums** over histories and polymers, and the final integration [10, 30].

Dimock lists the generic difficulties as follows (my paraphrase of [38]):

* multiscale random-walk expansions forced by the multiscale histories;
* abundant coupling between large and small regions;
* localized characteristic functions, which become sources of non-locality under translation to critical points;
* several large/small splits per step.

### 3.3 The 3D result (YM₃)

[6] proves UV stability for pure YM₃ on a torus (Jaffe–Witten: estimates uniform in the lattice spacing, with gauges in phase cells evolving from "ultraviolet gauges" to "infrared gauges").

Jaffe–Witten call this "an important step toward" the continuum limit on compactified space-time. They add that it "need[s] to be extended to the study of expectations of gauge-invariant functions." No such extension was published by Balaban.

The 2026 Aronow–Lopatto manuscripts [67] use precisely [1–7, 13] as imported inputs. They cite exact propositions, e.g. Prop. 1.1 p. 33 of [1], Prop. 2.7/Cor. 2.8 p. 249 of [2], and Thms 3.1–3.3 pp. 397–399 of [5]. This suggests the 1984–85 papers are usable as black-box lemma libraries.

### 3.4 The 4D result (YM₄): what is solid, what is shaky

**Solid (published, refereed, cited as established by all reviewers):**

* the small-field 4D flow, with localized effective actions and β-function recursion [8];
* the cluster expansions [9];
* the convergent renormalization expansion [10];
* the large-field ℝ operation [11, 12].

Jaffe–Witten call the 4D extension "a qualitative breakthrough", including asymptotic-freedom control and large-field estimates. Summers [59] says Balaban proved UV stability "of the model on a lattice of arbitrary bond length", which "should be the core of" a proof that UV limits of Wilson-loop expectations exist. He adds that the series ended before Schwinger functions were constructed.

**Shaky or incomplete:**

* *Missing perturbative input.* Dimock [31] notes that the paper on the coupling-constant flow in second-order perturbation theory is missing.
  * Boston [68] is an unvetted, single-author 2026 analysis. It says the 4D stability is proved only under the hypothesis that all effective couplings stay below a constant. It also says the "Theorem 2" that would discharge this was announced in 1987 and never published. It backs both points with page-cited transcriptions of CMP 109 and CMP 122 II, including Balaban's 1989 remark that the proof "has not been published yet".
  * These two sources are independent and agree, and [68]'s transcription attributes the admission to Balaban himself. **Treat this as the single most important concrete gap in the 4D UV-stability result.** Confirming it against the primary pages is still the top action item in §6.
* *One-sidedness.* Dimock lists an "upper stability bound" for YM₃,₄, versus upper *and* lower bounds for scalar QED and φ⁴₃.
* *No independent re-derivation.* Dimock's program reached QED₃ only. Goswami adapted only the variational module. The 2026 AI efforts are the first attempts to rebuild 4D (§3.9).

### 3.5 Dimock's exposition and extension program (established)

| Paper | arXiv | Journal | Pages | Content |
|---|---|---|---|---|
| RG according to Balaban I | 1108.1335 | RMP 25 (2013) 1330010 | 52 | φ⁴₃ small fields (bounded-field model) |
| II | 1212.5562 | JMP 54 (2013) 092301 | 94 | Large fields |
| III | 1304.0705 | AHP 15 (2014) 2133–2175 | 37 | Convergence; two-sided stability |
| QED on the 3-torus I, II | math-ph/0210020, 0407063 | — | 70 + 37 | First step; preliminary flow |
| Scalar QED d = 3 (nonperturbative renormalization) | 1502.02946 | JMP 56 (2015) | 85 | Bounded-field flow via dynamical systems |
| UV regularity for QED₃ | 1512.04373 | JMP 59 (2018) 012301 | 89 | Bounded-field approximation; counterterms |
| Multiscale block averaging for QED₃ | 1712.10029 | JMP 61 (2020) 032302 | 53 | Multiscale propagators and minimizers; regularity theorem |
| UV stability for QED₃ | 2009.01156 | AHP 23 (2022) 2113–2205 | 78 | Full large-field control; $\tfrac12\le Z/Z_0\le\tfrac32$ |
| Stability for QED₃: overview | 2204.07201 | JMP 63 (2022) | 16 | Readable overview |

Dimock's own forward-looking remarks [37, 38]:

* It "should" be possible to add sources (e.g. $\langle dA,J\rangle$, currents), get correlation functions, and prove the continuum limit.
* The method works in any finite volume.
* The infinite-volume limit "would pose new difficulties" ("a difficult problem for this massless model").

**Size lesson.** A careful modern treatment of UV stability alone for QED₃, a super-renormalizable abelian model, took about 220 arXiv pages across three papers (89 + 53 + 78). That rises to about 305 if one counts the 85-page bounded-field scalar-QED₃ paper, which is a different model. The φ⁴₃ exposition took 183 pages. *(Verifier correction: the earlier "305 pp across four papers" mixed in scalar QED₃.)*

### 3.6 Balaban–Imbrie–Jaffe and the Higgs line

* **BBIJ 1984 [22].** Isomorphism between compact and noncompact abelian lattice gauge formulations; at weak coupling, the mass gap predicted by the Higgs mechanism is proved on a **unit lattice**. (OSTI abstract; established.)
* **BIJ 1985 [23].** Minimizers, propagators, and stability of mean-field theory.
* **BIJ 1988 [24]** (read in full).
  * A multiscale cluster expansion for the high-frequency modes, inside iterated RG, giving a gauge-invariant unit-lattice effective theory with a "deep Higgs potential".
  * The program's stated goal: the mass gap on the gauge-invariant sector, uniformly in the lattice spacing.
  * The paper says a final cluster expansion "will be performed … in another paper". Summers [59] confirms that **"the final step in that proof never appeared in print."**
  * The gauge-changing-in-patches mechanism described there is the same as in the YM papers.
* **King [48, 49]**, building on Balaban: U(1) Higgs in d = 2, 3, with continuum and infinite-volume limits (RG plus correlation inequalities). All OS axioms are verified except ergodicity and the regularity needed for tempered Wightman functions (Summers). Established.
* **Brydges–Fröhlich–Seiler [53]:** 2D abelian Higgs, all OS axioms except clustering. Jaffe–Witten call it "the only complete example of an interacting gauge theory satisfying the axioms" (as of 2000).

### 3.7 Other constructive YM₄ programs of the era

* **Federbush, "A phase cell approach to Yang–Mills theory" [42–47].**

  | Part | Topic | Reference |
  |---|---|---|
  | I | Modes, lattice–continuum duality | CMP 107 (1986) 319–329 |
  | II | Analysis of a mode (with Williamson) | JMP 28 (1987) 1416–1419 |
  | III | Local stability, modified RG transformation | CMP 110 (1987) 293–309 |
  | IV | The choice of variables | CMP 114 (1988) 317–343 |
  | V | Analysis of a chunk | CMP 127 (1990) 433–457 |
  | VI | Non-abelian lattice–continuum duality | Ann. IHP 47 (1987) 17–23 |

  The program was incomplete; Summers says it ended before Schwinger functions were constructed. Federbush later proposed a nonlinear wavelet formulation of gauge theories (hep-ph/9505368 [82]).
* **Magnen–Rivasseau–Sénéor [40, 41] (CMP 155 (1993) 325–383; PLB 283 (1992) 90–96).**
  * The published abstract says the paper provides "the basis for" a rigorous construction of the Schwinger functions of **pure SU(2) YM₄ in the trivial topological sector**, with **a fixed infrared cutoff, no UV cutoff, and a regularized axial gauge**, and that it outlines the construction in one self-contained paper. The 1992 preprint abstract (mp_arc 92-38) speaks more strongly of "a rigorous construction".
  * Large-field positivity comes from the axial gauge. For small fields they switch to a gauge better suited to perturbation theory, whose propagator depends on large background fields at lower momenta.
  * The main difficulty is controlling small-field functional integrals together with the gauge-restoring counterterms. They show the combined effect is stabilizing for certain momentum cutoffs.
  * They verify the Slavnov identities **non-perturbatively** (OSTI abstract).
  * Rivasseau later called this "a less advanced attempt". Chatterjee summarizes it as a gauge-breaking continuum regularization removed in a limit.
  * Rivasseau's open problem [58]: construct YM₄ correlation functions in finite volume in a standard gauge such as Landau gauge ("a front attack on the Gribov problem").
  * 2026: Aronow–Lopatto say their 3D work *began* as an LLM attempt to pursue the MRS program, but ended up lattice-based and Balaban-like [67].
* **Leonard Gross (U(1)₃, 1983) [50] and Driver (U(1)₄, 1987) [51]:** lattice → free electromagnetic field, in the sense of characteristic functions of $F_{\mu\nu}$. Established. **Gross–King–Sengupta (1989) [52]:** 2D U(N) YM in axial gauge via stochastic differential equations; Wilson-loop Schwinger functions with Euclidean invariance. Established. (These are the "Gross"/"King" items; they are abelian or 2D and do not feed the 4D non-abelian problem directly.)

### 3.8 Status assessments over time (all consistent)

* **Jaffe–Witten (2000) [56].** The 3D work is an important step toward the continuum limit on a compactified space-time and must be extended to gauge-invariant expectations. 4D is "a qualitative breakthrough". The vision is to extend these methods to a complete construction on a compact 4D space-time; "one presumably needs to revisit known results at a deep level, simplify the methods, and extend them". New ideas are needed for a mass gap uniform in volume, which "would enable the study of the limit as $T^4\to\mathbb R^4$".
* **Rivasseau (2000) [58].** In finite volume Balaban proved UV stability of the effective action after arbitrarily many RG steps. Open problem: simplify and rewrite, which is "no small task since references … total hundreds of pages".
* **Douglas (2004) [57].** No significant progress toward a rigorous construction; the state of the art is still Balaban and MRS.
* **Summers (2012) [59] and Chatterjee (2018) [60].** As above. Chatterjee notes there is still no continuum limit of a lattice gauge theory in d > 2 with nontrivial Wilson-loop behaviour.
* **Goswami (2022) [62].** Balaban's method "has remained largely inaccessible".
* **Douglas, *Nat. Rev. Phys.* 8 (2026) 86–97 [61].** Existence verified via Crossref; full text not read. A secondhand quote suggests he floats tensor-RG methods as a possible route.

### 3.9 The 2026 AI-era developments that build on Balaban (all claimed, unverified)

1. **OpenAI (announced 26 Oct 2026).** Claims a rigorous existence proof for 4D YM, including coupling to fermions (QCD); existence only, no mass gap.
   * The committee statement [65] (read in full) credits Balaban's 1980s RG work. It says his ideas helped OpenAI follow the theory "all the way to infinite distances" and prove that its continuum limit exists.
   * Size and formalization: **1147 pages** of LLM proofs. A Lean formalization will be released after the committee checks that its definitions match standard ones.
   * Dates, per OpenAI's press release as quoted by Woit [69] and press coverage (secondhand): natural-language YM proof 9 Sep 2026; QCD proof 18 Sep; Lean formalization finished 16 Oct. Separately, the committee statement says Gross was asked to take custody of the proof on 16 Oct. Woit reports a second committee statement (3 Nov) hoping to release the Lean proof the following week.
   * Not public: gauge group(s), axioms verified, uniqueness. Status: **claimed, unverified**.
2. **Alpöge–Sussman / Claude [66].**
   * The explicit goal is to "induce LLMs to develop, push, and extend Balaban's program".
   * Claimed manuscripts:
     * QED₃: 242 pp, with OS axioms for $F_{\mu\nu}$ on ℝ³;
     * YM₃ I: 857 pp, OS axioms for tr F² on ℝ³;
     * YM₃ II: 1201 pp;
     * YM₄: about 61k pages of raw output and about 20k "closed", unfinished.
   * The **YM₄ assembly overview** (read) has thirteen modules:
     * L: lattice Gibbs laws, reflections, chessboards;
     * M: constrained linear block estimates;
     * G: non-abelian backgrounds;
     * E: marginal action and one-loop coefficient;
     * N: exact local nonlinear step;
     * P: free Gaussian curvature term;
     * T: running coupling, "logarithmic asymptotic freedom";
     * H: history measures and large-field partition bounds;
     * R: sources and response;
     * C: continuum limits by compactness;
     * K: components and clustering;
     * V: two-point law;
     * Z: the target.
   * **Target Theorem A** is stated there as "an ergodic component of a volume-first subsequential" 4D **SU(2)** action-density limit, with translation and O(4) invariance, reflection positivity, factorial growth, **inverse-square clustering**, and a connected two-point function comparable to $d^{-8}/(\log(1/d))^2$. The overview marks Theorem A as **"remains unproved"**.
   * This is not a Clay solution: there is no mass gap, the limit is subsequential, and existence is in the weak sense.
3. **Aronow–Lopatto [67]** (Hexagon 2610.00506 and 00509–00512; pp. 316, 297, 297, 283, 286, ≈ **1,479 pp**).
   * Setting: SU(2) Wilson measure on a fixed 3D torus with $g^2=g_3^2a$.
   * Claimed result: joint laws of flowed Wilson loops converge as $a\to0$ along refinement classes $nM^k$, to a unique limit per class on a Cao–Chatterjee-type state space [71]. The method combines a Balaban-style multiscale RG on a small-field event (its complement controlled by reflection positivity and chessboard estimates) with a Wilson-flow analysis.
   * Provenance: primarily AI-generated (Claude, GPT-6 Astra, GPT-6.1 Sol); "Human understanding: no parts"; limited Lean background formalization.
   * Status: claimed, unverified; not an OS construction.
4. **Boston [68]**: an unvetted reading of the Alpöge–Sussman corpus. It is the source of the "Theorem 2 never published" claim (§3.4).

---

## 4. What is proven vs open

Legend: **E** = established theorem (published, refereed); **E\*** = published, but the 4D details carry a documented caveat; **C** = claimed, unverified (2026); **F** = folklore or expert expectation; **O** = open; **I** = incomplete program.

| Item | Status | Source / notes |
|---|---|---|
| Lattice Wilson measure is reflection positive; transfer matrix exists | E | Osterwalder–Seiler 1978 [54] |
| Large/small-field block RG for scalar QED₂,₃ in finite volume; UV stability | E | Balaban [14–16]; King [48, 49] for limits |
| Random-walk expansions; decay and regularity of block Green's functions (scalar and gauge, incl. background field) | E | [13, 1, 2, 5]; reused in 2026 manuscripts |
| Non-abelian averaging; regular configurations; local gauge fixing; variational problem | E | [3, 4, 7]; partial re-derivation [62] |
| UV stability of pure YM₃ on a torus (effective-action bounds uniform in ε) | E | [6]; Jaffe–Witten [56] |
| YM₄ small-field effective actions, β-function recursion, coupling renormalization | E | [8] (abstract) |
| YM₄ cluster expansions; convergent renormalization expansion; large-field ℝ operation | E | [9–12] |
| YM₄ UV stability **conditional** on all running couplings $g_k\le\gamma$ ("Theorem 1" of [8], [12]) | **E\*** | Published and refereed, never independently re-derived. Only an upper Z-bound listed by Dimock [31]; a small-field density lower bound is transcribed in [68] |
| Existence of bare couplings $g_0(\varepsilon)$ keeping every $g_k\le\gamma$ (CMP 109 "Theorem 2", SU(2)); hence **unconditional** YM₄ UV stability | **O** | Stated 1987, proof never published: Dimock [31] ("missing" paper), plus Balaban's 1989 remark as transcribed by [68]. *Verifier correction: this row was previously merged into the E\* row above.* |
| Independent full re-derivation of Balaban's YM₄ | O (C in 2026) | None published; AI efforts [65, 66] unverified |
| Two-sided UV stability for φ⁴₃ and for QED₃ via Balaban's method | E | Dimock [28–30, 37] |
| Gauge-invariant correlation functions with uniform bounds (finite volume), YM₃ or YM₄ | O (Balaban) / C (2026) | [66, 67] |
| Convergence of correlations as ε → 0 on T³ | C | Aronow–Lopatto [67] (flowed Wilson loops, per refinement class) |
| Convergence as ε → 0 on T⁴ | O / C | OpenAI [65] (scope unknown) |
| Extension to correlations and continuum limit on a torus "should be feasible" | F | Dimock [37, 38]; Summers [59] |
| Infinite-volume limit for YM₄ | O / C | OpenAI committee wording [65]; Alpöge–Sussman (subsequential; their overview says unproved) |
| OS axioms for YM₄ incl. O(4) restoration | O / C | [66] (RP "O(d) trick", unverified) |
| Mass gap for YM₄ (continuum) | O | No 2026 claim either; Jaffe–Witten: "new ideas are needed" |
| MRS: SU(2) YM₄ with infrared cutoff, regularized axial gauge, Slavnov identities | E\* (limited scope) | [40, 41]; published; the abstract says it gives "the basis for" a construction and an outline in one paper; Rivasseau: "less advanced attempt"; not continued |
| Federbush phase-cell program | I | [42–47] |
| Abelian Higgs mass gap in the continuum limit (BIJ) | I | Final step never published [59] |
| U(1)₃, U(1)₄ continuum limits (free field); 2D Higgs OS (BFS); 2D YM (GKS) | E | [50–53] |
| Free-field OS axioms formalized in Lean 4 (no axioms beyond Mathlib) | E (formal) | OSforGFF [70] |

---

## 5. Relevance to a 4D YM existence + mass-gap proof, and to Lean

### 5.1 Exactly what remains after Balaban

**(a) Continuum limit of gauge-invariant correlations in finite volume (T⁴).**

1. **Close the 4D UV-stability caveats.**
   * Compute the second-order (one-loop) term of the coupling flow *in Balaban's scheme*, with his nonlinear averaging and block constraints. Show it reproduces the universal $b_0>0$, and bound the remainders, so that $g_k$ stays in the window $\{g_k\le \bar g\}$ for all $k\le N$ given $g_0(N)$.
   * Recast the bare-coupling choice as a boundary-value/fixed-point problem, as Dimock did (initial $g_0(N)$, final $g_N=g$), now with a marginal direction.
   * Prove a matching lower bound.

   This is finite, well-posed and partly computational.
2. **Choose an observable class.**
   * Wilson loops in 4D need perimeter/cusp renormalization, so they are poor primary observables.
   * Better choices are **gradient-flowed (Wilson-flow) observables** at positive flow time, which the 2026 3D works use. These are UV-finite *to all orders in perturbation theory* (Lüscher 2010 [73]; Lüscher–Weisz 2011 [81]), which is not a nonperturbative theorem. Another option is smeared $\operatorname{tr}F^2$ with its multiplicative renormalization.
3. **Add sources** to the action. Extend every inductive bound to analytic dependence on the sources, which gives uniform bounds on generating functionals and hence on correlations. The QED₃ remarks [37] say this "should be possible".
4. **Prove convergence, not just compactness.** Show the unit-scale effective action is Cauchy in $N$: irrelevant directions contract and the marginal coupling is pinned by a renormalization condition. Jaffe–Witten's footnote makes this, or an equivalent identification of the limit, non-optional.
5. **Prove non-triviality**, e.g. via the asymptotic-freedom form of the two-point function of tr F² (cf. the $d^{-8}/\log^2$ law targeted in [66]).

**(b) Infinite-volume limit.**

* Balaban's estimates need the running coupling to be small at the box scale. At fixed physics, enlarging the box drives $g$ up logarithmically to $O(1)$ at the dynamical scale $\Lambda^{-1}$. The infrared problem is therefore intrinsically non-perturbative.
* A **weak** route looks plausible to me (interpretation, not established):
  1. run the RG from ε only up to a fixed scale $\ell_0$ where $g(\ell_0)$ is still small, using estimates that are local and extensive, in *infinite* volume;
  2. obtain an effective lattice gauge theory at spacing $\ell_0$ with a complicated but local action;
  3. use compactness of $G$ together with reflection-positivity chessboard bounds to take subsequential infinite-volume limits.

  This gives existence in the weak sense only: no uniqueness, and no clustering unless proved separately. Alpöge–Sussman's "volume-first subsequential … ergodic component" matches this shape.
* A **strong** route (uniqueness, clustering) seems to need a mass gap, or at least uniform decay. Jaffe–Witten say exactly this.

**(c) OS axioms.**

* **OS3 (reflection positivity):** inherited from the lattice [54] for gauge-invariant observables. Care is needed with the observable class and limits.
* **OS1 (Euclidean covariance):** translations come from density of lattice translations plus continuity. **O(4) rotations must be restored**: one must show the hypercubic-breaking (dimension ≥ 6, irrelevant) parts of the effective action vanish as ε → 0, up to logs, in the asymptotically free regime. Alpöge–Sussman propose an "RP O(d) trick" (unverified).
* **OS0/OS1′ (regularity):** factorial bounds on n-point functions, which need the source analysis of (a)(3).
* **OS4 (clustering/ergodicity):** needs infinite volume; there is no clustering on T⁴.
* An intermediate target with a natural Hilbert space is **YM on $T^3_\ell\times\mathbb R$ with small spatial size ℓ**. Lüscher's small-volume effective-Hamiltonian analysis [72] suggests a finite-volume gap there. This is heuristic for the continuum; I know of no rigorous version.

**(d) Mass gap.** This is not reachable with Balaban's toolkit, which is perturbative in the running coupling at every scale. Rigorous gap-type results exist, for example, in these settings. All are at **fixed lattice spacing**, and none holds in a continuum limit.

* At strong lattice coupling (Osterwalder–Seiler).
* For finite gauge groups at weak coupling. Adhikari–Cao [75] prove exponential decay of correlations for gauge-invariant functions, including functions of Wilson loops. This is a decay-of-correlations statement, which is not the same as a stated transfer-matrix gap.
* For Higgs models on a unit lattice (BBIJ).

*(Verifier note: "only" was softened to "for example". The list is illustrative, not exhaustive.)*

There is no bridge from the weak-coupling UV regime to the confining regime. Even the 2026 claims do not attempt one.

### 5.2 Why the program stalled (assessment)

1. **Size and density.** About 400 CMP pages for YM alone, plus about 150 of precursors, with heavily cross-referenced notation. Experts repeatedly call it inaccessible (Rivasseau 2000; Goswami 2022). The first readable exposition, of a toy model, came only in 2011–2013 (Dimock).
2. **It stopped one level short of physics.** Only the partition function was treated: no correlations or continuum limit. The documented gap in the perturbative coupling flow (§3.4) was never filled.
3. **Mismatch of incentives.** The Clay-relevant goal (ℝ⁴ plus a mass gap) needs new infrared ideas. Finishing the finite-volume continuum limit was seen as long but "routine", so it offered little reward relative to its length.
4. **Balaban's own trajectory.** He moved to low-temperature N-vector models (1995–99; 8 papers) and then to bosonic many-body models with Feldman, Knörrer and Trubowitz (small-field parabolic flow). The six arXiv postings of 4 Sep 2016 (1609.00961, 00968, 01745–01748) total about 260 pp by their arXiv comments; the series has further papers. *(Verifier correction: the earlier "about 365 pp" figure could not be reproduced.)* These projects again leaned heavily on small-field analysis.
5. **Community shift.** After about 1990, constructive QFT moved to fermionic condensed matter and statistical-mechanics RG (Brydges–Slade). In the 2010s–2020s, gauge theory was attacked by different tools: stochastic quantization and regularity structures (Chandra–Chevyrev–Hairer–Shen [76]), probabilistic lattice methods (Chatterjee, Cao, Adhikari), and gradient-flow state spaces [71].
6. **Verification bottleneck.** Proofs of 1,000-plus pages with few qualified readers are effectively unrefereeable. This is the bottleneck AI plus Lean might remove, and the 2026 events suggest it is now being attacked by brute force.

### 5.3 What massive AI effort could plausibly complete (ranked)

| WP | Task | Feasibility | Rough size (modern pp) |
|---|---|---|---|
| B0 | Acquire and transcribe [1–17] to LaTeX; build a lemma-level dependency graph ("blueprint") of the YM series | High | 550–700 pp transcribed |
| B1 | Pilot: blueprint, then formal statements of Dimock's φ⁴₃ trilogy (the cleanest Balaban-method instance) | High | 183 pp source |
| B2 | **Missing 4D coupling flow**: one-loop coefficient in Balaban's scheme, remainder bounds, fixed-point choice of $g_0(N)$; lower stability bound | High–medium (computer algebra plus estimates) | 50–150 |
| B3 | YM₃ on T³: correlations of flowed observables and continuum limit; cross-check against Aronow–Lopatto [67] | Medium | 300–600 |
| B4 | YM₄ on T⁴: sources, analyticity, uniform bounds, Cauchy-in-N convergence, nontriviality | Medium | 400–800 |
| B5 | OS on T⁴ / $T^3\times\mathbb R$: RP inheritance; hypercubic → O(4) restoration in the continuum | Medium–low | 100–300 |
| B6 | Infinite volume, weak (compactness after UV control at fixed ℓ₀) | Medium | 200–400 |
| B7 | Infinite volume with clustering; **mass gap** | Low (new ideas) | Unknown |
| B8 | Lean: finite-lattice definitions and theorem statements (Wilson measure, block averaging, Balaban's theorem in a non-trivial normalized form) | High | — |
| B9 | Lean: core libraries (finite-dimensional Gaussian integrals, random-walk expansions, polymer/cluster expansion convergence, Haar integrals on SU(N), Banach fixed point on sequence spaces) | Medium | — |

**Proof-size estimate for a Balaban-route 4D existence proof** (finite-volume continuum limit + weak infinite volume + OS, no mass gap): about **1,000–1,500 pages**. This is consistent with OpenAI's 1147 pages, Aronow–Lopatto's ~1,479 pp for the *3D torus alone* (AI prose is verbose), and Alpöge–Sussman's 242 pp (QED₃) and 2,058 pp (YM₃).

### 5.4 Lean-specific notes

* **Big structural advantage.** For each fixed $N$, every object in Balaban's program is a **finite-dimensional integral over $G^{\#\text{bonds}}$**. UV stability is a family of inequalities uniform in $N$. Statements need no infinite-dimensional measure theory until the continuum limit. Mathlib already has Haar measure, matrix unitary groups (`Matrix.specialUnitaryGroup`), Bochner integrals, the contraction-mapping theorem (`ContractingWith`), and analytic functions.
* **Trap.** As noted in §2.1, $Z_N\le1$ holds trivially for compact $G$. A faithful statement must compare to the Gaussian normalization: $|\log Z_N-\log Z_N^{\mathrm{free}}+\varepsilon_N\mathrm{Vol}|\le C\,\mathrm{Vol}$ with explicit counterterms. Better still, state the structural theorem about effective densities. This connects to recent warnings that Lean checking does not guarantee faithful formalization (Bastounis–Circelli–Hansen, arXiv 2610.08144, in the shared library).
* **Precedent.** OSforGFF [70] formalized the OS (Glimm–Jaffe) axioms for the 4D free field with no extra axioms, and Douglas sits on the OpenAI committee. Our project's T⁴ and ℝ⁴ OS-statement layer could build on it.
* **Natural first formal targets.**
  1. definitions of the toroidal lattice, the Wilson action, the gauge action and gauge-invariant observables;
  2. the block-averaging map and its gauge covariance (abelian first);
  3. random-walk expansion lemmas for finite-range operators with a gap;
  4. Kotecký–Preiss-type polymer expansion convergence;
  5. Dimock's fixed-point renormalization lemma (Theorem 2 of [38]).

### 5.5 How (b)/(c) (OpenAI's agentic approach) bear on this workstream

The visible 2026 Balaban-route projects share a work pattern:

1. decompose the proof into ten-plus interface-specified modules ("submanuscripts"), plus an assembly overview;
2. generate redundant raw output, then distil it with a second model;
3. run adversarial multi-model audits;
4. formalize only the architecture or selected claims in Lean.

For us, the lesson is to front-load:

* precise interface statements for each module (§3.2's eight modules map naturally onto agents);
* an early, frozen choice of observable class and normalization;
* a dependency graph tied to Lean statements,

so that agent swarms can work in parallel with machine-checkable hand-offs.

---

## 6. Open questions / leads

1. **Read the primary texts** (human download from Project Euclid). Check [68]'s transcriptions against the actual pages, and settle:
   1. the exact statement of "Theorem 1" in [8], pp. 259 and 267, and in [12], p. 355;
   2. whether the density lower bound (0.1) of [12] gives a two-sided normalized partition-function bound;
   3. the deferral of Theorem 2 in [8], pp. 251 and 260, and whether any later paper (published or preprint) proves it;
   4. the gauge-group hypotheses: [68] transcribes Theorem 2 as SU(2)-only, with the restriction called "superficial".
2. **Search for an unpublished Balaban manuscript** on the perturbative coupling flow (Harvard HUTMP preprints c. 1984–87; Boston University). Ask Imbrie and Jaffe, who were close to the program; Jaffe is on the OpenAI committee.
3. Does Balaban's 4D large-field ℝ operation localize so that UV bounds hold **in infinite volume up to a fixed scale ℓ₀**? This is key to the weak infinite-volume route (§5.1 b).
4. Which observable class gives the cleanest 4D continuum limit inside Balaban's framework: flowed observables, smeared $\operatorname{tr}F^2$, or renormalized Wilson loops?
5. Can the **one-loop coefficient in Balaban's scheme** be computed and verified symbolically, and checked in Lean (finite lattice sums and Fourier analysis on $\mathbb Z^4$)? This is a high-value early deliverable.
6. **O(4) restoration:** is there a rigorous argument within RG for asymptotically free theories (irrelevant-operator decay with logs)? Assess the claimed "RP O(d) trick" [66].
7. **$T^3_\ell\times\mathbb R$ at small ℓ.** Is a rigorous finite-volume mass gap, à la Lüscher [72], attainable by combining Balaban's UV control with a constant-mode effective Hamiltonian? It would be an intermediate theorem of independent interest.
8. Track the release of the OpenAI 1147-page proof and its Lean files. Compare their modules against §3.2 and against the Alpöge–Sussman YM₄ overview. In particular, check whether they also leave the infrared on compactness only.
9. Audit Aronow–Lopatto's citations of exact Balaban propositions: a cheap way to test whether the 1984–85 papers are correct as black boxes.
10. A non-abelian analogue of Dimock's QED₃ trilogy for YM₃ (≈ 300–500 pp, human-readable) would be a credible, publishable milestone, and a stepping stone that validates the agent pipeline before 4D.

---

## 7. References

"Verified" means existence and bibliographic data were confirmed in this session via the arXiv API, Crossref, OSTI, Numdam, the publisher, or a live web page. It does **not** mean the content was checked. "Content read" marks whether I read the text (full or abstract only).

**Balaban, YM series**

1. T. Bałaban, *Propagators and renormalization transformations for lattice gauge theories. I*, Commun. Math. Phys. 95 (1984) 17–40. DOI 10.1007/BF01215753. Verified (Crossref). Content: not read.
2. T. Bałaban, *… II*, Commun. Math. Phys. 96 (1984) 223–250. DOI 10.1007/BF01240221. Verified. Not read.
3. T. Bałaban, *Averaging operations for lattice gauge theories*, Commun. Math. Phys. 98 (1985) 17–51. DOI 10.1007/BF01211042. Verified. Not read.
4. T. Bałaban, *Spaces of regular gauge field configurations on a lattice and gauge fixing conditions*, Commun. Math. Phys. 99 (1985) 75–102. DOI 10.1007/BF01466594. Verified. Not read.
5. T. Bałaban, *Propagators for lattice gauge theories in a background field*, Commun. Math. Phys. 99 (1985) 389–434. DOI 10.1007/BF01240355. Verified. Not read.
6. T. Bałaban, *Ultraviolet stability of three-dimensional lattice pure gauge field theories*, Commun. Math. Phys. 102 (1985) 255–275. DOI 10.1007/BF01229380. Verified. Not read.
7. T. Bałaban, *The variational problem and background fields in renormalization group method for lattice gauge theories*, Commun. Math. Phys. 102 (1985) 277–309. DOI 10.1007/BF01229381. Verified. Not read.
8. T. Bałaban, *Renormalization group approach to lattice gauge field theories. I. Generation of effective actions in a small field approximation and a coupling constant renormalization in four dimensions*, Commun. Math. Phys. 109 (1987) 249–301. DOI 10.1007/BF01215223. Verified (Crossref; OSTI abstract read).
9. T. Bałaban, *Renormalization group approach to lattice gauge field theories. II. Cluster expansions*, Commun. Math. Phys. 116 (1988) 1–22. DOI 10.1007/BF01239022. Verified (subtitle from Project Euclid URL and nLab). Not read.
10. T. Bałaban, *Convergent renormalization expansions for lattice gauge theories*, Commun. Math. Phys. 119 (1988) 243–285. DOI 10.1007/BF01217741. Verified. Not read.
11. T. Bałaban, *Large field renormalization. I. The basic step of the ℝ operation*, Commun. Math. Phys. 122 (1989) 175–202. DOI 10.1007/BF01257412. Verified (OSTI abstract read).
12. T. Bałaban, *Large field renormalization. II. Localization, exponentiation, and bounds for the ℝ operation*, Commun. Math. Phys. 122 (1989) 355–392. DOI 10.1007/BF01238433. Verified (Crossref; OSTI abstract read; note OSTI's conflicting volume/pages).

**Balaban, precursors, reviews and later work**

13. T. Bałaban, *Regularity and decay of lattice Green's functions*, Commun. Math. Phys. 89 (1983) 571–597. DOI 10.1007/BF01214744. Verified.
14. T. Bałaban, *(Higgs)₂,₃ quantum fields in a finite volume. I. A lower bound*, Commun. Math. Phys. 85 (1982) 603–626. DOI 10.1007/BF01403506. Verified (subtitle added from Crossref).
15. T. Bałaban, *… II. An upper bound*, Commun. Math. Phys. 86 (1982) 555–594. DOI 10.1007/BF01214890. Verified.
16. T. Bałaban, *… III. Renormalization*, Commun. Math. Phys. 88 (1983) 411–445. DOI 10.1007/BF01213217. Verified.
17. T. Bałaban, *Ultraviolet stability in field theory. The φ⁴₃ model*, in *Scaling and Self-Similarity in Physics* (J. Fröhlich, ed.), Birkhäuser 1983, 297–319. DOI 10.1007/978-1-4899-6762-6_9. Verified.
18. T. Bałaban, *Recent results in constructing gauge fields*, Physica A 124 (1984) 79–89. DOI 10.1016/0378-4371(84)90228-0. Verified.
19. T. Bałaban, A. Jaffe, *Constructive gauge theory*, in *Fundamental Problems of Gauge Field Theory* (Erice 1985), NATO ASI B141, Plenum 1986, 207–263. DOI 10.1007/978-1-4757-0363-4_5. Verified.
20. T. Bałaban, *Constructive gauge theory II*, in *Constructive Quantum Field Theory II* (Erice 1988), NATO ASI B234, Plenum 1990, 55–68. DOI 10.1007/978-1-4684-5838-1_3. Verified.
21. T. Bałaban, *Renormalization group methods in non-abelian gauge theories*, Harvard preprint HUTMP B134 (1984). **[UNVERIFIED]** as a document. The citation itself is confirmed in Chatterjee [60]'s bibliography (ref. [2] there).
22. T. Bałaban, D. Brydges, J. Imbrie, A. Jaffe, *The mass gap for Higgs models on a unit lattice*, Ann. Phys. 158 (1984) 281–319. DOI 10.1016/0003-4916(84)90121-0. Verified (OSTI abstract read).
23. T. Bałaban, J. Imbrie, A. Jaffe, *Renormalization of the Higgs model: minimizers, propagators and the stability of mean field theory*, Commun. Math. Phys. 97 (1985) 299–329. DOI 10.1007/BF01206191. Verified.
24. T. Bałaban, J. Imbrie, A. Jaffe, *Effective action and cluster properties of the abelian Higgs model*, Commun. Math. Phys. 114 (1988) 257–315. DOI 10.1007/BF01225038. Verified (full text read, author-hosted).
25. J. Imbrie, *Renormalization group methods in gauge field theories*, in K. Osterwalder, R. Stora (eds.), *Critical Phenomena, Random Systems, Gauge Theories* (Les Houches 1984, session XLIII), North-Holland 1986; Harvard preprint HUTMP 85/B176. Partly verified: the volume is confirmed in library catalogues and the lecture in secondary citations. No DOI or full text was checked.
26. T. Bałaban, M. O'Carroll, R. Schor, *Block renormalization group for Euclidean fermions*, Commun. Math. Phys. 122 (1989) 233–247. DOI 10.1007/BF01257414. Verified.
27. T. Bałaban, M. O'Carroll, R. Schor, *Properties of block renormalization group operators for Euclidean fermions in an external gauge field*, J. Math. Phys. 32 (1991) 3199–3208. DOI 10.1063/1.529479. Verified.

**Dimock and Goswami**

28. J. Dimock, *The renormalization group according to Balaban — I. Small fields*, arXiv:1108.1335; Rev. Math. Phys. 25 (2013) 1330010. DOI 10.1142/S0129055X13300100. Verified; read; PDF downloaded.
29. J. Dimock, *… II. Large fields*, arXiv:1212.5562; J. Math. Phys. 54 (2013) 092301. DOI 10.1063/1.4821275. Verified; read (intro); PDF downloaded.
30. J. Dimock, *… III. Convergence*, arXiv:1304.0705; Ann. Henri Poincaré 15 (2014) 2133–2175. DOI 10.1007/s00023-013-0303-3. Verified; PDF downloaded.
31. J. Dimock, *The renormalization group according to Balaban* (slides), ETH Zürich workshop, 27 May 2013. https://ethz.ch/content/dam/ethz/special-interest/phys/theoretical-physics/pauli-center-dam/documents/workshop-analytical-aspects-of-mathematical-physics/Dimock.pdf. Verified; read in full.
32. J. Dimock, *Quantum electrodynamics on the 3-torus I — First step*, arXiv:math-ph/0210020. Verified; PDF downloaded.
33. J. Dimock, *Quantum electrodynamics on the 3-torus II — The RG flow*, arXiv:math-ph/0407063. Verified (metadata).
34. J. Dimock, *Nonperturbative renormalization of scalar QED in d=3*, arXiv:1502.02946; J. Math. Phys. 56 (2015). DOI 10.1063/1.4933224. Verified; PDF downloaded.
35. J. Dimock, *Ultraviolet regularity for QED in d=3*, arXiv:1512.04373; J. Math. Phys. 59 (2018) 012301. DOI 10.1063/1.5009458. Verified; PDF downloaded.
36. J. Dimock, *Multiscale block averaging for QED in d=3*, arXiv:1712.10029; J. Math. Phys. 61 (2020) 032302. DOI 10.1063/1.5134439. Verified; read (sections 1, 3); PDF downloaded.
37. J. Dimock, *Ultraviolet stability for QED in d=3*, arXiv:2009.01156; Ann. Henri Poincaré 23 (2022) 2113–2205. DOI 10.1007/s00023-021-01127-z. Verified; read (intro, final remarks); PDF downloaded.
38. J. Dimock, *Stability for QED in d=3: an overview*, arXiv:2204.07201; J. Math. Phys. 63 (2022). DOI 10.1063/5.0081057. Verified; read in full; PDF downloaded.
39. J. Dimock, *Covariant axial gauge*, arXiv:1410.2798; Lett. Math. Phys. 105 (2015) 959–987. DOI 10.1007/s11005-015-0763-0. Verified (metadata; volume and pages added from Crossref).

**Other constructive gauge theory**

40. J. Magnen, V. Rivasseau, R. Sénéor, *Construction of YM₄ with an infrared cutoff*, Commun. Math. Phys. 155 (1993) 325–383. DOI 10.1007/BF02097397; preprint mp_arc 92-38. Verified (Crossref; abstract read).
41. J. Magnen, V. Rivasseau, R. Sénéor, *Rigorous results on the ultraviolet limit of non-abelian gauge theories*, Phys. Lett. B 283 (1992) 90–96. DOI 10.1016/0370-2693(92)91433-A. Verified (OSTI).
42. P. Federbush, *A phase cell approach to Yang–Mills theory. I. Modes, lattice-continuum duality*, Commun. Math. Phys. 107 (1986) 319–329. DOI 10.1007/BF01209397. Verified.
43. P. Federbush, C. Williamson, *… II. Analysis of a mode*, J. Math. Phys. 28 (1987) 1416–1419. DOI 10.1063/1.527495. Verified.
44. P. Federbush, *… III. Local stability, modified renormalization group transformation*, Commun. Math. Phys. 110 (1987) 293–309. DOI 10.1007/BF01207369. Verified.
45. P. Federbush, *… IV. The choice of variables*, Commun. Math. Phys. 114 (1988) 317–343. DOI 10.1007/BF01225039. Verified.
46. P. Federbush, *… V. Analysis of a chunk*, Commun. Math. Phys. 127 (1990) 433–457. DOI 10.1007/BF02104497. Verified.
47. P. Federbush, *… VI. Non-abelian lattice-continuum duality*, Ann. Inst. H. Poincaré Phys. Théor. 47 (1987) 17–23. Numdam AIHPA_1987__47_1_17_0. Verified.
48. C. King, *The U(1) Higgs model. I. The continuum limit*, Commun. Math. Phys. 102 (1986) 649–677. DOI 10.1007/BF01221651. Verified.
49. C. King, *The U(1) Higgs model. II. The infinite volume limit*, Commun. Math. Phys. 103 (1986) 323–349. DOI 10.1007/BF01206942. Verified.
50. L. Gross, *Convergence of U(1)₃ lattice gauge theory to its continuum limit*, Commun. Math. Phys. 92 (1983) 137–162. DOI 10.1007/BF01210842. Verified.
51. B. K. Driver, *Convergence of the U(1)₄ lattice gauge theory to its continuum limit*, Commun. Math. Phys. 110 (1987) 479–501. DOI 10.1007/BF01212424. Verified.
52. L. Gross, C. King, A. Sengupta, *Two dimensional Yang–Mills theory via stochastic differential equations*, Ann. Phys. 194 (1989) 65–112. DOI 10.1016/0003-4916(89)90032-8. Verified.
53. D. Brydges, J. Fröhlich, E. Seiler, *On the construction of quantized gauge fields. I. General results*, Ann. Phys. 121 (1979) 227–284. DOI 10.1016/0003-4916(79)90098-8. (II: CMP 71 (1980) 159–205, DOI 10.1007/BF01197918. III: *The two-dimensional abelian Higgs model without cutoffs*, CMP 79 (1981) 353–399, DOI 10.1007/BF01208500.) Verified (I, II, III via Crossref).
54. K. Osterwalder, E. Seiler, *Gauge field theories on a lattice*, Ann. Phys. 110 (1978) 440–471. DOI 10.1016/0003-4916(78)90039-8. Verified.
55. E. Seiler, *Gauge Theories as a Problem of Constructive Quantum Field Theory and Statistical Mechanics*, Lecture Notes in Physics 159, Springer 1982. DOI 10.1007/3-540-11559-5. Verified.

**Status reviews**

56. A. Jaffe, E. Witten, *Quantum Yang–Mills theory* (Clay Millennium problem description), 2000. https://www.claymath.org/wp-content/uploads/2022/06/yangmills.pdf. Verified; read (§§4–6).
57. M. R. Douglas, *Report on the Status of the Yang–Mills Millenium Prize Problem* (April 2004; the title's spelling of "Millenium" is as printed). https://ncatlab.org/nlab/files/Douglas-StatusOfYMMillenniumProb.pdf. Verified; read.
58. V. Rivasseau, *Constructive field theory and applications: perspectives and open problems*, arXiv:math-ph/0006017; J. Math. Phys. 41 (2000) 3764–3775. DOI 10.1063/1.533326. Verified; read; PDF downloaded.
59. S. J. Summers, *A perspective on constructive quantum field theory*, arXiv:1203.3991. Verified; read (§3.7); PDF downloaded.
60. S. Chatterjee, *Yang–Mills for probabilists*, arXiv:1803.01950. Verified; read; PDF downloaded.
61. M. R. Douglas, *The Yang–Mills Millennium problem*, Nat. Rev. Phys. 8(2) (2026) 86–97 (online 12 Jan 2026). DOI 10.1038/s42254-025-00909-2. Verified (Crossref). Content: not read.
62. A. Goswami, *The variational problem and background field in the renormalization group method for non-linear sigma models*, arXiv:2204.08252; Ann. Henri Poincaré 25 (2024) 2065–2085. DOI 10.1007/s00023-023-01353-7. Verified; abstract and intro read; PDF downloaded.
63. T. Bałaban, *A low temperature expansion for classical N-vector models. I. A renormalization group flow*, Commun. Math. Phys. 167 (1995) 103–154. DOI 10.1007/BF02099355 (series continues in CMP 175, 182, 196, 198). Verified.
64. T. Bałaban, J. Feldman, H. Knörrer, E. Trubowitz, *Complex bosonic many-body models: overview of the small field parabolic flow*, arXiv:1609.00968; Ann. Henri Poincaré 18 (2017) 2873–2903. DOI 10.1007/s00023-017-0587-9. Companion postings: arXiv 1609.00961 and 1609.01745–01748. Verified (arXiv API + Crossref).

**2026 developments (claims unverified)**

65. M. R. Douglas, D. J. Gross (chair), A. Jaffe, I. R. Klebanov, N. Nekrasov, *Proof by OpenAI of the existence of quantum Yang–Mills theory: statement by the shepherding committee*, October 2026 (PDF created 27 Oct 2026). https://www.kitp.ucsb.edu/sites/default/files/YM_working_group.pdf. Verified; re-read in full by the verifier.
66. E. Sussman, L. Alpöge (with Claude; Codex used for condensation), *Yang–Mills LLM experiment* (GitHub repository; README and YM4_assembly_overview read, accessed 2026-11-05). https://github.com/ethanwsussman/Yang--Mills-LLM-experiment. Verified (exists; page counts and the "Target Theorem A remains unproved" wording re-checked by the verifier). Content unvetted. *(The middle initial "W." in the earlier draft appears only in the GitHub handle and has been dropped as unconfirmed.)*
67. P. M. Aronow, P. Lopatto, *The continuum limit of three-dimensional SU(2) lattice Yang–Mills theory on a torus I–V* (I: Foundations and classical fields, 316 pp; II: Fluctuation integration and local reconstruction, 297 pp; III: Regional renormalization and large-field control, 297 pp; IV: Wilson flow and continuum measure, 283 pp; V: Short-distance and weak-coupling asymptotics, 286 pp). Hexagon (hexagonmath.org) 2610.00506, 2610.00509, 2610.00510, 2610.00511, 2610.00512, v1 dated 23–26 Oct 2026. Earlier version at https://github.com/pmaronow/3d-ym-torus. Verified (all five landing pages; total 1,479 pp; the provenance statement names Claude, GPT 6 Astra and GPT 6.1 Sol; "Human understanding: no parts"). Unvetted.
68. E. Boston III, *The Ground: Yang–Mills Theory after the Alpöge–Sussman Manuscripts* (III-Yang_Mills GitHub repository; dated 28 Oct 2026, revised through rev. 35 on 5 Nov 2026), with ledger file `OPEN/ledger/d4-balaban-the-pages.md` transcribing CMP 109 and CMP 122 II. https://github.com/edwinboston1-svg/III-Yang_Mills. Verified (exists; README and ledger read). Single-author, unvetted. Use as a pointer, and check its transcriptions against the primary texts.
69. P. Woit, *Secret Unified Physics Slop* (Not Even Wrong blog, 26 Oct 2026, with updates). https://www.math.columbia.edu/~woit/wordpress/?p=15948. Verified. Commentary only, but it is the secondhand source for OpenAI's press-release dates (9 Sep, 18 Sep, 16 Oct) and for the committee's 3 Nov update.

**Lean, observables and other context**

70. M. R. Douglas, S. Hoback, A. Mei, R. Nissim, *Formalization of QFT*, arXiv:2603.15770 (OSforGFF). Verified (metadata/abstract); PDF in library.
71. S. Cao, S. Chatterjee, *A state space for 3D Euclidean Yang–Mills theories*, arXiv:2111.12813. Verified (metadata); PDF in library.
72. M. Lüscher, *Some analytic results concerning the mass spectrum of Yang–Mills gauge theories on a torus*, Nucl. Phys. B 219 (1983) 233–261. DOI 10.1016/0550-3213(83)90436-4. Verified (Crossref). Not read.
73. M. Lüscher, *Properties and uses of the Wilson flow in lattice QCD*, JHEP 08 (2010) 071. DOI 10.1007/JHEP08(2010)071. Verified (Crossref). Not read.
74. A. N. Efremov, R. Guida, C. Kopper, *Renormalization of SU(2) Yang–Mills theory with flow equations*, arXiv:1704.06799; J. Math. Phys. 58 (2017). DOI 10.1063/1.5000041. Verified (metadata). Perturbative input relevant to WP B2.
75. A. Adhikari, S. Cao, *Correlation decay for finite lattice gauge theories at weak coupling*, arXiv:2202.10375; Ann. Probab. 53(1) (2025) 140–174. DOI 10.1214/24-AOP1702. Verified (arXiv API + Crossref; abstract read).
76. A. Chandra, I. Chevyrev, M. Hairer, H. Shen, *Stochastic quantisation of Yang–Mills–Higgs in 3D*, arXiv:2201.03487; Invent. Math. 237 (2024) 541–696. DOI 10.1007/s00222-024-01264-2. Verified (metadata).
77. K. Osterwalder, R. Schrader, *Axioms for Euclidean Green's functions*, Commun. Math. Phys. 31 (1973) 83–112 (DOI 10.1007/BF01645738); *II*, 42 (1975) 281–305 (DOI 10.1007/BF01608978). Verified.
78. J. Feldman, K. Osterwalder, *The Wightman axioms and the mass gap for weakly coupled (φ⁴)₃ quantum field theories*, Ann. Phys. 97 (1976) 80–135. DOI 10.1016/0003-4916(76)90223-2. Verified.
79. D. Brydges, J. Dimock, T. R. Hurd, *The short distance behavior of (φ⁴)₃*, Commun. Math. Phys. 172 (1995) 143–186. DOI 10.1007/BF02104514. Verified.
80. A. Bastounis, F. Circelli, A. C. Hansen, *Navier–Stokes lost in translation: why Lean verification of AI autoformalisation does not guarantee correct natural language proofs*, arXiv:2610.08144. Verified (arXiv metadata). Relevant to statement faithfulness.
81. M. Lüscher, P. Weisz, *Perturbative analysis of the gradient flow in non-abelian gauge theories*, arXiv:1101.0963; JHEP 02 (2011) 051. DOI 10.1007/JHEP02(2011)051. Verified (arXiv API); PDF already in library (another workstream). *Added by the verifier.*
82. P. Federbush, *A new formulation and regularization of gauge theories using a non-linear wavelet expansion*, arXiv:hep-ph/9505368; Prog. Theor. Phys. 94 (1995) 1135–1146. DOI 10.1143/PTP.94.1135. Verified (arXiv API + Crossref). *Cited inline in §3.7 but missing from the original list; added by the verifier.*

*PDFs downloaded by this workstream* (in `library/pdfs/`): 1108.1335, 1212.5562, 1304.0705, 2009.01156, 1712.10029, 1512.04373, 1502.02946, 2204.07201, 1803.01950, 2204.08252, math-ph_0210020, 1203.3991, math-ph_0006017. Also present, downloaded by other workstreams: 2603.15770, 2111.12813, 2202.10375, 2201.03487, 2610.08144.

---

## Verification log

*Adversarial verification pass, 2026-11-05. The verifier assumed that references might be hallucinated and that results might be overstated. All edits above marked "verifier" were made in this pass.*

### A. Reference existence and metadata (82 entries after additions)

* **arXiv IDs (23 checked via the export.arxiv.org API):** 1108.1335, 1212.5562, 1304.0705, math-ph/0210020, math-ph/0407063, 1502.02946, 1512.04373, 1712.10029, 2009.01156, 2204.07201, 1410.2798, math-ph/0006017, 1203.3991, 1803.01950, 2204.08252, 1609.00968 (+ companions 1609.00961, 01745–01748), 2603.15770, 2111.12813, 1704.06799, 2202.10375, 2201.03487, 2610.08144, hep-ph/9505368, and 1101.0963 (added). For every one, title and authors match the note. **No fabricated arXiv IDs.**
* **DOIs (64 checked via api.crossref.org):** all Balaban CMP papers [1]–[16], [17]–[20], [22]–[24], [26], [27]; all Dimock journal DOIs; MRS [40, 41]; Federbush [42]–[46]; King [48, 49]; Gross [50]; Driver [51]; GKS [52]; BFS I, II, III [53]; Osterwalder–Seiler [54]; Seiler LNP [55]; Rivasseau [58]; Douglas 2026 [61]; Goswami [62]; Bałaban 1995 [63]; BFKT [64]; Lüscher [72, 73]; Efremov–Guida–Kopper [74]; CCHS [76]; OS I/II [77]; Feldman–Osterwalder [78]; BDH [79]; Federbush PTP [82]. All resolve, and titles, volumes, pages and years match. **The page count of 399 for [1]–[12] was recomputed from Crossref page ranges and is exact.** The precursors total 149 pp; the "≈ 800 pp" corpus total recomputes to 784.
* **URLs (WebFetch or direct download):**
  * KITP committee statement [65]: read in full.
  * Dimock ETH slides [31]: text extracted and read.
  * Clay/Jaffe–Witten [56]: text extracted.
  * Douglas 2004 [57]: text extracted.
  * Sussman–Alpöge repo [66]: README and YM4_assembly_overview.pdf read.
  * Aronow–Lopatto Hexagon parts I–V [67]: all five landing pages read.
  * Boston repo [68]: README and the Balaban ledger file read.
  * Woit [69]: read.
  * Numdam [47]: checked.
  * All exist and match.
* **Unconfirmed:** [21] (HUTMP B134 preprint, known only as a citation in Chatterjee) is flagged [UNVERIFIED]. [25] (Imbrie, Les Houches 1984) is partly verified through catalogue records.
* **Metadata corrections applied:**
  * subtitles added to [14]–[16], [53], [63];
  * volume and pages added to [39] and [64];
  * Adhikari–Cao [75] now carries its published DOI 10.1214/24-AOP1702 (Ann. Probab. 53(1) 2025, 140–174);
  * BFS II DOI added;
  * Sussman's unconfirmed middle initial dropped;
  * Aronow–Lopatto part titles and page counts filled in (316 + 297 + 297 + 283 + 286 = 1,479);
  * [82] (Federbush wavelets, cited inline but unlisted) and [81] (Lüscher–Weisz) added.
* **PDFs:** all 18 PDFs the note lists were opened. Each first page matches its arXiv ID, and page counts match the §3.5 table. No PDF was deleted and none was downloaded.

### B. Ten key claims checked against sources

1. **"12 CMP papers, 399 pp, 1983–1989."** The papers and page count are confirmed. The years are wrong: the YM series runs 1984–89 (Dimock's slides also give 1984–89, though they count 11 papers, matching Rivasseau's [Ba1] list, which omits the YM₃ paper [6]). **Corrected** in §1.
2. **The reconstructed 4D theorem (§2.4).** **Overstated; corrected.** The draft asserted that bare couplings $g_0(N)$ exist which keep the flow small. Per [68]'s page-cited transcription of CMP 109 (pp. 259, 260, 267) and CMP 122 II (p. 355), the published Theorem 1 is *conditional* on all $g_k\in\,]0,\gamma]$. The existence statement is CMP 109's Theorem 2 (SU(2)). Its proof was deferred, and Balaban wrote in 1989 that it "has not been published yet". Dimock's slides independently say the coupling-flow paper is "missing". §1, §2.4, §3.4 and the §4 table were rewritten. The table now separates the conditional theorem (E\*) from the unconditional statement (**O**).
3. **"Dimock lists only an upper bound."** Confirmed from the slides. **Nuance added:** per [68]'s transcription, [12] p. 355 states two-sided density bounds, with a small-field lower bound carrying $\chi_k$. The "one-sided" characterization is therefore Dimock's summary of the partition-function bound, not necessarily the full content.
4. **Gauge group.** Dimock's slides say "semi-simple compact"; Summers says SU(2) where details matter. **Added:** Theorem 2 is SU(2)-only, per the transcription.
5. **OpenAI committee claims [65].** Confirmed: the five members with Gross as chair; "including coupling to fermions"; the Balaban sentence; "1147-page LLM proofs"; confinement and mass gap "remain very important open challenges"; Lean proof to be released after validation. **Corrected:** "Lean formalization dated 16 Oct" conflated two dates. The committee statement gives 16 Oct as the day Gross was asked to take custody. OpenAI's press release, quoted secondhand by Woit and press coverage, says the Lean formalization was *finished* on 16 Oct. Both dates are now stated, plus 9 Sep (NL proof), 18 Sep (QCD) and the 26 Oct announcement (corroborated by [68] and Woit).
6. **Alpöge–Sussman [66].** Confirmed: QED₃ 242 pp; YM₃ 857 + 1201 pp; YM₄ unfinished (~61k raw, ~20k closed); the stated aim to "develop, push, and extend Balaban's program"; the thirteen module letters; Target Theorem A's wording; and "Target Theorem A remains unproved". **Added:** Alpöge's README remark that they "(appear to) have" an ℝ⁴ existence argument in raw form.
7. **Aronow–Lopatto [67].** Confirmed: five parts, 1,479 pp; flowed Wilson loops; refinement classes $nM^k$; unique limit on a Cao–Chatterjee-type space; Balaban tradition; models Claude, GPT 6 Astra and GPT 6.1 Sol; "Human understanding: no parts"; limited Lean background formalization. The GitHub README confirms the MRS origin.
8. **Adhikari–Cao "mass gap for finite groups at weak coupling".** **Softened:** the paper proves exponential decay of correlations on the lattice at fixed spacing, which is not a stated continuum gap. "Rigorous gap results exist *only* …" was changed to "for example …", with a fixed-lattice-spacing caveat.
9. **Higgs line.** Confirmed in Summers [59]: BIJ's final step "never appeared in print"; King's results in d = 2, 3, all OS axioms except ergodicity and regularity; BFS all OS axioms except clustering. Also confirmed: BBIJ's unit-lattice gap, and Jaffe–Witten calling BFS "the only complete example".
10. **MRS "groundwork".** **Corrected wording:** the published abstract says "the basis for" a rigorous construction, outlined in one paper; the 1992 preprint abstract says "a rigorous construction". The table status changed from E to E\* (limited scope).

Also checked and confirmed:

* Jaffe–Witten quotes: "important step toward"; the need to extend to gauge-invariant expectations; "qualitative breakthrough"; "revisit known results at a deep level"; "New ideas are needed"; footnote 2 excluding weak existence.
* Rivasseau: "less advanced attempt"; "front attack on the Gribov problem"; "Simplify and rewrite Balaban's results"; "hundreds of pages".
* Douglas 2004: no significant progress; state of the art is Balaban and MRS.
* Chatterjee: UV stability as convergent subsequences; no nontrivial continuum lattice gauge theory above d = 2; HUTMP B134 citation.
* Summers: "bond length" and "core of" quotes.
* Goswami: "largely inaccessible"; d = 2 sigma models.
* Dimock [37]: $\tfrac12\le Z/Z_0\le\tfrac32$; infinite volume a "difficult problem"; sources "should be possible".
* Dimock [38]: "no marginal terms"; Theorem 2 as a fixed point in a sequence space; correlations and continuum limit "should also be feasible"; infinite volume "would pose new difficulties".
* Dimock [36]: Lemmas 16–17 are abelian versions of Balaban's non-abelian results.
* OSforGFF [70]: GJ/OS axioms for the 4D free field now proved using only Lean and Mathlib.

### C. Other corrections

* **Dimock scope.** Scalar QED₃ (1502.02946) is a bounded-field approximation only, not two-sided UV stability. The QED₃ page total "305 pp across four papers" mixed in that 85-pp scalar-QED paper; the three QED₃ papers total 220 pp.
* **Superrenormalizable flow.** The coupling grows by a factor $L^{1/2}$ per step, not "$L^{k/2}$ per step".
* **Gradient-flow observables.** These are UV-finite to all orders in perturbation theory (Lüscher–Weisz), which is not a nonperturbative theorem. Qualifier added.
* **Boston [68].** "AI-assisted" could not be confirmed from the text. The remark was removed.
* **BFKT page total.** "About 365 pp" could not be reproduced. The six 2016 postings total about 262 pp by their arXiv comments.

### D. Residual concerns

* **No Balaban primary text was read by the verifier either.** The upgraded §2.4 statement relies on [68]'s transcriptions. They are page-cited and internally consistent, and they agree with Dimock's slides, but [68] is unvetted. A human should check CMP 109 pp. 251, 259–260 and 267, and CMP 122 p. 355.
* **OpenAI dates.** The 9 Sep, 18 Sep and 16 Oct dates come from the press release as quoted by Woit and secondary press, not from the OpenAI release itself. The 3 Nov committee update is likewise secondhand.
* **Aronow–Lopatto citations.** Their exact citations of Balaban propositions (§3.3, §2.2: e.g. "eq. (15), p. 19 of [3]") were not independently checked. The page numbers do fall inside the right page ranges.
* **The OSTI conflicting-volume remark for [12]** was not re-checked.
* **Figures not re-derived.** The "1 CMP page ≈ 1.3–1.7 modern pages" multiplier and the 1,000–1,500-page proof-size estimate remain the author's judgment, not measurements.
* **Douglas, Nat. Rev. Phys. 2026 [61].** The content remains unread; the tensor-RG remark is secondhand.
