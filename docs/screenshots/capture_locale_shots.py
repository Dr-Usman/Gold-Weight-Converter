#!/usr/bin/env python3
"""Capture Play Store screenshots for localized listings via adb.

Prereq: app installed with HIDE_ADS + SCREENSHOT_DEMO.

Usage:
  python3 docs/screenshots/capture_locale_shots.py
  python3 docs/screenshots/capture_locale_shots.py india pakistan
"""

from __future__ import annotations

import json
import os
import subprocess
import sys
import time
from pathlib import Path

DEVICE = os.environ.get("ANDROID_SERIAL", "emulator-5554")
PACKAGE = "com.avenzor.gold_weight_converter"
ACTIVITY = f"{PACKAGE}/.MainActivity"
PROJECT = Path(__file__).resolve().parents[2]

# Pixel 9 (1080x2424) tap targets — LTR calibrated; RTL mirrors X for Urdu
W = 1080
TAP_LTR = {
    "menu": (74, 216),
    "drawer_zakat": (399, 441),
    "drawer_history": (399, 590),
    "drawer_language": (399, 1058),
    "outside_drawer": (980, 1200),
}
TAP_RTL = {k: (W - x, y) for k, (x, y) in TAP_LTR.items()}

LOCALES = {
    "india": {
        "folder": "india",
        "locale_code": "hi",
        "language": "hi",
        "currency": "INR",
        "rate": "150,000",
    },
    "pakistan": {
        "folder": "pakistan",
        "locale_code": "ur",
        "language": "ur",
        "currency": "PKR",
        "rate": "438,000",
        "rtl": True,
    },
    "bangladesh": {
        "folder": "bangladesh",
        "locale_code": "bn",
        "language": "bn",
        "currency": "BDT",
        "rate": "190,800",
    },
    "nepal": {
        "folder": "nepal",
        "locale_code": "ne",
        "language": "ne",
        "currency": "NPR",
        "rate": "292,800",
    },
}


def adb(*args: str, check: bool = True) -> subprocess.CompletedProcess:
    return subprocess.run(
        ["adb", "-s", DEVICE, *args],
        check=check,
        capture_output=True,
    )


def sh(cmd: str, check: bool = True) -> None:
    adb("shell", cmd, check=check)


def tap(x: int, y: int, pause: float = 0.7) -> None:
    sh(f"input tap {x} {y}")
    time.sleep(pause)


def swipe(x1: int, y1: int, x2: int, y2: int, dur_ms: int = 400) -> None:
    sh(f"input swipe {x1} {y1} {x2} {y2} {dur_ms}")
    time.sleep(0.6)


def back(pause: float = 0.8) -> None:
    sh("input keyevent KEYCODE_BACK")
    time.sleep(pause)



def shot_name(cfg: dict, stem: str) -> str:
    """e.g. 01-converter-inputs + hi -> 01-converter-inputs-hi.png"""
    return f"{stem}-{cfg['locale_code']}.png"

