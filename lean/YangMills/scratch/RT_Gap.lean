import YangMills

open Filter Topology

namespace YangMills

variable {ι : Type} [Fintype ι] [DecidableEq ι]
set_option linter.unusedSectionVars false

example (a : E4) (f : TestFn ι) (x : E4) : translate a f x = f (x - a) := by
  simp [translate]

lemma tsupport_translate (a : E4) (f : TestFn ι) :
    tsupport (translate a f : E4 → ι → ℂ) = (fun x => x - a) ⁻¹' tsupport (f : E4 → ι → ℂ) := by
  have : (translate a f : E4 → ι → ℂ) = (f : E4 → ι → ℂ) ∘ (Homeomorph.subRight a) := by
    funext x; simp [translate]
  rw [this, tsupport_comp_eq_preimage]
  rfl

lemma e0_smul_zero (t : ℝ) : (t • e0) 0 = t := by simp [e0]

lemma Monomial.orderedPositive_translate (A : Monomial ι) (hA : A.OrderedPositive)
    (t : ℝ) (ht : 0 ≤ t) : (A.map (translate (t • e0))).OrderedPositive := by
  obtain ⟨τ, h0, hmono, hsupp⟩ := hA
  refine ⟨fun k => if k = 0 then 0 else τ k + t, by simp, ?_, ?_⟩
  · intro i j hij
    have hτpos : ∀ k : Fin (A.n + 1), k ≠ 0 → 0 < τ k := fun k hk => by
      have : τ 0 < τ k := hmono (Fin.pos_iff_ne_zero.mpr hk)
      linarith
    by_cases hi : i = 0
    · have hj : j ≠ 0 := by rintro rfl; exact absurd hij (by simp [hi])
      simp only [hi, hj, ite_true, ite_false]
      linarith [hτpos j hj]
    · have hj : j ≠ 0 := by
        rintro rfl; exact absurd hij (by simp)
      simp only [hi, hj, ite_false]
      linarith [hmono hij]
  · intro (k : Fin A.n) x hx
    show (if k.castSucc = 0 then (0:ℝ) else τ k.castSucc + t) < x 0 ∧
      x 0 < (if k.succ = 0 then (0:ℝ) else τ k.succ + t)
    simp only [Monomial.map] at hx
    rw [tsupport_translate] at hx
    obtain ⟨h1, h2⟩ := hsupp k _ hx
    have hx0 : (x - t • e0) 0 = x 0 - t := by simp [e0]
    rw [hx0] at h1 h2
    have hs : k.succ ≠ 0 := Fin.succ_ne_zero k
    simp only [hs, ite_false]
    refine ⟨?_, by linarith⟩
    by_cases hk : k.castSucc = 0
    · simp only [hk, ite_true]
      have : τ k.castSucc = 0 := by rw [hk]; exact h0
      linarith
    · simp only [hk, ite_false]; linarith

lemma Poly.orderedPositive_translate (G : Poly ι) (hG : G.OrderedPositive)
    (t : ℝ) (ht : 0 ≤ t) : (G.map (translate (t • e0))).OrderedPositive :=
  fun j => Monomial.orderedPositive_translate _ (hG j) t ht

end YangMills
