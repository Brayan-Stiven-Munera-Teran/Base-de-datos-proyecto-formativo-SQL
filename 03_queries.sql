-- =====================================================================
-- 03_consultas_practicas_14.sql · 14 Consultas Prácticas y Fáciles
-- Sistema de Transporte Escolar (TransiKids)
-- =====================================================================
USE transporte_escolar;

-- 1. Listar los vehículos operativos de la flota
SELECT placa, marca, modelo, anio, capacidad_pasajeros
FROM vehiculos
WHERE estado = 'operativo';

-- 2. Listar las escuelas registradas y su teléfono de contacto
SELECT nombre, direccion, telefono_contacto
FROM escuelas;

-- 3. Ver todos los usuarios registrados con su respectivo rol
SELECT u.nombre, u.apellido, u.email, r.nombre AS rol
FROM usuarios u
JOIN roles r ON r.id_rol = u.id_rol;

-- 4. Ver los estudiantes activos junto al nombre de su colegio y grado
SELECT CONCAT(e.nombre, ' ', e.apellido) AS estudiante, e.grado_curso, esc.nombre AS escuela
FROM estudiantes e
JOIN escuelas esc ON esc.id_escuela = e.id_escuela
WHERE e.estado = 'activo';

-- 5. Listar los conductores y sus licencias de conducción vigentes
SELECT CONCAT(u.nombre, ' ', u.apellido) AS conductor, c.numero_licencia, c.categoria_licencia, c.fecha_vencimiento_licencia
FROM conductores c
JOIN usuarios u ON u.id_usuario = c.id_usuario;

-- 6. Ver las rutas escolares programadas con su escuela y horario
SELECT r.nombre_ruta, esc.nombre AS escuela_destino, r.tipo_trayecto, r.hora_inicio_estimada
FROM rutas r
JOIN escuelas esc ON esc.id_escuela = r.id_escuela;

-- 7. Listar las paradas asociadas a cada ruta
SELECT r.nombre_ruta, p.orden_secuencia, p.nombre_parada, p.direccion_referencia, p.hora_estimada
FROM paradas p
JOIN rutas r ON r.id_ruta = p.id_ruta
ORDER BY r.id_ruta, p.orden_secuencia;

-- 8. Conteo de estudiantes inscritos por cada escuela
SELECT esc.nombre AS escuela, COUNT(e.id_estudiante) AS total_estudiantes
FROM escuelas esc
LEFT JOIN estudiantes e ON e.id_escuela = esc.id_escuela
GROUP BY esc.id_escuela, esc.nombre;

-- 9. Listar las asistencias registradas (subió / bajó / ausente) en los viajes
SELECT v.id_viaje, CONCAT(e.nombre, ' ', e.apellido) AS estudiante, a.estado_asistencia, a.fecha_hora_evento
FROM asistencias a
JOIN viajes v ON v.id_viaje = a.id_viaje
JOIN estudiantes e ON e.id_estudiante = a.id_estudiante
LIMIT 50;

-- 10. Ver los viajes programados o en curso con su fecha y estado
SELECT v.id_viaje, r.nombre_ruta, v.fecha, v.estado
FROM viajes v
JOIN rutas r ON r.id_ruta = v.id_ruta
LIMIT 50;

-- 11. Consultar las novedades reportadas con su nivel de gravedad y descripción
SELECT nov.tipo_novedad, nov.gravedad, nov.descripcion, nov.fecha_hora
FROM novedades nov;

-- 12. Ver las notificaciones enviadas a los usuarios y si ya fueron leídas
SELECT u.email, n.titulo, n.mensaje, n.leido, n.fecha_envio
FROM notificaciones n
JOIN usuarios u ON u.id_usuario = n.id_usuario
LIMIT 50;

-- 13. Consultar los códigos de entrega seguros generados para los viajes
SELECT ce.id_codigo, ce.codigo_seguridad, ce.nombre_receptor, ce.validado
FROM codigos_entrega ce
LIMIT 50;

-- 14. Listar las auxiliares de ruta con su estado de certificación
SELECT CONCAT(u.nombre, ' ', u.apellido) AS auxiliar, a.certificacion_primeros_auxilios, a.observaciones
FROM auxiliares a
JOIN usuarios u ON u.id_usuario = a.id_usuario;
