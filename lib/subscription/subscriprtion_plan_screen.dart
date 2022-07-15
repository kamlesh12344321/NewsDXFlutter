import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:newsdx/model/subscription_plan.dart';
import 'package:newsdx/subscription/subscription_plan_widget.dart';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:newsdx/widgets/common_toolbar.dart';
import 'package:provider/provider.dart';
import '../app_constants/string_constant.dart';
import '../preference/user_preference.dart';
import '../router/app_state.dart';
import '../router/ui_pages.dart';
import '../screens/login_screen.dart';
import '../userprofile/user_profile_info_screen.dart';
import 'consumable_store.dart';

class SubscriptionPlanScreen extends StatefulWidget {
  // final List<Plan>? subscriptionPlanList;
  const SubscriptionPlanScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionPlanScreen> createState() => _SubscriptionPlanScreenState();
}


const bool _kAutoConsume = true;
const String _kConsumableId = 'consumable';
const String _kSilverSubscriptionId = 'subscription_silver';
const String _kGoldSubscriptionId = 'subscription_gold';


class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  List<String> _consumables = <String>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;


  late SubscriptionPlan mSubscriptionPlane;
   List<String> kPro = [];

  @override
  void initState() {
    super.initState();

    setState((){
      fetchPost().then((value) => {
        kPro = value
      });
    });

  }
  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    final PageController controller = PageController(
      viewportFraction: 0.8
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          leading: Transform.scale(
            scale: 1.2,
            child: IconButton(
                icon: SvgPicture.asset("assets/back.svg"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
          actions: [
            Padding(
              padding:  const EdgeInsets.only(right: 16),
              child: IconButton(
                icon: Transform.scale(
                  scale: 1,
                  child:   CircleAvatar(
                    backgroundImage: Prefs.getIsLoggedIn() == true ?
                    NetworkImage(Prefs.getUserImageUrlInfo()!) : const NetworkImage('https://newsdx.io/assets/others/carbon_user-avatar-filled.svg') ,
                    radius: 15,
                  ),
                ),
                onPressed: () {
                  // if(Prefs.getIsLoggedIn() == true){
                  //   appState.currentAction = PageAction(
                  //       state: PageState.addWidget,
                  //       widget: const UserProfileInfoScreen(),
                  //       page: UserProfileInfoPageConfig);
                  // } else{
                  //   appState.currentAction = PageAction(
                  //       state: PageState.addWidget,
                  //       widget: const LoginScreen(),
                  //       page: LoginPageConfig);
                  }
                // },
              ),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 21,
                    ),
                    child: SizedBox(
                      height: 37,
                      width: 39,
                      child: SvgPicture.asset("assets/app_logo_new.svg"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      top: 21,
                    ),
                    child: Column(
                      children: [
                        Text(
                          MyConstant.appName,
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        Text(
                          MyConstant.appType,
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
               Padding(
                padding: const  EdgeInsets.only(top: 6, left: 16),
                child: SizedBox(
                    child: Text(
                  'Subscription Plan',
                 style: GoogleFonts.roboto(
                   fontSize: 30,
                   fontWeight: FontWeight.w900,
                   color: Colors.black
                 ),),),
              ),
              const SizedBox(height: 50,),
              Expanded(
                child:  PageView.builder(
                  itemCount: _products.length,
                  controller:  controller,
                  itemBuilder: (context,index){
                    return SubscriptionPlanCard(data: _products[index],);
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
               Align(
                alignment: Alignment.bottomCenter,
                child: Text('For support contact ', style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14
                ),),
              ),
              Align(
               alignment: Alignment.bottomCenter,
               child:  Text('wecare@alpinenews.com', style: GoogleFonts.roboto(
                 color: Colors.blue,
                 fontSize: 14,
                 fontWeight: FontWeight.w500
               ),),
             )
            ],
          ),
        ));

  }

  Future<List<String>> fetchPost() async {
    List<String>  _kProductIds  =[];
    String? getAccessToken = "Bearer ${"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0aW1lIjoxNjU1NzA5MTA4LCJwcm9wZXJ0eUtleSI6IjBhNDE1OTA2ZGYyZmQ2NDM3MzNiODY1MTY3YWRiMTlkIn0.DveZXEDBB2OJIUU31KlHexj-1L1nYEx1Uxisv45Q0oU"}";

    Map data = {
      "app_bundleId": "in.ninestars.NewsDX",
      // "propertyKey": "0a415906df2fd643733b865167adb19d",
    };

    var url = Uri.parse("https://api.newsdx.io/V1/List_in_app_products/apple");
    final response = await http.post(url,
        body: data,
      headers: {
        "Authorization" : MyConstant.propertyToken
      },
    );

    if (response.statusCode == 200) {
      final subscriptionPlan = subscriptionPlanFromJson(response.body);
      for (int i = 0; i < subscriptionPlan.data!.length; i++) {
        _kProductIds.add(subscriptionPlan.data![i].productId.toString());
      }
      _kProductIds.add("article_30");
      _kProductIds.add("article_50");
      _kProductIds.add("article_40");
      _kProductIds.add("article_20");

      initStoreInfo(_kProductIds);
      return _kProductIds;
    }
    return [];
  }

  Future<void> initStoreInfo(List<String> kProductIds) async {
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
        debugPrint("kk1 initStoreInfo-> product${_products.length} ${_purchases.length} ${_notFoundIds.length}");
      });
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    // List<String> _kProductIds = [];
    final ProductDetailsResponse productDetailResponse =
    await _inAppPurchase.queryProductDetails(kProductIds.toSet());
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

    List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
  }

  Future<void> consume(String id) async {
    await ConsumableStore.consume(id);
    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _consumables = consumables;
    });
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
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

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
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
  }

  Future<void> confirmPriceChange(BuildContext context) async {
    if (Platform.isAndroid) {
      final InAppPurchaseAndroidPlatformAddition androidAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      final BillingResultWrapper priceChangeConfirmationResult =
      await androidAddition.launchPriceChangeConfirmationFlow(
        sku: 'purchaseId',
      );
      if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Price change accepted'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            priceChangeConfirmationResult.debugMessage ??
                'Price change failed with code ${priceChangeConfirmationResult.responseCode}',
          ),
        ));
      }
    }
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iapStoreKitPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
    }
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




/// Example implementation of the
/// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
///
/// The payment queue delegate can be implementated to provide information
/// needed to complete transactions.
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}

