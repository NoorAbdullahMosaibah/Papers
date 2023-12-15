/*
الاسم: نور عبدالله مصيباح 

المكاتب التي تم استخدامها هي 
 1- flutter_localization: ^0.1.14 //من اجل اضافة اللغة العربية للتطبيق
 2- intl: ^0.18.1 // من اجل اضافة فورمات محدد للوقت والتريخ
 3- hand_signature: ^3.0.2 // من اجل عمل التوقيع
*/

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hand_signature/signature.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
          textTheme: const TextTheme(
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(fontSize: 13),
        bodyMedium: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
      )),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'AE'), // English, no country code
      ],
      home: HomePage(),
      initialRoute: "/homePage",
      routes: <String, Widget Function(BuildContext)>{
        "/homePage": (context) => HomePage(),
        "/HeadOfDepartment": (context) => const HeadOfDepartment(),
        "/partThree": (context) => PartThree(),
        "/partFour": (context) => PartFour(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime currentDate = DateTime.now();
  String currentDepartement = "علوم الحاسوب";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String previouesDepartement = "امن المعلومات";
  String smester = "اول";
  TextEditingController? textControllerForCollegeDean;
  TextEditingController? textControllerForEmail;
  TextEditingController? textControllerForId;
  TextEditingController? textControllerForPhone;
  TextEditingController? textControllerForStudent;

  final DateFormat _dateFormat = DateFormat('MM - dd - yyyy');

  @override
  void initState() {
    super.initState();

    textControllerForCollegeDean = TextEditingController();
    textControllerForStudent = TextEditingController();
    textControllerForId = TextEditingController();
    textControllerForPhone = TextEditingController();
    textControllerForEmail = TextEditingController();
  }

  _handleDataPicker() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: "اختر التاريخ الجامعي",
    );
    if (date != null && date != currentDate) {
      setState(() {
        currentDate = date;
      });
      //dataController.text = _dateFormat.format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: Container(
        // margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        width: w,
        height: h,
        //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'الجمهورية اليمنية',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text('جامعة سيئون',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text('نيابة شئون الطلاب',
                          style: Theme.of(context).textTheme.titleSmall),
                      Text('الإداره العامعة للقبول والتسجيل',
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              //height: h / 1.206,
              //  height: h,
              width: 50,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'استمارة طلب الانتقال من قسم إلى اّخر في الكلية',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.black, // Step 2 SEE HERE
                            ),
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            textController: textControllerForCollegeDean!,
                            text: "الأخ/ عميد كلية",
                            keyboardType: TextInputType.name,
                            validation: (value) {
                              if (value!.isEmpty)
                                return 'لا يمكن ان يكون فارغا';
                              return null;
                            },
                          ),
                          CustomTextFormField(
                            textController: textControllerForStudent!,
                            text: "أتقدم إليكم أنا الطالب",
                            keyboardType: TextInputType.name,
                            validation: (value) {
                              if (value!.isEmpty)
                                return 'لا يمكن ان يكون فارغا';
                              return null;
                            },
                          ),
                          CustomTextFormField(
                            textController: textControllerForId!,
                            text: "المقيد برقم قيد",
                            keyboardType: TextInputType.number,
                            validation: (value) {
                              if (value!.isEmpty) {
                                return "Cannot be empty";
                              }
                              return null;
                            },
                          ),
                          CustomTextFormField(
                            textController: textControllerForPhone!,
                            text: "رقم التلفون",
                            keyboardType: TextInputType.number,
                            validation: (value) {
                              const pattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
                              final regex = RegExp(pattern);
                              if (value!.isEmpty)
                                return 'لا يمكن ان يكون فارغا';
                              return value.isNotEmpty && !regex.hasMatch(value)
                                  ? 'تأكد من ادخال رقم هاتف صحيح '
                                  : null;
                            },
                          ),
                          CustomTextFormField(
                            textController: textControllerForEmail!,
                            text: "البريد",
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            validation: (value) {
                              const pattern =
                                  r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                                  r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                                  r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                                  r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                                  r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                                  r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                                  r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                              final regex = RegExp(pattern);
                              if (value!.isEmpty)
                                return 'لا يمكن ان يكون فارغا';
                              return value.isNotEmpty && !regex.hasMatch(value)
                                  ? 'تأكد من ادخال بريد صحيح'
                                  : null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SelectDepatment(departement: currentDepartement),
                    SelectYear(smester: smester),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: Text(
                              "اختر التاريخ الجامعي",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            onPressed: () => _handleDataPicker(),
                          ),
                          Text(
                            _dateFormat.format(currentDate),
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        "\nيطلب الإنتقال الى تخصص ",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SelectDepatment(departement: previouesDepartement),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: Text(
                            "التوقيع",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blue.shade200,
                          ),
                          child: HandSignature(
                            color: Colors.red,
                            control: HandSignatureControl(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                    Center(
                      child: CustomFloatingButtom(
                        text: 'تأكيد',
                        is_initializPage: true,
                        color: Colors.blue.shade500,
                        press: () {
                          if (formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('تأكد من جميع المدخلات',
                                      style:
                                          Theme.of(context).textTheme.titleLarge
                                      //  textDirection: TextDirection.rtl,
                                      ),
                                  content: Text("هل انت متأكد من جميع الحقول",
                                      style:
                                          Theme.of(context).textTheme.titleLarge
                                      //  textDirection: TextDirection.rtl
                                      ),
                                  actions: <Widget>[
                                    MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: new Text('إلغاء')),
                                    MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                              context, "/HeadOfDepartment");
                                        },
                                        child: new Text('حسنا')),
                                  ],
                                );
                              },
                            );
                          } else {
                            print("error");
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.text,
    required this.textController,
    required this.validation,
    required this.keyboardType,
    this.textInputAction = TextInputAction.next,
  });

  final TextInputType keyboardType;
  final String text;
  final TextEditingController textController;
  final TextInputAction? textInputAction;
  final String? Function(String?) validation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textController,
        style: const TextStyle(fontSize: 10),
        validator: validation,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        decoration: InputDecoration(
            labelText: text,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 3, color: Color.fromARGB(255, 110, 142, 168)),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 3, color: Color.fromARGB(255, 79, 62, 60)),
              borderRadius: BorderRadius.circular(15),
            )),
      ),
    );
  }
}

