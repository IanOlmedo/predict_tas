SET @materia_ = 3;  -- 1 lengua -- 2 Leng y Lit -- 3 Matemática 
SET @fecha_desde = '2024-03-01';
SET @fecha_hasta = '2024-05-31';


SELECT 
ID_escuela_,
Alumno_ID,
Persona_ID,
-- dni,
-- apellido,
-- NOMBRE_ALUMNO,
curso_,
division_,
T.`materia`,
-- T.`tipo_evaluacion_id`,
-- T.`tipo_evaluacion`,


COUNT(T.`tipo_evaluacion_id`) AS 'cantidad de evaluaciones',
sum(T.`cantidad de calificaciones ausentes`) AS 'cantidad de evaluaciones ausentes',
GROUP_CONCAT(T.`asistencia`) AS 'asistencia',
GROUP_CONCAT(COALESCE( T.`nota`,0)) AS 'notas',
GROUP_CONCAT(T.`descripcion_evaluacion`) AS 'descripcion_evaluacion',
GROUP_CONCAT(T.`fecha_evaluacion`) AS 'fecha_evaluacion',

-- COUNT(if(T.`tipo_evaluacion_id` = '2',T.`tipo_evaluacion_id`, NULL)) AS 'Examen escrito',
-- GROUP_CONCAT(T.`nota`,' ',if(T.`tipo_evaluacion_id` = '2',' ', NULL)) AS 'notas_Examen escrito',
-- sum(if(T.`tipo_evaluacion_id` = '2',T.`tipo_evaluacion_id`, NULL),T.`nota`) AS 'sdad',

-- COUNT(if(T.`tipo_evaluacion_id` = '3',T.`tipo_evaluacion_id`, NULL)) AS 'Lección oral',
-- GROUP_CONCAT(T.`nota`,' ',if(T.`tipo_evaluacion_id` = '3',' ', NULL)) AS 'notas_Lección oral',

-- COUNT(if(T.`tipo_evaluacion_id` = '4',T.`tipo_evaluacion_id`, NULL)) AS 'Concepto',
-- GROUP_CONCAT(T.`nota`,' ',if(T.`tipo_evaluacion_id` = '4',' ', NULL)) AS 'notas_Concepto',

-- COUNT(if(T.`tipo_evaluacion_id` = '5',T.`tipo_evaluacion_id`, NULL)) AS 'Trabajo Práctico',
-- GROUP_CONCAT(T.`nota`,' ',if(T.`tipo_evaluacion_id` = '5',' ', NULL)) AS 'notas_Trabajo Práctico',

-- COUNT(if(T.`tipo_evaluacion_id` = '6',T.`tipo_evaluacion_id`, NULL)) AS 'Carpeta',
-- GROUP_CONCAT(T.`nota`,' ',if(T.`tipo_evaluacion_id` = '6',' ', NULL)) AS 'notas_Carpeta',

-- COUNT(if(T.`tipo_evaluacion_id` = '35',T.`tipo_evaluacion_id`, NULL)) AS 'Acreditación Aprendizaje Prioritario',
-- GROUP_CONCAT(T.`nota`,' ',if(T.`tipo_evaluacion_id` = '35',' ', NULL)) AS 'notas_Acreditación Aprendizaje Prioritario',

-- COUNT(if(T.`tipo_evaluacion_id` = '38',T.`tipo_evaluacion_id`, NULL)) AS 'Diagnóstico Inicial',
-- GROUP_CONCAT(T.`nota`,' ',if(T.`tipo_evaluacion_id` = '38',' ', NULL)) AS 'notas_Diagnóstico Inicial',
-- T.`nota`,
SUM(T.`nota`) AS 'suma_notas',
-- AVG(T.`nota`) AS 'promedio,'
(SUM(T.`nota`)/ COUNT(T.`tipo_evaluacion_id`)) AS 'promedio'

FROM (
		SELECT
		p.id AS 'Persona_ID',
		-- ev.id AS 'ID_evaluacion',
		-- n.descripcion as 'nivel',
		-- de.descripcion as 'gestion',
		-- s.nombre as 'supervision',
		-- amb.descripcion AS 'AMBITO',
		e.id AS 'ID_escuela_',
		-- e.numero, e.anexo,
		-- CONCAT(e.numero,'-',e.anexo) AS 'Numero_Anexo_',
		-- e.nombre,
		-- dep.descripcion as 'departamento',
		-- l.descripcion AS 'localidad',
		cu.descripcion as 'curso_',
		d.division AS 'division_',
		a.id AS 'Alumno_ID',
		p.documento AS 'dni', p.apellido, p.nombre AS 'NOMBRE_ALUMNO',
		m.descripcion as 'materia',
		et.descripcion as 'tipo_evaluacion',
		et.id AS 'tipo_evaluacion_id',
		et.descripcion AS 'descripcion_evaluacion',
		ev.fecha AS 'fecha_evaluacion',
		
		ev.fecha, 
		ev.tema as 'evaluacion',
		cn.nota AS 'nota',
		
		if ((cn.asistencia = 'Ausente') , '1' , '') AS 'cantidad de calificaciones ausentes',
		
		cn.asistencia AS 'asistencia',
		cne.en_proceso, 
		cne.texto	
		
		FROM evaluacion ev
		JOIN cursada c ON ev.cursada_id=c.id
		JOIN alumno_cursada ac ON ac.cursada_id=c.id
		LEFT JOIN cursada_nota cn ON ev.id=cn.evaluacion_id AND cn.alumno_cursada_id=ac.id 
		LEFT JOIN cursada_nota_ep cne ON ev.id=cne.evaluacion_id AND cne.alumno_cursada_id=ac.id
		JOIN alumno_division ad ON ac.alumno_division_id=ad.id AND ad.ciclo_lectivo=ev.ciclo_lectivo
		JOIN alumno a ON ad.alumno_id=a.id
		JOIN persona p ON a.persona_id=p.id
		JOIN evaluacion_tipo et ON ev.evaluacion_tipo_id=et.id
		JOIN espacio_curricular ec ON ec.id=c.espacio_curricular_id
		JOIN materia m ON m.id=ec.materia_id
		JOIN division d ON c.division_id=d.id
		JOIN escuela e ON d.escuela_id=e.id
		LEFT JOIN ambito amb ON e.ambito_id = amb.id
		JOIN curso cu ON cu.id=d.curso_id
		LEFT JOIN supervision s ON s.id=e.supervision_id
		JOIN nivel n ON n.id=e.nivel_id
		JOIN dependencia de ON de.id=e.dependencia_id
		LEFT JOIN localidad l ON l.id=e.localidad_id
		LEFT JOIN departamento dep ON dep.id=l.departamento_id
		WHERE ev.ciclo_lectivo IN (2024)
		
		
		AND e.nivel_id IN (2 , 3 , 4)
		
		-- AND e.dependencia_id IN (1,2,3,4)
		
		AND m.id = @materia_ -- IN (1 , 2 , 3) -- @materia_
		
		
		 AND (cn.id IS NOT NULL OR cne.id IS NOT NULL)
		 AND ev.fecha >= @fecha_desde
		 AND ev.fecha <= @fecha_hasta
		 -- AND e.numero IN ('1246')     
		 -- AND et.id IN (13 , 39 , 40)
		 -- AND e.id IN (1246)
		-- AND a.id IN ('6054')   
          
ORDER BY  fecha_evaluacion , e.id , cu.descripcion , d.division , a.id   -- );
) AS T

GROUP BY 
ID_escuela_,
Alumno_ID,
materia
-- tipo_evaluacion

ORDER BY Alumno_ID 
;