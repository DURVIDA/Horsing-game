shader_type spatial;

uniform vec3 water_color : source_color;
uniform float uv_scale : hint_range(0.0, 10.0, 0.25) = 1.0;
uniform float time_scale : hint_range(0.0, 10.0, 0.25) = 1.0; 
uniform sampler2D water_normal_noise;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable;
uniform sampler2D sun_highlights;

uniform float color_ratio : hint_range(0.0, 1.0, 0.1) = 0.5;

uniform vec2 abberation_r;
uniform vec2 abberation_g; 
uniform vec2 abberation_b; 

vec3 soft_light(vec3 base, vec3 blend){
	vec3 limit = step(0.5, blend);
	return mix(2.0 * base * blend + base * base * (1.0 - 2.0 * blend), sqrt(base) * (2.0 * blend -1.0) + (2.0 * base) * (1.0 - blend), limit);
}

void fragment() {
	
	vec2 _uv = UV* uv_scale;
	vec2 _suv = SCREEN_UV;
	
	_uv.x += sin(TIME * time_scale + (_uv.x + _uv.y) * 25.0) * 0.01;
	_uv.y += cos(TIME * time_scale + (_uv.x - _uv.y) * 25.0) * 0.01;
	
	_suv.x += sin(TIME * time_scale + (_suv.x + _suv.y) * 25.0) * 0.01;
	_suv.y += cos(TIME * time_scale + (_suv.x - _suv.y) * 25.0) * 0.01;
	
	float r = texture(sun_highlights, _uv + abberation_r).r;
	float g = texture(sun_highlights, _uv + abberation_g).g;
	float b = texture(sun_highlights, _uv + abberation_b).b;
	
	vec3 blended = soft_light(vec3(r,g,b), texture(screen_texture, _suv).rgb);
	
	ALBEDO = blended;
	NORMAL_MAP = texture(water_normal_noise, _uv).rgb;
	NORMAL *= 0.5;
	ROUGHNESS = 0.2;
	ALPHA = 0.5;
	
}