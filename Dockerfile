FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install lib32gcc1 unzip wget nodejs npm -y && npm install pm2 -g

RUN useradd --user-group --system --create-home --no-log-init steam
USER steam
WORKDIR /home/steam

RUN wget http://media.steampowered.com/client/steamcmd_linux.tar.gz \
    && tar -xvf steamcmd_linux.tar.gz && rm steamcmd_linux.tar.gz

COPY steam_script .

RUN mkdir acmanager && cd acmanager && wget https://github.com/lmitusinski/ACServerManager/archive/master.zip \
    && unzip master.zip && mv ACServerManager-master/* . && rm -R ACServerManager-master && rm master.zip && npm install

COPY settings.js acmanager/
COPY pre_init.sh .

ARG STEAM_USER
ARG STEAM_PASS
ARG STEAM_CODE

RUN sed -i "s/<STEAM_USER>/$STEAM_USER/" steam_script && sed -i "s/<STEAM_PASS>/$STEAM_PASS/" steam_script \
    && sed -i "s/<STEAM_CODE>/$STEAM_CODE/" steam_script
RUN ./steamcmd.sh +@sSteamCmdForcePlatformType windows +runscript steam_script && rm steam_script

CMD ./pre_init.sh && pm2 start acmanager/server.js && pm2 logs