

SELECT

e.id AS 'Escuela_ID',
e.cue AS 'CUE',
e.subcue AS 'subcue',
e.numero AS 'Número_escuela',
e.anexo AS 'Anexo',
CONCAT(e.numero,'-',e.anexo) AS 'Número_Anexo',
e.nombre AS 'Nombre_Escuela',
n.descripcion AS 'Nivel',
g.descripcion AS 'Gestión',
s.nombre AS 'Supervisión',
dep.descripcion AS 'Departamento',
l.descripcion AS 'Localidad',
z.descripcion AS 'zona',
amb.descripcion AS 'AMBITO',
reg.descripcion AS 'Regional',

a.id AS 'Alumno_ID',
p.id AS 'Persona_ID',

c.descripcion curso,
d.division,

r_a_r.rate_alumno_id AS 'RATE_ALUMNO_ID',

-- -------------------------NO BORRAR , SIRVE PARA VER LA CONSULTA EN FORMA VERTICAL -------------------
/*
r_p.id AS 'Codigo de la pregunta',
r_p.pregunta AS 'Pregunta',
r_a_r.rate_opcion_id AS 'Código respuesta seleccionada',
r_o.opcion AS 'Respuesta',
r_a.fecha_carga AS 'Fecha de Carga',
*/

-- id
-- 1 -- ¿El estudiante necesita recursos tecnológicos para resolver sus tareas escolares?
-- 2 -- ¿Qué tipo de recurso necesita?
-- 3 -- ¿Qué nivel de vinculación tiene el estudiante con la escuela?
-- 4 -- ¿Está siendo abordado por SOE?
-- 5 -- ¿Está siendo abordado por DOAITE?
-- 6 -- ¿Está siendo abordado por APOYO PSICOPEDAGOGICO?
-- 7 -- ¿Necesita abordaje específico?
-- 8 -- ¿El estudiante recibe apoyo pedagógico complementario?
-- 9 -- Recibe apoyo de:
-- 10-- ¿Necesita apoyo escolar complementario para fortalecer sus saberes prioritarios?
-- 11-- ¿Esta recibiendo un abordaje específico para la revinculación?
-- 12-- ¿Necesita un abordaje específico?

-- -------------------------PARA TRANSPONER LA TABLA ----------------------------------------------------

r_a.fecha_carga AS 'Fecha de Carga',
r_a.ames AS 'MES',


MAX(CASE
    WHEN r_a_r.rate_pregunta_id = 1 AND r_a_r.rate_opcion_id = 1 THEN r_o.opcion
    WHEN r_a_r.rate_pregunta_id = 1 AND r_a_r.rate_opcion_id = 2 THEN r_o.opcion
	 ELSE '-'
END) AS '¿El estudiante necesita recursos tecnológicos para resolver sus',
         
MAX(CASE
    WHEN r_a_r.rate_pregunta_id = 2 AND r_a_r.rate_opcion_id = 3 THEN r_o.opcion
	 ELSE '-'
END) AS '¿Qué tipo de recurso necesita 1?',

MAX(CASE
    WHEN r_a_r.rate_pregunta_id = 2 AND r_a_r.rate_opcion_id = 4 THEN r_o.opcion
	 ELSE '-'
END) AS '¿Qué tipo de recurso necesita 2?',

MAX(CASE    
    WHEN r_a_r.rate_pregunta_id = 2 AND r_a_r.rate_opcion_id = 5 THEN r_o.opcion
	 ELSE '-'
END) AS '¿Qué tipo de recurso necesita 3?',

MAX(CASE
    WHEN r_a_r.rate_pregunta_id = 3 AND r_a_r.rate_opcion_id = 6 THEN r_o.opcion
    WHEN r_a_r.rate_pregunta_id = 3 AND r_a_r.rate_opcion_id = 7 THEN r_o.opcion
    WHEN r_a_r.rate_pregunta_id = 3 AND r_a_r.rate_opcion_id = 8 THEN r_o.opcion
	 ELSE '-'
END) AS '¿Qué nivel de vinculación tiene el estudiante con la escuela?',
         

