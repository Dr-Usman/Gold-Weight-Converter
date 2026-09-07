#!/usr/bin/env python3
"""
Play Store Mockup Generator for Gold Weight Converter
=====================================================
Generates high-resolution (1242 x 2688 px) Google Play Store mockups
with modern titanium smartphone framing, floating 3D drop shadow,
warm luxury gold gradient background, and crisp localized typography.

Usage:
    python3 docs/mockups/generate_mockups.py
"""

import os
import sys
from PIL import Image, ImageDraw, ImageFilter, ImageFont

# ---------------------------------------------------------------------------
# Configuration & Geometry
# ---------------------------------------------------------------------------
CANVAS_WIDTH = 1242
CANVAS_HEIGHT = 2688

# Background Gradient Palette: Warm Ivory -> Soft Gold -> Rich Amber
COLOR_TOP = (255, 249, 238)
COLOR_MID = (254, 227, 168)
COLOR_BOT = (248, 180, 100)

# Phone Chassis Geometry (fits 1080x2400 aspect ratio)
PHONE_WIDTH = 980
BEZEL_WIDTH = 16
SCREEN_WIDTH = PHONE_WIDTH - (BEZEL_WIDTH * 2)               # 948 px
SCREEN_HEIGHT = int(SCREEN_WIDTH * (2400 / 1080))            # 2106 px
PHONE_HEIGHT = SCREEN_HEIGHT + (BEZEL_WIDTH * 2)             # 2138 px
PHONE_X = (CANVAS_WIDTH - PHONE_WIDTH) // 2                  # Centered: 131 px
PHONE_Y = 530                                                # Top offset

PHONE_OUTER_RADIUS = 70
SCREEN_RADIUS = 54
PUNCH_HOLE_DIAMETER = 26

# Typography Colors
COLOR_TEXT_PRIMARY = (20, 28, 56, 255)   # Deep Royal Navy
COLOR_TEXT_SECONDARY = (85, 70, 50, 255) # Warm Charcoal / Bronze
COLOR_BADGE_TEXT = (185, 95, 10, 255)    # Amber Gold
COLOR_BADGE_BORDER = (230, 160, 40, 190)
COLOR_BADGE_FILL = (255, 255, 255, 230)

# ---------------------------------------------------------------------------
# Font Discovery (English & Devanagari with cross-platform fallback)
# ---------------------------------------------------------------------------
def get_font(size, bold=False, lang='ne'):
    if lang == 'en':
        candidate_paths = [
            '/System/Library/Fonts/HelveticaNeue.ttc',
            '/System/Library/Fonts/Supplemental/Arial Bold.ttf' if bold else '/System/Library/Fonts/Supplemental/Arial.ttf',
            '/Library/Fonts/Arial Bold.ttf' if bold else '/Library/Fonts/Arial.ttf',
            '/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf' if bold else '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf',
        ]
        for path in candidate_paths:
            if os.path.exists(path):
                try:
                    idx = 1 if bold and path.endswith('.ttc') else 0
                    return ImageFont.truetype(path, size, index=idx)
                except Exception:
                    try:
                        return ImageFont.truetype(path, size)
                    except Exception:
                        continue
        return ImageFont.load_default()

    # Devanagari font search
    candidate_paths = [
        '/System/Library/Fonts/Supplemental/Devanagari Sangam MN.ttc',
        '/System/Library/Fonts/Supplemental/ITFDevanagari.ttc',
        '/System/Library/Fonts/Supplemental/DevanagariMT.ttc',
        '/usr/share/fonts/truetype/noto/NotoSansDevanagari-Bold.ttf' if bold else '/usr/share/fonts/truetype/noto/NotoSansDevanagari-Regular.ttf',
        os.path.expanduser('~/Library/Fonts/NotoSansDevanagari-Bold.ttf') if bold else os.path.expanduser('~/Library/Fonts/NotoSansDevanagari-Regular.ttf'),
    ]

    for path in candidate_paths:
        if os.path.exists(path):
            try:
                idx = 1 if bold and path.endswith('.ttc') else 0
                return ImageFont.truetype(path, size, index=idx)
            except Exception:
                try:
                    return ImageFont.truetype(path, size)
                except Exception:
                    continue

    return ImageFont.load_default()

