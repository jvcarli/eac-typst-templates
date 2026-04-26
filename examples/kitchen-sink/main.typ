#import "@preview/eac-typst-templates:0.1.0": templates
#import templates.slides.themes.neo: *

#title-slide(
  "Título: EAC Typst Slides Template - Kitchen Sink",
  subtitle: "Subtítulo: teste da funcionalidade total do pacote",
  author: "Autores",
  date: "data"
)

#slide(title: "Introdução")[
  Slide simples
  #v(1cm)
  - Lista
  - Proporção de tela _16:9_
]

#slide(title: "Funcionalidades")[
  Enumeração com as funcionalidades do pacote.
  #v(0.5cm)
  + Slides de título
  + Slides de conteúdo com títulos opcionais
  + Formatação limpa
  + Configuração de página adequada
]

#slide[
  Slide sem título.
  #v(1cm)
  Apenas conteúdo.
]
