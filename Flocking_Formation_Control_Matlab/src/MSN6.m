clear all; close all; clc;

%initialize random values for initial r and v at time 0
r_x(1,:) = [3, 6, 9, 10, 11, 13, 15, 16, 12, 11];
r_y(1,:) = [3, 7, 9, 11, 13, 5, 7, 9, 12, 11];
v_x(1,:) = [0, 0.2, 0.5, 0.4, 0.2, 0.1, 0.4, 0.5, 0.6, 0.8];
v_y(1,:) = [0.9, 0.3, 0.4, 0.1, 0.3, 0.8, 0.7, 06., 0.5, 0.4];

%strong adjacency matrix
%A = [0 1 1 1 1;
%     1 0 1 1 1;
%     1 1 0 1 1;
%     1 1 1 0 1;
%     1 1 1 1 0];

%randomly generated adjacency matrix
N = 10;
A = randi(2,N,N) - 1;
A = A - tril(A,-1) + triu(A,1)'; 

%A=[0 0 1 0 0;%strong
% 1 0 0 0 0;
% 0 1 0 0 1;
% 0 0 1 0 0;
% 0 0 0 1 0];
 
%initializing number of iterations, number of agents, R and timestep
iter = 1000;
R = 0.5;
dt = 0.01;

%starting iterations
for t = 1:iter
    
    %update position vector of each agent
    for i = 1:N
        r_x(t + 1,i) = r_x(t,i) + dt * v_x(t,i);
        r_y(t + 1,i) = r_y(t,i) + dt * v_y(t,i);
    end
    
    sumvel_x = zeros(1,N);
    sumvel_y = zeros(1,N);
    
    %calculating the first part of ui
    for i = 1:N
        for j = 1:N
            if A(i,j)==1
                sumvel_x(i) = sumvel_x(i) + v_x(t,i) - v_x(t,j);
                sumvel_y(i) = sumvel_y(i) + v_y(t,i) - v_y(t,j);
            end
        end
    end
    
    difpot_x = zeros(1,N);
    difpot_y = zeros(1,N);
    
    rmin = 0;
    
    %calculating a1, a2 and gradient of potential function V
    for i = 1:N 
        for j = 1:N
            if i~=j
                r(i,j) = sqrt((r_x(t,i) - r_x(t,j))^2 + (r_y(t,i) - r_y(t,j))^2);
                rmin = min(r,[],'all');
            end
        end
    end
    
    a1 = 1 / (rmin + R);
    a2 = (rmin * R) / (rmin + R);
    
    for i = 1:N 
        for j = 1:N
            if i~=j
                r(i,j) = sqrt((r_x(t,i) - r_x(t,j))^2 + (r_y(t,i) - r_y(t,j))^2);
                p_x = 0;
                p_y = 0;
                if r(i,j) <= R && r(i,j)>0
                    p1_x = -a1 * (r_x(t,i) - r_x(t,j)) / r(i,j);
                    p1_y = -a1 * (r_y(t,i) - r_y(t,j)) / r(i,j);
                    p2_x = (r_x(t,i) - r_x(t,j)) / (r(i,j)^2);
                    p2_y = (r_y(t,i) - r_y(t,j)) / (r(i,j)^2);
                    p3_x = -a2 * (r_x(t,i) - r_x(t,j)) / (r(i,j)^3);
                    p3_y = -a2 * (r_y(t,i) - r_y(t,j)) / (r(i,j)^3);
                    p_x = p1_x + p2_x + p3_x;
                    p_y = p1_y + p2_y + p3_y;
                end
            difpot_x(i) = difpot_x(i) + p_x;
            difpot_y(i) = difpot_y(i) + p_y;
            end
        end
    end
    
    u_x = zeros(1,N);
    u_y = zeros(1,N);
    
    %calculating the final control input for each agent
    for i = 1:N
        u_x(i) = - sumvel_x(i) - difpot_x(i);
        u_y(i) = - sumvel_y(i) - difpot_y(i);
    end
    
    %updating the velocity vectors of each agent
    for i = 1:N
        v_x(t + 1,i) = v_x(t,i) + dt * u_x(i);
        v_y(t + 1,i) = v_y(t,i) + dt * u_y(i);
    end
end

%plotting results
figure();
subplot(2,1,1);
for i = 1:N
    plot([1:(iter+1)],sqrt((v_x(:,i)).^2 + v_y(:,i).^2),'-');
    hold on;
    title('Convergence of the magnitude of velocity vector of the agents');
    xlabel('iterations')
    ylabel('magnitude of velocity vector');
    legend
end

subplot(2,1,2);
for i = 1:N
    plot([1:(iter+1)],atan(v_y(:,i)./v_x(:,i)),'-');
    hold on;
    title('Convergence of the angle of velocity vector of the agents');
    xlabel('iterations');
    ylabel('angle of velocity vector');
end

figure();
for i = 1:N
    plot3(r_x(:,i),r_y(:,i),[1:(iter+1)]);
    rotate3d on;
    hold on;
    title('inter-agent distances converge');
    xlabel('position_x(m)')
    ylabel('position_y(m)')
    zlabel('iterations')
    legend
end
