close all;
clear;
clc;

%% Read & load data
datatest = xlsread('Testset.xls');
load hasilTrainingJSTdenganGA;

%% Prediksi kelas
y_prediksi = prediksi(bestKrom, datatest);

%% Write to excel file
% save hasilTesting y_prediksi
filename = 'TestsetTugas3.xlsx';
xlswrite(filename,y_prediksi);