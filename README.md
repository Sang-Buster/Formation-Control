<h1 align="center">Flocking Algorithm and Formation Control</h1>

<h6 align="center"><small>Python and MATLAB implementations of Flocking Algorithm and Formation Control Algorithm.</small></h6>

<p align="center"><b>#Unmanned Aerial Vehicles &emsp; #Multi-agent Systems  &emsp; #Communication-aware <br/> #Decentralized  &emsp; #Distributed  &emsp; #Consensus-based  &emsp; #Formation Control</b></p>

</br>

&emsp; Over the past few decades, unmanned aerial vehicle (UAV) technology has played a significant role in military and civilian applications. To meet the challenges of the future, in addition to improving the functionality and utility of individual aircraft, there is a need to consider how to develop more effective UAV management and organizations. Consequently, among the many developments in UAVs, formation control has become an important concept in recent years. Formation control requires multiple UAVs to adapt to the mission including generate a formation, stay in formation, and change formation. In this paper, we further constrain the formation controller model, not only estimate the desired separation with acceptable accuracy but also ensure a consensus among estimates. Thus, optimizes the overall communication performance of a dynamical multi-agent system.

<table>
  <tr>
    <th>Paper</th>
    <th>Presentation</th>
  </tr>
  <tr>
    <td align="center">
          <a href="https://github.com/Sang-Buster/Formation-Control/blob/main/lib/Xing_paper.pdf"><img src="https://github.com/Sang-Buster/Formation-Control/blob/main/img/Paper.png?raw=true" /></a>
          <a href="https://github.com/Sang-Buster/Formation-Control/blob/main/lib/Xing_paper.pdf"><img src="https://img.shields.io/badge/View%20More-282c34?style=for-the-badge&logoColor=white" width="100" /></a>
    </td>
    <td align="center">
          <a href="https://github.com/Sang-Buster/Formation-Control/blob/main/lib/Xing_ppt.pdf"><img src="https://github.com/Sang-Buster/Formation-Control/blob/main/img/Presentation.png?raw=true" /></a>
          <a href="https://github.com/Sang-Buster/Formation-Control/blob/main/lib/Xing_ppt.pdf"><img src="https://img.shields.io/badge/View%20More-282c34?style=for-the-badge&logoColor=white" width="100" /></a>
    </td>
  </tr>
</table>

<h2 align="center">Simulation</h2>

<h4 align="Center">Before Proposed with 7+1 Agents According to [3]</h4>
<p align="center">
<img src="https://github.com/Sang-Buster/Formation-Control/blob/main/img/Before.gif?raw=true" width="350">
</p>

<h4 align="Center">After Proposed with 7+1 Agents</h4>

<div align="center">
<table>
  <tr>
    <th>8 Agents Traveling at NE Direction</th>
    <th>8 Agents Traveling at E Direction</th>
  </tr>
  <tr>
    <td><p align="center"><img src="img/After_NE-Direction.gif" width="380"></p></td>
    <td><p align="center"><img src="img/After_E-Direction.gif" width="380"></p></td>
  </tr>
</table>
</div>
</br>

**PS**: In order to run `src/Swarm_Formation_of_8_After.m`, it is required to have a Matlab-based modeling system for convex optimization ([CVX](http://cvxr.com/cvx/))! You can install CVX at [here](http://cvxr.com/cvx/download/), and sign up for a free license at [here](http://cvxr.com/cvx/licensing/).

<h2 align="center">BibTeX Citation</h2>

```
@INPROCEEDINGS{10115199,
  author={Xing, Sang and Yang, Thomas and Song, Houbing},
  booktitle={SoutheastCon 2023}, 
  title={Consensus-based Communication-aware Formation Control for a Mobile Multi-agent System}, 
  year={2023},
  volume={},
  number={},
  pages={60-67},
  doi={10.1109/SoutheastCon51012.2023.10115199}}
```

<h2 align="center">References</h2>

[[1]](https://github.com/Sang-Buster/Formation-Control/blob/main/lib/Olfati-Saber.pdf) R. Olfati-Saber, "*Flocking for multi-agent dynamic systems: algorithms and theory*," in IEEE Transactions on Automatic Control, vol. 51, no. 3, pp. 401-420, March 2006. doi: 10.1109/TAC.2005.864190

[[2]](https://github.com/Sang-Buster/Formation-Control/blob/main/lib/Tanner.pdf) H. G. Tanner, A. Jadbabaie and G. J. Pappas, "*Flocking in Fixed and Switching Networks*," in IEEE Transactions on Automatic Control, vol. 52, no. 5, pp. 863-868, May 2007. doi: 10.1109/TAC.2007.895948

[[3]](https://github.com/Sang-Buster/Formation-Control/blob/main/lib/Li.pdf) H. Li, J. Peng, W. Liu, K. Gao, and Z. Huang, “*A novel communication-aware formation control strategy for dynamical multi-agent systems*,” Journal of the Franklin Institute, vol. 352, no. 9, pp. 3701-3715, Sep. 2015.

[[4]](https://github.com/Sang-Buster/Formation-Control/blob/main/lib/Fathian.pdf) K. Fathian, T. H. Summers, and N. R. Gans, “*Distributed formation control and navigation of fixed-wing UAVs at constant altitude*,” in 2018 International Conference on Unmanned Aircraft Systems (ICUAS), 2018.

---

**Credit for `etc` folder**: [arjunhw97](https://github.com/arjunhw97/MSN-Flocking-Formation-Control), [amirhosseinh77](https://github.com/amirhosseinh77/Flocking-Multi-Agent), [paul-shuvo](https://github.com/paul-shuvo/MSN-Flocking-Formation-Control), [ap3885](https://github.com/ap3885/Multi-Agent-Flocking), and [harveydevereux](https://github.com/harveydevereux/Consensus)
