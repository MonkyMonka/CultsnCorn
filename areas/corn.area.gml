#define init

#macro DEBUG true// remember to set to false before sharing

    if DEBUG{
        trace("Press 6 to access CORN area");
        if fork(){
            while(mod_exists("area", mod_current)){
                with(Player) if button_pressed(index, "key6"){
                    with instance_create(x, y, Portal) endgame = 5;
                    with(GameCont){
                        area = mod_current;
                        subarea = 0;
                    }
                }
                wait(0);
            }
            exit;
        }
    }
#define area_name
return "ZZZ";

#define area_sprite(q)
switch (q) {
    case sprFloor1: return sprFloor0;
    case sprFloor1B: return sprFloor0;
    case sprFloor1Explo: return sprFloor0Explo;
    case sprWall1Trans: return sprWall0Trans;
    case sprWall1Bot: return sprWall0Bot;
    case sprWall1Out: return sprWall0Out;
    case sprWall1Top: return sprWall0Top;
    case sprDebris1: return sprDebris0;
}

#define area_transit
if (lastarea != "test" && area == 2) {
    area = "test";
}

#define area_finish
area = 2;
subarea = 1;

#define area_setup
goal = 40;
background_color = make_color_rgb(106, 122, 175);
BackCont.shadcol = c_black;
TopCont.fog = sprFog2;

#define area_make_floor
instance_create(x, y, Floor);
var turn = choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 90, -90, 90, -90, 180);
direction += turn;
if (turn == 180 && point_distance(x, y, 10016, 10016) > 48) {
    // turnarounds - weapon chests spawn in such
    instance_create(x, y, Floor);
    instance_create(x + 16, y + 16, WeaponChest);
}
if (random(19 + instance_number(FloorMaker)) > 22) {
    // dead ends - ammo chests spawn in such
    if (point_distance(x, y, 10016, 10016) > 48) {
        instance_create(x + 16, y + 16, AmmoChest);
        instance_create(x, y, Floor);
    }
    instance_destroy();
} else if (random(4) < 1) {
    // branching
    instance_create(x, y, FloorMaker);
}

#define area_pop_enemies
if (random(4) < 1) instance_create(x + 16, y + 16, Bandit);

#define area_pop_props
if (random(4) < 1) instance_create(x + 16, y + 16, NightCactus);

#define area_mapdata(lx, ly, lp, ls, ws, ll)
return [lx, 9];