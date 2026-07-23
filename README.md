# CV

CV/résumé, written in [Typst](https://typst.app), single file (`main.typ`).

Built automatically by CI on every push to `trunk`. Download the latest PDF from the [latest release](https://github.com/stepbeekio/cv/releases/latest).

## Usage

```sh
just build   # compile to out/CV.pdf
just watch   # recompile on changes
just open    # build and open the PDF
just clean   # remove compiled output
```

Requires the `typst` CLI.
