# Образ майнинга для SaladCloud (22.10.2026). База — та же, что у групп сейчас: её слои уже в кэше сети Salad.
# Поверх — curl и архивы майнеров, каждый проверен по SHA-256 (те же суммы, что в research/salad_deploy.py).
# Кошелька, воркера и ключей в образе нет: они приходят в команде группы, как сейчас.
FROM nvidia/cuda:12.0.1-base-ubuntu22.04

RUN apt-get update \
 && apt-get install -y --no-install-recommends curl ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Каждый майнер — отдельным слоем: новая версия одного не заставляет машины качать остальные заново.
# Имя файла — как в релизе GitHub: скрипт ищет /opt/miners/<имя файла из адреса загрузки>.
WORKDIR /opt/miners

# SRBMiner 3.7.9 — NVIDIA RTX 30xx/40xx/50xx до 25.10 (запасной для отката по карте)
RUN curl -fsSLO https://github.com/doktor83/SRBMiner-Multi/releases/download/3.7.9/SRBMiner-Multi-3-7-9-Linux.tar.gz \
 && echo "f0cfca82411fdf2245422db1d5989ce3f5e5b746ec776581853af5705f2b9a7f  SRBMiner-Multi-3-7-9-Linux.tar.gz" | sha256sum -c -

# SRBMiner 3.7.8 — RTX 4050 Laptop
RUN curl -fsSLO https://github.com/doktor83/SRBMiner-Multi/releases/download/3.7.8/SRBMiner-Multi-3-7-8-Linux.tar.gz \
 && echo "2f303e3512eddc8faedac00e7f126e30de0dcff31369a05e5827cac81b40e74c  SRBMiner-Multi-3-7-8-Linux.tar.gz" | sha256sum -c -

# PeakMiner 2.19.1 — RTX 20xx, Китай, запасной при отказе SRBMiner
RUN curl -fsSLO https://github.com/peakminer/peakminer/releases/download/v2.19.1/peakminer-2.19.1-linux-x86_64 \
 && echo "99d19b100ad136f11ad07f593dbd6eca8a6bd5631f9b9fb519576a1a87aa9ab1  peakminer-2.19.1-linux-x86_64" | sha256sum -c -

# PeakMiner 2.17.5 — запасной для RTX 50xx (Blackwell)
RUN curl -fsSLO https://github.com/peakminer/peakminer/releases/download/v2.17.5/peakminer-2.17.5-linux-x86_64 \
 && echo "8eb1f86bc8e366ca33a656360966784c4c0a7262a703c5bc2a901e8795685b11  peakminer-2.17.5-linux-x86_64" | sha256sum -c -

# SRBMiner 3.8.0 — NVIDIA RTX 30xx/40xx/50xx, новые машины с 25.10 (последним слоем: прежние слои остаются в кэше)
RUN curl -fsSLO https://github.com/doktor83/SRBMiner-Multi/releases/download/3.8.0/SRBMiner-Multi-3-8-0-Linux.tar.gz \
 && echo "095c3f75905ee023e8ed85ac905afefc92825cce83a528fa955cf1db456d3dd8  SRBMiner-Multi-3-8-0-Linux.tar.gz" | sha256sum -c -

# PeakMiner 2.20.2 (28.10) — RTX 20xx, Китай, запасной при отказе SRBMiner на 30xx/40xx (2.19.1 выше — для отката;
# RTX 50xx — по-прежнему 2.17.5: тикет peakminer#24 открыт). Последним слоем: прежние слои остаются в кэше
RUN curl -fsSLO https://github.com/peakminer/peakminer/releases/download/v2.20.2/peakminer-2.20.2-linux-x86_64 \
 && echo "6095b04fc0f40616c2b4e7ea94f370c2fe245a2fdddf3d46258a909d5127b045  peakminer-2.20.2-linux-x86_64" | sha256sum -c -

# SRBMiner 3.8.1 (29.10, владелец: «вышла новая srbminer… обнови докер и устанавливай её вместо 3.8.0») — NVIDIA RTX
# 30xx/40xx/50xx, новые машины; 3.8.0 выше — для отката. Последним слоем: прежние слои остаются в кэше
RUN curl -fsSLO https://github.com/doktor83/SRBMiner-Multi/releases/download/3.8.1/SRBMiner-Multi-3-8-1-Linux.tar.gz \
 && echo "2f65b3b7f7781def46610c43b8a10a3d38033f6cf4ef6cc968b405ca9b0ce807  SRBMiner-Multi-3-8-1-Linux.tar.gz" | sha256sum -c -

WORKDIR /
