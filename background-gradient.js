AFRAME.registerShader('background-gradient', {
    schema: {
        colorTop: { type: 'color', default: '#666666', is: 'uniform' },
        colorBottom: { type: 'color', default: '#1a1a1a', is: 'uniform' }
    },
    vertexShader: `
        varying vec2 vUv;
        void main() {
            vUv = uv;
            gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
        }
    `,
    fragmentShader: `
        uniform vec3 colorTop;
        uniform vec3 colorBottom;
        varying vec2 vUv;
        void main() {
            gl_FragColor = vec4(mix(colorBottom, colorTop, vUv.y), 1.0);
        }
    `
});
