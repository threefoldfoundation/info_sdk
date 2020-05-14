# Release notes TFGrid 2.0.5 beta

TFGrid 2.0.5 beta is a minor release which is focus on bug fixing and stability improvement.

We have received quite a lot of feedback from the field regarding difficulty of installation and confusion around how identity works.
These concerned have been addressed, documentation improved and 3sdk CLI tool simplified.

TODO: add more detail about all the improvement made @rkhamis @grimpy

## Component versions

- Jumpscale/SDK: `10.5.3`
  - [Github project](https://github.com/orgs/threefoldtech/projects/77)
  - [Jumpscale core release notes](https://github.com/threefoldtech/jumpscaleX_core/releases/tag/v10.5.3)
  - [Jumpscale libs release notes](https://github.com/threefoldtech/jumpscaleX_libs/releases/tag/v10.5.3)
  - [Jumpscale libs extra release notes](https://github.com/threefoldtech/jumpscaleX_libs_extra/releases/tag/v10.5.3)
  - [Jumpscale threebot release notes](https://github.com/threefoldtech/jumpscaleX_threebot/releases/tag/v10.5.3)
  - [Jumpscale builders release notes](https://github.com/threefoldtech/jumpscaleX_builders/releases/tag/v10.5.3)
- 0-OS v2:`0.3.1`
  - [Github project](https://github.com/orgs/threefoldtech/projects/87)
  - [0-OS release notes](https://github.com/threefoldtech/zos/releases/tag/v0.3.1)
  - [tfexplorer release notes](https://github.com/threefoldtech/tfexplorer/releases/tag/v0.2.6)

## Known issues

- Impossible to extend or modify a reservation. Research to allow it is ongoing at https://github.com/threefoldtech/tfexplorer/pull/64