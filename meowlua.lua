if not getgenv()._meow_loaded_guard then
    local _loaded_ok = false
    task.spawn(function()
        local _t = tick()
        repeat task.wait(0.1) until game:IsLoaded() or (tick() - _t) > 15
        _loaded_ok = true
    end)
    local _wait_start = tick()
    repeat task.wait(0.05) until _loaded_ok or (tick() - _wait_start) > 16
end
pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
if getgenv().meowlua_loaded then return end
getgenv().meowlua_loaded = true

local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

task.defer(function()
    local _stbl; _stbl = hookfunction(getrenv().setmetatable, newcclosure(function(tbl, mt)
        if mt and typeof(mt) == "table" and rawget(mt, "__mode") == "kv" then
            local tr = debug.traceback()
            if tr:find("MiscellaneousController") then return _stbl({1,2,3}, {}) end
        end
        return _stbl(tbl, mt)
    end))
end)
coroutine.wrap(function()
    pcall(function()
        local function _proc(o)
            pcall(function()
                if o:IsA("LocalScript") or o:IsA("ModuleScript") then
                    local _s, nm = pcall(function() return o.Name:lower() end)
                    if not _s or not nm then return end
                    local _tags = {"anticheat","ac","detection","ban","kick","security","moderation"}
                    for _i = 1, #_tags do
                        if nm:find(_tags[_i]) then pcall(function() o.Disabled = true end) break end
                    end
                end
            end)
        end
        pcall(function() local _desc = game:GetDescendants(); for _i = 1, #_desc do _proc(_desc[_i]) end end)
        pcall(function() game.DescendantAdded:Connect(_proc) end)
    end)
    pcall(function()
        local _nc = game:GetService("NetworkClient")
        if not _nc then return end
        _nc.ChildAdded:Connect(function(ch)
            pcall(function()
                local _ok, _n = pcall(function() return ch.Name:lower() end)
                if _ok and _n then
                    if _n:find("anticheat") or _n:find("detection") then pcall(function() ch:Destroy() end) end
                end
            end)
        end)
    end)
end)()

local _fakeEv
pcall(function()
    _fakeEv = Instance.new("RemoteEvent")
    _fakeEv.Name = "ClientAlert"
    _fakeEv.Parent = LocalPlayer
end)

task.defer(function()
    pcall(function()
        local _rf = game:GetService("ReplicatedFirst")
        local _tgt = _rf:WaitForChild("LocalScript3", 10)
        local _gc = getgc(false)
        for _i = 1, #_gc do
            local _fn = _gc[_i]
            if type(_fn) ~= "function" then continue end
            local _ok1, _env = pcall(getfenv, _fn)
            if not _ok1 or type(_env) ~= "table" then continue end
            local _ok2, _scr = pcall(function() return rawget(_env, "script") end)
            if not _ok2 or not _scr or typeof(_scr) ~= "Instance" then continue end
            local _ok3, _ss = pcall(tostring, _scr)
            if not _ok3 then continue end
            if not (_scr == _tgt or (type(_ss) == "string" and _ss:find("LoadingScreen"))) then continue end
            local _ok4, _consts = pcall(debug.getconstants, _fn)
            if not _ok4 or type(_consts) ~= "table" then continue end
            for _j = 1, #_consts do
                local _c = _consts[_j]
                if type(_c) == "string" and (_c:find("TakeTheL") or _c:find("ban") or _c:find("kick")) then
                    pcall(function() hookfunction(_fn, function() end) end)
                    break
                end
            end
        end
    end)
end)
local players = game:GetService("Players")
local localplayer = players.LocalPlayer
local r_storage = game:GetService("ReplicatedStorage")
local user_input_service = game:GetService("UserInputService")
local run_service = game:GetService("RunService")
local virtual_user = game:GetService("VirtualUser")
local workspace = game:GetService("Workspace")
local http_service = game:GetService("HttpService")
local teleport_service = game:GetService("TeleportService")
local lighting = game:GetService("Lighting")
local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")

getgenv().config = {
    nc = false, fly_enabled = false, fly_speed = 100, double_jump_enabled = false, fake_position_enabled = false, desync_enabled = false,
    blink_enabled = false, blink_radius = 120, blink_rate = 120, ghost_enabled = false, ghost_distance = 300,
    glide_enabled = false, glide_speed = 350, glide_accel = 30,
    void_spam_enabled = false, vs_xp = 5000, vs_xn = 5000, vs_yp = 5000, vs_yn = 5000, vs_zp = 5000, vs_zn = 5000, vs_min_dist = 0, vs_max_dist = 50000,
    void_pattern = "rhombus", void_axis_x = true, void_axis_y = true, void_axis_z = true, void_smooth = false, void_smooth_alpha = 1.0, vs_dist_per_tp = 1000,
    et_order = "Triangle", et_mode = "Random", et_speed = 1000, et_total = 1000,
    pos_spam_enabled = false, pos_spam_speed = 100,
    map_orbit_enabled = false, map_orbit_x = 1000000, map_orbit_y = 1000000, map_orbit_z = 1000000, mo_burst = 1000, mo_interval = 0.05,
    strafebot_enabled = false, strafe_speed = 150, strafe_radius = 20, strafe_height = 8, strafe_randomize = false,
    anti_close = false, dagger_bypass = false, anti_aim_enabled = false,
    aa_method = "Static", aa_pixel_scale = 1, aa_spin_speed = 9999, aa_yaw = 0, aa_pitch = 0, aa_roll = 0,
    riot_abuser_enabled = false, riot_abuser_distance = 500, riot_abuser_x = 50, riot_abuser_y = 15, riot_abuser_z = 50, riot_abuser_spin = 1000000000000,
    riot_bypass_enabled = false, riot_bypass_distance = 3, riot_bypass_position = "front",
    zigzag_enabled = false, zigzag_speed = 100, zigzag_radius = 35, zigzag_spread = 1000,
    anti_afk_enabled = false, autocollect_enabled = false, autocollect_radius = 120, return_home_enabled = false, home_return_delay = 1.0,
    safe_zone_enabled = false, safe_zone_y = -10, teleport_loop_enabled = false, teleport_loop_delay = 0.5, ffa_hopping_enabled = false,
    rage_bot_enabled = false, rage_type = "Normal", rage_strategy = "TP", rage_weapon = "None", rage_hitbox = "Head", rage_priority = "", rage_position = "Inside",
    rage_tp_radius = 2, rage_tp_height = -4, rage_orbit_speed = 500, rage_spin = false, rage_spin_speed = 1e70, knife_dist = 3,
    shoot_attempts = 1, prediction_enabled = false, prediction_mult = 1.2,
    tp_prediction_enabled = false, tp_pred_strength = 1.0,
    no_spread = false, no_recoil = false, no_muzzle_flash = false, rapid_fire = false,
    mod_detector = false,
    esp_boxes = false, esp_names = false, esp_health = false, esp_tracers = false, display_angles = false, starborn_enabled = false,
    autoload_config = true, last_loaded_config = "default", w_fps = false, w_stretch = false, w_stretch_amt = 0.81, w_dark = false, w_atmo = false, w_amb = false, w_time = 14,
    evasion_enabled = false, evasion_burst = 500, evasion_interval = 1, evasion_spin_speed = 9999, evasion_mode = "Random",
    sbd_enabled = false, sbd_infinite_range = true, sbd_no_gravity = true,
    sbd_teleport_projectiles = true, sbd_rapid_fire = true,
    sbd_ignore_walls = true, sbd_hitbox_expand = true,
    sbd_instant_kill = true, sbd_through_walls = true,
    sbd_auto_aim = false, sbd_auto_shoot = false,
    sbd_anti_projectile = false, sbd_bullet_time = false,
    sbd_damage_mult = 100, sbd_no_damage_falloff = true,
    sbd_heat_seeking = false, sbd_chain_lightning = false,
    bullet_tp_enabled = false, bullet_tp_radius = 5000,
    bullet_tp_attempts = 10, bullet_tp_delay = 0.005,
    bullet_tp_headshot = true, bullet_tp_auto_reset = true,
}
getgenv().all_connections = {}
getgenv().loop_waypoints = {}
getgenv().loop_index = 1
local config = getgenv().config
local configs_folder = "meowlua_configs"
if not isfolder(configs_folder) then makefolder(configs_folder) end
local function notify(title, content)
    pcall(function() game:GetService("StarterGui"):SetCore("SendNotification", { Title = title, Text = content, Duration = 3 }) end)
end
getgenv().save_cfg = function(name)
    if not name or name == "" then name = "default" end
    local path = configs_folder .. "/" .. name .. ".json"
    local data = { AutoLoadConfig = config.autoload_config, LastLoadedConfig = name, full_config = config }
    local ok, encoded = pcall(http_service.JSONEncode, http_service, data)
    if ok and encoded then
        local w_ok = pcall(writefile, path, encoded)
        if w_ok then notify("Config", "Saved: " .. name) return true end
    end
    notify("Config", "Failed to save config.")
    return false
end
getgenv().load_cfg = function(name)
    if not name or name == "" then name = "default" end
    local path = configs_folder .. "/" .. name .. ".json"
    if not isfile(path) then notify("Config", "Not found: " .. name) return false end
    local ok, raw = pcall(readfile, path)
    if not ok then notify("Config", "Failed to read config.") return false end
    local s, d = pcall(http_service.JSONDecode, http_service, raw)
    if s and d and d.full_config then
        config.autoload_config = d.AutoLoadConfig or true
        config.last_loaded_config = name
        for k, v in pairs(d.full_config) do
            if config[k] ~= nil and type(config[k]) == type(v) then config[k] = v end
        end
        notify("Config", "Loaded: " .. name)
        return true
    end
    notify("Config", "Corrupted config file.")
    return false
end
getgenv().delete_cfg = function(name)
    if not name or name == "" or name == "default" then notify("Config", "Cannot delete default.") return false end
    local path = configs_folder .. "/" .. name .. ".json"
    if not isfile(path) then notify("Config", "Not found.") return false end
    local ok = pcall(delfile, path)
    if ok then notify("Config", "Deleted: " .. name) return true end
    notify("Config", "Failed to delete.")
    return false
end
getgenv().list_cfgs = function()
    if not isfolder(configs_folder) then return {} end
    local list = {}
    local ok, files = pcall(listfiles, configs_folder)
    if ok and files then
        for _, f in ipairs(files) do
            local matched = f:match("([^/\\]+)%.json$")
            if matched then table.insert(list, matched) end
        end
    end
    table.sort(list)
    return list
end
getgenv().get_hrp = function(plr)
    local p = plr or localplayer
    if not p.Character then return nil end
    return p.Character:FindFirstChild("HumanoidRootPart")
end
getgenv().safe_teleport = function(pos)
    local hrp = getgenv().get_hrp(localplayer)
    if not hrp then return end
    local x, y, z = pos.X, pos.Y, pos.Z
    y = math.clamp(y, 2, hrp.Position.Y + 800)
    local p = RaycastParams.new()
    p.FilterType = Enum.RaycastFilterType.Exclude
    p.FilterDescendantsInstances = { localplayer.Character }
    local hit = workspace:Raycast(Vector3.new(x, y + 60, z), Vector3.new(0, -220, 0), p)
    if hit then y = math.max(hit.Position.Y + 3, 2) end
    hrp.CFrame = CFrame.new(x, y, z)
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
end
getgenv().get_rage_target = function()
    local targetName = config.rage_priority
    if targetName and targetName ~= "" then
        local specificPlayer = players:FindFirstChild(targetName)
        if specificPlayer and specificPlayer.Character
            and specificPlayer.Character:FindFirstChild("HumanoidRootPart")
            and specificPlayer.Character:FindFirstChildOfClass("Humanoid").Health > 0
            and not specificPlayer.Character:FindFirstChildOfClass("ForceField")
            and (localplayer.Team == nil or specificPlayer.Team == nil or localplayer.Team ~= specificPlayer.Team) then
            return specificPlayer
        end
    end
    local best_target, best_score = nil, math.huge
    local hrp = getgenv().get_hrp(localplayer)
    if not hrp then return nil end
    for _, p in ipairs(players:GetPlayers()) do
        if p ~= localplayer and p.Character then
            if p.Character:FindFirstChildOfClass("ForceField") then continue end
            local t_hrp = p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChild("Humanoid")
            local is_valid = t_hrp and hum and hum.Health > 0
                and (localplayer.Team == nil or p.Team == nil or localplayer.Team ~= p.Team)
            if is_valid then
                local score = (hrp.Position - t_hrp.Position).Magnitude
                if score < best_score then best_score = score; best_target = p end
            end
        end
    end
    return best_target
end
local cached_target, last_target_tick = nil, 0
getgenv().get_closest = function(check_ff)
    local now = tick()
    if now - last_target_tick < 0.1 then
        if cached_target and cached_target.Character
            and cached_target.Character:FindFirstChild("HumanoidRootPart")
            and cached_target.Character:FindFirstChild("Humanoid").Health > 0 then
            if not check_ff or not cached_target.Character:FindFirstChildOfClass("ForceField") then
                return cached_target
            end
        end
    end
    last_target_tick = now
    local closest, min_d = nil, math.huge
    local hrp = getgenv().get_hrp(localplayer)
    if not hrp then return nil end
    for _, p in ipairs(players:GetPlayers()) do
        if p ~= localplayer and p.Character then
            if check_ff and p.Character:FindFirstChildOfClass("ForceField") then continue end
            local t_hrp = p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChild("Humanoid")
            if t_hrp and hum and hum.Health > 0 then
                if localplayer.Team == nil or p.Team == nil or localplayer.Team ~= p.Team then
                    local d = (hrp.Position - t_hrp.Position).Magnitude
                    if d < min_d then min_d = d; closest = p end
                end
            end
        end
    end
    cached_target = closest
    return closest
end
local SBD = {
    active = false, originalRaycast = nil, originalFindPart = nil, hijackedRemotes = {},
    connections = {}, projectileHandler = nil, teleportedCount = 0, shotCount = 0, killCount = 0, damageDealt = 0,
}
function SBD:Enable()
    if self.active then return end
    self.active = true
    local function annihilateRaycast()
        local worldRoot = workspace
        self.originalRaycast = getmetatable(worldRoot).__index.Raycast
        local mt = getrawmetatable(game)
        local oldIndex = mt.__index
        mt.__index = newcclosure(function(t, k)
            if t == workspace and k == "Raycast" then
                return function(origin, direction, params)
                    local extDirection = direction.Unit * 999999999
                    local rayParams = RaycastParams.new()
                    if params then
                        if params.FilterType then rayParams.FilterType = params.FilterType end
                        if params.FilterDescendantsInstances then rayParams.FilterDescendantsInstances = params.FilterDescendantsInstances end
                        if params.IgnoreWater then rayParams.IgnoreWater = params.IgnoreWater end
                    end
                    if config.sbd_ignore_walls then
                        rayParams.FilterType = Enum.RaycastFilterType.Include
                        local playerInstances = {}
                        for _, player in ipairs(Players:GetPlayers()) do
                            if player ~= localplayer and player.Character then
                                for _, part in ipairs(player.Character:GetChildren()) do
                                    if part:IsA("BasePart") then table.insert(playerInstances, part) end
                                end
                            end
                        end
                        rayParams.FilterDescendantsInstances = playerInstances
                    end
                    local result = self.originalRaycast(worldRoot, origin, extDirection, rayParams)
                    if config.sbd_ignore_walls and not result then return nil end
                    return result
                end
            end
            return oldIndex(t, k)
        end)
        self.originalFindPart = workspace.FindPartOnRay
        workspace.FindPartOnRay = function(ray, ignoreInstance, terrainCellsAreCubes, ignoreWater)
            local extRay = Ray.new(ray.Origin, ray.Direction.Unit * 999999999)
            return self.originalFindPart(workspace, extRay, ignoreInstance, terrainCellsAreCubes, ignoreWater)
        end
    end
    local function hijackAllRemotes()
        local function hijackRemote(remote)
            if self.hijackedRemotes[remote] then return end
            self.hijackedRemotes[remote] = true
            local originalFireServer = remote.FireServer
            remote.FireServer = function(self_r, ...)
                local args = {...}
                local remoteName = remote.Name:lower()
                local remoteParent = remote.Parent and remote.Parent.Name:lower() or ""
                local weaponRelated = remoteName:find("fire") or remoteName:find("shoot") or remoteName:find("launch") or remoteName:find("attack") or remoteName:find("projectile") or remoteName:find("weapon") or remoteName:find("sling") or remoteName:find("bow") or remoteName:find("dagger") or remoteName:find("throw") or remoteName:find("arrow") or remoteName:find("bolt") or remoteName:find("pellet") or remoteName:find("bullet") or remoteName:find("knife") or remoteName:find("blade") or remoteParent:find("weapon") or remoteParent:find("slingshot") or remoteParent:find("bow") or remoteParent:find("dagger")
                if weaponRelated and config.sbd_infinite_range then
                    self.shotCount = self.shotCount + 1
                    local modifiedArgs = {}
                    for i, arg in ipairs(args) do
                        if typeof(arg) == "Vector3" then
                            local camPos = workspace.CurrentCamera.CFrame.Position
                            local direction = (arg - camPos).Unit
                            if config.sbd_heat_seeking then
                                local target = getgenv().get_closest(true)
                                if target and target.Character then
                                    local head = target.Character:FindFirstChild("Head")
                                    if head then direction = (head.Position - camPos).Unit end
                                end
                            end
                            modifiedArgs[i] = camPos + direction * 999999999
                        elseif typeof(arg) == "CFrame" then
                            local camPos = workspace.CurrentCamera.CFrame.Position
                            local direction = arg.LookVector
                            if config.sbd_heat_seeking then
                                local target = getgenv().get_closest(true)
                                if target and target.Character then
                                    local head = target.Character:FindFirstChild("Head")
                                    if head then direction = (head.Position - camPos).Unit end
                                end
                            end
                            modifiedArgs[i] = CFrame.lookAt(camPos, camPos + direction * 999999999)
                        else modifiedArgs[i] = arg end
                    end
                    local burstCount = config.sbd_rapid_fire and 5 or 1
                    for _ = 1, burstCount do task.spawn(function() pcall(function() originalFireServer(remote, unpack(modifiedArgs)) end) end) end
                    return originalFireServer(remote, unpack(modifiedArgs))
                else return originalFireServer(remote, ...) end
            end
        end
        local function scanAndHijack(parent)
            if not parent then return end
            for _, child in ipairs(parent:GetChildren()) do
                if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then pcall(function() hijackRemote(child) end) end
                if #child:GetChildren() > 0 then scanAndHijack(child) end
            end
        end
        scanAndHijack(ReplicatedStorage); scanAndHijack(workspace)
    end
    local function enableProjectileTeleport()
        self.projectileHandler = run_service.Heartbeat:Connect(function()
            if not config.sbd_teleport_projectiles then return end
            local projectiles = {}
            pcall(function()
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if not obj:IsA("BasePart") then continue end
                    local projNames = {"projectile","arrow","bolt","dagger","rock","pellet","bullet","sling","dart","spear","knife","blade"}
                    local isProjectile = false
                    for _, name in ipairs(projNames) do if obj.Name:lower():find(name) then isProjectile = true break end end
                    if not isProjectile and obj:IsA("BasePart") and obj.Velocity.Magnitude > 50 and obj.Size.Magnitude < 10 then isProjectile = true end
                    if isProjectile and obj.Velocity.Magnitude > 0 then table.insert(projectiles, obj) end
                end
            end)
            for _, obj in ipairs(projectiles) do
                pcall(function()
                    local nearestPlayer, nearestDist = nil, math.huge
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= localplayer and player.Character then
                            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                            local head = player.Character:FindFirstChild("Head")
                            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                            if hrp and humanoid and humanoid.Health > 0 then
                                if localplayer.Team and player.Team and localplayer.Team == player.Team then continue end
                                if player.Character:FindFirstChildOfClass("ForceField") then continue end
                                local targetPart = head or hrp
                                local dist = (obj.Position - targetPart.Position).Magnitude
                                if dist < nearestDist and dist < (config.bullet_tp_radius or 5000) then
                                    nearestDist = dist
                                    nearestPlayer = { Character = player.Character, RootPart = hrp, Head = head, Humanoid = humanoid, TargetPart = targetPart }
                                end
                            end
                        end
                    end
                    if nearestPlayer then
                        local targetPart = nearestPlayer.TargetPart
                        local teleportPos = targetPart.Position + (obj.Velocity.Unit * 2)
                        obj.Position = teleportPos; obj.CFrame = CFrame.lookAt(teleportPos, targetPart.Position)
                        self.teleportedCount = self.teleportedCount + 1
                        if config.sbd_instant_kill and nearestPlayer.Humanoid then
                            local damage = 9999 * (config.sbd_damage_mult or 100)
                            nearestPlayer.Humanoid:TakeDamage(damage)
                            if nearestPlayer.Humanoid.Health <= 0 then nearestPlayer.Humanoid.Health = 0; self.killCount = self.killCount + 1; self.damageDealt = self.damageDealt + damage end
                        end
                        obj:Destroy()
                    end
                end)
            end
        end)
    end
    local function enablePhysicsBypass()
        pcall(function() PhysicsService:CreateCollisionGroup("SBDBypass"); PhysicsService:CollisionGroupSetCollidable("SBDBypass","Default",false); PhysicsService:CollisionGroupSetCollidable("SBDBypass","Terrain",false) end)
        local function setProjectilePhysics(instance)
            if not instance:IsA("BasePart") then return end
            local projNames = {"projectile","arrow","bolt","dagger","rock","pellet","bullet","sling","dart","spear","knife","blade"}
            local isProjectile = false
            for _, name in ipairs(projNames) do if instance.Name:lower():find(name) then isProjectile = true break end end
            if not isProjectile and instance.Velocity.Magnitude > 50 and instance.Size.Magnitude < 10 then isProjectile = true end
            if isProjectile then
                pcall(function()
                    PhysicsService:SetPartCollisionGroup(instance, "SBDBypass"); instance.CanCollide = false
                    for _, child in ipairs(instance:GetChildren()) do if child:IsA("BodyForce") or child:IsA("BodyThrust") or child:IsA("BodyVelocity") or child:IsA("RocketPropulsion") then child:Destroy() end end
                    if config.sbd_no_gravity then
                        local bodyVel = Instance.new("BodyVelocity")
                        bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                        bodyVel.Velocity = instance.Velocity.Unit * (config.sbd_infinite_range and 9999999 or 999999)
                        bodyVel.Name = "SBDVelocity"; bodyVel.Parent = instance
                        task.spawn(function()
                            while instance and instance.Parent do
                                task.wait(0.5)
                                pcall(function() if instance and instance.Parent and bodyVel and bodyVel.Parent then bodyVel.Velocity = bodyVel.Velocity.Unit * 9999999 end end)
                            end
                        end)
                    end
                end)
            end
        end
        for _, obj in ipairs(workspace:GetDescendants()) do pcall(function() setProjectilePhysics(obj) end) end
        workspace.DescendantAdded:Connect(function(child) task.wait(0.05) pcall(function() setProjectilePhysics(child) end) end)
    end
    annihilateRaycast(); hijackAllRemotes(); enableProjectileTeleport(); enablePhysicsBypass()
    notify("SBD Bypass", "Full bypass activated!")
end
function SBD:Disable()
    self.active = false
    if self.projectileHandler then self.projectileHandler:Disconnect(); self.projectileHandler = nil end
    for _, conn in ipairs(self.connections) do conn:Disconnect() end
    self.connections = {}
    notify("SBD Bypass", "Bypass disabled")
end
local BulletTP = {
    active = false, task = nil,
    desyncState = { desync=false, curr=nil, conn=nil, task=nil, randomOffset=nil },
    teleportCount = 0, killCount = 0,
}
function BulletTP:findTargets()
    local myChar = localplayer.Character; if not myChar then return {} end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart"); if not myRoot then return {} end
    local targets = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player == localplayer then continue end
        if localplayer.Team and player.Team and localplayer.Team == player.Team then continue end
        local char = player.Character; if not char then continue end
        local root = char:FindFirstChild("HumanoidRootPart"); local head = char:FindFirstChild("Head"); local hum = char:FindFirstChildOfClass("Humanoid")
        if not (root and head and hum and hum.Health > 0) then continue end
        if char:FindFirstChildOfClass("ForceField") then continue end
        local dist = (myRoot.Position - root.Position).Magnitude
        if dist < (config.bullet_tp_radius or 5000) then table.insert(targets, {player=player, root=root, head=head, hum=hum, dist=dist}) end
    end
    table.sort(targets, function(a,b) return a.dist < b.dist end)
    return targets
end
function BulletTP:Enable()
    if self.active then return end
    self.active = true
    self.task = task.spawn(function()
        while self.active do
            if not config.bullet_tp_enabled then task.wait(0.1) continue end
            local targets = self:findTargets()
            if #targets == 0 then task.wait(0.05) continue end
            local target = targets[1]
            local targetPart = config.bullet_tp_headshot and target.head or target.root
            local projectiles = {}
            pcall(function()
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if not obj:IsA("BasePart") then continue end
                    local projNames = {"projectile","arrow","bolt","dagger","rock","pellet","bullet","sling","dart","spear","knife","blade"}
                    local isProjectile = false
                    for _, name in ipairs(projNames) do if obj.Name:lower():find(name) then isProjectile = true break end end
                    if isProjectile and obj.Velocity.Magnitude > 0 then table.insert(projectiles, obj) end
                end
            end)
            for _, obj in ipairs(projectiles) do
                pcall(function()
                    for _ = 1, (config.bullet_tp_attempts or 10) do
                        obj.CFrame = CFrame.new(targetPart.Position)
                        task.wait(config.bullet_tp_delay or 0.005)
                    end
                    if config.bullet_tp_auto_reset then obj:Destroy() end
                end)
            end
            self.teleportCount = self.teleportCount + 1
            task.wait(0.01)
        end
    end)
end
function BulletTP:Disable()
    self.active = false
    if self.task then task.cancel(self.task); self.task = nil end
end
local pos_spam_conn = nil
getgenv().start_pos_spam = function()
    if pos_spam_conn then pos_spam_conn:Disconnect() end
    pos_spam_conn = run_service.Heartbeat:Connect(function()
        if not config.pos_spam_enabled then return end
        local hrp = getgenv().get_hrp(localplayer); if not hrp then return end
        local sign = math.random() > 0.5 and 1 or -1
        local dist = (1000000000 + math.random() * (12e25 - 1000000000)) * sign
        hrp.CFrame = CFrame.new(math.random(-5000, 5000), dist, math.random(-5000, 5000))
        hrp.AssemblyLinearVelocity = Vector3.zero; hrp.AssemblyAngularVelocity = Vector3.zero
    end)
end
getgenv().stop_pos_spam = function() if pos_spam_conn then pos_spam_conn:Disconnect(); pos_spam_conn = nil end; config.pos_spam_enabled = false end

local mo_conn, mo_acc = nil, 0
getgenv().start_map_orbit = function()
    if mo_conn then mo_conn:Disconnect() end
    mo_acc = config.mo_interval or 0.05
    mo_conn = run_service.Heartbeat:Connect(function(dt)
        if not config.map_orbit_enabled then return end
        local hrp = getgenv().get_hrp(localplayer); if not hrp then return end
        mo_acc = mo_acc + dt
        if mo_acc >= (config.mo_interval or 0.05) then
            mo_acc = 0
            local iterations = math.clamp(config.mo_burst or 1000, 100, 5000)
            for i = 1, iterations do
                local rx = math.random(-config.map_orbit_x, config.map_orbit_x)
                local rz = math.random(-config.map_orbit_z, config.map_orbit_z)
                hrp.CFrame = CFrame.new(rx, -math.abs(config.map_orbit_depth or 1000000), rz)
            end
            hrp.AssemblyLinearVelocity = Vector3.zero; hrp.AssemblyAngularVelocity = Vector3.zero
        end
    end)
end
getgenv().stop_map_orbit = function() if mo_conn then mo_conn:Disconnect(); mo_conn = nil end; config.map_orbit_enabled = false end

local ra_conn = nil
getgenv().start_riot_abuser = function()
    if ra_conn then ra_conn:Disconnect() end
    local hrp = getgenv().get_hrp(localplayer); getgenv().ra_original = hrp and hrp.CFrame or nil
    local t0 = tick(); local seed = math.random(1000, 9999)
    ra_conn = run_service.Heartbeat:Connect(function(dt)
        if not config.riot_abuser_enabled then return end
        local hrp = getgenv().get_hrp(localplayer); if not hrp then return end
        local t = tick()-t0; local sm = config.riot_abuser_spin or 1000000000000
        local yaw = math.rad(sm*dt); local pitch = math.rad(sm*0.37*dt*math.sin(t*3.1)); local roll = math.rad(sm*0.19*dt*math.cos(t*5.7+seed))
        local spinCF = hrp.CFrame * CFrame.Angles(pitch, yaw, roll)
        local spread = (config.riot_abuser_distance or 500)/300
        local jX = (math.random()-0.5)*(config.riot_abuser_x or 50)*spread*2 + math.noise(t*9,seed,0)*(config.riot_abuser_x or 50)*spread
        local jY = (math.random()-0.5)*(config.riot_abuser_y or 15)*spread + math.noise(0,t*9,seed)*(config.riot_abuser_y or 15)*spread*0.3
        local jZ = (math.random()-0.5)*(config.riot_abuser_z or 50)*spread*2 + math.noise(0,0,t*9+seed)*(config.riot_abuser_z or 50)*spread
        hrp.CFrame = spinCF + Vector3.new(jX, math.max(spinCF.Position.Y+jY, 2)-spinCF.Position.Y, jZ)
    end)
end
getgenv().stop_riot_abuser = function()
    if ra_conn then ra_conn:Disconnect(); ra_conn = nil end
    if getgenv().get_hrp(localplayer) and getgenv().ra_original then getgenv().get_hrp(localplayer).CFrame = getgenv().ra_original end
end

local strafe_conn_s, strafe_conn_rs = nil, nil
local strafe_angle, strafe_dir = 0, 1
getgenv().start_strafebot = function()
    if strafe_conn_s then strafe_conn_s:Disconnect() end
    if strafe_conn_rs then strafe_conn_rs:Disconnect() end
    strafe_angle = 0; local last_switch = tick()
    strafe_conn_s = run_service.Stepped:Connect(function(_, dt)
        if not config.strafebot_enabled then return end
        local target = getgenv().get_closest(true); local hrp = getgenv().get_hrp(localplayer)
        if target and target.Character and hrp then
            local t_hrp = target.Character:FindFirstChild("HumanoidRootPart")
            if t_hrp then
                if config.strafe_randomize and tick()-last_switch > math.random(1,3) then strafe_dir = strafe_dir*-1; last_switch = tick() end
                strafe_angle = strafe_angle + (((config.strafe_speed or 50)/100)*strafe_dir*dt*60)
                local tv = t_hrp.AssemblyLinearVelocity
                local pred = t_hrp.Position + (tv*dt + (tv*(localplayer:GetNetworkPing()*2)))
                local off = Vector3.new(math.cos(strafe_angle)*(config.strafe_radius or 15), config.strafe_height or 5, math.sin(strafe_angle)*(config.strafe_radius or 15))
                hrp.CFrame = CFrame.lookAt(pred+off, t_hrp.Position); hrp.AssemblyLinearVelocity = tv; hrp.AssemblyAngularVelocity = Vector3.zero
            end
        end
    end)
    strafe_conn_rs = run_service.RenderStepped:Connect(function(dt)
        if not config.strafebot_enabled then return end
        local target = getgenv().get_closest(true); local hrp = getgenv().get_hrp(localplayer)
        if target and target.Character and hrp then
            local t_hrp = target.Character:FindFirstChild("HumanoidRootPart")
            if t_hrp then
                local tv = t_hrp.AssemblyLinearVelocity
                local pred = t_hrp.Position + (tv*dt + (tv*(localplayer:GetNetworkPing()*2)))
                local off = Vector3.new(math.cos(strafe_angle)*(config.strafe_radius or 15), config.strafe_height or 5, math.sin(strafe_angle)*(config.strafe_radius or 15))
                hrp.CFrame = CFrame.lookAt(pred+off, t_hrp.Position)
            end
        end
    end)
end
getgenv().stop_strafebot = function()
    if strafe_conn_s then strafe_conn_s:Disconnect(); strafe_conn_s = nil end
    if strafe_conn_rs then strafe_conn_rs:Disconnect(); strafe_conn_rs = nil end
    config.strafebot_enabled = false
end

local zza_conn = nil
getgenv().start_zigzag_abuser = function()
    if zza_conn then zza_conn:Disconnect() end
    zza_conn = run_service.Heartbeat:Connect(function()
        if not config.zigzag_enabled then return end
        local hrp = getgenv().get_hrp(localplayer); if not hrp then return end
        local spd = config.zigzag_speed or 50; local spread = config.zigzag_spread or 500; local t = tick()*spd
        local x = math.sin(t)*spread + math.random(-spread, spread)
        local y = math.cos(t*1.3)*spread + math.random(50, spread)
        local z = math.sin(t*0.8)*spread + math.random(-spread, spread)
        local tgt = getgenv().get_closest(true)
        local base = (tgt and tgt.Character and tgt.Character:FindFirstChild("HumanoidRootPart")) and tgt.Character.HumanoidRootPart.Position or hrp.Position
        hrp.CFrame = CFrame.new(base + Vector3.new(x, y, z)); hrp.AssemblyLinearVelocity = Vector3.zero; hrp.AssemblyAngularVelocity = Vector3.zero
    end)
end
getgenv().stop_zigzag_abuser = function() if zza_conn then zza_conn:Disconnect(); zza_conn = nil end end
local function compute_evasion_offset(mode, t, r)
    if mode=="Random" then return Vector3.new(math.random(-r,r),math.random(-r,r),math.random(-r,r))
    elseif mode=="Circle" then local a=t*math.pi*2 return Vector3.new(math.cos(a)*r,0,math.sin(a)*r)
    elseif mode=="Spiral" then local a=t*math.pi*2*3 return Vector3.new(math.cos(a)*r*t,math.sin(t*math.pi)*r*0.5,math.sin(a)*r*t)
    elseif mode=="Figure8" then local a=t*math.pi*2 return Vector3.new(math.sin(a)*r,math.sin(a*2)*r*0.5,math.cos(a)*r*math.cos(a))
    elseif mode=="Helix" then local a=t*math.pi*2*4 return Vector3.new(math.cos(a)*r,math.sin(t*math.pi*2)*r,math.sin(a)*r)
    elseif mode=="Star" then local k=math.floor(t*5)%2==0; local a=t*math.pi*2 return Vector3.new(math.cos(a)*(k and r or r*0.4),0,math.sin(a)*(k and r or r*0.4))
    elseif mode=="Triangle" then local p=t%3; local v; if p<1 then v=Vector3.new(0,r,0):Lerp(Vector3.new(r,-r,0),p) elseif p<2 then v=Vector3.new(r,-r,0):Lerp(Vector3.new(-r,-r,0),p-1) else v=Vector3.new(-r,-r,0):Lerp(Vector3.new(0,r,0),p-2) end return v
    elseif mode=="Square" then local p=t%4; if p<1 then return Vector3.new(r,-r,0):Lerp(Vector3.new(r,r,0),p) elseif p<2 then return Vector3.new(r,r,0):Lerp(Vector3.new(-r,r,0),p-1) elseif p<3 then return Vector3.new(-r,r,0):Lerp(Vector3.new(-r,-r,0),p-2) else return Vector3.new(-r,-r,0):Lerp(Vector3.new(r,-r,0),p-3) end
    elseif mode=="Pentagon" then local ph=(math.floor(t*5)%5)/5*math.pi*2 return Vector3.new(math.cos(ph)*r,0,math.sin(ph)*r)
    elseif mode=="Hexagon" then local ph=(math.floor(t*6)%6)/6*math.pi*2 return Vector3.new(math.cos(ph)*r,0,math.sin(ph)*r)
    elseif mode=="Octagon" then local ph=(math.floor(t*8)%8)/8*math.pi*2 return Vector3.new(math.cos(ph)*r,0,math.sin(ph)*r)
    elseif mode=="Diamond" then local p=t%4; if p<1 then return Vector3.new(0,r,0):Lerp(Vector3.new(r,0,0),p) elseif p<2 then return Vector3.new(r,0,0):Lerp(Vector3.new(0,-r,0),p-1) elseif p<3 then return Vector3.new(0,-r,0):Lerp(Vector3.new(-r,0,0),p-2) else return Vector3.new(-r,0,0):Lerp(Vector3.new(0,r,0),p-3) end
    elseif mode=="Cross" then local tog=math.floor(t*10)%2==0 return Vector3.new(tog and r or 0,0,not tog and r or 0)
    elseif mode=="Zigzag" then local p=t%2 return Vector3.new((p<1 and p or 2-p)*r*2-r,0,math.floor(t)*r*0.5)
    elseif mode=="Wave" then return Vector3.new(t*r*4,math.sin(t*math.pi*6)*r,0)
    elseif mode=="Sine" then local a=t*math.pi*2*3 return Vector3.new(math.sin(a)*r,math.cos(a*0.5)*r*0.5,math.sin(a*0.7)*r*0.3)
    elseif mode=="Lemniscate" then local a=t*math.pi*2; local d=1+math.sin(a)^2 return Vector3.new(math.cos(a)/d*r,0,math.sin(a)*math.cos(a)/d*r)
    elseif mode=="Rose" then local a=t*math.pi*2; local rr=math.cos(3*a)*r return Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif mode=="Butterfly" then local a=t*math.pi*2; local rr=(math.exp(math.cos(a))-2*math.cos(4*a))*r*0.3 return Vector3.new(math.sin(a)*rr,math.cos(a*2)*r*0.3,math.cos(a)*rr)
    elseif mode=="Cardioid" then local a=t*math.pi*2 return Vector3.new((1-math.cos(a))*r*0.5*math.cos(a),0,(1-math.cos(a))*r*0.5*math.sin(a))
    elseif mode=="Epicycloid" then local a=t*math.pi*2; local R=r; local rc=r*0.3 return Vector3.new((R+rc)*math.cos(a)-rc*math.cos((R/rc+1)*a),0,(R+rc)*math.sin(a)-rc*math.sin((R/rc+1)*a))
    elseif mode=="Hypocycloid" then local a=t*math.pi*2; local R=r; local rc=r*0.3 return Vector3.new((R-rc)*math.cos(a)+rc*math.cos((R/rc-1)*a),0,(R-rc)*math.sin(a)-rc*math.sin((R/rc-1)*a))
    elseif mode=="Hypotrochoid" then local a=t*math.pi*2; local R=r; local rc=r*0.4; local d=r*0.7 return Vector3.new((R-rc)*math.cos(a)+d*math.cos((R/rc-1)*a),0,(R-rc)*math.sin(a)-d*math.sin((R/rc-1)*a))
    elseif mode=="Epitrochoid" then local a=t*math.pi*2; local R=r; local rc=r*0.4; local d=r*0.6 return Vector3.new((R+rc)*math.cos(a)-d*math.cos((R/rc+1)*a),0,(R+rc)*math.sin(a)-d*math.sin((R/rc+1)*a))
    elseif mode=="Fermat" then local a=t*math.pi*4; local rr=math.sqrt(math.abs(a))*r*0.3 return Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif mode=="Archimedes" then local a=t*math.pi*8 return Vector3.new(a*math.cos(a)*r*0.05,0,a*math.sin(a)*r*0.05)
    elseif mode=="Lituus" then local a=t*math.pi*6+0.01; local rr=r/math.sqrt(a) return Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif mode=="Cissoid" then local a=t*math.pi*2-math.pi/2+0.01; local rr=2*r*0.5*(math.sin(a)^2/math.cos(a)) return Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif mode=="Strophoid" then local a=t*math.pi*2-math.pi/2+0.01; local rr=r*0.5*(-math.cos(2*a)/math.cos(a)) return Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif mode=="Limacon" then local a=t*math.pi*2; local rr=(r*0.6+r*0.4*math.cos(a)) return Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif mode=="Astroid" then local a=t*math.pi*2 return Vector3.new(math.cos(a)^3*r,math.sin(a*2)*r*0.2,math.sin(a)^3*r)
    elseif mode=="Deltoid" then local a=t*math.pi*2 return Vector3.new((2*math.cos(a)+math.cos(2*a))*r*0.3,0,(2*math.sin(a)-math.sin(2*a))*r*0.3)
    elseif mode=="Nephroid" then local a=t*math.pi*2 return Vector3.new((3*math.cos(a)-math.cos(3*a))*r*0.25,0,(3*math.sin(a)-math.sin(3*a))*r*0.25)
    elseif mode=="Trefoil" then local a=t*math.pi*2; local rr=math.cos(3*a)*r return Vector3.new(rr*math.cos(a),math.sin(a*3)*r*0.2,rr*math.sin(a))
    elseif mode=="Viviani" then local a=t*math.pi*2 return Vector3.new(r*(1+math.cos(a))*0.5,r*math.sin(a)*0.5,r*math.sin(a/2)*0.5)
    elseif mode=="Rhodonea" then local a=t*math.pi*2; local rr=math.cos(4*a)*r return Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif mode=="Maclaurin" then local a=t*math.pi*2; local rr=r*0.5*(2*math.cos(a)-1) return Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif mode=="Trisectrix" then local a=t*math.pi*2+0.01; local rr=r*0.5*(4*math.cos(a)-1/math.cos(a)) return Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif mode=="Folium" then local a=t*math.pi*2-math.pi/4+0.01; local d=math.sin(a)^3+math.cos(a)^3; if math.abs(d)<0.01 then d=0.01 end; local rr=r*3*math.sin(a)*math.cos(a)/d return Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif mode=="Cochleoid" then local a=t*math.pi*4+0.01; local rr=r*math.sin(a)/a return Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif mode=="Involute" then local a=t*math.pi*4 return Vector3.new(r*0.3*(math.cos(a)+a*math.sin(a)),0,r*0.3*(math.sin(a)-a*math.cos(a)))
    else return Vector3.new(math.random(-r,r),math.random(-r,r),math.random(-r,r)) end
end

local evasion_conn = nil
getgenv().start_evasion = function()
    if evasion_conn then evasion_conn:Disconnect() end
    local dt_buf = 0
    evasion_conn = run_service.Heartbeat:Connect(function(dt)
        if not config.evasion_enabled then return end
        local hrp = getgenv().get_hrp(localplayer)
        local hum = localplayer.Character and localplayer.Character:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then return end
        if hum:GetState() ~= Enum.HumanoidStateType.Physics then hum:ChangeState(Enum.HumanoidStateType.Physics) end
        dt_buf = dt_buf + dt
        local interval = math.max((config.evasion_interval or 1) * 0.001, 0.001)
        if dt_buf >= interval then
            dt_buf = 0
            local iters = math.clamp(config.evasion_burst or 500, 100, 1000)
            local spd = config.evasion_spin_speed or 9999
            local t = tick()
            for i = 1, iters do
                local frac = (i - 1) / iters
                local offset = compute_evasion_offset(config.evasion_mode or "Random", frac, 50000)
                local dest = hrp.Position + offset
                hrp.CFrame = CFrame.new(dest.X, dest.Y, dest.Z)
                    * CFrame.Angles(math.rad(spd * t * 1.0 % 360), math.rad(spd * t * 0.73 % 360), math.rad(spd * t * 0.41 % 360))
            end
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
        end
    end)
end
getgenv().stop_evasion = function()
    if evasion_conn then evasion_conn:Disconnect(); evasion_conn = nil end
    config.evasion_enabled = false
end
local aa_conn_s = nil
local aa_orbit_angle = 0
getgenv().start_anti_aim = function()
    if aa_conn_s then aa_conn_s:Disconnect() end
    local aa_t0 = tick()
    aa_conn_s = run_service.Heartbeat:Connect(function(dt)
        if not config.anti_aim_enabled then return end
        local hrp = getgenv().get_hrp(localplayer)
        local hum = localplayer.Character and localplayer.Character:FindFirstChildOfClass("Humanoid")
        local cam = workspace.CurrentCamera
        if not hrp or not cam then return end
        local method = config.aa_method or "Static"
        local t = tick() - aa_t0
        if method=="Pixelated" then
            if hum then hum.AutoRotate=false end
            local char=localplayer.Character
            if char then for _,v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then pcall(function() v.Size=v.Size*math.clamp((config.aa_pixel_scale or 1)/100,0.01,1) end) end end end
            hrp.CFrame=hrp.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360)))
        elseif method=="Static" then
            if hum then hum.AutoRotate=false end
            hrp.CFrame=CFrame.new(hrp.Position)*CFrame.Angles(math.rad(180),0,0)
        elseif method=="Spin" then
            if hum then hum.AutoRotate=false end
            hrp.CFrame=CFrame.new(hrp.Position)*CFrame.Angles(0,math.rad((config.aa_spin_speed or 9999)*t%360),0)
        elseif method=="Jitter" then
            if hum then hum.AutoRotate=false end
            local tog=(math.floor(t*30))%2==0
            hrp.CFrame=CFrame.new(hrp.Position)*CFrame.Angles(tog and math.rad(180) or 0,tog and math.rad(90) or math.rad(-90),0)
        elseif method=="Desync" then
            if hum then hum.AutoRotate=false end
            local rootPos=hrp.Position; local look=cam.CFrame.LookVector
            local base=CFrame.lookAt(rootPos,rootPos+Vector3.new(look.X,0,look.Z))
            hrp.CFrame=base*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360)))
            for _,v in pairs(localplayer.Character:GetDescendants()) do
                if v:IsA("Motor6D") and v.Name~="RootJoint" then pcall(function() v.Transform=CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))) end) end
            end
        elseif method=="Sway" then
            if hum then hum.AutoRotate=false end
            hrp.CFrame=CFrame.new(hrp.Position)*CFrame.Angles(math.cos(t*2)*math.rad(45),math.sin(t*3)*math.rad(90),math.sin(t*1.5)*math.rad(30))
        elseif method=="Breaker" then
            if hum then hum.AutoRotate=false end
            if (math.floor(t*20))%5==0 then hrp.CFrame=CFrame.new(hrp.Position)*CFrame.Angles(math.rad(math.random(-720,720)),math.rad(math.random(-720,720)),math.rad(math.random(-720,720)))
            else hrp.CFrame=CFrame.new(hrp.Position)*CFrame.Angles(math.rad(180),0,0) end
        elseif method=="Lurk" then
            if hum then hum.AutoRotate=false end
            local look=cam.CFrame.LookVector; local away=Vector3.new(-look.X,0,-look.Z); local rootPos=hrp.Position
            if away.Magnitude>0.001 then hrp.CFrame=CFrame.lookAt(rootPos,rootPos+away)*CFrame.Angles(math.rad(15),math.rad(180),0) end
        elseif method=="Orbit" then
            if hum then hum.AutoRotate=false end
            aa_orbit_angle=aa_orbit_angle+dt*(config.aa_spin_speed or 9999)*0.05
            local dirs={Vector3.new(math.cos(aa_orbit_angle),0,math.sin(aa_orbit_angle)),Vector3.new(0,math.sin(aa_orbit_angle),math.cos(aa_orbit_angle)),Vector3.new(math.cos(aa_orbit_angle*1.3),math.sin(aa_orbit_angle*0.7),math.sin(aa_orbit_angle*1.1))}
            local chosen=dirs[(math.floor(t*8)%#dirs)+1]; local rootPos=hrp.Position; local rand_r=math.random(500,50000)
            hrp.CFrame=CFrame.new(rootPos+chosen*rand_r)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360)))
            hrp.AssemblyLinearVelocity=Vector3.zero; hrp.AssemblyAngularVelocity=Vector3.zero
        elseif method=="Custom" then
            if hum then hum.AutoRotate=false end
            hrp.CFrame=CFrame.new(hrp.Position)*CFrame.Angles(math.rad(config.aa_pitch or 0),math.rad(config.aa_yaw or 0),math.rad(config.aa_roll or 0))
        end
    end)
