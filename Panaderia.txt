import random
import math
from datetime import datetime

precio_venta = 35
costo_produccion = 25
precio_remate = 18
dias = 30

politicas = range(2, 10) 

# Usamos la fecha y hora actual como semilla
random.seed(datetime.now().timestamp())

def simular_politica(docenas_producidas):
    piezas_producidas = docenas_producidas * 12
    ganancias = []

    for _ in range(dias):
        # Demanda aleatoria entre 3 y 7 docenas
        demanda_docenas = random.uniform(3, 7)
        demanda_piezas = int(demanda_docenas * 12)

        vendidas = min(piezas_producidas, demanda_piezas)
        sobrantes = piezas_producidas - vendidas

        # Cálculo de ingresos (incluyendo el remate del 70% del sobrante)
        ingreso = (vendidas * precio_venta) + (sobrantes * 0.70) * precio_remate 
        costo = piezas_producidas * costo_produccion

        ganancia = ingreso - costo
        ganancias.append(ganancia)

    promedio = sum(ganancias) / len(ganancias)

    # Cálculo de desviación estándar
    varianza = sum((g - promedio) ** 2 for g in ganancias) / len(ganancias)
    desviacion = math.sqrt(varianza)

    return promedio, desviacion

print(f"Resultados de la simulación - {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
print("Docenas | Ganancia Promedio | Desviación Estándar")
print("--------------------------------------------------")

for politica in politicas:
    promedio, desviacion = simular_politica(politica)
    print(f"{politica:^7} | {promedio:>17.2f} | {desviacion:>20.2f}")
