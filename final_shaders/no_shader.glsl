// ---------------------------------------------------------------------------
// Name    : No shader
// Authors : lance-leau <lancelot.dou7@gmail.com>
// Ref     : Original work
// License : BSD-3-Clause (F3D)
// ---------------------------------------------------------------------------

vec4 pixel(vec2 uv)
{
  return texture(source, uv);
}
