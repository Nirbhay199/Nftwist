import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nftwist/constant/apiConstant.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/constant/style.dart';
import 'package:video_player/video_player.dart';
class NewsFeed extends StatefulWidget {
  final void Function()? onTap;
  final String? name;
  final String? description;
  final String? file;
  final String? media_type;
  final String? collection_name;
  final String? collection_symbol;
  final String? first_name;
  final String? last_name;
  final String? user_name;
  final String? profile_pic;
  final bool? is_private;
  final int? likes_count;
  final int? comment_count;
  final String? createAt;
  final bool isPaly;


  const NewsFeed({Key? key, this.onTap, required this.name, required this.description, required this.file, required this.media_type, required this.collection_name, required this.collection_symbol, required this.first_name, required this.last_name, required this.user_name, required this.profile_pic, required this.is_private, required this.likes_count, required this.comment_count,this.isPaly=false, this.createAt}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.media_type=="VIDEO"){
      _controller=VideoPlayerController.networkUrl(Uri.parse("$videoBaseUrl${widget.file.toString()}"));
      _initializeVideoPlayerFuture =
          _controller.initialize().then((_) {
            setState(() {});
          });
      if (widget.isPaly) {
        _controller.play();
        _controller.setLooping(true);
      }    }

  }



  @override
  void didUpdateWidget(oldWidget) {
    if (oldWidget.isPaly != widget.isPaly&&widget.media_type=="VIDEO"&&oldWidget.media_type=="VIDEO") {
      if (widget.isPaly) {
        _controller.play();
        _controller.setLooping(true);
      } else {
        _controller.pause();
      }
    }

    super.didUpdateWidget(oldWidget);
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
    return InkWell(
      onTap: widget.onTap,
      child: Container(
      height: 300,
      margin:const EdgeInsets.fromLTRB(20, 0, 20, 16),
      decoration: BoxDecoration(
         border: Border.all(color: blackBorderColor),
         borderRadius: BorderRadius.circular(12)
      ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(margin: const EdgeInsets.all(16),
                  height: 110,width: MediaQuery.of(context).size.width,
                  decoration:widget.media_type=="VIDEO"? null:  BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image:widget.media_type=="VIDEO"?null:DecorationImage(
                        image:NetworkImage("${widget.media_type=="GIF"?gifBaseUrl:imageBaseUrl}${widget.file.toString()}"),
                        fit: BoxFit.cover,
                    ),
                  ),
                   child:  widget.media_type=="VIDEO"?
                  ClipRRect(borderRadius: const BorderRadius.only(topLeft: Radius.circular(11),topRight: Radius.circular(11)),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: SizedBox(
                        height: 350,
                        width: MediaQuery.of(context).size.width,
                        child: FutureBuilder(
                          future: _initializeVideoPlayerFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return VideoPlayer(_controller);
                            } else {
                              return const CupertinoActivityIndicator(color: whiteColor);
                            }
                          },
                        )
                      ),
                    ),
                  )
                      : null,
                ),


                Positioned(
                  right: 24,top: 24,
                    child: SvgPicture.asset("assets/icons/more_background.svg",height: 20,width: 20,))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(imageUrl: imageBaseUrl+widget.profile_pic.toString(),
                          height: 30,width: 30,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return Image.asset("assets/images/banner-image.png",fit: BoxFit.cover,);
                          },placeholder: (context, imageProvider) {
                            return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
                          },
                        )
                      ),
                    const SizedBox(width: 6,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(widget.user_name.toString(),style: w_100.copyWith(  fontFamily: GoogleFonts.montserrat(fontWeight: FontWeight.w500).fontFamily,),),
                      Text(
    DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.createAt!))).inDays>0?
                          "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.createAt!))).inDays.toString()} days ago":
    DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.createAt!))).inHours>0?
    "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.createAt!))).inHours.toString()} hours ago":
    DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.createAt!))).inMinutes>0?
    "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.createAt!))).inMinutes.toString()} minutes ago":
    "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.createAt!))).inSeconds.toString()} seconds ago",style: w_100.copyWith(
                        fontSize: 12,
                        fontFamily: GoogleFonts.montserrat(fontWeight: FontWeight.w400).fontFamily,),),
                    ],),
                    const Spacer(),
                    Column(children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/icons/heart.svg",height: 13.55,width: 12,),
                          const SizedBox(width: 5.2,),
                            Text(widget.likes_count!<9&&widget.likes_count!=0?"0${widget.likes_count}":widget.likes_count.toString(),style: w_100.copyWith(  fontFamily: GoogleFonts.montserrat(fontWeight: FontWeight.w500).fontFamily,fontSize: 12),),
                        ],
                      ),
                      const SizedBox(height: 2,),
                      Row(
                        children: [
                          SvgPicture.asset("assets/icons/message.svg",height: 13.55,width: 12,),
                          const SizedBox(width: 5.2,),
                            Text(widget.comment_count!<9&&widget.comment_count!=0?"0${widget.comment_count}":widget.comment_count.toString(),style: w_100.copyWith(  fontFamily: GoogleFonts.montserrat(fontWeight: FontWeight.w500).fontFamily,fontSize: 12),),
                        ],
                      ),
                    ],),
                  ],),
                  const SizedBox(height: 16,),
                  if(widget.collection_name!=null)Text(widget.collection_name.toString(),style: w_400.copyWith(fontSize: 12),),
                  const SizedBox(height: 4,),
                  if(widget.name!=null)Text(widget.name.toString(),style: w_500.copyWith(color: whiteColor),),
                  const SizedBox(height: 8,),
                  if(widget.description!=null)Text(widget.description.toString(),style: w_400.copyWith(fontSize: 12),maxLines: 2),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
