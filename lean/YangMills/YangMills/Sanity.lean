import YangMills.Statement

/-!
# Sanity checks on the formal statement (fully proved, no `sorry`)

1. **Consistency of the OS axioms.** The trivial theory (`S₀ = 1`, `Sₙ = 0` for `n ≥ 1`)
   satisfies every OS axiom and has a mass gap, but is *not* `NonTrivial`. So the axioms as
   formalized are satisfiable (not contradictory), and the non-triviality clause does real
   work.
2. **The lattice Gibbs measure is well defined.** The partition function is strictly positive,
   so expectations are genuine averages (not junk division by zero), and `⟨c⟩ = c`.
-/

noncomputable section

open Filter Topology MeasureTheory
open scoped SchwartzMap

namespace YangMills

section Trivial

variable {ι : Type} [Fintype ι] [DecidableEq ι]

/-- Schwinger functions of the trivial theory. -/
def trivialS : (n : ℕ) → ContinuousMultilinearMap ℂ (fun _ : Fin n => TestFn ι) ℂ
  | 0 => ContinuousMultilinearMap.constOfIsEmpty ℂ (fun _ : Fin 0 => TestFn ι) 1
  | _ + 1 => 0

/-- The trivial theory. -/
def trivialTheory : Schwinger ι := ⟨trivialS⟩

lemma trivialS_apply (n : ℕ) (f : Fin n → TestFn ι) :
    trivialS n f = if n = 0 then 1 else 0 := by
  cases n <;> simp [trivialS]

/-- The vacuum component of a polynomial: the sum of its degree-zero coefficients. -/
def Poly.vac (F : Poly ι) : ℂ := ∑ j, if (F.m j).n = 0 then F.c j else 0

lemma rpForm_trivial (ρ : O4 →* Matrix ι ι ℝ) (F G : Poly ι) :
    rpForm ρ trivialTheory F G = (starRingEnd ℂ) F.vac * G.vac := by
  unfold rpForm Poly.vac
  rw [map_sum, Finset.sum_mul_sum]
  refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun l _ => ?_
  simp only [trivialTheory, trivialS_apply, Nat.add_eq_zero_iff]
  by_cases hj : (F.m j).n = 0 <;> by_cases hl : (G.m l).n = 0 <;> simp [hj, hl]

lemma Poly.vac_one : (Poly.one : Poly ι).vac = 1 := by
  simp [Poly.vac, Poly.one]
  exact Finset.card_fin 1

lemma Poly.vac_map (F : Poly ι) (T : TestFn ι → TestFn ι) : (F.map T).vac = F.vac := rfl

lemma rpFormT_trivial (ρ : O4 →* Matrix ι ι ℝ) (F G : Poly ι) :
    rpFormT ρ trivialTheory F G = 0 := by
  simp [rpFormT, rpForm_trivial, Poly.vac_one]

theorem trivial_osAxioms (ρ : O4 →* Matrix ι ι ℝ) : OSAxioms ρ (trivialTheory (ι := ι)) where
  normalized := by simp [OS.Normalized, trivialTheory, trivialS]
  growth := by
    refine ⟨0, 1, 0, fun n => ?_⟩
    cases n with
    | zero =>
      let T : 𝓢(Fin 0 → E4, (Fin 0 → ι) → ℂ) →L[ℂ] ℂ :=
        (ContinuousLinearMap.proj (R := ℂ) (φ := fun _ : (Fin 0 → ι) => ℂ) Fin.elim0).comp
          ((BoundedContinuousFunction.evalCLM ℂ (Fin.elim0 : Fin 0 → E4)).comp
            (SchwartzMap.toBoundedContinuousFunctionCLM ℂ (Fin 0 → E4) ((Fin 0 → ι) → ℂ)))
      refine ⟨T, fun F => ?_, fun f F _ hF => ?_⟩
      · have h1 : ‖T F‖ ≤ ‖F (Fin.elim0 : Fin 0 → E4)‖ := by
          simpa [T, BoundedContinuousFunction.evalCLM_apply] using
            norm_le_pi_norm (F (Fin.elim0 : Fin 0 → E4)) Fin.elim0
        have h2 : ‖F (Fin.elim0 : Fin 0 → E4)‖ ≤ SchwartzMap.seminorm ℂ 0 0 F := by
          simpa using SchwartzMap.le_seminorm ℂ 0 0 F (Fin.elim0 : Fin 0 → E4)
        simp only [Nat.factorial_zero, Nat.cast_one, Real.rpow_zero, one_mul, zero_mul,
          schwartzNormN, zero_add, Finset.range_one, Finset.sum_singleton]
        linarith
      · simp [T, BoundedContinuousFunction.evalCLM_apply, hF, trivialTheory, trivialS_apply]
    | succ m =>
      refine ⟨0, fun F => ?_, fun f F _ _ => ?_⟩
      · simp only [ContinuousLinearMap.zero_apply, norm_zero, Real.rpow_zero, one_mul]
        exact Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ => apply_nonneg _ _
      · simp [trivialTheory, trivialS_apply]
  real := by
    intro n f _
    simp only [trivialTheory, trivialS_apply]
    split_ifs <;> simp
  covariant := by
    intro R a n f _
    simp [trivialTheory, trivialS_apply]
  symmetric := by
    intro n f σ _
    simp [trivialTheory, trivialS_apply]
  reflectionPositive := by
    intro F _
    rw [rpForm_trivial]
    constructor
    · simp [Complex.mul_im, mul_comm]
    · simp only [Complex.mul_re, Complex.conj_re, Complex.conj_im]
      nlinarith [sq_nonneg F.vac.re, sq_nonneg F.vac.im]
  cluster := by
    intro A B _ _ a _ _
    have hconst : ∀ lam : ℝ,
        trivialTheory.S _ (reflectAppend ρ A (B.map (translate (lam • a)))) =
          trivialTheory.S _ (fun k => osReflect ρ (A.f (Fin.rev k))) *
            trivialTheory.S _ B.f := by
      intro lam
      simp only [trivialTheory]
      rw [trivialS_apply, trivialS_apply, trivialS_apply]
      simp only [Monomial.map, Nat.add_eq_zero_iff]
      by_cases hA : A.n = 0 <;> by_cases hB : B.n = 0 <;> simp [hA, hB]
    simp only [hconst]
    exact tendsto_const_nhds