# ---------------------------------------------------------------------------
# Background Builder
# ---------------------------------------------------------------------------
def build_canvas_background():
    bg = Image.new('RGBA', (CANVAS_WIDTH, CANVAS_HEIGHT))
    draw = ImageDraw.Draw(bg)

    # 1. Vertical linear gradient
    for y in range(CANVAS_HEIGHT):
        t = y / CANVAS_HEIGHT
        if t < 0.45:
            f = t / 0.45
            r = int(COLOR_TOP[0] + (COLOR_MID[0] - COLOR_TOP[0]) * f)
            g = int(COLOR_TOP[1] + (COLOR_MID[1] - COLOR_TOP[1]) * f)
            b = int(COLOR_TOP[2] + (COLOR_MID[2] - COLOR_TOP[2]) * f)
        else:
            f = (t - 0.45) / 0.55
            r = int(COLOR_MID[0] + (COLOR_BOT[0] - COLOR_MID[0]) * f)
            g = int(COLOR_MID[1] + (COLOR_BOT[1] - COLOR_MID[1]) * f)
            b = int(COLOR_MID[2] + (COLOR_BOT[2] - COLOR_MID[2]) * f)
        draw.line([(0, y), (CANVAS_WIDTH, y)], fill=(r, g, b, 255))

    # 2. Ambient light glows
    glow = Image.new('RGBA', (CANVAS_WIDTH, CANVAS_HEIGHT), (0, 0, 0, 0))
    glow_draw = ImageDraw.Draw(glow)
    glow_draw.ellipse([(600, -300), (1400, 400)], fill=(255, 220, 120, 90))
    glow_draw.ellipse([(150, 600), (1100, 1900)], fill=(255, 255, 255, 40))
    glow_draw.ellipse([(-200, 1900), (800, 2800)], fill=(240, 140, 50, 70))
    glow = glow.filter(ImageFilter.GaussianBlur(90))

    return Image.alpha_composite(bg, glow)