class SelectDepatment extends StatefulWidget {
  SelectDepatment({super.key, this.departement});

  var departement;

  @override
  State<SelectDepatment> createState() => _SelectDepatmentState();
}

class _SelectDepatmentState extends State<SelectDepatment> {
  // String hint = "اختر تخصصك";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: DropdownButton<String>(
          value: widget.departement,
          //  hint: Text(hint),
          items: <String>['امن المعلومات', 'علوم الحاسوب', 'تقنية المعلومات']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              widget.departement = newValue!;
            });
          },
        ),
      ),
    );
  }
}

class SelectYear extends StatefulWidget {
  SelectYear({super.key, this.smester});

  var smester;

  @override
  State<SelectYear> createState() => _SelectYearState();
}

class _SelectYearState extends State<SelectYear> {
  // String hint = "اختر المستوى";
  // String? smester;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: DropdownButton<String>(
          value: widget.smester,
          // hint: Text(hint),
          items: <String>['اول', 'ثاني', 'ثالث', 'رابع']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              widget.smester = newValue!;
            });
          },
        ),
      ),
    );
  }
}

class CustomFloatingButtom extends StatelessWidget {
  const CustomFloatingButtom({
    super.key,
    required this.text,
    required this.press,
    required this.is_initializPage,
    required this.color,
  });

  final Color color;
  final bool is_initializPage;
  final void Function() press;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: is_initializPage == false ? 200 : 294,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}

class HeadOfDepartment extends StatefulWidget {
  const HeadOfDepartment({super.key});

  @override
  State<HeadOfDepartment> createState() => _HeadOfDepartmentState();
}

