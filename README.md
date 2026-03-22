# 🚀 n8n Hibrit Dağıtım Rehberi (Render & Hugging Face)

Bu proje, n8n'i hem **Render** hem de **Hugging Face Spaces** üzerinde aynı **Neon.tech** veritabanını kullanarak senkronize bir şekilde çalıştırmanızı sağlar. Bir platformda yaptığınız değişiklik veya oluşturduğunuz workflow, diğerinde anında görünür!

---

## 🛠️ Hazırlık: Neon.tech Veritabanı

1. [Neon.tech](https://neon.tech/) üzerinden ücretsiz bir PostgreSQL projesi oluşturun.
2. Sağ taraftaki **"Connection String"** panelinden host ve şifre bilgilerini alın.
3. Proje klasöründeki `Dockerfile` dosyasını açın ve şu satırları Neon bilgilerinizle doldurun:
   ```dockerfile
   ENV DB_POSTGRESDB_HOST=ep-xxxx-xxxx.eu-central-1.aws.neon.tech
   ENV DB_POSTGRESDB_PASSWORD=BURAYA_NEON_SIFRENIZI_YAZIN
   ```

---

## 🚀 Dağıtım Adımları

### 1. Projeyi GitHub'a Yükleyin
- Bu klasörü bir GitHub repository'sine yükleyin.

### 2. Render.com Kurulumu
1. Render paneline girin ve **"New Web Service"**'e tıklayın.
2. GitHub repository'nizi bağlayın.
3. **Instance Type** olarak en düşüğü seçebilirsiniz.
4. **Environment Variables** (Ortam Değişkenleri) kısmına şunu ekleyin:
   - `N8N_WEBHOOK_URL`: `https://[senin-app-adın].onrender.com/`

### 3. Hugging Face Spaces Kurulumu
1. Hugging Face'de **"New Space"** oluşturun.
2. SDK olarak **"Docker"**'ı seçin.
3. Repository'nizi bağlayın (veya dosyaları yükleyin).
4. **Settings** -> **Variables and Secrets** kısmına gidin.
5. **Variables** kısmına şunu ekleyin:
   - `N8N_WEBHOOK_URL`: `https://[kullanıcı-adın]-[space-adın].hf.space/`

---

## 💡 Önemli İpuçları & Kullanım Kılavuzu

### 🔄 Senkronizasyon Nasıl Çalışır?
Her iki platform da Neon veritabanına bağlıdır. Hugging Face üzerinde bir otomasyon kaydederseniz, Render adresinizi yenilediğinizde aynı otomasyonu orada da göreceksiniz.

### 🔌 Webhook Tetikleyicileri
n8n'de webhook kullanırken, kullandığınız platformun (Render veya HF) URL'sinin `N8N_WEBHOOK_URL` ile eşleştiğinden emin olun. Platforma özel tetiklemeler için bu URL değişkendir.

### ⚠️ Fabrika Ayarları (Factory Reboot)
Eğer platformlardan birine girince eski halini görüyorsanız veya bağlantı hatası alıyorsanız, o platformun panelinden **"Restart"** veya **"Factory Reboot"** yapmanız yeterlidir.

### 🔒 Güvenlik
`Dockerfile` içinde şifrelerinizi barındırmak istemiyorsanız, bu değerleri platformların kendi panelindeki "Secret" veya "Env" kısımlarından da tanımlayabilirsiniz; ancak Dockerfile yöntemi en hızlı test yöntemidir.

---

**Mutlu Otomasyonlar!** 💡
