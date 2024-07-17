Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629BA15A8
	for <xenomai@lists.linux.dev>; Wed, 17 Jul 2024 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721196975; cv=fail; b=CA9DFbc+m4hmHpNPoFmj4HOSYaYyhTWH1KftxvYu3ib4GP23GXadPu1OfZiP7ywSKx2Wn9n1b8cVhXgjOqhYv7T2ySMN8sWbehdawAnmkKrpPmxxCRGHfrRJOC/kjJG6I69+ItgBM0NDLIExsX/9hL5MiKWM8TPAtYX2abK4vPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721196975; c=relaxed/simple;
	bh=mRSNfb2whUvpIb1JPQqtj5laWmvxM1utmA1kbILDrNE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mbEx7KjZ/fiHDRzn8MmXRHJrOGU55uUYwh/AjC7u3BPCzkhHxCoRvQXxgkLa1tHaF4gHph0ghVJGPaa2JfAUeq7p0FRixSeyrg+xglUKDilu5zHcgy474Ghg3A2wmbcUgeOomkKyzhqmOdLDVd2migVRNBD/anGDWB4DilZ56bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=A5cMS0nY; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="A5cMS0nY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doFsQ4n5qgBTp6/TN/hSRCtGkQgLpbeOTdaDPrt3imYv95Sxr8a3MTa3AqmpFXqhbm4WKjG/A9/+baIOcDqGqiricU8rlkbJmLOhPehqC5a1t2I49sXU9fapv3V8X76ofDOW1C83nIYNp6dWTwbRTE+gaKohm3qME8k0guQptjpM47tk2I5Qsd9YwUFQuFH80rT8sJaTtKvjGjKzJ9Frc3C09PaQqQWGso/PBxt1v4PE6nLuD/O6/hoZ5NZyodpKPKhey84I5rdINvmWnzQGsNTK9cXwHaCztTt6mol6y8vdY+9Q6/MaCdSU0xWoDkqDeHKluJRVtMY0nHrxEZlftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD2T9yew9UehEELDV910kgr4/UM5fQIXZCy9zQtk5xs=;
 b=DvxVZJW2j7zvB9N7VaB1FPqePk5/rh1yKn+5f/dGa1QtE7iikLCWyHmqVcq58kFF/tXd6dRdxSus0cBYAZ1H2j1JFxGAHyozS8oTJjIJ+LE7O4Rpc20U3WzEUSmB06glwWeijOzMHLZsTLF34jHJhMpvhSyXV6Agg+bDR4x9ZbJoYTAHCFHCiXLcHcTVYBGrMkvzz5LjczIyF1Lg7065SkSQTHrAvXnBVN/8SF7eHt8mK65AYMn29Oo1J991hV9YRmiAdgGhMTyiPwWEzXrlYVf0jLL6/kr6PLgajq5vwy1/taQdpIF3pNhMky8brMmbUUXpL7RwCZ3WssLJR5J7bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wD2T9yew9UehEELDV910kgr4/UM5fQIXZCy9zQtk5xs=;
 b=A5cMS0nY7J1zMSYidCPwVrtKZOOVfX3Hpp+pDJ2DBZapolVKbsETmSQFpBqW9azEzNem/E4QqK6OiTOEKHu/HytJWWUzdj7XumKB1wllgymqRD9g1rbfvyLfe7w+Wwx0H7Zt+QhPcPB3zJqGGm0q15vV4RsvemnaDqKu9jFiCHGz1KgnZeYVVdwQSJkrwzeQyrPvVTQ92FUwYAR4GJo3IliqjqQtf3CoLADATqwCK1Vd5oMY/RzzmLEOx9iiav0GgnMzfIiyHHM0tlYKF6xyT7IDaRPJaCWTdNimzOvoCkenSt6H79KKg4aNaBKezaa18E3zR6YSqluixl4EJZWTqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8299.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:120::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 06:16:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 06:16:02 +0000
