/*
 * @file    Mix.comp.glsl
 * @author  David Gallardo Moreno
 */


#version 430
precision highp float;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(binding = 0, rgba16f) uniform image2D uOutputBuffer0;
layout(binding = 1, rgba16f) uniform image2D uInputBuffer0;

layout(location = 100) uniform ivec3 uOutputBufferSize;
layout(location = 101) uniform ivec3 uInvocationOffset;

layout(location = 0)  uniform vec4      uBeginColor;
layout(location = 1)  uniform vec4      uEndColor;

void main(void)
{
    ivec2 lBufferCoord = ivec2(gl_GlobalInvocationID.xy + uInvocationOffset.xy);
    //vec2 lUV = (vec2(lBufferCoord.xy) / vec2(uOutputBufferSize.xy));
    vec4 lInputColor = imageLoad(uInputBuffer0, lBufferCoord);
    vec4 lOutputColor = mix(uBeginColor, uEndColor, lInputColor);
    imageStore (uOutputBuffer0, lBufferCoord, clamp(lOutputColor, 0.0, 1.0));
}
