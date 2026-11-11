import YangMills
open YangMills MeasureTheory Filter Topology

noncomputable section
namespace YangMills.CL3

variable {d : ℕ} {G : Type} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  [CompactSpace G] [MeasurableSpace G] [BorelSpace G]

/-- Pointwise action of a real matrix on a test function. -/
abbrev pc (M : Matrix ι4 ι4 ℝ) : TestFn ι4 →L[ℂ] TestFn ι4 :=
  SchwartzMap.postcompCLM (matCLM M)

lemma pc_apply (M : Matrix ι4 ι4 ℝ) (f : TestFn ι4) (x : E4) (l : ι4) :
    (pc M f) x l = ∑ i, (M l i : ℂ) * f x i := by
  simp [pc, SchwartzMap.postcompCLM_apply, matCLM, Matrix.mulVec, dotProduct]

lemma smearedField_mul (P : GaugeGroup d G) (L : ℕ) (a β : ℝ) (M Z : Matrix ι4 ι4 ℝ)
    (f : TestFn ι4) (U : GaugeConfig G L) :
    smearedField P L a β (M.transpose * Z) f U = smearedField P L a β Z (pc M f) U := by
  unfold smearedField
  apply congrArg (fun s => ((a ^ 4 : ℝ) : ℂ) * s)
  refine Finset.sum_congr rfl fun x _ => ?_
  simp only [pc_apply, Matrix.mul_apply, Matrix.transpose_apply, Complex.ofReal_sum,
    Complex.ofReal_mul, Finset.sum_mul, Finset.mul_sum]
  conv_lhs => enter [2, x1]; rw [Finset.sum_comm]
  rw [Finset.sum_comm]
  conv_rhs => enter [2, x1]; rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun r _ => Finset.sum_congr rfl fun p _ =>
    Finset.sum_congr rfl fun q _ => ?_
  ring

/-- The "channel-projected" theory `S_M(f₁,…,fₙ) = S(M f₁,…,M fₙ)`. -/
def compM (S : Schwinger ι4) (M : Matrix ι4 ι4 ℝ) : Schwinger ι4 :=
  ⟨fun n => (S.S n).compContinuousLinearMap (fun _ => pc M)⟩

lemma tsupport_pc_subset (M : Matrix ι4 ι4 ℝ) (f : TestFn ι4) :
    tsupport (pc M f : E4 → ι4 → ℂ) ⊆ tsupport (f : E4 → ι4 → ℂ) := by
  apply closure_mono
  intro x hx
  by_contra h
  apply hx
  have h0 : f x = 0 := by simpa using h
  funext l
  simp [pc_apply, h0]

/-- **Key fact behind CL-3.** If `S` is a Wilson limit, so is its projection onto ANY
sub-channel `M` (with renormalizations `Mᵀ Z_k`). In particular, from a genuine full-field
witness one obtains a witness for the lattice clause that keeps a single scalar channel. -/
theorem isWilsonLimit_compM (P : GaugeGroup d G) (S : Schwinger ι4) (a β : ℕ → ℝ)
    (M : Matrix ι4 ι4 ℝ) (h : IsWilsonLimit P S a β) : IsWilsonLimit P (compM S M) a β := by
  obtain ⟨L, Z, ha, ha0, hvol, hβ, hlim⟩ := h
  refine ⟨L, fun k => M.transpose * Z k, ha, ha0, hvol, hβ, fun n f hc hd => ?_⟩
  have hc' : ∀ k, HasCompactSupport (pc M (f k) : E4 → ι4 → ℂ) := fun k =>
    IsCompact.of_isClosed_subset (hc k) (isClosed_tsupport _) (tsupport_pc_subset M (f k))
  have hd' : DisjointSupports (fun k => pc M (f k)) := fun i j hij =>
    (hd hij).mono (tsupport_pc_subset M (f i)) (tsupport_pc_subset M (f j))
  have := hlim n (fun k => pc M (f k)) hc' hd'
  simpa [compM, latticeSchwinger, smearedField_mul] using this

/-- Rank-one `Z = u wᵀ`: the smeared lattice field depends on the test function only through
the single scalar channel `⟨u, f⟩` (labels of `S` need not be `tr F_{μν}F_{κλ}` either:
`u` is arbitrary, e.g. `u = δ_{μν}δ_{κλ}` lives outside the `tr FF` index-symmetry space). -/
lemma smearedField_rankOne (P : GaugeGroup d G) (L : ℕ) (a β : ℝ) (u w : ι4 → ℝ)
    (f : TestFn ι4) (U : GaugeConfig G L) :
    smearedField P L a β (Matrix.vecMulVec u w) f U =
      ((a ^ 4 : ℝ) : ℂ) * ∑ x : Site L, (∑ i, f (sitePos L a x) i * (u i : ℂ)) *
        ∑ j, (w j : ℂ) * ((latticeT P U x j : ℂ) - expect P L β (fun V => (latticeT P V x j : ℂ))) := by
  unfold smearedField
  apply congrArg (fun s => ((a ^ 4 : ℝ) : ℂ) * s)
  refine Finset.sum_congr rfl fun x _ => ?_
  simp only [Matrix.vecMulVec_apply, Complex.ofReal_mul, Finset.sum_mul, Finset.mul_sum]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  ring

end YangMills.CL3
end

#print axioms YangMills.CL3.isWilsonLimit_compM
#print axioms YangMills.CL3.smearedField_rankOne
