local eggInfo = {}

eggInfo.Info =
{
	CommonEgg = {
		Name = "Common Egg",
		Price = 250,
		Color = Color3.new(0.95, 0.95, 0.95),
		Weight = 300
	},
	UncommonEgg = {
		Name = "Uncommon Egg",
		Price = 5000,
		Color = Color3.new(0.1, 0.9, 0.2),
		Weight = 50
	},
	AdvancedEgg = {
		Name = "Advanced Egg",
		Price = 100_000,
		Color = Color3.new(0.1, 0.5, 0.9),
		Weight = 20
	},
	RareEgg = {
		Name = "Rare Egg",
		Price = 5_000_000,
		Color = Color3.new(1, 0.4, 1),
		Weight = 10
	},
	EpicEgg = {
		Name = "Epic Egg",
		Price = 100_000_000,
		Color = Color3.new(0.4, 0.0, 1.0),
		Weight = 3
	},
	LegendaryEgg = {
		Name = "Legendary Egg",
		Price = 2_500_000_000,
		Color = Color3.new(1, 1, 0),
		Weight = 1
	}
}

return eggInfo