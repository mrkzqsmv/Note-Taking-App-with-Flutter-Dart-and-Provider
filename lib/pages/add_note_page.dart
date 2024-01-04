import 'package:flutter/material.dart';
import 'package:note_taking_app/models/note_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/note_provider.dart';
import 'home_page.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var uuid = const Uuid();


  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: bodyWidget(context),
    );
  }

  //appBarWidget
  AppBar appBarWidget(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios)),
      title: const Text(
        'Create Note',
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  //bodyWidget
  bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            textFormFieldWidget('Title', _titleController),
            textFormFieldWidget('Description', _descriptionController),
            const Spacer(),
            saveButtonWidget(context),
          ],
        ),
      ),
    );
  }
  
  //saveButtonWidget
  ElevatedButton saveButtonWidget(BuildContext context) {
    return ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<NoteProvider>().addNote(
                      NoteModel(
                        title: _titleController.text.trim(),
                        description: _descriptionController.text.trim(),
                        id: uuid.v4(),
                        date: DateTime.now(),
                      ),
                    );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const HomePage();
                    },
                  ),
                );
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }

  //textFormFieldWidget
  textFormFieldWidget(String hintText, TextEditingController controller) {
    return TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
        border: InputBorder.none,
      ),
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
