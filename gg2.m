 close all
 clear all
 pkg load image

 r1 = imread("Blood.jpg");
 g = rgb2gray(r1);
 figure,
 imshow(g,[]);
 
 figure,
 imhist(g);
 His = imhist(g);
 hold on
 grid minor on
 plot(His,'-r');
 xlim ([50,256]); ylim ([0,14000]);
 xlabel('Gray scale value');
 ylabel('Frequency');
 title('Histogram Frequency');
 %grid on

  %% Transforn the graph Histogram to be smooth by using Spline interpolation ::
  x = 1:256; y = His;
  xspline = 1:5:256;  yspline = spline (x,y,xspline);
  figure,  plot (x,y,"-r", xspline,yspline,"-b");
  title ("spline fit to points from Histogram value");
  xlim ([50,256]); ylim ([0,14000]);
  xlabel('Gray scale value');
  ylabel('Frequency');
  title('Histogram Frequency');
  grid minor on


% Algorithm for calculating the range intensity color value of blood cell ::
%% All CELL ::


a1 = 0;
  a2 = 89; 
  [m,n] = size(g);
   for i=1:m;
    for j=1:n;
      if(g(i,j)>a1 && g(i,j)<a2)
        g(i,j)=1;
      else
        g(i,j)=0;
      endif
     end
    end
   end

  % insert and fill pixel in blood cell ::
  HF = imfill(g,"holes");
  SE = strel('disk',5,0);
  
  % Delete the noise image ::
  
  HF2 = imopen(HF,SE);
  figure,   imshow(g,[]);   title('The Gray scale image');
  figure,   imshow(HF,[]);  title('Hole Filling Technique ');
  figure,   imshow(HF2,[]); title('Remove Noise from blood cell');
 
  

  
  
  %% Separate the blood cell for each cell :: 
  [L, number] = bwlabel(HF2);
  
  
  
     
   
   %2Display the Label of blood cell of each cell ::   
   for i=1:number
   figure
   imshow(L==i,[]);
   title("The number of white blood cell :: ");
 end
 
 % -------------------------------------------------------------------------
  %% Find the egde of image and Construct the egde of blood in RED color ::
  % -------------------------------------------------------------------------
  
  Detect = edge(HF2,"canny");
  imshow(Detect,[])
  [m,n] = size(Detect);
  for i = 1:m;
        for j= 1:n;
          if(Detect(i,j) == 1)
            r1(i,j,1) = 255;
            r1(i,j,2) = 0;
            r1(i,j,3) = 0;
           end
         end
        end
    figure
    imshow(r1);
  