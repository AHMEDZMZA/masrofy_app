<div align="center">

# 💸 مصروفي — Masrofy

### تطبيق ذكي لإدارة ميزانيتك الشخصية

_أدر مصروفاتك وديونك وأهدافك المالية في مكان واحد_

---

<!-- 👇 ضع صور التطبيق هنا -->
<!-- مثال:
<img src="assets/screenshots/home.png" width="200"/> &nbsp;
<img src="assets/screenshots/reports.png" width="200"/> &nbsp;
<img src="assets/screenshots/goals.png" width="200"/>
-->

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Riverpod](https://img.shields.io/badge/Riverpod-StateManagement-00BCD4?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

</div>

---

## 📱 عن التطبيق

**مصروفي** تطبيق Flutter مجاني لإدارة المال الشخصي، يساعدك على تتبع مصروفاتك ودخلك وديونك وأهدافك المالية بسهولة وبواجهة عربية أنيقة.

> _"التحكم في أموالك هو أول خطوة للحرية المالية"_

---

## ✨ المميزات

| الميزة                      | الوصف                                           |
| --------------------------- | ----------------------------------------------- |
| 📊 **الملخص المالي**        | نظرة شاملة على رصيدك ودخلك ومصروفاتك            |
| 💰 **تتبع المصروفات**       | سجّل مصروفاتك اليومية مع التصنيف والوصف         |
| 💵 **إدارة الدخل**          | سجّل مصادر دخلك من راتب، عمل حر، استثمار وغيرها |
| 📋 **الديون**               | تتبع ديونك وما تم سداده مع نسب واضحة            |
| 🎯 **الأهداف المالية**      | ضع أهدافاً للادخار وتابع تقدمك                  |
| 📈 **التقارير والإحصائيات** | رسوم بيانية وإحصائيات شهرية مفصّلة              |
| 🌙 **الوضع الداكن**         | دعم الوضع الفاتح والداكن والتلقائي              |
| 🌐 **ثنائي اللغة**          | يدعم العربية والإنجليزية بالكامل                |
| 🔐 **تسجيل بجوجل**          | دخول آمن وسريع عبر حساب Google                  |

---

## 🗂️ هيكل المشروع

```
masrofy/
├── lib/
│   ├── core/
│   │   ├── constants/       # الثوابت (الألوان، الأحجام...)
│   │   ├── extensions/      # امتدادات Dart
│   │   ├── routes/          # التنقل بين الشاشات (GoRouter)
│   │   ├── service/         # الخدمات المشتركة
│   │   ├── themes/          # الثيم الفاتح والداكن
│   │   └── widgets/         # Widgets مشتركة
│   └── features/
│       ├── auth/            # 🔐 تسجيل الدخول
│       ├── home/            # 🏠 الشاشة الرئيسية والملخص
│       ├── expenses/        # 💸 المصروفات
│       ├── income/          # 💵 الدخل
│       ├── debts/           # 📋 الديون
│       └── goals/           # 🎯 الأهداف المالية
└── assets/
    ├── images/              # الصور
    └── translations/        # ملفات الترجمة (ar.json, en.json)
```

---

## 🛠️ التقنيات المستخدمة

| التقنية                                                           | الاستخدام                |
| ----------------------------------------------------------------- | ------------------------ |
| [Flutter](https://flutter.dev)                                    | إطار العمل الأساسي       |
| [Firebase Auth](https://firebase.google.com/products/auth)        | المصادقة وتسجيل الدخول   |
| [Cloud Firestore](https://firebase.google.com/products/firestore) | قاعدة البيانات السحابية  |
| [Riverpod](https://riverpod.dev)                                  | إدارة الحالة             |
| [GoRouter](https://pub.dev/packages/go_router)                    | التنقل بين الشاشات       |
| [Easy Localization](https://pub.dev/packages/easy_localization)   | دعم تعدد اللغات          |
| [Google Fonts](https://pub.dev/packages/google_fonts)             | الخطوط                   |
| [Flutter ScreenUtil](https://pub.dev/packages/flutter_screenutil) | التوافق مع أحجام الشاشات |
| [Google Sign In](https://pub.dev/packages/google_sign_in)         | تسجيل الدخول عبر جوجل    |

---

## 🚀 تشغيل المشروع

### المتطلبات

- Flutter SDK `^3.11.5`
- Dart SDK `^3.x`
- حساب Firebase مع مشروع مُهيَّأ

### خطوات التثبيت

```bash
# 1. استنسخ المشروع
git clone https://github.com/your-username/masrofy.git
cd masrofy

# 2. ثبّت الحزم
flutter pub get

# 3. اضبط Firebase (تأكد من وجود google-services.json)
# راجع: https://firebase.google.com/docs/flutter/setup

# 4. شغّل التطبيق
flutter run
```

---

## 📸 صور التطبيق

> سيتم إضافة صور التطبيق قريباً...

---

## 📄 الرخصة

هذا المشروع مرخص تحت رخصة [MIT](LICENSE).

---

<div align="center">

صُنع بـ ❤️ بـ Flutter

</div>
