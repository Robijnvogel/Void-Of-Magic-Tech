#start of the ore processing minetweaker script

#Imports
	import minetweaker.item.IItemStack;
	import minetweaker.item.IIngredient;
	import modtweaker.gas.IGasStack;

	import mods.botania.ManaInfusion;
	import mods.factorization.Lacerator;
	import mods.factorization.SlagFurnace;
	import mods.ic2.Macerator;
	import mods.ic2.OreWasher;
	import mods.ic2.ThermalCentrifuge;
	import mods.immersiveengineering.ArcFurnace;
	import mods.immersiveengineering.Crusher as IECrusher;
	import mods.mekanism.Enrichment;
	import mods.mekanism.Purification;
	import mods.mekanism.chemical.Injection;
	import mods.mekanism.chemical.Dissolution;
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
	#others?

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

	var oreDictIngots = [ <ore:ingotIron>,
		<ore:ingotGold>,
		<ore:ingotCopper>,
		<ore:ingotTin>,
		<ore:IngotSilver>,
		<ore:IngotLead>
	] as IIngredient[];

	var oreDictNuggets = [ <ore:nuggetIron>,
		<ore:nuggetGold>,
		<ore:nuggetCopper>,
		<ore:nuggetTin>,
		<ore:nuggetSilver>,
		<ore:nuggetLead>
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
		<ThermalFoundation:material:99>, #lead
		<ThermalFoundation:material:100>, #nickel
		<ThermalFoundation:material:101>, #platinum
		<ThermalFoundation:material:102>, #mithril
		<ImmersiveEngineering:metal:23>, #aluminium
		<IC2:itemUran235small>, #uranium
		<aobd:nuggetOsmium>, #osmium
		<aobd:nuggetFzDarkIron>, #dark iron
		<aobd:nuggetBoron>, #boron
		<aobd:nuggetLithium>, #lithium
		<aobd:nuggetMagnesium>, #magnesium
		<aobd:nuggetThorium> #thorium		
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
		<Mekanism:ingot:1>, #osmium
		<factorization:dark_iron_ingot>, #dark iron
		<NuclearCraft:material:43>, #boron
		<NuclearCraft:material:42>, #lithium
		<NuclearCraft:material:50>, #magnesium
		<NuclearCraft:material:5>, #thorium		
	] as IItemStack[];

	var ieIngots = [ <minecraft:iron_ingot>,
		<minecraft:gold_ingot>,
		<ImmersiveEngineering:metal>, #copper
		<ThermalFoundation:material:65>, #tin
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
		<NuclearCraft:material:20> #thorium
	] as IItemStack[];

	#used for removal of IE ore + hammer -> dust recipes
	var ieDusts = [ <ImmersiveEngineering:metal:8>, #iron
		<ImmersiveEngineering:metal:9>, #gold
		<ImmersiveEngineering:metal:10>, #copper
		<ThermalFoundation:material:33>, #tin
		<ImmersiveEngineering:metal:13>, #silver
		<ImmersiveEngineering:metal:12> #lead
	] as IItemStack[];

	var ic2TinyDusts = [ <IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall:2>, #gold
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall:4>, #silver
		<IC2:itemDustSmall:5>, #lead
		<aobd:dustTinyNickel>, #nickel
		<aobd:dustTinyPlatinum>, #platinum
		<aobd:dustTinyMithril>, #mithril
		<aobd:dustTinyAluminum>, #aluminium
		<aobd:dustTinyUranium>, #uranium
		<aobd:dustTinyOsmium>, #osmium
		<aobd:dustTinyFzDarkIron>, #dark iron
		<aobd:dustTinyBoron>, #boron
		<IC2:itemDustSmall:7>, #lithium
		<aobd:dustTinyMagnesium>, #magnesium
		<aobd:dustTinyThorium> #thorium
	] as IItemStack[];

	var ic2Crushed = [ <IC2:itemCrushedOre>, #iron
		<IC2:itemCrushedOre:2>, #gold
		<IC2:itemCrushedOre:1>, #copper
		<IC2:itemCrushedOre:3>, #tin
		<IC2:itemCrushedOre:5>, #silver
		<IC2:itemCrushedOre:6> #lead
	] as IItemStack[];

	var ic2CrushedPurified = [ <IC2:itemPurifiedCrushedOre>, #iron
		<IC2:itemPurifiedCrushedOre:2>, #gold
		<IC2:itemPurifiedCrushedOre:1>, #copper
		<IC2:itemPurifiedCrushedOre:3>, #tin
		<IC2:itemPurifiedCrushedOre:5>, #silver
		<IC2:itemPurifiedCrushedOre:6> #lead
	] as IItemStack[];

	var mkClumps = [ <Mekanism:Clump>, #iron
		<Mekanism:Clump:1>, #gold
		<Mekanism:Clump:3>, #copper
		<Mekanism:Clump:4>, #tin
		<Mekanism:Clump:5>, #silver
		<Mekanism:Clump:6>, #lead
	] as IItemStack[];

	var mkCrystals = [<Mekanism:Crystal>, #iron
		<Mekanism:Crystal:1>, #gold
		<Mekanism:Crystal:3>, #copper
		<Mekanism:Crystal:4>, #tin
		<Mekanism:Crystal:5>, #silver
		<Mekanism:Crystal:6>, #lead
	] as IItemStack[];

	var mkShards = [ <Mekanism:Shard>, #iron
		<Mekanism:Shard:1>, #gold
		<Mekanism:Shard:3>, #copper
		<Mekanism:Shard:4>, #tin
		<Mekanism:Shard:5>, #silver
		<Mekanism:Shard:6>, #lead
	] as IItemStack[];

	var mkDirtyDusts = [ <Mekanism:DirtyDust>, #iron
		<Mekanism:DirtyDust:1>, #gold
		<Mekanism:DirtyDust:3>, #copper
		<Mekanism:DirtyDust:4>, #tin
		<Mekanism:DirtyDust:5>, #silver
		<Mekanism:DirtyDust:6>, #lead
	] as IItemStack[];

	var mkSlurries = [ <gas:iron>, #iron
		<gas:gold>, #gold
		<gas:copper>, #copper
		<gas:tin>, #tin
		<gas:silver>, #silver
		<gas:lead>, #lead
		<gas:nickel>, #nickel
		<gas:platinum>, #platinum
		<gas:mithril>, #mithril
		<gas:aluminium>, #aluminium
		<gas:uranium>, #uranium
		<gas:osmium>, #osmium
		<gas:fzdarkiron>, #dark iron
		<gas:boron>, #boron
		<gas:lithium>, #lithium
		<gas:magnesium>, #magnesium
		<gas:thorium>, #thorium
	] as IGasStack[];

	var mkCleanSlurries = [ <gas:cleanIron>, #Iron
		<gas:cleanGold>, #gold
		<gas:cleanCopper>, #copper
		<gas:cleanTin>, #tin
		<gas:cleanSilver>, #silver
		<gas:cleanLead>, #lead
	] as IGasStack[];

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
	
	var tfPulvSecondaries = [ <aobd:dustTinyNickel>, #iron -> ferrous
		<ThermalFoundation:material:20>, #gold -> cinnabar
		<IC2:itemDustSmall:2>, #copper -> gold
		<IC2:itemDustSmall>, #tin -> iron
		<IC2:itemDustSmall:5>, #silver -> lead
		<IC2:itemDustSmall:4> #lead -> silver
	] as IItemStack[];
	
	var tfPulvSecondaryChances = [ 10, #iron
		5, #gold
		10, #copper
		10, #tin
		10, #silver
		10 #lead
	] as int[];
	
	var ieCrusherSecondaries = [ <aobd:dustTinyNickel>, #iron -> ferrous
		<IC2:itemDustSmall:2>, #gold -> gold
		<minecraft:cobblestone>, #copper -> stone
		<minecraft:cobblestone>, #tin -> stone
		<IC2:itemDustSmall:5>, #silver -> lead
		<IC2:itemDustSmall:4> #lead -> silver
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
		<aobd:dustTinyThorium> #thorium
	] as IItemStack[];

	var tcClusters = [ <Thaumcraft:ItemNugget:16>, #Iron
		<Thaumcraft:ItemNugget:31>, #gold
		<Thaumcraft:ItemNugget:17>, #copper
		<Thaumcraft:ItemNugget:18>, #tin
		<Thaumcraft:ItemNugget:19>, #silver
		<Thaumcraft:ItemNugget:20>, #lead
	] as IItemStack[];

	var fzCrystallines = [ <factorization:ore/crystal>, #Iron
		<factorization:ore/crystal:1>, #gold
		<factorization:ore/crystal:4>, #copper
		<factorization:ore/crystal:3>, #tin
		<factorization:ore/crystal:5>, #silver
		<factorization:ore/crystal:2>, #lead
	] as IItemStack[];

	var fzCleanGravels = [ <factorization:ore/clean>, #Iron
		<factorization:ore/clean:1>, #gold
		<factorization:ore/clean:4>, #copper
		<factorization:ore/clean:3>, #tin
		<factorization:ore/clean:5>, #silver
		<factorization:ore/clean:2>, #lead
	] as IItemStack[];

	var fzReducedChunks = [ <factorization:ore/reduced>, #Iron
		<factorization:ore/reduced:1>, #gold
		<factorization:ore/reduced:4>, #copper
		<factorization:ore/reduced:3>, #tin
		<factorization:ore/reduced:5>, #silver
		<factorization:ore/reduced:2>, #lead
	] as IItemStack[];

	var fzDirtyGravels = [ <factorization:ore/gravel>, #Iron
		<factorization:ore/gravel:1>, #gold
		<factorization:ore/gravel:4>, #copper
		<factorization:ore/gravel:3>, #tin
		<factorization:ore/gravel:5>, #silver
		<factorization:ore/gravel:2>, #lead
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
		<technom:pureAluminium>,
		<technom:pureUranium>,
		<technom:pureOsmium>,
		<technom:pureFzDarkIron>,
		<technom:pureBoron>,
		<technom:pureLithium>,
		<technom:pureMagnesium>,
		<technom:pureThorium>,
	] as IItemStack[];
	
	var tmPurified2 = [ <technom:pureIron:1>,
		<technom:pureGold:1>,
		<technom:pureCopper:1>,
		<technom:pureTin:1>,
		<technom:pureSilver:1>,
		<technom:pureLead:1>		
	] as IItemStack[];
	
	var tmPurified3 = [ <technom:pureIron:2>,
		<technom:pureGold:2>,
		<technom:pureCopper:2>,
		<technom:pureTin:2>,
		<technom:pureSilver:2>,
		<technom:pureLead:2>		
	] as IItemStack[];
	
	var tmPurified4 = [ <technom:pureIron:3>,
		<technom:pureGold:3>,
		<technom:pureCopper:3>,
		<technom:pureTin:3>,
		<technom:pureSilver:3>,
		<technom:pureLead:3>		
	] as IItemStack[];
	
	var tmPurified5 = [ <technom:pureIron:4>,
		<technom:pureGold:4>,
		<technom:pureCopper:4>,
		<technom:pureTin:4>,
		<technom:pureSilver:4>,
		<technom:pureLead:4>		
	] as IItemStack[];
	
	var tmPurified6 = [ <technom:pureIron:5>,
		<technom:pureGold:5>,
		<technom:pureCopper:5>,
		<technom:pureTin:5>,
		<technom:pureSilver:5>,
		<technom:pureLead:5>		
	] as IItemStack[];

