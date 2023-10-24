shader_type canvas_item;

uniform vec4 color_primary: source_color;
uniform vec4 color_secondary: source_color;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	COLOR = mix(color_secondary, color_primary, length(col.rgb));
	COLOR.a = col.a;
}
