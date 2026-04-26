#import "@preview/eac-typst-templates:0.1.0": templates
#import templates.slides.themes.neo: *

#title-slide(
  "Título da Apresentação",
  subtitle: "Subtítulo opcional",
  author: "Autor",
  date: "2026"
)

#slide(title: "Introdução")[
  - Primeiro ponto
  - Segundo ponto
  - Terceiro ponto
]

#slide(title: "Conteúdo")[
  Parágrafo de exemplo com conteúdo principal do slide.
]

#slide[
  Slide sem título, apenas conteúdo.
]
