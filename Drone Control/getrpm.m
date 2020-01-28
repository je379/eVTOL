%% LOAD IN RPM DATA FIRST (Raw ADC output)

importrpm;
[pks ind] = findpeaks(RPM);

% load('RPMTEST.mat'); % RPM RAW TEST DATA

readspersec = 251;
T = 1/readspersec;
averagewindow = 20;

ind = ind(pks > 0.8);
n = length(ind);

for j = 1:n-1
    seperation(j) = (ind(j+1) - ind(j))*T;
end
for i = 1+averagewindow:n-averagewindow 
    rpmmeasure(i) =  60 / (sum(seperation(i-averagewindow:i+averagewindow-1))/(2*averagewindow));
end

figure(2); hold on; plot(rpmmeasure);
save('OUTPUT');