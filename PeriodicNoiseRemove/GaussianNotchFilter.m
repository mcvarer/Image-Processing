function Huv = GaussianNotchFilter(rows, cols, centers, D0, order)

centerNumbers = size(centers,1);
Huv = ones(rows, cols);
[X,Y] = meshgrid(-(cols-1)/2:(cols-1)/2, (rows-1)/2:-1:-(rows-1)/2);
for centerIndex = 1:centerNumbers
    Duv = sqrt((X - centers(centerIndex,1)).^2 + (Y - centers(centerIndex,2)).^2);
    GaussianFilter1 = exp(-Duv.^2./(2*D0^order));
    
    DuvConj = sqrt((X + centers(centerIndex,1)).^2 + (Y + centers(centerIndex,2)).^2);
    GaussianFilter2 = exp(-DuvConj.^2./(2*D0^order));
    Huv = Huv .* GaussianFilter1 .* GaussianFilter2;
end
