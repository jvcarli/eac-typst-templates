#import "@preview/touying:0.7.3": *
#import "@preview/eac-typst-templates:0.1.0": templates
#import templates.slides.themes.neo: *

#show: neo-theme.with(
  course-code: [EAC1234 --- Nome da disciplina],
  // logo: image("assets/logos/eac_ufsm.svg", height: 5mm),

  config-info(
    title: [EAC Typst Slides Template --- Kitchen Sink],
    subtitle: "Subtítulo: exemplo de uso de todas as funcionalidades do tema Neo",
    // Você pode passar uma lista de autores.
    author: (
      "Autor 1 autor1@email.com.br",
      "Autor 2 autor2@email.com.br",
      "Autor 3 autor2@email.com.br",
    ),
    date: [*Inclusão de data*: _N_ de mês _tal_ de 20XY],
  ),
)

#title-slide()

#outline()

= Primeira seção

== Primeiro Slide

Exemplo de slide muito simples.

- Tópico A
- Tópico B

+ Item
  + Sub item
    + Subsub item
    + Subsub item
  + Sub item
+ Enumeração

= Segunda seção

== Segundo Slide

#slide[
  Primeira coluna.
][
  Segunda coluna.
]

#slide[
  Novo slide, mas note que o título foi mantido.

  A paginação está correta. Olhe no canto inferior direito.
]

= Exemplos mais avançados

== _Override_ de opções

- _Bullet_ comum
- Outro _bullet_

Usaremos:

```typst
// Mudando o marcador do bullet de bolinha para seta.
#set list(marker: text(fill: c-accent)[▸], indent: 2mm, body-indent: 3mm)
```

// Aqui temos o código que é executado para
// Função #set do typst (VEJA: https://typst.app/docs/reference/styling/)
#set list(marker: text(fill: c-accent)[▸], indent: 2mm, body-indent: 3mm)

para alterar opções de formatação da apresentação.

- _Bullets_ viram seta
- Outro _bullet_
  - Subitem

*NOTA*: não é usual nem boa prática mudar estilos no meio do documento, mas isso é uma funcionalidade presente no Typst, que pode ser usada normalmente.
