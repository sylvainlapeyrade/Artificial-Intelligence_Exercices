from lab1.liuvacuum import *

DEBUG_OPT_DENSEWORLDMAP = False

AGENT_STATE_UNKNOWN = 0
AGENT_STATE_WALL = 1
AGENT_STATE_CLEAR = 2
AGENT_STATE_DIRT = 3
AGENT_STATE_HOME = 4

AGENT_DIRECTION_NORTH = 0
AGENT_DIRECTION_EAST = 1
AGENT_DIRECTION_SOUTH = 2
AGENT_DIRECTION_WEST = 3


def direction_to_string(cdr):
    cdr %= 4
    return "NORTH" if cdr == AGENT_DIRECTION_NORTH else\
        "EAST" if cdr == AGENT_DIRECTION_EAST else\
        "SOUTH" if cdr == AGENT_DIRECTION_SOUTH else\
        "WEST"  # if dir == AGENT_DIRECTION_WEST


"""
Internal state of a vacuum agent
"""


class MyAgentState:

    def __init__(self, width, height):

        # Initialize perceived world state
        self.world = [[AGENT_STATE_UNKNOWN for _ in range(
            height)] for _ in range(width)]
        self.world[1][1] = AGENT_STATE_HOME

        # Agent internal state
        self.last_action = ACTION_NOP
        self.direction = AGENT_DIRECTION_EAST
        self.pos_x = 1
        self.pos_y = 1

        # Metadata
        self.world_width = width
        self.world_height = height

    """
    Update perceived agent location
    """

    def update_position(self, bump):
        if not bump and self.last_action == ACTION_FORWARD:
            if self.direction == AGENT_DIRECTION_EAST:
                self.pos_x += 1
            elif self.direction == AGENT_DIRECTION_SOUTH:
                self.pos_y += 1
            elif self.direction == AGENT_DIRECTION_WEST:
                self.pos_x -= 1
            elif self.direction == AGENT_DIRECTION_NORTH:
                self.pos_y -= 1

    """
    Update perceived or inferred information about a part of the world
    """

    def update_world(self, x, y, info):
        self.world[x][y] = info

    """
    Dumps a map of the world as the agent knows it
    """

    def print_world_debug(self):
        for y in range(self.world_height):
            for x in range(self.world_width):
                if self.world[x][y] == AGENT_STATE_UNKNOWN:
                    print("?" if DEBUG_OPT_DENSEWORLDMAP else " ? ", end="")
                elif self.world[x][y] == AGENT_STATE_WALL:
                    print("#" if DEBUG_OPT_DENSEWORLDMAP else " # ", end="")
                elif self.world[x][y] == AGENT_STATE_CLEAR:
                    print("." if DEBUG_OPT_DENSEWORLDMAP else " . ", end="")
                elif self.world[x][y] == AGENT_STATE_DIRT:
                    print("D" if DEBUG_OPT_DENSEWORLDMAP else " D ", end="")
                elif self.world[x][y] == AGENT_STATE_HOME:
                    print("H" if DEBUG_OPT_DENSEWORLDMAP else " H ", end="")

            print()  # Newline
        print()  # Delimiter post-print


"""
Vacuum agent
"""


