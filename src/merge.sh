
FRANCE_AREA=552000000 # m2
UNLOCATED_POWER=$(cat capacity-aggregated.csv | grep unlocated | cut -d',' -f3 | tr -d $'\r')
UNLOCATED_DENSITY=$(echo $UNLOCATED_POWER/$FRANCE_AREA | bc -l)
echo $UNLOCATED_DENSITY
gdal_rasterize -burn $UNLOCATED_DENSITY -init 0 -ot Float32 -a_srs EPSG:2154 -tr 100 100 ../../fr-boundaries/france-geojson-metropole-lambert.geojson density-unlocated.tif

RASTERIZE="gdal_rasterize -a POWER_DENSITY -init 0 -ot Float32 -a_srs EPSG:2154 -tr 100 100"

$RASTERIZE capacity-iris.gpkg density-iris.tif
$RASTERIZE capacity-insee.gpkg density-insee.tif
$RASTERIZE capacity-epci.gpkg density-epci.tif
$RASTERIZE capacity-departements.gpkg density-departements.tif
$RASTERIZE capacity-regions.gpkg density-regions.tif

gdal_calc.py --calc="A+B+C+D+E+F" \
-A density-unlocated.tif \
-B density-iris.tif \
-C density-insee.tif \
-D density-epci.tif \
-E density-departements.tif \
-F density-regions.tif \
--outfile=../density.tif \
--extent=intersect # --extent needs version >= 3.3