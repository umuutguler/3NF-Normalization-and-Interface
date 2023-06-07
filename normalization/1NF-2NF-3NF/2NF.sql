CREATE DATABASE meta_land_2NF;
use meta_land_2NF;

CREATE TABLE OyunAlan (
    AlanNo INT PRIMARY KEY,
    AlanTuru VARCHAR(255),
    AlanSahibi VARCHAR(255),
    GunlukYiyecekGideri DECIMAL(10, 2),
    GunlukEsyaGideri DECIMAL(10, 2),
    GunlukParaGideri DECIMAL(10, 2),
    IsletmeTuru VARCHAR(255),
    YoneticiIsletmeUcreti DECIMAL(10, 2),
    KullaniciIsletmeUcreti DECIMAL(10, 2),
    IsletmeSeviyesi INT,
    IsletmeKapasitesi INT,
    IsletmeCalisanSayisi INT,
    MarketYiyecekUcreti DECIMAL(10, 2),
    MagazaEsyaUcreti DECIMAL(10, 2),
    IsletmeFiyati DECIMAL(10, 2),
    KiralikIsletmeFiyati DECIMAL(10, 2),
    EmlakKomisyonu DECIMAL(10, 2),
    EmlakIslemi VARCHAR(255),
    KiraSure INT,
    SatisTarihi DATE,
    KiralamaTarihi DATE,
    KiraBitisTarihi DATE,
    IslemYapilanEmlak VARCHAR(255),
    IsletmeSabitGelirMiktari DECIMAL(10, 2),
    IsletmeSabitGelirOrani DECIMAL(5, 2),
    IsletmeMevcutSeviyeBaslangicTarihi DATE
);

CREATE TABLE Kullanici (
    KullaniciNo INT PRIMARY KEY,
    KullaniciAdi VARCHAR(255),
    KullaniciSoyadi VARCHAR(255),
    KullaniciSifresi VARCHAR(255),
    KullaniciYemekMiktari INT,
    KullaniciEsyaMiktari INT,
    KullaniciParaMiktari DECIMAL(10, 2),
    BaslangicYemekMiktari INT,
    BaslangicEsyaMiktari INT,
    BaslangicParaMiktari DECIMAL(10, 2),
    OyunBaslangicTarihi DATE,
    AlanNo INT,
    KullaniciCalismaBaslangicTarihi DATE,
    KullaniciCalismaBitisTarihi DATE,
    KullaniciCalismaGunSayisi INT,
    KullaniciCalismaSaatleri VARCHAR(255),
    FOREIGN KEY (AlanNo) REFERENCES OyunAlan(AlanNo)
);
