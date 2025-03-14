-- MATRICULA_NOMINAL_ALUMNOS

SELECT 

a.id AS 'Alumno_ID',
p.id AS 'Persona_ID',
-- p.documento AS 'DNI',
-- p.apellido AS 'Apellido_Alumno ',
-- p.nombre AS 'Nombre_Alumno ',
sex.descripcion AS 'Sexo',
p.fecha_nacimiento AS 'Fecha Nacimiento',
TIMESTAMPDIFF(YEAR,p.fecha_nacimiento,CURDATE()) AS 'Edad',

-- COALESCE(cgm.descripcion, c.descripcion) AS 'CURSO_NORMALIZADO',

c.descripcion AS 'Curso',
d.division AS 'Division',

ca_en.descripcion AS 'causa-entra',
ca_sa.descripcion AS 'causa-sale',

lo_pe.descripcion AS 'localidad alumno',
de_pe.descripcion AS 'departamento alumno',
	
--	cgm.codigo AS 'CGM CURSO', 
--	c.codigo AS 'CODIGO GRADO MULTIPLE',

tur.descripcion AS 'Turno', 
mo.descripcion AS 'Modalidad',
n.descripcion AS 'Nivel',
g.descripcion AS 'Gestion',
s.nombre AS 'Supervisión',
e.id AS 'ID_escuela',

e.cue AS 'CUE',
e.subcue AS 'subcue',
e.numero AS 'Número_escuela',
e.anexo AS 'Anexo',
CONCAT(e.numero,'-',e.anexo) AS 'Número_Anexo',
e.nombre AS 'Nombre_Escuela',
dep.descripcion AS 'Departamento',
l.descripcion AS 'Localidad',
z.descripcion AS 'zona',
amb.descripcion AS 'AMBITO',
reg.descripcion AS 'Regional',
coor.Lat AS 'latitud',
coor.`Long` AS 'longitud',



p_madre.id AS 'persona_id_madre',
p_madre.fecha_nacimiento AS 'fecha nacimiento madre',
p_madre.fecha_defuncion AS 'fecha defunción madre',
ocu_madre.descripcion AS 'ocupación madre',
nivel_estudio_madre.descripcion AS 'nivel de estudio madre',
-- p_madre.calle AS 'calle madre',
-- p_madre.calle_numero AS 'número madre',
-- p_madre.piso AS 'piso madre',
-- p_madre.barrio AS 'barrio madre',
-- p_madre.manzana AS 'manzana madre',
-- p_madre.casa AS 'casa madre',
-- p_madre.codigo_postal AS 'código postal madre',
lo_pe_madre.descripcion AS 'localidad madre',
de_pe_madre.descripcion AS 'departamento madre',

p_padre.id AS 'persona_id_padre',
p_padre.fecha_nacimiento AS 'fecha nacimiento padre',
p_padre.fecha_defuncion AS 'fecha defunción padre',
ocu_padre.descripcion AS 'ocupación padre',
nivel_estudio_padre.descripcion AS 'nivel de estudio padre',
-- p_padre.calle AS 'calle padre',
-- p_padre.calle_numero AS 'número padre',
-- p_padre.piso AS 'piso padre',
-- p_padre.barrio AS 'barrio padre',
-- p_padre.manzana AS 'manzana padre',
-- p_padre.casa AS 'casa padre',
-- p_padre.codigo_postal AS 'código postal padre',
lo_pe_padre.descripcion AS 'localidad padre',
de_pe_padre.descripcion AS 'departamento padre',

p_tutor.id AS 'persona_id_tutor',
p_tutor.fecha_nacimiento AS 'fecha nacimiento tutor',
p_tutor.fecha_defuncion AS 'fecha defunción tutor',
ocu_tutor.descripcion AS 'ocupación tutor',
nivel_estudio_tutor.descripcion AS 'nivel de estudio tutor',
-- p_tutor.calle AS 'calle tutor',
-- p_tutor.calle_numero AS 'número tutor',
-- p_tutor.piso AS 'piso tutor',
-- p_tutor.barrio AS 'barrio tutor',
-- p_tutor.manzana AS 'manzana tutor',
-- p_tutor.casa AS 'casa tutor',
-- p_tutor.codigo_postal AS 'código postal tutor',
lo_pe_tutor.descripcion AS 'localidad tutor',
de_pe_tutor.descripcion AS 'departamento tutor'




