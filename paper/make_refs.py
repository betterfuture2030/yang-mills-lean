#!/usr/bin/env python3
"""Build paper/refs.bib: the subset of ../library/references.bib cited in main.tex, plus a few
added (Crossref/arXiv-verified) entries, with characters unsupported by Latin Modern converted
to LaTeX. Run from the paper/ directory."""
import re

tex = open('main.tex').read()
keys = []
for m in re.finditer(r'\\cite[pt]?\*?\{([^}]*)\}', tex):
    for k in m.group(1).split(','):
        k = k.strip()
        if k and k not in keys:
            keys.append(k)
lib = open('../library/references.bib').read()
entries = {}
for e in re.split(r'\n(?=@)', lib):
    m = re.match(r'@\w+\{([^,]+),', e)
    if m:
        entries[m.group(1)] = e.strip()
extra = {
 'Caswell1974': "@article{Caswell1974,\n  author = {Caswell, W. E.},\n  title = {{Asymptotic behavior of non-Abelian gauge theories to two-loop order}},\n  journal = {Phys. Rev. Lett.},\n  volume = {33},\n  pages = {244--246},\n  year = {1974},\n  doi = {10.1103/PhysRevLett.33.244}\n}",
 'Jones1974': "@article{Jones1974,\n  author = {Jones, D. R. T.},\n  title = {{Two-loop diagrams in Yang--Mills theory}},\n  journal = {Nucl. Phys. B},\n  volume = {75},\n  pages = {531--538},\n  year = {1974},\n  doi = {10.1016/0550-3213(74)90093-5}\n}",
 'Collins1977': "@article{Collins1977,\n  author = {Collins, J. C. and Duncan, A. and Joglekar, S. D.},\n  title = {{Trace and dilatation anomalies in gauge theories}},\n  journal = {Phys. Rev. D},\n  volume = {16},\n  pages = {438--449},\n  year = {1977},\n  doi = {10.1103/PhysRevD.16.438}\n}",
 'Ebel2025': "@misc{Ebel2025,\n  author = {Ebel, N. and Kennedy, T. and Rychkov, S.},\n  title = {{Tensor renormalization group meets computer assistance}},\n  howpublished = {arXiv:2506.03247},\n  year = {2025},\n  eprint = {2506.03247},\n  archivePrefix = {arXiv},\n  url = {https://arxiv.org/abs/2506.03247}\n}",
}