Message-ID: <e0bfa4c9-e0fe-4d5b-b12a-c1c0b9cefff3@siemens.com>
Date: Wed, 17 Jul 2024 08:16:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] ci: Add a long term latency test
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20240716183326.1432379-1-tobias.schaffner@siemens.com>
 <20240716183326.1432379-3-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240716183326.1432379-3-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d56f93-17a0-4ba4-7639-08dca627ef0b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1pWemcrblF0d2VCSkZUbjdvWlhGcFl3Wk1ETVdvVEV4WDVQUVhtUWs5b2RW?=
 =?utf-8?B?ZjlCaG1YbFFLcHdzQ3I4M2Z5cWhQYWZSdXJVOENLQlV1UlgvV0ltLzBNWVV3?=
 =?utf-8?B?U1RUd3hXbDdtVm9SbWVjaWtyeGRJRk1JT1pPQVUxdXNKNysvZG91c051K2pV?=
 =?utf-8?B?aTR2dWF2MDFVNHpnMkE3RUtEcXhIWFlhamJFQjVXa2dpaWVNWnlJdi9lZDRv?=
 =?utf-8?B?TXBDaExLZytiSkRRcVhzRk9TOVZxR24yY294eFVMT1dmZjNONldZam5Eb1dr?=
 =?utf-8?B?N3JxdTVtTGNjUjBSQ2FZTHFrd1JTcnVLZ2RGeElDZUUvbit2OHlTQnBaVGM4?=
 =?utf-8?B?Mkh5YjBMbThWYWUyWWI3WnNQdXRzMDFYQXhwZkpYTWdSbVhiQnRubjJaVHhC?=
 =?utf-8?B?S3BnS285NDdoekRta29BYzlTenBKZzk0cm9hRktVNk9ocjFPb05DVkp2SDND?=
 =?utf-8?B?QWxLem1mR0Q3OENhU3ZGTFVUMmh1N0Zhc3l2Q1o4ZXFiczN1U01WYXJTRjBQ?=
 =?utf-8?B?K2N3VHU3VTIzSGlYTFR2dWhmVERGZ2s4THhaOHJWbWZIVTdIZ2Q5VEY4WWVL?=
 =?utf-8?B?cmYvb3BuYjhIeWx4c0M1bE9hWDZXdE8xelZiUHdJMGJQeFNjODJ1M1d3cXRt?=
 =?utf-8?B?U3BkQ2pGMGRxODRsaE5HZ3NyUGlzTzdaQW1VeExTYTdZaTR2YS9PZjJWVGVL?=
 =?utf-8?B?eFAzd2p0Qk9rMG1oYVdjV3BKUm5ENGpNRzlwcmNhUmEzQnJRNTRWQ3dSYWsr?=
 =?utf-8?B?S2s3TnpvMW9mdTl6Ly9WN3FaS2R5YVBZR2dpYVlJZUhPeWNweS9MaWNkbEJC?=
 =?utf-8?B?NEh0YW52S3JxWEVDU0ZLZDBwa2ZEZEVjQ2hVdGlWZ2tSM0V3S05EazY5dEZN?=
 =?utf-8?B?eWFMUUhQMFcyRzRndHcyY09JZnh3Ylk4OEFrYVdPS1JjSWZucmdKVFM4ZmIw?=
 =?utf-8?B?VmozUkZyVUcxM1JQL1JjWkZ6Z3FPVE5zK0UvN2M2YUpHdjE3STBCQitKSERy?=
 =?utf-8?B?N3B4MVB1Vy8ySnBlZk5zQ1dNdzJEdll0V2tOdDd5bnNzdzliL2RRN3V5bFNC?=
 =?utf-8?B?a0hwUmo0T2dOcEtMei9lVFpjcXFzSG82SUlYUFRlMjJlb2pmS29RRVZlTjhS?=
 =?utf-8?B?QnZ2TXZQYU1GVzhtQUVaU2hoWVdNc0xuRm9RZ3U4Q1ZoNmtyaEpyeXA3RWo1?=
 =?utf-8?B?aDdmZE1GdHJzUm14Y1l6RERLYjJTNTI2b1NBYSt5MkRjWDk0Wk9ZN0RyZE5u?=
 =?utf-8?B?THdyM3FmL05yREFhZWFJMWNtVkxuY2lYYm9vZFYxOGlPdlhWUkhCbUYwWEVJ?=
 =?utf-8?B?KzAwMy9WeEU2K05RenlOZHdJcFZQREVvSEpmUlk3cm5yUUVMUEVyd3I0RWJF?=
 =?utf-8?B?RVd6KzhOQ1ArMVdEa0tFSmE3ZU1TVlkwcG9IbjNTVllHMDRSNU53bDFlUVRG?=
 =?utf-8?B?a3lDTFI3dDNGMHJXNGV2Ym95akxwd01XZ0FFcjU4OVgwWm96SCtWeGx2VW1C?=
 =?utf-8?B?cXlMc3U2V2pvYXJiQWhXaTNQMmlmZVc1VDdIclViclJUd3g5UllNZUI2cXlu?=
 =?utf-8?B?MFRteVdZeHdVQ0dYUmVxTm9zU0tPZzNVL1ROM1c0SUpBTUh4dmgvTGlWZTIv?=
 =?utf-8?B?SER2UngrSmNhRVcxRWFPeDJMN3FtbUFzbnRVV1Q1Q2xxbXgvbEx6L1FIeGZS?=
 =?utf-8?B?UlZ6YTJoMTg2TlIzT2NiMWpSYnB3dExBQWJPVzZ6SHF5RllGdkVIT3gxaFVE?=
 =?utf-8?B?cHlyTHJENDRpdkRua3k3MlhwbkRCMGNFVkViQ3VDRkZBdkZ1dEFzVGNQYVVp?=
 =?utf-8?B?WHBzVzI1ZURZRTFwT2RUQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGd6RmdUTi9UdTRRRHV1cWs0eG91T3ViZzhwT29LN2RaSFZHQXkvd0M4MjM1?=
 =?utf-8?B?Q1ZzNkZCeXYxbWdRSjBxSW9mQW9oeVJKY2RMSmk0QXR0TUpUQUVtTmpTZTZ3?=
 =?utf-8?B?Snk4dWdOZFNScmF1TlNXRlVxb2xsYVNTeWVDTlRsNk0vL3FsVWExUDUvTEZP?=
 =?utf-8?B?V3poTEdBeHhJbGZSZkdOL3lBazl1ZEZmVmMwM1grWHRLcFE1T3NiN0UwSEtY?=
 =?utf-8?B?U1Rubi9uelJ2MVQxckppU0ZWejU2d21OMmtuaTBaNk5ITFIzVVkrNlJ2QUph?=
 =?utf-8?B?a3N1WmlKWHZPaXhtdmlzRUg0TVdpcW9pbE9NTGJjR0t3K1VaMXJqMzJZYzVC?=
 =?utf-8?B?bGVsOE1mTFZoa1R6bWRuS244SWxQN2J3SGVJa2pRUHFsUTl2VFBFU3dCWUlt?=
 =?utf-8?B?enRXY2tBMm1DMEhSYjRoZ25DRlRMWEdKbVRWMWE2Ri9CSzRmSitHQStndnlh?=
 =?utf-8?B?U1VoSWdzUXZZTmxJK0NzZVdNbG5nNlFEeGNoQmZGVnRubmpWWXBkZEt3eW10?=
 =?utf-8?B?VHkzT3hDZmNOY2h0cUpXYzhaOWJSbk5zblBod05pRzRVTmlwTXVhSklWZG51?=
 =?utf-8?B?K1FIeTR2WkNZNlRLalpSSjdmV1dTdWpZUzlxc09icmtuZUhIM2ZLSTNjaGJ3?=
 =?utf-8?B?OThwWEdrMGFWNzhYNjNZMzBkL0xza3pKZHRMSmxRN2szU3RvenliWEZXTEll?=
 =?utf-8?B?SGhKTnJQV3lTTjFBbjhvMU12N0hLWlplYll5S2dnUDljMTRhc3pSUGF3NzVL?=
 =?utf-8?B?enZLZGlmZWZSV3BNL0w4OGUwWHl6ZHlteE5QYlp3Q3gva2F6UllKMWdjVzl2?=
 =?utf-8?B?YW9iZHB0TlhibXNVaVMxOFhOeGhsbjgxVDNKL2d4Nk9DYkI1KzlaSzZNcTF3?=
 =?utf-8?B?UnRkaEV3NGZ0Z2dLYjk4cFVWQ2JncEh6NDl3QVpLTXd1WG4vVmhPa3k3UjhG?=
 =?utf-8?B?ajRWcVZxM2pNNkZBV1VJWHRjOXZXWnVwbWx1T3NaWmFjTDZMcFdva1hZSVlF?=
 =?utf-8?B?RDV3SnF6Ti9lOE92Nys3OVZkUDV6RzhMbkloSHE2YXMzYjlCNExNSS9VeDNN?=
 =?utf-8?B?VkVuSUp6NnpnV2FWSTg0V2t1eks5Sy9FTTNQbnozbWpBd3Z2VmEvTVp4QXpP?=
 =?utf-8?B?MDlqMWtPcFd0R0MyWmw5cERFNCt6cWZHTGFDQXpUSWt2ZjRDRlNTS3V1cTBM?=
 =?utf-8?B?VThsbjFUR0pDOEhsODhPVXhVMHRnRkU0YmZDemcrdEJvUHpqSnJvTmgxclFQ?=
 =?utf-8?B?TDF1T1VRcHZ6SUFtejMyTXV4RVRxeHEydVlvQmdGRUw3dEFuSFFCUmpreU5Z?=
 =?utf-8?B?NHh1VGMxcGZyaitVZlBiQ0t5UmZVN0VsQVpTU0VYb1FEdkthQ3JXbGErVi9E?=
 =?utf-8?B?K1JlSnEwUVRxa0RDOW00TnViT0hsNGVvTDVTMGprWDM2b3NNYno5RnQzMmFk?=
 =?utf-8?B?cHBWRnBEZFZhWDFKMjk3TGlkcVJXSElEdWxmWHpmcFJ4bjdsZnBVRGxWSWFj?=
 =?utf-8?B?bHRBdVZJdldlSXZlQ3RtcHg5MjZsV2RXb28vVHh3bE5TbHNUS3FCWEhzWjB5?=
 =?utf-8?B?S2ExVDB1Z09RR2pvdTBSWlJIbDdGbmxXbTJKT3ljQjBiNVRWK0tKRzl0eW1N?=
 =?utf-8?B?STRPSGFkQTFER2RjNzJtNVBhWTVqVlo3cEc2M1VtR3M1TzNCS1hRYmNBV2ZW?=
 =?utf-8?B?Z2hpbHFaNDFSK3lGUnRvdFRmZmdTdHlXOWZjTjBmV1F2bHE4YUZpUURrNGtE?=
 =?utf-8?B?RG5LMkxNR2EzS05MY0EvRHZqMmxXZTM5WldkaXlEU3F4TjVkVWxCejlacVZa?=
 =?utf-8?B?OXJsWFJtYjZpN3hyNkdxZHpWOUk5a09ocHQ0Y2lRQzBZaklRa2ZIemV3QlRw?=
 =?utf-8?B?SmcyYnptTzA1YXovYXZ4ZElnR1hOLzlCMkJMa0JSbWtlQmxmek1HYXBNU01M?=
 =?utf-8?B?RmxCRnZsbHRDV1lxSWRRZERvNG5xQXk3ZzVaYTh1NS9helg4eEVVYTBCelBL?=
 =?utf-8?B?bnhrODlaUldqQUYvQ2VVSE5kOXRtOW1zNVN3QnBoWE1yTHFJeEsvbkZNVUpS?=
 =?utf-8?B?a2wvYUFSTTMvTElzTGYxTkdBZEdPZTQ1bTJXWFNRNzNpMGFncnh2TmRTWEc4?=
 =?utf-8?B?MmxhT296VEw3N2tlTGFQUmkzMVFvK3hXMnBrc3B5cjJicFdyV1k3emEvQzA5?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d56f93-17a0-4ba4-7639-08dca627ef0b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 06:16:02.5013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rE/epQIKYB+D+tjNJlwC9Yi/GU4mjg+oqWjX4WcHVAOK9/PB0+QW6/LFuO7rS8PEYKQUbufsrqir1/kGRPI9BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8299

