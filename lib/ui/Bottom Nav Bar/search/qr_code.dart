import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nftwist/constant/apiConstant.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/rendering.dart';
class QRCode extends StatefulWidget {
  final bool userQr;
  final bool myQr;
  final bool nftQr;
  final bool partnerQr;
  final String qrString;
  final String? NFTname;
  final String? name;
  final String? username;
  // final double? price;
  // final String? dollarValue;
  final String? image;
  final String? mediaType;

  const QRCode(
      {Key? key,
      this.userQr = false,
      this.myQr = false,
      this.nftQr = false,
      this.partnerQr = false,
      this.qrString = "123464758472",
      this.NFTname,
      // this.price,
      this.image,
      // this.dollarValue,
      this.mediaType, this.name, this.username})
      : super(key: key);
  static const route = 'qr-code';

  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  final GlobalKey _globalKey = GlobalKey();
  Future<void> _shareImage(text) async {
    try {
      print('inside');
      RenderRepaintBoundary boundary =
      _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      // var _image = MemoryImage(pngBytes);
      final directory = await getTemporaryDirectory();
      final imageFile = File('${directory.path}/temp_image.png');
      await imageFile.writeAsBytes(pngBytes);


      // Share the image using the share package
      // await Share.shareFiles([imageFile.path],text: text);
       await Share.shareXFiles([XFile(imageFile.path)]);
    } catch (e) {
      print(e);
      // Handle the error in your specific use case
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.mediaType);
    if (widget.mediaType == "VIDEO") {
      _controller = VideoPlayerController.networkUrl(Uri.parse("$videoBaseUrl${widget.image!}"));
      _initializeVideoPlayerFuture= _controller.initialize().then((_) {
        // Ensure the video is looped.
        _controller.setLooping(true);
        // Start playing the video.
        _controller.play();
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.myQr
            ? "My QR Code"
            : widget.userQr
                ? "User QR Code"
                : widget.nftQr
                    ? "NFT QR Code"
                    : widget.partnerQr
                        ? "Partner QR Code"
                        : '',
        data: true,
      ),
      body: SingleChildScrollView(
        physics: MediaQuery.of(context).size.height > 667.0
            ? const NeverScrollableScrollPhysics()
            : const ScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 105,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  constraints:
                      BoxConstraints(maxHeight: widget.userQr ? 520 : 540),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.only(top: 90),
                  decoration: BoxDecoration(
                      border: Border.all(color: blackBorderColor),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      if (widget.nftQr == true) ...[
                        Text(
                          widget.NFTname.toString(),
                          style: w_700.copyWith(fontSize: 20),
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // Text(
                        //   "${widget.price??0} MATIC",
                        //   style: w_600.copyWith(fontSize: 16),
                        // ),
                        // const SizedBox(
                        //   height: 4,
                        // ),
                        // Text(
                        //   "${(widget.price??0.1 * double.parse(widget.dollarValue!)).toStringAsFixed(6)} USD",
                        //   style: w_400.copyWith(fontSize: 14),
                        // ),
                        const SizedBox(
                          height: 15,
                        ),
                      ] else ...[
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          widget.name??'',
                          style: w_700.copyWith(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "@${widget.username}",
                          style: w_600.copyWith(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                      RepaintBoundary(
                        key: _globalKey,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: blackColor2),
                          child: Column(
                            children: [
                              QrImageView(
                                data: widget.qrString,
                                version: QrVersions.auto,
                                size: 180.0,
                                eyeStyle: const QrEyeStyle(
                                    eyeShape: QrEyeShape.square,
                                    color: whiteColor),
                                dataModuleStyle: const QrDataModuleStyle(
                                    dataModuleShape: QrDataModuleShape.square,
                                    color: whiteColor),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                widget.myQr
                                    ? "My QR Code"
                                    : widget.userQr
                                    ? "User QR Code"
                                    : widget.nftQr
                                    ? "NFT QR Code"
                                    : widget.partnerQr
                                    ? "Partner QR Code"
                                    : '',
                                style: w_600.copyWith(fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Button(buttonTxt: "Share QR Code", function: () async {

                        _shareImage(widget.qrString);
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 20,width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [widget.myQr || widget.userQr || widget.partnerQr
                    ? Container(
                    height: 160,width: 160,
                    decoration:  BoxDecoration(
                      gradient:widget.myQr? const LinearGradient(
                        colors: [
                          Color(0xFF00FFDD),
                          Color(0xFF2BCAE4),
                          Color(0xFF6383EE),
                          Color(0xFF904BF5),
                          Color(0xFFB123FA),
                          Color(0xFFC50AFE),
                          Color(0xFFCC01FF),
                        ],
                        stops: [
                          0.0,
                          0.1615,
                          0.3281,
                          0.5052,
                          0.6771,
                          0.8229,
                          1.0,
                        ],
                      ):null,
                      shape: BoxShape.circle,
                      color: appColor,
                    ),
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(3.0),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(imageUrl:"$imageBaseUrl${widget.image}",
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          return Image.asset("assets/images/banner-image.png",fit: BoxFit.cover,);
                        },        placeholder: (context, imageProvider) {
                          return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
                        },   

                      ),
                    )

                )
                    : Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    color: blackColor2,
                    image: widget.mediaType == "VIDEO"
                        ? null
                        : DecorationImage(
                        image: CachedNetworkImageProvider("${widget.mediaType=="IMAGE"?imageBaseUrl:gifBaseUrl}${widget.image}"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: widget.mediaType == "VIDEO"
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _controller!=null?FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CupertinoActivityIndicator(color: whiteColor),
                          );
                        } else {
                          return VideoPlayer(_controller!);
                        }
                      },
                    ):null,)
                      : null,
                ),],)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
