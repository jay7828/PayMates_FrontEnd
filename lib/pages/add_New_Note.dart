import 'package:flutter/material.dart';
import 'package:paymates/models/notes.dart';
import 'package:paymates/providerr/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:paymates/providerr/notes_provider.dart';

class AddNewPage extends StatefulWidget {
  final bool isUpdate;
  final Notes? note;
  const AddNewPage({Key?key, required this.isUpdate, this.note}): super(key: key);

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {

  FocusNode noteFocus = FocusNode();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController contentcontroller =TextEditingController();
  NotesProvider notesProvider = NotesProvider();
  @override
  void initState() {
    super.initState();
    if (widget.isUpdate)
    {
      // widget.note!.totalamt=(widget.note!.totalamt!)-(widget.note!.title!);
      titlecontroller.text=widget.note!.title!.toString();
      contentcontroller.text=widget.note!.content!;
    }
  }
  void addNewNote()
  {
    Notes newNote = Notes(
      id: const Uuid().v1(),
      userid: "jay2",
      content: contentcontroller.text,
      title: int.tryParse(titlecontroller.text) ?? 0,
      dateadded: DateTime.now(),
    );
    Provider.of<NotesProvider>((context),listen: false).addNotes(newNote);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: {} For Left Side Stuff
          actions: [
            IconButton(
              onPressed:(){
                if(widget.isUpdate)
                {
                  // updateNote();
                }
                else
                {
                  addNewNote();
                }
              },
              icon:const Icon(Icons.check),
            )
          ]//For Right Side Stuff,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children:[

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: titlecontroller,
                      onSubmitted: (val) {
                        if (val.isNotEmpty) {
                          noteFocus.requestFocus();
                        }
                      },
                      autofocus: widget.isUpdate == true ? false : true,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                      keyboardType: TextInputType.number, // Set keyboardType to number
                      decoration: const InputDecoration(
                        hintText: "Enter The Amount",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "₹",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),

              Expanded(
                child: TextField(
                  controller: contentcontroller,
                  focusNode: noteFocus,
                  maxLines: null,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Notes",
                    border: InputBorder.none,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}