; @Authors: LAPEYRADE Sylvain; sylla801
;           BOURAKKADI Reda; redbo196
; @File: Problem 1
; @Task: 1. Implementation of the alternative 2: Shakey's World
;   Problem 1:
;   Shakey must move the two toys to room 3 and get back to room 1
;   with the lights of room 1, 2 and 3 turned off
; @ Usage:
; FF: /courses/TDDC17/bin/ff -o task1/shakey_domain.pddl -f task1/shakey_problem1.pddl
; Lama: /courses/TDDC17/bin/downward/src/lama task1/shakey_domain.pddl task1/shakey_problem1.pddl
 
(define (problem problem1) (:domain shakey_world)
(:objects
    shakey gripper1 gripper2
    room1 room2 room3
    door1 door2 door3
    lightswitch1 lightswitch2 lightswitch3
    box toy1 toy2
)

(:init ; Initial state
    (is_connected room1 room2 door1) (is_connected room2 room1 door1)
    (is_connected room1 room2 door2) (is_connected room2 room1 door2)
    (is_connected room2 room3 door3) (is_connected room3 room2 door3)
    (is_wide door2) (is_wide door3)
    (is_in lightswitch1 room1) (is_switch lightswitch1)
    (is_in lightswitch2 room2) (is_switch lightswitch2)
    (is_in lightswitch3 room3) (is_switch lightswitch3)
    (is_in shakey room1) (is_shakey shakey)
    (is_gripper_free gripper1) (is_gripper_free gripper2)
    (is_box box) (is_in box room1)
    (is_small toy1) (is_small toy2) (is_in toy1 room1) (is_in toy2 room2)
)

(:goal ; Final State
    (and(is_in toy1 room3)
        (is_in toy2 room3)
        (not(is_light_on lightswitch1))
        (not(is_light_on lightswitch2))
        (not(is_light_on lightswitch3))
        (is_in shakey room1))
)
)