#import "@preview/eac-typst-slides-template:0.1.0" as eac

#eac.title-slide(
  "Título: EAC Typst Slides Template - Kitchen Sink",
  subtitle: "Subtítulo: teste da funcionalidade total do pacote",
  author: "Autores",
  date: "data"
)

#eac.slide(title: "Introdução")[
  Slide simples
  #v(1cm)
  - Lista
  - Proporção de tela _16:9_
]

#eac.slide(title: "Funcionalidades")[
  Enumeração com as funcionalidades do pacote.
  #v(0.5cm)
  + Slides de título
  + Slides de conteúdo com títulos opcionais
  + Formatação limpa
  + Configuração de página adequada
]

#eac.slide[
  Slide sem título.
  #v(1cm)
  Apenas conteúdo.
]
