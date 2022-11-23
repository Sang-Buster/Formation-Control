%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---Communication-aware Formation Control_v1.0---%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
clc;


%% ---Initialize all parameters--- %%
max_times   = 1000;
h           = 1;
swarm_size  = 7;
alpha       = 10^(-5);                  % system parameter about antenna characteristics
delta       = 2;                        % required application data rate
v           = 3;                        % path loss exponent
r0          = 5;                        % reference antenna near-field
PT          = 0.94;                     % reception probability threshold
Beta        = alpha*(2^delta-1);
varphi_rij  = 0;


%% ---Initialize agents' position--- %%
swarm=[-5  14
       -5 -19
        0   0
       20  21
       35  41
       68   0
       72  13
       72 -18];   %System of 7+1 Agents

% swarm=[-5  14
%        -5 -19
%         0   0
%        20  21
%        32  33
%        35  41
%        68   0
%        72  13
%        72 -18];   %System of 7+2 Agents


%% ---Initialize the velocity--- %%
for j = 1:size(swarm, 1)
    speed(j,1) = 0;
    speed(j,2) = 0;
end


%% ---Initialize video--- %%
myVideo = VideoWriter('System_of_7+1_Agents.avi');
myVideo.FrameRate = 24;
open(myVideo)


%% Closed-loop dynamics of the unicycle model with Dubins constraints.
%  Kaveh Fathian's Code Refference, 2017-2018, https://sites.google.com/view/kavehfathian/code/formation-control-of-fixed-wing-uavs
addpath('FindControlGainMatrix');

% % Desired formation coordinates
qs = [0    -2    -2    -2    -4    -4    -4    -1
      0    -1     1     0    -2     2     0     1];               %System of 7+1 Agents

% qs = [0    -2    -2    -2    -4    -4    -4    -1    1
%       0    -1     1     0    -2     2     0     1    1];          %System of 7+2 Agents


% % Random initial heading angles
theta0  = [0 0 0 0 0 0 0 0 0].';                                                                                %System of 7+1 Agents
% theta0  = [6.2150    0.4206    5.9024    0.1142    4.2967    4.9244    3.3561    5.5629    3.1415].';           %System of 7+2 Agents

% Graph adjacency matrix
adj = [0 1 1 1 1 1 1 0
       1 0 1 0 0 0 1 0
       1 1 0 1 0 0 0 0
       1 0 1 0 1 0 0 0
       1 0 0 1 0 1 0 0
       1 0 0 0 1 0 1 1
       1 1 0 0 0 1 0 1
       0 0 0 0 0 1 1 0];      %System of 7+1 Agents

% adj =  [0 1 1 1 1 1 1 0 0
%         1 0 1 0 0 0 1 0 0
%         1 1 0 1 0 0 0 0 1
%         1 0 1 0 1 0 0 0 1
%         1 0 0 1 0 1 0 0 0
%         1 0 0 0 1 0 1 1 0
%         1 1 0 0 0 1 0 1 0
%         0 0 0 0 0 1 1 0 0
%         0 0 1 1 0 0 0 0 0];     %System of 7+2 Agents


n           = size(swarm,1);                                     % Number of agents
state0      = [swarm(:); theta0];                                % Initial state
q           = state0(1:2*n);                                     % Position vector
A           = FindGains(qs(:), adj);                             % Control Gain Matrix,  Requires CVX! Download CVX from:  http://cvxr.com/cvx/

vSat        = [3, 5];                                            % Speed range
omegaSat    = [-pi/4, pi/4];                                     % Allowed heading angle rate of change
p_i         = [1; 0];                                            % Desired direction of motion
theta       = state0(2*n+1: 3*n);                                % Heading
H           = zeros(2*n, n);                                     % Heading matrix
Hp          = zeros(2*n, n);                                     % Perpendicular heading matrix
R           = [0 -1; 1 0];                                       % 90 degree roation matrix
hi          = [cos(theta).'; sin(theta).'];
hi          = hi(:);

for i = 1 : n
    H(2*i-1:2*i,i)  = hi(2*i-1:2*i);
    Hp(2*i-1:2*i,i) = R *hi(2*i-1:2*i);
end

% Constant speed
p = mean(vSat) * repmat(p_i, n,1);

% Speed limiter
vCtrl       = H.'* A*q;
vSatMean    = mean(vSat);
vMin        = ones(size(vCtrl)) * (vSat(1)-vSatMean);
vMax        = ones(size(vCtrl)) * (vSat(2)-vSatMean);
vCtrl       = max(vCtrl, vMin);
vCtrl       = min(vCtrl, vMax);

% Heading angle rate of change limiter
omegaCtrl   = Hp.' * A*q;
omegaMin    = ones(size(omegaCtrl)) * omegaSat(1);
omegaMax    = ones(size(omegaCtrl)) * omegaSat(2);
omegaCtrl   = max(omegaCtrl, omegaMin);
omegaCtrl   = min(omegaCtrl, omegaMax);

% Control
V           = H.' * p + vCtrl;
omega       = Hp.' * p + omegaCtrl;

% Speed limiter
vMin        = ones(size(V)) * vSat(1);
vMax        = ones(size(V)) * vSat(2);
V           = max(V, vMin);
V           = min(V, vMax);

