Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A59123957D
	for <xenomai@lists.linux.dev>; Tue, 12 Aug 2025 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754999817; cv=fail; b=fc1OwLzeTRkHiZmaZzOxUmEfPw10TR+G9TyAVL3+BntaKgspPuQNClLyPGRNjVtE7BqHby1UzssHWhvYu5kRlk2EwWgPbiI48yiNSmxKXHpbOoAojld9laI29+cM/lHh8CrIt+MmOHA5ELVudn9DblQtaL9V6lwgPJzDaSeBZ/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754999817; c=relaxed/simple;
	bh=tzoMqoNiOGiUfvyqICGAEIZT6nUbJyWNZ/Z45zhiBC8=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=iLbAWlYBW2Ed/A0/tyfD3yF6RAV2XAIhHDWkaL7W3i9JLUNlHJVCoYcEYgA4TarIb7WIrIWg4oAYWeVnv6FkJk7ZYjQlSMJxo/ewCFYvMI2GnrttUJtap9z+pt0wYtnfaV9K/7vNuoNtQIYLpDuZSdSYiJLWwdstUw3b5uX9S2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=o2y8fjUi; arc=fail smtp.client-ip=52.101.69.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="o2y8fjUi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7+S+fVardf5fSUyGrEJOHG+4EWDqWRcJ2r6DRIsWbnlZu/1UI0OJdnEUY5viQT6Iu9B0hoNL7AsGXWXulvj+o8ejs7JXwESop+zjJJu5HsC4jcVhF9a6Hkx0plHC1PCLDPs+jEv3+a6ndeFcK0NqyOC57bC3hvqnNOGEv6R8yqtTbsBlC08MpwRusQJkienk5ceHQSHT2xPd1MWbEvaa2e/hJjqwbAerECvM6rgqQTib/JymRbq+MO4rQAjZDR2SAQZJo9eP08I/Tn92lUv5yoBsZKtL1rKCDNJ9XWe5S+0Jw1JYfMgHC3eef60/CpsU+Wdm9Pdm9RBaF6B5SbZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMmh/Jlc5K4chxmOe6OqTkTwOtDTgFq5sWPZAGlQF/A=;
 b=F3jzyUiNdOHUBEvxgu72lYIVkc04y+AYj75wRkfK31+wFnA9/VWeghn3LNAcgTH/2uqp196QTn0FHjpzBTrMM4qIRRlD3ItcmALzXkO8Uy9PmHqan5qxxq6ECWMm5tFVe9zqq6Zn6Ku23DO/96qyWCP2AZbjBSfZEfctfDHx0uEKoy2lMGizYSwYSFmg00A4bfF7YWxKAoNnYFwbiKN2utzO+5a7MEgurlHL8TJ7lT+Qeuhp4z4oOYXM97a/TdjNcLK/ZRVD9+s8USJKRThYhnnmOQN+jOFxI0TFKRmrmvqThZZt1FxUsuEMeUOKI8NzwLkpICndO3+A8/Y6ebZEYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMmh/Jlc5K4chxmOe6OqTkTwOtDTgFq5sWPZAGlQF/A=;
 b=o2y8fjUiyxx1jmTVuFW1mYGJBb35NmRAMtlcTo1Tjz9o33QqmTJC3EIAscljCPYdaWX9YaognlaMRR/DCkh+ksU4iv5Ahh/UEOWVcWkwrYpwwPuc06TnO1hz+rXGe9kDA/X2EdffZaGje1mEpUg4ilOihJahYUzDZu526Dfl95LRNyIdBDHsgrpLA6KKRkcZ7y96s0XwTqDl9UZp/xLxb72cSZeuBqtSEpyY+HYTVQdDnP7If3WNZLMe7bA5EKiKj64Rb5cZAeVueO5zqNK3bBZUsWDnJIonUMlI3jIJm9bkUXmBQF0OiG7plOKoiCamlPOCfrMHTAo0mrxPcWF86w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 11:56:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 11:56:50 +0000
