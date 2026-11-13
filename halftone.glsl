//--------------------------------------------------------------------------
// Based on : https://www.shadertoy.com/view/4sBBDK
//-------------------------------------------------------------------------

const float PI = 3.1415926535897932384626433832795;
const float PI180 = float(PI / 180.0);

float greyScale(in vec3 col) {
    return dot(col, vec3(0.2126, 0.7152, 0.0722));
}

mat2 rotate2d(float angle)
{
    return mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
}

float dotScreen(in vec2 uv, in float angle, in float scale)
{
    vec2 p = (uv - vec2(0.5)) * vec2(resolution);
    vec2 q = rotate2d(angle) * p * scale;
    return (sin(q.x) * sin(q.y)) * 4.0;
}

vec4 pixel(vec2 uv)
{
    vec3 col = texture(source, uv).rgb;
    float angle = 20.0 * PI180;
    float scale = 0.75 + 0.15 * sin(time);
    float pattern = dotScreen(uv, angle, scale);

    vec3 result = clamp(col * 8.0 - 4.0 + vec3(pattern), 0.0, 1.0);
    return vec4(result, 1.0);
}

