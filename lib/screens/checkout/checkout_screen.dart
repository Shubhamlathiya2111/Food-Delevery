import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery/providers/cart_provider.dart';
import 'package:food_delivery/services/payment_service.dart';

class CheckoutScreen extends StatefulWidget {
  final double total;

  const CheckoutScreen({
    super.key,
    required this.total,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPaymentMethod = 'Cash';
  bool _isProcessing = false;
  List<String> _logs = [];

  void _addLog(String log) {
    setState(() {
      _logs.add('${DateTime.now().toString().split('.')[0]} - $log');
    });
  }

  @override
  void initState() {
    super.initState();
    PaymentService.initPhonePe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Method Section
            const Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  RadioListTile(
                    title: Row(
                      children: const [
                        Icon(Icons.money),
                        SizedBox(width: 12),
                        Text('Cash on Delivery'),
                      ],
                    ),
                    value: 'Cash',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Row(
                      children: const [
                        Icon(Icons.account_balance),
                        SizedBox(width: 12),
                        Text('UPI'),
                      ],
                    ),
                    value: 'UPI',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Row(
                      children: const [
                        Icon(Icons.credit_card),
                        SizedBox(width: 12),
                        Text('Credit/Debit Card'),
                      ],
                    ),
                    value: 'Card',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value.toString();
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Order Summary Section
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal'),
                        Text('\$${widget.total.toStringAsFixed(2)}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Delivery Fee'),
                        Text('\$${(widget.total * 0.1).toStringAsFixed(2)}'),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '\$${(widget.total * 1.1).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _processPayment,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
          ),
          child: _isProcessing
              ? const CircularProgressIndicator()
              : const Text(
                  'Place Order',
                  style: TextStyle(fontSize: 16),
                ),
        ),
      ),
    );
  }

  Future<void> _processPayment() async {
    setState(() {
      _isProcessing = true;
    });

    _addLog('Initializing payment...');
    
    final String transactionId = 'TXN${DateTime.now().millisecondsSinceEpoch}';
    final response = await PaymentService.startPayment(
      amount: widget.total.toString(),
      transactionId: transactionId,
      callbackUrl: 'https://webhook.site/callback-url', // Replace with your callback URL
    );

    if (response != null) {
      if (response['status'] == 'SUCCESS') {
        _addLog('Payment successful!');
        // Handle successful payment
        context.read<CartProvider>().clearCart();
        _showSuccessDialog();
      } else {
        _addLog('Payment failed: ${response['error']}');
        _showErrorDialog(response['error'] ?? 'Payment failed');
      }
    } else {
      _addLog('Payment initialization failed');
      _showErrorDialog('Could not initialize payment');
    }

    setState(() {
      _isProcessing = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Order Placed Successfully'),
        content: const Text('Your order has been placed and will be delivered soon.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close checkout screen
              Navigator.of(context).pop(); // Close cart screen
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
} 