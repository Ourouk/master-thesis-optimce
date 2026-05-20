// In file top level sit the global variables that need to be exported
// (they need to be used outside the template settings),
// as well as the main template setting function, named `project`.

// Save font families.
// STIX Two Text: standard font for scientific/academic papers.
#let main-font = "STIX Two Text"
// Noto Sans: clean, professional sans-serif for headings.
#let sans-font = "Noto Sans"
// Fira Code: monospaced font for code blocks.
#let mono-font = "Fira Code"

// Code block styling for codly.
#let code-stroke-color = rgb("#d0d7de")
#let code-bg-color = rgb("#f6f8fa")

//Based on color scheme of the official https://hepl.be/themes/custom/hepl/css/module.css?s8sgmk
#let HEPLColors = (
  beige-super-pale:   rgb("#e8e8e3"),
  rouge-prv:          rgb("#CC0033"),
  jaune-prv:          rgb("#F6A800"),
  jaune-fonce-hepl:   rgb("#be7f00"),
  bleu-hepl:          rgb("#0080a0"),
  bleu-clair-hepl:    rgb("#8abcc8"),
  bleu-clair-darker-hepl:    rgb("#294e57"),
  bleu-fonce-hepl:    rgb("#002b4f"),
)

// Uliège colors (from official graphic chart).
#let Uliege = (
  TealDark:  rgb(000, 112, 127),
  TealLight: rgb(095, 164, 176),
  // Beige gray scale.
  BeigeLight: rgb(232, 226, 222),
  BeigePale:  rgb(230, 230, 225),
  BeigeDark:  rgb(198, 192, 180),
  // Faculty colors.
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

// The project function defines how your document looks.
// It takes your content and some metadata and formats rest.
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
  body,
) = {
  //Add Support for code blocks with academic styling
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
  // Document's basic properties.
  set document(author: authors.map(author => author.first-name + author.last-name), title: sub-title)


  // Paper and margins
  set page(
    paper: paper-size,
    margin:
    (x: 2.5cm, top: 1.5cm, bottom: 2.0cm),
    header-ascent: 35%,
    header: context {
      set text(font: sans-font, fill: Uliege.GrayDark, size: 0.9em)

      let selector = selector(heading).before(here())
      let level = counter(selector)
      let headings = query(selector)

      let heading_text = if headings.len() > 0 {
        let headings_shown = (1, 2)
        let heading_max_level = calc.max(..headings_shown)

        level.display((..nums) => nums
          .pos()
          .slice(0, calc.min(heading_max_level, nums.pos().len()))
          .map(str)
          .join("."))

        headings_shown.map((i) => {
          let headings_at_this_level = headings
            .filter(h => h.level == i)

          if headings_at_this_level.len() == 0 { return none }

          headings_at_this_level
            .last()
            .body
        })
        .filter(it => it != none)
        .join([ --- ])
      } else {
        none
      }

      grid(
        columns: (1fr, auto),
        column-gutter: 1em,
        align(left, heading_text),
        align(right, counter(page).display()),
      )
    }
  )

  // Font families.
  let font-size = 11pt
  let code-size = 9pt
  set text(
    font: main-font,
    size: font-size,
    lang: "en",
    number-type: "lining",
    number-width: "tabular")
  show raw: set text(font: mono-font, size: code-size)
  set raw(tab-size: 4)

  // Hyphenation.
  set text(hyphenate: true)

  // Math settings.
  show math.equation: set text(font: "STIX Two Math")
  set math.equation(numbering: "(1.1)")

  // Paragraphs with character-level justification for academic typography.
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

  // Headings.
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
      // Run-in subheadings for level 4+.
      parbreak()
      text(font: sans-font, fill: Uliege.TealDark, weight: "semibold")[#rest.body ---]
    }
  }

  // Figure and table numbering by chapter (e.g., Figure 3.2).
  set figure(numbering: "1.1")

  // Footnote styling for academic tone.
  show footnote: set text(size: 0.85em, fill: Uliege.GrayDark)

  // Bibliography styling with hanging indent and tighter spacing.
  show bibliography: set text(0.9em)
  show bibliography: set par(hanging-indent: 1.5em, spacing: 0.9em)

// Information Parsing
  // Année académique parsing
  let school-year = if date.month() < 9 {
  [Année académique #(date.year() - 1)–#date.year()]
  } else {
    [Année académique #date.year()–#(date.year() + 1)]
  }
//Title Page
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
      #stack(
        dir: ttb,
        ..authors-content
      )
    ]
  ]
  pagebreak()
} else {
    let size = 2.2em
    let number_of_authors = 0
    if authors.len() > 3 {
      number_of_authors = authors.len() -3
    }
    let header-height = 6.5cm + number_of_authors * size
    stack(
      dir: ttb,
      spacing: 0pt,
      rect(
        fill: HEPLColors.beige-super-pale,
        width: 100%,
        height: header-height,
      ),
      block(height: 2cm, 
        place(right + top, dx: -1.5cm, dy: -1.2cm,
          rotate(30deg,
            polygon.regular(
              fill: HEPLColors.rouge-prv,
              size: 5cm,
              vertices: 5,
            )
          )
        )
      ),
      align(center,
        block(height: header-height,
          grid(
            columns: (1fr, 1fr),
            column-gutter: 1cm,
            row-gutter: 0.5cm,
            [
              #image("figures/g2.svg", height: 1.25cm)
            ],
            [
              #let this_year = date.year()
              #if date.month() < 9 [Année Académique #{this_year - 1} -- #this_year] else [Année Académique #this_year -- #(this_year+ 1)]
              #linebreak()
              #text(size: 1.4em, fill: HEPLColors.bleu-fonce-hepl, weight: "semibold")[#main-title :]
              #linebreak()
              #text(size: 1.8em, fill: HEPLColors.bleu-clair-darker-hepl, weight: "semibold")[#sub-title]
            ],
            [],
            [
              #grid(
                ..authors.map(author =>
                    [
                      #author.first-name #smallcaps(author.last-name)  \
                      #author.cursus \
                      #if "specialty" in author [#author.specialty] \
                      \
                    ]
                )
              )
            ],
          )
        )
      ),
    )
  }



// Abstract.
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

  v(1cm)
  outline(indent: auto,title: "Table des matières",depth: 3)
  pagebreak()
  // Document main body.
  body
  // Print the bibliography.
  if bibliography-file != none {
    pagebreak()
    show bibliography: set text(0.9em)
    bibliography(bibliography-file, full: false, style: "ieee",title: "Bibliographie")
  }

  // Print the annex.
  if annex != none {
    pagebreak()
    counter(heading).update(0)
    set heading(numbering: "A.1", supplement: [Annexe])
    annex
  }
}
