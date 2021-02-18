# Release notes TF Grid 2.0.6 beta

TF Grid 2.0.6 beta is a minor release which is focus on bug fixing and stability improvement.

## Change log

### 3SDK

#### 3sdk improvements

- `--version` subcommand to see currently installed version
- `update` subcommand to update to latest codebase
- Building locally builds with current version
- `3sdk container` simplified in non-expert mode to `3sdk threebot` and `3sdk simulator`
- Show progress when starting a container
- Simulator browser starting
- 3sdk specify branch

#### Admin panel improvements

- Scrollbar in sidebar
- More intuitive UI for deployed solutions
- Notifications about new 3sdk version availability
- Ability to delete wallets
- Ability to change farm location from farm management dashboard

#### Chatflows improvements

- Stateful chatflows:
- Pick up where a chatflow was last left
- Go back and forth within a chatflow
- Gitea solution chatflow
- Split-up of bill about what is to be paid
- Expose solution with custom domains
- Added showing loading of payment and deployment with the remaining Time until it expires
- Show error on payment or deployment failure
- couldcel deployments if payment or deployments expire
- Give summary of all components that will be deployed for a Solution
- Ensure dates in chatflows start from present
- Pressing enter goes to next action instead of restarting chatflow
- Ensure non-duplicate network names
- More informative error messages
- Port is shown in 'deployed solutions' after Flist reservation

#### Package management streamlining

- Harden logic pertaining package.toml to indicate missing or invalid toml

#### Documentation

- Improve docs and provide more tutorials

#### Bugs fixed

- Mixing of `--expert` and non-expert mode issues fixed
- 3Bot restart issues
- Delete specific schema and remove it from cache
- Resetting name error
- The total amount deducted is exactly as paid to farmer
- 3sdk to only kill ssh-agent of current user
- Adding administrators from admin panel
- Admin panel not showing all of deployed solutions
- Flist deploy uses hru instead of mru
- Secret could contain any special characters

### Zero-OS

- You could now configure the size and type of the root filesystem of the containers
- Better report of the node health
- Report of the network configuration of a node to the farmer

### TFExplorer

- The node marked as free to use could now also be paid in other currencies. This should help resorbed the split in the network created by the different currencies to be used to reserve capacity.

## Component versions

- Jumpscale/SDK: `10.6`
- [Github project](https://github.com/orgs/Threefoldtech/projects/88)
- [Jumpscale release notes](https://github.com/Threefoldtech/jumpscaleX_core/releases/tag/v10.6)
- Zero-OS v2:`0.3.3`:
- [Github project](https://github.com/orgs/Threefoldtech/projects/89)
- [Zero-OS release notes](https://github.com/Threefoldtech/zos/releases/tag/v0.3.3)
- [tfexplorer release notes](https://github.com/Threefoldtech/tfexplorer/releases/tag/v0.3.1)

### 3SDK binaries

- Linux: [3sdk_v10.6_linux_x86_64](https://github.com/Threefoldtech/jumpscaleX_core/releases/download/v10.6/3sdk_v10.6_linux_x86_64)
- MacOS: [3sdk_v10.6_darwin_x86_64](https://github.com/Threefoldtech/jumpscaleX_core/releases/download/v10.6/3sdk_v10.6_darwin_x86_64)
- Windows: [3sdk_v10.6_windows](https://github.com/Threefoldtech/jumpscaleX_core/releases/download/v10.6/3sdk_v10.6_windows.exe)

## Known issues

- Impossible to extend or modify a reservation. Will be resolved in 2.1 which releases later this month. You could checkout the specification at https://github.com/Threefoldtech/tfexplorer/blob/master/specs/modify_IT_contract_over_time.md
- Improve installer experience