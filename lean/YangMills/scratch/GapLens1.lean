import YangMills

open YangMills Filter Topology
open scoped SchwartzMap

noncomputable section

namespace Scratch

variable {ι : Type} [Fintype ι] [DecidableEq ι]

/-- Time translation shifts supports towards LATER times: `(T_a f)(x) = f(x - a)`. -/
example (a : E4) (f : TestFn ι) (x : E4) : YangMills.translate a f x = f (x - a) := rfl

/-- Pointwise action of a real matrix on test functions. -/
def act (M : Matrix ι ι ℝ) : TestFn ι →L[ℂ] TestFn ι := SchwartzMap.postcompCLM (matCLM M)

lemma act_apply (M : Matrix ι ι ℝ) (f : TestFn ι) (x : E4) (i : ι) :
    act M f x i = ∑ j, (M i j : ℂ) * f x j := by
  simp [act, matCLM, Matrix.toLin'_apply, Matrix.mulVec, dotProduct]

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

/-- **Key lattice identity.** Renormalizing with `Pm * Z` is the same as renormalizing with `Z`
and smearing with `Pmᵀ f`.  So any witness `(S, Z_k)` yields a witness `(S ∘ Pmᵀ, Pm Z_k)`. -/
lemma smearedField_mul {d : ℕ} {G : Type} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    [CompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (P : GaugeGroup d G) (L : ℕ) (a β : ℝ) (Pm Z : Matrix ι4 ι4 ℝ) (f : TestFn ι4)
    (U : GaugeConfig G L) :
    smearedField P L a β (Pm * Z) f U = smearedField P L a β Z (act Pm.transpose f) U := by
  unfold smearedField
  refine congrArg _ (Finset.sum_congr rfl fun x _ => ?_)
  simp only [act_apply]
  exact inner_id _ _ Pm Z

lemma latticeSchwinger_mul {d : ℕ} {G : Type} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (P : GaugeGroup d G) (L : ℕ) (a β : ℝ) (Pm Z : Matrix ι4 ι4 ℝ) (n : ℕ)
    (f : Fin n → TestFn ι4) :
    latticeSchwinger P L a β (Pm * Z) n f =
      latticeSchwinger P L a β Z n (fun k => act Pm.transpose (f k)) := by
  unfold latticeSchwinger
  simp only [smearedField_mul]

end Scratch
