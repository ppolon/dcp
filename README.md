# Dual Cross Pattern (DCP) feature extractor for face recognition

Multi-Directional Multi-Level Dual-Cross Patterns feature extractor (IEEE TPAMI 2016)

- Author: Changxing Ding (University of Technology Sydney)
- Maintainer: Jonghyun Choi (ppolon@gmail.com)

## Usage

```MATLAB
regionrow = 9; % number of rows of the divided regions
regioncol = 9; % number of cols of the divided regions
radius = [4 6]; % radius of two coaxial circles

img = imread('image.jpg');
feaVec = main(img, regionrow, regioncol, radius);
```

## Reference
Changxing Ding, Jonghyun Choi, Dacheng Tao, and Larry S. Davis, `Multi-Directional Multi-Level Dual-Cross Patterns for Robust Face Recognition', Vol.38, No.3, pp.518-531, IEEE TPAMI 2016.
