# {{PROJECT_TITLE}} figure style

## Canvas and framing

Record background color, border color and weight, corner radius, interior
padding, target aspect ratios, and intended print width.

## Drawing language

Record line weights, fills, tube or member construction, connector simplification,
cutaway convention, ground datum, arrows, leader lines, and approved visual
exaggerations.

## Color semantics

List every color and its fixed meaning. Do not reuse a semantic color for
decoration.

## Labels

Record top-label hierarchy, part badge shape, typeface, size, capitalization,
quantity notation, and whether labels belong inside the art or in Word text.

## Captions and alt text

Record caption style and numbering. Alt text must communicate purpose and
important geometry rather than repeating a filename.

## Source and export policy

- Preserve incoming and approved sources unchanged.
- Prefer SVG for line art.
- Retain a high-resolution PNG fallback when required for Word compatibility.
- Preserve aspect ratio and verify 100%/200% render sharpness.

## Figure acceptance checklist

- Geometry agrees with `TECHNICAL_SPEC.md`.
- No part or label is clipped.
- All ground contacts are on or above the datum.
- Cutaways hide only the intended near side.
- Fasteners and annotations match the requested view.
- Part IDs are complete and legible at print size.
- Frame, padding, top label, caption, and alt text match adjacent figures.
