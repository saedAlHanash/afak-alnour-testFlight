// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Afaq-Alnour Academy`
  String get name_company {
    return Intl.message(
      'Afaq-Alnour Academy',
      name: 'name_company',
      desc: '',
      args: [],
    );
  }

  /// `It is our great pleasure that we announce to you the completion of the curriculum of the Horizons of Light (Afaq ALNoor) and its launch into the light illuminating for our children their path and assisting them in the learning process, based on their needs that we have reached through our scientific experience with them until God honored us with a book that we put between their hands with our hope to God Almighty that we achieve our highly important goals by learning The Arabic language in an entertaining way and to include its main components (reading, listening and writing) through useful and interesting lessons.`
  String get description {
    return Intl.message(
      'It is our great pleasure that we announce to you the completion of the curriculum of the Horizons of Light (Afaq ALNoor) and its launch into the light illuminating for our children their path and assisting them in the learning process, based on their needs that we have reached through our scientific experience with them until God honored us with a book that we put between their hands with our hope to God Almighty that we achieve our highly important goals by learning The Arabic language in an entertaining way and to include its main components (reading, listening and writing) through useful and interesting lessons.',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get button_next {
    return Intl.message(
      'Next',
      name: 'button_next',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get button_skip {
    return Intl.message(
      'Skip',
      name: 'button_skip',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get button_finish {
    return Intl.message(
      'Finish',
      name: 'button_finish',
      desc: '',
      args: [],
    );
  }

  /// `Courses`
  String get courses {
    return Intl.message(
      'Courses',
      name: 'courses',
      desc: '',
      args: [],
    );
  }

  /// `Choose Course`
  String get choose_course {
    return Intl.message(
      'Choose Course',
      name: 'choose_course',
      desc: '',
      args: [],
    );
  }

  /// `Register Now`
  String get register_course {
    return Intl.message(
      'Register Now',
      name: 'register_course',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Course Name :`
  String get course_name {
    return Intl.message(
      'Course Name :',
      name: 'course_name',
      desc: '',
      args: [],
    );
  }

  /// `Course Price :`
  String get course_price {
    return Intl.message(
      'Course Price :',
      name: 'course_price',
      desc: '',
      args: [],
    );
  }

  /// `Make Payment`
  String get make_payment {
    return Intl.message(
      'Make Payment',
      name: 'make_payment',
      desc: '',
      args: [],
    );
  }

  /// `Description : `
  String get description_course {
    return Intl.message(
      'Description : ',
      name: 'description_course',
      desc: '',
      args: [],
    );
  }

  /// `Welcome To`
  String get welcome {
    return Intl.message(
      'Welcome To',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message(
      'First Name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get last_name {
    return Intl.message(
      'Last Name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Parent Name`
  String get parent_name {
    return Intl.message(
      'Parent Name',
      name: 'parent_name',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth :`
  String get age {
    return Intl.message(
      'Date of birth :',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get Month {
    return Intl.message(
      'Month',
      name: 'Month',
      desc: '',
      args: [],
    );
  }

  /// `year`
  String get year {
    return Intl.message(
      'year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Gender :`
  String get gender {
    return Intl.message(
      'Gender :',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get email {
    return Intl.message(
      'email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get street {
    return Intl.message(
      'Street',
      name: 'street',
      desc: '',
      args: [],
    );
  }

  /// `Building Number`
  String get building_number {
    return Intl.message(
      'Building Number',
      name: 'building_number',
      desc: '',
      args: [],
    );
  }

  /// `This field is required *`
  String get val {
    return Intl.message(
      'This field is required *',
      name: 'val',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `don't have an account?`
  String get have_account {
    return Intl.message(
      'don\'t have an account?',
      name: 'have_account',
      desc: '',
      args: [],
    );
  }

  /// `Enroll Now`
  String get enroll {
    return Intl.message(
      'Enroll Now',
      name: 'enroll',
      desc: '',
      args: [],
    );
  }

  /// `Level Test Date :`
  String get test_date {
    return Intl.message(
      'Level Test Date :',
      name: 'test_date',
      desc: '',
      args: [],
    );
  }

  /// `The support team will contact you shortly to confirm the test date`
  String get msg_test {
    return Intl.message(
      'The support team will contact you shortly to confirm the test date',
      name: 'msg_test',
      desc: '',
      args: [],
    );
  }

  /// `All Subjects`
  String get all_courses {
    return Intl.message(
      'All Subjects',
      name: 'all_courses',
      desc: '',
      args: [],
    );
  }

  /// `All Packages`
  String get all_packages {
    return Intl.message(
      'All Packages',
      name: 'all_packages',
      desc: '',
      args: [],
    );
  }

  /// `Seasonal Course`
  String get seasonal_course {
    return Intl.message(
      'Seasonal Course',
      name: 'seasonal_course',
      desc: '',
      args: [],
    );
  }

  /// `Login as guest`
  String get guest {
    return Intl.message(
      'Login as guest',
      name: 'guest',
      desc: '',
      args: [],
    );
  }

  /// `sorry There is no Package yet`
  String get error_package {
    return Intl.message(
      'sorry There is no Package yet',
      name: 'error_package',
      desc: '',
      args: [],
    );
  }

  /// `sorry There is no Seasonal Course yet`
  String get error_seasonal {
    return Intl.message(
      'sorry There is no Seasonal Course yet',
      name: 'error_seasonal',
      desc: '',
      args: [],
    );
  }

  /// `sorry There is no Course yet`
  String get error_course {
    return Intl.message(
      'sorry There is no Course yet',
      name: 'error_course',
      desc: '',
      args: [],
    );
  }

  /// `Child courses`
  String get child_courses {
    return Intl.message(
      'Child courses',
      name: 'child_courses',
      desc: '',
      args: [],
    );
  }

  /// `My courses`
  String get my_courses {
    return Intl.message(
      'My courses',
      name: 'my_courses',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `see all`
  String get see_all {
    return Intl.message(
      'see all',
      name: 'see_all',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get log_out {
    return Intl.message(
      'Log out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `العربية`
  String get lang {
    return Intl.message(
      'العربية',
      name: 'lang',
      desc: '',
      args: [],
    );
  }

  /// `Wolverhampton branch :`
  String get branch {
    return Intl.message(
      'Wolverhampton branch :',
      name: 'branch',
      desc: '',
      args: [],
    );
  }

  /// `Birmingham Branch :`
  String get branch1 {
    return Intl.message(
      'Birmingham Branch :',
      name: 'branch1',
      desc: '',
      args: [],
    );
  }

  /// `Hi I want to make test for {name} subject`
  String test_message(Object name) {
    return Intl.message(
      'Hi I want to make test for $name subject',
      name: 'test_message',
      desc: '',
      args: [name],
    );
  }

  /// `Do you want to start from ?`
  String get test_dialog {
    return Intl.message(
      'Do you want to start from ?',
      name: 'test_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Level one`
  String get test_lvl1 {
    return Intl.message(
      'Level one',
      name: 'test_lvl1',
      desc: '',
      args: [],
    );
  }

  /// `placement test`
  String get test {
    return Intl.message(
      'placement test',
      name: 'test',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to register now!`
  String get gust_dialog {
    return Intl.message(
      'Do you want to register now!',
      name: 'gust_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get gust_register {
    return Intl.message(
      'Register',
      name: 'gust_register',
      desc: '',
      args: [],
    );
  }

  /// `stay as a guest`
  String get gust {
    return Intl.message(
      'stay as a guest',
      name: 'gust',
      desc: '',
      args: [],
    );
  }

  /// `Start hour :`
  String get start_hour {
    return Intl.message(
      'Start hour :',
      name: 'start_hour',
      desc: '',
      args: [],
    );
  }

  /// `Start date :`
  String get start_date {
    return Intl.message(
      'Start date :',
      name: 'start_date',
      desc: '',
      args: [],
    );
  }

  /// `End date :`
  String get end_date {
    return Intl.message(
      'End date :',
      name: 'end_date',
      desc: '',
      args: [],
    );
  }

  /// `Duration :`
  String get duration {
    return Intl.message(
      'Duration :',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `Price :`
  String get price {
    return Intl.message(
      'Price :',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `start now`
  String get start {
    return Intl.message(
      'start now',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get close {
    return Intl.message(
      'Closed',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `By clicking register now you are accept to our `
  String get policy {
    return Intl.message(
      'By clicking register now you are accept to our ',
      name: 'policy',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get policy1 {
    return Intl.message(
      'Privacy Policy',
      name: 'policy1',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get policy2 {
    return Intl.message(
      '',
      name: 'policy2',
      desc: '',
      args: [],
    );
  }

  /// `Hello, Could you approve my account!`
  String get Approved_message {
    return Intl.message(
      'Hello, Could you approve my account!',
      name: 'Approved_message',
      desc: '',
      args: [],
    );
  }

  /// `Hello\nI want to pay for a course`
  String get enrool_Course_whatsApp {
    return Intl.message(
      'Hello\nI want to pay for a course',
      name: 'enrool_Course_whatsApp',
      desc: '',
      args: [],
    );
  }

  /// `Start Course Successfully`
  String get Start_Course_Successfully {
    return Intl.message(
      'Start Course Successfully',
      name: 'Start_Course_Successfully',
      desc: '',
      args: [],
    );
  }

  /// `Please contact the administration for payment`
  String get payment_message {
    return Intl.message(
      'Please contact the administration for payment',
      name: 'payment_message',
      desc: '',
      args: [],
    );
  }

  /// `User name`
  String get user_name {
    return Intl.message(
      'User name',
      name: 'user_name',
      desc: '',
      args: [],
    );
  }

  /// `Sign in As ?`
  String get sign_in_ass {
    return Intl.message(
      'Sign in As ?',
      name: 'sign_in_ass',
      desc: '',
      args: [],
    );
  }

  /// `Parent`
  String get parent {
    return Intl.message(
      'Parent',
      name: 'parent',
      desc: '',
      args: [],
    );
  }

  /// `Child`
  String get child {
    return Intl.message(
      'Child',
      name: 'child',
      desc: '',
      args: [],
    );
  }

  /// `Let's GO`
  String get lets_go {
    return Intl.message(
      'Let\'s GO',
      name: 'lets_go',
      desc: '',
      args: [],
    );
  }

  /// `Name : `
  String get child_name {
    return Intl.message(
      'Name : ',
      name: 'child_name',
      desc: '',
      args: [],
    );
  }

  /// `Guardian Relationship : `
  String get guardian_relationship {
    return Intl.message(
      'Guardian Relationship : ',
      name: 'guardian_relationship',
      desc: '',
      args: [],
    );
  }

  /// `Add Child`
  String get add_child {
    return Intl.message(
      'Add Child',
      name: 'add_child',
      desc: '',
      args: [],
    );
  }

  /// `My Children`
  String get my_children {
    return Intl.message(
      'My Children',
      name: 'my_children',
      desc: '',
      args: [],
    );
  }

  /// `Min participants :`
  String get min_participants {
    return Intl.message(
      'Min participants :',
      name: 'min_participants',
      desc: '',
      args: [],
    );
  }

  /// `Max participants :`
  String get max_participants {
    return Intl.message(
      'Max participants :',
      name: 'max_participants',
      desc: '',
      args: [],
    );
  }

  /// `Add to card`
  String get add_to_cart {
    return Intl.message(
      'Add to card',
      name: 'add_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Card`
  String get card {
    return Intl.message(
      'Card',
      name: 'card',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure ?`
  String get are_you_sure {
    return Intl.message(
      'Are you sure ?',
      name: 'are_you_sure',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get yes {
    return Intl.message(
      'yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `no`
  String get no {
    return Intl.message(
      'no',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Middle Name`
  String get middle_name {
    return Intl.message(
      'Middle Name',
      name: 'middle_name',
      desc: '',
      args: [],
    );
  }

  /// `Total :`
  String get total {
    return Intl.message(
      'Total :',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `One time payment`
  String get one_time_payment {
    return Intl.message(
      'One time payment',
      name: 'one_time_payment',
      desc: '',
      args: [],
    );
  }

  /// `Payment in three installments`
  String get three_time {
    return Intl.message(
      'Payment in three installments',
      name: 'three_time',
      desc: '',
      args: [],
    );
  }

  /// `Child number :`
  String get child_num {
    return Intl.message(
      'Child number :',
      name: 'child_num',
      desc: '',
      args: [],
    );
  }

  /// `Add child to course or package`
  String get noItemInCard {
    return Intl.message(
      'Add child to course or package',
      name: 'noItemInCard',
      desc: '',
      args: [],
    );
  }

  /// `Add a child to follow his lessons`
  String get child_not_found {
    return Intl.message(
      'Add a child to follow his lessons',
      name: 'child_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Add child to course or package to follow his lessons`
  String get add_child_to_courses {
    return Intl.message(
      'Add child to course or package to follow his lessons',
      name: 'add_child_to_courses',
      desc: '',
      args: [],
    );
  }

  /// `Payment history`
  String get payment_history {
    return Intl.message(
      'Payment history',
      name: 'payment_history',
      desc: '',
      args: [],
    );
  }

  /// `Add a child to enroll in a course or package`
  String get add_child_to_invoice {
    return Intl.message(
      'Add a child to enroll in a course or package',
      name: 'add_child_to_invoice',
      desc: '',
      args: [],
    );
  }

  /// `remaining seats : `
  String get remaining_seats {
    return Intl.message(
      'remaining seats : ',
      name: 'remaining_seats',
      desc: '',
      args: [],
    );
  }

  /// `Note: The card will be automatically deleted after one day`
  String get card_deleted {
    return Intl.message(
      'Note: The card will be automatically deleted after one day',
      name: 'card_deleted',
      desc: '',
      args: [],
    );
  }

  /// `Attention, you must remove a child from a course because you are adding it twice`
  String get course_attention {
    return Intl.message(
      'Attention, you must remove a child from a course because you are adding it twice',
      name: 'course_attention',
      desc: '',
      args: [],
    );
  }

  /// `Attention, you must remove a child from a package because you are adding it twice`
  String get package_attention {
    return Intl.message(
      'Attention, you must remove a child from a package because you are adding it twice',
      name: 'package_attention',
      desc: '',
      args: [],
    );
  }

  /// `There is no test available for this category`
  String get empty_test {
    return Intl.message(
      'There is no test available for this category',
      name: 'empty_test',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `save edit`
  String get save_edit {
    return Intl.message(
      'save edit',
      name: 'save_edit',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Please select course`
  String get pleaseSelectCourse {
    return Intl.message(
      'Please select course',
      name: 'pleaseSelectCourse',
      desc: '',
      args: [],
    );
  }

  /// `Please select number of session`
  String get pleaseSelectNumberSession {
    return Intl.message(
      'Please select number of session',
      name: 'pleaseSelectNumberSession',
      desc: '',
      args: [],
    );
  }

  /// `Select homework to download or open`
  String get selectHomeworkToDownloadOrOpen {
    return Intl.message(
      'Select homework to download or open',
      name: 'selectHomeworkToDownloadOrOpen',
      desc: '',
      args: [],
    );
  }

  /// `Homeworks`
  String get homework {
    return Intl.message(
      'Homeworks',
      name: 'homework',
      desc: '',
      args: [],
    );
  }

  /// `Additional contact number`
  String get emergency_mobile {
    return Intl.message(
      'Additional contact number',
      name: 'emergency_mobile',
      desc: '',
      args: [],
    );
  }

  /// `Additional contact name`
  String get emergency_name {
    return Intl.message(
      'Additional contact name',
      name: 'emergency_name',
      desc: '',
      args: [],
    );
  }

  /// `Same address`
  String get same_address {
    return Intl.message(
      'Same address',
      name: 'same_address',
      desc: '',
      args: [],
    );
  }

  /// `Choose child`
  String get Choose_child {
    return Intl.message(
      'Choose child',
      name: 'Choose_child',
      desc: '',
      args: [],
    );
  }

  /// `See Levels`
  String get see_Levels {
    return Intl.message(
      'See Levels',
      name: 'see_Levels',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
