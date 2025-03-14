SET @fecha_desde = '2024-05-01';
SET @fecha_hasta = '2024-05-31';
set @ames=(SELECT DATE_FORMAT(@fecha_desde, '%Y%m'));

SELECT 
t.Alumno_ID AS 'Alumno_ID',
t.Persona_ID AS 'Persona_ID',
-- t.DNI,
-- t.Apellido,
-- t.Nombre,
-- t.nivel_,
-- t.numero,
t.escuela_id AS 'Escuela_ID',
t.Curso_ AS 'Curso',
t.Division AS 'División',
t.Nivel AS 'Nivel',
t.Gestion AS 'Gestión',
t.Supervisión AS 'Supervisión',
-- t.ID_escuela,
t.CUE AS 'CUE',
t.subcue AS 'subcue',
t.Numero_escuela AS 'Número_escuela',
t.Anexo AS 'Anexo',
-- t.Número_Anexo,
-- t.Escuela,
t.Departamento AS 'Departamento',
t.Localidad AS 'Localidad',
-- t.ames AS 'mes',
t.anio_mes AS 'año-mes',
t.cDia,
-- t.Faltas AS '-- no usar --' ,
t.Asistencia,

-- --TENGO QUE HACER LA SUMA DE LAS QUE REALMENTE IMPORTAN
(
if (t.2a IS NULL , 0 , t.2a) +
if (t.2b IS NULL , 0 , t.2b) +
if (t.2c IS NULL , 0 , t.2c) +
if (t.2d IS NULL , 0 , t.2d) +
if (t.2e IS NULL , 0 , t.2e) +
if (t.2f IS NULL , 0 , t.2f) +
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if (t.3a IS NULL , 0 , t.3a) +
if (t.3b IS NULL , 0 , t.3b) +
if (t.3c IS NULL , 0 , t.3c) +
if (t.3d IS NULL , 0 , t.3d) +
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if (t.4a IS NULL , 0 , t.4a) +
if (t.4b IS NULL , 0 , t.4b) +
if (t.4c IS NULL , 0 , t.4c) +
if (t.4d IS NULL , 0 , t.4d) +
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
-- t.5a +	
-- t.5b +
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
-- t.6a +
-- t.6b +
-- t.6c +
-- t.6d +
-- t.6e +
-- t.6f +
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
if (t.8a IS NULL , 0 , t.8a) +
if (t.8b IS NULL , 0 , t.8b) +
if (t.8c IS NULL , 0 , t.8c) +
if (t.8d IS NULL , 0 , t.8d) +
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
if (t.10a IS NULL , 0 , t.10a) +
if (t.10b IS NULL , 0 , t.10b) +
if (t.10c IS NULL , 0 , t.10c) +
if (t.10d IS NULL , 0 , t.10d) +
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
if (t.11a IS NULL , 0 , t.11a) +
if (t.11b IS NULL , 0 , t.11b) +
if (t.11c IS NULL , 0 , t.11c) +
if (t.11d IS NULL , 0 , t.11d) +
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
if (t.12a IS NULL , 0 , t.12a) +
if (t.12b IS NULL , 0 , t.12b) +
if (t.12c IS NULL , 0 , t.12c) +
if (t.12d IS NULL , 0 , t.12d) +
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
if (t.13a IS NULL , 0 , t.13a) +
if (t.13b IS NULL , 0 , t.13b) +
if (t.13c IS NULL , 0 , t.13c) +
if (t.13d IS NULL , 0 , t.13d) +
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------				
if (t.14a IS NULL , 0 , t.14a) +
if (t.14b IS NULL , 0 , t.14b) +
if (t.14c IS NULL , 0 , t.14c) +
if (t.14d IS NULL , 0 , t.14d) +
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
if (t.15a IS NULL , 0 , t.15a) +
if (t.15b IS NULL , 0 , t.15b) +
if (t.15c IS NULL , 0 , t.15c) +
if (t.15d IS NULL , 0 , t.15d) +
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
if (t.16a IS NULL , 0 , t.16a) +
if (t.16b IS NULL , 0 , t.16b) +
if (t.16c IS NULL , 0 , t.16c) +
if (t.16d IS NULL , 0 , t.16d) +
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
if (t.17a IS NULL , 0 , t.17a) +
if (t.17b IS NULL , 0 , t.17b) +
if (t.17c IS NULL , 0 , t.17c) +
if (t.17d IS NULL , 0 , t.17d) +
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
if (t.26a IS NULL , 0 , t.26a) +
if (t.26b IS NULL , 0 , t.26b) +
if (t.26c IS NULL , 0 , t.26c) +
if (t.26d IS NULL , 0 , t.26d) +
if (t.26e IS NULL , 0 , t.26e) +
if (t.26f IS NULL , 0 , t.26f) +
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
if (t.27a IS NULL , 0 , t.27a) +
if (t.27b IS NULL , 0 , t.27b) +
if (t.27c IS NULL , 0 , t.27c) +
if (t.27d IS NULL , 0 , t.27d) +
if (t.27e IS NULL , 0 , t.27e) +
if (t.27f IS NULL , 0 , t.27f) +
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
if (t.28a IS NULL , 0 , t.28a) +
if (t.28b IS NULL , 0 , t.28b) +
if (t.28c IS NULL , 0 , t.28c) +
if (t.28d IS NULL , 0 , t.28d) +
if (t.28e IS NULL , 0 , t.28e) +
if (t.28f IS NULL , 0 , t.28f) +
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
if (t.34a IS NULL , 0 , t.34a) +
if (t.34b IS NULL , 0 , t.34b) +
if (t.34c IS NULL , 0 , t.34c) +
if (t.34d IS NULL , 0 , t.34d) +
if (t.34e IS NULL , 0 , t.34e) +
if (t.34f IS NULL , 0 , t.34f) 

) AS 'faltasReales',


