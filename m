Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121AD2E11B8
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977282; cv=fail; b=XVY+WMa7CRsYFnewz3Q4dQe4Un2ZBcR9Iq7S7rniEx5yrzmTIbLAtZ6b1RMQPnSmV7fj8KMad+AjQmE1tnOFKsnPW49fPHO6WsCTMAb5ezd/I9nOc8HGdSx3KAK+KSxAIW1TiWqU7kHIKfS9RwpJPDw4VUhjn4uwj9yqYnpmQls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977282; c=relaxed/simple;
	bh=kO0oSKJXe6AoBb6RLJbvXB2w5girdm5xnoptntDuW7Q=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=ny65jzjdpoX2FzLzcwK6x/13m8h2PRThlSkQ9NgDItkZP1LqliUgy9XaJlcw+7/pKg4LZ1DOx9UxAlfFsslzLAG1ModGQBAOr4B9nPRaMubi2XN0isXz8Aoynabm+d36YZRJ9q6xYgrLxU8NZlQIMCVF/2uCWoRW2CHGXwgw/lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zZKn8+Oc; arc=fail smtp.client-ip=52.101.70.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zZKn8+Oc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lz/HsqRVG06ytJqeTx1CYNKBdXh/n3/7Z6mwr5h2yeJwXC87a7tZDVUROZOfoZRwEBaJt8Px1u/SAamE3FetqQQs2iFz9MVhfI8nz4C6Kq8Ac6d3gmFtN906r32PRJONG5UmeyB5uz1HKM9Qb8yH+9KlWzuio5nJtIhwqXYRCVpkAV6Y6iZHJRBbaftKpSxRFvI08UliSqxtLCWpMIcOeYW3ypjmiLZf+Bb6g8r42zFpsVzqhBnpezcz4RWGZNZdeQOh+pTKE1U6yDQG2x69aSJMF3GhwUyQoSkugWLNvDEl6E55tE3uGy5/WAicO/LgWQww3VvPXpT5ByL9vJ1gmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xy9lgsXbpQmh6pH4wT77auPdDXrncSG87CgmR+4Z6k=;
 b=e6nPIExBXtsS68Iltd94RFiqKoHDyEQjOQ8tEk5NqyZUqviP5IOmzJwaH4qUmwaKmsUVQK6n0kVTbzBCikWeklnuf5UJZQJXCKTI1Gcizg5bfc8lYPR1UTknHFUSK6KIJ8lNa/LD5r5zN2TgwFm74gKXxwB4aI+5ASfNBy4NoStXR3kEMF7yqnVD+cniSFRM79zVVjwAr/gDnPadTR98ynRYXYBxcMW+F6+sq+7TRDFXIrKA1oRyyiTGkZZgtKuoq7DIC9P5DcMwEAqXrxUbt3r3zunHgGmVG8NBRWw8KgHIOll6DtzvJPJr4FXWxUZJ9SaiVsrYcqe+EyRpEduLlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xy9lgsXbpQmh6pH4wT77auPdDXrncSG87CgmR+4Z6k=;
 b=zZKn8+OcNSvLkcTnZB5hoJJco7KQSgvGpJ5MO3XGMPmCfnDZ4GAL8yWieweRVcPVBwoSv43hXydtNTl+URgBX85JmCMnEUY1/0fVq+Y2bcijKqAK9VvMvGWyHev7eKhpkIibOtbKF5a+6GQNhIciBEPqf79hMf7DKcHQEVQj2NdB5xAezS0SiGXHo+9zORqzBWOlX80KN+/CbnFYtXv5n8e1SfwMgB0EoPdbLejB45Vc+hIoyHP41/c9G+lnfmjtK8ZT9IE1IAqjIFQHwcDA1OQzuxLk6rb7U/fU9N3o0H54t8XYN3ifxtffaj6k20KaWGas4eDtkqXnv3hbaeCEDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS8PR10MB6127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:548::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 09:14:37 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 09:14:37 +0000
