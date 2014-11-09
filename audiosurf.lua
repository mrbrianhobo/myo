scriptId = 'com.thalmic.scripts.audiosurf'
minMyoConnectVer='0.4.0'
--SDK version >= Beta4, uses mouse control
--For the following control presses the button is held until the gesture is released
--fingersSpread press space 
--fist press left mouse button
--waveIn press right mouse button
--move hand to move ship
--thumbToPinky toggle unlock, when unlocks recenters mouse.
--note only centain ships use space, left or right click
      
function conditionallySwapWave(pose)
    if myo.getArm() == "left" then
        if pose == "waveIn" then
            pose = "waveOut"
        elseif pose == "waveOut" then
            pose = "waveIn"
        end
    end
    return pose
end

function onPoseEdge(pose, edge)
    pose=conditionallySwapWave(pose)
    local now = myo.getTimeMilliseconds()

    --Other shortcut control
    if edge == "on" then
        if pose == "thumbToPinky" and enabled then
            --myo.controlMouse(false)
        elseif pose == "waveIn" and enabled then
            myo.keyboard("space","down")
        elseif pose == "fist" and enabled then   
            myo.mouse("left","down")
        elseif pose == "fingersSpread" and enabled then 
            myo.mouse("right","down")
        elseif pose == "waveOut" and enabled then  
            --unused
        end
    elseif edge=="off" then 
    --Unlatch holding
        if pose=="thumbToPinky" then
            --myo.controlMouse(true)
        end
        myo.mouse("left","up")
        myo.mouse("right","up") 
        myo.keyboard("space","up")
    end
end

-- onPeriodic runs every ~10ms
function onActiveChange(isActive)
    if isActive then
        enabled = true
        myo.controlMouse(true)
    else
        enabled = false
        myo.controlMouse(false)
    end 
end
-- Only activate when using Audiosurf
function onForegroundWindowChange(app, title)   
    if string.match(title, "Audiosurf") then    
        return true
    end
end