#Additional lists:
	#used for additional removal of IE ore crusher recipes
	var ieDusts2 = [ <IC2:itemDust:7>, #tin
		#<IC2:itemDust:3>
	] as IItemStack[];
	
	#used for FZ slag furnace recipes as input
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
		<factorization:ResourceBlock>
	] as IItemStack[];
	
	#used for FZ slag furnace recipes as output
	var allNuggets = [ <ThermalFoundation:material:8>,
		<minecraft:gold_nugget>,
		<ThermalFoundation:material:96>,
		<ThermalFoundation:material:97>,
		<ThermalFoundation:material:96>,
		<ThermalFoundation:material:97>,
		<ImmersiveEngineering:metal:23>,
		<ThermalFoundation:material:96>,
		<ThermalFoundation:material:97>,
		<ImmersiveEngineering:metal:23>,
		<ThermalFoundation:material:8>,
		<ThermalFoundation:material:96>,
		<ThermalFoundation:material:97>,
		<ThermalFoundation:material:8>,
		<ThermalFoundation:material:96>,
		<ThermalFoundation:material:97>,
		<IC2:itemUran235small>,
		<ThermalFoundation:material:99>,
		<ThermalFoundation:material:96>,
		<ImmersiveEngineering:metal:23>,
		<ThermalFoundation:material:99>,
		<ThermalFoundation:material:98>,
		<ThermalFoundation:material:100>,
		<aobd:nuggetOsmium>,
		<ThermalFoundation:material:96>,
		<ThermalFoundation:material:97>,
		<ThermalFoundation:material:96>,
		<ThermalFoundation:material:97>,
		<ThermalFoundation:material:99>,
		<ThermalFoundation:material:98>,
		<IC2:itemUran235small>,
		<aobd:nuggetThorium>,
		<aobd:nuggetLithium>,
		<aobd:nuggetBoron>,
		<aobd:nuggetMagnesium>,
		<ThermalFoundation:material:96>,
		<ThermalFoundation:material:97>,
		<ThermalFoundation:material:98>,
		<ThermalFoundation:material:99>,
		<ThermalFoundation:material:100>,
		<ThermalFoundation:material:101>,
		<ThermalFoundation:material:102>,
		<aobd:nuggetFzDarkIron>,
		<ThermalFoundation:material:98>
	] as IItemStack[];
	
	#used for removal of furnace recipes as output
	var allIngots = [ <minecraft:iron_ingot>,
		<minecraft:gold_ingot>,
		<IC2:itemIngot>, #copper
		<IC2:itemIngot:1>, #tin
		<IC2:itemIngot:6>, #silver
		<IC2:itemIngot:5> #lead
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
		#IC2 Uranium is a separate case, I guess?

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
		}
		SlagFurnace.removeRecipe(<factorization:ore/clean:5>); #silver
	
	#fz reduced chunks
		for chunk in fzReducedChunks {
			furnace.remove(<*>, chunk);
			RSFurnace.removeRecipe(chunk); #TE Redstone furnace
		}
	
	#fz crystals
		for crystal in fzCrystallines {
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
			RSFurnace.removeRecipe(purified); #TE Redstone furnace
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
		
	#mk crystals		
		
	#mk shards
	
	#mk clumps
	
	#mk dirty dusts
	


#Recipe creation
	#ores
		for i, ore in oredictOres {
			furnace.addRecipe(tfNuggets[i], ore, 0.5); #Furnace
			recipes.addShapeless(ic2TinyDusts[i], [<ImmersiveEngineering:tool>.transformDamage(), ore]); #IE Engineers Hammer
			recipes.addShapeless(tfNuggets[i] * 2, [<ThermalFoundation:material:512>, ore ]); #Pyrotheum			
				#Macerator.addRecipe(ic2TinyDusts[i] * 2, ore); #IC2 macerator can only be overwritten, not removed.
			Enrichment.addRecipe(tfOres[i], ic2TinyDusts[i] * 2);			
			Purification.addRecipe(tfOres[i], <gas:oxygen>, tfNuggets[i] * 2); #MK purification chamber (2x output)
			Injection.addRecipe(tfOres[i], <gas:hydrogenchloride>, tfNuggets[i] * 3); #MK injection chamber (3x output)
			Dissolution.addRecipe(tfOres[i], mkSlurries[i] * 110); #MK dissolution chamber
			IECrusher.addRecipe(ic2TinyDusts[i] * 2, ore, 2500, ieCrusherSecondaries[i], 0.1);
			RSFurnace.addRecipe(800, tfOres[i], tfNuggets[i] * 2); #TE Redstone furnace
			Pulverizer.addRecipe(1000, tfOres[i], ic2TinyDusts[i] * 2, tfPulvSecondaries[i], tfPulvSecondaryChances[i]); #TE Pulverizer (2 x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, tfOres[i], tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] ); #TE Induction smelter Sand
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, tfOres[i], tfNuggets[i] * 3, tfISmelterSecondaries[i], tfISmelterSecChances[i]); #TE Induction smelter Cinnabar
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, tfOres[i], tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Pyrotheum
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, tfOres[i], tfNuggets[i] * 3, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag
			ArcFurnace.addRecipe(tfNuggets[i] * 2, ore, <ImmersiveEngineering:material:13>, 100, 512); 	#IE Arc Furnace
		}		
		#IC2 Blast Furnace recipes are done in the configs
		for i, ore in allOres {
		#	for ore in ores {
				SlagFurnace.addRecipe(ore, allNuggets[i], 1.5, <minecraft:stone>, 0.4);
		#	}		
		}

	#dusts	
		for i, dust in oredictDusts {
			var tDust = ic2TinyDusts[i];
			recipes.addShapeless(tDust * 9, [dust]);
			recipes.addShapeless(ic2Dusts[i], [tDust, tDust, tDust, tDust, tDust, tDust, tDust, tDust, tDust]);
		}

	#ingot <-> dust (IE crusher)
	#nugget <-> tiny dust (probably all ways)
	#dust <-> tiny dust (probably all ways)
	#ingot <-> nugget (probably none needed)

	#tc clusters
		for i, cluster in tcClusters {			
			furnace.addRecipe(tfNuggets[i] * 2, cluster, 0.5);
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 3, cluster, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace
			RSFurnace.addRecipe(800, cluster, tfNuggets[i] * 3); #TE Redstone furnace
			Pulverizer.addRecipe(1000, cluster, ic2TinyDusts[i] * 3, tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 2); #TE Pulverizer (2 x output)
			Lacerator.addRecipe(cluster, fzDirtyGravels[i], 3.5); #FZ Lacerator
		}
		
	#fz dirty gravel
		for i, gravel in fzDirtyGravels {
			furnace.addRecipe(tfNuggets[i], gravel, 0.5);
			SlagFurnace.addRecipe(gravel, tfNuggets[i], 1.1, <minecraft:dirt>, 0.2);
			RSFurnace.addRecipe(800, gravel, tfNuggets[i] * 2); #TE Redstone furnace
		}

	#fz clean gravel
		for i, gravel in fzCleanGravels {
			furnace.addRecipe(tfNuggets[i], gravel, 0.5);
			RSFurnace.addRecipe(800, gravel, tfNuggets[i] * 2); #TE Redstone furnace
		}
		SlagFurnace.addRecipe(<factorization:ore/clean:5>, <factorization:ore/reduced:5>, 1.25, <factorization:ore/reduced:5>, 1.25); #silver
		
	#fz reduced chunks
		for i, chunk in fzReducedChunks {
			furnace.addRecipe(tfNuggets[i], chunk, 0.5);
			RSFurnace.addRecipe(800, chunk, tfNuggets[i] * 2); #TE Redstone furnace
			ManaInfusion.addAlchemy(ic2Crushed[i] * 2, chunk, 1000); #Botania alchemy
		}
	
	#fz crystals
		for i, crystal in fzCrystallines {
			furnace.addRecipe(tfNuggets[i], crystal, 0.5);
			RSFurnace.addRecipe(800, crystal, tfNuggets[i] * 2); #TE Redstone furnace
			ManaInfusion.addAlchemy(ic2Crushed[i] * 3, crystal, 750); #Botania alchemy
		}

	#ic2 crushed
		for i, crushed in ic2Crushed {
			furnace.addRecipe(tfNuggets[i], crushed, 0.5);			
			ThermalCentrifuge.addRecipe([ ic2TinyDusts[i], ic2ThermCentSecondaries[i], <IC2:itemDust:9> ], crushed, 2000); #thermal centrifuge in configs?
			RSFurnace.addRecipe(800, crushed, tfNuggets[i] * 2); #TE Redstone furnace
		}
	
	#ic2 purified
		for i, crushed in ic2CrushedPurified {
			furnace.addRecipe(tfNuggets[i], crushed, 0.5);
			ThermalCentrifuge.addRecipe([ tmPurified1[i], ic2ThermCentSecondaries[i], <IC2:itemDust:9> ], crushed, 1000); #thermal centrifuge in configs -> into technomancy
			RSFurnace.addRecipe(800, crushed, tfNuggets[i] * 2); #TE Redstone furnace
		}
	
	#tm purified 1
		for i, purified in tmPurified1 {
			furnace.addRecipe(tfNuggets[i] * 2, purified, 0.5);
			RSFurnace.addRecipe(800, purified, tfNuggets[i] * 3); #TE Redstone furnace
		}
		
	#tm purified 2
		for i, purified in tmPurified2 {
			furnace.addRecipe(tfNuggets[i] * 3, purified, 0.5);
			RSFurnace.addRecipe(800, purified, tfNuggets[i] * 4); #TE Redstone furnace
		}
		
	#tm purified 3
		for i, purified in tmPurified3 {
			furnace.addRecipe(tfNuggets[i] * 4, purified, 0.5);
			RSFurnace.addRecipe(800, purified, tfNuggets[i] * 6); #TE Redstone furnace
		}
		
	#tm purified 4
		for i, purified in tmPurified4 {
			furnace.addRecipe(tfNuggets[i] * 5, purified, 0.5);
			RSFurnace.addRecipe(800, purified, tfNuggets[i] * 7); #TE Redstone furnace
		}
		
	#tm purified 5
		for i, purified in tmPurified5 {
			furnace.addRecipe(tfNuggets[i] * 6, purified, 0.5);
			RSFurnace.addRecipe(800, purified, tfNuggets[i] * 9); #TE Redstone furnace
		}
		
	#tm purified 6
		for i, purified in tmPurified6 {
			furnace.addRecipe(tfNuggets[i] * 7, purified, 0.5);
			RSFurnace.addRecipe(800, purified, tfNuggets[i] * 10); #TE Redstone furnace
			Dissolution.addRecipe(purified, mkSlurries[i] * 1200); #MK dissolution chamber
		}
	
	#mk crystals
		
	#mk shards
	
	#mk clumps
	
	#mk dirty dusts	

#Crushers: IC2 Macerator, TE Pulverizer, IE Crusher, Mk Crusher, FZ Lacerator (also block -> 9 dusts), EIO Sag Mill
#Furnaces: 

#todo:
#1. Everything smelts and pulverizes to nuggets and tiny dusts
#2. Every last product in a chain can be input into the start of another chain to yield twice? the outcome of an ore?
#3. Keep an eye on whether the first things actually need to be removed and stuff
#4. Everything at the start of the chain is usable later in the chain?
#TC is the first step, then Factorization, then Botania, then IC2, then Technomancy and eventually Mekanism?

#Other files: aobd.cfg, ic2/Blast_Furnace.ini, enderio/SagMillRecipes_User.xml

#Problems
#Fz lacerator recipes cannot be removed
#Mk Combiner can break everything