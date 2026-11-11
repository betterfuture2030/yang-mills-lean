# 02 — OpenAI's Yang–Mills claim and the shepherding committee

*Workstream key:* `02-openai-ym-claim` · *Compiled:* 2026-11-05 · *Status of subject:* claim unreleased; Lean release promised "hopefully next week" (week of 2026-11-09)

**How to read this note.** Each factual statement carries a source tag.

- **[P]** Primary source that I read in full. These are the committee's two statements, its Rules and Procedures, the KITP news page, the AGMAI statements, OpenAI's GitHub repositories and history logs, the Sussman–Alpöge repository, Craig's arXiv paper and the Jaffe–Witten problem description.
- **[P\*]** OpenAI's own blog post. I could **not** fetch it: openai.com returned HTTP 403 to the fetch tool, and I did not try to get around the bot check. Its content below is rebuilt from short quotes and paraphrases that agree across at least three independent secondary sources (Woit, The Decoder, TNW, unite.ai, xenospectrum, cellcog, datastudios). Treat exact wording as *probable*, not certain. *[Verifier, 2026-11-05: only Woit reproduces OpenAI's text verbatim, for the headline phrase and the three dates. The Decoder, unite.ai, xenospectrum and datastudios mostly paraphrase. Several phrases this note once presented as OpenAI quotes are really those outlets' own wording; they are flagged below. cellcog and explainx are not in the reference list and were not re-checked.]*
- **[S]** Credible press: Scientific American, Science (search snippets only), The Decoder, TNW.
- **[C]** Commentary: blogs, blog comments, X posts and aggregators.
- **[I]** My own inference. It is not stated by any source.

---

## Summary

On **Monday 26 Oct 2026**, OpenAI announced three results from unnamed internal models in a blog post titled *"Working with academic communities to build scientific understanding"* [P\*]:

1. a claimed refutation of the **Exponential Time Hypothesis (ETH)**;
2. a claimed proof of **Sogge's local smoothing conjecture** in every spatial dimension $n\ge2$. Per `openai/math` (history.md, CONTENTS.md entry 079), it also yields Bochner–Riesz, the Kakeya (and Nikodym) maximal conjectures, full Hausdorff dimension of Kakeya sets, and Stein's spherical restriction estimates throughout the interior of the conjectured range;
3. in physics, a claimed **"mathematically rigorous existence proof of certain interacting quantum field theories"** (Woit quotes this verbatim) in four dimensions with gauge fields and fermions. This covers QCD and a "unified completion of the Standard Model" (also verbatim per Woit). Secondary outlets (Decoder, unite.ai, xenospectrum) paraphrase the target as the *simplest grand unified theory containing the SM gauge fields and fermions*; I could not confirm that wording as OpenAI's own. A proof of existence of **pure Yang–Mills** is included as a "subproblem". That word appears on the KITP page and in unite.ai/xenospectrum, but OpenAI's own use of it is unconfirmed.

OpenAI dates the physics work as follows [P\*, consistent across sources]:

- natural-language YM proof on **9 Sep 2026**;
- QCD proof on **18 Sep 2026**;
- Lean formalization of YM existence finished on **16 Oct 2026**.

**The mass gap is not claimed.** OpenAI calls pure-YM existence "part of" the Clay problem (unite.ai, xenospectrum). Sources disagree on whether OpenAI's post mentions the gap at all. Woit and unite.ai say it does not. The Decoder says OpenAI states it solved only the existence part. *[Verifier correction: an earlier draft said OpenAI "says it will not seek the prize" for YM. I found no source for that. OpenAI's reported no-prize statement (TNW) concerned **Navier–Stokes** in September. Without a gap, the YM claim cannot meet the Clay criteria anyway.]* The committee states explicitly that "confinement and the mass gap remain very important open challenges" [P].

On 16 Oct OpenAI asked **David Gross** to take custody of the proof and decide how to release it. Gross then picked a five-person **shepherding committee**: Michael R. Douglas, David J. Gross (Chair), Arthur Jaffe, Igor R. Klebanov and Nikita Nekrasov [P]. The committee has issued three documents.

**First statement** (dated "October 2026"; PDF created 2026-10-27 [P]):
- It welcomes a proof of existence of quantum YM "including coupling to fermions".
- It credits **Balaban's 1980s rigorous renormalization-group work** and Wilson's lattice as key ingredients.
- It says OpenAI followed the theory "all the way to infinite distances" and proved existence of its "proper continuum limit".
- It sets out a release plan: first validate the Lean definitions and problem statement, then release the Lean proof; later, release an assessment together with the **"full 1147-page LLM proofs"**.

**Second statement** (3 Nov 2026) [P]:
- Validation of the Lean proof of existence of **pure** YM is "proceeding well".
- The Lean proof will be released "hopefully next week".
- Any release of LLM material will be announced a full day in advance.

**Rules and Procedures** (3 Nov 2026) [P]:
- The steering committee alone decides when "LLM products" are released.
- Participants sign no NDAs but agree to abide by committee decisions. Participation is unpaid.
- There are conflict-of-interest bars on outside research into YM/QCD existence.
- The group claims no credit for the AI discoveries but seeks recognition for its own write-ups.

**Pushback.** The Advisory Group on Mathematics and AI (AGMAI) includes Gowers, Hairer and Witten. Witten is co-author of the Clay problem description. AGMAI recommended on 25 Oct that labs stop designating mathematicians, and on 26 Oct asked OpenAI to release the natural-language and Lean outputs **immediately** [P]. Critics (Woit, Baez and others) note that nobody yet knows the precise theorem: which gauge groups, which axioms, full or subsequential limit, torus or $\mathbb R^4$, non-triviality. Before the committee's statement appeared, Woit wondered whether the claim covers only small volume [C, ref 24]. The committee's "infinite distances" wording argues against that reading.

**Parallel open effort.** Ethan Sussman (Northwestern) and Levent Alpöge (Anthropic) have been pushing Balaban's programme with Claude in public. They claim QED$_3$ and YM$_3$ constructions (OS axioms for selected gauge-invariant fields, with subsequential limits) and an unfinished YM$_4$ "slop" [P].

**The strongest technical hint** about the "unified completion" is circumstantial but notable [I]. On 6 Oct 2026, Nathaniel Craig (KITP + OpenAI) posted arXiv:2610.09093. It is a GPT-6-Astra-assisted, nonperturbative **gauge-invariant lattice measure for chiral overlap fermions**, with a Lean-checked mathematical companion. The Lean check covers the companion's formal statements "under their recorded assumptions". AI agents, not humans, reviewed the correspondence between the Lean code and the companion (Craig §12). It begins with **SU(5) and $\mathbf{10}\oplus\bar{\mathbf 5}$**, which is exactly one SM generation in the simplest GUT [P]. Craig's own conclusions list reflection positivity compatible with admissibility, and the interacting continuum theory, as **open** as of 6 Oct [P].

**Bottom line for our project.** As of 2026-11-05 nothing about OpenAI's YM proof is public: no theorem statement, no Lean code and no manuscript. The first public artifact will almost certainly be the Lean statement and proof of *pure* YM existence. Our project should be ready to audit it within days of release. Our own "option 1" Lean problem statement should be designed so it can be compared directly with OpenAI's. The **mass gap remains open by every account**.

---

## 1. Key definitions and statements

### 1.1 The Clay problem (Jaffe–Witten), the yardstick for every claim

[P] Jaffe & Witten, *Quantum Yang–Mills Theory* (Clay official description), §4. *Close paraphrase of the boxed statement; the verifier rechecked it against the Clay PDF:*

> **Yang–Mills Existence and Mass Gap.** For every compact simple gauge group $G$, prove that a non-trivial quantum Yang–Mills theory exists on $\mathbb R^4$ and has a mass gap $\Delta>0$. Here "existence" means establishing axiomatic properties at least as strong as those in Jaffe–Witten's refs. [45, 35], i.e. Streater–Wightman and Osterwalder–Schrader.

Jaffe–Witten add several requirements and remarks:

- The QFT should have local quantum field operators corresponding to gauge-invariant local polynomials in the curvature, e.g. $\operatorname{Tr}F_{ij}F_{kl}(x)$.
- Correlation functions should agree at short distances with **asymptotic freedom** and perturbative renormalization theory. This includes a stress tensor and an OPE with the predicted local singularities.
- *Mass gap:* $H\Omega=0$ and $\operatorname{spec}H\cap(0,\Delta)=\emptyset$ for some $\Delta>0$.
- They remark that a **uniform gap for finite-volume approximations may be fundamental to proving existence of the infinite-volume limit**.

That last remark matters here: on my reading, the committee asserts infinite-volume control **without** a mass gap [I, interpreting "all the way to infinite distances"]. Jaffe–Witten §6 also says that in 2000 no known methods pointed toward a mass gap uniform in volume, or toward the limit $T^4\to\mathbb R^4$ [P].

**Euclidean (OS) formulation, which any Lean statement will almost certainly use [I].** Choose a family of gauge-invariant local fields $\{\mathcal O_\alpha\}$, for example smeared $\operatorname{Tr}F^2$ or Wilson-loop-type observables. The Schwinger functions
$$S_n(f_1,\dots,f_n)=\langle \mathcal O_{\alpha_1}(f_1)\cdots\mathcal O_{\alpha_n}(f_n)\rangle,\qquad f_i\in\mathcal S(\mathbb R^4),$$
must satisfy the following:

