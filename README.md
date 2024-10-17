# Beamforming_MATLAB

## Table of Contents
* **1. Overview**
* **2. Signal Preparation**
* **3. Beamforming**
* **4. Evaluation**
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

**Additional Notes:**

* Consider providing more specific details about the noise reduction techniques used, along with references or code snippets for clarity.
* Include guidance for users on how to adjust SNR control parameters within the script.

## 2. Beamforming (final_beamforming.m)

This module implements various beamforming algorithms using the pre-processed signals:

* **MVDR Beamformer (Minimum Variance Distortionless Response):** Aims to minimize the output signal's noise power while maintaining a desired response in a specific direction. [Link to a relevant MVDR explanation]
* **Subband MVDR Beamformer:** Extends the MVDR concept to the frequency domain, potentially yielding improved performance in noisy environments. [Link to a Subband MVDR resource]
* **Frost Beamformer:** Leverages a noise covariance matrix to suppress interference while maintaining the desired signal strength. [Link to a Frost Beamformer explanation]
* **Phase Shift Beamformer:** Steers the beam pattern by adjusting the phase shifts introduced to the signals at each sensor element. [Link to a Phase Shift Beamformer resource]
* **Subband Phase Shift Beamformer:** Applies the phase shift approach to different frequency subbands, potentially enhancing performance in scenarios with frequency-dependent noise. [Link to a Subband Phase Shift Beamformer reference]

**Further Considerations:**

* Provide references or code examples for each beamforming algorithm to assist users in understanding their implementation details.
* If applicable, mention any specific parameters or configurations used within the beamformers for optimal performance.

## 3. Evaluation (final_evaluation.m)

This module assesses the performance of the applied beamforming algorithms using the following metrics:

* **Signal-to-Noise Ratio (SNR):** Quantifies the improvement in the desired signal level relative to the background noise after beamforming.
* **Contrast (RMS Difference):** Measures the root mean square (RMS) difference between the desired signal and the interfering noise, indicating the effectiveness of beamforming in separating the desired signal.
* **Perceptual Evaluation of Speech Quality (PESQ) or Perceptual Objective Speech Quality (POLQA):** Standardized metrics that simulate human speech quality perception to evaluate the beamforming's impact on speech intelligibility. [Link to PESQ and/or POLQA resources]
* **Speech Transmission Index (STI):** Assesses speech intelligibility by considering factors like background noise and room acoustics. [Link to STI explanation]

## Using the Repository

**Prerequisites:**

* MATLAB with the Beamforming Toolbox installed

**Installation:**

1. Clone this repository using `git clone https://github.com/your_username/Beamforming_MATLAB.git` (replace `your_username` with your actual GitHub username).
2. Navigate to the project directory: `cd Beamforming_MATLAB`

**Running the Scripts:**

1. Execute the main.m file or run the individual files seperately


