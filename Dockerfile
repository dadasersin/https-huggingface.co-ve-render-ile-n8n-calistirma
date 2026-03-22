FROM node:20-slim

# Gerekli sistem araçları
RUN apt-get update && apt-get install -y graphicsmagick ghostscript ca-certificates && rm -rf /var/lib/apt/lists/*

# En güncel n8n kurulumu
RUN npm install -g n8n

# Port Ayarı (Hugging Face 7860 ister, Render bunu anlar)
ENV N8N_PORT=7860
EXPOSE 7860

# --- VERİTABANI BAĞLANTISI ---
# Not: Güvenlik için bu değerleri Render/HF panellerinden "Environment Variables" olarak tanımlayın.
# Dockerfile içinde şifre saklamak risklidir.
ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_PORT=5432
ENV DB_POSTGRESDB_DATABASE=neondb

# --- KRİTİK & PERFORMANS AYARLARI ---
ENV N8N_USER_MANAGEMENT_DISABLED=true
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false
ENV N8N_COOKIES_SAME_SITE=lax
ENV N8N_CORS_ALLOWED_ORIGINS=*

# Şifreleme Anahtarı (Kurulumdan sonra panelden ayarlanması şiddetle önerilir)
# ENV N8N_ENCRYPTION_KEY=SizinGüçlüAnahtarınız

# Bellek tasarrufu için (Özellikle Free Tier platformlarda önerilir)
ENV EXECUTIONS_PROCESS=main

# Node.js bellek limiti (Opsiyonel: Kaynak yetersizse artırılabilir)
# ENV NODE_OPTIONS=--max-old-space-size=512

WORKDIR /home/node
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n
USER node

CMD ["node", "/usr/local/bin/n8n", "start"]