class _HeadOfDepartmentState extends State<HeadOfDepartment> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textControllerForCollegeDean = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: h,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue.shade200,
            const Color(0xFF0077cc), // Darker shade of blue
            //   Colors.red,
            // Color(0xFFcc0000)
          ],
        )),
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 8, right: 8),
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Form(
                key: formKey,
                child: CustomTextFormField(
                  textController: textControllerForCollegeDean,
                  text: "الأخ رئيس قسم",
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  validation: (value) {
                    if (value!.isEmpty) return 'لا يمكن ان يكون فارغا';
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                  "نحيل إليكم الطلب المذكور َنفا للإطلاع والاجراء بحسب ضوابط النقل من تخصص إلى اخر في إطار الكلية و ريازة الوثائق العلمية الخاصه",
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                height: 100,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.white.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue.shade200,
                      ),
                      child: HandSignature(
                        color: Colors.red,
                        control: HandSignatureControl(),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text(
                        "التوقيع",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded(child: Container()),
              SizedBox(height: h / 3),
              CustomFloatingButtom(
                text: 'تأكيد',
                is_initializPage: true,
                color: Colors.blue.shade200,
                press: () {
                  if (formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('تأكد من جميع المدخلات',
                              style: Theme.of(context).textTheme.titleLarge
                              //  textDirection: TextDirection.rtl,
                              ),
                          content: Text("هل انت متأكد من جميع الحقول",
                              style: Theme.of(context).textTheme.titleLarge
                              //  textDirection: TextDirection.rtl
                              ),
                          actions: <Widget>[
                            MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: new Text('إلغاء')),
                            MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);

                                  ///partThree
                                  Navigator.pushNamed(context, "/partThree");
                                },
                                child: new Text('حسنا')),
                          ],
                        );
                      },
                    );
                  } else {
                    print("error");
                  }
                },
              ),
              const SizedBox(
                height: 40,
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class PartThree extends StatefulWidget {
  PartThree({super.key});

  @override
  State<PartThree> createState() => _PartThreeState();
}

class _PartThreeState extends State<PartThree> {
  DateTime currentDate = DateTime.now();
  String currentDepartement = "علوم الحاسوب";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String previouesDepartement = "امن المعلومات";
  String smester = "اول";
  TextEditingController textControllerForCollegeDean = TextEditingController();

  final DateFormat _dateFormat = DateFormat('MM - dd - yyyy');

  _handleDataPicker() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: "اختر التاريخ الجامعي",
    );
    if (date != null && date != currentDate) {
      setState(() {
        currentDate = date;
      });
      //dataController.text = _dateFormat.format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: h,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.blue.shade100,
          const Color(0xFF0077cc), // Darker shade of blue
          //   Colors.red,
          // Color(0xFFcc0000)
        ],
      )),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Form(
              key: formKey,
              child: CustomTextFormField(
                textController: textControllerForCollegeDean,
                text: "الأخ/ عميد كلية",
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                validation: (value) {
                  if (value!.isEmpty) return 'لا يمكن ان يكون فارغا';
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                  'بعد الإطلاع على وثائق الطال المذكور لا مانع من تحويله من قسم',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 18)
                  //  textDirection: TextDirection.rtl,
                  ),
            ),
            SelectDepatment(departement: currentDepartement),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('المستوى',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 18)
                  //  textDirection: TextDirection.rtl,
                  ),
            ),
            SelectYear(smester: smester),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('الى قسم',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 18)
                  //  textDirection: TextDirection.rtl,
                  ),
            ),
            SelectDepatment(departement: previouesDepartement),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('المستوى',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 18)
                  //  textDirection: TextDirection.rtl,
                  ),
            ),
            SelectYear(smester: smester),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text(
                      "اختر التاريخ الجامعي",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 18),
                    ),
                    onPressed: () => _handleDataPicker(),
                  ),
                  Text(
                    _dateFormat.format(currentDate),
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
            ),
            //Expanded(child: Container()),
            SizedBox(height: h / 3.5),
            Center(
              child: CustomFloatingButtom(
                text: 'تأكيد',
                is_initializPage: true,
                color: Colors.blue.shade200,
                press: () {
                  if (formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('تأكد من جميع المدخلات',
                              style: Theme.of(context).textTheme.titleLarge
                              //  textDirection: TextDirection.rtl,
                              ),
                          content: Text("هل انت متأكد من جميع الحقول",
                              style: Theme.of(context).textTheme.titleLarge
                              //  textDirection: TextDirection.rtl
                              ),
                          actions: <Widget>[
                            MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: new Text('إلغاء')),
                            MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);

                                  ///partThree
                                  Navigator.pushNamed(context, "/partFour");
                                },
                                child: new Text('حسنا')),
                          ],
                        );
                      },
                    );
                  } else {
                    print("error");
                  }
                },
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    ));
  }
}

class PartFour extends StatefulWidget {
  PartFour({super.key});

  @override
  State<PartFour> createState() => _PartFourState();
}