Message-ID: <d890a459-ffb5-4afb-a3e1-28e374c3fd21@siemens.com>
Date: Thu, 4 Sep 2025 11:14:35 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Kconfig: Fix kernel default choices
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::13) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS8PR10MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: f946ddb5-71e9-4294-98fd-08ddeb937871
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUNxNUlmWGNOUzd0VEFGcEFmUHJwRUJvWFFJbHNXZUQzbVVYYWd3akVqeVZm?=
 =?utf-8?B?OTMzKzVLYzB0YWxBdXAzeXY2SGowV0podHRXaWM3U3cvLzVmYmlIVUQyVHNM?=
 =?utf-8?B?ZisvbjVEbitDbER1bWlXblBkRVNPY1VjN0ZtV2ZzWXoyWkoyYWVLV2dLU3Q4?=
 =?utf-8?B?NE4zaXJCTTVkQ1ZTTThVMTE1Y0FMc2JjQzlzYUx4RGoyR3p6Q2pXVDF6eHdt?=
 =?utf-8?B?YkhweVpocDgrdUJHVHB4WEhCdFNqOEQyUGdWcDRZUTlWT2dXZmZOQ3pJQ0JG?=
 =?utf-8?B?ZjdORFJ3dy9yRHlKempyMTBRRFVFUm93VTc4NEJIendJa281eTVleldZby9h?=
 =?utf-8?B?VEo1S1M4ZWNuT2hSL3hJdXlqVnNnV0hHL3hSL21CYTZScUk2T0hTSWlYa1I4?=
 =?utf-8?B?MWZ3YzQwUUs5TGhDOHN5RUdHeloxZVhBTFN0MVEybGJiZGloUHlET1MrY1Jh?=
 =?utf-8?B?MVBRM2lFT1gyaVlJczVOeTBPaGxsNDUzeUhCeG1iQnlnV3BzT0J6dG1pTHZy?=
 =?utf-8?B?cHZYbmd6WDVaL3lhUFFOcFNtZ1RaOWFUbC8xbnlEYUgxTFpnbWhPUmtlb2xp?=
 =?utf-8?B?UlFTa1dWNlVLZ0Q1VkpCUkZWeDBid1g2cWYraG9vazFxZlFjVDhUamVmb05P?=
 =?utf-8?B?QTNZbnZRMnV2ZDVielRPWDA1cThXakg5dGJMcVQzYVYvT3hYTG5jR1NUWHlX?=
 =?utf-8?B?NmkwVmVpRmpiWFM0bC9qN01qeEQwbnRVcFNFZTg1SS9hQnp3cDc3RlNSOC9w?=
 =?utf-8?B?TDRsNXJxa0hiZlI4V2pubElaTk0xNjFkNnRtWDNESFJ5N25XM2RHak05dmRp?=
 =?utf-8?B?a3BxLzZTRjhzdkprVUxJRmdhV01sTXVjSk9vNVJuc3VteVZ1bFgwODFjcVdt?=
 =?utf-8?B?RmNoaGVRdzRIa2ZBSERjZEU5Yzc0dVBBNjd3Q0p0TER1U0gxSTNET1lCQklk?=
 =?utf-8?B?L09oUnh2WE00bTBvY2NoY2FyMHhwUXoxU2lxVkcwRmVsZjZmWjE5V3V3SXpO?=
 =?utf-8?B?ZW5hd1I0b2NrejlZWlp3U2NrVG1IdWhxN0VuaDBMcWlUczQzRkRUM21ldmtD?=
 =?utf-8?B?T2JHRXBLNTRrQjZrckRUb2l1WjVWOWxlb3c1Z2ljWWFNOFJaUzVVTWJNa3pI?=
 =?utf-8?B?VlhIK1lQRVFlTmZGMDhhS2p6eGpTdzVGamFqUUdqK0hYV2grNktZRVFtQUhD?=
 =?utf-8?B?ejZQV0pGR3JjdmNSWG1NcTFHM3BkbzJQcmVrL3ZkaVBmb2t6S3g1dllNckp2?=
 =?utf-8?B?bWdGRFhkaFRmclJnLzk2RTJYQnlUV3hWblVnNTJrZFo3N3orV2ZSUDNyRmRk?=
 =?utf-8?B?MDBxQzB0NWtFdjN1MThYSEJBOWdnRVRIcE9QWS9IMStVazV0U0pIRk5sNVFz?=
 =?utf-8?B?U2w2MG9CdS94TEx3WVpZTFpVSWFyWlI3N2ZXcVlaN2dZVWJpMTZrY2ZlTmZk?=
 =?utf-8?B?QlM2U0NvYzBJTjR3b3I2L3dCdmJFTFhya1BSd0lDVzRiTENGSktTazlJYTds?=
 =?utf-8?B?STBKdzdRTDVGYTI1dlRIUm1zZmhJRE00a3M1UmFLanR3VVJRV1BpUkRnOGlv?=
 =?utf-8?B?cjJlaHVxTGJSdTlKbllhTkNhbHZQZldWL2U3QmdXTjZ0dlROaEM5TUZHcldp?=
 =?utf-8?B?N2ZmWkRTNFhUVEVObFRBeUI1eHg4cWQ4cnpIUTU5WmhBL3FXenkxaS85YUsx?=
 =?utf-8?B?bWx5Vjc1UmlzbGxSaVFDTGhSdFZuaUlJUDNDOW1tNWF0MUdjUHVWbk5TOVI3?=
 =?utf-8?B?SWlGWUZkSU5rNWlvblI5dGR5U25LVldhQVBYSVc0NEhheWt2ajk5QXRLdFNX?=
 =?utf-8?B?dHdORm1oSlRkNkJkelNvbDE4SysxVEh3VHF2RHRmN1BOalNMTzMxMnh1UmYx?=
 =?utf-8?B?K2plT3dMWENuc1VJckFWL0VmRG44MEpJclhpS0ZaM081VHRJUng1QzZTZGJZ?=
 =?utf-8?Q?VOuCrySp5Hs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QS9xdjAxTjVGUG9wazNzRXBRbTFMcjdWdjhmOE5McFFMNWFLU0lidEplSWJp?=
 =?utf-8?B?UjFIMnJBdE1ySzZJZUFXVFBOKzcrT2lYRGZjckx2U2o3Q3RLRkdpdXdhR2lz?=
 =?utf-8?B?VzJjMDRNZVZmYmllSUQ4N054cXdjTFVmYjN4cWpoeWZ2RVJ2Zi9uMzVuQVRR?=
 =?utf-8?B?N204M1FNa2JCTk8zYXNSMkN1NUJmNjI2WHBFV3ZrbWRzblJkazdKbEhaNUR4?=
 =?utf-8?B?anp4ZmFMdlJxOElSNkpuYlNqa0NZWEI3QTZIeTV2QU5oUDJ3NjFvUE44NkR1?=
 =?utf-8?B?SmNaVkZhZE9DS2NWb2Ntcit0NGtoVEpNLzNWNkg1V0pydXJRZCtBTC9jV3Rh?=
 =?utf-8?B?UVhRSmk2UGIxaEloMzFHVlpMdStFNmVLbTZuMkc1Qnc2QmhRbm9sMXlVS3V5?=
 =?utf-8?B?QXJKUjRDY0pTdTAwWjVhckVOeForNXU2VURMOUE5MGxacDM5VmJFOGlXTGlm?=
 =?utf-8?B?Szh5c2JvWUtlSWViVDUwaFMxNlFTZWZDV1pEbnlhalc2OFpUNTNNL1kyWCtK?=
 =?utf-8?B?OWQyY25BTEp3Rm1BWk1xR0hYcWpjL1prMWEyZHByQkJ4c3NIejA0RDdGdytq?=
 =?utf-8?B?bmlnQWorOUo3WXFiM0dFb1NBR3lBQk5kdS9Ra3JSOGR1ZWR6MytRUlc5aUFD?=
 =?utf-8?B?L1V5cWV5TmVZakNVNTJiNWg5UHJGTXE2Q2tsRkk5U2toZW5aMWxzTlZaVTZw?=
 =?utf-8?B?em81cXJPZjN0YWhUbUp2WEtqNi9tOFh4Njd1aUlQc1dVWkZDRmNxMHBaREJ5?=
 =?utf-8?B?ODFJYVU2NEVxUE1uTVhVcHBlenBBaTRSWmkzZGlaR2h5cE1ZNUNoTUtTMHEy?=
 =?utf-8?B?V3pTYU1zT0NiTkdZVzhhZXdMTWVVRGlKR1MzbFArMGZIWm1PUVhFU2JtdjMy?=
 =?utf-8?B?K3FVK1ZQV3ZnQ0V1MERPUWNTTXl3YXo5enVzbm8zRzUzakxIU21ReDIzK1lp?=
 =?utf-8?B?ZklaQlk1OHNuN1NwRUh6VmJhdlVKNzdFc0dvS3VpMFJ2WU9HNy9VZkwxWXdr?=
 =?utf-8?B?T1dzemtiNUxxeGo2QnRkTEtrYVpSOFFBemt1MFVPd0dYY2RrQldzM20rcFkv?=
 =?utf-8?B?UWZqS0tibG1Mb1haZnZTaGMxbmY4bmoveDgzU2h5b3JuaWwxZWpXVTd4UTF1?=
 =?utf-8?B?VG1NSnVjSFp3cWVZdXlTVVp4ZFh3c3J6MDc1NTJGL1NTRHZJWks4aW1sajJC?=
 =?utf-8?B?RXlvVjUyeEFPQzJ4Zm5LcGZmYUhpdjlHMVVzWlNUQzAzK2RlTG10dTdFdUlV?=
 =?utf-8?B?RktvcUNaYytteGdBaHI0MEJmaWlkUlRJZlFGc3l1bW5WSDg4QlJCOUN1dGYw?=
 =?utf-8?B?RDJ3WGhaeG9DS3VxQkpSWGtUaGF1U01FUlR6M0JYd1hZMEJnOThNYmpTemdw?=
 =?utf-8?B?M0xWV25QNFc3VHpEb3RldDFNSWhsS3JtUjFFVEkvVVhwV0J2b003TFZpMVU1?=
 =?utf-8?B?SjUxUThaeGhtaFA2U2ZQcVhQdVhUUlRzdWRINXAyZEk1cmNxWVV5YjFvaExj?=
 =?utf-8?B?bVpmYWdjWi9tVyt3aVhHT1JiSjVXQ3BQTzRreC91cUVaNFVzVkNKelJDZ2ZE?=
 =?utf-8?B?WStiMDFnRVlBSng5S3BVZWdyb2NkVG5SUU5ha3RNemFsakh3L0lXZGZZcStH?=
 =?utf-8?B?ZXlkK21sSyt6azZQUlJuT1hrSGZjRzUwNVRmTkhrZDZTVGRhTUl0OE84TUZR?=
 =?utf-8?B?ZVl3RkNCZ2NJOC9WYjNBbG1Dd0FOUmZDUEpWc09KaURLN0gzdUYydEl1Y0Zx?=
 =?utf-8?B?WW1Ob0Nnck9rempROVVOcVo4YTNkZTZWSXdrem5TYkIzN3lEdnpmY2JMNENs?=
 =?utf-8?B?NTRsZjVqY002cHFCRW93YVRlbHh0aEFUc3VoVkNVU2NkbllLVmpaOGJ0R0I4?=
 =?utf-8?B?aCsyVlorK080Q0djakh1bDJYUlNDVUJ3T2pKT3RUL2lGbWJwTTVLRVp2aWxi?=
 =?utf-8?B?NlVSbHhMNGp4cllKRkRIQVFsY3pEVEs2cFRLN2lRQjc0aGo5ME1zUysvc1lL?=
 =?utf-8?B?eEpiNmN2TEFUdGtRcXhhaHJQbGdUV1RhamFZTXl2ZURBUEw4VHp1ajkwWWll?=
 =?utf-8?B?RmZDaEZ4MWZlK3ZnUjFIT3AwUC9PcE1NYk0rbFNQNVpBelJOSU5qd1VBa2dF?=
 =?utf-8?B?VmRya1J3STVxYU9WYUhxakJTeEVtSnZDa0RkL1BsZGdOREQ0UjBiL0x6aWxl?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f946ddb5-71e9-4294-98fd-08ddeb937871
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 09:14:37.3137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaYEcWn97ze2214XtjSo4jUhahOLmwoQRegPvziidIGwXZlPyYg7xDrimud9xJCn1gBfnXOuofq+MWDXh86L6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6127

From: Jan Kiszka <jan.kiszka@siemens.com>

We no longer support 6.6.

Fixes: c38ca8967f70 ("Drop kernel 6.6")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index 672db57..17e0885 100644
--- a/Kconfig
+++ b/Kconfig
@@ -109,7 +109,7 @@ config KAS_INCLUDE_XENOMAI
 
 choice
 	prompt "Kernel version"
-	default KERNEL_6_6
+	default KERNEL_6_12
 
 config KERNEL_LATEST
 	bool "Head of latest Dovetail branch"
@@ -212,7 +212,7 @@ if XENOMAI4
 
 choice
 	prompt "Kernel version"
-	default EVL_KERNEL_6_6
+	default EVL_KERNEL_6_12
 
 config EVL_KERNEL_LATEST
 	bool "Head of latest EVL branch"
-- 
2.43.0
