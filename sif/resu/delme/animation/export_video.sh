#!/bin/zsh
ffmpeg -framerate 1 -i  moving_barrier.000%01d.png -c:v libx264 -r 30 -pix_fmt yuv420p 00.mp4
ffmpeg -framerate 1 -i  moving_barrier.001%01d.png -c:v libx264 -r 30 -pix_fmt yuv420p 01.mp4
ffmpeg -framerate 2 -i  moving_barrier.002%01d.png -c:v libx264 -r 30 -pix_fmt yuv420p 02.mp4
ffmpeg -framerate 2 -i  moving_barrier.003%01d.png -c:v libx264 -r 30 -pix_fmt yuv420p 03.mp4
ffmpeg -framerate 2 -i  moving_barrier.004%01d.png -c:v libx264 -r 30 -pix_fmt yuv420p 04.mp4
ffmpeg -framerate 2 -i  moving_barrier.005%01d.png -c:v libx264 -r 30 -pix_fmt yuv420p 05.mp4
ffmpeg -framerate 2 -i  moving_barrier.006%01d.png -c:v libx264 -r 30 -pix_fmt yuv420p 06.mp4
ffmpeg -framerate 2 -i  moving_barrier.007%01d.png -c:v libx264 -r 30 -pix_fmt yuv420p 07.mp4
ffmpeg -framerate 2 -i  moving_barrier.008%01d.png -c:v libx264 -r 30 -pix_fmt yuv420p 08.mp4
ffmpeg -framerate 2 -i  moving_barrier.009%01d.png -c:v libx264 -r 30 -pix_fmt yuv420p 09.mp4

ffmpeg -framerate 2 -i  moving_barrier.01%02d.png -c:v libx264 -r 30 -pix_fmt yuv420p 10.mp4
ffmpeg -framerate 2 -i  moving_barrier.02%02d.png -c:v libx264 -r 30 -pix_fmt yuv420p 11.mp4
ffmpeg -framerate 2 -i  moving_barrier.03%02d.png -c:v libx264 -r 30 -pix_fmt yuv420p 12.mp4
ffmpeg -framerate 2 -i  moving_barrier.04%02d.png -c:v libx264 -r 30 -pix_fmt yuv420p 13.mp4
ffmpeg -framerate 2 -i  moving_barrier.05%02d.png -c:v libx264 -r 30 -pix_fmt yuv420p 14.mp4
ffmpeg -framerate 2 -i  moving_barrier.06%02d.png -c:v libx264 -r 30 -pix_fmt yuv420p 15.mp4
ffmpeg -framerate 2 -i  moving_barrier.07%02d.png -c:v libx264 -r 30 -pix_fmt yuv420p 16.mp4
