//
// Created by HokoFly on 16/7/28.
//

#include "BoxBlurFilter.h"

void boxBlurHorizontal(uint32_t *, uint32_t *, int width, int radius, int, int, int, int);

void boxBlurVertical(uint32_t *, uint32_t *, int width, int radius, int, int, int, int);

using namespace hokoblur;

void boxBlur(uint32_t *pixels, int radius, int cores, int index, int direction, int w, int h) {

    if (pixels == NULL) {
        return;
    }

    uint32_t *copy = NULL;
    copy = (uint32_t *) malloc(sizeof(uint32_t) * w * h);

    for (int i = 0; i < w * h; i++) {
        copy[i] = pixels[i];
    }

    if (direction == HORIZONTAL) {
        int deltaY = h / cores;
        int startY = index * deltaY;

        if (index == cores - 1) {
            deltaY = h - (cores - 1) * deltaY;
        }

        boxBlurHorizontal(copy, pixels, w, radius, 0, startY, w, deltaY);

    } else if (direction == VERTICAL) {
        int deltaX = w / cores;
        int startX = index * deltaX;

        if (index == cores - 1) {
            deltaX = w - (cores - 1) * (w / cores);
        }

        boxBlurVertical(copy, pixels, w, radius, startX, 0, deltaX, h);
    }

    free(copy);

}

void boxBlurHorizontal(uint32_t *in, uint32_t *out, int width, int radius, int startX, int startY, int deltaX, int deltaY) {
    int tableSize = 2 * radius + 1;
    uint32_t divide[256 * tableSize];

    for (uint32_t i = 0; i < 256 * tableSize; i++)
        divide[i] = i / tableSize;

    for (int y = startY; y < startY + deltaY; y++) {
        int ta = 0, tr = 0, tg = 0, tb = 0;

        for (int i = -radius; i <= radius; i++) {
            int rgb = in[y * width +
                    clamp(i, startX, startX + deltaX - 1)];
            ta += (rgb >> 24) & 0xff;
            tr += (rgb >> 16) & 0xff;
            tg += (rgb >> 8) & 0xff;
            tb += rgb & 0xff;
        }

        int baseIndex = y * width;

        for (int x = startX; x < startX + deltaX; x++) {

            int i1 = x + radius + 1;
            if (i1 > startX + deltaX - 1)
                i1 = startX + deltaX - 1;
            int i2 = x - radius;
            if (i2 < startX)
                i2 = startX;
            int rgb1 = in[baseIndex + i1];
            int rgb2 = in[baseIndex + i2];

            ta += ((rgb1 >> 24) & 0xff) - ((rgb2 >> 24) & 0xff);
            tr += ((rgb1 & 0xff0000) - (rgb2 & 0xff0000)) >> 16;
            tg += ((rgb1 & 0xff00) - (rgb2 & 0xff00)) >> 8;
            tb += (rgb1 & 0xff) - (rgb2 & 0xff);

            out[baseIndex + x] = (divide[ta] << 24) | (divide[tr] << 16) | (divide[tg] << 8) |
                    divide[tb];
        }
    }
}


void boxBlurVertical(uint32_t *in, uint32_t *out, int width, int radius, int startX, int startY, int deltaX, int deltaY) {
    int tableSize = 2 * radius + 1;
    uint32_t divide[256 * tableSize];

    for (uint32_t i = 0; i < 256 * tableSize; i++)
        divide[i] = i / tableSize;

    for (int x = startX; x < startX + deltaX; x++) {
        int ta = 0, tr = 0, tg = 0, tb = 0;

        for (int i = -radius; i <= radius; i++) {
            int rgb = in[x + clamp(i, startY, startY + deltaY - 1) * width];
            ta += (rgb >> 24) & 0xff;
            tr += (rgb >> 16) & 0xff;
            tg += (rgb >> 8) & 0xff;
            tb += rgb & 0xff;
        }

        for (int y = startY; y < startY + deltaY; y++) {
            out[y * width + x] = (divide[ta] << 24) | (divide[tr] << 16) | (divide[tg] << 8) |
                    divide[tb];

            int i1 = y + radius + 1;
            if (i1 > startY + deltaY - 1)
                i1 = startY + deltaY - 1;
            int i2 = y - radius;
            if (i2 < startY)
                i2 = startY;
            int rgb1 = in[x + i1 * width];
            int rgb2 = in[x + i2 * width];

            ta += ((rgb1 >> 24) & 0xff) - ((rgb2 >> 24) & 0xff);
            tr += ((rgb1 & 0xff0000) - (rgb2 & 0xff0000)) >> 16;
            tg += ((rgb1 & 0xff00) - (rgb2 & 0xff00)) >> 8;
            tb += (rgb1 & 0xff) - (rgb2 & 0xff);
        }
    }
}
