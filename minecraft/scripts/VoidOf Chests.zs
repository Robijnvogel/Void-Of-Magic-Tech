#start of the armour processing minetweaker script

#Imports
	import minetweaker.item.IItemStack;
	import minetweaker.item.IIngredient;
	
#Item lists
	#in the rest of this document, some lists of items are used.
	#These lists will have the following order:
	#0 -> Copper
	#1 -> Iron
	#2 -> Silver
	#3 -> Gold
	
	var oreDictIngots = [ <ore:ingotCopper>,
		<ore:ingotIron>,
		<ore:ingotSilver>,
		<ore:ingotGold>
	] as IIngredient[];
	
	var oreDictNuggets = [ <ore:nuggetCopper>,
		<ore:nuggetIron>,
		<ore:nuggetSilver>,
		<ore:nuggetGold>
	] as IIngredient[];
	
	var inputChests = [ <minecraft:chest>, #Copper: Wood
		<minecraft:chest>, #Iron: Wood
		<IronChest:BlockIronChest:3>, #Silver: Copper
		<IronChest:BlockIronChest> #Gold: Iron
	] as IItemStack[];
	
	var outputChests = [ <IronChest:BlockIronChest:3>, #Copper
		<IronChest:BlockIronChest>, #Iron
		<IronChest:BlockIronChest:4>, #Silver
		<IronChest:BlockIronChest:1> #Gold
	] as IItemStack[];
	
#Recipe removal
	#all
		for i, output in outputChests {
			recipes.remove(output);
		}
		
#Recipe creation	
	#all
		for i, nugget in oreDictNuggets {
			#first chest recipe
				recipes.addShaped(outputChests[i], 
				[ [oreDictIngots[i], nugget, oreDictIngots[i]],
				[nugget, inputChests[i], nugget], 
				[oreDictIngots[i], nugget, oreDictIngots[i]] ]);
			#second chest recipe
				if (i > 0) {
					var j = i - 1;
					recipes.addShaped(outputChests[i], 
					[ [<ore:blockGlass>, oreDictIngots[i], <ore:blockGlass>],
					[nugget, outputChests[j], nugget], 
					[<ore:blockGlass>, oreDictIngots[i], <ore:blockGlass>] ]);
				}
		}