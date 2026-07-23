# Analytics Tracking — Mixpanel

This project uses **Mixpanel** for all product analytics. Mixpanel is the single source of truth for event tracking, user identification, and behavioral data. Do not introduce any other analytics tools, SDKs, or tracking libraries without explicit instruction from a user.

---

## Before You Add or Modify Any Tracking

⛔ **Do not write Mixpanel tracking code without reading this file first.**

Wrong assumptions about platform, identity, or consent will produce broken Mixpanel data that requires manual cleanup or data deletion requests.

### Mandatory checklist before writing any Mixpanel code

- [ ] Confirm you are using the correct Mixpanel SDK for this project's platform (see Tech Stack below)
- [ ] Check if this project routes data through a CDP — if yes, send Mixpanel events through the CDP, not the Mixpanel SDK directly
- [ ] Check if consent gating is required — if this project serves EU or California users, no Mixpanel events may fire before user consent
- [ ] Review the existing Mixpanel tracking plan below before adding new events

---

## Tech Stack

| Detail | Value |
|---|---|
| **Platform** | Flutter (iOS / Android / Web) |
| **Mixpanel SDK** | `mixpanel_flutter` |
| **SDK version** | `^2.12.0` |
| **Tracking method** | client-side |
| **CDP (if any)** | none |
| **Consent required** | no (no EU/CA users at Quick Start) |
| **Mixpanel project token location** | `lib/services/analytics_service.dart` → `AnalyticsService.projectToken` (override with `--dart-define=MIXPANEL_TOKEN=...`) |

---

## Mixpanel Initialization

Mixpanel is initialized in:

**File:** `lib/services/analytics_service.dart`
**Called from:** `lib/main.dart` via `await AnalyticsService.init()`

```dart
// Mixpanel is initialized once at app startup
// Do not create additional Mixpanel instances
// Track events through AnalyticsService helpers — do not import Mixpanel in feature files
```

**Do not:**
- Initialize Mixpanel in multiple places
- Create separate Mixpanel instances per component or module
- Import `mixpanel_flutter` directly in feature files — use `AnalyticsService`

---

## Mixpanel Identity

This app has **no authentication**. Users remain anonymous under Mixpanel's auto-generated `distinct_id`.

| Action | When to call | Code location |
|---|---|---|
| `mixpanel.identify(user_id)` | Not used — no login/signup | N/A |
| `mixpanel.reset()` | Not used — no logout | N/A |

If auth is added later:
- Call `identify()` with a stable internal user ID (never email) after the user record exists
- Call `reset()` on every logout path

---

## Mixpanel Tracking Plan

These are the Mixpanel events currently tracked in this project. **All new Mixpanel events must follow the same conventions.**

### Naming conventions

- Mixpanel event names: `snake_case`, past tense verb + noun (e.g., `report_generated`, `item_added_to_cart`)
- Mixpanel property names: `snake_case` (e.g., `sign_up_method`, `plan_type`)
- No abbreviations in Mixpanel event or property names — use full words
- Boolean Mixpanel properties: use `is_` prefix (e.g., `is_gold_rate_set`)

### Current Mixpanel events

| Mixpanel Event | Trigger | Key Properties | File |
|---|---|---|---|
| `app_opened` | App finishes Mixpanel init at startup | (none custom — Mixpanel auto-sends `$os`, `mp_lib`, device, app version, geo, etc.) | `lib/services/analytics_service.dart` |
| `conversion_completed` | User taps Calculate with at least one weight input | `input_units_used`, `rate_unit`, `is_gold_rate_set` | `lib/converter_screen.dart` → `calculateAll()` |
| `language_changed` | User picks a different language in settings | `language`, `previous_language` | `lib/providers/locale_provider.dart` |
| `theme_changed` | User toggles dark/light theme | `theme_mode`, `previous_theme_mode` | `lib/providers/theme_provider.dart` |

### Mixpanel People properties

Set at app start via `AnalyticsService.syncUserPreferences`, and updated on change:

| Property | Values | Meaning |
|---|---|---|
| `preferred_language` | `en`, `ur`, `ur_ro`, `sd`, … | Last selected app language |
| `theme_mode` | `light`, `dark`, `system` | Last selected theme preference |

Do **not** send a custom `platform` property. Mixpanel already provides `$os` (e.g. `Android`, `iOS`) and `mp_lib` (`flutter`).

---

## How to Add a New Mixpanel Event

1. **Check the tracking plan above** — if the Mixpanel event already exists, use it. Do not create duplicate Mixpanel events.
2. **Name the Mixpanel event** using the conventions above: `snake_case`, past tense, descriptive.
3. **Define Mixpanel properties** — only include properties available at the moment the event fires. Do not fetch additional data just for Mixpanel tracking.
4. **Place the Mixpanel tracking call** at the right moment:
   - Track Mixpanel events **after** the action succeeds, not on empty/invalid input
   - Prefer adding a helper on `AnalyticsService` rather than calling Mixpanel directly
5. **Update this file** — add the new Mixpanel event to the tracking plan table above.
6. **Verify in Mixpanel Live View** — confirm the event appears in Mixpanel with correct properties before considering it done.

### Mixpanel event template

```dart
// Prefer a named helper on AnalyticsService
AnalyticsService.instance?.track('event_name', properties: {
  'property_name': value,
});
```

---

## What Not to Do

- **Do not introduce other analytics tools.** This project uses Mixpanel. All tracking goes through Mixpanel.
- **Do not track Mixpanel events on every keystroke** — conversion is tracked on Calculate tap only.
- **Do not track PII as Mixpanel properties** — no emails, full names, phone numbers, IP addresses, or payment details in Mixpanel event properties.
- **Do not fire Mixpanel events inside loops** — each Mixpanel event call is a network request.
- **Do not hardcode a second Mixpanel project token** — use `AnalyticsService.projectToken` / `--dart-define=MIXPANEL_TOKEN`.
- **Do not skip `mixpanel.reset()` on logout** if auth is added later — failing to reset merges the next user's events with the previous profile.
- **Do not call `mixpanel.identify()` before the user is authenticated** — premature identification creates orphaned Mixpanel profiles.
