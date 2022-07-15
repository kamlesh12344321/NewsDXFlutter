import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:newsdx/model/subscription_plan.dart';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:newsdx/subscription/subscriprtion_plan_screen.dart';

import '../utils/device_information_list.dart';
import 'consumable_store.dart';


const bool _kAutoConsume = true;
const String _kConsumableId = 'consumable';
const String _kSilverSubscriptionId = 'subscription_silver';
const String _kGoldSubscriptionId = 'subscription_gold';

class SubscriptionPlanCard extends StatefulWidget {
  final ProductDetails data ;
  const SubscriptionPlanCard({Key? key, required this.data}) : super(key: key);

  @override
  State<SubscriptionPlanCard> createState() => _SubscriptionPlanCardState();
}

class _SubscriptionPlanCardState extends State<SubscriptionPlanCard> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _consumables = <String>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  bool _purchasePending = false;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> _products = <ProductDetails>[];
  bool _isAvailable = false;
  bool _loading = true;
  String? _queryProductError;
   final List<String> _kProductIds = <String>[
    "article_30",
    "article_40",
    "article_50",
    "article_20",
    "article_60",
  ];


  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
          _listenToPurchaseUpdated(purchaseDetailsList);
          debugPrint("kk1 initStoreInfo-> product${purchaseDetailsList.length}");
        }, onDone: () {
          _subscription.cancel();
        }, onError: (Object error) {
          // handle error here.
        });
    initStoreInfo();
    super.initState();
  }
  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];
        _notFoundIds = <String>[];
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse =
    await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {

         if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          }
        }
        if (Platform.isAndroid) {
          if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
            _inAppPurchase.getPlatformAddition<
                InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    if (purchaseDetails.productID == _kConsumableId) {
      await ConsumableStore.save(purchaseDetails.purchaseID!);
      final List<String> consumables = await ConsumableStore.load();
      setState(() {
        _purchasePending = false;
        _consumables = consumables;
      });
    } else {
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {


    const Color topPicksSectionBg = Color(0xFF0F74FF);
    return Card(
      color: topPicksSectionBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child:  Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Padding(
                padding:  EdgeInsets.all(7.0),
                child:  Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Recommended",style: TextStyle(color: Colors.white),),
                    ),
                    Padding(padding: EdgeInsets.all(10.0),),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(widget.data.title.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            Text(widget.data.price,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(10.0),
                      child: Text(widget.data.description.toString(),style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding:  EdgeInsets.all(7.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child:  Text("Checkout",
                          style: TextStyle(
                              color: topPicksSectionBg,
                              fontWeight: FontWeight.w400
                          ),),
                        onPressed: ()  {
                          final Map<String, PurchaseDetails> purchases =
                          Map<String, PurchaseDetails>.fromEntries(
                              _purchases.map((PurchaseDetails purchase) {
                                if (purchase.pendingCompletePurchase) {
                                  _inAppPurchase.completePurchase(purchase);
                                }
                                return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
                              }));
                          late PurchaseParam purchaseParam;
                          if (Platform.isAndroid) {
                            final GooglePlayPurchaseDetails? oldSubscription =
                            _getOldSubscription(widget.data, purchases);

                            purchaseParam = GooglePlayPurchaseParam(
                                productDetails: widget.data,
                                applicationUserName: null,
                                changeSubscriptionParam: (oldSubscription != null)
                                    ? ChangeSubscriptionParam(
                                  oldPurchaseDetails: oldSubscription,
                                  prorationMode:
                                  ProrationMode.immediateWithTimeProration,
                                )
                                    : null);
                          } else {
                            purchaseParam = PurchaseParam(
                              productDetails: widget.data,
                              applicationUserName: null,
                            );
                          }

                          if (widget.data.id == _kConsumableId) {
                            _inAppPurchase.buyConsumable(
                                purchaseParam: purchaseParam,
                                autoConsume: _kAutoConsume || Platform.isIOS);
                          } else {
                            _inAppPurchase.buyNonConsumable(
                                purchaseParam: purchaseParam);
                          }



                        },
                      ),

                    ),

                    /*Container(
                      height: 150,
                      child:  ListView.builder(
                          itemCount: widget.data.description!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return  Padding(padding: EdgeInsets.only(left: 16), child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset("assets/tick.svg"),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:  Text(widget.data.productFeatures![index].toString(), style: TextStyle(color: Colors.white),),
                                )
                              ],
                            ),);
                          }),
                    )*/
                  ],
                ))
          ],
        ),
      ),
    );
  }

  GooglePlayPurchaseDetails? _getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    // This is just to demonstrate a subscription upgrade or downgrade.
    // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
    // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
    // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
    // Please remember to replace the logic of finding the old subscription Id as per your app.
    // The old subscription is only required on Android since Apple handles this internally
    // by using the subscription group feature in iTunesConnect.
    GooglePlayPurchaseDetails? oldSubscription;
    if (productDetails.id == _kSilverSubscriptionId &&
        purchases[_kGoldSubscriptionId] != null) {
      oldSubscription =
      purchases[_kGoldSubscriptionId]! as GooglePlayPurchaseDetails;
    } else if (productDetails.id == _kGoldSubscriptionId &&
        purchases[_kSilverSubscriptionId] != null) {
      oldSubscription =
      purchases[_kSilverSubscriptionId]! as GooglePlayPurchaseDetails;
    }
    return oldSubscription;
  }

}




