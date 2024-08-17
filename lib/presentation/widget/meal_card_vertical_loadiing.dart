import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MealCardVerticalLoading extends StatelessWidget {
  const MealCardVerticalLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Card(
          child: Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.black12,
                highlightColor: Colors.white12,
                child: Container(
                  height: 150,
                  width: 150,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.black12,
                        highlightColor: Colors.white12,
                        child: Container(
                          height: 10,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Shimmer.fromColors(
                        baseColor: Colors.black12,
                        highlightColor: Colors.white12,
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                      ),
                    ],
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
