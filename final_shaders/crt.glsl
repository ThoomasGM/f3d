vec4 pixel(vec2 uv)
{
    float wave = abs(sin((uv * resolution.xy).y + time));
    return vec4(mix(texture(source, uv).rgb,vec3(0.0),wave),1.0);
}