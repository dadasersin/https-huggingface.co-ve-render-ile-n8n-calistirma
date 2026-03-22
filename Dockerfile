FROM node:20-slim

# Gerekli sistem araçları
RUN apt-get update && apt-get install -y graphicsmagick ghostscript ca-certificates && rm -rf /var/lib/apt/lists/*

# En güncel n8n kurulumu
RUN npm install -g n8n

# Port Ayarı (Hugging Face 7860 ister, Render bunu anlar)
ENV N8N_PORT=7860
EXPOSE 7860

# --- VERİTABANI BAĞLANTISI (Neon.tech Bilgileri) ---
# Neon konsolundaki bilgilerle bu kısımları doldurun
ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_HOST=ep-xxxx-xxxx.eu-central-1.aws.neon.tech
ENV DB_POSTGRESDB_PORT=5432
ENV DB_POSTGRESDB_DATABASE=neondb
ENV DB_POSTGRESDB_USER=neondb_owner
ENV DB_POSTGRESDB_PASSWORD=BURAYA_NEON_SIFRENIZI_YAZIN

# --- KRİTİK AYARLAR ---
ENV N8N_USER_MANAGEMENT_DISABLED=true
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false
ENV N8N_COOKIES_SAME_SITE=lax
ENV N8N_CORS_ALLOWED_ORIGINS=*

WORKDIR /home/node
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n
USER node

CMD ["node", "/usr/local/bin/n8n", "start"]
