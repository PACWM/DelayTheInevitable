shader_type canvas_item;

uniform float fill : hint_range(0.0, 1.0, 0.01);
const float inner_red_radius = 0.5;
const float outer_red_radius = 0.7;

void fragment() {
	//xx + yy = rr
	// || = or ; && = and
	vec2 center = UV - vec2(0.5,0.5);
	float outer_circle = center.x*center.x + center.y * center.y ; //da sistemare
	if (outer_circle <= (outer_red_radius * outer_red_radius) && outer_circle >= (inner_red_radius * inner_red_radius)){
		COLOR = vec4(0,0,0,1);
	}
	
	float green_radius = fill * inner_red_radius;
	
	if (outer_circle <= (green_radius * green_radius)){
		COLOR = vec4(0,fill,0,1);
	}
	
}
