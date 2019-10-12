import numpy as np
import matplotlib.pyplot as plt

batch_size = [1, 10, 100, 1000, 60000]
time = [138, 15, 3, 1, 1]
accuracy = [0.8127, 0.8262, 0.8185, 0.7242, 0.4960]

# plt.plot(batch_size, time)
plt.plot(batch_size, time)

# naming the x axis
plt.xlabel('Batch Size')
# naming the y axis
plt.ylabel('Time')

# giving a title to my graph
plt.title('Time in relation to Batch Size')

# function to show the plot
plt.show()
