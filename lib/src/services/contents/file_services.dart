import 'dart:io';
import 'package:date_time_format/date_time_format.dart';
import 'package:desktop_practice/src/utils/utils_export.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileService {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();

  bool fieldsNotEmpty = false;

  File? _selectedFile;
  String _selectedDirectory = '';

  static String getTodayDate() {
    final now = DateTime.now();
    final formattedDate = DateTimeFormat.format(now, format: 'yyy-MM-dd');
    return formattedDate;
  }

  void saveContent(context) async {
    final title = titleController.text;
    final description = descriptionController.text;
    final tags = tagsController.text;

    if (title.isEmpty || description.isEmpty || tags.isEmpty) {
      SnackBarUtils.showSnackbar(
          context, Icons.error_outlined, 'All fields are required');
      return;
    }

    final textContent =
        'Title: \n\n $title \n\n Decription: \n\n $description \n\n tags: \n\n $tags';
    try {
      if (_selectedFile != null) {
        await _selectedFile!.writeAsString(textContent);
      } else {
        final todayDate = getTodayDate();
        String metaDataDirPath = _selectedDirectory;
        if (metaDataDirPath.isEmpty) {
          final directory = await FilePicker.platform.getDirectoryPath();
          _selectedDirectory = metaDataDirPath = directory!;
        } else {
          final filePath =
              '$metaDataDirPath/$todayDate - $title - Metadata.txt';
          final newFile = File(filePath);
          await newFile.writeAsString(textContent);
        }
        SnackBarUtils.showSnackbar(
            context, Icons.check_circle, 'File saved successfully');
      }
    } catch (error) {
      SnackBarUtils.showSnackbar(
          context, Icons.error_outlined, 'File not saved');
    }
  }

  void uploadFIle(context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path!);
        _selectedFile = file;

        final fileContent = await file.readAsString();
        final lines = fileContent.split('\n\n');
        titleController.text = lines[1];
        descriptionController.text = lines[3];
        tagsController.text = lines[5];
        SnackBarUtils.showSnackbar(
            context, Icons.upload_file_rounded, 'File uploaded');
      } else {
        SnackBarUtils.showSnackbar(
            context, Icons.error_rounded, 'No file Selected');
      }
    } catch (error) {
      SnackBarUtils.showSnackbar(
          context, Icons.error_outlined, 'File not saved');
    }
  }

  void newFile(context) {
    _selectedFile = null;
    titleController.clear();
    descriptionController.clear();
    tagsController.clear();
    SnackBarUtils.showSnackbar(
        context, Icons.upload_file_rounded, 'New file created');
  }

  void newDirectory(context) async {
    try {
      String? directory = await FilePicker.platform.getDirectoryPath();
      _selectedDirectory = directory!;
      _selectedFile = null;
      SnackBarUtils.showSnackbar(
          context, Icons.upload_file_rounded, 'New folder selected');
    } catch (error) {
      SnackBarUtils.showSnackbar(
          context, Icons.error_outlined, 'No folder selected');
    }
  }
}
