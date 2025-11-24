%% Script para gerar os gráficos ARSP BAT e GPS

% Carregar os dados
load('dados_case.mat');


%% 1) Gráfico ARSP (Airspeed) x Tempo
tempo_arsp = ARSP_0(:, 2) / 1e6;   % tempo em segundos
airspeed   = ARSP_0(:, 4);

figure;
plot(tempo_arsp, airspeed);
xlabel('Tempo (s)');
ylabel('Airspeed (m/s)');
title('Airspeed x Tempo');
grid on;

%% 2) Gráfico BAT (Corrente) x Tempo
tempo_bat = BAT_0(:, 2) / 1e6;
corrente  = BAT_0(:, 6);

figure;
plot(tempo_bat, corrente);
xlabel('Tempo (s)');
ylabel('Corrente da Bateria (A)');
title('Corrente da Bateria x Tempo');
grid on;

%% 3) Gráfico GPS (Longitude x Latitude)
latitude  = GPS_0(:, 9);
longitude = GPS_0(:, 10);

figure;
plot(longitude, latitude);
xlabel('Longitude (graus)');
ylabel('Latitude (graus)');
title('Trajetória do Avião (GPS)');
grid on;
axis equal;
