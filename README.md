<div align="center">

# 💸 مصروفي — Masrofy

### تطبيق ذكي لإدارة ميزانيتك الشخصية

_أدر مصروفاتك وديونك وأهدافك المالية في مكان واحد_

---

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

## 🎬 شاهد التطبيق

https://github.com/user-attachments/assets/803da1de-014d-47ca-9f12-c7bd1b424561


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

<p align="center">
  <img width="130" src="https://github.com/user-attachments/assets/34c05ec5-7807-46a7-9575-2f79e141d2b1" />
  <img width="130" src="https://github.com/user-attachments/assets/fa64ea09-6c70-4627-8037-2fd40df494e0" />
  <img width="130" src="https://github.com/user-attachments/assets/e6fb69ee-205b-4bc2-9b8b-deb74f28fbd9" />
  <img width="130" src="https://github.com/user-attachments/assets/498bfefa-9050-43dd-91fa-1f6b36205343" />
  <img width="130" src="https://github.com/user-attachments/assets/e1c12a54-e2ce-4c61-b39b-c168cbd1abd9" />
  <img width="130" src="https://github.com/user-attachments/assets/5bbc6a02-b455-425a-aa51-04679cae446b" />
</p>
<p align="center">
  <img width="130" src="https://github.com/user-attachments/assets/543d27bc-45b9-44a0-8539-8201fa810c88" />
  <img width="130" src="https://github.com/user-attachments/assets/f462d3ef-915b-40ef-b92b-24a8080211f3" />
  <img width="130" src="https://github.com/user-attachments/assets/486c6ab7-1582-4497-90d1-464e067cddc7" />
  <img width="130" src="https://github.com/user-attachments/assets/c0c6aa76-1937-4abc-a5ee-e6e5cdcb195f" />
  <img width="130" src="https://github.com/user-attachments/assets/56e0b4e0-81f2-45d2-ba39-8f71ea97ef54" />
  <img width="130" src="https://github.com/user-attachments/assets/079c2407-4952-4a96-b014-518d0eb5d5e9" />
</p>
<p align="center">
  <img width="130" src="https://github.com/user-attachments/assets/2f3c6ed8-2f3f-4036-a799-f3919456c5f4" />
  <img width="130" src="https://github.com/user-attachments/assets/ddb452cb-2f29-4268-b9ce-b767c7f6692f" />
  <img width="130" src="https://github.com/user-attachments/assets/1ff90c1d-916d-4a5a-aed2-3842ef57dc89" />
  <img width="130" src="https://github.com/user-attachments/assets/1eb3fd62-ce5b-45e1-b764-c750c6f36e89" />
  <img width="130" src="https://github.com/user-attachments/assets/172b3c5c-bd94-496a-93b4-5cd768b2f85d" />
  <img width="130" src="https://github.com/user-attachments/assets/84a4f31d-b985-419b-951e-a968e69f7656" />
</p>
<p align="center">
  <img width="130" src="https://github.com/user-attachments/assets/f10e043f-cf4a-4ec7-a654-ad9765e03f23" />
  <img width="130" src="https://github.com/user-attachments/assets/0a81a6c8-b14d-450f-a123-f1a32b919ead" />
  <img width="130" src="https://github.com/user-attachments/assets/75b57032-b846-47cd-9ea4-e0f458f4db3f" />
  <img width="130" src="https://github.com/user-attachments/assets/ecacc1af-b6ac-456a-ae4b-fd3c9d36fd72" />
  <img width="130" src="https://github.com/user-attachments/assets/21fc0073-71ad-4b21-95dd-66faa87cc72c" />
  <img width="130" src="https://github.com/user-attachments/assets/b8c3f839-7604-4c98-a1b4-ab7f990809a2" />
</p>
<p align="center">
  <img width="130" src="https://github.com/user-attachments/assets/15d5203e-f416-481b-9423-8c3fb12fc5be" />
  <img width="130" src="https://github.com/user-attachments/assets/ab0f2d0d-8b9b-4523-aacf-f8eaa97b068f" />
</p>

---

<div align="center">

صُنع بـ ❤️ بـ Flutter

</div>



