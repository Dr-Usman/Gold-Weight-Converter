#!/usr/bin/env python3
"""
Google Play Feature Graphic Generator for Gold Weight Converter
================================================================
Generates official 1024 x 500 px Google Play Store feature graphics for
Pakistan (Urdu / اردو) and Bangladesh (Bengali / বাংলা).

Maintains exact visual fidelity with existing graphics (English, Hindi, Nepali):
- Luxury deep navy to warm golden amber radial background glow
- Outer gold decorative border and bottom platform / open-source banner
- Embossed 3D gold typography with multi-layer bronze extrusion and drop shadow
- Direct perspective-warped smartphone with localized app screenshot
- Realistic rounded screen corners, Dynamic Island front-camera pill, and 3D golden balance scale
- Preserved Flutter medallion, floating coins, and store badges

Usage:
    python3 docs/feature-graphics/generate_feature_graphics.py
"""

import os
import sys
import math
from PIL import Image, ImageDraw, ImageFont, ImageFilter

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT = os.path.abspath(os.path.join(SCRIPT_DIR, '../..'))

CANVAS_WIDTH = 1024
CANVAS_HEIGHT = 500

# ---------------------------------------------------------------------------
# Perspective Solver
# ---------------------------------------------------------------------------
def solve_linear_system(A, B):
    n = len(B)
    M = [A[i][:] + [B[i]] for i in range(n)]
    for i in range(n):
        max_row = max(range(i, n), key=lambda r: abs(M[r][i]))
        M[i], M[max_row] = M[max_row], M[i]
        pivot = M[i][i]
        if abs(pivot) < 1e-9:
            continue
        for j in range(i, n + 1):
            M[i][j] /= pivot
        for r in range(n):
            if r != i:
                factor = M[r][i]
                for c in range(i, n + 1):
                    M[r][c] -= factor * M[i][c]
    return [M[i][n] for i in range(n)]

def find_perspective_coeffs(src_pts, dst_pts):
    matrix = []
    rhs = []
    for (xd, yd), (xs, ys) in zip(dst_pts, src_pts):
        matrix.append([xd, yd, 1, 0, 0, 0, -xs * xd, -xs * yd])
        rhs.append(xs)
        matrix.append([0, 0, 0, xd, yd, 1, -ys * xd, -ys * yd])
        rhs.append(ys)
    return solve_linear_system(matrix, rhs)

# ---------------------------------------------------------------------------
# Font Discovery
# ---------------------------------------------------------------------------
def get_font(size, bold=True, lang='ur'):
    if lang == 'ur':
        paths = [
            ('/System/Library/Fonts/GeezaPro.ttc', 1 if bold else 0),
            ('/System/Library/Fonts/SFArabic.ttf', 0),
            ('/Library/Fonts/NotoNastaliqUrdu-Bold.ttf' if bold else '/Library/Fonts/NotoNastaliqUrdu-Regular.ttf', 0),
            ('/usr/share/fonts/truetype/noto/NotoNastaliqUrdu-Bold.ttf' if bold else '/usr/share/fonts/truetype/noto/NotoNastaliqUrdu-Regular.ttf', 0),
        ]
        for path, idx in paths:
            if os.path.exists(path):
                try:
                    return ImageFont.truetype(path, size, index=idx)
                except Exception:
                    try:
                        return ImageFont.truetype(path, size)
                    except Exception:
                        continue
        return ImageFont.load_default()

    if lang == 'bn':
        paths = [
            ('/System/Library/Fonts/KohinoorBangla.ttc', 3 if bold else 0),
            ('/System/Library/Fonts/Supplemental/Bangla Sangam MN.ttc', 1 if bold else 0),
            ('/System/Library/Fonts/Supplemental/Bangla MN.ttc', 1 if bold else 0),
            ('/usr/share/fonts/truetype/noto/NotoSansBengali-Bold.ttf' if bold else '/usr/share/fonts/truetype/noto/NotoSansBengali-Regular.ttf', 0),
        ]
        for path, idx in paths:
            if os.path.exists(path):
                try:
                    return ImageFont.truetype(path, size, index=idx)
                except Exception:
                    try:
                        return ImageFont.truetype(path, size)
                    except Exception:
                        continue
        return ImageFont.load_default()

    # Fallback / English
    paths = [
        '/System/Library/Fonts/HelveticaNeue.ttc',
        '/System/Library/Fonts/Supplemental/Arial Bold.ttf' if bold else '/System/Library/Fonts/Supplemental/Arial.ttf',
        '/Library/Fonts/Arial Bold.ttf' if bold else '/Library/Fonts/Arial.ttf',
    ]
    for path in paths:
        if os.path.exists(path):
            try:
                return ImageFont.truetype(path, size)
            except Exception:
                continue
    return ImageFont.load_default()

