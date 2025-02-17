shader_type canvas_item;

uniform float num_lines = 20.;
uniform float x_threshold: hint_range(0.0, 1.0) = 0.;
uniform float y_threshold: hint_range(-1,1) = 0;
uniform vec4 line_color_a: source_color = vec4(1.);
uniform vec4 line_color_b: source_color = vec4(0., 0., 0., 1.0);
uniform float bg_alpha: hint_range(0.0, 1.0) = 0.4;
uniform float thickness: hint_range(0.0, 1.0) = 0.5;
uniform float offset: hint_range(0,1) = 0;

void fragment() {
	if (UV.y<y_threshold){
		vec2 tiled_uv = vec2(UV.x, fract((UV.y+offset) * num_lines / 2.));
		if (tiled_uv.y < thickness){
			if(tiled_uv.x < x_threshold){
				COLOR = line_color_a;
			} else{
				if (tiled_uv.x > 1. - x_threshold){
					COLOR = line_color_b * bg_alpha;
				} else{
					COLOR = vec4(0.);
				}
			}
		} else {
			if (tiled_uv.x > 1. - x_threshold){
				COLOR = line_color_b;
			} else{
				if (x_threshold > tiled_uv.x){
					COLOR = line_color_a * bg_alpha;
				} else{
					COLOR = vec4(0.);
				}
			}
		}
	} else{
		COLOR = vec4(0.);
	}
}