On 16.07.24 20:33, Tobias Schaffner wrote:
> Add a long term latency test that is only running on physical targets.
> The duration is set to 60 minutes for testing purposes.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  .gitlab-ci.yml                  | 10 +++++++++-
>  ci/xenomai_3_next_long_term.yml | 20 ++++++++++++++++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
>  create mode 100644 ci/xenomai_3_next_long_term.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 9edf635..803feaf 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -23,7 +23,7 @@ stages:
>      forward:
>        pipeline_variables: true
>    rules:
> -    - if: '$ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME || $ONLY_RUN == "xenomai-3/${CI_JOB_NAME}"'
> +    - if: '$CI_PIPELINE_SOURCE == "push" && ($ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME || $ONLY_RUN == "xenomai-3/${CI_JOB_NAME}")'
>  

I need these also on manual triggers. Maybe just exclude "schedule".

Jan

>  
>  stable/v3.0.x:
> @@ -49,3 +49,11 @@ xenomai-3/next:
>    trigger:
>      include:
>        - local: '/ci/xenomai_3_next.yml'
> +
> +xenomai-3/next-long-term:
> +  extends: .parent
> +  trigger:
> +    include:
> +      - local: '/ci/xenomai_3_next_long_term.yml'
> +  rules:
> +  - if: $CI_PIPELINE_SOURCE == "schedule"
> diff --git a/ci/xenomai_3_next_long_term.yml b/ci/xenomai_3_next_long_term.yml
> new file mode 100644
> index 0000000..5fb0de7
> --- /dev/null
> +++ b/ci/xenomai_3_next_long_term.yml
> @@ -0,0 +1,20 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +include:
> +  - local: '/ci/gitlab-ci-base.yml'
> +  - local: '/ci/kernel_6_6_physical.yml'
> +
> +variables:
> +  XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
> +  XENOMAI_VERSION: "next"
> +  LATEST_KERNEL_VERSION: "6.6"
> +  TEST_RUNTIME_SECONDS: 3600

-- 
Siemens AG, Technology
Linux Expert Center

