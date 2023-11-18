shader_type canvas_item;

uniform vec4 color_primary: source_color;
uniform vec4 color_secondary: source_color;

// account for modulation:
// https://github.com/godotengine/godot/issues/49781#issuecomment-1543250039
varying flat vec4 modulate;

void vertex() {
	modulate = COLOR;
}

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	COLOR = mix(color_secondary, color_primary, length(col.rgb));
	COLOR.a = col.a;
	COLOR *= modulate;
}