- **OS0**: temperedness / regularity, with the OS linear-growth condition needed for reconstruction;
- **OS1**: Euclidean $E(4)$ covariance;
- **OS2**: reflection positivity;
- **OS3**: permutation symmetry;
- **OS4**: clustering / ergodicity.

*(Numbering differs between sources. Glimm–Jaffe use OS0 analyticity, OS1 regularity, OS2 Euclidean invariance, OS3 reflection positivity, OS4 ergodicity. The labels above are this note's own, so check a Lean statement against content, not labels.)*

OS reconstruction then gives a Wightman theory. "Non-trivial" means at least non-Gaussian, for example a nonzero connected 4-point function. Ideally it also means agreement with perturbative AF at short distances.

**Regularization implied by the committee's text.** Wilson lattice action for $G=SU(N)$:
$$S_a(U)=\beta\sum_{p}\Bigl(1-\tfrac1N\operatorname{Re}\operatorname{Tr}U_p\Bigr),\qquad \beta=\frac{2N}{g_0^2(a)}.$$
The bare coupling is driven to zero as $a\to0$ along the AF trajectory: $\mu\,dg/d\mu=-\beta_0 g^3/(16\pi^2)+\dots$, with $\beta_0=\tfrac{11}{3}N-\tfrac23 N_f$. QCD with $SU(3)$ is AF for $N_f\le16$.

### 1.2 What OpenAI claims (rebuilt from [P\*])

| Element | Content (paraphrase; quotes ≤15 words) | Confidence |
|---|---|---|
| Physics headline | "mathematically rigorous existence proof of certain interacting quantum field theories" in 4D, with gauge fields and fermions | High (Woit quotes it verbatim; datastudios and xenospectrum paraphrase) |
| Theories covered | QCD; a "unified completion of the Standard Model"; pure YM as a "subproblem" | High for QCD and "unified completion" (Woit verbatim). Medium for "subproblem" (KITP page, unite.ai, xenospectrum; not confirmed as OpenAI's word) |
| Why a GUT | The SM itself "cannot be extrapolated to arbitrarily short distances" (unite.ai and xenospectrum quote this as OpenAI's). The Decoder says the reason is that some SM forces strengthen at short distances. The target is paraphrased as the *simplest grand unified theory* containing the SM gauge fields and fermions | Medium-high for the short-distance sentence; medium for the "simplest GUT" wording (outlets' paraphrase) |
| Clay relation | Pure YM existence is "part of" the Clay Millennium problem. Mass gap not claimed. *(Verifier: no source found for "prize not sought" on YM; that statement concerned Navier–Stokes)* | High (part of; no gap) |
| Method hint | Builds on Balaban's approach to constructive QFT (unite.ai, xenospectrum and datastudios all report this). The Decoder says both theories exist "mainly because of" asymptotic freedom | Medium-high |
| Dates | NL proof of YM 9 Sep 2026; QCD 18 Sep 2026; Lean of YM existence finished 16 Oct 2026 | High (Woit quotes OpenAI verbatim) |
| Release | Delayed until the Lean formalization was complete (AGMAI's 26 Oct statement confirms OpenAI gave this reason). Then deferred to the shepherds, who are withholding the AI artifacts and writing up the result themselves. *(The phrase "given the length and complexity" is unite.ai's wording, not a confirmed OpenAI quote)* | High |
| Principles | No NDAs (datastudios quotes the principle about non-disclosure agreements); OpenAI claims no academic credit; groups get recognition for their write-ups; participation voluntary and unpaid; members don't speak for OpenAI. OpenAI acknowledges that choosing the first shepherds creates an information asymmetry. *(That is the outlets' paraphrase: unite.ai, xenospectrum, Decoder; it is not a confirmed verbatim quote)* | High (datastudios, Decoder, unite.ai) |
| Funding | $5M to Simons Foundation for workshops and conferences on AI-produced results | High |

**Not stated anywhere public** [P\*, S]:
- the gauge group(s): all compact simple $G$, or $SU(N)$, or $SU(3)$ only;
- which axioms are verified;
- whether convergence is full or subsequential;
- torus or $\mathbb R^4$ (the committee implies $\mathbb R^4$);
- how non-triviality is shown;
- the exact Lean theorem;
- model name, prompts, compute, agent count;
- the GUT group, and whether a Higgs sector is included;
- whether QCD is Lean-formalized (only YM is reported as formalized).

### 1.3 What the committee states (all [P])

**First statement** ("Proof by OpenAI of the Existence of Quantum Yang-Mills theory — Statement by the shepherding committee", Oct 2026, 2 pp.):

- They welcome "the recent proof by OpenAI of the existence of quantum Yang-Mills theory, including coupling to fermions". They call it "an important step" toward rigorous QFT.
- **Custody:** on 16 Oct OpenAI asked Gross to take custody, decide the release mode and shepherd it. Gross chose the other members. They act for the academic community, to minimize risks such as wrong results or omitted attributions. "We have no responsibility to OpenAI."
- **Physics framing:** $SU(3)$ YM plus quarks is QCD. AF is believed to lead to confinement and a mass gap.
- **Method credit:** Wilson's 1974 lattice regularization, and lattice-gauge numerics as evidence for the continuum limit, confinement and the gap. The RG as "repeated coarse graining of the lattice by integrating out a subset of the degrees of freedom". In infinite volume the limit "must become translationally and rotationally invariant". Balaban's 1980s constructive RG papers. Balaban's ideas were "among the important elements" enabling OpenAI to "follow the theory all the way to infinite distances" and prove the existence of its "proper continuum limit".
- **Explicitly open:** confinement and the mass gap.
- **Process:** The manuscripts' length and complexity are "formidable". They want to be convinced the proof is correct before releasing it. OpenAI is providing a Lean formalization. **Step 1:** check that the definitions and problem statement match standard physics and mathematics, and that the formalization matches the informal treatment. Then release the Lean proof. **Step 2:** deeper understanding, drawing in other community members. When satisfied, release the assessment "together with the full 1147-page LLM proofs".
- Framed as an experiment. Cites Douglas, *The Yang–Mills Millennium problem*, Nat. Rev. Phys. 8, 86–97 (2026). Contact: YANGMILLS4d@gmail.com.

**Second statement** (3 Nov 2026, 1 p.):

- Current focus is checking "the Lean proof of the existence of **pure** Yang-Mills theory": definitions and problem statements versus standard ones, and the formalization versus the informal treatment.
- "Proceeding well … hope to complete it very soon"; release "hopefully next week".
- Periodic updates promised. Any release of LLM-produced material will be announced a full day ahead.

**Rules and Procedures of the Yang Mills Group** (3 Nov 2026, 1 p.; PDF author metadata "David Gross"):

- **Purpose:** evaluate OpenAI's claimed construction of YM in 4D **and QCD**, and release it with an assessment. The assessment covers a clear statement of what is claimed, the ideas behind the proof, a correctness judgment, and a review of prior researchers' contributions. The group may extend its purview to other submitted works.
- **Governance:** the steering committee (the five) decides "how we proceed and when we release the LLM products". More members may be added, with membership disclosed. No NDAs, but members agree to abide by committee decisions. Voluntary and unpaid.
- **Credit:** no academic credit sought for AI discoveries. Recognition is sought for the group's understanding, write-ups and materials, and the group will ensure proper attribution of prior work.
- **Conflicts of interest:** members may not do outside research on proofs of existence of YM and QCD, work for a company doing such research, or have other biasing interests.
- **Departure:** members who leave agree not to disclose group materials. This is functionally an NDA-like obligation despite the "no NDA" clause [I].

> Correction to a widely repeated reading: Woit wrote that the rules keep the 1147-page write-up private for the group's own use. That is his interpretation. The **first statement** explicitly commits to releasing the full 1147-page proofs *with the assessment, once satisfied*. No date is given [P].

---

## 2. Detailed findings

### 2.1 Timeline (verified dates in bold; source tags)

| Date (2026) | Event | Source |
|---|---|---|
| Aug 1–5 | OpenAI "ten advances" (Astra); `openai/ten-proofs` repo created 2026-08-05 (Lean 4.32.0, ten math/TCS results, no physics) | [P] repo, GitHub API; [C] timeline blog |
| ~Sep 3 | GPT-6 Astra publicly launched (limited access) | [S/C] multiple aggregators; not opened |
| **Sep 8** | OpenAI Navier–Stokes blow-up claim; `openai/NavierStokesAndEuler` repo created. Same day Sussman emails Alpöge and their collaboration begins | [P] repo; [S] SciAm |
| **Sep 9** | OpenAI model produces a natural-language proof of YM existence | [P\*] |
| **Sep 18** | QCD proof | [P\*] |
| Sep 22 / 29 | AGMAI formed; general guidelines published (pathways 2A/2B) | [P] agmai.org |
| **Oct 6** | `openai/math` released (repo created 2026-10-06T21:47Z per the GitHub API; the *current* README says 721 manuscripts in 373 families, a count that postdates the Oct 26 additions). Includes the "baby Yang–Mills" 2D $O(3)$ family 215. Craig posts arXiv:2610.09093 (Astra-assisted chiral lattice measure). Sussman–Alpöge repo made public. AGMAI comments on the release | [P] |
| Oct 7 | Three manuscripts withdrawn (sign error); 14 revised | [P] `history.md` |
| Oct 8 | Woit, "AI and Chiral Fermions" | [C] |
| **Oct 16** | YM Lean formalization finished. OpenAI asks Gross to take custody. Also the reported ETH disproof date | [P] committee; [P\*] |
| Oct 19–23 | KITP program "Intermediate-Scale AI for Physics". Coordinators: Craig, Qi, Roberts, Silverstein, Strominger, Xi Yin (Woit: all now OpenAI-affiliated). Discussion sessions not recorded | [P] KITP page; [C] Woit |
| **Oct 25** | AGMAI: "Disadvantages of Designating Mathematicians for AI Output Releases". `openai/math` preprints for ETH and local smoothing dated Oct 25. Sussman–Alpöge update the repo with YM3 existence. SciAm says only "Sunday evening"; Oct 25 is my inference from the Monday 26 Oct announcement | [P]; [S] |
| **Oct 26 (Mon)** | OpenAI blog post. `openai/math` updated with ETH and local-smoothing manuscripts plus Lean. AGMAI asks for immediate release of the YM output. Alpöge's X post criticizing OpenAI for not contacting Sussman. Woit, "Secret Unified Physics Slop". Wikipedia updated | [P], [P\*], [C] |
| **Oct 27** | Committee's first statement (PDF CreationDate 2026-10-27 15:25:56 CDT = 20:25:56Z). SciAm articles (dated Oct 27). SciAm reports that Anthropic posted its own ETH disproof "mere hours" after OpenAI's announcement, which puts it on ~Oct 26–27, not necessarily Oct 27 | [P], [S] |
| Oct 29 | `openai/math` Comparator fix (CM Hodge) | [P] |
| Nov 2 | Woit, "OpenAI Conference at KITP". In a later update to that post, Woit reports that Xi Yin announced he is leaving OpenAI (date of the announcement is ~Nov 2–3) | [C] |
| **Nov 3** | Second statement plus Rules and Procedures (PDF created 2026-11-03T19:29Z). KITP news page "Statement by the Yang-Mills Working Group – November 3, 2026 Update" | [P] |
| ~Nov 9–13 (expected) | Lean proof of pure YM existence to be released, announced one day in advance | [P] 2nd statement |

**Reporting discrepancies to be aware of:**
- Wikipedia's citation dates the OpenAI post "2026-10-06". This conflicts with every other source (Oct 26) and is likely a citation error.
- Some outlets date the committee statement Oct 28.
- SciAm's lede says OpenAI "released" a formal proof validating QCD, which contradicts its own body text and all primary sources. No QCD Lean formalization is reported.
- Press gives the Oct 6 manuscript count as 722 or 719. The current README says 721 manuscripts in 373 families. `history.md` (Oct 7 entry) says 300/719 top-line results formalized; note that 719 counts *top-line results*, not manuscripts.

### 2.2 How the proof was produced (models, agents, compute)

**What is known:**

- **Model:** an unnamed "internal" OpenAI model [P\*]. Scientific American reports it is the **same proprietary internal model behind the Navier–Stokes result** [S].
- **Lean timing:** OpenAI said Lean verification of YM took "well more than a month" (Sep 9 to Oct 16 = 37 days). SciAm cites "a reported 17 hours" for Navier–Stokes, without saying who reported it [S, SciAm]. Tristan Buckmaster (NYU) disputed that Lean verification should take more than a couple of days [S].
- **Length:** "1147-page LLM proofs" [P, committee]. That is about 1,150 pages of natural-language proof. Its scope is **unstated**: it could be YM only, YM plus QCD, or all three theories.
- **Disclosure:** prompts, compute time and chain-of-thought have **not** been disclosed [S, SciAm "Dueling proofs"]. AGMAI's pathway 2B asks for disclosure of model name, prompts, reasoning traces, number of attempts, compute and cost, and of how problems were chosen. **None of this has been provided for YM** [P].
- **Navier–Stokes as the closest documented analogue** [S, unverified against OpenAI's NS post]:
  - ~10,000 parallel agents for ~88 hours (NYT via The Nightly; Science Times; widely repeated);
  - message and token counts **conflict across outlets**: one gives ~2.7M messages and ~130B tokens, another ~5M messages (apparently Euler and NS combined);
  - a staged strategy: first the inviscid Euler blow-up, then a *forced* Navier–Stokes blow-up (Clay alternatives (C)/(D), per the `openai/NavierStokesAndEuler` README);
  - Lean formalization in a "reported 17 hours" (SciAm).
  - The ~10,000-agent swarm figure is reported for **NS only**. Nothing public says the YM proof used a comparable swarm. SciAm says only that YM came from the same internal model.

  A personal blog (George Coote) names the NS model "Bel" and estimates the cost at $15–30M [C, unverified]. Bastounis–Circelli–Hansen, arXiv:2610.08144 (posted 6 Oct; verified), argue that the NS *Lean proof* does not correspond to the natural-language *proof*. They document mismatches in intermediate lemmas, and a separate library note (03) says they do not claim the headline Lean theorem fails [P]. This is a direct warning about the fidelity risk, between statement and proof, that the committee is now checking for YM.
- **Oct 6 batch as process baseline** [P, `openai/math` README]: about 4,000 problems were posed to an unreleased internal model. The average compute per result was about 3 hours of "ChatGPT Pro thinking". Output was aggregated into families and manuscripts above a significance bar. Lean "Comparator challenges" separate statement files from proof files. About 42% of top-line results were formalized; the README warns that unformalized ones "could have issues".

**Contrast: the open Sussman–Alpöge pipeline** [P, repo README]:

1. Claude generates massive "slop": QED3 about 4,000 pages, YM3 about 30k, YM4 about 61k.
2. Codex condenses this into "minimal manuscripts": QED3 242 pp.; YM3 857 + 1201 pp.
3. "Closed slop" means material that has been refereed and frozen.
4. Some parts are checked by hand. Hybrid human/Astra rewrites are planned (e.g. RPM1).

Known failure mode: definitions explicit in the slop become implicit after condensation. Credit is proposed on the model of experimental physics collaborations.

**Contrast: Craig's Astra pipeline** [P, arXiv:2610.09093, Acknowledgments and §12]:

1. The human proposes a strategy (extend Lüscher via refinement).
2. Several rounds of iteration with Astra and outside experts. Golterman and Shamir are thanked for input "throughout"; Kronfeld for expertise and comments on the manuscript.
3. An "Astra-led proof", with the manuscript mixing human-written and Astra-rewritten sections.
4. Astra carries out Lean verification. Sixteen Lean 4 modules compile with standard axioms only and no placeholders. Correspondence between Lean and the math companion is reviewed by "AI agents".
5. Two independent cross-checks: a 2D chiral SU(5) analogue, and a second, independent construction that agrees up to exponentially local counterterms.

### 2.3 Technical hints about the method

**Directly sourced:**

1. **Lattice plus rigorous RG à la Balaban** [P committee; P\* OpenAI]. Balaban's CMP series (1983–89) built block-averaging RG for lattice gauge fields:
   - background fields and propagators: CMP 95, 99, 102 (1984–85);
   - effective actions and small-field coupling-constant renormalization in $d=4$: CMP 109 (1987), CMP 116 (1988);
   - large-field renormalization: CMP 122 (1989).

   This is generally summarized as **ultraviolet stability on a finite torus**: bounds on effective actions and the partition function that are uniform in the lattice spacing. It is **not** a construction of the continuum limit of gauge-invariant correlation functions. Jaffe–Witten §6 note that the effective-action results still had to be extended to expectations of gauge-invariant functions of the fields [P].

   Expert opinion on its status is mixed [S]. Bauerschmidt says "He basically did it" (SciAm, *Dueling proofs*). He also says the papers are incomplete and extraordinarily hard to read, that experts did not seriously doubt they could be completed (SciAm, Oct 27), and that nobody who understands them can currently tell whether they are correct (*Dueling proofs*).

   Dimock's expository series (arXiv:1108.1335, 1212.5562, 1304.0705) illustrates Balaban's method on scalar $\phi^4_3$ on a toroidal lattice. His QED$_3$ paper (arXiv:2009.01156) proves a UV stability bound in fixed finite volume. Together they make the method accessible.
2. **Infinite volume.** The committee says Balaban's ideas helped OpenAI "follow the theory all the way to infinite distances" and prove the existence of its "proper continuum limit" [P]. *[Verifier correction: the committee's sentence that the infinite-volume limit "must become translationally and rotationally invariant" is a **general statement about the RG approach**, made in the preceding paragraph. It does **not** say explicitly that OpenAI proved rotation invariance. Reading "proper continuum limit" as including full $O(4)$ invariance is an inference.]* This goes beyond Balaban, who stayed on a torus. Baez commented that the IR limit to $\mathbb R^4$ is "another huge step" that this approach still needs, and that Balaban stopped largely because he did not know how to do it [C, Woit comments; paraphrase corrected by the verifier].

   How OpenAI controls the IR **without** a mass gap is the central unknown. Possibilities [I]:
   - (a) compactness / tightness giving subsequential limits (Prokhorov-type), with OS axioms checked on limit points;
   - (b) a large-field / polymer expansion uniform in volume for gauge-invariant observables at fixed physical scale;
   - (c) a reflection-positivity trick for O(4) invariance. Alpöge mentions "winning O(4)-invariance via an RP trick" in YM4 [P, Sussman repo].
3. **Asymptotic freedom** is essential. Per the Decoder, OpenAI says both theories exist "mainly because of" AF [S]. The SM is excluded because it "cannot be extrapolated to arbitrarily short distances" [P\*, via unite.ai and xenospectrum]. The specific mechanism, the U(1)$_Y$ Landau pole and possibly the Higgs-quartic and Yukawa UV behaviour, is **my and Woit's gloss** [I/C], not OpenAI's stated reason.
4. **Not mentioned anywhere public:**
   - stochastic quantization (Chandra–Chevyrev–Hairer–Shen line);
   - gauge-fixing specifics (Balaban works with axial/Landau-type gauges on blocks; that is literature, not a claim about OpenAI);
   - Hamiltonian methods;
   - tensor RG. Douglas' Nat Rev Phys review reportedly flagged it [C, Iowa seminar abstract], but this is **[UNVERIFIED]**: no URL was recorded, the verifier could not locate the abstract, and the review is paywalled;
   - whether fermions are handled by Balaban–O'Carroll–Schor-type block RG for Euclidean fermions, which is a natural guess [I].

**Indirect but suggestive** (OpenAI-ecosystem artifacts from the same weeks):

5. **"Baby Yang–Mills": 2D $O(3)$ sigma model** [P, `openai/math` family 215, manuscripts dated Sep 23 – Oct 5]. The claims are a *canonical massive continuum limit* of the 2D nearest-neighbour $O(3)$ model:
   - taken along **all** couplings, not subsequences;
   - OS axioms satisfied;
   - nonzero connected 4-point function;
   - unique vacuum and positive Hamiltonian gap;
   - an isolated particle pole;
   - exact $O(4)$ lattice mass asymptotics $m_{\rm lat}(\beta)\sim32e^{\pi/4-1/2}\sqrt\beta\,e^{-\pi\beta}$;
   - exponential decay for 2D $O(n)$, $n\ge3$, at all temperatures. That is the Polyakov mass-generation conjecture, which would be a major result on its own.

   Only the $O(n)$ exponential-decay statement is Lean-formalized, and only as a bound uniform over *finite* free-boundary subgraphs. The infinite-volume limit, the $O(3)$ continuum limit and the $O(4)$ gap claim are explicitly excluded (lean/docs/215.md). Douglas called the sigma model the widely accepted "warm-up" for YM. On the related papers, SciAm (Oct 8) reports Bauerschmidt finding the first groundbreaking and comprehensible; that is the reporters' paraphrase, and his direct quote is that it "seems very reasonable". He called the second paper "horrible" and the rest "incomprehensible slop" [S]. **If the internal model can do an AF-driven, gap-producing full continuum limit in 2D, an AF-driven 4D existence proof without a gap is plausible as a capability claim** [I]. It also suggests the mass gap is the targeted next step.
6. **Chiral lattice measure for SU(5) $\mathbf{10}\oplus\bar{\mathbf5}$** [P, Craig, arXiv:2610.09093, 6 Oct; KITP + OpenAI affiliation; GPT-6 Astra "essential"]:
   - a nonperturbative gauge-invariant overlap-fermion measure on admissible gauge fields;
   - covers SU(5) with one generation, all four global forms of the SM group $[SU(3)\times SU(2)\times U(1)]/\Gamma$ with $\Gamma=1,\mathbb Z_2,\mathbb Z_3,\mathbb Z_6$, and families of other anomaly-free chiral theories.

   This is the obvious ingredient for a "simplest GUT including SM fermions", since a chiral GUT needs a gauge-invariant chiral fermion measure [I]. Craig lists as **open**: reflection positivity compatible with admissibility, and the definition of the interacting continuum theory. Either OpenAI's GUT result resolved these after Oct 6, or its GUT claim is narrower than it sounds (e.g. a vectorlike reformulation, or no OS2 claimed) [I]. **High-priority question for the committee.**
7. **The GUT's AF arithmetic** [I, standard one-loop formula $b_0=\tfrac{11}{3}C_2(G)-\tfrac23\sum_{\text{Weyl}}T(R)-\tfrac16\sum_{\text{real scalars}}T(R)$]. For $SU(5)$ with three generations of $\bar{\mathbf5}\oplus\mathbf{10}$: $b_0=\tfrac{55}{3}-4=\tfrac{43}{3}>0$. Adding a real $\mathbf{24}$ and complex $\mathbf5$ Higgs gives $b_0=\tfrac{40}{3}>0$. So the gauge coupling is AF either way. Scalars would bring in quartic and Yukawa couplings whose UV behaviour is not automatically AF. OpenAI's phrase "gauge fields and fermions" (no Higgs mentioned) fits Woit's guess of SU(5) **without** a Higgs sector [C]. That guess appears in his 2 Nov post (ref 25), not the 26 Oct post. SU(5) minimal GUT is experimentally excluded (proton decay), which is irrelevant to the mathematics.

### 2.4 The committee's verification process and release schedule (consolidated)

| Stage | Description | Status (2026-11-05) | Source |
|---|---|---|---|
| 0 | OpenAI hands custody (16 Oct); Gross forms the committee | Done | [P] |
| 1a | Check that Lean **definitions and problem statement** match standard physics and math | "Proceeding well" | [P] 2nd stmt |
| 1b | Check that the formalization aligns with the informal 1147-page treatment | In progress | [P] |
| 1c | **Release the Lean proof of pure YM existence**, with one day's notice | "Hopefully next week" | [P] |
| 2 | Deeper understanding; recruit extra members (no NDAs; abide by decisions; COI rules) | Planned | [P] Rules |
| 3 | Release the assessment (claim statement, ideas, correctness judgment, attribution review) **with the full 1147-page LLM proofs** | No date | [P] 1st stmt, Rules |
| — | QCD: in purview per Rules; no Lean reported | Unknown | [P], [S] |
| — | GUT / "completions of the SM": KITP page mentions it; committee docs do not discuss it | Unknown | [P] KITP |

### 2.5 Expert statements and reactions

**Michael Douglas** (Harvard, committee member):
- On the OpenAI result: "a major advance", and the start of something larger [S, SciAm].
- On the 2D sigma-model papers: a decades-old warm-up for YM [S].
- He is also lead author of *Formalization of QFT* (arXiv:2603.15770, Mar 2026). That paper is a Lean 4 / Mathlib formalization of the 4D free scalar field satisfying the Glimm–Jaffe (OS-variant) axioms, now with no assumed results [P]. **This is the most likely reference point for the committee's "definitions match standard ones" audit** [I].

**Roland Bauerschmidt** (NYU):
- Balaban "basically did it" (SciAm, *Dueling proofs*), though he adds that nobody who understands the papers can tell whether they are correct.
- In the other Oct 27 SciAm piece he calls the papers incomplete and extraordinarily hard to read, while saying experts did not seriously doubt they could be completed [S].

**Ethan Sussman** (Northwestern):
- The obstacle was the volume of work, not missing ideas.
- He is disappointed.
- His group claims subsequential limits plus OS axioms (with linear growth, hence Wightman) for the selected fields.
- It will be interesting to see whether OpenAI has *full* sequential convergence [S; C, Woit comments].

**Levent Alpöge** (Anthropic):
- Said on X that OpenAI chose not to contact Sussman to collaborate, and expressed dismay [S/C].
- The repository README warns against "rushing out 10,000-page slop" [P].

**Tristan Buckmaster** (NYU): disputes the claim that Lean takes over a month [S].

**John Baez:**
- Existence must exclude a disguised free theory.
- The IR limit from $T^4$ to $\mathbb R^4$ is a separate hard step.
- Existence is itself a major open problem [C].

**Peter Woit:**
- Calls omitting the mass gap from the headline misleading.
- Calls "unified completion of the SM" unexplained (26 Oct). Guesses SU(5) without a Higgs sector or symmetry breaking (2 Nov).
- Objects to secrecy, notes that six KITP coordinators are OpenAI-affiliated, and argues a public Lean release would allow fast verification [C].

**Blog commenters on Woit's posts** [C]:
- "Prokhorov_tightness": expects compactness / subsequential limits.
- "thelastcontrarian": points to the Jaffe–Witten exclusion of mere weak existence.
- "Haag": asks about Haag's theorem, Nielsen–Ninomiya and the Minkowski measure; answered by noting OS reconstruction and that QCD is vectorlike.

**AGMAI** (Charles, De Lellis, Gowers, Hairer, Srivastava, Tillmann, Vakil, Witten, Wood) [P]:
- Respects the chosen scientists, but understanding should develop openly with equal access.
- OpenAI tied the delay to Lean completion, which is now done, so there is "no scientific reason" for further delay.
- Designated-shepherd arrangements cause unequal access, biased selection and "borrowed reputation", and are unnecessary.

A reported OpenAI spokesperson reply told AGMAI to raise its concerns with Gross directly [S, search snippet only; unverified].


**Related ETH review group** (Impagliazzo, Paturi, Williams): their open letter says involvement "should not be taken as certification" [S]. That contrasts with the YM committee, which *does* intend to judge correctness.

### 2.6 The sibling claims (for comparison of release strategies)

| Claim | Release mode | Artifacts | Reviewers |
|---|---|---|---|
| ETH false: deterministic subexponential-time, poly-space #SAT for fixed-width CNF; 3-SAT case refutes ETH | Public immediately, at reviewers' request | `openai/math` preprint (Oct 25) plus Lean | Impagliazzo, Paturi, Williams; OpenAI to fund a conference |
| Local smoothing for the wave equation in all $n\ge2$, implying Kakeya maximal/dimension and Stein spherical restriction in the interior range | Released directly (Oct 6 pattern); an outside expert consulted; no shepherds | `openai/math` preprint plus Lean | None designated |
| YM, QCD, "unified completion" existence | Withheld; custody with shepherds | Nothing public | Gross committee |

Note the inconsistency: the **math** results are public with Lean, while the **physics** result is withheld. That is despite the physics Lean being finished first (Oct 16), and the ETH Lean on Oct 17 [P\*, S].

---

## 3. What is proven vs open

| Item | Status | Basis |
|---|---|---|
| OpenAI *claims* rigorous existence of 4D pure YM | **Claimed, unverified**; no public artifact | [P\*], [P] committee |
| OpenAI *claims* existence of QCD (YM plus quarks) | **Claimed, unverified**; Lean not reported | [P\*] |
| OpenAI *claims* existence of the "simplest GUT" / "unified completion of SM" | **Claimed, unverified; content undefined in public** | [P\*], KITP page |
| Lean formalization of pure-YM existence exists and compiles | **Claimed** by OpenAI and implicitly by the committee; not public | [P\*], [P] |
| Lean statement faithfully encodes the Clay existence notion | **Open**; it is exactly the committee's current task | [P] 2nd stmt |
| Mass gap for 4D YM | **Open**; explicitly not claimed by OpenAI or the committee | [P], [P\*] |
| Confinement | **Open** | [P] |
| Which $G$ (all compact simple vs $SU(N)$ vs $SU(3)$) | **Unknown** | — |
| Infinite volume ($\mathbb R^4$) vs torus | The committee **asserts** that OpenAI followed the theory to "infinite distances" and proved a "proper continuum limit". It mentions translation/rotation invariance only as a general requirement of the RG approach, not as something OpenAI explicitly proved. Details unknown | [P] |
| Full vs subsequential limit; uniqueness | **Unknown** | — |
| Non-triviality (non-Gaussian; AF short-distance behaviour) | **Unknown** | — |
| Balaban: UV stability of 4D lattice YM on a torus (effective-action / partition-function bounds; **not** a continuum limit of correlation functions) | **Published theorems** (CMP 1984–89, DOIs verified). Experts believe the programme can be completed, but they describe the papers as incomplete, very hard to read, and not currently checkable by anyone (Bauerschmidt) | [S] Bauerschmidt; Jaffe–Witten §6; literature |
| Magnen–Rivasseau–Sénéor: YM$_4$ with an infrared cutoff (CMP 155, 1993) | Published result (finite volume / IR-regularized) | DOI verified |
| Sussman–Alpöge: QED$_3$, YM$_3$ on $\mathbb R^3$ (subsequential, OS axioms for selected gauge-invariant fields) | **Claimed, LLM-written, partially hand-checked**; tentative per authors | [P] repo |
| Sussman–Alpöge YM$_4$ | **Unfinished "slop"** (≈61k pages; ≈20k "closed"). Sussman (not both authors) writes that it is "more likely than not" mostly correct, and he urges caution | [P] |
| `openai/math` 2D $O(3)$ massive continuum limit with gap | **Claimed, LLM-written. Only $O(n)$ exponential decay is Lean-formalized**, uniformly on finite subgraphs; no infinite-volume limit | [P] |
| Craig: gauge-invariant chiral lattice measure for SU(5) $\mathbf{10}\oplus\bar{\mathbf5}$ and SM groups | **Claimed; Lean-checked mathematical companion; not peer reviewed**. RP compatibility and the interacting continuum explicitly open | [P] arXiv:2610.09093 |
| Navier–Stokes (OpenAI, Sep 8): *forced* blow-up, Clay alternatives (C)/(D) | Claimed and Lean-certified. Bastounis–Circelli–Hansen (arXiv:2610.08144) document mismatches between the Lean proof and the natural-language proof. Not accepted by Clay | [P] repo, arXiv; [S] |
| Clay prize status | YM problem still listed as unsolved. With no mass gap claimed, the YM claim cannot satisfy the Clay statement. No OpenAI statement about the YM prize was found (its no-prize statement concerned NS) | [S] |

---

## 4. Relevance to a 4D YM existence + mass-gap proof and to Lean formalization

1. **The existence half may soon have a public Lean statement and proof.** If the committee releases as planned, our project's "option 1" Lean problem statement should be designed for **direct comparison** with OpenAI's. Concretely [I]:
   - mirror OpenAI's repository conventions, as observed in `openai/math`, `openai/ten-proofs` and `openai/NavierStokesAndEuler`. These are a separate `ComparatorChallenges/<Name>.lean` statement file with a matching `<Name>.json` Comparator config, a per-result scope document (`lean/docs/NNN.md` in `openai/math`), and a pinned Lean/Mathlib version (ten-proofs uses Lean 4.32.0). *(Verifier: an earlier draft named a `formalization.yaml` scope file; no such file was found in these repositories);*
   - be ready to run their proof against *our* statement, or prove equivalence or implication between statements.
2. **An audit checklist for the expected Lean release** [I; derived from Jaffe–Witten and the commentary]:
   - **Gauge group:** quantifier over all compact simple $G$, or a specific $SU(N)$? How are Lie groups and representations formalized?
   - **Observables:** which gauge-invariant fields (smeared $\operatorname{Tr}F^2$, all local polynomials, Wilson loops)? Are Schwinger functions tempered distributions on $\mathcal S(\mathbb R^4)^{\otimes n}$?
   - **Domain:** $\mathbb R^4$ or $T^4$. Infinite-volume uniqueness?
   - **Limit:** existence of *a* limit point vs a unique limit independent of regularization choices (block shape, gauge fixing, lattice action).
   - **OS axioms:** each of OS0–OS4 present? Linear-growth condition (needed for reconstruction)? Full $O(4)$ or only hypercubic covariance? Clustering stated without a gap?
   - **Non-triviality:** a nonzero connected 4-point function? Agreement with AF / perturbation theory at short distances? Stress tensor / OPE? (Jaffe–Witten's remarks, not strictly in the boxed statement.)
   - **Hygiene:** no `sorry`, no extra `axiom`s, no opaque constants that trivialize the statement. Check with `#print axioms` and an independent kernel replay.
   - **Statement fidelity:** compare with the free-field OS formalization of Douglas et al. (arXiv:2603.15770), which is the natural benchmark for "standard definitions".
   - **Trivial-solution check:** a Gaussian/free field must *not* satisfy the formal statement. If it does, the statement is too weak.
3. **The mass gap stays open, so it remains the frontier for our project.** OpenAI's ecosystem shows it can produce AF-driven, gap-producing continuum limits in **2D** (family 215). If the 4D YM proof is released, its RG machinery (multi-scale effective actions, large/small-field decomposition, uniform bounds) is the natural substrate on which to attempt a gap. Jaffe–Witten even suggest that uniform finite-volume gaps may underpin the infinite-volume limit. We should plan to *consume* their construction once it is public.
4. **Method signal.** Every primary or semi-primary hint points to **Balaban-style lattice RG**, not stochastic quantization or other routes. The length (1147 pp.) is consistent with the user's premise of a ~1,000-page, Lean-formalizable proof. Our research library should prioritise Balaban (CMP series), Dimock's expositions, Magnen–Rivasseau–Sénéor, and the Sussman–Alpöge QED$_3$/YM$_3$ manuscripts as the closest public analogues.
5. **Lessons for the AI process.** These bear on items (b) and (c) of the user's request.
   - (i) OpenAI's physics workflow was staged: YM first, then QCD nine days later, then the GUT (no date reported for the GUT). Natural-language proof came first and Lean afterwards. OpenAI says YM formalization took "well more than a month" (37 days from the NL proof to Lean completion), against a reported 17 h for NS. Buckmaster disputes that Lean needs that long. This suggests **the Lean step for constructive QFT is the bottleneck** and needs dedicated infrastructure: Mathlib distributions, Gaussian measures, Lie groups.
   - (ii) The open Sussman–Alpöge pipeline is a reproducible template for a smaller team: massive generation, then condensation, then refereeing, then "closed slop", then human-paced rewriting. Its failure mode (definitions lost in condensation) is a design requirement for our pipeline: keep a **definitions ledger**.
   - (iii) Craig's pipeline shows the value of *independent second constructions* and *lower-dimensional analogues* as verification beyond Lean.
   - (iv) AGMAI pathway 2B is the emerging disclosure norm (model, prompts, traces, attempts, compute, problem selection). Our project should comply by design.

---

## 5. Open questions and leads

1. **Exact theorem.** What precisely does the Lean statement of "existence of pure YM" assert (see the checklist above)? *Lead:* the committee's announced release (watch KITP news, the committee's email, and Woit's blog). The committee promises one day of notice.
2. **Which gauge groups?** The committee's text speaks of YM generally, and $SU(3)$ for QCD. Does the proof handle every compact simple $G$, as Clay requires?
3. **IR control without a gap.** How does OpenAI get to "infinite distances"? Compactness (subsequential), uniform-in-volume cluster expansions for gauge-invariant observables, or something new? Is the limit unique?
4. **Rotational invariance.** Restored from hypercubic symmetry how? Alpöge's "RP trick" for O(4) invariance in YM4 may be related.
5. **Non-triviality.** Is a non-Gaussian connected correlator proved? Is short-distance agreement with AF proved?
6. **Fermions.** For QCD, which lattice fermions (Wilson, staggered, overlap)? Is reflection positivity proved with fermions? For the GUT, is a chiral measure used (Craig) and is RP established (Craig lists it as open)?
7. **"Unified completion of the SM" / "completions" (plural on the KITP page).** Which group (SU(5)? SO(10)?), how many generations, and is there a Higgs? Is any Lean formalization done?
8. **Scope of the 1147 pages.** YM alone, YM plus QCD, or all three?
9. **Process disclosure.** Model identity (internal model vs GPT-6 Astra vs the NS model), agent count, compute, attempts. None disclosed. AGMAI pressure may yield more.
10. **Relationship to open efforts.** Did OpenAI's model see the Sussman–Alpöge repository (public from Oct 6; OpenAI's YM proof dated Sep 9)? Dates suggest independent priority for OpenAI, but attribution of Balaban-programme ideas will be part of the committee's review.
11. **Independent formal check.** Will the Lean release include Comparator-style statement files enabling third-party replay? (OpenAI's math repositories do this.)
12. **Mass-gap follow-up.** Is OpenAI attempting the gap? The 2D $O(3)$/$O(4)$ gap results suggest capability interest. Watch `openai/math` `history.md`.
13. **Craig's open items.** RP compatible with admissibility, and the interacting continuum. Were they resolved inside OpenAI's GUT proof?
14. **Navier–Stokes precedent.** The mismatch for NS between the Lean proof and the natural-language proof (Bastounis–Circelli–Hansen, arXiv:2610.08144, 6 Oct) is a template for the failure mode to test in the YM Lean release.
15. **Leads to monitor:**
    - KITP news page;
    - YANGMILLS4d@gmail.com (committee contact);
    - agmai.org;
    - github.com/openai (new repositories);
    - the Sussman–Alpöge repository and sibling projects (`marikgoldstein/scalar-qed-existence`, `pmaronow/3d-ym-torus`);
    - Woit's *Not Even Wrong*;
    - Douglas, Nat Rev Phys 8 (2026) 86–97, for the committee's own framing of the problem.

---

## References

Verified = I confirmed the item exists via arXiv metadata, DOI/Crossref, GitHub API/raw files, or by fetching the page. "Content read" says whether I read the content directly.

1. Douglas, M. R.; Gross, D. J. (Chair); Jaffe, A.; Klebanov, I. R.; Nekrasov, N. *Proof by OpenAI of the Existence of Quantum Yang-Mills theory — Statement by the shepherding committee* (Oct 2026; PDF created 2026-10-27). https://www.kitp.ucsb.edu/sites/default/files/YM_working_group.pdf — **verified; read in full**.
2. Same authors. *Proof by OpenAI of the existence of Quantum Yang-Mills Theory — 2nd Statement by the Shepherding Committee, Nov. 3, 2026.* https://www.kitp.ucsb.edu/sites/default/files/2nd-Statement-About-Quantum-YangMills-Theory_Nov-3.pdf — **verified; read in full**.
3. (Gross, D., PDF author.) *Rules and Procedures of the Yang Mills Group* (2026-11-03). https://www.kitp.ucsb.edu/sites/default/files/RULES%20AND%20PROCEDURES%20OF%20THE%20YANG%20MILLS%20GROUP.pdf — **verified; read in full**.
4. KITP. *Statement by the Yang-Mills Working Group – November 3, 2026 Update.* https://www.kitp.ucsb.edu/statement-by-the-yangmills-working-group — **verified; read**.
5. OpenAI. *Working with academic communities to build scientific understanding* (blog post, 26 Oct 2026). https://openai.com/index/building-scientific-understanding-with-academic-communities/ — **existence verified** (URL returns 403 rather than 404; cited by Wikipedia, TNW, Woit and others); **content NOT read directly**, rebuilt from secondary quotes.
6. AGMAI. Statements of 22 Sep, 29 Sep, 6 Oct, 25 Oct ("Disadvantages of Designating Mathematicians…") and 26 Oct 2026 ("Recommendation for Immediate Release of Yang–Mills AI Output"). https://agmai.org/ (anchors `#request-immediate-release`, `#disadvantages-designating-mathematicians`, `#openai-release`; guidelines at https://agmai.org/general-sep29/) — **verified; read**.
7. OpenAI. `openai/math` GitHub repository (created 2026-10-06), README, CONTENTS.md, history.md, lean/docs/215.md. https://github.com/openai/math — **verified; read** (README, history, family 215 entries, Lean scope doc).
8. OpenAI (internal model). *The canonical massive continuum limit of the two-dimensional O(3) model* and companions (family 215, Sep 23 – Oct 5, 2026). https://github.com/openai/math/blob/main/preprints/The-canonical-massive-continuum-limit-of-the-two-dimensional-O3-model-October-4-2026/massive-continuum-o3.pdf — **verified (listed in CONTENTS.md); abstract read, PDF not read**.
9. OpenAI. `openai/ten-proofs` (Lean certificates for ten results; created 2026-08-05). https://github.com/openai/ten-proofs — **verified; README read**.
10. OpenAI. `openai/NavierStokesAndEuler` (Lean certificates; created 2026-09-08). https://github.com/openai/NavierStokesAndEuler — **verified; README read**. Linked blog: https://openai.com/index/navier-stokes-solution/ — listed in the official README; not read.
11. Sussman, E. W.; Alpöge, L. *Yang–Mills-LLM-experiment* (GitHub, public from ~6 Oct 2026). https://github.com/ethanwsussman/Yang--Mills-LLM-experiment — **verified; README read in full**.
12. Craig, N. *A gauge-invariant measure for lattice chiral fermions.* arXiv:2610.09093 [hep-lat] (6 Oct 2026). https://arxiv.org/abs/2610.09093 — **verified (arXiv API); PDF downloaded; pp. 1–7, 57–63 read**.
13. Craig, N. *Mathematical companion and Lean formalization for "A gauge-invariant measure for lattice chiral fermions"* (Zenodo, 2026-10-06). doi:10.5281/zenodo.23196062 — **verified (Zenodo API)**; not read.
14. Douglas, M. R. *The Yang–Mills Millennium problem.* Nat. Rev. Phys. **8**, 86–97 (2026). doi:10.1038/s42254-025-00909-2 — **verified (Crossref)**; not read (paywalled).
15. Douglas, M. R.; Hoback, S.; Mei, A.; Nissim, R. *Formalization of QFT.* arXiv:2603.15770 (Mar 2026). — **verified (arXiv); abstract read**; PDF already in library.
16. Jaffe, A.; Witten, E. *Quantum Yang–Mills Theory* (Clay Mathematics Institute problem description). https://www.claymath.org/wp-content/uploads/2022/06/yangmills.pdf — **verified; §§3–5 read**.
17. Clay Mathematics Institute. *Yang–Mills & the Mass Gap* (problem page). https://www.claymath.org/millennium/yang-mills-the-maths-gap/ — **verified (HTTP 200)**; not read.
18. Howlett, J. (SciAm; ed. L. Billings; sole author, so the earlier "Hall, P." co-author credit was a verifier correction). *OpenAI just scooped mathematicians' work on another million-dollar problem* (on-page headline; the page title is "OpenAI just scooped human researchers on a million-dollar quantum math problem") (27 Oct 2026). https://www.scientificamerican.com/article/openai-just-scooped-human-researchers-on-a-million-dollar-quantum-math-problem/ — **verified; read via fetch summary**.
19. Howlett, J.; Hall, P. (SciAm). *Dueling proofs from OpenAI and Anthropic astound scientists* (27 Oct 2026). https://www.scientificamerican.com/article/dueling-proofs-from-openai-and-anthropic-astound-scientists/ — **verified; read via fetch summary**.
20. Hall, P.; Howlett, J. (SciAm). *The most exciting claims from OpenAI's heap of new proofs* (8 Oct 2026). https://www.scientificamerican.com/article/the-most-exciting-claims-from-openais-heap-of-new-proofs/ — **verified; read via fetch summary**.
21. Schreiner, M. (The Decoder). *OpenAI asks outside experts, including a Nobel laureate, to check proofs its AI produced…* (27 Oct 2026). https://the-decoder.com/openai-asks-outside-experts-including-a-nobel-laureate-to-check-proofs-its-ai-produced-in-math-computer-science-and-physics/ — **verified; read**.
22. Constantin, A. M. (The Next Web). *OpenAI says its AI model has disproved the Exponential Time Hypothesis* (26 Oct 2026). https://thenextweb.com/news/openai-exponential-time-hypothesis-false-kakeya-yang-mills — **verified; read**.
23. Science (news). *AI cracks a 27-year-old pillar of computer science, OpenAI and Anthropic claim* (Oct 2026). https://www.science.org/content/article/ai-cracks-27-year-old-pillar-computer-science-openai-and-anthropic-claim — **exists (search index); fetch returned 403; only snippets seen**.
24. Woit, P. *Secret Unified Physics Slop* (Not Even Wrong, 26 Oct 2026, with updates and comments). https://www.math.columbia.edu/~woit/wordpress/?p=15948 — **verified; read**.
25. Woit, P. *OpenAI Conference at KITP* (2 Nov 2026). https://www.math.columbia.edu/~woit/wordpress/?p=15957 — **verified; read**.
26. Woit, P. *AI and Chiral Fermions* (8 Oct 2026). https://www.math.columbia.edu/~woit/wordpress/?p=15915 — **verified; read**.
27. KITP. *Intermediate-Scale AI for Physics* (program, 19–23 Oct 2026). https://www.kitp.ucsb.edu/activities/physicsai-m26 — **verified; read**.
28. Wikipedia. *Yang–Mills existence and mass gap* (accessed 2026-11-05). https://en.wikipedia.org/wiki/Yang%E2%80%93Mills_existence_and_mass_gap — **verified; read** (note its apparently wrong Oct 6 date for the OpenAI post).
29. Quantum Research Center. *OpenAI claims a proof that Yang–Mills theory exists* (28 Oct 2026). https://quantumresearch.center/news/articles/openai-yang-mills-existence/ — **verified; read**; secondary, moderate reliability.
30. Xenospectrum. *OpenAI Claims AI Produced New Results … but Withholds the Physics Proofs* (27 Oct 2026). https://xenospectrum.com/en/openai-yang-mills-kakeya-eth-release/ — **verified; read**; secondary.
31. Unite.AI. *OpenAI Says Its Models Produced Three Proofs in Math, CS, and Physics* (Oct 2026). https://www.unite.ai/openai-says-its-models-produced-three-proofs-in-math-cs-and-physics/ — **verified; read**; secondary.
32. Datastudios. *OpenAI claims AI disproof of the Exponential Time Hypothesis plus Kakeya and Yang-Mills proofs.* https://www.datastudios.org/post/openai-models-exponential-time-hypothesis-disproof-kakeya-yang-mills-proofs — **verified; read**; secondary.
33. Calegari, F. (guest post on T. Tao's blog). *Mathematics has changed; let's act like it* (1 Nov 2026). https://terrytao.wordpress.com/2026/11/01/mathematics-has-changed-lets-act-like-it/ — **verified; read** (no YM content; context on norms).
34. Coote, G. (personal blog, gc602). *A rough timeline of LLMs in maths* (11 Oct 2026). https://gc602.user.srcf.net/2026/10/11/a-rough-timeline-of-llms-in-maths/ — **verified; read**; low reliability (source of the unverified "Bel"/cost figures).
35. Alpöge, L. X post on OpenAI and Sussman (26 Oct 2026). https://x.com/__alpoge__/status/2114838067953770981 — **not verified directly** (fetch returned 402; seen only in search index and SciAm).
36. (Entry removed before publication: an unverified social-media post.)
37. Bałaban, T. *Renormalization group approach to lattice gauge field theories. I. Generation of effective actions in a small field approximation and a coupling constant renormalization in four dimensions.* Commun. Math. Phys. **109**, 249–301 (1987). doi:10.1007/BF01215223 — **verified (Crossref)**.
38. Balaban, T. *Renormalization group approach to lattice gauge field theories. II. Cluster expansions.* Commun. Math. Phys. **116**, 1–22 (1988). doi:10.1007/BF01239022 — **verified (Crossref; Crossref records the subtitle "II. Cluster expansions" in its subtitle field)**.
39. Balaban, T. *Large field renormalization. I. The basic step of the R operation.* Commun. Math. Phys. **122**, 175–202 (1989). doi:10.1007/BF01257412 — **verified (Crossref)**.
40. Balaban, T. *Large field renormalization. II. Localization, exponentiation, and bounds for the R operation.* Commun. Math. Phys. **122**, 355–392 (1989). doi:10.1007/BF01238433 — **verified (Crossref)**.
41. Balaban, T. *Propagators and renormalization transformations for lattice gauge theories. I* (CMP 95, 17–40, 1984, doi:10.1007/BF01215753); *Propagators for lattice gauge theories in a background field* (CMP 99, 389–434, 1985, doi:10.1007/BF01240355); *Ultraviolet stability of three-dimensional lattice pure gauge field theories* (CMP 102, 255–275, 1985, doi:10.1007/BF01229380); *The variational problem and background fields…* (CMP 102, 277–309, 1985, doi:10.1007/BF01229381) — **all verified (Crossref)**.
42. Magnen, J.; Rivasseau, V.; Sénéor, R. *Construction of YM$_4$ with an infrared cutoff.* Commun. Math. Phys. **155**, 325–383 (1993). doi:10.1007/BF02097397 — **verified (Crossref)**.
43. Dimock, J. *The Renormalization Group According to Balaban – I. Small fields; II. Large fields; III. Convergence.* arXiv:1108.1335, 1212.5562, 1304.0705 — **verified (arXiv)**; PDFs already in library.
44. Dimock, J. *Ultraviolet Stability for QED in d=3.* arXiv:2009.01156 — **verified (arXiv API; PDF in library)**.
45. Lüscher, M. *Abelian chiral gauge theories on the lattice with exact gauge invariance.* arXiv:hep-lat/9811032 — **verified; PDF downloaded**.
46. Lüscher, M. *Lattice regularization of chiral gauge theories to all orders of perturbation theory.* arXiv:hep-lat/0006014 — **verified; PDF downloaded**.
47. Lüscher, M. *Chiral gauge theories revisited.* arXiv:hep-th/0102028 — **verified; PDF downloaded**.
48. Chatterjee, S. *Yang–Mills for probabilists.* arXiv:1803.01950 — **verified**; PDF in library.
49. Chevyrev, I. *Stochastic quantisation of Yang–Mills* (review). arXiv:2202.13359 — **verified**; PDF in library (the alternative route; not indicated by any OpenAI hint).
50. Bauerschmidt, R.; Brydges, D. C.; Slade, G. *Introduction to a renormalisation group method.* arXiv:1907.05474 — **verified (arXiv)**; PDF now in library (downloaded by another workstream).
51. OpenAI. *GPT-6 Astra* (product page, Sep 2026; localized URLs such as https://openai.com/it-IT/index/gpt-6-astra/) — **page not verified directly** (HTTP 403). The 3 Sep 2026 limited-access launch is corroborated by multiple outlets (e.g. Fox Business, Constellation Research).
52. Secondary reporting on OpenAI's Navier–Stokes run (≈10,000 agents, 88 h): e.g. Science Times, *OpenAI Claims to Have Solved the Million-Dollar Navier–Stokes Problem in 88 Hours* (9 Sep 2026), https://www.sciencetimes.com/articles/62566/20260909/openai-claims-have-solved-million-dollar-navierstokes-problem-88-hours.htm — **verified by the verifier (page fetched)**: about 10,000 agents and ~88 h; no Lean timing given. The 17 h Lean figure comes from SciAm (ref 18).
53. Bastounis, A.; Circelli, F.; Hansen, A. C. *Navier-Stokes lost in translation: Why Lean verification of AI autoformalisation does not guarantee correct natural language proofs.* arXiv:2610.08144 [math.AP] (6 Oct 2026). https://arxiv.org/abs/2610.08144 — **verified (arXiv API)**; PDF already in library. Added by the verifier as the source of the "Oct 6 paper" on the NS mismatch between the Lean proof and the natural-language proof.

---

## Verification log

*Adversarial verification pass, 2026-11-05. All checks were made against live sources on that date. Corrections are applied in place above and marked "Verifier" where they change substance.*

### A. Reference existence and metadata

| Refs | Method | Result |
|---|---|---|
| 12, 15, 43 (×3), 44, 45, 46, 47, 48, 49, 50, 53 (arXiv) | arXiv API `id_list` query | All 14 IDs exist. Titles, authors and dates match. 2610.09093 = Craig (6 Oct 2026, hep-lat); 2603.15770 = Douglas, Hoback, Mei, Nissim (16 Mar 2026); 2610.08144 = Bastounis, Circelli, Hansen (6 Oct 2026; **added**). |
| 14, 37–42 (DOIs) | Crossref API | All 10 DOIs resolve, with matching title, volume, pages and year. Ref 38's subtitle is in Crossref's subtitle field (caveat corrected). Douglas, Nat. Rev. Phys. 8, 86–97, issued 12 Jan 2026. |
| 13 (Zenodo) | Zenodo API | Record 23196062: "Mathematical companion and Lean formalization for A gauge-invariant measure for lattice chiral fermions", Craig, 2026-10-06. Verified. (Crossref does not index it; DataCite DOI.) |
| 1–3 (committee PDFs) | Downloaded to scratch and text-extracted | Titles, members, wording and PDF metadata match. Ref 1 CreationDate 2026-10-27 15:25:56 CDT. Ref 3 author "David Gross", created 2026-11-03 13:29 CST. All quoted phrases ("including coupling to fermions", "all the way to infinite distances", "proper continuum limit", "full 1147-page LLM proofs", "hopefully next week", "a full day in advance") confirmed verbatim. |
| 4, 27 (KITP) | WebFetch | Confirmed. The news page mentions "completions of the Standard Model" and a YM "subproblem". Program coordinators confirmed (Craig, Qi, Roberts, Silverstein, Strominger, Yin); the page itself does not mention OpenAI. |
| 6 (AGMAI) | WebFetch of agmai.org and /general-sep29/ | Five statements, dates (22 Sep, 29 Sep, 6 Oct, 25 Oct, 26 Oct), all nine members, "no scientific reason" and "borrowed reputation" confirmed. Pathway 2B disclosures (model name, prompts, summarized reasoning trace, time, estimated compute cost, failed-problem counts, problem selection) confirmed. |
| 7–11 (GitHub) | GitHub API and raw files | Creation dates confirmed: `openai/math` 2026-10-06T21:47Z; `ten-proofs` 2026-08-05; `NavierStokesAndEuler` 2026-09-08; Sussman repo 2026-10-06. Also confirmed: README counts (721/373, ~4,000 problems, 3 h average, ~42%); history.md (Oct 7 withdrawals and 14 revisions; Oct 26 additions; Oct 29 Hodge fix; 300/719); CONTENTS family 215 (titles, dates 23 Sep – 5 Oct, $m_{\rm lat}$ formula); lean/docs/215.md scope; Sussman README page counts and quotes. The $O(4)$ asymptotic $32e^{\pi/4-1/2}\sqrt\beta\,e^{-\pi\beta}$ was also checked independently: it agrees with the Hasenfratz–Niedermayer $O(N)$ mass-gap formula at $N=4$, $m\propto\beta^{1/(N-2)}e^{-2\pi\beta/(N-2)}$. |
| 16, 17 (Clay) | PDF downloaded and text-extracted; page HTTP 200 | Problem statement, §4 requirements and the "uniform gap … may play a fundamental role" remark confirmed. The boxed statement is now given as a close paraphrase, not a 40-word quotation. |
| 18–22, 24–26, 28–34, 52 (press and blogs) | WebFetch | All exist with matching content. **Corrected:** ref 18 author (Howlett alone, not Howlett & Hall; on-page headline differs from page title); ref 22 author added (Constantin); ref 34 author added (Coote); ref 52 now actually opened. |
| 5, 10 (blog link), 23, 51 (openai.com, science.org) | HTTP status | 403 (bot wall). Existence is supported by secondary citations only. Content not verified; flags kept. |
| 35, 36 (X posts) | — | Cannot be verified (X serves any URL with 200). Ref 35's gist is corroborated by SciAm (Alpöge said OpenAI chose to scoop Sussman rather than collaborate). Ref 36 remains unverified. |

No fabricated references were found. No reference was removed.

### B. Library PDFs checked for content and ID match

First-page text was checked for 2610.09093, hep-lat_9811032, hep-lat_0006014, hep-th_0102028, 2603.15770, 1108.1335, 1212.5562, 1304.0705, 2009.01156, 1803.01950, 2202.13359, 1907.05474 and 2610.08144. All match their IDs. **No files deleted or downloaded.**

### C. Ten key factual claims checked

1. **OpenAI's dates (YM NL 9 Sep; QCD 18 Sep; YM Lean 16 Oct).** Confirmed. Woit quotes OpenAI verbatim, and unite.ai, datastudios and Quantum Research Center agree.
2. **Committee composition and custody (16 Oct, Gross chose the rest).** Confirmed verbatim in ref 1.
3. **Committee text on infinite distances, the continuum limit and the mass gap.** Confirmed. *Overstatement corrected:* the note had said the committee asserts OpenAI proved a translation- and rotation-invariant limit. The committee states invariance only as a general requirement of the RG approach (§2.3 item 2 and the §3 table fixed).
4. **Second statement and Rules (pure YM Lean check; "hopefully next week"; no NDAs; COI bars; departure confidentiality).** Confirmed verbatim.
5. **"OpenAI says it will not seek the prize" for YM.** *Not supported.* TNW reports a no-prize statement for **Navier–Stokes** (September). Removed from the Summary, the §1.2 table and the §3 table.
6. **OpenAI quotes ("simplest grand unified theory", "subproblem", "asymmetry of information", "given the length and complexity").** *Downgraded.* These are the outlets' paraphrases (unite.ai, xenospectrum, Decoder), not confirmed OpenAI wording. "Cannot be extrapolated to arbitrarily short distances" is quoted by two outlets as OpenAI's.
7. **Balaban's status.** Confirmed that the published CMP results establish UV stability on a torus. *Clarified* that this is not a continuum limit of correlation functions (per Jaffe–Witten §6). Bauerschmidt's "basically did it" is in *Dueling proofs*; in the same piece he says nobody can currently tell whether the papers are correct. "Widely regarded as essentially correct" was softened.
8. **Craig, arXiv:2610.09093.** Confirmed from the PDF: KITP/UCSB/OpenAI affiliations; SU(5) $\mathbf{10}\oplus\bar{\mathbf5}$; four SM global forms; sixteen Lean 4 modules with standard axioms only; correspondence reviewed by AI agents; 2D analogue and second construction; RP compatible with admissibility and the interacting continuum explicitly open; GPT-6 Astra "essential". *Nuance added:* Lean covers the companion's formal statements under recorded assumptions.
9. **Sussman–Alpöge claims and figures.** Confirmed: QED3 242 pp. / 4,007 pp. of slop; YM3 857+1201 pp. / ~30k; YM4 ~61k / ~20k closed; RP trick for O(4); "10,000-page slop" warning. Subsequential limits with OS axioms are confirmed by Sussman's comment on Woit's blog. *Corrected:* "more likely than not" is Sussman's view, not both authors'. Sussman's 8 Sep email and his "amount of work rather than … ideas" remark are confirmed in SciAm.
10. **Navier–Stokes analogue (10,000 agents, 88 h, 17 h Lean; the Oct 6 mismatch paper).** Agents and hours are confirmed as press reports (NYT via The Nightly; Science Times). The 17 h figure is SciAm's "reported" number. Message and token counts conflict across outlets (now noted). The Oct 6 paper is now identified as arXiv:2610.08144. *Corrected* "Lean statement does not match the English proof" to "Lean **proof** does not correspond to the NL **proof**" (intermediate-lemma mismatches).

Other spot checks:
- The $SU(5)$ one-loop $b_0$ arithmetic is correct ($43/3$; $40/3$ with a real $\mathbf{24}$ and a complex $\mathbf5$).
- QCD AF for $N_f\le16$ is correct, and so is the Wilson action normalization.
- Wikipedia's "2026-10-06" citation date is confirmed (text says 26 Oct).
- ETH found 16 Oct and formalized 17 Oct is confirmed (TNW, datastudios, unite.ai).
- Local smoothing was released directly on an outside expert's advice (Decoder; history.md).
- $5M to Simons is confirmed (Decoder, TNW).
- The ETH reviewers' "should not be taken as certification" is confirmed (TNW).
- Woit's SU(5)-without-Higgs guess is in his **2 Nov** post (attribution fixed).
- Baez's wording was a paraphrase presented as a quote (fixed to "another huge step").
- The SciAm lede inconsistency on QCD is confirmed.
- No `formalization.yaml` exists in OpenAI's repositories. The actual convention is `ComparatorChallenges/*.lean` + `*.json` and `lean/docs/NNN.md` (fixed).

### D. Residual concerns

- OpenAI's primary blog post (ref 5) remains **unread** because of the 403. Every [P\*] item depends on secondary reconstruction. Woit is the only verbatim source, and he quotes only a few sentences.
- Unverified: the "Douglas review flagged tensor RG" item (no source located); the OpenAI spokesperson reply to AGMAI; the GPT-6 Astra page itself.
- "Infinite distances" is read throughout as infinite volume / $\mathbb R^4$. The committee does not use the words "infinite volume" about OpenAI's result, so this reading should be confirmed when the Lean statement is released.
- No source confirms that the YM proof (as opposed to NS) used a large agent swarm. Treat agent-swarm parallels as analogy only.
- Craig's affiliation with OpenAI, and the KITP coordinators' affiliations, are relevant to independence, but their exact employment status (employee vs. visiting) comes from Woit [C].
- Some timeline items still rest on a single secondary source: Anthropic's ETH timing, Xi Yin's departure date, and the Oct 25 Sunday repo update.
