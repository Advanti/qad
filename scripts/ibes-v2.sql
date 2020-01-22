use OpenAristos
;
go

drop view if exists dbo.IBESV2_TREInfo_Enriched
;
go

create view dbo.IBESV2_TREInfo_Enriched
as
/*
Purpose:
Add Human Readable Codes

Description:
Add's DefCurrCode, DefPerCurrCode, DefTPCurrCode, and ExpCurrCode to the data for more meaningful analysis.
Uppercase all currency codes as some come through like "GBp" so instead it's "GBP".
*/
select
TREInfo.*,
upper(default_currency.Description) as DefCurrCode,
upper(default_per_share_currency.Description) as DefPerCurrCode,
upper(default_price_target_currency.Description) as DefTPCurrCode,
upper(expected_reporting_currency.Description) as ExpCurrCode
from qai.dbo.TREInfo
inner join qai.dbo.TRECode as default_currency
on TREInfo.DefCurrPermID = default_currency.Code
and default_currency.CodeType = 7
inner join qai.dbo.TRECode as default_per_share_currency
on TREInfo.DefPerCurrPermID = default_per_share_currency.Code
and default_per_share_currency.CodeType = 7
inner join qai.dbo.TRECode as default_price_target_currency
on TREInfo.DefTPCurrPermID = default_price_target_currency.Code
and default_price_target_currency.CodeType = 7
inner join qai.dbo.TRECode as expected_reporting_currency
on TREInfo.ExpCurrPermID = expected_reporting_currency.Code
and expected_reporting_currency.CodeType = 7
;
