begin_version
3
end_version
begin_metric
0
end_metric
10
begin_variable
var0
-1
3
Atom is_in(box, room1)
Atom is_in(box, room2)
Atom is_in(box, room3)
end_variable
begin_variable
var1
-1
2
Atom is_on_box(shakey)
NegatedAtom is_on_box(shakey)
end_variable
begin_variable
var2
-1
2
Atom is_gripper_free(gripper1)
NegatedAtom is_gripper_free(gripper1)
end_variable
begin_variable
var3
-1
2
Atom is_gripper_free(gripper2)
NegatedAtom is_gripper_free(gripper2)
end_variable
begin_variable
var4
-1
3
Atom is_in(shakey, room1)
Atom is_in(shakey, room2)
Atom is_in(shakey, room3)
end_variable
begin_variable
var5
-1
2
Atom is_light_on(lightswitch1)
NegatedAtom is_light_on(lightswitch1)
end_variable
begin_variable
var6
-1
2
Atom is_light_on(lightswitch2)
NegatedAtom is_light_on(lightswitch2)
end_variable
begin_variable
var7
-1
2
Atom is_light_on(lightswitch3)
NegatedAtom is_light_on(lightswitch3)
end_variable
begin_variable
var8
-1
5
Atom is_in(toy1, room1)
Atom is_in(toy1, room2)
Atom is_in(toy1, room3)
Atom is_object_gripped(toy1, gripper1)
Atom is_object_gripped(toy1, gripper2)
end_variable
begin_variable
var9
-1
5
Atom is_in(toy2, room1)
Atom is_in(toy2, room2)
Atom is_in(toy2, room3)
Atom is_object_gripped(toy2, gripper1)
Atom is_object_gripped(toy2, gripper2)
end_variable
2
begin_mutex_group
3
2 0
8 3
9 3
end_mutex_group
begin_mutex_group
3
3 0
8 4
9 4
end_mutex_group
begin_state
0
1
0
0
0
1
1
1
0
1
end_state
begin_goal
6
4 0
5 1
6 1
7 1
8 2
9 2
end_goal
58
begin_operator
climb_box shakey box room1
2
0 0
4 0
1
0 1 1 0
1
end_operator
begin_operator
climb_box shakey box room2
2
0 1
4 1
1
0 1 1 0
1
end_operator
begin_operator
climb_box shakey box room3
2
0 2
4 2
1
0 1 1 0
1
end_operator
begin_operator
descend_box shakey box room1
2
0 0
4 0
1
0 1 0 1
1
end_operator
begin_operator
descend_box shakey box room2
2
0 1
4 1
1
0 1 0 1
1
end_operator
begin_operator
descend_box shakey box room3
2
0 2
4 2
1
0 1 0 1
1
end_operator
begin_operator
descend_box shakey lightswitch1 room1
1
4 0
1
0 1 0 1
1
end_operator
begin_operator
descend_box shakey lightswitch2 room2
1
4 1
1
0 1 0 1
1
end_operator
begin_operator
descend_box shakey lightswitch3 room3
1
4 2
1
0 1 0 1
1
end_operator
begin_operator
descend_box shakey shakey room1
1
4 0
1
0 1 0 1
1
end_operator
begin_operator
descend_box shakey shakey room2
1
4 1
1
0 1 0 1
1
end_operator
begin_operator
descend_box shakey shakey room3
1
4 2
1
0 1 0 1
1
end_operator
begin_operator
descend_box shakey toy1 room1
2
4 0
8 0
1
0 1 0 1
1
end_operator
begin_operator
descend_box shakey toy1 room2
2
4 1
8 1
1
0 1 0 1
1
end_operator
begin_operator
descend_box shakey toy1 room3
2
4 2
8 2
1
0 1 0 1
1
end_operator
begin_operator
descend_box shakey toy2 room1
2
4 0
9 0
1
0 1 0 1
1
end_operator
begin_operator
descend_box shakey toy2 room2
2
4 1
9 1
1
0 1 0 1
1
end_operator
begin_operator
descend_box shakey toy2 room3
2
4 2
9 2
1
0 1 0 1
1
end_operator
begin_operator
drop_object shakey toy1 gripper1 room1
2
4 0
1 1
2
0 2 -1 0
0 8 3 0
1
end_operator
begin_operator
drop_object shakey toy1 gripper1 room2
2
4 1
1 1
2
0 2 -1 0
0 8 3 1
1
end_operator
begin_operator
drop_object shakey toy1 gripper1 room3
2
4 2
1 1
2
0 2 -1 0
0 8 3 2
1
end_operator
begin_operator
drop_object shakey toy1 gripper2 room1
2
4 0
1 1
2
0 3 -1 0
0 8 4 0
1
end_operator
begin_operator
drop_object shakey toy1 gripper2 room2
2
4 1
1 1
2
0 3 -1 0
0 8 4 1
1
end_operator
begin_operator
drop_object shakey toy1 gripper2 room3
2
4 2
1 1
2
0 3 -1 0
0 8 4 2
1
end_operator
begin_operator
drop_object shakey toy2 gripper1 room1
2
4 0
1 1
2
0 2 -1 0
0 9 3 0
1
end_operator
begin_operator
drop_object shakey toy2 gripper1 room2
2
4 1
1 1
2
0 2 -1 0
0 9 3 1
1
end_operator
begin_operator
drop_object shakey toy2 gripper1 room3
2
4 2
1 1
2
0 2 -1 0
0 9 3 2
1
end_operator
begin_operator
drop_object shakey toy2 gripper2 room1
2
4 0
1 1
2
0 3 -1 0
0 9 4 0
1
end_operator
begin_operator
drop_object shakey toy2 gripper2 room2
2
4 1
1 1
2
0 3 -1 0
0 9 4 1
1
end_operator
begin_operator
drop_object shakey toy2 gripper2 room3
2
4 2
1 1
2
0 3 -1 0
0 9 4 2
1
end_operator
begin_operator
move_room shakey room1 room2 door1
1
1 1
1
0 4 0 1
1
end_operator
begin_operator
move_room shakey room1 room2 door2
1
1 1
1
0 4 0 1
1
end_operator
begin_operator
move_room shakey room2 room1 door1
1
1 1
1
0 4 1 0
1
end_operator
begin_operator
move_room shakey room2 room1 door2
1
1 1
1
0 4 1 0
1
end_operator
begin_operator
move_room shakey room2 room3 door3
1
1 1
1
0 4 1 2
1
end_operator
begin_operator
move_room shakey room3 room2 door3
1
1 1
1
0 4 2 1
1
end_operator
begin_operator
pick_object shakey toy1 gripper1 room1 lightswitch1
3
4 0
5 0
1 1
2
0 2 0 1
0 8 0 3
1
end_operator
begin_operator
pick_object shakey toy1 gripper1 room2 lightswitch2
3
4 1
6 0
1 1
2
0 2 0 1
0 8 1 3
1
end_operator
begin_operator
pick_object shakey toy1 gripper1 room3 lightswitch3
3
4 2
7 0
1 1
2
0 2 0 1
0 8 2 3
1
end_operator
begin_operator
pick_object shakey toy1 gripper2 room1 lightswitch1
3
4 0
5 0
1 1
2
0 3 0 1
0 8 0 4
1
end_operator
begin_operator
pick_object shakey toy1 gripper2 room2 lightswitch2
3
4 1
6 0
1 1
2
0 3 0 1
0 8 1 4
1
end_operator
begin_operator
pick_object shakey toy1 gripper2 room3 lightswitch3
3
4 2
7 0
1 1
2
0 3 0 1
0 8 2 4
1
end_operator
begin_operator
pick_object shakey toy2 gripper1 room1 lightswitch1
3
4 0
5 0
1 1
2
0 2 0 1
0 9 0 3
1
end_operator
begin_operator
pick_object shakey toy2 gripper1 room2 lightswitch2
3
4 1
6 0
1 1
2
0 2 0 1
0 9 1 3
1
end_operator
begin_operator
pick_object shakey toy2 gripper1 room3 lightswitch3
3
4 2
7 0
1 1
2
0 2 0 1
0 9 2 3
1
end_operator
begin_operator
pick_object shakey toy2 gripper2 room1 lightswitch1
3
4 0
5 0
1 1
2
0 3 0 1
0 9 0 4
1
end_operator
begin_operator
pick_object shakey toy2 gripper2 room2 lightswitch2
3
4 1
6 0
1 1
2
0 3 0 1
0 9 1 4
1
end_operator
begin_operator
pick_object shakey toy2 gripper2 room3 lightswitch3
3
4 2
7 0
1 1
2
0 3 0 1
0 9 2 4
1
end_operator
begin_operator
push_box shakey box room1 room2 door2
0
2
0 0 0 1
0 4 0 1
1
end_operator
begin_operator
push_box shakey box room2 room1 door2
0
2
0 0 1 0
0 4 1 0
1
end_operator
begin_operator
push_box shakey box room2 room3 door3
0
2
0 0 1 2
0 4 1 2
1
end_operator
begin_operator
push_box shakey box room3 room2 door3
0
2
0 0 2 1
0 4 2 1
1
end_operator
begin_operator
turn_off_light shakey lightswitch1 room1
2
4 0
1 0
1
0 5 0 1
1
end_operator
begin_operator
turn_off_light shakey lightswitch2 room2
2
4 1
1 0
1
0 6 0 1
1
end_operator
begin_operator
turn_off_light shakey lightswitch3 room3
2
4 2
1 0
1
0 7 0 1
1
end_operator
begin_operator
turn_on_light shakey lightswitch1 room1
2
4 0
1 0
1
0 5 1 0
1
end_operator
begin_operator
turn_on_light shakey lightswitch2 room2
2
4 1
1 0
1
0 6 1 0
1
end_operator
begin_operator
turn_on_light shakey lightswitch3 room3
2
4 2
1 0
1
0 7 1 0
1
end_operator
0
