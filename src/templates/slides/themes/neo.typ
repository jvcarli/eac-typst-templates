// NEO THEME — lib.typ
#import "@preview/touying:0.7.3": *

// --- 1. CONFIGURAÇÕES PADRÃO (FIEL AO V9) ---
#let _default-colors = (
  bg:          rgb("#FAFAF8"),
  text:        rgb("#1A1A2E"),
  accent:      rgb("#2E7D5E"),
  muted:       rgb("#6B7280"),
  bar-bg:      rgb("#E8F3ED"),
  bar-border:  rgb("#2E7D5E"),
  divider-bg:  rgb("#2E7D5E"),
)

#let _default-scale = (
  title:    44pt,
  subtitle: 20pt,
  heading:  32pt,
  body:     18pt,
  caption:  12pt,
  bar:      10pt,
)

#let _default-layout = (
  bar-h: 8mm,
  pad-x: 16mm,
  pad-y: 12mm,
)

#let c-accent  = _default-colors.accent
#let c-muted   = _default-colors.muted
#let t-caption = _default-scale.caption

// --- 2. PARSER DE AUTORES (HIERARQUIA REFINADA) ---
#let _format-author-content(it) = {
  if it == none { return none }
  let items = if type(it) == array { it } else { (it,) }

  grid(
    columns: range(items.len()).map(_ => 1fr),
    column-gutter: 1em,
    ..items.map(p => {
      if type(p) == str {
        let parts = p.trim().split(" ")
        let email = parts.filter(pt => pt.contains("@")).at(0, default: none)
        let name = parts.filter(pt => not pt.contains("@")).join(" ")
        
        align(center)[
          #text(size: 22pt, weight: "semibold")[#name] 
          #if email != none {
            v(2mm)
            // Email em 12pt para não brigar com o nome
            text(size: 12pt, fill: _default-colors.muted)[#email]
          }
        ]
      } else {
        align(center)[#text(size: 22pt, weight: "semibold")[#p]]
      }
    })
  )
}

// --- 3. COMPONENTES DE INTERFACE ---
#let _header-title(self) = {
  let c = self.store.colors; let s = self.store.scale; let l = self.store.layout
  rect(width: 100%, height: l.bar-h, fill: c.bar-bg, stroke: (bottom: 0.5pt + c.bar-border), inset: (x: 6mm, y: 0mm))[
    #align(horizon)[#grid(columns: (1fr, 1fr),
      align(left, text(size: s.bar, fill: c.muted, weight: "semibold")[#utils.call-or-display(self, self.store.course-code)]),
      align(right, utils.call-or-display(self, self.store.logo))
    )]
  ]
}

#let _header-content(self) = {
  let c = self.store.colors; let s = self.store.scale; let l = self.store.layout
  rect(width: 100%, height: l.bar-h, fill: c.bar-bg, stroke: (bottom: 0.5pt + c.bar-border), inset: (x: 6mm, y: 0mm))[
    #align(horizon)[#grid(columns: (1fr, 2fr, 1fr),
      align(left, text(size: s.bar, fill: c.muted, weight: "semibold")[#utils.call-or-display(self, self.store.course-code)]),
      align(center, text(size: s.bar, fill: c.accent, weight: "semibold")[#self.info.title]),
      align(right, utils.call-or-display(self, self.store.logo))
    )]
  ]
}

#let _footer(self) = {
  let c = self.store.colors; let s = self.store.scale; let l = self.store.layout
  rect(width: 100%, height: l.bar-h, fill: c.bar-bg, stroke: (top: 0.5pt + c.bar-border), inset: (x: 6mm, y: 0mm))[
    #align(horizon)[#grid(columns: (1fr, 1fr, 1fr),
      align(left, text(size: s.bar, fill: c.muted)[#utils.display-current-heading(level: 1)]),
      [],
      align(right, context text(size: s.bar, fill: c.muted)[#counter(page).display() / #utils.last-slide-number])
    )]
  ]
}

// --- 4. DEFINIÇÃO DE SLIDES ---
#let slide(config: (:), repeat: auto, setting: body => body, composer: auto, ..bodies) = touying-slide-wrapper(self => {
  let c = self.store.colors; let s = self.store.scale; let l = self.store.layout
  let self = utils.merge-dicts(self, config-page(fill: c.bg, header: _header-content, footer: _footer), config-common(subslide-preamble: self.store.subslide-preamble))
  let new-setting = body => { set text(fill: c.text, size: s.body); show: setting; pad(x: l.pad-x, top: l.pad-y, bottom: l.pad-y, body) }
  touying-slide(self: self, config: config, repeat: repeat, setting: new-setting, composer: composer, ..bodies)
})

