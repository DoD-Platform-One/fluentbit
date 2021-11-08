**Fluentbit Package Dependency Update a.b.c -> x.y.z**

Make the following updates to chart/Chart.yaml

- replace appVersion from a.b.c to x.y.z (1.8.6 -> 1.8.9)
- Change the version to the appropriate upstream version corresponding to appVersion x.y.z (0.19.3 for 1.8.9) and apeend `-bb.n` to it (n is a unique number for this version)
- Update the description in annotations (e.g. Replace “Update image version to va.b.c” with “Update image version to vx.y.z”)

Make the following updates to chart/values.yaml

- Update tag from a.b.c to x.y.z (1.8.6 -> 1.8.9)

Run the following command

- `git add . && git commit -m “Updated the version from a.b.c to x.y.z”`
- `kpt pkg update chart/@fluent-bit-0.19.3 --strategy alpha-git-patch` (0.19.3 for 1.8.9)