public class StateAndReward {

	/* Angle properties */
	private static final int angle_state = 20;
	private static final double min_angle = -Math.PI / 5;
	private static final double max_angle = Math.PI / 5;
	// private static final double min_angle = -Math.PI;
	// private static final double max_angle = Math.PI;

	/* Velocity X properties */
	private static final int velocityX_state = 5;
	private static final double min_velocityX = -0.5;
	private static final double max_velocityX = 0.5;
	// private static final int velocityX_state = 10;
	// private static final double min_velocityX = -20;
	// private static final double max_velocityX = 20;

	/* Velocity Y properties */
	private static final int velocityY_state = 10;
	private static final double min_velocityY = -0.5;
	private static final double max_velocityY = 0.5;
	// private static final int velocityY_state = 20;
	// private static final double min_velocityY = -20;
	// private static final double max_velocityY = 20;

	/* State discretization function for the angle controller */
	public static String getStateAngle(double angle, double vx, double vy) {

		/* TODO: IMPLEMENT THIS FUNCTION */
		String state = "State angle:" + discretize(angle, angle_state, min_angle, max_angle);

		return state;
	}

	/* Reward function for the angle controller */
	public static double getRewardAngle(double angle, double vx, double vy) {

		/* TODO: IMPLEMENT THIS FUNCTION */
		double reward = Math.PI - Math.abs(angle);

		return reward;
	}

	/* State discretization function for the full hover controller */
	public static String getStateHover(double angle, double vx, double vy) {

		/* TODO: IMPLEMENT THIS FUNCTION */
		String vx_state = " vx_state:" + discretize(vx, velocityX_state, min_velocityX, max_velocityX);
		String vy_state = " vy_state:" + discretize(vy, velocityY_state, min_velocityY, max_velocityY);

		String state = getStateAngle(angle, vx, vy) + vx_state + vy_state;

		return state;
	}

	/* Reward function for the full hover controller */
	public static double getRewardHover(double angle, double vx, double vy) {

		/* TODO: IMPLEMENT THIS FUNCTION */
		double angle_reward = getRewardAngle(angle, vx, vy) / Math.PI;
		double hover_reward = (20 - Math.abs(vx) + 20 - Math.abs(vy)) / 40;

		return angle_reward + hover_reward;
	}

	// ///////////////////////////////////////////////////////////
	// discretize() performs a uniform discretization of the
	// value parameter.
	// It returns an integer between 0 and nrValues-1.
	// The min and max parameters are used to specify the interval
	// for the discretization.
	// If the value is lower than min, 0 is returned
	// If the value is higher than min, nrValues-1 is returned
	// otherwise a value between 1 and nrValues-2 is returned.
	//
	// Use discretize2() if you want a discretization method that does
	// not handle values lower than min and higher than max.
	// ///////////////////////////////////////////////////////////
	public static int discretize(double value, int nrValues, double min, double max) {
		if (nrValues < 2) {
			return 0;
		}

		double diff = max - min;

		if (value < min) {
			return 0;
		}
		if (value > max) {
			return nrValues - 1;
		}

		double tempValue = value - min;
		double ratio = tempValue / diff;

		return (int) (ratio * (nrValues - 2)) + 1;
	}

	// ///////////////////////////////////////////////////////////
	// discretize2() performs a uniform discretization of the
	// value parameter.
	// It returns an integer between 0 and nrValues-1.
	// The min and max parameters are used to specify the interval
	// for the discretization.
	// If the value is lower than min, 0 is returned
	// If the value is higher than min, nrValues-1 is returned
	// otherwise a value between 0 and nrValues-1 is returned.
	// ///////////////////////////////////////////////////////////
	public static int discretize2(double value, int nrValues, double min, double max) {
		double diff = max - min;

		if (value < min) {
			return 0;
		}
		if (value > max) {
			return nrValues - 1;
		}

		double tempValue = value - min;
		double ratio = tempValue / diff;

		return (int) (ratio * nrValues);
	}

}