end
getgenv().stop_anti_aim = function()
    if aa_conn_s then aa_conn_s:Disconnect(); aa_conn_s=nil end
    local hum=localplayer.Character and localplayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.AutoRotate=true end
    config.anti_aim_enabled=false
end

local afk_conn=nil
getgenv().start_anti_afk=function()
    if afk_conn then afk_conn:Disconnect() end
    afk_conn=localplayer.Idled:Connect(function()
        if config.anti_afk_enabled then virtual_user:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) task.wait(1) virtual_user:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end
    end)
end
getgenv().stop_anti_afk=function() if afk_conn then afk_conn:Disconnect(); afk_conn=nil end end

local auto_conn,home_conn,safe_conn=nil,nil,nil
local last_auto_tick=0
getgenv().start_autocollect=function()
    if auto_conn then auto_conn:Disconnect() end
    auto_conn=run_service.Heartbeat:Connect(function()
        if not config.autocollect_enabled then return end
        local hrp=getgenv().get_hrp(localplayer); if not hrp then return end
        if tick()-last_auto_tick<0.25 then return end; last_auto_tick=tick()
        local best,min_d=nil,math.huge
        for _,o in ipairs(workspace:GetDescendants()) do
            local n=string.lower(o.Name)
            if string.find(n,"heal") or string.find(n,"health") or string.find(n,"medkit") or string.find(n,"bandage") then
                local p=o:IsA("Model") and (o.PrimaryPart or o:FindFirstChildWhichIsA("BasePart")) or (o:IsA("BasePart") and o or nil)
                if p then local d=(p.Position-hrp.Position).Magnitude; if d<min_d and d<=config.autocollect_radius then min_d=d; best=p.Position end end
            end
        end
        if best then getgenv().safe_teleport(best) end
    end)
