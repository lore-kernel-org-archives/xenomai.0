Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011031.outbound.protection.outlook.com [40.107.130.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A689355057
	for <xenomai@lists.linux.dev>; Thu, 11 Jun 2026 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164568; cv=fail; b=mkLzFWYstShy+eYuR5MJrPEdQmoInWy2ED/V6Sop2b9ZI60gSM8yjOZrcKIwS8RpzqJ3i3O/tqTpDdBM2N+9cazRhCBCAi3oCJ3T0goAJEpNaqNUca0tvNtlfJnxriXX4E+O2lV+DijkhheE3epQrnfMysaEwaBlXWfWbSba50c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164568; c=relaxed/simple;
	bh=PciTvlEDelh4ULCp3uK6Y/qiwpxb2jMQ41n2iMVdDO8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fFphxIHFs66k5i2KcFXxr+r2wpCHFIeg4eDN3Nv8QNbbr7drOYS9T/YEyBaJFxsarA2Uwqb5yvu+B6ngsXUoIwtDytX8/Eosi3FHLM2U2lAo6cYEwCPbAecwlGoRzdDH15vBZnKerR188SWfJQe9aS97+CkDgRIvogLRCzPilcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VmWDAFXP; arc=fail smtp.client-ip=40.107.130.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VmWDAFXP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrYrcrJrsg073yIJx8vkkxxjlZ8oFeiEG9IS7MTNRPuga//NuMf4igxL+HkAjPsh2h4jMNFRcoUg5zRGhrYEFdzEjXMHj+pSiKuEqNE3E8Z4JHIBEG+5Ya+cmCdPSxKOe40kwdIuBD4OItuvsFmJIgzROvVF1hU+pyFa6Sm++RLRp/a7AY4asShzJKPL51fpQskVAH4qL2Ql4CPoIguSKQGvne1v5gZx/9cSEnj+kRCX+Pfr6bx4i32NUi12G7jwXJiTSbDGECuFeq9yA8wlsLm86QsSMrJrEC4tiNHTHe8LJte5Yf0pB5N80DacqKe1pS3PjLuuQbobp1NPkU0KgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ecZ/fzEETO/ZiQ1+OVrpBWMVrmNdd8xbN8NFBQeNSM=;
 b=XJ7sdtVRsxOISkWPX4qO11wEku7Y+7ljIWCExDyj10aWKwXFkAw+4oV/3FC7sykiZ/D5QVfElKHO2D8SZK38OO1J8qch0P4zfvf83hKsOSIBZhx7nMB5PAbsS5jLCpWfVhhsQQY7j8/Jm4uGUAi1Da4wABL0R2vD8vk3J/kZsXUo1jA3R6f2sam+JsQMkK3+S4W+ksWuQQmuKQq/1ijjoF2O3AcPbIbuBTsaCJDRPTIywxSF21w7LmdcT3IDB/ylIesgL3Po3Vo7SjzFYHA3yHmiqXQ6tKgRVXxqMZnubrQqVMxBbSLcdGhe21uVgHuCANAg7j6skV1JdneWF4L+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ecZ/fzEETO/ZiQ1+OVrpBWMVrmNdd8xbN8NFBQeNSM=;
 b=VmWDAFXPGr+LIEXd7k+yDPRsI3HCwcyWGVcs6zRzUT+J494lqI7L79ZulRgphKeMzpVitaHGvqYEr/fe+sqWtvWcO2/WO3d/TAcRl7+R3CJcIGHr4+1nj6JInkmrP1+ZqPFeI/4A1Dwcnd8wDNkSuD9BSt7DDrVrFCTXqhRZkz8WD7jDiWmFgc+yc4LakVDpEFHadPqZvzt3yzPWjsQFFAee6fKbLWuph22cyFHYJDwhsHJuUJmQPO5poOTpUsjuIjkRerMGsENc3jwBZ54Xa8RWauSrTyexMVQ2Yp/L3DY707gmR9DDlbu+b1NKQwvoiggW7A+5e1eeykV+v2RD2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6912.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:32f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 07:56:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 07:56:03 +0000
Message-ID: <2becb808-b1ef-4d3e-b1e7-121697cef154@siemens.com>
Date: Thu, 11 Jun 2026 09:56:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: SCHED_SPORADIC in Xenomai 3
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <19c8bc29-9eb5-4265-931a-1cc5c34ba1ac@siemens.com>
 <5bb1aace-8083-400b-9e74-5a047873a1ed@siemens.com>
 <c5761187-9689-45b1-9527-89cc8a5b2763@siemens.com>
 <2227cdf6-d2cc-4f5a-87ab-d09861d4ce26@siemens.com>
 <30be9f34-4fd0-47fc-932f-70970217acb0@siemens.com>
 <87y0glbjp6.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87y0glbjp6.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c45616-e985-44ca-aeb8-08dec78ee267
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|55112099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	W5DNpAhNY25B+Sq4r4TR2XkVmvdrmXXDSCr4Mx/UIWKOhhdGEwEm/d7jJPct31kqG9qel0NEPf8J/3X4IagUoH35rozLGqPc0r7AOyvekKUtN9hkeOl5vYjOHCGd61tRqrv/MW5u2llniAIkhggqFr1JA7c8XpXkjo8dJgiY5HaHpWrqZlr22w33F5QqgjhcL7iZbXUqnaW3knu4p4yKI7FXUczkd35AcD7qyS5dL1HYG27BfmivJf+UNnMZijHjRuU/9dzk9NIfy54P407Usg1MaNAZvJDFAOhAUGwD1ULPQSFLKSZ9B26aSjVV6Vef8Hjwk+EnNNq9y7oE4bVqmEmvx/AdXO8QXR91zj8gGJq8o3V6yVCVvx0Ci3RBuJuXpXhTF24WcotrYokn+ZsEHdh4+9AAwGNYCoKS8IIstdR6jw01WPkZE0MYM4ftHnK57lpaSE4/WHek5fIH5FnBOKJrfC9h/lQP0UrnHyoQ/gn1+VJ3vaSw5oaZLtps4hCITkNXZbHfjSZY8SjWPq5vzvbAEOCkTygrMrKF023z4Oon3N50h3LMfDVtzoMCwrh4hByEo0f4W5xWjwgf0FClgsGfhR8Sz8rSQXWfOLFBcO9kdZcN0aL6visrJKuvqbW/0GFTu31A3sZn1Y8InGGoVzPWQhA+3Vii9yOXNanioF+pO8kl+04ZME3r0fmLQMVK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(55112099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a283TGJFb1M1S0Q3YW8zWFZ5cVV4SThMYlpYNWxuQ2RwZ01YRnNqc1VZWFpB?=
 =?utf-8?B?MzFqVkFiQkdCcnh5MTA5UXJkcnVyQXRwOXQ1eUEvQk5NYUJwZktPOHFWK291?=
 =?utf-8?B?Q2RoZmZrQ3lVVTJGRjM0QjJsZ2pPd3NLam9FWXVUb0oyeTl0L1JGa3RhSEtQ?=
 =?utf-8?B?VXo5QU1kbUEvSFpYT0U0dU54QUdhNXpVVXlxMGtxUHJlTjJIVXJtc2pibTQr?=
 =?utf-8?B?ZFJ5YmlBWTQ0eGVVNzdFZVc4YTBGcUxLcDRhY2FsYzNVYUVySmlpR083Qnl3?=
 =?utf-8?B?NSs5Qm9GVnBoYVlSV1M5YnpmYXVlUHlUeHJWeWRNWU9zKzd5aDlMVkNiaFQ0?=
 =?utf-8?B?LzNvOTFONFVXL2I0OG1mWFFZVENQUWZzcFY1Tmh2SzdNa3NQWTZwOE9GdlNi?=
 =?utf-8?B?RG5ZY1BXSzE0VFIxelppNWF1N05iSzRPNG1JWjNXc2tUZUFaU3VqNXRUTy9a?=
 =?utf-8?B?Umh2bjN0ZHZSREFjR2FtSVpJNGtmK1VCeHl1YnpSa2dtbnRISXIyZTlkaUpD?=
 =?utf-8?B?aDViUHJEeGF5SFoycXhVR3BrcGxnM0hwY0RQNll3cXJWYVdPS3hrUkpHUUNO?=
 =?utf-8?B?Njd2K3JrYXlPUUxxcmlqbXp5SFVONGVKUURLZjFvZHB3NEF3THIwYk5hMTVP?=
 =?utf-8?B?QzRxVWpIRVBSSkY2aDdFalhoUC9sWUxOOTl4U0RSTmVvNEdjZ3RreTF6Z1hr?=
 =?utf-8?B?NjFzaVlzYUtRSko2S0tsWXN5c01NVUVFRFppMDdvUlBpUWdBUjErT3lIYThY?=
 =?utf-8?B?aDAxb2tIWW1PS2FMYk5ZUm1taTRhMWVPOUlrbjdsNU5hZzNHaDdsajIwWVpm?=
 =?utf-8?B?SWpnOXN5VTF1b0QvUE5wZGNzN3U0cGFRckQyUTVsWFVkWVFKam1UenhRSis4?=
 =?utf-8?B?R041ZjB2K3l5VlpvYjNTN2ZvZXRKRTVteklBY1g5aUZKR0ZEQlZWc3RrcGhG?=
 =?utf-8?B?YndtaVZobVNDMzJkNVFTdU16aFEzWFAvZjFhSURFZ09rMjlxZk80N0lTemFv?=
 =?utf-8?B?U1pzTmI3aTZHQ09UMUFsZEs1K1lYRE1vSmRIckVBRTh0UHBDbUE0RDYwR2Zv?=
 =?utf-8?B?MHNJRWV2bXBYWFpuaElEVFhwTjQ5ZjNjVXE4b2pBQlNEWDhGU2FNTWFQd2pO?=
 =?utf-8?B?QUZmT1pvTmkzeVkraGxaVUVQNTZDTzNiZzlnb2oyWkI2dzFXMkFmbVZUNEl1?=
 =?utf-8?B?MkMra25GSVFLMmJmRCtMWTIzV1lKbU5uWmk3MWlOaUlFQnF6Y3BGUTJzZkh3?=
 =?utf-8?B?NFJGbHh1ZEZSWHlXMzdvK0xlSEViOHdhRzE5MDlZaHlOb08reFVjcVYwZ1hq?=
 =?utf-8?B?WXF4dUZUSG9QQkVOVjVVWC9TK2lYWnVYMEZSYkd5bUUwRjVseDJlZ01SZ0wv?=
 =?utf-8?B?QkpjR1RIOXU4K1g2YnNaNFdJRFlXMUZHY3lEUksvbGhDRWQ4MUc0dUtpd0VK?=
 =?utf-8?B?OTRUVXRTdUFCcEtrUTluK2FFS0VWT3VnMStIcGZJT2NGSlkxUFNTSnZJWWdX?=
 =?utf-8?B?VndyclpLVW1UYTdjWDJVcUVUSHgyME9ERFFsdndwdHJmTjREbHNBOFJCM08w?=
 =?utf-8?B?d29hVzFCZ2JqdHkzMkFiVk9mQVpvWVpjdHhIcGo4WHdpMkFTV0I5YlZkdnM5?=
 =?utf-8?B?OCszQUZxRC9SQmU1dzNEMlVvNldPMUJKY3VqWThKVFJRLzkrdHRaanR4b2VE?=
 =?utf-8?B?NDFqcmVGd1oxSlZMM3FFMWlSMmR0LzJXRjVLU2J0UzhDR1B1dTlqdUJ6YW85?=
 =?utf-8?B?SUFnWFE1UldaMm5aUk9oNHJjY0plSFB0cTR4c0JuMmNHQ0IzUDU4T2VoRGZj?=
 =?utf-8?B?Y0NyelIzczhqREZnZjFXbnNTeHJaNFZsMGo0UkRFdDlCWFpZbzJNdHloNHJD?=
 =?utf-8?B?SXhMUUFuNVhHeUZGL1BscHNhTk9YSzRNSDBMTEplY2VoWDhESEI1eU1IRnlI?=
 =?utf-8?B?UVQ0ZFpWd2E1eWh1QTNnZkVDVUJneVdKdkJRTWxvVkJPTWhCZ1cvbjFETElC?=
 =?utf-8?B?ZlQxZW1RTTJuSlE3Z0hwSkFRMm9RODFNVHBtOHNOOWo1NEJiT1gwYkNvc3pT?=
 =?utf-8?B?S1d5RHQveUNaR0E2M0VGSXVaWGg2SkdKNmI2d05ROUxjVjVJc3p4dDJTQk5h?=
 =?utf-8?B?eGh6RitUajNyMkVTM2Rld1grSzQwTXpzaTZiNjA1ZDhhSXpkS2dieDZoZTZ5?=
 =?utf-8?B?N2xGV2VWNkxmRVh5ekM2MitIWnNiWVhzTjM2c3ZlWk9keDZPcnVXbDBCOHdk?=
 =?utf-8?B?QzFlOXhLU01ORHBWdlFBMVlFKzIrYjRqSis2c0dDRG9KWVUrWkxTajJoVmxU?=
 =?utf-8?B?VkNlNGNCTVp5amNXOTB6TllPNWVFclVQWHAxLzZIb05rQUM2S2Rvdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c45616-e985-44ca-aeb8-08dec78ee267
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 07:56:03.2679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmkgqlRsYkEUk+ifbuh9WMF0KX56xi5Ul5nv5WPnDFC6wE5SKaqcWoeHQsCjuNkW6YsSRWzwCa9lovKmjsB87Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6912

On 11.06.26 09:49, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
>> index d527b6be2c..6dfbf83220 100644
>> --- a/kernel/cobalt/sched.c
>> +++ b/kernel/cobalt/sched.c
>> @@ -895,6 +895,7 @@ static inline void do_lazy_user_work(struct xnthread *curr)
>>  
>>  int ___xnsched_run(struct xnsched *sched)
>>  {
>> +	struct xnsched_class *prev_schedclass __maybe_unused;
>>  	bool switched = false, leaving_inband;
>>  	struct xnthread *prev, *next, *curr;
>>  	spl_t s;
>> @@ -933,6 +934,13 @@ int ___xnsched_run(struct xnsched *sched)
>>  
>>  	prev = curr;
>>  
>> +#ifdef CONFIG_XENO_OPT_SCHED_CLASSES
>> +	prev_schedclass = prev->sched_class;
>> +	if (prev_schedclass->weight < next->sched_class->weight &&
>> +	    prev_schedclass->sched_out)
>> +		prev_schedclass->sched_out(prev);
>> +#endif
> 
> I would call the scheduling out hook unconditionally, the sched class
> has all the information required to sort this out, do the right thing,
> which the generic scheduler does not.

That would mean moving the accounting out of the pick callback
unconditionally as well - leaving some smaller synergies on the road.
Need to look into that closer, though.

>>
>> Something analogous for sched-sporadic does not help. It looks broken in 
>> its algorithm, specifically that is schedules consumed budget for 
>> recharge on preemption, rather than reducing the remaining budget.
> 
> Since the original implementation did not account for the preemption
> case in budget-tracking classes, that makes sense.
> 

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
