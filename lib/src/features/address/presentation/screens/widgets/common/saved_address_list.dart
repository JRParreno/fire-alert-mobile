import 'package:fire_alert_mobile/src/core/location/place_detail.dart';
import 'package:fire_alert_mobile/src/features/address/presentation/screens/widgets/common/saved_address_tile.dart';
import 'package:flutter/material.dart';

class SavedAddressList extends StatelessWidget {
  final List<PlaceDetail> addressList;
  final bool disableScroll;
  final bool isFromProfile;

  const SavedAddressList({
    super.key,
    required this.addressList,
    this.disableScroll = false,
    this.isFromProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    if (addressList.isNotEmpty) {
      return ListView.builder(
        physics: disableScroll
            ? const NeverScrollableScrollPhysics()
            : const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: addressList.length > 5
            ? addressList.sublist(0, 5).length
            : addressList.length,
        itemBuilder: (context, index) => SavedAddressTile(
          address: addressList[index],
          isBorderLine: true,
          isFirstItem: index == 0,
          isFromProfile: isFromProfile,
        ),
      );
    }
    return const SizedBox();
  }
}
