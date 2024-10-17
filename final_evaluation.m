% Find the folders containing the output signals of each beamformer.
tic;
folder_output_frost = findfolder('output_Frost');
folder_output_mvdr = findfolder('output_MVDR');
folder_output_phaseShift = findfolder('output_PhaseShift');
folder_output_subband_mvdr = findfolder('output_Subband_MVDR');
folder_output_subband_phaseShift = findfolder('output_Subband_PhaseShift');
folder_output_timedelay = findfolder('output_Time_Delay');
folder_output_timedelay_selfmade = findfolder('output_Time_Delay_Selfmade');

% Read the output signals from the beamformers to start the evaluation.

output_frost = readAudio(folder_output_frost, number_of_files);
output_mvdr = readAudio(folder_output_mvdr, number_of_files);
output_phaseShift = readAudio(folder_output_phaseShift, number_of_files);
output_subband_mvdr = readAudio(folder_output_subband_mvdr, number_of_files);
output_subband_phaseShift = readAudio(folder_output_subband_phaseShift, number_of_files);
output_timedelay = readAudio(folder_output_timedelay, number_of_files);
output_timedelay_selfmade =readAudio(folder_output_timedelay_selfmade, number_of_files);

%%
%%%%%%%%%%%%%%%%%%%%%%% CONTRAST ANALYSIS %%%%%%%%%%%%%%%%%%%%%%%%

[average_contrast_frost, contrast_frost] = calculateContrast(output_frost, number_of_files, mixed_signals);
[average_contrast_mvdr, contrast_mvdr] = calculateContrast(output_mvdr, number_of_files, mixed_signals);
[average_contrast_phaseShift, contrast_phaseShift] = calculateContrast(output_phaseShift, number_of_files, mixed_signals);
[average_contrast_subband_mvdr, contrast_subband_mvdr] = calculateContrast(output_subband_mvdr, number_of_files, mixed_signals);
[average_contrast_subband_phaseShift, contrast_subband_phaseShift] = calculateContrast(output_subband_phaseShift, number_of_files, mixed_signals);
[average_contrast_timedelay, contrast_timedelay] = calculateContrast(output_timedelay, number_of_files, mixed_signals);
[average_contrast_timedelay_selfmade, contrast_timedelay_selfmade] = calculateContrast(output_timedelay_selfmade, number_of_files, mixed_signals);

% Combine into  one table
tables = {contrast_frost, contrast_mvdr, contrast_phaseShift, contrast_subband_mvdr, ...
    contrast_subband_phaseShift, contrast_timedelay, contrast_timedelay_selfmade};
All_Contrast_Values = combineTables(tables);
Beamformer = {'Frost';'MVDR';'PhaseShift';'Subband_MVDR,';'Subband_PhaseShift'; 'Timedelay'; 'Timedelay_Selfmade'};
Average_Contrast_Values = [average_contrast_frost,average_contrast_mvdr,average_contrast_phaseShift, average_contrast_subband_mvdr,...
    average_contrast_subband_phaseShift,average_contrast_timedelay, average_contrast_timedelay_selfmade]';
All_Average_Contrast_Values = table(Beamformer,Average_Contrast_Values);

%%
%%%%%%%%%%%%%%%%%%%%%%% SNR ANALYSIS %%%%%%%%%%%%%%%%%%%%%%%%

[average_SNR_frost, SNR_frost] =calculateSNR(output_frost, number_of_files, mixed_signals);
[average_SNR_mvdr, SNR_mvdr] = calculateSNR(output_mvdr, number_of_files, mixed_signals);
[average_SNR_phaseShift, SNR_phaseShift] = calculateSNR(output_phaseShift, number_of_files, mixed_signals);
[average_SNR_subband_mvdr, SNR_subband_mvdr] = calculateSNR(output_subband_mvdr, number_of_files, mixed_signals);
[average_SNR_subband_phaseShift, SNR_subband_phaseShift] = calculateSNR(output_subband_phaseShift, number_of_files, mixed_signals);
[average_SNR_timedelay, SNR_timedelay] = calculateSNR(output_timedelay, number_of_files, mixed_signals);
[average_SNR_timedelay_selfmade, SNR_timedelay_selfmade] = calculateSNR(output_timedelay_selfmade, number_of_files, mixed_signals);

% Combine into  one table
tables = {SNR_frost, SNR_mvdr, SNR_phaseShift, SNR_subband_mvdr, ...
    SNR_subband_phaseShift, SNR_timedelay, SNR_timedelay_selfmade};
