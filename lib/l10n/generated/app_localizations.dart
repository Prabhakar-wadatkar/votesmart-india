import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_mr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('mr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'VoteSmart India'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get homeTitle;

  /// No description provided for @chatTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get chatTitle;

  /// No description provided for @journeyTitle.
  ///
  /// In en, this message translates to:
  /// **'Election Journey'**
  String get journeyTitle;

  /// No description provided for @timelineTitle.
  ///
  /// In en, this message translates to:
  /// **'Election Timeline'**
  String get timelineTitle;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get profileTitle;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to VoteSmart India!'**
  String get welcomeMessage;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your AI-powered guide to the Indian election process'**
  String get welcomeSubtitle;

  /// No description provided for @askAiAssistant.
  ///
  /// In en, this message translates to:
  /// **'Ask AI Assistant'**
  String get askAiAssistant;

  /// No description provided for @startJourney.
  ///
  /// In en, this message translates to:
  /// **'Start Journey'**
  String get startJourney;

  /// No description provided for @viewTimeline.
  ///
  /// In en, this message translates to:
  /// **'View Timeline'**
  String get viewTimeline;

  /// No description provided for @journeyProgress.
  ///
  /// In en, this message translates to:
  /// **'Journey Progress'**
  String get journeyProgress;

  /// No description provided for @eligibilityStatus.
  ///
  /// In en, this message translates to:
  /// **'Eligibility Status'**
  String get eligibilityStatus;

  /// No description provided for @nextElection.
  ///
  /// In en, this message translates to:
  /// **'Next Election'**
  String get nextElection;

  /// No description provided for @eligible.
  ///
  /// In en, this message translates to:
  /// **'Eligible to Vote'**
  String get eligible;

  /// No description provided for @notEligible.
  ///
  /// In en, this message translates to:
  /// **'Not Yet Eligible'**
  String get notEligible;

  /// No description provided for @daysUntilEligible.
  ///
  /// In en, this message translates to:
  /// **'You will be eligible in {days} days'**
  String daysUntilEligible(int days);

  /// No description provided for @checkEligibility.
  ///
  /// In en, this message translates to:
  /// **'Check Eligibility'**
  String get checkEligibility;

  /// No description provided for @enterDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Enter Date of Birth'**
  String get enterDateOfBirth;

  /// No description provided for @enterAge.
  ///
  /// In en, this message translates to:
  /// **'Enter your age'**
  String get enterAge;

  /// No description provided for @enterLocation.
  ///
  /// In en, this message translates to:
  /// **'Enter your location'**
  String get enterLocation;

  /// No description provided for @detectLocation.
  ///
  /// In en, this message translates to:
  /// **'Detect My Location'**
  String get detectLocation;

  /// No description provided for @step1Eligibility.
  ///
  /// In en, this message translates to:
  /// **'Eligibility Check'**
  String get step1Eligibility;

  /// No description provided for @step2Registration.
  ///
  /// In en, this message translates to:
  /// **'Voter Registration'**
  String get step2Registration;

  /// No description provided for @step3Verification.
  ///
  /// In en, this message translates to:
  /// **'Voter ID Verification'**
  String get step3Verification;

  /// No description provided for @step4Timeline.
  ///
  /// In en, this message translates to:
  /// **'Election Timeline'**
  String get step4Timeline;

  /// No description provided for @step5VotingDay.
  ///
  /// In en, this message translates to:
  /// **'Voting Day Process'**
  String get step5VotingDay;

  /// No description provided for @step6Results.
  ///
  /// In en, this message translates to:
  /// **'Result Declaration'**
  String get step6Results;

  /// No description provided for @step1Desc.
  ///
  /// In en, this message translates to:
  /// **'Verify if you are eligible to vote in Indian elections based on your age and citizenship.'**
  String get step1Desc;

  /// No description provided for @step2Desc.
  ///
  /// In en, this message translates to:
  /// **'Learn how to register as a voter using Form 6 online or offline at your nearest ERO office.'**
  String get step2Desc;

  /// No description provided for @step3Desc.
  ///
  /// In en, this message translates to:
  /// **'Understand how to verify your Voter ID (EPIC) and check your name in the electoral roll.'**
  String get step3Desc;

  /// No description provided for @step4Desc.
  ///
  /// In en, this message translates to:
  /// **'Stay updated with upcoming election dates, nomination deadlines, and polling schedules.'**
  String get step4Desc;

  /// No description provided for @step5Desc.
  ///
  /// In en, this message translates to:
  /// **'Know the complete voting day process — from reaching the booth to casting your vote using the EVM.'**
  String get step5Desc;

  /// No description provided for @step6Desc.
  ///
  /// In en, this message translates to:
  /// **'Understand how votes are counted, results are declared, and winners are announced.'**
  String get step6Desc;

  /// No description provided for @markComplete.
  ///
  /// In en, this message translates to:
  /// **'Mark as Complete'**
  String get markComplete;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @notStarted.
  ///
  /// In en, this message translates to:
  /// **'Not Started'**
  String get notStarted;

  /// No description provided for @chatHint.
  ///
  /// In en, this message translates to:
  /// **'Ask me anything about Indian elections...'**
  String get chatHint;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @thinking.
  ///
  /// In en, this message translates to:
  /// **'Thinking...'**
  String get thinking;

  /// No description provided for @suggestEligibility.
  ///
  /// In en, this message translates to:
  /// **'Am I eligible to vote?'**
  String get suggestEligibility;

  /// No description provided for @suggestRegistration.
  ///
  /// In en, this message translates to:
  /// **'How to register as a voter?'**
  String get suggestRegistration;

  /// No description provided for @suggestDocuments.
  ///
  /// In en, this message translates to:
  /// **'What documents do I need?'**
  String get suggestDocuments;

  /// No description provided for @suggestVotingProcess.
  ///
  /// In en, this message translates to:
  /// **'What happens on voting day?'**
  String get suggestVotingProcess;

  /// No description provided for @documentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Required Documents'**
  String get documentsTitle;

  /// No description provided for @voterIdCard.
  ///
  /// In en, this message translates to:
  /// **'Voter ID Card (EPIC)'**
  String get voterIdCard;

  /// No description provided for @voterIdDesc.
  ///
  /// In en, this message translates to:
  /// **'The Electoral Photo Identity Card is your primary identity for voting.'**
  String get voterIdDesc;

  /// No description provided for @aadhaarCard.
  ///
  /// In en, this message translates to:
  /// **'Aadhaar Card'**
  String get aadhaarCard;

  /// No description provided for @aadhaarDesc.
  ///
  /// In en, this message translates to:
  /// **'Can be used as proof of identity and address for voter registration.'**
  String get aadhaarDesc;

  /// No description provided for @form6.
  ///
  /// In en, this message translates to:
  /// **'Form 6 — New Registration'**
  String get form6;

  /// No description provided for @form6Desc.
  ///
  /// In en, this message translates to:
  /// **'Application form for new voter registration. Submit online at voters.eci.gov.in.'**
  String get form6Desc;

  /// No description provided for @form6a.
  ///
  /// In en, this message translates to:
  /// **'Form 6A — Overseas Voters'**
  String get form6a;

  /// No description provided for @form6aDesc.
  ///
  /// In en, this message translates to:
  /// **'Registration form for NRIs who wish to register as overseas electors.'**
  String get form6aDesc;

  /// No description provided for @form7.
  ///
  /// In en, this message translates to:
  /// **'Form 7 — Objection'**
  String get form7;

  /// No description provided for @form7Desc.
  ///
  /// In en, this message translates to:
  /// **'Form to raise objection to inclusion of a name in the electoral roll.'**
  String get form7Desc;

  /// No description provided for @form8.
  ///
  /// In en, this message translates to:
  /// **'Form 8 — Correction'**
  String get form8;

  /// No description provided for @form8Desc.
  ///
  /// In en, this message translates to:
  /// **'Application for correction of entries in the electoral roll.'**
  String get form8Desc;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @completedStatus.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedStatus;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @local.
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get local;

  /// No description provided for @allRegions.
  ///
  /// In en, this message translates to:
  /// **'All Regions'**
  String get allRegions;

  /// No description provided for @nominationDate.
  ///
  /// In en, this message translates to:
  /// **'Nomination Date'**
  String get nominationDate;

  /// No description provided for @pollingDate.
  ///
  /// In en, this message translates to:
  /// **'Polling Date'**
  String get pollingDate;

  /// No description provided for @resultDate.
  ///
  /// In en, this message translates to:
  /// **'Result Date'**
  String get resultDate;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'हिन्दी'**
  String get hindi;

  /// No description provided for @marathi.
  ///
  /// In en, this message translates to:
  /// **'मराठी'**
  String get marathi;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @clearSession.
  ///
  /// In en, this message translates to:
  /// **'Clear Session Data'**
  String get clearSession;

  /// No description provided for @clearSessionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure? This will reset all your progress and chat history.'**
  String get clearSessionConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @sessionInfo.
  ///
  /// In en, this message translates to:
  /// **'Session Information'**
  String get sessionInfo;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @chatHistory.
  ///
  /// In en, this message translates to:
  /// **'Chat History'**
  String get chatHistory;

  /// No description provided for @messagesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} messages'**
  String messagesCount(int count);

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get errorOccurred;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection.'**
  String get noInternet;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @poweredByAi.
  ///
  /// In en, this message translates to:
  /// **'Powered by AI — Responses may not be 100% accurate'**
  String get poweredByAi;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learnMore;

  /// No description provided for @officialEciLink.
  ///
  /// In en, this message translates to:
  /// **'Visit Official ECI Website'**
  String get officialEciLink;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @recentChats.
  ///
  /// In en, this message translates to:
  /// **'Recent Conversations'**
  String get recentChats;

  /// No description provided for @noChatsYet.
  ///
  /// In en, this message translates to:
  /// **'No conversations yet. Start chatting with the AI assistant!'**
  String get noChatsYet;

  /// No description provided for @stepsCompleted.
  ///
  /// In en, this message translates to:
  /// **'{count} of {total} steps completed'**
  String stepsCompleted(int count, int total);

  /// No description provided for @step1DetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Who Can Vote?'**
  String get step1DetailTitle;

  /// No description provided for @step1DetailBody.
  ///
  /// In en, this message translates to:
  /// **'To be eligible to vote in Indian elections, you must be:\n\n• A citizen of India\n• At least 18 years of age on the qualifying date\n• An ordinary resident of the constituency\n• Not disqualified by law\n\nQualifying dates: January 1, April 1, July 1, October 1'**
  String get step1DetailBody;

  /// No description provided for @step2DetailTitle.
  ///
  /// In en, this message translates to:
  /// **'How to Register'**
  String get step2DetailTitle;

  /// No description provided for @step2DetailBody.
  ///
  /// In en, this message translates to:
  /// **'Register as a new voter through:\n\n1. Online: Visit voters.eci.gov.in and fill Form 6\n2. Voter Helpline App\n3. Offline: Visit your local ERO/BLO office\n\nDocuments needed: Proof of age, address, and passport photo'**
  String get step2DetailBody;

  /// No description provided for @step3DetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Voter ID'**
  String get step3DetailTitle;

  /// No description provided for @step3DetailBody.
  ///
  /// In en, this message translates to:
  /// **'After registration:\n\n1. Visit electoralsearch.eci.gov.in\n2. Search by name or EPIC number\n3. Check polling station details\n4. Download your e-EPIC'**
  String get step3DetailBody;

  /// No description provided for @step4DetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Key Election Dates'**
  String get step4DetailTitle;

  /// No description provided for @step4DetailBody.
  ///
  /// In en, this message translates to:
  /// **'Important milestones:\n\n• Announcement of schedule\n• Nomination filing\n• Scrutiny of nominations\n• Withdrawal deadline\n• Campaigning period (ends 48hrs before polling)\n• Polling Day\n• Counting Day\n• Results Declaration'**
  String get step4DetailBody;

  /// No description provided for @step5DetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Voting Day Guide'**
  String get step5DetailTitle;

  /// No description provided for @step5DetailBody.
  ///
  /// In en, this message translates to:
  /// **'On voting day:\n\n1. Locate your booth via Voter Helpline App\n2. Carry your Voter ID or approved photo ID\n3. Get verified and ink-marked\n4. Press button next to your candidate on EVM\n5. Verify on VVPAT slip\n6. Exit the booth\n\nPolling hours: typically 7 AM to 6 PM'**
  String get step5DetailBody;

  /// No description provided for @step6DetailTitle.
  ///
  /// In en, this message translates to:
  /// **'How Results are Declared'**
  String get step6DetailTitle;

  /// No description provided for @step6DetailBody.
  ///
  /// In en, this message translates to:
  /// **'After polling:\n\n1. EVMs sealed and stored securely\n2. Counting day: usually 3-4 days after last phase\n3. EVM votes counted, matched with VVPAT samples\n4. Results declared in rounds\n5. Winner receives Certificate of Election\n\nLive results at results.eci.gov.in'**
  String get step6DetailBody;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'mr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'mr':
      return AppLocalizationsMr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
