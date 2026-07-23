out := "out/CV.pdf"

# Compile the CV to PDF
build:
    typst compile main.typ {{out}}

# Recompile on changes
watch:
    typst watch main.typ {{out}}

# Open the compiled PDF
open: build
    xdg-open {{out}}

# Remove compiled output
clean:
    rm -f {{out}}
