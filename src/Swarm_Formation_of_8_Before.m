% Communication-aware Formation Control (v_1.0)
clear all;
close all;
clc;

% Initialize all parameters
max_times  = 1000;
h          = 1;
swarm_size = 7;
alpha       = 10^(-5);                 % system parameter about antenna characteristics
delta       = 2;                       % required application data rate
Beta        = alpha*(2^delta-1);
v           = 3;                       % path loss exponent
r0          = 5;                       % reference antenna near-field
PT          = 0.94;                    % reception probability threshold
rho_ij      = 0;


% Initialize agents' position
swarm = [-5,  14;   -5,  -19;   0,  0;   20, 20;
         35,  -4;   68,    0;  72,  13;  72,-18];    


% Initialize the velocity
for j = 1:swarm_size
    speed(j,1) = 0;
    speed(j,2) = 0;
end


%---Performance Indicators---%
t_Elapsed = 0;
Jn        = 0;
rn        = 0;

figure(1)
Jn_Plot = plot(t_Elapsed, Jn);                  % Plot Jn 
pos1 = get(gcf,'Position');                     % get position of Figure(1) 
set(gcf,'Position', pos1 - [pos1(3)/2,0,0,0])   % Shift position of Figure(1)
xlabel('$t(s)$', 'Interpreter','latex', 'FontSize', 12, 'Rotation', 0)
ylabel('$J_n$', 'Interpreter','latex', 'FontSize', 12, 'Rotation', 0)
axis ([0 100 0.97, 0.98]);

figure(2)
rn_Plot = plot(t_Elapsed, rn);                  % Plot rn
pos2 = get(gcf,'Position');                     % get position of Figure(2) 
set(gcf,'Position', pos2 + [pos1(3)/2,0,0,0])   % Shift position of Figure(2)
xlabel('$t(s)$', 'Interpreter','latex', 'FontSize', 12, 'Rotation', 0)
ylabel('$r_n$', 'Interpreter','latex', 'FontSize', 12, 'Rotation', 0)
axis equal;

drawnow                                         % Force a graphics refresh so that isn't counted in our elapsed time


tic
for k=1:max_times
    for i=1:swarm_size
        rho_ij=0;
        for j=[1:(i-1),(i+1):swarm_size]
            rij=sqrt((swarm(i,1)-swarm(j,1))^2+(swarm(i,2)-swarm(j,2))^2);
            aij=exp(-alpha*(2^delta-1)*(rij/r0)^v);
            gij=rij/sqrt(rij^2+r0^2);
            if aij>=PT
                rho_ij=(-Beta*v*rij^(v+2)-Beta*v*(r0^2)*(rij^v)+r0^(v+2))*exp(-Beta*(rij/r0)^v)/sqrt((rij^2+r0^2)^3);
            else
                rho_ij=0;
            end
            phi_rij=gij*aij;
            qi=[swarm(i,1),swarm(i,2)];
            qj=[swarm(j,1),swarm(j,2)];
            nd=(qi-qj)/sqrt(1+norm(qi-qj));
            speed(i,1)=speed(i,1)+rho_ij*nd(1);
            speed(i,2)=speed(i,2)+rho_ij*nd(2);
        end
        swarm(i,1)=swarm(i,1)+speed(i,1)*h;
        swarm(i,2)=swarm(i,2)+speed(i,2)*h;
        speed(i,1)=0;
        speed(i,2)=0;
        
        t_Elapsed=cat(1, t_Elapsed, toc);

        %---Average Communication Performance Indicator---%
        Jn=cat(1, Jn, phi_rij);
        Jn=smooth(Jn);
        set(Jn_Plot, 'xdata', t_Elapsed, 'ydata', Jn);      % Plot Jn
        pause(0);

        %---Average Neighboring Distance Indicator---%
        rn=cat(1, rn, rij);
        rn=smooth(rn);
        set(rn_Plot, 'xdata', t_Elapsed, 'ydata', rn);      % Plot rn
        pause(0);

    end

    %---Plot Swarms---%
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

end

