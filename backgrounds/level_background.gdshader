shader_type canvas_item;

uniform vec4 color_top : source_color;
uniform vec4 color_bottom : source_color;
uniform float scroll : hint_range(0.0, 1.0, 0.01);

void fragment() {
	float uv_x;
	modf(UV.x + scroll, uv_x);
	COLOR = texture(TEXTURE, vec2(mod(UV.x + scroll, 1.), UV.y));
	COLOR *= mix(color_top, color_bottom, clamp(SCREEN_UV.y, 0., 1.));
}
