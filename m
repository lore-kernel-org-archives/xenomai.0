Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6893428B516
	for <xenomai@lists.linux.dev>; Mon,  7 Jul 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751880553; cv=fail; b=UdQyo9SVr45RcvQ1txiu+VLaVm3X13X1IvSv1Sap9CfJp10cftOr6u49H+krTs7Qv7wjwRCnk78C+uzH/4MRWeLe+qsFK29slvBx8orR9QNdI24V5HaFR49NH6Qmq9V+pwrF5xoxkiHQTbHJG28kw4a2ILylSiSb+oENuZ6ZhcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751880553; c=relaxed/simple;
	bh=ga0W/2y2fBlIFTDpSP0Kar1jYFOz7usqMWYMQSls+S0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h0e1v1p7i2EjtVnokbHEsXKbHnnunFvEhUZVgcQSE7RoI6DlkhHse3ve30XlC4uH+e2ljlrnC2L+9IukpyVn6VQiGKzb+4Iti37jLQMd/Tm7zT4UUull4vKlD6W94LfUAeY6/eIe/ThcmQLRnwUQMmwDENy5HS+ng0Dhr1o3PBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JKI1RfnK; arc=fail smtp.client-ip=52.101.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JKI1RfnK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dX0Ryr6TFPPyftJFMMl8AS7dK5Rod4O/MdNES69lK5GV6CO1NiLFVKtnAVLrFczaJ3cWXLhBunQE8/HmeXh5VexO80AjFfMD7fXxNbo2Y2zu0imSiXYOFXhlmihSyPUua3OY+yLGBC5ZW126Q6jY064yRHniX9+KZwkuZTgpuGIIxwhjgTirXYLa+Br9lPc+NZQnIL8ptKp2iDctQ0rBz/sqj8Byv8GWRLQwUsL+Yj5SkRR5KiLEk6HnIUI3/xb6trAmUHlaz9Tpd+Pf7OXnjlAeNZSmjnW44UabAjuGaGNrG2gZUv1cVvtcYi3vf4tF/iNf5gKQDTADR7uAtlwsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDc5LoFtoQZujjZ7xEEw7yi2AJw+WhZPEyuGU8ReEQ4=;
 b=icwFzGrXlVXTy6feHGxdbn17Ipxia/P+MpJYT7gicp7RyRxc5Q4i4fOKLrvm+yPuaaNsf0NAdn18FYsMLmSbzfJWDMO39+z7jfvNXul/4QmpGctQv0dwBFTXycHoduzGDTbcdqrrXvLL9KbAg5KF2XLwWE2K4CzmvR0/9cpDAMW7VqPoYsJiUIdMFIvD7bCuSV8fPKm2+gruMFLtoHQml0bJ6FtHINlkGBBqaHiTEsqK5EWJfgG2YRAYnZPYgHfy/Frvd2CHJ3n6v72F+npPROtzWsf1CYPM9uGAZ1kJ+wxQRzeq0XwNjfAqdRgtBzlI/5PqLCd4EOdTYywoU6da0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDc5LoFtoQZujjZ7xEEw7yi2AJw+WhZPEyuGU8ReEQ4=;
 b=JKI1RfnKYxUSSPHRWaQgX+z7MstuZa06MnZiYCuLIlKGqU/RAyBTzf1zr+ZbCppcYmW14hpacTDjotB+ycKVZGKKYA4hBbMTSmah0lEoLqimQvKabfTqjSkqGP30vVziTZql90KzZehc7tK28mdFRq7K0bku+Mi7rQtfg27SpHVVQB8a9Xg84d4ZVFWWGuQ3F4yjgcGqhfODSU+mP19B/FEY4Aci4/1JmyI1bg4mosTjQxdeXDaOeH4EMp3dyYYuTuNLehA0wYui6lKPvjx5tIzKkxVI1YrEWnTOo06aCGMa5xQNrsbuJIbXcMf8EsUOdMKigVGWw5MTDbkvFNrm8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3501.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 09:29:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 09:29:06 +0000
Message-ID: <8ba477b5-a2f6-44fc-8b2f-58e2cbcd48d4@siemens.com>
Date: Mon, 7 Jul 2025 11:29:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai 3.2.x in debian12 strncpy warning
To: Luis <luis@apue.org>, xenomai <xenomai@lists.linux.dev>
References: <e936781c-3a9a-45a9-bf62-113cc0bf43d2.luis@apue.org>
 <924e7b82-8695-496c-bbe3-fea195b6c05f.luis@apue.org>
 <945a6b69-8a99-4b09-87a7-195683ea3540.luis@apue.org>
 <e4529393-79f0-4579-a7c4-4424f348da29.luis@apue.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e4529393-79f0-4579-a7c4-4424f348da29.luis@apue.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3501:EE_
