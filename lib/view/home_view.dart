import 'package:advertisement/add_product/add_product.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home View'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> data =
                    documents[index].data() as Map<String, dynamic>;

                // Extract the data from the document
                final String title = data['title'];
                final String description = data['description'];
                final String name = data['name'];
                final String dateTime = data['dateTime'];
                final String phoneNumber = data['phoneNumber'];
                final String address = data['address'];
                final List<String> imageUrls =
                    List<String>.from(data['imageUrls']);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    Image.network(
                      imageUrls[0],
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 10),
                    Text('Name: $name'),
                    Text('Date and Time: $dateTime'),
                    Text('Phone Number: $phoneNumber'),
                    Text('Address: $address'),
                    const Divider(), // Add a divider between items
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProduct()),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.blue,
        ),
      ),
    );
  }
}
