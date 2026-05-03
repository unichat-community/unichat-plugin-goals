--[[
 * Copyright (c) 2026 Voguh
 *
 * This program and the accompanying materials are made
 * available under the terms of the Eclipse Public License 2.0
 * which is available at https://www.eclipse.org/legal/epl-2.0/
 *
 * SPDX-License-Identifier: EPL-2.0
]]

---@type UniChatLogger
local logger = require("unichat:logger");
---@type UniChatStrings
local strings = require("unichat:strings");

--[[ ============================================================================================================== ]]--

local DONATION_GOAL_AMOUNT_STORED_KEY = "donation_goal_amount";
local DONATION_GOAL_TARGET_STORED_KEY = "donation_goal_target";

--[[ ============================================================================================================== ]]--

local donation_goal_amount = 0;
local donation_goal_target = 1000;

--[[ ============================================================================================================== ]]--

---@param data UniChatDonateEventPayload The data payload of the donation event.
local function on_donate(data)
    if donation_goal_target <= 0 then
        return;
    end

    -- Ignore twitch since "donate" in twitch is bits.
    if data.platform == UniChatPlatform:Twitch() then
        logger:warn("Received donation event from unsupported platform: {}", data.platform);
        return;
    end

    donation_goal_amount = donation_goal_amount + data.value;
    UniChatAPI:set_userstore_item(DONATION_GOAL_AMOUNT_STORED_KEY, tostring(donation_goal_amount));
end

--[[ ====================================================================== ]]--

---@param data UniChatSponsorEventPayload The data payload of the sponsorship event.
local function on_sponsor(data)
    logger:info("Working in progress: Sponsorship event handling is not implemented yet.");
end

--[[ ====================================================================== ]]--

---@param args string[] The command arguments as an array of strings.
local function on_set_subcommand(args)
    local scope = table.remove(args, 1);
    local value = table.remove(args, 1);

    if scope == "donate" then
        local amount = tonumber(value);

        if amount ~= nil then
            donation_goal_target = amount;
            UniChatAPI:set_userstore_item(DONATION_GOAL_TARGET_STORED_KEY, tostring(donation_goal_target));
            if donation_goal_target > 0 then
                UniChatAPI:notify("Donation goal target set to " .. donation_goal_target);
            else
                donation_goal_amount = 0;
                UniChatAPI:set_userstore_item(DONATION_GOAL_AMOUNT_STORED_KEY, tostring(donation_goal_amount));

                UniChatAPI:notify("Donation goal target disabled.");
            end
        end
    else
        logger:warn("Unknown scope for set subcommand: {}", scope);
    end
end

---@param args string[] The command arguments as an array of strings.
local function on_add_subcommand(args)
    local scope = table.remove(args, 1);
    local value = table.remove(args, 1);

    if scope == "donate" then
        local amount = tonumber(value);

        if amount ~= nil then
            donation_goal_amount = donation_goal_amount + amount;
            UniChatAPI:set_userstore_item(DONATION_GOAL_AMOUNT_STORED_KEY, tostring(donation_goal_amount));
            UniChatAPI:notify("Added " .. amount .. " to the donation goal progress. Current progress: " .. donation_goal_amount .. "/" .. donation_goal_target);
        end
    else
        logger:warn("Unknown scope for add subcommand: {}", scope);
    end
end

---@param args string[] The command arguments as an array of strings.
local function on_remove_subcommand(args)
    local scope = table.remove(args, 1);
    local value = table.remove(args, 1);

    if scope == "donate" then
        local amount = tonumber(value);

        if amount ~= nil then
            donation_goal_amount = math.max(0, donation_goal_amount - amount);
            UniChatAPI:set_userstore_item(DONATION_GOAL_AMOUNT_STORED_KEY, tostring(donation_goal_amount));
            UniChatAPI:notify("Removed " .. amount .. " from the donation goal progress. Current progress: " .. donation_goal_amount .. "/" .. donation_goal_target);
        end
    else
        logger:warn("Unknown scope for remove subcommand: {}", scope);
    end
end

---@param args string[] The command arguments as an array of strings.
local function on_reset_subcommand(args)
    local scope = table.remove(args, 1);

    if scope == "donate" then
        donation_goal_amount = 0;
        UniChatAPI:set_userstore_item(DONATION_GOAL_AMOUNT_STORED_KEY, tostring(donation_goal_amount));
    else
        logger:warn("Unknown scope for reset subcommand: {}", scope);
    end
end

---@param args string[] The command arguments as an array of strings.
local function on_goal_command(args)
    logger:info("Working in progress: Command handling is not implemented yet.");

    local subcmd = table.remove(args, 1);
    if subcmd == "set" then
        on_set_subcommand(args);
    elseif subcmd == "add" then
        on_add_subcommand(args);
    elseif subcmd == "remove" then
        on_remove_subcommand(args);
    elseif subcmd == "reset" then
        on_reset_subcommand(args);
    else
        logger:warn("Unknown subcommand: {}", subcmd);
    end
end

---@param data UniChatMessageEventPayload The data payload of the message event.
local function on_message(data)
    if data.authorType == "MODERATOR" or data.authorType == "BROADCASTER" then
        local args = strings:split(data.messageText, " ");
        local cmd = table.remove(args, 1);

        if cmd == "!goal" then
            on_goal_command(args);
        end
    end
end

--[[ ====================================================================== ]]--

---@param event UniChatEvent
local function on_event(event)
    if event.type == "unichat:donate" then
        on_donate(event.data);
    elseif event.type == "unichat:sponsor" then
        on_sponsor(event.data);
    elseif event.type == "unichat:message" then
        on_message(event.data);
    end
end

--[[ ============================================================================================================== ]]--

local raw_donation_goal_amount = UniChatAPI:get_userstore_item(DONATION_GOAL_AMOUNT_STORED_KEY);
if raw_donation_goal_amount ~= nil then
    donation_goal_amount = tonumber(raw_donation_goal_amount) or donation_goal_amount;
else
    UniChatAPI:set_userstore_item(DONATION_GOAL_AMOUNT_STORED_KEY, tostring(donation_goal_amount));
end

local raw_donation_goal_target = UniChatAPI:get_userstore_item(DONATION_GOAL_TARGET_STORED_KEY);
if raw_donation_goal_target ~= nil then
    donation_goal_target = tonumber(raw_donation_goal_target) or donation_goal_target;
else
    UniChatAPI:set_userstore_item(DONATION_GOAL_TARGET_STORED_KEY, tostring(donation_goal_target));
end

--[[ ============================================================================================================== ]]--

UniChatAPI:add_event_listener(on_event);
