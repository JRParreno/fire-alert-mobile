import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/common_widget/common_widget.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/data/models/incident_type.dart';
import 'package:flutter/material.dart';

class SelectIncidentType extends StatelessWidget {
  final List<IncidentType> incidentTypes;
  final Function(IncidentType) onSelect;
  final IncidentType? incidentType;

  const SelectIncidentType({
    super.key,
    required this.incidentTypes,
    required this.onSelect,
    this.incidentType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView.builder(
        itemCount: incidentTypes.length,
        itemBuilder: (context, index) {
          final item = incidentTypes[index];

          return Column(
            children: [
              ListTile(
                title: CustomText(text: item.name),
                onTap: () {
                  onSelect(item);
                },
                style: ListTileStyle.list,
                selected: incidentType != null && incidentType == item,
              ),
              const Divider(
                color: ColorName.gray,
              )
            ],
          );
        },
      ),
    );
  }
}
