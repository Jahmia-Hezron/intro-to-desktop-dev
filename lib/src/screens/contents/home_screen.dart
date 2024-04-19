import 'package:flutter/material.dart';
import '../../utils/utils_export.dart';
import '../../widgets/widget_export.dart';
import '../../services/services_export.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  FileService fileService = FileService();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  void addListeners() {
    List<TextEditingController> controllers = [
      fileService.titleController,
      fileService.descriptionController,
      fileService.tagsController
    ];

    for (TextEditingController controller in controllers) {
      controller.addListener(_onFieldChanged);
    }
  }

  void removeListeners() {
    List<TextEditingController> controllers = [
      fileService.titleController,
      fileService.descriptionController,
      fileService.tagsController
    ];

    for (TextEditingController controller in controllers) {
      controller.removeListener(_onFieldChanged);
    }
  }

  void _onFieldChanged() {
    setState(() {
      fileService.fieldsNotEmpty =
          fileService.titleController.text.isNotEmpty &&
              fileService.descriptionController.text.isNotEmpty &&
              fileService.tagsController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    removeListeners();
  }

  Widget _buildActionButton(IconData icon, VoidCallback onPressed) {
    return ActionButton(
      icon: icon,
      iconColor: AppTheme.tertiary,
      splashColor: AppTheme.secondary,
      onPressed: onPressed,
    );
  }

  Widget _buildNewFileButton() {
    return Button(
      buttonText: 'New File',
      onPressed: () => null,
      textColor: AppTheme.primary,
      backgroundColor: AppTheme.tertiary,
      disabledBackgroundColor: AppTheme.secondary,
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildNewFileButton(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton(Icons.upload_rounded, () {}),
            const SizedBox(width: 10),
            _buildActionButton(Icons.folder, () {}),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Button(
            buttonText: 'Save File',
            onPressed: () => null,
            textColor: AppTheme.primary,
            backgroundColor: AppTheme.tertiary,
            disabledBackgroundColor: AppTheme.secondary,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.primary,
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          children: [
            _buildHeaderRow(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: TextArea(
                hintText: 'Enter Title',
                maxLength: 20,
                maxLines: 2,
                controller: fileService.titleController,
              ),
            ),
            TextArea(
              hintText: 'Enter Video Description',
              maxLength: 500,
              maxLines: 6,
              controller: fileService.descriptionController,
            ),
            TextArea(
              hintText: 'Enter Tag',
              maxLength: 200,
              maxLines: 4,
              controller: fileService.tagsController,
            ),
            _buildFooterRow(),
          ],
        ),
      ),
    );
  }
}
