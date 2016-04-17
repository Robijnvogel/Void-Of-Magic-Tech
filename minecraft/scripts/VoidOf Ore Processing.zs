#start of the ore processing minetweaker script

import minetweaker.item.IItemStack;
import minetweaker.item.IIngredient;

import mods.ic2.Macerator;
import mods.ic2.OreWasher;
import mods.ic2.ThermalCentrifuge;
import mods.mekanism.Enrichment;
import mods.mekanism.Purification;
import mods.mekanism.chemical.Injection;
import mods.mekanism.chemical.Dissolution;
import mods.thermalexpansion.Furnace as RSFurnace;
import mods.thermalexpansion.Smelter as ISmelter;
import mods.immersiveengineering.ArcFurnace;

#Item lists
#in the rest of this document, some lists of items are used.
#These lists will have the following order:
#0 -> Iron
#1 -> Gold
#2 -> Copper
#3 -> Tin
#4 -> Silver
#5 -> Lead
#6 -> Nickel
#7 -> Platinum
#8 -> 
#9 -> 

var oredictOres = [ <ore:oreIron>,
    <ore:oreGold>,
	<ore:oreCopper>,
	<ore:oreTin>,
	<ore:oreSilver>,
	<ore:oreLead>
] as IIngredient[];

var oredictDusts = [ <ore:dustIron>,
    <ore:dustGold>,
	<ore:dustCopper>,
	<ore:dustTin>,
	<ore:dustSilver>,
	<ore:dustLead>
] as IIngredient[];

var tfOres = [ <minecraft:iron_ore>,
    <minecraft:gold_ore>,
	<ThermalFoundation:Ore>, #copper
	<ThermalFoundation:Ore:1>, #tin
	<ThermalFoundation:Ore:2>, #silver
	<ThermalFoundation:Ore:3> #lead
] as IItemStack[];

var tfNuggets = [ <ThermalFoundation:material:8>, #iron
	<minecraft:gold_nugget>,
	<ThermalFoundation:material:96>, #copper
	<ThermalFoundation:material:97>, #tin
	<ThermalFoundation:material:98>, #silver
	<ThermalFoundation:material:99> #lead
] as IItemStack[];

var ic2Ingots = [ <minecraft:iron_ingot>,
    <minecraft:gold_ingot>,
	<IC2:itemIngot>, #copper
	<IC2:itemIngot:1>, #tin
	<IC2:itemIngot:6>, #silver
	<IC2:itemIngot:5> #lead
] as IItemStack[];

var ieIngots = [ <minecraft:iron_ingot>,
    <minecraft:gold_ingot>,
	<ImmersiveEngineering:metal>, #copper
	<ThermalFoundation:material:97>, #tin
	<ImmersiveEngineering:metal:3>, #silver
	<ImmersiveEngineering:metal:2>, #lead
	<ImmersiveEngineering:metal:4> #nickel
] as IItemStack[];

var ic2Dusts = [ <IC2:itemDust:5>, #iron
    <IC2:itemDust:4>, #gold
	<IC2:itemDust:3>, #copper
	<IC2:itemDust:7>, #tin
	<IC2:itemDust:6>, #silver
	<IC2:itemDust:10>, #lead
] as IItemStack[];

var ic2Crushed = [ <IC2:itemCrushedOre>, #iron
	<IC2:itemCrushedOre:2>, #gold
	<IC2:itemCrushedOre:1>, #copper
	<IC2:itemCrushedOre:3>, #tin
	<IC2:itemCrushedOre:6>, #silver
	<IC2:itemCrushedOre:5> #lead
] as IItemStack[];

var mkClumps = [ <Mekanism:Clump>, #iron
	<Mekanism:Clump:1>, #gold
	<Mekanism:Clump:3>, #copper
	<Mekanism:Clump:4>, #tin
	<Mekanism:Clump:5>, #silver
	<Mekanism:Clump:6>, #lead
] as IItemStack[];

var mkShards = [ <Mekanism:Shard>, #iron
	<Mekanism:Shard:1>, #gold
	<Mekanism:Shard:3>, #copper
	<Mekanism:Shard:4>, #tin
	<Mekanism:Shard:5>, #silver
	<Mekanism:Shard:6>, #lead
] as IItemStack[];

#var mkGasses = [ <gas:iron>, #iron
#	<gas:gold>, #gold
#	<gas:copper>, #copper
#	<gas:tin>, #tin
#	<gas:silver>, #silver
#	<gas:lead>, #lead
#];

var tfISmelterRichChances = [ 5, #iron
	60, #gold
	5, #copper
	5, #tin
	5, #silver
	5 #lead
] as int[];

var tfISmelterSecondaries = [ <ThermalFoundation:material:100>, #iron -> ferrous
	<ThermalExpansion:material:515>, #gold -> rich slag
	<minecraft:gold_nugget>, #copper -> gold
	<ThermalExpansion:material:8>, #tin -> iron
	<ThermalFoundation:material:99>, #silver -> lead
	<ThermalFoundation:material:98> #lead -> silver
] as IItemStack[];
	
