1. Signal Preparation <a name="signal-preparation"></a>
File: final_sig_prep.m

In this stage, the input audio signals are prepared for beamforming. This process includes:

Audio File Organization: Loading and organizing speech files in a suitable format (e.g., .wav).
Noise Reduction: Preprocessing techniques are applied to reduce background noise in the audio signals.
SNR Adjustment: To test the robustness of the beamformers, speech signals are mixed with noise at specific Signal-to-Noise Ratios (SNR). SNR is a measure of how much the desired signal stands out from the background noise.
