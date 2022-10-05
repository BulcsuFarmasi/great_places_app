import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_app/models/place.dart';
import 'package:provider/provider.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';
import '../providers/places.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  String? title;
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage  = pickedImage;
  }

  void _selectLocation(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace() {
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate() || _pickedImage == null || _pickedLocation == null) {
      return;
    }
    Provider.of<Places>(context, listen: false).addPlace(title!, _pickedImage!, _pickedLocation!);
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add new place'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                              decoration: const InputDecoration(label: Text('Title')),
                              onSaved: (value) {
                                title = value;
                              },
                              validator: (String? value) {
                                String? errorMessage;
                                if (value == null || value.length < 5) {
                                  errorMessage = 'The title should be at least 5 characters long';
                                }
                                return errorMessage;
                              }

                          ),
                          const SizedBox(height: 10),
                          ImageInput(_selectImage),
                          const SizedBox(height: 10),
                          LocationInput(onSelectLocation: _selectLocation),
                        ],
                      ),
                    ),
                  ),
                )),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(),
                  elevation: 0,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPrimary: Colors.black,
                  primary: Theme
                      .of(context)
                      .colorScheme
                      .secondary),
            )
          ],
        ));
  }
}
