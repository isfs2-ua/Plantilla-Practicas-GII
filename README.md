# Plantilla de memorias de prácticas — Ingeniería Informática

Plantilla editable en Markdown para generar memorias en PDF con Pandoc y LuaLaTeX. Es una plantilla orientativa, no un formato oficial de la Universidad de Alicante: adapta portada, estructura y estilo a las instrucciones de cada asignatura.

## Requisitos

- [Pandoc](https://pandoc.org/installing.html), con soporte para archivos de opciones (`--defaults`).
- Una distribución de LaTeX que incluya LuaLaTeX y los paquetes usados por Pandoc (por ejemplo, TeX Live o MiKTeX). Una instalación mínima puede necesitar paquetes adicionales.

## Uso

1. Copia esta carpeta para cada práctica.
2. Edita los datos de la cabecera de `memoria.md`: título, asignatura, autores y curso. Añade en el subtítulo o el documento cualquier dato adicional que pida el profesorado.
3. Edita los archivos de `capitulos/` para sustituir el contenido de ejemplo y coloca las imágenes en `recursos/`. Cada archivo contiene una sección principal de la memoria.
4. Para añadir, quitar o reordenar capítulos, modifica la lista `input-files` de `pandoc.yaml`. Mantén `memoria.md` en primer lugar para conservar los datos de la portada.
5. Desde esta carpeta, ejecuta:

   ```sh
   pandoc --defaults=pandoc.yaml -o memoria.pdf
   ```

Abre y revisa el PDF antes de entregarlo. Si falta un paquete `.sty`, instálalo en tu distribución de LaTeX y vuelve a compilar. La portada usa los datos del encabezado y el índice aparece después. Para quitarlo, cambia `table-of-contents` a `false` en `pandoc.yaml`.

## Markdown y LaTeX

Puedes usar Markdown de Pandoc para encabezados, tablas, imágenes y bloques de código. Las fórmulas se escriben entre `$...$` o `$$...$$`. Para incluir LaTeX sin procesar, usa un bloque con la etiqueta `{=latex}`, como en el ejemplo de `capitulos/03-desarrollo.md`. Añade los paquetes que necesites a `formato.tex`; evita cargar dos veces paquetes ya incluidos por Pandoc. Los bloques de LaTeX puro están pensados para la salida PDF y pueden omitirse al convertir a otros formatos.

## Bibliografía opcional

Crea un archivo `referencias.bib`, añade las fuentes y cítalas en el texto como `[@clave]`. Para generar la bibliografía, ejecuta:

```sh
pandoc --defaults=pandoc.yaml --citeproc --bibliography=referencias.bib -o memoria.pdf
```

Pandoc añadirá las referencias al final; puedes situarlas bajo el encabezado «Referencias» usando un `::: {#refs}` seguido de `:::` en líneas separadas. El estilo puede cambiarse con `--csl=estilo.csl`. Consulta la [guía de citas de Pandoc](https://pandoc.org/MANUAL.html#citations).
