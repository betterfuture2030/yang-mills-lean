import YangMills.Lattice

/-!
# `SU(N)` as a compact gauge group

Instances needed to state the problem concretely for `G = SU(N)`, with full proofs.
-/

noncomputable section

open Topology

namespace YangMills

/-- The special unitary group `SU(N)`. -/
abbrev SU (N : ℕ) : Type := ↥(Matrix.specialUnitaryGroup (Fin N) ℂ)

variable {N : ℕ}

instance : ContinuousInv (SU N) where
  continuous_inv := by
    refine continuous_induced_rng.2 ?_
    have : (fun A : SU N => ((A⁻¹ : SU N) : Matrix (Fin N) (Fin N) ℂ)) =
        fun A : SU N => star (A : Matrix (Fin N) (Fin N) ℂ) := by
      funext A; rfl
    change Continuous (fun A : SU N => ((A⁻¹ : SU N) : Matrix (Fin N) (Fin N) ℂ))
    rw [this]
    exact continuous_subtype_val.star

instance : IsTopologicalGroup (SU N) where

/-- Entries of a unitary matrix have modulus at most one. -/
lemma norm_entry_le_one_of_star_mul_self {A : Matrix (Fin N) (Fin N) ℂ}
    (hA : star A * A = 1) (i j : Fin N) : ‖A i j‖ ≤ 1 := by
  have h := congrFun (congrFun hA j) j
  simp only [Matrix.mul_apply, Matrix.star_apply, Matrix.one_apply_eq] at h
  have hre := congrArg Complex.re h
  simp only [Complex.re_sum, Complex.one_re] at hre
  have hterm : ∀ k, (star (A k j) * A k j).re = ‖A k j‖ ^ 2 := by
    intro k
    rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]
    simp [Complex.mul_re]
  simp only [hterm] at hre
  have hle : ‖A i j‖ ^ 2 ≤ 1 := by
    rw [← hre]
    exact Finset.single_le_sum (f := fun k => ‖A k j‖ ^ 2) (fun k _ => by positivity)
      (Finset.mem_univ i)
  nlinarith [norm_nonneg (A i j)]

lemma isCompact_specialUnitaryGroup :
    IsCompact (Matrix.specialUnitaryGroup (Fin N) ℂ : Set (Matrix (Fin N) (Fin N) ℂ)) := by
  let K : Set (Matrix (Fin N) (Fin N) ℂ) :=
    Set.univ.pi fun _ => Set.univ.pi fun _ => Metric.closedBall (0 : ℂ) 1
  have hK : IsCompact K :=
    isCompact_univ_pi fun _ => isCompact_univ_pi fun _ => isCompact_closedBall _ _
  have hset : (Matrix.specialUnitaryGroup (Fin N) ℂ : Set (Matrix (Fin N) (Fin N) ℂ)) =
      {A | star A * A = 1} ∩ {A | A.det = 1} := by
    ext A
    simp [Matrix.mem_specialUnitaryGroup_iff, Matrix.mem_unitaryGroup_iff']
  have hclosed : IsClosed
      (Matrix.specialUnitaryGroup (Fin N) ℂ : Set (Matrix (Fin N) (Fin N) ℂ)) := by
    rw [hset]
    exact (isClosed_eq (continuous_star.mul continuous_id) continuous_const).inter
      (isClosed_eq (continuous_id.matrix_det) continuous_const)
  refine hK.of_isClosed_subset hclosed ?_
  intro A hA
  rw [hset] at hA
  intro i _ j _
  rw [Metric.mem_closedBall, dist_zero_right]
  exact norm_entry_le_one_of_star_mul_self hA.1 i j

instance : CompactSpace (SU N) :=
  isCompact_iff_compactSpace.mp isCompact_specialUnitaryGroup

instance : MeasurableSpace (SU N) := borel _

instance : BorelSpace (SU N) := ⟨rfl⟩

/-- `SU(N)` with its defining representation on `ℂᴺ`. -/
def suGauge (N : ℕ) : GaugeGroup N (SU N) where
  π := Submonoid.inclusion (Matrix.specialUnitaryGroup_le_unitaryGroup)
  continuous := continuous_inclusion
    (SetLike.coe_subset_coe.mpr Matrix.specialUnitaryGroup_le_unitaryGroup)
  injective := Submonoid.inclusion_injective Matrix.specialUnitaryGroup_le_unitaryGroup

end YangMills