Message-ID: <3ab406de-31c3-4ca3-b233-fb13c60a7e8a@siemens.com>
Date: Tue, 12 Aug 2025 13:56:46 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Drop kernel 6.6
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:610:b2::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c7cbeb-624d-4e3a-76b2-08ddd9975220
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDQ4UWZvN0dOZHQyd00vVEhib1VTanpIejArQnNZeTN6T1ZBcVRRcUE1dkVm?=
 =?utf-8?B?UkpQRzJPUDByMVJDcS8vOXQvZlhuQVlmd2ZNNTN6M1VOVTJ2ajQwNnI1S3pZ?=
 =?utf-8?B?dHV3dHoxeHdMeGFTY2RHSkU5QUtBaGQyWVoxU0JOVEVDemdscWIvUVZNWVRQ?=
 =?utf-8?B?YTJ6T0wyZG0rZEpTQ3hNT2dGaFpPQ0JhaEZOcG9LbG04dnNzUy9VQkhiUUpw?=
 =?utf-8?B?NDJZczg2ZWtSRmFkb3FOaVRuRWttN2xId1F0UktZeWdSNEt2TFlzWFVMNlMw?=
 =?utf-8?B?d1Q3SU9JM3hjbit6MWF0emlLSSthTFN0cGdOd3ZNdnBDMnM4S09DYlNqWkJH?=
 =?utf-8?B?OWh6eGhVc1lxaE54SnFWeHdBY0Z1cy9lbmwyVUNUSlJWU1g1M29VWGk1SHlt?=
 =?utf-8?B?bGtQdkhzZEllYjhac2tXeDBnQ2NqQXd5S1l6eFppejV3cWpaZTZEak5QMVJm?=
 =?utf-8?B?cnNyOWdiVm9XLzFiSEtPTlNCRDJrNUlPbFpDS2FTL2M5T2hhQ2xaeXBGRzJV?=
 =?utf-8?B?aXpSOWZDTy9MV3ZyVUVtTG94bGpoeHJWbWtQNEJmQUI1NXpTeVRaQzNMdVdN?=
 =?utf-8?B?ZlNUZVFETjFQRHhyWlpld0JJS0J2UjhCQmlRV2ZhSkZrSHFlc1pjTjNidzNk?=
 =?utf-8?B?ZmdQU0FHaHFwTTlWNkFQVXFvYVRrQXNVZDdraVlXVGpWbWZ4ZGVDMisvMm5R?=
 =?utf-8?B?WGszaGpqS0Q0Nm1wdFNDempZaXRreFExcXJXTXhWWVNRa20xNXFvTFhkRUxZ?=
 =?utf-8?B?ZTRCbkZLNmgzTzdVcjNLK0R2Y1krZ0JRTnhLdGU2ZWd5Ri9yU1FmVVVQKzIv?=
 =?utf-8?B?Q1hUaXZkSmlaY3dkTDdKcmtlVzFsVW5WQlgxaXdTdmt5M0F4aDNKM0JER05x?=
 =?utf-8?B?UkRBTC9MWUw3UE5oNG9WMFJSY3A1MC9uOXpBWUtYU3hxbm1abnliQ3FuWHRh?=
 =?utf-8?B?cWUvUUFpWEhiNkNOcjhBWjI3NERwdWJCVm55Y2hxZVU0TTFuWm5ZdHZmUnhy?=
 =?utf-8?B?Rk90STE5VlRHMGdPSSt4T2gzV0ozOVc2UEJpakZPc29RcllDU3NUTExPOVlV?=
 =?utf-8?B?N3MxdWNaL1MwSStwWUtBUWNNcnlObGN6VHh0TWlnSk15TXlvekVjUzhNR3VD?=
 =?utf-8?B?VVhHQ3FWZU5UaFhjTER5S2dlVldnS0wxZU85NkJPSmE3Ukwzc041MHU0OGFU?=
 =?utf-8?B?UXFrc0N1QUthczJMRFErZkpqSjlKUkhBTDR1NElJdUc1aHVDL0dzbDdES1hu?=
 =?utf-8?B?TFlOcllwTUFZVUtKTmFtdFgwR0RhOHF3QmVhMGhsYVdrL08xdHhJVWtiRDI0?=
 =?utf-8?B?UGRHb2c1eE5hb2JyMGZzTzErZWlQTFBZdlJkenI3QUdFdm0zazNtNXdqTnZ3?=
 =?utf-8?B?V2JieXQ5NWJxNVhIZHZjejNPblNNcHVtV2JhSSswemNtb1F5emIxOVBsZEJQ?=
 =?utf-8?B?ME9EdWVMYml3SkNzK2xYOWpPU3lGZnlZY3oxVUlzTW9VRm4zVmlrWWRlZDJK?=
 =?utf-8?B?ZXNBb3d5Z0NFZGtKaHV3bzdIVXJKczZVRU9FdjZVQkxleGlwQ2RsMnA5RXg3?=
 =?utf-8?B?V2NMZnVCYWR0L05yYnllV1h2NTRIUG1DRDB3dHJQTnQ0VXZZdjdMaWtyc3ps?=
 =?utf-8?B?RjlXbndid3R5MFZqY3hTb0VtSHJlNE51QjhZemN0WDg2bUJrRVI4bHB2ZnBJ?=
 =?utf-8?B?c2o4WVlXQVlwU05ZR3BtYWc2VnFXQm9ZM1BOZkY5aW9TL3RlNElDbm41WGt4?=
 =?utf-8?B?cFJ2OWpmcHdZUDBDcGNybGg5ZVdlaVZYTGhqS2IzRkFZclZMdi9zOEVmU0Ju?=
 =?utf-8?B?WVFaYXppdFN0SUFuOHlxbmgxeDFXUEtSbHE4YVNCM3EzODNaVHMwNkVlVWlk?=
 =?utf-8?B?bUt4bURmWjRIWDNuNU5CWW1vcnRTYUtRRGF0WjRESndBMlBWcUFWRVNPeVlj?=
 =?utf-8?Q?Ifvn4jdhgWo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3dFb3lRNDJ5S1ViQUxud3gyL2NjN1B1TGVwYko5eXZFZnNUZlRONmlJQk8w?=
 =?utf-8?B?dXRvUXNxdG1rUDVjd1BxUWV6RmhBczRGbmt5L3FtN1ZaU21ITGV2WnZ6Vzds?=
 =?utf-8?B?a1BEQmcrWDRuQlczQkJVMHFuTU4wOU4zaUJyeGxIRlkzekdtbVhnR0JmaHVq?=
 =?utf-8?B?cTdvSmRnaWRVN2ZXMTVENFFBVCtkbjU3aStjTkI0V0NqQnpCdnJYcFRmZjVZ?=
 =?utf-8?B?OWFOVW9USnd2dlpRTU1FaHFFaDlYbk0yZGJobktkRE9jYWpMckIzZFZxVU81?=
 =?utf-8?B?dG5EWHVTVnk3N0p6bXlEVkpSNGsreU40REFYeWVyK3VTdXlPVEN0M01PaW9S?=
 =?utf-8?B?VU5EaU15b3puemdaU2thenBSUm5UNm5Yem5LM2gydjdEWmZ1cEtPQXZnK2tk?=
 =?utf-8?B?dlZvMzcxSzdQUXFQaFcwcTFLVXJENHpOb2w3RTdXRE1JbmdOd2ZCQ3NRRnc1?=
 =?utf-8?B?cURNZGFwN3FWeFhNcUdFaTVhSElzeW1JMVEwbjA2c2gwUnZRaGJQc2NXK3hp?=
 =?utf-8?B?Yy9PcVEyZDhKWWg3RjFRUHhJWGsxMWROZ0JLSHBpS2hvMVdrdUpDdjFmUHkr?=
 =?utf-8?B?aDRVam5oN0prbmlZK2pLK0h5QUgwQVAwekFuNG1EeWFMV2hyeWt4WnlieDZX?=
 =?utf-8?B?dTB6dHIvOEw0eVVFQm1BVUdHelR1MTNrV3RjdmFXMDRWamU1VXBBL1l6WmJB?=
 =?utf-8?B?dE0vR0R2cFF0K1Z2alZzU1VKM2JQcStiWTBsRmExa2JhNUd3UFhuQTNYa3ZJ?=
 =?utf-8?B?OU9ETjJUai9YeWZEcExJemtZZ0tEUEJzWmVQeXpHN0dkWGpUUHJHVWNxd2xo?=
 =?utf-8?B?U1ZWWHd3aFRhSi93SHhoQmpOZ2pWN285RlJmVXFUaVVjZ25OUTlxV1ltVVBp?=
 =?utf-8?B?YWpIRVNvS3hDZFhZektRY0RJdzIwOFJYaHYzMFJ1aGZaZDIzTXFxaEVMUjNv?=
 =?utf-8?B?aWpMU2JPWWV0K3dzRTJyVWhrM3pNNUdiUy9Ic0tWa1dEdDBkOTJscHBoSTQw?=
 =?utf-8?B?VW9ybXdVakZYRnhDSW14bFVTVUZoMHZQcnZDL0JiTTdaWVFlNFZrdkdSeFI3?=
 =?utf-8?B?SHdYRUlCNkdIVXk5MDNLR09WS1JOWU1MSmg3dHA0S3FVVzFybzFEREhCcHla?=
 =?utf-8?B?S24zYkFSZ1ZsZTh1WFA4RytrSzBjTUVCaFdoZmxzRlI3akRCdEpTVG40UWQx?=
 =?utf-8?B?RXRKVGhmK3VKb3lMQklpbjVXWUpleTFEMjRaTE1iVngxUmZKeFkvUUFYWlFO?=
 =?utf-8?B?RjdCTkx3a3EraGNqbmpzN3pkcGVEbFdudzhOSGZqZ0xXOUxpUGl0dU9LM0Nm?=
 =?utf-8?B?ZTBpSC9GQzZqT0lkQnc0NjlHaTUrekJHWjFkS0UzRHZ5TFphZXRkQ2RPU3lI?=
 =?utf-8?B?ZlRCWVRUcnF1YVFHdUJ3OWVqUG0zZ2htMHNOY3gxZnRGekhDcURvYUtxOTlE?=
 =?utf-8?B?OHloYjJkbFFBdjFoZmJUblgrRTJSUVUrT3M3WW1rQUdPZ1NWSldJUVhGamZn?=
 =?utf-8?B?TVNWQkxwN2taL0NIY1VXZVM4NUhmcU9HcEhNRk5CUkFkdkhuQ2xQblVZOU1n?=
 =?utf-8?B?cGgyMUtrMXBLdVVENmRqNE0rM1hkMUswR1pUMDQwWkhIUlo1cGkrUzJSYlIx?=
 =?utf-8?B?SzZ1Y3ljRU9QZFZzUFNNVCt6RjRrN28yaVdJeVIzMkRRZ1kzeWhLUTUxNita?=
 =?utf-8?B?S0Z5QmVSUDh6Wm5ZQWJaTzg3OWI3aHhOY3BIZlpEclNSUGZJVjBaN3NncVlt?=
 =?utf-8?B?R1czSkpxVElHM3ExcWZJcU1xTFhaMFpXSjN3RHhHNHYxb2xMNXVvVHAxbGEx?=
 =?utf-8?B?UjBKRDRlTkcyQnBrQ2drYjkrOEJ3a2J6ZHBhd0cvQlJFTWJhNEdTcWdzSlVn?=
 =?utf-8?B?eFBidXBFQ29EWXFZVm03RjBBdDNzZjkvWEp2Ums4aUFpWmlNdmpWaThGN1da?=
 =?utf-8?B?eWM0MXZwUDlxME9NU3RLZWs5c0ZkajIraDFzbi91eDJOakc2ZVVDWHE4WEpa?=
 =?utf-8?B?OFBkczc4OG9DenRRSVorUDRKM2hIQkErVjUxampMOUlFcy9hN2hWVkxMNitT?=
 =?utf-8?B?b0dkWkdvN3ZkcGZGTWlUNFZhamE3WDNTQjZZcDYyR0FMSHNQQUlEcXNUZ2hU?=
 =?utf-8?B?SUVVbVJ3bEtDaS9RdFlweWtvV3JjeGJ4VXhYYUFJeWFhMzkrYnBvV3g4cGFZ?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c7cbeb-624d-4e3a-76b2-08ddd9975220
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 11:56:50.0631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mt6sJu/zkdFXp2bq5tXc404Qq7Q/LHKSWBbSBYoWdm/V7ll94NhQy1A+qHcFxnoWNI6cVHhGvr3ffyt6LVLcfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6828

