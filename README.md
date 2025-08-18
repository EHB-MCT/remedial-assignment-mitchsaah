[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/BhMy8Rjk)
# Portfolio - Weather-Economy App (SwiftUI + Firebase)

## 1. Project overview
I made this app to simulate an energy economy for users based on local weather. Users authenticate, set location & solar prefs, and the app calculates expected generation using real time weather data.

- **Persistence:** Firebase Firestore (users, preferences, readings)
- **External data:** OpenWeather (3.0) for forecast/solar inputs
- **Platform:** iOS (SwiftUI), FirebaseAuth, Firestore, Google Sign-In

## 2. Branch strategy
### setup/dependencies
- AddedSPM packages (Firebase/Auth/Firestore, GoogleSignIn, Alamofire, OpenWeather)
- Configured GoogleService-Info.plist
- AppDelegate calls FirebaseApp.configure()
- Added a gitignore to exclude files like google-service.plist

### feature/auth-base
- This was the branch that I used as a main branch for the user-authentication, so I nested these into:
  #### feature/auth/email-password-base:
  I also used this one as a main branch for everything concering the email/password authentication
  - #### feature/auth/email-password/userprofile
    → This was to track a proper domain user model (profile doc in Firestore) and wire app state to it, so UI can react to “is the user fully set up?” and redirect to the dashboard when signed in.
    ##### Key commits
    - **Added an auth state listener handle:** I needed it to react to Auth sign-in/out changes centrally
    - **Added didFinishSetup with debug logging:** UI should know if the user profile exists/was loaded
    - **Imported Firestore and implement profile check:** This was to determine whether the user already has a profile document
    - **Injected AppState into SwiftUI environment:** I allowed all views to observe auth/profile changes without manual prop drilling
    - **Created AuthService:** Creates Firebase account for user, a profile document and calls a completion(error) so the ViewModel can surface errors to the UI
  - #### feature/auth/email-password/authviewmodel
    → Introduces a dedicated ViewModel to handle email/password flows, input validation, and error surfacing keeping SwiftUI views dumb and the service layer thin
    ##### Key commits
    - **Added login state & fields:** isLogin toggles between Login to Register modes (and vice versa) in the UI
    - **Implemented submit + validation:** Implements submit() in AuthViewModel with basic input checks. It blocks empty email/password, and in register mode ensures the two passwords match. Depending on isLogin, it calls AuthService.signIn or AuthService.signUp. Any failures are captured and published to errorMessage on the main thread so the UI can display clear feedback.
  - #### feature/auth/email-password/UI
    Adds a focused SwiftUI screen bound to AuthViewModel via @StateObject. The view presents a simple header with a circular logo, a dynamic title (“Login”/“Register”), and a minimal form: email and password fields plus a confirm-password field that only appears in register mode. Fields use proper keyboard and capitalization settings, with subtle rounded borders for clarity. A full-width primary button triggers vm.submit(), and any backend/validation errors are shown inline via vm.errorMessage. A footer action lets the user toggle between Login and Register, clearing errors as the mode changes. The layout uses neutral system colors and full-width controls to keep attention on functionality, in line with the development-first requirements.

### feature/auth-google-login-base
  - **AuthService.signInWithGoogle(idToken, accessToken):** Exchanges tokens with Firebase; if it’s the first time, creates users/{uid} (idempotent).
  - **AppDelegate URL handling:** Adds GIDSignIn.sharedInstance.handle(url) and URL Scheme (REVERSED_CLIENT_ID).
	- **AuthViewModel.googleSignIn():** Configures clientID from Firebase, presents the Google sheet, exchanges tokens, sets loading/error states.

## feature/economy/solar-simulation
### feature/economy/user-preferences (onboarding)
  - **LocationPickerView:** Search by query (geocoding) or Use Current Location (CoreLocation). Aligns search field with the results list.
	- **SolarPrefsForm:** Capacity (kWp), efficiency, tariff (€ / kWh).
	- **OnboardingView:** Two steps (Location, then Solar). Calls onCompleted(location, prefs) to persist under users/{uid}/prefs/solar.
   → With the user's preferences, this will determine their estimated spending based on the weather.

## Sources
- https://firebase.google.com/docs/auth
- https://firebase.google.com/docs/firestore
- https://medium.com/@0xLeif/appstate-5a1037ec9ce2
- https://firebase.google.com/docs/rules
- https://developer.apple.com/documentation/swiftui/building-layouts-with-stack-views
- https://developer.apple.com/documentation/swiftui/geometryreader
- https://developer.apple.com/documentation/corelocation/getting-the-current-location-of-a-device
- https://openweathermap.org/api/one-call-3
- https://developer.apple.com/design/human-interface-guidelines/sf-symbols
- https://developers.google.com/identity/sign-in/ios/sign-in
- https://developer.apple.com/documentation/swiftdata/model()
- https://developer.apple.com/documentation/Swift/Decodable

## Firestore data model

```text
users/{uid}
  uid: string
  email: string
  firstName?: string
  lastName?: string
  createdAt: serverTimestamp

users/{uid}/prefs/solar
  lat: number
  lon: number
  cityName: string
  capacityKwp: number
  efficiency: number
  tariffEurPerKwh: number
  updatedAt: serverTimestamp

users/{uid}/readings/{yyyy-MM-dd}   # optional daily cache
  date: string (YYYY-MM-DD)
  estimatedKwh: number
  estimatedValueEur: number
  inputs: { ghi?: number, cloud?: number, temp?: number }



