# energyexplorer-datasets/fr-solar-installed-capacity

## Content

### density.tif

**Density of photovoltaic production capacity**

![preview](density-preview.png)

Direct download : https://energyexplorer.s3.fr-par.scw.cloud/density.b103ec05f71c1682706f5e9b1e022ec5abce55480040b5a8ad75d506e7e06dd0.tif

Unit: maximum installed production capacity, in kW / m2

Projection: Lambert-93

Source: [Registre national des installations de production et de stockage d'électricité (31/10/2022)](https://odre.opendatasoft.com/explore/dataset/registre-national-installation-production-stockage-electricite-agrege/information) / ODRÉ

## How to pull the large files?

The large files are stored outside this repository.

They are replaced by a ".DOWNLOAD_ME" file, containing the URL where you can download this file.

Once you have pulled the repository, you can retrieve all files by running the `./download.sh`.

To make this process automated after each pull, go to the root of your repository and run the following command: `H=.git/hooks/post-merge; echo -e '#!/bin/sh\nexec ./download.sh' > $H; chmod +x $H`

## Methodology

Methodology: see src/README.md

## License

Data: Licence Ouverte

Code: MIT