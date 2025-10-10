% 5. Create an animation of the rotation of e^jtheta in the complex plane. (unit circle animation)

figure('Name', 'e^{j\theta} Rotation');
hold on;
grid on;
axis equal;
axis([-1.5 1.5 -1.5 1.5]);
title('Animation of e^{j\theta} in the Complex Plane', 'Interpreter', 'tex');
xlabel('Real Axis');
ylabel('Imaginary Axis');
theta_circle = linspace(0, 2*pi, 200);
plot(cos(theta_circle), sin(theta_circle), 'g--', 'LineWidth', 1);
plot([-1.5 1.5], [0 0], 'g-');
plot([0 0], [-1.5 1.5], 'g-');
h_vector = plot([0 1], [0 0], 'b-', 'LineWidth', 2.5);
h_point = plot(1, 0, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
h_text = text(0.1, 1.3, 'Angle (\theta) = 0.00 rad', 'FontSize', 12, 'FontWeight', 'bold');
for theta = linspace(0, 2*pi, 300)
    x = cos(theta);
    y = sin(theta);
    set(h_vector, 'XData', [0 x], 'YData', [0 y]);
    set(h_point, 'XData', x, 'YData', y);
    set(h_text, 'String', sprintf('Angle (\\theta) = %.2f rad', theta));
    pause(0.05);
end