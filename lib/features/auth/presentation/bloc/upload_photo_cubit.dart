import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

abstract class SelectPhotoState {}

class SelectPhotoInitial extends SelectPhotoState {}

class PhotoSelectLoading extends SelectPhotoState {}

class PhotoSelected extends SelectPhotoState {
  final File image;
  PhotoSelected(this.image);
}

class PhotoSelectFailure extends SelectPhotoState {
  final String message;
  PhotoSelectFailure(this.message);
}

class SelectPhotoCubit extends Cubit<SelectPhotoState> {
  SelectPhotoCubit() : super(SelectPhotoInitial());

  Future<void> pickImage() async {
    try {
      emit(PhotoSelectLoading());
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(PhotoSelected(File(pickedFile.path)));
      } else {
        emit(SelectPhotoInitial());
      }
    } catch (e) {
      emit(PhotoSelectFailure(e.toString()));
    }
  }
}
