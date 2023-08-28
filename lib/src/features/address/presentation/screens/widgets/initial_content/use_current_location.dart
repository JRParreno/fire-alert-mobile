import 'package:flutter/material.dart';

class SearchUseCurrentLocation extends StatelessWidget {
  const SearchUseCurrentLocation({
    super.key,
    required this.onTap,
    this.isFromOnBoarding = false,
  });

  final VoidCallback onTap;
  final bool isFromOnBoarding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: const Icon(Icons.location_pin),
              ),
              const SizedBox(width: 10),
              const Text("Use Current Location"),
            ],
          ),
        ),
      ),
    );
  }
}
