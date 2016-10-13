#start of the ore processing minetweaker script

#Imports
	import minetweaker.item.IItemStack;
	import minetweaker.item.IIngredient;
	import minetweaker.data.IData;
	import modtweaker.gas.IGasStack;

	import mods.botania.ManaInfusion;
	import mods.factorization.Crystallizer as FZCrystallizer;
	import mods.factorization.Lacerator;
	import mods.factorization.SlagFurnace;
	import mods.ic2.Macerator;
	import mods.ic2.OreWasher;
	import mods.ic2.ThermalCentrifuge;
	import mods.immersiveengineering.ArcFurnace;
	import mods.immersiveengineering.Crusher as IECrusher;
	import mods.mekanism.chemical.Crystallizer as MKCrystallizer;
	import mods.mekanism.chemical.Injection;
	import mods.mekanism.chemical.Dissolution;
	import mods.mekanism.Combiner;
	import mods.mekanism.Crusher as MKCrusher;
	import mods.mekanism.Enrichment;
	import mods.mekanism.Purification;
	import mods.thermalexpansion.Furnace as RSFurnace;
	import mods.thermalexpansion.Pulverizer;
	import mods.thermalexpansion.Smelter as ISmelter;
	import mods.witchinggadgets.InfernalBlastfurnace;

