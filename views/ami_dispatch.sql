CREATE OR REPLACE VIEW DM_DATASCIENCE.AMI_DISPATCH
AS
WITH jobs_events
     AS (SELECT J.event_idx,
                J.begin_time,
                J.restore_time,
                J.trouble_code,
                J.alarm_state,
                J.num_cust_out,
                J.operator_comment,
                J.power_up_count,
                J.call_type
         FROM   outagemanagement.jobs J
         WHERE  1 = 1
                AND J.complete = 'Y'
                AND J.alarm_state NOT IN ( 'NFY' )
                AND J.trouble_code LIKE '%AO-AMI%'
                AND J.begin_time > '31-DEC-2018' -- update the date here!
        --AND J.EVENT_IDX ='601079'
        ),
     when_assigned
     AS (SELECT Min(CA.when_assigned) WHEN_ASSIGNED,
                CA.assignment_idx
         FROM   outagemanagement.crew_assignments CA
         WHERE  CA.action = 'AS'
                AND CA.when_assigned = CA.when_happened
         GROUP  BY CA.assignment_idx),
     customer_calltime
     AS (SELECT I.event_idx,
                Min(input_time) CUSTOMER_CALL_TIME
         FROM   outagemanagement.incidents I,
                jobs_events JE
         WHERE  I.event_idx = JE.event_idx
                AND I.short_desc != 'AO-AMI'
         GROUP  BY I.event_idx)
SELECT DISTINCT J.event_idx,
                J.begin_time,
                J.restore_time,
                WA.when_assigned,-- wa.crew_name,
                CC.customer_call_time,
                J.trouble_code,
                J.alarm_state,
                J.num_cust_out,
                J.operator_comment,
                PC.reason_for_update,
                PL.system_om,
                PL.failure_om,
                PL.interrupt_dev_om,
                PL.remedy_om,
                J.power_up_count,
                (SELECT Count(1)
                 FROM   outagemanagement.incidents I
                 WHERE  I.event_idx = J.event_idx
                        AND I.short_desc = 'AO-AMI') NUMBER_OF_POWER_OFFS,
                J.call_type
FROM   jobs_events J,
       when_assigned WA,
       customer_calltime CC,
       outagemanagement.picklist_completion_log PC,
       outagemanagement.picklist_info_upd_tr PL
WHERE  1 = 1
       AND WA.assignment_idx(+) = J.event_idx
       AND CC.event_idx(+) = J.event_idx
       AND PC.field_name IS NULL
       AND PC.ref_id = J.event_idx
       AND PL.ref_id(+) = J.event_idx ;