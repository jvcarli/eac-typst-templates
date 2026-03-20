#import "@preview/eac-typst-slides-template:0.1.0" as eac

#eac.slide(title: "Um Tópico")[
  Consectetur adipiscing elit, sed do eiusmod tempor.
  #v(0.5cm)
  + Primeira etapa do método
  + Segunda etapa do método
  + Terceira etapa do método
]

#eac.slide(title: "Resultados")[
  #figure(
    rect(width: 70%, height: 4cm, fill: luma(220)),
    caption: [Gráfico de resultados placeholder]
  )
  #v(0.3cm)
  Quis nostrud exercitation ullamco laboris nisi @lorem2020.
]
