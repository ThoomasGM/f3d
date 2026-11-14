vec4 pixel(vec2 uv)
{
  return vec4(vec3(1.0, 1.0, 1.0) - texture(source, uv).rgb, 1.0);
}
