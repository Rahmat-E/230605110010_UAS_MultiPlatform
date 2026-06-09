#  Note-Taking App (Flutter - BAB 4)

Aplikasi **Note-Taking sederhana berbasis Flutter** yang menyimpan data menggunakan **file system (dart:io)**.
Project ini merupakan implementasi dari **Data Persistence III - Read & Write Files**.

---
#   230605110010-Rahmat Enomoto

##  Fitur Utama

*  Membuat catatan (judul + isi)
*  Menampilkan daftar catatan
*  Edit catatan
*  Hapus catatan
*  Menyimpan data ke file `.txt`
*  Menyimpan gambar (image.jpg)
*  Kompresi gambar otomatis
*  Setiap catatan disimpan dalam folder terpisah

---

##  Konsep yang Digunakan

* **dart:io** → operasi file (read & write)
* **path_provider** → menentukan lokasi penyimpanan
* **path** → mengatur path file
* **image_picker** → ambil gambar dari galeri
* **flutter_image_compress** → kompres gambar

---

##  Struktur Project

```
lib/
├── main.dart
├── models/
│   └── note.dart
├── helpers/
│   └── file_helper.dart
└── screens/
    ├── note_list_screen.dart
    └── note_editor_screen.dart
```

##  Alur Aplikasi

1. User membuka aplikasi
2. Klik tombol + untuk membuat catatan
3. Input judul & isi
4. (Optional) pilih gambar dari galeri
5. Klik simpan
6. Data disimpan ke file system
7. Kembali ke list catatan

---
