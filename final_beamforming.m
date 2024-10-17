% Define the microphone properties for beamforming

microphone = phased.CustomMicrophoneElement;
number_of_microphones = 2;
microphone_spacing = 0.03333;
microphone_array = phased.ULA('Element',microphone,'NumElements',...
    number_of_microphones, 'ElementSpacing',microphone_spacing);
operating_frequency = sampling_frequency_speech;
number_of_files = size(microphone_signal_1,2);

% Create folders to save the output signals of the beamformers seperately

createfolder('output_Frost');
createfolder('output_Subband_MVDR');
createfolder('output_Time_Delay');
createfolder('output_Subband_PhaseShift');
createfolder('output_MVDR');
createfolder('output_PhaseShift');
createfolder('output_Time_Delay_Selfmade');

% Beamforming
tic
for current_file_number = 1:size(mixed_signals,2)
   
    input_signal = [microphone_signal_1(:,current_file_number), ...
        microphone_signal_2(1:size(microphone_signal_1,1),current_file_number)];

    % Set 1: Wideband beamformers

    % Beamformer 1.1 : Frost beamformer
    frostBeamformer(microphone_array, input_signal, operating_frequency, current_file_number);

    % Beamformer 1.2 : Subband MVDR Beamformer
    subbandMVDRBeamformer(microphone_array, input_signal, operating_frequency, current_file_number);
    
    % Beamformer 1.3 : Time delay Beamformer
    timeDelayBeamformer(microphone_array, input_signal, operating_frequency, current_file_number);
    
    % Beamfoermer 1.4: Time delay -Self made
    timeDelaySelfmadeBeamformer(input_signal, operating_frequency, current_file_number)
    
    % Beamformer 1.5 : Subband Phase shift Beamformer
    subbandPhaseshiftBeamformer(microphone_array, input_signal, operating_frequency, current_file_number);
    
    % Set 2: Narrowband beamformers
    % Beamformer 2.1 : MVDR beamformer
    mvdrBeamformer(microphone_array, input_signal, operating_frequency, current_file_number);
    
    % Beamformer 2.2 : Phase shift beamformer
    phaseShiftBeamformer(microphone_array, input_signal, operating_frequency, current_file_number);

end
process_time = toc;
disp("Beamforming completed!");
disp(strcat("It took ", num2str(process_time), " seconds for the beamforming of ", num2str(number_of_files), " files"));

%% Necessary functions

% Delete all the '.wav' files to avoid mistakes while overwriting

function deleteWavFiles(directory)

current_directory = pwd;
cd (directory);
wavFiles = dir(fullfile('*.wav'));
for k = 1:length(wavFiles)
    filePath = fullfile(wavFiles(k).name);
    delete(filePath);
end
cd (current_directory);
end

% create folders for beamforming output. If the folder already exist, it will be deleted.

function createfolder(foldername)
current_directory = pwd;
if exist(foldername, "dir") == 7
    directory_to_remove = strcat(current_directory, '\', foldername);
    deleteWavFiles(directory_to_remove);
    rmdir(directory_to_remove);
end
mkdir(foldername);
end

% Frost Beamformer

function frostBeamformer(microphone_array, input_signal, operating_frequency, current_file_number)

beamformer = phased.FrostBeamformer ("SensorArray",microphone_array, "SampleRate",44.1e3);
beamformer_output = beamformer(input_signal);
filename = strcat("beamformer_output_Frost_",num2str(current_file_number), ".wav");
current_directory = pwd;
cd output_Frost\
audiowrite(filename,beamformer_output,operating_frequency);
cd(current_directory);

end

% Subband MVDR Beamformer

function subbandMVDRBeamformer(microphone_array, input_signal, operating_frequency, current_file_number)

beamformer = phased.SubbandMVDRBeamformer ("SensorArray",microphone_array, "SampleRate",44.1e3);
beamformer_output = beamformer(input_signal);
filename = strcat("beamformer_output_subband_mvdr",num2str(current_file_number), ".wav");
current_directory = pwd;
cd output_Subband_MVDR\
audiowrite(filename,beamformer_output,operating_frequency);
cd(current_directory);

end

% Time Delay Beamformer
function timeDelayBeamformer(microphone_array, input_signal, operating_frequency, current_file_number)

beamformer = phased.TimeDelayBeamformer("SensorArray",microphone_array, "SampleRate",44.1e3);
beamformer_output = beamformer(input_signal);
filename = strcat("beamformer_output_timedelay_",num2str(current_file_number), ".wav");
current_directory = pwd;
cd output_Time_Delay\
audiowrite(filename,beamformer_output,operating_frequency);
cd(current_directory);

end

% Time Delay Selfmade Beamformer
function timeDelaySelfmadeBeamformer(input_signal, operating_frequency, current_file_number)

added_signal = input_signal(:,1) + input_signal(:, 2);
normalized_signal = added_signal/2;
filename = strcat("beamformer_output_timedely_selfmade_",num2str(current_file_number), ".wav");
current_directory = pwd;
cd output_Time_Delay_Selfmade\
audiowrite(filename,normalized_signal,operating_frequency);
cd(current_directory);

end

% Subband Phase shift Beamformer

function subbandPhaseshiftBeamformer(microphone_array, input_signal, operating_frequency, current_file_number)

beamformer = phased.SubbandPhaseShiftBeamformer("SensorArray",microphone_array, "SampleRate",44.1e3);
beamformer_output = beamformer(input_signal);
filename = strcat("beamformer_output_SubbandPhaseShift_",num2str(current_file_number), ".wav");
current_directory = pwd;
cd output_Subband_PhaseShift\
audiowrite(filename,beamformer_output,operating_frequency);
cd(current_directory);

end

% MVDR Beamformer

function mvdrBeamformer(microphone_array, input_signal, operating_frequency, current_file_number)

beamformer = phased.MVDRBeamformer("SensorArray",microphone_array);
beamformer_output = beamformer(input_signal);
filename = strcat("beamformer_output_mvdr_",num2str(current_file_number), ".wav");
current_directory = pwd;
cd output_MVDR\
audiowrite(filename,beamformer_output,operating_frequency);
cd(current_directory);

end

% Phase shift beamformer

function phaseShiftBeamformer(microphone_array, input_signal, operating_frequency, current_file_number)

beamformer = phased.PhaseShiftBeamformer("SensorArray",microphone_array);
beamformer_output = beamformer(input_signal);
filename = strcat("beamformer_output_phaseshift_",num2str(current_file_number), ".wav");
current_directory = pwd;
cd output_PhaseShift\
audiowrite(filename,beamformer_output,operating_frequency);
cd(current_directory);

end