# ---- corrections from the pre-deposit verification (all metadata checked against Crossref/arXiv/Zenodo)
extra.update({
 'Remondiere2026': "@misc{Remondiere2026,\n  author = {R{\\'e}mondi{\\`e}re, K{\\'e}vin},\n  title = {{ClayYM: a candidate Lean 4 statement of the Yang--Mills existence and mass gap problem, with compiled guards against fake models}},\n  howpublished = {Zenodo, version 1.1.0, 25 Oct 2026},\n  year = {2026},\n  doi = {10.5281/zenodo.23650415},\n  url = {https://github.com/AIdevsmartdata/yang-mills-lean-statement}\n}",
 'AGMAI2026a': "@misc{AGMAI2026a,\n  author = {{Advisory Group on Mathematics and Artificial Intelligence (AGMAI)}},\n  title = {{Responsible Release of AI-Generated Mathematics (General Guidelines)}},\n  howpublished = {29 Sep 2026},\n  year = {2026},\n  url = {https://agmai.org/general-sep29/}\n}",
 'AGMAI2026': "@misc{AGMAI2026,\n  author = {{Advisory Group on Mathematics and Artificial Intelligence (AGMAI)}},\n  title = {{Statements of 22 Sep, 29 Sep, 6 Oct, 25 Oct and 26 Oct 2026, including the Recommendation for Immediate Release of Yang--Mills AI Output}},\n  howpublished = {Accessed 5 Nov 2026},\n  year = {2026},\n  url = {https://agmai.org/}\n}",
 'Dimock2013b': "@article{Dimock2013b,\n  author = {Dimock, J.},\n  title = {{The renormalization group according to Balaban, I. Small fields}},\n  journal = {Rev. Math. Phys.},\n  volume = {25},\n  pages = {1330010},\n  year = {2013},\n  doi = {10.1142/S0129055X13300100}\n}",
 'Dimock2013c': "@article{Dimock2013c,\n  author = {Dimock, J.},\n  title = {{The renormalization group according to Balaban. II. Large fields}},\n  journal = {J. Math. Phys.},\n  volume = {54},\n  pages = {092301},\n  year = {2013},\n  eprint = {1212.5562},\n  archivePrefix = {arXiv},\n  doi = {10.1063/1.4821275}\n}",
 'Dimock2014': "@article{Dimock2014,\n  author = {Dimock, J.},\n  title = {{The renormalization group according to Balaban III. Convergence}},\n  journal = {Ann. Henri Poincar\\'e},\n  volume = {15},\n  pages = {2133--2175},\n  year = {2014},\n  eprint = {1304.0705},\n  archivePrefix = {arXiv},\n  doi = {10.1007/s00023-013-0303-3}\n}",
 'Dimock2022': "@article{Dimock2022,\n  author = {Dimock, J.},\n  title = {{Stability for QED in d=3: an overview}},\n  journal = {J. Math. Phys.},\n  volume = {63},\n  pages = {042305},\n  year = {2022},\n  eprint = {2204.07201},\n  archivePrefix = {arXiv},\n  doi = {10.1063/5.0081057}\n}",
 'Brydges2015a': "@article{Brydges2015a,\n  author = {Brydges, D. C. and Slade, G.},\n  title = {{A renormalisation group method. I. Gaussian integration and normed algebras}},\n  journal = {J. Stat. Phys.},\n  volume = {159},\n  pages = {421--460},\n  year = {2015},\n  eprint = {1403.7244},\n  archivePrefix = {arXiv},\n  doi = {10.1007/s10955-014-1163-z}\n}",
 'Dobrushin1985': "@incollection{Dobrushin1985,\n  author = {Dobrushin, R. L. and Shlosman, S. B.},\n  title = {{Constructive criterion for the uniqueness of Gibbs field}},\n  booktitle = {Statistical Physics and Dynamical Systems},\n  editor = {Fritz, J. and Jaffe, A. and Sz{\\'a}sz, D.},\n  publisher = {Birkh{\\\"a}user},\n  address = {Boston},\n  pages = {347--370},\n  year = {1985},\n  doi = {10.1007/978-1-4899-6653-7_20}\n}",
 'Moura2021': "@inproceedings{Moura2021,\n  author = {de Moura, L. and Ullrich, S.},\n  title = {{The Lean 4 theorem prover and programming language}},\n  booktitle = {Automated Deduction -- CADE 28},\n  series = {Lecture Notes in Computer Science},\n  volume = {12699},\n  pages = {625--635},\n  publisher = {Springer},\n  year = {2021},\n  doi = {10.1007/978-3-030-79876-5_37}\n}",
 'Mathlib2020': "@inproceedings{Mathlib2020,\n  author = {{The mathlib Community}},\n  title = {{The Lean mathematical library}},\n  booktitle = {Proceedings of the 9th ACM SIGPLAN International Conference on Certified Programs and Proofs (CPP 2020)},\n  pages = {367--381},\n  year = {2020},\n  doi = {10.1145/3372885.3373824}\n}",
 'Tanizaki2022': "@article{Tanizaki2022,\n  author = {Tanizaki, Y. and \\\"Unsal, M.},\n  title = {{Center vortex and confinement in Yang--Mills theory and QCD with anomaly-preserving compactifications}},\n  journal = {Prog. Theor. Exp. Phys.},\n  volume = {2022},\n  pages = {04A108},\n  year = {2022},\n  doi = {10.1093/ptep/ptac042}\n}",
 'Gaiotto2017': "@article{Gaiotto2017,\n  author = {Gaiotto, D. and Kapustin, A. and Komargodski, Z. and Seiberg, N.},\n  title = {{Theta, time reversal and temperature}},\n  journal = {J. High Energy Phys.},\n  volume = {2017},\n  number = {5},\n  pages = {091},\n  year = {2017},\n  eprint = {1703.00501},\n  archivePrefix = {arXiv},\n  doi = {10.1007/JHEP05(2017)091}\n}",
 'Morningstar1999': "@article{Morningstar1999,\n  author = {Morningstar, C. and Peardon, M.},\n  title = {{The glueball spectrum from an anisotropic lattice study}},\n  journal = {Phys. Rev. D},\n  volume = {60},\n  pages = {034509},\n  year = {1999},\n  eprint = {hep-lat/9901004},\n  archivePrefix = {arXiv},\n  doi = {10.1103/PhysRevD.60.034509}\n}",
 'Lucini2013': "@article{Lucini2013,\n  author = {Lucini, B. and Panero, M.},\n  title = {{SU(N) gauge theories at large N}},\n  journal = {Phys. Rep.},\n  volume = {526},\n  pages = {93--163},\n  year = {2013},\n  doi = {10.1016/j.physrep.2013.01.001}\n}",
 'Chevyrev2026d': "@article{Chevyrev2026d,\n  author = {Chevyrev, I. and Shen, H.},\n  title = {{Uniqueness of gauge covariant renormalisation of stochastic 3D Yang--Mills--Higgs}},\n  journal = {Arch. Ration. Mech. Anal.},\n  volume = {250},\n  number = {1},\n  pages = {11},\n  year = {2026},\n  eprint = {2503.03060},\n  archivePrefix = {arXiv},\n  doi = {10.1007/s00205-025-02163-3}\n}",
 'Aizenman2021': "@article{Aizenman2021,\n  author = {Aizenman, M. and Duminil-Copin, H.},\n  title = {{Marginal triviality of the scaling limits of critical 4D Ising and $\\lambda\\phi^4_4$ models}},\n  journal = {Ann. of Math.},\n  volume = {194},\n  pages = {163--235},\n  year = {2021},\n  eprint = {1912.07973},\n  archivePrefix = {arXiv},\n  doi = {10.4007/annals.2021.194.1.3}\n}",
 'Sussman2026': "@misc{Sussman2026,\n  author = {Sussman, E. and Alp{\\\"o}ge, L.},\n  title = {{Yang--Mills-LLM-experiment}},\n  howpublished = {GitHub repository, created 6 Oct 2026, accessed 6 Nov 2026; LLM-written QED$_3$ and YM$_3$ manuscripts, unfinished YM$_4$},\n  year = {2026},\n  url = {https://github.com/ethanwsussman/Yang--Mills-LLM-experiment}\n}",
 'Aronow2026': "@misc{Aronow2026,\n  author = {Aronow, P. M. and Lopatto, P.},\n  title = {{The continuum limit of three-dimensional SU(2) lattice Yang--Mills theory on a torus I--V}},\n  howpublished = {Hexagon preprints 2610.00506 and 2610.00509--2610.00512 (v1, Oct 2026); primarily AI-generated},\n  year = {2026},\n  url = {https://hexagonmath.org/2610.00506v1}\n}",
 'Yin2026': "@misc{Yin2026,\n  author = {Yin, X. and others},\n  title = {{xiyin137/OSreconstruction: Lean 4 formalization of the Osterwalder--Schrader reconstruction theorem}},\n  howpublished = {GitHub repository (contributors include X.~Yin, M.~R. Douglas and A.~Mei), accessed 5 Nov 2026},\n  year = {2026},\n  url = {https://github.com/xiyin137/OSreconstruction}\n}",
 'OpenAI2026b': "@misc{OpenAI2026b,\n  author = {{OpenAI}},\n  title = {{Exponential decay in two-dimensional classical $O(n)$ models}},\n  howpublished = {openai/math repository, family 215, 23 Sep 2026},\n  year = {2026},\n  url = {https://github.com/openai/math}\n}",
 'OpenAI2026j': "@misc{OpenAI2026j,\n  author = {{OpenAI}},\n  title = {{openai/math: AI-generated manuscripts with Lean library}},\n  howpublished = {GitHub repository, Apache-2.0; 721 manuscripts in 373 families as of 6 Nov 2026},\n  year = {2026},\n  url = {https://github.com/openai/math}\n}",
 'OpenAI2026p': "@misc{OpenAI2026p,\n  author = {{OpenAI}},\n  title = {{Working with academic communities to build scientific understanding}},\n  howpublished = {Blog post, 26 Oct 2026},\n  note = {Not retrievable by the author's tools (HTTP 403); content as reported by press and blogs},\n  year = {2026},\n  url = {https://openai.com/index/building-scientific-understanding-with-academic-communities/}\n}",
 'Leandojo2026': "@misc{Leandojo2026,\n  author = {{lean-dojo}},\n  title = {{lean-dojo/LeanMillenniumPrizeProblems}},\n  howpublished = {GitHub repository, accessed 5 Nov 2026},\n  year = {2026},\n  url = {https://github.com/lean-dojo/LeanMillenniumPrizeProblems}\n}",
 'DeepMind2026': "@misc{DeepMind2026,\n  author = {{Google DeepMind and contributors}},\n  title = {{google-deepmind/formal-conjectures}},\n  howpublished = {GitHub repository, accessed 6 Nov 2026},\n  year = {2026},\n  url = {https://github.com/google-deepmind/formal-conjectures}\n}",
 'Douglas2026c': "@misc{Douglas2026c,\n  author = {Douglas, M. R. and Rajasekaran, F.},\n  title = {{mrdouglasny/lgt: Lattice gauge theory in Lean 4}},\n  howpublished = {GitHub repository, accessed 5 Nov 2026},\n  year = {2026},\n  url = {https://github.com/mrdouglasny/lgt}\n}",
 'KITP2026b': "@misc{KITP2026b,\n  author = {{KITP}},\n  title = {{Statement by the Yang--Mills Working Group -- November 3, 2026 Update}},\n  howpublished = {Web page, 3 Nov 2026},\n  year = {2026},\n  url = {https://www.kitp.ucsb.edu/statement-by-the-yangmills-working-group}\n}",
 'Fefferman2000': "@misc{Fefferman2000,\n  author = {Fefferman, C. L.},\n  title = {{Existence and smoothness of the Navier--Stokes equation}},\n  howpublished = {Clay Mathematics Institute problem description (2000)},\n  year = {2000},\n  url = {https://www.claymath.org/wp-content/uploads/2022/06/navierstokes.pdf}\n}",
})
extra.update({
 'Douglas2026g': "@misc{Douglas2026g,\n  author = {Douglas, M. R. and Gross, D. J. and Jaffe, A. and Klebanov, I. R. and Nekrasov, N.},\n  title = {{Proof by OpenAI of the existence of Quantum Yang-Mills Theory: 3rd Statement by the Shepherding Committee}},\n  howpublished = {KITP, 9 Nov 2026; announces the release on 10 Nov 2026 of https://github.com/yang-mills-group/OpenAI-YM-20261028 and https://github.com/yang-mills-group/YM},\n  year = {2026},\n  url = {https://www.kitp.ucsb.edu/sites/default/files/3rd-Statement-About-Quantum-YangMills-Theory_Nov-9.pdf}\n}",
})
extra.update({
 'Osterwalder1973': "@article{Osterwalder1973,\n  author = {Osterwalder, K. and Schrader, R.},\n  title = {{Axioms for Euclidean Green's functions}},\n  journal = {Commun. Math. Phys.},\n  volume = {31},\n  pages = {83--112},\n  year = {1973},\n  doi = {10.1007/BF01645738}\n}",
 'Osterwalder1975': "@article{Osterwalder1975,\n  author = {Osterwalder, K. and Schrader, R.},\n  title = {{Axioms for Euclidean Green's functions II}},\n  journal = {Commun. Math. Phys.},\n  volume = {42},\n  pages = {281--305},\n  year = {1975},\n  doi = {10.1007/BF01608978}\n}",
 'Douglas2004': "@misc{Douglas2004,\n  author = {Douglas, M. R.},\n  title = {{Report on the Status of the Yang--Mills Millenium Prize Problem}},\n  howpublished = {Clay Mathematics Institute, April 2004 (title spelling as printed)},\n  year = {2004},\n  url = {https://ncatlab.org/nlab/files/Douglas-StatusOfYMMillenniumProb.pdf}\n}",
})
for _k, _v in list(extra.items()):
    entries.pop(_k, None)   # overrides win

