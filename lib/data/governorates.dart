class Governorate {
  const Governorate(this.id, this.en, this.ar);
  final String id;
  final String en;
  final String ar;

  String name(String lang) => lang == 'ar' ? ar : en;
}

const List<Governorate> kGovernorates = [
  Governorate('cairo', 'Cairo', 'القاهرة'),
  Governorate('giza', 'Giza', 'الجيزة'),
  Governorate('alexandria', 'Alexandria', 'الإسكندرية'),
  Governorate('qalyubia', 'Qalyubia', 'القليوبية'),
  Governorate('port_said', 'Port Said', 'بورسعيد'),
  Governorate('suez', 'Suez', 'السويس'),
  Governorate('dakahlia', 'Dakahlia', 'الدقهلية'),
  Governorate('sharqia', 'Sharqia', 'الشرقية'),
  Governorate('gharbia', 'Gharbia', 'الغربية'),
  Governorate('monufia', 'Monufia', 'المنوفية'),
  Governorate('beheira', 'Beheira', 'البحيرة'),
  Governorate('kafr_el_sheikh', 'Kafr El Sheikh', 'كفر الشيخ'),
  Governorate('damietta', 'Damietta', 'دمياط'),
  Governorate('ismailia', 'Ismailia', 'الإسماعيلية'),
  Governorate('faiyum', 'Faiyum', 'الفيوم'),
  Governorate('beni_suef', 'Beni Suef', 'بني سويف'),
  Governorate('minya', 'Minya', 'المنيا'),
  Governorate('asyut', 'Asyut', 'أسيوط'),
  Governorate('sohag', 'Sohag', 'سوهاج'),
  Governorate('qena', 'Qena', 'قنا'),
  Governorate('luxor', 'Luxor', 'الأقصر'),
  Governorate('aswan', 'Aswan', 'أسوان'),
  Governorate('red_sea', 'Red Sea', 'البحر الأحمر'),
  Governorate('new_valley', 'New Valley', 'الوادي الجديد'),
  Governorate('matrouh', 'Matrouh', 'مطروح'),
  Governorate('north_sinai', 'North Sinai', 'شمال سيناء'),
  Governorate('south_sinai', 'South Sinai', 'جنوب سيناء'),
];

Governorate? governorateById(String? id) {
  if (id == null) return null;
  for (final g in kGovernorates) {
    if (g.id == id) return g;
  }
  return null;
}