;; Domain definition file

(define (domain shakey)
  (:requirements :strips);; only strips is required for this domain

  ;; predicates definitions

  (:predicates

    ;; statics
    (connected ?room-1 ?room-2 ?door) ;; rooms are connected through a door
    (wide ?door) ;; a door can be wide opened or narrow
    (pushable ?item) ;; an item can be pushable
    (climbable ?item) ;; a box can be climbable
    (carriable ?item) ;; a small item can be carriable
    (movable ?object) ;; shakey can move, any other object can not !
    (switchable ?object) ;; a switch is a switchable object

    ;; dynamics
    (carry ?item ?arm)
    (arm ?arm)
    (free ?arm) ;; arm is free
    (in ?what ?room)
    (turnedOn ?light) ;; a light can be turned on
    (on ?who) ;; shakey can be on an object
    )

  ;; Shakey can move from a room to another as long as they are
  ;; connected through a door.

  (:action move
    :parameters (?who ?from ?to ?door)
    :precondition (and (connected ?from ?to ?door)
      (in ?who ?from)
      (not(on ?who))
      (movable ?who))
    :effect  (and (not (in ?who ?from))
      (in ?who ?to))
  )

  ;; Shakey can push a pushable item from a room to another as long
  ;; as they are connected through a wide door. At the end Shakey and the
  ;; object are in the destination room.

  (:action push
    :parameters (?who ?item ?from ?to ?door)
    :precondition (and (connected ?from ?to ?door)
      (in ?who ?from)
      (not(on ?who))
      (movable ?who)
      (in ?item ?from)
      (pushable ?item)
      (wide ?door))

    :effect  (and (not (in ?who ?from))
      (in ?who ?to)
      (not(in ?item ?from))
      (in ?item ?to))
    )

  ;; Shakey can climb on a box to access a lightswitch. The box must be
  ;;climbable and in the same room as shakey.

  (:action climb
    :parameters (?who ?box ?room)
    :precondition (and (in ?who ?room)
      (in ?box ?room)
      (movable ?who);;only shakey can climb !
      (not(on ?who))
      (climbable ?box))

    :effect(on ?who)
    )

  ;; But then to continue, he has to descend

  (:action descend
    :parameters (?who)
    :precondition (and(on ?who)
      (movable ?who))
    :effect(not(on ?who))
    )

  ;;Turnin on the light imply being in the same room as the lightswitch
  ;; and being on a box.

  (:action turnon
    :parameters(?who ?light ?room)
    :precondition(and(on ?who)
      (in ?who ?room)
      (in ?light ?room)
      (switchable ?light)
      (not(turnedOn ?light)))
    :effect(turnedOn ?light)
    )

  ;; Shakey can pick small carriable objects with his two grippers
  ;; The chosen grippers must be free  and light must be turned on
  ;; in the room

  (:action pickup
    :parameters(?who ?item ?room ?light ?arm)
    :precondition(and(in ?who ?room)
      (in ?light ?room)
      (in ?item ?room)
      (turnedOn ?light)
      (carriable ?item)
      (movable ?who)
      (not(on ?who))
      (arm ?arm);
      (free ?arm);
      )

    :effect(and(not(in ?item ?room))
      (carry ?item ?arm);
      (not(free ?arm)));
    )

    ;; Then Shakey can drop the item in another room

  (:action drop
    :parameters(?who ?item ?room ?arm)
    :precondition(and
      (arm ?arm)
      (carry ?item ?arm)
      (movable ?who)
      (in ?who ?room)
      (not(on ?who)))

    :effect(and
      (not(carry ?item ?arm))
      (free ?arm)
      (in ?item ?room))
    )
)