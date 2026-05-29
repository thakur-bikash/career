# Applied Mathematics Career Document Suite

A professional LaTeX template system designed specifically for applied
mathematics academics and researchers targeting positions in:

- Faculty (tenure-track, teaching, lecturer)
- Postdoctoral fellowships
- National laboratory research staff
- Industry R&D (quant finance, data science, scientific computing)
- Government / defence research (DARPA, DoE labs, NIST)

---

## Structure

```
career/
├── build_clean.sh          # Build script (see Usage below)
├── main.tex                # Assembles all PDFs into one file
├── resume/
│   └── resume.tex          # 1–2 page academic/industry CV
├── projects/
│   └── projects.tex        # Technical project portfolio (1–3 pages)
└── cover_letter/
    └── cover_letter.tex    # Targeted cover letter template
```

---

## Usage

```bash
# Build everything and open main.pdf
./build_clean.sh

# Build only one component
./build_clean.sh resume
./build_clean.sh projects
./build_clean.sh letter

# Build everything but don't open a PDF viewer
./build_clean.sh noopen
```

The script runs **two LaTeX passes** per file to resolve references, then
cleans all auxiliary files automatically.

---

## Customising Each File

### `resume/resume.tex`

| Marker | What to fill in |
|---|---|
| `Your Full Name` | Your name (appears in header) |
| Research interests line | Your actual focus areas |
| Education blocks | Degrees, dates, GPA, advisor |
| `\cventry` blocks | Jobs, internships, research positions |
| `\cvpub` entries | Your publications and preprints |
| Skills section | Languages and tools you actually use |

**Tip:** The `\cventry{Title}{Org}{Date}{Details}` command keeps alignment
consistent. Use `\eq{...}` for inline math anywhere in bullet points.

### `projects/projects.tex`

Each project follows a structured narrative:

1. **Problem** — what gap exists, what the cost was before your work
2. **Contribution** — your specific mathematical/algorithmic idea
3. **Results** — concrete numbers (speedup, error rate, complexity)
4. **Key result box** — one-line highlight (paper, GitHub, award)

Aim for 2–3 projects at full depth, 1–2 at short depth.

### `cover_letter/cover_letter.tex`

Search for `%% <<FILL>>` — there are 8 places to customise per application:

- Recipient name and affiliation
- Position title and reference number  
- Why *this* group (the most important paragraph — be specific)
- One concrete joint research direction

The mathematical content (research paragraphs) can stay mostly fixed across
applications; only the fit paragraph needs deep customisation.

---

## Design Choices

**Colour palette**
- `NavyDeep` `#1B2A4A` — headings, names, rules
- `AccentTeal` `#2A6E7C` — links, bullets, tags, accents
- `SubtleGray` `#6B7280` — secondary text, metadata

**Typography**  
Latin Modern (`lmodern`) throughout — the standard for mathematics,
familiar to every reviewer in the field. `microtype` handles kerning.

**Math in bullets**  
Use `\eq{...}` (shortcut for `$...$`) freely in bullet points. Complexity
bounds, dimensions, norms, and rates all look professional inline.

---

## Dependencies

```bash
# Fedora / RHEL
sudo dnf install texlive-scheme-full

# or minimal set
sudo dnf install texlive-latex texlive-lmodern texlive-microtype \
  texlive-fontawesome5 texlive-tcolorbox texlive-booktabs \
  texlive-enumitem texlive-hyperref texlive-geometry \
  texlive-amsmath texlive-xcolor texlive-pdfpages
```

---

## Tips for Different Job Types

### Postdoc / Faculty applications
- Keep resume to **2 pages maximum**
- Expand publications section; add a "Works in Progress" subsection
- Write 3 distinct cover letters: research-heavy, teaching-heavy, fit-heavy

### National Lab (DoE, NIST, AFRL, …)
- Emphasise HPC, parallel scaling, and software engineering in skills
- Mention security clearance eligibility if applicable
- Quantify compute hours used on federal HPC systems

### Quant / Industry R&D
- Lead with impact (speedups, error reductions, dollar value if possible)
- Compress publications; expand tools and software
- Remove or shorten dissertation description; expand internship bullets

---

*Template version 2.0 — May 2026*
