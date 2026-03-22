# 🚀 n8n Hibrit Dağıtım Rehberi (Render & Hugging Face)

Bu proje, n8n'i hem **Render** hem de **Hugging Face Spaces** üzerinde aynı **Neon.tech** veritabanını kullanarak senkronize bir şekilde çalıştırmanızı sağlar.

---

## ⚠️ KRİTİK: Neon.tech Bağlantı Ayarı

Neon.tech veritabanına bağlanırken **"unsupported startup parameter: statement_timeout"** hatası alıyorsanız şu adımı mutlaka yapmalısınız:

1.  **Neon.tech Konsoluna** gidin.
2.  **Connection String** bölümünde **"Pooled Connection"** seçeneğini **KAPATIN** (Direct'i seçin).
3.  Host adresinizin içinde `-pooler` ifadesi **olmadığından** emin olun.
4.  Yeni "Direct" bağlantı bilgilerini Render ve Hugging Face ortam değişkenlerine girin.

---

## 🛠️ Hazırlık: Ortam Değişkenleri

Platformlardaki **Environment Variables / Secrets** kısmına şunları ekleyin:

-   `DB_POSTGRESDB_HOST`: Neon "Direct" host adresiniz.
-   `DB_POSTGRESDB_USER`: Neon kullanıcı adınız.
-   `DB_POSTGRESDB_PASSWORD`: Neon şifreniz.
-   `DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED`: `false` (Zorunludur).
-   `N8N_ENCRYPTION_KEY`: Rastgele güçlü bir anahtar belirleyin. **Önemli:** Her iki platformda (Render ve HF) da bu anahtar **birebir aynı** olmalıdır. Aksi takdirde verileriniz senkronize olmaz ve hata alırsınız.
-   `N8N_WEBHOOK_URL`: İlgili platformun URL'si (Örn: `https://uygulamaniz.onrender.com/`).

---

## 🚀 Dağıtım Adımları

1.  **GitHub:** Projeyi kendi repository'nize yükleyin.
2.  **Render:** "New Web Service" oluşturun, GitHub'ı bağlayın, yukarıdaki değişkenleri ekleyin.
3.  **Hugging Face:** "New Space" (Docker) oluşturun, GitHub'ı bağlayın, `Settings -> Secrets` kısmına hassas bilgileri ekleyin.

---

## 🔐 Güvenlik ve Performans

-   **Secret Kullanımı:** Şifreleri asla `Dockerfile` içine yazmayın.
-   **Bellek:** Ücretsiz planlar için `EXECUTIONS_PROCESS=main` ayarı `Dockerfile` içinde aktif edilmiştir. Bu n8n'in daha stabil çalışmasını sağlar.

---

## 🛠️ Sorun Giderme

### ❌ Veritabanı Başlatılamadı (DB Initialization Error)
-   Bağlantınızın "Pooled" değil "Direct" olduğundan emin olun.
-   Neon projenizde IP Allowlist'in `0.0.0.0/0` (herkese açık) olduğunu kontrol edin.

### 🐢 Donma Sorunu
-   Kaynak yetersizse Render/HF ayarlarından `NODE_OPTIONS` değişkenine `--max-old-space-size=512` değerini ekleyebilirsiniz.

---

**Mutlu Otomasyonlar!** 💡
