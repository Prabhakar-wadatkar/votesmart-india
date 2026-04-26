// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appTitle => 'वोटस्मार्ट इंडिया';

  @override
  String get homeTitle => 'डॅशबोर्ड';

  @override
  String get chatTitle => 'AI सहाय्यक';

  @override
  String get journeyTitle => 'निवडणूक प्रवास';

  @override
  String get timelineTitle => 'निवडणूक वेळापत्रक';

  @override
  String get profileTitle => 'माझी प्रोफाइल';

  @override
  String get welcomeMessage => 'वोटस्मार्ट इंडियामध्ये आपले स्वागत!';

  @override
  String get welcomeSubtitle =>
      'भारतीय निवडणूक प्रक्रियेसाठी तुमचे AI-संचालित मार्गदर्शक';

  @override
  String get askAiAssistant => 'AI सहाय्यकाला विचारा';

  @override
  String get startJourney => 'प्रवास सुरू करा';

  @override
  String get viewTimeline => 'वेळापत्रक पहा';

  @override
  String get journeyProgress => 'प्रवास प्रगती';

  @override
  String get eligibilityStatus => 'पात्रता स्थिती';

  @override
  String get nextElection => 'पुढची निवडणूक';

  @override
  String get eligible => 'मतदानासाठी पात्र';

  @override
  String get notEligible => 'अद्याप पात्र नाही';

  @override
  String daysUntilEligible(int days) {
    return 'तुम्ही $days दिवसांत पात्र व्हाल';
  }

  @override
  String get checkEligibility => 'पात्रता तपासा';

  @override
  String get enterDateOfBirth => 'जन्मतारीख टाका';

  @override
  String get enterAge => 'तुमचे वय टाका';

  @override
  String get enterLocation => 'तुमचे स्थान टाका';

  @override
  String get detectLocation => 'माझे स्थान शोधा';

  @override
  String get step1Eligibility => 'पात्रता तपासणी';

  @override
  String get step2Registration => 'मतदार नोंदणी';

  @override
  String get step3Verification => 'मतदार ओळखपत्र पडताळणी';

  @override
  String get step4Timeline => 'निवडणूक वेळापत्रक';

  @override
  String get step5VotingDay => 'मतदान दिवस प्रक्रिया';

  @override
  String get step6Results => 'निकाल जाहीर';

  @override
  String get step1Desc =>
      'तुमच्या वय आणि नागरिकत्वावर आधारित तुम्ही भारतीय निवडणुकांमध्ये मतदानासाठी पात्र आहात का ते तपासा.';

  @override
  String get step2Desc =>
      'फॉर्म 6 वापरून ऑनलाइन किंवा तुमच्या जवळच्या ERO कार्यालयात मतदार म्हणून नोंदणी कशी करावी ते जाणा.';

  @override
  String get step3Desc =>
      'तुमचे मतदार ओळखपत्र (EPIC) कसे पडताळावे आणि मतदार यादीत तुमचे नाव कसे तपासावे ते समजून घ्या.';

  @override
  String get step4Desc =>
      'आगामी निवडणूक तारखा, नामांकन मुदत आणि मतदान वेळापत्रकाबद्दल अपडेट रहा.';

  @override
  String get step5Desc =>
      'मतदान दिवसाची संपूर्ण प्रक्रिया जाणा — बूथवर पोहोचण्यापासून EVM वर मतदान करण्यापर्यंत.';

  @override
  String get step6Desc =>
      'मते कशी मोजली जातात, निकाल कसे जाहीर होतात आणि विजेते कसे ठरतात ते समजून घ्या.';

  @override
  String get markComplete => 'पूर्ण म्हणून चिन्हांकित करा';

  @override
  String get completed => 'पूर्ण';

  @override
  String get inProgress => 'प्रगतीपथावर';

  @override
  String get notStarted => 'सुरू झाले नाही';

  @override
  String get chatHint => 'भारतीय निवडणुकांबद्दल काहीही विचारा...';

  @override
  String get send => 'पाठवा';

  @override
  String get thinking => 'विचार करत आहे...';

  @override
  String get suggestEligibility => 'मी मतदानासाठी पात्र आहे का?';

  @override
  String get suggestRegistration => 'मतदार म्हणून नोंदणी कशी करावी?';

  @override
  String get suggestDocuments => 'मला कोणत्या कागदपत्रांची गरज आहे?';

  @override
  String get suggestVotingProcess => 'मतदानाच्या दिवशी काय होते?';

  @override
  String get documentsTitle => 'आवश्यक कागदपत्रे';

  @override
  String get voterIdCard => 'मतदार ओळखपत्र (EPIC)';

  @override
  String get voterIdDesc =>
      'निवडणूक फोटो ओळखपत्र हे मतदानासाठी तुमचे प्राथमिक ओळखपत्र आहे.';

  @override
  String get aadhaarCard => 'आधार कार्ड';

  @override
  String get aadhaarDesc =>
      'मतदार नोंदणीसाठी ओळख आणि पत्त्याचा पुरावा म्हणून वापरता येते.';

  @override
  String get form6 => 'फॉर्म 6 — नवीन नोंदणी';

  @override
  String get form6Desc =>
      'नवीन मतदार नोंदणीसाठी अर्ज. voters.eci.gov.in वर ऑनलाइन सबमिट करा.';

  @override
  String get form6a => 'फॉर्म 6A — परदेशी मतदार';

  @override
  String get form6aDesc =>
      'परदेशी मतदार म्हणून नोंदणी करू इच्छिणाऱ्या NRI साठी नोंदणी फॉर्म.';

  @override
  String get form7 => 'फॉर्म 7 — हरकत';

  @override
  String get form7Desc =>
      'मतदार यादीत नावाच्या समावेशावर हरकत नोंदवण्यासाठी फॉर्म.';

  @override
  String get form8 => 'फॉर्म 8 — दुरुस्ती';

  @override
  String get form8Desc => 'मतदार यादीतील नोंदींमध्ये दुरुस्तीसाठी अर्ज.';

  @override
  String get upcoming => 'आगामी';

  @override
  String get active => 'सक्रिय';

  @override
  String get completedStatus => 'पूर्ण';

  @override
  String get general => 'सार्वत्रिक';

  @override
  String get state => 'राज्य';

  @override
  String get local => 'स्थानिक';

  @override
  String get allRegions => 'सर्व प्रदेश';

  @override
  String get nominationDate => 'नामांकन तारीख';

  @override
  String get pollingDate => 'मतदान तारीख';

  @override
  String get resultDate => 'निकाल तारीख';

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
  String get clearSession => 'सत्र डेटा साफ करा';

  @override
  String get clearSessionConfirm =>
      'तुम्हाला खात्री आहे? यामुळे तुमची सर्व प्रगती आणि चॅट इतिहास रीसेट होईल.';

  @override
  String get cancel => 'रद्द करा';

  @override
  String get confirm => 'पुष्टी करा';

  @override
  String get sessionInfo => 'सत्र माहिती';

  @override
  String get age => 'वय';

  @override
  String get location => 'स्थान';

  @override
  String get chatHistory => 'चॅट इतिहास';

  @override
  String messagesCount(int count) {
    return '$count संदेश';
  }

  @override
  String get errorOccurred => 'एक त्रुटी आली. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get noInternet => 'इंटरनेट कनेक्शन नाही.';

  @override
  String get retry => 'पुन्हा प्रयत्न';

  @override
  String get poweredByAi => 'AI द्वारे संचालित — प्रतिसाद 100% अचूक नसू शकतात';

  @override
  String get learnMore => 'अधिक जाणा';

  @override
  String get officialEciLink => 'अधिकृत ECI वेबसाइटला भेट द्या';

  @override
  String get quickActions => 'जलद कृती';

  @override
  String get recentChats => 'अलीकडील संभाषणे';

  @override
  String get noChatsYet => 'अद्याप संभाषणे नाहीत. AI सहाय्यकाशी चॅट सुरू करा!';

  @override
  String stepsCompleted(int count, int total) {
    return '$total पैकी $count टप्पे पूर्ण';
  }

  @override
  String get step1DetailTitle => 'कोण मतदान करू शकतो?';

  @override
  String get step1DetailBody =>
      'भारतीय निवडणुकांमध्ये मतदानासाठी:\n\n• भारताचा नागरिक असणे आवश्यक\n• पात्रता तारखेला किमान 18 वर्षे वय\n• मतदारसंघाचा सामान्य रहिवासी\n• कायद्याने अपात्र नसणे';

  @override
  String get step2DetailTitle => 'नोंदणी कशी करावी';

  @override
  String get step2DetailBody =>
      'नवीन मतदार म्हणून नोंदणी:\n\n1. ऑनलाइन: voters.eci.gov.in वर फॉर्म 6 भरा\n2. वोटर हेल्पलाइन अॅप\n3. ऑफलाइन: तुमच्या स्थानिक ERO/BLO कार्यालयात जा';

  @override
  String get step3DetailTitle => 'तुमचे मतदार ओळखपत्र पडताळा';

  @override
  String get step3DetailBody =>
      'नोंदणीनंतर:\n\n1. electoralsearch.eci.gov.in वर जा\n2. नाव किंवा EPIC क्रमांकाने शोधा\n3. मतदान केंद्र तपशील तपासा\n4. तुमचे e-EPIC डाउनलोड करा';

  @override
  String get step4DetailTitle => 'प्रमुख निवडणूक तारखा';

  @override
  String get step4DetailBody =>
      'महत्त्वाचे टप्पे:\n\n• वेळापत्रक जाहीर\n• नामांकन दाखल\n• नामांकन छाननी\n• माघारीची अंतिम तारीख\n• प्रचार कालावधी\n• मतदान दिवस\n• मतमोजणी दिवस\n• निकाल जाहीर';

  @override
  String get step5DetailTitle => 'मतदान दिवस मार्गदर्शक';

  @override
  String get step5DetailBody =>
      'मतदानाच्या दिवशी:\n\n1. वोटर हेल्पलाइन अॅपवरून तुमचा बूथ शोधा\n2. मतदार ओळखपत्र सोबत आणा\n3. पडताळणी आणि शाईचे चिन्ह\n4. EVM वर तुमच्या उमेदवाराचे बटण दाबा\n5. VVPAT स्लिपवर पडताळणी करा';

  @override
  String get step6DetailTitle => 'निकाल कसे जाहीर होतात';

  @override
  String get step6DetailBody =>
      'मतदानानंतर:\n\n1. EVM सील करून सुरक्षित ठेवल्या जातात\n2. मतमोजणी: सामान्यतः शेवटच्या टप्प्यानंतर 3-4 दिवस\n3. EVM मते मोजली जातात\n4. निकाल फेऱ्यांमध्ये जाहीर\n5. विजेत्याला निवडणूक प्रमाणपत्र मिळते';
}
