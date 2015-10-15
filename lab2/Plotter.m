classdef Plotter
    %PLOTTER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        POSITION_FULL = get(groot,'ScreenSize');
        DEFAULT_POSITION = [600, 600, 1000, 1000];
        FILENAME = 'Figure';
        FORMAT = '-dpng';
    end
    
    methods (Static)
        
        function out = plotImageAndHistogram(image)
            
            figHandle = figure();
            subplot(1,2,1);
            imshow(image);
            subplot(1,2,2);
            imhist(image);
            
            Plotter.saveFig(figHandle);
            
        end
        
        function out = plotImage(image)
            
            figHandle = figure();
            imshow(image);
            Plotter.saveFig(figHandle);
            
        end
        
        function out = plotImages(varargin)
            
            imageCount = nargin;
            
            if (imageCount == 2)
                figHandle = figure();

                for image = 1:imageCount
                    subplot(1,2,image);
                    imshow(varargin{image});
                end

                Plotter.saveFig(figHandle);
            end
        end
        
        function out = saveFig(figureHandle)
           filename = sprintf('%s-%d', Plotter.FILENAME, figureHandle.get('Number'));
           print(figureHandle, filename, Plotter.FORMAT);
        end
        


    end
    
end

