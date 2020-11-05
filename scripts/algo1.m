clear all;
close all;

% Per treballar al laboratori
% dirMask = dir('C:\Users\piv430\Desktop\Prog0\Masks-Ideal');
% dirImg = dir('C:\Users\piv430\Desktop\Prog0\Images');

% Per treballar al PC Laura
dirMask = dir('/home/laura/Desktop/Adria-Laura/Training-Dataset/Masks-Ideal');
dirImg = dir('/home/laura/Desktop/Adria-Laura/Training-Dataset/Images');

% Generació de la matriu histograma de les components CbCr
histCbCr = zeros(256); 

numMask = size(dirMask);
numFile = size(dirImg);

% Comprovació que el número de màscares i imatges són els mateixos
if(numMask(1) ~= numFile(1))
    error('Numero dimatges i mascares diferents');
end

% Per cada imatge
for l=3:1:numMask(1)
    
    % Accés al directori de les imatges
    cd('/home/laura/Desktop/Adria-Laura/Training-Dataset/Images');
    % Conversió RGB a YCbCr
    ycbcr=rgb2ycbcr(imread(dirImg(l).name));
    
    % Accés al directori de les mascares
    cd('/home/laura/Desktop/Adria-Laura/Training-Dataset/Masks-Ideal');
    
    % Busquem el nom de la imatge per treure les dimensions a la iteració
    mask = imread(dirMask(l).name);
    
    % Iterem la imatge i la mascara per mirar la crominancia dels pixels de pell
    %(píxel de pell quan la mascara = 0)
    for i = 1:1:size(mask,1)
        for j= 1:1:size(mask,2)
            if(mask(i,j) == 0)
                histCbCr(ycbcr(i,j,2),ycbcr(i,j,3)) = histCbCr(ycbcr(i,j,2),ycbcr(i,j,3)) + 1;
            end
        end
    end
end

% Representació de l'histograma
% mesh(histCbCr)

cd('/home/laura/Desktop/Adria-Laura/Scripts/');
