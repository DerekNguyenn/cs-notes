# cs-notes
Comprehensive personal notes for programming and data science. Currently includes R and Python programming.

**Live site:** https://dereknguyenn.github.io/cs-notes/

## Site Guide

Standard procedures for maintaining pages on this site. The same guide is on the site: [Site Guide](https://dereknguyenn.github.io/cs-notes/guide.html).

**Current workflow**:

1. Write in **RStudio**
2. Commit and Push from **VS Code**, and let **GitHub Pages** serve the `docs/` folder.

> [!WARNING]
> Changes are made in Quarto (.qmd) documents and .yaml only! You should never have to modify an HTML file directly.

### Publishing Changes

Committing doesn't publish anything. GitHub serves whatever is in `docs/`, so the order is **render → commit → push**.

1. **Render** in RStudio: **Build → Render Website** (or `quarto render` in the terminal). This rebuilds `docs/` and the course PDFs.
2. **Commit** in VS Code: Source Control (Cmd + Shift + G) → stage everything, including `docs/` and `_freeze/` → write a message → **Commit**.
3. **Push** in VS Code: **Sync Changes**.
4. **Wait about a minute** while GitHub rebuilds the site. Watch it under the repo's **Actions** tab ("pages build and deployment"), then hard-refresh with Cmd + Shift + R.

> [!WARNING]
> If I edit a `.qmd` but skip rendering, the live site won't change, because `docs/` still has the old version.

- The **Render** button on a single file only previews that page. It doesn't rebuild the course PDF.
- Save in RStudio before committing: VS Code only sees saved changes.

### Adding a New Section

Example: adding a course called `math208` with its own navbar entry and sidebar.

#### 1. Create the folder and a landing page

`math208/index.qmd`:

```markdown
---
title: "MATH 208: Course Name"
subtitle: "UW Bothell · Winter 2027"
toc: false
---

Notes for MATH 208.
```

#### 2. Add it to the navbar

In `_quarto.yml`, under `website: navbar: left:`

```yaml
      - href: math208/index.qmd
        text: MATH 208
```

#### 3. Give it its own sidebar

In `_quarto.yml`, under `website: sidebar:`, next to the existing `bdata200` and `bdata232` entries:

```yaml
    - id: math208
      title: "MATH 208"
      style: docked
      contents:
        - href: math208/index.qmd
          text: Course home
        - href: math208/week1.qmd
          text: Week 1
```

Every page listed in a sidebar's `contents` gets that sidebar. A new page that isn't listed in any sidebar has none.

#### 4. Optional extras

- Add a row for it to the Courses table on the home page (`index.qmd`)
- **Python pages:** use Python code chunks (```` ```{python} ```` instead of ```` ```{r} ````) in a `.qmd`, or drop in a Jupyter notebook (`.ipynb`). Everything else works the same way.

### Breaking Up a Page

#### Headings

Each `##` and `###` heading becomes a section in the "On this page" list on the right:

```markdown
## Big section

### Smaller part of that section

#### Even smaller (doesn't show in "On this page")
```

#### Section IDs for linking

Give a heading an ID to link straight to it:

```markdown
## Trend Lines {#trend-lines}
```

Then link to it from another page with `[see trend lines](plots.qmd#trend-lines)`.

#### Grouping pages in the sidebar

Use `section:` in `_quarto.yml`. This is how B DATA 200 has "Wrangling", "Visualizing & Modeling" and so on:

```yaml
        - section: "Wrangling"
          contents:
            - href: bdata200/joins.qmd
              text: Joins
```

#### Tabs and callouts

```markdown
::: {.panel-tabset}
## R
R version here
## Python
Python version here
:::

::: {.callout-note}
A highlighted note box.
:::
```

### PDF Exports

B DATA 200 pages also go into the printable PDF (`bdata200/bdata200-notes.qmd`) as a backup in case of a site render error.

- **Page titles:** pages use `pagetitle:` at the top plus a `# Heading` line, not `title:`. A `title:` will overwrite the PDF's title.

- **New chapters:** a new 200 chapter needs three things:

  1. the `.qmd` file in `bdata200/`

  2. a sidebar entry in `_quarto.yml`

  3. an include line in `bdata200/bdata200-notes.qmd`:

     ```markdown
     {{< include newfile.qmd >}}
     ```

  Without step 3, the chapter shows on the site but not in the PDF.

Other sections (232, Python, new courses) can use plain `title:` unless they get a printable PDF too. If they do, copy the setup in `bdata200/bdata200-notes.qmd`.
