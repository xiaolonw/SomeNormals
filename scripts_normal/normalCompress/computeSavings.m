location = 'compa1/';
files = dir([location '/*.mat']);
totalFileUsage = sum(cat(1,files.bytes));
values = 0;
nonzeroValues = 0;
for i=1:numel(files)
    data = load([location '/' files(i).name]);
    values = values + numel(data.Q);
    nonzeroValues = nonzeroValues + sum(data.Q(:) ~= 0);
end

names = {'Naive Double','2/3 Single'};
counts = [8*nonzeroValues*3,4*nonzeroValues*2];

for i=1:numel(names)
    fprintf('%s: %.2f\n',names{i},counts(i)/totalFileUsage);
end
