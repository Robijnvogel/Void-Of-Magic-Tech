import minetweaker.item.IItemStack;

var lootTech = [ <IC2:itemOreIridium>,
    <IC2:itemShardIridium>,
	<IC2:itemToolBronzePickaxe>,
	<IC2:itemToolBronzeSword>,
    <IC2:itemArmorBronzeHelmet>,
    <IC2:itemArmorBronzeChestplate>,
    <IC2:itemArmorBronzeLegs>,
    <IC2:itemArmorBronzeBoots>,
    <IC2:itemTinCanFilled>,
    <IC2:itemShardIridium>,
	<IC2:itemIngot>,
    <IC2:itemIngot:1>,
	<IC2:itemTreetap>,
	<IC2:blockRubSapling>,
    <NuclearCraft:dominoes>,
    <NuclearCraft:ricecake>,
    <NuclearCraft:upgrade>,
    <NuclearCraft:fuel:4>,
    <NuclearCraft:WRTG>,
    <NuclearCraft:material:32>,
    <NuclearCraft:material:59>,
    <NuclearCraft:fuel:47>,
    <NuclearCraft:recordPractice>,
    <NuclearCraft:recordArea51>,
    <NuclearCraft:recordNeighborhood>,
    <NuclearCraft:blastBlock>,
    <NuclearCraft:boiledEgg>,
    <NuclearCraft:boronHelm>,
    <NuclearCraft:boronChest>,
    <NuclearCraft:boronLegs>,
    <NuclearCraft:boronBoots>,
    <NuclearCraft:toughBow>,
	<NuclearCraft:pistol>,
    <NuclearCraft:dUBullet>,
    <NuclearCraft:bronzeHelm>,
    <NuclearCraft:bronzeChest>,
    <NuclearCraft:bronzeLegs>,
    <NuclearCraft:bronzeBoots>,
    <NuclearCraft:toughAlloyShovel>,
	<NuclearCraft:toughHelm>,
    <NuclearCraft:toughChest>,
    <NuclearCraft:toughLegs>,
    <NuclearCraft:toughBoots>,
	<ImmersiveEngineering:blueprint:2>,
	<EnderIO:itemAlloy>,
    <EnderIO:itemAlloy:3>,
    <EnderIO:itemAlloy:6>,
    <EnderIO:itemAlloy:5>,
    <EnderIO:itemAlloy:2>,
    <EnderIO:itemConduitProbe>,
	<EnderIO:itemTravelStaff>,
	<EnderIO:item.darkSteel_sword>,
    <EnderIO:item.darkSteel_boots>,
    <PneumaticCraft:stopWorm>,
    <PneumaticCraft:nukeVirus>,
] as IItemStack[];

for item in lootTech {
	vanilla.loot.removeChestLoot("bonusChest", item);
	vanilla.loot.removeChestLoot("dungeonChest", item);
	vanilla.loot.removeChestLoot("mineshaftCorridor", item);
	vanilla.loot.removeChestLoot("pyramidDesertyChest", item);
	vanilla.loot.removeChestLoot("pyramidJungleChest", item);
	vanilla.loot.removeChestLoot("pyramidJungleDispenser", item);
	vanilla.loot.removeChestLoot("strongholdCorridor", item);
	vanilla.loot.removeChestLoot("strongholdCrossing", item);
	vanilla.loot.removeChestLoot("strongholdLibrary", item);
	vanilla.loot.removeChestLoot("towerChestContents", item);
	vanilla.loot.removeChestLoot("villageBlacksmith", item);
}
