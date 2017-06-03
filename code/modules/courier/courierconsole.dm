/******************************  Courier System *********************************************************************************
##
##		This system is intended such that:
##			ID points system similar to the mining redemption machine (Same points? Change to general "Supply Points"?)
##			Insert ID into package console 1, purchase a package for ~50 points or so (may start out with courier voucher?)
##			Carry package to console 2, use package on console, insert ID, collect points.
##			Package tracks how many tiles it has been on, keeps array of coordinates
##			Points given is something like:
##					Reward = BasePrice + (tilesRun - 100)
##			Fuck it, it gives caps
##			Alright we're done here
*******************************************************************************************************************************/


/obj/machinery/courierconsole
	name = "Courier Depo"
	desc = "A machine which exchanges packages for caps, and vise-versa."
	icon = 'icons/obj/machines/courier_machines.dmi'
	icon_state = "courierVend"
	density = 1
	anchored = 1
	var/capBank = 0

/obj/machinery/courierconsole/New()
	..()
	component_parts += new /obj/item/weapon/stock_parts/console_screen(null)
	RefreshParts()
	return

/obj/machinery/courierconsole/RefreshParts()
	return

/obj/machinery/courierconsole/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/stack/caps))
		var/tempamount = round(input("How many sheets do you want to add?") as num)//No decimals
		var/obj/item/stack/caps/I = W
		if(!user.Adjacent(src))
			return
		if(tempamount <= 0 || I.amount <= 0)
			return
		if(tempamount >= I.amount)
			tempamount = I.amount
			capBank += tempamount
			I.amount -= tempamount
			user.unEquip(W)
			if (I.amount <= 0)
				del(I)
			user << "<span class='notice'>You add [tempamount] caps to the [src.name].</span>"
