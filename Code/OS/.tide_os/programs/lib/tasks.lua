function selectTask(dataPath, taskID)
    local task = dataPath[1][taskID]
    if dataPath[2] == taskID then
        return
    end

    local currentProcess = dataPath[1][dataPath[2]]
    currentProcess.window.setVisible(false)

    dataPath[2] = taskID
    task.window.setVisible(true)
    term.redirect(task.window)
end

function beginTask(dataPath, taskPath, permission, activeByDefault)
    local task = {
        window = nil,
        isAsRoot = permission,
        taskName = nil
    }

    local w, h = term.native().getSize()

    task.window = window.create(term.current(), 0, 0, w, h, false)
    task.taskName = fs.getName(taskPath)

    table.insert(dataPath[1], task)
    shell.openTab(taskPath)
end

return {launch = beginTask, select = selectTask}