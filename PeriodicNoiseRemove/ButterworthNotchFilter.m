function Huv = ButterworthNotchFilter(rows, cols, centers, D0, order)

centerNumbers = size(centers,1);
Huv = ones(rows, cols);
[X,Y] = meshgrid(-(cols-1)/2:(cols-1)/2, (rows-1)/2:-1:-(rows-1)/2);
for centerIndex = 1:centerNumbers
    Duv = sqrt((X - centers(centerIndex,1)).^2 + (Y - centers(centerIndex,2)).^2);
    ButterworthHighPassPart1 = 1 ./ (1 + ((D0 ./ Duv).^(2*order)));
    
    DuvConj = sqrt((X + centers(centerIndex,1)).^2 + (Y + centers(centerIndex,2)).^2);
    ButterworthHighPassPart2 = 1 ./ (1 + ((D0 ./ DuvConj).^(2*order)));
    Huv = Huv .* ButterworthHighPassPart1 .* ButterworthHighPassPart2;
end