#Item lists
	#in the rest of this document, some lists of items are used.
	#These lists will have the following order:
	#0 -> Iron
	#1 -> Gold
	#2 -> Copper
	#3 -> Tin
	#4 -> Silver (Galena)
	#5 -> Lead
	#6 -> Nickel (Ferrous)
	#7 -> Platinum (Shiny)
	#8 -> Mithril (ManaSteel)
	#9 -> Aluminium
	#10 -> Uranium
	#11 -> Osmium
	#12 -> Dark Iron
	#13 -> Boron
	#14 -> Lithium
	#15 -> Magnesium
	#16 -> Thorium
	#17 -> Octine
	#18 -> Syrmorite

	var oredictOres = [ <ore:oreIron>,
		<ore:oreGold>,
		<ore:oreCopper>,
		<ore:oreTin>,
		<ore:oreSilver>,
		<ore:oreLead>,
		<ore:oreNickel>,
		<ore:orePlatinum>,
		<ore:oreMithril>,
		<ore:oreAluminum>,
		<ore:oreUranium>,
		<ore:oreOsmium>,
		<ore:oreFzDarkIron>,
		<ore:oreBoron>,
		<ore:oreLithium>,
		<ore:oreMagnesium>,
		<ore:oreThorium>,
		<ore:oreOctine>,
		<ore:oreSyrmorite>
	] as IIngredient[];

	var oredictDusts = [ <ore:dustIron>,
		<ore:dustGold>,
		<ore:dustCopper>,
		<ore:dustTin>,
		<ore:dustSilver>,
		<ore:dustLead>,
		<ore:dustNickel>,
		<ore:dustPlatinum>,
		<ore:dustMithril>,
		<ore:dustAluminum>,
		<ore:dustUranium>,
		<ore:dustOsmium>,
		<ore:dustFzDarkIron>,
		<ore:dustBoron>,
		<ore:dustLithium>,
		<ore:dustMagnesium>,
		<ore:dustThorium>,
		<ore:dustOctine>,
		<ore:dustSyrmorite>
	] as IIngredient[];

	var oreDictIngots = [ <ore:ingotIron>,
		<ore:ingotGold>,
		<ore:ingotCopper>,
		<ore:ingotTin>,
		<ore:ingotSilver>,
		<ore:ingotLead>,
		<ore:ingotNickel>,
		<ore:ingotPlatinum>,
		<ore:ingotMithril>,
		<ore:ingotAluminum>,
		<ore:ingotUranium>,
		<ore:ingotOsmium>,
		<ore:ingotFzDarkIron>,
		<ore:ingotBoron>,
		<ore:ingotLithium>,
		<ore:ingotMagnesium>,
		<ore:ingotThorium>,
		<ore:ingotOctine>,
		<ore:ingotSyrmorite>
	] as IIngredient[];

	var oreDictNuggets = [ <ore:nuggetIron>,
		<ore:nuggetGold>,
		<ore:nuggetCopper>,
		<ore:nuggetTin>,
		<ore:nuggetSilver>,
		<ore:nuggetLead>,
		<ore:nuggetNickel>,
		<ore:nuggetPlatinum>,
		<ore:nuggetMithril>,
		<ore:nuggetAluminum>,
		<ore:nuggetUranium>,
		<ore:nuggetOsmium>,
		<ore:nuggetFzDarkIron>,
		<ore:nuggetBoron>,
		<ore:nuggetLithium>,
		<ore:nuggetMagnesium>,
		<ore:nuggetThorium>,
		<ore:nuggetOctine>,
		<ore:nuggetSyrmorite>
	] as IIngredient[];
	
	var oreDictBlocks = [ <ore:blockIron>,
		<ore:blockGold>,
		<ore:blockCopper>,
		<ore:blockTin>,
		<ore:blockSilver>,
		<ore:blockLead>,
		<ore:blockNickel>,
		<ore:blockPlatinum>,
		<ore:blockMithril>,
		<ore:blockAluminum>,
		<ore:blockUranium>,
		<ore:blockOsmium>,
		<ore:blockFzDarkIron>,
		<ore:blockBoron>,
		<ore:blockLithium>,
		<ore:blockMagnesium>,
		<ore:blockThorium>,
		<ore:blockOctine>,
		<ore:blockSyrmorite>
	] as IIngredient[];

	var tfOres = [ <minecraft:iron_ore>,
		<minecraft:gold_ore>,
		<ThermalFoundation:Ore>, #copper
		<ThermalFoundation:Ore:1>, #tin
		<ThermalFoundation:Ore:2>, #silver
		<ThermalFoundation:Ore:3>, #lead
		<ThermalFoundation:Ore:4>, #nickel
		<ThermalFoundation:Ore:5>, #platinum
		<ThermalFoundation:Ore:6>, #mithril
		<ImmersiveEngineering:ore:1>, #aluminium
		<NuclearCraft:blockOre:4>, #uranium
		<Mekanism:OreBlock>, #osmium
		<factorization:DarkIronOre>,
		<NuclearCraft:blockOre:8>, #boron
		<NuclearCraft:blockOre:7>, #lithium
		<NuclearCraft:blockOre:9>, #magnesium
		<NuclearCraft:blockOre:5>, #thorium
		<thebetweenlands:octineOre>,
		<thebetweenlands:syrmoriteOre>
	] as IItemStack[];

	var tfNuggets = [ <ThermalFoundation:material:8>, #iron
		<minecraft:gold_nugget>,
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ThermalFoundation:material:98>, #silver
		<ThermalFoundation:material:99>, #lead
		<ThermalFoundation:material:100>, #nickel
		<ThermalFoundation:material:101>, #platinum
		<ThermalFoundation:material:102>, #mithril
		<ImmersiveEngineering:metal:23>, #aluminium
		<IC2:itemUran235small>, #uranium
		<aobd:nuggetOsmium>,
		<aobd:nuggetFzDarkIron>,
		<aobd:nuggetBoron>,
		<aobd:nuggetLithium>,
		<aobd:nuggetMagnesium>,
		<aobd:nuggetThorium>,
		<aobd:nuggetOctine>,
		<aobd:nuggetSyrmorite>
	] as IItemStack[];

	var ic2Ingots = [ <minecraft:iron_ingot>,
		<minecraft:gold_ingot>,
		<IC2:itemIngot>, #copper
		<IC2:itemIngot:1>, #tin
		<IC2:itemIngot:6>, #silver
		<IC2:itemIngot:5>, #lead
		<ThermalFoundation:material:68>, #nickel
		<ThermalFoundation:material:69>, #platinum
		<ThermalFoundation:material:70>, #mithril
		<ImmersiveEngineering:metal:1>, #aluminium
		<NuclearCraft:material:4>, #uranium
		<Mekanism:Ingot:1>, #osmium
		<factorization:dark_iron_ingot>, #dark iron
		<NuclearCraft:material:43>, #boron
		<NuclearCraft:material:42>, #lithium
		<NuclearCraft:material:50>, #magnesium
		<NuclearCraft:material:5>, #thorium
		<thebetweenlands:unknownGeneric:15>, #octine
		<thebetweenlands:unknownGeneric:14> #syrmorite
	] as IItemStack[];

	var ieIngots = [ <minecraft:iron_ingot>,
		<minecraft:gold_ingot>,
		<ImmersiveEngineering:metal>, #copper
		<ThermalFoundation:material:65>, #tin
		<ImmersiveEngineering:metal:3>, #silver
		<ImmersiveEngineering:metal:2>, #lead
		<ImmersiveEngineering:metal:4>, #nickel
		<ThermalFoundation:material:69>, #platinum
		<ThermalFoundation:material:70>, #mithril
		<ImmersiveEngineering:metal:1>, #aluminium
		<NuclearCraft:material:4>, #uranium
		<Mekanism:Ingot:1>, #osmium
		<factorization:dark_iron_ingot>, #dark iron
		<NuclearCraft:material:43>, #boron
		<NuclearCraft:material:42>, #lithium
		<NuclearCraft:material:50>, #magnesium
		<NuclearCraft:material:5>, #thorium
		<thebetweenlands:unknownGeneric:15>, #octine
		<thebetweenlands:unknownGeneric:14> #syrmorite
	] as IItemStack[];
	
	var tfBlocks = [ <minecraft:iron_block>,
		<minecraft:gold_block>,
		<ThermalFoundation:Storage>, #copper
		<ThermalFoundation:Storage:1>, #tin
		<ThermalFoundation:Storage:2>, #silver
		<ThermalFoundation:Storage:3>, #lead
		<ThermalFoundation:Storage:4>, #nickel
		<ThermalFoundation:Storage:5>, #platinum
		<ThermalFoundation:Storage:6>, #mithril
		<ImmersiveEngineering:storage:1>, #aluminium
		<NuclearCraft:blockBlock:4>, #uranium
		<Mekanism:BasicBlock>, #osmium
		<factorization:ResourceBlock:3>, #dark iron
		<NuclearCraft:blockBlock:9>, #boron
		<NuclearCraft:blockBlock:8>, #lithium
		<NuclearCraft:blockBlock:10>, #magnesium
		<NuclearCraft:blockBlock:5>, #thorium
		<thebetweenlands:octineBlock>,
		<thebetweenlands:syrmoriteBlock>
	] as IItemStack[];

	var ic2Dusts = [ <IC2:itemDust:5>, #iron
		<IC2:itemDust:4>, #gold
		<IC2:itemDust:3>, #copper
		<IC2:itemDust:7>, #tin
		<IC2:itemDust:6>, #silver
		<IC2:itemDust:10>, #lead
		<ImmersiveEngineering:metal:14>, #nickel
		<ThermalFoundation:material:37>, #platinum
		<ThermalFoundation:material:38>, #mithril
		<ImmersiveEngineering:metal:11>, #aluminium
		<NuclearCraft:material:19>, #uranium
		<Mekanism:Dust:2>, #osmium
		<aobd:dustFzDarkIron>,
		<NuclearCraft:material:45>, #boron
		<IC2:itemDust:14>, #lithium
		<NuclearCraft:material:51>, #magnesium
		<NuclearCraft:material:20>, #thorium
		<aobd:dustOctine>,
		<aobd:dustSyrmorite>
	] as IItemStack[];

	#used for removal of IE ore + hammer -> dust recipes
	var ieDusts = [ <ImmersiveEngineering:metal:8>, #iron
		<ImmersiveEngineering:metal:9>, #gold
		<ImmersiveEngineering:metal:10>, #copper
		<ThermalFoundation:material:33>, #tin
		<ImmersiveEngineering:metal:13>, #silver
		<ImmersiveEngineering:metal:12>, #lead
		<ImmersiveEngineering:metal:14>, #nickel
		<ThermalFoundation:material:37>, #platinum
		<ThermalFoundation:material:38>, #mithril
		<ImmersiveEngineering:metal:11>, #aluminium
		<NuclearCraft:material:19>, #uranium
		<Mekanism:Dust:2>, #osmium
		<aobd:dustFzDarkIron>, #dark iron
		<NuclearCraft:material:45>, #boron
		<IC2:itemDust:14>, #lithium
		<NuclearCraft:material:51>, #magnesium
		<NuclearCraft:material:20>, #thorium
		<aobd:dustOctine>,
		<aobd:dustSyrmorite>
	] as IItemStack[];

	var ic2TinyDusts = [ <IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall:2>, #gold
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall:4>, #silver
		<IC2:itemDustSmall:5>, #lead
		<aobd:dustTinyNickel>,
		<aobd:dustTinyPlatinum>,
		<aobd:dustTinyMithril>,
		<aobd:dustTinyAluminum>, #aluminium
		<aobd:dustTinyUranium>,
		<aobd:dustTinyOsmium>,
		<aobd:dustTinyFzDarkIron>,
		<aobd:dustTinyBoron>,
		<IC2:itemDustSmall:7>, #lithium
		<aobd:dustTinyMagnesium>,
		<aobd:dustTinyThorium>,
		<aobd:dustTinyOctine>,
		<aobd:dustTinySyrmorite>
	] as IItemStack[];

	var ic2Crushed = [ <IC2:itemCrushedOre>, #iron
		<IC2:itemCrushedOre:2>, #gold
		<IC2:itemCrushedOre:1>, #copper
		<IC2:itemCrushedOre:3>, #tin
		<IC2:itemCrushedOre:5>, #silver
		<IC2:itemCrushedOre:6>, #lead
		<aobd:crushedNickel>, #nickel
		<aobd:crushedPlatinum>, #platinum
		<aobd:crushedMithril>, #mithril
		<aobd:crushedAluminum>, #aluminium
		<IC2:itemCrushedOre:4>, #uranium
		<aobd:crushedOsmium>, #osmium
		<aobd:crushedFzDarkIron>, #dark iron
		<aobd:crushedBoron>, #boron
		<aobd:crushedLithium>, #lithium
		<aobd:crushedMagnesium>, #magnesium
		<aobd:crushedThorium>,
		<aobd:crushedOctine>,
		<aobd:crushedSyrmorite>
	] as IItemStack[];

	var ic2CrushedPurified = [ <IC2:itemPurifiedCrushedOre>, #iron
		<IC2:itemPurifiedCrushedOre:2>, #gold
		<IC2:itemPurifiedCrushedOre:1>, #copper
		<IC2:itemPurifiedCrushedOre:3>, #tin
		<IC2:itemPurifiedCrushedOre:5>, #silver
		<IC2:itemPurifiedCrushedOre:6>, #lead
		<aobd:crushedPurifiedNickel>, #nickel
		<aobd:crushedPurifiedPlatinum>, #platinum
		<aobd:crushedPurifiedMithril>, #mithril
		<aobd:crushedPurifiedAluminum>, #aluminium
		<IC2:itemPurifiedCrushedOre:4>, #uranium
		<aobd:crushedPurifiedOsmium>, #osmium
		<aobd:crushedPurifiedFzDarkIron>, #dark iron
		<aobd:crushedPurifiedBoron>, #boron
		<aobd:crushedPurifiedLithium>, #lithium
		<aobd:crushedPurifiedMagnesium>, #magnesium
		<aobd:crushedPurifiedThorium>,
		<aobd:crushedPurifiedOctine>,
		<aobd:crushedPurifiedSyrmorite>
	] as IItemStack[];

	var mkClumps = [ <Mekanism:Clump>, #iron
		<Mekanism:Clump:1>, #gold
		<Mekanism:Clump:3>, #copper
		<Mekanism:Clump:4>, #tin
		<Mekanism:Clump:5>, #silver
		<Mekanism:Clump:6>, #lead
		<aobd:clumpNickel>, #nickel
		<aobd:clumpPlatinum>, #platinum
		<aobd:clumpMithril>, #mithril
		<aobd:clumpAluminum>, #aluminium
		<aobd:clumpUranium>, #uranium
		<Mekanism:Clump:2>, #osmium
		<aobd:clumpFzDarkIron>, #dark iron
		<aobd:clumpBoron>, #boron
		<aobd:clumpLithium>, #lithium
		<aobd:clumpMagnesium>, #magnesium
		<aobd:clumpThorium>,
		<aobd:clumpOctine>,
		<aobd:clumpSyrmorite>
	] as IItemStack[];

	var mkCrystals = [<Mekanism:Crystal>, #iron
		<Mekanism:Crystal:1>, #gold
		<Mekanism:Crystal:3>, #copper
		<Mekanism:Crystal:4>, #tin
		<Mekanism:Crystal:5>, #silver
		<Mekanism:Crystal:6>, #lead
		<aobd:crystalNickel>, #nickel
		<aobd:crystalPlatinum>, #platinum
		<aobd:crystalMithril>, #mithril
		<aobd:crystalAluminum>, #aluminium
		<aobd:crystalUranium>, #uranium
		<Mekanism:Crystal:2>, #osmium
		<aobd:crystalFzDarkIron>, #dark iron
		<aobd:crystalBoron>, #boron
		<aobd:crystalLithium>, #lithium
		<aobd:crystalMagnesium>, #magnesium
		<aobd:crystalThorium>,
		<aobd:crystalOctine>,
		<aobd:crystalSyrmorite>
	] as IItemStack[];

	var mkShards = [ <Mekanism:Shard>, #iron
		<Mekanism:Shard:1>, #gold
		<Mekanism:Shard:3>, #copper
		<Mekanism:Shard:4>, #tin
		<Mekanism:Shard:5>, #silver
		<Mekanism:Shard:6>, #lead
		<aobd:shardNickel>, #nickel
		<aobd:shardPlatinum>, #platinum
		<aobd:shardMithril>, #mithril
		<aobd:shardAluminum>, #aluminium
		<aobd:shardUranium>, #uranium
		<Mekanism:Shard:2>, #osmium
		<aobd:shardFzDarkIron>, #dark iron
		<aobd:shardBoron>, #boron
		<aobd:shardLithium>, #lithium
		<aobd:shardMagnesium>, #magnesium
		<aobd:shardThorium>,
		<aobd:shardOctine>,
		<aobd:shardSyrmorite>
	] as IItemStack[];

	var mkDirtyDusts = [ <Mekanism:DirtyDust>, #iron
		<Mekanism:DirtyDust:1>, #gold
		<Mekanism:DirtyDust:3>, #copper
		<Mekanism:DirtyDust:4>, #tin
		<Mekanism:DirtyDust:5>, #silver
		<Mekanism:DirtyDust:6>, #lead
		<aobd:dustDirtyNickel>, #nickel
		<aobd:dustDirtyPlatinum>, #platinum
		<aobd:dustDirtyMithril>, #mithril
		<aobd:dustDirtyAluminum>, #aluminium
		<aobd:dustDirtyUranium>, #uranium
		<Mekanism:DirtyDust:2>, #osmium
		<aobd:dustDirtyFzDarkIron>, #dark iron
		<aobd:dustDirtyBoron>, #boron
		<aobd:dustDirtyLithium>, #lithium
		<aobd:dustDirtyMagnesium>, #magnesium
		<aobd:dustDirtyThorium>,
		<aobd:dustDirtyOctine>,
		<aobd:dustDirtySyrmorite>
	] as IItemStack[];

	var mkSlurries = [ <gas:iron>,
		<gas:gold>,
		<gas:copper>,
		<gas:tin>,
		<gas:silver>,
		<gas:lead>,
		<gas:Nickel>,
		<gas:Platinum>,
		<gas:Mithril>,
		<gas:Aluminum>,
		<gas:Uranium>,
		<gas:osmium>,
		<gas:FzDarkIron>,
		<gas:Boron>,
		<gas:Lithium>,
		<gas:Magnesium>,
		<gas:Thorium>,
		<gas:Octine>,
		<gas:Syrmorite>
	] as IGasStack[];

	var mkCleanSlurries = [ <gas:cleanIron>,
		<gas:cleanGold>,
		<gas:cleanCopper>,
		<gas:cleanTin>,
		<gas:cleanSilver>,
		<gas:cleanLead>,
		<gas:cleanNickel>,
		<gas:cleanPlatinum>,
		<gas:cleanMithril>,
		<gas:cleanAluminum>,
		<gas:cleanUranium>,
		<gas:cleanOsmium>,
		<gas:cleanFzDarkIron>,
		<gas:cleanBoron>,
		<gas:cleanLithium>,
		<gas:cleanMagnesium>,
		<gas:cleanThorium>,
		<gas:cleanOctine>,
		<gas:cleanSyrmorite>
	] as IGasStack[];

	var tfISmelterRichChances = [ 5, #iron
		20, #gold
		5, #copper
		5, #tin
		5, #silver
		5, #lead
		15, #nickel
		30, #platinum
		15, #mithril
		5, #aluminium
		15, #uranium
		15, #osmium
		5, #dark iron
		5, #boron
		5, #lithium
		5, #magnesium
		5, #thorium
		10, #octine
		10, #syrmorite
	] as int[];

	var tfISmelterSecondaries = [ <ThermalFoundation:material:100>, #iron -> nickel
		<ThermalExpansion:material:515>, #gold -> rich slag
		<minecraft:gold_nugget>, #copper -> gold
		<ThermalExpansion:material:8>, #tin -> iron
		<ThermalFoundation:material:99>, #silver -> lead
		<ThermalFoundation:material:98>, #lead -> silver
		<ThermalFoundation:material:101>, #nickel -> platinum
		<ThermalExpansion:material:515>, #platinum -> rich slag
		<ThermalExpansion:material:515>, #mithril -> rich slag
		<ImmersiveEngineering:metal:23>, #aluminium -> aluminium
		<IC2:itemUran235small>, #uranium -> uranium
		<aobd:nuggetOsmium>, #osmium -> osmium
		<ThermalFoundation:material:98>, #dark iron -> silver
		<aobd:nuggetBoron>, #boron -> boron
		<aobd:nuggetLithium>, #lithium -> lithium
		<aobd:nuggetMagnesium>, #magnesium -> magnesium
		<aobd:nuggetThorium>, #thorium -> thorium
		<aobd:nuggetSyrmorite>, #octine -> syrmorite
		<aobd:nuggetOctine> #syrmorite -> octine
	] as IItemStack[];
	
	var tfISmelterSecChances = [ 100, #iron
		75, #gold
		100, #copper
		100, #tin
		100, #silver
		100, #lead
		100, #nickel
		75, #platinum
		75, #mithril
		100, #aluminium
		100, #uranium
		100, #osmium
		100, #dark iron
		100, #boron
		100, #lithium
		100, #magnesium
		100, #thorium
		75, #octine
		75 #syrmorite
	] as int[];
	
	var tfPulvSecondaries = [ <aobd:dustTinyNickel>, #iron -> nickel
		<ThermalFoundation:material:20>, #gold -> cinnabar
		<IC2:itemDustSmall:2>, #copper -> gold
		<IC2:itemDustSmall>, #tin -> iron
		<IC2:itemDustSmall:5>, #silver -> lead
		<IC2:itemDustSmall:4>, #lead -> silver
		<aobd:dustTinyPlatinum>, #nickel -> platinum
		<ThermalFoundation:material:20>, #platinum -> cinnabar
		<ThermalFoundation:material:20>, #mithril -> cinnabar
		<aobd:dustTinyAluminum>, #aluminium -> aluminium
		<aobd:dustTinyUranium>, #uranium -> uranium
		<aobd:dustTinyOsmium>, #osmium -> osmium
		<IC2:itemDustSmall:4>, #dark iron -> silver
		<aobd:dustTinyBoron>, #boron -> boron
		<IC2:itemDustSmall:7>, #lithium -> lithium
		<aobd:dustTinyMagnesium>, #magnesium -> magnesium
		<aobd:dustTinyThorium>, #thorium -> thorium
		<aobd:dustTinySyrmorite>, #octine -> syrmorite
		<aobd:dustTinyOctine> #syrmorite -> octine
	] as IItemStack[];
	
	var tfPulvSecondaryChances = [ 10, #iron
		5, #gold
		10, #copper
		10, #tin
		10, #silver
		10, #lead
		10, #nickel
		10, #platinum
		5, #mithril
		10, #aluminium
		10, #uranium
		10, #osmium
		10, #dark iron
		10, #boron
		10, #lithium
		10, #magnesium
		10, #thorium
		10, #octine
		10 #syrmorite
	] as int[];
	
	var ieCrusherSecondaries = [ <aobd:dustTinyNickel>, #iron -> ferrous
		<IC2:itemDustSmall:2>, #gold -> gold
		<minecraft:cobblestone>, #copper -> stone
		<IC2:itemDustSmall>, #tin -> iron
		<IC2:itemDustSmall:5>, #silver -> lead
		<IC2:itemDustSmall:4>, #lead -> silver
		<aobd:dustTinyPlatinum>, #nickel -> platinum
		<aobd:dustTinyPlatinum>, #platinum
		<IC2:itemDustSmall:4>, #mithril -> silver
		<aobd:dustTinyAluminum>, #aluminium
		<IC2:itemDustSmall:5>, #uranium -> lead
		<aobd:dustTinyOsmium>, #osmium
		<IC2:itemDustSmall>, #dark iron -> iron
		<aobd:dustTinyBoron>, #boron
		<IC2:itemDustSmall:7>, #lithium
		<aobd:dustTinyMagnesium>, #magnesium
		<aobd:dustTinyThorium>, #thorium
		<aobd:dustTinySyrmorite>, #octine -> syrmorite
		<aobd:dustTinyOctine> #syrmorite -> octine
	] as IItemStack[];
	
	var ic2ThermCentSecondaries = [ <aobd:dustTinyNickel>, #iron -> ferrous
		<IC2:itemDustSmall:4>, #gold -> silver
		<IC2:itemDustSmall:3>, #copper -> tin
		<IC2:itemDustSmall:1>, #tin -> copper
		<IC2:itemDustSmall:5>, #silver -> lead
		<IC2:itemDustSmall:4>, #lead -> silver
		<aobd:dustTinyPlatinum>, #ferrous -> shiny
		<aobd:dustTinyPlatinum>, #platinum
		<aobd:dustTinyMithril>, #mithril
		<IC2:itemDustSmall:3>, #aluminium -> tin
		<aobd:dustTinyUranium>, #uranium
		<aobd:dustTinyOsmium>, #osmium
		<aobd:dustTinyFzDarkIron>, #dark iron
		<aobd:dustTinyBoron>, #boron
		<IC2:itemDustSmall:7>, #lithium
		<aobd:dustTinyMagnesium>, #magnesium
		<aobd:dustTinyThorium>, #thorium
		<aobd:dustTinySyrmorite>, #octine -> syrmorite
		<aobd:dustTinyOctine> #syrmorite -> octine
	] as IItemStack[];

	var tcClusters = [ <Thaumcraft:ItemNugget:16>, #Iron
		<Thaumcraft:ItemNugget:31>, #gold
		<Thaumcraft:ItemNugget:17>, #copper
		<Thaumcraft:ItemNugget:18>, #tin
		<Thaumcraft:ItemNugget:19>, #silver
		<Thaumcraft:ItemNugget:20>, #lead
		<WitchingGadgets:item.WG_Cluster:3>, #nickel
		<WitchingGadgets:item.WG_Cluster:7>, #platinum
		<WitchingGadgets:item.WG_Cluster:24>, #mithril
		<WitchingGadgets:item.WG_Cluster>, #aluminium
		<aobd:clusterUranium>, #uranium
		<aobd:clusterOsmium>, #osmium
		<aobd:clusterFzDarkIron>, #dark iron
		<aobd:clusterBoron>, #boron
		<aobd:clusterLithium>, #lithium
		<aobd:clusterMagnesium>, #magnesium
		<aobd:clusterThorium>,
		<aobd:clusterOctine>,
		<aobd:clusterSyrmorite>
	] as IItemStack[];

	var fzCrystallines = [ <factorization:ore/crystal>, #Iron
		<factorization:ore/crystal:1>, #gold
		<factorization:ore/crystal:4>, #copper
		<factorization:ore/crystal:3>, #tin
		<factorization:ore/crystal:5>, #silver
		<factorization:ore/crystal:2>, #lead
		<aobd:crystallineNickel>, #nickel
		<aobd:crystallinePlatinum>, #platinum
		<aobd:crystallineMithril>, #mithril
		<aobd:crystallineAluminum>, #aluminium
		<aobd:crystallineUranium>, #uranium
		<aobd:crystallineOsmium>, #osmium
		<factorization:ore/crystal:10>, #dark iron
		<aobd:crystallineBoron>, #boron
		<aobd:crystallineLithium>, #lithium
		<aobd:crystallineMagnesium>, #magnesium
		<aobd:crystallineThorium>,
		<aobd:crystallineOctine>,
		<aobd:crystallineSyrmorite>
	] as IItemStack[];

	var fzCleanGravels = [ <factorization:ore/clean>, #Iron
		<factorization:ore/clean:1>, #gold
		<factorization:ore/clean:4>, #copper
		<factorization:ore/clean:3>, #tin
		<factorization:ore/clean:6>, #silver
		<factorization:ore/clean:2>, #lead
		<aobd:cleanGravelNickel>, #nickel
		<aobd:cleanGravelPlatinum>, #platinum
		<aobd:cleanGravelMithril>, #mithril
		<aobd:cleanGravelAluminum>, #aluminium
		<aobd:cleanGravelUranium>, #uranium
		<aobd:cleanGravelOsmium>, #osmium
		<factorization:ore/clean:10>, #dark iron
		<aobd:cleanGravelBoron>, #boron
		<aobd:cleanGravelLithium>, #lithium
		<aobd:cleanGravelMagnesium>, #magnesium
		<aobd:cleanGravelThorium>,
		<aobd:cleanGravelOctine>,
		<aobd:cleanGravelSyrmorite>
	] as IItemStack[];

	var fzReducedChunks = [ <factorization:ore/reduced>, #Iron
		<factorization:ore/reduced:1>, #gold
		<factorization:ore/reduced:4>, #copper
		<factorization:ore/reduced:3>, #tin
		<factorization:ore/reduced:5>, #silver
		<factorization:ore/reduced:2>, #lead
		<aobd:reducedNickel>, #nickel
		<aobd:reducedPlatinum>, #platinum
		<aobd:reducedMithril>, #mithril
		<aobd:reducedAluminum>, #aluminium
		<aobd:reducedUranium>, #uranium
		<aobd:reducedOsmium>, #osmium
		<factorization:ore/reduced:10>, #dark iron
		<aobd:reducedBoron>, #boron
		<aobd:reducedLithium>, #lithium
		<aobd:reducedMagnesium>, #magnesium
		<aobd:reducedThorium>,
		<aobd:reducedOctine>,
		<aobd:reducedSyrmorite>
	] as IItemStack[];

	var fzDirtyGravels = [ <factorization:ore/gravel>, #Iron
		<factorization:ore/gravel:1>, #gold
		<factorization:ore/gravel:4>, #copper
		<factorization:ore/gravel:3>, #tin
		<factorization:ore/gravel:6>, #silver
		<factorization:ore/gravel:2>, #lead
		<aobd:dirtyGravelNickel>, #nickel
		<aobd:dirtyGravelPlatinum>, #platinum
		<aobd:dirtyGravelMithril>, #mithril
		<aobd:dirtyGravelAluminum>, #aluminium
		<aobd:dirtyGravelUranium>, #uranium
		<aobd:dirtyGravelOsmium>, #osmium
		<factorization:ore/gravel:10>, #dark iron
		<aobd:dirtyGravelBoron>, #boron
		<aobd:dirtyGravelLithium>, #lithium
		<aobd:dirtyGravelMagnesium>, #magnesium
		<aobd:dirtyGravelThorium>,
		<aobd:dirtyGravelOctine>,
		<aobd:dirtyGravelSyrmorite>
	] as IItemStack[];

	var tmPurified1 = [ <technom:pureIron>,
		<technom:pureGold>,
		<technom:pureCopper>,
		<technom:pureTin>,
		<technom:pureSilver>,
		<technom:pureLead>,
		<technom:pureNickel>,
		<technom:purePlatinum>,
		<technom:pureMithril>,
		<technom:pureAluminum>,
		<technom:pureUranium>,
		<technom:pureOsmium>,
		<technom:pureFzDarkIron>,
		<technom:pureBoron>,
		<technom:pureLithium>,
		<technom:pureMagnesium>,
		<technom:pureThorium>,
		<technom:pureOctine>,
		<technom:pureSyrmorite>
	] as IItemStack[];
	
	var tmPurified2 = [ <technom:pureIron:1>,
		<technom:pureGold:1>,
		<technom:pureCopper:1>,
		<technom:pureTin:1>,
		<technom:pureSilver:1>,
		<technom:pureLead:1>,
		<technom:pureNickel:1>,
		<technom:purePlatinum:1>,
		<technom:pureMithril:1>,
		<technom:pureAluminum:1>,
		<technom:pureUranium:1>,
		<technom:pureOsmium:1>,
		<technom:pureFzDarkIron:1>,
		<technom:pureBoron:1>,
		<technom:pureLithium:1>,
		<technom:pureMagnesium:1>,
		<technom:pureThorium:1>,
		<technom:pureOctine:1>,
		<technom:pureSyrmorite:1>
	] as IItemStack[];
	
	var tmPurified3 = [ <technom:pureIron:2>,
		<technom:pureGold:2>,
		<technom:pureCopper:2>,
		<technom:pureTin:2>,
		<technom:pureSilver:2>,
		<technom:pureLead:2>,
		<technom:pureNickel:2>,
		<technom:purePlatinum:2>,
		<technom:pureMithril:2>,
		<technom:pureAluminum:2>,
		<technom:pureUranium:2>,
		<technom:pureOsmium:2>,
		<technom:pureFzDarkIron:2>,
		<technom:pureBoron:2>,
		<technom:pureLithium:2>,
		<technom:pureMagnesium:2>,
		<technom:pureThorium:2>,
		<technom:pureOctine:2>,
		<technom:pureSyrmorite:2>
	] as IItemStack[];
	
	var tmPurified4 = [ <technom:pureIron:3>,
		<technom:pureGold:3>,
		<technom:pureCopper:3>,
		<technom:pureTin:3>,
		<technom:pureSilver:3>,
		<technom:pureLead:3>,
		<technom:pureNickel:3>,
		<technom:purePlatinum:3>,
		<technom:pureMithril:3>,
		<technom:pureAluminum:3>,
		<technom:pureUranium:3>,
		<technom:pureOsmium:3>,
		<technom:pureFzDarkIron:3>,
		<technom:pureBoron:3>,
		<technom:pureLithium:3>,
		<technom:pureMagnesium:3>,
		<technom:pureThorium:3>,
		<technom:pureOctine:3>,
		<technom:pureSyrmorite:3>
	] as IItemStack[];
	
	var tmPurified5 = [ <technom:pureIron:4>,
		<technom:pureGold:4>,
		<technom:pureCopper:4>,
		<technom:pureTin:4>,
		<technom:pureSilver:4>,
		<technom:pureLead:4>,
		<technom:pureNickel:4>,
		<technom:purePlatinum:4>,
		<technom:pureMithril:4>,
		<technom:pureAluminum:4>,
		<technom:pureUranium:4>,
		<technom:pureOsmium:4>,
		<technom:pureFzDarkIron:4>,
		<technom:pureBoron:4>,
		<technom:pureLithium:4>,
		<technom:pureMagnesium:4>,
		<technom:pureThorium:4>,
		<technom:pureOctine:4>,
		<technom:pureSyrmorite:4>
	] as IItemStack[];
	
	var tmPurified6 = [ <technom:pureIron:5>,
		<technom:pureGold:5>,
		<technom:pureCopper:5>,
		<technom:pureTin:5>,
		<technom:pureSilver:5>,
		<technom:pureLead:5>,
		<technom:pureNickel:5>,
		<technom:purePlatinum:5>,
		<technom:pureMithril:5>,
		<technom:pureAluminum:5>,
		<technom:pureUranium:5>,
		<technom:pureOsmium:5>,
		<technom:pureFzDarkIron:5>,
		<technom:pureBoron:5>,
		<technom:pureLithium:5>,
		<technom:pureMagnesium:5>,
		<technom:pureThorium:5>,
		<technom:pureOctine:5>,
		<technom:pureSyrmorite:5>
	] as IItemStack[];
	