From: Jan Kiszka <jan.kiszka@siemens.com>

Patches for this version are no longer maintained by the Xenomai
project. CI stopped for it long ago via 39a822c1a315.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                       | 18 ------------------
 opt-linux-6.6.yml                             | 18 ------------------
 opt-linux-latest-6.6.yml                      | 19 -------------------
 recipes-kernel/linux/linux-xenomai-3_6.6.bb   | 14 --------------
 .../linux/linux-xenomai-3_latest.bb           |  3 ---
 recipes-kernel/linux/linux-xenomai-4_6.6.bb   | 14 --------------
 .../linux/linux-xenomai-4_latest.bb           |  3 +--
 7 files changed, 1 insertion(+), 88 deletions(-)
 delete mode 100644 opt-linux-6.6.yml
 delete mode 100644 opt-linux-latest-6.6.yml
 delete mode 100644 recipes-kernel/linux/linux-xenomai-3_6.6.bb
 delete mode 100644 recipes-kernel/linux/linux-xenomai-4_6.6.bb

diff --git a/Kconfig b/Kconfig
index 14bf12e..672db57 100644
--- a/Kconfig
+++ b/Kconfig
@@ -123,14 +123,6 @@ config KERNEL_6_12
 	bool "Latest 6.12 Dovetail release"
 	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3
 
