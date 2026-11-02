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

## Portadas por asignatura

La plantilla incluye variantes para las asignaturas del [plan de estudios del Grado en Ingeniería Informática de la Universidad de Alicante](https://www.boe.es/diario_boe/txt.php?id=BOE-A-2023-11557), incluidas las optativas y el trabajo de fin de grado. Combinan cuatro composiciones y un color propio para cada asignatura; son propuestas de la plantilla, no diseños oficiales de la UA.

Busca la asignatura en [portadas/asignaturas.tsv](portadas/asignaturas.tsv) y copia su identificador en la cabecera de `memoria.md`. Por ejemplo:

```yaml
title: "Título de la práctica"
portada: programacion-1
subtitle: "Práctica 1"
author:
  - "Nombre y apellidos"
date: "Curso 2026–2027"
lang: es-ES
```

El nombre de la asignatura se añade automáticamente delante del subtítulo. Si no indicas `portada` o usas `portada: general`, se conserva la portada genérica y puedes escribir la asignatura directamente en `subtitle`. También puedes probar una variante sin cambiar el archivo con `pandoc --defaults=pandoc.yaml -M portada=programacion-1 -o memoria.pdf`. Ejecuta Pandoc desde la carpeta de la plantilla para que encuentre el catálogo y el filtro.

## Markdown y LaTeX

Puedes usar Markdown de Pandoc para encabezados, tablas, imágenes y bloques de código. Las fórmulas se escriben entre `$...$` o `$$...$$`. Para incluir LaTeX sin procesar, usa un bloque con la etiqueta `{=latex}`, como en el ejemplo de `capitulos/03-desarrollo.md`. Añade los paquetes que necesites a `formato.tex`; evita cargar dos veces paquetes ya incluidos por Pandoc. Los bloques de LaTeX puro están pensados para la salida PDF y pueden omitirse al convertir a otros formatos.

## Bibliografía opcional

Crea un archivo `referencias.bib`, añade las fuentes y cítalas en el texto como `[@clave]`. Para generar la bibliografía, ejecuta:

```sh
pandoc --defaults=pandoc.yaml --citeproc --bibliography=referencias.bib -o memoria.pdf
```

Pandoc añadirá las referencias al final; puedes situarlas bajo el encabezado «Referencias» usando un `::: {#refs}` seguido de `:::` en líneas separadas. El estilo puede cambiarse con `--csl=estilo.csl`. Consulta la [guía de citas de Pandoc](https://pandoc.org/MANUAL.html#citations).

## Licencias y recursos de terceros

- **Plantilla:** el código y la documentación propios del proyecto se distribuyen bajo la [licencia MIT](LICENSE). Esta licencia no se aplica al logotipo ni a otros recursos de terceros.
- **Logotipo de la Universidad de Alicante:** `recursos/logo-ua.pdf` es la versión horizontal en color distribuida por la [Universidad de Alicante](https://imagenycomunicacion.ua.es/es/identidad-visual-corporativa-y-logotipos-ua.html). La marca y el logotipo pertenecen a la UA y se rigen por sus propias [condiciones de uso](https://si.ua.es/es/web-institucional-ua/normativa/condiciones-de-uso.html) y su [manual de identidad visual](https://web.ua.es/es/gabinete-imagen/documentos/ivcorporativaua-2026.pdf). La inclusión del logotipo no concede una licencia abierta sobre él ni implica que esta plantilla sea oficial.
- **Herramientas:** Pandoc y LaTeX son proyectos independientes, sujetos a las licencias de sus respectivas distribuciones y paquetes. No se incluyen en la plantilla.
