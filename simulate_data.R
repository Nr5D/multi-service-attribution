# Load library
library(tidyverse)

# 1. Simulasi Data Raw dari Google Form
set.seed(123)
services <- c("Layanan A", "Layanan B", "Layanan C", "Layanan D", "Layanan E")

raw_data <- tibble(
  respondent_id = 1:15,
  # Simulasi pilihan multiple answer (separator semicolon)
  layanan_diterima = replicate(15, paste(sample(services, sample(1:3, 1)), collapse = "; ")),
  # Simulasi jawaban 9 unsur (Skala 1-4)
  U1 = sample(1:4, 15, replace = TRUE, prob = c(0.05, 0.1, 0.4, 0.45)), # Persyaratan
  U2 = sample(1:4, 15, replace = TRUE, prob = c(0.05, 0.15, 0.4, 0.4)), # Prosedur
  U3 = sample(1:4, 15, replace = TRUE, prob = c(0.1, 0.2, 0.4, 0.3)),  # Waktu
  U4 = sample(1:4, 15, replace = TRUE, prob = c(0.05, 0.05, 0.2, 0.7)), # Biaya
  U5 = sample(1:4, 15, replace = TRUE, prob = c(0.05, 0.1, 0.4, 0.45)), # Produk
  U6 = sample(1:4, 15, replace = TRUE, prob = c(0.05, 0.1, 0.5, 0.35)), # Kompetensi
  U7 = sample(1:4, 15, replace = TRUE, prob = c(0.05, 0.05, 0.4, 0.5)), # Perilaku
  U8 = sample(1:4, 15, replace = TRUE, prob = c(0.1, 0.2, 0.5, 0.2)),  # Pengaduan
  U9 = sample(1:4, 15, replace = TRUE, prob = c(0.05, 0.1, 0.4, 0.45))  # Sarpras
)

print(head(raw_data))
