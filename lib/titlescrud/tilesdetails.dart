import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TileDetailsDialog extends StatelessWidget {
  final String title;
  final String category;
  final String city;
  final String contact;
  final String description;
  final String imageUrl;
  final String location;
  final int price;
  final List<String> offers;

  const TileDetailsDialog({
    Key? key,
    required this.title,
    required this.category,
    required this.city,
    required this.contact,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.price,
    required this.offers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text('Category: $category'),
              Text('City: $city'),
              Text('Contact: $contact'),
              Text('Location: $location'),
              Text('Price: \$${price.toString()}'),
              Text('Offers: ${offers.join(", ")}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
