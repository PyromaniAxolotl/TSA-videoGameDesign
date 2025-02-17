shader_type canvas_item;

uniform vec4 new_color: source_color = vec4(0,255,0,255);

void fragment() {
	vec4 curr_color = texture(TEXTURE,UV);
	if (curr_color.a>0.4 && curr_color.a<0.6){
		COLOR.a = new_color.a;
		COLOR.rgb = new_color.rgb * curr_color.rgb;
	}
}