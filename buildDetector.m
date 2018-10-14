function detector = buildDetector( thresholdFace, thresholdParts, stdsize )

%default thresholdFace
if( nargin < 1 )
 thresholdFace = 1;
end


%default thresholdParts
if( nargin < 2 )
 thresholdParts = 1;
end


%default stdsize
if( nargin < 3 )
 stdsize = 176;
end


%initialize
nameDetector = {'LeftEye'; 'RightEye'; 'Mouth'; 'Nose'; };
mins = [[12 18]; [12 18]; [15 25]; [15 18]; ];
detector.stdsize = stdsize;
detector.detector = cell(5,1);
for k=1:4
 minSize = int32([stdsize/5 stdsize/5]);
 minSize = [max(minSize(1),mins(k,1)), max(minSize(2),mins(k,2))];
 detector.detector{k} = vision.CascadeObjectDetector(char(nameDetector(k)), 'MergeThreshold',... 
 thresholdParts,'MinSize', minSize);
end
detector.detector{5} = vision.CascadeObjectDetector('FrontalFaceCART', 'MergeThreshold', thresholdFace);