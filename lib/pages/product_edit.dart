import 'package:flutter/material.dart';

import '../widgets/helpers/ensure-visible.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> product;
  final int productIndex;

  ProductEditPage(
      {this.addProduct, this.updateProduct, this.product, this.productIndex});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  Widget _buildTitleTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(labelText: 'Product Title'),
        initialValue: widget.product == null ? '' : widget.product['title'],
        validator: (String value) {
          if (value.isEmpty || value.length < 5) {
            return 'Title is required and should be greater than 5 characters.';
          }
        },
        onSaved: (String title) {
          _formData['title'] = title;
        },
      ),
    );
  }

  Widget _buildDescriptionTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        maxLines: 4,
        decoration: InputDecoration(labelText: 'Product Description'),
        initialValue:
            widget.product == null ? '' : widget.product['description'],
        validator: (String value) {
          if (value.isEmpty || value.length < 10) {
            return 'Description is required and should be greater than 10 characters.';
          }
        },
        onSaved: (String description) {
          _formData['description'] = description;
        },
      ),
    );
  }

  Widget _buildPriceTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        keyboardType: TextInputType.number,
        initialValue:
            widget.product == null ? '' : widget.product['price'].toString(),
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
            return 'Price is required and should be a number.';
          }
        },
        decoration: InputDecoration(labelText: 'Product Price'),
        onSaved: (String price) {
          _formData['price'] = double.parse(price);
        },
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (widget.product == null) {
      widget.addProduct(_formData);
    } else {
      widget.updateProduct(widget.productIndex, _formData);
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.9;
    final double targetPadding = deviceWidth - targetWidth;
    final Widget pageContent = GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(),
              _buildDescriptionTextField(),
              _buildPriceTextField(),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                child: Text('Save'),
                textColor: Colors.white,
                onPressed: _submitForm,
              )
              // GestureDetector( // Super customizable gesture listener
              //   onTap: _submitForm,
              //   child: Container(
              //     color: Colors.green,
              //     padding: EdgeInsets.all(5.0),
              //     child: Text('My Button'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: pageContent,
          );
  }
}
