#pragma glslify: pnoise = require(glsl-noise/periodic/3d)


    // float heightX = sin(vUv.x * 10.0 + time * 0.03) * speed;
    // float heightY = sin(vUv.y * 10.0 + time * 0.03) * speed;
    // float noiseMap = texture2D( map, vec2(heightX, heightY)).r;

    varying vec2 vUv;
    varying float noise;
    uniform float time;
    uniform float ok;

    float turbulence( vec3 p ) {
        float w = 100.0;
        float t = -.5;
        for (float f = 1.0 ; f <= 10.0 ; f++ ){
            float power = pow( 2.0, f );
            t += abs( pnoise( vec3( power * p ), vec3( 10.0, 10.0, 10.0 ) ) / power );
        }
        return t;
    }

    void main() {

        vUv = uv;

        // add time to the noise parameters so it's animated
        noise = 0.10 *  1.10 * turbulence( .5 * normal + time );
        float b = .9 * pnoise( 10.15 * position + vec3( 2.0 * time ), vec3( 100.0 ) );
        float displacement = - noise + b;

        vec3 newPosition = position + normal;// * (displacement * ok);
        gl_Position = projectionMatrix * modelViewMatrix * vec4( newPosition, 1.0 );

    }
