DEFENDERS_COUNT_X = 8
DEFENDERS_COUNT_Y = 6

DefenderTable = {}

Defender = createClass({
    hp = 0,
    name = "",

    constructor = function(self, hp, name)
        self.hp = hp
        self.name = name
    end
}, {
    kek = "ues"
}, nil)


function Defender:say()
    print(self.hp)
    print(self.name)
    print(self.kek)
end