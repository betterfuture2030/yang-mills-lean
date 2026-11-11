# YangMills: a Lean 4 / Mathlib statement of Yang–Mills existence and mass gap

Lean `v4.36.0-rc2`, Mathlib `v4.36.0-rc2`. Build: `lake exe cache get && lake build`.
Audit: `lake env lean YangMills/Audit.lean`.

This project **states** the problem. It does not prove it. Every `sorry` lives in
`YangMills/OpenProblems.lean`.

## Files

| File | Contents | `sorry` |
|---|---|---|
| `YangMills/OS.lean` | Spacetime, test functions, Euclidean motions, OS reflection; Osterwalder–Schrader axioms (normalization, E0' growth, reality, E1 covariance, E3 symmetry, E2 reflection positivity, E4 cluster); mass gap; non-triviality | none |
| `YangMills/Lattice.lean` | Compact matrix gauge groups, Lie algebra and simplicity; periodic lattice, plaquettes, Wilson action, Haar product measure, Gibbs expectations; lattice field strength and the composite fields `T_{μνκλ} = tr F_{μν}F_{κλ}`; the tensor representation of `O(4)`; smeared renormalized lattice fields and the continuum-limit predicate `IsWilsonLimit` | none |
| `YangMills/SU.lean` | `SU(N)` as a compact topological group (compactness proved), `suGauge N` | none |
| `YangMills/Statement.lean` | `IsYangMillsTheory`, `ExistsWithMassGap`, **`ClayYangMills`**, asymptotic scaling (`b₀`, `b₁`), **`SUNExists`** | none |
| `YangMills/OpenProblems.lean` | `clay_yang_mills`, `clay_existence`, `su_yang_mills_exists`, `su_yang_mills_mass_gap` (OPEN); `os_nonTrivial_fullField_consistent` (classical, not yet formalized); `su_connected`, `su_lieAlgebra_simple`, `su_mass_gap_of_clay` (**proved**) | 5 |
| `YangMills/NonVacuity/*.lean` | Fully proved: Lie algebra of `suGauge N` is `𝔰𝔲(N)`; `𝔰𝔲(N)` is simple (`N ≥ 2`); `SU(N)` is path-connected | none |
| `YangMills/Sanity.lean` | Fully proved: the trivial theory satisfies all OS axioms and has a mass gap but is not `NonTrivial`; the Wilson partition function is positive; `⟨c⟩ = c` | none |
| `YangMills/Audit.lean` | `#print axioms` for all of the above | — |

## The statement in one paragraph

`ClayYangMills` says: for every compact connected group `G` with a faithful continuous
unitary representation `π : G → U(d)` whose matrix Lie algebra is simple, there is a family
`S` of Schwinger functions for the 256 local fields `T_{μνκλ}(x) = tr F_{μν}F_{κλ}(x)` such
that

1. `S` satisfies the Osterwalder–Schrader axioms (with OS's linear growth condition E0', so
   OS reconstruction gives a Wightman theory);
2. `S` is non-trivial: centred, with a non-zero two-point function and a non-zero fourth cumulant
   at separated points, and a state orthogonal to the vacuum with positive norm;
3. `S` is the continuum limit (`a → 0`, `aL → ∞`, `β → ∞`, divergent renormalization matrices
   `Z_k` valued in the 21-dimensional `tr F F` space, plus vacuum subtraction) of Wilson's
   lattice gauge theory for *some* faithful unitary representation of `G`;
   * `FullFieldContent`: every non-zero direction in the 21-dimensional space gives a non-zero
     state;
   * `ShortDistanceAF`: in the scalar channel
     `λ⁸ log²(1/λ) S₂(D_λh₁, D_λh₂) → C ∫∫ h₁(x)h₂(y)|x−y|⁻⁸ dx dy` with `C > 0`;
4. `S` has a mass gap `Δ > 0`: `‖e^{-tH}(1 - P_Ω)‖ ≤ e^{-Δ t}`, stated on the OS
   pre-Hilbert space.

`SUNExists N` drops (4). To exclude the free massless limit it instead requires the
continuum limit to follow the two-loop asymptotic-freedom trajectory
`β/(2N) = 2b₀ log(1/a) + (b₁/b₀) log log(1/a) + const + o(1)`.

The docstrings of `SUNExists` (`Statement.lean`) and `su_yang_mills_exists` (`OpenProblems.lean`)
call it the shape or scope of OpenAI's announced result. That wording dates from 3–6 November 2026,
when OpenAI's gauge groups and exact statement were not public, and has not been checked against
the Lean code released on 10 November 2026. The files are left unchanged because their SHA-256
hashes are fixed (paper, §10).

## Design choices and known limitations

See `../../PROBLEM.md` §4 (choices and deviations) and §5 (review history) for the full discussion. In brief:

* **Multilinear Schwinger functions.** Every axiom except growth is imposed only on tuples
  with pairwise disjoint supports (the analogue of OS's `𝓢₀`). Reflection positivity is
  imposed on products supported in ordered positive-time slabs (the analogue of `𝓢₊`).
  Contact terms are left unconstrained, as in OS. Growth is OS II's E0′ on configuration
  space. The cluster axiom requires a **non-zero** spatial vector.
* **Field content.** The fields are the dimension-4 operators `tr F F`. The mass gap is
  therefore required (by `HasMassGap`) only on the Hilbert space these fields generate, which is a
  subspace of the charge-conjugation even sector. Adding higher-dimension operators (for example `tr F{F,F}`)
  with their own non-degeneracy clauses would cover more; this is a planned extension.
* **"Yang–Mills" is pinned down by the lattice.** Without the lattice clause the statement
  would be satisfied by non-Yang–Mills theories, such as Wick powers of a massive free field.
* **Subsequential limits.** Existence along *some* sequence. Uniqueness and universality
  (independence of the discretization) are not required.
* **Milestones.** `SUNExistsM7a` (hypercubic covariance, no cluster) and `SUNExistsM7b` (full
  O(4), no cluster) are weaker rungs; `SUNExists → M7b → M7a` is proved.
* **Non-vacuity.** `Sanity.lean` shows the OS axioms are satisfiable and that `NonTrivial`
  excludes the trivial theory. `NonVacuity/` proves that `SU(N)` (`N ≥ 2`) satisfies the
  hypotheses of `ClayYangMills` (connected, Lie algebra `𝔰𝔲(N)` simple), so the general
  statement is not vacuous; `su_mass_gap_of_clay` is sorry-free. Consistency of
  OS + `NonTrivial` + `FullFieldContent` (free Maxwell composites) remains a labelled obligation.
* **Review.** v0.1 → v0.2 fixed a critical bug (cluster axiom admitted `a = 0`, collapsing the
  Hilbert space) and four major fidelity issues found by adversarial review (two only partly: `ShortDistanceAF` is
  a scalar two-point fingerprint with no stress-tensor or OPE clause, and for Wilson-lattice method
  dependence the representation is now existential and the rest is a recorded deviation); see
  `../../PROBLEM.md` §5.
