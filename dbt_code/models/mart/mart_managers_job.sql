with
    fct_job_ads as (select * from {{ ref('fct_job_ads') }}),
    dim_occupation as (select * from {{ ref('dim_occupation') }}),
    dim_employer as (select * from {{ ref('dim_employer') }}),
    dim_job_details as (select * from {{ ref('dim_job_details') }}),
    dim_auxilliary_attributes as (select * from {{ ref('dim_auxilliary_attributes') }})
select
    f.vacancies,
    f.relevance,
    e.EMPLOYER__NAME,
    o.occupation,
    o.occupation_group,
    o.occupation_field,
    j.HEADLINE,
    j.DURATION,
    e.workplace_address__municipality,
    a.DRIVING_LICENSE_REQUIRED,
    f.application_deadline,
from fct_job_ads f
left join dim_occupation o on f.occupation_id = o.occupation_id
left join dim_employer e on f.employer_id = e.employer_id 
left join dim_job_details j on f.job_details_id = j.job_details_id
left join dim_auxilliary_attributes a on f.auxilliary_attributes_id = a.auxilliary_attributes_id
where o.occupation_field = 'Chefer och verksamhetsledare'