function alreadyLocked = isLocked(lockName)
    %return false only if a lock can be successfully created
    %i.e., return true if locked. 
    %if not, attempt to lock, return true if lock was already created.
    if exist(lockName)
        alreadyLocked = true;
        return;
    end
    %ok - assume it's ok
    alreadyLocked = false;
    [s, mess, messid] = mkdir(lockName);
    %check to make sure we don't get any error messages
    if numel(mess) > 0
        alreadyLocked = true;
    end 
end