MAX(CASE
    WHEN r_a_r.rate_pregunta_id = 4 AND r_a_r.rate_opcion_id = 19 THEN r_o.opcion
    WHEN r_a_r.rate_pregunta_id = 4 AND r_a_r.rate_opcion_id = 20 THEN r_o.opcion    
	 ELSE '-'
END) AS '¿Está siendo abordado por SOE?',


MAX(CASE
    WHEN r_a_r.rate_pregunta_id = 5 AND r_a_r.rate_opcion_id = 21 THEN r_o.opcion
    WHEN r_a_r.rate_pregunta_id = 5 AND r_a_r.rate_opcion_id = 22 THEN r_o.opcion    
	 ELSE '-'
END) AS '¿Está siendo abordado por DOAITE?',


MAX(CASE
    WHEN r_a_r.rate_pregunta_id = 6 AND r_a_r.rate_opcion_id = 23 THEN r_o.opcion
    WHEN r_a_r.rate_pregunta_id = 6 AND r_a_r.rate_opcion_id = 24 THEN r_o.opcion    
	 ELSE '-'
END) AS '¿Está siendo abordado por APOYO PSICOPEDAGOGICO?',
         

MAX(CASE
    WHEN r_a_r.rate_pregunta_id = 7 AND r_a_r.rate_opcion_id = 25 THEN r_o.opcion
    WHEN r_a_r.rate_pregunta_id = 7 AND r_a_r.rate_opcion_id = 26 THEN r_o.opcion    
	 ELSE '-'
END) AS '¿Necesita abordaje específico?',


MAX(CASE
    WHEN r_a_r.rate_pregunta_id = 8 AND r_a_r.rate_opcion_id = 27 THEN r_o.opcion
    WHEN r_a_r.rate_pregunta_id = 8 AND r_a_r.rate_opcion_id = 28 THEN r_o.opcion    
	 ELSE '-'
END) AS '¿El estudiante recibe apoyo pedagógico complementario?',


MAX(CASE
    WHEN r_a_r.rate_pregunta_id = 9 AND r_a_r.rate_opcion_id = 29 THEN r_o.opcion
    WHEN r_a_r.rate_pregunta_id = 9 AND r_a_r.rate_opcion_id = 30 THEN r_o.opcion
	 WHEN r_a_r.rate_pregunta_id = 9 AND r_a_r.rate_opcion_id = 31 THEN r_o.opcion
    WHEN r_a_r.rate_pregunta_id = 9 AND r_a_r.rate_opcion_id = 32 THEN r_o.opcion     
    WHEN r_a_r.rate_pregunta_id = 9 AND r_a_r.rate_opcion_id = 33 THEN r_o.opcion
	 
	 WHEN r_a_r.rate_pregunta_id = 9 AND r_a_r.rate_opcion_id = 40 THEN r_o.opcion
	 WHEN r_a_r.rate_pregunta_id = 9 AND r_a_r.rate_opcion_id = 41 THEN r_o.opcion
	 WHEN r_a_r.rate_pregunta_id = 9 AND r_a_r.rate_opcion_id = 42 THEN r_o.opcion
	 WHEN r_a_r.rate_pregunta_id = 9 AND r_a_r.rate_opcion_id = 43 THEN r_o.opcion
	 WHEN r_a_r.rate_pregunta_id = 9 AND r_a_r.rate_opcion_id = 44 THEN r_o.opcion
	 WHEN r_a_r.rate_pregunta_id = 9 AND r_a_r.rate_opcion_id = 45 THEN r_o.opcion
	 WHEN r_a_r.rate_pregunta_id = 9 AND r_a_r.rate_opcion_id = 46 THEN r_o.opcion
	 WHEN r_a_r.rate_pregunta_id = 9 AND r_a_r.rate_opcion_id = 47 THEN r_o.opcion
	 WHEN r_a_r.rate_pregunta_id = 9 AND r_a_r.rate_opcion_id = 48 THEN r_o.opcion
	 WHEN r_a_r.rate_pregunta_id = 9 AND r_a_r.rate_opcion_id = 49 THEN r_o.opcion	 
	      
	 ELSE '-'
END) AS 'Recibe apoyo de:',


