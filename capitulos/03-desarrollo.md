# Desarrollo {#sec:desarrollo}

Explica el procedimiento, las decisiones tomadas y las herramientas utilizadas.

## Ejemplo de código

```python
def saludo(nombre):
    return f"Hola, {nombre}"
```

## Ejemplo de fórmula

Una fórmula en línea puede expresar una complejidad $O(n \log n)$. Para una fórmula numerada con referencia, usa LaTeX:

```{=latex}
\begin{equation}
  T(n) = n \log_2 n
  \label{ec:complejidad}
\end{equation}
```

La ecuación \ref{ec:complejidad} es un ejemplo de referencia automática.

## Ejemplo de tabla

| Caso | Resultado esperado | Resultado obtenido |
|:-----|:-------------------|:------------------|
| 1    | Correcto           | Correcto          |

Table: Ejemplo de resultados de una prueba.\label{tab:prueba}

El cuadro \ref{tab:prueba} recoge un caso de prueba. Sustituye sus datos por los de tu práctica.

## Ejemplo de figura

La figura \ref{fig:flujo} muestra un flujo sencillo. Guarda tus imágenes en `recursos/` y sustituye la ruta y el texto del ejemplo.

![Flujo básico de una aplicación.\label{fig:flujo}](recursos/ejemplo-flujo.png){width=85%}

## Ejemplo de referencia a una sección

Puedes remitir al apartado \ref{sec:desarrollo} mediante el identificador indicado en su encabezado. Cambia los identificadores para que sean únicos en toda la memoria.

## Ejemplo de LaTeX

El siguiente bloque se incluirá directamente en el PDF:

```{=latex}
\begin{center}
\fbox{\parbox{0.8\textwidth}{\textbf{Nota:} sustituye este ejemplo por el contenido necesario.}}
\end{center}
```
