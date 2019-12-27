function Huv = BandrejectFilter(rows, cols, centers, D0, W, order)

centerNumbers = size(centers,1);
Huv = ones(rows, cols);
[X,Y] = meshgrid(-(cols-1)/2:(cols-1)/2, (rows-1)/2:-1:-(rows-1)/2);
for centerIndex = 1:centerNumbers
    Duv = sqrt((X - centers(centerIndex,1)).^2 + (Y - centers(centerIndex,2)).^2);
    HbrFilt1 = 1./(1 + (Duv.*W./(Duv.^2-D0^2)).^(2*order));
    
    DuvConj = sqrt((X + centers(centerIndex,1)).^2 + (Y + centers(centerIndex,2)).^2);
    HbrFilt2 = 1./(1 + (DuvConj.*W./(DuvConj.^2-D0^2)).^(2*order));
    
    Huv = HbrFilt1 .* Huv .* HbrFilt2;
end
