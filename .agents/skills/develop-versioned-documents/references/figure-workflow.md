# Figure development and integration

Use this reference for new drawings, replacements, panel substitutions, framing,
or any request to review an image before changing the document.

## Asset states

- `assets/incoming/`: untouched reviewer uploads and source exports.
- `assets/working/<figure-id>/`: redraws, crops, composites, fallbacks, and review
  previews.
- `assets/approved/`: exact reviewer-approved technical sources.

Never edit a file in `incoming` or `approved`. Create a named derivative.

## Standalone review loop

1. Identify the intended figure and whether the request replaces the whole
   figure, one panel, or only presentation furniture.
2. Copy the source into `incoming` without recompression or renaming that loses
   provenance.
3. Record the mapping and technical acceptance criteria in the change record and
   figure register.
4. Produce a clean standalone SVG when the drawing is vector line art. Also
   produce a high-resolution PNG fallback if the DOCX consumer requires it.
5. Review geometry at full resolution and at intended print size.
6. Return the standalone asset without editing the DOCX.
7. After approval, preserve that exact source in `approved`; build framing and
   top-label composites as separate working derivatives.

## Source priority

Use, in order: current reviewer instruction, reviewer-supplied art or sketch,
approved CAD/photo-derived geometry, accepted figure, then style inference.
Ask when equally authoritative sources conflict.

## Drawing controls

- Match the approved figure system: tube construction, connector simplification,
  part badges, palette, line weights, framing, radius, padding, and label style.
- Keep mechanical relationships correct even when clarity requires a documented
  not-to-scale exaggeration.
- Do not show components passing through the ground datum.
- Keep ground-contact points tangent to or above the ground line.
- Apply cutaways by hiding the intended near side, not by making the whole object
  transparent.
- Show only fasteners and annotations authorized for that figure.
- Keep part identifiers complete, upright, unoccluded, and near their targets.
- Preserve aspect ratio and adequate whitespace. No source part or label may be
  clipped by a crop or frame.

## Document-ready composite

When integrating:

1. Apply the same frame, background, padding, top label, and visual hierarchy as
   comparable accepted figures.
2. Preserve the approved art inside the composite without redrawing it.
3. Prefer inline placement in Word unless a floating layout is essential.
4. Keep the caption in a separate paragraph immediately after the image.
5. Write alt text that communicates the figure's purpose and important geometry;
   do not merely repeat the filename or caption.
6. Update the figure register with approved source, composite path, approving
   D-build, first public release when known, caption, alt text, and status.
7. Render at 100% and 200% zoom and compare with adjacent figure pages.

## Replacement safety

Map the existing image relationship and size before substitution. For panel
replacement, preserve untouched panels and the parent frame. For whole-figure
replacement, verify that obsolete media and relationships are removed only when
they are no longer referenced. Never perform a document-wide run cleanup merely
to replace one image.