def write_prefs(cfg: dict) -> None:
    rate = cfg["rate"]
    nepali = cfg["language"] == "ne" or cfg["currency"] == "NPR"
    if nepali:
        history = [
            {
                "id": "shot-demo-1",
                "timestamp": "2026-10-08T12:00:00.000000",
                "inputs": {"tola": 1.5, "lal": 25.0, "ana": 7.0},
                "gold_rate": float(rate.replace(",", "")),
                "rate_unit": "Tola",
                "currency_code": cfg["currency"],
                "total_grams": 25.5063,
                "total_tola": 2.1875,
                "price_formatted": f"Rate: {rate} per Tola",
                "result_text": "Demo conversion",
                "is_nepali_system": True,
            },
            {
                "id": "shot-demo-2",
                "timestamp": "2026-10-08T11:30:00.000000",
                "inputs": {"ana": 3.0, "lal": 10.0},
                "gold_rate": float(rate.replace(",", "")),
                "rate_unit": "Tola",
                "currency_code": cfg["currency"],
                "total_grams": 3.3523,
                "total_tola": 0.2875,
                "price_formatted": f"Rate: {rate} per Tola",
                "result_text": "Demo conversion 2",
                "is_nepali_system": True,
            },
        ]
    else:
        history = [
            {
                "id": "shot-demo-1",
                "timestamp": "2026-10-08T12:00:00.000000",
                "inputs": {"tola": 1.5, "masha": 4.0, "ana": 7.0, "ratti": 18.0},
                "gold_rate": float(rate.replace(",", "")),
                "rate_unit": "Tola",
                "currency_code": cfg["currency"],
                "total_grams": 28.6663,
                "total_tola": 2.4585,
                "price_formatted": f"Rate: {rate} per Tola",
                "result_text": "Demo conversion",
                "is_nepali_system": False,
            },
            {
                "id": "shot-demo-2",
                "timestamp": "2026-10-08T11:30:00.000000",
                "inputs": {"ana": 3.0, "ratti": 4.0},
                "gold_rate": float(rate.replace(",", "")),
                "rate_unit": "Tola",
                "currency_code": cfg["currency"],
                "total_grams": 2.6723,
                "total_tola": 0.2292,
                "price_formatted": f"Rate: {rate} per Tola",
                "result_text": "Demo conversion 2",
                "is_nepali_system": False,
            },
        ]
    zakat_items = [
        {
            "id": "shot-zakat-1",
            "name": "Ring",
            "weight": 2.4,
            "unit": "gram",
            "purity": "karat22",
            "customKarat": None,
        }
    ]
    prefs = {
        "flutter.language_code": cfg["language"],
        "flutter.currency_code": cfg["currency"],
        "flutter.theme_mode": cfg.get("theme_mode", "light"),
        "flutter.converter_gold_rate": rate,
        "flutter.zakat_gold_rate": rate,
        "flutter.converter_rate_unit": "Tola",
        "flutter.zakat_rate_unit": "Tola",
        "flutter.ad_free_until": "2026-12-31T00:00:00.000",
        "flutter.conversion_history": json.dumps(history, ensure_ascii=False),
        "flutter.zakat_gold_items": json.dumps(zakat_items, ensure_ascii=False),
    }
    lines = ["<?xml version='1.0' encoding='utf-8' standalone='yes' ?>", "<map>"]
    for k, v in prefs.items():
        esc = (
            str(v)
            .replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace('"', "&quot;")
            .replace("'", "&apos;")
        )
        lines.append(f'    <string name="{k}">{esc}</string>')
    lines.append("</map>")
    xml_body = "\n".join(lines)
    r = subprocess.run(
        [
            "adb",
            "-s",
            DEVICE,
            "shell",
            f"run-as {PACKAGE} sh -c 'cat > shared_prefs/FlutterSharedPreferences.xml'",
        ],
        input=xml_body.encode("utf-8"),
        capture_output=True,
    )
    if r.returncode != 0:
        raise RuntimeError(f"Failed writing prefs: {r.stderr!r}")


def wait_past_splash(min_kb: int = 200, tries: int = 15) -> None:
    """Poll screencap size until UI (not splash) is on screen."""
    tmp = PROJECT / ".tmp_splash_probe.png"
    for i in range(tries):
        swipe(540, 700, 540, 1500, 200)
        time.sleep(1.0)
        data = subprocess.check_output(
            ["adb", "-s", DEVICE, "exec-out", "screencap", "-p"]
        )
        if not data.startswith(b"\x89PNG"):
            data = data.replace(b"\r\n", b"\n")
        tmp.write_bytes(data)
        kb = tmp.stat().st_size // 1024
        if kb >= min_kb:
            tmp.unlink(missing_ok=True)
            time.sleep(0.6)
            return
        print(f"  splash wait {i + 1}: {kb} KB")
    tmp.unlink(missing_ok=True)
    print("  [WARN] splash wait timed out")


