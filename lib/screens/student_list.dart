import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/controller/student_provider.dart';
import 'package:student_management_provider/screens/add_student.dart';
import 'package:student_management_provider/screens/edit_student.dart';
import 'package:student_management_provider/screens/profile_student.dart';

class StudentList extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            foregroundColor: Colors.black,
            backgroundColor: Colors.lightGreenAccent[400],
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => AddStudent()));
            },
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
          appBar: AppBar(
            title: const Text(
              'HOME(Provider)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    focusColor: Colors.white,
                    fillColor: Colors.black,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  onChanged: (value) {
                    (context as Element).markNeedsBuild();
                  },
                ),
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(child: Consumer<StudentProvider>(
                  builder: (context, studentinfoProvider, child) {
                final names =
                    studentinfoProvider.searchStudents(searchController.text);
                return ListView.builder(
                    itemCount: names.length,
                    itemBuilder: (context, index) {
                      final nameEntry = names[index];
                      return Card(
                        color: Colors.black,
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) =>
                                    ProfileScreen(nameEntry: nameEntry)));
                          },
                          leading: nameEntry.imageUrl.isNotEmpty
                              ? CircleAvatar(
                                  radius: 30,
                                  child: ClipOval(
                                    child: Image.file(
                                      File(nameEntry.imageUrl),
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : null,
                          title: Text(
                            nameEntry.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            overflow: TextOverflow.ellipsis,
                            nameEntry.place,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 224, 221, 221),
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) => EditStudent(
                                                nameEntry: nameEntry,
                                                index: index)));
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.lightBlue,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content:
                                                const SingleChildScrollView(
                                              child: ListBody(
                                                children: [
                                                  Text(
                                                    'Are you sure want to delete it',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            backgroundColor: Colors.white,
                                            title: const Text(
                                              "Delete !!",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.lightBlue,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    Provider.of<StudentProvider>(
                                                            context,
                                                            listen: false)
                                                        .deleteStudent(index);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        color: Colors.redAccent,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        ),
                      );
                    });
              },
              ),
              ),
            ],
          ),
          ),
    );
  }
}
