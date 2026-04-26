// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'VoteSmart India';

  @override
  String get homeTitle => 'Dashboard';

  @override
  String get chatTitle => 'AI Assistant';

  @override
  String get journeyTitle => 'Election Journey';

  @override
  String get timelineTitle => 'Election Timeline';

  @override
  String get profileTitle => 'My Profile';

  @override
  String get welcomeMessage => 'Welcome to VoteSmart India!';

  @override
  String get welcomeSubtitle =>
      'Your AI-powered guide to the Indian election process';

  @override
  String get askAiAssistant => 'Ask AI Assistant';

  @override
  String get startJourney => 'Start Journey';

  @override
  String get viewTimeline => 'View Timeline';

  @override
  String get journeyProgress => 'Journey Progress';

  @override
  String get eligibilityStatus => 'Eligibility Status';

  @override
  String get nextElection => 'Next Election';

  @override
  String get eligible => 'Eligible to Vote';

  @override
  String get notEligible => 'Not Yet Eligible';

  @override
  String daysUntilEligible(int days) {
    return 'You will be eligible in $days days';
  }

  @override
  String get checkEligibility => 'Check Eligibility';

  @override
  String get enterDateOfBirth => 'Enter Date of Birth';

  @override
  String get enterAge => 'Enter your age';

  @override
  String get enterLocation => 'Enter your location';

  @override
  String get detectLocation => 'Detect My Location';

  @override
  String get step1Eligibility => 'Eligibility Check';

  @override
  String get step2Registration => 'Voter Registration';

  @override
  String get step3Verification => 'Voter ID Verification';

  @override
  String get step4Timeline => 'Election Timeline';

  @override
  String get step5VotingDay => 'Voting Day Process';

  @override
  String get step6Results => 'Result Declaration';

  @override
  String get step1Desc =>
      'Verify if you are eligible to vote in Indian elections based on your age and citizenship.';

  @override
  String get step2Desc =>
      'Learn how to register as a voter using Form 6 online or offline at your nearest ERO office.';

  @override
  String get step3Desc =>
      'Understand how to verify your Voter ID (EPIC) and check your name in the electoral roll.';

  @override
  String get step4Desc =>
      'Stay updated with upcoming election dates, nomination deadlines, and polling schedules.';

  @override
  String get step5Desc =>
      'Know the complete voting day process — from reaching the booth to casting your vote using the EVM.';

  @override
  String get step6Desc =>
      'Understand how votes are counted, results are declared, and winners are announced.';

  @override
  String get markComplete => 'Mark as Complete';

  @override
  String get completed => 'Completed';

  @override
  String get inProgress => 'In Progress';

  @override
  String get notStarted => 'Not Started';

  @override
  String get chatHint => 'Ask me anything about Indian elections...';

  @override
  String get send => 'Send';

  @override
  String get thinking => 'Thinking...';

  @override
  String get suggestEligibility => 'Am I eligible to vote?';

  @override
  String get suggestRegistration => 'How to register as a voter?';

  @override
  String get suggestDocuments => 'What documents do I need?';

  @override
  String get suggestVotingProcess => 'What happens on voting day?';

  @override
  String get documentsTitle => 'Required Documents';

  @override
  String get voterIdCard => 'Voter ID Card (EPIC)';

  @override
  String get voterIdDesc =>
      'The Electoral Photo Identity Card is your primary identity for voting.';

  @override
  String get aadhaarCard => 'Aadhaar Card';

  @override
  String get aadhaarDesc =>
      'Can be used as proof of identity and address for voter registration.';

  @override
  String get form6 => 'Form 6 — New Registration';

  @override
  String get form6Desc =>
      'Application form for new voter registration. Submit online at voters.eci.gov.in.';

  @override
  String get form6a => 'Form 6A — Overseas Voters';

  @override
  String get form6aDesc =>
      'Registration form for NRIs who wish to register as overseas electors.';

  @override
  String get form7 => 'Form 7 — Objection';

  @override
  String get form7Desc =>
      'Form to raise objection to inclusion of a name in the electoral roll.';

  @override
  String get form8 => 'Form 8 — Correction';

  @override
  String get form8Desc =>
      'Application for correction of entries in the electoral roll.';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get active => 'Active';

  @override
  String get completedStatus => 'Completed';

  @override
  String get general => 'General';

  @override
  String get state => 'State';

  @override
  String get local => 'Local';

  @override
  String get allRegions => 'All Regions';

  @override
  String get nominationDate => 'Nomination Date';

  @override
  String get pollingDate => 'Polling Date';

  @override
  String get resultDate => 'Result Date';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get hindi => 'हिन्दी';

  @override
  String get marathi => 'मराठी';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get clearSession => 'Clear Session Data';

  @override
  String get clearSessionConfirm =>
      'Are you sure? This will reset all your progress and chat history.';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get sessionInfo => 'Session Information';

  @override
  String get age => 'Age';

  @override
  String get location => 'Location';

  @override
  String get chatHistory => 'Chat History';

  @override
  String messagesCount(int count) {
    return '$count messages';
  }

  @override
  String get errorOccurred => 'An error occurred. Please try again.';

  @override
  String get noInternet => 'No internet connection.';

  @override
  String get retry => 'Retry';

  @override
  String get poweredByAi =>
      'Powered by AI — Responses may not be 100% accurate';

  @override
  String get learnMore => 'Learn More';

  @override
  String get officialEciLink => 'Visit Official ECI Website';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get recentChats => 'Recent Conversations';

  @override
  String get noChatsYet =>
      'No conversations yet. Start chatting with the AI assistant!';

  @override
  String stepsCompleted(int count, int total) {
    return '$count of $total steps completed';
  }

  @override
  String get step1DetailTitle => 'Who Can Vote?';

  @override
  String get step1DetailBody =>
      'To be eligible to vote in Indian elections, you must be:\n\n• A citizen of India\n• At least 18 years of age on the qualifying date\n• An ordinary resident of the constituency\n• Not disqualified by law\n\nQualifying dates: January 1, April 1, July 1, October 1';

  @override
  String get step2DetailTitle => 'How to Register';

  @override
  String get step2DetailBody =>
      'Register as a new voter through:\n\n1. Online: Visit voters.eci.gov.in and fill Form 6\n2. Voter Helpline App\n3. Offline: Visit your local ERO/BLO office\n\nDocuments needed: Proof of age, address, and passport photo';

  @override
  String get step3DetailTitle => 'Verify Your Voter ID';

  @override
  String get step3DetailBody =>
      'After registration:\n\n1. Visit electoralsearch.eci.gov.in\n2. Search by name or EPIC number\n3. Check polling station details\n4. Download your e-EPIC';

  @override
  String get step4DetailTitle => 'Key Election Dates';

  @override
  String get step4DetailBody =>
      'Important milestones:\n\n• Announcement of schedule\n• Nomination filing\n• Scrutiny of nominations\n• Withdrawal deadline\n• Campaigning period (ends 48hrs before polling)\n• Polling Day\n• Counting Day\n• Results Declaration';

  @override
  String get step5DetailTitle => 'Voting Day Guide';

  @override
  String get step5DetailBody =>
      'On voting day:\n\n1. Locate your booth via Voter Helpline App\n2. Carry your Voter ID or approved photo ID\n3. Get verified and ink-marked\n4. Press button next to your candidate on EVM\n5. Verify on VVPAT slip\n6. Exit the booth\n\nPolling hours: typically 7 AM to 6 PM';

  @override
  String get step6DetailTitle => 'How Results are Declared';

  @override
  String get step6DetailBody =>
      'After polling:\n\n1. EVMs sealed and stored securely\n2. Counting day: usually 3-4 days after last phase\n3. EVM votes counted, matched with VVPAT samples\n4. Results declared in rounds\n5. Winner receives Certificate of Election\n\nLive results at results.eci.gov.in';
}
