#!/usr/bin/env bash
set -euo pipefail

if [[ ! -r /etc/os-release ]]; then
  echo 'No se puede identificar la distribución: falta /etc/os-release.' >&2
  exit 1
fi

# shellcheck source=/dev/null
. /etc/os-release

familia=''
for distribucion in "${ID:-}" ${ID_LIKE:-}; do
  case "$distribucion" in
    debian|ubuntu) familia=debian ;;
    fedora) familia=fedora ;;
    arch|archlinux) familia=arch ;;
  esac
  [[ -z "$familia" ]] || break
done

if [[ -z "$familia" ]]; then
  echo "Distribución no compatible: ${PRETTY_NAME:-desconocida}." >&2
  exit 1
fi

if [[ $EUID -eq 0 ]]; then
  privilegios=()
elif command -v sudo >/dev/null 2>&1; then
  privilegios=(sudo)
else
  echo 'Se necesita sudo o ejecutar el script como administrador.' >&2
  exit 1
fi

echo "Instalando dependencias para ${PRETTY_NAME:-$familia}..."
case "$familia" in
  debian)
    "${privilegios[@]}" apt-get update
    "${privilegios[@]}" apt-get install --no-install-recommends \
      pandoc texlive-luatex texlive-latex-extra texlive-lang-spanish \
      texlive-fonts-recommended lmodern
    ;;
  fedora)
    "${privilegios[@]}" dnf install pandoc texlive-collection-luatex \
      texlive-collection-latexextra texlive-collection-latexrecommended \
      texlive-collection-langspanish texlive-collection-fontsrecommended texlive-lm
    ;;
  arch)
    "${privilegios[@]}" pacman -Syu --needed pandoc texlive-luatex \
      texlive-latexextra texlive-latexrecommended texlive-langspanish \
      texlive-fontsrecommended
    ;;
esac

echo 'Dependencias instaladas. Genera la memoria con:'
echo '  pandoc --defaults=pandoc.yaml -o memoria.pdf'
