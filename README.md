# 🚀 n8n Hibrit Dağıtım Rehberi (Render & Hugging Face)

Bu proje, n8n'i hem **Render** hem de **Hugging Face Spaces** üzerinde aynı **Neon.tech** veritabanını kullanarak senkronize bir şekilde çalıştırmanızı sağlar. Bir platformda yaptığınız değişiklik veya oluşturduğunuz workflow, diğerinde anında görünür!

---

## 🛠️ Hazırlık: Neon.tech Veritabanı

1. [Neon.tech](https://neon.tech/) üzerinden ücretsiz bir PostgreSQL projesi oluşturun.
2. Sağ taraftaki **"Connection String"** panelinden host ve şifre bilgilerini alın.
3. Bu bilgileri platformlardaki **Environment Variables** (Ortam Değişkenleri) kısmına ekleyeceksiniz.

---

## 🚀 Dağıtım Adımları

### 1. Projeyi GitHub'a Yükleyin
- Bu klasörü bir GitHub repository'sine yükleyin.

### 2. Render.com Kurulumu
1. Render paneline girin ve **"New Web Service"**'e tıklayın.
2. GitHub repository'nizi bağlayın.
3. **Instance Type** olarak en düşüğü seçebilirsiniz.
4. **Environment Variables** kısmına şunları ekleyin:
   - `DB_POSTGRESDB_HOST`: Neon host adresiniz
   - `DB_POSTGRESDB_USER`: Neon kullanıcı adınız
   - `DB_POSTGRESDB_PASSWORD`: Neon şifreniz
   - `N8N_ENCRYPTION_KEY`: Güçlü ve rastgele bir anahtar (Verilerinizin güvenliği için kritiktir!)
   - `N8N_WEBHOOK_URL`: `https://[senin-app-adın].onrender.com/`

### 3. Hugging Face Spaces Kurulumu
1. Hugging Face'de **"New Space"** oluşturun.
2. SDK olarak **"Docker"**'ı seçin.
3. Repository'nizi bağlayın.
4. **Settings** -> **Variables and Secrets** kısmına gidin.
5. **Secrets** kısmına Neon veritabanı bilgilerinizi ve `N8N_ENCRYPTION_KEY` anahtarınızı ekleyin.
6. **Variables** kısmına şunu ekleyin:
   - `N8N_WEBHOOK_URL`: `https://[kullanıcı-adın]-[space-adın].hf.space/`

---

## 🔐 Güvenlik ve En İyi Uygulamalar

- **Secret Kullanımı:** Hassas bilgileri (`PASSWORD`, `HOST`, `ENCRYPTION_KEY`) asla `Dockerfile` içine yazmayın. Her zaman platformun kendi Gizli Değişkenler (Secret) özelliğini kullanın.
- **N8N_ENCRYPTION_KEY:** Bu anahtarı bir kez belirleyin ve her iki platformda da aynısını kullanın. Eğer bu anahtarı kaybederseniz, veritabanındaki şifrelenmiş veriler (kimlik bilgileri vb.) okunamaz hale gelir.
- **Kullanıcı Yönetimi:** Bu kurulumda `N8N_USER_MANAGEMENT_DISABLED=true` ayarlanmıştır. Daha fazla güvenlik için bunu `false` yapıp n8n içinde bir admin hesabı oluşturabilirsiniz.

---

## 🛠️ Sorun Giderme (Troubleshooting)

### ❌ Veritabanı Bağlantı Hatası
- Neon.tech "Project Settings" kısmında "IP Allowlist" ayarının kapalı veya `0.0.0.0/0` olduğundan emin olun.
- Host ve şifre bilgilerinin doğru girildiğini kontrol edin.

### 🐢 Donma veya Yavaşlama (Bellek Sorunu)
- Ücretsiz planlarda bellek yetersiz kalabilir. `Dockerfile` içinde `EXECUTIONS_PROCESS=main` ayarının aktif olduğundan emin olun (bu kurulumda aktiftir).
- Eğer hala sorun yaşıyorsanız, `NODE_OPTIONS=--max-old-space-size=512` değişkenini ekleyerek n8n'in bellek kullanımını limitleyebilirsiniz.

### 🔄 Senkronizasyon Çalışmıyor
- Her iki platformun da **aynı** Neon veritabanına ve **aynı** `N8N_ENCRYPTION_KEY` anahtarına sahip olduğundan emin olun.

---

**Mutlu Otomasyonlar!** 💡
