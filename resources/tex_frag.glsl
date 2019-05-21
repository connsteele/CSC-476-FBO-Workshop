#version 330 core

in vec2 texCoord;
out vec4 color;
uniform sampler2D texBuf;
uniform float time;

uniform float offset[5] = float[]( 0.0, 1.0, 2.0, 3.0, 4.0 );
uniform float weight[5] = float[]( 0.2270270270, 0.1945945946, 0.1216216216, 0.0540540541, 0.0162162162 );

void main(){
	vec3 blue = vec3(0, 0, 0.5);

	vec3 texColor = texture( texBuf, texCoord ).rgb;
	//TODO modify to show this is a 2D image
	//if (gl_FragCoord.x > 680 ) // Draw half of the texture blue
	//{
	//	texColor -= blue;
	//}

	float d = distance(vec2(gl_FragCoord), vec2(640, 480)); // Calculate a distance
	texColor += (1 - (d / 1280)) * vec3(0.65, 0.4, 0.0); // Compute a color based on distance
	clamp(texColor, 0.0, 1.0);


	vec4 tempColor = vec4(texture( texBuf, texCoord ).rgb, 1);

    color = tempColor*weight[0];

    for (int i=1; i <5; i ++) {
        color += vec4(texture( texBuf, texCoord + vec2(offset[i], 0.0)/512.0 ).rgb, 1)*weight[i];
        color += vec4(texture( texBuf, texCoord - vec2(offset[i], 0.0)/512.0 ).rgb, 1)*weight[i];
    }

    if (tempColor.r > tempColor.b && tempColor.g > tempColor.b) {
      color.xyz += 0.01 * vec3(0.6, 0.4, 0.0);
    }



	//color = vec4(texColor, 1.0);

}