-config KERNEL_6_6_LATEST
-	bool "Head of 6.6 Dovetail branch"
-	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3
-
-config KERNEL_6_6
-	bool "Latest 6.6 Dovetail release"
-	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3
-
 config KERNEL_6_1_LATEST
 	bool "Head of 6.1 Dovetail branch"
 	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
@@ -178,8 +170,6 @@ config KAS_INCLUDE_KERNEL
 	default "opt-linux-latest.yml" if KERNEL_LATEST
 	default "opt-linux-latest-6.12.yml" if KERNEL_6_12_LATEST
 	default "opt-linux-6.12.yml" if KERNEL_6_12
-	default "opt-linux-latest-6.6.yml" if KERNEL_6_6_LATEST
-	default "opt-linux-6.6.yml" if KERNEL_6_6
 	default "opt-linux-latest-6.1.yml" if KERNEL_6_1_LATEST
 	default "opt-linux-6.1.yml" if KERNEL_6_1
 	default "opt-linux-latest-5.15.yml" if KERNEL_5_15_LATEST
@@ -233,12 +223,6 @@ config EVL_KERNEL_6_12_LATEST
 config EVL_KERNEL_6_12
 	bool "Latest 6.12 EVL release"
 
-config EVL_KERNEL_6_6_LATEST
-	bool "Head of 6.6 EVL branch"
-
-config EVL_KERNEL_6_6
-	bool "Latest 6.6 EVL release"
-
 config EVL_KERNEL_6_1_LATEST
 	bool "Head of 6.1 EVL branch"
 
