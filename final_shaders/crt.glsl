// ---------------------------------------------------------------------------
// Name    : CRT
// Authors : Jules Caron <jules.caron@epita.fr>
// Ref     : CRT by kbjwes77 - https://www.shadertoy.com/view/WsVSzV
// License : CC BY-NC-SA 3.0 (Shadertoy default, no license stated by author)
// ---------------------------------------------------------------------------

float warp = 1.00; // slider(0.0, 2.0)
float scan = 2.00; // slider(0.0, 2.0)

vec4 pixel(vec2 uv)
{
    vec3 value = texture(source, uv).rgb;
	vec2 fragCoord = uv * resolution.xy;
	vec2 dc = abs(0.5-uv);
    dc *= dc;
    
    uv.x -= 0.5; uv.x *= 1.0+(dc.y*(0.3*warp)); uv.x += 0.5;
    uv.y -= 0.5; uv.y *= 1.0+(dc.x*(0.4*warp)); uv.y += 0.5;

    if (uv.y > 1.0 || uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0)
        return vec4(0.0,0.0,0.0,1.0);
    else
    	{
        float apply = abs(sin(fragCoord.y)*0.5*scan);

    	return vec4(mix(value,vec3(0.0),apply),1.0);
        }
}
