#start of the nugget recipes minetweaker script
#this script adds 6 kinds of recipes to craft various types of nuggets into other nuggets, such as alloying and magical transmutations

#Imports
	import minetweaker.item.IItemStack;
	import minetweaker.item.IIngredient;
	
	import mods.botania.ElvenTrade;
	import mods.botania.ManaInfusion;
	import mods.immersiveengineering.ArcFurnace;
	import mods.thaumcraft.Crucible;
	import mods.thermalexpansion.Smelter;

#Item lists
	#in the rest of this document, some lists of items are used.
	#These lists will have the following order:
	#0 -> Constantan (copper + ferrous)	
	#1 -> Electrum (Gold + Silver)
	#2 -> Invar (2 iron + 1 ferrous)
	#3 -> Bronze (3 copper + 1 tin)	
	
	var oreDictNuggetsIn2 = [ <ore:nuggetNickel>,
		<ore:nuggetSilver>,
		<ore:nuggetNickel>,
		<ore:nuggetTin>
	] as IIngredient[];
	
	var in1Amounts = [ 1,
		1,
		2,
		3
	] as int[];
	
	var ic2TinyDustsIn1 = [ <IC2:itemDustSmall:1>,
		<IC2:itemDustSmall:2>,
		<IC2:itemDustSmall> * 2,
		<IC2:itemDustSmall:1> * 3
	] as IItemStack[];

	var ic2TinyDustsIn2 = [ <aobd:dustTinyNickel>,
		<IC2:itemDustSmall:4>,
		<aobd:dustTinyNickel>,
		<IC2:itemDustSmall:3>
	] as IItemStack[];
	
	var tfNuggetsIn1 = [ <ThermalFoundation:material:96>,
		<minecraft:gold_nugget>,
		<ThermalFoundation:material:8> * 2,
		<ThermalFoundation:material:96> * 3
	] as IItemStack[];
	
	var tfNuggetsIn2 = [ <ThermalFoundation:material:100>,
		<ThermalFoundation:material:98>,
		<ThermalFoundation:material:100>,
		<ThermalFoundation:material:97>
	] as IItemStack[];
	
	var nuggetsOut = [ <ImmersiveEngineering:metal:27> * 2,
		<ThermalFoundation:material:103> * 2,
		<ThermalFoundation:material:104> * 3,
		<ThermalFoundation:material:105> * 4
	] as IItemStack[];
	
#Recipe creation
	#Alloys
		for i, output in nuggetsOut {
			#nuggets -> nuggets
			Smelter.addRecipe(800, tfNuggetsIn1[i], tfNuggetsIn2[i], output); #TE Induction Furnace nuggets
			Smelter.addRecipe(800, ic2TinyDustsIn1[i], ic2TinyDustsIn2[i], output); #TE Induction Furnace tiny dusts
			ArcFurnace.addRecipe(output, oreDictNuggetsIn2[i], null, 4600, 3600, [ic2TinyDustsIn1[i]], "Alloying"); #IE Arc furnace nuggets with tiny dusts
			#EIO Alloy smeltery are done in the EIO smeltery xml file (also lumium and signalum)
		}
	#Botania
		ManaInfusion.addAlchemy(<Botania:manaResource:17>, <Thaumcraft:ItemNugget>, 500); #Botania alchemy: Iron -> Manasteel
		ElvenTrade.addRecipe(<Botania:manaResource:19>, [<Botania:manaResource:17>, <Botania:manaResource:17>]); # Elven trade: 2 Manasteel -> Elementium
	#Thaumium
		Crucible.addRecipe("THAUMIUM", <Thaumcraft:ItemNugget:6>, <ore:nuggetIron>, "praecantatio 1"); #Crucible recipe 1 praecantatio <Thaumcraft:itemNugget> or <ore:nuggetIron> to <Thaumcraft:itemNugget:6>
