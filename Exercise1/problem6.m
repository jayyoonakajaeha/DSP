% 6. Find the projection of a 2D orthogonal vector example (e.g., [1,0], [0,2]).

% Define 2D orthogonal vectors
v = [3, 4];
u = [-4, 3];

dot_product = dot(v, u);
fprintf('Inner product of the vectors: %d\n', dot_product);
projection_v_on_u = (dot(v, u) / norm(u)^2) * u;
disp('The projection of v=[3,4] onto u=[-4,3] is:');
disp(projection_v_on_u);

figure;
hold on;
quiver(0, 0, v(1), v(2), 0, 'b', 'LineWidth', 2, 'MaxHeadSize', 0.4);
quiver(0, 0, u(1), u(2), 0, 'g', 'LineWidth', 2, 'MaxHeadSize', 0.4);
plot(projection_v_on_u(1), projection_v_on_u(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
axis equal;
grid on;
xlim([-5 5]);
ylim([-5 5]);
title('Projection of Orthogonal Vectors');
xlabel('x-axis');
ylabel('y-axis');
legend('Vector v = [3, 4]', 'Vector u = [-4, 3]', 'Projection (Zero Vector)', 'Location', 'northwest');
hold off;