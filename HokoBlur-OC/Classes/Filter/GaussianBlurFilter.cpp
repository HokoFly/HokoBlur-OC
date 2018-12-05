//
// Created by HokoFly on 16/9/10.
//

#include "GaussianBlurFilter.h"

using namespace hokoblur;

float *makeKernel(int r);

void gaussianBlurHorizontal(float *kernel, uint32_t *inPixels, uint32_t *outPixels, int width, int radius, int startX, int startY, int deltaX, int deltaY);

void gaussianBlurVertical(float *kernel, uint32_t *inPixels, uint32_t *outPixels, int width, int radius, int startX, int startY, int deltaX, int deltaY);

void gaussianBlur(uint32_t *pixels, int radius, int cores, int index, int direction, int w, int h) {
    if (pixels == NULL) {
        return;
    }

    float *kernel = NULL;
    kernel = makeKernel(radius);

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

        gaussianBlurHorizontal(kernel, copy, pixels, w, radius, 0, startY, w, deltaY);

    } else if (direction == VERTICAL) {
        int deltaX = w / cores;
        int startX = index * deltaX;

        if (index == cores - 1) {
            deltaX = w - (cores - 1) * (w / cores);
        }

        gaussianBlurVertical(kernel, copy, pixels, w, radius, startX, 0, deltaX, h);
    }


    free(copy);
    free(kernel);
}

void gaussianBlurHorizontal(float *kernel, uint32_t *inPixels, uint32_t *outPixels, int width, int radius, int startX, int startY, int deltaX, int deltaY) {
    int cols = 2 * radius + 1;
    int cols2 = cols / 2;
    int x, y, col;

    int endY = startY + deltaY;
    int endX = startX + deltaX;

    for (y = startY; y < endY; y++) {
        int ioffset = y * width;
        for (x = startX; x < endX; x++) {
            float r = 0, g = 0, b = 0;
            int moffset = cols2;
            for (col = -cols2; col <= cols2; col++) {
                float f = kernel[moffset + col];

                if (f != 0) {
                    int ix = x + col;
                    if (ix < startX) {
                        ix = startX;
                    } else if (ix >= endX) {
                        ix = endX - 1;
                    }
                    int rgb = inPixels[ioffset + ix];
                    r += f * ((rgb >> 16) & 0xff);
                    g += f * ((rgb >> 8) & 0xff);
                    b += f * (rgb & 0xff);
                }
            }

            int outIndex = ioffset + x;
            uint32_t ia = (inPixels[ioffset + x] >> 24) & 0xff;
            uint32_t ir = (uint32_t) clamp((uint32_t) (r + 0.5), 0, 255);
            uint32_t ig = (uint32_t) clamp((uint32_t) (g + 0.5), 0, 255);
            uint32_t ib = (uint32_t) clamp((uint32_t) (b + 0.5), 0, 255);
            outPixels[outIndex] = (ia << 24) | (ir << 16) | (ig << 8) | ib;
        }
    }
}

void gaussianBlurVertical(float *kernel, uint32_t *inPixels, uint32_t *outPixels, int width, int radius, int startX, int startY, int deltaX, int deltaY) {
    int cols = 2 * radius + 1;
    int cols2 = cols / 2;
    int x, y, col;

    int endY = startY + deltaY;
    int endX = startX + deltaX;

    for (x = startX; x < endX; x++) {
        int ioffset = x;
        for (y = startY; y < endY; y++) {
            float r = 0, g = 0, b = 0;
            int moffset = cols2;
            for (col = -cols2; col <= cols2; col++) {
                float f = kernel[moffset + col];

                if (f != 0) {
                    int iy = y + col;
                    if (iy < startY) {
                        iy = startY;
                    } else if (iy >= endY) {
                        iy = endY - 1;
                    }
                    int rgb = inPixels[ioffset + iy * width];
                    r += f * ((rgb >> 16) & 0xff);
                    g += f * ((rgb >> 8) & 0xff);
                    b += f * (rgb & 0xff);
                }
            }
            int outIndex = ioffset + y * width;
            uint32_t ia = (inPixels[ioffset + x] >> 24) & 0xff;
            uint32_t ir = (uint32_t) clamp((uint32_t) (r + 0.5), 0, 255);
            uint32_t ig = (uint32_t) clamp((uint32_t) (g + 0.5), 0, 255);
            uint32_t ib = (uint32_t) clamp((uint32_t) (b + 0.5), 0, 255);
            outPixels[outIndex] = (ia << 24) | (ir << 16) | (ig << 8) | ib;
        }
    }
}

float *makeKernel(int r) {
    int i, row;
    int rows = r * 2 + 1;
    float *matrix = (float *) malloc(sizeof(float) * rows);
    float sigma = (r + 1) / 2.0f;
    float sigma22 = 2 * sigma * sigma;
    float total = 0;
    int index = 0;
    for (row = -r; row <= r; row++) {
        matrix[index] = exp(-1 * (row * row) / sigma22) / sigma;
        total += matrix[index];
        index++;
    }
    for (i = 0; i < rows; i++) {
        matrix[i] /= total;
    }

    return matrix;
}

