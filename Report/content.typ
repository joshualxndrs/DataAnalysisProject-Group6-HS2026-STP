// THE TEXT OF THE REPORT. This is the only file to edit when writing.
//
// Each section is a #let name = [ ... ]; write full sentences inside the brackets.
// The layout (report.typ) places each section beside its figure, so the text must fit its row:
// the number of lines is given above each section (about 9 words per line). After writing,
// compile and check that the page is still one page.
//
// Numbers from the script are inserted with #n.name, never typed:
//   #n.n_total #n.cut #n.on_cut #n.net_missing #n.lonely_n #n.net_n #n.group_n
//   #n.n0 #n.n1 #n.sd0 #n.sd1 #n.diff #n.diff_lo #n.diff_hi #n.t #n.df #n.p
// (every name is in Working/Group6_InternetAndLoneliness/figures/report_numbers.csv)
// Group 1 is red everywhere: write it as #g1[above the mean]. Variable names in backticks: `fltlnl`.
// Do not repeat a number that the figure or table beside the text already shows; say what it means.
// Longer guidance per section: WRITING_NOTES.md.

#import "numbers.typ": n, g1

#let title = [Internet use and loneliness]
#let rq = [Is people's internet use associated with their feeling of loneliness?]
#let authors = [Gabriele Pizzi, Marlo (Clara) Roth, Ole Handschug, Joshua Silalahi]

// FINDINGS, 3 lines. Two sentences: the result in plain language, then what it means and the
// main caveat (regular internet users only; a mean split is a crude test). No numbers.
#let findings = [
  Among regular internet users in Switzerland, those #g1[above the mean] in self-reported time
  online report no more loneliness than those at or below it.
]

// DEPENDENT VARIABLE, 7 lines (beside Figure 1). Why `fltlnl`: the only item that asks about the
// feeling of loneliness itself (the others measure contact or mood). What Figure 1 shows: almost
// everyone in the lowest category, so little variation to explain. Limitations: one item, past
// week only, four coarse categories, self-reported.
#let dependent = [
  For our dependent variable, we chose `fltlnl` ("Felt lonely, how often past week", #box[1–4])
  as a proxy for the self-reported loneliness of our respondents. In ESS 11, it is the only item
  about the feeling of loneliness itself. Others like `fltdpr` and `fltsd` report bad feelings
  like depression or sadness, but no others report loneliness. The main limitation is the
  answer distribution of this variable (Figure 1). The vast majority report no loneliness, which
  leads to very little variation to explain and group differences being small.
]

// INDEPENDENT VARIABLE, 7 lines (beside Figure 2). Why `netustm`: minutes per day is continuous
// and spread out, while `netusoft` is "every day" for 80%. What Figure 2 shows: right-skewed,
// long tail, spikes at whole hours (people round). Limitations: includes work use, self-reported
// and heaped, asked only of people online most days (the #n.net_missing not asked stay missing).
#let independent = [
  `netustm` ("Internet use, how much time on typical day, in minutes") was chosen as the
  independent variable. While there are other variables like `netusoft` also reporting internet
  usage, `netustm` is continuous and further spread out. `netusoft` is coarser and four in five
  respondents answered with "every day". The answer distribution of `netustm` is shown in
  Figure 2. A major limitation is that this question was only asked of people who had
  previously reported using the internet most days or every day. This led to 168 respondents
  being skipped and never shown this question. Additionally, the reported time also
  includes work use.
]

// GROUPING, 4 lines (beside Figure 3). How the variable was made: split at the mean of
// #n.cut minutes, 1 = above, 0 = at or below, original variable kept, cut point one line in the
// script. Boundary: a value equal to the mean goes to group 0; #n.on_cut respondents sit on it.
// Why the groups are unequal: the skew pulls the mean above the median.
#let grouping = [
  In order to perform a t-test later on, a new grouping variable `net_group` was created,
  which splits `netustm` at its mean of #n.cut minutes. 1 is assigned to values #g1[above the
  mean], 0 for values exactly at or below the mean. No respondent sits exactly on the mean,
  and `netustm` itself is left unchanged. Because the mean of `netustm` lies above its median,
  fewer answers fall above it, which leads to groups of unequal size (Figure 3).
]

// DESCRIPTIVES, 9 lines (beside Table 1). Read the table back without copying it: recoding from
// text labels to numbers; the DV's median, mode and IQR all at the bottom of the scale; the IV's
// mean far above its median and an SD close to the mean (strong skew); the mode of 120 minutes
// reflects rounding to whole hours; who is missing and why.
#let descriptives = [
  After recoding the text labels in the CSV to numbers (Table 1), for `fltlnl` median, mode, and IQR
  are all at the bottom of the scale, while for `netustm` the mean is far above the median
  (#n.net_mean against #n.net_median). Looking at its distribution, it is strongly right-skewed and
  answers also heap at whole hours, but the split at the mean still produced two sufficiently
  large groups (Figure 3).
]

// TEST, 3 lines (beside the group N and SD). Which test and why: Welch's two-sample t-test, two
// independent groups of unequal size and spread, no equal-variance assumption. H0 in words.
#let test = [
  We chose to use Welch's two-sample t-test, which is the default of R. This works well
  because our groups are independent, unequal in size and spread, and Welch does not assume
  equal variances.
]

// INTERPRETATION, 8 lines (beside Figure 4, under Figure 5). Four things: which groups and their
// means (point to Figure 4); the difference, its direction and that it is not significant (the
// numbers are in Figure 4's caption); the plain-language meaning; the cut-point limitation, using
// Figure 5 (the split ignores all variation within the groups; Report 2 uses the minutes in full).
#let interpretation = [
  To answer our research question, the t-test compares the mean self-reported loneliness of
  the two groups (Figure 4). Respondents #g1[above the mean] report slightly more loneliness
  than those at or below it, but the difference is very small and not statistically
  significant. For regular internet users in Switzerland, time spent online therefore tells us
  almost nothing about the reported feeling of loneliness. A limitation is the cut point
  itself, since splitting at the mean only compares two group averages and ignores all
  variation within each group. Figure 5 displays all respondents' reported answers. It shows
  that loneliness is spread similarly across both sides of the cut. In Report 2, the regression
  will use `netustm` as a continuous variable instead of the split.
]
