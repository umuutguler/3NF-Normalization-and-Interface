import tkinter as tk
import mysql.connector
from tkinter import messagebox

# MySQL veritabanı bağlantısı
db = mysql.connector.connect(
    host="localhost",
    port=3306,
    user="root",
    password="ug12345",
    database="meta_land"
)
# MySQL veritabanı bağlantısı için cursor oluşturma
cursor = db.cursor()

def validate_login():
    username = username_entry.get()
    surname = surname_entry.get()
    password = password_entry.get()

    if username == "admin" and surname == "admin" and password == "admin":
        show_admin_screen()
    else:
        # Kullanıcı adı, soyadı ve şifreyle giriş kontrolü
        query = "SELECT * FROM kullanicilar WHERE KullaniciAdi = %s AND KullaniciSoyadi = %s AND KullaniciSifresi = %s"
        values = (username, surname, password)
        cursor.execute(query, values)
        result = cursor.fetchone()

        if result:
            messagebox.showinfo("Başarılı", "Giriş yapıldı.")
            show_main_screen()
        else:
            messagebox.showerror("Hata", "Geçersiz kullanıcı adı, soyadı veya şifre.")


def register():
    username = username_entry.get()
    surname = surname_entry.get()
    password = password_entry.get()

    # KullaniciNo değerini son satırdaki değerin bir fazlası olarak belirleme
    query = "SELECT KullaniciNo FROM kullanicilar ORDER BY KullaniciNo DESC LIMIT 1"
    cursor.execute(query)
    last_user_no = cursor.fetchone()
    user_no = 1 if last_user_no is None else last_user_no[0] + 1

    # Yeni kullanıcıyı veritabanına ekleme
    query = "INSERT INTO kullanicilar (KullaniciNo, KullaniciAdi, KullaniciSoyadi, KullaniciSifresi) VALUES (%s, %s, %s, %s)"
    values = (user_no, username, surname, password)
    cursor.execute(query, values)
    db.commit()

    messagebox.showinfo("Başarılı", "Kaydolma işlemi başarıyla tamamlandı.")

def show_main_screen():
    login_screen.destroy()

    main_screen = tk.Tk()
    main_screen.title("Ana Ekran")
    main_screen.geometry("100x100")

    def logout():
        main_screen.destroy()
        show_login_screen()

    logout_button = tk.Button(main_screen, text="Çıkış Yap", command=logout)
    logout_button.pack()

    main_screen.mainloop()

def show_login_screen():
    global username_entry, surname_entry, password_entry, login_screen
    login_screen = tk.Tk()
    login_screen.title("Giriş Ekranı")

    username_label = tk.Label(login_screen, text="Kullanıcı Adı:")
    username_label.pack()

    username_entry = tk.Entry(login_screen)
    username_entry.pack()

    surname_label = tk.Label(login_screen, text="Kullanıcı Soyadı:")
    surname_label.pack()

    surname_entry = tk.Entry(login_screen)
    surname_entry.pack()

    password_label = tk.Label(login_screen, text="Şifre:")
    password_label.pack()

    password_entry = tk.Entry(login_screen, show="*")
    password_entry.pack()

    login_button = tk.Button(login_screen, text="Giriş Yap", command=validate_login)
    login_button.pack()

    register_button = tk.Button(login_screen, text="Kaydol", command=show_register_screen)
    register_button.pack()

    login_screen.mainloop()

def show_register_screen():
    global username_entry, surname_entry, password_entry, register_screen
    login_screen.destroy()

    register_screen = tk.Tk()
    register_screen.title("Kaydolma Ekranı")

    username_label = tk.Label(register_screen, text="Kullanıcı Adı:")
    username_label.pack()

    username_entry = tk.Entry(register_screen)
    username_entry.pack()

    surname_label = tk.Label(register_screen, text="Kullanıcı Soyadı:")
    surname_label.pack()

    surname_entry = tk.Entry(register_screen)
    surname_entry.pack()

    password_label = tk.Label(register_screen, text="Şifre:")
    password_label.pack()

    password_entry = tk.Entry(register_screen, show="*")
    password_entry.pack()

    register_button = tk.Button(register_screen, text="Kaydol", command=register)
    register_button.pack()

    login_button = tk.Button(register_screen, text="Giriş Yap", command=show_login_screen)
    login_button.pack()

    register_screen.mainloop()


# Admin ekranını gösteren fonksiyon
def show_admin_screen():
    login_screen.withdraw()

    # Yeni pencere oluştur
    admin_screen = tk.Toplevel()
    admin_screen.title("Admin Ekranı")
    admin_screen.geometry("300x200")

    def delete_user(user_no):
        cursor = db.cursor()
        delete_query = "DELETE FROM kullanicilar WHERE KullaniciNo = %s"
        cursor.execute(delete_query, (user_no,))
        db.commit()
        messagebox.showinfo("Başarılı", "Kullanıcı silindi.")
        show_admin_screen()

    def logout():
        admin_screen.destroy()
        login_screen.deiconify()

    # Kullanıcıları veritabanından al
    cursor = db.cursor()
    query = "SELECT KullaniciNo, KullaniciAdi, KullaniciSoyadi, KullaniciSifresi FROM kullanicilar"
    cursor.execute(query)
    users = cursor.fetchall()

    for user in users:
        user_info = f"Kullanıcı No: {user[0]}, Kullanıcı Adı: {user[1]}, Kullanıcı Soyadı: {user[2]}, Kullanıcı Şifre: {user[3]}"
        label = tk.Label(admin_screen, text=user_info)
        label.pack()

        delete_button = tk.Button(admin_screen, text="Sil", command=lambda user_no=user[0]: delete_user(user_no))
        delete_button.pack()

    logout_button = tk.Button(admin_screen, text="Çıkış Yap", command=logout)
    logout_button.pack()

show_login_screen()