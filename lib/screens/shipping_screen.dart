import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/Section_Header.dart';
import '../components/resultcard.dart';
import '../components/shippingdetailscart.dart';
import '../services/api_services.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  List<String> pickupCities = [];
  List<String> deliveryCities = [];
  List<String> couriers = [];

  String? selectedPickup;
  String? selectedDelivery;
  String? selectedCourier;
  int? shippingCost;
  bool isLoading = true;
  bool isCalculating = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await ShippingService.fetchRates();
      setState(() {
        pickupCities = data.map((e) => e['pickup'].toString()).toSet().toList()..sort();
        deliveryCities = data.map((e) => e['delivery'].toString()).toSet().toList()..sort();
        couriers = data.map((e) => e['courier'].toString()).toSet().toList()..sort();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorSnackBar("Failed to load shipping data: $e");
    }
  }

  Future<void> _calculatePrice() async {
    if (selectedPickup == null || selectedDelivery == null || selectedCourier == null) {
      _showErrorSnackBar("Please select all required fields");
      return;
    }

    if (selectedPickup == selectedDelivery) {
      _showErrorSnackBar("Pickup and delivery cities cannot be the same");
      return;
    }

    setState(() {
      isCalculating = true;
      shippingCost = null;
    });

    try {
      final cost = await ShippingService.calculateRate(
        selectedPickup!,
        selectedDelivery!,
        selectedCourier!,
      );

      setState(() {
        shippingCost = cost;
        isCalculating = false;
      });

      if (shippingCost == null) {
        _showErrorSnackBar("No shipping rate found for selected combination");
      }
    } catch (e) {
      setState(() {
        isCalculating = false;
      });
      _showErrorSnackBar("Error calculating shipping rate: $e");
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SHIPLEE",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
            tooltip: "Refresh data",
           color: Colors.white,
          ),
        ],
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: "Enter Shipment Details",
                subtitle: "Calculate shipping rates across India",
                icon: Icons.local_shipping_outlined,
              ),
              const SizedBox(height: 20),
              ShippingDetailsCard(
                pickupCities: pickupCities,
                deliveryCities: deliveryCities,
                couriers: couriers,
                selectedPickup: selectedPickup,
                selectedDelivery: selectedDelivery,
                selectedCourier: selectedCourier,
                onPickupChanged: (value) {
                  setState(() {
                    selectedPickup = value;
                    shippingCost = null;
                  });
                },
                onDeliveryChanged: (value) {
                  setState(() {
                    selectedDelivery = value;
                    shippingCost = null;
                  });
                },
                onCourierChanged: (value) {
                  setState(() {
                    selectedCourier = value;
                    shippingCost = null;
                  });
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: isCalculating ? null : _calculatePrice,
                  icon: isCalculating
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Icon(Icons.calculate),
                  label: Text(isCalculating ? "Calculating..." : "Calculate Price"),
                ),
              ),
              const SizedBox(height: 30),
              if (shippingCost != null) ResultCard(shippingCost: shippingCost!),
            ],
          ),
        ),
      ),
    );
  }
}