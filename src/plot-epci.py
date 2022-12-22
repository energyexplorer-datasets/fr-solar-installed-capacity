from osgeo import ogr
import shutil
import csv

sites = {}

with open('capacity-aggregated.csv') as file:
    csv_reader = csv.DictReader(file)
    for facility in csv_reader:
        if facility['site_type'] != 'epci':
            continue
        else:
            sites[facility['site_code']] = float(facility['power'])

    input = '../../fr-boundaries/epci.gpkg'
    output = 'capacity-epci.gpkg'

    shutil.copy(input, output)

    driver = ogr.GetDriverByName("GPKG")
    dataSource = driver.Open(output, 1)
    layer = dataSource.GetLayer()
    power_field = ogr.FieldDefn("POWER", ogr.OFTReal)
    power_density_field = ogr.FieldDefn("POWER_DENSITY", ogr.OFTReal)
    layer.CreateField(power_field)
    layer.CreateField(power_density_field)

    for feature in layer:
        code = feature.GetField('CODE_SIREN')
        #print(code)
        if not code in sites:
            continue
        power = sites[code]
        geom = feature.GetGeometryRef()
        area = geom.GetArea() 
        feature.SetField('POWER', power)
        feature.SetField('POWER_DENSITY', power / area)
        layer.SetFeature(feature)
