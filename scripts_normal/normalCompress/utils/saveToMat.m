function saveToMat(filename, name, value)
    %Handy for saving inside parfors
    eval([name ' =  value;']);
    save(filename, name);
end
