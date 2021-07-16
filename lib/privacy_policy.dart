import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEAF9FE),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xff478CA8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        title: Align(
          alignment: Alignment.center,
          child: Text('ANY BOOKS'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Color(0xff000000),
              elevation: 25,
              child: Container(
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Privacy Policy\n',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SelectableText(
                        'Het Joshi built The Any Books app as a Free app. This SERVICE is provided by Het Joshi at no cost and is intended for use as it is.\n\nThis page is used to inform visitors regarding my policies with the collection, use and disclosure of Personal Information if any one decided to use my Service.\n\nIf you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.\n\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at General Knowledge unless otherwise defined in this Privacy Policy.\n\nInformation Collection and Use\n\nFor a better experience, while using our Service, I may require you to provide us with certain personally identifiable information,including but not limited to not collecting any data. The information that I request will retained on your device and is not collected by me in any way.\n\nApp does use third party services that may collect information used to identify you.\n\nLink to privacy policy of third party service providers used by the app\n\nGoogle Play Services\n\nLog Data\n\nI want to inform you that whenever you usemy Service, in a case of an error in the app |collect data and information (through third party products) on your phone called LogData. This Log Data may include information such as your device Internet Protocol ("IP")address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date ofyour use of the Service, and other statistics.\n\nCookies\n\nCookies are files with a small amount of datathat are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit andare stored on your device\'s internal memory.\n\nThis Service does not use these "cookies”explicitly. However, the app may use third party code and libraries that use "cookies" to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.\n\nService Providers\n\nI may employ third-party companies and individuals due to the following reasons:\n\nTo facilitate our Service;\n\nTo provide the Service on our behalf;\n\nTo perform Service-related services; or\n\nTo assist us in analyzing how our Service is used.\n\nI want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.\n\nSecurity\n\nI value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security. Links to Other Sites This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.\n\nChildren\'s Privacy\n\nThese Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do necessary actions.\n\nChanges to This Privacy Policy\n\n I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.\n\nThis policy is effective as of 2021-04-22\n\nContact Us\n\nIf you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at hetcjoshi1684@gmail.com.',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'roboto',
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