X-MS-Office365-Filtering-Correlation-Id: 792087dd-a9dc-409e-4dae-08ddbd38b858
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGhjUVlCMEhaOFdnVTFkMkJaQWVCU2U4QlNzWm1pZkdOOWl1dFFxV0xYbjNa?=
 =?utf-8?B?TU5pSTZLYmc3cnp6YlNJL0Foa00wM2ptMmhCcFBaTVd3enl2T0JPV25QOUtq?=
 =?utf-8?B?UjNTSkg5OVZ1VVFFbkhzMG45azBIMjlzT2NITGtmYXVYL2hrMk5NTnZTQlht?=
 =?utf-8?B?Qk0yMlB0di9mZkV6aEl3N0x3c2lQWGhQWG4yRHJUVXRYcHFLWnQ1cGRsL3VW?=
 =?utf-8?B?NnlWazM4VDN5NW9iaHhlNGtWM0ljUmtiY3pLVmhZYWQ5eXV0eGZBbG1MZXN1?=
 =?utf-8?B?ck1QcHdhZDhORnNVSWExdUg5UDlRN1I1d0xkTlJtdnBJQlhndG5MK0c5VGpk?=
 =?utf-8?B?dk0yV0xmVDM2SnV2NkNMQ2txRVQrRG5rS3JGQjNXN21WZ2VVTjZnZ3E3cGJs?=
 =?utf-8?B?cjllVXhDRXFIWGt1MU5ZYk56d0Jjc2JUbHR6NHJFSmM4akZUME5WL1lYT1hk?=
 =?utf-8?B?R1ZkQmVHQVphNnRyS1lleVBoVUcvdmpJZmU3Ujd2UkNrTTBPaXRFcEpqT1VB?=
 =?utf-8?B?VGYxSXNyTVNPR3ppOHpnaHNGWEdPZ1pZNGNjSFhuRmF0d25INlJaM21uUjNN?=
 =?utf-8?B?Rlh2dUdCTnduWmV1aTFDOWQ2S3drV3BaMlpzaVI5Q2dTRWVRTERmUVhmZ20y?=
 =?utf-8?B?RnZLUzYxdXZOTDB1eVY4ZWY4bTUyMEQxanRrc28yc2FXQXYzSWNkeFpaMytO?=
 =?utf-8?B?VVRpTVZhZXFwcC92R1V1KzA0dDBUc1lGcThkVHRCS3pjdjdtUm0wQ0I5K0Z1?=
 =?utf-8?B?WFliZmRuRVl5bjhZTzNnSHFYbTNDM0xZbWxSckJjZmQxRGdDK296VHozcjE5?=
 =?utf-8?B?bkdnT1ZtQUI4VXg4S090TnpIV0pvQ2NtZG1jTWE1bVJYbXRvNUJNOG1iMGkr?=
 =?utf-8?B?Z1Nzek16M2VVcGxFMjBtV3dZclNoUFpUVjd3U1N4a3A0YnQza2RvV3drWm9w?=
 =?utf-8?B?c05XK2VneHdyRDQ5dGdlMVVSOG9OUVlJRHhlY01ITTRISUJZek1yd3ZFVkRq?=
 =?utf-8?B?OWpNTTlCcXl6R2Q2cldyV1JEUzVZcGludkRKeEF5ektUWjREb1BWajl5a2hi?=
 =?utf-8?B?OWMwNVBGdE1PclJJazZMdTVzV3FkYXBESGxwOUdZNUF4alZHOWIwMUxmYkFF?=
 =?utf-8?B?YThqNUFCUlNOWHBzNE9DeXZvYU5ZeSs1MTFmMkM5RGFWZGlhKzMyUmJ2eTNa?=
 =?utf-8?B?clp4S0pGdGF1aUovOHJPVlFFOW11RkhjcjE4Q1RqWnYyaFVML244aDJBbnZr?=
 =?utf-8?B?MkZmbnpNU2szZWh0SVBJQ3BQS0JEdmRFclZUOVE5NXRsUTc2SEc1UFh1YnpD?=
 =?utf-8?B?WlZCd1NxK1JMUkFxVWtpSTE2U0xRak90RVlmd28wOG5rQ1NXNmtNQk5wMFdX?=
 =?utf-8?B?bTVHK1NnU3I5dkVkbHl0VFViRHlqam1scFNsSWk2aStvcW4wNGE2aTlMbnFk?=
 =?utf-8?B?R1FjZC9Gbzd5QW53a1BLS1dKaXRqanlraW5zUzdLUUlSUDVjTjBOTVM4TDJx?=
 =?utf-8?B?Y2tVbDBwZTZxV1ArTFRYSFU1dmJTM1J4RS9RVmZSZDVZODVFUE9BWDFHYmdk?=
 =?utf-8?B?VzhndWF6MkRld0E1UzRQK0ZpeTRCampQMjFUVnJkR0xLUVNOK000YVhLTWYw?=
 =?utf-8?B?em9USlM1dm5ORGprR0VLUE8rZHg5N2xoWlRHaXBRSlp2V2lQSVJBR3VrU0pz?=
 =?utf-8?B?Y05ac0VIeTE1amVHZEphQ2JpMHpIbWZKSEpGS21rbytrMVZsSWZLZGd6M3pF?=
 =?utf-8?B?NTIvY1NkL3BZUGlTUGNsNXFlUE9MV0ZtTGJTVlFFdEdPK3h0YlpFSEMxT0x5?=
 =?utf-8?Q?znqLcGKU4BqRFUMMDxGGwTkH9UXmOWaVwWdy8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlpqMkVJSzYyWjQ0eS9WU3ZINU83Q29aUW44dzJmK2t0ajh3NXEzcWhLRTJ3?=
 =?utf-8?B?UXN5eXlrV1RZajQ3YWIvajU0MytwSlBjVUk2bzZqL096KzA4djJKYThvM1BW?=
 =?utf-8?B?SE1PYTFNUDNtdTdyeUw4SWZkSjVpbm1wT2paTGZCd3ZucXlsRldEbGRLeFl3?=
 =?utf-8?B?VG5NZ3I3bGZNZ0k5bFNweExwTktUR2hFNXZQUjJ3MVJ1d1BoMjlweXhzaGE4?=
 =?utf-8?B?djZtZjIyTlM3UzYvTGF3RDNiS0JidzdIY3VlVGpuYWUwam1ydTFiWmVYUmlm?=
 =?utf-8?B?a0xVL2R4dHZuS3NkU2FMMXp1UEVSNWt2VzdmU0NsUHA2aTJtWjBBTm5MMVV1?=
 =?utf-8?B?WTE0MC9HSWpsaVhXbWRCN3NiaktxRVdlbmlNaUd3UjluK3NQRHpmY0tYYkEx?=
 =?utf-8?B?ZzlESWNqTVlhc1JLNGdac2JreUZzaVRmdkFqYUdyTG9UUW85VXJZUUYvRjEv?=
 =?utf-8?B?OGRrait3aVVoZDZSUytKOHQ3bjJqd2liZG5IbEpTaWxXV0ZCUnREbWFDSEtu?=
 =?utf-8?B?YlNLd0J3NFNjbjVkejFhc2Y4dVYwWDhmYkhhNkIyZUQ3V1RHYlFPMEthMk81?=
 =?utf-8?B?OGdoblJnTmloblNkakpRN2tQaS9hU1FzNVFSZU1oUTlHRG9ZT0dLaGYvQVlU?=
 =?utf-8?B?a2hKODUzMUVXT3cvMmMzQmFsSW1zdk5NMzdJcTFKUUVDNk85Z2FGWUN3Si9z?=
 =?utf-8?B?bFBYS2tzdDFyemRVajNBNjVRbGxxV2ZDeURTNFlWa2I3ZEw4WkQzTWN0YUVD?=
 =?utf-8?B?R0R3Q0VkRGVRc00ybTdadXcyYTk5UW56Smh3SC8vTnBhM0xlenRVWHV6ek9n?=
 =?utf-8?B?WUdnbm1ZeFBWUCtIUStaNzE5Qjk2N1FUTExNdkUzVU1pOEp5RTlNTVdsenAv?=
 =?utf-8?B?Uk5GVzNzU1AyWEo2R2tHeit4YnlNV21WT0dIY2JHcTNBd3B1RHRBdldGSTl1?=
 =?utf-8?B?bUtSaHlZZGE1T3ZFWjg5UWtKWnp1WllLRlNWS2YxMExRaUE1b3gzaHYyQ3o4?=
 =?utf-8?B?ZWh5T0grakc5REw1emtRVGRvSnYrdHdHSDNZRlJiMjRhWnlHR1gyMlBvQnRm?=
 =?utf-8?B?cDVsbWN6MVpUNDBVd2RRelZ3KzlQSWY4eFA0MlcyYklWSHpuQjJqNitMcVlJ?=
 =?utf-8?B?T0NaT3c0TlFiK1NiVE1NUzEyTS9CMTA2NFhqNUtTYXZIUUtoT3orM3g5Q1NZ?=
 =?utf-8?B?RlJZb0pSY1h1d29uMUEvNGRUUDFtQ3J5T0dyZEZFdkhsSFF2TnFJL0pnSFRK?=
 =?utf-8?B?RWZGcFZ4aE9GcHNUY1dRUnpYOVJ1anI5Q2paMXg4Z2h3SUJNWVNLMSt1VWpB?=
 =?utf-8?B?aEdYQzlvM0duYTBPQy9iWk5YNDdXMjFPdnlNV3VzKzZOQXc3ZGJ4cGhiUnly?=
 =?utf-8?B?L1YzNDlkZG1MUWZqL2E1aGlSZjljMTNobTU1RnlGUTZxZmU5WEh3NGR0L0Y3?=
 =?utf-8?B?ZndBNytxQU83bmtlZkZFZllDbWVtUGliUG1vaXFQaGhKcThIRGVKSXM3R2FV?=
 =?utf-8?B?Z29MNVpkYklhK1QxUVhIZkt2bTZGS1dGbThjak9pYWJxRzU4MDI3YitPdlZp?=
 =?utf-8?B?aXNjQTkwZVJHUkNhYnBuUlNrcDVFUU9mVUhhbXB2bkVaTlZpUUZsbUhBMFJk?=
 =?utf-8?B?NEpQdnFHN2pHT2t0VnZ4clpBcmNUc1ZTdHV2YTdHK1lKZ3F5RjA3ZHJvV3d3?=
 =?utf-8?B?VThieDdpZUZtNFlORkR3dllzaE12M3drcmhweUtmZk81TXBteHNBY1plbGRh?=
 =?utf-8?B?ZCtWNDNUaWphcHlQTms3a0tjc2FNQUptNHJ0dFpzQ0IvS3VMOVBjd1V1ZWEv?=
 =?utf-8?B?Y1JLSUpOaUFZNFB5Z3ZaaXF2clNzdGVRam9jSVZzNDZPZmhhTC95UzRnREs1?=
 =?utf-8?B?bDd6bkRKbnlSZFlibU1UTXlEd1VxTUh5TVR6R2dsOEhjTEZsbXNPanBYbjdM?=
 =?utf-8?B?TlFoR2NoSWFWNXFwUnlpdklVMUM0OWgxMHhlWnN1bys0aVJVdzA4K2o2bkpl?=
 =?utf-8?B?dkg3M3JMaXRHeG1ETzdaVFJRU0VBSUQ2Um95ZVRXSHVnTzd0bzNXS2JyOEgy?=
 =?utf-8?B?cWh3RFp6REhEVjI4TWJuU002VGljYmI2KzRvQ3VQN0Q2Q2hxTXk3a3QvOHZD?=
 =?utf-8?Q?HtKj7vkJDGrKZL9EwmZ3qC6N8?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792087dd-a9dc-409e-4dae-08ddbd38b858
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 09:29:06.7383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqmE8lV4G2jg7pTnbL8+NDJZGjKCeEKZZGxm72n6+a7d75szwx6fz3DH5Ev/+0ZwC1E22wNHVB34fg4nfavPnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3501