class _PartFourState extends State<PartFour> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<int> marks = [];
  List<String> semesters = [];
  List<String> subjects = [];
  TextEditingController textControllerForLevel = TextEditingController();
  TextEditingController textControllerForMarks = TextEditingController();
  TextEditingController textControllerForSubject = TextEditingController();

  List<DataRow> _buildRows() {
    List<DataRow> rows = [];
    for (int i = 0; i < subjects.length; i++) {
      List<DataCell> cells = [];
      cells.add(DataCell(Text(
        subjects[i],
        style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 15),
      )));
      cells.add(DataCell(Text(semesters[i],
          style:
              Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 15))));
      cells.add(DataCell(Text("${marks[i]}",
          style:
              Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 15))));
      rows.add(DataRow(cells: cells));
    }
    return rows;
  }

  void _addSubject({required String? subject}) {
    setState(() {
      subjects.add(subject!);
    });
  }

  void _addSemester({required int? semester}) {
    setState(() {
      semesters.add("$semester");
    });
  }

  void _addMarks({required int? mark}) {
    setState(() {
      marks.add(mark!); // Replace this with your actual logic to get marks
    });
  }

  List<DataColumn> _buildColumns() {
    return [
      DataColumn(
          label: Text(
        'المقررات',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
      )),
      DataColumn(
          label: Text(
        'المستوى',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
      )),
      DataColumn(
          label: Text(
        'العلامة',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
      )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () {
          textControllerForSubject.text = "";
          textControllerForLevel.text = "";
          textControllerForMarks.text = "";
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('إضافة مقرر جديد',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 20)
                    //  textDirection: TextDirection.rtl,
                    ),
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextFormField(
                        textController: textControllerForSubject,
                        text: "المقرر",
                        keyboardType: TextInputType.name,
                        validation: (value) {
                          if (value!.isEmpty) return 'لا يمكن ان يكون فارغا';
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        textController: textControllerForLevel,
                        text: "المستوى",
                        keyboardType: TextInputType.number,
                        validation: (value) {
                          if (value!.isEmpty) return 'لا يمكن ان يكون فارغا';
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        textController: textControllerForMarks,
                        text: "العلامة",
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        validation: (value) {
                          if (value!.isEmpty) return 'لا يمكن ان يكون فارغا';
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              int mark = int.parse(textControllerForMarks.text);
                              int semester =
                                  int.parse(textControllerForLevel.text);
                              _addSubject(
                                  subject: textControllerForSubject.text);
                              _addSemester(semester: semester);
                              _addMarks(mark: mark);
                              Navigator.pop(context);
                            }
                          },
                          child: Text('إضافة',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 18))),
                      MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('إلغاء',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 18)))
                    ],
                  ),
                ],
              );
            },
          );
          //  _addSemester();
        },
        child: Text(
          'إضافة مقرر',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue.shade100,
            const Color(0xFF0077cc), // Darker shade of blue
          ],
        )),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                border: TableBorder.all(color: Colors.black),
                columns: _buildColumns(),
                rows: _buildRows(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
































//----------------------------القسم الأول-----------------------------------------
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("الأخ/ عميد كلية ............................... المحترم",
//                     style: Theme.of(context).textTheme.bodyMedium),
//                 Text(
//                     "أتقدم إليكم أنا الطالب : ...................المقيد برقم :..................",
//                     style: Theme.of(context).textTheme.bodyMedium),
//                 Text(
//                     "تخصص : ............... المستوى : ........ للعام الجامعي : ............",
//                     style: Theme.of(context).textTheme.bodyMedium),
//                 Text(
//                     "يطلب الإانتقال إلى تخصص : ............... نظام القبول : ............",
//                     style: Theme.of(context).textTheme.bodyMedium),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 25, top: 20),
//                     child: Text("التوقيع : .......................",
//                         style: Theme.of(context).textTheme.bodyMedium),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 40),
//                     child: Text("التاريخ : ..........................",
//                         style: Theme.of(context).textTheme.bodyMedium),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 40),
//                   child: Text("-  مرفق بيان درجات"),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 40),
//                   child: Text("-  نسخة من شهادة الثانوية ",
//                       style: Theme.of(context).textTheme.bodyMedium),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//               margin: const EdgeInsets.symmetric(horizontal: 5),
//               width: w - 10,
//               color: Colors.black,
//               height: 2),
// //----------------------------القسم الثاني-----------------------------------------
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 30),
//                   child: Text(
//                       "الأخ/ رئيس قسم  ...............................              المحترم",
//                       style: Theme.of(context).textTheme.bodyMedium),
//                 ),
// Text(
//     "نحيل إليكم الطلب المذكور َنفا للإطلاع والاجراء بحسب ضوابط النقل من تخصص إلى اخر في إطار الكلية و ريازة الوثائق العلمية الخاصه",
//     style: Theme.of(context).textTheme.bodyMedium),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 30, top: 20),
//                     child: Text("..........................",
//                         style: Theme.of(context).textTheme.bodyMedium),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 50, top: 5),
//                     child: Text("عميد الكلية",
//                         style: Theme.of(context).textTheme.bodyMedium),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//               margin: const EdgeInsets.symmetric(horizontal: 5),
//               width: w - 10,
//               color: Colors.black,
//               height: 2),
// //----------------------------القسم الثالث-----------------------------------------
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 30),
//                   child: Text(
//                       "الأخ/ عميد الكلية                                                 المحترم",
//                       style: Theme.of(context).textTheme.bodyMedium),
//                 ),
//                 Text(
//                     "بعد الإطلاع على وثائق الطال المذكور لا مانع من تحويله من قسم : .............. المستوى : ............. إلى قسم :............... المستوى : .......... للعام الجامعي : .................",
//                     style: Theme.of(context).textTheme.bodyMedium),
//               ],
//             ),
//           )