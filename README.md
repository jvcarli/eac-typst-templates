# eac-typst-templates

Coleção de templates para apresentações de slides,
relatórios técnicos e laudos do curso de
[Engenharia Acústica](https://www.eac.ufsm.br/)
da [Universidade Federal de Santa Maria](https://www.ufsm.br/),
desenvolvidos em [Typst](https://github.com/typst/typst).

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
└── typst.toml              # Arquivo de manifesto com metadados do pacote
```

## Contribuindo

Contribuições são bem-vindas!
Isso inclui [reportar _bugs_ ou sugerir melhorias](https://github.com/jvcarli/eac-typst-templates/issues/new),
melhorar a documentação ou abrir um _pull request_ com modificações no código.

Este projeto usa o gerenciador de pacotes [Pixi](https://pixi.prefix.dev/latest/) para gerir as
dependências de desenvolvimento.

**Pré-requisitos de desenvolvimento:**
- [Git](https://git-scm.com/)
- [Pixi](https://pixi.prefix.dev/latest/)

Com ambos instalados abra a shell de sua preferência e rode os comandos:

```shell
git clone https://github.com/jvcarli/eac-typst-templates
cd eac-typst-templates
pixi shell
just setup
```

> [!NOTE]
> `pixi shell` instalará todas as dependências de desenvolvimento necessárias
> e o colocará em um ambiente de desenvolvimento com elas disponíveis.

> [!NOTE]
> O uso do [Just](https://github.com/casey/just) não é obrigatório.
> Ele é um _command runner_ utilizado para facilitar tarefas comuns de desenvolvimento.
> Caso prefira, é possível executar os comandos manualmente,
> basta consultar o arquivo [`justfile`](./justfile) para ver o que cada receita faz.
> O Just será instalado ao executar `pixi shell`.
> Você pode ver todas as receitas disponíveis digitando `just` ou `just --list`.

Abra o projeto no seu editor de preferência e modifique o que desejar.
Consulte os códigos da pasta examples/ para ver exemplos de utilização da biblioteca.
O arquivo examples/kitchen-sink.typ contém um exemplo de uso de todas as funcionalidades deste pacote.

## Licença

[MIT](./LICENSE.md)
