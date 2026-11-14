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
    float wave = abs(sin((uv * resolution.xy).y + time));
    return vec4(mix(texture(source, uv).rgb,vec3(0.0),wave),1.0);
}
