#Chestplate = 5 nuggets in shape hopper 3 ingots in shape upside down bucket
#Leggings = 3 ingots, 4 nuggets
#Boots = 2 ingots, 2 nuggets
#Helmet = 2 ingots, 3 nuggets

#start of the armour processing minetweaker script

#Imports
	import minetweaker.item.IItemStack;
	import minetweaker.item.IIngredient;
	
#Item lists
	#in the rest of this document, some lists of items are used.
	#These lists will have the following order:
	#0 -> Iron
	#1 -> Gold
	#2 -> Copper
	#3 -> Tin
	#4 -> Silver
	#5 -> Lead
	#6 -> Nickel (Ferrous)
	#7 -> Platinum (Shiny)
	#8 -> Bronze
	#9 -> Osmium
	#10 -> Steel (Refined Iron)
	#11 -> Boron
	#12 -> Thaumium
	#13 -> Void metal
	#14 -> Electrum
	
	var oreDictIngots = [ <ore:ingotIron>,
		<ore:ingotGold>,
		<ore:ingotCopper>,
		<ore:ingotTin>,
		<ore:ingotSilver>,
		<ore:ingotLead>,
		<ore:ingotNickel>,
		<ore:ingotPlatinum>,
		<ore:ingotBronze>,
		<ore:ingotOsmium>,
		<ore:ingotSteel>,
		<ore:ingotBoron>,
		<ore:ingotThaumium>,
		<ore:ingotVoid>,
		<ore:ingotElectrum>
		#bronze?
		#bronze?
		#bronze?
	] as IIngredient[];
	
	var oreDictNuggets = [ <ore:nuggetIron>,
		<ore:nuggetGold>,
		<ore:nuggetCopper>,
		<ore:nuggetTin>,
		<ore:nuggetSilver>,
		<ore:nuggetLead>,
		<ore:nuggetNickel>,
		<ore:nuggetPlatinum>,
		<ore:nuggetBronze>,
		<ore:nuggetOsmium>,
		<ore:nuggetSteel>,
		<ore:nuggetBoron>,
		<ore:nuggetThaumium>,
		<ore:nuggetVoid>,
		<ore:nuggetElectrum>
		#bronze?
		#bronze?
		#bronze?
	] as IIngredient[];
	
	var helmets = [ <minecraft:iron_helmet>,
		<minecraft:golden_helmet>,
		<ThermalFoundation:armor.helmetCopper>,
		<ThermalFoundation:armor.helmetTin>,
		<ThermalFoundation:armor.helmetSilver>,
		<ThermalFoundation:armor.helmetLead>,
		<ThermalFoundation:armor.helmetNickel>,
		<ThermalFoundation:armor.helmetPlatinum>,
		<IC2:itemArmorBronzeHelmet>,
		<MekanismTools:OsmiumHelmet>,
		<MekanismTools:SteelHelmet>,
		<NuclearCraft:boronHelm>,
		<Thaumcraft:ItemHelmetThaumium>,
		<Thaumcraft:ItemHelmetVoid>,
		<ThermalFoundation:armor.helmetElectrum>,
		<ThermalFoundation:armor.helmetBronze>, #Extra Bronze 1
		<MekanismTools:BronzeHelmet>, #Extra Bronze 2
		<NuclearCraft:bronzeHelm> #Extra Bronze 3
	] as IItemStack[];
	
	var chestplates = [ <minecraft:iron_chestplate>,
		<minecraft:golden_chestplate>,
		<ThermalFoundation:armor.plateCopper>,
		<ThermalFoundation:armor.plateTin>,
		<ThermalFoundation:armor.plateSilver>,
		<ThermalFoundation:armor.plateLead>,
		<ThermalFoundation:armor.plateNickel>,
		<ThermalFoundation:armor.platePlatinum>,
		<IC2:itemArmorBronzeChestplate>,
		<MekanismTools:OsmiumChestplate>,
		<MekanismTools:SteelChestplate>,
		<NuclearCraft:boronChest>,
		<Thaumcraft:ItemChestplateThaumium>,
		<Thaumcraft:ItemChestplateVoid>,
		<ThermalFoundation:armor.plateElectrum>,
		<ThermalFoundation:armor.plateBronze>, #Extra Bronze 1
		<MekanismTools:BronzeChestplate>, #Extra Bronze 2
		<NuclearCraft:bronzeChest> #Extra Bronze 3
	] as IItemStack[];
	
	var leggings = [ <minecraft:iron_leggings>,
		<minecraft:golden_leggings>,
		<ThermalFoundation:armor.legsCopper>,
		<ThermalFoundation:armor.legsTin>,
		<ThermalFoundation:armor.legsSilver>,
		<ThermalFoundation:armor.legsLead>,
		<ThermalFoundation:armor.legsNickel>,
		<ThermalFoundation:armor.legsPlatinum>,
		<IC2:itemArmorBronzeLegs>,
		<MekanismTools:OsmiumLeggings>,
		<MekanismTools:SteelLeggings>,
		<NuclearCraft:boronLegs>,
		<Thaumcraft:ItemLeggingsThaumium>,
		<Thaumcraft:ItemLeggingsVoid>,
		<ThermalFoundation:armor.legsElectrum>,
		<ThermalFoundation:armor.legsBronze>, #Extra Bronze 1
		<MekanismTools:BronzeLeggings>, #Extra Bronze 2
		<NuclearCraft:bronzeLegs> #Extra Bronze 3
	] as IItemStack[];
	
	var boots = [ <minecraft:iron_boots>,
		<minecraft:golden_boots>,
		<ThermalFoundation:armor.bootsCopper>,
		<ThermalFoundation:armor.bootsTin>,
		<ThermalFoundation:armor.bootsSilver>,
		<ThermalFoundation:armor.bootsLead>,
		<ThermalFoundation:armor.bootsNickel>,
		<ThermalFoundation:armor.bootsPlatinum>,
		<IC2:itemArmorBronzeBoots>,
		<MekanismTools:OsmiumBoots>,
		<MekanismTools:SteelBoots>,
		<NuclearCraft:boronBoots>,
		<Thaumcraft:ItemBootsThaumium>,
		<Thaumcraft:ItemBootsVoid>,
		<ThermalFoundation:armor.bootsElectrum>,
		<ThermalFoundation:armor.bootsBronze>, #Extra Bronze 1
		<MekanismTools:BronzeBoots>, #Extra Bronze 2
		<NuclearCraft:bronzeHelm> #Extra Bronze 3
	] as IItemStack[];
	
#Recipe removal
	#all
		for i, output in helmets {
			recipes.remove(output);
			recipes.remove(chestplates[i]);
			recipes.remove(leggings[i]);
			recipes.remove(boots[i]);
		}
		
#Recipe creation	
	#all
		for i, nugget in oreDictNuggets {
			#helmets
			recipes.addShaped(helmets[i], 
				[[oreDictIngots[i], nugget, oreDictIngots[i]],
				[nugget, null, nugget]]);
			#chestplates
				recipes.addShaped(chestplates[i], 
				[[nugget, null, nugget],
				[nugget, oreDictIngots[i], nugget], 
				[oreDictIngots[i], nugget, oreDictIngots[i]]]);
			#leggings
				recipes.addShaped(leggings[i], 
				[[oreDictIngots[i], oreDictIngots[i], oreDictIngots[i]],
				[nugget, null, nugget], 
				[nugget, null, nugget]]);
			#boots
				recipes.addShaped(boots[i], 
				[[nugget, null, nugget],
				[oreDictIngots[i], null, oreDictIngots[i]]]);	
		}