@@ -252,8 +236,6 @@ config KAS_INCLUDE_EVL_KERNEL
 	default "opt-linux-latest.yml" if EVL_KERNEL_LATEST
 	default "opt-linux-latest-6.12.yml" if EVL_KERNEL_6_12_LATEST
 	default "opt-linux-6.12.yml" if EVL_KERNEL_6_12
-	default "opt-linux-latest-6.6.yml" if EVL_KERNEL_6_6_LATEST
-	default "opt-linux-6.6.yml" if EVL_KERNEL_6_6
 	default "opt-linux-latest-6.1.yml" if EVL_KERNEL_6_1_LATEST
 	default "opt-linux-6.1.yml" if EVL_KERNEL_6_1
 
diff --git a/opt-linux-6.6.yml b/opt-linux-6.6.yml
deleted file mode 100644
index 0de37f8..0000000
--- a/opt-linux-6.6.yml
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2024
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-header:
-  version: 14
-
-local_conf_header:
-  linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai-3 = "6.6%"
-    PREFERRED_VERSION_linux-xenomai-4 = "6.6%"
diff --git a/opt-linux-latest-6.6.yml b/opt-linux-latest-6.6.yml
deleted file mode 100644
index a17e78b..0000000
--- a/opt-linux-latest-6.6.yml
+++ /dev/null
@@ -1,19 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2024
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-header:
-  version: 14
-
-local_conf_header:
-  linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
-    PREFERRED_VERSION_linux-xenomai-4 = "9999-%"
-    LATEST_GIT_BRANCH = "6.6"
diff --git a/recipes-kernel/linux/linux-xenomai-3_6.6.bb b/recipes-kernel/linux/linux-xenomai-3_6.6.bb
deleted file mode 100644
index cc765e1..0000000
--- a/recipes-kernel/linux/linux-xenomai-3_6.6.bb
+++ /dev/null
@@ -1,14 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2024-2025
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
-
-SRCREV ?= "v6.6.69-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
index ff9e685..52fcf1e 100644
--- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
@@ -41,7 +41,6 @@ GIT_BRANCH = "${@ \
     else 'v5.10.y-cip-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
     else 'v6.1.y-cip-dovetail-rebase' if is_kernel(d, '6.1') \
