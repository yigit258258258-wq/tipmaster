import '../models/question.dart';

class VisualQuestions {
  static final List<Question> questions = [
    // ============================================================
    // FEMUR (Femur.png) - Kırmızı işaretli uyluk kemiği
    // ============================================================
    Question(id: 'vis_f01', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'easy',
      questionText: 'Görselde kırmızı ile işaretlenmiş kemik hangisidir?', imageUrl: 'assets/images/Femur.png',
      options: ['Tibia', 'Femur', 'Humerus', 'Fibula'], correctAnswer: 'Femur', latinTerm: 'Os femoris',
      explanation: 'Femur (uyluk kemiği), vücudun en uzun ve en güçlü kemiğidir. Yaklaşık 48 cm uzunluğundadır.'),
    Question(id: 'vis_f02', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'medium',
      questionText: 'Görseldeki kırmızı kemiğin üst ucu (proksimal) hangi eklemle eklemlenir?', imageUrl: 'assets/images/Femur.png',
      options: ['Diz eklemi', 'Kalça eklemi (articulatio coxae)', 'Ayak bileği eklemi', 'Sakroiliak eklem'],
      correctAnswer: 'Kalça eklemi (articulatio coxae)', latinTerm: 'Articulatio coxae',
      explanation: 'Femur başı (caput femoris), pelvisin asetabulumu ile eklem yaparak kalça eklemini oluşturur. Ball-and-socket tipi bir eklemdir.'),
    Question(id: 'vis_f03', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'medium',
      questionText: 'Görseldeki kırmızı kemiğin alt ucu (distal) hangi eklemle eklemlenir?', imageUrl: 'assets/images/Femur.png',
      options: ['Kalça eklemi', 'Diz eklemi (articulatio genus)', 'Ayak bileği eklemi', 'Dirsek eklemi'],
      correctAnswer: 'Diz eklemi (articulatio genus)', latinTerm: 'Articulatio genus',
      explanation: 'Femur distalde tibia ve patella ile eklemlenerek diz eklemini (articulatio genus) oluşturur. Vücudun en büyük eklemidir.'),
    Question(id: 'vis_f04', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'hard',
      questionText: 'Görseldeki femurun boyun kırığında en tehlikeli komplikasyon nedir?', imageUrl: 'assets/images/Femur.png',
      options: ['Sinir hasarı', 'Avasküler nekroz', 'Omurilik basısı', 'Pnömotoraks'],
      correctAnswer: 'Avasküler nekroz', latinTerm: 'Collum femoris',
      explanation: 'Femur boynu kırıklarında a. circumflexa femoris medialis hasar görebilir ve femur başı avasküler nekroza (kan beslenememe sonucu kemik ölümü) uğrar.'),
    Question(id: 'vis_f05', category: 'anatomy', subcategory: 'skeletal_system', type: 'open', difficulty: 'hard',
      questionText: 'Görseldeki femurun arka yüzeyindeki belirgin uzunlamasına çıkıntının Latince adı nedir?', imageUrl: 'assets/images/Femur.png',
      correctAnswer: 'Linea aspera', latinTerm: 'Linea aspera',
      explanation: 'Linea aspera, femur gövdesinin arka yüzeyinde bulunan belirgin bir çıkıntıdır. Birçok uyluk kası bu yapıya tutunur.'),

    // ============================================================
    // KAFATASI (Skull.PNG) - Renkli kemikler
    // ============================================================
    Question(id: 'vis_s01', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'easy',
      questionText: 'Görselde farklı renklerle gösterilen yapı nedir?', imageUrl: 'assets/images/Skull.PNG',
      options: ['Pelvis', 'Kafatası (Cranium)', 'Göğüs kafesi', 'Omurga'],
      correctAnswer: 'Kafatası (Cranium)', latinTerm: 'Cranium',
      explanation: 'Kafatası 22 kemikten oluşur: 8 kranial (beyin kafatası) ve 14 yüz kemiği. Görselde her kemik farklı renkle gösterilmiştir.'),
    Question(id: 'vis_s02', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'medium',
      questionText: 'Görselde mavi renkle gösterilen en büyük kranial kemik hangisidir?', imageUrl: 'assets/images/Skull.PNG',
      options: ['Os frontale', 'Os parietale', 'Os temporale', 'Os occipitale'],
      correctAnswer: 'Os parietale', latinTerm: 'Os parietale',
      explanation: 'Parietal kemik (tepe kemiği), kafatasının üst-yan kısmını oluşturan çift kemiktir. Görselde mavi/açık mavi olarak en geniş alanı kaplar.'),
    Question(id: 'vis_s03', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'medium',
      questionText: 'Görselde turuncu renkle gösterilen şakak bölgesi kemiğinin Latince adı nedir?', imageUrl: 'assets/images/Skull.PNG',
      options: ['Os frontale', 'Os parietale', 'Os temporale', 'Os sphenoidale'],
      correctAnswer: 'Os temporale', latinTerm: 'Os temporale',
      explanation: 'Temporal kemik (şakak kemiği) kafatasının yan kısmında bulunur. İçinde orta ve iç kulak yapıları yer alır.'),
    Question(id: 'vis_s04', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'medium',
      questionText: 'Görselde yeşil renkle gösterilen arka kısımdaki kemik hangisidir?', imageUrl: 'assets/images/Skull.PNG',
      options: ['Os frontale', 'Os parietale', 'Os temporale', 'Os occipitale'],
      correctAnswer: 'Os occipitale', latinTerm: 'Os occipitale',
      explanation: 'Oksipital kemik (art kafa kemiği), kafatasının arka-alt kısmını oluşturur. Foramen magnum bu kemik üzerindedir.'),
    Question(id: 'vis_s05', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'hard',
      questionText: 'Görselde sarı renkle gösterilen alın kemiğinin altındaki büyük açıklık (orbita) hangi yapıyı barındırır?', imageUrl: 'assets/images/Skull.PNG',
      options: ['Beyin', 'Göz küresi (bulbus oculi)', 'İç kulak', 'Paranazal sinüs'],
      correctAnswer: 'Göz küresi (bulbus oculi)', latinTerm: 'Orbita',
      explanation: 'Orbita (göz çukuru), göz küresi, göz kasları, sinirler ve damarları barındıran piramit şekilli boşluktur. 7 farklı kemikten oluşur.'),
    Question(id: 'vis_s06', category: 'anatomy', subcategory: 'skeletal_system', type: 'open', difficulty: 'hard',
      questionText: 'Görseldeki kafatasında alt çene kemiğinin Latince adını yazınız.', imageUrl: 'assets/images/Skull.PNG',
      correctAnswer: 'Mandibula', latinTerm: 'Mandibula',
      explanation: 'Mandibula, kafatasının tek hareketli kemiğidir. Temporomandibular eklem (TME) ile temporal kemiğe bağlanır.'),

    // ============================================================
    // OMURGA (Spine.png) - Renkli bölgeler
    // ============================================================
    Question(id: 'vis_sp01', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'easy',
      questionText: 'Görseldeki omurga toplam kaç omurdan oluşur?', imageUrl: 'assets/images/Spine.png',
      options: ['26', '30', '33', '36'], correctAnswer: '33',
      explanation: 'Omurga 33 omurdan oluşur: 7 servikal, 12 torakal, 5 lumbal, 5 sakral (kaynaşık), 4 koksigeal (kaynaşık).'),
    Question(id: 'vis_sp02', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'medium',
      questionText: 'Görselde en üstteki açık renkli bölge (boyun) kaç omur içerir?', imageUrl: 'assets/images/Spine.png',
      options: ['5', '7', '9', '12'], correctAnswer: '7', latinTerm: 'Vertebrae cervicales',
      explanation: 'Servikal bölge 7 omur içerir (C1-C7). C1 Atlas kafatasını taşır, C2 Axis dens çıkıntısıyla baş rotasyonunu sağlar.'),
    Question(id: 'vis_sp03', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'medium',
      questionText: 'Görselde mor/lila renkle gösterilen bölge hangisidir?', imageUrl: 'assets/images/Spine.png',
      options: ['Servikal', 'Torakal', 'Lumbal', 'Sakral'], correctAnswer: 'Sakral', latinTerm: 'Os sacrum',
      explanation: 'Sakrum (os sacrum), 5 kaynaşmış omurdan oluşur. Mor/lila ile gösterilen bu bölge pelvisin arka duvarını oluşturur.'),
    Question(id: 'vis_sp04', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'hard',
      questionText: 'Görselde omurga eğrilikleri görülmektedir. Boyun ve bel bölgesindeki öne doğru eğriliğe ne denir?', imageUrl: 'assets/images/Spine.png',
      options: ['Kifoz', 'Lordoz', 'Skolyoz', 'Spondiloz'], correctAnswer: 'Lordoz',
      explanation: 'Lordoz, servikal ve lumbal bölgelerdeki fizyolojik öne doğru eğriliktir. Kifoz ise torakal ve sakral bölgelerdeki arkaya doğru eğriliktir.'),
    Question(id: 'vis_sp05', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'hard',
      questionText: 'Görseldeki omurgada disk hernisi (fıtık) en sık hangi bölgede görülür?', imageUrl: 'assets/images/Spine.png',
      options: ['Servikal (C1-C2)', 'Torakal (T5-T8)', 'Lumbal (L4-L5, L5-S1)', 'Sakral'],
      correctAnswer: 'Lumbal (L4-L5, L5-S1)',
      explanation: 'Disk hernisi en sık L4-L5 ve L5-S1 seviyelerinde görülür çünkü bu bölge en fazla mekanik yüke maruz kalır.'),

    // ============================================================
    // EL İSKELETİ (Hand.png)
    // ============================================================
    Question(id: 'vis_h01', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'easy',
      questionText: 'Görseldeki bir elde toplam kaç kemik bulunur?', imageUrl: 'assets/images/Hand.png',
      options: ['19', '23', '27', '31'], correctAnswer: '27',
      explanation: 'Her elde 27 kemik bulunur: 8 karpal (bilek), 5 metakarpal (avuç içi tarak), 14 falanks (parmak) kemiği.'),
    Question(id: 'vis_h02', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'medium',
      questionText: 'Görseldeki el bileği kemiklerinden en sık kırılan hangisidir?', imageUrl: 'assets/images/Hand.png',
      options: ['Lunat', 'Skafoid', 'Kapitat', 'Hamat'], correctAnswer: 'Skafoid', latinTerm: 'Os scaphoideum',
      explanation: 'Skafoid (navikular), el bileğinde en sık kırılan kemiktir. Kanlanması zayıf olduğu için avasküler nekroz riski taşır.'),
    Question(id: 'vis_h03', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'medium',
      questionText: 'Görselde parmak kemiklerine ne ad verilir?', imageUrl: 'assets/images/Hand.png',
      options: ['Karpal', 'Metakarpal', 'Falanks (Phalanges)', 'Tarsal'],
      correctAnswer: 'Falanks (Phalanges)', latinTerm: 'Phalanges',
      explanation: 'Parmak kemiklerine falanks denir. Başparmak 2, diğer parmaklar 3 falankstan oluşur: proksimal, medial (orta), distal.'),
    Question(id: 'vis_h04', category: 'anatomy', subcategory: 'skeletal_system', type: 'open', difficulty: 'hard',
      questionText: 'Görselde el bileği ile parmaklar arasındaki 5 uzun kemiğin Latince adını yazınız.', imageUrl: 'assets/images/Hand.png',
      correctAnswer: 'Ossa metacarpalia', latinTerm: 'Ossa metacarpalia',
      explanation: 'Metakarpal kemikler (I-V), avuç içini oluşturan 5 uzun kemiktir. Proksimalde karpal, distalde falanks kemikleriyle eklemlenir.'),

    // ============================================================
    // PATELLA (patella.png)
    // ============================================================
    Question(id: 'vis_p01', category: 'anatomy', subcategory: 'skeletal_system', type: 'open', difficulty: 'medium',
      questionText: 'Görseldeki kemiğin Latince adını yazınız.', imageUrl: 'assets/images/patella.png',
      correctAnswer: 'Patella', latinTerm: 'Patella',
      explanation: 'Patella (diz kapağı), vücudun en büyük sesamoid kemiğidir. Quadriceps tendonunun içinde gelişir.'),
    Question(id: 'vis_p02', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'hard',
      questionText: 'Görseldeki patella hangi tendonun içinde bulunan sesamoid bir kemiktir?', imageUrl: 'assets/images/patella.png',
      options: ['Hamstring tendonu', 'Quadriceps femoris tendonu', 'Aşil tendonu', 'Patellar ligament'],
      correctAnswer: 'Quadriceps femoris tendonu',
      explanation: 'Patella, quadriceps femoris tendonunun içinde gelişen sesamoid kemiktir. Diz ekstansiyonunda mekanik avantaj sağlar.'),

    // ============================================================
    // STERNUM (sternum.png) - Doğumda ve 3 yaşında
    // ============================================================
    Question(id: 'vis_st01', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'medium',
      questionText: 'Görseldeki sternum (göğüs kemiği) kaç ana parçadan oluşur?', imageUrl: 'assets/images/sternum.png',
      options: ['2', '3', '4', '5'], correctAnswer: '3', latinTerm: 'Sternum',
      explanation: 'Sternum 3 parçadan oluşur: Manubrium (sap), Corpus sterni (gövde), Processus xiphoideus (kılıç çıkıntısı).'),
    Question(id: 'vis_st02', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'hard',
      questionText: 'Görselde doğumdaki ve 3 yaşındaki sternum karşılaştırılmıştır. Kırmızı alanlar neyi gösterir?', imageUrl: 'assets/images/sternum.png',
      options: ['Kemikleşme merkezleri (ossifikasyon)', 'Kanama alanları', 'Kas tutunma noktaları', 'Kıkırdak hasarı'],
      correctAnswer: 'Kemikleşme merkezleri (ossifikasyon)',
      explanation: 'Kırmızı alanlar ossifikasyon (kemikleşme) merkezlerini gösterir. Sternum doğumda büyük ölçüde kıkırdaktır ve yaşla birlikte kemikleşir.'),
    Question(id: 'vis_st03', category: 'anatomy', subcategory: 'skeletal_system', type: 'open', difficulty: 'hard',
      questionText: 'Görseldeki sternumun en alt ucundaki kıkırdak çıkıntının Latince adını yazınız.', imageUrl: 'assets/images/sternum.png',
      correctAnswer: 'Processus xiphoideus', latinTerm: 'Processus xiphoideus',
      explanation: 'Processus xiphoideus (ksifoid çıkıntı), sternumun en alt ve en küçük parçasıdır. Kıkırdak yapıda olup yaşla kemikleşir.'),

    // ============================================================
    // PELVİS (Pelvis.png) - Etiketli
    // ============================================================
    Question(id: 'vis_pe01', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'easy',
      questionText: 'Görseldeki pelvis hangi üç kemiğin birleşmesinden oluşur?', imageUrl: 'assets/images/Pelvis.png',
      options: ['Femur, Tibia, Fibula', 'İlium, İschium, Pubis', 'Sakrum, Koksiks, Femur', 'Radius, Ulna, Humerus'],
      correctAnswer: 'İlium, İschium, Pubis', latinTerm: 'Os coxae',
      explanation: 'Os coxae; ilium (yayvan kemik), ischium (oturak kemiği) ve pubis (çatı kemiği) kaynaşmasından oluşur.'),
    Question(id: 'vis_pe02', category: 'anatomy', subcategory: 'skeletal_system', type: 'test', difficulty: 'hard',
      questionText: 'Görseldeki pelviste femur başının oturduğu çukura ne denir?', imageUrl: 'assets/images/Pelvis.png',
      options: ['Fossa iliaca', 'Acetabulum', 'Foramen obturatum', 'Fossa ischioanalis'],
      correctAnswer: 'Acetabulum', latinTerm: 'Acetabulum',
      explanation: 'Acetabulum, ilium, ischium ve pubis kemiklerinin birleşme noktasındaki çukurdur. Femur başı burada oturarak kalça eklemini oluşturur.'),

    // ============================================================
    // KALP (heart.png) - Detaylı kesit, oklar
    // ============================================================
    Question(id: 'vis_hr01', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'easy',
      questionText: 'Görseldeki organ hangisidir?', imageUrl: 'assets/images/heart.png',
      options: ['Akciğer', 'Kalp', 'Karaciğer', 'Böbrek'], correctAnswer: 'Kalp', latinTerm: 'Cor',
      explanation: 'Kalp (Cor), göğüs boşluğunda mediastinumda yer alan 4 odacıklı müsküler pompadır.'),
    Question(id: 'vis_hr02', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'medium',
      questionText: 'Görseldeki kalp kesitinde mavi renkle gösterilen taraf ne taşır?', imageUrl: 'assets/images/heart.png',
      options: ['Oksijenli kan', 'Oksijensiz (venöz) kan', 'Lenf sıvısı', 'Beyin omurilik sıvısı'],
      correctAnswer: 'Oksijensiz (venöz) kan',
      explanation: 'Kalbin sağ tarafı (mavi) oksijensiz kan taşır. Sağ atriuma vena cavalardan gelen kan, sağ ventrikülden pulmoner arterle akciğerlere gönderilir.'),
    Question(id: 'vis_hr03', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'medium',
      questionText: 'Görseldeki kalp kesitinde kırmızı/pembe renkle gösterilen taraf ne taşır?', imageUrl: 'assets/images/heart.png',
      options: ['Oksijensiz kan', 'Oksijenli (arteriyel) kan', 'Safra', 'İdrar'],
      correctAnswer: 'Oksijenli (arteriyel) kan',
      explanation: 'Kalbin sol tarafı (kırmızı/pembe) oksijenli kan taşır. Pulmoner venlerden sol atriuma gelen kan, sol ventrikülden aort ile tüm vücuda pompalanır.'),
    Question(id: 'vis_hr04', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'hard',
      questionText: 'Görselde üstten çıkan büyük kırmızı damar hangisidir?', imageUrl: 'assets/images/heart.png',
      options: ['Vena cava superior', 'Arteria pulmonalis', 'Aorta', 'Vena pulmonalis'],
      correctAnswer: 'Aorta', latinTerm: 'Aorta',
      explanation: 'Aort, sol ventrikülden çıkan vücudun en büyük arteridir. Oksijenli kanı tüm vücuda dağıtır. Çapı yaklaşık 2.5 cm\'dir.'),
    Question(id: 'vis_hr05', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'hard',
      questionText: 'Görseldeki oklar kan akış yönünü göstermektedir. Triküspit kapak hangi iki odacık arasında bulunur?', imageUrl: 'assets/images/heart.png',
      options: ['Sol atrium - Sol ventrikül', 'Sağ atrium - Sağ ventrikül', 'Sol ventrikül - Aort', 'Sağ ventrikül - Pulmoner arter'],
      correctAnswer: 'Sağ atrium - Sağ ventrikül', latinTerm: 'Valva tricuspidalis',
      explanation: 'Triküspit (üç yaprakçıklı) kapak, sağ atrium ile sağ ventrikül arasındadır. Sol tarafta ise mitral (biküspit) kapak bulunur.'),
    Question(id: 'vis_hr06', category: 'physiology', subcategory: 'cardiovascular', type: 'test', difficulty: 'hard',
      questionText: 'Görseldeki kalbin sol ventrikül duvarı neden sağdan daha kalındır?', imageUrl: 'assets/images/heart.png',
      options: ['Daha fazla kan alır', 'Tüm vücuda kan pompalamak için daha fazla basınç üretir', 'Daha fazla kapak içerir', 'Koroner arterler sol taraftadır'],
      correctAnswer: 'Tüm vücuda kan pompalamak için daha fazla basınç üretir',
      explanation: 'Sol ventrikül tüm vücuda (sistemik dolaşım) kan pompalar ve bunun için yüksek basınç gerekir. Sağ ventrikül sadece akciğerlere pompar.'),

    // ============================================================
    // AKCİĞERLER (lungs.png) - Bronş ağacı ve damarlar
    // ============================================================
    Question(id: 'vis_l01', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'easy',
      questionText: 'Görseldeki organ hangisidir?', imageUrl: 'assets/images/lungs.png',
      options: ['Karaciğer', 'Böbrek', 'Akciğerler', 'Dalak'], correctAnswer: 'Akciğerler', latinTerm: 'Pulmones',
      explanation: 'Akciğerler (Pulmones), göğüs boşluğunda yer alan solunum organlarıdır.'),
    Question(id: 'vis_l02', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'medium',
      questionText: 'Görselde sağ akciğer kaç lobdan oluşur?', imageUrl: 'assets/images/lungs.png',
      options: ['2', '3', '4', '5'], correctAnswer: '3',
      explanation: 'Sağ akciğer 3 lobdan (üst, orta, alt), sol akciğer 2 lobdan (üst, alt) oluşur.'),
    Question(id: 'vis_l03', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'medium',
      questionText: 'Görselde ortada görülen halkalar halindeki yapı (trakea) hangi kıkırdaktan oluşur?', imageUrl: 'assets/images/lungs.png',
      options: ['Elastik kıkırdak', 'Fibrokıkırdak', 'C şeklinde hyalin kıkırdak', 'Kemik halka'],
      correctAnswer: 'C şeklinde hyalin kıkırdak', latinTerm: 'Trachea',
      explanation: 'Trakea, C şeklinde (arkası açık) 16-20 hyalin kıkırdak halkadan oluşur. Arkada membranöz kısım özofagusa komşudur.'),
    Question(id: 'vis_l04', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'hard',
      questionText: 'Görselde mavi damarlar ve kırmızı damarlar görülmektedir. Pulmoner arter hangi renktedir ve ne taşır?', imageUrl: 'assets/images/lungs.png',
      options: ['Kırmızı - oksijenli kan', 'Mavi - oksijensiz kan', 'Kırmızı - oksijensiz kan', 'Sarı - lenf sıvısı'],
      correctAnswer: 'Mavi - oksijensiz kan', latinTerm: 'Arteria pulmonalis',
      explanation: 'Pulmoner arter oksijensiz kan taşıyan TEK arterdir. Sağ ventrikülden çıkarak kanı akciğerlere götürür. Görselde mavi olarak gösterilir.'),
    Question(id: 'vis_l05', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'hard',
      questionText: 'Görselde üstte görülen tiroid bezinin altındaki yapı hangisidir?', imageUrl: 'assets/images/lungs.png',
      options: ['Özofagus', 'Timus', 'Larinks', 'Tiroid kıkırdağı'],
      correctAnswer: 'Larinks', latinTerm: 'Larynx',
      explanation: 'Görselde tiroid bezinin üstündeki yapı larinks (gırtlak)tir. Ses üretimi ve hava yolunu koruma fonksiyonları vardır.'),

    // ============================================================
    // BÖBREK (Kidney.png) - Detaylı kesit
    // ============================================================
    Question(id: 'vis_k01', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'easy',
      questionText: 'Görseldeki organ hangisidir?', imageUrl: 'assets/images/Kidney.png',
      options: ['Dalak', 'Böbrek', 'Adrenal bez', 'Karaciğer'], correctAnswer: 'Böbrek', latinTerm: 'Ren',
      explanation: 'Böbrek (Ren), fasulye şeklinde, retroperitoneal alanda bulunan bir çift organdır.'),
    Question(id: 'vis_k02', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'medium',
      questionText: 'Görselde kırmızı damar (arter) ve mavi damar (ven) görülmektedir. Renal arter nereden dallanır?', imageUrl: 'assets/images/Kidney.png',
      options: ['Vena cava inferior', 'Aorta abdominalis', 'Arteria iliaca', 'Arteria mesenterica'],
      correctAnswer: 'Aorta abdominalis', latinTerm: 'Arteria renalis',
      explanation: 'Renal arter, abdominal aorttan doğrudan dallanır. Her böbreğe bir renal arter gider ve kalp debisinin yaklaşık %20-25\'ini alır.'),
    Question(id: 'vis_k03', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'hard',
      questionText: 'Görselde böbrek kesitinde görülen piramit şekilli yapılar hangi tabakadadır?', imageUrl: 'assets/images/Kidney.png',
      options: ['Korteks', 'Medulla', 'Pelvis', 'Kapsül'], correctAnswer: 'Medulla', latinTerm: 'Medulla renalis',
      explanation: 'Böbrek piramitleri medullada (iç tabaka) bulunur. Henle kulpları ve toplayıcı kanallar burada yer alır.'),

    // ============================================================
    // SİNDİRİM SİSTEMİ (Digestive.png) - Tam sistem
    // ============================================================
    Question(id: 'vis_d01', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'medium',
      questionText: 'Görseldeki sindirim sisteminde protein sindirimi ilk hangi organda başlar?', imageUrl: 'assets/images/Digestive.png',
      options: ['Ağız', 'Özofagus', 'Mide', 'İnce bağırsak'], correctAnswer: 'Mide', latinTerm: 'Ventriculus',
      explanation: 'Protein sindirimi midede pepsin enzimi ile başlar. HCl pepsinojeni aktif pepsine dönüştürür.'),
    Question(id: 'vis_d02', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'medium',
      questionText: 'Görselde yeşil ile gösterilen kalın bağırsağın ilk bölümünün adı nedir?', imageUrl: 'assets/images/Digestive.png',
      options: ['Sigmoid kolon', 'Çekum (sekum)', 'Transvers kolon', 'Rektum'],
      correctAnswer: 'Çekum (sekum)', latinTerm: 'Caecum',
      explanation: 'Çekum (sekum), kalın bağırsağın başlangıç bölümüdür. Apendiks vermiformis çekumdan çıkar.'),
    Question(id: 'vis_d03', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'hard',
      questionText: 'Görselde karaciğerin hemen altında görülen yeşilimsi küçük kese nedir?', imageUrl: 'assets/images/Digestive.png',
      options: ['Pankreas', 'Safra kesesi (vesica biliaris)', 'Dalak', 'Böbrek'],
      correctAnswer: 'Safra kesesi (vesica biliaris)', latinTerm: 'Vesica biliaris',
      explanation: 'Safra kesesi, karaciğerin alt yüzünde bulunan ve safrayı depolayan küçük kesedir. Yağ sindirimi için safrayı duodenuma boşaltır.'),

    // ============================================================
    // KARACİĞER (liver.png) - Numaralı yapılar (1-13)
    // ============================================================
    Question(id: 'vis_li01', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'easy',
      questionText: 'Görseldeki numaralı organ hangisidir?', imageUrl: 'assets/images/liver.png',
      options: ['Böbrek', 'Dalak', 'Karaciğer', 'Pankreas'], correctAnswer: 'Karaciğer', latinTerm: 'Hepar',
      explanation: 'Karaciğer (Hepar), yaklaşık 1.5 kg ağırlığıyla vücudun en büyük iç organıdır.'),
    Question(id: 'vis_li02', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'medium',
      questionText: 'Görselde 1 ve 2 numaralı ok ile gösterilen karaciğerin iki büyük lobu hangileridir?', imageUrl: 'assets/images/liver.png',
      options: ['Kuadat ve Kaudat lob', 'Sağ lob ve Sol lob', 'Anterior ve Posterior lob', 'Superior ve Inferior lob'],
      correctAnswer: 'Sağ lob ve Sol lob', latinTerm: 'Lobus dexter et sinister hepatis',
      explanation: 'Karaciğerin en büyük iki lobu sağ lob (lobus dexter - daha büyük) ve sol lobdur (lobus sinister). Ligamentum falciforme ile ayrılır.'),
    Question(id: 'vis_li03', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'hard',
      questionText: 'Görselde 7 numaralı ok ile gösterilen karaciğer altındaki koyu yapı nedir?', imageUrl: 'assets/images/liver.png',
      options: ['Dalak', 'Pankreas', 'Safra kesesi (vesica biliaris)', 'Böbrek'],
      correctAnswer: 'Safra kesesi (vesica biliaris)', latinTerm: 'Vesica biliaris',
      explanation: 'Safra kesesi, karaciğerin viseral yüzünde fossa vesicae biliaris içinde yer alır. Safrayı depolar ve konsantre eder.'),
    Question(id: 'vis_li04', category: 'anatomy', subcategory: 'organs', type: 'test', difficulty: 'hard',
      questionText: 'Görselde karaciğerin arka yüzünde (posterior view) vena cava inferior hangi numarayla gösterilmiştir?', imageUrl: 'assets/images/liver.png',
      options: ['3', '4', '8', '13'], correctAnswer: '13',
      explanation: 'Vena cava inferior (VCI), karaciğerin arka yüzünde sulcus venae cavae içinden geçer. Hepatik venler VCI\'ye dökülür.'),

    // ============================================================
    // BEYİN (Brain.png) - Renkli loblar
    // ============================================================
    Question(id: 'vis_b01', category: 'anatomy', subcategory: 'nervous_system', type: 'test', difficulty: 'medium',
      questionText: 'Görselde farklı renklerle gösterilen beyin loblarından frontal lob hangi fonksiyondan sorumludur?', imageUrl: 'assets/images/Brain.png',
      options: ['Görme', 'Kişilik, planlama, motor kontrol', 'İşitme', 'Denge'],
      correctAnswer: 'Kişilik, planlama, motor kontrol', latinTerm: 'Lobus frontalis',
      explanation: 'Frontal lob beynin en büyük lobüdür. Motor korteks, Broca alanı (konuşma), karar verme, planlama ve kişilik burada kontrol edilir.'),
    Question(id: 'vis_b02', category: 'anatomy', subcategory: 'nervous_system', type: 'test', difficulty: 'medium',
      questionText: 'Görselde pembe renkle gösterilen arka-alt bölge (beyincik) hangi fonksiyondan sorumludur?', imageUrl: 'assets/images/Brain.png',
      options: ['Görme', 'Konuşma', 'Denge ve koordinasyon', 'Hafıza'], correctAnswer: 'Denge ve koordinasyon', latinTerm: 'Cerebellum',
      explanation: 'Serebellum (beyincik), hareket koordinasyonu, denge ve motor öğrenmeden sorumludur.'),
    Question(id: 'vis_b03', category: 'anatomy', subcategory: 'nervous_system', type: 'test', difficulty: 'hard',
      questionText: 'Görselde sarı renkle gösterilen parietal lobda bulunan somatosensoriyel korteks ne algılar?', imageUrl: 'assets/images/Brain.png',
      options: ['Görme', 'İşitme', 'Dokunma, ağrı, ısı, basınç duyuları', 'Koku'],
      correctAnswer: 'Dokunma, ağrı, ısı, basınç duyuları', latinTerm: 'Lobus parietalis',
      explanation: 'Parietal lobdaki postsentral girusta somatosensoriyel korteks bulunur. Vücuttan gelen dokunma, ağrı, ısı ve propriosepsiyon duyularını işler.'),
    Question(id: 'vis_b04', category: 'anatomy', subcategory: 'nervous_system', type: 'test', difficulty: 'hard',
      questionText: 'Görselde yeşil renkle gösterilen temporal lobda bulunan Wernicke alanı ne ile ilgilidir?', imageUrl: 'assets/images/Brain.png',
      options: ['Motor kontrol', 'Dili anlama (konuşma algılama)', 'Görme', 'Denge'],
      correctAnswer: 'Dili anlama (konuşma algılama)', latinTerm: 'Lobus temporalis',
      explanation: 'Wernicke alanı sol temporal lobda bulunur ve konuşmayı anlamadan sorumludur. Hasarında akıcı ama anlamsız konuşma (Wernicke afazisi) görülür.'),

    // ============================================================
    // NÖRON (neuron.png) - Numaralı detaylı yapı
    // ============================================================
    Question(id: 'vis_n01', category: 'anatomy', subcategory: 'nervous_system', type: 'test', difficulty: 'medium',
      questionText: 'Görseldeki sinir hücresinde mavi uzun yapı nedir?', imageUrl: 'assets/images/neuron.png',
      options: ['Dendrit', 'Akson (miyelin kılıflı)', 'Soma', 'Sinaps'], correctAnswer: 'Akson (miyelin kılıflı)', latinTerm: 'Axon',
      explanation: 'Akson, sinir impulslarını hücre gövdesinden uzağa iletir. Mavi renkteki miyelin kılıfı (Schwann hücreleri) iletim hızını artırır.'),
    Question(id: 'vis_n02', category: 'anatomy', subcategory: 'nervous_system', type: 'test', difficulty: 'hard',
      questionText: 'Görselde 19 numaralı yapı (sinaptik vezikül) hangi maddeleri içerir?', imageUrl: 'assets/images/neuron.png',
      options: ['Kan hücreleri', 'Nörotransmitterler', 'Hormonlar', 'Antikorlar'],
      correctAnswer: 'Nörotransmitterler',
      explanation: 'Sinaptik veziküller, akson terminalinde nörotransmitter (asetilkolin, dopamin, serotonin vb.) depolayan küçük keseciklerdir.'),
    Question(id: 'vis_n03', category: 'anatomy', subcategory: 'nervous_system', type: 'test', difficulty: 'hard',
      questionText: 'Görselde akson üzerindeki 12 ve 20 numaralı yapılar miyelin kılıfını oluşturan hücrenin adı nedir?', imageUrl: 'assets/images/neuron.png',
      options: ['Astrosit', 'Oligodendrosit', 'Schwann hücresi', 'Mikroglia'],
      correctAnswer: 'Schwann hücresi', latinTerm: 'Cellula Schwanni',
      explanation: 'Periferik sinir sisteminde miyelin kılıfını Schwann hücreleri oluşturur. MSS\'de ise oligodendrositler bu görevi yapar.'),
    Question(id: 'vis_n04', category: 'physiology', subcategory: 'nervous', type: 'test', difficulty: 'hard',
      questionText: 'Görseldeki akson üzerinde miyelin kılıfının kesintiye uğradığı boğumların adı nedir?', imageUrl: 'assets/images/neuron.png',
      options: ['Sinaps', 'Ranvier boğumu', 'Nissl cisimciği', 'Bouton terminal'],
      correctAnswer: 'Ranvier boğumu', latinTerm: 'Nodus Ranvieri',
      explanation: 'Ranvier boğumları, miyelin kılıfının kesintiye uğradığı noktalardır. Saltatorik (sıçrayıcı) iletim buralarda gerçekleşerek iletim hızını artırır.'),

    // ============================================================
    // KAS SİSTEMİ (muscles.png) - Önden tam vücut
    // ============================================================
    Question(id: 'vis_m01', category: 'anatomy', subcategory: 'muscular_system', type: 'test', difficulty: 'easy',
      questionText: 'Görseldeki kas sisteminde göğüs bölgesindeki büyük yelpaze şekilli kas hangisidir?', imageUrl: 'assets/images/muscles.png',
      options: ['Deltoid', 'Pectoralis major', 'Trapezius', 'Serratus anterior'],
      correctAnswer: 'Pectoralis major', latinTerm: 'M. pectoralis major',
      explanation: 'Pectoralis major (büyük göğüs kası), göğüs ön duvarında bulunan büyük yelpaze şekilli kastır. Kol addüksiyonu ve iç rotasyonu yapar.'),
    Question(id: 'vis_m02', category: 'anatomy', subcategory: 'muscular_system', type: 'test', difficulty: 'medium',
      questionText: 'Görselde karın ön duvarında görülen "six-pack" kası hangisidir?', imageUrl: 'assets/images/muscles.png',
      options: ['Obliquus externus', 'Rectus abdominis', 'Transversus abdominis', 'Psoas major'],
      correctAnswer: 'Rectus abdominis', latinTerm: 'M. rectus abdominis',
      explanation: 'Rectus abdominis, karın ön duvarında bulunan ve tendinöz kesişmelerle bölümlere ayrılan kastır (six-pack). Gövdeyi öne eğer.'),
    Question(id: 'vis_m03', category: 'anatomy', subcategory: 'muscular_system', type: 'test', difficulty: 'medium',
      questionText: 'Görselde uyluğun ön tarafında görülen büyük kas grubu hangisidir?', imageUrl: 'assets/images/muscles.png',
      options: ['Hamstring', 'Quadriceps femoris', 'Adductor grup', 'Gluteal grup'],
      correctAnswer: 'Quadriceps femoris', latinTerm: 'M. quadriceps femoris',
      explanation: 'Quadriceps femoris, 4 başlı bir kastır (rectus femoris, vastus lateralis, medialis, intermedius). Dizin en güçlü ekstensörüdür.'),

    // ============================================================
    // BİCEPS (biceps.png) - Kırmızı ve yeşil başlar
    // ============================================================
    Question(id: 'vis_bi01', category: 'anatomy', subcategory: 'muscular_system', type: 'test', difficulty: 'medium',
      questionText: 'Görselde kırmızı ile gösterilen bicepsin uzun başı (caput longum) nereden başlar?', imageUrl: 'assets/images/biceps.png',
      options: ['Processus coracoideus', 'Tuberculum supraglenoidale (scapula)', 'Humerus başı', 'Acromion'],
      correctAnswer: 'Tuberculum supraglenoidale (scapula)', latinTerm: 'Caput longum m. bicipitis brachii',
      explanation: 'Bicepsin uzun başı (kırmızı), scapulanın tuberculum supraglenoidalesinden başlar ve glenohumeral eklem kapsülü içinden geçer.'),
    Question(id: 'vis_bi02', category: 'anatomy', subcategory: 'muscular_system', type: 'test', difficulty: 'medium',
      questionText: 'Görselde yeşil ile gösterilen bicepsin kısa başı (caput breve) nereden başlar?', imageUrl: 'assets/images/biceps.png',
      options: ['Tuberculum supraglenoidale', 'Processus coracoideus (scapula)', 'Acromion', 'Clavicula'],
      correctAnswer: 'Processus coracoideus (scapula)', latinTerm: 'Caput breve m. bicipitis brachii',
      explanation: 'Bicepsin kısa başı (yeşil), scapulanın processus coracoideusundan başlar. Coracobrachialis kası ile ortak origoya sahiptir.'),

    // ============================================================
    // DNA (DNApng.png) - Etiketli yapı
    // ============================================================
    Question(id: 'vis_dn01', category: 'pharmacology', subcategory: 'general', type: 'test', difficulty: 'medium',
      questionText: 'Görseldeki DNA yapısında Adenin hangi bazla eşleşir?', imageUrl: 'assets/images/DNApng.png',
      options: ['Guanin', 'Sitozin', 'Timin', 'Urasil'], correctAnswer: 'Timin',
      explanation: 'DNA\'da Adenin-Timin (A-T, 2 hidrojen bağı) ve Guanin-Sitozin (G-C, 3 hidrojen bağı) eşleşir. RNA\'da timin yerine urasil bulunur.'),
    Question(id: 'vis_dn02', category: 'pharmacology', subcategory: 'general', type: 'test', difficulty: 'hard',
      questionText: 'Görselde "Sugar Phosphate Backbone" olarak gösterilen yapı DNA\'nın hangi kısmıdır?', imageUrl: 'assets/images/DNApng.png',
      options: ['Bazlar', 'Şeker-fosfat omurgası (iskelet)', 'Hidrojen bağları', 'Histon proteinleri'],
      correctAnswer: 'Şeker-fosfat omurgası (iskelet)',
      explanation: 'DNA\'nın dış iskeleti deoksiriboz şekeri ve fosfat gruplarından oluşan şeker-fosfat omurgasıdır. Bazlar bu iskeletin iç kısmında eşleşir.'),
    Question(id: 'vis_dn03', category: 'pharmacology', subcategory: 'antibiotics', type: 'test', difficulty: 'hard',
      questionText: 'Görseldeki DNA replikasyonunu engelleyen antibiyotik grubu hangisidir?', imageUrl: 'assets/images/DNApng.png',
      options: ['Beta-laktamlar', 'Makrolidler', 'Florokinolonlar (DNA giraz inhibitörleri)', 'Aminoglikozidler'],
      correctAnswer: 'Florokinolonlar (DNA giraz inhibitörleri)',
      explanation: 'Florokinolonlar (siprofloksasin, levofloksasin), DNA giraz (topoizomeraz II) ve topoizomeraz IV enzimlerini inhibe ederek DNA replikasyonunu engeller.'),

    // ============================================================
    // MİTOZ (Mitosis.png) - Aşamalar
    // ============================================================
    Question(id: 'vis_mi01', category: 'pathology', subcategory: 'general', type: 'test', difficulty: 'medium',
      questionText: 'Görseldeki hücre bölünmesi aşamalarının doğru sırası nedir?', imageUrl: 'assets/images/Mitosis.png',
      options: ['Metafaz-Profaz-Anafaz-Telofaz', 'Profaz-Metafaz-Anafaz-Telofaz', 'Anafaz-Profaz-Telofaz-Metafaz', 'Telofaz-Anafaz-Metafaz-Profaz'],
      correctAnswer: 'Profaz-Metafaz-Anafaz-Telofaz',
      explanation: 'Mitoz bölünme sırayla: Profaz (kromatin yoğunlaşır), Metafaz (kromozomlar ortada dizilir), Anafaz (kardeş kromatidler ayrılır), Telofaz (çekirdek zarı oluşur).'),
    Question(id: 'vis_mi02', category: 'pathology', subcategory: 'general', type: 'test', difficulty: 'hard',
      questionText: 'Görseldeki mitoz bölünme kontrolsüz hale geldiğinde oluşan patolojik duruma ne denir?', imageUrl: 'assets/images/Mitosis.png',
      options: ['Apoptoz', 'Nekroz', 'Neoplazi', 'Atrofi'], correctAnswer: 'Neoplazi',
      explanation: 'Neoplazi, hücre bölünmesinin kontrolsüz hale gelmesidir. Tümör süpresör genlerin (p53, Rb) inaktivasyonu veya onkogenlerin aktivasyonu ile oluşur.'),

    // ============================================================
    // KAN HÜCRELERİ (blood cells.png) - Mikroskop görüntüsü
    // ============================================================
    Question(id: 'vis_bc01', category: 'pathology', subcategory: 'general', type: 'test', difficulty: 'medium',
      questionText: 'Görseldeki mikroskop görüntüsünde görülen çift konkav disk şeklindeki hücreler hangisidir?', imageUrl: 'assets/images/blood cells.png',
      options: ['Lökositler', 'Trombositler', 'Eritrositler', 'Makrofajlar'],
      correctAnswer: 'Eritrositler', latinTerm: 'Erythrocytus',
      explanation: 'Eritrositler (kırmızı kan hücreleri), çift konkav disk şeklinde, çekirdeksiz hücrelerdir. Hemoglobin içererek oksijen taşır.'),
    Question(id: 'vis_bc02', category: 'physiology', subcategory: 'cardiovascular', type: 'test', difficulty: 'hard',
      questionText: 'Görseldeki eritrositlerin ortasındaki soluk bölge (merkezi solgunluk) neyi gösterir?', imageUrl: 'assets/images/blood cells.png',
      options: ['Çekirdek', 'Çift konkav şekilden dolayı ince merkez', 'Hemoglobin eksikliği', 'Parazit enfeksiyonu'],
      correctAnswer: 'Çift konkav şekilden dolayı ince merkez',
      explanation: 'Eritrositler bikonkav (çift çukur) disk şeklindedir. Ortaları ince olduğu için ışık daha fazla geçer ve soluk görünür. Normal merkezi solgunluk çapın 1/3\'üdür.'),
    Question(id: 'vis_bc03', category: 'physiology', subcategory: 'cardiovascular', type: 'test', difficulty: 'hard',
      questionText: 'Görseldeki eritrositlerin ömrü yaklaşık kaç gündür ve nerede yıkılırlar?', imageUrl: 'assets/images/blood cells.png',
      options: ['30 gün - Karaciğer', '60 gün - Böbrek', '120 gün - Dalak', '180 gün - Kemik iliği'],
      correctAnswer: '120 gün - Dalak',
      explanation: 'Eritrositlerin ortalama ömrü 120 gündür. Yaşlanan eritrositler dalakta (ve kısmen karaciğerde) yıkılır. Hemoglobin bilirubin ve demire ayrılır.'),
  ];
}