class MyVacuumAgent(Agent):

    def __init__(self, world_width, world_height, log):
        super().__init__(self.execute)
        self.initial_random_actions = 10
        self.iteration_counter = world_width * world_width * 5
        self.state = MyAgentState(world_width, world_height)
        self.log = log

        # *** OUR CUSTOM VARIABLES ***
        self.direction_stack = []
        self.direction_home_stack = []
        self.home_found = False

    def move_to_random_start_position(self, bump):
        action = random()

        self.initial_random_actions -= 1
        self.state.update_position(bump)

        if action < 0.1666666:   # 1/6 chance
            self.state.direction = (self.state.direction + 3) % 4
            self.state.last_action = ACTION_TURN_LEFT
            return ACTION_TURN_LEFT
        elif action < 0.3333333:  # 1/6 chance
            self.state.direction = (self.state.direction + 1) % 4
            self.state.last_action = ACTION_TURN_RIGHT
            return ACTION_TURN_RIGHT
        else:                    # 4/6 chance
            self.state.last_action = ACTION_FORWARD
            return ACTION_FORWARD

    def execute(self, percept):

        ###########################
        # DO NOT MODIFY THIS CODE #
        ###########################

        bump = percept.attributes["bump"]
        dirt = percept.attributes["dirt"]
        home = percept.attributes["home"]

        # Move agent to a randomly chosen initial position
        if self.initial_random_actions > 0:
            self.log("Moving to random start position ({} steps left)".format(
                self.initial_random_actions))
            return self.move_to_random_start_position(bump)

        # Finalize randomization by properly updating position
        #  (without subsequently changing it)
        elif self.initial_random_actions == 0:
            self.initial_random_actions -= 1
            self.state.update_position(bump)
            self.state.last_action = ACTION_SUCK
            self.log("Processing percepts after position randomization")
            return ACTION_SUCK

        ########################
        # START MODIFYING HERE #
        ########################

        # Max iterations for the agent
        if self.iteration_counter < 1:
            if self.iteration_counter == 0:
                self.iteration_counter -= 1
                self.log("Iteration counter is now 0. Halting!")
                self.log("Performance: {}".format(self.performance))
            return ACTION_NOP

        self.log("Position: ({}, {})\t\tDirection: {}".
                 format(self.state.pos_x, self.state.pos_y,
                        direction_to_string(self.state.direction)))

        self.iteration_counter -= 1

        # Track position of agent
        self.state.update_position(bump)

        if bump:
            # Get an xy-offset pair based on where the agent is facing
            offset = [(0, -1), (1, 0), (0, 1), (-1, 0)][self.state.direction]

            # Mark the tile at the offset from the agent as a wall
            #  (since the agent bumped into it)
            self.state.update_world(
                self.state.pos_x + offset[0],
                self.state.pos_y + offset[1], AGENT_STATE_WALL)

        # Update perceived state of current tile
        if dirt:
            self.state.update_world(
                self.state.pos_x, self.state.pos_y, AGENT_STATE_DIRT)
        else:
            self.state.update_world(
                self.state.pos_x, self.state.pos_y, AGENT_STATE_CLEAR)

        # Debug
        self.state.print_world_debug()

        # *************************************************
        # *********** OUR ADDITIONS START HERE ************
        # It is an implementation of Depth-First Algorithm
        #     The queue has been modeled with a stack
        # *************************************************

        # Generic method to know if a pile have been visited or not
        def is_pile_visited(pile):
            if pile is AGENT_STATE_UNKNOWN or pile is AGENT_STATE_HOME:
                return False
            else:
                return True

        # Test if the tile in front of the agent has been visited
        def front_tile_visited():
            if self.state.direction == AGENT_DIRECTION_EAST:
                return is_pile_visited(
                    self.state.world[self.state.pos_x + 1][self.state.pos_y])
            elif self.state.direction == AGENT_DIRECTION_SOUTH:
                return is_pile_visited(
                    self.state.world[self.state.pos_x][self.state.pos_y + 1])
            elif self.state.direction == AGENT_DIRECTION_WEST:
                return is_pile_visited(
                    self.state.world[self.state.pos_x - 1][self.state.pos_y])
            elif self.state.direction == AGENT_DIRECTION_NORTH:
                return is_pile_visited(
                    self.state.world[self.state.pos_x][self.state.pos_y - 1])
            return False

        # Test if the tile at the right of the agent has been visited
        def right_tile_visited():
            if self.state.direction == AGENT_DIRECTION_EAST:
                return is_pile_visited(
                    self.state.world[self.state.pos_x][self.state.pos_y + 1])
            elif self.state.direction == AGENT_DIRECTION_SOUTH:
                return is_pile_visited(
                    self.state.world[self.state.pos_x - 1][self.state.pos_y])
            elif self.state.direction == AGENT_DIRECTION_WEST:
                return is_pile_visited(
                    self.state.world[self.state.pos_x][self.state.pos_y - 1])
            elif self.state.direction == AGENT_DIRECTION_NORTH:
                return is_pile_visited(
                    self.state.world[self.state.pos_x + 1][self.state.pos_y])
            return False

        # Test if the tile at the left of the agent has been visited
        def left_tile_visited():
            if self.state.direction == AGENT_DIRECTION_EAST:
                return is_pile_visited(
                    self.state.world[self.state.pos_x][self.state.pos_y - 1])
            elif self.state.direction == AGENT_DIRECTION_SOUTH:
                return is_pile_visited(
                    self.state.world[self.state.pos_x + 1][self.state.pos_y])
            elif self.state.direction == AGENT_DIRECTION_WEST:
                return is_pile_visited(
                    self.state.world[self.state.pos_x][self.state.pos_y + 1])
            elif self.state.direction == AGENT_DIRECTION_NORTH:
                return is_pile_visited(
                    self.state.world[self.state.pos_x - 1][self.state.pos_y])
            return False

        # Make the agent move forward from his direction
        def agent_go_forward():
            self.state.last_action = ACTION_FORWARD
            return ACTION_FORWARD

        # Make the agent turn right from his direction
        def agent_turn_right():
            self.state.direction = (self.state.direction + 1) % 4
            self.state.last_action = ACTION_TURN_RIGHT
            return ACTION_TURN_RIGHT

        # Make the agent turn right from his direction
        def agent_turn_left():
            self.state.direction = (self.state.direction + 3) % 4
            self.state.last_action = ACTION_TURN_LEFT
            return ACTION_TURN_LEFT

        # Return the opposed direction from the agent
        def opposed_direction(direction):
            if direction is AGENT_DIRECTION_SOUTH:
                return AGENT_DIRECTION_NORTH
            elif direction is AGENT_DIRECTION_NORTH:
                return AGENT_DIRECTION_SOUTH
            elif direction is AGENT_DIRECTION_EAST:
                return AGENT_DIRECTION_WEST
            elif direction is AGENT_DIRECTION_WEST:
                return AGENT_DIRECTION_EAST

        # If the opposed direction of the agent is right :
        #   It makes it turn right, otherwise it turns left
        def agent_turn_back(opposed_direction):
            if (opposed_direction == AGENT_DIRECTION_EAST and
                self.state.direction == AGENT_DIRECTION_NORTH) or \
                (opposed_direction == AGENT_DIRECTION_NORTH and
                    self.state.direction == AGENT_DIRECTION_WEST) or \
                (opposed_direction == AGENT_DIRECTION_WEST and
                    self.state.direction == AGENT_DIRECTION_SOUTH) or \
                (opposed_direction == AGENT_DIRECTION_SOUTH and
                    self.state.direction == AGENT_DIRECTION_EAST):
                return agent_turn_right()
            else:
                return agent_turn_left()

        # Make the agent go back from where it started
        def agent_go_back():
            direction = self.direction_stack[-1]
            if self.state.direction == opposed_direction(direction):
                self.direction_stack.pop()
                return agent_go_forward()
            else:
                return agent_turn_back(opposed_direction(direction))

        # Make the agent go back the home position once he encoutered it
        def agent_go_back_home():
            direction = self.direction_home_stack[-1]
            if self.state.direction == opposed_direction(direction):
                self.direction_home_stack.pop()
                return agent_go_forward()
            else:
                return agent_turn_back(opposed_direction(direction))

        # Stop the agent and informs the simulator the cleaning is finished
        def cleaning_done():
            self.iteration_counter = 0  # Does not stop without setting
            # iteration_counter to 0, might be a bug since it works on java
            self.state.last_action = ACTION_NOP
            return ACTION_NOP

        #  Decide action
        if dirt:
            self.log("DIRT -> choosing SUCK action!")
            self.state.last_action = ACTION_SUCK
            return ACTION_SUCK
        else:
            # If first at home position, home_found = True
            if self.state.pos_x == 1 and self.state.pos_y == 1:
                if self.home_found is False:
                    self.home_found = True
            # Remove the last direction from the stacks as
            # we don't want to store bumps
            if bump:
                if len(self.direction_stack) > 0:
                    self.direction_stack.pop()
                if len(self.direction_home_stack) > 0:
                    self.direction_home_stack.pop()
            # Add direction of front tiles to the stacks if not visited
            if front_tile_visited() is False:
                self.direction_stack.append(self.state.direction)
                # Add direction only once the home is visited
                if self.home_found is True:
                    self.direction_home_stack.append(self.state.direction)
                return agent_go_forward()
            # Else if one of the side tiles is not visited: turn
            elif left_tile_visited() is False:
                return agent_turn_left()
            elif right_tile_visited() is False:
                return agent_turn_right()

            # If agent at home positon, and direction_stack empty,
            # then the agent has to have visited all tiles (DFS)
            if self.state.pos_x == 1 and self.state.pos_y == 1:
                if len(self.direction_stack) < 1:
                    cleaning_done()

            if len(self.direction_stack) > 0:
                return agent_go_back()
            elif len(self.direction_home_stack) > 0:
                return agent_go_back_home()
            else:
                self.iteration_counter = 0
                self.state.last_action = ACTION_NOP
                return ACTION_NOP
