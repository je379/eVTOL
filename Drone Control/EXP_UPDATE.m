%% Update Data 

load('EXP_DATA.mat','S08S','S10S','S12S','S08L','S10L','S12L','S08','S10','S12');
load('EXP_DATA_PROP.mat', 'APC', 'BASE');
load('EXP_META.mat')
load('EXP_OP.mat')

diff = '10L';

switch diff
    case '8'
        S08.FOM = [S08.FOM FOM];
        S08.P = [S08.P P];
        S08.T = [S08.T T];
        S08.mass = [S08.mass mass];
        S08.rpmmean = [S08.rpmmean rpmmean];
        S08.pwm = [S08.pwm pwm];
        S08.nomV = [S08.nomV nomV];
    case '08S'
        S08S.FOM = [S08S.FOM FOM];
        S08S.P = [S08S.P P];
        S08S.T = [S08S.T T];
        S08S.mass = [S08S.mass mass];
        S08S.rpmmean = [S08S.rpmmean rpmmean];
        S08S.pwm = [S08S.pwm pwm];
        S08S.nomV = [S08S.nomV nomV];
    case '08L'
        S08L.FOM = [S08L.FOM FOM];
        S08L.P = [S08L.P P];
        S08L.T = [S08L.T T];
        S08L.mass = [S08L.mass mass];
        S08L.rpmmean = [S08L.rpmmean rpmmean];
        S08L.pwm = [S08L.pwm pwm];
        S08L.nomV = [S08L.nomV nomV];
    case '10'
        S10.FOM = [S10.FOM FOM];
        S10.P = [S10.P P];
        S10.T = [S10.T T];
        S10.mass = [S10.mass mass];
        S10.rpmmean = [S10.rpmmean rpmmean];
        S10.pwm = [S10.pwm pwm];
        S10.nomV = [S10.nomV nomV];
    case '10S'
        S10S.FOM = [S10S.FOM FOM];
        S10S.P = [S10S.P P];
        S10S.T = [S10S.T T];
        S10S.mass = [S10S.mass mass];
        S10S.rpmmean = [S10S.rpmmean rpmmean];
        S10S.pwm = [S10S.pwm pwm];
        S10S.nomV = [S10S.nomV nomV];
    case '10L'
        S10L.FOM = [S10L.FOM FOM];
        S10L.P = [S10L.P P];
        S10L.T = [S10L.T T];
        S10L.mass = [S10L.mass mass];
        S10L.rpmmean = [S10L.rpmmean rpmmean];
        S10L.pwm = [S10L.pwm pwm];
        S10L.nomV = [S10L.nomV nomV];
    case '12'
        S12.FOM = [S12.FOM FOM];
        S12.P = [S12.P P];
        S12.T = [S12.T T];
        S12.mass = [S12.mass mass];
        S12.rpmmean = [S12.rpmmean rpmmean];
        S12.pwm = [S12.pwm pwm];
        S12.nomV = [S12.nomV nomV];
    case '12S'
        S12S.FOM = [S12S.FOM FOM];
        S12S.P = [S12S.P P];
        S12S.T = [S12S.T T];
        S12S.mass = [S12S.mass mass];
        S12S.rpmmean = [S12S.rpmmean rpmmean];
        S12S.pwm = [S12S.pwm pwm];
        S12S.nomV = [S12S.nomV nomV];
    case '12L'
        S12L.FOM = [S12L.FOM FOM];
        S12L.P = [S12L.P P];
        S12L.T = [S12L.T T];
        S12L.mass = [S12L.mass mass];
        S12L.rpmmean = [S12L.rpmmean rpmmean];
        S12L.pwm = [S12L.pwm pwm];
        S12L.nomV = [S12L.nomV nomV];
    case 'APC'
        PROP.FOM = [PROP.FOM FOM];
        PROP.P = [PROP.P P];
        PROP.T = [PROP.T T];
        PROP.mass = [PROP.mass mass];
        PROP.pwm = [PROP.pwm pwm];
        PROP.nomV = [PROP.nomV nomV];
    case 'BASE'
        BASE.FOM = [BASE.FOM FOM];
        BASE.P = [BASE.P P];
        BASE.T = [BASE.T T];
        BASE.mass = [BASE.mass mass];
        BASE.pwm = [BASE.pwm pwm];
        BASE.nomV = [BASE.nomV nomV];
end

save('EXP_DATA.mat','S08S','S10S','S12S','S08L','S10L','S12L','S08','S10','S12');
save('EXP_DATA_PROP.mat', 'APC', 'BASE');

clear all;

EXP_DATA_PLOT