var tfISmelterSecChances = [ 100, #iron
	75, #gold
	100, #copper
	100, #tin
	100, #silver
	100 #lead
] as int[];


#Recipe removal
#ores
for i, ore in oredictOres {
	furnace.remove(<*>, ore); #Furnace
	recipes.removeShapeless(ic2Ingots[i], [<ThermalFoundation:material:512>, ore ]); #Pyrotheum
	Macerator.addRecipe(ic2Dusts[i] * 2, ore); #IC2 macerator can only be overwritten, not removed.
	Purification.removeRecipe(mkClumps[i], ore, <gas:oxygen>); #MK purification chamber
	Injection.removeRecipe(mkShards[i], ore, <gas:hydrogenchloride>); #MK injection chamber
	#Dissolution.removeRecipe(ore, <gas:iron>); #MK dissolution chamber (not working)
	recipes.remove(<Mekanism:MachineBlock2:6>); #(let's leave this as a solution for now)
	RSFurnace.removeRecipe(tfOres[i]); #TE Redstone furnace
	ISmelter.removeRecipe(tfOres[i], <minecraft:sand>); #TE Induction smelter Sand
	ISmelter.removeRecipe(tfOres[i], <ThermalFoundation:material:20>); #TE Induction smelter Cinnabar
	ISmelter.removeRecipe(tfOres[i], <ThermalFoundation:material:512>); #TE Induction smelter Pyrotheum
	ISmelter.removeRecipe(tfOres[i], <ThermalExpansion:material:515>); #TE Induction smelter Rich Slag
	ArcFurnace.removeRecipe(ieIngots[i]); #IE Arc Furnace
	recipes.remove(<NuclearCraft:factoryIdle>); #NC ManuFactory (something weird with tin...)	
}
#IC2 Blast Furnace iron
#dusts
for i, dust in oredictDusts {
	furnace.remove(<*>, dust); #Furnace	
	RSFurnace.removeRecipe(ic2Dusts[i]); #TE Redstone furnace
	ISmelter.removeRecipe(ic2Dusts[i], <minecraft:sand>); #TE Induction smelter Sand
}
#IC2 Blast Furnace and induction and arc furnace steel
#induction invar, electrum, bronze
#Arc furnace alloys

#clusters
#Factorization stuff
#Mekanism junk	




#Recipe creation
#ores
for i, ore in oredictOres {
	furnace.addRecipe(tfNuggets[i], ore, 0.5); #Furnace
	recipes.addShapeless(tfNuggets[i] * 2, [<ThermalFoundation:material:512>, ore ]); #Pyrotheum
	#Macerator.addRecipe(ic2Dusts[i], ore); #IC2 macerator (has already been done in removal step)	
	Purification.addRecipe(ore, <gas:oxygen>, tfNuggets[i] * 2); #MK purification chamber (2x output)
	Injection.addRecipe(ore, <gas:hydrogenchloride>, tfNuggets[i] * 3); #MK injection chamber (3x output)
	#Dissolution.addRecipe(ore, <gas:water>); MK dissolution chamber
	RSFurnace.addRecipe(800, tfOres[i], tfNuggets[i] * 2); #TE Redstone furnace (2 x output)
	ISmelter.addRecipe(1600, <minecraft:sand>, tfOres[i], tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] ); #TE Induction smelter Sand
	ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, tfOres[i], tfNuggets[i] * 3, tfISmelterSecondaries[i], tfISmelterSecChances[i]); #TE Induction smelter Cinnabar
	ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, tfOres[i], tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Pyrotheum
	ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, tfOres[i], tfNuggets[i] * 3, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag
	ArcFurnace.addRecipe(tfNuggets[i] * 2, ore, <ImmersiveEngineering:material:13>, 100, 512); 	#IE Arc Furnace
}
#IC2 Blast Furnace
#dusts
for i, dust in oredictDusts {
	furnace.addRecipe(tfNuggets[i], dust); #Furnace
	RSFurnace.addRecipe(800, ic2Dusts[i], tfNuggets[i] * 2); #TE Redstone furnace (2 x output)
	ISmelter.addRecipe(1600, <minecraft:sand>, ic2Dusts[i], tfNuggets[i] * 2, <ThermalExpansion:material:514> , 25 ); #TE Induction smelter Sand
}
#IC2 Blast Furnace and induction and arc furnace steel
#induction invar, electrum, bronze
#Arc furnace alloys

#clusters
#Factorization stuff
#Mekanism junk	




#Problems
#IC2 Blast furnace seems to not be available for editing
#I have no idea how to edit Mekanism's Chemical Dissolution recipes
#I can not make an array of Mekanism gasses
#Combiner can break everything