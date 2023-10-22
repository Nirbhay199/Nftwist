import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../constant/apiConstant.dart';
import '../../constant/color.dart';
import '../../constant/style.dart';
class OngoingCampaign extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final String mediaType;
  final int? totalAvailableNfts;
  final int? totalNfts;
  final onTap;
  const OngoingCampaign({Key? key, required this.title, required this.description, required this.image, this.totalAvailableNfts, this.totalNfts, this.onTap, required this.mediaType}) : super(key: key);

  @override
  State<OngoingCampaign> createState() => _OngoingCampaignState();
}

class _OngoingCampaignState extends State<OngoingCampaign> {
  VideoPlayerController? _controller;
  late Future<void> _initializeVideoPlayerFuture;
@override
  void initState() {
    // TODO: implement initState
  if(widget.mediaType=="VIDEO"){
    _controller = VideoPlayerController.networkUrl(Uri.parse("$videoBaseUrl${widget.image}}"));
    _initializeVideoPlayerFuture= _controller!.initialize().then((_) {
      // Ensure the video is looped.
      _controller?.setLooping(true);
      // Start playing the video.
      _controller?.play();
      setState(() {});
    });}
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin:const EdgeInsets.fromLTRB(20,0,20,16),
        decoration: BoxDecoration(
            border: Border.all(color: blackBorderColor),
            borderRadius: BorderRadius.circular(12)
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:  widget.mediaType=="VIDEO"?   FittedBox(
                fit: BoxFit.fitWidth,
                child: SizedBox(
                  height:180,
                  width: MediaQuery.of(context).size.width,
                  child:_controller!=null?FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CupertinoActivityIndicator(color: whiteColor),
                        );
                      }
                      else {
                        return VideoPlayer(_controller!);
                      }
                    },
                  ):null,
                ),
              )
                  :CachedNetworkImage(
                imageUrl:"${widget.mediaType=="IMAGE"?imageBaseUrl:gifBaseUrl}${widget.image.toString()}",
                height: 180,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                errorWidget: (context, url, error) {
                  return Image.asset("assets/images/john_doe_cover.png",fit: BoxFit.cover,);
                },placeholder: (context, imageProvider) {
                return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
              },
              ) ,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title.toString(),style: w_700,),
                  const SizedBox(height: 4,),
                  Text("Current Available NFTs ${widget.totalAvailableNfts}/${widget.totalNfts}",style: w_500.copyWith(fontSize: 16,color: textColor2),),
                  const SizedBox(height: 8,),
                  Text("Current NFT Utility:",style: w_400.copyWith(fontWeight: FontWeight.w400,fontSize: 14),),
                  // ListView.builder(
                  //   padding: const EdgeInsets.only(top: 13),
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemCount: items.length,
                  //   itemBuilder: (context, index) {
                  //     final item = items[index];
                  //     final itemNumber = index + 1;
                  //     return Row(crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text('$itemNumber-   ',style: w_400.copyWith(fontSize: 12),),
                  //         SizedBox(width:270,
                  //         child: Text('$item\n',style: w_400.copyWith(fontSize: 12),)),
                  //       ],
                  //     );
                  //   },
                  // )
                  Text("${widget.description}\n")

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
