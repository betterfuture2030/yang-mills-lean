import YangMills

/-! Lens: mass gap / non-triviality.  Any witness `S` can be replaced by its projection
`S' = S ∘ M` (fields `Mᵀφ`), keeping the Wilson-limit, reflection-positivity and mass-gap
properties.  With `M` the O(4)-equivariant projector onto the scalar `tr F²` this collapses
the field content to a single scalar. -/

open YangMills Filter Topology
open scoped SchwartzMap

noncomputable section

namespace Scratch3

variable {ι : Type} [Fintype ι] [DecidableEq ι]

def act (M : Matrix ι ι ℝ) : TestFn ι →L[ℂ] TestFn ι := SchwartzMap.postcompCLM (matCLM M)

def pull (T : TestFn ι →L[ℂ] TestFn ι) (S : Schwinger ι) : Schwinger ι :=
  ⟨fun n => (S.S n).compContinuousLinearMap (fun _ => T)⟩

lemma act_apply (M : Matrix ι ι ℝ) (f : TestFn ι) (x : E4) (i : ι) :
    act M f x i = ∑ j, (M i j : ℂ) * f x j := by
  simp [act, matCLM, Matrix.toLin'_apply, Matrix.mulVec, dotProduct]

lemma tsupport_act (M : Matrix ι ι ℝ) (f : TestFn ι) :
    tsupport (act M f : E4 → ι → ℂ) ⊆ tsupport (f : E4 → ι → ℂ) :=
  tsupport_comp_subset (map_zero (matCLM M)) f

lemma inner_id {κ : Type} [Fintype κ] (v D : κ → ℂ) (Pm Z : Matrix κ κ ℝ) :
    ∑ i, v i * ∑ j, (((Pm * Z) i j : ℝ) : ℂ) * D j =
      ∑ i, (∑ j, ((Pm.transpose i j : ℝ) : ℂ) * v j) * ∑ j, ((Z i j : ℝ) : ℂ) * D j := by
  have lhs : ∑ i, v i * ∑ j, (((Pm * Z) i j : ℝ) : ℂ) * D j =
      ∑ a, ∑ c, ∑ b, v a * (Pm a c : ℂ) * (Z c b : ℂ) * D b := by
    simp only [Matrix.mul_apply, Complex.ofReal_sum, Complex.ofReal_mul, Finset.sum_mul,
      Finset.mul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun b _ => ?_
    ring
  have rhs : ∑ i, (∑ j, ((Pm.transpose i j : ℝ) : ℂ) * v j) * ∑ j, ((Z i j : ℝ) : ℂ) * D j =
      ∑ c, ∑ a, ∑ b, v a * (Pm a c : ℂ) * (Z c b : ℂ) * D b := by
    simp only [Matrix.transpose_apply, Finset.sum_mul, Finset.mul_sum]
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    ring
  rw [lhs, rhs, Finset.sum_comm]

section Lattice
variable {d : ℕ} {G : Type} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    [CompactSpace G] [MeasurableSpace G] [BorelSpace G]

lemma smearedField_mul (P : GaugeGroup d G) (L : ℕ) (a β : ℝ) (Pm Z : Matrix ι4 ι4 ℝ)
    (f : TestFn ι4) (U : GaugeConfig G L) :
    smearedField P L a β (Pm * Z) f U = smearedField P L a β Z (act Pm.transpose f) U := by
  unfold smearedField
  refine congrArg _ (Finset.sum_congr rfl fun x _ => ?_)
  simp only [act_apply]
  exact inner_id _ _ Pm Z

lemma latticeSchwinger_mul (P : GaugeGroup d G) (L : ℕ) (a β : ℝ) (Pm Z : Matrix ι4 ι4 ℝ)
    (n : ℕ) (f : Fin n → TestFn ι4) :
    latticeSchwinger P L a β (Pm * Z) n f =
      latticeSchwinger P L a β Z n (fun k => act Pm.transpose (f k)) := by
  unfold latticeSchwinger
  simp only [smearedField_mul]

/-- **The Wilson-limit clause is stable under projecting the field content.** For ANY real
matrix `M`, if `S` is a Wilson limit (renormalizations `Z_k`), so is `S ∘ M`
(renormalizations `Mᵀ Z_k`). -/
theorem isWilsonLimit_pull (P : GaugeGroup d G) (S : Schwinger ι4) (a β : ℕ → ℝ)
    (M : Matrix ι4 ι4 ℝ) (h : IsWilsonLimit P S a β) :
    IsWilsonLimit P (pull (act M) S) a β := by
  obtain ⟨L, Z, ha, ha0, hbox, hβ, hlim⟩ := h
  refine ⟨L, fun k => M.transpose * Z k, ha, ha0, hbox, hβ, fun n f hc hd => ?_⟩
  have hc' : ∀ k, HasCompactSupport (act M (f k) : E4 → ι4 → ℂ) := fun k =>
    (hc k).mono' ((subset_tsupport _).trans (tsupport_act M (f k)))
  have hd' : DisjointSupports (fun k => act M (f k)) := fun i j hij =>
    ((hd hij).mono (tsupport_act M (f i)) (tsupport_act M (f j)))
  simp only [latticeSchwinger_mul, Matrix.transpose_transpose]
  exact hlim n _ hc' hd'

end Lattice

end Scratch3