All_SNR_Values = combineTables(tables);
Average_SNR_Values = [average_SNR_frost,average_SNR_mvdr,average_SNR_phaseShift, average_SNR_subband_mvdr,...
    average_SNR_subband_phaseShift,average_SNR_timedelay, average_SNR_timedelay_selfmade]';
All_Average_SNR_Values = table(Beamformer,Average_SNR_Values);

%%
%%%%%%%%%%%%%%%%%%%%%%% STOI ANALYSIS %%%%%%%%%%%%%%%%%%%%%%%%

[average_STOI_frost, STOI_frost] =calculateSTOI(output_frost, number_of_files, mixed_signals, operating_frequency);
[average_STOI_mvdr, STOI_mvdr] = calculateSTOI(output_mvdr, number_of_files, mixed_signals, operating_frequency);
[average_STOI_phaseShift, STOI_phaseShift] = calculateSTOI(output_phaseShift, number_of_files, mixed_signals, operating_frequency);
[average_STOI_subband_mvdr, STOI_subband_mvdr] = calculateSTOI(output_subband_mvdr, number_of_files, mixed_signals, operating_frequency);
[average_STOI_subband_phaseShift, STOI_subband_phaseShift] = calculateSTOI(output_subband_phaseShift, number_of_files, mixed_signals, operating_frequency);
[average_STOI_timedelay, STOI_timedelay] = calculateSTOI(output_timedelay, number_of_files, mixed_signals, operating_frequency);
[average_STOI_timedelay_selfmade, STOI_timedelay_selfmade] = calculateSTOI(output_timedelay_selfmade, number_of_files, mixed_signals, operating_frequency);

% Combine into  one table
tables = {STOI_frost, STOI_mvdr, STOI_phaseShift, STOI_subband_mvdr, ...
    STOI_subband_phaseShift, STOI_timedelay, STOI_timedelay_selfmade};
All_STOI_Values = combineTables(tables);
Average_STOI_Values = [average_STOI_frost,average_STOI_mvdr,average_STOI_phaseShift, average_STOI_subband_mvdr,...
    average_STOI_subband_phaseShift,average_STOI_timedelay, average_STOI_timedelay_selfmade]';
All_Average_STOI_Values = table(Beamformer,Average_STOI_Values);

%%
%%%%%%%%%%%%%%%%%%%%%%% VISQOL ANALYSIS %%%%%%%%%%%%%%%%%%%%%%%%

[average_VISQOL_frost, VISQOL_frost] =calculateVISQOL(output_frost, number_of_files, mixed_signals, operating_frequency);
[average_VISQOL_mvdr, VISQOL_mvdr] = calculateVISQOL(output_mvdr, number_of_files, mixed_signals, operating_frequency);
[average_VISQOL_phaseShift, VISQOL_phaseShift] = calculateVISQOL(output_phaseShift, number_of_files, mixed_signals, operating_frequency);
[average_VISQOL_subband_mvdr, VISQOL_subband_mvdr] = calculateVISQOL(output_subband_mvdr, number_of_files, mixed_signals, operating_frequency);
[average_VISQOL_subband_phaseShift, VISQOL_subband_phaseShift] = calculateVISQOL(output_subband_phaseShift, number_of_files, mixed_signals, operating_frequency);
[average_VISQOL_timedelay, VISQOL_timedelay] = calculateVISQOL(output_timedelay, number_of_files, mixed_signals, operating_frequency);
[average_VISQOL_timedelay_selfmade, VISQOL_timedelay_selfmade] = calculateVISQOL(output_timedelay_selfmade, number_of_files, mixed_signals, operating_frequency);

% Combine into  one table
tables = {VISQOL_frost, VISQOL_mvdr, VISQOL_phaseShift, VISQOL_subband_mvdr, ...
    VISQOL_subband_phaseShift, VISQOL_timedelay, VISQOL_timedelay_selfmade};
All_VISQOL_Values = combineTables(tables);
Average_VISQOL_Values = [average_VISQOL_frost,average_VISQOL_mvdr,average_VISQOL_phaseShift, average_VISQOL_subband_mvdr,...
    average_VISQOL_subband_phaseShift,average_VISQOL_timedelay, average_VISQOL_timedelay_selfmade]';
All_Average_VISQOL_Values = table(Beamformer,Average_VISQOL_Values);

%%%%%%%%%%%%%%%%%%%%%%% END OF ANALYSIS %%%%%%%%%%%%%%%%%%%%%%%%

process_time = toc;
disp(strcat("It took ", num2str(process_time), " seconds to evaluate ", num2str(number_of_files), " files"));