FROM escuela e
LEFT JOIN ambito amb ON e.ambito_id = amb.id
JOIN division d ON d.escuela_id = e.id  AND d.fecha_baja IS NULL 
JOIN alumno_division ad ON ad.division_id = d.id AND ad.ciclo_lectivo = 2024  -- AND ad.fecha_hasta IS NULL  

LEFT JOIN causa_entrada ca_en ON ca_en.id = ad.causa_entrada_id
LEFT JOIN causa_salida ca_sa ON ca_sa.id = ad.causa_salida_id

JOIN alumno a ON a.id = ad.alumno_id 
JOIN persona p ON p.id=a.persona_id 
JOIN curso c ON c.id = d.curso_id 
JOIN nivel n ON n.id = e.nivel_id 
JOIN dependencia g ON g.id = e.dependencia_id 

LEFT JOIN curso cgm ON cgm.id = ad.curso_id -- ME PERMITE TRAER EL ALUMNO DE UN GRADO MULTIPLE

LEFT JOIN localidad l ON e.localidad_id = l.id 
LEFT JOIN departamento dep ON l.departamento_id = dep.id
LEFT JOIN supervision s ON s.id=e.supervision_id 
LEFT JOIN zona z ON z.id = e.zona_id 
LEFT JOIN sexo sex ON sex.id = p.sexo_id 
LEFT JOIN regional reg ON reg.id = e.regional_id 
LEFT JOIN modalidad mo ON mo.id = d.modalidad_id 
LEFT JOIN turno tur ON tur.id = d.turno_id
LEFT JOIN coordenada coor ON coor.escuela_id = e.id

LEFT JOIN localidad lo_pe ON lo_pe.id = p.localidad_id
LEFT JOIN departamento de_pe ON de_pe.id = lo_pe.departamento_id

LEFT JOIN familia f_madre ON f_madre.persona_id = p.id AND f_madre.parentesco_tipo_id = 1
LEFT JOIN persona p_madre ON p_madre.id = f_madre.pariente_id
LEFT JOIN ocupacion ocu_madre ON ocu_madre.id = p_madre.ocupacion_id
LEFT JOIN nivel_estudio nivel_estudio_madre ON nivel_estudio_madre.id = p_madre.nivel_estudio_id
LEFT JOIN localidad lo_pe_madre ON lo_pe_madre.id = p_madre.localidad_id
LEFT JOIN departamento de_pe_madre ON de_pe_madre.id = lo_pe_madre.departamento_id

LEFT JOIN familia f_padre ON f_padre.persona_id = p.id AND f_padre.parentesco_tipo_id = 2
LEFT JOIN persona p_padre ON p_padre.id = f_padre.pariente_id
LEFT JOIN ocupacion ocu_padre ON ocu_padre.id = p_padre.ocupacion_id
LEFT JOIN nivel_estudio nivel_estudio_padre ON nivel_estudio_padre.id = p_padre.nivel_estudio_id
LEFT JOIN localidad lo_pe_padre ON lo_pe_padre.id = p_padre.localidad_id
LEFT JOIN departamento de_pe_padre ON de_pe_padre.id = lo_pe_padre.departamento_id

LEFT JOIN familia f_tutor ON f_tutor.persona_id = p.id AND f_tutor.parentesco_tipo_id = 3
LEFT JOIN persona p_tutor ON p_tutor.id = f_tutor.pariente_id
LEFT JOIN ocupacion ocu_tutor ON ocu_tutor.id = p_tutor.ocupacion_id
LEFT JOIN nivel_estudio nivel_estudio_tutor ON nivel_estudio_tutor.id = p_tutor.nivel_estudio_id
LEFT JOIN localidad lo_pe_tutor ON lo_pe_tutor.id = p_tutor.localidad_id
LEFT JOIN departamento de_pe_tutor ON de_pe_tutor.id = lo_pe_tutor.departamento_id

/*
sasd
*/

WHERE
e.fecha_cierre IS NULL
-- AND 
-- nivel_id IN ('2','3','4')

AND n.id IN ('2','3','4')
-- AND c.descripcion IN ("Grado Múltiple") 
-- AND c.id IN ('1' , '14')
-- AND p.documento = '47874471'
-- AND e.numero = 'P040'
 
group by g.id , e.nivel_id  , a.id -- , c.id , d.id
ORDER BY
n.id, 
`Gestion`,
 
`Supervisión`,
`Número_Anexo`,
-- `CURSO_NORMALIZADO`,
Alumno_ID
