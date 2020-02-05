load('EXP_DATA_PROP.mat');
load('APC_FIT.mat', 'APC_FIT');
%%
rpmlim = [3000 12000];

testrpm = linspace(rpmlim(1), rpmlim(2), 10000);
testpwr = APC_FIT.rpm_pwr(testrpm);

for i = 1:length(APC.P)
    apcpwr = ones([1, 10000]) .* APC.P(i);
    diff = apcpwr - testpwr;
    for j = 1:10000
        diffj = diff(j);
        if diffj < 0
            break
        end
    end
    rpm(i) = testrpm(j);
end

APC.rpmmean = rpm;

save('EXP_DATA_PROP.mat', 'APC', 'BASE');

clear rpm diff diffj apcpwr testpwr testrpm rpmlim APC_FIT i j