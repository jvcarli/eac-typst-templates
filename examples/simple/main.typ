#import "@preview/eac-typst-templates:0.1.0" as eac

#eac.title-slide(
  "Título da Apresentação",
  subtitle: "Subtítulo opcional",
  author: "Autor",
  date: "2026"
)

#eac.slide(title: "Introdução")[
  - Primeiro ponto
  - Segundo ponto
  - Terceiro ponto
]

#eac.slide(title: "Conteúdo")[
  Parágrafo de exemplo com conteúdo principal do slide.
]

#eac.slide[
  Slide sem título, apenas conteúdo.
]