IFNULL(t.fecha_cierre_asistencia, '-') AS 'fecha cierre asistencia',
if( t.fecha_cierre_asistencia IS NULL , 'No' , 'Si') AS 'cerró_asistencia..??' , 

-- colocara acá todas las clases de inasistencias..!!!


t.`2a` AS '2_Inasistencia_Si_Justificada_contraturno_Si', -- '2_Inasistencia_Si_Justificada_contraturno_Si'
t.`2b` AS '2_Inasistencia_Si_Justificada_contraturno_No', -- '2_Inasistencia_Si_Justificada_contraturno_No'
t.`2c` AS '2_Inasistencia_No_Justificada_contraturno_Si', -- '2_Inasistencia_No_Justificada_contraturno_Si'
t.`2d` AS '2_Inasistencia_No_Justificada_contraturno_No', -- '2_Inasistencia_No_Justificada_contraturno_No'
t.`2e` AS '2_Inasistencia_NC_Justificada_contraturno_Si', -- '2_Inasistencia_NC_Justificada_contraturno_Si'
t.`2f` AS '2_Inasistencia_NC_Justificada_contraturno_No', -- '2_Inasistencia_NC_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
t.`3a` AS '3_Tardanza_Si_Justificada_contraturno_Si', -- '3_Tardanza_Si_Justificada_contraturno_Si'
t.`3b` AS '3_Tardanza_Si_Justificada_contraturno_No', -- '3_Tardanza_Si_Justificada_contraturno_No'
t.`3c` AS '3_Tardanza_No_Justificada_contraturno_Si', -- '3_Tardanza_No_Justificada_contraturno_Si'
t.`3d` AS '3_Tardanza_No_Justificada_contraturno_No', -- '3_Tardanza_No_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
t.`4a` AS '4_Retiro_Si_Justificada_contraturno_Si', -- '4_Retiro_Si_Justificada_contraturno_Si'
t.`4b` AS '4_Retiro_Si_Justificada_contraturno_No', -- '4_Retiro_Si_Justificada_contraturno_No'
t.`4c` AS '4_Retiro_No_Justificada_contraturno_Si', -- '4_Retiro_No_Justificada_contraturno_Si'
t.`4d` AS '4_Retiro_No_Justificada_contraturno_No', -- '4_Retiro_No_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
t.`5a` AS '5_Previo_ingreso_NC_Justificada_contraturno_Si', -- '5_Previo_ingreso_NC_Justificada_contraturno_Si'	
t.`5b` AS '5_Previo_ingreso_NC_Justificada_contraturno_No', -- '5_Previo_ingreso_NC_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
t.`6a` AS '6_Posterior_egreso_NC_Justificada_contraturno_Si', -- '6_Posterior_egreso_NC_Justificada_contraturno_Si'
t.`6b` AS '6_Posterior_egreso_NC_Justificada_contraturno_No', -- '6_Posterior_egreso_NC_Justificada_contraturno_No'
t.`6c` AS '6_Posterior_egreso_No_Justificada_contraturno_Si', -- '6_Posterior_egreso_No_Justificada_contraturno_Si'
t.`6d` AS '6_Posterior_egreso_No_Justificada_contraturno_No', -- '6_Posterior_egreso_No_Justificada_contraturno_No'
t.`6e` AS '6_Posterior_egreso_Si_Justificada_contraturno_Si', -- '6_Posterior_egreso_Si_Justificada_contraturno_Si'
t.`6f` AS '6_Posterior_egreso_Si_Justificada_contraturno_No', -- '6_Posterior_egreso_Si_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
t.`8a` AS '8_Presente_NC_No_Justificada_contraturno_Si', -- '8_Presente_NC_No_Justificada_contraturno_Si'
t.`8b` AS '8_Presente_NC_No_Justificada_contraturno_No', -- '8_Presente_NC_No_Justificada_contraturno_No'
t.`8c` AS '8_Presente_NC_Si_Justificada_contraturno_Si', -- '8_Presente_NC_Si_Justificada_contraturno_Si'
t.`8d` AS '8_Presente_NC_Si_Justificada_contraturno_No', -- '8_Presente_NC_Si_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
t.`10a` AS '10_Tardanza+10m_Si_Justificada_contraturno_Si', -- '10_Tardanza+10m_Si_Justificada_contraturno_Si'
t.`10b` AS '10_Tardanza+10m_Si_Justificada_contraturno_No', -- '10_Tardanza+10m_Si_Justificada_contraturno_No'
t.`10c` AS '10_Tardanza+10m_No_Justificada_contraturno_Si', -- '10_Tardanza+10m_No_Justificada_contraturno_Si'
t.`10d` AS '10_Tardanza+10m_No_Justificada_contraturno_No', -- '10_Tardanza+10m_No_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
t.`11a` AS '11_Ausente_Tardanza_Si_Justificada_contraturno_Si', -- '11_Ausente_Tardanza_Si_Justificada_contraturno_Si'
t.`11b` AS '11_Ausente_Tardanza_Si_Justificada_contraturno_No', -- '11_Ausente_Tardanza_Si_Justificada_contraturno_No'
t.`11c` AS '11_Ausente_Tardanza_No_Justificada_contraturno_Si', -- '11_Ausente_Tardanza_No_Justificada_contraturno_Si'
t.`11d` AS '11_Ausente_Tardanza_No_Justificada_contraturno_No', -- '11_Ausente_Tardanza_No_Justificada_contraturno_No'	
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
t.`12a` AS '12_Retiro+10m_Si_Justificada_contraturno_Si', -- '12_Retiro+10m_Si_Justificada_contraturno_Si'
t.`12b` AS '12_Retiro+10m_Si_Justificada_contraturno_No', -- '12_Retiro+10m_Si_Justificada_contraturno_No'
t.`12c` AS '12_Retiro+10m_No_Justificada_contraturno_Si', -- '12_Retiro+10m_No_Justificada_contraturno_Si'
t.`12d` AS '12_Retiro+10m_No_Justificada_contraturno_No', -- '12_Retiro+10m_No_Justificada_contraturno_No'	
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
t.`13a` AS '13_Ausente_Retiro_Si_Justificada_contraturno_Si', -- '13_Ausente_Retiro_Si_Justificada_contraturno_Si'
t.`13b` AS '13_Ausente_Retiro_Si_Justificada_contraturno_No', -- '13_Ausente_Retiro_Si_Justificada_contraturno_No'
t.`13c` AS '13_Ausente_Retiro_No_Justificada_contraturno_Si', -- '13_Ausente_Retiro_No_Justificada_contraturno_Si'
t.`13d` AS '13_Ausente_Retiro_No_Justificada_contraturno_No', -- '13_Ausente_Retiro_No_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------				
t.`14a` AS '14_Tardanza,Retiro_Si_Justificada_contraturno_Si', -- '14_Tardanza,Retiro_Si_Justificada_contraturno_Si'
t.`14b` AS '14_Tardanza,Retiro_Si_Justificada_contraturno_No', -- '14_Tardanza,Retiro_Si_Justificada_contraturno_No'
t.`14c` AS '14_Tardanza,Retiro_No_Justificada_contraturno_Si', -- '14_Tardanza,Retiro_No_Justificada_contraturno_Si'
t.`14d` AS '14_Tardanza,Retiro_No_Justificada_contraturno_No', -- '14_Tardanza,Retiro_No_Justificada_contraturno_No'	
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
t.`15a` AS '15_Tardanza+10m,Retiro_Si_Justificada_contraturno_Si', -- '15_Tardanza+10m,Retiro_Si_Justificada_contraturno_Si'
t.`15b` AS '15_Tardanza+10m,Retiro_Si_Justificada_contraturno_No', -- '15_Tardanza+10m,Retiro_Si_Justificada_contraturno_No'
t.`15c` AS '15_Tardanza+10m,Retiro_No_Justificada_contraturno_Si', -- '15_Tardanza+10m,Retiro_No_Justificada_contraturno_Si'
t.`15d` AS '15_Tardanza+10m,Retiro_No_Justificada_contraturno_No', -- '15_Tardanza+10m,Retiro_No_Justificada_contraturno_No'							
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
t.`16a` AS '16_Tardanza,Retiro+10m_Si_Justificada_contraturno_Si', -- '16_Tardanza,Retiro+10m_Si_Justificada_contraturno_Si'
t.`16b` AS '16_Tardanza,Retiro+10m_Si_Justificada_contraturno_No', -- '16_Tardanza,Retiro+10m_Si_Justificada_contraturno_No'
t.`16c` AS '16_Tardanza,Retiro+10m_No_Justificada_contraturno_Si', -- '16_Tardanza,Retiro+10m_No_Justificada_contraturno_Si'
t.`16d` AS '16_Tardanza,Retiro+10m_No_Justificada_contraturno_No', -- '16_Tardanza,Retiro+10m_No_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
t.`17a` AS '17_Tardanza+10m,Retiro+10m_Si_Justificada_contraturno_Si', -- '17_Tardanza+10m,Retiro+10m_Si_Justificada_contraturno_Si
t.`17b` AS '17_Tardanza+10m,Retiro+10m_Si_Justificada_contraturno_No', -- '17_Tardanza+10m,Retiro+10m_Si_Justificada_contraturno_No'
t.`17c` AS '17_Tardanza+10m,Retiro+10m_No_Justificada_contraturno_Si', -- '17_Tardanza+10m,Retiro+10m_No_Justificada_contraturno_Si'
t.`17d` AS '17_Tardanza+10m,Retiro+10m_No_Justificada_contraturno_No',	-- '17_Tardanza+10m,Retiro+10m_No_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
t.`26a` AS '26_Ausente_Si_Justificada_contraturno_Si', -- '26_Ausente_Si_Justificada_contraturno_Si'
t.`26b` AS '26_Ausente_Si_Justificada_contraturno_No', -- '26_Ausente_Si_Justificada_contraturno_No'
t.`26c` AS '26_Ausente_No_Justificada_contraturno_Si', -- '26_Ausente_No_Justificada_contraturno_Si'
t.`26d` AS '26_Ausente_No_Justificada_contraturno_No', -- '26_Ausente_No_Justificada_contraturno_No'
t.`26e` AS '26_Ausente_NC_Justificada_contraturno_Si', -- '26_Ausente_NC_Justificada_contraturno_Si'
t.`26f` AS '26_Ausente_NC_Justificada_contraturno_No', -- '26_Ausente_NC_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
t.`27a` AS '27_Ausente_Caso_confirmado_COVID_Si_Justificada_contraturno_Si', -- '27_Ausente_Caso_confirmado_COVID_Si_Justificada_contraturno_Si'
t.`27b` AS '27_Ausente_Caso_confirmado_COVID_Si_Justificada_contraturno_No', -- '27_Ausente_Caso_confirmado_COVID_Si_Justificada_contraturno_No'
t.`27c` AS '27_Ausente_Caso_confirmado_COVID_No_Justificada_contraturno_Si', -- '27_Ausente_Caso_confirmado_COVID_No_Justificada_contraturno_Si'
t.`27d` AS '27_Ausente_Caso_confirmado COVID_No_Justificada_contraturno_No', -- '27_Ausente_Caso_confirmado COVID_No_Justificada_contraturno_No'
t.`27e` AS '27_Ausente_Caso_confirmado_COVID_NC_Justificada_contraturno_Si', -- '27_Ausente_Caso_confirmado_COVID_NC_Justificada_contraturno_Si'
t.`27f` AS '27_Ausente_Caso_confirmado_COVID_NC_Justificada_contraturno_No',
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
t.`28a` AS '28_Ausente_Caso_sospechoso_COVID_Con_síntomas_Si_Justificada_contraturno_Si', -- '28_Ausente_Caso_sospechoso_COVID_Con_síntomas_Si_Justificada_contraturno_Si'
t.`28b` AS '28_Ausente_Caso sospechoso_COVID_Con_síntomas_Si_Justificada_contraturno_No', -- '28_Ausente_Caso sospechoso_COVID_Con_síntomas_Si_Justificada_contraturno_No'
t.`28c` AS '28_Ausente_Caso_sospechoso_COVID_Con_síntomas_No_Justificada_contraturno_Si', -- '28_Ausente_Caso_sospechoso_COVID_Con_síntomas_No_Justificada_contraturno_Si'
t.`28d` AS '28_Ausente_Caso_sospechoso_COVID_Con_síntomas_No_Justificada_contraturno_No', -- '28_Ausente_Caso_sospechoso_COVID_Con_síntomas_No_Justificada_contraturno_No'
t.`28e` AS '28_Ausente_Caso_sospechoso_COVID_Con_síntomas_NC_Justificada_contraturno_Si', -- '28_Ausente_Caso_sospechoso_COVID_Con_síntomas_NC_Justificada_contraturno_Si'
t.`28f` AS '28_Ausente_Caso_sospechoso_COVID_Con_síntomas_NC_Justificada_contraturno_No', -- '28_Ausente_Caso_sospechoso_COVID_Con_síntomas_NC_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
t.`34a` AS '34_Ausente_No_Presencial_Si_Justificada_contraturno_Si', -- '34_Ausente_No_Presencial_Si_Justificada_contraturno_Si'
t.`34b` AS '34_Ausente_No_Presencial_Si_Justificada_contraturno_No', -- '34_Ausente_No_Presencial_Si_Justificada_contraturno_No'
t.`34c` AS '34_Ausente_No_Presencial_No_Justificada_contraturno_Si', -- '34_Ausente_No_Presencial_No_Justificada_contraturno_Si'
t.`34d` AS '34_Ausente_No_Presencial_No_Justificada_contraturno_No', -- '34_Ausente_No_Presencial_No_Justificada_contraturno_No'
t.`34e` AS '34_Ausente_No_Presencial_NC_Justificada_contraturno_Si', -- '34_Ausente_No_Presencial_NC_Justificada_contraturno_Si'
t.`34f` AS '34_Ausente_No_Presencial_NC_Justificada_contraturno_No', -- '34_Ausente_No_Presencial_NC_Justificada_contraturno_No'
		
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
t.`1a` AS '1-Resumen mensual', -- '1-Resumen mensual'	
t.`7a` AS '7-Fuerza mayor',	-- '7-Fuerza mayor'
t.`9a` AS '9-No corresponde', -- '9-No corresponde'	
t.`18a` AS '18-No corresponde',	-- '18-No corresponde'
t.`19a` AS '19-No debe asistir', -- '19-No debe asistir'	
t.`20a` AS '20-Retira - Inclemencias climáticas', -- '20-Retira - Inclemencias climáticas'	
t.`21a` AS '21-Retira - Problemas familiares',	-- '21-Retira - Problemas familiares'
t.`22a` AS '22-Retira - Otros', -- '22-Retira - Otros'
t.`23a` AS '23-No debe asistir - Inclemencias climáticas',	-- '23-No debe asistir - Inclemencias climáticas'
t.`24a` AS '24-No debe asistir - Problemas Edilicios', -- '24-No debe asistir - Problemas Edilicios'	
t.`25a` AS '25-No debe asistir - Otros', -- '25-No debe asistir - Otros'
t.`29a` AS '29-Presente No Presencial', -- '29-Presente No Presencial'	
t.`30a` AS '30-Presente No Presencial - Alternancia', -- '30-Presente No Presencial - Alternancia'	
t.`31a` AS '31-Presente No Presencial - Cuarentena - Contacto Estrecho Escolar', -- '31-Presente No Presencial - Cuarentena - Contacto Estrecho Escolar'	
t.`32a` AS '32-Presente No Presencial - Cuarentena - Contacto Estrecho No Escolar', -- '32-Presente No Presencial - Cuarentena - Contacto Estrecho No Escolar'	
t.`33a` AS '33-Presente No Presencial - Persona en grupo de riesgo' -- ,-- '33-Presente No Presencial - Persona en grupo de riesgo'
-- CONCAT ('*','*') AS 'sep'		


