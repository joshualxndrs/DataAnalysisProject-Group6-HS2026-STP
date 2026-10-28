// THE LAYOUT of the report: one page, figures beside the text that reads them.
// The text lives in content.typ (edit that file to write); the numbers come from numbers.typ.
//
// Build: run Working/Group6_InternetAndLoneliness/Exploration_00.R first (it writes the figures and
// the numbers to its figures/ folder), then from the repo root:
//   typst compile --root . --font-path Report/fonts Report/report.typ
// Fonts: ABC Areal for text, ABC Areal Mono for variable names and labels, read from Report/fonts.
// If that folder is empty Typst falls back to Arial and Courier New.

#import "numbers.typ": out, n, g1, red
#import "content.typ": *

// grid: unit X = page width / 135, which is the x-height of the text. one line = 2.5X.
// 6 columns of 16X with 3X gutters and 12X margins; labels take 1 column, text 3, figures 2.
#let X = 595.28pt / 135
#let u = 2.5 * X
#let gut = 3 * X
#let col = 16 * X
#let margin = 12 * X
#let span(k) = k * col + (k - 1) * gut
#let col-a = 13 * X
#let col-b = span(3) + 6 * X + 3 * X
#let col-c = span(2)
#let lines = 66
#let text-size = X / 0.519             // ABC Areal's x-height is 0.519 em
#let small-size = 5 / 6 * text-size
#let title-size = 1.5 * u / 0.716
#let drop = 0.6 * X                    // the baseline sits this far above the bottom of its line

#let ink = rgb("#1a1a1a")
#let grey = luma(42%)
#let sans = ("ABC Areal", "Arial")
#let mono = ("ABC Areal Mono", "Courier New")

#set page(paper: "a4",
  // the body is exactly `lines` lines tall; 297mm is A4, the 0.01pt keeps rounding from breaking the last row
  margin: (left: margin, right: margin, top: margin, bottom: 297mm - margin - lines * u - 0.01pt),
  footer-descent: 0pt,
  footer: text(size: small-size, fill: grey, font: mono,
    grid(columns: (col-a, col-b, col-c), column-gutter: gut, row-gutter: 0pt,
      grid.cell(colspan: 3, v(u)),                            // one empty line between the body and the credits
      [Authors], authors, [Data Analysis for Public Policy \ ETH Zürich, HS2026])))
#set text(font: sans, size: text-size, fill: ink, top-edge: u - drop, bottom-edge: -drop, lang: "en")
#set par(leading: 0pt, spacing: 0pt)
#set block(spacing: 0pt)
#show raw: set text(font: mono, size: 1.25em)

#let tag(body) = text(font: mono, fill: grey, size: small-size, body)   // labels in the left column
#let small(body) = text(size: small-size, number-width: "tabular", body)
#let fig(caption, file, height, width: col-c) = small({      // height in lines
  block(width: width, caption)
  block(image(out + file, width: width, height: height * u, fit: "contain"))
})
#let tbl(..cells) = small(table(columns: (1.6fr, 1fr, 1fr), stroke: none, inset: 0pt,
  align: (left, right, right), ..cells))
#let rule = table.hline(stroke: 0.4pt)

#grid(
  columns: (col-a, col-b, col-c),
  column-gutter: gut,
  row-gutter: u,                                      // one empty line between rows

  // title
  tag[Report 1 \ Group 6],
  grid.cell(colspan: 2, text(size: title-size, top-edge: 2 * u - drop, bottom-edge: -drop, title)),


  // findings
  tag[Findings],
  findings,
  small(text(fill: grey)[European Social Survey Round 11 \ Switzerland, 2023 \ N #n.n_total respondents]),

  // 1 variables
  small[1 Variables \ #tag[Dependent \ `fltlnl`]],
  dependent,
  fig([Figure 1 Self-reported loneliness, past week], "fig1_lonely.svg", 6),

  tag[Independent \ `netustm`],
  independent,
  fig([Figure 2 Self-reported minutes online per day], "fig2_internet.svg", 6),

  // 2 grouping
  small[2 Grouping \ #tag[`net_group`]],
  grouping,
  fig([Figure 3 Groups, N #n.group_n, mode #n.group_mode], "fig3_groups.svg", 3),

  // 3 descriptives
  small[3 Descriptives],
  descriptives,
  tbl(
    [Table 1], `fltlnl`, `netustm`, rule,
    [Valid N],  n.lonely_n,      n.net_n,
    [Mean],     n.lonely_mean,   n.net_mean,
    [Median],   n.lonely_median, n.net_median,
    [Mode],     n.lonely_mode,   n.net_mode,
    [Variance], n.lonely_var,    n.net_var,
    [SD],       n.lonely_sd,     n.net_sd,
    [Range],    n.lonely_range,  n.net_range,
    [IQR],      n.lonely_iqr,    n.net_iqr, rule,
  ),

  // 4 test
  small[4 Test],
  test,
  tbl(
    [Group], [N], [SD], rule,
    [0 at or below], n.n0, n.sd0,
    g1[1 above], g1(n.n1), g1(n.sd1),
  ),

  // figure 5 across the text and figure columns
  tag[Figure 5],
  grid.cell(colspan: 2, fig([Every respondent, self-reported loneliness (1–4, jittered) by self-reported minutes online, #g1[red above the mean]], "fig5_scatter.svg", 4, width: col-b + gut + col-c)),

  // 5 interpretation
  small[5 Interpretation],
  interpretation,
  fig([Figure 4 Mean self-reported loneliness, 95% CI \ Welch #g1[1] − 0: #n.diff (#n.diff_lo to #n.diff_hi) \ t #n.t, df #n.df, p #n.p], "fig4_means.svg", 5),
)
