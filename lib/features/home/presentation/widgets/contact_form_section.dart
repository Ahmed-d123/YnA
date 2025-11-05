import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/size_config.dart';
import '../provider/home_provider.dart';

class ContactFormSection extends StatefulWidget {
  const ContactFormSection({super.key});

  @override
  State<ContactFormSection> createState() => _ContactFormSectionState();
}

class _ContactFormSectionState extends State<ContactFormSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final s = S.of(context);
      final provider = context.read<HomeProvider>();

      final success = await provider.submitContactForm(
        name: _nameController.text,
        email: _emailController.text,
        message: _messageController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success ? s.contactFormSuccess : s.contactFormError),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );

        if (success) {
          _formKey.currentState?.reset();
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final provider = context.watch<HomeProvider>(); // Watch for loading state
    final double size = SizeConfig.defultSize!;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(hintText: s.contactFormNameHint),
            validator: (value) =>
                (value == null || value.isEmpty) ? 'Please enter your name' : null,
          ),
          SizedBox(height: size * 0.66), // 16
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(hintText: s.contactFormEmailHint),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => (value == null ||
                    !value.contains('@') ||
                    !value.contains('.'))
                ? 'Please enter a valid email'
                : null,
          ),
          SizedBox(height: size * 0.66), // 16
          TextFormField(
            controller: _messageController,
            decoration: InputDecoration(hintText: s.contactFormMessageHint),
            maxLines: 4,
            validator: (value) => (value == null || value.isEmpty)
                ? 'Please enter your message'
                : null,
          ),
          SizedBox(height: size), // 24
          provider.isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(s.contactFormButtonSend),
                  ),
                ),
        ],
      ),
    );
  }
}
