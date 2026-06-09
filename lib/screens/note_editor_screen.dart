import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../helpers/file_helper.dart';
import '../models/note.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;

  const NoteEditorScreen({
    super.key,
    this.note,
  });

  @override
  State<NoteEditorScreen> createState() =>
      _NoteEditorScreenState();
}

class _NoteEditorScreenState
    extends State<NoteEditorScreen> {
  final FileHelper _fileHelper =
  FileHelper();

  final TextEditingController
  _titleController =
  TextEditingController();

  final TextEditingController
  _contentController =
  TextEditingController();

  bool _isSaving = false;

  List<File> _imageFiles = [];

  bool get _isEditMode =>
      widget.note != null;

  String get _noteId =>
      widget.note?.id ??
          _fileHelper.generateNoteId();

  late final String _resolvedNoteId;

  @override
  void initState() {
    super.initState();

    _resolvedNoteId = _noteId;

    if (_isEditMode) {
      _titleController.text =
          widget.note!.title;

      _contentController.text =
          widget.note!.content;

      _loadExistingImages();
    }
  }

  Future<void>
  _loadExistingImages() async {
    final images =
    await _fileHelper
        .getNoteImages(
      _resolvedNoteId,
    );

    if (mounted) {
      setState(() {
        _imageFiles = images;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    if (_imageFiles.length >= 3) {
      return;
    }

    final picker = ImagePicker();

    final xFile =
    await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (xFile != null &&
        mounted) {
      setState(() {
        _imageFiles.add(
          File(xFile.path),
        );
      });
    }
  }

  Future<void> _removeImage(
      int index,
      ) async {
    final image =
    _imageFiles[index];

    final isSavedImage =
    image.path.contains(
      _resolvedNoteId,
    );

    if (isSavedImage) {
      await _fileHelper
          .deleteNoteImage(
        _resolvedNoteId,
        index + 1,
      );
    }

    setState(() {
      _imageFiles.removeAt(
        index,
      );
    });
  }

  Future<void> _saveNote() async {
    if (_titleController.text
        .trim()
        .isEmpty &&
        _contentController.text
            .trim()
            .isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Judul atau isi catatan tidak boleh kosong.',
          ),
        ),
      );

      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      await _fileHelper.saveNote(
        _resolvedNoteId,
        _titleController.text
            .trim(),
        _contentController.text
            .trim(),
      );

      for (int i = 0;
      i < _imageFiles.length;
      i++) {
        final image =
        _imageFiles[i];

        final isNewImage =
        !image.path.contains(
          _resolvedNoteId,
        );

        if (isNewImage) {
          await _fileHelper
              .saveNoteImage(
            _resolvedNoteId,
            i + 1,
            image.path,
          );
        }
      }

      if (mounted) {
        Navigator.pop(
          context,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal menyimpan catatan: $e',
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Widget _buildImageItem(
      int index,
      ) {
    return Container(
      width: 120,
      margin:
      const EdgeInsets.only(
        right: 8,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius:
            BorderRadius.circular(
              8,
            ),
            child: Image.file(
              _imageFiles[index],
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              decoration:
              const BoxDecoration(
                color:
                Colors.white70,
                shape:
                BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color:
                  Colors.red,
                ),
                onPressed: () =>
                    _removeImage(
                      index,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditMode
              ? 'Edit Catatan'
              : 'Catatan Baru',
        ),
        actions: [
          _isSaving
              ? const Padding(
            padding:
            EdgeInsets.all(
              16,
            ),
            child:
            SizedBox(
              width: 20,
              height: 20,
              child:
              CircularProgressIndicator(
                strokeWidth:
                2,
              ),
            ),
          )
              : IconButton(
            icon:
            const Icon(
              Icons.save,
            ),
            tooltip:
            'Simpan',
            onPressed:
            _saveNote,
          ),
        ],
      ),
      body:
      SingleChildScrollView(
        padding:
        const EdgeInsets.all(
          16,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment
              .stretch,
          children: [
            TextField(
              controller:
              _titleController,
              decoration:
              const InputDecoration(
                hintText:
                'Judul catatan',
                border:
                InputBorder.none,
              ),
              style:
              const TextStyle(
                fontSize: 22,
                fontWeight:
                FontWeight
                    .bold,
              ),
            ),

            const Divider(),

            TextField(
              controller:
              _contentController,
              decoration:
              const InputDecoration(
                hintText:
                'Tulis catatanmu di sini...',
                border:
                InputBorder.none,
              ),
              maxLines: null,
              minLines: 8,
              style:
              const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            if (_imageFiles
                .isNotEmpty)
              SizedBox(
                height: 130,
                child:
                ListView.builder(
                  scrollDirection:
                  Axis.horizontal,
                  itemCount:
                  _imageFiles
                      .length,
                  itemBuilder:
                      (
                      context,
                      index,
                      ) {
                    return _buildImageItem(
                      index,
                    );
                  },
                ),
              ),

            OutlinedButton.icon(
              onPressed:
              _imageFiles
                  .length <
                  3
                  ? _pickImage
                  : null,
              icon:
              const Icon(
                Icons
                    .add_photo_alternate,
              ),
              label: Text(
                'Tambah Gambar (${_imageFiles.length}/3)',
              ),
            ),
          ],
        ),
      ),
    );
  }
}