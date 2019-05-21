#version 330 core

in vec2 texCoord;
out vec4 color;
uniform sampler2D texBuf;
uniform float time;

void main(){
	vec3 blue = vec3(0, 0, 0.5);

	vec3 texColor = texture( texBuf, vec2(time / 2.0 + texCoord.x, texCoord.y + 0.15 * sin(time - gl_FragCoord.x / 100) ) ).rgb;
	//TODO modify to show this is a 2D image
	//if (gl_FragCoord.x > 680 ) // Draw half of the texture blue
	//{
	//	texColor -= blue;
	//}

	float d = distance(vec2(gl_FragCoord), vec2(640, 480)); // Calculate a distance
	texColor += (1 - (d / 1280)) * vec3(0.65, 0.4, 0.0); // Compute a color based on distance
	clamp(texColor, 0.0, 1.0);



	color = vec4(texColor, 1.0);

}
