# fr-solar-installed-capacity

## Content

### density.tif

Direct download : https://energyexplorer.s3.fr-par.scw.cloud/density.b103ec05f71c1682706f5e9b1e022ec5abce55480040b5a8ad75d506e7e06dd0.tif

**Density of photovoltaic production capacity**

![preview](density-preview.png)

Unit: maximum installed production capacity, in kW / m2

Projection: Lambert-93

Source: [Registre national des installations de production et de stockage d'électricité (31/10/2022)](https://odre.opendatasoft.com/explore/dataset/registre-national-installation-production-stockage-electricite-agrege/information) / ODRÉ

## Methodology

Methodology: see src/README.md

## .DOWNLOAD_ME files

The large files are stored outside this repository. They are replaced by a ".DOWNLOAD_ME" file containing their URL.

To easily retrieve all files at once, you can use the `./download.sh` utility from the [energyexplorer-datasets/common](https://github.com/energyexplorer-datasets/common) repository.

```
git clone https://github.com/energyexplorer-datasets/common.git
git clone https://github.com/energyexplorer-datasets/fr-solar-installed-capacity.git
cd fr-solar-installed-capacity
../common/download.sh
```

You can have the new or updated files automatically downloaded when you do a `git pull`. For that, add a hook to your git repository:
```
cd fr-solar-installed-capacity # if not already here
echo -e '#!/bin/sh\nexec ../common/download.sh' >> .git/hooks/post-merge
chmod +x .git/hooks/post-merge
```

## License

Data: Licence Ouverte

Code: MIT
