// ============================================================
//  EAC Report Template
//  A4, fundo azul total na capa, rodapé estilo livro
// ============================================================

// ── Paleta ───────────────────────────────────────────────────
#let accent-blue       = rgb("#005C8B")
#let accent-blue-light = accent-blue.lighten(30%)
#let page-margin = (
  top: 2.5cm, bottom: 2.5cm,
  left: 2.5cm, right: 2cm,
)

#let cover-logo = image("../../assets/logos/eac_ufsm_white.svg", width: 10cm)

#let cover-waves = image("../../assets/color_waves.svg")

// ── Rodapé estilo livro ──────────────────────────────────────
#let report-footer(numbering-style: "1") = {
  context {
    let n      = counter(page).display(numbering-style)
    let num    = text(size: 8pt, fill: luma(120), n)
    let is-odd = calc.odd(counter(page).get().first())

    stack(
      line(length: 100%, stroke: 0.5pt + luma(160)),
      v(4pt),
      if is-odd {
        align(right, num)
      } else {
        align(left, num)
      },
    )
  }
}

#let cover-page(
  course-code: none,
  course-name: none,
  subtitle:    none,
  authors:     (),
  date:        none,
  institution: none,
) = {
  set page(margin: 0pt, footer: none, header: none)

  box(width: 100%, height: 100%, fill: accent-blue, {

    // Rodapé de ondas
    place(right + bottom,  cover-waves)

    pad(left: 2cm, right: 2cm, top: 0pt, bottom: 0pt, {

      // Top logo
      v(2.5cm)
      align(left, cover-logo)

      v(1fr)

      if course-code != none {
        text(size: 12pt, weight: "semibold", fill: white, course-code)
        v(0.25cm)
      }

      if course-name != none {
        block(width: 100%,
          text(size: 24pt, weight: "bold", fill: white, course-name)
        )
        v(0.5cm)
      }

      if subtitle != none {
        block(width: 100%,
          text(size: 12pt, fill: white, subtitle)
        )
        v(0.5cm)
      }

      if authors.len() > 0 {
        v(0.5cm)
        for a in authors {
          text(size: 12pt, fill: white, a, weight: "semibold")
          linebreak()
        }
      }

      v(1fr)

      if institution != none {
        for line-text in institution {
          text(size: 10pt, fill: white, line-text)
          linebreak()
        }
        v(0.5cm)
      }

      if date != none {
        text(size: 10pt, fill: white,
          if type(date) == datetime {
            date.display("[day]/[month]/[year]")
          } else {
            str(date)
          }
        )
      }

      v(7.5cm)
    })
  })
}

// ── Template principal ───────────────────────────────────────
// This function is the public template. Use it with `#show: templates.technical-report.with(...)`
#let technical-report(
  course-code:       none,
  course-name:       none,
  subtitle:          none,
  authors:           (),
  date:              none,
  institution:       none,
  lang:              "pt",
  body-size:         11pt,
  heading-numbering: "1.1.1",
  page-numbering:    "1",
  body,
) = {

  set document(
    title:  if course-code != none { course-code + " — " + course-name } else { course-name },
    author: authors,
  )

  set text(size: body-size, lang: lang)
  set par(justify: true, leading: 0.65em)

  set heading(numbering: heading-numbering)

  show outline: it => {
    pagebreak(weak: true)
    it
    pagebreak()
  }

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(1.2em)
    text(size: 16pt, weight: "bold", fill: black, it)
    v(0.4em)
  }

  show heading.where(level: 2): it => {
    v(0.9em)
    text(size: 13pt, weight: "semibold", fill: black, it)
    v(0.3em)
  }

  show heading.where(level: 3): it => {
    v(0.7em)
    text(size: 11pt, weight: "semibold", fill: black, it)
    v(0.2em)
  }

  cover-page(
    course-code: course-code,
    course-name: course-name,
    subtitle:    subtitle,
    authors:     authors,
    date:        date,
    institution: institution,
  )

  set page(
    paper:  "a4",
    margin: page-margin,
    footer: report-footer(numbering-style: page-numbering),
    header: none,
  )

  counter(page).update(1)

  body
}
