insert into Area (id,area_description,go_east) values (1,"There's nothing in this room but a door in the east.",2);
insert into Area (id,area_description,go_south,go_west) values (2,"What a nice smell in here. Doors are in the south and west.",3,1);
insert into Area (id,area_description,go_north,go_south,go_west) values (3,"You entered a huge hall with random numbers in it. You can see three doors.",2,6,4);
insert into Area (id,area_description,go_east,go_west) values (4,"The light is broken, but you can see a creature in the corner between the two doors in the east and west.",3,5);
insert into Area (id,area_description,go_east) values (5,"There's a huge Chuck Norris picture at the wall and the door you're came from.",4);
insert into Area (id,area_description,go_north,go_south) values (6,"It looks like a bath. You can go north or south.",3,7);
insert into Area (id,area_description,go_north) values (7,"There's a chest in the middle of the room, a skylight and a door behind you.",6);

insert into Item (id,item_description,name,use_action,takeable,area_id) values (1,"It's a round glas table.","table","examine",0,2);
insert into Item (id,item_description,name,use_action,takeable,area_id) values (2,"Do not eat this cake!","cake","eat die",1,2);
insert into Item (id,item_description,name,use_action,takeable,area_id) values (3,"The missing number of some game. But why is it here??","missingno","catch",0,3);
insert into Item (id,item_description,name,use_action,takeable,area_id) values (4,"It's a pokeball. Maybe you're in the wrong game?","pokeball","missingno die",1,3);
insert into Item (id,item_description,name,use_action,takeable,area_id) values (5,"A small, green man is sitting in the corner. Maybe he speaks your language.","man","ask",0,4);
insert into Item (id,item_description,name,use_action,takeable,area_id) values (6,"This is a chair for testing.","testchair","examine",0,5);
insert into Item (id,item_description,name,use_action,takeable,area_id) values (7,"A bottle filled with a red liquid.","bottle","use",1,5);
insert into Item (id,item_description,name,use_action,takeable,area_id) values (8,"A big painting of Chuck Norris.","painting","examine",0,5);
insert into Item (id,item_description,name,use_action,takeable,area_id) values (9,"A small wooden chest. What might be in it?","chest","open",0,7);
insert into Item (id,item_description,name,use_action,takeable,area_id) values (10,"It's small black key. It might be good for opening something.","key","chest win",1,5);
