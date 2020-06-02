# Release notes TFGrid 2.0.6 beta

TFGrid 2.0.6 beta is a minor release which is focus on bug fixing and stability improvement.

## NEW
  - 3sdk improvements:
     - `--version` subcommand to see currently installed version
     - `update` subcommand to update to latest codebase
     - building locally builds with current version
     - `3sdk container` simplified in non-expert mode to `3sdk threebot` and `3sdk simulator`
     - show progress when starting a container 
     - simulator browser starting
     - 3sdk specify branch
  -  admin panel improvements:
     - scrollbar in sidebar
     - more intuitive UI for deployed solutions
     - notifications about new 3sdk version availability
     - ability to delete wallets
     - ability to change farm location from farmmanagement
 - chatflows improvements:
    - STATEFULL chatflows:
        - pick up where a chatflow was last left
        - go back and forth within a chatflow
    - gitea solution chatflow
    - split-up of bill about what is to be paid
    - expose solution with custom domains
    - added showing loading of payment and deployment with the remaining time until it expires
    - show error on payment or deployment failure
    - cancel deployments if payment or deployments expire
    - give summary of all components that will be deployed for a solution
    - ensure dates in chatflows start from present
    - pressing enter goes to next action instead of restarting chatflow
    - ensure non-duplicate network names
    - more informative error messages
    - port is shown in 'deployed solutions' after flist reservation 
  - package management streamlining:
    - harden logic pertaining package.toml to indicate missing or invalid toml
  - improve docs and provide more tutorials

 - bugs fixed:
  - mixing of `--expert` and non-expert mode issues fixed 
  - 3bot restart issues
  - delete specific schema and remove it from cache
  - resetting name error
  - the total amount deducted is exactly as  paid to  farmer
  - 3sdk to only kill ssh-agent of current user
  - adding administrators from admin panel
  - admin panel not showing all of deployed solutions
  - flist deploy uses hru instead of mru
  - secret can contain any special characters

## Component versions

- Jumpscale/SDK: `10.6`
  - [Github project](https://github.com/orgs/threefoldtech/projects/88)
  - [Jumpscale release notes](https://github.com/threefoldtech/jumpscaleX_core/releases/tag/v10.6)
- 0-OS v2:`0.3.1`: TODO, CHANGE LINKS BELOW
  - [Github project](https://github.com/orgs/threefoldtech/projects/87)
  - [0-OS release notes](https://github.com/threefoldtech/zos/releases/tag/v0.3.1)
  - [tfexplorer release notes](https://github.com/threefoldtech/tfexplorer/releases/tag/v0.3.0)

### 3SDK binaries

- Linux: [3sdk_v10.6_linux_x86_64](https://github.com/threefoldtech/jumpscaleX_core/releases/download/v10.6/3sdk_v10.6_linux_x86_64)
- MacOS: [3sdk_v10.6_darwin_x86_64](https://github.com/threefoldtech/jumpscaleX_core/releases/download/v10.6/3sdk_v10.6_darwin_x86_64)
- Windows: [3sdk_v10.6_windows](https://github.com/threefoldtech/jumpscaleX_core/releases/download/v10.6/3sdk_v10.6_windows.exe)

## Known issues

- Impossible to extend or modify a reservation. Will be resolved in 2.1 which releases later this month
- Improve installer experience


## Roadmap see

- [Roadmap](info:roadmap.md)
