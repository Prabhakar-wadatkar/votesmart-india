// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'वोटस्मार्ट इंडिया';

  @override
  String get homeTitle => 'डैशबोर्ड';

  @override
  String get chatTitle => 'AI सहायक';

  @override
  String get journeyTitle => 'चुनाव यात्रा';

  @override
  String get timelineTitle => 'चुनाव समयरेखा';

  @override
  String get profileTitle => 'मेरी प्रोफ़ाइल';

  @override
  String get welcomeMessage => 'वोटस्मार्ट इंडिया में आपका स्वागत है!';

  @override
  String get welcomeSubtitle =>
      'भारतीय चुनाव प्रक्रिया के लिए आपका AI-संचालित मार्गदर्शक';

  @override
  String get askAiAssistant => 'AI सहायक से पूछें';

  @override
  String get startJourney => 'यात्रा शुरू करें';

  @override
  String get viewTimeline => 'समयरेखा देखें';

  @override
  String get journeyProgress => 'यात्रा प्रगति';

  @override
  String get eligibilityStatus => 'पात्रता स्थिति';

  @override
  String get nextElection => 'अगला चुनाव';

  @override
  String get eligible => 'मतदान के लिए पात्र';

  @override
  String get notEligible => 'अभी पात्र नहीं';

  @override
  String daysUntilEligible(int days) {
    return 'आप $days दिनों में पात्र होंगे';
  }

  @override
  String get checkEligibility => 'पात्रता जाँचें';

  @override
  String get enterDateOfBirth => 'जन्म तिथि दर्ज करें';

  @override
  String get enterAge => 'अपनी आयु दर्ज करें';

  @override
  String get enterLocation => 'अपना स्थान दर्ज करें';

  @override
  String get detectLocation => 'मेरा स्थान पहचानें';

  @override
  String get step1Eligibility => 'पात्रता जाँच';

  @override
  String get step2Registration => 'मतदाता पंजीकरण';

  @override
  String get step3Verification => 'मतदाता पहचान पत्र सत्यापन';

  @override
  String get step4Timeline => 'चुनाव समयरेखा';

  @override
  String get step5VotingDay => 'मतदान दिवस प्रक्रिया';

  @override
  String get step6Results => 'परिणाम घोषणा';

  @override
  String get step1Desc =>
      'अपनी आयु और नागरिकता के आधार पर जाँचें कि आप भारतीय चुनावों में मतदान के लिए पात्र हैं या नहीं।';

  @override
  String get step2Desc =>
      'फॉर्म 6 का उपयोग करके ऑनलाइन या अपने निकटतम ERO कार्यालय में मतदाता के रूप में पंजीकरण कैसे करें।';

  @override
  String get step3Desc =>
      'अपने मतदाता पहचान पत्र (EPIC) को कैसे सत्यापित करें और मतदाता सूची में अपना नाम जाँचें।';

  @override
  String get step4Desc =>
      'आगामी चुनाव तिथियों, नामांकन की अंतिम तिथि और मतदान कार्यक्रम से अपडेट रहें।';

  @override
  String get step5Desc =>
      'मतदान दिवस की पूरी प्रक्रिया जानें — बूथ पहुँचने से लेकर EVM पर मतदान करने तक।';

  @override
  String get step6Desc =>
      'समझें कि वोटों की गिनती कैसे होती है, परिणाम कैसे घोषित होते हैं और विजेता कैसे तय होते हैं।';

  @override
  String get markComplete => 'पूर्ण चिह्नित करें';

  @override
  String get completed => 'पूर्ण';

  @override
  String get inProgress => 'प्रगति पर';

  @override
  String get notStarted => 'शुरू नहीं हुआ';

  @override
  String get chatHint => 'भारतीय चुनावों के बारे में कुछ भी पूछें...';

  @override
  String get send => 'भेजें';

  @override
  String get thinking => 'सोच रहा हूँ...';

  @override
  String get suggestEligibility => 'क्या मैं मतदान के लिए पात्र हूँ?';

  @override
  String get suggestRegistration => 'मतदाता के रूप में पंजीकरण कैसे करें?';

  @override
  String get suggestDocuments => 'मुझे किन दस्तावेजों की आवश्यकता है?';

  @override
  String get suggestVotingProcess => 'मतदान के दिन क्या होता है?';

  @override
  String get documentsTitle => 'आवश्यक दस्तावेज';

  @override
  String get voterIdCard => 'मतदाता पहचान पत्र (EPIC)';

  @override
  String get voterIdDesc =>
      'चुनावी फोटो पहचान पत्र मतदान के लिए आपकी प्राथमिक पहचान है।';

  @override
  String get aadhaarCard => 'आधार कार्ड';

  @override
  String get aadhaarDesc =>
      'मतदाता पंजीकरण के लिए पहचान और पते के प्रमाण के रूप में उपयोग किया जा सकता है।';

  @override
  String get form6 => 'फॉर्म 6 — नया पंजीकरण';

  @override
  String get form6Desc =>
      'नए मतदाता पंजीकरण के लिए आवेदन पत्र। voters.eci.gov.in पर ऑनलाइन जमा करें।';

  @override
  String get form6a => 'फॉर्म 6A — विदेशी मतदाता';

  @override
  String get form6aDesc =>
      'विदेश में रहने वाले भारतीयों (NRI) के लिए पंजीकरण फॉर्म।';

  @override
  String get form7 => 'फॉर्म 7 — आपत्ति';

  @override
  String get form7Desc =>
      'मतदाता सूची में किसी नाम के शामिल होने पर आपत्ति दर्ज करने का फॉर्म।';

  @override
  String get form8 => 'फॉर्म 8 — सुधार';

  @override
  String get form8Desc =>
      'मतदाता सूची में प्रविष्टियों में सुधार के लिए आवेदन।';

  @override
  String get upcoming => 'आगामी';

  @override
  String get active => 'सक्रिय';

  @override
  String get completedStatus => 'पूर्ण';

  @override
  String get general => 'आम';

  @override
  String get state => 'राज्य';

  @override
  String get local => 'स्थानीय';

  @override
  String get allRegions => 'सभी क्षेत्र';

  @override
  String get nominationDate => 'नामांकन तिथि';

  @override
  String get pollingDate => 'मतदान तिथि';

  @override
  String get resultDate => 'परिणाम तिथि';

  @override
  String get language => 'भाषा';

  @override
  String get english => 'English';

  @override
  String get hindi => 'हिन्दी';

  @override
  String get marathi => 'मराठी';

  @override
  String get darkMode => 'डार्क मोड';

  @override
  String get clearSession => 'सत्र डेटा साफ़ करें';

  @override
  String get clearSessionConfirm =>
      'क्या आप सुनिश्चित हैं? इससे आपकी सभी प्रगति और चैट इतिहास रीसेट हो जाएगा।';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get confirm => 'पुष्टि करें';

  @override
  String get sessionInfo => 'सत्र जानकारी';

  @override
  String get age => 'आयु';

  @override
  String get location => 'स्थान';

  @override
  String get chatHistory => 'चैट इतिहास';

  @override
  String messagesCount(int count) {
    return '$count संदेश';
  }

  @override
  String get errorOccurred => 'एक त्रुटि हुई। कृपया पुनः प्रयास करें।';

  @override
  String get noInternet => 'इंटरनेट कनेक्शन नहीं है।';

  @override
  String get retry => 'पुनः प्रयास';

  @override
  String get poweredByAi =>
      'AI द्वारा संचालित — प्रतिक्रियाएँ 100% सटीक नहीं हो सकतीं';

  @override
  String get learnMore => 'और जानें';

  @override
  String get officialEciLink => 'आधिकारिक ECI वेबसाइट पर जाएँ';

  @override
  String get quickActions => 'त्वरित कार्य';

  @override
  String get recentChats => 'हाल की बातचीत';

  @override
  String get noChatsYet => 'अभी तक कोई बातचीत नहीं। AI सहायक से चैट शुरू करें!';

  @override
  String stepsCompleted(int count, int total) {
    return '$total में से $count चरण पूर्ण';
  }

  @override
  String get step1DetailTitle => 'कौन मतदान कर सकता है?';

  @override
  String get step1DetailBody =>
      'भारतीय चुनावों में मतदान के लिए पात्र होने के लिए:\n\n• भारत का नागरिक होना चाहिए\n• अर्हता तिथि पर कम से कम 18 वर्ष की आयु\n• निर्वाचन क्षेत्र का सामान्य निवासी\n• कानून द्वारा अयोग्य नहीं';

  @override
  String get step2DetailTitle => 'पंजीकरण कैसे करें';

  @override
  String get step2DetailBody =>
      'नए मतदाता के रूप में पंजीकरण:\n\n1. ऑनलाइन: voters.eci.gov.in पर फॉर्म 6 भरें\n2. वोटर हेल्पलाइन ऐप\n3. ऑफलाइन: अपने स्थानीय ERO/BLO कार्यालय में जाएँ';

  @override
  String get step3DetailTitle => 'अपना मतदाता पहचान पत्र सत्यापित करें';

  @override
  String get step3DetailBody =>
      'पंजीकरण के बाद:\n\n1. electoralsearch.eci.gov.in पर जाएँ\n2. नाम या EPIC नंबर से खोजें\n3. मतदान केंद्र विवरण जाँचें\n4. अपना e-EPIC डाउनलोड करें';

  @override
  String get step4DetailTitle => 'प्रमुख चुनाव तिथियाँ';

  @override
  String get step4DetailBody =>
      'महत्वपूर्ण मील के पत्थर:\n\n• कार्यक्रम की घोषणा\n• नामांकन दाखिल करना\n• नामांकन की जाँच\n• वापसी की अंतिम तिथि\n• प्रचार अवधि\n• मतदान दिवस\n• मतगणना दिवस\n• परिणाम घोषणा';

  @override
  String get step5DetailTitle => 'मतदान दिवस मार्गदर्शिका';

  @override
  String get step5DetailBody =>
      'मतदान के दिन:\n\n1. वोटर हेल्पलाइन ऐप से अपना बूथ खोजें\n2. मतदाता पहचान पत्र साथ लाएँ\n3. सत्यापन और स्याही का निशान लगवाएँ\n4. EVM पर अपने उम्मीदवार का बटन दबाएँ\n5. VVPAT पर्ची पर सत्यापित करें';

  @override
  String get step6DetailTitle => 'परिणाम कैसे घोषित होते हैं';

  @override
  String get step6DetailBody =>
      'मतदान के बाद:\n\n1. EVM को सील कर सुरक्षित रखा जाता है\n2. मतगणना: आमतौर पर अंतिम चरण के 3-4 दिन बाद\n3. EVM वोट गिने जाते हैं\n4. परिणाम राउंड में घोषित\n5. विजेता को निर्वाचन प्रमाण पत्र मिलता है';
}
