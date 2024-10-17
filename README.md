# Beamforming_MATLAB

## Table of Contents
* **Overview**
* **Signal Preparation**
* **Beamforming**
* **Evaluation**
* **Using the Repository**
    * **Prerequisites**
    * **Installation**
    * **Running the Scripts**

 ## 1. Overview
This project provides a systematic implementation and evaluation of beamforming algorithms, specifically tailored for speech processing applications. Beamforming is a signal processing technique used to control the directionality of signal reception or transmission, and it is crucial in applications like speech enhancement, noise suppression, and direction-of-arrival (DOA) estimation.

The project leverages MATLAB's powerful Phased Array System Toolbox and the Signal Processing Toolbox to develop and test multiple beamforming techniques. The project is divided into three main stages:

1. Signal Preparation
2. Beamforming Implementation
3. Evaluation

## 1. Signal Preparation (final_sig_prep.m)

This module prepares the input signals that will be processed by the beamformers. Key functionalities include:

* **Organizing Audio Files:** Script handles efficient organization of your audio files, ensuring proper file handling.
* **Format Validation:** Ensures that the audio files are in a compatible format for processing by the beamformers.
* **Noise Reduction:** Techniques like spectral subtraction or filtering are employed to remove unwanted background noise, improving speech intelligibility.
* **Signal-to-Noise Ratio (SNR) Control:** To effectively test the robustness of the beamforming algorithms, speech commands can be mixed with controlled levels of noise signals. This allows for evaluating performance under different noise conditions.

## 2. Beamforming (final_beamforming.m)

This module implements various beamforming algorithms using the pre-processed signals:

* **MVDR Beamformer (Minimum Variance Distortionless Response):** Aims to minimize the output signal's noise power while maintaining a desired response in a specific direction.
* **Subband MVDR Beamformer:** Extends the MVDR concept to the frequency domain, potentially yielding improved performance in noisy environments. 
* **Frost Beamformer:** Leverages a noise covariance matrix to suppress interference while maintaining the desired signal strength.
* **Phase Shift Beamformer:** Steers the beam pattern by adjusting the phase shifts introduced to the signals at each sensor element.
* **Subband Phase Shift Beamformer:** Applies the phase shift approach to different frequency subbands, potentially enhancing performance in scenarios with frequency-dependent noise.

## 3. Evaluation (final_evaluation.m)

This module assesses the performance of the applied beamforming algorithms using the following metrics:

* **Signal-to-Noise Ratio (SNR):** Quantifies the improvement in the desired signal level relative to the background noise after beamforming.
* **Contrast (RMS Difference):** Measures the root mean square (RMS) difference between the desired signal and the interfering noise, indicating the effectiveness of beamforming in separating the desired signal.
* **STOI (Short-Time Objective Intelligibility)**: Quantifies the intelligibility of speech, especially in noisy conditions.
* **VISQOL (Virtual Speech Quality Objective Listener)**: Assesses speech quality from a perceptual perspective.

## Using the Repository

**Prerequisites:**

* MATLAB with the Beamforming Toolbox installed

**Installation:**

1. Clone this repository using `git clone https://github.com/your_username/Beamforming_MATLAB.git` (replace `your_username` with your actual GitHub username).
2. Navigate to the project directory: `cd Beamforming_MATLAB`

**Running the Scripts:**

1. Execute the main.m file or run the individual files seperately


