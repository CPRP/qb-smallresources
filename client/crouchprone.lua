local stage = 0
local movingForward = false
CreateThread(function()
    while true do
        Wait(1)
        local ped = PlayerPedId()
        if not IsPedSittingInAnyVehicle(ped) and not IsPedFalling(ped) and not IsPedSwimming(ped) and not IsPedSwimmingUnderWater(ped) then
            if IsControlJustReleased(0, 36) then
                stage = stage + 1
                if stage == 2 then
                    -- Crouch stuff
                    ClearPedTasks(ped)
                    RequestAnimSet("move_ped_crouched")
                    while not HasAnimSetLoaded("move_ped_crouched") do
                        Wait(0)
                    end

                    SetPedMovementClipset(ped, "move_ped_crouched",1.0)
                    SetPedWeaponMovementClipset(ped, "move_ped_crouched",1.0)
                    SetPedStrafeClipset(ped, "move_ped_crouched_strafing",1.0)
                elseif stage == 3 then
                    ClearPedTasks(ped)
                    RequestAnimSet("move_crawl")
                    while not HasAnimSetLoaded("move_crawl") do
                        Wait(0)
                    end
                elseif stage > 3 then
                    stage = 0
                    ClearPedTasksImmediately(ped)
                    ResetAnimSet()
                    SetPedStealthMovement(ped,0,0)
                end
            end

            if stage == 2 then
                if GetEntitySpeed(ped) > 1.0 then
                    SetPedWeaponMovementClipset(ped, "move_ped_crouched",1.0)
                    SetPedStrafeClipset(ped, "move_ped_crouched_strafing",1.0)
                elseif GetEntitySpeed(ped) < 1.0 and (GetFollowPedCamViewMode() == 4 or GetFollowVehicleCamViewMode() == 4) then
                    ResetPedWeaponMovementClipset(ped)
                    ResetPedStrafeClipset(ped)
                end
            elseif stage == 3 then
                DisableControlAction(0, 21, true ) -- sprint
                DisableControlAction(1, 140, true)
                DisableControlAction(1, 141, true)
                DisableControlAction(1, 142, true)

                if (IsControlPressed(0, 32) and not movingForward) and Config.EnableProne  then
                    movingForward = true
                    SetPedMoveAnimsBlendOut(ped)
                    local pronepos = GetEntityCoords(ped)
                    TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_fwd", pronepos.x, pronepos.y, pronepos.z+0.1, 0.0, 0.0, GetEntityHeading(ped), 100.0, 0.4, 1.0, 7, 2.0, 1, 1)
                    Wait(500)
                elseif (not IsControlPressed(0, 32) and movingForward) then
                    local pronepos = GetEntityCoords(ped)
                    TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_fwd", pronepos.x, pronepos.y, pronepos.z+0.1, 0.0, 0.0, GetEntityHeading(ped), 100.0, 0.4, 1.0, 6, 2.0, 1, 1)
                    Wait(500)
                    movingForward = false
                end

                if IsControlPressed(0, 34) then
                    SetEntityHeading(ped,GetEntityHeading(ped) + 1)
                end

                if IsControlPressed(0, 9) then
                    SetEntityHeading(ped,GetEntityHeading(ped) - 1)
                end
            end
        else
            stage = 0
            Wait(1000)
        end
    end
end)

local walkSet = "default"

RegisterNetEvent('crouchprone:client:SetWalkSet', function(clipset)
    walkSet = clipset
end)

function ResetAnimSet()
    local ped = PlayerPedId()
    if walkSet == "default" then
        ResetPedMovementClipset(ped)
        ResetPedWeaponMovementClipset(ped)
        ResetPedStrafeClipset(ped)
    else
        ResetPedMovementClipset(ped)
        ResetPedWeaponMovementClipset(ped)
        ResetPedStrafeClipset(ped)
        Wait(100)
        RequestWalking(walkSet)
        SetPedMovementClipset(ped, walkSet, 1)
        RemoveAnimSet(walkSet)
    end
end

function RequestWalking(set)
    RequestAnimSet(set)
    while not HasAnimSetLoaded(set) do
        Wait(1)
    end
end

local shot = false
local check = false
local check2 = false
local count = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsPlayerFreeAiming(PlayerId()) then
            if GetFollowPedCamViewMode() == 4 and check == false then
                check = false
            else
                SetFollowVehicleCamViewMode(4)
                check = true
            end
        else
            if check == true then
                SetFollowVehicleCamViewMode(1)
                check = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsPedShooting(PlayerPedId()) and shot == false and GetFollowPedCamViewMode() ~= 4 then
            check2 = true
            shot = true
            SetFollowVehicleCamViewMode(4)
        end
        if IsPedShooting(PlayerPedId()) and shot == true and GetFollowPedCamViewMode() == 4 then
            count = 0
        end
        if not IsPedShooting(PlayerPedId()) and shot == true then
            count = count + 1
        end
        if not IsPedShooting(PlayerPedId()) and shot == true then
            if not IsPedShooting(PlayerPedId()) and shot == true and count > 20 then
                if check2 == true then
                    check2 = false
                    shot = false
                    SetFollowVehicleCamViewMode(1)
                end
            end
        end
    end
end)

-- roll Prevention
Citizen.CreateThread(function()
    while true do
        if (not IsPedInAnyVehicle(PlayerPedId(),false)) then
            Citizen.Wait(4)
            if IsPlayerFreeAiming(PlayerPedId()) then
                DisableControlAction(0, 22, 1)
            else
                Citizen.Wait(100)
            end
        else
            Citizen.Wait(500)
        end
    end
end)
