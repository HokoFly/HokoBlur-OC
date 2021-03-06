//
//  StackBlurFilter.cpp
//  HokoBlur-OC
//
//  Created by HokoFly on 2018/11/22.
//

#include <stdio.h>
#include "StackBlurFilter.h"

void doHorizontalBlur(uint32_t *pix, int w, int h, int radius, int startX, int startY, int deltaX, int deltaY);

void doVerticalBlur(uint32_t *pix, int w, int h, int radius, int startX, int startY, int deltaX, int deltaY);

void stackBlur(uint32_t *pixels, int radius, int cores, int index, int direction, int w, int h) {

    using namespace hokoblur;

    if (pixels == NULL) {
        return;
    }

    if (direction == HORIZONTAL) {
        int deltaY = h / cores;
        int startY = index * deltaY;

        if (index == cores - 1) {
            deltaY = h - (cores - 1) * deltaY;
        }

        doHorizontalBlur(pixels, w, h, radius, 0, startY, w, deltaY);

    } else if (direction == VERTICAL) {
        int deltaX = w / cores;
        int startX = index * deltaX;

        if (index == cores - 1) {
            deltaX = w - (cores - 1) * (w / cores);
        }

        doVerticalBlur(pixels, w, h, radius, startX, 0, deltaX, h);
    }

}


void doHorizontalBlur(uint32_t *pix, int w, int h, int radius, int startX, int startY, int deltaX, int deltaY) {

    int wm = w - 1;
    int div = radius + radius + 1;

    int rsum, gsum, bsum, x, y, i, p, yi;
    int *vmin;

    vmin = (int *) malloc(sizeof(int) * max(w, h));

    int divsum = (div + 1) >> 1;
    divsum *= divsum;

    short *dv;
    dv = (short *) malloc(sizeof(short) * 256 * divsum);

    for (i = 0; i < 256 * divsum; i++) {
        dv[i] = (short) (i / divsum);
    }

    //int stack[div][3];

    int (*stack)[3];
    stack = (int (*)[3]) malloc(sizeof(int) * div * 3);

    int stackpointer;
    int stackstart;
    int *sir;
    int rbs;
    int r1 = radius + 1;
    int routsum, goutsum, boutsum;
    int rinsum, ginsum, binsum;
    int baseIndex;
    int endX = startX + deltaX;
    int endY = startY + deltaY;

    for (y = startY; y < endY; y++) {
        rinsum = ginsum = binsum = routsum = goutsum = boutsum = rsum = gsum = bsum = 0;
        baseIndex = y * w;

        for (i = -radius; i <= radius; i++) {
            p = pix[baseIndex + min(wm, max(startX, i + startX))];
            sir = stack[i + radius];
            sir[0] = (p & 0xff0000) >> 16;
            sir[1] = (p & 0x00ff00) >> 8;
            sir[2] = (p & 0x0000ff);
            rbs = r1 - abs(i);
            rsum += sir[0] * rbs;
            gsum += sir[1] * rbs;
            bsum += sir[2] * rbs;
            if (i > 0) {
                rinsum += sir[0];
                ginsum += sir[1];
                binsum += sir[2];
            } else {
                routsum += sir[0];
                goutsum += sir[1];
                boutsum += sir[2];
            }
        }
        stackpointer = radius;

        yi = baseIndex + startX;
        for (x = startX; x < endX; x++) {

            pix[yi] = (0xff000000 & pix[yi]) | (dv[rsum] << 16) | (dv[gsum] << 8) | dv[bsum];

            rsum -= routsum;
            gsum -= goutsum;
            bsum -= boutsum;

            stackstart = stackpointer - radius + div;
            sir = stack[stackstart % div];

            routsum -= sir[0];
            goutsum -= sir[1];
            boutsum -= sir[2];

//            if (y == 0) {
            vmin[x] = min(x + radius + 1, wm);
//            }
            p = pix[baseIndex + vmin[x]];

            sir[0] = (p & 0xff0000) >> 16;
            sir[1] = (p & 0x00ff00) >> 8;
            sir[2] = (p & 0x0000ff);

            rinsum += sir[0];
            ginsum += sir[1];
            binsum += sir[2];

            rsum += rinsum;
            gsum += ginsum;
            bsum += binsum;

            stackpointer = (stackpointer + 1) % div;
            sir = stack[(stackpointer) % div];

            routsum += sir[0];
            goutsum += sir[1];
            boutsum += sir[2];

            rinsum -= sir[0];
            ginsum -= sir[1];
            binsum -= sir[2];

            yi++;
        }
    }


    free(dv);
    free(stack);
}


