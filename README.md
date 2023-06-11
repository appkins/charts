# Kubernetes Helm Charts

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![](https://github.com/appkins/charts/workflows/Release%20Charts/badge.svg?branch=main)](https://github.com/appkins/charts/actions)
[![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/appkins)](https://artifacthub.io/packages/search?repo=appkins)

These charts are provided as-is with no warranties.

## Usage

[Helm](https://helm.sh) must be installed to use the charts, please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```shell
helm repo add appkins https://appkins.github.io/helm-charts/
helm repo update
```

You can then run `helm search repo appkins` to see the charts.

## License

[MIT License](./LICENSE).
