pathName = 'E:\Ronald\Databases\LungNodules_SPIE\SPIE-AAPM Lung CT Challenge';

SMALL = 11;
MEDIUM = 21;
BIG = 51;

fileNames = generateFileNames(pathName);
fileNameLocations = readscv('locations.csv');
numberFiles = length(fileNames);

trainingSet = [];

for i = 1:numberFiles
    I = imread(fileNames(i));
    coordinates = fileNameLocations(i);
    window = [coordinates, SMALL, SMALL];
    [binaryMask, interior, boundary] = preprocessing(I, window);
    [featureVector] = featureExtraction(binaryMask, interior, boundary);
    trainingSet = trainingSet + featureVector;
end

% model selection 
model = generateModel(featureVector);