On 07.07.25 06:28, Luis wrote:
> Hil all,
> 
> 
> Here are versions affected by my testing:
> kernel: 
>         4.19.89 to 4.19.292, with ipipe
> xenomai: 
>         3.2.2 to 3.2.6
> xenomai configure cmdline:
>         --with-core=cobalt --prefix=/XENOMAI_PATH --enable-pshared --enable-smp
> host system: debian 12.10 amd64
> glibc: debian default 2.36
> gcc, g++: debian default 12.2.0
> 
> 
> The error msg:
> fs-common.c: In function ‘open_heaps’:
> include/boilerplate/ancillaries.h:37:3: error: ‘strncpy’ output may be truncated copying 31 bytes from a string of length 31 [-Werror=stringop-truncation]
>    37 |   strncpy((__dst), __src, sizeof(__dst));   \
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> 
> My patch:
> Just replace the 'strncpy' with 'memcpy', as follows:
> - strncpy((__dst), __src, sizeof(__dst)); \
> + memcpy(__dst, __src, sizeof(__dst)); \
> 
> 
> Or any better solution?
> 
> 
> This warning also exists in the default gcc in Debian11 AMD64, with linux 4.19.x+xenomai 3.2.x
> 
> 
> Regards,
> Luis.Koo
> 

See this ongoing discussion:
https://lore.kernel.org/xenomai/61d4d7521138677983a987639ebf6dad4fe3ae72.camel@siemens.com/T/#t

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
