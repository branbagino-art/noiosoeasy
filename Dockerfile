FROM python:3.10-slim

# Installa dipendenze di sistema (git per clonare, ffmpeg per media)
RUN apt-get update && apt-get install -y git ffmpeg && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clona il TUO fork (non l'originale)
# Sostituisci "tuo-username" con il tuo nome utente GitHub
RUN git clone --depth 1 https://github.com/tuo-username/EasyProxy.git .

# Installa le dipendenze Python
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir gunicorn aiohttp flask requests

# Porta richiesta da Hugging Face Spaces
ENV PORT=7860
EXPOSE 7860

# Crea un utente non root (opzionale ma consigliato)
RUN useradd -m -u 1000 appuser && chown -R appuser /app
USER appuser

# Avvia l'applicazione (verifica che il file principale si chiami app.py)
CMD ["python", "app.py"]