# ---------------------------------------------------------------------------
# Base Template Plate Generator
# ---------------------------------------------------------------------------
def create_clean_template(base_image_path):
    """
    Cleans the left text area (x: 35..465, y: 28..442) and CTA text area (x: 785..975, y: 178..198)
    by seamlessly interpolating the royal navy-to-gold radial glow and geometric pattern.
    """
    base = Image.open(base_image_path).convert('RGBA')
    W, H = base.size

    bg_clean = base.copy()

    # 1. Clean left text area
    for y in range(28, 442):
        for x in range(35, 480):
            dx = (x - 510) * 1.0
            dy = (y - 80) * 1.2
            d = math.sqrt(dx * dx + dy * dy)

            t = min(1.0, max(0.0, d / 490.0))
            s = t * t * (3 - 2 * t)

            if s < 0.35:
                f = s / 0.35
                r = int(115 + (65 - 115) * f)
                g = int(84 + (44 - 84) * f)
                b = int(23 + (28 - 23) * f)
            else:
                f = (s - 0.35) / 0.65
                r = int(65 + (19 - 65) * f)
                g = int(44 + (8 - 44) * f)
                b = int(28 + (33 - 28) * f)

            if x <= 464:
                alpha = 1.0
            elif x < 476:
                tx = (x - 464) / 12.0
                alpha = 0.5 * (1.0 + math.cos(math.pi * tx))
            else:
                alpha = 0.0

            orig = base.getpixel((x, y))
            final_r = int(r * alpha + orig[0] * (1.0 - alpha))
            final_g = int(g * alpha + orig[1] * (1.0 - alpha))
            final_b = int(b * alpha + orig[2] * (1.0 - alpha))
            bg_clean.putpixel((x, y), (final_r, final_g, final_b, 255))

    # 2. Clean CTA text area (wipe "DOWNLOAD NOW!" without touching the coin or store badges)
    cta_patch = base.crop((785, 158, 975, 178))
    bg_clean.paste(cta_patch, (785, 178))

    return bg_clean

# ---------------------------------------------------------------------------
# 3D Gold Typography Engine
# ---------------------------------------------------------------------------
def draw_3d_gold_text(target_img, pos, text, font, lang='en'):
    """
    Renders luxury 3D embossed gold text with:
    - Deep ambient drop shadow (blur 3.5, offset 4, 6)
    - Dark bronze / amber bevel extrusion (layers at offsets 1..3)
    - Rich warm gold face (245, 205, 95)
    - Crisp top specular highlight shimmer (255, 245, 200)
    """
    W, H = target_img.size
    x, y = pos
    direction = 'rtl' if lang == 'ur' else None

    # 1. Soft ambient shadow
    sh = Image.new('RGBA', (W, H), (0, 0, 0, 0))
    d_sh = ImageDraw.Draw(sh)
    d_sh.text((x + 4, y + 6), text, font=font, fill=(5, 2, 8, 220), direction=direction)
    sh = sh.filter(ImageFilter.GaussianBlur(3.5))
    target_img.alpha_composite(sh)

    d = ImageDraw.Draw(target_img)

    # 2. 3D extrusion bevels (dark bronze -> rich amber)
    extrusion_colors = [
        (85, 50, 12, 255),
        (120, 75, 20, 255),
        (160, 105, 30, 255),
    ]
    for idx, (off_y, off_x) in enumerate([(3, 2), (2, 2), (1, 1)]):
        d.text((x + off_x, y + off_y), text, font=font, fill=extrusion_colors[idx], direction=direction)

    # 3. Gold face (rich yellow gold)
    d.text((x, y), text, font=font, fill=(245, 205, 95, 255), direction=direction)

    # 4. Top highlight shimmer
    d.text((x, y - 1), text, font=font, fill=(255, 245, 200, 170), direction=direction)

def draw_text_with_shadow(draw, pos, text, font, fill=(255, 255, 255, 255), shadow_fill=(10, 5, 15, 220), lang='en', offset=(1, 2)):
    x, y = pos
    ox, oy = offset
    direction = 'rtl' if lang == 'ur' else None
    draw.text((x + ox, y + oy), text, font=font, fill=shadow_fill, direction=direction)
    draw.text((x, y), text, font=font, fill=fill, direction=direction)

