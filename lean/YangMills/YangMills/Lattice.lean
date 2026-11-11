import YangMills.OS

/-!
# Wilson's lattice Yang–Mills theory and the continuum limit

Definitions only. This file pins down *which* Euclidean field theory counts as "quantum
Yang–Mills theory with gauge group `G`": the continuum limit (lattice spacing `a → 0`,
volume → ∞, bare coupling `g₀ → 0`, i.e. `β → ∞`) of Wilson's lattice gauge theory, observed
through the gauge-invariant local composite fields

  `T_{μνκλ}(x) = tr F_{μν}(x) F_{κλ}(x)`

(256 index components spanning the 21-dimensional space of tensors with the symmetries of
`tr F_{μν}F_{κλ}`; they include `tr F²`, `tr F F̃` and the energy-momentum tensor), with an
arbitrary cutoff-dependent renormalization: a matrix `Z_k` mixing these fields (valued in the
21-dimensional space), plus subtraction of the vacuum expectation value. `latticeT` is
dimensionless, `≈ a⁴ g₀² tr F F`, so a non-trivial limit forces `‖Z_k‖ → ∞` like
`a_k⁻⁴ g₀⁻²` up to logarithms (anomalous dimensions); `Z_k` is *not* a finite renormalization. The continuum Schwinger functions are required
to be limits of the lattice ones for compactly supported test functions with pairwise
disjoint supports (away from contact terms).

Gauge group: a compact topological group `G` with a faithful continuous unitary
representation `π : G → U(d)`; the Wilson action is
`S(U) = β ∑_{plaquettes} (1 - Re tr π(U_p) / d)`.
-/

noncomputable section

open MeasureTheory Filter Topology
open scoped SchwartzMap

namespace YangMills

/-! ## Gauge groups -/

/-- A compact matrix gauge group: a faithful continuous unitary representation
`π : G → U(d)` of a topological group `G`. -/
structure GaugeGroup (d : ℕ) (G : Type) [Group G] [TopologicalSpace G] where
  /-- The defining representation. -/
  π : G →* Matrix.unitaryGroup (Fin d) ℂ
  continuous : Continuous π
  injective : Function.Injective π

variable {d : ℕ} {G : Type} [Group G] [TopologicalSpace G]

/-- The matrix of `π g`. -/
def GaugeGroup.mat (P : GaugeGroup d G) (g : G) : Matrix (Fin d) (Fin d) ℂ := (P.π g : _)

/-- The (real) Lie algebra of the matrix group `π(G)`:
`𝔤 = {X | exp(t X) ∈ π(G) for all t ∈ ℝ}`. -/
def GaugeGroup.lieAlgebra (P : GaugeGroup d G) : Set (Matrix (Fin d) (Fin d) ℂ) :=
  {X | ∀ t : ℝ, ∃ g : G, P.mat g = NormedSpace.exp ((t : ℂ) • X)}

/-- A set of matrices is a *simple real Lie algebra*: it is non-abelian and its only ideals
(real subspaces `I ⊆ 𝔤` with `[𝔤, I] ⊆ I`) are `0` and `𝔤`. -/
def IsSimpleMatrixLieAlgebra {n : Type} [Fintype n] [DecidableEq n]
    (𝔤 : Set (Matrix n n ℂ)) : Prop :=
  (∃ X ∈ 𝔤, ∃ Y ∈ 𝔤, X * Y - Y * X ≠ 0) ∧
  ∀ I : Submodule ℝ (Matrix n n ℂ), (I : Set (Matrix n n ℂ)) ⊆ 𝔤 →
    (∀ X ∈ 𝔤, ∀ Y ∈ I, X * Y - Y * X ∈ I) → I = ⊥ ∨ (I : Set (Matrix n n ℂ)) = 𝔤

/-! ## The periodic lattice -/

/-- Sites of the periodic lattice `(ℤ/(L+1)ℤ)⁴`. -/
abbrev Site (L : ℕ) : Type := Fin 4 → ZMod (L + 1)

/-- Oriented links `(x, μ)` from `x` to `x + e_μ`. -/
abbrev Link (L : ℕ) : Type := Site L × Fin 4

/-- Lattice gauge fields: one group element per link. -/
abbrev GaugeConfig (G : Type) (L : ℕ) : Type := Link L → G

/-- Lattice unit vector. -/
def unitVec {L : ℕ} (μ : Fin 4) : Site L := Pi.single μ 1

