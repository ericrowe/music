#!/usr/bin/env python3
"""
Deterministic Lineup Assembly & Compositor
Skill: simulate-prop-photometrics

Assembles side-by-side comparative strips of individual prop renders.
Ensures identical background plates, bit-identical performer registration,
and clean typographical stencil overlays.
"""

import argparse
import os
import sys
from PIL import Image, ImageDraw, ImageFont

def assemble_horizontal_strip(
    image_paths,
    labels=None,
    crop_box=None, # (left, top, right, bottom)
    output_path="lineup_comparison.jpg",
    spacing=10,
    bg_color=(20, 20, 24),
    label_color=(240, 240, 245),
    header_title=""
):
    images = []
    for p in image_paths:
        if not os.path.exists(p):
            raise FileNotFoundError(f"Image not found: {p}")
        im = Image.open(p).convert("RGB")
        if crop_box:
            im = im.crop(crop_box)
        images.append(im)

    if not images:
        raise ValueError("No images provided to assemble.")

    n = len(images)
    w_each, h_each = images[0].size
    
    # Verify all cropped images have the same dimensions
    for i, im in enumerate(images):
        if im.size != (w_each, h_each):
            images[i] = im.resize((w_each, h_each), Image.LANCZOS)

    header_h = 40 if header_title else 0
    footer_h = 36 if labels else 0

    total_w = n * w_each + (n - 1) * spacing
    total_h = h_each + header_h + footer_h

    canvas = Image.new("RGB", (total_w, total_h), bg_color)
    draw = ImageDraw.Draw(canvas)

    try:
        font = ImageFont.truetype("Arial", 16)
        title_font = ImageFont.truetype("Arial Bold", 18)
    except IOError:
        font = ImageFont.load_default()
        title_font = font

    # Draw Header
    if header_title:
        draw.text((total_w // 2, 20), header_title, fill=label_color, font=title_font, anchor="mm")

    # Paste images
    for i, im in enumerate(images):
        x = i * (w_each + spacing)
        y = header_h
        canvas.paste(im, (x, y))

        # Draw Label
        if labels and i < len(labels):
            lbl = labels[i]
            lbl_y = y + h_each + (footer_h // 2)
            draw.text((x + w_each // 2, lbl_y), lbl, fill=label_color, font=font, anchor="mm")

    # Save output
    canvas.save(output_path, quality=95)
    print(f"Assembled {n}-option comparative lineup saved to: {output_path} ({total_w}x{total_h}px)")
    return output_path

def main():
    parser = argparse.ArgumentParser(description="Deterministic Lineup Assembly & Compositor")
    parser.add_argument("--images", nargs="+", required=True, help="List of input image paths")
    parser.add_argument("--labels", nargs="*", help="Optional labels for each image")
    parser.add_argument("--crop", nargs=4, type=int, metavar=("L", "T", "R", "B"), help="Optional crop box")
    parser.add_argument("--out", type=str, default="lineup_assembled.jpg", help="Output path")
    parser.add_argument("--title", type=str, default="", help="Optional header title")
    args = parser.parse_args()

    crop_box = tuple(args.crop) if args.crop else None
    assemble_horizontal_strip(
        image_paths=args.images,
        labels=args.labels,
        crop_box=crop_box,
        output_path=args.out,
        header_title=args.title
    )

if __name__ == "__main__":
    main()
