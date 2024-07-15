import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CityDetailsDialog extends StatelessWidget {
  final String cityName;
  final String cityImage;
  final String cityDescription;

  const CityDetailsDialog({
    Key? key,
    required this.cityName,
    required this.cityImage,
    required this.cityDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 500,
              width: 250,
              child: CachedNetworkImage(
                imageUrl: cityImage,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              cityName,
              // style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              cityDescription,
              style: Theme.of(context).textTheme.labelMedium,
            ),
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
    );
  }
}
