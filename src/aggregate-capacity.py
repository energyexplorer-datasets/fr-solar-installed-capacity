import csv
from osgeo import ogr
import shutil

capacity = {
    'iris': {},
    'insee': {},
    'epci': {},
    'departement': {},
    'region': {},
    'unlocated': {}
}

def add(type, site, power):
    if not site in capacity[type]:
        capacity[type][site] = float(power)
    else:
        capacity[type][site] += float(power)

with open('registre-national-installation-production-stockage-electricite-agrege.csv') as file:
    csv_reader = csv.DictReader(file, delimiter=';')
    for facility in csv_reader:
        
        channel = facility['codeFiliere']
        power = facility['puisMaxInstallee']
        power2 = facility['puisMaxRac']
        irisSite = facility['codeIRISCommuneImplantation']
        iris = facility['codeIRIS']
        inseeSite = facility['codeINSEECommuneImplantation']
        insee = facility['codeINSEECommune']
        epci = facility['codeEPCI']
        departement = facility['codeDepartement']
        region = facility['codeRegion']
        
        if channel != 'SOLAI':
            continue
        
        if not power:
            if power2:
                power = power2
            else:
                print('no power')
                print(facility)
                continue

        if irisSite:
            add('iris', irisSite, power)
        elif inseeSite:
            add('insee', inseeSite, power)
        elif iris:
            add('iris', iris, power)
        elif insee:
            add('insee', insee, power)
        elif epci:
            add('epci', epci, power)
        elif departement:
            add('departement', departement, power)
        elif region:
            add('region', region, power)
        else:
            add('unlocated', 'na', power)

    writer = csv.writer(open(f'capacity-aggregated.csv', 'w'))
    writer.writerow(['site_type', 'site_code', 'power'])
    for type in capacity:
        for site, power in capacity[type].items():
            writer.writerow([type, site, power])