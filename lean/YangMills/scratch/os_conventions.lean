import YangMills

open YangMills
open scoped SchwartzMap

variable {ι : Type} [Fintype ι] [DecidableEq ι]

-- 1. The Euclidean action evaluates as documented: (g·f)(x) = ρ(R⁻¹)ᵀ f(R⁻¹(x - a)).
example (ρ : O4 →* Matrix ι ι ℝ) (R : O4) (a : E4) (f : TestFn ι) (x : E4) :
    euclid ρ R a f x = matCLM (ρ R⁻¹).transpose (f (R.symm (x - a))) := by
  rfl

-- 2. translate a f = f(· - a)
example (a : E4) (f : TestFn ι) (x : E4) : YangMills.translate a f x = f (x - a) := by
  rfl

-- 3. Time reflection sends e0 to -e0 and fixes vectors orthogonal to e0.
example : timeReflection e0 = -e0 := by
  unfold timeReflection
  simp [Submodule.reflection_orthogonalComplement_singleton_eq_neg]

#check @Submodule.reflection_orthogonalComplement_singleton_eq_neg
#check @Submodule.reflection_apply