missing = [k for k in keys if k not in entries and k not in extra]
if missing:
    raise SystemExit(f"missing keys: {missing}")
sup = dict(zip('⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻', '0123456789+-'))
sub = dict(zip('₀₁₂₃₄₅₆₇₈₉₊₋', '0123456789+-'))
greek = {'α': r'\alpha', 'β': r'\beta', 'γ': r'\gamma', 'δ': r'\delta', 'ε': r'\varepsilon',
         'θ': r'\theta', 'λ': r'\lambda', 'μ': r'\mu', 'ν': r'\nu', 'π': r'\pi', 'ρ': r'\rho',
         'σ': r'\sigma', 'τ': r'\tau', 'φ': r'\phi', 'χ': r'\chi', 'ψ': r'\psi', 'ω': r'\omega',
         'Φ': r'\Phi', 'Λ': r'\Lambda', 'Σ': r'\Sigma', 'Ω': r'\Omega', 'Δ': r'\Delta', 'Γ': r'\Gamma'}
syms = {'≥': r'$\geq$', '≤': r'$\leq$', '∞': r'$\infty$', '→': r'$\to$', '≈': r'$\approx$',
        '×': r'$\times$', 'ℝ': r'$\mathbb{R}$'}

def san(s):
    out = []
    for ch in s:
        if ch in sup: out.append(r'\textsuperscript{%s}' % sup[ch])
        elif ch in sub: out.append(r'\textsubscript{%s}' % sub[ch])
        elif ch in greek: out.append('$%s$' % greek[ch])
        elif ch in syms: out.append(syms[ch])
        else: out.append(ch)
    return ''.join(out)

