import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/QR%20Scanner/select_type_profile.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/home/wallet.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../constant/color.dart';
import '../../../provider/market_place_nfts.dart';
import '../../../provider/other_profile.dart';
import '../../../services/locator.dart';
import '../../../services/navigation_service.dart';
import '../search/nftDetails.dart';
class QRScanner extends StatefulWidget {
  final TabController? tabController;
  final bool back;
  const QRScanner({Key? key, this.back=false,this.tabController}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  // Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool loading=false;
  bool isScanned=false;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderPage(
        loading: loading,
        child: Column(
          children: <Widget>[
            Expanded(flex: 4, child: _buildQrView(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = 256.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: whiteBorderColor,
              // borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanArea),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
    /* if(!widget.back)   Positioned( right: 20,top: 63,
          child: Container(
            height: 76,width: 35,
            decoration:BoxDecoration(borderRadius: BorderRadius.circular(800),color: whiteColor.withOpacity(.2)) ,
            child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: (){
                        widget.tabController?.animateTo(1);
                      },
                      child: SvgPicture.asset("assets/icons/explore_more 1.svg",width: 18,height: 16,)),
                  const SizedBox(height: 16,),
                  InkWell(
                      onTap: (){
                        locator<NavigationService>().namedNavigateTo(Wallet.route);
                      },
                      child: SvgPicture.asset("assets/icons/wallet.svg",width: 18,height: 16,))
                ]),
          ),
        ),*/
       // if(result!=null)Align(
       //     alignment: Alignment.bottomCenter,
       //     child: Padding(
       //       padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 120),
       //       child: Text(result!.code??"search"),
       //     )),
/*
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: whiteColor,),
            child: Center(
              child: Container(
                height:48,width: 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100), color: whiteColor,
                    border: Border.all(color: blackColor,width: 2)),
              ),
            ),

          ),
        ),
*/
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    try{
      setState(() {
        this.controller = controller;
      });
      controller.scannedDataStream.listen((scanData) async {
          if ((scanData.code!.startsWith("details-")||scanData.code!.startsWith("profile-"))&&isScanned==false){
            controller.pauseCamera();
            setState(() {
              loading = true;
              isScanned=true;
            });
            if (scanData.code!.startsWith("profile-")) {
              List<String>? dataList =scanData.code?.replaceAll("profile-","").split("/email")??[];
              if(widget.back){
                locator<NavigationService>().goBack(data:dataList[1] );
                setState(() {
                  loading = false;
                });
              }
              if(widget.back==false){
                if(dataList[2]=="2"){
                  var user=Provider.of<User>(context,listen: false).user;
                  setState(() {loading=true;});
                  Provider.of<OtherUserProfile>(context,listen: false).getOtherUserProfile(id:dataList[0],user_id:user?.id).then((value) {
                  setState(() {
                  loading=false;
                  isScanned=false;
                  });
                  controller.resumeCamera();
                  });
                }else{
                  locator<NavigationService>()
                      .push(MaterialPageRoute(builder: (context) => SelectOption(code:scanData.code!),settings: const RouteSettings(name: SelectOption.route))).then((value) {
                    setState(() {
                      loading=false;
                      isScanned=false;
                    });
                    controller.resumeCamera();
                  });
                }

              }
              // });
            }
            if (scanData.code!.startsWith("details-")&&widget.back==false) {
              Provider.of<Nfts>(context, listen: false)
                  .getNftDetails(scanData.code!.replaceAll("details-", "").split("-/ownerID")[0],scan: 1,ownerId:scanData.code!.replaceAll("details-", "").split("-/ownerID")[1])
                  .then((_) async {
                loading = await locator<NavigationService>().push(MaterialPageRoute(
                    builder: (context) => const NftDetails(),
                    settings: const RouteSettings(name: NftDetails.route)));
                setState(() {});
                if (!loading) {
                  isScanned=false;
                  controller.resumeCamera();
                }
              });
            }
          }
      });
    }catch(_){}
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}