end
getgenv().stop_autocollect=function() if auto_conn then auto_conn:Disconnect(); auto_conn=nil end end
getgenv().home_position=nil
getgenv().start_return_home=function()
    if home_conn then home_conn:Disconnect() end
    local hrp_init=getgenv().get_hrp(localplayer)
    if not getgenv().home_position and hrp_init then getgenv().home_position=hrp_init.Position end
    local last_ret=0
    home_conn=run_service.Heartbeat:Connect(function()
        if not config.return_home_enabled or not getgenv().home_position then return end
        local hrp=getgenv().get_hrp(localplayer); if not hrp then return end
        if (hrp.Position-getgenv().home_position).Magnitude>50 and (tick()-last_ret)>=config.home_return_delay then
            last_ret=tick(); getgenv().safe_teleport(getgenv().home_position)
        end
    end)
end
getgenv().stop_return_home=function() if home_conn then home_conn:Disconnect(); home_conn=nil end end
getgenv().start_safe_zone=function()
    if safe_conn then safe_conn:Disconnect() end
    safe_conn=run_service.Heartbeat:Connect(function()
        if not config.safe_zone_enabled then return end
        local hrp=getgenv().get_hrp(localplayer); if not hrp then return end
        if hrp.Position.Y<(config.safe_zone_y or -10) then
            local last_safe=getgenv().home_position or Vector3.new(0,10,0)
            hrp.CFrame=CFrame.new(last_safe.X,math.max(last_safe.Y,10),last_safe.Z)
            hrp.AssemblyLinearVelocity=Vector3.zero; hrp.AssemblyAngularVelocity=Vector3.zero
        else getgenv().home_position=hrp.Position end
    end)
end
getgenv().stop_safe_zone=function() if safe_conn then safe_conn:Disconnect(); safe_conn=nil end end

