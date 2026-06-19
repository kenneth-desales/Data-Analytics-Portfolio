-- ==============================================================================
-- Project: Multi-Channel Marketing ROI Tracking
-- Description: SQL script to clean raw data, aggregate metrics, and calculate 
--              performance indicators (ROI, CPC) across ad channels.
-- ==============================================================================

SELECT 
    campaign_name,
    ad_channel, -- e.g., Facebook Ads, Google Ads
    
    -- Cleaning NULL values (replacing blanks with 0) and aggregating metrics
    SUM(COALESCE(impressions, 0)) AS total_impressions,
    SUM(COALESCE(clicks, 0)) AS total_clicks,
    SUM(COALESCE(ad_spend, 0)) AS total_spend,
    SUM(COALESCE(revenue_generated, 0)) AS total_revenue,
    
    -- Calculating Cost Per Click (CPC)
    -- Using NULLIF to prevent "division by zero" errors in the database
    (SUM(COALESCE(ad_spend, 0)) / NULLIF(SUM(COALESCE(clicks, 0)), 0)) AS cost_per_click,
    
    -- Calculating Return on Investment (ROI) percentage
    ((SUM(COALESCE(revenue_generated, 0)) - SUM(COALESCE(ad_spend, 0))) 
      / NULLIF(SUM(COALESCE(ad_spend, 0)), 0)) * 100 AS roi_percentage

FROM 
    marketing_campaigns_raw
WHERE 
    -- Filtering for the active campaign year
    campaign_date BETWEEN '2025-01-01' AND '2026-01-01'
GROUP BY 
    campaign_name, 
    ad_channel
ORDER BY 
    roi_percentage DESC;
