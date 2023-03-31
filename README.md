Run this Bash script to turn `src/hello.md` into a PDF located at `out/hello.pdf`:

```bash
./build.sh
```

Any arguments passed to that script will be relayed to Pandoc. For example:

```bash
# Turns src/hello.md into a PDF located somewhere else
./build.sh --output=/somewhere/else/hello.pdf
```

```bash
# Turns src/hello.md into an HTML file
./build.sh --output=/out/hello.html
```