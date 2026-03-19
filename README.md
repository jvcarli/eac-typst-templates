# eac-typst-slides-template

Template para apresentações de slides do curso de [Engenharia Acústica](https://www.eac.ufsm.br/)
da [Universidade Federal de Santa Maria](https://www.ufsm.br/),
desenvolvido em [Typst](https://github.com/typst/typst).

## Estrutura do projeto

```
.
├── examples/
│   ├── complex/            # Exemplo com múltiplos arquivos
│   ├── simple.typ          # Exemplo em arquivo único
│   └── kitchen-sink.typ    # Demonstração completa de todas as funcionalidades
├── scripts/                # Scripts auxiliares para desenvolvimento do projeto
├── src/
│   └── lib.typ             # Código principal do template
├── justfile                # Definição de tasks de desenvolvimento, testes e distribuição
├── pixi.toml               # Configuração do Pixi
└── typst.toml              # Configuração do pacote eac-typst-slides-template
```

## Contribuindo

Contribuições são bem-vindas!
Isso inclui [reportar _bugs_ ou sugerir melhorias](https://github.com/jvcarli/eac-typst-slides-template/issues/new),
melhorar a documentação ou abrir um _pull request_ com modificações no código.

Este projeto usa o gerenciador de pacotes [Pixi](https://pixi.prefix.dev/latest/) para gerir as
dependências de desenvolvimento.

**Pré-requisitos de desenvolvimento:**
- [Git](https://git-scm.com/)
- Pixi

Com ambos instalados abra a shell de sua preferência e rode os comandos:

```shell
git clone https://github.com/jvcarli/eac-typst-slides-template
cd eac-typst-slides-template
pixi install
pixi shell
```

Abra o projeto no seu editor de preferência e modifique o que desejar.
Consulte os códigos da pasta examples/ para ver exemplos de utilização da biblioteca.
O arquivo examples/kitchen-sink.typ contém um exemplo de uso de todas as funcionalidades deste pacote.

## Licença

[MIT](./LICENSE.md)
