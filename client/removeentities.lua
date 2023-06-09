-- local entPoly = {}

-- RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
--     Wait(5000)
--     for _, v in pairs(Config.Objects) do
--         entPoly[#entPoly + 1] = BoxZone:Create(v.coords, v.length, v.width, {
--             name = v.model,
--             debugPoly = false,
--             heading = 0,
--         })
--     end

--     local entCombo = ComboZone:Create(entPoly, { name = "entcombo", debugPoly = false })
--     entCombo:onPlayerInOut(function(isPointInside)
--         if isPointInside then
--             for _,v in pairs(Config.Objects) do
--                 local model = v.model
--                 if type(v.model) == 'string' then
--                     model = GetHashKey(v.model)
--                 end

--                 local ent = GetClosestObjectOfType(v.coords.x, v.coords.y, v.coords.z, 2.0, model, false, false, false)
--                 SetEntityAsMissionEntity(ent, true, true)
--                 DeleteObject(ent)
--                 SetEntityAsNoLongerNeeded(ent)
--             end
--         end
--     end)
-- end)

local gates = {
	'p_barier_test_s',
	'prop_sec_barier_01a',
	'prop_sec_barier_02a',
	'prop_sec_barier_02b',
	'prop_sec_barier_03a',
	'prop_sec_barier_03b',
	'prop_sec_barier_04a',
	'prop_sec_barier_04b',
	'prop_sec_barier_base_01',
	'prop_sec_barrier_ld_01a',
	'prop_sec_barrier_ld_02a',
	'prop_gate_airport_01',
	'prop_facgate_01',
	'prop_facgate_03_l',
	'prop_facgate_03_r',
    'prop_burgerstand_01',
    'prop_food_van_01',
    'prop_road_memorial_02',
	'prop_gate_docks_ld',
	'prop_security_case_01',
	'prop_tool_pickaxe',
	'prop_fnclink_06gate3',
	'prop_drinkmenu',
	'prop_lrggate_02',

}

local gate2 = {
	-1574151574,
	1215477734,
	-1697935936,
    -1439869581,
}

Citizen.CreateThread(function()
   while true do
		for i=1, #gates do
			local coords = GetEntityCoords(PlayerPedId(), false)
			local gate = GetClosestObjectOfType(coords.x, coords.y, coords.z, 100.0, GetHashKey(gates[i]), 0, 0, 0)
			local gate2 = GetClosestObjectOfType(coords.x, coords.y, coords.z, 100.0, gate2[i], 0, 0, 0)
			if gate ~= 0 then
				SetEntityAsMissionEntity(gate, 1, 1)
				DeleteObject(gate)
				SetEntityAsNoLongerNeeded(gate)
			elseif gate2 ~= 0 then
				SetEntityAsMissionEntity(gate2, 1, 1)
				DeleteObject(gate2)
				SetEntityAsNoLongerNeeded(gate2)
			end
		end
	   Wait(2500)
   end
end)
