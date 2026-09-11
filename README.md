# Fuzz App

A Flutter food-ordering UI: onboarding → login → home/menu → food detail →
cart → live order tracking. Built on top of the icon and photo assets from
the original `FuzzApp-main` asset pack.

## Screens

- **Splash** – brand intro, auto-advances.
- **Onboarding** – 3-page walkthrough (`food_ic_walk1/2/3.svg`) with a
  skip button and progress dots.
- **Login** – email/password form plus Google, Facebook, and WhatsApp
  sign-in buttons.
- **Home** – greeting header, cart badge, search bar, category filter
  chips, and a two-column menu grid.
- **Food detail** – hero image, rating/prep-time/category pills,
  description, quantity stepper, add-to-cart bar.
- **Cart** – editable line items, subtotal/delivery/total summary,
  checkout button.
- **Order tracking** – animated 4-stage progress bar (confirmed →
  preparing → on the way → delivered), rider card, and a lightweight
  map mock built from the bundled compass/delivery/pin assets.

## Project structure

```
lib/
  data/            dummy in-memory menu data
  models/          FoodItem, CartLine
  screens/         one folder per flow (splash, onboarding, auth, home,
                   food_detail, cart, tracking)
  state/           CartModel (ChangeNotifier) + CartScope (InheritedNotifier)
  theme/           app_theme.dart (colors/typography), app_assets.dart
                   (asset path constants)
  widgets/         shared UI pieces (buttons, food card, category chip)
assets/images/food/  all original icons and photos
```

No external state-management package is used — cart state is a small
`ChangeNotifier` shared via `InheritedNotifier`, so the whole app stays
easy to follow.

## Running it

1. Make sure the Flutter SDK is installed (`flutter --version`).
2. From this folder:
   ```bash
   flutter pub get
   flutter create .
   flutter run -d chrome
   ```

## Notes / next steps

- Menu photos reuse the two bundled stock photos (`placeholder.jpg`,
  `recipes.png`) across multiple dishes — swap in real dish photography
  per item when you have it.
- Login and checkout are wired for the demo flow (no real backend/auth);
  hook up your API of choice where `_continue()` / order submission
  happens.
- The tracking screen's map is a lightweight illustrative mock (grid +
  icons), not a real map SDK — swap in `google_maps_flutter` or
  `flutter_map` if you want live geolocation.
