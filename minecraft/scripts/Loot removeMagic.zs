import minetweaker.item.IItemStack;

var lootMagic = [ <Botania:lexicon>,
    <Botania:blackLotus>,
	<Botania:manaResource>,
    <Botania:manaBottle>,
	<Botania:manaResource:1>,
    <Botania:overgrowthSeed>,
	<arsmagica2:rune:17>,
    <arsmagica2:rune:18>,
	<Automagy:baubleEnderDisjunction:1>,
	<Automagy:phialExtra>,
	<AWWayofTime:standardBindingAgent>,
    <AWWayofTime:mundanePowerCatalyst>,
    <AWWayofTime:mundaneLengtheningCatalyst>,
    <AWWayofTime:averagePowerCatalyst>,
    <AWWayofTime:averageLengtheningCatalyst>,
    <AWWayofTime:greaterPowerCatalyst>,
    <AWWayofTime:greaterLengtheningCatalyst>,
	<MagicBees:frameOblivion>,
	<Thaumcraft:ItemLootBag>,
    <Thaumcraft:ItemResource:2>,
    <Thaumcraft:ItemResource:6>,
    <Thaumcraft:ItemLootBag:1>,
    <Thaumcraft:ItemBaubleBlanks>,
    <Thaumcraft:ItemBaubleBlanks:1>,
    <Thaumcraft:ItemBaubleBlanks:2>,
    <Thaumcraft:ItemResource:9>,
    <Thaumcraft:ItemLootBag:2>,
    <Thaumcraft:ItemThaumonomicon>,
    <Thaumcraft:ItemSwordThaumium>,
    <Thaumcraft:ItemPickThaumium>,
    <Thaumcraft:ItemAxeThaumium>,
    <Thaumcraft:ItemHoeThaumium>,
    <Thaumcraft:ItemRingRunic>,
    <Thaumcraft:ItemBaubleBlanks:3>,
    <Thaumcraft:ItemBaubleBlanks:4>,
    <Thaumcraft:ItemBaubleBlanks:5>,
    <Thaumcraft:ItemBaubleBlanks:6>,
    <Thaumcraft:ItemBaubleBlanks:7>,
    <Thaumcraft:ItemBaubleBlanks:8>,
	<Thaumcraft:ItemAmuletVis>,
    <Forestry:beeDroneGE>,    
	<WitchingGadgets:item.WG_Material:8>,
	<EMT:TaintedMjolnir>,
	<EMT:BaseBaubles>
] as IItemStack[];

for item in lootMagic {
	vanilla.loot.removeChestLoot("bonusChest", item);
	vanilla.loot.removeChestLoot("dungeonChest", item);
	vanilla.loot.removeChestLoot("mineshaftCorridor", item);
	vanilla.loot.removeChestLoot("pyramidDesertyChest", item);
	vanilla.loot.removeChestLoot("pyramidJungleChest", item);
	vanilla.loot.removeChestLoot("strongholdCorridor", item);
	vanilla.loot.removeChestLoot("strongholdCrossing", item);
	vanilla.loot.removeChestLoot("strongholdLibrary", item);
	vanilla.loot.removeChestLoot("towerChestContents", item);
	vanilla.loot.removeChestLoot("villageBlacksmith", item);
}
