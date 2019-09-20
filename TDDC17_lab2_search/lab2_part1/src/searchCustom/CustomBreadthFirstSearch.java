package searchCustom;

// import java.util.Random;

public class CustomBreadthFirstSearch extends CustomGraphSearch {

	public CustomBreadthFirstSearch(int maxDepth) {
		// Temporary random choice, you need to true or false!
		// super(new Random().nextBoolean());
		super(false); // False since BFS uses FIFO queue
		// System.out.println("Change line above in "CustomBreadthFirstSearch.java\"!");
	}
};
