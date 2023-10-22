import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nftwist/constant/apiConstant.dart';
import 'package:video_player/video_player.dart';

import '../constant/color.dart';

class ActivityNFTs extends StatefulWidget {
  final String? mediaType;
  final String? image;
  final double? width;
  final double? height;
  final double? borderRadius;
  const ActivityNFTs({super.key, this.mediaType, this.image, this.width, this.height, this.borderRadius});

  @override
  State<ActivityNFTs> createState() => _ActivityNFTsState();
}

class _ActivityNFTsState extends State<ActivityNFTs> {
   VideoPlayerController? _controller;
   Future<void>? _initializeVideoPlayerFuture;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.mediaType=="VIDEO"){
      _controller=VideoPlayerController.networkUrl(Uri.parse("$videoBaseUrl${widget.image}"));
      _initializeVideoPlayerFuture =
          _controller?.initialize().then((_) {
            setState(() {});
          });
    }

  }
  @override
  void dispose() {
    if(widget.mediaType=="VIDEO"){
      _controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height??69,
      width: widget.width??69,
      decoration:widget.mediaType=="VIDEO"? null:  BoxDecoration(
        borderRadius:BorderRadius.circular(widget.borderRadius??12),
        image:DecorationImage(
            image: CachedNetworkImageProvider("${widget.mediaType=="IMAGE"?imageBaseUrl:gifBaseUrl}${widget.image}",
            ),
            fit: BoxFit.cover
        ),
      ),
      child:  widget.mediaType=="VIDEO"?
      ClipRRect(borderRadius:   BorderRadius.circular(12),
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: SizedBox(
              height: 69,
              width: 69,
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting||_controller==null) {
                    return const Center(
                      child: CupertinoActivityIndicator(color: whiteColor),
                    );
                  }else if(snapshot.hasError){
                    return Image.asset("assets/images/john_doe_cover.png",fit: BoxFit.cover,);
                  } else {
                    return VideoPlayer(_controller!);
                  }
                },
              )
          ),
        ),
      )
          :null,
    );
  }
}




class ActivityFollow extends StatelessWidget {
  final String? cover;
  final String? image;
  const ActivityFollow({super.key, this.cover, this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 90,
      child: Stack(
        children: [
          Container(
            height: 69,
            width: 69,
            decoration:   BoxDecoration(
              borderRadius:BorderRadius.circular(12),
            ),
child: ClipRRect(
  borderRadius:BorderRadius.circular(12),
  child: CachedNetworkImage(imageUrl: "$imageBaseUrl$cover",
          fit: BoxFit.cover,
          errorWidget: (context, url, error) {
            return Image.asset("assets/images/banner-image.png",fit: BoxFit.cover,);
          },placeholder: (context, imageProvider) {
            return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
          },),
),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(radius: 20,backgroundImage: CachedNetworkImageProvider("$imageBaseUrl$image"),))
        ],
      ),
    );
  }

}
