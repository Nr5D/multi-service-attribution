# One Rating, Multiple Services

**Solving the 100-Service Dilemma: Automated Attribution for Multi-Service Public Satisfaction Surveys**

🎤 Presented as a **Lightning Talk** at **useR! 2026** — Virtual Presentation Room
📁 Topic: *Applications → Case studies and applications*

---

## The Problem

Indonesian regulation ([Permenpan RB 14/2017](https://peraturan.bpk.go.id/Details/132600/permen-pan-rb-no-14-tahun-2017)) requires every public service to be scored on **9 quality components** (procedures, cost, staff competence, facilities, etc.). This is manageable for a single service — but government can offer **hundreds of services** under one roof.

Asking each visitor to rate every service they used, on all 9 components, separately, means hundreds of repetitive answers per person — leading to severe respondent fatigue and poor data quality.

## The Approach

Instead of one form per service, respondents:
1. Check off **every service they received** in a single visit (e.g., *Service A; Service B; Service E*)
2. Give **one holistic rating** across the 9 components, based on their overall experience

This matches how people actually experience a visit — and shifts the challenge from survey design to a data engineering problem: turning one combined rating into accurate, per-service scores.

## The Solution: Disaggregate → Attribute

Google Forms exports multi-select answers as a single semicolon-separated string. This repository provides a minimal `{tidyverse}` pipeline that:

1. **Disaggregates** — `tidyr::separate_longer_delim()` explodes one response row into multiple rows, one per selected service, copying the same ratings to each
2. **Attributes** — `group_by()` + `summarise()` averages every rating that touched a given service, across all respondents who used it (alone or combined with others)
3. **Scores** — applies the official Permenpan RB weighting (`0.111` per component, scaled to 100) to produce a compliant satisfaction index per service

```r
clean_data <- raw_data %>%
  separate_longer_delim(services, delim = "; ") %>%   # 1. disaggregate
  group_by(services) %>%
  summarise(across(U1:U9, mean), n = n()) %>%          # 2. attribute
  mutate(
    IKM = rowSums(across(starts_with("U")) * 0.111) * 25  # 3. score
  )
```

No respondent ever fills in more than one rating block, and the same 4-line pipeline scales from 5 services to 500+ without any code changes.

## Repository Contents

| File | Description |
|---|---|
| `simulate_data.R` | Generates example survey data (Google Form–style export, 15 respondents, Services A–E) |
| `attribution_pipeline.R` | The disaggregate → attribute → score workflow |
| `visualize_results.R` | Bar chart of satisfaction index per service |
| `sample_data.csv` | Example raw export with semicolon-separated multi-select responses |

## Requirements

```r
install.packages("tidyverse")
```

## Usage

```r
source("simulate_data.R")
source("attribution_pipeline.R")
source("visualize_results.R")
```

## Methodology Notes

- Validity relies on proper response tracking: each respondent's row is duplicated across every service they selected, so every service receives contributions only from respondents who actually experienced it.
- Cross-cutting components (e.g., facility quality, staff competence) are often perceived holistically by users, which supports rating them once per visit rather than once per service.
- This approach maintains regulatory compliance with Permenpan RB 14/2017 while substantially reducing respondent burden.

## Presentation

- **Format:** Lightning Talk (5 minutes)
- **Venue:** useR! 2026, Virtual Presentation Room (Aula VI (SGH Warsaw School of Economics))
- **Slides & speaker notes:** see [`/slides`](./slides) in this repo

## Authors

- [Abdul Aziz Nurussadad](https://events.digital-research.academy/event/109/contributions/489/author/632) — Badan Informasi Geospasial
- [Akbar Rizki](https://events.digital-research.academy/event/109/contributions/489/author/633) — IPB University

## Citation

If you use this pipeline or reference this talk, please cite:

```
Nurussadad, A. A., & Rizki, A. (2026). One Rating, Multiple Services: Solving the
100-Service Dilemma — Automated Attribution for Multi-Service Public Satisfaction
Surveys. Lightning Talk, useR! 2026, Virtual Presentation Room.
Code: https://github.com/Nr5D/multi-service-attribution
```


## License

MIT
