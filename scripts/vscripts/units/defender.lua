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