#Additional lists:
	#used for additional removal of IE ore crusher recipes
	var ieDusts2 = [ <IC2:itemDust:7> #tin
	] as IItemStack[];
	
	#used for FZ slag furnace and Mekanism recipes as input
	var allOres = [ <minecraft:iron_ore>,
		<minecraft:gold_ore>,
		<Forestry:resources:1>,
		<Forestry:resources:2>,
		<GalacticraftCore:tile.gcBlockCore:5>,
		<GalacticraftCore:tile.gcBlockCore:6>,
		<GalacticraftCore:tile.gcBlockCore:7>,
		<GalacticraftCore:tile.moonBlock>,
		<GalacticraftCore:tile.moonBlock:1>,
		<GalacticraftMars:tile.asteroidsBlock:3>,
		<GalacticraftMars:tile.asteroidsBlock:5>,
		<GalacticraftMars:tile.mars>,
		<GalacticraftMars:tile.mars:1>,
		<GalacticraftMars:tile.mars:3>,
		<IC2:blockOreCopper>,
		<IC2:blockOreTin>,
		<IC2:blockOreUran>,
		<IC2:blockOreLead>,
		<ImmersiveEngineering:ore>,
		<ImmersiveEngineering:ore:1>,
		<ImmersiveEngineering:ore:2>,
		<ImmersiveEngineering:ore:3>,
		<ImmersiveEngineering:ore:4>,
		<Mekanism:OreBlock>,
		<Mekanism:OreBlock:1>,
		<Mekanism:OreBlock:2>,
		<NuclearCraft:blockOre>,
		<NuclearCraft:blockOre:1>,
		<NuclearCraft:blockOre:2>,
		<NuclearCraft:blockOre:3>,
		<NuclearCraft:blockOre:4>,
		<NuclearCraft:blockOre:5>,
		<NuclearCraft:blockOre:7>,
		<NuclearCraft:blockOre:8>,
		<NuclearCraft:blockOre:9>,
		<ThermalFoundation:Ore>,
		<ThermalFoundation:Ore:1>,
		<ThermalFoundation:Ore:2>,
		<ThermalFoundation:Ore:3>,
		<ThermalFoundation:Ore:4>,
		<ThermalFoundation:Ore:5>,
		<ThermalFoundation:Ore:6>,
		<factorization:DarkIronOre>,
		<factorization:ResourceBlock>,
		<thebetweenlands:octineOre>,
		<thebetweenlands:syrmoriteOre>
	] as IItemStack[];
	
	#used for FZ slag furnace and Mekanism recipes as output
	var allNuggets = [ <ThermalFoundation:material:8>, #iron
		<minecraft:gold_nugget>, #gold
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ImmersiveEngineering:metal:23>, #aluminium
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ImmersiveEngineering:metal:23>, #aluminium
		<ThermalFoundation:material:8>, #iron
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ThermalFoundation:material:8>, #iron
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<IC2:itemUran235small>, #uranium
		<ThermalFoundation:material:99>, #lead
		<ThermalFoundation:material:96>, #copper
		<ImmersiveEngineering:metal:23>, #aluminium
		<ThermalFoundation:material:99>, #lead
		<ThermalFoundation:material:98>, #silver
		<ThermalFoundation:material:100>, #nickel
		<aobd:nuggetOsmium>, #osmium
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ThermalFoundation:material:99>, #lead
		<ThermalFoundation:material:98>, #silver
		<IC2:itemUran235small>, #uranium
		<aobd:nuggetThorium>, #thorium
		<aobd:nuggetLithium>, #lithium
		<aobd:nuggetBoron>, #boron
		<aobd:nuggetMagnesium>, #magnesium
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ThermalFoundation:material:98>, #silver
		<ThermalFoundation:material:99>, #lead
		<ThermalFoundation:material:100>, #nickel
		<ThermalFoundation:material:101>, #platinum
		<ThermalFoundation:material:102>, #mithril
		<aobd:nuggetFzDarkIron>, #dark iron
		<ThermalFoundation:material:98>, #silver
		<aobd:nuggetOctine>,
		<aobd:nuggetSyrmorite>
	] as IItemStack[];
	
	#used for Mekanism recipes as output
	var allTinyDusts = [ <IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall:2>, #gold
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<aobd:dustTinyAluminum>, #aluminium
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<aobd:dustTinyAluminum>, #aluminium
		<IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<aobd:dustTinyUranium>, #uranium
		<IC2:itemDustSmall:5>, #lead
		<IC2:itemDustSmall:1>, #copper
		<aobd:dustTinyAluminum>, #aluminium
		<IC2:itemDustSmall:5>, #lead
		<IC2:itemDustSmall:4>, #silver
		<aobd:dustTinyNickel>, #nickel
		<aobd:dustTinyOsmium>, #osmium
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall:5>, #lead
		<IC2:itemDustSmall:4>, #silver
		<aobd:dustTinyUranium>, #uranium
		<aobd:dustTinyThorium>, #thorium
		<IC2:itemDustSmall:7>, #lithium
		<aobd:dustTinyBoron>, #boron
		<aobd:dustTinyMagnesium>, #magnesium
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall:4>, #silver
		<IC2:itemDustSmall:5>, #lead
		<aobd:dustTinyNickel>, #nickel
		<aobd:dustTinyPlatinum>, #platinum
		<aobd:dustTinyMithril>, #mithril
		<aobd:dustTinyFzDarkIron>, #dark iron
		<IC2:itemDustSmall:4>, #silver
		<aobd:dustTinyOctine>,
		<aobd:dustTinySyrmorite>
	] as IItemStack[];
	
	#used for Mekanism Crusher Nugget recipes as input
	var allMKCNuggets = [ <minecraft:gold_nugget>, #gold
		<ImmersiveEngineering:metal:21>, #iron
		<ImmersiveEngineering:metal:22>, #copper
		<ImmersiveEngineering:metal:23>, #aluminium
		<ImmersiveEngineering:metal:24>, #lead
		<ImmersiveEngineering:metal:25>, #silver
		<ImmersiveEngineering:metal:26>, #nickel
		<MagicBees:beeNugget>, #iron
		<MagicBees:beeNugget:1>, #copper
		<MagicBees:beeNugget:2>, #tin
		<MagicBees:beeNugget:3>, #silver
		<MagicBees:beeNugget:4>, #lead
		<Thaumcraft:ItemNugget>, #iron
		<Thaumcraft:ItemNugget:1>, #copper
		<Thaumcraft:ItemNugget:2>, #tin
		<Thaumcraft:ItemNugget:3>, #silver
		<Thaumcraft:ItemNugget:4>, #lead
		<ThermalFoundation:material:8>, #iron
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ThermalFoundation:material:98>, #silver
		<ThermalFoundation:material:99>, #lead
		<ThermalFoundation:material:100>, #nickel
		<ThermalFoundation:material:101>, #platinum
		<ThermalFoundation:material:102>, #mithril
		<ThermalFoundation:material:105>, #bronze
		<aobd:nuggetUranium>, #uranium
		<aobd:nuggetFzDarkIron>, #dark iron
		<aobd:nuggetOsmium>, #osmium
		<aobd:nuggetThorium>, #thorium
		<aobd:nuggetLithium>, #lithium
		<aobd:nuggetBoron>, #boron
		<aobd:nuggetMagnesium>, #magnesium
		<IC2:itemUran235small>, #uranium
		<aobd:nuggetOctine>,
		<aobd:nuggetSyrmorite>
	] as IItemStack[];
	
	#used for Mekanism Crusher Nugget recipes as output
	var allMKCTinyDusts = [ <IC2:itemDustSmall:2>, #gold
		<IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall:1>, #copper
		<aobd:dustTinyAluminum>, #aluminium
		<IC2:itemDustSmall:5>, #lead
		<IC2:itemDustSmall:4>, #silver
		<aobd:dustTinyNickel>, #nickel
		<IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall:4>, #silver
		<IC2:itemDustSmall:5>, #lead
		<IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall:4>, #silver
		<IC2:itemDustSmall:5>, #lead
		<IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall:4>, #silver
		<IC2:itemDustSmall:5>, #lead
		<aobd:dustTinyNickel>, #nickel
		<aobd:dustTinyPlatinum>, #platinum
		<aobd:dustTinyMithril>, #mithril
		<IC2:itemDustSmall:8>, #bronze
		<aobd:dustTinyUranium>, #uranium
		<aobd:dustTinyFzDarkIron>, #dark iron
		<aobd:dustTinyOsmium>, #osmium
		<aobd:dustTinyThorium>, #thorium
		<IC2:itemDustSmall:7>, #lithium
		<aobd:dustTinyBoron>, #boron
		<aobd:dustTinyMagnesium>, #magnesium
		<aobd:dustTinyUranium>, #uranium
		<aobd:dustTinyOctine>,
		<aobd:dustTinySyrmorite>
	] as IItemStack[];
	
