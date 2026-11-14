const float STEP = 1.0;

const vec3 gold = vec3(1.0, 0.800, 0.333);

float intensity(vec4 color) {
    return length(color.rgb);
}

vec3 sobel(float stepx, float stepy, vec2 center) {
    float tleft  = intensity(texture(source, center + vec2(-stepx,  stepy)));
    float left   = intensity(texture(source, center + vec2(-stepx,  0.0)));
    float bleft  = intensity(texture(source, center + vec2(-stepx, -stepy)));
    float top    = intensity(texture(source, center + vec2( 0.0,    stepy)));
    float bottom = intensity(texture(source, center + vec2( 0.0,   -stepy)));
    float tright = intensity(texture(source, center + vec2( stepx,  stepy)));
    float right  = intensity(texture(source, center + vec2( stepx,  0.0)));
    float bright = intensity(texture(source, center + vec2( stepx, -stepy)));

    float x = tleft + 2.0 * left + bleft - tright - 2.0 * right - bright;
    float y = -tleft - 2.0 * top - tright + bleft + 2.0 * bottom + bright;
    float color = sqrt(x * x + y * y);
    return vec3(color);
}

vec4 pixel(vec2 uv) 
{
    vec2 px = STEP / vec2(resolution);
    vec3 src = texture(source, uv).rgb;
    float e = clamp(sobel(px.x, px.y, uv).r, 0.0, 1.0);
    return vec4(mix(src, gold, e), 1.0);
}
