-- CASO 1: Registrar un nuevo paciente
CALL RegistrarPaciente(23, 'Mateo Andrade', '3001122334', 'mateo.andrad@gmail.com', 'Calle 45 #12-34', 3);

-- CASO 2: Obtener citas de un paciente específico
CALL ObtenerCitasPorPaciente(1);

-- CASO 3: Evitar eliminación de paciente con citas activas
DELETE FROM PACIENTES WHERE id_paciente = 1;

-- CASO 4: Insertar un pago
INSERT INTO PAGOS (id_pago, metodo_pago, fecha_pago, id_factura) 
VALUES (11, 'Efectivo', '2025-04-06 09:00:00', 2);

-- CASO 5: Usar función para contar citas de un médico
SELECT contar_citas_por_medico(1) AS total_citas_medico_1;

-- CASO 6: Identificar servicios no utilizados
SELECT nombre_servicio 
FROM SERVICIOS 
WHERE id_servicio NOT IN (
    SELECT DISTINCT id_servicio FROM CITAS
);

-- CASO 7: Verificar total facturado por médico
SELECT m.nombre, SUM(f.monto) AS total_facturado
FROM MEDICO m
JOIN CITAS c ON m.id_medico = c.id_medico
JOIN FACTURAS f ON c.id_cita = f.id_cita
GROUP BY m.id_medico, m.nombre;

