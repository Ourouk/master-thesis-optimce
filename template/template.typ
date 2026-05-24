// ============================================================
// TEMPLATE CONFIGURATION — HEPL Master's Thesis
// ============================================================
// This file defines the visual layout and formatting rules for
// the thesis document. The main entry point is the `project`
// function at the bottom, which accepts metadata and body content.
//
// Global variables (fonts, colors) are defined at the top level
// so they can be accessed from other files if needed.
// ============================================================

// ── Fonts ────────────────────────────────────────────────────
// STIX Two Text: serif font optimized for scientific papers.
#let main-font = "STIX Two Text"
// Noto Sans: clean sans-serif for headings and UI elements.
#let sans-font = "Noto Sans"
// Fira Code: monospaced font with ligatures for code blocks.
#let mono-font = "Fira Code"

// ── Code Block Colors (GitHub-inspired theme) ───────────────
#let code-stroke-color = rgb("#d0d7de")
#let code-bg-color = rgb("#f6f8fa")

// ── HEPL Official Colors ────────────────────────────────────
// Source: https://hepl.be/themes/custom/hepl/css/module.css
#let HEPLColors = (
  beige-super-pale:   rgb("#e8e8e3"),
  rouge-prv:          rgb("#CC0033"),
  jaune-prv:          rgb("#F6A800"),
  jaune-fonce-hepl:   rgb("#be7f00"),
  bleu-hepl:          rgb("#0080a0"),
  bleu-clair-hepl:    rgb("#8abcc8"),
  bleu-clair-darker-hepl: rgb("#294e57"),
  bleu-fonce-hepl:    rgb("#002b4f"),
)

// ── ULiège Official Colors ──────────────────────────────────
// Source: ULiège graphic chart.
#let Uliege = (
  TealDark:  rgb(000, 112, 127),
  TealLight: rgb(095, 164, 176),
  BeigeLight: rgb(232, 226, 222),
  BeigePale:  rgb(230, 230, 225),
  BeigeDark:  rgb(198, 192, 180),
  Yellow:        rgb(255, 208, 000),
  OrangeLight:   rgb(248, 170, 000),
  OrangeDark:    rgb(240, 127, 060),
  Red:           rgb(230, 045, 049),
  GreenPale:     rgb(185, 205, 118),
  GreenLight:    rgb(125, 185, 040),
  Green:         rgb(040, 155, 056),
  GreenDark:     rgb(000, 132, 059),
  BlueLight:     rgb(031, 186, 219),
  BlueDark:      rgb(000, 092, 169),
  LavenderDark:  rgb(091, 087, 162),
  LavenderLight: rgb(141, 166, 214),
  PurpleLight:   rgb(168, 088, 158),
  PurpleDark:    rgb(091, 037, 125),
  GrayDark:      rgb(140, 139, 130),
  GrayLight:     rgb(181, 180, 169),
)