theorem trivial_massGap (ρ : O4 →* Matrix ι ι ℝ) :
    HasMassGap ρ (trivialTheory (ι := ι)) 1 := by
  refine ⟨one_pos, fun F G _ _ t _ => ?_⟩
  rw [rpFormT_trivial]
  simp only [norm_zero]
  positivity

theorem trivial_not_nonTrivial (ρ : O4 →* Matrix ι ι ℝ) :
    ¬ NonTrivial ρ (trivialTheory (ι := ι)) := by
  rintro ⟨-, ⟨f, -, hf⟩, -⟩
  simp [trivialTheory, trivialS_apply] at hf

/-- Regression guard for the cluster axiom: non-zero spatial vectors exist, so `OS.Cluster`
is not vacuous. -/
theorem exists_spatial_ne_zero : ∃ a : E4, a ≠ 0 ∧ a 0 = 0 := by
  refine ⟨EuclideanSpace.single 1 1, fun h => ?_, by simp⟩
  have := congrArg (fun v : E4 => v 1) h
  simp at this

end Trivial

section Gibbs

variable {d : ℕ} {G : Type} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  [CompactSpace G] [MeasurableSpace G] [BorelSpace G] [SecondCountableTopology G]

lemma continuous_mat (P : GaugeGroup d G) : Continuous P.mat :=
  continuous_subtype_val.comp P.continuous

lemma continuous_wilsonAction (P : GaugeGroup d G) (L : ℕ) (β : ℝ) :
    Continuous (wilsonAction P β : GaugeConfig G L → ℝ) := by
  unfold wilsonAction
  refine continuous_const.mul (continuous_finsetSum _ fun x _ =>
    continuous_finsetSum _ fun μ _ => continuous_finsetSum _ fun ν _ => ?_)
  split_ifs
  · have hplaq : Continuous fun U : GaugeConfig G L => plaquette U x μ ν := by
      unfold plaquette
      fun_prop
    exact continuous_const.sub
      ((Complex.continuous_re.comp ((continuous_mat P).comp hplaq).matrix_trace).div_const _)
  · exact continuous_const

instance : IsProbabilityMeasure (haarG : Measure G) := by
  constructor
  have h := Measure.haarMeasure_self (K₀ := (⊤ : TopologicalSpace.PositiveCompacts G))
  simpa [haarG] using h

instance (L : ℕ) : IsProbabilityMeasure (linkMeasure G L) := by
  unfold linkMeasure
  infer_instance

lemma integrable_boltzmann (P : GaugeGroup d G) (L : ℕ) (β : ℝ) :
    Integrable (boltzmann P β : GaugeConfig G L → ℝ) (linkMeasure G L) := by
  have hc : Continuous (boltzmann P β : GaugeConfig G L → ℝ) :=
    Real.continuous_exp.comp (continuous_wilsonAction P L β).neg
  obtain ⟨C, hC⟩ := hc.norm.bddAbove_range_of_hasCompactSupport
    (HasCompactSupport.of_compactSpace _)
  exact Integrable.of_bound hc.aestronglyMeasurable C
    (Eventually.of_forall fun U => hC ⟨U, rfl⟩)

/-- The lattice partition function is strictly positive. -/
theorem partitionFn_pos (P : GaugeGroup d G) (L : ℕ) (β : ℝ) : 0 < partitionFn P L β := by
  unfold partitionFn
  rw [integral_pos_iff_support_of_nonneg (f := boltzmann P β)
    (fun U => (Real.exp_pos _).le) (integrable_boltzmann P L β)]
  have hsupp : Function.support (boltzmann P β : GaugeConfig G L → ℝ) = Set.univ :=
    Set.eq_univ_of_forall fun U => (Real.exp_pos _).ne'
  rw [hsupp, measure_univ]
  exact one_pos

/-- Gibbs expectations of constants are the constants (so `S₀ = 1` on the lattice). -/
theorem expect_const (P : GaugeGroup d G) (L : ℕ) (β : ℝ) (c : ℂ) :
    expect P L β (fun _ => c) = c := by
  unfold expect
  rw [integral_mul_const, integral_complex_ofReal]
  have : (partitionFn P L β : ℂ) ≠ 0 := by
    exact_mod_cast (partitionFn_pos P L β).ne'
  unfold partitionFn at this ⊢
  field_simp

end Gibbs

end YangMills
