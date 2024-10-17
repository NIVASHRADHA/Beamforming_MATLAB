% Load the speech and noise signals
speech_dir = dir('C:\beamforming_HMI\large_data_set\white_noise\clean');
noise_dir = dir('C:\beamforming_HMI\large_data_set\white_noise\white_noise');
speech_signals = [];
for i = 3:size(speech_dir,1)
    filename = strcat(speech_dir(i).folder, '\' , speech_dir(i).name);
    [current_speech_signal, sampling_frequency_speech] = audioread(filename);
    speech_signals = [speech_signals, current_speech_signal];
end

noise_signals = [];
for i = 3:size(noise_dir,1)
    filename = strcat(noise_dir(i).folder, '\' , noise_dir(i).name);
    [current_noise_signal, sampling_frequency_noise] = audioread(filename);
    noise_signals = [noise_signals, current_noise_signal];
end

if sampling_frequency_speech ~= sampling_frequency_noise
    error('Sampling rates of speech and noise signals must be the same');
end

mixed_signals = [];
for i = 1:size(speech_signals,2)
    for j = 1:size(noise_signals,2)
        % Normalize the speech signal to 70 dB SPL
        desired_speech_level_dB = 70; % Desired speech level in dB SPL
        speech_rms = rms(speech_signals(:,i)); % Root Mean Square (RMS) of the speech signal
        speech_level_dB = 20*log10(speech_rms); % Current level in dB
        speech_scaling_factor = 10^((desired_speech_level_dB - speech_level_dB) / 20);
        speech_normalized = speech_signals(:,i) * speech_scaling_factor; % Scaled speech signal to 70 dB SPL

        % Ensure both signals are the same length by padding or truncating
        min_length = min(length(speech_normalized), length(noise_signals(:,j)));
        speech_normalized = speech_normalized(1:min_length);
        noise = noise_signals(:,j);
        noise = noise(1:min_length);

        % Array of desired SNR values
        snr_values = [0];

        % Loop over each SNR value
        for k = 1:length(snr_values)
            snr_db = snr_values(k);
            noise_scaled = scale_noise_for_snr(speech_normalized, noise, snr_db);
            current_mixed_signal = speech_normalized + noise_scaled;

            % Ensure that the combined signal does not clip
            max_mixed = max(abs(current_mixed_signal));
            if max_mixed > 1
                current_mixed_signal = current_mixed_signal / max_mixed;
            end
            mixed_signals = [current_mixed_signal, mixed_signals];
            % Save the resulting signal
            % filename = sprintf('combined_signal_%d_dB_SNR.wav', snr_db);
            % audiowrite(filename, combined_signal, fs);

            % Display the RMS values for verification
            % fprintf('SNR: %d dB\n', snr_db);
            % fprintf('Speech RMS (normalized to 70 dB SPL): %f\n', rms(speech_normalized));
            % fprintf('Noise RMS for %d dB SNR: %f\n', snr_db, rms(noise_scaled));
            % fprintf('ratio: %d dB\n', (rms(speech_normalized)/rms(noise_scaled)));

        end


        if j == size(noise_signals,2)
            break;
        end


    end
end

ratios = zeros(100,1); stoi_values = zeros(100,1);
for i = 1: size(mixed_signals,2)
    filename = sprintf('mixed_signal_%d_dB_SNR_%d.wav', snr_db, i);
    audiowrite(filename, mixed_signals(:,i), sampling_frequency_noise);
    ratios(i,1) =  rms(speech_normalized)/rms(noise_scaled);
   % stoi_values(i,1) =  stoi(current_mixed_signal,speech_normalized,sampling_frequency_noise);
end

[microphone_signal_1, microphone_signal_2] = addChannel(mixed_signals, sampling_frequency_speech, size(mixed_signals,2));

% Function to scale noise for desired SNR
function noise_scaled = scale_noise_for_snr(speech, noise, snr_db)
speech_rms = rms(speech);
noise_rms = speech_rms / (10^(snr_db / 20));
noise_scaling_factor = noise_rms / rms(noise);
noise_scaled = noise * noise_scaling_factor;
end

function [microphone_signal_1, microphone_signal_2] = addChannel(mixed_signals, sampling_frequency_speech, number_of_files)

% Calculated delay for XMOS microphone with inter-mic spacing of 33.33 mm

delay = 97.2e-6;
number_of_samples_to_shift = round(sampling_frequency_speech*delay);
microphone_signal_1 = mixed_signals;
microphone_signal_2 = [];

for current_file_number = 1: number_of_files

    current_mixed_signal = (mixed_signals(:, current_file_number));
    shifted_signal = [zeros(number_of_samples_to_shift,1); current_mixed_signal];

    microphone_signal_2 = [microphone_signal_2, shifted_signal];

end
end

