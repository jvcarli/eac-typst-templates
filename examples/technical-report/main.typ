#import "@preview/eac-typst-templates:0.1.0": templates

#show: templates.technical-report.with(
  course-code: "EAC1234",
  course-name: "Disciplina Tal",
  subtitle: [Relatório Técnico --- Tema X],
  authors: ("Fulano de Tal", "Fulana de Tal"),
  institution: ("Universidade Federal de Santa Maria", "Centro de Tecnologia"),
  date: datetime.today(),
)

= Introdução

#lorem(50)
