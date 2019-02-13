function res = loadcheck(m)
    try
        res = m.nmapsFill{1};
    catch
        res = m.nmapsFill;
    end 
end
