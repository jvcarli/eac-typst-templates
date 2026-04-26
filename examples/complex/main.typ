#import "@preview/eac-typst-templates:0.1.0": templates
#import templates.slides.themes.neo: *

#title-slide(
  "Lorem Ipsum Dolor Sit Amet",
  subtitle: "Uma Apresentação de Exemplo Complexa",
  author: "Fulano de Tal",
  date: "2026"
)

#slide(title: "Sumário")[
  + Introdução
  + Um Tópico
  + Conclusão
  + Referências
]

#include "introduction.typ"
#include "a-topic.typ"
#include "conclusion.typ"
#include "references.typ"
