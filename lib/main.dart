import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.dark;
  Locale _locale = Locale('en');
  @override
  Widget build(BuildContext context) {
    Color surfaceColor = Color(0x0dffffff);
    Color primaryColor = Colors.pink.shade400;
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      debugShowCheckedModeBanner: false,
      title: 'Profile App',
      theme: themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().gettheme(_locale.languageCode)
          : MyAppThemeConfig.light().gettheme(_locale.languageCode),
      home: MyHomePage(toggleThemeMode: () {
        setState(
          () {
            if (themeMode == ThemeMode.dark)
              themeMode = ThemeMode.light;
            else
              themeMode = ThemeMode.dark;
          },
        );
      }, selectedLanguageChanged: (_Language newSelectedLanguageByUser) {
        setState(() {
          _locale = newSelectedLanguageByUser == _Language.en
              ? Locale('en')
              : Locale('fa');
        });
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(_Language _language) selectedLanguageChanged;

  const MyHomePage(
      {Key? key,
      required this.toggleThemeMode,
      required this.selectedLanguageChanged})
      : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum _SkillType {
  photoshop,
  xd,
  illustrator,
  afterEffect,
  lightRoom,
}

class MyAppThemeConfig {
  static const String faPrimaryFontFamily = 'IranYekan';
  final primaryColor = Colors.pink.shade400;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color surfaceColor;
  final Color backgroundColor;
  final Color appBarColor;
  final Brightness brightness;
  MyAppThemeConfig.dark()
      : primaryTextColor = Colors.white,
        secondaryTextColor = Colors.white70,
        surfaceColor = Color(0x0dffffff),
        backgroundColor = Color.fromARGB(255, 30, 30, 30),
        appBarColor = Colors.black,
        brightness = Brightness.dark;
  MyAppThemeConfig.light()
      : primaryTextColor = Colors.grey.shade900,
        secondaryTextColor = Colors.grey.shade900.withOpacity(0.8),
        surfaceColor = Color(0x0d000000),
        backgroundColor = Color.fromARGB(255, 235, 235, 235),
        appBarColor = Colors.white,
        brightness = Brightness.light;
  ThemeData gettheme(String languageCode) {
    return ThemeData(
      primarySwatch: Colors.pink,
      primaryColor: primaryColor,
      brightness: brightness,
      dividerColor: surfaceColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
        ),
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: appBarColor,
          foregroundColor: primaryTextColor),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: surfaceColor,
      ),
      textTheme: languageCode == 'en' ? enPrimaryTextTheme : faPrimaryTextTheme,
    );
  }

  TextTheme get enPrimaryTextTheme => GoogleFonts.latoTextTheme(
        TextTheme(
          bodyText2: TextStyle(fontSize: 15, color: primaryTextColor),
          bodyText1: TextStyle(fontSize: 13, color: secondaryTextColor),
          headline6:
              TextStyle(fontWeight: FontWeight.w900, color: primaryTextColor),
          subtitle1: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryTextColor),
        ),
      );
  TextTheme get faPrimaryTextTheme => TextTheme(
      bodyText2: TextStyle(
          height: 1.3,
          fontSize: 15,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily),
      bodyText1: TextStyle(
          fontSize: 13,
          height: 1.5,
          color: secondaryTextColor,
          fontFamily: faPrimaryFontFamily),
      caption: TextStyle(fontFamily: faPrimaryFontFamily),
      headline6: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily),
      subtitle1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily),
      button: TextStyle(fontFamily: faPrimaryFontFamily));
}

class _MyHomePageState extends State<MyHomePage> {
  _SkillType _skill = _SkillType.photoshop;
  _Language _language = _Language.en;
  void updateSelectedSkill(_SkillType skillType) {
    setState(() {
      this._skill = skillType;
    });
  }

