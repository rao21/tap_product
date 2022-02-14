import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_todo/bloc/product_bloc.dart';
import 'package:tap_todo/bloc/product_event.dart';
import 'package:tap_todo/bloc/product_state.dart';
import 'package:tap_todo/utils/constants.dart';
import 'model/product_model.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  late ProductBloc _productBloc;

  @override
  void initState() {
    _productBloc = BlocProvider.of<ProductBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _productBloc.close();
    super.dispose();
  }

  bool _validateForm() {
    if (_nameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _nameController.text.length < 3 ||
        _descriptionController.text.length < 3 ||
        _priceController.text.isEmpty ||
        double.tryParse(_priceController.text) == null) {
      return false;
    } else {
      return true;
    }
  }

  void _addProducts() {
    _productBloc.add(ProductAddEvent(
        data: Product(
            name: _nameController.text,
            description: _descriptionController.text,
            price: double.parse(_priceController.text))));
  }

  @override
  Widget build(BuildContext context) {
    final _isEnable = _validateForm();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Add Product',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          color: Theme.of(context).primaryColorLight,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              Column(
                children: [
                  CutomTextField(
                      hint: 'Product Name',
                      controller: _nameController,
                      onChange: (value) {
                        setState(() {
                          _validateForm();
                        });
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  CutomTextField(
                      hint: 'Product Description',
                      controller: _descriptionController,
                      onChange: (value) {
                        setState(() {
                          _validateForm();
                        });
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  CutomTextField(
                      hint: 'Product Price',
                      keyBoardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      controller: _priceController,
                      formatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,2}'))
                      ],
                      trailingWidget: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          GlobalConstant.currency,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                      onChange: (value) {
                        setState(() {
                          _validateForm();
                        });
                      }),
                  const SizedBox(
                    height: 32,
                  ),
                  BlocBuilder<ProductBloc, ProductState>(
                    bloc: _productBloc,
                    builder: (context, state) {
                      if (state is AddedProductSuccessedState) {
                        Navigator.pop(context, true);
                      }
                      return BlocBuilder<ProductBloc, ProductState>(
                          bloc: _productBloc,
                          builder: (context, state) {
                            return CustomButton(
                              onPressed: _addProducts,
                              title: 'Submit',
                              isEnable: _isEnable,
                              isLoading: state is AddingProductState,
                            );
                          });
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String? title;
  final bool isEnable;
  final bool isLoading;
  final VoidCallback onPressed;
  const CustomButton({
    Key? key,
    required this.title,
    this.isEnable = false,
    this.isLoading = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnable ? 1 : 0.5,
      child: SizedBox(
        height: 48,
        width: double.infinity,
        child: ElevatedButton(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Text(title!),
          onPressed: isEnable ? onPressed : () {},
          style: ElevatedButton.styleFrom(
            onPrimary: Theme.of(context).primaryColor,
            primary: Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
      ),
    );
  }
}

class CutomTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController controller;
  final Function(String) onChange;
  final TextInputType keyBoardType;
  final List<TextInputFormatter>? formatters;
  final Widget? trailingWidget;
  final Widget? leadingWidget;
  const CutomTextField(
      {Key? key,
      this.hint,
      required this.controller,
      required this.onChange,
      this.formatters,
      this.trailingWidget,
      this.leadingWidget,
      this.keyBoardType = TextInputType.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: SizedBox(
        height: 48,
        child: TextFormField(
          keyboardType: keyBoardType,
          autovalidateMode: AutovalidateMode.always,
          controller: controller,
          maxLines: 1,
          inputFormatters: formatters,
          decoration: InputDecoration(
            prefixIcon: leadingWidget,
            suffixIcon: trailingWidget,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 2,
              minHeight: 2,
            ),
            labelText: hint,
            labelStyle: Theme.of(context).textTheme.bodyText1,
            fillColor: Theme.of(context).primaryColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).primaryColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).primaryColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).primaryColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(
                  width: 1,
                  color: Theme.of(context).accentColor,
                )),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          onChanged: onChange,
        ),
      ),
    );
  }
}