#Recipe removal
	#ore smelting and pulverizing
		for i, ore in oredictOres {
			furnace.remove(<*>, ore); #Furnace
			recipes.remove(ieDusts[i]); #IE Engineers Hammer
			recipes.removeShapeless(ic2Ingots[i], [<ThermalFoundation:material:512>, ore ]); #Pyrotheum			
			#IC2 macerator can only be overwritten, not removed, done in recipe creation step.			
			Enrichment.removeRecipe(ore); #MK Enrichment chamber			
			Purification.removeRecipe(mkClumps[i], ore, <gas:oxygen>); #MK purification chamber
			Injection.removeRecipe(mkShards[i], ore, <gas:hydrogenchloride>); #MK injection chamber
			#MK dissolution chamber can only be overwritten, not removed, done in recipe creation step.
			IECrusher.removeRecipe(ieDusts[i]); #IE crusher
			RSFurnace.removeRecipe(tfOres[i]); #TE Redstone furnace
			Pulverizer.removeRecipe(tfOres[i]); #TE Pulverizer
			ISmelter.removeRecipe(<minecraft:sand>, tfOres[i]); #TE Induction smelter Sand
			ISmelter.removeRecipe(<ThermalFoundation:material:20>, tfOres[i]); #TE Induction smelter Cinnabar
			ISmelter.removeRecipe(<ThermalFoundation:material:512>, tfOres[i]); #TE Induction smelter Pyrotheum
			ISmelter.removeRecipe(<ThermalExpansion:material:515>, tfOres[i]); #TE Induction smelter Rich Slag
			ArcFurnace.removeRecipe(ieIngots[i]); #IE Arc Furnace
			
			#ore crafting
			Combiner.removeRecipe(ore);
		}
		for dust in ieDusts2 {
			IECrusher.removeRecipe(dust); #IE crusher
		}
		for ore in allOres {
			SlagFurnace.removeRecipe(ore); #Fz Slag Furnace
		}
		recipes.remove(<NuclearCraft:crusherIdle>); #NC Crusher
		recipes.remove(<NuclearCraft:electricCrusherIdle>); #NC Electric crusher
		recipes.remove(<NuclearCraft:factoryIdle>); #NC ManuFactory
		#IC2 Blast Furnace and EIO Sagmill recipes are done in the configs

	#tc clusters
		for i, cluster in tcClusters {
			furnace.remove(<*>, cluster);
			InfernalBlastfurnace.removeRecipe(ic2Ingots[i]); #WG Infernal Blast Furnace
			RSFurnace.removeRecipe(cluster); #TE Redstone furnace
			Pulverizer.removeRecipe(cluster); #TE Pulverizer
		}
	
	#fz dirty gravel
		for gravel in fzDirtyGravels {
			furnace.remove(<*>, gravel);
			SlagFurnace.removeRecipe(gravel); #Fz Slag Furnace
			RSFurnace.removeRecipe(gravel); #TE Redstone furnace
		}
	
	#fz clean gravel
		for gravel in fzCleanGravels {
			furnace.remove(<*>, gravel);
			RSFurnace.removeRecipe(gravel); #TE Redstone furnace
			SlagFurnace.removeRecipe(gravel); #silver
		}
	
	#fz reduced chunks
		for chunk in fzReducedChunks {
			furnace.remove(<*>, chunk);
			RSFurnace.removeRecipe(chunk); #TE Redstone furnace
		}
	
	#fz crystals
		for crystal in fzCrystallines {
			FZCrystallizer.removeRecipe(crystal);		
			furnace.remove(<*>, crystal);
			RSFurnace.removeRecipe(crystal); #TE Redstone furnace
		}
		
	#ic2 crushed
		for crushed in ic2Crushed {
			furnace.remove(<*>, crushed);
			RSFurnace.removeRecipe(crushed); #TE Redstone furnace
		}
	
	#ic2 purified
		for crushed in ic2CrushedPurified {
			furnace.remove(<*>, crushed);
			RSFurnace.removeRecipe(crushed); #TE Redstone furnace
		}

	#tm purified 1
		for purified in tmPurified1 {
			furnace.remove(<*>, purified);
			RSFurnace.removeRecipe(purified); #TE Redstone furnace
		}
		
	#tm purified 2
		for purified in tmPurified2 {
			furnace.remove(<*>, purified);
			#RSFurnace.removeRecipe(purified); #TE Redstone furnace
		}
		
	#tm purified 3
		for purified in tmPurified3 {
			furnace.remove(<*>, purified);
			RSFurnace.removeRecipe(purified); #TE Redstone furnace
		}
		
	#tm purified 4
		for purified in tmPurified4 {
			furnace.remove(<*>, purified);
			RSFurnace.removeRecipe(purified); #TE Redstone furnace
		}
		
	#tm purified 5
		for purified in tmPurified5 {
			furnace.remove(<*>, purified);
			RSFurnace.removeRecipe(purified); #TE Redstone furnace
		}
		
	#tm purified 6
		for purified in tmPurified6 {
			furnace.remove(<*>, purified);
			RSFurnace.removeRecipe(purified); #TE Redstone furnace
		}



