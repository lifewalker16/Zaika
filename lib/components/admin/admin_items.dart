import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

// ✅ Use your actual Cloudinary details
const cloudName = 'dx02fsahn';
const uploadPreset = 'zaika_uploads';

class AddFoodItemPage extends StatefulWidget {
  const AddFoodItemPage({super.key});

  @override
  State<AddFoodItemPage> createState() => _AddFoodItemPageState();
}

class _AddFoodItemPageState extends State<AddFoodItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _prepTimeController = TextEditingController();

  File? _imageFile;
  bool _isUploading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage({required bool fromCamera}) async {
    final pickedFile = await _picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadToCloudinary(File imageFile) async {
    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    final resStr = await response.stream.bytesToString();
    print('Cloudinary response: $resStr');

    if (response.statusCode == 200) {
      final data = json.decode(resStr);
      return data['secure_url'];
    } else {
      print('❌ Upload failed: $resStr');
      return null;
    }
  }

  Future<void> _saveFoodItem() async {
    if (!_formKey.currentState!.validate() || _imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all fields and add a photo'),
        ),
      );
      return;
    }

    setState(() => _isUploading = true);

    final imageUrl = await _uploadToCloudinary(_imageFile!);
    if (imageUrl == null) {
      setState(() => _isUploading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image upload failed. Try again.')),
      );
      return;
    }

    // Create an item ID (you can make it more complex if needed)
    final itemId = 'item_${DateTime.now().millisecondsSinceEpoch}';

    final menuItemData = {
      'name': _nameController.text.trim(),
      'category': _categoryController.text.trim(),
      'price': double.tryParse(_priceController.text.trim()) ?? 0.0,
      'preparation_time': int.tryParse(_prepTimeController.text.trim()) ?? 0,
      'image_url': imageUrl,
      'created_at': Timestamp.now(),
    };

    await FirebaseFirestore.instance.collection('food_items').doc(itemId).set({
      'menuItems': {itemId: menuItemData},
    });

    setState(() => _isUploading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Food item added successfully!')),
    );

    Navigator.pop(context);
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF8173C3)),
              title: const Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(fromCamera: true);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo, color: Color(0xFF8173C3)),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(fromCamera: false);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6FF),
      appBar: AppBar(
        title: const Text('Add Food Item'),
        backgroundColor: const Color(0xFF8173C3),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _showImageSourceDialog,
                child: Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF8173C3),
                      width: 2,
                    ),
                    image: _imageFile != null
                        ? DecorationImage(
                            image: FileImage(_imageFile!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _imageFile == null
                      ? const Center(
                          child: Icon(
                            Icons.camera_alt,
                            color: Color(0xFF8173C3),
                            size: 50,
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Food Name',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter food name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category (e.g., Drinks, Main Course)',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter category' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price (₹)',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Enter price' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _prepTimeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Preparation Time (minutes)',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter preparation time' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isUploading ? null : _saveFoodItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8173C3),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isUploading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Save Food Item',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
