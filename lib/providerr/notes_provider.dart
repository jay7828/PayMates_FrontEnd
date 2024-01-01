import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:paymates/models/notes.dart';
import 'package:paymates/services/api_services.dart';

class NotesProvider with ChangeNotifier{
  List<Notes> notes =[];
  bool isLoading =true;
  List<Notes> getFilteredNotes( String searchQuery){
    return notes.where((element) => element.title!.toString().toLowerCase().contains(searchQuery.toLowerCase()) ||element.content!.toLowerCase().contains(searchQuery.toLowerCase()) ).toList();
  }

  NotesProvider(){
    log("App started");
    fetchNotes();
  }

  void sortNotes()
  {
    notes.sort((a,b)=>b.dateadded!.compareTo(a.dateadded!));
  }
  int addAmount(Notes note){
    return notes.first.totalamt!+note.title!;

  }
  void subAmount(Notes note)
  {
    notes.first.totalamt=notes.first.totalamt!-note.title!;
  }
  void addNotes(Notes note) {
    note.totalamt=(notes.isNotEmpty)?addAmount(note):note.title!;
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }
  void updateNotes(Notes note){
    int indexOfNote =notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote]=note;
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);

  }


  void deleteNotes(Notes note){
    int indexOfNote =notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    subAmount(note);
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void fetchNotes()async{
    notes= await ApiService.fetchList("jay2");
    isLoading=false;
    sortNotes();
    notifyListeners();
  }

}