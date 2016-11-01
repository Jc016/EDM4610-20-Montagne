// Port to processing by Jean-Christophe Leclerc-Massé
// Originaly from https://www.shadertoy.com/view/ldXGW4
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif
varying vec4 vertTexCoord;
uniform sampler2D origin, texture;
uniform float  time;
uniform vec2   resolution;
uniform int  frame;

void main( )
{
    vec2 uv = vertTexCoord.st;

    if (frame < 10) {
    	gl_FragColor = texture2D(origin, uv);
    } else {

        vec2 vUv = vertTexCoord.st;
        vec2 texel = 1. / resolution.xy;

        vec3 uv = texture2D(texture, vUv).xyz;

        float gt = mod(time*vUv.x*vUv.y, 2.0*3.1415)*1.0;

        vec2 d1 = vec2(uv.x*vec2(texel.x*sin(gt*uv.z), texel.y*cos(gt*uv.x)));
        vec2 d2 = vec2(uv.y*vec2(texel.x*sin(gt*uv.x), texel.y*cos(gt*uv.y)));
        vec2 d3 = vec2(uv.z*vec2(texel.x*sin(gt*uv.y), texel.y*cos(gt*uv.z)));

        float bright = (uv.x+uv.y+uv.z)/3.0+0.5;

        float r = texture2D(texture, vUv+d1*bright).x;
        float g = texture2D(texture, vUv+d2*bright).y;
        float b = texture2D(texture, vUv+d3*bright).z;

        vec3 uvMix = mix(uv, vec3(r,g,b), 0.2);

        vec3 orig = texture2D(origin, vUv).xyz;

        gl_FragColor = vec4(mix(uvMix, orig, 0.007), 1.0);

    }
}
