%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: /Users/jordaneriksen/Documents/Uni/Part 2B/Project/Drone Control/rpm.txt
%
% Auto-generated by MATLAB on 17-Jan-2020 17:32:55

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 1);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = "RPM";
opts.VariableTypes = "double";

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Import the data
tbl = readtable("/Users/jordaneriksen/Documents/Uni/Part 2B/Project/Drone Control/rpm.txt", opts);

%% Convert to output type
RPM = tbl.RPM;

%% Clear temporary variables
clear opts tbl