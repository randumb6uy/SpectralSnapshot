shader_type canvas_item;


uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float ca_strength = 20.0;

uniform int amount = 40;


void fragment() {
	// Called for every pixel the material is visible on.
	vec2 grid_uv = round(UV * float(amount)) / float(amount);
	
	vec4 text = texture(TEXTURE, grid_uv);
	
	
	vec2 ca_offset = vec2(ca_strength,0.0)*SCREEN_PIXEL_SIZE;
	text.r= texture(SCREEN_TEXTURE , SCREEN_UV - ca_offset).r;
	text.g= texture(SCREEN_TEXTURE , SCREEN_UV).g;
	text.b= texture(SCREEN_TEXTURE , SCREEN_UV + ca_offset).b;
	text.a = 1.0;
	COLOR = text;
	
}




//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