% Heading angle rate of change limiter
omegaMin    = ones(size(omega)) * omegaSat(1);
omegaMax    = ones(size(omega)) * omegaSat(2);
omega       = max(omega, omegaMin);
omega       = min(omega, omegaMax);
dtheta      = omega;


%% Performance Indicators Jn and rn
t_Elapsed = 0;
Jn        = 0;
rn        = 0;

figure(1)
Jn_Plot = plot(t_Elapsed, Jn);                  % Plot Jn 
pos1 = get(gcf,'Position');                     % get position of Figure(1) 
set(gcf,'Position', pos1 - [pos1(3)/2,0,0,0])   % Shift position of Figure(1)
xlabel('$t(s)$', 'Interpreter','latex', 'FontSize', 12, 'Rotation', 0)
ylabel('$J_n$', 'Interpreter','latex', 'FontSize', 12, 'Rotation', 0)
axis ([0 250 0.97, 0.98]);

figure(2)
rn_Plot = plot(t_Elapsed, rn);                  % Plot rn
pos2 = get(gcf,'Position');                     % get position of Figure(2)
set(gcf,'Position', pos2 + [pos1(3)/2,0,0,0])   % Shift position of Figure(2)
xlabel('$t(s)$', 'Interpreter','latex', 'FontSize', 12, 'Rotation', 0)
ylabel('$r_n$', 'Interpreter','latex', 'FontSize', 12, 'Rotation', 0)
axis equal;

drawnow                                         % Force a graphics refresh so that isn't counted in our elapsed time


%% ---Formation Control Algorithmn--- %%
tic
for k=1:max_times
    for i=1:n
        for j=[1:(i-1),(i+1):swarm_size]
            rij=sqrt((swarm(i,1)-swarm(j,1))^2+(swarm(i,2)-swarm(j,2))^2);
            gij=rij/sqrt(rij^2+r0^2);
            aij=exp(-alpha*(2^delta-1)*(rij/r0)^v);
            if aij>=PT
                varphi_rij=(-Beta*v*rij^(v+2)-Beta*v*(r0^2)*(rij^v)+r0^(v+2))*exp(-Beta*(rij/r0)^v)/sqrt((rij^2+r0^2)^3);
            else
                varphi_rij=0;
            end
            phi_rij=gij*aij;
            qi=[swarm(i,1),swarm(i,2)];
            qj=[swarm(j,1),swarm(j,2)];
            nd=(qi-qj)/sqrt(1+norm(qi-qj));    % For swarms traveling at E direction and Faster Convergence
%             nd=(qi-qj)/norm(qi-qj);            % For swarms traveling at NE direction
            speed(i,1)=speed(i,1)+varphi_rij*nd(1);
            speed(i,2)=speed(i,2)+varphi_rij*nd(2);
        end
        %---Gradient Term---%
        swarm(i,1)=swarm(i,1)+speed(i,1);
        swarm(i,2)=swarm(i,2)+speed(i,2);
        speed(i,1)=0;
        speed(i,2)=0;

        %---Consensus Term---%
        Consensus_ui=H*V;

        %---Line of Sight---%
        rho_i=atan2(swarm(i,2)-swarm(j,2), swarm(i,1)-swarm(j,1));
        
        t_Elapsed=cat(1, t_Elapsed, toc);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %----Average Communication Performance Indicator----%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Jn=cat(1, Jn, phi_rij);
        Jn=smooth(Jn);
        set(Jn_Plot, 'xdata', t_Elapsed, 'ydata', Jn);      % Plot Jn
        pause(0);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %----Average Neighboring Distance Indicator Indicator----%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        rn=cat(1, rn, rij);
        rn=smooth(rn);
        set(rn_Plot, 'xdata', t_Elapsed, 'ydata', rn);      % Plot rn
        pause(0);
         
    end
    swarm(:,1)=swarm(:,1)+(1/7)*V.*cos(theta);                     % For swarms traveling at E direction
    swarm(:,2)=swarm(:,2)+(1/7)*V.*sin(theta);                     % For swarms traveling at E direction
%     swarm(:,1)=swarm(:,1)+Consensus_ui(1:8).*cos(rho_i-theta);     % For swarms traveling at NE direction
%     swarm(:,2)=swarm(:,2)+Consensus_ui(9:16).*cos(rho_i-theta);    % For swarms traveling at NE direction

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %------------------Plot Swarms---------------%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(3);
    dt = delaunayTriangulation(swarm(:, 1), swarm(:, 2));           % Compute the Delaunay triangulation
    edgeIndex = edges(dt);                                          % Triangulation edge indices
    triplot(dt,'-o');                                               % Plot the Delaunay triangulation
    hold on                                                         % Plot agents' directional vector arrows.
    vecarrow_x=swarm(:, 1)./sqrt(swarm(:, 1).^2+swarm(:, 2).^2);    % Plot Arrows
    vecarrow_y=swarm(:, 2)./sqrt(swarm(:, 1).^2+swarm(:, 2).^2);
    quiver(swarm(:, 1), swarm(:, 2), vecarrow_x, vecarrow_y, 0.3, 'r');
    hold off
    axis equal;
    pause(0)
    frame = getframe(gcf);
    writeVideo(myVideo, frame);                                     % convert the image to frames

end

close(myVideo)

