# 2. Workflow Disagregasi dan Perhitungan
clean_data <- raw_data %>%
  # Langkah Kunci: Memecah string layanan menjadi baris terpisah
  separate_longer_delim(layanan_diterima, delim = "; ") %>%
  # Menghitung Nilai Rata-rata (NRR) per Unsur untuk tiap Layanan
  group_by(layanan_diterima) %>%
  summarise(
    across(U1:U9, mean,.names = "NRR_{.col}"),
    n_responden = n()
  ) %>%
  # Menghitung NRR Tertimbang (Bobot 1/9 = 0.111)
  mutate(
    # Penjumlahan NRR * 0.111
    IKM_Unit = rowSums(across(starts_with("NRR_")) * 0.111),
    # Konversi ke skala 100
    IKM_Konversi = IKM_Unit * 25
  ) %>%
  # Menambahkan Predikat sesuai Permenpan 14/2017
  mutate(
    Mutu = case_when(
      IKM_Konversi >= 88.31 ~ "A (Sangat Baik)",
      IKM_Konversi >= 76.61 ~ "B (Baik)",
      IKM_Konversi >= 65.00 ~ "C (Kurang Baik)",
      TRUE ~ "D (Tidak Baik)"
    )
  )

print(clean_data)
