import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nftwist/constant/apiConstant.dart';
import 'package:nftwist/constant/style.dart';
import 'package:video_player/video_player.dart';

import '../../constant/color.dart';
import '../button.dart';
class PartnerWidget extends StatelessWidget {
  final void Function()? onTap;
  const PartnerWidget({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height:120,
        width: 120,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
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
          ),
         borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/become_a_partner.svg"),
            const Text("Become a\nPartner",textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
class PartnerWidget_2 extends StatefulWidget {
  final String? onImageTitle;
  final String? onImageSubtitle;
  final String image;
  final double minHeight;
  final double minWidth;
  final String? media_type;
  final onTap;

  const PartnerWidget_2({
    Key? key,
    required this.image,
      this.onImageTitle,
      this.onImageSubtitle,this.minHeight=120,this.minWidth=120, required this.media_type, this.onTap,
  }) : super(key: key);

  @override
  State<PartnerWidget_2> createState() => _PartnerWidget_2State();
}

class _PartnerWidget_2State extends State<PartnerWidget_2> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.media_type=="VIDEO"){
      _controller=VideoPlayerController.networkUrl(Uri.parse("$videoBaseUrl${widget.image.toString()}"));
      _initializeVideoPlayerFuture =
          _controller.initialize().then((_) {
            setState(() {});
          });
        _controller.play();
        _controller.setLooping(true);
        _controller.setVolume(0);
      }

  }

  @override
  void dispose() {
    if(widget.media_type=="VIDEO"){
      _controller.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16,),
      child: UnicornOutlineButton(
        strokeWidth: 2,minHeight: widget.minHeight,minWidth: widget.minWidth,
        radius: 12,
        gradient: const LinearGradient(
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
        ),
        onPressed: widget.onTap,
        child: Container(
          margin: const EdgeInsets.all(2),width: 130,
          decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(9)      ),
          child: Stack(
            children: [
           if( widget.media_type=="VIDEO")
              ClipRRect(borderRadius: BorderRadius.circular(9),
                child: FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return VideoPlayer(_controller);
                    } else {
                      return const Center(
                        child: CupertinoActivityIndicator(color: whiteColor),
                      );
                    }
                  },
                ),
              )
           else ClipRRect(borderRadius: BorderRadius.circular(9),
               child: SizedBox(
                 height: 400,
                 width: MediaQuery.of(context).size.width,
                 child: CachedNetworkImage(imageUrl: "${widget.media_type=="IMAGE"?imageBaseUrl:gifBaseUrl}${widget.image.toString()}",
                   fit: BoxFit.cover,
                   errorWidget: (context, url, error) {
                   return Image.asset("assets/images/banner-image.png",fit: BoxFit.cover,);
                 },     placeholder: (context, imageProvider) {
                   return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
                 },),
               )   ,),
              if(widget.onImageTitle!=null||widget.onImageSubtitle!=null)Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(widget.onImageTitle??"",style: w_500,textAlign: TextAlign.start,),
                    Text(widget.onImageSubtitle??"",style: w_500.copyWith(fontSize: 12),textAlign: TextAlign.start,),],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
