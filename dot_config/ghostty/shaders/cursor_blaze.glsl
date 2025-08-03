lowp float ease(lowp float x) {
    return pow(1.0 - x, 10.0);
}

lowp float sdBox(in vec2 p, in vec2 xy, in vec2 b)
{
    vec2 d = abs(p - xy) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

lowp float getSdfRectangle(in vec2 p, in vec2 xy, in vec2 b)
{
    vec2 d = abs(p - xy) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}
// Based on Inigo Quilez's 2D distance functions article: https://iquilezles.org/articles/distfunctions2d/
// Potencially optimized by eliminating conditionals and loops to enhance performance and reduce branching
lowp float seg(in vec2 p, in vec2 a, in vec2 b, inout lowp float s, lowp float d) {
    vec2 e = b - a;
    vec2 w = p - a;
    vec2 proj = a + e * clamp(dot(w, e) / dot(e, e), 0.0, 1.0);
    lowp float segd = dot(p - proj, p - proj);
    d = min(d, segd);

    lowp float c0 = step(0.0, p.y - a.y);
    lowp float c1 = 1.0 - step(0.0, p.y - b.y);
    lowp float c2 = 1.0 - step(0.0, e.x * w.y - e.y * w.x);
    lowp float allCond = c0 * c1 * c2;
    lowp float noneCond = (1.0 - c0) * (1.0 - c1) * (1.0 - c2);
    lowp float flip = mix(1.0, -1.0, step(0.5, allCond + noneCond));
    s *= flip;
    return d;
}

lowp float getSdfParallelogram(in vec2 p, in vec2 v0, in vec2 v1, in vec2 v2, in vec2 v3) {
    lowp float s = 1.0;
    lowp float d = dot(p - v0, p - v0);

    d = seg(p, v0, v3, s, d);
    d = seg(p, v1, v0, s, d);
    d = seg(p, v2, v1, s, d);
    d = seg(p, v3, v2, s, d);

    return s * sqrt(d);
}

vec2 normalize(vec2 value, lowp float isPosition) {
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

lowp float blend(lowp float t)
{
    lowp float sqr = t * t;
    return sqr / (2.0 * (sqr - t) + 1.0);
}

lowp float antialising(lowp float distance) {
    return 1. - smoothstep(0., normalize(vec2(2., 2.), 0.).x, distance);
}

lowp float determineStartVertexFactor(vec2 a, vec2 b) {
    // Conditions using step
    lowp float condition1 = step(b.x, a.x) * step(a.y, b.y); // a.x < b.x && a.y > b.y
    lowp float condition2 = step(a.x, b.x) * step(b.y, a.y); // a.x > b.x && a.y < b.y

    // If neither condition is met, return 1 (else case)
    return 1.0 - max(condition1, condition2);
}
vec2 getRectangleCenter(vec4 rectangle) {
    return vec2(rectangle.x + (rectangle.z / 2.), rectangle.y - (rectangle.w / 2.));
}

const vec4 TRAIL_COLOR = vec4(1.0, 0.46, 0.8, 1.0);
const vec4 CURRENT_CURSOR_COLOR = TRAIL_COLOR;
const vec4 PREVIOUS_CURSOR_COLOR = TRAIL_COLOR;
// const vec4 TRAIL_COLOR = vec4(0.482, 0.886, 1.0, 1.0);
const vec4 TRAIL_COLOR_ACCENT = vec4(1.0, 0., 0., 1.0); // red-orange
//const vec4 TRAIL_COLOR_ACCENT = vec4(1.0, 0.725, 0.161, 1.0); // yellow
// const vec4 TRAIL_COLOR_ACCENT = vec4(0.0, 0.424, 1.0, 1.0);
const lowp float DURATION = .5;
const lowp float OPACITY = .2;

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    #if !defined(WEB)
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    #endif
    //Normalization for fragCoord to a space of -1 to 1;
    vec2 vu = normalize(fragCoord, 1.);
    vec2 offsetFactor = vec2(-.5, 0.5);

    //Normalization for cursor position and size;
    //cursor xy has the postion in a space of -1 to 1;
    //zw has the width and height
    vec4 currentCursor = vec4(normalize(iCurrentCursor.xy, 1.), normalize(iCurrentCursor.zw, 0.));
    vec4 previousCursor = vec4(normalize(iPreviousCursor.xy, 1.), normalize(iPreviousCursor.zw, 0.));

    //When drawing a parellelogram between cursors for the trail i need to determine where to start at the top-left or top-right vertex of the cursor
    lowp float vertexFactor = determineStartVertexFactor(currentCursor.xy, previousCursor.xy);
    lowp float invertedVertexFactor = 1.0 - vertexFactor;

    //Set every vertex of my parellogram
    vec2 v0 = vec2(currentCursor.x + currentCursor.z * vertexFactor, currentCursor.y - currentCursor.w);
    vec2 v1 = vec2(currentCursor.x + currentCursor.z * invertedVertexFactor, currentCursor.y);
    vec2 v2 = vec2(previousCursor.x + currentCursor.z * invertedVertexFactor, previousCursor.y);
    vec2 v3 = vec2(previousCursor.x + currentCursor.z * vertexFactor, previousCursor.y - previousCursor.w);

    vec4 newColor = vec4(fragColor);

    lowp float progress = blend(clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1));
    lowp float easedProgress = ease(progress);

    //Distance between cursors determine the total length of the parallelogram;
    vec2 centerCC = getRectangleCenter(currentCursor);
    vec2 centerCP = getRectangleCenter(previousCursor);
    lowp float lineLength = distance(centerCC, centerCP);
    lowp float distanceToEnd = distance(vu.xy, centerCC);
    lowp float alphaModifier = distanceToEnd / (lineLength * (easedProgress));
    //float alphaModifier = distanceToEnd / (lineLength * (1 - progress));

    if (alphaModifier > 1.0) {
      alphaModifier = 1.0;
    }

    lowp float sdfCursor = getSdfRectangle(vu, currentCursor.xy - (currentCursor.zw * offsetFactor), currentCursor.zw * 0.5);
    lowp float sdfTrail = getSdfParallelogram(vu, v0, v1, v2, v3);

    newColor = mix(newColor, TRAIL_COLOR_ACCENT, 1.0 - smoothstep(sdfTrail, -0.01, 0.001));
    newColor = mix(newColor, TRAIL_COLOR, antialising(sdfTrail));

    newColor = mix(fragColor, newColor, 1.0 - alphaModifier);
    fragColor = mix(newColor, fragColor, step(sdfCursor, 0));
}
