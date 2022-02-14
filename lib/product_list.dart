import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_todo/add_product.dart';
import 'package:tap_todo/bloc/product_bloc.dart';
import 'package:tap_todo/bloc/product_event.dart';
import 'package:tap_todo/bloc/product_state.dart';
import 'package:tap_todo/model/product_model.dart';
import 'package:tap_todo/utils/constants.dart';

class ProductList extends StatefulWidget {
  ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late ProductBloc _productBloc;
  final _searchController = TextEditingController();
  @override
  void initState() {
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _productBloc.add(ProductFetchEvent());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _productBloc.close();
    super.dispose();
  }

  void _showProductAddNotification() async {
    await Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      title: '',
      messageColor: Colors.greenAccent,
      backgroundColor: Theme.of(context).primaryColorDark,
      message: 'Product was added successfully.',
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Manage Product',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CutomTextField(
                hint: 'Search product',
                controller: _searchController,
                onChange: (value) {
                  _productBloc.add(ProductSearchEvent(query: value));
                }),
          ),
          Expanded(child: ProductBlocList(bloc: _productBloc)),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: SizedBox(
            width: double.infinity,
            child: CustomButton(
              isEnable: true,
              onPressed: () async {
                bool pop = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProduct()),
                );
                // ignore: unnecessary_null_comparison
                if (pop) {
                  _showProductAddNotification();
                  _productBloc.add(ProductFetchEvent());
                }
              },
              title: 'Add Product',
            )),
      ),
    );
  }
}

// ignore: must_be_immutable
class ProductBlocList extends StatefulWidget {
  ProductBloc bloc;
  ProductBlocList({Key? key, required this.bloc}) : super(key: key);

  @override
  State<ProductBlocList> createState() => _ProductBlocListState();
}

class _ProductBlocListState extends State<ProductBlocList> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
        bloc: widget.bloc,
        listener: (context, state) {},
        child: BlocBuilder<ProductBloc, ProductState>(
            bloc: widget.bloc,
            builder: (context, state) {
              if (state is FetchingProductListState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is FetchProductFailedState) {
                return Center(child: Text(state.message.toString()));
              }
              if (state is FetchingProductEmptyListState) {
                return const Text("No Data found");
              }

              if (state is FetchedProductSuccessedState) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: state.data!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Product _item = state.data![index];
                            return Column(
                              children: [
                                Card(
                                  color: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: Text(_item.name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(_item.description!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            _item.price!.toString() +
                                                ' ' +
                                                GlobalConstant.currency,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                ?.copyWith(
                                                    color: Theme.of(context)
                                                        .accentColor),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                              ],
                            );
                          })
                      : const Center(
                          child: Text('No Data.'),
                        ),
                );
              }
              return Container();
            }));
  }
}
