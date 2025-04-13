
# 👭 MentorBridge Frontend

MentorBridge is an AI-powered mentorship platform designed to help women across all career stages connect with mentors who truly understand them. This repository contains the **Flutter-based frontend** for the MentorBridge platform, supporting both **mobile** and **web** experiences.

---

## 🚀 What It Does

- 🔐 **Auth0 Role-Based Login:** Separate onboarding for mentors and mentees, with safe-mode profile visibility options.
- 🌐 **Explore Mentors:** Swipe-style discovery with AI-generated summaries using Google Gemini.
- 🤖 **AI Matching:** Personalized mentor recommendations refined by Gemini based on experience, tech stack, goals, and communication styles.
- 💬 **In-App Chat:** Real-time messaging powered by StreamChat, integrated with Gemini's message drafting assistant.
- 🧠 **Ask Wall:** Anonymous question board with AI-generated replies and community reactions.
- ✨ **Affirmation Mode:** Daily emotional check-ins with uplifting AI-generated affirmations.
- 🎉 **Celebrate Your Win:** Share and celebrate milestones to build confidence and track growth.

---

## 🧱 Tech Stack

| Layer            | Tech                          |
|------------------|-------------------------------|
| **Frontend**     | Flutter (Web + Mobile)        |
| **Auth**         | Auth0                         |
| **Backend API**  | FastAPI (Python)              |
| **AI Features**  | Google Gemini API             |
| **Messaging**    | StreamChat                    |
| **Storage**      | MongoDB Atlas, AWS S3, DynamoDB |
| **Deployment**   | AWS Lambda (Serverless Framework) |

---

## 🛠 Setup Instructions

### Prerequisites

- Flutter SDK (>=3.10.0)
- Firebase CLI (if testing messaging locally)
- Auth0 Application (with callback/logout URLs set)
- `.env` file for API keys and base URLs

### 1. Clone the Repo

```bash
git clone https://github.com/yourusername/mentorbridge-frontend.git
cd mentorbridge-frontend
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Add Your Environment File

Create a `.env` file in the root directory and include:

```env
AUTH0_DOMAIN=your-auth0-domain
AUTH0_CLIENT_ID=your-client-id
API_BASE_URL=https://your-api-url.amazonaws.com/dev
AUTH0_REDIRECT_URI=com.your_project.app://login-callback
AUTH0_ISSUER=https://dev-your_key.us.auth0.com
#AUTH0_LOGOUT_REDIRECT_URI=com.your_project.app://logout
AUTH0_LOGOUT_REDIRECT_URI=https://your_project.app/logout-callback
STREAM_API_KEY=your_key
STREAM_API_SECRET=your_secret_key
```

You may use [`flutter_dotenv`](https://pub.dev/packages/flutter_dotenv) to load them securely.

### 4. Run Locally

```bash
flutter run -d chrome  # For web
flutter run            # For mobile (iOS/Android)
```

---

## 💡 Project Architecture

- `lib/screens/`: Main UI screens (Explore, Chat, AskWall, Dashboard)
- `lib/services/`: API and Auth0 integration logic
- `lib/widgets/`: Reusable components like mentor cards, reaction chips, etc.
- `lib/models/`: User and message models
- `lib/utils/`: Helpers for themes, scoring, and AI calls

---

## 🤝 Contributing

We welcome contributions to improve the platform for underrepresented voices in tech.

1. Fork the repo
2. Create your branch (`git checkout -b feature-name`)
3. Commit your changes
4. Push and create a PR

---

## 🛡 Security & Privacy

- All AI suggestions are generated without storing personal inputs.
- Mentees can hide profile info using Safe Mode.
- Ask Wall is fully anonymous, and no contact details are ever exposed.

---

## 📬 Contact

Built by [Rashmi B Subhash](https://github.com/rashmisubhash) & [Aneesa Shaik](https://github.com/aneesa2023/).  
Reach out if you'd like to collaborate or join the mission 💜

---

## ⭐️ If you like the project...

Give us a star 🌟 or contribute to help us grow the MentorBridge community!
