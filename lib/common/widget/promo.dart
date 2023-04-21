import 'package:flutter/material.dart';
import 'package:west_sea/common/models/recent.dart';
import '../theme/pallete.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({
    super.key,
    required this.competion,
  });

  final Recent competion;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                competion.prize,
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(child: Text(competion.name)),
            const Spacer(),
            Ink(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Pallete.bgColor,
              child: const Center(
                child: Text('Details'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
