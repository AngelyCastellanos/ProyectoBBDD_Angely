-- 2 FUNCIONES ALMACENADAS
DELIMITER //
-- Esta funcion cuenta las citas por medico
CREATE FUNCTION contar_citas_por_medico(id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_citas INT;

    SELECT COUNT(*) INTO total_citas
    FROM CITAS
    WHERE id_medico = id;

    IF total_citas IS NULL THEN
        RETURN 0;
    ELSE
        RETURN total_citas;
    END IF;

END
// DELIMITER ;

-- Esta funcion cuenta la cantidad de pacientes que tienen una aseguradora
DELIMITER //
CREATE FUNCTION obtener_cantidad_pacientes_por_aseguradora(id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;

    SELECT COUNT(*) INTO cantidad
    FROM PACIENTES
    WHERE id_aseguradora = id;

    IF cantidad IS NULL THEN
        SET cantidad = 0;
    END IF;

    RETURN cantidad;
END
// DELIMITER ;

-- 2 PROCEDIMIENTOS ALMACENADOS

-- Este procedimiento sirve para registrar un nuevo paciente
DELIMITER //
CREATE PROCEDURE RegistrarPaciente(
    IN p_id_paciente INT,
    IN p_nombre VARCHAR(100),
    IN p_telefono VARCHAR(10),
    IN p_email VARCHAR(100),
    IN p_direccion VARCHAR(100),
    IN p_id_aseguradora INT)
BEGIN
    INSERT INTO PACIENTES (
        id_paciente, nombre, telefono, email, direccion, id_aseguradora) VALUES 
        (p_id_paciente, p_nombre, p_telefono, p_email, p_direccion, p_id_aseguradora);
END
// DELIMITER ;

-- Esta procedimiento lista todas las citas de un paciente
DELIMITER //
CREATE PROCEDURE ObtenerCitasPorPaciente(IN p_id_paciente INT)
BEGIN
    SELECT 
        c.id_cita, 
        c.fecha, 
        c.hora, 
        c.estado,
        m.nombre AS medico,
        s.nombre_servicio
    FROM CITAS c
    JOIN MEDICO m ON c.id_medico = m.id_medico
    JOIN SERVICIOS s ON c.id_servicio = s.id_servicio
    WHERE c.id_paciente = p_id_paciente;
END
// DELIMITER ;

-- 2 TRIGGERS 

-- Este trigger evita que se elimine un paciente con citas
DELIMITER //
CREATE TRIGGER eliminar_paciente
BEFORE DELETE ON PACIENTES
FOR EACH ROW
BEGIN
    DECLARE total_citas INT;
    SELECT COUNT(*) INTO total_citas
    FROM CITAS
    WHERE id_paciente = OLD.id_paciente;

    IF total_citas > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar el paciente porque tiene citas.';
    END IF;
END
// DELIMITER ;

-- Este trigger se encarga de actualizar el estado de una factura
DELIMITER //
CREATE TRIGGER cambiar_estado_pago
AFTER INSERT ON PAGOS
FOR EACH ROW
BEGIN
  UPDATE FACTURAS
  SET estado_pago = 'Pagado'
  WHERE id_factura = NEW.id_factura;
END

// DELIMITER ;