# ---------------------------------------------------------------------------
# Global Smartphone Screen Perspective Warp
# ---------------------------------------------------------------------------
def warp_phone_screen_global(base_img, screenshot_path):
    """
    Directly warps the screenshot into the global screen quad on the phone:
    [(584, 35), (738, 58), (657, 436), (503, 410)]
    and restores:
    - 3D Gold Scale foreground (pan, chains, base)
    - Dynamic Island pill and camera lens
    """
    W, H = base_img.size

    global_quad = [(584, 35), (738, 58), (657, 436), (503, 410)]

    shot = Image.open(screenshot_path).convert('RGBA')
    sw, sh = shot.size
    src_quad = [(0, 0), (sw, 0), (sw, sh), (0, sh)]

    coeffs = find_perspective_coeffs(src_quad, global_quad)
    warped = shot.transform((W, H), Image.PERSPECTIVE, coeffs, Image.Resampling.BICUBIC)

    # Rounded screen corner mask (radius 120 on original 1080x2400)
    shot_mask = Image.new('L', (sw, sh), 0)
    d_sm = ImageDraw.Draw(shot_mask)
    d_sm.rounded_rectangle([(0, 0), (sw, sh)], radius=120, fill=255)
    warped_mask = shot_mask.transform((W, H), Image.PERSPECTIVE, coeffs, Image.Resampling.BICUBIC)

    res = base_img.copy()
    res.paste(warped, (0, 0), mask=warped_mask)

    # 1. Restore Dynamic Island pill at (635, 42)
    pill_path = os.path.join(PROJECT_ROOT, 'docs/screenshots/scratch_real_pill.png')
    if os.path.exists(pill_path):
        pill = Image.open(pill_path).convert('RGBA')
        res.paste(pill, (635, 42), mask=pill)

    # 2. Restore 3D Gold Scale in front of phone
    for y in range(245, 442):
        for x in range(610, 760):
            orig = base_img.getpixel((x, y))
            r, g, b = orig[:3]
            is_gold = (r > 120 and g > 75 and b < 130 and (r - b) > 30) or \
                      (r > 200 and g > 165 and (r - b) > 40) or \
                      (x > 685 and y > 250)
            if is_gold:
                res.putpixel((x, y), orig)

    return res

# ---------------------------------------------------------------------------
# Feature Graphic Builder
# ---------------------------------------------------------------------------
def generate_feature_graphic(config, out_path):
    print(f"-> Generating Feature Graphic for {config['name']} ({out_path})...")

    # 1. Base clean template
    en_path = os.path.join(SCRIPT_DIR, 'feature-graphic-en.png')
    base = create_clean_template(en_path)

    # 2. Direct global screen warp on smartphone
    base = warp_phone_screen_global(base, config['screenshot'])

    # 3. Render 3D Gold Title
    lang = config['lang']
    font_title = get_font(config['title_size'], bold=True, lang=lang)
    for pos, text in config['title_lines']:
        draw_3d_gold_text(base, pos, text, font_title, lang=lang)

    # 4. Render Subtitle
    d = ImageDraw.Draw(base)
    font_sub = get_font(config['sub_size'], bold=True, lang=lang)
    draw_text_with_shadow(d, config['sub_pos'], config['sub_text'], font_sub,
                          fill=(255, 255, 255, 255), shadow_fill=(15, 8, 25, 240), lang=lang)

    # 5. Render Bullet Icons and Text
    font_bullet = get_font(config['bullet_size'], bold=True, lang=lang)

    ico_scale = Image.open(os.path.join(PROJECT_ROOT, 'docs/screenshots/scratch_ico_scale.png')).convert('RGBA')
    ico_money = Image.open(os.path.join(PROJECT_ROOT, 'docs/screenshots/scratch_ico_money.png')).convert('RGBA')
    ico_hand = Image.open(os.path.join(PROJECT_ROOT, 'docs/screenshots/scratch_ico_hand.png')).convert('RGBA')
    ico_flag = Image.open(config['flag_icon']).convert('RGBA')

    icons = [
        (ico_scale, 65, 235),
        (ico_money, 68, 278),
        (ico_hand, 66, 328),
        (ico_flag, 68, 370),
    ]

    for (ico, ix, iy), text, by in zip(icons, config['bullets'], config['bullet_ys']):
        base.paste(ico, (ix, iy), mask=ico)
        draw_text_with_shadow(d, (112, by), text, font_bullet,
                              fill=(255, 255, 255, 255), shadow_fill=(15, 8, 25, 230), lang=lang)

    # 6. Render Flag Strip under 4th bullet (Pakistan, India, Bangladesh, Nepal)
    flags_strip = Image.open(os.path.join(PROJECT_ROOT, 'docs/screenshots/scratch_flags.png')).convert('RGBA')
    flags_clean = flags_strip.crop((54, 8, 199, 32))
    base.paste(flags_clean, (112, 408), mask=flags_clean)

    # 7. Render Localized CTA Button Text (Centered above Google Play badge at x=858, y=170)
    font_cta = get_font(config['cta_size'], bold=True, lang=lang)
    cta_text = config['cta_text']
    bbox = d.textbbox((0, 0), cta_text, font=font_cta)
    text_w = bbox[2] - bbox[0]
    cta_x = int(858 - (text_w / 2))
    cta_y = 168
    draw_text_with_shadow(d, (cta_x, cta_y), cta_text, font_cta,
                          fill=(255, 232, 170, 255), shadow_fill=(10, 5, 20, 255), lang=lang, offset=(2, 3))

    # 8. Save final feature graphic (exactly 1024 x 500 px RGB)
    final_img = base.convert('RGB')
    final_img.save(out_path, 'PNG', optimize=True)
    print(f"  [SUCCESS] Saved {out_path} ({final_img.size[0]} x {final_img.size[1]} px)")

