scriptId = 'com.thalmic.scripts.reader'
--Google Slides, powerpoints
--books, PDFs, manga readers

locked = true
appTitle = ""
 
function activeAppName()
	return appTitle
end

--next page/slide
function flipForward()
	myo.keyboard("right_arrow", "press")
end

--previous page/slide
function flipBackward()
	myo.keyboard("left_arrow", "press")
end
 
function onPoseEdge(pose, edge)
	myo.debug("onPoseEdge: " .. pose .. ": " .. edge)
	
	pose = conditionallySwapWave(pose)
	
	if (edge == "on") then
		if (pose == "fist") then
			toggleLock()
		elseif (not locked) then
			if (pose == "waveOut") then
				flipBackward()
			elseif (pose == "waveIn") then
				flipForward()
			end

		end
	end
end
 
function toggleLock()
	locked = not locked
	myo.vibrate("short")
	if (not locked) then
		-- Vibrate twice on unlock
		myo.debug("Unlocked")
		myo.vibrate("short")
	else 
		myo.debug("Locked")
	end
end
 
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

function onForegroundWindowChange(app, title)   
    --if string.match(title, "Microsoft Powerpoint") then
    --if string.match(title, "Adobe Reader") then
    --replace window title with browser name
    if string.match(title, "Google Chrome") then    
        return true
    end
end