shader_type canvas_item;

uniform sampler2D noise_texture : filter_linear, repeat_enable;
uniform float splatter_threshold : hint_range(0.0, 1.0) = 0.5;
uniform vec4 blood_color : source_color = vec4(0.6, 0.0, 0.0, 1.0);
uniform float blend_strength : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    vec2 uv = UV;

    // Base texture sample
    vec4 base_col = texture(TEXTURE, uv);

    // Use alpha as a mask (to match sprite's shape)
    float alpha_mask = base_col.a;

    // Sample noise texture
    float noise_val = texture(noise_texture, uv).r;

    // Compute splatter mask (1.0 where noise <= threshold)
    float splatter_mask = step(noise_val, splatter_threshold);

    // Apply blood only where the sprite is visible
    float final_mask = splatter_mask * alpha_mask;

    // Blend blood color with base color
    vec4 result = mix(base_col, blood_color, final_mask * blend_strength);

    // Preserve original alpha
    result.a = base_col.a;

    COLOR = result;
}