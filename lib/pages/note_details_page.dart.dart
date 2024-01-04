import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/note_provider.dart';

class NoteDetailPage extends StatefulWidget {
  final int index;
  final Color color;
  const NoteDetailPage({super.key, required this.index, required this.color});

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(context),
        body: bodyWidget(context),
      ),
    );
  }

  //bodyWidget
  Center bodyWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AvatarGlow(
                glowColor: widget.color,
                glowCount: 10,
                animate: true,
                child: CircleAvatar(
                  backgroundColor: widget.color,
                  radius: 60,
                  child: Text(
                    (widget.index + 1).toString(),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                Provider.of<NoteProvider>(context)
                    .notes[widget.index]
                    .title
                    .toString(),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                Provider.of<NoteProvider>(context)
                    .notes[widget.index]
                    .description
                    .toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                Provider.of<NoteProvider>(context)
                    .notes[widget.index]
                    .date
                    .toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              deleteButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }

  //deleteButtonWidget
  ElevatedButton deleteButtonWidget() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: widget.color,
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        context.read<NoteProvider>().deleteNote(
              widget.index,
            );
        Navigator.pop(context);
      },
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Delete Note',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  //appBarWidget
  AppBar appBarWidget(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
    );
  }
}
