#!/usr/bin/env wolframscript
RKODE[G_, x0_, f0_, dx_, Ns_] := Module [{k1, k2, retvals, index, xn, fn},
retvals = Table[{0.0, 0.0}, {i, 1, Ns}];
xn = x0;
fn = f0;
retvals[[1]] = {x0, f0};
For[index = 2, index <= Ns, index = index +1,
        k1 = dx G[xn, fn];
        k2 = dx G[xn + dx/2, fn + k1/2];
        fn = fn + k2;
        xn = xn + dx;
        retvals[[index]] = {xn, fn};
        ];
Return[retvals];
]

f[t_, x_]:= -2*x*t
x0=1.0;
f0=1.0;
dx=0.1;
Ns=50;
resultados = RKODE[f, x0, f0, dx, Ns];
ListPlot[resultados,
(*Realiza la gráfica en base a los resultados*)
 Joined -> True, (*Conecta todos los puntos de tal forma sea continuo*)
 Mesh -> All, (*Muestra todos los puntos*)
 AxesLabel -> {"Tiempo (t)", "x(t)"}, (*Etiquetas para {x,t}*)
 PlotLabel -> "Solución usando Runge-Kutta (Midpoint)", (*Título*)
 
 PlotStyle -> {Blue, Thick},
 MeshStyle -> Red]  (*Color y estilo de los puntos*)

(*TABLA: Resultados*)

Print["Tabla de resultados (primeros 5 valores):"]; (*Título*)

TableForm[Take[resultados, 5],
 TableHeadings -> {None, {"Tiempo (t)", "x(t)"}}]
(*Crea la tabla con nombre para {x,t}*)
