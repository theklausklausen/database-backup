# shared configuration

This configuration are used by the Makefile and by the CIs.

## Requirements

Required is a Bash CLI (e.g. Terminal on Unix, WSL on Windows)
and Docker.

## Usage

### Include to your project

Add this submodule with
`git submodule add --force https://git.fw.systems/infrastruktur/shared-configuration`

### Use Makefile

#### markdown-lint

`make -f shared-configuration/Makefile markdown-lint`

#### yaml-lint

`make -f shared-configuration/Makefile yaml-lint`

#### ansible-lint

`make -f shared-configuration/Makefile ansible-lint`

#### prettier

`make -f shared-configuration/Makefile prettier`

#### helm-lint

`make -f shared-configuration/Makefile helm-lint`

#### json-lint

`make -f shared-configuration/Makefile helm-lint`
