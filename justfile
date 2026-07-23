# Compile the CV to PDF
build:
    mkdir -p out
    typst compile main.typ out/CV.pdf

# Recompile on changes
watch:
    typst watch main.typ out/CV.pdf

# Open the compiled PDF
open: build
    xdg-open out/CV.pdf

# Remove compiled output
clean:
    rm -f out/CV.pdf
