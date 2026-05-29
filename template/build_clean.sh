#!/usr/bin/env bash
# =============================================================
#  build_clean.sh — Applied Mathematics Career Document Builder
#  Usage:
#    ./build_clean.sh            # build everything
#    ./build_clean.sh resume     # build only the resume
#    ./build_clean.sh projects   # build only the projects doc
#    ./build_clean.sh letter     # build only the cover letter
#    ./build_clean.sh noopen     # build all, skip PDF viewer
# =============================================================

set -euo pipefail

# ── Colour helpers ────────────────────────────────────────────
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
ok()   { echo -e "${GREEN}  ✓  $*${NC}"; }
warn() { echo -e "${YELLOW}  ⚠  $*${NC}"; }
fail() { echo -e "${RED}  ✗  $*${NC}"; exit 1; }

LATEXCMD="pdflatex -interaction=batchmode -halt-on-error"

compile() {
  local dir="$1" file="$2"
  echo "  Compiling ${dir}/${file}.tex …"
  cd "$dir"
  # Two passes to resolve cross-references / labels
  $LATEXCMD "${file}.tex" > /dev/null 2>&1 || fail "First pass failed: ${dir}/${file}.tex"
  $LATEXCMD "${file}.tex" > /dev/null 2>&1 || fail "Second pass failed: ${dir}/${file}.tex"
  cd ..
  ok "${dir}/${file}.pdf"
}

clean_aux() {
  echo "  Cleaning auxiliary files …"
  find . -type f \( \
    -name '*.aux' -o -name '*.log' -o -name '*.out' \
    -o -name '*.toc' -o -name '*.lof' -o -name '*.lot' \
    -o -name '*.fls' -o -name '*.fdb_latexmk' \
    -o -name '*.synctex.gz' \
  \) -delete
  ok "Auxiliary files removed"
}

TARGET="${1:-all}"
OPEN=true
[[ "${1:-}" == "noopen" ]] && { OPEN=false; TARGET="all"; }

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Career Document Builder — Applied Mathematics "
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

case "$TARGET" in
  resume)
    compile resume resume ;;
  projects)
    compile projects projects ;;
  letter|cover|cover_letter)
    compile cover_letter cover_letter ;;
  all)
    compile resume resume
    compile projects projects
    compile cover_letter cover_letter
    echo ""
    echo "  Assembling final PDF …"
    $LATEXCMD main.tex > /dev/null 2>&1 || fail "Assembly pass 1 failed"
    $LATEXCMD main.tex > /dev/null 2>&1 || fail "Assembly pass 2 failed"
    ok "main.pdf assembled"
    ;;
  *)
    fail "Unknown target '${TARGET}'. Use: resume | projects | letter | all | noopen"
    ;;
esac

echo ""
clean_aux

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ok "Done."

# ── Open the relevant PDF ─────────────────────────────────────
if $OPEN; then
  case "$TARGET" in
    resume)   PDF="resume/resume.pdf" ;;
    projects) PDF="projects/projects.pdf" ;;
    letter|cover|cover_letter) PDF="cover_letter/cover_letter.pdf" ;;
    all)      PDF="main.pdf" ;;
  esac
  if [ -f "$PDF" ]; then
    xdg-open "$PDF" &
  else
    warn "$PDF not found — skipping viewer launch."
  fi
fi