  void _updateSelectedLanguage(_Language language) {
    widget.selectedLanguageChanged(language);
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          title: Text(localization.profileTitle),
          actions: [
            InkWell(
              onTap: widget.toggleThemeMode,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
                child: Icon(CupertinoIcons.sunrise),
              ),
            ),
            Icon(CupertinoIcons.chat_bubble),
            SizedBox(
              width: 8,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
              child: Icon(CupertinoIcons.ellipsis_vertical),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/profile_image.jpg',
                          width: 60,
                          height: 60,
                        )),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localization.name,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(localization.job),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.location_solid,
                                size: 14,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                localization.location,
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Icon(CupertinoIcons.heart,
                        color: Theme.of(context).primaryColor),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                child: Text(
                  localization.summary,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.selectedLanguage),
                    CupertinoSlidingSegmentedControl<_Language>(
                        groupValue: _language,
                        thumbColor: Theme.of(context).colorScheme.primary,
                        children: {
                          _Language.fa: Text(
                            localization.faLanguage,
                            style: TextStyle(fontSize: 14),
                          ),
                          _Language.en: Text(
                            localization.enLanguage,
                            style: TextStyle(fontSize: 14),
                          )
                        },
                        onValueChanged: (value) {
                          if (value != null) _updateSelectedLanguage(value);
                        })
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      localization.skills,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      CupertinoIcons.chevron_down,
                      size: 12,
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Skill(
                      type: _SkillType.photoshop,
                      title: 'photoshop',
                      imagePath: 'assets/images/app_icon_01.png',
                      shadowColor: Colors.blue,
                      isActive: _skill == _SkillType.photoshop,
                      onTap: () {
                        updateSelectedSkill(_SkillType.photoshop);
                      },
                    ),
                    Skill(
                        type: _SkillType.xd,
                        title: 'Adobe XD',
                        imagePath: 'assets/images/app_icon_05.png',
                        shadowColor: Colors.pink,
                        isActive: _skill == _SkillType.xd,
                        onTap: () {
                          updateSelectedSkill(_SkillType.xd);
                        }),
                    Skill(
                        type: _SkillType.illustrator,
                        title: 'Illustrator',
                        imagePath: 'assets/images/app_icon_04.png',
                        shadowColor: Colors.orange.shade100,
                        isActive: _skill == _SkillType.illustrator,
                        onTap: () {
                          updateSelectedSkill(_SkillType.illustrator);
                        }),
                    Skill(
                        type: _SkillType.afterEffect,
                        title: 'After Effect',
                        imagePath: 'assets/images/app_icon_03.png',
                        shadowColor: Colors.blue.shade800,
                        isActive: _skill == _SkillType.afterEffect,
                        onTap: () {
                          updateSelectedSkill(_SkillType.afterEffect);
                        }),
                    Skill(
                        type: _SkillType.lightRoom,
                        title: 'Lightroom',
                        imagePath: 'assets/images/app_icon_02.png',
                        shadowColor: Colors.blue,
                        isActive: _skill == _SkillType.lightRoom,
                        onTap: () {
                          updateSelectedSkill(_SkillType.lightRoom);
                        }),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localization.personalInformation,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: localization.email,
                        prefixIcon: Icon(CupertinoIcons.at),
                      ),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: localization.password,
                        prefixIcon: Icon(CupertinoIcons.lock),
                      ),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            localization.save,
                            style: TextStyle(fontSize: 17),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class Skill extends StatelessWidget {
  final _SkillType type;
  final String title;
  final String imagePath;
  final Color shadowColor;
  final bool isActive;
  final Function() onTap;

  const Skill(
      {Key? key,
      required this.type,
      required this.title,
      required this.imagePath,
      required this.shadowColor,
      required this.isActive,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius defultborderRadius = BorderRadius.circular(12);
    return InkWell(
      borderRadius: defultborderRadius,
      onTap: onTap,
      child: Container(
        width: 110,
        height: 110,
        decoration: isActive
            ? BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: defultborderRadius)
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: shadowColor.withOpacity(0.5), blurRadius: 20)
                    ])
                  : null,
              child: Image.asset(
                imagePath,
                width: 50,
                height: 50,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}

enum _Language { en, fa }
