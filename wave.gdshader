shader_type canvas_item;

uniform vec2 speed;

void vertex() {
	VERTEX.y += sin(TIME * speed.y);
}

void fragment() {
	COLOR = texture(TEXTURE, UV + vec2(TIME * speed.x, 0));
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
