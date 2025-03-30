
# AI-Based Diagnostic Tool for Remote Healthcare

## Overview
This project is an AI-powered diagnostic system designed to assist rural clinics in detecting **Tuberculosis (TB)** and **Malaria** using **symptom analysis** and **image-based diagnosis**. It enables **clinic workers**, **doctors**, and **patients** to collaborate through a mobile and web-based platform for early disease detection and treatment.

## Features
### Clinic Worker App (Flutter)
- Register patients
- Upload diagnostic images (X-rays, blood smears)
- Collect symptoms
- Assign doctors

### Doctor Portal
- View assigned patients
- Review AI-generated reports
- Add final diagnosis and recommendations

### AI-Based Diagnosis
- Uses **pre-trained models** to analyze images
- Evaluates symptoms for risk assessment
- Provides diagnosis with accuracy scores

## Tech Stack
- **Frontend**: Flutter (for mobile apps)
- **Backend**: Flask (Python)
- **Database**: MongoDB (NoSQL)
- **AI/ML**: TensorFlow (for image analysis), OpenCV (for preprocessing)
- **Cloud Storage**: Firebase (for storing diagnostic images)

## Setup Instructions
```

### Frontend (Flutter App)
```sh
cd ../frontend
flutter pub get
flutter run
```

## Future Improvements
- Improve AI model accuracy with real medical datasets
- Implement real-time telemedicine consultations
- Add multi-language support for accessibility




