# 3. Visualisasi Hasil
ggplot(clean_data, aes(x = layanan_diterima, y = IKM_Konversi, fill = Mutu)) +
  geom_col(color = "black", width = 0.7) +
  geom_text(aes(label = round(IKM_Konversi, 2)), vjust = -0.5, fontface = "bold") +
  scale_fill_manual(values = c("A (Sangat Baik)" = "#2ecc71", "B (Baik)" = "#3498db")) +
  labs(
    title = "Indeks Kepuasan Masyarakat (IKM) per Jenis Layanan",
    subtitle = "Hasil Atribusi Data Agregat (Workflow R)",
    x = "Jenis Layanan",
    y = "Nilai IKM (Skala 100)",
    caption = "Sumber: Simulasi Data Google Form - Standar Permenpan RB 14/2017"
  ) +
  theme_minimal() +
  ylim(0, 100)
