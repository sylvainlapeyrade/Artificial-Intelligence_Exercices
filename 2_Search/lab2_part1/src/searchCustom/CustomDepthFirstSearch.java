package searchCustom;

// import java.util.Random;

public class CustomDepthFirstSearch extends CustomGraphSearch {

	public CustomDepthFirstSearch(int maxDepth) {
		// super(new Random().nextBoolean()); // Temporary random choice, you need to
		// true or false!
		super(true); // True since DFS uses LIFO queue
		// System.out.println("Change line above in \"CustomDepthFirstSearch.java\"!");
	}
};