FROM (

		SELECT
		ad.alumno_id AS 'Alumno_ID',
		p.id AS 'Persona_ID',
		p.documento AS 'DNI',
		p.apellido AS 'Apellido',
		p.nombre AS 'Nombre',
		n.descripcion AS 'nivel_',
		e.numero,
		e.id AS 'escuela_id',		
		c.descripcion AS 'Curso_',
		d.division AS 'Division',
		-- tur.descripcion AS 'Turno', 
		-- mo.descripcion AS 'Modalidad',
		n.descripcion AS 'Nivel',
		g.descripcion AS 'Gestion',
		s.nombre AS 'Supervisión',		
		e.id AS 'ID_escuela',
		e.cue AS 'CUE',
		e.subcue AS 'subcue',
		e.numero AS 'Numero_escuela',
		e.anexo AS 'Anexo',
		CONCAT(e.numero,'-',e.anexo) AS 'Número_Anexo',
		e.nombre AS 'Escuela',
		dep.descripcion AS 'Departamento',
		l.descripcion AS 'Localidad',		
		pap.ames,
		c.descripcion AS 'curso',
		d.division AS 'División', 
		@ames AS 'anio_mes',
		
		di.fecha_cierre AS 'fecha_cierre_asistencia',
		
		
		COUNT(DISTINCT CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) THEN did.fecha END) AS 'cDia', -- cuenta 1 en caso de que en did.fecha està la fecha o sea el presente
		 
		sum(ai.falta) AS 'Faltas',
		
		COUNT( CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND ai.inasistencia_tipo_id IS NULL THEN 1 END) AS 'Asistencia',	
		
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '2') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '2a', -- '2_Inasistencia_Si_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '2') AND (ai.contraturno = 'No') THEN ai.falta END) AS '2b', -- '2_Inasistencia_Si_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '2') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '2c', -- '2_Inasistencia_No_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '2') AND (ai.contraturno = 'No') THEN ai.falta END) AS '2d', -- '2_Inasistencia_No_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'NC') AND (ai.inasistencia_tipo_id = '2') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '2e', -- '2_Inasistencia_NC_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'NC') AND (ai.inasistencia_tipo_id = '2') AND (ai.contraturno = 'No') THEN ai.falta END) AS '2f', -- '2_Inasistencia_NC_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '3') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '3a', -- '3_Tardanza_Si_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '3') AND (ai.contraturno = 'No') THEN ai.falta END) AS '3b', -- '3_Tardanza_Si_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '3') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '3c', -- '3_Tardanza_No_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '3') AND (ai.contraturno = 'No') THEN ai.falta END) AS '3d', -- '3_Tardanza_No_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '4') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '4a', -- '4_Retiro_Si_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '4') AND (ai.contraturno = 'No') THEN ai.falta END) AS '4b', -- '4_Retiro_Si_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '4') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '4c', -- '4_Retiro_No_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '4') AND (ai.contraturno = 'No') THEN ai.falta END) AS '4d', -- '4_Retiro_No_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'NC') AND (ai.inasistencia_tipo_id = '5') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '5a', -- '5_Previo_ingreso_NC_Justificada_contraturno_Si'	
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'NC') AND (ai.inasistencia_tipo_id = '5') AND (ai.contraturno = 'No') THEN ai.falta END) AS '5b', -- '5_Previo_ingreso_NC_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'NC') AND (ai.inasistencia_tipo_id = '6') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '6a', -- '6_Posterior_egreso_NC_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'NC') AND (ai.inasistencia_tipo_id = '6') AND (ai.contraturno = 'No') THEN ai.falta END) AS '6b', -- '6_Posterior_egreso_NC_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '6') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '6c', -- '6_Posterior_egreso_No_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '6') AND (ai.contraturno = 'No') THEN ai.falta END) AS '6d', -- '6_Posterior_egreso_No_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '6') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '6e', -- '6_Posterior_egreso_Si_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '6') AND (ai.contraturno = 'No') THEN ai.falta END) AS '6f', -- '6_Posterior_egreso_Si_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '8') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '8a', -- '8_Presente_NC_No_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '8') AND (ai.contraturno = 'No') THEN ai.falta END) AS '8b', -- '8_Presente_NC_No_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND 
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '8') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '8c', -- '8_Presente_NC_Si_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '8') AND (ai.contraturno = 'No') THEN ai.falta END) AS '8d', -- '8_Presente_NC_Si_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '10') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '10a', -- '10_Tardanza+10m_Si_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '10') AND (ai.contraturno = 'No') THEN ai.falta END) AS '10b', -- '10_Tardanza+10m_Si_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '10') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '10c', -- '10_Tardanza+10m_No_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '10') AND (ai.contraturno = 'No') THEN ai.falta END) AS '10d', -- '10_Tardanza+10m_No_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '11') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '11a', -- '11_Ausente_Tardanza_Si_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '11') AND (ai.contraturno = 'No') THEN ai.falta END) AS '11b', -- '11_Ausente_Tardanza_Si_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '11') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '11c', -- '11_Ausente_Tardanza_No_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '11') AND (ai.contraturno = 'No') THEN ai.falta END) AS '11d', -- '11_Ausente_Tardanza_No_Justificada_contraturno_No'	
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '12') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '12a', -- '12_Retiro+10m_Si_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '12') AND (ai.contraturno = 'No') THEN ai.falta END) AS '12b', -- '12_Retiro+10m_Si_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '12') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '12c', -- '12_Retiro+10m_No_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '12') AND (ai.contraturno = 'No') THEN ai.falta END) AS '12d', -- '12_Retiro+10m_No_Justificada_contraturno_No'	
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '13') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '13a', -- '13_Ausente_Retiro_Si_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '13') AND (ai.contraturno = 'No') THEN ai.falta END) AS '13b', -- '13_Ausente_Retiro_Si_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '13') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '13c', -- '13_Ausente_Retiro_No_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '13') AND (ai.contraturno = 'No') THEN ai.falta END) AS '13d', -- '13_Ausente_Retiro_No_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------				
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '14') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '14a', -- '14_Tardanza,Retiro_Si_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '14') AND (ai.contraturno = 'No') THEN ai.falta END) AS '14b', -- '14_Tardanza,Retiro_Si_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '14') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '14c', -- '14_Tardanza,Retiro_No_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '14') AND (ai.contraturno = 'No') THEN ai.falta END) AS '14d', -- '14_Tardanza,Retiro_No_Justificada_contraturno_No'	
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '15') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '15a', -- '15_Tardanza+10m,Retiro_Si_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '15') AND (ai.contraturno = 'No') THEN ai.falta END) AS '15b', -- '15_Tardanza+10m,Retiro_Si_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '15') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '15c', -- '15_Tardanza+10m,Retiro_No_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '15') AND (ai.contraturno = 'No') THEN ai.falta END) AS '15d', -- '15_Tardanza+10m,Retiro_No_Justificada_contraturno_No'							
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '16') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '16a', -- '16_Tardanza,Retiro+10m_Si_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '16') AND (ai.contraturno = 'No') THEN ai.falta END) AS '16b', -- '16_Tardanza,Retiro+10m_Si_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '16') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '16c', -- '16_Tardanza,Retiro+10m_No_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '16') AND (ai.contraturno = 'No') THEN ai.falta END) AS '16d', -- '16_Tardanza,Retiro+10m_No_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '17') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '17a', -- '17_Tardanza+10m,Retiro+10m_Si_Justificada_contraturno_Si
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '17') AND (ai.contraturno = 'No') THEN ai.falta END) AS '17b', -- '17_Tardanza+10m,Retiro+10m_Si_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '17') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '17c', -- '17_Tardanza+10m,Retiro+10m_No_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '17') AND (ai.contraturno = 'No') THEN ai.falta END) AS '17d',	-- '17_Tardanza+10m,Retiro+10m_No_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '26') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '26a', -- '26_Ausente_Si_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '26') AND (ai.contraturno = 'No') THEN ai.falta END) AS '26b', -- '26_Ausente_Si_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '26') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '26c', -- '26_Ausente_No_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '26') AND (ai.contraturno = 'No') THEN ai.falta END) AS '26d', -- '26_Ausente_No_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'NC') AND (ai.inasistencia_tipo_id = '26') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '26e', -- '26_Ausente_NC_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'NC') AND (ai.inasistencia_tipo_id = '26') AND (ai.contraturno = 'No') THEN ai.falta END) AS '26f', -- '26_Ausente_NC_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '27') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '27a', -- '27_Ausente_Caso_confirmado_COVID_Si_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '27') AND (ai.contraturno = 'No') THEN ai.falta END) AS '27b', -- '27_Ausente_Caso_confirmado_COVID_Si_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '27') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '27c', -- '27_Ausente_Caso_confirmado_COVID_No_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '27') AND (ai.contraturno = 'No') THEN ai.falta END) AS '27d', -- '27_Ausente_Caso_confirmado COVID_No_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'NC') AND (ai.inasistencia_tipo_id = '27') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '27e', -- '27_Ausente_Caso_confirmado_COVID_NC_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'NC') AND (ai.inasistencia_tipo_id = '27') AND (ai.contraturno = 'No') THEN ai.falta END) AS '27f', -- '27_Ausente_Caso_confirmado_COVID_NC_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '28') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '28a', -- '28_Ausente_Caso_sospechoso_COVID_Con_síntomas_Si_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '28') AND (ai.contraturno = 'No') THEN ai.falta END) AS '28b', -- '28_Ausente_Caso sospechoso_COVID_Con_síntomas_Si_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '28') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '28c', -- '28_Ausente_Caso_sospechoso_COVID_Con_síntomas_No_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '28') AND (ai.contraturno = 'No') THEN ai.falta END) AS '28d', -- '28_Ausente_Caso_sospechoso_COVID_Con_síntomas_No_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'NC') AND (ai.inasistencia_tipo_id = '28') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '28e', -- '28_Ausente_Caso_sospechoso_COVID_Con_síntomas_NC_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'NC') AND (ai.inasistencia_tipo_id = '28') AND (ai.contraturno = 'No') THEN ai.falta END) AS '28f', -- '28_Ausente_Caso_sospechoso_COVID_Con_síntomas_NC_Justificada_contraturno_No'
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '34') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '34a', -- '34_Ausente_No_Presencial_Si_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'Si') AND (ai.inasistencia_tipo_id = '34') AND (ai.contraturno = 'No') THEN ai.falta END) AS '34b', -- '34_Ausente_No_Presencial_Si_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '34') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '34c', -- '34_Ausente_No_Presencial_No_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'No') AND (ai.inasistencia_tipo_id = '34') AND (ai.contraturno = 'No') THEN ai.falta END) AS '34d', -- '34_Ausente_No_Presencial_No_Justificada_contraturno_No'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'NC') AND (ai.inasistencia_tipo_id = '34') AND (ai.contraturno = 'Si') THEN ai.falta END) AS '34e', -- '34_Ausente_No_Presencial_NC_Justificada_contraturno_Si'
		sum(CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND
			(ai.justificada = 'NC') AND (ai.inasistencia_tipo_id = '34') AND (ai.contraturno = 'No') THEN ai.falta END) AS '34f', -- '34_Ausente_No_Presencial_NC_Justificada_contraturno_No'
		
		-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
		COUNT( CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND ai.inasistencia_tipo_id IN (1) THEN 1 END) AS '1a', -- '1-Resumen mensual'	
		COUNT( CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND ai.inasistencia_tipo_id IN (7) THEN 1 END) AS '7a',	-- 7-Fuerza mayor'
		COUNT( CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND ai.inasistencia_tipo_id IN (9) THEN 1 END) AS '9a', -- '9-No corresponde'	
		COUNT( CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND ai.inasistencia_tipo_id IN (18) THEN 1 END) AS '18a',	-- '18-No corresponde'
		COUNT( CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND ai.inasistencia_tipo_id IN (19) THEN 1 END) AS '19a', -- '19-No debe asistir'	
		COUNT( CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND ai.inasistencia_tipo_id IN (20) THEN 1 END) AS '20a', -- '20-Retira - Inclemencias climáticas'	
		COUNT( CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND ai.inasistencia_tipo_id IN (21) THEN 1 END) AS '21a',	-- '21-Retira - Problemas familiares'
		COUNT( CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND ai.inasistencia_tipo_id IN (22) THEN 1 END) AS '22a', -- '22-Retira - Otros'
		COUNT( CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND ai.inasistencia_tipo_id IN (23) THEN 1 END) AS '23a',	-- '23-No debe asistir - Inclemencias climáticas'
		COUNT( CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND ai.inasistencia_tipo_id IN (24) THEN 1 END) AS '24a', -- '24-No debe asistir - Problemas Edilicios'	
		COUNT( CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND ai.inasistencia_tipo_id IN (25) THEN 1 END) AS '25a', -- '25-No debe asistir - Otros'
		COUNT( CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND ai.inasistencia_tipo_id IN (29) THEN 1 END) AS '29a', -- '29-Presente No Presencial'	
		COUNT( CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND ai.inasistencia_tipo_id IN (30) THEN 1 END) AS '30a', -- '30-Presente No Presencial - Alternancia'	
		COUNT( CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND ai.inasistencia_tipo_id IN (31) THEN 1 END) AS '31a', -- '31-Presente No Presencial - Cuarentena - Contacto Estrecho Escolar'	
		COUNT( CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND ai.inasistencia_tipo_id IN (32) THEN 1 END) AS '32a', -- '32-Presente No Presencial - Cuarentena - Contacto Estrecho No Escolar'	
		COUNT( CASE WHEN did.fecha BETWEEN CAST(@fecha_desde AS DATE) AND CAST(@fecha_hasta AS DATE) AND ai.inasistencia_tipo_id IN (33) THEN 1 END) AS '33a' -- '33-Presente No Presencial - Persona en grupo de riesgo'
		
		FROM escuela e
		JOIN planilla_asisnov_plazo pap ON pap.ames BETWEEN @ames AND @ames
		JOIN division d ON d.escuela_id = e.id
		JOIN curso c ON c.id = d.curso_id
		JOIN nivel n ON n.id = e.nivel_id
		JOIN dependencia g ON g.id = e.dependencia_id
		LEFT JOIN supervision sup on e.supervision_id = sup.id
		JOIN alumno_division ad ON ad.division_id = d.id AND ad.ciclo_lectivo = 2024 AND ad.estado_id = '1' AND pap.ames BETWEEN DATE_FORMAT(ad.fecha_desde, "%Y%m") AND COALESCE(DATE_FORMAT(ad.fecha_hasta, "%Y%m"),pap.ames)
		LEFT JOIN division_inasistencia di ON di.division_id = d.id AND di.mes=pap.ames
		
		
		LEFT JOIN division_inasistencia_dia did ON did.division_inasistencia_id = di.id
		LEFT JOIN alumno_inasistencia ai ON ai.division_inasistencia_dia_id = did.id and ai.contraturno IN ('Si' , 'No') AND ai.alumno_division_id = ad.id
		LEFT JOIN inasistencia_tipo it ON ai.inasistencia_tipo_id = it.id
		JOIN alumno a ON a.id = ad.alumno_id
		JOIN persona p ON p.id=a.persona_id
		JOIN localidad l ON e.localidad_id = l.id
		JOIN departamento dep ON l.departamento_id = dep.id
		
		LEFT JOIN supervision s ON s.id=e.supervision_id 
		
		WHERE
		-- e.dependencia_id IN (1 , 2)
		-- AND
		n.id IN(2 , 3 , 4 )
		AND 
		c.id NOT IN  ('287','288','289','290','291','293', '294')
		-- AND
		-- a.id = '337510'
		
		-- n.id IN('5','6','7','8','9','10','12','13','15','16','17','18','19','20','21','22','23','24','25','26' )
		-- AND
		-- e.numero = 'P002'
		-- AND
		-- p.documento = '53664867'
		-- AND
		-- c.descripcion IN ('1°' , '2°' , '3°')
		-- c.id IN ('2','3','4','15','16','17','73','209','240','241','242') -- 2 , 3 y 4to secundarias
		
		-- AND did.fecha >= @fecha_desde
		-- AND did.fecha <= @fecha_hasta
		
		GROUP BY e.nivel_id , e.id , a.id
		ORDER BY 
		e.id,
		e.numero,
		e.anexo,
		c.descripcion,
		d.division,
		n.id
		-- gestion
) t