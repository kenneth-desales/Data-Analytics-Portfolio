-- ==============================================================================
-- Project: Customer Operations Efficiency Tracker
-- Description: SQL script to process support ticket timestamps, extract 
--              critical time-series metrics (FRT, MTTR), and identify bottlenecks.
-- ==============================================================================

SELECT 
    ticket_id,
    created_at,
    first_replied_at,
    resolved_at,
    
    -- Extracting the specific hour to identify high-volume bottleneck periods
    HOUR(created_at) AS ticket_hour,
    
    -- Calculating First Response Time (FRT) in hours
    TIMESTAMPDIFF(HOUR, created_at, first_replied_at) AS first_response_time_hours,
    
    -- Calculating Mean Time to Resolution (MTTR) in hours
    TIMESTAMPDIFF(HOUR, created_at, resolved_at) AS resolution_time_hours

FROM 
    support_tickets
WHERE 
    status = 'Resolved'
    AND first_replied_at IS NOT NULL
ORDER BY 
    created_at DESC;
