local function SocietyAccount(amount)
    if Config.UseSocietyAccount then 
        TriggerEvent('qb-bossmenu:server:addAccountMoney', Config.SocietyAccount, amount)
    end
end

QBCore.Functions.CreateCallback('qb-carfixstation:server:pay', function(source, cb, amount)
    if QBCore.Functions.GetPlayer(source).Functions.RemoveMoney("cash", amount, "repair-station") then
	if state then
	    SocietyAccount(amount)
	end
	cb({
	    state   = true,
	    message = Lang:t('company.cost_repair', {amount})
	})
    else
	if QBCore.Functions.GetPlayer(source).Functions.RemoveMoney("bank", amount, "repair-station") then
	    if state then
	    	SocietyAccount(amount)
	    end
	    cb({
		state   = true,
		message = Lang:t('company.cost_repair', {amount})
	    })
	else
	    cb({
		state   = false,
	        message = Lang:t('company.not_enough_money')
	    })
	end
    end
end)
