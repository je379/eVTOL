%% Update Data 

load('EXP_DATA_SHORTINTAKE.mat', 'S08', 'S10', 'S12');
load('EXP_DATA_LONGINTAKE.mat','S10L','S08L','S12L');
load('EXP_DATA_PROP.mat', 'APC', 'BASE');

pwm = 2000;
nomV = 14.8;

diff = '10L';

switch diff
    case 8
        S08.FOM = [S08.FOM FOM];
        S08.P = [S08.P P];
        S08.T = [S08.T T];
        S08.mass = [S08.mass mass];
        S08.rpmmean = [S08.rpmmean rpmmean];
        S08.pwm = [S08.pwm pwm];
        S08.nomV = [S08.nomV nomV];
    case '08L'
        S08L.FOM = [S08L.FOM FOM];
        S08L.P = [S08L.P P];
        S08L.T = [S08L.T T];
        S08L.mass = [S08L.mass mass];
        S08L.rpmmean = [S08L.rpmmean rpmmean];
        S08L.pwm = [S08L.pwm pwm];
        S08L.nomV = [S08L.nomV nomV];
    case 10
        S10.FOM = [S10.FOM FOM];
        S10.P = [S10.P P];
        S10.T = [S10.T T];
        S10.mass = [S10.mass mass];
        S10.rpmmean = [S10.rpmmean rpmmean];
        S10.pwm = [S10.pwm pwm];
        S10.nomV = [S10.nomV nomV];
    case '10L'
        S10L.FOM = [S10L.FOM FOM];
        S10L.P = [S10L.P P];
        S10L.T = [S10L.T T];
        S10L.mass = [S10L.mass mass];
        S10L.rpmmean = [S10L.rpmmean rpmmean];
        S10L.pwm = [S10L.pwm pwm];
        S10L.nomV = [S10L.nomV nomV];
    case 12
        S12.FOM = [S12.FOM FOM];
        S12.P = [S12.P P];
        S12.T = [S12.T T];
        S12.mass = [S12.mass mass];
        S12.rpmmean = [S12.rpmmean rpmmean];
        S12.pwm = [S12.pwm pwm];
        S12.nomV = [S12.nomV nomV];
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

save('EXP_DATA_SHORTINTAKE.mat', 'S08', 'S10', 'S12');
save('EXP_DATA_LONGINTAKE.mat','S10L','S08L','S12L');
save('EXP_DATA_PROP.mat', 'APC', 'BASE');

EXP_DATA_PLOT