# Building the dataset

## density.tif

**Density of photovoltaic production capacity, in kWc / m2**

Download the [registry of production facilities](https://odre.opendatasoft.com/explore/dataset/registre-national-installation-production-stockage-electricite-agrege/information)

Save it as `registre-national-installation-production-stockage-electricite-agrege.csv`

Run `python3 aggregate-capacity.py`

Iterate production facilities. Keep only photovoltaic facilities. Assign them to the smallest possible geographical feature. Sum the power of facilies for each feature.

Run `find . -name 'plot-*.py' | xargs -n1 python3`

For each geographical layer, we set POWER and POWER_DENSITY for each known feature. POWER_DENSITY is the sum of facilities into each unit (max production power - kW), divided by the area of the feature (m2). For this to work, we need a low-distortion projection, with distances exprimed in meters.

Run `./merge.sh`

Convert vector maps to raster, for each layer. Create a single raster, additionning the values of every layers.