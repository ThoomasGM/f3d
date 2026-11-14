float lum(vec3 c) {
    return dot(c, vec3(0.299, 0.587, 0.114));
}

vec4 pixel(vec2 uv) {
    vec2 p = 1.0 / vec2(resolution);

    // sobel tap
    float s[8];
    s[0] = lum(texture(source, uv + vec2(-p.x, -p.y)).rgb);
    s[1] = lum(texture(source, uv + vec2( 0.0, -p.y)).rgb);
    s[2] = lum(texture(source, uv + vec2( p.x, -p.y)).rgb);
    s[3] = lum(texture(source, uv + vec2(-p.x,  0.0)).rgb);
    s[4] = lum(texture(source, uv + vec2( p.x,  0.0)).rgb);
    s[5] = lum(texture(source, uv + vec2(-p.x,  p.y)).rgb);
    s[6] = lum(texture(source, uv + vec2( 0.0,  p.y)).rgb);
    s[7] = lum(texture(source, uv + vec2( p.x,  p.y)).rgb);

    float gx = (s[2] + 2.0*s[4] + s[7]) - (s[0] + 2.0*s[3] + s[5]);
    float gy = (s[5] + 2.0*s[6] + s[7]) - (s[0] + 2.0*s[1] + s[2]);
    float ink = smoothstep(0.1, 0.25, length(vec2(gx, gy)));

    // posterize (5 steps)
    vec3 col = texture(source, uv).rgb;
    col = floor(col * 5.0 + 0.5) * 0.2;

    // saturation boost
    col = clamp(mix(vec3(lum(col)), col, 1.3), 0.0, 1.0);

    return vec4(col * (1.0 - ink), 1.0);
}
