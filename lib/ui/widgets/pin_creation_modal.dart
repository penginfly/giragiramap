// lib/ui/widgets/pin_creation_modal.dart
import 'package:flutter/material.dart';

class PinCreationModal extends StatefulWidget {
  final String category; // カテゴリは長押しで自動設定されるため、選択UIは不要
  final Offset initialPosition;

  const PinCreationModal({
    super.key,
    required this.category,
    required this.initialPosition,
  });

  @override
  State<PinCreationModal> createState() => _PinCreationModalState();
}

class _PinCreationModalState extends State<PinCreationModal> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 問題の原因: MediaQuery.of(context).viewInsets.bottom を直接Paddingに指定
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'ピンを立てる',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'タイトル',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'タイトルは必須です';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: '詳細',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newPinData = {
                      'title': _titleController.text,
                      'description': _descriptionController.text,
                      'category': widget.category, // コンストラクタから受け取ったカテゴリを使用
                      'userId': 'user_a_id',
                      'xPosition': widget.initialPosition.dx,
                      'yPosition': widget.initialPosition.dy,
                    };
                    Navigator.of(context).pop(newPinData);
                  }
                },
                child: const Text('ピンを立てる'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}