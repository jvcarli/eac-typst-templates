#let title-slide(title, subtitle: none, author: none, date: none) = {
  page(paper: "presentation-16-9", margin: 2cm)[
    #set text(size: 24pt)

    #align(center + horizon)[
      #v(5cm)
      #text(size: 40pt, weight: "bold")[#title]

      #if subtitle != none [
        #v(1cm)
        #text(size: 30pt)[#subtitle]
      ]

      #if author != none [
        #v(2cm)
        #text(size: 20pt)[#author]
      ]

      #if date != none [
        #v(0.5cm)
        #text(size: 16pt)[#date]
      ]
    ]
  ]
}

#let slide(title: none, body) = {
  page(paper: "presentation-16-9", margin: 1.5cm)[
    #if title != none [
      #set text(size: 32pt, weight: "bold")
      #block[#title]
      #v(1cm)
    ]

    #set text(size: 20pt)
    #body
  ]
}
