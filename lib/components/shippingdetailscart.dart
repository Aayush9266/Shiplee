import 'package:flutter/material.dart';

class ShippingDetailsCard extends StatelessWidget {
  final List<String> pickupCities;
  final List<String> deliveryCities;
  final List<String> couriers;
  final String? selectedPickup;
  final String? selectedDelivery;
  final String? selectedCourier;
  final Function(String?) onPickupChanged;
  final Function(String?) onDeliveryChanged;
  final Function(String?) onCourierChanged;

  const ShippingDetailsCard({
    Key? key,
    required this.pickupCities,
    required this.deliveryCities,
    required this.couriers,
    required this.selectedPickup,
    required this.selectedDelivery,
    required this.selectedCourier,
    required this.onPickupChanged,
    required this.onDeliveryChanged,
    required this.onCourierChanged,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFormField( // Changed from FormField to CustomFormField
              label: "Pickup Address",
              icon: Icons.location_on_outlined,
              child: DropdownButtonFormField<String>(
                value: selectedPickup,
                decoration: const InputDecoration(
                  hintText: "Select Pickup City",
                ),
                items: pickupCities.map((city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: onPickupChanged,
              ),
            ),
            const SizedBox(height: 16),
            CustomFormField( // Changed from FormField to CustomFormField
              label: "Delivery Address",
              icon: Icons.pin_drop_outlined,
              child: DropdownButtonFormField<String>(
                value: selectedDelivery,
                decoration: const InputDecoration(
                  hintText: "Select Delivery City",
                ),
                items: deliveryCities.map((city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: onDeliveryChanged,
              ),
            ),
            const SizedBox(height: 16),
            CustomFormField( // Changed from FormField to CustomFormField
              label: "Select Courier",
              icon: Icons.local_shipping_outlined,
              child: DropdownButtonFormField<String>(
                value: selectedCourier,
                decoration: const InputDecoration(
                  hintText: "Select Courier Service",
                ),
                items: couriers.map((courier) {
                  return DropdownMenuItem<String>(
                    value: courier,
                    child: Text(courier),
                  );
                }).toList(),
                onChanged: onCourierChanged,
              ),
            ),
          ],
        ),
      ),
    );
}
}
// Change the name from FormField to CustomFormField to avoid conflicts
class CustomFormField extends StatelessWidget {
  final String label;
  final IconData icon;
  final Widget child;

  const CustomFormField({
    Key? key,
    required this.label,
    required this.icon,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 8),
          child: Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: Colors.deepPurple, // or AppTheme.primaryColor if available
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF424242), // or AppTheme.textColor if available
                ),
              ),
            ],
          ),
        ),
        child,
      ],
    );
  }
}
