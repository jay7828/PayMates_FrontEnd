import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paymates/models/notes.dart';
import 'package:paymates/providerr/notes_provider.dart';
import 'package:paymates/pages/add_New_Note.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget
{
  const HomePage ({Key?key}) : super(key:key);
  @override
  _HomePageState createState()=> _HomePageState() ;
}

class _HomePageState extends State<HomePage>{

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    NotesProvider notesProvider = Provider.of<NotesProvider>( context);
    double screenWidth = MediaQuery.of(context).size.width;//getting the width of my Mobile Used In container
    return Scaffold(
      appBar: AppBar(
        title: const Text("PayMates App"),
        centerTitle: true,
      ),
      body:(notesProvider.isLoading==false)?SafeArea(
        child:Column(
          children: [Container(

            width: screenWidth , //screenwidth is defined Above
            height: 100,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey,

              ),

            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Total Expense   - ", style: TextStyle(fontSize:28,fontWeight:FontWeight.w700,),),
                Text((notesProvider.notes.isNotEmpty)?notesProvider.notes.first.totalamt.toString():"0",style: const TextStyle(fontSize: 30 ,fontWeight:FontWeight.w900,),)
              ],
            ),
          ),
            Expanded(
              child: (notesProvider.notes.isNotEmpty)? ListView(
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (val){
                        setState(() {
                          searchQuery = val;
                        });
                      },
                      decoration: const InputDecoration(
                          hintText : "Search"
                      ),
                    ),
                  ),

                  if (notesProvider.getFilteredNotes(searchQuery).isNotEmpty)  ListView(
                    shrinkWrap: true,
                    children: notesProvider.getFilteredNotes(searchQuery).map((currentNote) {
                      return GestureDetector(
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     CupertinoPageRoute(
                        //       builder: (context) => AddNewPage(isUpdate: true, note: currentNote),
                        //     ),
                        //   );
                        // },
                        onLongPress: () {
                          notesProvider.deleteNotes(currentNote);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.grey,
                              width: 3,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width : 200,
                                child: Text(
                                  currentNote.content!,
                                  style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20 ,color: Colors.blueGrey),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                currentNote.title!.toString(),
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 30,),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  )else const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("No Transaction found!" , textAlign: TextAlign.center,),
                    ),
                  ),
                ],
              ): const Center(
                child: Text("No Transaction Yet"),
              ),
            ),
          ],
        ),
      ):const Center(
        child: CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => const AddNewPage(isUpdate: false,),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

}