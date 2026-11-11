# scratch/ — review artefacts (not part of the Lean library)

These files were written by AI reviewer and prover agents during the work described in the paper.
They are kept as provenance; they are not imported by the `YangMills` library.

* `JL_*`, `RT_*`, `ClusterZero.lean`, `Verify_*`, `GapLens*`, `ZProjection.lean`, `CL*`, `LAT1_verify.lean`,
  `ClayLens_*`, `growth_fix.lean`, `verify_*`, `os_conventions.lean`, `LatticeLens.lean`, `lat2_verify.lean`:
  adversarial-review files against statement **v0.1**. Several of them (e.g. `RT_All.lean`,
  `JL_ClusterCollapse.lean`) proved that v0.1's cluster axiom collapsed the OS Hilbert space; after
  the fix in v0.2 they **intentionally no longer compile** (this is the regression test).
* `nv_lie.lean`, `nv_simple.lean`, `nv_connected.lean`: the original non-vacuity proofs, now moved
  into `YangMills/NonVacuity/`.
