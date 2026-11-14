// ---------------------------------------------------------------------------
// Name    : Aura
// Authors : Palpatoche8 <scheepers.thomas78@gmail.com>
// Ref     : Original work
// License : BSD-3-Clause (F3D)
// ---------------------------------------------------------------------------

const vec3 AURA_COLOR = vec3(1.0, 0.8, 0.4); // slider(0.0, 1.0)
const vec3 CORE_COLOR = vec3(1.0, 1.0, 0.9); // slider(0.0, 1.0)
const float AURA_RADIUS = 0.07; // slider(0.0, 0.2)
const float AURA_STRENGTH = 1.5; // slider(0.0, 3.0)
const float RIM_STRENGTH = 0.6; // slider(0.0, 2.0)
const float RAYS_STRENGTH = 0.30; // slider(0.0, 1.0)
const float BG_THRESHOLD = 0.03; // slider(0.0, 0.2)
const int DIRS = 16; // slider(4, 32)
const int STEPS = 6; // slider(1, 12)


float objectMask(vec2 uv, vec3 bg)
{
  vec3 c = texture(source, clamp(uv, 0.0, 1.0)).rgb;
  return smoothstep(BG_THRESHOLD, BG_THRESHOLD * 3.0, distance(c, bg));
}

vec4 pixel(vec2 uv)
{
  vec3 bg = texture(source, vec2(0.002)).rgb;
  vec3 col = texture(source, uv).rgb;
  float aspect = float(resolution.x) / float(resolution.y);

  float self = objectMask(uv, bg);
  float outside = 1.0 - self;

  float glow = 0.0;
  float ring = 0.0;
  float wsum = 0.0;
  for (int i = 0; i < DIRS; i++)
  {
    float a = 6.28 * (float(i) + 0.5) / float(DIRS);
    vec2 dir = vec2(cos(a) / aspect, sin(a));
    for (int j = 1; j <= STEPS; j++)
    {
      float t = float(j) / float(STEPS);
      float w = 1.0 - t * 0.8;
      float m = objectMask(uv + dir * AURA_RADIUS * t, bg);
      glow += w * m;
      wsum += w;
      if (j == 1) 
        ring += m;
    }
  }
  glow /= wsum;
  ring /= float(DIRS);

  float pulse = 0.85 + 0.15 * sin(time * 2.0);
  float g = pow(glow, 0.6) * pulse;

  vec3 result = col;

  vec3 auraCol = mix(AURA_COLOR, CORE_COLOR, smoothstep(0.3, 0.9, g));
  result += auraCol * g * AURA_STRENGTH * outside;

  float rim = self * (1.0 - ring);
  result += CORE_COLOR * rim * RIM_STRENGTH * pulse;

  vec2 p = uv - vec2(0.5, 1.2);
  p.x *= aspect;
  float ang = atan(p.x, -p.y);
  float rays = 0.6 * pow(0.5 + 0.5 * sin(ang * 22.0 + time * 0.4), 8.0)
             + 0.4 * pow(0.5 + 0.5 * sin(ang * 9.0 - time * 0.25), 4.0);
  float fall = 1.0 - smoothstep(0.3, 1.6, length(p));
  result += AURA_COLOR * rays * fall * RAYS_STRENGTH * outside;

  return vec4(result, 1.0);
}