# ---------------------------------------------------------------------------
# Phone Chassis Builder
# ---------------------------------------------------------------------------
def render_phone_chassis(screenshot_path_or_img, width=PHONE_WIDTH, bezel=BEZEL_WIDTH, outer_radius=PHONE_OUTER_RADIUS, screen_radius=SCREEN_RADIUS, punch_diameter=PUNCH_HOLE_DIAMETER):
    screen_width = width - (bezel * 2)
    screen_height = int(screen_width * (2400 / 1080))
    height = screen_height + (bezel * 2)

    phone_body = Image.new('RGBA', (width, height), (0, 0, 0, 0))
    draw_body = ImageDraw.Draw(phone_body)

    # 1. Midnight Titanium Outer Frame with Metallic 3px Highlight Rim
    draw_body.rounded_rectangle(
        [(0, 0), (width, height)],
        radius=outer_radius,
        fill=(22, 24, 28, 255),
        outline=(70, 76, 85, 255),
        width=3
    )

    # 2. Fit Screenshot with Lanczos Filtering and Rounded Corner Mask
    if isinstance(screenshot_path_or_img, str):
        raw_shot = Image.open(screenshot_path_or_img).convert('RGBA')
    else:
        raw_shot = screenshot_path_or_img.convert('RGBA')
    resized_shot = raw_shot.resize((screen_width, screen_height), Image.Resampling.LANCZOS)

    screen_mask = Image.new('L', (screen_width, screen_height), 0)
    draw_mask = ImageDraw.Draw(screen_mask)
    draw_mask.rounded_rectangle([(0, 0), (screen_width, screen_height)], radius=screen_radius, fill=255)

    phone_body.paste(resized_shot, (bezel, bezel), mask=screen_mask)

    # 3. Center Punch-Hole Camera with Sapphire Lens Highlight Dot
    cam_cx = width // 2
    cam_cy = bezel + int(44 * (width / PHONE_WIDTH))
    draw_body.ellipse(
        [(cam_cx - punch_diameter // 2, cam_cy - punch_diameter // 2),
         (cam_cx + punch_diameter // 2, cam_cy + punch_diameter // 2)],
        fill=(10, 10, 12, 255),
        outline=(35, 38, 45, 255),
        width=1
    )
    draw_body.ellipse([(cam_cx - 3, cam_cy - 3), (cam_cx - 1, cam_cy - 1)], fill=(70, 95, 140, 210))

    return phone_body

# ---------------------------------------------------------------------------
# Shadow for Rotated Elements (Full-Canvas Layer to Avoid Boundary Clipping)
# ---------------------------------------------------------------------------
def render_shadow_layer(rotated_img, pos, blur=48, opacity=120, offset_y=36):
    layer = Image.new('RGBA', (CANVAS_WIDTH, CANVAS_HEIGHT), (0, 0, 0, 0))
    alpha = rotated_img.split()[3]
    solid = Image.new('RGBA', rotated_img.size, (25, 16, 8, opacity))
    layer.paste(solid, (pos[0], pos[1] + offset_y), mask=alpha)
    return layer.filter(ImageFilter.GaussianBlur(blur))

# ---------------------------------------------------------------------------
# Mockup Generator (Single Device)
# ---------------------------------------------------------------------------
def generate_mockup(base_bg, shadow_layer, screenshot_path, badge, title, subtitle, output_path, lang='ne'):
    # 1. Combine background with 3D drop shadow
    canvas = Image.alpha_composite(base_bg, shadow_layer)

    # 2. Render and composite phone
    phone = render_phone_chassis(screenshot_path)
    canvas.paste(phone, (PHONE_X, PHONE_Y), mask=phone)

    # 3. Render Typography
    draw = ImageDraw.Draw(canvas)
    badge_font = get_font(32 if lang == 'en' else 34, bold=True, lang=lang)
    title_font = get_font(78 if lang == 'en' else 82, bold=True, lang=lang)
    subtitle_font = get_font(42 if lang == 'en' else 44, bold=False, lang=lang)

    # Badge Pill
    bbox_b = draw.textbbox((0, 0), badge, font=badge_font)
    bw = bbox_b[2] - bbox_b[0] + 54
    bh = 62
    bx = (CANVAS_WIDTH - bw) // 2
    by = 100

    draw.rounded_rectangle(
        [(bx, by), (bx + bw, by + bh)],
        radius=31,
        fill=COLOR_BADGE_FILL,
        outline=COLOR_BADGE_BORDER,
        width=2
    )
    draw.text(
        ((CANVAS_WIDTH - (bbox_b[2] - bbox_b[0])) // 2, by + (13 if lang == 'en' else 11)),
        badge,
        font=badge_font,
        fill=COLOR_BADGE_TEXT
    )

    # Primary Title & Subtitle
    bbox_title = draw.textbbox((0, 0), title, font=title_font)
    bbox_sub = draw.textbbox((0, 0), subtitle, font=subtitle_font)

    tx = (CANVAS_WIDTH - (bbox_title[2] - bbox_title[0])) // 2
    sx = (CANVAS_WIDTH - (bbox_sub[2] - bbox_sub[0])) // 2

    draw.text((tx, 205), title, font=title_font, fill=COLOR_TEXT_PRIMARY)
    draw.text((sx, 325), subtitle, font=subtitle_font, fill=COLOR_TEXT_SECONDARY)

    # 4. Save Final High-Quality Asset
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    canvas.convert('RGB').save(output_path, quality=98)
    print(f"  [DONE] Created: {output_path}")

# ---------------------------------------------------------------------------
# Mockup Generator (Dual Angled Devices for Light & Dark Mode)
# ---------------------------------------------------------------------------
def generate_dual_mockup(base_bg, light_screenshot_path, dark_screenshot_path, badge, title, subtitle, output_path, lang='ne'):
    canvas = base_bg.copy()

    # Load light screenshot (harmonize status bar for clean presentation if needed)
    light_img = Image.open(light_screenshot_path).convert('RGBA')
    if lang == 'ne':
        en_ref = os.path.join(os.path.dirname(light_screenshot_path), '../english/01-converter-inputs.png')
        if os.path.exists(en_ref):
            ref_bar = Image.open(en_ref).crop((0, 0, 1080, 110))
            light_img.paste(ref_bar, (0, 0))

    dark_img = Image.open(dark_screenshot_path).convert('RGBA')

    # Render phone chassis (compact scale: width 710)
    phone_light = render_phone_chassis(light_img, width=710, bezel=13, outer_radius=52, screen_radius=42, punch_diameter=20)
    phone_dark = render_phone_chassis(dark_img, width=710, bezel=13, outer_radius=52, screen_radius=42, punch_diameter=20)

    # Rotate devices with subtle dynamic tilt
    rot_light = phone_light.rotate(6.5, resample=Image.Resampling.BICUBIC, expand=True)
    rot_dark = phone_dark.rotate(-6.5, resample=Image.Resampling.BICUBIC, expand=True)

    pos_light = (60, 620)
    pos_dark = (370, 780)

    # 1. Left Phone Shadows (smooth double layer: soft ambient + diffuse elevation)
    sh_light_ambient = render_shadow_layer(rot_light, pos_light, blur=24, opacity=70, offset_y=18)
    sh_light_diffuse = render_shadow_layer(rot_light, pos_light, blur=54, opacity=60, offset_y=36)
    canvas = Image.alpha_composite(canvas, sh_light_ambient)
    canvas = Image.alpha_composite(canvas, sh_light_diffuse)

    # 2. Left Phone Body
    canvas.paste(rot_light, pos_light, mask=rot_light)

    # 3. Right Phone Foreground Shadows (casts onto canvas AND left phone, completely unclipped)
    sh_dark_ambient = render_shadow_layer(rot_dark, pos_dark, blur=24, opacity=90, offset_y=20)
    sh_dark_diffuse = render_shadow_layer(rot_dark, pos_dark, blur=58, opacity=85, offset_y=42)
    canvas = Image.alpha_composite(canvas, sh_dark_ambient)
    canvas = Image.alpha_composite(canvas, sh_dark_diffuse)

    # 4. Right Phone Body
    canvas.paste(rot_dark, pos_dark, mask=rot_dark)

    # Render Typography
    draw = ImageDraw.Draw(canvas)
    badge_font = get_font(32 if lang == 'en' else 34, bold=True, lang=lang)
    title_font = get_font(78 if lang == 'en' else 80, bold=True, lang=lang)
    subtitle_font = get_font(42 if lang == 'en' else 42, bold=False, lang=lang)

    # Badge Pill
    bbox_b = draw.textbbox((0, 0), badge, font=badge_font)
    bw = bbox_b[2] - bbox_b[0] + 54
    bh = 62
    bx = (CANVAS_WIDTH - bw) // 2
    by = 100

    draw.rounded_rectangle(
        [(bx, by), (bx + bw, by + bh)],
        radius=31,
        fill=COLOR_BADGE_FILL,
        outline=COLOR_BADGE_BORDER,
        width=2
    )
    draw.text(
        ((CANVAS_WIDTH - (bbox_b[2] - bbox_b[0])) // 2, by + (13 if lang == 'en' else 11)),
        badge,
        font=badge_font,
        fill=COLOR_BADGE_TEXT
    )

    # Primary Title & Subtitle
    bbox_title = draw.textbbox((0, 0), title, font=title_font)
    bbox_sub = draw.textbbox((0, 0), subtitle, font=subtitle_font)

    tx = (CANVAS_WIDTH - (bbox_title[2] - bbox_title[0])) // 2
    sx = (CANVAS_WIDTH - (bbox_sub[2] - bbox_sub[0])) // 2

    draw.text((tx, 205), title, font=title_font, fill=COLOR_TEXT_PRIMARY)
    draw.text((sx, 325), subtitle, font=subtitle_font, fill=COLOR_TEXT_SECONDARY)

    # Save Final High-Quality Asset
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    canvas.convert('RGB').save(output_path, quality=98)
    print(f"  [DONE] Created: {output_path}")

# ---------------------------------------------------------------------------
# Main Routine
# ---------------------------------------------------------------------------
def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.abspath(os.path.join(script_dir, '../..'))

    print("==================================================")
    print("Gold Weight Converter — Store Mockup Generator")
    print("==================================================")

    # Build base background
    print("-> Rendering luxury background gradient and ambient glow...")
    base_bg = build_canvas_background()

    # Pre-render 3D floating drop shadow layer
    print("-> Computing 3D floating shadow layer...")
    shadow_layer = Image.new('RGBA', (CANVAS_WIDTH, CANVAS_HEIGHT), (0, 0, 0, 0))
    shadow_draw = ImageDraw.Draw(shadow_layer)
    shadow_draw.rounded_rectangle(
        [(PHONE_X, PHONE_Y + 36), (PHONE_X + PHONE_WIDTH, PHONE_Y + PHONE_HEIGHT + 36)],
        radius=PHONE_OUTER_RADIUS,
        fill=(35, 20, 10, 110)
    )
    shadow_layer = shadow_layer.filter(ImageFilter.GaussianBlur(36))

    # Mockup Definitions for Nepal Store Listing
    nepal_mockups = [
        {
            'type': 'single',
            'shot': os.path.join(project_root, 'docs/screenshots/nepal/01-converter-inputs.png'),
            'badge': 'नेपाल विशेष',
            'title': 'तोला, लाल र ग्राम रूपान्तरक',
            'subtitle': 'नेपाली सुन बजारको सही र भरपर्दो हिसाब',
            'out': os.path.join(project_root, 'docs/mockups/nepal/01-converter-inputs-mockup.png'),
            'lang': 'ne'
        },
        {
            'type': 'single',
            'shot': os.path.join(project_root, 'docs/screenshots/nepal/02-results-and-price.png'),
            'badge': 'हिसाब विवरण',
            'title': 'विस्तृत हिसाब र सुनको मूल्य',
            'subtitle': 'नेपाली रुपैयाँ (रु) मा तत्काल बजार भाउ',
            'out': os.path.join(project_root, 'docs/mockups/nepal/02-results-and-price-mockup.png'),
            'lang': 'ne'
        },
        {
            'type': 'single',
            'shot': os.path.join(project_root, 'docs/screenshots/nepal/03-gold-zakat.png'),
            'badge': 'जकात क्याल्कुलेटर',
            'title': 'सुनको २.५% जकात हिसाब',
            'subtitle': 'गहना, २४ क्यारेट र २२ क्यारेट अनुसार',
            'out': os.path.join(project_root, 'docs/mockups/nepal/03-gold-zakat-mockup.png'),
            'lang': 'ne'
        },
        {
            'type': 'single',
            'shot': os.path.join(project_root, 'docs/screenshots/nepal/04-drawer-menu.png'),
            'badge': 'मुद्रा र थिम',
            'title': 'नेपाली रुपैयाँ र डार्क थिम',
            'subtitle': 'आफ्नो रोजाइको मुद्रा र आकर्षक दृश्य',
            'out': os.path.join(project_root, 'docs/mockups/nepal/04-drawer-menu-mockup.png'),
            'lang': 'ne'
        },
        {
            'type': 'single',
            'shot': os.path.join(project_root, 'docs/screenshots/nepal/05-languages.png'),
            'badge': 'बहुभाषिक समर्थन',
            'title': 'नेपाली भाषा र २०+ भाषाहरू',
            'subtitle': 'आफ्नै मातृभाषामा सरल र सहज प्रयोग',
            'out': os.path.join(project_root, 'docs/mockups/nepal/05-languages-mockup.png'),
            'lang': 'ne'
        },
        {
            'type': 'dual',
            'shot_light': os.path.join(project_root, 'docs/screenshots/nepal/01-converter-inputs.png'),
            'shot_dark': os.path.join(project_root, 'docs/screenshots/nepal/01-converter-inputs-dark.png'),
            'badge': 'आकर्षक थिमहरू',
            'title': 'लाइट र डार्क थिम समर्थन',
            'subtitle': 'दिन वा रात, जुनसुकै समयमा आँखालाई आरामदायी',
            'out': os.path.join(project_root, 'docs/mockups/nepal/06-light-dark-mode-mockup.png'),
            'lang': 'ne'
        }
    ]

    # Mockup Definitions for English Store Listing
    english_mockups = [
        {
            'type': 'single',
            'shot': os.path.join(project_root, 'docs/screenshots/english/01-converter-inputs.png'),
            'badge': 'PRECISION CONVERTER',
            'title': 'Convert Tola, Masha & Gram',
            'subtitle': 'Accurate Tola, Masha, Ana, Ratti & Gram units',
            'out': os.path.join(project_root, 'docs/mockups/english/01-converter-inputs-mockup.png'),
            'lang': 'en'
        },
        {
            'type': 'single',
            'shot': os.path.join(project_root, 'docs/screenshots/english/02-results-and-price.png'),
            'badge': 'DETAILED BREAKDOWN',
            'title': 'Instant Results & Gold Value',
            'subtitle': 'Live calculation breakdown and pricing estimates',
            'out': os.path.join(project_root, 'docs/mockups/english/02-results-and-price-mockup.png'),
            'lang': 'en'
        },
        {
            'type': 'single',
            'shot': os.path.join(project_root, 'docs/screenshots/english/03-gold-zakat.png'),
            'badge': 'ZAKAT CALCULATOR',
            'title': 'Calculate 2.5% Gold Zakat',
            'subtitle': 'Add jewelry items with 24K & 22K purity breakdown',
            'out': os.path.join(project_root, 'docs/mockups/english/03-gold-zakat-mockup.png'),
            'lang': 'en'
        },
        {
            'type': 'single',
            'shot': os.path.join(project_root, 'docs/screenshots/english/04-drawer-menu.png'),
            'badge': 'SMART CUSTOMIZATION',
            'title': '36 Currencies & Dark Mode',
            'subtitle': 'Tailor units, themes & local display preferences',
            'out': os.path.join(project_root, 'docs/mockups/english/04-drawer-menu-mockup.png'),
            'lang': 'en'
        },
        {
            'type': 'single',
            'shot': os.path.join(project_root, 'docs/screenshots/english/05-languages.png'),
            'badge': 'GLOBAL REACH',
            'title': 'Available in 20+ Languages',
            'subtitle': 'Designed for jewellers, traders & buyers worldwide',
            'out': os.path.join(project_root, 'docs/mockups/english/05-languages-mockup.png'),
            'lang': 'en'
        },
        {
            'type': 'dual',
            'shot_light': os.path.join(project_root, 'docs/screenshots/english/01-converter-inputs.png'),
            'shot_dark': os.path.join(project_root, 'docs/screenshots/english/01-converter-inputs-dark.png'),
            'badge': 'ADAPTIVE THEMES',
            'title': 'Stunning in Light & Dark',
            'subtitle': 'Designed for seamless comfort, day and night',
            'out': os.path.join(project_root, 'docs/mockups/english/06-light-dark-mode-mockup.png'),
            'lang': 'en'
        }
    ]

    # Mockup Definitions for India (Hindi) Store Listing
    india_mockups = [
        {
            'type': 'single',
            'shot': os.path.join(project_root, 'docs/screenshots/india/01-converter-inputs.png'),
            'badge': 'सटीक कनवर्टर',
            'title': 'तोला, माशा, रत्ती और ग्राम',
            'subtitle': 'पारंपरिक भारतीय इकाइयों का सटीक और आसान हिसाब',
            'out': os.path.join(project_root, 'docs/mockups/india/01-converter-inputs-mockup.png'),
            'lang': 'hi'
        },
        {
            'type': 'single',
            'shot': os.path.join(project_root, 'docs/screenshots/india/02-results-and-price.png'),
            'badge': 'विस्तृत हिसाब',
            'title': 'तुरंत परिणाम और सोने की कीमत',
            'subtitle': 'भारतीय रुपये (₹) में लाइव व सटीक बाज़ार भाव',
            'out': os.path.join(project_root, 'docs/mockups/india/02-results-and-price-mockup.png'),
            'lang': 'hi'
        },
        {
            'type': 'single',
            'shot': os.path.join(project_root, 'docs/screenshots/india/03-gold-zakat.png'),
            'badge': 'ज़कात क्याल्कुलेटर',
            'title': 'सोने की 2.5% ज़कात का हिसाब',
            'subtitle': '24K और 22K हॉलमार्क आभूषणों के अनुसार गणना',
            'out': os.path.join(project_root, 'docs/mockups/india/03-gold-zakat-mockup.png'),
            'lang': 'hi'
        },
        {
            'type': 'single',
            'shot': os.path.join(project_root, 'docs/screenshots/india/04-drawer-menu.png'),
            'badge': 'स्मार्ट सेटिंग्स',
            'title': 'भारतीय रुपया (₹) और डार्क मोड',
            'subtitle': '36 मुद्राएं और आंखों के लिए आरामदायक थीम',
            'out': os.path.join(project_root, 'docs/mockups/india/04-drawer-menu-mockup.png'),
            'lang': 'hi'
        },
        {
            'type': 'single',
            'shot': os.path.join(project_root, 'docs/screenshots/india/05-languages.png'),
            'badge': 'बहुभाषी समर्थन',
            'title': 'हिंदी सहित 20+ भाषाओं में',
            'subtitle': 'ज्वैलर्स, सर्राफा व्यापारियों और ग्राहकों के लिए',
            'out': os.path.join(project_root, 'docs/mockups/india/05-languages-mockup.png'),
            'lang': 'hi'
        },
        {
            'type': 'dual',
            'shot_light': os.path.join(project_root, 'docs/screenshots/india/01-converter-inputs.png'),
            'shot_dark': os.path.join(project_root, 'docs/screenshots/india/01-converter-inputs-dark.png'),
            'badge': 'आकर्षक थीम्स',
            'title': 'लाइट और डार्क थीम समर्थन',
            'subtitle': 'दिन या रात, हर समय सहज और प्रीमियम अनुभव',
            'out': os.path.join(project_root, 'docs/mockups/india/06-light-dark-mode-mockup.png'),
            'lang': 'hi'
        }
    ]

    print("\n-> Generating Nepal Store Mockups (1 to 6)...")
    for m in nepal_mockups:
        if m.get('type') == 'dual':
            if not os.path.exists(m['shot_light']) or not os.path.exists(m['shot_dark']):
                print(f"  [WARN] Missing screenshot for dual mockup: {m['out']}")
                continue
            generate_dual_mockup(base_bg, m['shot_light'], m['shot_dark'], m['badge'], m['title'], m['subtitle'], m['out'], lang=m['lang'])
        else:
            if not os.path.exists(m['shot']):
                print(f"  [WARN] Screenshot missing: {m['shot']}")
                continue
            generate_mockup(base_bg, shadow_layer, m['shot'], m['badge'], m['title'], m['subtitle'], m['out'], lang=m['lang'])

    print("\n-> Generating English Store Mockups (1 to 6)...")
    for m in english_mockups:
        if m.get('type') == 'dual':
            if not os.path.exists(m['shot_light']) or not os.path.exists(m['shot_dark']):
                print(f"  [WARN] Missing screenshot for dual mockup: {m['out']}")
                continue
            generate_dual_mockup(base_bg, m['shot_light'], m['shot_dark'], m['badge'], m['title'], m['subtitle'], m['out'], lang=m['lang'])
        else:
            if not os.path.exists(m['shot']):
                print(f"  [WARN] Screenshot missing: {m['shot']}")
                continue
            generate_mockup(base_bg, shadow_layer, m['shot'], m['badge'], m['title'], m['subtitle'], m['out'], lang=m['lang'])

    print("\n-> Generating India (Hindi) Store Mockups (1 to 6)...")
    for m in india_mockups:
        if m.get('type') == 'dual':
            if not os.path.exists(m['shot_light']) or not os.path.exists(m['shot_dark']):
                print(f"  [WARN] Missing screenshot for dual mockup: {m['out']}")
                continue
            generate_dual_mockup(base_bg, m['shot_light'], m['shot_dark'], m['badge'], m['title'], m['subtitle'], m['out'], lang=m['lang'])
        else:
            if not os.path.exists(m['shot']):
                print(f"  [WARN] Screenshot missing: {m['shot']}")
                continue
            generate_mockup(base_bg, shadow_layer, m['shot'], m['badge'], m['title'], m['subtitle'], m['out'], lang=m['lang'])

    print("\nAll mockups generated successfully at 1242 x 2688 px!")

if __name__ == '__main__':
    main()

