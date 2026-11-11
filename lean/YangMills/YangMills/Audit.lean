import YangMills

/-! Axiom audit. Expected: sanity theorems use only `propext`, `Classical.choice`,
`Quot.sound`; open problems additionally show `sorryAx`. -/

-- Fully proved sanity results (must NOT mention sorryAx)
#print axioms YangMills.trivial_osAxioms
#print axioms YangMills.trivial_massGap
#print axioms YangMills.trivial_not_nonTrivial
#print axioms YangMills.partitionFn_pos
#print axioms YangMills.expect_const
#print axioms YangMills.isCompact_specialUnitaryGroup
#print axioms YangMills.tensorRep

-- Open problems (sorryAx expected)
#print axioms YangMills.clay_yang_mills
#print axioms YangMills.su_yang_mills_exists
#print axioms YangMills.su_yang_mills_mass_gap
#print axioms YangMills.su_mass_gap_of_clay

-- Added after adversarial review
#print axioms YangMills.exists_spatial_ne_zero
#print axioms YangMills.existsWithMassGapFor_of_sun
#print axioms YangMills.clay_existence
#print axioms YangMills.os_nonTrivial_fullField_consistent

-- Non-vacuity (now fully proved)
#print axioms YangMills.su_connected
#print axioms YangMills.su_lieAlgebra_simple
#print axioms YangMills.suGauge_lieAlgebra
#print axioms YangMills.su_isSimple

-- Milestone ladder ordering (fully proved)
#print axioms YangMills.SUNExists.toM7b
#print axioms YangMills.SUNExistsM7b.toM7a
