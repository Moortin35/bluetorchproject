shader_type canvas_item;

uniform float amount : hint_range(0.0, 1.0) = 0.1;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    vec4 blurred = vec4(0.0);

    blurred += texture(TEXTURE, UV + vec2(TEXTURE_PIXEL_SIZE.x, 0.0));
    blurred += texture(TEXTURE, UV + vec2(-TEXTURE_PIXEL_SIZE.x, 0.0));
    blurred += texture(TEXTURE, UV + vec2(0.0, TEXTURE_PIXEL_SIZE.y));
    blurred += texture(TEXTURE, UV + vec2(0.0, -TEXTURE_PIXEL_SIZE.y));

    blurred /= 4.0;

    COLOR = mix(color, blurred, amount);
}