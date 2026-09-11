# Fuzz App

A single-restaurant Flutter ordering app: **Fuzz Kitchen** shows its own
product catalog (menu), and customers browse, favorite, order, track,
and review — all for that one restaurant. Built on top of the icon/
photo assets from the original `FuzzApp-main` asset pack.

## Flow

Splash → Onboarding (3-page walkthrough) → Login / Sign up → **Main app**
(5-tab bottom navigation):

- **Home** — the restaurant's own storefront: cover banner with name,
  tagline, rating/delivery info; search bar; a promo banner; "Chef's
  picks" rail; a category-tabbed full menu grid (Popular / Mains /
  Sides / Drinks / Desserts); and a reviews preview with "See all".
- **Search** — search the menu by name or category, with quick filters
  (Bestsellers / Healthy / Under $5) and recent searches.
- **Orders** — order history with status badges, tap through to order
  detail + 5-star rating, one-tap "Reorder".
- **Favorites** — saved dishes.
- **Profile** — account header, delivery addresses (add/select/default),
  payment methods (add/select/default), notifications, edit profile,
  log out.

Tapping a dish opens **Food detail** (quantity stepper, favorite toggle,
add to cart). The floating cart button leads to **Cart** → **Checkout**
(pick delivery address & payment method, review the order) → **Order
tracking** (animated 4-stage status) → back to Home, with the completed
order now in Order history.

## Project structure

```
lib/
  data/            the restaurant, its full menu, reviews, seeded order
                   history, addresses, payment methods
  models/          FoodItem, Restaurant, Review, Address, PaymentCard,
                   OrderRecord
  screens/         one folder per flow: splash, onboarding, auth, main
                   (bottom-nav shell), home, search, favorites, orders,
                   checkout, tracking, reviews, profile
  state/           CartModel, FavoritesModel, OrdersModel,
                   AddressesModel, PaymentMethodsModel — each a small
                   ChangeNotifier exposed via an InheritedNotifier scope
  theme/           app_theme.dart (colors/typography/category palette),
                   app_assets.dart (asset path constants)
  utils/           cart_helpers.dart (adds to cart with a friendly
                   snackbar)
  widgets/         shared UI: food card, dish & restaurant cover
                   images, promo banner, review/order cards, settings
                   tile, empty state, bottom nav bar
assets/images/food/  all original icons and photos
```

No external state-management package is used — every piece of state is
a small `ChangeNotifier` shared via `InheritedNotifier`.

### Photos vs. icon fallbacks

Only two real food photos ship in the asset pack (the rest are UI icons
and a blank placeholder texture). Rather than show a blank gray box for
a dish without a real photo, `DishThumbnail` and `RestaurantCover` fall
back to a deterministic branded gradient with a category icon (burger,
pizza, ramen bowl, etc.) — every dish still looks intentional. Swap in
real photography by setting `image` on a `FoodItem` in
`lib/data/dummy_restaurants.dart`, or `coverImage` on `kRestaurant`.

## Running it

1. Make sure the Flutter SDK is installed (`flutter --version`).
2. From this folder:
   ```bash
   flutter pub get
   flutter run
   ```

## Customizing for your restaurant

- Rename/restyle the restaurant in `lib/data/dummy_restaurants.dart`
  (`kRestaurant`) — name, tagline, rating, delivery time/fee, promo.
- Edit or add dishes in the same file's `kMenuItems` list — each needs
  an id, name, description, price, category (must be one of
  `kMenuSections`), and optional tags (`Bestseller`, `Healthy`, `New`)
  used by the search filters and card badges.
- Menu categories, reviews, and order history all key off
  `kRestaurant.id`, so they stay in sync automatically.

## Notes / next steps

- All data (menu, reviews, orders, addresses, cards) is in-memory dummy
  data in `lib/data/` — wire up a real backend/API where those files
  are currently read.
- Login/sign-up are demo flows only (no real auth).
- The tracking screen's map is a lightweight illustrative mock (grid +
  icons), not a real map SDK — swap in `google_maps_flutter` or
  `flutter_map` for live geolocation.