def restart_app(settle: float = 5.0) -> None:
    sh(f"am force-stop {PACKAGE}")
    time.sleep(1.2)
    sh(f"am start -n {ACTIVITY}")
    time.sleep(settle)
    wait_past_splash()


def screencap(path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    data = subprocess.check_output(["adb", "-s", DEVICE, "exec-out", "screencap", "-p"])
    if not data.startswith(b"\x89PNG"):
        data = data.replace(b"\r\n", b"\n")
    path.write_bytes(data)
    kb = path.stat().st_size // 1024
    print(f"  saved {path.relative_to(PROJECT)} ({kb} KB)")
    if kb < 180:
        print("  [WARN] file looks like splash/blank — may need retry")


def capture_locale(key: str, cfg: dict) -> None:
    folder = PROJECT / "docs" / "screenshots" / cfg["folder"]
    taps = TAP_RTL if cfg.get("rtl") else TAP_LTR
    print(f"\n=== {key} ({cfg['language']}/{cfg['currency']} @ {cfg['rate']}/tola) ===")

    # Light theme shots
    write_prefs({**cfg, "theme_mode": "light"})
    restart_app(settle=9.0)

    # 01 converter inputs
    swipe(540, 600, 540, 1900, 300)
    swipe(540, 600, 540, 1900, 300)
    time.sleep(0.5)
    screencap(folder / shot_name(cfg, "01-converter-inputs"))

    # 02 results + price
    swipe(540, 1800, 540, 400, 450)
    swipe(540, 1800, 540, 500, 450)
    time.sleep(0.5)
    screencap(folder / shot_name(cfg, "02-results-and-price"))

    # 03 zakat — match English: full disclaimer at top (do not leave scrolled down)
    tap(*taps["menu"], pause=1.0)
    tap(*taps["drawer_zakat"], pause=1.2)
    tap(540, 1450, pause=1.0)  # calculate zakat
    for _ in range(5):
        swipe(540, 700, 540, 2000, 250)
    time.sleep(0.5)
    screencap(folder / shot_name(cfg, "03-gold-zakat"))
    back()

    # 04 history
    tap(*taps["menu"], pause=1.0)
    tap(*taps["drawer_history"], pause=1.2)
    screencap(folder / shot_name(cfg, "04-conversion-history"))
    back()

    # 05 languages
    tap(*taps["menu"], pause=1.0)
    tap(*taps["drawer_language"], pause=1.2)
    screencap(folder / shot_name(cfg, "05-languages"))
    back()

    # 06 dark converter — match English: form top (Tola/Lal first), not mid-scroll
    write_prefs({**cfg, "theme_mode": "dark"})
    restart_app(settle=5.0)
    for _ in range(6):
        swipe(540, 700, 540, 2000, 250)
    time.sleep(0.5)
    screencap(folder / shot_name(cfg, "06-dark-converter-inputs"))
    dark = folder / shot_name(cfg, "06-dark-converter-inputs")
    (folder / shot_name(cfg, "01-converter-inputs-dark")).write_bytes(dark.read_bytes())

    obsolete = folder / "04-drawer-menu.png"
    if obsolete.exists():
        obsolete.unlink()
        print(f"  removed obsolete {obsolete.name}")

    print(f"=== done {key} ===")


def main() -> None:
    selected = [a.lower() for a in sys.argv[1:] if a.lower() in LOCALES]
    if not selected:
        selected = list(LOCALES.keys())

    devices = subprocess.check_output(["adb", "devices"], text=True)
    if DEVICE not in devices:
        sys.exit(f"Device {DEVICE} not connected")

    for key in selected:
        capture_locale(key, LOCALES[key])

    print("\nAll locale screenshots captured.")


if __name__ == "__main__":
    main()