#Recipe creation
	#ores (1)
		for i, input in oredictOres {
			ManaInfusion.addAlchemy(ic2Crushed[i] * 2, tfOres[i], 1000); #Botania alchemy
			Macerator.addRecipe(ic2Crushed[i], input); #IC2 macerator can only be overwritten, not removed.
			Dissolution.addRecipe(tfOres[i], mkSlurries[i] * 100); #MK dissolution chamber
			
			furnace.addRecipe(tfNuggets[i], input, 0.5); #Furnace (1x output)
			recipes.addShapeless(tfNuggets[i] * 2, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, tfOres[i], tfNuggets[i] * 2); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, tfOres[i], tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, tfOres[i], tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i], input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 2, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, tfOres[i], tfNuggets[i] * 3, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, tfOres[i], tfNuggets[i] * 3, tfISmelterSecondaries[i], tfISmelterSecChances[i]); #TE Induction smelter Cinnabar (3x+ output)
			
			recipes.addShapeless(ic2TinyDusts[i], [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			IECrusher.addRecipe(ic2TinyDusts[i] * 2, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
			Pulverizer.addRecipe(1000, tfOres[i], ic2TinyDusts[i] * 2, tfPulvSecondaries[i], tfPulvSecondaryChances[i]); #TE Pulverizer (2x+ output)
			
			#ore crafting
			Combiner.addRecipe(tfBlocks[i] * 3, tfOres[i]);
			recipes.addShapeless(tfOres[i], 
				[oreDictBlocks[i], oreDictBlocks[i], oreDictBlocks[i], 
				oreDictIngots[i], oreDictIngots[i], oreDictIngots[i], 
				oreDictIngots[i], oreDictIngots[i], oreDictIngots[i]]);
			}
		#IC2 Blast Furnace and EIO Sagmill recipes are done in the configs
		for i, input in allOres {
			SlagFurnace.addRecipe(input, allNuggets[i], 1.5, <minecraft:stone>, 0.4); #FZ Slag Furnace (1,5x output)
			
			MKCrusher.addRecipe(input, allTinyDusts[i] * 2); #MK Crusher (2x output)
			
			Enrichment.addRecipe(input, allTinyDusts[i] * 2); #MK enrichment chamber (2x output)
			Purification.addRecipe(input, <gas:oxygen>, allNuggets[i] * 3); #MK purification chamber (3x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, allNuggets[i] * 4); #MK injection chamber (4x output)
		}

	#dusts as input
		for i, input in oredictDusts {
			recipes.addShapeless(ic2TinyDusts[i] * 9, [input]);	

			recipes.addShapeless(ic2Ingots[i], [<ThermalFoundation:material:512>, input ]); #Pyrotheum
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, ic2Dusts[i], ic2Ingots[i], <ThermalExpansion:material:514> , 100 ); #TE Induction smelter Pyrotheum
			InfernalBlastfurnace.addRecipe(ic2Ingots[i], input, 50, null, false); #WG Infernal Blast Furnace
		}
		
	#tiny dusts as input
		for i, input in ic2TinyDusts {
			recipes.addShapeless(ic2Dusts[i], 
				[input, input, input, 
				input, input, input, 
				input, input, input]);
			
			furnace.addRecipe(tfNuggets[i], input); #Furnace
			recipes.addShapeless(tfNuggets[i], [<ThermalFoundation:material:512>, input ]); #Pyrotheum
			RSFurnace.addRecipe(800, ic2TinyDusts[i], tfNuggets[i]); #TE Redstone furnace
			ISmelter.addRecipe(1600, <minecraft:sand>, ic2TinyDusts[i], tfNuggets[i], <ThermalExpansion:material:514> , 25 ); #TE Induction smelter Sand
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, ic2TinyDusts[i], tfNuggets[i], <ThermalExpansion:material:514> , 100 ); #TE Induction smelter Pyrotheum
			InfernalBlastfurnace.addRecipe(tfNuggets[i], input, 50, null, false); #WG Infernal Blast Furnace
			ArcFurnace.addRecipe(tfNuggets[i], input, <ThermalExpansion:material:514>, 100, 512); #IE Arc Furnace
		}
		
	#blocks as input
		for i, input in oreDictBlocks {
			Lacerator.addRecipe(input, ic2Dusts[i], 9.0); #FZ Lacerator
		}
		
	#ingots as input
		for i, input in oreDictIngots {
			recipes.addShapeless(ic2Dusts[i], [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer
			Macerator.addRecipe(ic2Dusts[i], input); #IC2 macerator
			Lacerator.addRecipe(input, ic2Dusts[i], 1.0); #FZ Lacerator
		}
		
	#nuggets as input
		for i, input in oreDictNuggets {
			recipes.addShaped(ic2Ingots[i], 
				[[input, input, input],
				[input, input, input], 
				[input, input, input]]);
			
			recipes.addShapeless(ic2TinyDusts[i], [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer
			IECrusher.addRecipe(ic2TinyDusts[i], input, 2500); #IE Crusher
			Pulverizer.addRecipe(1000, tfNuggets[i], ic2TinyDusts[i]); #TE Pulverizer
			Lacerator.addRecipe(input, ic2TinyDusts[i], 1.0); #FZ Lacerator
		}
		for i, input in allMKCNuggets {
			MKCrusher.addRecipe(input, allMKCTinyDusts[i]); #MK Crusher
		}

	#tc clusters (2)
		for i, input in tcClusters {
			Lacerator.addRecipe(input, fzDirtyGravels[i], 2.5); #FZ Lacerator
			
			ManaInfusion.addAlchemy(ic2Crushed[i] * 5, input, 1500); #Botania alchemy
			Macerator.addRecipe(ic2Crushed[i] * 2, input); #IC2 macerator
			Dissolution.addRecipe(input, mkSlurries[i] * 300); #MK dissolution chamber
			Purification.addRecipe(input, <gas:oxygen>, mkCrystals[i]); #MK purification chamber
			Injection.addRecipe(input, <gas:hydrogenchloride>, mkShards[i]); #MK injection chamber
			
			furnace.addRecipe(tfNuggets[i] * 2, input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 3.0, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 4, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 4); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] *4, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 2 ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 4, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 6 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 4, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 5, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 6, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 6, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 2); #TE Induction smelter Cinnabar (3x+ output)
			
			recipes.addShapeless(ic2TinyDusts[i] * 3, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			MKCrusher.addRecipe(input, ic2TinyDusts[i] * 4); #MK Crusher (2x output)
			IECrusher.addRecipe(ic2TinyDusts[i] * 4, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
			Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 4, tfPulvSecondaries[i], tfPulvSecondaryChances[i]); #TE Pulverizer (2x+ output)
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 4); #MK enrichment chamber (2x output)
		}
		
	#fz dirty gravel (1)
		for i, input in fzDirtyGravels {
			ManaInfusion.addAlchemy(ic2Crushed[i] * 2, input, 1000); #Botania alchemy
			Macerator.addRecipe(ic2Crushed[i], input); #IC2 macerator can only be overwritten, not removed.
			OreWasher.addRecipe([ic2CrushedPurified[i], ic2TinyDusts[i], <IC2:itemDust:9>], input, 1000); #IC2 Orewasher
			ThermalCentrifuge.addRecipe([ tmPurified1[i], ic2ThermCentSecondaries[i], <IC2:itemDust:9> ], input, 2000); #IC2 Thermal Centrifuge
			Dissolution.addRecipe(input, mkSlurries[i] * 150); #MK dissolution chamber
			
			furnace.addRecipe(tfNuggets[i], input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 1.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 2, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 2); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i], input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 2, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 3, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 3, tfISmelterSecondaries[i], tfISmelterSecChances[i]); #TE Induction smelter Cinnabar (3x+ output)
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 2); #MK enrichment chamber (2x output)
			Purification.addRecipe(input, <gas:oxygen>, tfNuggets[i] * 3); #MK purification chamber (3x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, tfNuggets[i] * 4); #MK injection chamber (4x output)
		}

	#fz clean gravel (1)
		for i, input in fzCleanGravels {
			SlagFurnace.addRecipe(input, fzReducedChunks[i], 0.75, fzReducedChunks[i], 0.75);
			
			ManaInfusion.addAlchemy(ic2Crushed[i] * 2, input, 1000); #Botania alchemy
			Macerator.addRecipe(ic2Crushed[i], input); #IC2 macerator can only be overwritten, not removed.
			Dissolution.addRecipe(input, mkSlurries[i] * 175); #MK dissolution chamber
			
			furnace.addRecipe(tfNuggets[i], input, 0.5); #Furnace (1x output)
			recipes.addShapeless(tfNuggets[i] * 2, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 2); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i], input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 2, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 3, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 3, tfISmelterSecondaries[i], tfISmelterSecChances[i]); #TE Induction smelter Cinnabar (3x+ output)
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 2); #MK enrichment chamber (2x output)
			Purification.addRecipe(input, <gas:oxygen>, tfNuggets[i] * 3); #MK purification chamber (3x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, tfNuggets[i] * 4); #MK injection chamber (4x output)
		}
		
		
	#fz reduced chunks (1)
		for i, input in fzReducedChunks {
			FZCrystallizer.addRecipe(input, fzCrystallines[i], <factorization:acid:1>, 1.2);
			
			ManaInfusion.addAlchemy(ic2Crushed[i] * 2, input, 1000); #Botania alchemy
			Macerator.addRecipe(ic2Crushed[i], input); #IC2 macerator can only be overwritten, not removed.
			Dissolution.addRecipe(input, mkSlurries[i] * 150); #MK dissolution chamber
			
			furnace.addRecipe(tfNuggets[i], input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 1.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 2, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 2); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i], input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 2, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 3, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 3, tfISmelterSecondaries[i], tfISmelterSecChances[i]); #TE Induction smelter Cinnabar (3x+ output)
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 2); #MK enrichment chamber (2x output)
			Purification.addRecipe(input, <gas:oxygen>, tfNuggets[i] * 3); #MK purification chamber (3x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, tfNuggets[i] * 4); #MK injection chamber (4x output)
		}
	
	#fz crystals (1)
		for i, input in fzCrystallines {
			ManaInfusion.addAlchemy(ic2Crushed[i] * 2, input, 750); #Botania alchemy
			
			Macerator.addRecipe(ic2Crushed[i], input); #IC2 macerator can only be overwritten, not removed.
			Dissolution.addRecipe(input, mkSlurries[i] * 175); #MK dissolution chamber
			Purification.addRecipe(input, <gas:oxygen>, mkCrystals[i]); #MK purification chamber
			Injection.addRecipe(input, <gas:hydrogenchloride>, mkShards[i]); #MK injection chamber
		
			furnace.addRecipe(tfNuggets[i], input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 1.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 2, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 2); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i], input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 2, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 3, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 3, tfISmelterSecondaries[i], tfISmelterSecChances[i]); #TE Induction smelter Cinnabar (3x+ output)
			
			recipes.addShapeless(ic2TinyDusts[i], [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			MKCrusher.addRecipe(input, ic2TinyDusts[i] * 2); #MK Crusher (2x output)
			IECrusher.addRecipe(ic2TinyDusts[i] * 2, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
			Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 2, tfPulvSecondaries[i], tfPulvSecondaryChances[i]); #TE Pulverizer (2x+ output)
			Lacerator.addRecipe(input, ic2TinyDusts[i], 3.0); #FZ Lacerator (3x output)
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 2); #MK enrichment chamber (2x output)
		}

	#ic2 crushed (1)
		for i, input in ic2Crushed {
			ThermalCentrifuge.addRecipe([ tmPurified1[i], ic2ThermCentSecondaries[i], <IC2:itemDust:9> ], input, 2000); #thermal centrifuge in configs?
			Dissolution.addRecipe(input, mkSlurries[i] * 150); #MK dissolution chamber
			
			furnace.addRecipe(tfNuggets[i], input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 1.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 2, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 2); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i], input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 2, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 3, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 3, tfISmelterSecondaries[i], tfISmelterSecChances[i]); #TE Induction smelter Cinnabar (3x+ output)
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 2); #MK enrichment chamber (2x output)
			Purification.addRecipe(input, <gas:oxygen>, tfNuggets[i] * 3); #MK purification chamber (3x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, tfNuggets[i] * 4); #MK injection chamber (4x output)
		}
	
	#ic2 purified (1)
		for i, input in ic2CrushedPurified {
			ThermalCentrifuge.addRecipe([ tmPurified1[i].withTag({Thaumcraft: 1}), ic2ThermCentSecondaries[i], <IC2:itemDust:9> ], input, 1000); #thermal centrifuge in configs -> into technomancy
			
			furnace.addRecipe(tfNuggets[i], input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 1.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 2, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 2); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i], input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 2, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 3, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 3, tfISmelterSecondaries[i], tfISmelterSecChances[i]); #TE Induction smelter Cinnabar (3x+ output)
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 2); #MK enrichment chamber (2x output)
			Purification.addRecipe(input, <gas:oxygen>, tfNuggets[i] * 3); #MK purification chamber (3x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, tfNuggets[i] * 4); #MK injection chamber (4x output)
		}
	
	#tm purified 1 (2)
		function mekanismRecipes1(i as int, input as IItemStack, mkSlurries as IGasStack[], ic2TinyDusts as IItemStack[], tfNuggets as IItemStack[])
		{
			var tags = [ {Thaumcraft: 1},
				{Botania: 1},
				{"Blood Magic": 1}
			] as IData[];
		
			for tag in tags {
				Dissolution.addRecipe(input.withTag(tag), mkSlurries[i] * 300); #Mekanism dissolution chamber
				
				MKCrusher.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 4); #MK Crusher (2x output)
				
				Enrichment.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 4); #MK enrichment chamber (2x output)
				Purification.addRecipe(input.withTag(tag), <gas:oxygen>, tfNuggets[i] * 6); #MK purification chamber (3x output)
				Injection.addRecipe(input.withTag(tag), <gas:hydrogenchloride>, tfNuggets[i] * 8); #MK injection chamber (4x output)
			}
		}

		for i, input in tmPurified1 {
			
			mekanismRecipes1(i, input, mkSlurries, ic2TinyDusts, tfNuggets);
			
			furnace.addRecipe(tfNuggets[i] * 2, input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 3.0, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 4, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 4); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 4, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 2 ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 4, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 6 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 4, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 5, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 6, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 6, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 2); #TE Induction smelter Cinnabar (3x+ output)
			
			recipes.addShapeless(ic2TinyDusts[i] * 3, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			IECrusher.addRecipe(ic2TinyDusts[i] * 4, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
			Macerator.addRecipe(ic2TinyDusts[i] * 4, input); #IC2 macerator (2x output)
			Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 4, tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 2); #TE Pulverizer (2x+ output)
			Lacerator.addRecipe(input, ic2TinyDusts[i], 6.0); #FZ Lacerator (3x output)
		}
		
	#tm purified 2 (3)
		function mekanismRecipes2(i as int, input as IItemStack, mkSlurries as IGasStack[], mkCrystals as IItemStack[], mkShards as IItemStack[], ic2TinyDusts as IItemStack[])
		{
			var tags = [ {Thaumcraft: 2},
				{Botania: 2},
				{"Blood Magic": 2},
				{Thaumcraft: 1, Botania: 1},
				{Botania: 1, "Blood Magic": 1},
				{Thaumcraft: 1, "Blood Magic": 1}
			] as IData[];
	
			for tag in tags {
				Dissolution.addRecipe(input.withTag(tag), mkSlurries[i] * 400); #MK dissolution chamber
				Purification.addRecipe(input.withTag(tag), <gas:oxygen>, mkCrystals[i]); #MK purification chamber
				Injection.addRecipe(input.withTag(tag), <gas:hydrogenchloride>, mkShards[i]); #MK injection chamber
				
				MKCrusher.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 6); #MK Crusher (2x output)
				
				Enrichment.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 6); #MK enrichment chamber (2x output)
			}
		}
	
		for i, input in tmPurified2 {
		
			mekanismRecipes2(i, input, mkSlurries, mkCrystals, mkShards, ic2TinyDusts);
			
			furnace.addRecipe(tfNuggets[i] * 3, input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 4.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 6, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 6); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 6, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 6, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 9 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 6, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 7, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, ic2Ingots[i], <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, ic2Ingots[i], tfISmelterSecondaries[i], tfISmelterSecChances[i] * 3); #TE Induction smelter Cinnabar (3x+ output)
			
			recipes.addShapeless(ic2TinyDusts[i] * 4, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			IECrusher.addRecipe(ic2TinyDusts[i] * 6, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
			Macerator.addRecipe(ic2TinyDusts[i] * 6, input); #IC2 macerator (2x output)
			Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 6, tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 3); #TE Pulverizer (2x+ output)
			Lacerator.addRecipe(input, ic2TinyDusts[i], 9.0); #FZ Lacerator (3x output)
		}
		
	#tm purified 3 (4)
		function mekanismRecipes3(i as int, input as IItemStack, mkSlurries as IGasStack[], ic2TinyDusts as IItemStack[], tfNuggets as IItemStack[])
		{
			var tags = [ {Thaumcraft: 2, Botania: 1},
				{Thaumcraft: 2, "Blood Magic": 1},
				{Botania: 2, "Blood Magic": 1},
				{Thaumcraft: 1, Botania: 2},
				{Thaumcraft: 1, Botania: 1, "Blood Magic": 1},
				{Thaumcraft: 1, "Blood Magic": 2},
				{Botania: 1, "Blood Magic": 2}
			] as IData[];
	
			for tag in tags {
				Dissolution.addRecipe(input.withTag(tag), mkSlurries[i] * 500); #MK dissolution chamber
			
				MKCrusher.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 8); #MK Crusher (2x output)
			
				Enrichment.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 8); #MK enrichment chamber (2x output)
				Purification.addRecipe(input.withTag(tag), <gas:oxygen>, tfNuggets[i] * 12); #MK purification chamber (3x output)
				Injection.addRecipe(input.withTag(tag), <gas:hydrogenchloride>, tfNuggets[i] * 16); #MK injection chamber (4x output)
			}
		}
		
		for i, input in tmPurified3 {
		
			mekanismRecipes3(i, input, mkSlurries, ic2TinyDusts, tfNuggets);
		
			furnace.addRecipe(tfNuggets[i] * 4, input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 6.0, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 8, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 8); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 8, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 4 ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 8, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 12 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 9, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 10, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 12, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 12, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 4); #TE Induction smelter Cinnabar (3x+ output)
			
			recipes.addShapeless(ic2TinyDusts[i] * 6, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			IECrusher.addRecipe(ic2TinyDusts[i] * 8, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
			Macerator.addRecipe(ic2TinyDusts[i] * 8, input); #IC2 macerator (2x output)
			Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 8, tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 4); #TE Pulverizer (2x+ output)
			Lacerator.addRecipe(input, ic2TinyDusts[i], 12.0); #FZ Lacerator (3x output)
		}
		
	#tm purified 4 (5)
		function mekanismRecipes4(i as int, input as IItemStack, mkSlurries as IGasStack[], mkCrystals as IItemStack[], mkShards as IItemStack[], ic2TinyDusts as IItemStack[])
		{
			var tags = [ {Thaumcraft: 2, Botania: 2},
				{Thaumcraft: 2, Botania: 1, "Blood Magic": 1},
				{Thaumcraft: 2, "Blood Magic": 2},
				{Botania: 2, "Blood Magic": 2},
				{Thaumcraft: 1, Botania: 2, "Blood Magic": 1},
				{Thaumcraft: 1, Botania: 1, "Blood Magic": 2}
			] as IData[];
	
			for tag in tags {
				Dissolution.addRecipe(input.withTag(tag), mkSlurries[i] * 600); #MK dissolution chamber
				Purification.addRecipe(input.withTag(tag), <gas:oxygen>, mkCrystals[i] * 2); #MK purification chamber
				Injection.addRecipe(input.withTag(tag), <gas:hydrogenchloride>, mkShards[i] * 2); #MK injection chamber
			
				MKCrusher.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 10); #MK Crusher (2x output)
			
				Enrichment.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 10); #MK enrichment chamber (2x output)
			}
		}
		
		for i, input in tmPurified4 {
			
			mekanismRecipes4(i, input, mkSlurries, mkCrystals, mkShards, ic2TinyDusts);
			
			furnace.addRecipe(tfNuggets[i] * 5, input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 7.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 10, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 10); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 10, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 5 ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 10, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 15 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 11, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 12, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 15, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 15, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 5); #TE Induction smelter Cinnabar (3x+ output)
			
			recipes.addShapeless(ic2TinyDusts[i] * 7, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			IECrusher.addRecipe(ic2TinyDusts[i] * 10, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
			Macerator.addRecipe(ic2TinyDusts[i] * 10, input); #IC2 macerator (2x output)
			Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 10, tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 5); #TE Pulverizer (2x+ output)
			Lacerator.addRecipe(input, ic2TinyDusts[i], 15.0); #FZ Lacerator (3x output)
		}
		
	#tm purified 5 (6)
		function mekanismRecipes5(i as int, input as IItemStack, mkSlurries as IGasStack[], ic2TinyDusts as IItemStack[], tfNuggets as IItemStack[])
		{
			var tags = [ {Thaumcraft: 2, Botania: 2, "Blood Magic": 1},
				{Thaumcraft: 2, Botania: 1, "Blood Magic": 2},
				{Thaumcraft: 1, Botania: 2, "Blood Magic": 2}
			] as IData[];
	
			for tag in tags {
				Dissolution.addRecipe(input.withTag(tag), mkSlurries[i] * 700); #MK dissolution chamber
				
				MKCrusher.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 12); #MK Crusher (2x output)
				
				Enrichment.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 12); #MK enrichment chamber (2x output)
				Purification.addRecipe(input.withTag(tag), <gas:oxygen>, tfNuggets[i] * 18); #MK purification chamber (3x output)
				Injection.addRecipe(input.withTag(tag), <gas:hydrogenchloride>, tfNuggets[i] * 24); #MK injection chamber (4x output)
			}
		}
		
		for i, input in tmPurified5 {
		
			mekanismRecipes5(i, input, mkSlurries, ic2TinyDusts, tfNuggets);
			
			furnace.addRecipe(tfNuggets[i] * 6, input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 9.0, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 12, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 12); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 12, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 6 ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 12, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 18 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 14, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 15, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, ic2Ingots[i] * 3, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, ic2Ingots[i] * 3, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 6); #TE Induction smelter Cinnabar (3x+ output)
			
			recipes.addShapeless(ic2TinyDusts[i] * 9, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			IECrusher.addRecipe(ic2TinyDusts[i] * 12, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
			Macerator.addRecipe(ic2TinyDusts[i] * 12, input); #IC2 macerator (2x output)
			Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 12, tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 6); #TE Pulverizer (2x+ output)
			Lacerator.addRecipe(input, ic2TinyDusts[i], 18.0); #FZ Lacerator (3x output)
		}
		
	#tm purified 6 (7)
		for i, input in tmPurified6 {
			var tag = {Thaumcraft: 2, Botania: 2, "Blood Magic": 2} as IData;
			
			Dissolution.addRecipe(input.withTag(tag), mkSlurries[i] * 800); #MK dissolution chamber
			
			furnace.addRecipe(tfNuggets[i] * 7, input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 10.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 14, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 14); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 14, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 7 ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 14, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 21 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 16, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 17, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 21, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 21, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 7); #TE Induction smelter Cinnabar (3x+ output)
			
			recipes.addShapeless(ic2TinyDusts[i] * 10, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			MKCrusher.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 14); #MK Crusher (2x output)
			IECrusher.addRecipe(ic2TinyDusts[i] * 14, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
			Macerator.addRecipe(ic2TinyDusts[i] * 14, input); #IC2 macerator (2x output)
			Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 14, tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 7); #TE Pulverizer (2x+ output)
			Lacerator.addRecipe(input, ic2TinyDusts[i], 21.0); #FZ Lacerator (3x output)
			
			Enrichment.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 14); #MK enrichment chamber (2x output)
			Purification.addRecipe(input.withTag(tag), <gas:oxygen>, tfNuggets[i] * 21); #MK purification chamber (3x output)
			Injection.addRecipe(input.withTag(tag), <gas:hydrogenchloride>, tfNuggets[i] * 28); #MK injection chamber (4x output)
		}
	
	#mk slurries
		for i, slurry in mkSlurries {
			MKCrystallizer.addRecipe(slurry * 300, mkCrystals[i]);
		}
	
	#mk crystals (3)
		for i, input in mkCrystals {
			furnace.addRecipe(tfNuggets[i] * 3, input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 4.0, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 5, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 5); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 5, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 5, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 9 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 5, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 6, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 5, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 5, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 3); #TE Induction smelter Cinnabar (3x+ output)
			
			recipes.addShapeless(ic2TinyDusts[i] * 4, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			MKCrusher.addRecipe(input, ic2TinyDusts[i] * 5); #MK Crusher (2x output)
			IECrusher.addRecipe(ic2TinyDusts[i] * 5, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
			Macerator.addRecipe(ic2TinyDusts[i] * 5, input); #IC2 macerator (2x output)
			Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 5, tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 3); #TE Pulverizer (2x+ output)
			Lacerator.addRecipe(input, ic2TinyDusts[i], 5.5); #FZ Lacerator (3x output)
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 5); #MK enrichment chamber (2x output)
			Purification.addRecipe(input, <gas:oxygen>, tfNuggets[i] * 5); #MK purification chamber (3x output)
		}
	
	#mk shards (5)
		for i, input in mkShards {
			furnace.addRecipe(tfNuggets[i] * 5, input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 5.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 6, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 6); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 6, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 5 ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 6, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 15 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 6, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 7, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 6, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 6, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 5 ); #TE Induction smelter Cinnabar (3x+ output)
			
			recipes.addShapeless(ic2TinyDusts[i] * 5, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			MKCrusher.addRecipe(input, ic2TinyDusts[i] * 6); #MK Crusher (2x output)
			IECrusher.addRecipe(ic2TinyDusts[i] * 6, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
			Macerator.addRecipe(ic2TinyDusts[i] * 6, input); #IC2 macerator (2x output)
			Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 6, tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 5); #TE Pulverizer (2x+ output)
			Lacerator.addRecipe(input, ic2TinyDusts[i], 6.5); #FZ Lacerator (3x output)
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 6); #MK enrichment chamber (2x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, tfNuggets[i] * 6); #MK injection chamber (4x output)
		}
	
	#mk clumps (6)
		for i, input in mkClumps {
			furnace.addRecipe(tfNuggets[i] * 6, input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 7.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 7, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 7); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 7, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 6 ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 7, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 18 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 7, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 8, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 7, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 7, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 6); #TE Induction smelter Cinnabar (3x+ output)
			
			recipes.addShapeless(mkDirtyDusts[i], [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			IECrusher.addRecipe(mkDirtyDusts[i], input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
			Pulverizer.addRecipe(1000, input, mkDirtyDusts[i], tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 6); #TE Pulverizer (2x+ output)
			Lacerator.addRecipe(input, mkDirtyDusts[i], 1.1); #FZ Lacerator (3x output)
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 7); #MK enrichment chamber (2x output)
			Purification.addRecipe(input, <gas:oxygen>, tfNuggets[i] * 7); #MK purification chamber (3x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, tfNuggets[i] * 7); #MK injection chamber (4x output)
		}
		
	#mk dirty dusts (8)
		for i, input in mkDirtyDusts {
			furnace.addRecipe(tfNuggets[i] * 8, input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 8.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 8, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 8); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 8, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 8 ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 8, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 24 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 8, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 9, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 8, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 8, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 8); #TE Induction smelter Cinnabar (3x+ output)
			
			Purification.addRecipe(input, <gas:oxygen>, tfNuggets[i] * 8); #MK purification chamber (3x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, tfNuggets[i] * 8); #MK injection chamber (4x output)
		}

#todo:
#1. Handle Uranium processing a bit differently
#2. Make Semi-Product -> Tiny dust Sagmill recipes more complex?
#3. Other Bronze armours?
#4. Add Betweenlands ores to the Sagmill and Alloy Smelter configs? And armours to the armour config?

#Other files are needed for the OP to work: aobd.cfg, ic2/Blast_Furnace.ini, enderio/SagMillRecipes_User.xml and enderio/AlloySmelterRecipes_User.xml

#Problems
#Fz lacerator recipes cannot be removed?
#IC2 Uranium is a separate case, I guess?
