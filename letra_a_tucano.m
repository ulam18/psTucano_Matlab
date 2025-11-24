%% Script para gerar os gráficos do intervalo de voo

% Carregar os dados
load('dados_case.mat');

% Conversão de tempo para segundos
tempo_arsp = ARSP_0(:, 2) / 1e6;
airspeed   = ARSP_0(:, 4);

tempo_bat  = BAT_0(:, 2) / 1e6;
corrente   = BAT_0(:, 6);

tempo_gps  = GPS_0(:, 2) / 1e6;
latitude   = GPS_0(:, 9);
longitude  = GPS_0(:, 10);

% Intervalo de voo obtido a partir dos gráficos ARSP e BAT
t_inicio = 823;    % s
t_fim    = 936;    % s

% Máscaras lógicas para selecionar apenas o voo
idx_arsp = tempo_arsp >= t_inicio & tempo_arsp <= t_fim;
idx_bat  = tempo_bat  >= t_inicio & tempo_bat  <= t_fim;
idx_gps  = tempo_gps  >= t_inicio & tempo_gps  <= t_fim;

% Dados cortados
tempo_arsp_voo = tempo_arsp(idx_arsp);
airspeed_voo   = airspeed(idx_arsp);

tempo_bat_voo = tempo_bat(idx_bat);
corrente_voo  = corrente(idx_bat);

longitude_voo = longitude(idx_gps);
latitude_voo  = latitude(idx_gps);

%% 1) Airspeed x Tempo (apenas voo)
figure;
plot(tempo_arsp_voo, airspeed_voo);
xlabel('Tempo (s)');
ylabel('Airspeed (m/s)');
title('Airspeed durante o voo');
grid on;

%% 2) Corrente da Bateria x Tempo (apenas voo)
figure;
plot(tempo_bat_voo, corrente_voo);
xlabel('Tempo (s)');
ylabel('Corrente da Bateria (A)');
title('Corrente da Bateria durante o voo');
grid on;

%% 3) GPS (Longitude x Latitude) no intervalo de voo
figure;
plot(longitude_voo, latitude_voo);
xlabel('Longitude (graus)');
ylabel('Latitude (graus)');
title('Trajetória GPS da aeronave durante o voo');
grid on;
axis equal;

%% 4) Filtro Passa-Baixa no Airspeed (intervalo de voo)

% Filtro passa-baixa simples (média móvel)
janela = 50;   % tamanho da janela do filtro
airspeed_filtrado = movmean(airspeed_voo, janela);

%% 5) Gráfico comparando original x filtrado

figure;
plot(tempo_arsp_voo, airspeed_voo, 'Color', [0.7 0.7 1]); hold on;
plot(tempo_arsp_voo, airspeed_filtrado, 'LineWidth', 2, 'Color', [0 0 0.8]);
hold off;

xlabel('Tempo (s)');
ylabel('Airspeed (m/s)');
title('Airspeed (Original x Filtrado) - Intervalo de Voo');
legend('Sinal Original', 'Sinal Filtrado (Passa-Baixa)');
grid on;








