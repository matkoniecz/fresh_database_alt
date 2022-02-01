psql colouringlondondb
\l # list databases
\c colouringlondondb # connect
\dt # list tables
SELECT building_id, attribute, verified_value FROM building_verification;

\dt reference_tables.*
SHOW search_path;
SET search_path TO reference_tables;
\dt
SELECT * FROM buildings_landuse_class;


SELECT current_landuse_order
FROM buildings
WHERE current_landuse_order= 'Unclassified buildings';

SELECT
    geometry_id,
    current_landuse_order,
    CASE WHEN verified_value IS NULL THEN 0 ELSE 1 END AS verified_residential 
FROM
    buildings
LEFT OUTER JOIN
    building_verification
ON
    buildings.building_id = building_verification.building_id
WHERE
    (building_verification.verified_value = '["Dwellings"]' AND attribute = 'current_landuse_group') OR building_verification.verified_value IS NULL
;

SELECT * FROM building_verification;
verification_id |verification_timestamp   | building_id |               user_id                |           attribute           | verified_value
              59 | 2021-12-25 19:58:21.278366 |     2402812 | 1366e576-d67e-4eee-bb12-9ebabac4793a | current_landuse_group         | ["Dwellings"]
              60 | 2021-12-25 19:58:26.805859 |     2402773 | 1366e576-d67e-4eee-bb12-9ebabac4793a | current_landuse_group         | ["Dwellings"]
              61 | 2021-12-25 19:58:32.226357 |     2515962 | 1366e576-d67e-4eee-bb12-9ebabac4793a | current_landuse_group         | ["Dwellings"]
              62 | 2021-12-25 19:58:36.772896 |     2402805 | 1366e576-d67e-4eee-bb12-9ebabac4793a | current_landuse_group         | ["Dwellings"]
              63 | 2021-12-25 19:58:42.426324 |     2402797 | 1366e576-d67e-4eee-bb12-9ebabac4793a | current_landuse_group         | ["Dwellings"]
              64 | 2021-12-25 20:00:44.990971 |     2601356 | 1366e576-d67e-4eee-bb12-9ebabac4793a | current_landuse_group         | ["Dwellings"]
              65 | 2021-12-25 20:00:51.672505 |     2462508 | 1366e576-d67e-4eee-bb12-9ebabac4793a | current_landuse_group         | ["Dwellings"]
              

 building_id |     ref_toid      | ref_osm_id | geometry_id | revision_id | location_name | location_number | location_street | location_line_two | location_town | location_postcode | location_latitude | location_longitude | date_year | date_lower | date_upper |  date_source   |                            date_source_detail                            | facade_year | facade_upper | facade_lower | facade_source | facade_source_detail | size_storeys_attic | size_storeys_core | size_storeys_basement | size_height_apex | size_floor_area_ground | size_floor_area_total | size_width_frontage | likes_total | planning_portal_link | planning_in_conservation_area | planning_conservation_area_name | planning_in_list | planning_list_id | planning_heritage_at_risk_id | planning_world_list_id | planning_in_glher | planning_glher_url | planning_in_apa | planning_apa_name | planning_apa_tier | planning_in_local_list | planning_local_list_url | planning_in_historic_area_assessment | planning_historic_area_assessment_url | planning_list_cat | planning_list_grade | date_link | sust_breeam_rating | sust_breeam_date | sust_dec_date | sust_dec | sust_aggregate_estimate_epc | sust_retrofit_date | sust_embodied_carbon | sust_life_expectancy | sust_lifespan_average | building_attachment_form | date_change_building_use | current_landuse_order | current_landuse_group | current_landuse_class | construction_core_material | construction_secondary_materials | construction_roof_covering | demolished_buildings | dynamics_has_demolished_buildings | community_public_ownership_source | community_local_significance_total | community_activities | community_public_ownership | community_public_ownership_sources 


SELECT * FROM building_properties LIMIT 10;
SELECT * FROM buildings LIMIT 10;
SELECT * FROM buildings LIMIT 10;
SELECT current_landuse_order FROM buildings LIMIT 10;
 current_landuse_order 
-----------------------
 Residential
 Residential
 Residential
 Residential
 Residential
 Residential
 Residential
 Residential
 Residential
 Residential


SELECT current_landuse_group FROM buildings LIMIT 10
 {Dwellings}
 {Dwellings}
 {Dwellings}
 {Dwellings}
 {Dwellings}
 {Dwellings}
 {Dwellings}
 {Dwellings}
 {Dwellings}
 {Dwellings}
