import 'package:flutter/material.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/User%20profile/owned_nft_list.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';
 
import '../../../provider/other_profile.dart';
import '../../../services/locator.dart';
import '../../../services/navigation_service.dart';
import '../../../widget/button.dart';
class SelectOption extends StatefulWidget {
  final String? code;
  const SelectOption({super.key,this.code});
static const route="select_option";

  @override
  State<SelectOption> createState() => _SelectOptionState();
}

class _SelectOptionState extends State<SelectOption> {
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    var user=Provider.of<User>(context).user;
    var id=widget.code?.replaceAll("profile-","").split("/email");
    return Scaffold(
      appBar: const CustomAppBar(data: false,),
      body: WillPopScope(
        onWillPop: () async => false,
        child: LoaderPage(
          loading: loading,
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Expanded(child: Button_2(buttonTxt: 'Gift NFT', function: () async {
            locator<NavigationService>()
                    .push(MaterialPageRoute(builder: (context) => OwnedNfts(email:id?[1]),settings: const RouteSettings(name: OwnedNfts.route)));
              },radius: 23,verticalPadding: 10,horizontalPadding: 20,)),
              Expanded(child: Button_2(buttonTxt: 'View User Detail', function: ()async{
                setState(() {
                  loading=true;
                });
                loading =await Provider.of<OtherUserProfile>(context,listen: false).getOtherUserProfile(id:id?[0],user_id:user?.id);
                setState(() {
                 }); },radius: 23,verticalPadding: 10,horizontalPadding: 20,)),
            const SizedBox(height: 20,),
             ],
          ),
        ),
      ),
    );
  }
}
