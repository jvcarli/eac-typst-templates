#import "@preview/touying:0.7.3": *
#import "@preview/eac-typst-templates:0.1.0": templates
#import templates.slides.themes.neo: *

#show: neo-theme.with(
  course-code: [EAC1032 -- Auralização],
  logo: image("../../../assets/logos/eac_ufsm.svg", height: 5mm),

  config-info(
    title: [Lorem Ipsum Dolor Sit Amet],
    subtitle: "Uma Apresentação de Exemplo Complexa",

    // Você pode passar uma lista de autores.
    author: (
      "Fulano de Tal fulano.detal@email.com",
    ),
    date: "31 de março de 2026",
  ),
)

#title-slide()

#outline()

#include "introduction.typ"
#include "a-topic.typ"
#include "conclusion.typ"
#include "references.typ"