local tl_conn=nil
getgenv().start_teleport_loop=function()
    if tl_conn then tl_conn:Disconnect() end
    tl_conn=run_service.Heartbeat:Connect(function()
        if not config.teleport_loop_enabled then return end
        if #getgenv().loop_waypoints==0 then return end
        local hrp=getgenv().get_hrp(localplayer); if not hrp then return end
        local wp=getgenv().loop_waypoints[getgenv().loop_index]
        if wp then hrp.CFrame=CFrame.new(wp); hrp.AssemblyLinearVelocity=Vector3.zero end
        getgenv().loop_index=(getgenv().loop_index%(#getgenv().loop_waypoints))+1
        task.wait(config.teleport_loop_delay or 0.5)
    end)
end
getgenv().stop_teleport_loop=function() if tl_conn then tl_conn:Disconnect(); tl_conn=nil end; config.teleport_loop_enabled=false end

local last_hop_time=0
local function get_random_hop() return 14+math.random()*13 end
local function is_server_good(server)
    if not server or not server.id or server.id==game.JobId then return false end
    if server.playing>=server.maxPlayers*0.88 then return false end
    return true
end
local function server_hop()
    if not config.ffa_hopping_enabled then return end
    if tick()-last_hop_time<8 then return end
    task.wait(0.7+math.random()*1.6)
    task.spawn(function()
        local success,response=pcall(function() return http_service:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100",true)) end)
        if not success or not response or not response.data then return end
        local valid_servers={}
        for _,s in ipairs(response.data) do if is_server_good(s) then table.insert(valid_servers,s) end end
        if #valid_servers==0 then return end
        for i=#valid_servers,2,-1 do local j=math.random(i); valid_servers[i],valid_servers[j]=valid_servers[j],valid_servers[i] end
        local target=valid_servers[math.random(1,math.min(6,#valid_servers))]
        last_hop_time=tick(); task.wait(0.5+math.random()*1.3)
        pcall(function() teleport_service:TeleportToPlaceInstance(game.PlaceId,target.id,localplayer) end)
    end)
end
task.spawn(function() while task.wait(get_random_hop()) do if config.ffa_hopping_enabled then server_hop() end end end)

local mod_loop=nil
getgenv().start_mod_detector=function()
    if mod_loop then pcall(task.cancel,mod_loop) end
    mod_loop=task.spawn(function()
        while task.wait(3) do
            if not config.mod_detector then break end
            for _,plr in ipairs(players:GetPlayers()) do
                if plr~=localplayer then
                    pcall(function()
                        local tags={"mod","admin","staff","owner","dev","developer","helper","support"}
                        local nm=plr.Name:lower()
                        for _,tag in ipairs(tags) do
                            if nm:find(tag) then notify("Staff Detected",plr.Name.." joined!"); pcall(function() teleport_service:Teleport(game.PlaceId) end) return end
                        end
                    end)
                end
            end
        end
    end)
end
getgenv().stop_mod_detector=function() config.mod_detector=false; if mod_loop then pcall(task.cancel,mod_loop); mod_loop=nil end end

local starborn_conn
getgenv().start_starborn=function()
    starborn_conn=run_service.RenderStepped:Connect(function()
        if not config.starborn_enabled then return end
        for _,gui in ipairs(game:GetService("CoreGui"):GetDescendants()) do
            if gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox") then pcall(function() gui.Font=Enum.Font.Antique end) end
        end
    end)
end
getgenv().stop_starborn=function() config.starborn_enabled=false; if starborn_conn then starborn_conn:Disconnect(); starborn_conn=nil end end

local angle_gui,angle_conn=nil,nil
getgenv().start_display_angles=function()
    if angle_gui then angle_gui:Destroy() end
    if angle_conn then angle_conn:Disconnect() end
    angle_gui=Instance.new("ScreenGui"); angle_gui.Name="BodyCoordsGUI"
    pcall(function() angle_gui.Parent=game:GetService("CoreGui") end)
    if not angle_gui.Parent then angle_gui.Parent=localplayer:WaitForChild("PlayerGui",5) end
    local lbl=Instance.new("TextLabel",angle_gui)
    lbl.Size=UDim2.new(0,260,0,90); lbl.Position=UDim2.new(0.5,-130,0.05,0)
    lbl.BackgroundColor3=Color3.fromRGB(0,0,0); lbl.BackgroundTransparency=0.5
    lbl.TextColor3=Color3.fromRGB(0,255,150); lbl.Font=Enum.Font.RobotoMono; lbl.TextSize=16
    lbl.TextXAlignment=Enum.TextXAlignment.Left
    local pad=Instance.new("UIPadding",lbl); pad.PaddingLeft=UDim.new(0,15)
    local crn=Instance.new("UICorner",lbl); crn.CornerRadius=UDim.new(0,8)
    local function fmt(v) local f=string.format("%.1f",v); while true do local f2,k=string.gsub(f,"^(-?%d+)(%d%d%d)","%1,%2"); f=f2; if k==0 then break end end return f end
    angle_conn=run_service.RenderStepped:Connect(function()
        local hrp=getgenv().get_hrp(localplayer)
        if hrp then lbl.Text=string.format("X: %s\nY: %s\nZ: %s",fmt(hrp.Position.X),fmt(hrp.Position.Y),fmt(hrp.Position.Z))
        else lbl.Text="X: --\nY: --\nZ: --" end
    end)
end
getgenv().stop_display_angles=function()
    if angle_conn then angle_conn:Disconnect(); angle_conn=nil end
    if angle_gui then angle_gui:Destroy(); angle_gui=nil end
end

local muzzle_flash_conn=nil
getgenv().start_no_muzzle_flash=function()
    if muzzle_flash_conn then muzzle_flash_conn:Disconnect() end
    muzzle_flash_conn=run_service.RenderStepped:Connect(function()
        local vm=workspace:FindFirstChild("ViewModels")
        if vm then
            for _,child in ipairs(vm:GetDescendants()) do
                if child:IsA("ParticleEmitter") and child.Name=="ParticleEmiter" then child:Destroy() end
                if child:IsA("SpotLight") then child:Destroy() end
            end
        end
    end)
end
getgenv().stop_no_muzzle_flash=function() if muzzle_flash_conn then muzzle_flash_conn:Disconnect(); muzzle_flash_conn=nil end end

local WeaponSettings={ShootRecoil=0,ShootSpread=0,ProjectileSpeed=math.huge,ShootCooldown=0,QuickShotCooldown=0,ShootBurstCooldown=0,ShootExplosionRadius=0,AttackCooldown=0,Cooldown=0,DashCooldown=0,SpinCooldown=0,SpinSpeed=500,DeflectCooldown=0}
local rf_enabled=false
getgenv().start_rapid_fire=function()
    if rf_enabled then return end; rf_enabled=true
    task.spawn(function()
        pcall(function()
            local client_item=require(localplayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem)
            if not client_item then return end
            getgenv().old_input_func=hookfunction(client_item.Input,function(...)
                local args={...}
                if config.rapid_fire and type(args[1])=="table" and args[1].Info then for k,v in pairs(WeaponSettings) do args[1].Info[k]=v end end
                return getgenv().old_input_func(...)
            end)
        end)
    end)
end
getgenv().stop_rapid_fire=function()
    rf_enabled=false; config.rapid_fire=false
    if getgenv().old_input_func then
        pcall(function() require(localplayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem).Input=getgenv().old_input_func end)
        getgenv().old_input_func=nil
    end
end
local max_acc_hooked=false
local function hook_max_accuracy()
    if max_acc_hooked then return end; max_acc_hooked=true
    task.spawn(function()
        pcall(function()
            local util=require(game:GetService("ReplicatedStorage").Modules.GameplayUtility)
            if util and util.GetSpread then
                local orig=util.GetSpread
                util.GetSpread=function(s,am,ia,ic,pi,tp,c) if config.no_spread or config.rage_bot_enabled then return CFrame.new() end return orig(s,am,ia,ic,pi,tp,c) end
            end
        end)
        pcall(function()
            local gun=require(localplayer.PlayerScripts.Modules.ItemTypes.Gun)
            if gun and gun._Recoil then
                local orig=gun._Recoil
                gun._Recoil=function(self,mult) if config.no_recoil or config.rage_bot_enabled then return end return orig(self,mult) end
            end
        end)
    end)
end
hook_max_accuracy()
local vs_spiral, vs_wave, vs_helix, vs_strobe = 0, 0, 0, false
local vs_bounce_dir = { x=1, y=1, z=1 }
local vs_chaos = { math.random(), math.random(), math.random() }
local function get_vs_delta(dt, xp, xn, yp, yn, zp, zn)
    local ax,ay,az,p = config.void_axis_x, config.void_axis_y, config.void_axis_z, config.void_pattern
    if p=="spiral" then vs_spiral=vs_spiral+0.35 return Vector3.new(ax and math.cos(vs_spiral)*(xp+xn)/2 or 0, ay and math.sin(vs_spiral*0.6)*(yp+yn)/2 or 0, az and math.sin(vs_spiral)*(zp+zn)/2 or 0)
    elseif p=="wave" then vs_wave=vs_wave+dt*8 return Vector3.new(ax and math.sin(vs_wave)*(xp+xn)/2 or 0, ay and math.sin(vs_wave*1.7)*(yp+yn)/2 or 0, az and math.cos(vs_wave*0.9)*(zp+zn)/2 or 0)
    elseif p=="bounce" then local step=Vector3.new(ax and vs_bounce_dir.x*(xp+xn)/3 or 0, ay and vs_bounce_dir.y*(yp+yn)/3 or 0, az and vs_bounce_dir.z*(zp+zn)/3 or 0) if math.random()<0.25 then vs_bounce_dir.x=-vs_bounce_dir.x end if math.random()<0.25 then vs_bounce_dir.y=-vs_bounce_dir.y end if math.random()<0.25 then vs_bounce_dir.z=-vs_bounce_dir.z end return step
    elseif p=="chaos" then vs_chaos[1]=(vs_chaos[1]*1664525+1013904223)%1; vs_chaos[2]=(vs_chaos[2]*22695477+1)%1; vs_chaos[3]=(vs_chaos[3]*214013+2531011)%1 return Vector3.new(ax and (vs_chaos[1]*(xp+xn)-xn) or 0, ay and (vs_chaos[2]*(yp+yn)-yn) or 0, az and (vs_chaos[3]*(zp+zn)-zn) or 0)
    elseif p=="cross" then local tog=(math.floor(tick()*10))%2==0 return Vector3.new(ax and (tog and (math.random()*(xp+xn)-xn) or 0) or 0, ay and (not tog and (math.random()*(yp+yn)-yn) or 0) or 0, az and (tog and (math.random()*(zp+zn)-zn) or 0) or 0)
    elseif p=="helix" then vs_helix=vs_helix+dt*6 return Vector3.new(ax and math.cos(vs_helix*2)*(xp+xn)/2 or 0, ay and math.sin(vs_helix)*(yp+yn)/8 or 0, az and math.sin(vs_helix*2)*(zp+zn)/2 or 0)
    elseif p=="strobe" then vs_strobe=not vs_strobe; local s=vs_strobe and 1 or -1 return Vector3.new(ax and s*xp or 0, ay and s*yp or 0, az and s*zp or 0)
    elseif p=="rhombus" then
        local phase=(dt*2)%4; local wx=(xp+xn)/2; local z=(zp+zn)/2; local y=(yp+yn)/2
        if phase<1 then return Vector3.new(ax and wx*(1-phase) or 0, ay and -y or 0, az and z*phase or 0)
        elseif phase<2 then local pt=phase-1; return Vector3.new(ax and -wx*pt or 0, ay and -y or 0, az and z*(1-pt) or 0)
        elseif phase<3 then local pt=phase-2; return Vector3.new(ax and -wx*(1-pt) or 0, ay and -y or 0, az and -z*pt or 0)
        else local pt=phase-3; return Vector3.new(ax and wx*pt or 0, ay and -y or 0, az and -z*(1-pt) or 0) end
    elseif p=="infinity" then return Vector3.new(ax and math.sin(dt*2)*(xp+xn)/2 or 0, ay and math.sin(dt*4)*(yp+yn)/2 or 0, az and math.sin(dt*2)*math.cos(dt*2)*(zp+zn)/2 or 0)
    elseif p=="flower" then local r2=(xp+xn)/2*math.cos(dt*4) return Vector3.new(ax and math.cos(dt*2)*r2 or 0, ay and math.sin(dt*4)*(yp+yn)/2 or 0, az and math.sin(dt*2)*r2 or 0)
    elseif p=="butterfly" then local r2=(xp+xn)/2*(math.exp(math.cos(dt*2))-2*math.cos(4*dt*2)) return Vector3.new(ax and math.cos(dt*2)*r2 or 0, ay and math.cos(dt*4)*(yp+yn)/2 or 0, az and math.sin(dt*2)*r2 or 0)
    elseif p=="tornado" then return Vector3.new(ax and math.cos(dt*5)*dt*1000 or 0, ay and (dt*5000)%yn or 0, az and math.sin(dt*5)*dt*1000 or 0)
    elseif p=="heart" then local x=16*math.sin(dt*2)^3; local y=13*math.cos(dt*2)-5*math.cos(2*dt*2)-2*math.cos(3*dt*2)-math.cos(4*dt*2) return Vector3.new(ax and x*(xp+xn)/32 or 0, ay and y*(yp+yn)/32 or 0, az and math.sin(dt*2)*(zp+zn)/2 or 0)
    elseif p=="hexagon" then local ph=(math.floor(dt*2)%6)/6*math.pi*2 return Vector3.new(ax and math.cos(ph)*(xp+xn)/2 or 0, ay and (yp+yn)/2 or 0, az and math.sin(ph)*(zp+zn)/2 or 0)
    elseif p=="octagon" then local ph=(math.floor(dt*2)%8)/8*math.pi*2 return Vector3.new(ax and math.cos(ph)*(xp+xn)/2 or 0, ay and (yp+yn)/2 or 0, az and math.sin(ph)*(zp+zn)/2 or 0)
    elseif p=="star" then local r2=(math.floor(dt*5)%2==0) and (xp+xn)/2 or (xp+xn)/4; local ph=dt*math.pi*2 return Vector3.new(ax and math.cos(ph)*r2 or 0, ay and (yp+yn)/2 or 0, az and math.sin(ph)*r2 or 0)
    elseif p=="crescent" then return Vector3.new(ax and math.cos(dt*2)*(xp+xn)/2-math.cos(dt*4)*(xp+xn)/4 or 0, ay and math.cos(dt*3)*(yp+yn)/2 or 0, az and math.sin(dt*2)*(zp+zn)/2-math.sin(dt*4)*(zp+zn)/4 or 0)
    elseif p=="vortex" then return Vector3.new(ax and math.cos(dt*3)*(xp+xn)/2 or 0, ay and math.sin(dt*3)*(yp+yn)/2 or 0, az and math.sin(dt*1.5)*(zp+zn)/2 or 0)
    else return Vector3.new(ax and (math.random()*(xp+xn)-xn) or 0, ay and (math.random()*(yp+yn)-yn) or 0, az and (math.random()*(zp+zn)-zn) or 0) end
end
local function get_vs_order_offset(order, frac, i, ph, radius)
    local offset = Vector3.zero
    -- ph = frac * math.pi * 2  (full 0→2π sweep across the burst)
    -- frac = (i-1)/iters        (0→1 across the burst)
    -- All shapes must iterate their geometry using frac/ph so the burst
    -- distributes teleport positions along the actual shape path.

    if order=="Triangle" then
        -- Walk 3 edges: top → bottom-right → bottom-left → top
        local seg=math.floor(frac*3); local f=(frac*3)-seg
        if seg==0 then offset=Vector3.new(0,radius,0):Lerp(Vector3.new(radius,-radius,0),f)
        elseif seg==1 then offset=Vector3.new(radius,-radius,0):Lerp(Vector3.new(-radius,-radius,0),f)
        else offset=Vector3.new(-radius,-radius,0):Lerp(Vector3.new(0,radius,0),f) end

    elseif order=="Circle" then
        -- Full revolution in XZ plane
        offset=Vector3.new(math.cos(ph)*radius, 0, math.sin(ph)*radius)

    elseif order=="Square" then
        -- Walk 4 edges clockwise
        local seg=math.floor(frac*4); local f=(frac*4)-seg
        if seg==0 then offset=Vector3.new(radius,-radius,0):Lerp(Vector3.new(radius,radius,0),f)
        elseif seg==1 then offset=Vector3.new(radius,radius,0):Lerp(Vector3.new(-radius,radius,0),f)
        elseif seg==2 then offset=Vector3.new(-radius,radius,0):Lerp(Vector3.new(-radius,-radius,0),f)
        else offset=Vector3.new(-radius,-radius,0):Lerp(Vector3.new(radius,-radius,0),f) end

    elseif order=="Pentagon" then
        -- Walk 5 edges, vertices on unit circle scaled to radius
        local seg=math.floor(frac*5); local f=(frac*5)-seg
        local a1=(seg/5)*math.pi*2; local a2=((seg+1)/5)*math.pi*2
        offset=Vector3.new(math.cos(a1)*radius,0,math.sin(a1)*radius):Lerp(Vector3.new(math.cos(a2)*radius,0,math.sin(a2)*radius),f)

    elseif order=="Hexagon" then
        -- Walk 6 edges
        local seg=math.floor(frac*6); local f=(frac*6)-seg
        local a1=(seg/6)*math.pi*2; local a2=((seg+1)/6)*math.pi*2
        offset=Vector3.new(math.cos(a1)*radius,0,math.sin(a1)*radius):Lerp(Vector3.new(math.cos(a2)*radius,0,math.sin(a2)*radius),f)

    elseif order=="Octagon" then
        -- Walk 8 edges
        local seg=math.floor(frac*8); local f=(frac*8)-seg
        local a1=(seg/8)*math.pi*2; local a2=((seg+1)/8)*math.pi*2
        offset=Vector3.new(math.cos(a1)*radius,0,math.sin(a1)*radius):Lerp(Vector3.new(math.cos(a2)*radius,0,math.sin(a2)*radius),f)

    elseif order=="Star" then
        -- 5-pointed star: alternate outer/inner radii across 10 half-edges
        local seg=math.floor(frac*10); local f=(frac*10)-seg
        local ro=radius; local ri=radius*0.4
        local r1=seg%2==0 and ro or ri; local r2=seg%2==0 and ri or ro
        local a1=(seg/10)*math.pi*2; local a2=((seg+1)/10)*math.pi*2
        offset=Vector3.new(math.cos(a1)*r1,0,math.sin(a1)*r1):Lerp(Vector3.new(math.cos(a2)*r2,0,math.sin(a2)*r2),f)

    elseif order=="Diamond" then
        -- Rhombus in XY plane: top→right→bottom→left→top
        local seg=math.floor(frac*4); local f=(frac*4)-seg
        if seg==0 then offset=Vector3.new(0,radius,0):Lerp(Vector3.new(radius,0,0),f)
        elseif seg==1 then offset=Vector3.new(radius,0,0):Lerp(Vector3.new(0,-radius,0),f)
        elseif seg==2 then offset=Vector3.new(0,-radius,0):Lerp(Vector3.new(-radius,0,0),f)
        else offset=Vector3.new(-radius,0,0):Lerp(Vector3.new(0,radius,0),f) end

    elseif order=="Cross" then
        -- 4 arms: -X→+X, then -Z→+Z, then the two return strokes give a proper + shape
        local seg=math.floor(frac*4); local f=(frac*4)-seg
        if seg==0 then offset=Vector3.new(-radius,0,0):Lerp(Vector3.new(radius,0,0),f)
        elseif seg==1 then offset=Vector3.new(radius,0,0):Lerp(Vector3.new(0,0,0),f)
        elseif seg==2 then offset=Vector3.new(0,0,-radius):Lerp(Vector3.new(0,0,radius),f)
        else offset=Vector3.new(0,0,radius):Lerp(Vector3.new(0,0,0),f) end

    elseif order=="Spiral" then
        -- Outward Archimedean spiral: radius grows with frac, 3 full turns
        local turns=3; local a=frac*math.pi*2*turns; local r=frac*radius
        offset=Vector3.new(math.cos(a)*r, math.sin(frac*math.pi*2)*radius*0.5, math.sin(a)*r)

    elseif order=="Zigzag" then
        -- 20 zigzag segments advancing in Z, alternating X direction
        local segs=20; local seg=math.floor(frac*segs); local f=(frac*segs)-seg
        local x1=(seg%2==0) and -radius or radius
        local x2=(seg%2==0) and radius or -radius
        local z1=(seg/segs)*radius*2-radius; local z2=((seg+1)/segs)*radius*2-radius
        offset=Vector3.new(x1,0,z1):Lerp(Vector3.new(x2,0,z2),f)

    elseif order=="Wave" then
        -- Sine wave sweeping across X, amplitude in Y
        local x=(frac-0.5)*radius*2
        offset=Vector3.new(x, math.sin(frac*math.pi*6)*radius, 0)

    elseif order=="Figure8" then
        -- Lemniscate-of-Bernoulli style figure-8 in XZ with slight Y bow
        -- x=sin(t), z=sin(t)cos(t) traces a proper figure-8
        offset=Vector3.new(math.sin(ph)*radius, math.sin(ph*2)*radius*0.25, math.sin(ph)*math.cos(ph)*radius)

    elseif order=="Lemniscate" then
        -- Lemniscate of Bernoulli: r²=cos(2θ), only defined where cos(2θ)≥0
        -- Full trace: map frac over [0,2π], clamp r to 0 when undefined
        local cos2=math.cos(2*ph); local rr=cos2>=0 and math.sqrt(cos2)*radius or 0
        offset=Vector3.new(math.cos(ph)*rr, 0, math.sin(ph)*rr)

    elseif order=="Rose" then
        -- 3-petal rose: r=cos(3θ), full trace over [0,π] closes all petals
        local a=frac*math.pi; local rr=math.cos(3*a)*radius
        offset=Vector3.new(rr*math.cos(a), 0, rr*math.sin(a))

    elseif order=="Butterfly" then
        -- Butterfly curve: r=e^sin(θ)-2cos(4θ), full [0,2π] trace
        local rr=(math.exp(math.cos(ph))-2*math.cos(4*ph))*radius*0.3
        offset=Vector3.new(math.sin(ph)*rr, math.cos(ph*2)*radius*0.25, math.cos(ph)*rr)

    elseif order=="Cardioid" then
        -- Cardioid: r=1-cos(θ), full [0,2π] traces the heart shape
        local rr=(1-math.cos(ph))*radius*0.5
        offset=Vector3.new(rr*math.cos(ph), 0, rr*math.sin(ph))

    elseif order=="Helix3D" then
        -- 2-turn helix climbing from -radius to +radius in Y
        local a=frac*math.pi*4
        offset=Vector3.new(math.cos(a)*radius, frac*radius*2-radius, math.sin(a)*radius)

    elseif order=="Sine" then
        -- 3-period sine wave in 3D space (XYZ components at different frequencies)
        local a=frac*math.pi*6
        offset=Vector3.new(math.sin(a)*radius, math.cos(a*0.5)*radius*0.5, math.sin(a*0.7)*radius*0.3)

    elseif order=="Deltoid" then
        -- Deltoid (3-cusped hypocycloid): R=3r, r=R/3
        -- Parametric: x=(2r)cos(t)+r*cos(2t), z=(2r)sin(t)-r*sin(2t), scaled
        local r3=radius/3
        offset=Vector3.new((2*r3*math.cos(ph)+r3*math.cos(2*ph)), 0, (2*r3*math.sin(ph)-r3*math.sin(2*ph)))

    elseif order=="Astroid" then
        -- Astroid (4-cusped hypocycloid): x=cos³(t), z=sin³(t)
        offset=Vector3.new(math.cos(ph)^3*radius, math.sin(ph*2)*radius*0.2, math.sin(ph)^3*radius)

    elseif order=="Nephroid" then
        -- Nephroid (2-cusped epicycloid): x=(3cos-cos3t)/4, z=(3sin-sin3t)/4
        offset=Vector3.new((3*math.cos(ph)-math.cos(3*ph))*radius*0.25, 0, (3*math.sin(ph)-math.sin(3*ph))*radius*0.25)

    elseif order=="Trefoil" then
        -- Trefoil knot: 3D curve that loops through a donut in a knot
        local p=2; local q=3; local a=ph
        local r2=math.cos(q*a)+2
        offset=Vector3.new(r2*math.cos(p*a)*radius*0.3, math.sin(q*a)*radius*0.3, r2*math.sin(p*a)*radius*0.3)

    elseif order=="Rhodonea" then
        -- 4-petal rose: r=cos(2θ), full [0,2π] trace
        local rr=math.cos(2*ph)*radius
        offset=Vector3.new(rr*math.cos(ph), 0, rr*math.sin(ph))

    elseif order=="Limacon" then
        -- Limaçon of Pascal: r=b+a*cos(θ), full [0,2π] trace
        local rr=radius*0.6+radius*0.4*math.cos(ph)
        offset=Vector3.new(rr*math.cos(ph), 0, rr*math.sin(ph))

    elseif order=="Folium" then
        -- Folium of Descartes: r=3a*sin(t)cos(t)/(sin³t+cos³t)
        -- Use safe parametric range avoiding singularity near t=3π/4
        local a=frac*math.pi*1.5-math.pi*0.25+0.05
        local d=math.sin(a)^3+math.cos(a)^3; if math.abs(d)<0.01 then d=0.01 end
        local rr=3*math.sin(a)*math.cos(a)/d*radius*0.5
        rr=math.clamp(rr,-radius,radius)
        offset=Vector3.new(rr*math.cos(a), 0, rr*math.sin(a))

    elseif order=="Cochleoid" then
        -- Cochleoid: r=sin(θ)/θ, spirals from radius down to 0 over [0.01,4π]
        local a=frac*math.pi*4+0.01
        local rr=math.sin(a)/a*radius
        offset=Vector3.new(rr*math.cos(a), 0, rr*math.sin(a))

    elseif order=="Involute" then
        -- Involute of a circle: x=r(cos t+t sin t), z=r(sin t-t cos t)
        local a=frac*math.pi*4
        offset=Vector3.new(radius*0.25*(math.cos(a)+a*math.sin(a)), 0, radius*0.25*(math.sin(a)-a*math.cos(a)))

    elseif order=="Fermat" then
        -- Fermat's spiral: r=√θ, traces outward over [0,4π]
        local a=frac*math.pi*4
        local rr=math.sqrt(a)*radius*0.5
        offset=Vector3.new(rr*math.cos(a), 0, rr*math.sin(a))

    elseif order=="Archimedes" then
        -- Archimedean spiral: r=a*θ, 4 full turns
        local a=frac*math.pi*8
        local rr=a/( math.pi*8)*radius
        offset=Vector3.new(rr*math.cos(a), 0, rr*math.sin(a))

    elseif order=="Parabola" then
        -- Parabola: x sweeps -r to +r, y=x²/r, in XY plane
        local x=(frac-0.5)*radius*2
        offset=Vector3.new(x, x*x/radius, 0)

    elseif order=="Ellipse" then
        -- Ellipse: semi-major=radius, semi-minor=radius/2 in XZ plane
        offset=Vector3.new(math.cos(ph)*radius, 0, math.sin(ph)*radius*0.5)

    elseif order=="Cycloid" then
        -- Cycloid: x=r(t-sin t), y=r(1-cos t), 2 arches
        local a=frac*math.pi*4
        offset=Vector3.new((a-math.sin(a))*radius*0.15, (1-math.cos(a))*radius*0.4, 0)

    elseif order=="Bifolium" then
        -- Bifolium: r=sin(θ)cos²(θ), two petals over [0,2π]
        local rr=math.sin(ph)*math.cos(ph)^2*radius*4
        offset=Vector3.new(rr*math.cos(ph), 0, rr*math.sin(ph))

    elseif order=="Trifolium" then
        -- Trifolium: r=cos(3θ)+1, three petals over [0,2π]
        local rr=(math.cos(3*ph)+1)*radius*0.5
        offset=Vector3.new(rr*math.cos(ph), 0, rr*math.sin(ph))

    elseif order=="Quadrifolium" then
        -- Quadrifolium: r=cos(2θ), 4 petals over [0,2π]
        local rr=math.cos(2*ph)*radius
        offset=Vector3.new(rr*math.cos(ph), rr*0.2, rr*math.sin(ph))

    elseif order=="Cinquefoil" then
        -- 5-petal rose: r=cos(5θ/2) needs [0,4π] for all 5 petals to close
        local a=frac*math.pi*4
        local rr=math.cos(5*a/2)*radius
        offset=Vector3.new(rr*math.cos(a), 0, rr*math.sin(a))

    elseif order=="Sexfoil" then
        -- 6-petal rose: r=cos(3θ) over [0,2π] (even k: 2k petals)
        local rr=math.cos(3*ph)*radius
        offset=Vector3.new(rr*math.cos(ph), math.sin(ph*6)*radius*0.15, rr*math.sin(ph))

    elseif order=="Gear" then
        -- Gear profile: circle with cosine teeth (8 teeth)
        local rr=radius*(1+0.2*math.cos(8*ph))
        offset=Vector3.new(rr*math.cos(ph), 0, rr*math.sin(ph))

    elseif order=="Pinwheel" then
        -- Pinwheel: radius modulated by sin(6θ) with angular twist
        local rr=radius*(1+0.5*math.sin(6*ph))
        local twist=math.sin(6*ph)*0.3
        offset=Vector3.new(rr*math.cos(ph+twist), math.sin(ph*6)*radius*0.15, rr*math.sin(ph+twist))

    elseif order=="Sunflower" then
        -- Sunflower: radius oscillates on 12 petals with Y lift
        local rr=radius*(0.5+0.5*math.cos(ph*12))
        offset=Vector3.new(rr*math.cos(ph), math.cos(ph*12)*radius*0.15, rr*math.sin(ph))

    elseif order=="Daisy" then
        -- Daisy: 10-petal rhodonea, r=(cos(10θ)+1)/2
        local rr=(math.cos(ph*10)+1)*radius*0.5
        offset=Vector3.new(rr*math.cos(ph), 0, rr*math.sin(ph))

    elseif order=="Galaxy" then
        -- Galaxy: outward spiral with 3 full turns and slight vertical wave
        local a=frac*math.pi*6; local rr=frac*radius
        offset=Vector3.new(rr*math.cos(a), math.sin(frac*math.pi*2)*radius*0.2, rr*math.sin(a))

    elseif order=="Comet" then
        -- Comet: conic section (elliptical orbit), r=p/(1+e*cos(θ)), e=0.8
        local rr=radius*0.5/(1+0.8*math.cos(ph))
        rr=math.clamp(rr, 0, radius*3)
        offset=Vector3.new(rr*math.cos(ph), math.sin(ph*3)*radius*0.15, rr*math.sin(ph))

    elseif order=="Maltese" then
        -- Maltese cross: 4 lobes via r=sin(2θ)cos(2θ)=sin(4θ)/2
        local rr=math.sin(4*ph)*radius*0.5
        offset=Vector3.new(rr*math.cos(ph), rr*0.4, rr*math.sin(ph))

    elseif order=="Lightning" then
        -- Lightning bolt: jagged line sweeping X with high-freq Y/Z noise
        local x=(frac-0.5)*radius*2
        offset=Vector3.new(x+math.sin(frac*47)*radius*0.5, math.sin(frac*50)*radius*0.5, (math.sin(frac*31)-0.5)*radius)

    elseif order=="Fractal" then
        -- Fractal-ish: product of three trig terms gives complex multi-lobed shape
        local rr=math.cos(ph)*math.sin(2*ph)*math.cos(3*ph)*radius
        offset=Vector3.new(rr*math.cos(ph), rr*math.sin(2*ph)*0.5, rr*math.sin(ph))

    elseif order=="Hyperbola" then
        -- Hyperbola: x=cosh(t)*r, z=sinh(t)*r, parameter t over [-2,2]
        local t=(frac-0.5)*4
        offset=Vector3.new(math.cosh(t)*radius*0.5, 0, math.sinh(t)*radius*0.5)
    elseif order=="Strophoid" then local a=frac*math.pi*1.8-math.pi*0.9+0.05; local rr=-math.cos(2*a)/math.cos(a)*radius*0.3; offset=Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif order=="Cissoid" then local a=frac*math.pi*1.8-math.pi*0.9+0.05; local rr=2*math.sin(a)^2/math.cos(a)*radius*0.15; offset=Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif order=="Conchoid" then local a=frac*math.pi*1.8-math.pi*0.9+0.05; local rr=(1/math.cos(a)+radius*0.25)*radius*0.15; offset=Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif order=="Viviani" then offset=Vector3.new(radius*(1+math.cos(ph))*0.5,radius*math.sin(ph)*0.5,radius*math.sin(ph/2)*0.5)
    elseif order=="Maclaurin" then local rr=radius*0.5*(2*math.cos(ph)-1); offset=Vector3.new(rr*math.cos(ph),0,rr*math.sin(ph))
    elseif order=="Trisectrix" then local a=frac*math.pi*1.6-math.pi*0.8+0.01; local rr=radius*0.5*(4*math.cos(a)-1/math.cos(a)); offset=Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif order=="Kappa" then local a=frac*math.pi*1.6-math.pi*0.8+0.01; local rr=radius*math.cos(a)/math.sin(a)^2*0.3; offset=Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif order=="Lituus" then local a=frac*math.pi*6+0.01; local rr=radius/math.sqrt(a); offset=Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif order=="Trochoid" then local a=frac*math.pi*4; offset=Vector3.new(a*radius*0.06,radius*(1-1.5*math.cos(a))*0.25,0)
    elseif order=="Epitrochoid" then local R=radius; local r=radius*0.4; local d=radius*0.6; offset=Vector3.new((R+r)*math.cos(ph)-d*math.cos((R/r+1)*ph),0,(R+r)*math.sin(ph)-d*math.sin((R/r+1)*ph))
    elseif order=="Hypotrochoid" then local R=radius; local r=radius*0.4; local d=radius*0.7; offset=Vector3.new((R-r)*math.cos(ph)+d*math.cos((R/r-1)*ph),0,(R-r)*math.sin(ph)-d*math.sin((R/r-1)*ph))
    elseif order=="Vortex" then offset=Vector3.new(math.cos(ph*3)*radius,math.sin(ph*3)*radius,math.sin(ph*1.5)*radius)
    elseif order=="Lemniscate3D" then local d=1+math.sin(ph)^2; offset=Vector3.new(math.cos(ph)/d*radius,math.sin(ph)*radius*0.3,math.sin(ph)*math.cos(ph)/d*radius)
    elseif order=="Spirograph" then local R=radius*0.7; local r=radius*0.3; local d=radius*0.5; offset=Vector3.new((R-r)*math.cos(ph)+d*math.cos((R/r-1)*ph),math.sin(ph*3)*radius*0.2,(R-r)*math.sin(ph)-d*math.sin((R/r-1)*ph))
    elseif order=="Rhodonea6" then local rr=math.cos(6*ph)*radius; offset=Vector3.new(rr*math.cos(ph),0,rr*math.sin(ph))
    elseif order=="Rhodonea8" then local rr=math.cos(8*ph)*radius; offset=Vector3.new(rr*math.cos(ph),0,rr*math.sin(ph))
    elseif order=="EpiSpiral" then local n=3; local rr=radius/(math.cos(n*ph)+0.01)*0.3; offset=Vector3.new(rr*math.cos(ph),0,rr*math.sin(ph))
    elseif order=="HypoSpiral" then local n=4; local a=frac*math.pi*8; local rr=(1-frac)*radius; offset=Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif order=="Kampyle" then local a=frac*math.pi*1.4-math.pi*0.7+0.01; local rr=radius/(math.cos(a)^2+0.01)*0.2; offset=Vector3.new(rr*math.cos(a),0,rr*math.sin(a))
    elseif order=="Bicorn" then local rr=radius*math.sin(ph)^2*(2+math.cos(ph))/(3+math.sin(ph)^2+0.001); offset=Vector3.new(rr*math.cos(ph),0,rr*math.sin(ph))
    elseif order=="Pearce" then local rr=radius*(1+0.5*math.cos(ph))*0.8; offset=Vector3.new(rr*math.cos(ph),math.sin(ph*2)*radius*0.2,rr*math.sin(ph))
    elseif order=="Scarabaeus" then local rr=(math.cos(2*ph)-2*math.cos(ph))*radius*0.4; offset=Vector3.new(rr*math.cos(ph),0,rr*math.sin(ph))
    elseif order=="Dumbbell" then local rr=math.cos(ph)^2*radius; offset=Vector3.new(rr*math.cos(ph),math.sin(ph*4)*radius*0.15,rr*math.sin(ph))
    elseif order=="Teardrop" then local rr=radius*(1-math.cos(ph))*0.6; offset=Vector3.new(rr*math.cos(ph),math.sin(ph)*radius*0.3,rr*math.sin(ph))
    elseif order=="Talbot" then local a2=radius*0.6; local b2=radius*0.4; local rr=math.sqrt(a2^2*math.cos(ph)^2+b2^2*math.sin(ph)^2); offset=Vector3.new(rr*math.cos(ph),0,rr*math.sin(ph))
    elseif order=="Watt" then local rr=radius*(0.8+0.2*math.cos(2*ph)); offset=Vector3.new(rr*math.cos(ph),math.sin(ph*6)*radius*0.1,rr*math.sin(ph))
    elseif order=="Anguinea" then offset=Vector3.new(math.sin(ph)*radius,math.sin(2*ph)*radius*0.5,math.cos(ph)*radius*0.5)
    elseif order=="Squircle" then local s=math.sign(math.cos(ph))*math.abs(math.cos(ph))^(2/3)*radius; local t2=math.sign(math.sin(ph))*math.abs(math.sin(ph))^(2/3)*radius; offset=Vector3.new(s,0,t2)
    elseif order=="Superellipse" then local n=2.5; local s=math.sign(math.cos(ph))*math.abs(math.cos(ph))^(2/n)*radius; local t2=math.sign(math.sin(ph))*math.abs(math.sin(ph))^(2/n)*radius; offset=Vector3.new(s,0,t2)
    elseif order=="Lame" then local n=4; local s=math.sign(math.cos(ph))*math.abs(math.cos(ph))^(2/n)*radius; local t2=math.sign(math.sin(ph))*math.abs(math.sin(ph))^(2/n)*radius; offset=Vector3.new(s,math.sin(ph*4)*radius*0.1,t2)
    elseif order=="Astroid3D" then offset=Vector3.new(math.cos(ph)^3*radius,math.sin(ph*2)*radius*0.4,math.sin(ph)^3*radius)
    elseif order=="Nephroid3D" then offset=Vector3.new((3*math.cos(ph)-math.cos(3*ph))*radius*0.25,math.sin(ph*2)*radius*0.3,(3*math.sin(ph)-math.sin(3*ph))*radius*0.25)
    elseif order=="Cruciform" then local rr=radius/(math.cos(ph)*math.sin(ph)+0.01)*0.2; offset=Vector3.new(rr*math.cos(ph),0,rr*math.sin(ph))
    elseif order=="Piriform" then local rr=radius*0.6*(1+math.sin(ph))*math.cos(ph); offset=Vector3.new(rr,math.sin(ph*3)*radius*0.15,radius*0.6*(1+math.sin(ph))*math.sin(ph))
    elseif order=="CockedHat" then local rr=radius*(2*(1+math.cos(ph))*0.5-0.5); offset=Vector3.new(rr*math.cos(ph),0,rr*math.sin(ph))
    elseif order=="Tschirnhaus" then local a=frac*math.pi*4; offset=Vector3.new(a*radius*0.05,radius*a^2*0.002,0)
    elseif order=="Torpedo" then local rr=radius*math.sin(ph)^2*math.cos(ph); offset=Vector3.new(rr,math.cos(ph*4)*radius*0.15,radius*math.sin(ph)^3)
    elseif order=="Seashell" then local a=frac*math.pi*4; local rr=(1-frac)*radius; offset=Vector3.new(rr*math.cos(a),frac*radius*2-radius,rr*math.sin(a))
    elseif order=="Knot" then local a=frac*math.pi*2; offset=Vector3.new((2+math.cos(3*a))*math.cos(2*a)*radius*0.3,(2+math.cos(3*a))*math.sin(2*a)*radius*0.3,math.sin(3*a)*radius*0.3)
    elseif order=="Torus" then local a=frac*math.pi*2*5; local b=frac*math.pi*2; local R=radius*0.7; local r=radius*0.3; offset=Vector3.new((R+r*math.cos(b))*math.cos(a),r*math.sin(b),(R+r*math.cos(b))*math.sin(a))
    elseif order=="Pretzel" then local a=frac*math.pi*4; offset=Vector3.new(math.cos(a)*radius*(1+0.5*math.cos(3*a/2)),math.sin(a)*radius*0.4,radius*0.5*math.sin(3*a/2))
    elseif order=="Spring" then local a=frac*math.pi*2*8; offset=Vector3.new(math.cos(a)*radius*0.6,frac*radius*2-radius,math.sin(a)*radius*0.6)
    elseif order=="DNA" then local a=frac*math.pi*2*5; local x1=math.cos(a)*radius; local z1=math.sin(a)*radius; local x2=math.cos(a+math.pi)*radius; local z2=math.sin(a+math.pi)*radius; local strand=(i%2==0) and 1 or -1; offset=Vector3.new(strand>0 and x1 or x2,frac*radius*2-radius,strand>0 and z1 or z2)
    elseif order=="Mobius" then local a=ph; local b=frac*math.pi; offset=Vector3.new((1+b*0.5*math.cos(a/2))*math.cos(a)*radius*0.5,b*0.5*math.sin(a/2)*radius*0.5,(1+b*0.5*math.cos(a/2))*math.sin(a)*radius*0.5)
    elseif order=="Lorenz" then local x=math.sin(frac*math.pi*2)*radius*0.5; local y=math.cos(frac*math.pi*3)*radius*0.3; local z2=math.sin(frac*math.pi*5+math.pi)*radius*0.5; offset=Vector3.new(x,y,z2)
    elseif order=="Lissajous" then local a=3; local b2=2; local delta=math.pi/4; offset=Vector3.new(math.sin(a*frac*math.pi*2+delta)*radius,math.cos(frac*math.pi*2)*radius*0.4,math.sin(b2*frac*math.pi*2)*radius)
    elseif order=="Bowditch" then local a=5; local b2=4; offset=Vector3.new(math.sin(a*frac*math.pi*2)*radius,math.cos(b2*frac*math.pi*2)*radius,(math.sin((a+b2)*frac*math.pi))*radius*0.5)
    elseif order=="Hypocycloid3" then local R=radius; local r=radius/3; offset=Vector3.new((R-r)*math.cos(ph)+r*math.cos((R/r-1)*ph),0,(R-r)*math.sin(ph)-r*math.sin((R/r-1)*ph))
    elseif order=="Hypocycloid5" then local R=radius; local r=radius/5; offset=Vector3.new((R-r)*math.cos(ph)+r*math.cos((R/r-1)*ph),0,(R-r)*math.sin(ph)-r*math.sin((R/r-1)*ph))
    elseif order=="Epicycloid3" then local R=radius*0.6; local r=radius*0.2; offset=Vector3.new((R+r)*math.cos(ph)-r*math.cos((R/r+1)*ph),0,(R+r)*math.sin(ph)-r*math.sin((R/r+1)*ph))
    elseif order=="Epicycloid5" then local R=radius*0.7; local r=radius*0.14; offset=Vector3.new((R+r)*math.cos(ph)-r*math.cos((R/r+1)*ph),0,(R+r)*math.sin(ph)-r*math.sin((R/r+1)*ph))
    elseif order=="Gear12" then local rr=radius*(1+0.15*math.cos(12*ph)); offset=Vector3.new(rr*math.cos(ph),0,rr*math.sin(ph))
    elseif order=="Gear20" then local rr=radius*(1+0.1*math.cos(20*ph)); offset=Vector3.new(rr*math.cos(ph),0,rr*math.sin(ph))
    elseif order=="Sunray" then local rr=radius*(0.6+0.4*math.abs(math.cos(ph*8))); offset=Vector3.new(rr*math.cos(ph),0,rr*math.sin(ph))
    elseif order=="Atomic" then offset=Vector3.new(math.cos(ph)*radius*0.8,math.sin(3*ph)*radius*0.4,math.sin(ph)*radius*0.8)
    elseif order=="Pulsar" then local rr=radius*(0.5+0.5*math.sin(ph*13)); offset=Vector3.new(rr*math.cos(ph),math.cos(ph*5)*radius*0.3,rr*math.sin(ph))
    elseif order=="Ripple" then local a=frac*math.pi*2*5; local r=frac*radius; offset=Vector3.new(r*math.cos(a),math.sin(r*0.1)*radius*0.5,r*math.sin(a))
    elseif order=="Pyramid" then local level=math.floor(frac*4); local f2=(frac*4)-level; local h=level/4*radius; local base2=radius*(1-level/4); local a1=(level%4/4)*math.pi*2; local a2=((level%4+1)/4)*math.pi*2; offset=Vector3.new(math.cos(a1)*base2,h,math.sin(a1)*base2):Lerp(Vector3.new(math.cos(a2)*base2*(1-f2),h,math.sin(a2)*base2*(1-f2)),f2)
    elseif order=="Prism" then local side=math.floor(frac*6); local sf=(frac*6)-side; local a1=(side/6)*math.pi*2; local a2=((side+1)/6)*math.pi*2; local y2=side<3 and -radius*0.5 or radius*0.5; offset=Vector3.new(math.cos(a1)*radius,y2,math.sin(a1)*radius):Lerp(Vector3.new(math.cos(a2)*radius,y2,math.sin(a2)*radius),sf)
    elseif order=="Cube3D" then local edges=12; local edge=math.floor(frac*edges); local ef=(frac*edges)-edge; local s=radius*0.7; local pts={{Vector3.new(-s,-s,-s),Vector3.new(s,-s,-s)},{Vector3.new(s,-s,-s),Vector3.new(s,s,-s)},{Vector3.new(s,s,-s),Vector3.new(-s,s,-s)},{Vector3.new(-s,s,-s),Vector3.new(-s,-s,-s)},{Vector3.new(-s,-s,s),Vector3.new(s,-s,s)},{Vector3.new(s,-s,s),Vector3.new(s,s,s)},{Vector3.new(s,s,s),Vector3.new(-s,s,s)},{Vector3.new(-s,s,s),Vector3.new(-s,-s,s)},{Vector3.new(-s,-s,-s),Vector3.new(-s,-s,s)},{Vector3.new(s,-s,-s),Vector3.new(s,-s,s)},{Vector3.new(s,s,-s),Vector3.new(s,s,s)},{Vector3.new(-s,s,-s),Vector3.new(-s,s,s)}}; local ei=math.clamp(edge+1,1,#pts); offset=pts[ei][1]:Lerp(pts[ei][2],ef)
    elseif order=="Octahedron" then local b2=frac*math.pi; offset=Vector3.new(math.sin(b2)*math.cos(ph)*radius,math.cos(b2)*radius,math.sin(b2)*math.sin(ph)*radius)
    elseif order=="Tesseract" then local b2=frac*math.pi*4; local x=math.cos(ph)*radius; local y=math.sin(ph)*radius; local z2=math.cos(b2)*radius*0.5; local w=math.sin(b2)*radius*0.5; offset=Vector3.new(x+w*0.3,y+w*0.3,z2)
    elseif order=="Vortex3D" then local a=frac*math.pi*2*5; local r=(1-frac)*radius; offset=Vector3.new(r*math.cos(a),frac*radius*2-radius,r*math.sin(a))
    elseif order=="Helix4" then local a=frac*math.pi*2*4; offset=Vector3.new(math.cos(a)*radius*0.7,frac*radius*2-radius,math.sin(a)*radius*0.7)
    elseif order=="Corkscrew" then local a=frac*math.pi*2*6; local r=radius*(0.5+0.5*math.sin(a*0.5)); offset=Vector3.new(r*math.cos(a),frac*radius*2-radius,r*math.sin(a))
    elseif order=="Twister" then local a=frac*math.pi*2*3; local r=radius*(1-frac*0.5); offset=Vector3.new(r*math.cos(a)+math.sin(a*7)*radius*0.2,frac*radius*2-radius,r*math.sin(a)+math.cos(a*5)*radius*0.2)
    elseif order=="Whirlpool" then local a=frac*math.pi*2*5; local r=(1-frac)*radius; offset=Vector3.new(r*math.cos(a),math.sin(frac*math.pi*2)*radius*0.5,r*math.sin(a))
    elseif order=="Cyclone" then local a=frac*math.pi*2*4; local r=radius*(0.2+0.8*frac); offset=Vector3.new(r*math.cos(a),(1-frac)*radius*2-radius,r*math.sin(a))
    elseif order=="Tornado3D" then local a=frac*math.pi*2*6; local r=frac*radius; offset=Vector3.new(r*math.cos(a)+math.random(-1,1)*radius*0.05,frac*radius*2-radius,r*math.sin(a)+math.random(-1,1)*radius*0.05)
    elseif order=="Storm" then local a=frac*math.pi*2*4; local r=radius*(0.3+0.7*math.sin(frac*math.pi)^2); offset=Vector3.new(r*math.cos(a),math.sin(frac*math.pi*3)*radius*0.6,r*math.sin(a))
    elseif order=="Chaos3D" then local a=frac*math.pi*7; local b2=frac*math.pi*11; local c=frac*math.pi*13; offset=Vector3.new(math.sin(a)*math.cos(b2)*radius,math.sin(b2)*math.sin(c)*radius*0.7,math.cos(a)*math.cos(c)*radius)
    elseif order=="Nova" then local rr=radius*(0.5+0.5*math.sin(ph*17))*(1+0.3*math.cos(ph*5)); offset=Vector3.new(rr*math.cos(ph),math.sin(ph*7)*radius*0.3,rr*math.sin(ph))
    else offset=Vector3.new(math.cos(ph)*radius,0,math.sin(ph)*radius) end
    return offset
end
local vs_conn, last_vs_pos = nil, nil
getgenv().start_void_spam = function()
    if vs_conn then return end
    local dt_buf = 0
    vs_conn = run_service.Heartbeat:Connect(function(dt)
        if not config.void_spam_enabled then getgenv().stop_void_spam() return end
        for _, o in ipairs(workspace:GetChildren()) do
            if o.Name == "CoreProjectile" and o:IsA("BasePart") then o.CFrame = CFrame.new(999999, 999999, 999999); o.AssemblyLinearVelocity = Vector3.zero end
        end
        local hrp = getgenv().get_hrp(localplayer)
        local hum = localplayer.Character and localplayer.Character:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then return end
        if hum:GetState() ~= Enum.HumanoidStateType.Physics then hum:ChangeState(Enum.HumanoidStateType.Physics) end
        dt_buf = dt_buf + dt
        if dt_buf >= 0.001 then
            local iters = math.clamp(config.et_total or 1000, 1, 500)
            local spd = config.et_speed or 1000
            for i = 1, iters do
                local frac = (i - 1) / iters
                local ph = frac * math.pi * 2
                local radius = 50000
                local offset = get_vs_order_offset(config.et_order or "Triangle", frac, i, ph, radius)
                local finalPos = last_vs_pos or hrp.Position
                local mode = config.et_mode or "Random"
                if mode == "Random" then finalPos = hrp.Position + offset + Vector3.new(math.random(-500,500), math.random(-500,500), math.random(-500,500))
                elseif mode == "Camera" then local cam = workspace.CurrentCamera; if cam then finalPos = cam.CFrame.Position + (cam.CFrame.LookVector * radius) + offset end
                elseif mode == "Forward" then finalPos = hrp.Position + (hrp.CFrame.LookVector * radius) + offset
                elseif mode == "Directional" then
                    local raw_delta = get_vs_delta(dt, config.vs_xp, config.vs_xn, config.vs_yp, config.vs_yn, config.vs_zp, config.vs_zn)
                    local dir = raw_delta.Unit
                    if dir.Magnitude == dir.Magnitude then finalPos = finalPos + (dir * (config.vs_dist_per_tp or 1000)) end
                end
                last_vs_pos = finalPos
                hrp.CFrame = CFrame.new(finalPos)
            end
            hrp.AssemblyLinearVelocity = Vector3.zero; hrp.AssemblyAngularVelocity = Vector3.zero; dt_buf = 0
        end
    end)
end
getgenv().stop_void_spam = function() if vs_conn then vs_conn:Disconnect(); vs_conn = nil end; config.void_spam_enabled = false; last_vs_pos = nil end
local function get_hitbox_part(char)
    local hb=config.rage_hitbox; local part=nil
    if hb=="Head" then part=char:FindFirstChild("Head")
    elseif hb=="Upper torso" then part=char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    elseif hb=="HumanoidRootPart" then part=char:FindFirstChild("HumanoidRootPart")
    elseif hb=="Lower torso" then part=char:FindFirstChild("LowerTorso") or char:FindFirstChild("Torso")
    elseif hb=="Right arm" then part=char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm")
    elseif hb=="Left arm" then part=char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm")
    elseif hb=="Right leg" then part=char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg")
    elseif hb=="Left leg" then part=char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg") end
    return part or char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
end
local function get_weapon_slot() if config.rage_weapon=="None" then return nil end return config.rage_weapon=="Primary" and 1 or 2 end
local function equip_slot()
    local f_ctrl=localplayer.PlayerScripts.Controllers:FindFirstChild("FighterController")
    if f_ctrl then
        local lf=require(f_ctrl).LocalFighter
        if lf then
            local w=get_weapon_slot(); if config.rage_type=="Normal" then w=3 end
            if w then pcall(function() if lf.EquipItem then lf:EquipItem(w) end if lf.SwitchToSlot then lf:SwitchToSlot(w) end end) end
        end
    end
end
local predict_vel=Vector3.zero; local predict_lastpos=nil; local predict_lasttime=0
run_service.Heartbeat:Connect(function()
    if not config.prediction_enabled or not getgenv().rb_target then predict_vel=Vector3.zero; predict_lastpos=nil; return end
    local root=getgenv().rb_target.Character and getgenv().rb_target.Character:FindFirstChild("HumanoidRootPart"); if not root then return end
    local now=tick(); local dt=now-predict_lasttime
    if dt>0 and dt<0.1 then
        local cur=root.Position
        if predict_lastpos then local inst=(cur-predict_lastpos)/dt; predict_vel=predict_vel:Lerp(inst,0.6) end
        predict_lastpos=cur; predict_lasttime=now
    end
end)
local function predict_target(targetpart,origin)
    if not config.prediction_enabled or not targetpart then return targetpart and targetpart.Position or Vector3.zero end
    local dist=(targetpart.Position-origin).Magnitude; local ping=localplayer:GetNetworkPing()
    return targetpart.Position+(predict_vel*((dist/3000+ping)*(config.prediction_mult or 1.2)))
end
local tp_pred_history={}; local tp_pred_vel=Vector3.zero; local tp_pred_lasttime=0; local tp_pred_lastpos=nil
run_service.Heartbeat:Connect(function()
    if not config.tp_prediction_enabled or not getgenv().rb_target then tp_pred_history={}; tp_pred_vel=Vector3.zero; tp_pred_lastpos=nil; return end
    local root=getgenv().rb_target.Character and getgenv().rb_target.Character:FindFirstChild("HumanoidRootPart"); if not root then return end
    local now=tick(); local dt=now-tp_pred_lasttime
    if dt>0 and dt<0.2 then
        local cur=root.Position
        if tp_pred_lastpos then
            local inst=(cur-tp_pred_lastpos)/dt
            if inst.Magnitude<50000 then
                table.insert(tp_pred_history,inst)
                if #tp_pred_history>16 then table.remove(tp_pred_history,1) end
                local avg=Vector3.zero; local weight_sum=0
                for idx,v in ipairs(tp_pred_history) do local w=idx/#tp_pred_history; avg=avg+v*w; weight_sum=weight_sum+w end
                if weight_sum>0 then tp_pred_vel=avg/weight_sum end
            end
        end
        tp_pred_lastpos=cur; tp_pred_lasttime=now
    end
end)
local function tp_predict_pos(t_hrp)
    if not config.tp_prediction_enabled or not t_hrp then return t_hrp and t_hrp.Position or Vector3.zero end
    local ping=localplayer:GetNetworkPing(); local strength=config.tp_pred_strength or 1.0
    return t_hrp.Position+tp_pred_vel*((ping*4+0.05)*strength)
end
local function fire_autoshoot(t_head,t_char)
    task.spawn(function()
        pcall(function()
            local util=require(r_storage:WaitForChild("Modules",2):WaitForChild("Utility",2))
            local enums=require(r_storage:WaitForChild("Modules",2):WaitForChild("EnumLibrary",2))
            local f_ctrl=require(localplayer.PlayerScripts.Controllers:WaitForChild("FighterController",2))
            if not util or not enums or not f_ctrl then return end
            if f_ctrl.LocalFighter and f_ctrl.LocalFighter.EquippedItem then
                local item=f_ctrl.LocalFighter.EquippedItem; local cam_pos=workspace.CurrentCamera.CFrame.Position
                local atp=predict_target(t_head,cam_pos); local c_data={}
                c_data[utf8.char(1)]={[utf8.char(0)]=util:EncodeCFrame(CFrame.lookAt(cam_pos,atp)),[utf8.char(1)]=util:EncodeCFrame(CFrame.lookAt(cam_pos,atp)),[utf8.char(2)]=t_head,[utf8.char(3)]=util:EncodeCFrame(t_head.CFrame:ToObjectSpace(CFrame.new(atp)))}
                c_data.Hitbox=t_head.Name
                for _=1,(config.shoot_attempts or 1) do r_storage.Remotes.Replication.Fighter.UseItem:FireServer(item:Get("ObjectID"),enums:ToEnum("StartShooting"),c_data,nil) end
            end
        end)
    end)
end
getgenv().fire_autoshoot=fire_autoshoot
local rb_last_shot=0
local function _vec3_finite(v)
    return v.X==v.X and v.Y==v.Y and v.Z==v.Z
        and math.abs(v.X)~=math.huge and math.abs(v.Y)~=math.huge and math.abs(v.Z)~=math.huge
end
local function get_rage_offset(strat, t_hrp, base_pos)
    local look = t_hrp.CFrame.LookVector
    if look.Magnitude < 0.001 then look = Vector3.new(0, 0, -1) end
    local offset = Vector3.zero
    local wild = CFrame.Angles(0, 0, 0)
    if strat == "Orbit" then
        local spin_rad = tick() * (config.rage_orbit_speed or 500) / 100
        local radius = math.max(config.rage_tp_radius or 5, 1)
        local height = config.rage_tp_height or -4
        offset = Vector3.new(math.cos(spin_rad) * radius, height, math.sin(spin_rad) * radius)
        wild = CFrame.lookAt(Vector3.zero, Vector3.new(math.cos(spin_rad + math.pi), 0, math.sin(spin_rad + math.pi)))
    else
        local pos_mode = string.lower(config.rage_position or "inside")
        local pos_dist = config.rage_tp_radius or 2
        if pos_mode == "front" then offset = look * pos_dist
        elseif pos_mode == "behind" then offset = -look * pos_dist
        elseif pos_mode == "above" then offset = Vector3.new(0, math.abs(config.rage_tp_height or 15) + 5, 0)
        elseif pos_mode == "below" then offset = Vector3.new(0, -(math.abs(config.rage_tp_height or 4) + 2), 0) end
        local mode = config.rage_type or "Melee"
        if mode == "Gun" then offset = Vector3.new(0, math.max(config.rage_tp_height or 15, 5), 0)
        elseif mode == "Knife" then offset = -look * (config.knife_dist or 3) end
        if config.rage_spin then
            local t = tick()
            wild = CFrame.Angles(math.rad(1e70 * t * 1.0 % 360), math.rad(1e70 * t * 0.73 % 360), math.rad(1e70 * t * 0.41 % 360))
        end
    end
    return offset, wild
end
local function snap_to_target(dt)
    if not config.rage_bot_enabled then return end
    local target = getgenv().get_rage_target()
    getgenv().rb_target = target
    local hrp = getgenv().get_hrp(localplayer)
    if not (target and target.Character and hrp) then return end
    if localplayer.Team and target.Team and localplayer.Team == target.Team then return end
    local target_part = get_hitbox_part(target.Character)
    local t_hrp = target.Character:FindFirstChild("HumanoidRootPart")
    if not (target_part and t_hrp) then return end
    local hum = localplayer.Character and localplayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then pcall(function() hum:ChangeState(Enum.HumanoidStateType.Physics) end) end
    local strat = config.rage_strategy or "TP"
    local raw_base
    if config.tp_prediction_enabled then
        raw_base = tp_predict_pos(t_hrp)
        if not _vec3_finite(raw_base) then raw_base = t_hrp.Position end
    else
        raw_base = t_hrp.Position
    end
    if not _vec3_finite(raw_base) then raw_base = t_hrp.Position end
    if not _vec3_finite(raw_base) then return end
    local offset, wild = get_rage_offset(strat, t_hrp, raw_base)
    local dest_pos = raw_base + offset
    if not _vec3_finite(dest_pos) then dest_pos = raw_base end
    if not _vec3_finite(dest_pos) then return end
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
    pcall(function()
        hrp.CFrame = CFrame.new(dest_pos.X, dest_pos.Y, dest_pos.Z) * wild
    end)
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
end
local function snap_and_shoot(dt)
    if not config.rage_bot_enabled then return end
    snap_to_target(dt)
    equip_slot()
    local target = getgenv().rb_target
    if not (target and target.Character) then return end
    local target_part = get_hitbox_part(target.Character)
    local is_immune = target.Character:FindFirstChildOfClass("ForceField")
    if not target_part then return end
    local mode = config.rage_type or "Normal"
    if mode == "Knife" then workspace.CurrentCamera.CFrame = CFrame.lookAt(workspace.CurrentCamera.CFrame.Position, target_part.Position) end
    if mode ~= "Knife" and not is_immune and tick() - rb_last_shot > 0.05 then
        rb_last_shot = tick()
        fire_autoshoot(target_part, target.Character)
    end
end
getgenv().__ragebot_start = function()
    run_service:BindToRenderStep("RageSnapPosition", Enum.RenderPriority.Camera.Value + 2, function(dt)
        if not config.rage_bot_enabled then return end
        snap_to_target(dt)
    end)
    run_service:BindToRenderStep("RageSnapShoot", Enum.RenderPriority.Camera.Value + 1, function(dt)
        if not config.rage_bot_enabled then return end
        snap_and_shoot(dt)
    end)
end
getgenv().__ragebot_stop = function()
    config.rage_bot_enabled = false
    pcall(function() run_service:UnbindFromRenderStep("RageSnapPosition") end)
    pcall(function() run_service:UnbindFromRenderStep("RageSnapShoot") end)
    getgenv().rb_target = nil
end
local esp_drawings = {}
local function clear_esp()
    for _, d in ipairs(esp_drawings) do pcall(function() d:Remove() end) end
    esp_drawings = {}
end
local esp_conn = nil
local function start_esp()
    if esp_conn then esp_conn:Disconnect() end
    esp_conn = run_service.RenderStepped:Connect(function()
        clear_esp()
        if not (config.esp_boxes or config.esp_names or config.esp_health or config.esp_tracers) then return end
        local cam = workspace.CurrentCamera; if not cam then return end
        for _, plr in ipairs(players:GetPlayers()) do
            if plr == localplayer then continue end
            if not plr.Character then continue end
            local hrp2 = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum2 = plr.Character:FindFirstChildOfClass("Humanoid")
            if not hrp2 or not hum2 or hum2.Health <= 0 then continue end
            local pos, vis = cam:WorldToViewportPoint(hrp2.Position)
            if not vis then continue end
            if config.esp_names then
                local lbl = Drawing.new("Text"); lbl.Text = plr.Name; lbl.Position = Vector2.new(pos.X, pos.Y - 30)
                lbl.Color = Color3.fromRGB(255,255,255); lbl.Size = 14; lbl.Center = true; lbl.Visible = true
                table.insert(esp_drawings, lbl)
            end
            if config.esp_health then
                local hbar = Drawing.new("Text"); hbar.Text = string.format("HP: %d", math.floor(hum2.Health))
                hbar.Position = Vector2.new(pos.X, pos.Y - 14); hbar.Color = Color3.fromRGB(0,255,100); hbar.Size = 12; hbar.Center = true; hbar.Visible = true
                table.insert(esp_drawings, hbar)
            end
        end
    end)
end
start_esp()
local _lib_ready = false
local library, ThemeManagerObs, SaveManagerObs
local _lib_load_start = tick()
task.spawn(function()
    local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
    local _ok1, _lib = pcall(function()
        local raw = game:HttpGet(repo .. "Library.lua")
        return loadstring(raw)()
    end)
    if not _ok1 or not _lib then
        notify("meowlua", "UI library failed to load. Check HttpGet permissions.")
        _lib_ready = true
        return
    end
    library = _lib
    local _ok2, _tm = pcall(function()
        local raw = game:HttpGet(repo .. "addons/ThemeManager.lua")
        return loadstring(raw)()
    end)
    if _ok2 and _tm then ThemeManagerObs = _tm end
    local _ok3, _sm = pcall(function()
        local raw = game:HttpGet(repo .. "addons/SaveManager.lua")
        return loadstring(raw)()
    end)
    if _ok3 and _sm then SaveManagerObs = _sm end
    _lib_ready = true
end)
repeat task.wait(0.1) until _lib_ready or (tick() - _lib_load_start) > 30
if not library then
    notify("meowlua", "UI timed out, logic is active without UI.")
    getgenv().unload_all = function()
        getgenv().meowlua_loaded = false
        pcall(SBD.Disable, SBD); pcall(BulletTP.Disable, BulletTP)
        pcall(getgenv().stop_fly); pcall(getgenv().stop_fake_position); pcall(getgenv().stop_desync)
        pcall(getgenv().stop_anti_afk); pcall(getgenv().stop_pos_spam); pcall(getgenv().stop_void_spam)
        pcall(getgenv().stop_riot_abuser); pcall(getgenv().stop_zigzag_abuser)
        pcall(getgenv().stop_evasion); pcall(getgenv().stop_blink); pcall(getgenv().stop_ghost)
        pcall(getgenv().stop_autocollect); pcall(getgenv().stop_safe_zone); pcall(getgenv().stop_return_home)
        pcall(getgenv().stop_teleport_loop); pcall(getgenv().stop_anti_close); pcall(getgenv().stop_glide)
        pcall(getgenv().stop_map_orbit); pcall(getgenv().__ragebot_stop); pcall(getgenv().stop_strafebot)
        pcall(getgenv().stop_rapid_fire); pcall(getgenv().stop_anti_aim)
        pcall(getgenv().stop_no_muzzle_flash); pcall(getgenv().stop_display_angles)
        pcall(getgenv().stop_mod_detector); pcall(getgenv().stop_starborn)
        config.ffa_hopping_enabled = false
        for _, c in ipairs(getgenv().all_connections) do pcall(function() c:Disconnect() end) end
        getgenv().all_connections = {}
        clear_esp()
    end
    local function handle_autoload()
        local cfgs = getgenv().list_cfgs()
        for _, c in ipairs(cfgs) do
            local path = "meowlua_configs/" .. c .. ".json"
            local ok, raw = pcall(readfile, path)
            if ok and raw then
                local s, d = pcall(function() return http_service:JSONDecode(raw) end)
                if s and d and d.AutoLoadConfig and d.LastLoadedConfig then
                    if getgenv().load_cfg(d.LastLoadedConfig) then return end
                end
            end
        end
    end
    pcall(handle_autoload)
    return
end
local window = library:CreateWindow({ Title = "meowlua", Center = true, AutoShow = true, Footer = "version: v2.9 |best lua | simply the best | https://discord.gg/ZDQHjpUTd" })

local function tnotify(t, d) if d then library:Notify({ Title=t, Description=d, Time=3 }) else library:Notify({ Title=t, Time=3 }) end end
local function tgl(b, id, t, d, cb)
    local toggle = b:AddToggle(id, { Text=t, Default=false, Tooltip=d })
    toggle:OnChanged(function(v) if v then tnotify(t, d) end cb(v) end)
    toggle:AddKeyPicker(id.."_K", { Default="None", SyncToggleState=true, Mode="Toggle", Text=t })
    return toggle
end

local tab_rage     = window:AddTab("Rage",     "rbxassetid://98159911363596")
local tab_guns     = window:AddTab("Guns",     "rbxassetid://12403097620")
local tab_misc     = window:AddTab("Misc",     "rbxassetid://10455604811")
local tab_voidspam = window:AddTab("Lua",     "rbxassetid://10455603612")
local tab_settings = window:AddTab("Settings", "rbxassetid://11888734334")

local rb_rage = tab_rage:AddLeftGroupbox("Ragebot")
tgl(rb_rage, "rb_etg", "Ragebot", "Targets enemies based on mode, very customizable.", function(v)
    config.rage_bot_enabled = v
    if v then getgenv().__ragebot_start() else getgenv().__ragebot_stop() end
end)
rb_rage:AddDropdown("r_typ", { Text="Attack Mode", Default=1, Values={"Melee","Gun","Knife"} }):OnChanged(function(v)
    config.rage_type = v
end)
rb_rage:AddDropdown("r_strat", { Text="Ragebot Strategy",  Default=2, Values={"Orbit","TP"} }):OnChanged(function(v) config.rage_strategy=v end)
rb_rage:AddDropdown("r_wep",   { Text="Weapon",    Default=1, Values={"None","Primary","Secondary"} }):OnChanged(function(v) config.rage_weapon=v end)
rb_rage:AddDropdown("r_box",   { Text="Targeting", Default=1, Values={"Head","Upper torso","HumanoidRootPart","Lower torso","Right arm","Left arm","Right leg","Left leg"} }):OnChanged(function(v) config.rage_hitbox=v end)
rb_rage:AddDropdown("r_pos",   { Text="Position",  Default=5, Values={"Front","Behind","Above","Below","Inside"} }):OnChanged(function(v) config.rage_position=v end)
local function updatePlayerList()
    local list = {""}
    for _, p in ipairs(players:GetPlayers()) do if p ~= localplayer then table.insert(list, p.Name) end end
    return list
end
local prio_drop = rb_rage:AddDropdown("r_prio", { Text="Priority", Default=1, Values=updatePlayerList() })
prio_drop:OnChanged(function(v) config.rage_priority=v end)
players.PlayerAdded:Connect(function() prio_drop:SetValues(updatePlayerList()) end)
players.PlayerRemoving:Connect(function() prio_drop:SetValues(updatePlayerList()) end)
rb_rage:AddSlider("s_att",     { Text="Shoot Attempts",       Default=1,   Min=1,   Max=3,   Rounding=0 }):OnChanged(function(v) config.shoot_attempts=v end)
tgl(rb_rage, "pred_e",    "Bullet Prediction",   "Predicts where enemy will go to fire more smoothly at faster targets.", function(v) config.prediction_enabled=v end)
rb_rage:AddSlider("pred_m",  { Text="Prediction Multiplier", Default=1.2, Min=0.1, Max=3.0, Rounding=1 }):OnChanged(function(v) config.prediction_mult=v end)
tgl(rb_rage, "tp_pred_e", "Teleport Prediction", "Teleports to enemy based on prediction, not reaction time.",          function(v) config.tp_prediction_enabled=v end)
rb_rage:AddSlider("tp_pred_s", { Text="Prediction Strength", Default=1.0, Min=0.1, Max=5.0, Rounding=1 }):OnChanged(function(v) config.tp_pred_strength=v end)

local rb_sliders = tab_rage:AddLeftGroupbox("Ragebot Adjustments")
rb_sliders:AddSlider("rb_tp_rad", { Text="TP Radius",            Default=2,   Min=0,    Max=100,  Rounding=1 }):OnChanged(function(v) config.rage_tp_radius=v end)
rb_sliders:AddSlider("rb_tp_h",   { Text="TP Height",            Default=-4,  Min=-100, Max=100,  Rounding=1 }):OnChanged(function(v) config.rage_tp_height=v end)
rb_sliders:AddSlider("ro_spd",    { Text="Orbit Speed",          Default=500, Min=10,   Max=5000, Rounding=0 }):OnChanged(function(v) config.rage_orbit_speed=v end)
rb_sliders:AddSlider("kr_d",      { Text="Knife Distance Behind",Default=3,   Min=1,    Max=10,   Rounding=0 }):OnChanged(function(v) config.knife_dist=v end)
tgl(rb_sliders, "r_spin", "Spin", "Rotates at a extremely high velocity across all axes.", function(v) config.rage_spin=v end)

local box_evasion = tab_rage:AddRightGroupbox("Evasion")
tgl(box_evasion, "ev_e", "Evasion", "Spins and teleports your character rapidly across the map using a chosen pattern.", function(v)
    config.evasion_enabled = v
    if v then getgenv().start_evasion() else getgenv().stop_evasion() end
end)
box_evasion:AddDropdown("ev_mode", {
    Text = "Evasion Mode",
    Default = 1,
    Values = {
        "Random","Circle","Spiral","Figure8","Helix","Star","Triangle","Square","Pentagon","Hexagon",
        "Octagon","Diamond","Cross","Zigzag","Wave","Sine","Lemniscate","Rose","Butterfly","Cardioid",
        "Epicycloid","Hypocycloid","Hypotrochoid","Epitrochoid","Fermat","Archimedes","Lituus","Cissoid",
        "Strophoid","Limacon","Astroid","Deltoid","Nephroid","Trefoil","Viviani","Rhodonea","Maclaurin",
        "Trisectrix","Folium","Cochleoid","Involute"
    }
}):OnChanged(function(v) config.evasion_mode=v end)
box_evasion:AddSlider("ev_burst", { Text="Burst Count", Default=500, Min=100, Max=1000, Rounding=0 }):OnChanged(function(v) config.evasion_burst=v end)
box_evasion:AddSlider("ev_int",   { Text="Interval",    Default=1,   Min=1,   Max=1000, Rounding=0 }):OnChanged(function(v) config.evasion_interval=v end)
box_evasion:AddSlider("ev_spn",   { Text="Spin Speed",  Default=9999, Min=0,  Max=999999, Rounding=0 }):OnChanged(function(v) config.evasion_spin_speed=v end)

local box_anti_aim_new = tab_rage:AddRightGroupbox("Anti Aim")
tgl(box_anti_aim_new, "aa_e", "Anti Aim", "Scrambles orientation to reduce hitbox accuracy.", function(v)
    config.anti_aim_enabled = v
    if v then getgenv().start_anti_aim() else getgenv().stop_anti_aim() end
end)
box_anti_aim_new:AddDropdown("aa_meth", { Text="Anti Aim Method", Default=2, Values={"Pixelated","Static","Spin","Jitter","Desync","Sway","Breaker","Lurk","Orbit","Custom"} }):OnChanged(function(v) config.aa_method=v end)
box_anti_aim_new:AddSlider("aa_pxs", { Text="Pixelation Scale", Default=0,    Min=0,    Max=100,    Rounding=0 }):OnChanged(function(v) config.aa_pixel_scale=v end)
box_anti_aim_new:AddSlider("aa_spn", { Text="Spin Speed",       Default=9999, Min=100,  Max=999999, Rounding=0 }):OnChanged(function(v) config.aa_spin_speed=v end)
box_anti_aim_new:AddSlider("aa_yaw", { Text="Yaw",              Default=0,    Min=-0, Max=180,    Rounding=0 }):OnChanged(function(v) config.aa_yaw=v end)
box_anti_aim_new:AddSlider("aa_pit", { Text="Pitch",            Default=0,    Min=-0, Max=180,    Rounding=0 }):OnChanged(function(v) config.aa_pitch=v end)
box_anti_aim_new:AddSlider("aa_rol", { Text="Roll",             Default=0,    Min=-0, Max=180,    Rounding=0 }):OnChanged(function(v) config.aa_roll=v end)
local gun_box = tab_guns:AddLeftGroupbox("Gun Mods")
tgl(gun_box, "no_spread", "No Spread",       "Removes bullet spread completely.",  function(v) config.no_spread=v end)
tgl(gun_box, "no_recoil", "No Recoil",       "Removes weapon recoil.",             function(v) config.no_recoil=v end)
tgl(gun_box, "no_muzzle", "No Muzzle Flash", "Removes particles and lighting.",    function(v) config.no_muzzle_flash=v if v then getgenv().start_no_muzzle_flash() else getgenv().stop_no_muzzle_flash() end end)
tgl(gun_box, "rf",        "Rapid Fire",      "Removes cooldowns for all weapons.", function(v) config.rapid_fire=v if v then getgenv().start_rapid_fire() else getgenv().stop_rapid_fire() end end)

local box_font = tab_misc:AddLeftGroupbox("Customization")
tgl(box_font, "md",  "Staff Detector", "Instant leave if staff joins.",      function(v) config.mod_detector=v if v then getgenv().start_mod_detector() else getgenv().stop_mod_detector() end end)
tgl(box_font, "f_s", "Starborn Font",  "Changes all text to starborn font.", function(v) config.starborn_enabled=v if v then getgenv().start_starborn() else getgenv().stop_starborn() end end)

local box_auto = tab_misc:AddLeftGroupbox("Automation")
tgl(box_auto, "ac_e", "Auto Collect",     "Teleports to drops.",     function(v) config.autocollect_enabled=v if v then getgenv().start_autocollect() else getgenv().stop_autocollect() end end)
box_auto:AddSlider("ac_r", { Text="Collect Radius", Default=120, Min=10, Max=300, Rounding=0 }):OnChanged(function(v) config.autocollect_radius=v end)
tgl(box_auto, "sz_e", "Safe Zone Rescue", "Saves you from falling.", function(v) config.safe_zone_enabled=v if v then getgenv().start_safe_zone() else getgenv().stop_safe_zone() end end)
box_auto:AddSlider("sz_y", { Text="Depth Threshold", Default=-10, Min=-200, Max=50, Rounding=0 }):OnChanged(function(v) config.safe_zone_y=v end)
tgl(box_auto, "rh_e", "Return Home", "Snaps to saved position.", function(v) config.return_home_enabled=v if v then getgenv().start_return_home() else getgenv().stop_return_home() end end)
box_auto:AddButton({ Text="Save Home Position", Func=function()
    local hrp = getgenv().get_hrp(localplayer)
    if hrp then getgenv().home_position = hrp.Position; tnotify("System","Home position saved.") end
end })
box_auto:AddSlider("rh_d", { Text="Return Delay", Default=10, Min=1, Max=150, Rounding=0 }):OnChanged(function(v) config.home_return_delay=v/10 end)
tgl(box_auto, "afk", "Anti AFK",           "Prevents idle disconnect.",       function(v) config.anti_afk_enabled=v if v then getgenv().start_anti_afk() else getgenv().stop_anti_afk() end end)
tgl(box_auto, "ffa", "FFA Server Hopping", "Auto-hops to valid FFA servers.", function(v) config.ffa_hopping_enabled=v end)

local box_loop = tab_misc:AddRightGroupbox("Teleport Loop")
tgl(box_loop, "tl_e", "Teleport Loop", "Cycles saved waypoints.", function(v)
    if v then getgenv().start_teleport_loop() else getgenv().stop_teleport_loop() end
end)
box_loop:AddSlider("tl_d", { Text="Loop Delay", Default=50, Min=10, Max=1000, Rounding=0 }):OnChanged(function(v) config.teleport_loop_delay=v/100 end)
box_loop:AddButton({ Text="Add Waypoint",    Func=function() local hrp=getgenv().get_hrp(localplayer); if hrp then table.insert(getgenv().loop_waypoints,hrp.Position); tnotify("System","Waypoint added.") end end })
box_loop:AddButton({ Text="Clear Waypoints", Func=function() getgenv().loop_waypoints={}; getgenv().loop_index=1; tnotify("System","Waypoints cleared.") end })
local box_vs = tab_voidspam:AddLeftGroupbox("Void Teleport")
tgl(box_vs, "vs_e", "Voidspam", "Fast & very customizable void teleport that makes you hard to hit.", function(v)
    config.void_spam_enabled = v
    if v then getgenv().start_void_spam() else getgenv().stop_void_spam() end
end)
box_vs:AddDropdown("et_mod", { Text="Voidspam Type", Default=1, Values={"Random","Camera","Forward","Directional"} }):OnChanged(function(v) config.et_mode=v end)
box_vs:AddDropdown("et_ord", {
    Text = "Burst Pattern",
    Default = 1,
    Values = {
        "Triangle","Circle","Square","Pentagon","Hexagon","Octagon","Star","Diamond","Cross","Spiral",
        "Zigzag","Wave","Figure8","Lemniscate","Rose","Butterfly","Cardioid","Helix3D","Sine","Deltoid",
        "Astroid","Nephroid","Trefoil","Rhodonea","Limacon","Folium","Cochleoid","Involute","Fermat",
        "Archimedes","Parabola","Ellipse","Cycloid","Bifolium","Trifolium","Quadrifolium","Cinquefoil",
        "Sexfoil","Gear","Pinwheel","Sunflower","Daisy","Galaxy","Comet","Maltese","Lightning","Fractal",
        "Hyperbola","Strophoid","Cissoid","Conchoid","Viviani","Maclaurin","Trisectrix","Kappa","Lituus",
        "Trochoid","Epitrochoid","Hypotrochoid","Vortex","Lemniscate3D","Spirograph","Rhodonea6","Rhodonea8",
        "EpiSpiral","HypoSpiral","Kampyle","Bicorn","Pearce","Scarabaeus","Dumbbell","Teardrop","Talbot",
        "Watt","Anguinea","Squircle","Superellipse","Lame","Astroid3D","Nephroid3D","Cruciform","Piriform",
        "CockedHat","Tschirnhaus","Torpedo","Seashell","Knot","Torus","Pretzel","Spring","DNA","Mobius",
        "Lorenz","Lissajous","Bowditch","Hypocycloid3","Hypocycloid5","Epicycloid3","Epicycloid5","Gear12",
        "Gear20","Sunray","Atomic","Pulsar","Ripple","Pyramid","Prism","Cube3D","Octahedron","Tesseract",
        "Vortex3D","Helix4","Corkscrew","Twister","Whirlpool","Cyclone","Tornado3D","Storm","Chaos3D","Nova"
    }
}):OnChanged(function(v) config.et_order=v end)
box_vs:AddSlider("et_spd", { Text="Interval",    Default=10000000,  Min=0,  Max=10000000, Rounding=0 }):OnChanged(function(v) config.et_speed=v end)
box_vs:AddSlider("et_tot", { Text="Burst Count", Default=500,  Min=1,    Max=500,      Rounding=0 }):OnChanged(function(v) config.et_total=v end)

local box_vs_dir = tab_voidspam:AddLeftGroupbox("Directions")
box_vs_dir:AddSlider("vs_min", { Text="Min Distance", Default=0,     Min=0,  Max=50000,  Rounding=3 }):OnChanged(function(v) config.vs_min_dist=v*1e25 end)
box_vs_dir:AddSlider("vs_max", { Text="Max Distance", Default=50000, Min=10, Max=500000, Rounding=0 }):OnChanged(function(v) config.vs_max_dist=v end)
box_vs_dir:AddSlider("vs_xp",  { Text="X+",           Default=5000,  Min=0,  Max=50000,  Rounding=0 }):OnChanged(function(v) config.vs_xp=v end)
box_vs_dir:AddSlider("vs_xn",  { Text="X-",           Default=5000,  Min=0,  Max=50000,  Rounding=0 }):OnChanged(function(v) config.vs_xn=v end)
box_vs_dir:AddSlider("vs_yp",  { Text="Y+",           Default=5000,  Min=0,  Max=50000,  Rounding=0 }):OnChanged(function(v) config.vs_yp=v end)
box_vs_dir:AddSlider("vs_yn",  { Text="Y-",           Default=5000,  Min=0,  Max=50000,  Rounding=0 }):OnChanged(function(v) config.vs_yn=v end)
box_vs_dir:AddSlider("vs_zp",  { Text="Z+",           Default=5000,  Min=0,  Max=50000,  Rounding=0 }):OnChanged(function(v) config.vs_zp=v end)
box_vs_dir:AddSlider("vs_zn",  { Text="Z-",           Default=5000,  Min=0,  Max=50000,  Rounding=0 }):OnChanged(function(v) config.vs_zn=v end)
local box_vp = tab_voidspam:AddRightGroupbox("More Patterns")
box_vp:AddDropdown("vp_d", { Text="Pattern Settings", Default=1, Values={
    "random","spiral","wave","bounce","chaos","cross","helix","strobe","rhombus",
    "infinity","flower","butterfly","tornado","heart","hexagon","octagon","star","crescent","vortex"
}}):OnChanged(function(v) config.void_pattern=v end)
tgl(box_vp, "vp_x", "Axis X",      "Enable X Axis.",        function(v) config.void_axis_x=v end)
tgl(box_vp, "vp_y", "Axis Y",      "Enable Y axis.",        function(v) config.void_axis_y=v end)
tgl(box_vp, "vp_z", "Axis Z",      "Enable Z axis.",        function(v) config.void_axis_z=v end)
tgl(box_vp, "vp_s", "Smooth Mode", "Lerp instead of snap.", function(v) config.void_smooth=v end)
box_vp:AddSlider("vp_sa", { Text="Smoothness", Default=50, Min=1, Max=100, Rounding=0 }):OnChanged(function(v) config.void_smooth_alpha=v/100 end)

local box_riot = tab_voidspam:AddRightGroupbox("Riot Abuser")
tgl(box_riot, "ra_e", "Riot Abuser", "Spins and jitters your position to block shots.", function(v)
    config.riot_abuser_enabled = v
    if v then getgenv().start_riot_abuser() else getgenv().stop_riot_abuser() end
end)
box_riot:AddSlider("ra_dist", { Text="Riot Distance", Default=500,          Min=100,  Max=2000,        Rounding=0 }):OnChanged(function(v) config.riot_abuser_distance=v end)
box_riot:AddSlider("ra_x",    { Text="X Jitter",         Default=50,           Min=1,    Max=500,         Rounding=0 }):OnChanged(function(v) config.riot_abuser_x=v end)
box_riot:AddSlider("ra_y",    { Text="Y Jitter",         Default=15,           Min=1,    Max=200,         Rounding=0 }):OnChanged(function(v) config.riot_abuser_y=v end)
box_riot:AddSlider("ra_z",    { Text="Z Jitter",         Default=50,           Min=1,    Max=500,         Rounding=0 }):OnChanged(function(v) config.riot_abuser_z=v end)
box_riot:AddSlider("ra_spin", { Text="Spin Speed",       Default=1000000000000, Min=0,   Max=1000000000000, Rounding=0 }):OnChanged(function(v) config.riot_abuser_spin=v end)
local box_settings = tab_settings:AddLeftGroupbox("Settings")
box_settings:AddButton({ Text="Unload meowlua",   Func=function() getgenv().unload_all() end })
box_settings:AddButton({ Text="Display Keybinds", Func=function() library:SetKeybindMenuOpen(true) end })

local box_theme = tab_settings:AddRightGroupbox("Themes")
if ThemeManagerObs then
    ThemeManagerObs:SetLibrary(library)
    ThemeManagerObs:SetFolder("meowlua themes")
    ThemeManagerObs:ApplyToTab(tab_settings)
end
if SaveManagerObs then
    SaveManagerObs:SetLibrary(library)
    SaveManagerObs:IgnoreThemeSettings()
    SaveManagerObs:SetIgnoreIndexes({ "MenuKeybind" })
    SaveManagerObs:SetFolder("meowlua/configs")
    SaveManagerObs:BuildConfigSection(tab_settings)
end

getgenv().unload_all = function()
    getgenv().meowlua_loaded = false
    pcall(SBD.Disable, SBD); pcall(BulletTP.Disable, BulletTP)
    pcall(getgenv().stop_fly); pcall(getgenv().stop_fake_position); pcall(getgenv().stop_desync)
    pcall(getgenv().stop_anti_afk); pcall(getgenv().stop_pos_spam); pcall(getgenv().stop_void_spam)
    pcall(getgenv().stop_riot_abuser); pcall(getgenv().stop_zigzag_abuser)
    pcall(getgenv().stop_evasion); pcall(getgenv().stop_blink); pcall(getgenv().stop_ghost)
    pcall(getgenv().stop_autocollect); pcall(getgenv().stop_safe_zone); pcall(getgenv().stop_return_home)
    pcall(getgenv().stop_teleport_loop); pcall(getgenv().stop_anti_close); pcall(getgenv().stop_glide)
    pcall(getgenv().stop_map_orbit); pcall(getgenv().__ragebot_stop); pcall(getgenv().stop_strafebot)
    pcall(getgenv().stop_rapid_fire); pcall(getgenv().stop_anti_aim)
    pcall(getgenv().stop_no_muzzle_flash); pcall(getgenv().stop_display_angles)
    pcall(getgenv().stop_mod_detector); pcall(getgenv().stop_starborn)
    config.ffa_hopping_enabled = false
    for _, c in ipairs(getgenv().all_connections) do pcall(function() c:Disconnect() end) end
    getgenv().all_connections = {}
    clear_esp()
    pcall(function() library:Unload() end)
end

local function handle_autoload()
    local cfgs = getgenv().list_cfgs()
    for _, c in ipairs(cfgs) do
        local path = "meowlua_configs/" .. c .. ".json"
        local ok, raw = pcall(readfile, path)
        if ok and raw then
            local s, d = pcall(function() return http_service:JSONDecode(raw) end)
            if s and d and d.AutoLoadConfig and d.LastLoadedConfig then
                if getgenv().load_cfg(d.LastLoadedConfig) then
                    tnotify("Config", "Autoloaded: " .. d.LastLoadedConfig)
                    return
                end
            end
        end
    end
end
pcall(handle_autoload)