%% Necessary functions

function folder = findfolder(foldername)

current_directory = pwd;
if exist(foldername, "dir") == 7
    folder = strcat(current_directory, "\", foldername);
end

end

function audio_data = readAudio(directory, number_of_files)

folder_info = dir(directory);
current_directory = pwd;
cd(directory);
audio_data = [];

for current_file_number = 3:(number_of_files+2)
    current_audio_data = audioread(folder_info(current_file_number).name);
    audio_data = [audio_data, current_audio_data];
end
cd (current_directory);
end

function [average_contrast, contrast] = calculateContrast(output_beamformer, number_of_files, mixed_signals)

contrast = [];
for current_file = 1:number_of_files

    foreground = output_beamformer(1:size(mixed_signals,1), current_file);
    background = output_beamformer(end-(50000+1):end, current_file);
    rms_foreground = 20*log(rms(foreground));
    rms_background = 20*log(rms(background));
    this_contrast = rms_foreground - rms_background;
    contrast = [contrast, this_contrast];
end

average_contrast = mean(contrast,2);
File_Numbers = (1:number_of_files)';
Contrast_values = contrast';
contrast = table(File_Numbers,Contrast_values);

end

function [average_SNR, SNR] =calculateSNR(output_beamformer, number_of_files, mixed_signals)

SNR = [];
for current_file = 1:number_of_files

    desired_signal = output_beamformer(1:size(mixed_signals,1), current_file);
    noise_signal = output_beamformer(end-(50000+1):end, current_file);
    signal_power = sum(desired_signal.^2) / length(desired_signal);
    noise_power= sum(noise_signal.^2) / length(noise_signal);
    this_SNR = 10 * log10(signal_power / noise_power);
    SNR = [SNR, this_SNR];
end

average_SNR = mean(SNR,2);
File_Numbers = (1:number_of_files)';
SNR_values = SNR';
SNR = table(File_Numbers, SNR_values);
end

function [average_STOI, STOI] =calculateSTOI(output_beamformer, number_of_files, mixed_signals,sampling_frequency)
STOI = [];
for current_file = 1:number_of_files
    reference_signal = mixed_signals(:, current_file);
    processed_signal = output_beamformer(1:size(reference_signal,1),current_file);
    this_stoi = stoi(processed_signal,reference_signal,sampling_frequency);
    STOI = [STOI; this_stoi];
end

average_STOI = mean(STOI,1);
File_Numbers = (1:number_of_files)';
STOI_values = STOI;
STOI = table(File_Numbers, STOI_values);
end

function [average_VISQOL, VISQOL] =calculateVISQOL(output_beamformer, number_of_files, mixed_signals,sampling_frequency)
VISQOL = [];
for current_file = 1:number_of_files
    reference_signal = mixed_signals(:, current_file);
    processed_signal = output_beamformer(1:size(reference_signal,1),current_file);
    this_VISQOL = visqol(processed_signal,reference_signal,sampling_frequency);
    VISQOL = [VISQOL; this_VISQOL];
end

average_VISQOL = mean(VISQOL,1);
File_Numbers = (1:number_of_files)';
VISQOL_values = VISQOL;
VISQOL = table(File_Numbers, VISQOL_values);

end

function finalTable = combineTables(tables)

% Initialize variable names
Beamformer = {'Frost';'MVDR';'PhaseShift';'Subband_MVDR,';'Subband_PhaseShift'; 'Timedelay'; 'Timedelay_Selfmade'};

% Create an empty table for the final result
finalTable = table();

% Loop through each table and add a new column with the variable name
for i = 1:length(tables)
    % Get current table and variable name
    currentTable = tables{i};
    varName = Beamformer{i};

    % Add a new column with the variable name
    currentTable.VarName = repmat({varName}, height(currentTable), 1);

    % Move the new column to the second position
    currentTable = currentTable(:, [1, end, 2:end-1]);
    % Concatenate the current table to the final table
    finalTable = [finalTable; currentTable];
end

end

%% Input stats
[average_contrast_input, contrast_input] = calculateContrast(mixed_signals, number_of_files, mixed_signals);
[average_SNR_input, SNR_input] =calculateSNR(mixed_signals, number_of_files, mixed_signals);
[average_STOI_input, STOI_input] =calculateSTOI(mixed_signals, number_of_files, mixed_signals,operating_frequency);
[average_VISQOL_input, VISQOL_input] =calculateVISQOL(mixed_signals, number_of_files, mixed_signals,operating_frequency);