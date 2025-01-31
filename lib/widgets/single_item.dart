import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:provider/provider.dart';

class SingleItem extends StatefulWidget {
  final bool isBool;
  final String productImage;
  final String productName;
  final bool wishList;
  final int productPrice;
  final String productId;
  final int productQuantity;
  final Function() onDelete;
  final String? productUnit;

  SingleItem({
    required this.productQuantity,
    required this.productId,
    this.productUnit,
    required this.onDelete,
    required this.isBool,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.wishList,
  });

  @override
  _SingleItemState createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  late int count;
  ReviewCartProvider? reviewCartProvider;

  @override
  void initState() {
    super.initState();
    count = widget.productQuantity;
  }

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider!.getReviewCartData();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 90,
                  child: Center(
                    child: Image.network(
                      widget.productImage,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 90,
                  child: Column(
                    mainAxisAlignment: widget.isBool
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productName,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "\$${widget.productPrice}",
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      widget.isBool
                          ? Text(widget.productUnit ?? "")
                          : GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          title: Text('50 Gram'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          title: Text('500 Gram'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          title: Text('1 Kg'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 35,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "50 Gram",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 20,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 90,
                  padding: widget.isBool
                      ? EdgeInsets.only(left: 15, right: 15)
                      : EdgeInsets.symmetric(horizontal: 15, vertical: 32),
                  child: widget.isBool
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: widget.onDelete,
                                child: Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 5),
                              widget.wishList
                                  ? Container()
                                  : Container(
                                      height: 25,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (count == 1) {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "You have reached the minimum limit",
                                                  );
                                                } else {
                                                  setState(() {
                                                    count--;
                                                  });
                                                  reviewCartProvider!
                                                      .updateReviewCartData(
                                                    cartImage: widget.productImage,
                                                    cartId: widget.productId,
                                                    cartName: widget.productName,
                                                    cartPrice: widget.productPrice,
                                                    cartQuantity: count,
                                                  );
                                                }
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                color: primaryColor,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              "$count",
                                              style: TextStyle(
                                                color: primaryColor,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (count < 10) {
                                                  setState(() {
                                                    count++;
                                                  });
                                                  reviewCartProvider!
                                                      .updateReviewCartData(
                                                    cartImage: widget.productImage,
                                                    cartId: widget.productId,
                                                    cartName: widget.productName,
                                                    cartPrice: widget.productPrice,
                                                    cartQuantity: count,
                                                  );
                                                }
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color: primaryColor,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        )
                      : Container(),
                ),
              ),
            ],
          ),
        ),
        widget.isBool
            ? Divider(
                height: 1,
                color: Colors.black45,
              )
            : Container(),
      ],
    );
  }
}