ABBR = {'CMP': 'Commun. Math. Phys.', 'PRL': 'Phys. Rev. Lett.', 'PRD': 'Phys. Rev. D',
        'PRB': 'Phys. Rev. B', 'NPB': 'Nucl. Phys. B', 'Nucl. Phys. B': 'Nucl. Phys. B',
        'ARMA': 'Arch. Ration. Mech. Anal.', 'JMP': 'J. Math. Phys.', 'AHP': 'Ann. Henri Poincar\\\'e',
        'CPAM': 'Comm. Pure Appl. Math.', 'JSP': 'J. Stat. Phys.', 'PTRF': 'Probab. Theory Related Fields'}
JRE = re.compile(r'^(?P<j>.+?)\s+(?P<v>\d+[A-Za-z]?)\s*\((?P<y>\d{4})\)\s*(?:no\.\s*(?P<no>\w+),?\s*)?(?:art\.\s*|Paper No\.\s*|paper\s*)?(?P<p>[0-9A-Za-z]+(?:\s*[–-]+\s*[0-9A-Za-z]+)?)?\s*(?P<rest>.*)$')

def split_journal(e):
    m = re.search(r'\n(\s*)journal\s*=\s*\{(.*?)\},?\n', e)
    if not m:
        return e
    jm = JRE.match(m.group(2).strip())
    if not jm or re.search(r'\bvolume\s*=', e):
        return e
    j = ABBR.get(jm.group('j').strip(), jm.group('j').strip())
    fields = [f"  journal = {{{j}}},", f"  volume = {{{jm.group('v')}}},"]
    if jm.group('no'):
        fields.append(f"  number = {{{jm.group('no')}}},")
    if jm.group('p'):
        fields.append("  pages = {%s}," % re.sub(r'\s*[–-]+\s*', '--', jm.group('p')))
    return e.replace(m.group(0), "\n" + "\n".join(fields) + "\n")

def strip_fields(e):
    e = re.sub(r'\n\s*(keywords|theme|file)\s*=\s*\{[^\n]*\},?', '', e)
    # drop internal workflow annotations
    e = re.sub(r'\n\s*note\s*=\s*\{[^\n]*(UNVERIFIED|Additional URL|corrected from|verified in)[^\n]*\},?', '', e)
    e = re.sub(r'author\s*=\s*\{Balaban, T\.', r'author = {Ba{\\l}aban, T.', e)
    e = e.replace('author = {Bałaban, T.', r'author = {Ba{\l}aban, T.')
    return split_journal(e)

bib = [san(extra.get(k) or strip_fields(entries[k])) for k in keys]
open('refs.bib', 'w').write('% Cited subset of library/references.bib (+ added Crossref/arXiv-verified entries),\n'
                            '% sanitized for XeLaTeX with Latin Modern. Generated by make_refs.py.\n\n'
                            + '\n\n'.join(bib) + '\n')
print(f"{len(keys)} cited keys written; unverified: "
      f"{[k for k in keys if 'UNVERIFIED' in entries.get(k, '')]}")
