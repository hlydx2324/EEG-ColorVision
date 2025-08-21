%% color setting
R_xy = [0.628  0.337];  %red
G_xy =  [0.349  0.590]; %green
a = 1; %Luminance coefficient Y = 1
R_XYZ = [[R_xy(1) R_xy(2) 1-R_xy(1)-R_xy(2)]./R_xy(2).*a];  
G_XYZ = [[G_xy(1) G_xy(2) 1-G_xy(1)-G_xy(2)]./G_xy(2).*a]; 

XYZ2RGB = [3.2406255  -1.5372080  -0.4986286
    -0.9689307   1.8757561    0.0415175
    0.0557101  -0.2040211   1.0569959];  %XYZ transfer to sRGB %CIE 61966-2-1-1999
R_RGB = [XYZ2RGB*R_XYZ']'; 
G_RGB = [XYZ2RGB*G_XYZ']'; 

for iiiii =1:3 % gamma function
    if R_RGB(iiiii) < -0.0031308
        R_RGB(iiiii) = (-R_RGB(iiiii))^(1/2.4)*(-1.055) + 0.055;
    else if R_RGB(iiiii) <= 0.00031308
            R_RGB(iiiii) = 12.92* R_RGB(iiiii);
        else
            R_RGB(iiiii) = (R_RGB(iiiii))^(1/2.4)*1.055 - 0.055;
        end
    end
    if R_RGB(iiiii) >1
        R_RGB(iiiii)  = 1;
    else if R_RGB(iiiii) < 0
            R_RGB(iiiii)  = 0;
        end
    end  %red
    
    if G_RGB(iiiii) < -0.0031308
        G_RGB(iiiii) = (-G_RGB(iiiii))^(1/2.4)*(-1.055) + 0.055;
    else if G_RGB(iiiii) <= 0.00031308
            G_RGB(iiiii) = 12.92* G_RGB(iiiii);
        else
            G_RGB(iiiii) = (G_RGB(iiiii))^(1/2.4)*1.055 - 0.055;
        end
    end
    if G_RGB(iiiii) >1
        G_RGB(iiiii)  = 1;
    else if G_RGB(iiiii) < 0
            G_RGB(iiiii)  = 0;
        end %green
    end
end

GraySettings; %transfer to gray value
FlashHi = R_RGB*R_Gray; %for the red checker
FlashLo = G_RGB*G_Gray;%for the green checker