MAX(CASE
    WHEN r_a_r.rate_pregunta_id = 10 AND r_a_r.rate_opcion_id = 34 THEN r_o.opcion
    WHEN r_a_r.rate_pregunta_id = 10 AND r_a_r.rate_opcion_id = 35 THEN r_o.opcion
	 ELSE '-'
END) AS '¿Necesita apoyo escolar complementario para fortalecer sus saber',
         

MAX(CASE
    WHEN r_a_r.rate_pregunta_id = 11 AND r_a_r.rate_opcion_id = 36 THEN r_o.opcion
    WHEN r_a_r.rate_pregunta_id = 11 AND r_a_r.rate_opcion_id = 37 THEN r_o.opcion
	 ELSE '-'
END) AS '¿Esta recibiendo un abordaje específico para la revinculación?',
         

MAX(CASE
    WHEN r_a_r.rate_pregunta_id = 12 AND r_a_r.rate_opcion_id = 38 THEN r_o.opcion
    WHEN r_a_r.rate_pregunta_id = 12 AND r_a_r.rate_opcion_id = 39 THEN r_o.opcion
	 ELSE '-'
END) AS '¿Necesita un abordaje específico?',

MAX(CASE
    WHEN r_a_r.rate_pregunta_id = 13 AND r_a_r.rate_opcion_id = 50 THEN r_o.opcion
    WHEN r_a_r.rate_pregunta_id = 13 AND r_a_r.rate_opcion_id = 51 THEN r_o.opcion
    WHEN r_a_r.rate_pregunta_id = 13 AND r_a_r.rate_opcion_id = 52 THEN r_o.opcion
	 ELSE '-'
END) AS 'Seleccione si asistió a alguno de los siguientes talleres'


FROM
escuela e

JOIN division d ON d.escuela_id = e.id AND d.fecha_baja IS NULL
JOIN alumno_division ad ON ad.division_id = d.id AND ad.fecha_hasta IS NULL AND ad.ciclo_lectivo = 2023
-- JOIN alumno_division ad ON ad.division_id = d.id AND ad.fecha_hasta IS not NULL AND ad.ciclo_lectivo = 2021
JOIN alumno a ON a.id = ad.alumno_id 
JOIN persona p ON p.id=a.persona_id 
JOIN curso c ON c.id = d.curso_id
JOIN nivel n ON n.id = e.nivel_id
JOIN dependencia g ON g.id = e.dependencia_id

LEFT JOIN localidad lo_pe ON lo_pe.id = p.localidad_id
LEFT JOIN departamento de_pe ON de_pe.id = lo_pe.departamento_id

LEFT JOIN localidad l ON e.localidad_id = l.id 
LEFT JOIN departamento dep ON l.departamento_id = dep.id  
LEFT JOIN supervision s ON s.id=e.supervision_id 
LEFT JOIN zona z ON z.id = e.zona_id 
LEFT JOIN sexo sex ON sex.id = p.sexo_id 
LEFT JOIN regional reg ON reg.id = e.regional_id 
LEFT JOIN modalidad mo ON mo.id = d.modalidad_id 
LEFT JOIN turno tur ON tur.id = d.turno_id 
LEFT JOIN ambito amb ON e.ambito_id = amb.id 

-- -------------------------- RATE ALUMNOS ------------------------------------
left JOIN rate_alumno r_a ON r_a.alumno_division_id = ad.id AND r_a.ames = '202312'
left JOIN rate_alumno_respuesta r_a_r ON r_a_r.rate_alumno_id = r_a.id
left JOIN rate_pregunta r_p ON r_p.id = r_a_r.rate_pregunta_id
left JOIN rate_opcion r_o ON r_o.id = r_a_r.rate_opcion_id

WHERE
-- e.dependencia_id IN (1 , 2)
-- AND n.id IN(8) -- NIVEL INICIAL --
n.id in(2,3,4)
-- AND
-- r_a_r.rate_alumno_id = '91920'
-- ad.id = '705810'
-- e.numero = 1002
-- a.id = '705810'
-- AND 
-- p.documento = '53940554'
-- p.cuil = '20-54690237-5'
GROUP BY 
r_a_r.rate_alumno_id
ORDER BY
a.id , e.id;
-- LIMIT 1000