-- Lista todas las citas con datos del paciente, médico y servicio
SELECT c.id_cita, c.fecha, c.hora, p.nombre AS paciente, m.nombre AS medico, s.nombre_servicio
FROM CITAS c
JOIN PACIENTES p ON c.id_paciente = p.id_paciente
JOIN MEDICO m ON c.id_medico = m.id_medico
JOIN SERVICIOS s ON c.id_servicio = s.id_servicio;

-- Cuenta cuántas citas tiene cada paciente
SELECT p.nombre, COUNT(c.id_cita) AS total_citas
FROM PACIENTES p
LEFT JOIN CITAS c ON p.id_paciente = c.id_paciente
GROUP BY p.id_paciente, p.nombre;

-- Pacientes con más de 2 citas
SELECT p.nombre, COUNT(c.id_cita) AS total_citas
FROM PACIENTES p
JOIN CITAS c ON p.id_paciente = c.id_paciente
GROUP BY p.id_paciente, p.nombre
HAVING COUNT(c.id_cita) > 2;

-- Total facturado por médico
SELECT m.nombre, SUM(f.monto) AS total_facturado
FROM MEDICO m
JOIN CITAS c ON m.id_medico = c.id_medico
JOIN FACTURAS f ON c.id_cita = f.id_cita
GROUP BY m.id_medico, m.nombre;

-- Servicios con precio promedio mayor a 50
SELECT nombre_servicio, AVG(precio) AS precio_promedio
FROM SERVICIOS
GROUP BY nombre_servicio
HAVING AVG(precio) > 50;

-- Última cita de cada paciente
SELECT p.nombre, c.fecha, c.hora
FROM PACIENTES p
JOIN CITAS c ON p.id_paciente = c.id_paciente
WHERE c.fecha = (
    SELECT MAX(fecha) 
    FROM CITAS 
    WHERE id_paciente = p.id_paciente
);

-- Pacientes que no tienen citas
SELECT nombre
FROM PACIENTES p
WHERE NOT EXISTS (
    SELECT 1 FROM CITAS c WHERE c.id_paciente = p.id_paciente
);

-- Total pagado y pendiente por paciente
SELECT p.nombre,
       SUM(CASE WHEN f.estado_pago = 'Pagado' THEN f.monto ELSE 0 END) AS total_pagado,
       SUM(CASE WHEN f.estado_pago = 'Pendiente' THEN f.monto ELSE 0 END) AS total_pendiente
FROM PACIENTES p
JOIN CITAS c ON p.id_paciente = c.id_paciente
JOIN FACTURAS f ON c.id_cita = f.id_cita
GROUP BY p.id_paciente, p.nombre;

-- Médicos que atienden más de 3 pacientes distintos
SELECT m.nombre, COUNT(DISTINCT c.id_paciente) AS pacientes_atendidos
FROM MEDICO m
JOIN CITAS c ON m.id_medico = c.id_medico
GROUP BY m.id_medico, m.nombre
HAVING pacientes_atendidos > 3;

-- Servicios que no han sido utilizados en ninguna cita
SELECT nombre_servicio
FROM SERVICIOS
WHERE id_servicio NOT IN (
    SELECT DISTINCT id_servicio FROM CITAS
);