// ============================================================
// MAIN TEMPLATE FUNCTION
// ============================================================
// Call this function in `main.typ` to apply all formatting.
// Parameters:
//   main-title       — Title displayed on the cover page.
//   sub-title        — Subtitle or secondary title.
//   fullTitlePage    — true for a decorative cover, false for compact.
//   abstract         — Content block for the abstract (or `none`).
//   authors          — Array of author dictionaries.
//   thanks           — Array of acknowledgments (currently unused).
//   date             — Document date (defaults to today).
//   paper-size       — Paper format (default: "a4").
//   bibliography-file — Path to the .bib file (or `none`).
//   annex            — Content block for appendices (or `none`).
//   binding          — true adds 1cm extra left margin for physical binding.
//   body             — The main document content.
// ============================================================
#let project(
  main-title: "This is the main title",
  sub-title: "Sub-Title of the document",
  fullTitlePage: false,
  abstract: none,
  authors: (),
  thanks: (),
  date: datetime.today(),
  paper-size: "a4",
  bibliography-file: none,
  annex: none,
  binding: true,
  body,
) = {
  // ── Code Block Setup (codly package) ──────────────────────
  import "@preview/codly:1.3.0": *
  import "@preview/codly-languages:0.1.1": *
  show: codly-init.with()
  codly(
    languages: codly-languages,
    stroke: 1pt + code-stroke-color,
    radius: 4pt,
    fill: code-bg-color,
    display-icon: false,
  )

  // ── Document Metadata ─────────────────────────────────────
  set document(
    author: authors.map(a => a.first-name + " " + a.last-name),
    title: sub-title,
  )

  // ── Page Layout & Header ──────────────────────────────────
  // Margins follow academic standards.
  // When `binding` is true, left margin increases by 1cm for
  // physical binding (spiral, thermal, etc.).
  let left-margin = if binding { 3.5cm } else { 2.5cm }
  set page(
    paper: paper-size,
    margin: (left: left-margin, right: 2.5cm, top: 2.5cm, bottom: 2.5cm),
    header-ascent: 35%,
    header: context {
      set text(font: sans-font, fill: Uliege.GrayDark, size: 0.9em)

      // Build header text: current section number + title.
      let selector = selector(heading).before(here())
      let level = counter(selector)
      let headings = query(selector)

      let heading-text = if headings.len() > 0 {
        let levels-shown = (1, 2)
        let max-level = calc.max(..levels-shown)

        // Display section number (e.g., "3.2").
        level.display((..nums) => nums
          .pos()
          .slice(0, calc.min(max-level, nums.pos().len()))
          .map(str)
          .join("."))

        h(0.25em)
        // Concatenate titles of the latest h1 and h2.
        levels-shown.map((i) => {
          let headings-at-level = headings.filter(h => h.level == i)
          if headings-at-level.len() == 0 { return none }
          headings-at-level.last().body
        })
        .filter(it => it != none)
        .join([ --- ])
      } else {
        none
      }

      grid(
        columns: (1fr, auto),
        column-gutter: 1em,
        align(left, heading-text),
        align(right, if page.numbering != none { counter(page).display(page.numbering) }),
      )
    }
  )

  // ── Typography ────────────────────────────────────────────
  let font-size = 11pt
  let code-size = 9pt
  set text(
    font: main-font,
    size: font-size,
    lang: "en",
    number-type: "lining",
    number-width: "tabular",
  )
  show raw: set text(font: mono-font, size: code-size)
  set raw(tab-size: 4)
  set text(hyphenate: true)

  // ── Math Equations ────────────────────────────────────────
  show math.equation: set text(font: "STIX Two Math")
  set math.equation(numbering: "(1.1)")

  // ── Paragraph Formatting ──────────────────────────────────
  // Character-level justification for professional typography.
  set par(
    leading: 0.8em,
    first-line-indent: 1.8em,
    justify: true,
    justification-limits: (
      tracking: (min: -0.012em, max: 0.012em),
      spacing: (min: 75%, max: 120%),
    ),
    linebreaks: "optimized",
  )

  // ── Headings ──────────────────────────────────────────────
  set heading(numbering: "1.1")
  show heading: set text(font: sans-font, fill: Uliege.TealDark)
  show heading: rest => {
    if rest.level == 1 {
      text(size: 1.10em, weight: "semibold")[#rest]
    } else if rest.level == 2 {
      text(size: 1.05em, weight: "semibold")[#rest]
    } else if rest.level == 3 {
      text(size: 1.03em, weight: "regular")[#rest]
    } else {
      // Level 4: small standalone heading
      text(font: sans-font, fill: Uliege.TealDark, weight: "semibold", size: 0.9em)[#rest]
      v(0.2em)
    }
  }

  // ── Figures & Tables ──────────────────────────────────────
  // Numbered by chapter (e.g., Figure 3.2, Table 1.1).
  set figure(numbering: "1.1")
  
  set table(
    inset: 0.8em,
    stroke: 0.5pt + luma(220),
    fill: (x, y) => if y == 0 { luma(220) } else if calc.rem(y, 2) == 0 { luma(245) } else { white },
    align: (x, y) => if x == 0 { horizon + left } else { horizon + center },
  )

  // ── Footnotes ─────────────────────────────────────────────
  show footnote: set text(size: 0.85em, fill: Uliege.GrayDark)

  // ── Hyperlinks ────────────────────────────────────────────
  show link: it => {
    set text(fill: Uliege.BlueDark)
    it
  }

  // ── Bibliography ──────────────────────────────────────────
  // Hanging indent with compact line spacing.
  show bibliography: set text(0.9em)
  show bibliography: set par(hanging-indent: 1.5em, spacing: 0.9em)

  // ── Academic Year Calculation ─────────────────────────────
  let school-year = if date.month() < 9 {
    [Année académique #(date.year() - 1)–#date.year()]
  } else {
    [Année académique #date.year()–#(date.year() + 1)]
  }

  // ── Title Page ────────────────────────────────────────────
  if fullTitlePage {
    let authors-content = authors.map(author => [
      #author.first-name #smallcaps(author.last-name)  \
      #author.cursus \
      #if "specialty" in author [#author.specialty] \
      \
    ])
    page(
      margin: (x: 2.5cm, top: 2cm, bottom: 2cm),
      background: [
        #place(top + left, dx: -1.5cm, dy: -1cm, rotate(15deg, polygon.regular(fill: HEPLColors.bleu-hepl, size: 5cm, vertices: 6)))
        #place(top + left, dx: 3cm, dy: 25cm, rotate(-10deg, circle(radius: 1.5cm, fill: HEPLColors.rouge-prv)))
        #place(top + right, dx: -1cm, dy: 0pt, rotate(20deg, polygon.regular(fill: HEPLColors.jaune-prv, size: 3cm, vertices: 5)))
        #place(bottom + left, dx: 0pt, dy: 1cm, rotate(-15deg, circle(radius: 2cm, fill: HEPLColors.bleu-clair-hepl)))
        #place(bottom + right, dx: -1.5cm, dy: 1cm, rotate(10deg, polygon.regular(fill: HEPLColors.bleu-fonce-hepl, size: 2.8cm, vertices: 4)))
        #place(bottom + right, dx: 2.5cm, dy: 0pt, rotate(-5deg, circle(radius: 1.2cm, fill: HEPLColors.rouge-prv.lighten(30%))))
      ]
    )[
      #align(center + top)[
        #v(1cm)
        #image("figures/g2.svg", height: 3cm)
        #v(0.8em)
        #let this_year = date.year()
        #text(size: 0.9em, fill: HEPLColors.bleu-fonce-hepl)[Année Académique #{this_year - 1} -- #this_year]
        #v(2cm)
        #text(size: 2em, fill: HEPLColors.bleu-fonce-hepl, weight: "bold")[#main-title]
        #v(0.3em)
        #text(size: 1.5em, fill: HEPLColors.bleu-clair-darker-hepl, weight: "medium")[#sub-title]
        #v(10cm)
        #stack(dir: ttb, ..authors-content)
      ]
    ]
    pagebreak()
  } else {
    // Compact title page (default).
    let size = 2.2em
    let extra-authors = if authors.len() > 3 { authors.len() - 3 } else { 0 }
    let header-height = 6.5cm + extra-authors * size
    stack(
      dir: ttb,
      spacing: 0pt,
      rect(fill: HEPLColors.beige-super-pale, width: 100%, height: header-height),
      block(height: 2cm,
        place(right + top, dx: -1.5cm, dy: -1.2cm,
          rotate(30deg, polygon.regular(fill: HEPLColors.rouge-prv, size: 5cm, vertices: 5))
        )
      ),
      align(center,
        block(height: header-height,
          grid(
            columns: (1fr, 1fr),
            column-gutter: 1cm,
            row-gutter: 0.5cm,
            [#image("figures/g2.svg", height: 1.25cm)],
            [
              #let this_year = date.year()
              #if date.month() < 9 [Année Académique #{this_year - 1} -- #this_year] else [Année Académique #this_year -- #(this_year + 1)]
              #linebreak()
              #text(size: 1.4em, fill: HEPLColors.bleu-fonce-hepl, weight: "semibold")[#main-title :]
              #linebreak()
              #text(size: 1.8em, fill: HEPLColors.bleu-clair-darker-hepl, weight: "semibold")[#sub-title]
            ],
            [],
            [
              #grid(..authors.map(a => [
                #a.first-name #smallcaps(a.last-name)  \
                #a.cursus \
                #if "specialty" in a [#a.specialty] \
                \
              ]))
            ],
          )
        )
      ),
    )
  }

  // ── Abstract Block ────────────────────────────────────────
  if abstract != none {
    block(
      width: 100%,
      fill: Uliege.TealDark.lighten(90%),
      inset: 2em,
      below: 2em,
      par(first-line-indent: 0em)[
        #text(font: sans-font, fill: Uliege.TealDark, weight: "semibold")[Abstract]
        #linebreak()
        #abstract
      ]
    )
  }

  // ── Table of Contents ─────────────────────────────────────
  // Page numbering is disabled for front matter.
  set page(numbering: none)
  v(1cm)
  outline(indent: auto, title: "Table des matières", depth: 3)
  pagebreak()

  // Re-enable page numbering and reset the counter for main content.
  counter(page).update(1)
  set page(numbering: "1", footer: none)

  // ── Document Body ─────────────────────────────────────────
  body

  // ── Bibliography ──────────────────────────────────────────
  if bibliography-file != none {
    pagebreak()
    show bibliography: set text(0.9em)
    bibliography(bibliography-file, full: false, style: "ieee", title: "Bibliographie")
  }

  // ── Appendices ────────────────────────────────────────────
  if annex != none {
    pagebreak()
    counter(heading).update(0)
    set heading(numbering: "A.1", supplement: [Annexe])
    annex
  }
}
