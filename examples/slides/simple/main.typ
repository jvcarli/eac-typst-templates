#import "@preview/touying:0.7.3": *
#import "@preview/eac-typst-templates:0.1.0": templates
#import templates.slides.themes.neo: *

#show: neo-theme.with(
  config-info(
    title: [Apresentação simples],
    // Você pode passar uma lista de autores.
    author: (
      "Fulano de Tal",
    ),
    date: "31 de março de 2026",
  ),
)

#title-slide()

== Introdução

- Primeiro ponto
- Segundo ponto
- Terceiro ponto

== Conteúdo

Parágrafo de exemplo com conteúdo principal do slide.

== Fim

Obrigado!
