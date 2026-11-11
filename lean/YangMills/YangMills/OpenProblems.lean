import YangMills.Statement
import YangMills.NonVacuity.LieAlgebra
import YangMills.NonVacuity.Simple
import YangMills.NonVacuity.Connected

/-!
# Open problems (every `sorry` in the project lives here)

The first four theorems are **open**. Nothing in this project proves them. They are recorded
as theorems with `sorry` so that the statements are type-checked and can be audited, and so
that any future proof has a fixed target.

The one remaining `sorry` outside the open problems is a **classical fact not yet formalized
here** (consistency of the OS axioms with the non-degeneracy clauses). It is labelled as such.

Audit: `lake env lean YangMills/Audit.lean` prints the axioms of every theorem.
-/

namespace YangMills

/-- **Clay Millennium Problem: Yang–Mills existence and mass gap.** OPEN. -/
theorem clay_yang_mills : ClayYangMills := by
  sorry

/-- **Existence half of the Clay problem** (no mass gap). OPEN. -/
theorem clay_existence : ClayExistence := by
  sorry

/-- Existence of quantum `SU(N)` Yang–Mills theory on `ℝ⁴` along the asymptotic-freedom
trajectory (the scope of OpenAI's announced result, as reported). OPEN. -/
theorem su_yang_mills_exists (N : ℕ) (hN : 2 ≤ N) : SUNExists N := by
  sorry

/-- Existence and mass gap for `SU(N)` with the fundamental Wilson action. OPEN. -/
theorem su_yang_mills_mass_gap (N : ℕ) (hN : 2 ≤ N) : SUNExistsWithMassGap N := by
  sorry

/-! ### Non-vacuity obligations

They show that the hypotheses of `ClayYangMills` are satisfiable (so the general statement is
not vacuous), that it specializes to `SU(N)`, and that the axioms are jointly consistent with
the non-degeneracy clauses. -/

/-- `SU(N)` is connected. **Proved** (`NonVacuity/Connected.lean`: `SU(N)` is a continuous
retract-image of the path-connected unitary group). -/
theorem su_connected (N : ℕ) : ConnectedSpace (SU N) :=
  su_connected_proof N

/-- The Lie algebra of `SU(N)` (`N ≥ 2`) is simple. **Proved**: the Lie algebra of `suGauge N`
is `𝔰𝔲(N)` (`NonVacuity/LieAlgebra.lean`), which is a simple real Lie algebra
(`NonVacuity/Simple.lean`). -/
theorem su_lieAlgebra_simple (N : ℕ) (hN : 2 ≤ N) :
    IsSimpleMatrixLieAlgebra (suGauge N).lieAlgebra := by
  rw [suGauge_lieAlgebra]
  exact su_isSimple N hN

/-- Consistency of the OS axioms with `NonTrivial` and `FullFieldContent`. Classical: the
composite fields `tr F_{μν} F_{κλ}` (Wick-ordered) of the free Maxwell field with values in
`𝔰𝔲(N)` satisfy all of them. Not yet formalized here. (The full `IsYangMillsTheory` conjunction
also includes `ShortDistanceAF` and the lattice clause, and its consistency *is* the open
problem: no rigorous 4D asymptotically free theory is known.) -/
theorem os_nonTrivial_fullField_consistent :
    ∃ S : Schwinger ι4, OSAxioms tensorRep S ∧ NonTrivial tensorRep S ∧ FullFieldContent S := by
  sorry

/-- The Clay statement specializes to `SU(N)`. Fully proved (the hypotheses of `ClayYangMills`
are satisfied by `SU(N)`, `N ≥ 2`, so the general statement is not vacuous). -/
theorem su_mass_gap_of_clay (h : ClayYangMills) (N : ℕ) (hN : 2 ≤ N) :
    ExistsWithMassGapFor (SU N) := by
  have := su_connected N
  exact h N (SU N) (suGauge N) (su_lieAlgebra_simple N hN)

/-- `SUNExistsWithMassGap` (fundamental Wilson action) implies the Clay conclusion for `SU(N)`.
Fully proved. -/
theorem existsWithMassGapFor_of_sun (N : ℕ) (h : SUNExistsWithMassGap N) :
    ExistsWithMassGapFor (SU N) :=
  ⟨N, suGauge N, h⟩

end YangMills
