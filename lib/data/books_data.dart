import 'book_model.dart';

const List<Book> kBooks = [
  Book(
    id: 'republic',
    titleEn: 'The Republic',
    titleAr: 'الجمهورية',
    authorEn: 'Plato',
    authorAr: 'أفلاطون',
    price: 285,
    color: 0xFF8C7A55,
    image: 'assets/images/book_republic.png',
    descriptionEn:
        'A classic dialogue on justice, the ideal city and the role of the '
        'philosopher. Plato asks what a just life looks like and how a society '
        'can be organised so that its citizens can flourish.',
    descriptionAr:
        'حوار فلسفي كلاسيكي عن العدالة والمدينة الفاضلة ودور الفيلسوف. '
        'يسأل أفلاطون كيف تبدو الحياة العادلة وكيف يمكن تنظيم المجتمع '
        'ليزدهر مواطنوه.',
  ),
  Book(
    id: 'black_heart',
    titleEn: 'Black Heart',
    titleAr: 'القلب الأسود',
    authorEn: 'Holly Black',
    authorAr: 'هولي بلاك',
    price: 285,
    color: 0xFF2B1240,
    image: 'assets/images/book_black_heart.jpg',
    descriptionEn:
        'A dark fantasy of curses, schemes and dangerous loyalties. A young '
        'heroine must decide who to trust when every ally seems to be hiding '
        'a secret.',
    descriptionAr:
        'رواية فانتازيا مظلمة عن اللعنات والمؤامرات والولاءات الخطرة. على '
        'بطلة شابة أن تقرر بمن تثق حين يبدو أن كل حليف يخفي سراً.',
  ),
  Book(
    id: 'meditations',
    titleEn: 'Meditations',
    titleAr: 'التأملات',
    authorEn: 'Marcus Aurelius',
    authorAr: 'ماركوس أوريليوس',
    price: 199,
    color: 0xFF4A5D6B,
    image: 'assets/images/book_republic.png',
    descriptionEn:
        'Private notes of a Roman emperor on discipline, duty and keeping '
        'calm. Short, practical reflections that are still easy to apply today.',
    descriptionAr:
        'ملاحظات شخصية لإمبراطور روماني عن الانضباط والواجب والحفاظ على '
        'الهدوء. تأملات قصيرة وعملية ما زال تطبيقها سهلاً اليوم.',
  ),
  Book(
    id: 'alchemist',
    titleEn: 'The Alchemist',
    titleAr: 'الخيميائي',
    authorEn: 'Paulo Coelho',
    authorAr: 'باولو كويلو',
    price: 240,
    color: 0xFFB5773A,
    image: 'assets/images/book_republic.png',
    descriptionEn:
        'A shepherd boy travels toward the pyramids following a dream. A '
        'simple, hopeful story about listening to your heart and finishing '
        'the journey.',
    descriptionAr:
        'راعٍ شاب يسافر نحو الأهرامات متبعاً حلمه. قصة بسيطة ومتفائلة عن '
        'الإصغاء إلى القلب وإكمال الرحلة.',
  ),
  Book(
    id: 'pride',
    titleEn: 'Pride and Prejudice',
    titleAr: 'كبرياء وهوى',
    authorEn: 'Jane Austen',
    authorAr: 'جين أوستن',
    price: 220,
    color: 0xFF9C5B6B,
    image: 'assets/images/book_republic.png',
    descriptionEn:
        'A witty story of manners, family and first impressions, following '
        'Elizabeth Bennet as she learns how wrong a first judgement can be.',
    descriptionAr:
        'قصة ذكية عن الآداب والعائلة والانطباعات الأولى، تتبع إليزابيث '
        'بينيت وهي تتعلم كم يمكن أن يكون الحكم الأول خاطئاً.',
  ),
  Book(
    id: 'nineteen_eighty_four',
    titleEn: '1984',
    titleAr: '1984',
    authorEn: 'George Orwell',
    authorAr: 'جورج أورويل',
    price: 260,
    color: 0xFF7A1F1F,
    image: 'assets/images/book_republic.png',
    descriptionEn:
        'A chilling novel about surveillance, propaganda and the fight to '
        'keep independent thought alive under total control.',
    descriptionAr:
        'رواية مخيفة عن المراقبة والدعاية والكفاح للحفاظ على التفكير '
        'المستقل في ظل السيطرة الكاملة.',
  ),
];

Book? bookById(String id) {
  for (final b in kBooks) {
    if (b.id == id) return b;
  }
  return null;
}