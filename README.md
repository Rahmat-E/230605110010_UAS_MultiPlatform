# Note-Taking App (Flutter - Soal 5 Tantangan)

Aplikasi Note-Taking berbasis Flutter yang menggunakan file system (`dart:io`) untuk menyimpan data catatan dan lampiran gambar. Project ini merupakan implementasi dari materi **Data Persistence III - Read & Write Files** dengan pengembangan fitur multi-lampiran gambar pada Soal 5 Tantangan.

---

## Identitas

**Nama:** Rahmat Enomoto
**NIM:** 230605110010

---
link youtube: https://www.youtube.com/watch?v=qrNuIet8l0U

## Fitur Utama

* Membuat catatan (judul dan isi)
* Menampilkan daftar catatan
* Mengedit catatan
* Menghapus catatan
* Menyimpan data ke file `.txt`
* Menambahkan hingga 3 gambar pada setiap catatan
* Menghapus gambar secara individual
* Kompresi gambar otomatis
* Penyimpanan gambar berdasarkan indeks
* Penyimpanan data menggunakan file system
* Setiap catatan disimpan dalam folder terpisah

---

## Implementasi Soal 5

### Multi Lampiran Gambar

Setiap catatan dapat menyimpan maksimal tiga gambar.

Struktur penyimpanan:

```text
notes/
└── note_xxxxx
    ├── content.txt
    ├── image_1.jpg
    ├── image_2.jpg
    └── image_3.jpg
```

### Image Count

Model `Note` menggunakan properti:

```dart
final int imageCount;
```

untuk menyimpan jumlah lampiran gambar yang dimiliki oleh setiap catatan.

### Penyimpanan Berdasarkan Indeks

Metode:

```dart
saveNoteImage(noteId, index, sourcePath)
```

digunakan untuk menyimpan gambar sebagai:

* image_1.jpg
* image_2.jpg
* image_3.jpg

### Penghapusan Gambar Individual

Metode:

```dart
deleteNoteImage(noteId, index)
```

digunakan untuk menghapus satu gambar tanpa memengaruhi gambar lainnya.

### Tampilan Editor

* Menampilkan maksimal 3 gambar.
* Gambar tersusun dalam satu baris horizontal.
* Mendukung horizontal scrolling.
* Setiap gambar memiliki tombol hapus sendiri.
* Tombol tambah gambar otomatis nonaktif ketika jumlah gambar mencapai 3.

---

## Teknologi yang Digunakan

* Flutter
* Dart
* dart:io
* path_provider
* path
* image_picker
* flutter_image_compress

---

## Struktur Project

```text
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

---

## Alur Aplikasi

1. User membuka aplikasi.
2. Klik tombol **+** untuk membuat catatan baru.
3. Mengisi judul dan isi catatan.
4. Menambahkan hingga 3 gambar dari galeri (opsional).
5. Klik tombol simpan.
6. Data dan gambar disimpan ke file system.
7. Catatan ditampilkan pada halaman daftar catatan.
8. Catatan dapat diedit atau dihapus kembali.

---

## Hasil Pengujian

Pengujian menunjukkan bahwa:

* Catatan dapat menyimpan hingga 3 gambar.
* Gambar tersimpan sebagai `image_1.jpg`, `image_2.jpg`, dan `image_3.jpg`.
* Gambar dapat ditampilkan kembali saat catatan dibuka.
* Gambar dapat dihapus satu per satu.
* Tampilan gambar tersusun secara horizontal.
* Sistem membatasi jumlah lampiran maksimal 3 gambar sesuai spesifikasi soal.

---

## Kesimpulan

Fitur lampiran gambar berhasil dikembangkan dari satu gambar menjadi maksimal tiga gambar per catatan. Sistem penyimpanan, pengelolaan, dan tampilan gambar telah diperbarui sesuai dengan spesifikasi Soal 5 Tantangan sehingga pengguna dapat menambahkan, melihat, dan menghapus beberapa gambar dalam satu catatan dengan lebih fleksibel.
