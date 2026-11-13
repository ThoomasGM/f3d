//Temporal with the entire frame
// vec4 pixel(vec2 uv)
// {
//     vec4 current = texture(source, uv);
//     vec4 past = texture(history, uv);

//     float decay = 0.50; //Delay remanence of the past frame

//     return mix(current, past, decay);
// }

//Temporal with the entire frame and rgb différent offsets
vec4 pixel(vec2 uv)
{
    vec4 current = texture(source, uv);
    vec4 pastClean = texture(history, uv);

    //If the model is not moving, put rgb back
    // Motion delta
    float motion = length(current.rgb - pastClean.rgb);

    if (motion < 0.06)
    {
        return current;
    }

    // Speed factor [0, 1]
    float motionFactor = smoothstep(0.06, 0.12, motion);
    // Trail decay (0 if still)
    float dynamicDecay = mix(0.0, 0.75, motionFactor);

    //Only during movement
    vec2 offset = vec2(0.003, 0.0015) * motionFactor;

    float r = texture(history, uv + offset).r;
    float g = pastClean.g;
    float b = texture(history, uv - offset).b;

    // Rebuilt past frame
    vec4 past = vec4(r, g, b, 1.0);

    return mix(current, past, dynamicDecay);
}