CREATE DATABASE meta_land;
use meta_land;

-- Kullanicilar tablosu
CREATE TABLE Kullanicilar (
  KullaniciNo INT PRIMARY KEY,
  KullaniciAdi VARCHAR(255),
  KullaniciSoyadi VARCHAR(255),
  KullaniciSifresi VARCHAR(255)
);

-- Alanlar tablosu
CREATE TABLE Alanlar (
  AlanNo INT PRIMARY KEY,
  AlanTuru VARCHAR(255),
  AlanSahibi VARCHAR(255)
);

-- Isletmeler tablosu
CREATE TABLE Isletmeler (
  IsletmeTuru VARCHAR(255) PRIMARY KEY,
  YoneticiIsletmeUcreti DECIMAL(10,2),
  KullaniciIsletmeUcreti DECIMAL(10,2)
);

-- KullaniciCalismalari tablosu
CREATE TABLE KullaniciCalismalari (
  KullaniciNo INT,
  KullaniciCalismaBaslangicTarihi DATE,
  KullaniciCalismaBitisTarihi DATE,
  KullaniciCalismaGunSayisi INT,
  KullaniciCalismaSaatleri VARCHAR(255),
  PRIMARY KEY (KullaniciNo, KullaniciCalismaBaslangicTarihi),
  FOREIGN KEY (KullaniciNo) REFERENCES Kullanicilar(KullaniciNo)
);

-- IsletmeBilgileri tablosu
CREATE TABLE IsletmeBilgileri (
  IsletmeTuru VARCHAR(255),
  IsletmeSeviyesi INT,
  IsletmeKapasitesi INT,
  IsletmeCalisanSayisi INT,
  IsletmeSabitGelirMiktari DECIMAL(10,2),
  IsletmeSabitGelirOrani DECIMAL(5,2),
  PRIMARY KEY (IsletmeTuru),
  FOREIGN KEY (IsletmeTuru) REFERENCES Isletmeler(IsletmeTuru)
);

-- MarketBilgileri tablosu
CREATE TABLE MarketBilgileri (
  IsletmeTuru VARCHAR(255),
  MarketYiyecekUcreti DECIMAL(10,2),
  PRIMARY KEY (IsletmeTuru),
  FOREIGN KEY (IsletmeTuru) REFERENCES Isletmeler(IsletmeTuru)
);

-- MagazaBilgileri tablosu
CREATE TABLE MagazaBilgileri (
  IsletmeTuru VARCHAR(255),
  MagazaEsyaUcreti DECIMAL(10,2),
  PRIMARY KEY (IsletmeTuru),
  FOREIGN KEY (IsletmeTuru) REFERENCES Isletmeler(IsletmeTuru)
);

-- IsletmeFiyatlari tablosu
CREATE TABLE IsletmeFiyatlari (
  IsletmeTuru VARCHAR(255),
  IsletmeFiyati DECIMAL(10,2),
  KiralikIsletmeFiyati DECIMAL(10,2),
  PRIMARY KEY (IsletmeTuru),
  FOREIGN KEY (IsletmeTuru) REFERENCES Isletmeler(IsletmeTuru)
);

-- EmlakBilgileri tablosu
CREATE TABLE EmlakBilgileri (
  AlanTuru INT,
  EmlakKomisyonu DECIMAL(10,2),
  EmlakIslemi VARCHAR(255),
  KiralamaTarihi DATE,
  KiraBitisTarihi DATE,
  IslemYapilanEmlak INT,
  PRIMARY KEY (AlanTuru),
  FOREIGN KEY (AlanTuru) REFERENCES Alanlar(AlanNo)
);