void doVerticalBlur(uint32_t *pix, int w, int h, int radius, int startX, int startY, int deltaX, int deltaY) {

    int hm = h - 1;
    int hmw = hm * w;
    int div = radius + radius + 1;

    int rsum, gsum, bsum, x, y, i, p, yi;
    int *vmin;

    vmin = (int *) malloc(sizeof(int) * max(w, h));

    int divsum = (div + 1) >> 1;
    divsum *= divsum;

    short *dv;
    dv = (short *) malloc(sizeof(short) * 256 * divsum);

    for (i = 0; i < 256 * divsum; i++) {
        dv[i] = (short) (i / divsum);
    }

    //int stack[div][3];

    int (*stack)[3];
    stack = (int (*)[3]) malloc(sizeof(int) * div * 3);

    int stackpointer;
    int stackstart;
    int *sir;
    int rbs;
    int r1 = radius + 1;
    int routsum, goutsum, boutsum;
    int rinsum, ginsum, binsum;
    int endX = startX + deltaX;
    int endY = startY + deltaY;

    int baseIndex = startY * w;

    for (x = startX; x < endX; x++) {
        rinsum = ginsum = binsum = routsum = goutsum = boutsum = rsum = gsum = bsum = 0;
        for (i = -radius; i <= radius; i++) {
            p = pix[min(hmw, max(baseIndex + i * w, baseIndex)) + x];
            sir = stack[i + radius];
            sir[0] = (p & 0xff0000) >> 16;
            sir[1] = (p & 0x00ff00) >> 8;
            sir[2] = (p & 0x0000ff);
            rbs = r1 - abs(i);
            rsum += sir[0] * rbs;
            gsum += sir[1] * rbs;
            bsum += sir[2] * rbs;
            if (i > 0) {
                rinsum += sir[0];
                ginsum += sir[1];
                binsum += sir[2];
            } else {
                routsum += sir[0];
                goutsum += sir[1];
                boutsum += sir[2];
            }
        }
        stackpointer = radius;

        yi = baseIndex + x;
        for (y = startY; y < endY; y++) {

            pix[yi] = (0xff000000 & pix[yi]) | (dv[rsum] << 16) | (dv[gsum] << 8) | dv[bsum];

            rsum -= routsum;
            gsum -= goutsum;
            bsum -= boutsum;

            stackstart = stackpointer - radius + div;
            sir = stack[stackstart % div];

            routsum -= sir[0];
            goutsum -= sir[1];
            boutsum -= sir[2];


//            if (y == 0) {
            vmin[y] = min(y + radius + 1, hm);
//            }
            p = pix[vmin[y] * w + x];

            sir[0] = (p & 0xff0000) >> 16;
            sir[1] = (p & 0x00ff00) >> 8;
            sir[2] = (p & 0x0000ff);

            rinsum += sir[0];
            ginsum += sir[1];
            binsum += sir[2];

            rsum += rinsum;
            gsum += ginsum;
            bsum += binsum;

            stackpointer = (stackpointer + 1) % div;
            sir = stack[(stackpointer) % div];

            routsum += sir[0];
            goutsum += sir[1];
            boutsum += sir[2];

            rinsum -= sir[0];
            ginsum -= sir[1];
            binsum -= sir[2];

            yi += w;
        }
    }

    free(dv);
    free(stack);
}
