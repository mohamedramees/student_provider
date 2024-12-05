import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management_provider/model/student_model.dart';

class StudentProvider extends ChangeNotifier {
  final Box<Student> nameBox;
  String? selectedImage;

  StudentProvider() : nameBox = Hive.box<Student>('Student');

  // Getter to fetch all students
  List<Student> get names => nameBox.values.toList();

  //^ ADD STUDENT 
  
  void addStudent(
      String name, int age, String place, String phoneNumber, String imageUrl) {
    nameBox.add(Student(
        place: place,
        name: name,
        age: age,
        phoneNumber: phoneNumber,
        imageUrl: imageUrl));
    notifyListeners();
  }

//^ EDIT AND UPDATE STUDENTS

  void updateStudent(int index, String name, String place, int age,
      String imageUrl, String phoneNumber) {
    nameBox.putAt(
        index,
        Student(
            place: place,
            name: name,
            age: age,
            phoneNumber: phoneNumber,
            imageUrl: imageUrl));
    notifyListeners();
  }

//^ DELETE FUNCTIONALITY  

  void deleteStudent(int index) {
    nameBox.deleteAt(index);
    notifyListeners();
  }

  //^ SEARCH FUNCTIONALITY 

  List<Student> searchStudents(String query) {
    if (query.isEmpty) {
      return names;
    } else {
      return names.where((student) {
        return student.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  //^ IMAGE PICKER

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      selectedImage = pickedImage.path;
      notifyListeners();
    }
  }

//^ SAVE AND CLEAR IMAGE IN ADD STUDENT PAGE

  void clearSelectedImage() {
    selectedImage = null;
    notifyListeners();
  }
}
