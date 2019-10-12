
; @Authors: LAPEYRADE Sylvain; sylla801
;           BOURAKKADI Reda; redbo196
; @File: Domain shakey_world definition 
; @Task: 1. Implementation of the alternative 2: Shakey's World

(define (domain shakey_world)

(:requirements :strips) ; Only strips required

(:predicates ;Properties of objects 
    ;; statics -- properties always true
    (is_connected ?room_a ?room_b ?door) ; Shakey can go from room_a to room_b through a door
    (is_wide ?door) ; Door are either wide or narrow (box can be pushed only through wide)
    (is_box ?object) ; Only boxes can be pushed and climbed upon
    (is_small ?object) ; Only small objects can be carried
    (is_switch ?object) ; Only lights switches can be switched
    (is_shakey ?object) ; Only Shakey can move, climb, switch light, pick and push objects

    ;; dynamics -- properties that can be changed
    (is_gripper_free ?gripper) ; If at least one gripper is free
    (is_object_gripped ?object ?gripper) ; If an object is hold in a grip
    (is_in ?object ?room) ; If the object is in the room
    (is_on_box ?shakey) ; If Shakey is on a box
    (is_light_on ?light) ; If the light is on
)


;; Shakey move from room_a to room_b 
;; if they are adjacent and connected through a door
;; and if Shakey is not on a box
(:action move_room
:parameters (?shakey ?room_a ?room_b ?door)
:precondition (and(is_shakey ?shakey)
                (is_in ?shakey ?room_a)
                (is_connected ?room_a ?room_b ?door)
                (not(is_on_box ?shakey)))
:effect (and(not (is_in ?shakey ?room_a))
                (is_in ?shakey ?room_b))
)

;; Shakey climb to a box if they are in the same room
(:action climb_box
:parameters (?shakey ?box ?room)
:precondition (and(is_shakey ?shakey)
                (is_in ?shakey ?room)
                (is_in ?box ?room)
                (is_box ?box)
                (not(is_on_box ?shakey)))
:effect(is_on_box ?shakey)
)

;; Shakey descend from a box if they are in the same room
;; and if he is already on a box
(:action descend_box
:parameters (?shakey ?box ?room)
:precondition (and(is_shakey ?shakey)
                (is_in ?shakey ?room)
                (is_in ?box ?room)
                (is_on_box ?shakey))
:effect(not(is_on_box ?shakey))
)

;; Shakey can turn the light on if he is in the same room as the light switch
;; and if he is on a box
(:action turn_on_light
:parameters (?shakey ?light ?room)
:precondition (and(is_shakey ?shakey)
                (is_on_box ?shakey)
                (is_in ?shakey ?room)
                (is_in ?light ?room)
                (is_switch ?light)
                (not(is_light_on ?light)))
:effect (is_light_on ?light)
)

;; Shakey can turn the light off if he is in the same room as the light switch on
;; and if he is on a box
(:action turn_off_light
:parameters (?shakey ?light ?room)
:precondition (and(is_shakey ?shakey)
                (is_on_box ?shakey)
                (is_in ?shakey ?room)
                (is_in ?light ?room)
                (is_switch ?light)
                (is_light_on ?light))
:effect (not(is_light_on ?light))
)

;; Shakey can push an object to another room if it is a box,
;; if they are in the same room, and if the door is wide.
(:action push_box
:parameters (?shakey ?box ?room_a ?room_b ?door)
:precondition (and(is_shakey ?shakey)
                (is_box ?box)
                (is_connected ?room_a ?room_b ?door)
                (is_wide ?door)
                (is_in ?shakey ?room_a)
                (is_in ?box ?room_a)
                (not(is_on_box ?box)))
:effect (and(not(is_in ?shakey ?room_a))
            (is_in ?shakey ?room_b)
            (not(is_in ?box ?room_a))
            (is_in ?box ?room_b))
)


;; Shakey can pick an object in the room if the object is small and
;; if the gripper selected is free
;; Also light must be turned on in the room
(:action pick_object
:parameters(?shakey ?object ?gripper ?room ?light)
:precondition(and(is_shakey ?shakey)
                (is_in ?shakey ?room)
                (is_in ?object ?room)
                (is_in ?light ?room)
                (is_light_on ?light)
                (is_small ?object)
                (is_gripper_free ?gripper);
                (not(is_on_box ?shakey)))
:effect(and(not(is_in ?object ?room))
            (is_object_gripped ?object ?gripper);
            (not(is_gripper_free ?gripper)));
)

;; Shakey can drop an object in the current room if he is holding one
(:action drop_object
:parameters(?shakey ?object ?gripper ?room)
:precondition(and(is_shakey ?shakey)
                (is_in ?shakey ?room)
                (is_object_gripped ?object ?gripper)
                (not(is_on_box ?shakey)))
:effect(and(is_in ?object ?room)
            (not(is_object_gripped ?object ?gripper))
            (is_gripper_free ?gripper))
)

)