# ---------------------------------------------------------------------------
# Main Execution
# ---------------------------------------------------------------------------
def main():
    configs = {
        'ur': {
            'name': 'Pakistan (Urdu / اردو)',
            'lang': 'ur',
            'screenshot': os.path.join(PROJECT_ROOT, 'docs/screenshots/pakistan/01-converter-inputs.png'),
            'flag_icon': os.path.join(PROJECT_ROOT, 'docs/screenshots/scratch_flag_pk.png'),
            'title_size': 48,
            'title_lines': [
                ((72, 44), 'سونے کا وزن'),
                ((72, 108), 'کنورٹر'),
            ],
            'sub_size': 20,
            'sub_pos': (72, 185),
            'sub_text': 'تولہ، ماشہ، آنہ اور گرام کا درست حساب',
            'bullet_size': 16.5,
            'bullet_ys': [240, 286, 332, 374],
            'bullets': [
                'تولہ، ماشہ، آنہ، رتی سے گرام کنورژن',
                'پاکستانی روپوں میں سونے کا ریٹ',
                'سونے کا ۲.۵٪ زکوٰۃ کیلکولیٹر',
                'اردو اور ۲۰ سے زائد زبانوں میں دستیاب',
            ],
            'cta_text': 'ابھی ڈاؤنلوڈ کریں',
            'cta_size': 22,
            'out': os.path.join(SCRIPT_DIR, 'feature-graphic-ur.png'),
        },
        'bn': {
            'name': 'Bangladesh (Bengali / বাংলা)',
            'lang': 'bn',
            'screenshot': os.path.join(PROJECT_ROOT, 'docs/screenshots/bangladesh/01-converter-inputs.png'),
            'flag_icon': os.path.join(PROJECT_ROOT, 'docs/screenshots/scratch_flag_bd.png'),
            'title_size': 50,
            'title_lines': [
                ((72, 44), 'সোনার ওজন'),
                ((72, 108), 'রূপান্তরক'),
            ],
            'sub_size': 20,
            'sub_pos': (72, 185),
            'sub_text': 'তোলা, মাশা, আনা ও গ্রামের সঠিক হিসাব',
            'bullet_size': 16.5,
            'bullet_ys': [240, 286, 332, 374],
            'bullets': [
                'তোলা, মাশা, আনা, রত্তি থেকে গ্রাম রূপান্তর',
                'বাংলাদেশি টাকা (৳) তে স্বর্ণের দাম',
                'স্বর্ণের ২.৫% যাকাত ক্যালকুলেটর',
                'বাংলা সহ ২০+ ভাষায় উপলব্ধ',
            ],
            'cta_text': 'এখনই ডাউনলোড করুন!',
            'cta_size': 22,
            'out': os.path.join(SCRIPT_DIR, 'feature-graphic-bn.png'),
        }
    }

    targets = [arg.lower() for arg in sys.argv[1:] if arg.lower() in configs]
    if not targets:
        targets = list(configs.keys())

    for key in targets:
        cfg = configs[key]
        generate_feature_graphic(cfg, cfg['out'])

    print("\nFeature graphics generation complete!")

if __name__ == '__main__':
    main()
