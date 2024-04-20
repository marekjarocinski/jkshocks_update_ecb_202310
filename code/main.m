% Updating the JK shocks
clear all, close all

% Interest rate surprises to extract pc from, stock index
irnames = ["OIS_1M","OIS_3M","OIS_6M","OIS_1Y"];
stockname = "STOXX50";

% Load the Altavilla et al. (2019) Monetary Policy Database downloadable from
% https://www.ecb.europa.eu/pub/pdf/annex/Dataset_EA-MPD.xlsx
% use the Monetary Event Window
fname = '../source_data/Dataset_EA-MPD.xlsx';
opts = detectImportOptions(fname, 'Sheet', 'Monetary Event Window');
opts = setvartype(opts, opts.VariableNames(2:end), 'double');
tab = readtable(fname, opts);
tab.date.Format = 'uuuu-MM-dd';

% Select the sample
isample = true(size(tab,1),1);
% drop joint Fed and ECB announcements
isample(tab.date == datetime('13-Sep-2001')) = 0; % joint announcement of USD swap
isample(tab.date == datetime('17-Sep-2001')) = 0; % joint cut at 17:30
isample(tab.date == datetime('08-Oct-2008')) = 0; % joint cut

tab = tab(isample,:);
fprintf('Data from %s to %s, T=%d\n', tab.date(1), tab.date(end), size(tab,1))


% Compute the 1st principal component
X = tab{:, irnames};
[~,score] = pca(normalize(X,'scale','std'), 'Centered', false);
% rescale the 1st principal component
pc1 = score(:,1)/std(score(:,1))*std(tab.OIS_1Y)/100;

% add pc1 to the table
tab.pc1 = round(pc1,8);

% keep only the variables we need
tab = tab(:,["date","pc1",stockname]);


% Compute the poor man and median rotation shocks
M = tab{:,["pc1",stockname]};
% poor man's shocks
U_pm = [M(:,1).*(prod(M,2)<0) M(:,1).*(prod(M,2)>=0)];
% median rotation shocks
U_median = signrestr_median(M);


% Save daily shocks
shocks_names = ["MP_pm","CBI_pm","MP_median","CBI_median"];
shocks_table = array2table(round([U_pm U_median],8), 'VariableNames', shocks_names);
tab = [tab shocks_table];
filename_d = "../shocks/shocks_ecb_mpd_me_d.csv";
writetable(tab, filename_d);


% Aggregate to monthly
mtab = table_d2m2q(tab);
% add a suffix to pc1 and stock
mtab.Properties.VariableNames(3:4) = mtab.Properties.VariableNames(3:4) + "_hf";
writetable(mtab, strrep(filename_d,"_d","_m"));

