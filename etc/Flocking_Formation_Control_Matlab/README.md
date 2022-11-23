#  MSN Flocking Formation Control-MATLAB Version

This is a MATLAB implementation of "Flocking for multi-agent dynamic systems: Algorithms and theory" by Olfati-Saber, Reza. You can find the article using these links: [IEEE](https://ieeexplore.ieee.org/abstract/document/1605401), [PDF](https://sci-hub.yncjkj.com/10.1109/TAC.2005.864190).

---

## Installation

Install MATLAB to your system, copy the directory `src` to your MATLAB directory or any other directory and open and run any of the files - MSN1.m, MSN2.m, MSN3.m, MSN4.m, MSN5.m, MSN6.m and MSN6switching.m for the 7 cases explained below respectively.

## Project parameters:
- Number of sensor nodes: n =100.
- Space dimensions: m = 2.
- Desired distance among sensor node: d = 15.
- Scaling factor: k = 1.2 and interaction range r = k*d.
- Epsilon = 0.1 and Delta_t = 0.009 (These two parameters are optional and you can change them).

## Cases

### Case 1 - MSN Fragmentation

**Filename: MSN1.m**

- Randomly generates a connected network of 100 nodes in the area of 50x50. 
- Plots the initial deployment of the MSN of 100 nodes.
- Links the neighboring nodes together by a line. 

#### Plots
- Plots the fragmentation of the nodes.
- Plots the velocity.
- Plots the connectivity.
- Plots the trajectory.

#### Algorithm 1:

<img src='alg_img/alg1.JPG' width=500px>
<img src='alg_img/alg11.JPG' width=500px>
<img src='alg_img/alg12.JPG' width=500px>
<img src='alg_img/alg13.JPG' width=500px>


### Case 2 - Implements MSN Quasi-Lattice Formation with **static target**

**Filename: MSN2.m**

- Randomly generates a connected network of 100 nodes in the area of 50x50. 
- Sets up a target (gamma agent) as static point with its coordinate (x = 150, y =150). 
- Implements flocking behavior of the MSN.

#### Algorithm 2 for Case 2:

<img src='alg_img/alg2.JPG' width=500px>

#### Plots
- Plots the flocking of the nodes.
- Plots the velocity.
- Plots the connectivity.
- Plots the trajectory.


### Case 3 - Implements MSN Quasi-Lattice Formation with **dynamic target (Sine wave trajectory)**

**Filename: MSN3.m**

- Randomly generates a connected network of 100 nodes in the area of 150x150. 
- Sets up a target (gamma agent) moving in a **sine wave trajectory.** 
- Implements flocking behavior of the MSN.

#### Algorithm 2 for Case 3:

<img src='alg_img/alg21.JPG' width=500px>

#### Plots
- Plots the flocking of the nodes following the target (Sine wave trajectory).
- Plots the velocity.
- Plots the connectivity.
- Plots the trajectory.
- Plots the center of mass and target trajectory.


### Case 4 - Implements MSN Quasi-Lattice Formation with **dynamic target  (Circular trajectory)**

**Filename: MSN4.m**

- Randomly generates a connected network of 100 nodes in the area of 150x150. In this case you
- Sets up a target (gamma agent) moving in a **circular trajectory.** 
- Implements flocking behavior of the MSN.

#### Algorithm 2 for Case 3 (Same equation, change the values to make it a circular trajectory):

<img src='alg_img/alg21.JPG' width=500px>

#### Plots
- Plots the flocking of the nodes following the target (Circular trajectory).
- Plots the velocity.
- Plots the connectivity.
- Plots the trajectory.
- Plots the center of mass and target trajectory.


### Case 5 - Implements MSN Quasi-Lattice Formation with **obstacle avoidance**

**Filename: MSN5.m**

- Randomly generates a connected network of 100 nodes in the area of 50x50. 
- Sets up a target (gamma agent) at the location of (200, 25). 
- Sets up an obstacle, circular in shape with a radius of 15 and its center location at (100,25). 
- Implements flocking behavior of the MSN avoiding obstacles.

#### Algorithm 3:

<img src='alg_img/alg3.JPG' width=500px>
<img src='alg_img/alg31.JPG' width=500px>
<img src='alg_img/alg32.JPG' width=500px>

#### Plots
- Plots the flocking of the nodes following the target, avoiding obstacles.
- Plots the velocity.
- Plots the connectivity.
- Plots the trajectory.
- Plots the center of mass and target trajectory.



### Case 6 - Implements Leaderless Multi-Agent Flocking

**Filename: MSN6.m, MSN6switching.m**

This is a Leaderless Multi-Agent Flocking, governed by inter-agent potential and a network graph.

**Reference**:
H. G. Tanner, A. Jadbabaie and G. J. Pappas, "Flocking in Fixed and Switching Networks," in IEEE Transactions on Automatic Control, vol. 52, no. 5, pp. 863-868, May 2007, doi: 10.1109/TAC.2007.895948.



---

**Credit**: [arjunhw97](https://github.com/arjunhw97/MSN-Flocking-Formation-Control) and [ap3885](https://github.com/ap3885/Multi-Agent-Flocking)

