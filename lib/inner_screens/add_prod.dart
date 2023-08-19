import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import '../util/utils.dart';
import 'package:responsivedashboard/widgets/buttons.dart';
import 'package:responsivedashboard/widgets/textwidget.dart';

class UploadProductForm extends StatefulWidget {
  // static const routeName = '/UploadProductForm';

  const UploadProductForm({Key? key}) : super(key: key);

  @override
  _UploadProductFormState createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  final _formKey = GlobalKey<FormState>();
  String _catValue = 'Vegetables';
  late final TextEditingController _titleController, _priceController;
  int _groupValue = 1;
  bool isPiece = false;
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  @override
  void initState() {
    _priceController = TextEditingController();
    _titleController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _uploadForm() async {
    // final isValid = _formKey.currentState!.validate();
  }

  void _clearForm() {
    isPiece = false;
    _groupValue = 1;
    _priceController.clear();
    _titleController.clear();
    setState(() {
      _pickedImage = null;
      webImage = Uint8List(8);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Utils(context).getTheme;
    final color = Utils(context).color;
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    Size size = Utils(context).getScreenSize;
    var inputDecoration = InputDecoration(
      filled: true,
      fillColor: scaffoldColor,
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1.0,
        ),
      ),
    );

    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: size.width > 650 ? 650 : size.width,
                    color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _productTitle(color, inputDecoration),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: FittedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      _productPrice(color, inputDecoration),
                                      const SizedBox(height: 20),
                                      _productCategory(color),
                                      const SizedBox(height: 20),
                                      _productMeaureUnite(color),
                                    ],
                                  ),
                                ),
                              ),
                              _productImage(color, size),
                              _clearOrUpdate(),
                            ],
                          ),
                          _clearOrUpload(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productTitle(Color color, InputDecoration inputDecoration) {
    return Column(
      children: [
        TextWidget(
          text: 'Product title*',
          color: color,
          isTitle: true,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: _titleController,
          key: const ValueKey('Title'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a Title';
            }
            return null;
          },
          decoration: inputDecoration,
        ),
      ],
    );
  }

  Widget _productPrice(Color color, InputDecoration inputDecoration) {
    return Column(children: [
      TextWidget(
        text: 'Price in \$*',
        color: color,
        isTitle: true,
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: 100,
        child: TextFormField(
          controller: _priceController,
          key: const ValueKey('Price \$'),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Price is missed';
            }
            return null;
          },
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          ],
          decoration: inputDecoration,
        ),
      ),
    ]);
  }

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
        });
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = File('a');
        });
      } else {
        print('No image has been picked');
      }
    } else {
      print('Something went wrong');
    }
  }

  Widget _dottedBorder({
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
          dashPattern: const [6.7],
          borderType: BorderType.RRect,
          color: color,
          radius: const Radius.circular(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_outlined,
                  color: color,
                  size: 50,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: (() {
                      _pickImage();
                    }),
                    child: TextWidget(
                      text: 'Choose an image',
                      color: Colors.blue,
                    ))
              ],
            ),
          )),
    );
  }

  Widget _productCategory(Color color) {
    final color = Utils(context).color;
    return Column(
      children: [
        TextWidget(
          text: 'Porduct category*',
          color: color,
          isTitle: true,
        ),
        const SizedBox(height: 10),
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              value: _catValue,
              onChanged: (value) {
                setState(() {
                  _catValue = value!;
                });
                print(_catValue);
              },
              hint: const Text('Select a category'),
              items: const [
                DropdownMenuItem(
                  child: Text(
                    'Vegetables',
                  ),
                  value: 'Vegetables',
                ),
                DropdownMenuItem(
                  child: Text(
                    'Fruits',
                  ),
                  value: 'Fruits',
                ),
                DropdownMenuItem(
                  child: Text(
                    'Grains',
                  ),
                  value: 'Grains',
                ),
                DropdownMenuItem(
                  child: Text(
                    'Nuts',
                  ),
                  value: 'Nuts',
                ),
                DropdownMenuItem(
                  child: Text(
                    'Herbs',
                  ),
                  value: 'Herbs',
                ),
                DropdownMenuItem(
                  child: Text(
                    'Spices',
                  ),
                  value: 'Spices',
                )
              ],
            )),
          ),
        ),
      ],
    );
  }

  Widget _productMeaureUnite(Color color) {
    return Column(children: [
      TextWidget(
        text: 'Measure unit*',
        color: color,
        isTitle: true,
      ),
      const SizedBox(
        height: 10,
      ),
      // Radio button code here
      Row(
        children: [
          TextWidget(
            text: 'KG',
            color: color,
          ),
          Radio(
            value: 1,
            groupValue: _groupValue,
            onChanged: (valuee) {
              setState(() {
                _groupValue = 1;
                isPiece = false;
              });
            },
            activeColor: Colors.green,
          ),
          TextWidget(
            text: 'Piece',
            color: color,
          ),
          Radio(
            value: 2,
            groupValue: _groupValue,
            onChanged: (valuee) {
              setState(() {
                _groupValue = 2;
                isPiece = true;
              });
            },
            activeColor: Colors.green,
          ),
        ],
      )
    ]);
  }

  Widget _productImage(Color color, size) {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: size.width > 650 ? 350 : size.width * 0.45,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: _pickedImage == null
                ? _dottedBorder(color: color)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: kIsWeb
                        ? Image.memory(webImage, fit: BoxFit.fill)
                        : Image.file(_pickedImage!, fit: BoxFit.fill),
                  )),
      ),
    );
  }

  Widget _clearOrUpdate() {
    return Expanded(
        flex: 1,
        child: FittedBox(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _pickedImage = null;
                    webImage = Uint8List(8);
                  });
                },
                child: TextWidget(
                  text: 'Clear',
                  color: Colors.red,
                ),
              ),
              TextButton(
                onPressed: () => _pickImage(),
                child: TextWidget(
                  text: 'Update image',
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ));
  }

  Widget _clearOrUpload() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ButtonsWidget(
            onPressed: _clearForm,
            text: 'Clear form',
            icon: IconlyBold.danger,
            backgroundColor: Colors.red.shade300,
          ),
          ButtonsWidget(
            onPressed: () {
              _uploadForm();
            },
            text: 'Upload',
            icon: IconlyBold.upload,
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