/-- The plaquette variable `U_{μν}(x) = U(x,μ) U(x+μ,ν) U(x+ν,μ)⁻¹ U(x,ν)⁻¹`. -/
def plaquette {L : ℕ} (U : GaugeConfig G L) (x : Site L) (μ ν : Fin 4) : G :=
  U (x, μ) * U (x + unitVec μ, ν) * (U (x + unitVec ν, μ))⁻¹ * (U (x, ν))⁻¹

/-- Wilson's action `S(U) = β ∑_x ∑_{μ<ν} (1 - Re tr π(U_{μν}(x)) / d)`. -/
def wilsonAction (P : GaugeGroup d G) {L : ℕ} (β : ℝ) (U : GaugeConfig G L) : ℝ :=
  β * ∑ x : Site L, ∑ μ : Fin 4, ∑ ν : Fin 4,
    if μ < ν then 1 - (Matrix.trace (P.mat (plaquette U x μ ν))).re / d else 0

/-! ## The lattice Gibbs measure -/

section Measure

variable [IsTopologicalGroup G] [CompactSpace G] [MeasurableSpace G] [BorelSpace G]

/-- Normalized Haar measure on the compact group `G`. -/
def haarG : Measure G := Measure.haarMeasure ⊤

/-- Product Haar measure on lattice gauge fields. -/
def linkMeasure (G : Type) [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    [CompactSpace G] [MeasurableSpace G] [BorelSpace G] (L : ℕ) : Measure (GaugeConfig G L) :=
  Measure.pi fun _ : Link L => (haarG : Measure G)

/-- Boltzmann weight `e^{-S(U)}`. -/
def boltzmann (P : GaugeGroup d G) {L : ℕ} (β : ℝ) (U : GaugeConfig G L) : ℝ :=
  Real.exp (-wilsonAction P β U)

/-- Partition function `Z = ∫ e^{-S(U)} dU`. -/
def partitionFn (P : GaugeGroup d G) (L : ℕ) (β : ℝ) : ℝ :=
  ∫ U, boltzmann P β U ∂(linkMeasure G L)

/-- Gibbs expectation `⟨O⟩ = Z⁻¹ ∫ O(U) e^{-S(U)} dU`. -/
def expect (P : GaugeGroup d G) (L : ℕ) (β : ℝ) (O : GaugeConfig G L → ℂ) : ℂ :=
  (∫ U, (boltzmann P β U : ℂ) * O U ∂(linkMeasure G L)) / (partitionFn P L β : ℂ)

end Measure

/-! ## Lattice composite fields -/

/-- Lattice field strength (up to normalization `a² g₀`): the traceless Hermitian part of
`(U_{μν} - U_{μν}†) / 2i`. -/
def fieldStrength (P : GaugeGroup d G) {L : ℕ} (U : GaugeConfig G L) (x : Site L)
    (μ ν : Fin 4) : Matrix (Fin d) (Fin d) ℂ :=
  let W := P.mat (plaquette U x μ ν)
  let A := (2 * Complex.I)⁻¹ • (W - W.conjTranspose)
  A - (Matrix.trace A / d) • (1 : Matrix (Fin d) (Fin d) ℂ)

/-- Index set of the fields `T_{μνκλ}`. -/
abbrev ι4 : Type := ((Fin 4 × Fin 4) × Fin 4) × Fin 4

/-- The lattice composite fields `T_{μνκλ}(x) = Re tr F_{μν}(x) F_{κλ}(x)`. -/
def latticeT (P : GaugeGroup d G) {L : ℕ} (U : GaugeConfig G L) (x : Site L) (i : ι4) : ℝ :=
  (Matrix.trace (fieldStrength P U x i.1.1.1 i.1.1.2 * fieldStrength P U x i.1.2 i.2)).re

/-- The 21-dimensional space of index tensors with the symmetries of `tr F_{μν}F_{κλ}`:
antisymmetric in `μν` and in `κλ`, symmetric under exchange of the pairs. -/
def TFFSpace : Set (ι4 → ℝ) :=
  {v | ∀ μ ν κ l : Fin 4, v (((μ, ν), κ), l) = -v (((ν, μ), κ), l) ∧
    v (((μ, ν), κ), l) = -v (((μ, ν), l), κ) ∧ v (((μ, ν), κ), l) = v (((κ, l), μ), ν)}

/-! ## O(4) acts on `T` by the fourth tensor power of the vector representation -/

/-- Matrix of `R ∈ O(4)` in the standard basis. -/
def o4Matrix (R : O4) : Matrix (Fin 4) (Fin 4) ℝ :=
  LinearMap.toMatrix (EuclideanSpace.basisFun (Fin 4) ℝ).toBasis
    (EuclideanSpace.basisFun (Fin 4) ℝ).toBasis R.toLinearMap

lemma o4Matrix_mul (R S : O4) : o4Matrix (R * S) = o4Matrix R * o4Matrix S := by
  unfold o4Matrix
  rw [← LinearMap.toMatrix_mul]
  rfl

lemma o4Matrix_one : o4Matrix 1 = 1 := by
  unfold o4Matrix
  exact LinearMap.toMatrix_one _

/-- The tensor representation `R ↦ R ⊗ R ⊗ R ⊗ R` of `O(4)` on the components of `T`. -/
def tensorRep : O4 →* Matrix ι4 ι4 ℝ where
  toFun R := Matrix.kroneckerMap (· * ·) (Matrix.kroneckerMap (· * ·)
    (Matrix.kroneckerMap (· * ·) (o4Matrix R) (o4Matrix R)) (o4Matrix R)) (o4Matrix R)
  map_one' := by simp [o4Matrix_one, Matrix.one_kronecker_one]
  map_mul' R S := by simp [o4Matrix_mul, Matrix.mul_kronecker_mul]

/-! ## Smeared lattice fields and the continuum limit -/

/-- Physical position of a lattice site, using representatives in `(-L/2, L/2]`. -/
def sitePos (L : ℕ) (a : ℝ) (x : Site L) : E4 :=
  (EuclideanSpace.equiv (Fin 4) ℝ).symm fun μ => a * ((x μ).valMinAbs : ℝ)

section Limit

variable [IsTopologicalGroup G] [CompactSpace G] [MeasurableSpace G] [BorelSpace G]

/-- The renormalized, smeared lattice field
`φ_a(f) = a⁴ ∑_x ∑_i f_i(a x) ∑_j Z_{ij} (T_j(x) - ⟨T_j(x)⟩)`. -/
def smearedField (P : GaugeGroup d G) (L : ℕ) (a β : ℝ) (Z : Matrix ι4 ι4 ℝ)
    (f : TestFn ι4) (U : GaugeConfig G L) : ℂ :=
  ((a ^ 4 : ℝ) : ℂ) * ∑ x : Site L, ∑ i : ι4, f (sitePos L a x) i *
    ∑ j : ι4, (Z i j : ℂ) *
      ((latticeT P U x j : ℂ) - expect P L β (fun V => (latticeT P V x j : ℂ)))

/-- Lattice Schwinger functions `⟨φ_a(f₁) ⋯ φ_a(fₙ)⟩`. -/
def latticeSchwinger (P : GaugeGroup d G) (L : ℕ) (a β : ℝ) (Z : Matrix ι4 ι4 ℝ)
    (n : ℕ) (f : Fin n → TestFn ι4) : ℂ :=
  expect P L β fun U => ∏ k, smearedField P L a β Z (f k) U

/-- `S` is a continuum limit of Wilson lattice gauge theory with gauge group `P`: along some
sequence of lattice spacings `a_k → 0`, lattice sizes with `a_k (L_k+1) → ∞`, inverse bare
couplings `β_k → ∞` and (necessarily divergent) renormalization matrices `Z_k` whose output
lies in the space of `tr F F`-type tensors, the lattice Schwinger functions of the fields `T`
converge to `S` on compactly supported test functions with disjoint supports. -/
def IsWilsonLimit (P : GaugeGroup d G) (S : Schwinger ι4) (a β : ℕ → ℝ) : Prop :=
  ∃ (L : ℕ → ℕ) (Z : ℕ → Matrix ι4 ι4 ℝ),
    (∀ k j, (fun i => Z k i j) ∈ TFFSpace) ∧
    (∀ k, 0 < a k) ∧ Tendsto a atTop (𝓝 0) ∧
    Tendsto (fun k => a k * ((L k : ℝ) + 1)) atTop atTop ∧
    Tendsto β atTop atTop ∧
    ∀ (n : ℕ) (f : Fin n → TestFn ι4),
      (∀ k, HasCompactSupport (f k : E4 → ι4 → ℂ)) → DisjointSupports f →
      Tendsto (fun k => latticeSchwinger P (L k) (a k) (β k) (Z k) n f) atTop (𝓝 (S.S n f))

end Limit

end YangMills
