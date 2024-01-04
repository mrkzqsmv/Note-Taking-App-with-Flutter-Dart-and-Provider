import 'package:flutter/material.dart';
import 'package:note_taking_app/helper/data_helper.dart';
import 'package:note_taking_app/pages/note_details_page.dart.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import 'add_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    Provider.of<NoteProvider>(context, listen: false).loadNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: floatingActionButtonWidget(context),
        appBar: appBarWidget(),
        body: Provider.of<NoteProvider>(context).notes.isEmpty
            ? const Center(
                child: Text(
                  'No Notes Added Yet',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : gridViewWidget());
  }

  //floatingActionButtonWidget
  Row floatingActionButtonWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.grey,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNotePage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  //appBarWidget
  AppBar appBarWidget() {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu),
      ),
      title: const Text(
        'Recent Notes',
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(onPressed: () {
          Provider.of<NoteProvider>(context, listen: false).deleteAllTasks();
        }, icon: const Icon(Icons.delete_forever)),
      ],
    );
  }

  //gridViewWidget
  gridViewWidget() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: Provider.of<NoteProvider>(context).notes.length,
      itemBuilder: (BuildContext context, int index) {
        return Consumer(
          builder: (context, NoteProvider noteProvider, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteDetailPage(
                        index: index,
                        color: DataHelper().colors[index % 10],
                      ),
                    ),
                  );
                },
                child: Card(
                  color: DataHelper().colors[index % 10],
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          noteProvider.notes[index].title.length > 15
                              ? noteProvider.notes[index].title.substring(0, 15)
                              : noteProvider.notes[index].title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          noteProvider.notes[index].description.length > 60
                              ? noteProvider.notes[index].description
                                      .substring(0, 60) +
                                  '...'
                              : noteProvider.notes[index].description,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          noteProvider.notes[index].date.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