#let title-slide(config: (:), extra: none, ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-common(freeze-slide-counter: false), config-page(fill: self.store.colors.bg, header: _header-title, footer: none), config)
  let info = self.info + args.named(); let c = self.store.colors; let s = self.store.scale
  touying-slide(self: self, { align(center + horizon)[
    #v(40mm)
    #text(size: s.title, fill: c.text, weight: "bold")[#info.title]
    #v(4mm) #line(length: 80mm, stroke: 0.5pt + c.accent) #v(6mm)
    
    #if info.subtitle != none and info.subtitle != [] { 
      text(size: s.subtitle, fill: c.muted)[#info.subtitle]
      v(10mm) 
    }
    
    #_format-author-content(info.author)
    
    // Data em 12pt para manter a elegância "classic"
    #v(12mm) #if info.date != none { text(size: 12pt, fill: c.muted)[#utils.display-info-date(self)] }
    #if extra != none { v(4mm); text(size: 12pt, fill: c.muted)[#extra] }
  ]})
})

#let divider-slide(level: 1, numbered: true, config: (:), body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-page(fill: self.store.colors.divider-bg, header: none, footer: none), config)
  let c = self.store.colors; let s = self.store.scale
  let slide-body = { set std.align(center + horizon); set text(size: s.title, fill: white, weight: "bold")
    utils.display-current-heading(level: level, numbered: numbered)
    v(4mm); line(length: 40mm, stroke: 0.5pt + white.transparentize(50%)) }
  touying-slide(self: self, config: config, slide-body)
})

#let toc-slide(image-content: none, title: [Sumário], config: (:)) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-page(fill: self.store.colors.bg, header: none, footer: none), config)
  let c = self.store.colors; let s = self.store.scale; let l = self.store.layout
  touying-slide(self: self, { pad(top: -l.bar-h, bottom: -l.bar-h)[
    #grid(columns: (1fr, 1fr), gutter: 0mm,
      pad(left: l.pad-x, right: l.pad-x/2, y: 20mm)[
        #text(size: s.heading, weight: "bold")[#title] #v(2mm)
        #line(length: 100%, stroke: 0.5pt + c.bar-border) #v(5mm)
        #set enum(numbering: n => text(fill: c.accent, weight: "semibold")[#n.])
        #outline(title: none, indent: 0em, depth: 1)
      ],
      if image-content != none { set std.image(width: 100%, height: 100%, fit: "cover"); image-content }
    )]
  })
})

#let thanks-slide(name: none, email: none, github: none, image-content: none, config: (:)) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-page(fill: self.store.colors.bg, header: none, footer: none), config)
  let c = self.store.colors; let s = self.store.scale; let l = self.store.layout
  touying-slide(self: self, { pad(top: -l.bar-h, bottom: -l.bar-h)[
    #grid(columns: (1fr, 1.2fr), gutter: 0mm,
      pad(x: l.pad-x, y: 20mm)[
        #text(size: s.heading, weight: "bold", fill: c.text)[Obrigado!] #v(2mm)
        #line(length: 100%, stroke: 0.5pt + c.bar-border) #v(12mm)
        #set align(left)
        #if name != none { text(size: 18pt, weight: "semibold", fill: c.accent)[#name]; v(1mm); line(length: 30%, stroke: 0.5pt + c.accent); v(6mm) }
        #set text(size: 14pt, fill: c.muted)
        #stack(spacing: 16pt,
          if email != none { grid(columns: (7mm, 10pt, 1fr), align(center+horizon, image("../../../../assets/icons/heroicon_solid_envelope.svg", width: 5.5mm)), [], align(horizon, link("mailto:"+email)[#email])) },
          if github != none { grid(columns: (7mm, 10pt, 1fr), align(center+horizon, image("../../../../assets/icons/GitHub_Invertocat_Black.svg", width: 5.5mm)), [], align(horizon, link("https://github.com/"+github)[github.com/#github])) }
        )
      ],
      if image-content != none { set std.image(width: 100%, height: 100%, fit: "cover"); image-content } else { rect(width: 100%, height: 100%, fill: c.bar-bg) }
    )]
  })
})

// --- 5. FUNÇÃO DO TEMA ---
#let neo-theme(course-code: "", logo: none, authors-block: none, colors: (:), scale: (:), layout: (:), ..args, body) = {
  let c = utils.merge-dicts(_default-colors, colors); let s = utils.merge-dicts(_default-scale, scale); let l = utils.merge-dicts(_default-layout, layout)
  set text(lang: "pt", region: "BR", font: "Source Sans Pro", size: s.body, fill: c.text)
  set par(leading: 0.65em)
  show: touying-slides.with(
    config-page(width: 256mm, height: 192mm, margin: (top: l.bar-h, bottom: l.bar-h, x: 0mm), header-ascent: 0%, footer-descent: 0%),
    config-common(slide-fn: slide, new-section-slide-fn: divider-slide),
    config-methods(alert: utils.alert-with-primary-color),
    config-store(colors: c, scale: s, layout: l, course-code: course-code, logo: logo, authors-block: authors-block,
      subslide-preamble: self => {
        let c = self.store.colors; let s = self.store.scale; let h = utils.display-current-heading(depth: self.slide-level)
        if h != none and h != [] { text(size: s.heading, weight: "bold", fill: c.text)[#h]; v(2mm); line(length: 100%, stroke: 0.5pt + c.bar-border); v(5mm) }
      }
    ), ..args
  ); body
}
