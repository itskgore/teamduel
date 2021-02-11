import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/user.dart';
import 'package:winx/screens/uploadDoc.dart';

class KycStatus extends StatefulWidget {
  const KycStatus({
    Key key,
  }) : super(key: key);

  @override
  _KycStatusState createState() => _KycStatusState();
}

class _KycStatusState extends State<KycStatus> {
  var data;
  bool loading = false;
  Future<void> getKYC() async {
    setState(() {
      loading = true;
    });
    final user = Provider.of<User>(context, listen: false);
    if (user.kyc.isEmpty) {
      await user.getKycStatus();
    } else {
      user.getKycStatus();
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getKYC();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: Consumer<User>(
        builder: (con, user, _) => GestureDetector(
          onTap: () {
            if (user.kyc[0].msg.toString() != 'KYC Verified.') {
              Navigator.push(context, FadeNavigation(widget: UploadDoc()));
            }
          },
          child: Text(loading ? 'Loading...' : '${user.kyc[0].msg.toString()}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(color: Colors.white, fontSize: 13)),
        ),
      ),
    );
  }
}
