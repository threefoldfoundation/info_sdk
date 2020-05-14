# Release notes TFGrid 2.0.5 beta

TFGrid 2.0.5 beta is a minor release which is focus on bug fixing and stability improvement.

We have received quite a lot of feedback from the field regarding difficulty of installation and confusion around how identity works.
These concerned have been addressed, documentation improved and 3sdk CLI tool simplified.

- streamlined installation for normal and expert modes across all supported platforms
- better visualization of reservations in chatflows and admin panel
- admin panel components more defensive to help users reach successful reservations
- customized views for solutions for easier management
- step-by-step tutorials A new section has been created into the manual specially for this: [tutorials](getting_started_tutorials)

## Component versions

- Jumpscale/SDK: `10.5.3`
  - [Github project](https://github.com/orgs/threefoldtech/projects/77)
  - [Jumpscale release notes](https://github.com/threefoldtech/jumpscaleX_core/releases/tag/v10.5.3)
- 0-OS v2:`0.3.1`
  - [Github project](https://github.com/orgs/threefoldtech/projects/87)
  - [0-OS release notes](https://github.com/threefoldtech/zos/releases/tag/v0.3.1)
  - [tfexplorer release notes](https://github.com/threefoldtech/tfexplorer/releases/tag/v0.3.0)

### 3SDK binaries

- [linux](https://github.com/threefoldtech/jumpscaleX_core/releases/download/v10.5.3/3sdk_v10.5.3_linux_x86_64)
- [macOS](https://github.com/threefoldtech/jumpscaleX_core/releases/download/v10.5.3/3sdk_v10.5.3_darwin_x86_64)
- [windows](https://github.com/threefoldtech/jumpscaleX_core/releases/download/v10.5.3/3sdk_v10.5.3_windows.exe)

## Known issues

- Impossible to extend or modify a reservation. Research to allow it is ongoing at https://github.com/threefoldtech/tfexplorer/pull/64
- Improve installer experience
- Inability to go back in chatflows
