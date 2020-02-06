%% Update Data 

load('EXP_DATA.mat','S08S','S10S','S12S','S08L','S10L','S12L','S08','S10','S12');
load('EXP_DATA_PROP.mat', 'APC', 'BASE');

load('EXP_META.mat')
data = load('EXP_OP.mat');
data.nomV = nomV;
data.pwm = pwm;

switch SIGMANAME
    case '8'
        S08 = EXP_ADD(S08, data);
    case '08S'
        S08S = EXP_ADD(S08S, data);
    case '08L'
        S08L = EXP_ADD(S08L, data);
    case '10'
        S10 = EXP_ADD(S10, data);
    case '10S'
        S10S = EXP_ADD(S10S, data);
    case '10L'
        S10L = EXP_ADD(S10L, data);
    case '12'
        S12 = EXP_ADD(S12, data);
    case '12S'
        S12S = EXP_ADD(S12S, data);
    case '12L'
        S12L = EXP_ADD(S12L, data);
    case 'APC'
        PROP.FOM = [PROP.FOM data.FOM];
        PROP.P = [PROP.P data.P];
        PROP.T = [PROP.T data.T];
        PROP.mass = [PROP.mass data.mass];
        PROP.pwm = [PROP.pwm data.pwm];
        PROP.nomV = [PROP.nomV data.nomV];
    case 'BASE'
        BASE.FOM = [BASE.FOM data.FOM];
        BASE.P = [BASE.P data.P];
        BASE.T = [BASE.T data.T];
        BASE.mass = [BASE.mass data.mass];
        BASE.pwm = [BASE.pwm data.pwm];
        BASE.nomV = [BASE.nomV data.nomV];
end

save('EXP_DATA.mat','S08S','S10S','S12S','S08L','S10L','S12L','S08','S10','S12');
save('EXP_DATA_PROP.mat', 'APC', 'BASE');

clear all;

% EXP_PLOT;