-    else 'v6.6.y-dovetail-rebase' if is_kernel(d, '6.6') \
     else 'v6.12.y-dovetail-rebase' if is_kernel(d, '6.12') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
@@ -54,7 +53,6 @@ GIT_BRANCH:armhf = "${@ \
     else 'v5.10.y-cip-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
     else 'v6.1.y-cip-dovetail-rebase' if is_kernel(d, '6.1') \
-    else 'v6.6.y-dovetail-rebase' if is_kernel(d, '6.6') \
     else 'v6.12.y-dovetail-rebase' if is_kernel(d, '6.12') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
@@ -67,7 +65,6 @@ GIT_BRANCH:arm64 = "${@ \
     else 'v5.10.y-cip-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
     else 'v6.1.y-cip-dovetail-rebase' if is_kernel(d, '6.1') \
-    else 'v6.6.y-dovetail-rebase' if is_kernel(d, '6.6') \
     else 'v6.12.y-dovetail-rebase' if is_kernel(d, '6.12') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.6.bb b/recipes-kernel/linux/linux-xenomai-4_6.6.bb
deleted file mode 100644
index 730b0da..0000000
--- a/recipes-kernel/linux/linux-xenomai-4_6.6.bb
+++ /dev/null
@@ -1,14 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2023-2025
-#
-# Authors:
-#  Clara Kowalsky <clara.kowalsky@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-require recipes-kernel/linux/linux-xenomai-4-evl.inc
-
-SRCREV ?= "v6.6.69-evl1-rebase"
diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
index 5718e3b..aae7910 100644
--- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
@@ -27,12 +27,11 @@ python () {
         (ret, out) = subprocess.getstatusoutput(cmd)
         d.setVar('LATEST_KERNEL_BRANCH', out)
     else:
-        d.setVar('LATEST_KERNEL_BRANCH', 'v6.6.y-evl-rebase')
+        d.setVar('LATEST_KERNEL_BRANCH', 'v6.12.y-evl-rebase')
 }
 
 GIT_BRANCH = "${@ \
     'v6.1.y-cip-evl-rebase' if is_kernel(d, '6.1') \
-    else 'v6.6.y-evl-rebase' if is_kernel(d, '6.6') \
     else 'v6.12.y-evl-rebase' if is_kernel(d, '6.12') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
-- 
2.43.0
