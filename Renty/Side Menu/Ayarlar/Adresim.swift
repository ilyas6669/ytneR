//
//  Adresim.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/18/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase

class Adresim: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    let pickerView = UIPickerView()
    var countries = [Country]()
    var city = ""
    var country = ""
    
    let lblKonum : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.text = "Konum"
        lbl.textColor = .rgb(red: 0, green: 38, blue: 26)
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        return lbl
    }()
    
    var activityIndicator : UIActivityIndicatorView = {
       var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layoutDuzenle()
        pickerView.delegate = self
        pickerView.dataSource = self
        countriesAppend()
        


        let logo = UIImage(named: "Adresim")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    
    
    func layoutDuzenle() {
        view.addSubview(lblKonum)
        view.addSubview(pickerView)
        view.addSubview(activityIndicator)
        
        
        _ = pickerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        _ = lblKonum.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 5, left: 30, bottom: 0, right: 30))
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
     
        
        
        
    }
    
    
    
    
    @IBAction func btnLeft(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnOkey(_ sender: Any) {
          self.activityIndicator.startAnimating()
        var firebaseusermap = [String : Any]()
        
        let userID = Auth.auth().currentUser!.uid
        
        firebaseusermap["sehir"] = "\(country)"
        firebaseusermap["il"] = "\(city)"
        
        let ref = Database.database().reference()
        ref.child("user").child(userID).updateChildValues(firebaseusermap)
        { (err, resp) in
            guard err == nil else {
                print("Posting failed : ")
                return
            }
            self.activityIndicator.stopAnimating()
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabbBar") as! TabbBarr
        vc.selectedIndex = 0
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    func countriesAppend() {
        countries.append(Country(country: "İstanbul", cities: ["Adalar", "Bakırköy", "Beşiktaş", "Beykoz", "Beyoğlu", "Çatalca", "Eyüp", "Fatih", "Gaziosmanpaşa", "Kadıköy", "Kartal", "Sarıyer", "Silivri", "Şile", "Şişli", "Üsküdar", "Zeytinburnu", "Büyükçekmece", "Kağıthane", "Küçükçekmece", "Pendik", "Ümraniye", "Bayrampaşa", "Avcılar", "Bağcılar", "Bahçelievler", "Güngören", "Maltepe", "Sultanbeyli", "Tuzla", "Esenler", "Arnavutköy", "Ataşehir", "Başakşehir", "Beylikdüzü", "Çekmeköy", "Esenyurt", "Sancaktepe", "Sultangazi"]))
        countries.append(Country(country: "Ankara", cities: ["Altındağ", "Ayaş", "Bala", "Beypazarı", "Çamlıdere", "Çankaya", "Çubuk", "Elmadağ", "Güdül", "Haymana", "Kalecik", "Kızılcahamam", "Nallıhan", "Polatlı", "Şereflikoçhisar", "Yenimahalle", "Gölbaşı", "Keçiören", "Mamak", "Sincan", "Kazan", "Akyurt", "Etimesgut", "Evren", "Pursaklar"]))
        countries.append(Country(country: "İzmir", cities: ["Aliağa", "Bayındır", "Bergama", "Bornova", "Çeşme", "Dikili", "Foça", "Karaburun", "Karşıyaka", "Kemalpaşa", "Kınık", "Kiraz", "Menemen", "Ödemiş", "Seferihisar", "Selçuk", "Tire", "Torbalı", "Urla", "Beydağ", "Buca", "Konak", "Menderes", "Balçova", "Çiğli", "Gaziemir", "Narlıdere", "Güzelbahçe", "Bayraklı", "Karabağlar"]))
        countries.append(Country(country: "Adana", cities: ["Aladağ", "Ceyhan", "Çukurova", "Feke", "İmamoğlu", "Karaisalı", "Karataş", "Kozan", "Pozantı", "Saimbeyli", "Sarıçam", "Seyhan", "Tufanbeyli", "Yumurtalık", "Yüreğir"]))
        countries.append(Country(country:  "Adıyaman", cities: ["Besni", "Çelikhan", "Gerger", "Gölbaşı", "Kahta", "Merkez", "Samsat", "Sincik", "Tut"]))
        countries.append(Country(country: "Afyonkarahisar", cities: ["Başmakçı", "Bayat", "Bolvadin", "Çay", "Çobanlar", "Dazkırı", "Dinar", "Emirdağ", "Evciler", "Hocalar", "İhsaniye", "İscehisar", "Kızılören", "Merkez", "Sandıklı", "Sinanpaşa", "Sultandağı", "Şuhut"]))
        countries.append(Country(country: "Ağrı", cities: ["Diyadin", "Doğubayazıt", "Eleşkirt", "Hamur", "Merkez", "Patnos", "Taşlıçay", "Tutak"]))
        countries.append(Country(country: "Aksaray", cities:  ["Ağaçören", "Eskil", "Gülağaç", "Güzelyurt", "Merkez", "Ortaköy", "Sarıyahşi"]))
        countries.append(Country(country: "Amasya", cities: ["Göynücek", "Gümüşhacıköy", "Hamamözü", "Merkez", "Merzifon", "Suluova", "Taşova"]))
        countries.append(Country(country: "Antalya", cities: ["Akseki", "Alanya", "Elmalı", "Finike", "Gazipaşa", "Gündoğmuş", "Kaş", "Korkuteli", "Kumluca", "Manavgat", "Serik", "Demre", "İbradı", "Kemer", "Aksu", "Döşemealtı", "Kepez", "Konyaaltı", "Muratpaşa"]))
        countries.append(Country(country: "Ardahan", cities: ["Merkez", "Çıldır", "Göle", "Hanak", "Posof", "Damal"]))
        countries.append(Country(country: "Artvin", cities: ["Ardanuç", "Arhavi", "Merkez", "Borçka", "Hopa", "Şavşat", "Yusufeli", "Murgul"]))
        countries.append(Country(country: "Aydın", cities: ["Merkez", "Bozdoğan", "Efeler", "Çine", "Germencik", "Karacasu", "Koçarlı", "Kuşadası", "Kuyucak", "Nazilli", "Söke", "Sultanhisar", "Yenipazar", "Buharkent", "İncirliova", "Karpuzlu", "Köşk", "Didim"]))
        countries.append(Country(country: "Balıkesir", cities: ["Altıeylül", "Ayvalık", "Merkez", "Balya", "Bandırma", "Bigadiç", "Burhaniye", "Dursunbey", "Edremit", "Erdek", "Gönen", "Havran", "İvrindi", "Karesi", "Kepsut", "Manyas", "Savaştepe", "Sındırgı", "Gömeç", "Susurluk", "Marmara"]))
        countries.append(Country(country: "Bartın", cities: ["Merkez", "Kurucaşile", "Ulus", "Amasra"]))
        countries.append(Country(country: "Batman", cities: ["Merkez", "Beşiri", "Gercüş", "Kozluk", "Sason", "Hasankeyf"]))
        countries.append(Country(country: "Bayburt", cities: ["Merkez", "Aydıntepe", "Demirözü"]))
        countries.append(Country(country: "Bilecik", cities: ["Merkez", "Bozüyük", "Gölpazarı", "Osmaneli", "Pazaryeri", "Söğüt", "Yenipazar", "İnhisar"]))
        countries.append(Country(country:  "Bingöl", cities: ["Merkez", "Genç", "Karlıova", "Kiğı", "Solhan", "Adaklı", "Yayladere", "Yedisu"]))
        countries.append(Country(country: "Bitlis", cities: ["Adilcevaz", "Ahlat", "Merkez", "Hizan", "Mutki", "Tatvan", "Güroymak"]))
        countries.append(Country(country: "Bolu", cities: ["Merkez", "Gerede", "Göynük", "Kıbrıscık", "Mengen", "Mudurnu", "Seben", "Dörtdivan", "Yeniçağa"]))
        countries.append(Country(country: "Burdur", cities: ["Ağlasun", "Bucak", "Merkez", "Gölhisar", "Tefenni", "Yeşilova", "Karamanlı", "Kemer", "Altınyayla", "Çavdır", "Çeltikçi"]))
        countries.append(Country(country: "Bursa", cities: ["Gemlik", "İnegöl", "İznik", "Karacabey", "Keles", "Mudanya", "Mustafakemalpaşa", "Orhaneli", "Orhangazi", "Yenişehir", "Büyükorhan", "Harmancık", "Nilüfer", "Osmangazi", "Yıldırım", "Gürsu", "Kestel"]))
        countries.append(Country(country: "Çanakkale", cities: ["Ayvacık", "Bayramiç", "Biga", "Bozcaada", "Çan", "Merkez", "Eceabat", "Ezine", "Gelibolu", "Gökçeada", "Lapseki", "Yenice"]))
        countries.append(Country(country: "Çankırı", cities: ["Merkez", "Çerkeş", "Eldivan", "Ilgaz", "Kurşunlu", "Orta", "Şabanözü", "Yapraklı", "Atkaracalar", "Kızılırmak", "Bayramören", "Korgun"]))
        countries.append(Country(country:  "Çorum", cities: ["Alaca", "Bayat", "Merkez", "İskilip", "Kargı", "Mecitözü", "Ortaköy", "Osmancık", "Sungurlu", "Boğazkale", "Uğurludağ", "Dodurga", "Laçin", "Oğuzlar"]))
        countries.append(Country(country: "Denizli", cities: ["Acıpayam", "Buldan", "Çal", "Çameli", "Çardak", "Çivril", "Merkez", "Merkezefendi", "Pamukkale", "Güney", "Kale", "Sarayköy", "Tavas", "Babadağ", "Bekilli", "Honaz", "Serinhisar", "Baklan", "Beyağaç", "Bozkurt"]))
        countries.append(Country(country: "Diyarbakır", cities: ["Kocaköy", "Çermik", "Çınar", "Çüngüş", "Dicle", "Ergani", "Hani", "Hazro", "Kulp", "Lice", "Silvan", "Eğil", "Bağlar", "Kayapınar", "Sur", "Yenişehir", "Bismil"]))
        countries.append(Country(country: "Düzce", cities: ["Akçakoca", "Merkez", "Yığılca", "Cumayeri", "Gölyaka", "Çilimli", "Gümüşova", "Kaynaşlı"]))
        countries.append(Country(country: "Edirne", cities: ["Merkez", "Enez", "Havsa", "İpsala", "Keşan", "Lalapaşa", "Meriç", "Uzunköprü", "Süloğlu"]))
        countries.append(Country(country: "Elazığ", cities: ["Ağın", "Baskil", "Merkez", "Karakoçan", "Keban", "Maden", "Palu", "Sivrice", "Arıcak", "Kovancılar", "Alacakaya"]))
        countries.append(Country(country: "Erzincan", cities: ["Çayırlı", "Merkez", "İliç", "Kemah", "Kemaliye", "Refahiye", "Tercan", "Üzümlü", "Otlukbeli"]))
        countries.append(Country(country: "Erzurum", cities: ["Aşkale", "Çat", "Hınıs", "Horasan", "İspir", "Karayazı", "Narman", "Oltu", "Olur", "Pasinler", "Şenkaya", "Tekman", "Tortum", "Karaçoban", "Uzundere", "Pazaryolu", "Köprüköy", "Palandöken", "Yakutiye", "Aziziye"]))
        countries.append(Country(country: "Eskişehir", cities: ["Çifteler", "Mahmudiye", "Mihalıççık", "Sarıcakaya", "Seyitgazi", "Sivrihisar", "Alpu", "Beylikova", "İnönü", "Günyüzü", "Han", "Mihalgazi", "Odunpazarı", "Tepebaşı"]))
        countries.append(Country(country: "Gaziantep", cities: ["Araban", "İslahiye", "Nizip", "Oğuzeli", "Yavuzeli", "Şahinbey", "Şehitkamil", "Karkamış", "Nurdağı"]))
        countries.append(Country(country: "Giresun", cities: ["Alucra", "Bulancak", "Dereli", "Espiye", "Eynesil", "Merkez", "Görele", "Keşap", "Şebinkarahisar", "Tirebolu", "Piraziz", "Yağlıdere", "Çamoluk", "Çanakçı", "Doğankent", "Güce"]))
        countries.append(Country(country: "Gümüşhane", cities: ["Merkez", "Kelkit", "Şiran", "Torul", "Köse", "Kürtün"]))
        countries.append(Country(country: "Hakkari", cities: ["Çukurca", "Merkez", "Şemdinli", "Yüksekova"]))
        countries.append(Country(country: "Hatay", cities: ["Altınözü", "Arsuz", "Defne", "Dörtyol", "Hassa", "Antakya", "İskenderun", "Kırıkhan", "Payas", "Reyhanlı", "Samandağ", "Yayladağı", "Erzin", "Belen", "Kumlu"]))
        countries.append(Country(country: "Iğdır", cities: ["Aralık", "Merkez", "Tuzluca", "Karakoyunlu"]))
        countries.append(Country(country: "Isparta", cities: ["Atabey", "Eğirdir", "Gelendost", "Merkez", "Keçiborlu", "Senirkent", "Sütçüler", "Şarkikaraağaç", "Uluborlu", "Yalvaç", "Aksu", "Gönen", "Yenişarbademli"]))
        countries.append(Country(country: "Kahramanmaraş", cities: ["Afşin", "Andırın", "Dulkadiroğlu", "Onikişubat", "Elbistan", "Göksun", "Merkez", "Pazarcık", "Türkoğlu", "Çağlayancerit", "Ekinözü", "Nurhak"]))
        countries.append(Country(country: "Karabük", cities: ["Eflani", "Eskipazar", "Merkez", "Ovacık", "Safranbolu", "Yenice"]))
        countries.append(Country(country: "Karaman", cities: ["Ermenek", "Merkez", "Ayrancı", "Kazımkarabekir", "Başyayla", "Sarıveliler"]))
        countries.append(Country(country: "Kars", cities: ["Arpaçay", "Digor", "Kağızman", "Merkez", "Sarıkamış", "Selim", "Susuz", "Akyaka"]))
        countries.append(Country(country: "Kastamonu", cities: ["Abana", "Araç", "Azdavay", "Bozkurt", "Cide", "Çatalzeytin", "Daday", "Devrekani", "İnebolu", "Merkez", "Küre", "Taşköprü", "Tosya", "İhsangazi", "Pınarbaşı", "Şenpazar", "Ağlı", "Doğanyurt", "Hanönü", "Seydiler"]))
        countries.append(Country(country: "Kayseri", cities: ["Bünyan", "Develi", "Felahiye", "İncesu", "Pınarbaşı", "Sarıoğlan", "Sarız", "Tomarza", "Yahyalı", "Yeşilhisar", "Akkışla", "Talas", "Kocasinan", "Melikgazi", "Hacılar", "Özvatan"]))
        countries.append(Country(country: "Kırıkkale", cities: [ "Delice", "Keskin", "Merkez", "Sulakyurt", "Bahşili", "Balışeyh", "Çelebi", "Karakeçili", "Yahşihan"]))
        countries.append(Country(country: "Kırklareli", cities: [  "Babaeski", "Demirköy", "Merkez", "Kofçaz", "Lüleburgaz", "Pehlivanköy", "Pınarhisar", "Vize"]))
        countries.append(Country(country: "Kırşehir", cities: ["Çiçekdağı", "Kaman", "Merkez", "Mucur", "Akpınar", "Akçakent", "Boztepe"]))
        countries.append(Country(country: "Kilis", cities: ["Merkez", "Elbeyli", "Musabeyli", "Polateli"]))
        countries.append(Country(country:  "Kocaeli", cities: ["Gebze", "Gölcük", "Kandıra", "Karamürsel", "Körfez", "Derince", "Başiskele", "Çayırova", "Darıca", "Dilovası", "İzmit", "Kartepe"]))
        countries.append(Country(country: "Konya", cities: ["Akşehir", "Beyşehir", "Bozkır", "Cihanbeyli", "Çumra", "Doğanhisar", "Ereğli", "Hadim", "Ilgın", "Kadınhanı", "Karapınar", "Kulu", "Sarayönü", "Seydişehir", "Yunak", "Akören", "Altınekin", "Derebucak", "Hüyük", "Karatay", "Meram", "Selçuklu", "Taşkent", "Ahırlı", "Çeltik", "Derbent", "Emirgazi", "Güneysınır", "Halkapınar", "Tuzlukçu", "Yalıhüyük"]))
        countries.append(Country(country: "Malatya", cities: ["Altıntaş", "Domaniç", "Emet", "Gediz", "Merkez", "Simav", "Tavşanlı", "Aslanapa", "Dumlupınar", "Hisarcık", "Şaphane", "Çavdarhisar", "Pazarlar"]))
        countries.append(Country(country: "Manisa", cities: ["Akhisar", "Alaşehir", "Demirci", "Gördes", "Kırkağaç", "Kula", "Merkez", "Salihli", "Sarıgöl", "Saruhanlı", "Selendi", "Soma", "Şehzadeler", "Yunusemre", "Turgutlu", "Ahmetli", "Gölmarmara", "Köprübaşı"]))
        countries.append(Country(country: "Mardin", cities: ["Derik", "Kızıltepe", "Artuklu", "Merkez", "Mazıdağı", "Midyat", "Nusaybin", "Ömerli", "Savur", "Dargeçit", "Yeşilli"]))
        countries.append(Country(country: "Mersin", cities: ["Anamur", "Erdemli", "Gülnar", "Mut", "Silifke", "Tarsus", "Aydıncık", "Bozyazı", "Çamlıyayla", "Akdeniz", "Mezitli", "Toroslar", "Yenişehir"]))
        countries.append(Country(country: "Muğla", cities: ["Bodrum", "Datça", "Fethiye", "Köyceğiz", "Marmaris", "Menteşe", "Milas", "Ula", "Yatağan", "Dalaman", "Seydikemer", "Ortaca", "Kavaklıdere"]))
        countries.append(Country(country: "Muş", cities: ["Bulanık", "Malazgirt", "Merkez", "Varto", "Hasköy", "Korkut"]))
        countries.append(Country(country: "Nevşehir", cities: ["Avanos", "Derinkuyu", "Gülşehir", "Hacıbektaş", "Kozaklı", "Merkez", "Ürgüp", "Acıgöl"]))
        countries.append(Country(country: "Niğde", cities: ["Bor", "Çamardı", "Merkez", "Ulukışla", "Altunhisar", "Çiftlik"]))
        countries.append(Country(country: "Ordu", cities: ["Akkuş", "Altınordu", "Aybastı", "Fatsa", "Gölköy", "Korgan", "Kumru", "Mesudiye", "Perşembe", "Ulubey", "Ünye", "Gülyalı", "Gürgentepe", "Çamaş", "Çatalpınar", "Çaybaşı", "İkizce", "Kabadüz", "Kabataş"]))
        countries.append(Country(country: "Osmaniye", cities: ["Bahçe", "Kadirli", "Merkez", "Düziçi", "Hasanbeyli", "Sumbas", "Toprakkale"]))
        countries.append(Country(country: "Rize", cities: ["Ardeşen", "Çamlıhemşin", "Çayeli", "Fındıklı", "İkizdere", "Kalkandere", "Pazar", "Merkez", "Güneysu", "Derepazarı", "Hemşin", "İyidere"]))
        countries.append(Country(country: "Sakarya", cities: ["Akyazı", "Geyve", "Hendek", "Karasu", "Kaynarca", "Sapanca", "Kocaali", "Pamukova", "Taraklı", "Ferizli", "Karapürçek", "Söğütlü", "Adapazarı", "Arifiye", "Erenler", "Serdivan"]))
        countries.append(Country(country: "Samsun", cities: ["Alaçam", "Bafra", "Çarşamba", "Havza", "Kavak", "Ladik", "Terme", "Vezirköprü", "Asarcık", "Ondokuzmayıs", "Salıpazarı", "Tekkeköy", "Ayvacık", "Yakakent", "Atakum", "Canik", "İlkadım"]))
        countries.append(Country(country: "Siirt", cities: ["Baykan", "Eruh", "Kurtalan", "Pervari", "Merkez", "Şirvan", "Tillo"]))
        countries.append(Country(country: "Sinop", cities: ["Ayancık", "Boyabat", "Durağan", "Erfelek", "Gerze", "Merkez", "Türkeli", "Dikmen", "Saraydüzü"]))
        countries.append(Country(country: "Sivas", cities: ["Divriği", "Gemerek", "Gürün", "Hafik", "İmranlı", "Kangal", "Koyulhisar", "Merkez", "Suşehri", "Şarkışla", "Yıldızeli", "Zara", "Akıncılar", "Altınyayla", "Doğanşar", "Gölova", "Ulaş"]))
        countries.append(Country(country: "Şırnak", cities: ["Beytüşşebap", "Cizre", "İdil", "Silopi", "Merkez", "Uludere", "Güçlükonak"]))
        countries.append(Country(country: "Tekirdağ", cities: [ "Çerkezköy", "Çorlu", "Ergene", "Hayrabolu", "Malkara", "Muratlı", "Saray", "Süleymanpaşa", "Kapaklı", "Şarköy", "Marmaraereğlisi"]))
        countries.append(Country(country: "Tokat", cities: [ "Almus", "Artova", "Erbaa", "Niksar", "Reşadiye", "Merkez", "Turhal", "Zile", "Pazar", "Yeşilyurt", "Başçiftlik", "Sulusaray"]))
        countries.append(Country(country: "Trabzon", cities: ["Akçaabat", "Araklı", "Arsin", "Çaykara", "Maçka", "Of", "Ortahisar", "Sürmene", "Tonya", "Vakfıkebir", "Yomra", "Beşikdüzü", "Şalpazarı", "Çarşıbaşı", "Dernekpazarı", "Düzköy", "Hayrat", "Köprübaşı"]))
        countries.append(Country(country: "Tunceli", cities: ["Çemişgezek", "Hozat", "Mazgirt", "Nazımiye", "Ovacık", "Pertek", "Pülümür", "Merkez"]))
        countries.append(Country(country: "Şanlıurfa", cities: ["Akçakale", "Birecik", "Bozova", "Ceylanpınar", "Eyyübiye", "Halfeti", "Haliliye", "Hilvan", "Karaköprü", "Siverek", "Suruç", "Viranşehir", "Harran"]))
        countries.append(Country(country: "Uşak", cities: ["Banaz", "Eşme", "Karahallı", "Sivaslı", "Ulubey", "Merkez"]))
        countries.append(Country(country:  "Van", cities: ["Başkale", "Çatak", "Erciş", "Gevaş", "Gürpınar", "İpekyolu", "Muradiye", "Özalp", "Tuşba", "Bahçesaray", "Çaldıran", "Edremit", "Saray"]))
        countries.append(Country(country: "Yalova", cities: [ "Merkez", "Altınova", "Armutlu", "Çınarcık", "Çiftlikköy", "Termal"]))
        countries.append(Country(country: "Yozgat", cities: ["Akdağmadeni", "Boğazlıyan", "Çayıralan", "Çekerek", "Sarıkaya", "Sorgun", "Şefaatli", "Yerköy", "Merkez", "Aydıncık", "Çandır", "Kadışehri", "Saraykent", "Yenifakılı"]))
        countries.append(Country(country:  "Zonguldak", cities: ["Çaycuma", "Devrek", "Ereğli", "Merkez", "Alaplı", "Gökçebey"]))
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return countries.count
        }else{
            let selectedCountry = pickerView.selectedRow(inComponent: 0)
            return countries[selectedCountry].cities.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return countries[row].country
        }else{
            let selectedCountry = pickerView.selectedRow(inComponent: 0)
            return countries[selectedCountry].cities[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadComponent(1)
        
        let selectedConutry = pickerView.selectedRow(inComponent: 0)
        let selectedCity = pickerView.selectedRow(inComponent: 1)
        country = countries[selectedConutry].country
        city = countries[selectedConutry].cities[selectedCity]
        

        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributedString: NSAttributedString!
        
        if component == 0 {
            attributedString = NSAttributedString(string: countries[row].country, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
            
        }else{
            let selectedCountry = pickerView.selectedRow(inComponent: 0)
            attributedString = NSAttributedString(string: countries[selectedCountry].cities[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
            
            
        }
        
        return attributedString
    }
   

}
