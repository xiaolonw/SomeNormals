function data = loadImageStruct(imageSource, imageName)
    data = struct('annotation', []);
    
    I = imread([imageSource imageName]);
    [rows, cols, chans] = size(I);
    label = '';
    item = [];
    item.filename = imageName;
    item.folder = '';
    item.imagesize.nrows = rows;
    item.imagesize.ncols = cols;
    item.label = label;
    object = [];
    object.name = label;
    object.id = 1;
    object.crop = false;
    object.polygon.x = [ ...
    1, ...
    cols, ...
    cols, ...
    1, ...
    ];
    object.polygon.y = [ ...
    1, ...
    1, ...
    rows, ...
    rows, ...
    ];
    object.polygon.t = 1;
    object.polygon.key = 1;

    item.object = object;
    data(1).annotation = item;

end
