shader_type spatial;
// Drapes an orthophoto (color.png) onto a Terrain3D baked mesh.
// Terrain3D bakes UV = vertex world (X, Z) in METRES, so we normalise by the
// terrain's covered extent to map the image across the surface exactly once.

uniform sampler2D aerial : source_color, filter_linear, repeat_disable;
uniform vec2 terrain_size = vec2(4740.0, 3017.0); // metres the image covers (X, Z) = px * vertex_spacing
uniform vec2 terrain_offset = vec2(0.0, 0.0);     // metres; nudge if the image is shifted
uniform bool flip_v = false;                       // toggle if the image is N-S mirrored

void fragment() {
    vec2 uv = (UV - terrain_offset) / terrain_size;
    if (flip_v) {
        uv.y = 1.0 - uv.y;
    }
    ALBEDO = texture(aerial, uv).rgb;
    ROUGHNESS = 1.0;
    SPECULAR = 0.0;
}
