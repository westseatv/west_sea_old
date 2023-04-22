import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_sea/common/models/recent.dart';
import '../theme/pallete.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({
    super.key,
    required this.competition,
  });

  final Recent competition;

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
                competition.prize,
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(child: Text(competition.name)),
            const Spacer(),
            InkWell(
              onTap: () {
                Get.defaultDialog(
                  title: competition.name,
                  backgroundColor: Pallete.bgColor,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            '${competition.prize} Prizes',
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 29,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        detailTale('1st Prize', competition.prizes[0]),
                        detailTale('2nd Prize', competition.prizes[1]),
                        detailTale('3rd Prize', competition.prizes[2]),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text('End Date'),
                            const Spacer(),
                            Text(
                              competition.endDate,
                              style: const TextStyle(
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  textCancel: 'Close',
                );
              },
              child: Ink(
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: Pallete.bgColor,
                child: const Center(
                  child: Text('Details'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row detailTale(String label, String prize) {
    return Row(
      children: [
        Text(label),
        const Spacer(),
        Text(
          prize,
          style: const TextStyle(
            color: Colors.blueAccent,
          ),
        ),
      ],
    );
  }
}
