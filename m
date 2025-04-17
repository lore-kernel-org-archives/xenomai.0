Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012031.outbound.protection.outlook.com [52.101.71.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD0215061
	for <xenomai@lists.linux.dev>; Thu, 17 Apr 2025 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744890666; cv=fail; b=tMaWLGxV3VsUFG7iUeB/ifPou/aZeCoccums6TJZlqKReqbvj82tVHzBWaB59mHdYoqvExObG3qD88qmPYkhMaBcZzzOgo+tlfybvPadS8nXcswtilF0OATiN/LbwT7me5rmiOkGC5C/a0HcizJiMQ7o/Ehr4IljJul45cuxMcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744890666; c=relaxed/simple;
	bh=1//77cE2xB2GMmKBA0mFvd0XQuHjcZD9BY3i4Db/B6E=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=jCkOemJOIgmQKwGOKusi8A/YIllnD5FYnQXgs3kXGyWxLNmJdqZ9qxLYWf8xcq8QQwVluaDC2JTPj+6rlwOJvAtOOFuOroXuKyMuWEuKT4ozvPIIWI+UVH+ykKZJSCl+Z064FTjng9ZT6pf9hgvVZjwHkqOznZPFuLnOaVzD+WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZGffGSfk; arc=fail smtp.client-ip=52.101.71.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZGffGSfk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvY7uwqpQd7fgtRHpDkAl8v6kN+LaZiQ3rkURXQnOJHo+Hm0YPtu2VbE8DLi5ShGUIxU9B8BvoHfKET8pyBAQhvE1in7oIf5rAwYeD2Hqfb6BAhdCXUJL8FIPI70/WKYfgQq1cLhcgNmsJdX2WH64lMxm3mWOt3oju4lbsK8ae5/2t2rHrftw935fCBKMmb1a/sn7RTdMhYF8f4otP7Lak2YkuIdhn0BpN2f9Y3TvdZIOPUWWT8J5dWJa9gsVj7JLe2vJEeWitTMYzxwI8ldMLzl6YKDyASmEaA4+kASERerr8kUGtYfOtHTCnGmpzL3zRuw7Nio0oaRhRtDAdutPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/QeCR4uxDYaDiHoERARkqZS2e/ObJC61eNKCF8Aeo0=;
 b=F/pU2QcGM/0W0DztyWlk2+Nmwu5adC6B4nn+Fk3GCF5TjPLwq1y/9hs3huBI5Kotv5WO8rcxYvLULrddGtY0XkpRBFIuGkuW7I65CYdM1NRRS0eHEuRAO68dA5ol3usFO8TMKhQv/S+scOJ3nnwqq80Kn9aXec5yPOVzZXcBuLL1OYIzcnKmGgOG9UnzTI/W1ClNmwkmqif/hq4ImOwojKZ64uOD6Wy9CdXcwmLJAaCvT7TGGvqQYd/DSj6kEqirLQYjiEkRr6x5pVzXyJB9JuHWOk+WqL0a5jLTrKHxFLDBtLkuODQf+iwgxqkgyzcJGMT00Sr51UqLvivwrt+EgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/QeCR4uxDYaDiHoERARkqZS2e/ObJC61eNKCF8Aeo0=;
 b=ZGffGSfkLNpntIkq3gbMfXprdkcFfTGiqNTpOw5L1X0Ha5atLuN/QSMnsLLMWRMIK9waImQhDOFKbwIA7+22XB5wl0CHrWagTYYFMeH8gt2Gjs6xFnLlqq7qSB1FnJ0YHGdRQ0+4OATXZxvrW0az749c0SqJhFDyByQ/vRmCMVJ86TBgpkGfBqQOSqF8EMCUdoyJdN1+VfFgoeMcGhnesLSIkx5QFrqiRlMqlsBrIr+VyjgZdHaEKGHIh2K4MMSxaSb4GsRFvqUebIbMvqB4yUR7G9iUFoadGNNFy5o8C3KBW3By57BsrKj9eN9d1z4xJr2AjwoCpaaTHc4INyQvbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8482.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 11:50:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 11:50:58 +0000
Message-ID: <fcb894d8-b169-4f02-ad5e-1579f5f354ef@siemens.com>
Date: Thu, 17 Apr 2025 13:50:57 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.2.7 released
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 762100f3-dbd0-4889-f8a9-08dd7da61e04
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjlraXkrMkgwdHF4MkNrc0Z4K1NUNk56d3Z2UUxGRktkc2NsZWFRbExnSS85?=
 =?utf-8?B?RTAxL2dWSkdEWWNBUlN5U3I5RE1ZNU5oczZmMVVqc2QwNFdHbFRIQjl2Ly9m?=
 =?utf-8?B?NHpRQWZDY002ZHZBT2dHSmNTVGNHRDFPaFgzc0kweGl5ZUNrMGo5dTVIUEhv?=
 =?utf-8?B?QlBzUEFSZFBJWnlXcVNPTTMrY3JhZUsvMm9jbk9jSERJRDhoVWNsUU1aMGY1?=
 =?utf-8?B?L0NlbXFiVmord2dCRjkzV1RGdE1zWlFtUGx1UVlPbFkyYXNTQkNubjFpUUxY?=
 =?utf-8?B?SmpuMGVIdTlhZ0w2dlpJaFBjZis2UW44Z3NoYzBhaHdxTkJKWXdFd3lnRnYw?=
 =?utf-8?B?cC8wMEZGWlV5cC9PcjZpMVI1bFZ4SDFyWDdXcTFxMXBiUFM2S3BNNGhhdnN5?=
 =?utf-8?B?eEVpUjZJaFpoUld2em4xb1MvN0gwMGpCTzA1dC9JMFI1TVUyOXZxZmlXOVgw?=
 =?utf-8?B?WlpuVk1KdjVwN1NHR2xFVjF5NlRBc0ZDTmFTeE1sTHBjRzdIcS9VU0ozanlY?=
 =?utf-8?B?YWQvS3J6MkxjRmdndXY0UkFxOTdOVHRoRnl6dk0xRlpxZzJUbmVWeVhFQ05q?=
 =?utf-8?B?TWpGNXhEejZYd25VcUZqc0dFNFNadnBNZi9JbmpWNjNsMWNLTU45UGlHOWUv?=
 =?utf-8?B?b3pXcWlOOXlLVU5aM01qeC9UMHd5a2pZQSsyRGdFM04vZFBSblYvSDZ6cWdu?=
 =?utf-8?B?WTdmWlZpWmh3NEVpNXNEZUpyS2JGbXFvcnNxTlpxam1zaloyeGlQUzg0Nmpk?=
 =?utf-8?B?ZXgzdU1DQnBaa3Z0WW11VC93dzdBYWVFdmUxRWRkUFE0UVRqVjVIWUIwaWlu?=
 =?utf-8?B?Q2ZOYXF0NjZhWlZJSWhIT1o0ZkhZTDUwUERsTkljMGhma1hRdlNrc1llMkww?=
 =?utf-8?B?QUcyeEVpZUR3V1hQckFzaFhaMXJ2bVB3SVJlL05kSXFpWklaV0Yva1g4U3l5?=
 =?utf-8?B?eWd3aDhMaXNOUjFKY2FjUlpFZ240YS85U24yTFR3YXNKNWpVbEpNWS9rUmNZ?=
 =?utf-8?B?a1I3QTRqUXRIeDBzUGhnVzBoSlZhbkFmd0RRYmlDK0RiR2VWZlIwKzFob2hQ?=
 =?utf-8?B?dEUxWXQ3KzFXRUJMYlRkcVNKb2o5MzhYZGNDNnRxcGZhRjVlaVFVdmJKN3R0?=
 =?utf-8?B?dHc0NjVIdldNQ1dmN0w5Wm11bjRGNm4rZTBrMXk4VzgzZ0g3QnRFNDRjOVAy?=
 =?utf-8?B?VDQwRDczTkc0ZFZtWU5BYkNvYzIyVm1GUW9janl0V0NoS0RSdGVOSjBpOUdH?=
 =?utf-8?B?dnJwM2JucWNjVVJDTUpoTDJoemp4MDVhTGplTDVRelZqakZLbEFZTFFVR29F?=
 =?utf-8?B?cnc5V0R3a0c2c01PRjRxQ3NUbUwrTlBVKytNTUx0aGNsbyt4UnNzNGlLV2Fy?=
 =?utf-8?B?QjZDbkUzcTBPbnI1cFh4cVdEVzNldTV5RFRia0tFYXRSaDFmMTRqQnFkQ2Y1?=
 =?utf-8?B?ZUh5NG9hT2NSRVdTNG9aY0drc0JReWpYN2QwWU1aNzNLbmZ6UDVQVFRuZkhk?=
 =?utf-8?B?TGlxcit6SWZiTEtEVCthdGQ4c0RwanVZTHQ4T1N5MWFOdExYUzhXd3RNZ3Rq?=
 =?utf-8?B?d1JnRnp6ZW5VUVBFZHppU0tBRi9PMnA3Z2VaQ1AyL2dBM0cwZVNXZ0lnSGhR?=
 =?utf-8?B?SEp4cytlNVBUNm1oSXZvK2tUZ0hPUzArYkdVTkJFclVmZ3NJMUtKTDVQcHJU?=
 =?utf-8?B?cUVwSy8rRCtyZmJIUS93WlBiVGV0bU9sNzRwalhSclFzUWczblBYd2JuQktk?=
 =?utf-8?B?dVl0VHJWWW1kakVoQzR1Tjc1VFRWb2hqMUIwaXVNK08zMjY5OXdsZjRrV1d0?=
 =?utf-8?Q?9oc1SlPExMalRAvCd9vjud0ThuAIGzedTD7QY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1dpaURFbTF4K1lCemFmYjBSNWloWmtKS0Iwc0FrNWh5ckVlVHNFdGZCZ293?=
 =?utf-8?B?VXZTZ1JEMFNtWTQ1UlNCTWJYZVZvVml6VTFlU0tsTXNzVmpnb0FSb1IvMi9T?=
 =?utf-8?B?SzhSZEQ1bTcySlhoYVZpN1J5R2Rha0QwK1FEbkJHTDhsS3IyelZIYzA5Mk5Z?=
 =?utf-8?B?ekxKejhSUWplQngzd3Fka0ZOWDJYZDJlUVFXUk1VTDZhS1JRUnRjZGhRMk5T?=
 =?utf-8?B?emxGOXFPdGVOcW5hRTBGOHBWTTJLdVpkNlE0NVZ6bDYzalFKY09DM2IxYzEx?=
 =?utf-8?B?SFVLODMxR0g2SXpyVStvWUp2c3BJdUhVOU9hSWRFL1VIN2JYNFIxSmFBNjVD?=
 =?utf-8?B?U05GdVdyLzN1RVdadm5OczZTV0MraW5SSFlmd3hpblJoakowWldpNmowZklv?=
 =?utf-8?B?clpseGRKd01TdW1EMnR3cDkrSTF1WEw3MXM1ZXlCNitJd2NOd3FPNWdRa1Fx?=
 =?utf-8?B?S1ZmbGxrbVQ0QnJCT2gvakZicEg0VWVGMDhjNXZETTRIRjBpeWdHQzZzMnpR?=
 =?utf-8?B?WGRqbjd0MTNiMTd5VlkyV1hEa2FBTGo5OEs3Z2pVc2pURzh2Q1dGa0lvdlhO?=
 =?utf-8?B?K2Nrd2YrMVpOanRZUGRIRVE1eWVXaS9ib2ZFRXVUdWN1blpIK0lMOEFBcmty?=
 =?utf-8?B?UzZTT2pwcGVnd2hCY3YxRjd1c2RTQ2xDa1dOcXVSYTlFd3p5YjZDWWl0VkI2?=
 =?utf-8?B?R2RsVmRXZmg0LytoeDdIVURxaE9zSFN4NWdyT0dCV3pUODRRaGlTSkc2UmQv?=
 =?utf-8?B?eG8zbFVWYmhCUFJFdkdEUHNZdmFZVWZ4cS84QUh6bWdVN1VGZDk1VllwWWt1?=
 =?utf-8?B?MDFzMjVDM3hNaUFZaEwyNUdWZ2hEa1JYdlNUTjZWZTUrZlI1Y2R1UStINXlz?=
 =?utf-8?B?VjV1OGRPRVJHL1B6bDZsYUlzYm9BcHRQM3p3UkpvelJWS3VzdmN3dVh4a3JK?=
 =?utf-8?B?N2ZicC8xVmRDRXkzN2Z0RzN4WmdiUUZBVkFHcG8yZkN5TXUvYnhCNXlpZVJi?=
 =?utf-8?B?ejl1WU8zazlGazNRSXNEaFpVc3RZeTczellRWDJkcGZYdFViTnJMNklUZy84?=
 =?utf-8?B?OGc5VzhMUFRuQitMSXFXK21JUm9lYktLc1cva3hGYm8rQ2Q0MENKVWE5bFlB?=
 =?utf-8?B?aEFKT1VaaEx6MExqWDNZNXRZMVNsbzlCSEVnc1A0VWRkT243TDdvanB0ZzY2?=
 =?utf-8?B?d2ZZd0V5K2RXSmwrUzhrbjlYdzQ5WXptcXAyM0lhRWRlK0JOc1QvV0N3M3hW?=
 =?utf-8?B?MkJTVm5Za3JGMEo3dVBWRmkrWmhOS3NOQmIwOWVITUk5V1JNdFQ3V0NRNks3?=
 =?utf-8?B?elFhd0lablBkK1JITUZCdlF5d1FPcjZNWGdBaENZVjZhWHF1TVRCN3NlcEU0?=
 =?utf-8?B?WE9yVWsxTHlHNUlDTG41QmhnTGllTlZPOTRrSDM1RFFLcGRkZWU5QWlzR3pl?=
 =?utf-8?B?dHM3MjVadnJ5RC9mZzZMUUswREZoczJxclk3VUxRSXR5OXB5Y0tCVzBRMllh?=
 =?utf-8?B?K0p4OVQ5Wm91N254emRyRHpwM1pNVUNrak5tV3c3NTRKVDFFeGFKMloyYXFD?=
 =?utf-8?B?NExxLytTUmZiZ203aFpyc0pOdnNRMXhveFQ4aGk1WEFhYjFGalNGRnBZNW9V?=
 =?utf-8?B?OU5SSm5kS1d2dHRkcDJKWVZZT0dvUTQ2QmhwaTZvZldLK3dMQmFXN0hjM0ZC?=
 =?utf-8?B?TzdpbWIvWkJDdmF1MVdveU04UUNrRkNJUEdMYlV0RitVc0l0TjVJVUpxbmhR?=
 =?utf-8?B?TGowODdIRkxFdE1yS0NSeWtKTlFxU1REQS9hT3F6V2NZdjBKK1FLS2NCVjRD?=
 =?utf-8?B?a0tuL1REQngrcFBpMENhWU9DYy9kb1ZLVnVTMjIwMlIxbDJSWksrS3NudXdX?=
 =?utf-8?B?SUJ5cWZsbkJVN0lEZ3FmYm55V0FkVG5tSG5nSlJUTFRYQytxVFRjemx6WWg2?=
 =?utf-8?B?VHExTndCdjVuOGdRTUhnLzlyNmR6VGtQZXBvU2VlZ29aOUlyR2h0bm5LMWIy?=
 =?utf-8?B?Qlovc2dKaXNmVitkUUM1c1ZSR1ZYY2ZWYWVIZWtWMGllK3BNcFFKYTFNMnAy?=
 =?utf-8?B?MWwxRUFENHZSQjNBVVRXTmhvTklFMEZTQnR1bGJtV1hhbjRrSFFYNHQ4Y3gz?=
 =?utf-8?Q?OM+7I7PkX/7oGTmBNTCJyFnLN?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762100f3-dbd0-4889-f8a9-08dd7da61e04
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 11:50:57.9732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HlcoJCNFq2owpRkGvuM+XweNzfSQkgWc2acWx25Mb7dLMkwoP/+rpUwS12GmwU3hJmBvRgV1Pd3QHjrhyW2AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8482

Following the 3.3 update, here comes the subset for 3.2. It also 
includes the recvmmsg timeout change [1].

Download: https://source.denx.de/Xenomai/xenomai/-/archive/v3.2.7/xenomai-v3.2.7.tar.bz2

Changes since 3.2.6:

Florian Bezdeka (2):
      cobalt/tracing: Fix cobalt_tick_shot trace point
      drivers/via-rhine: Fix a build warning in via_rhine_init_one

Haiyang He (1):
      lib/cobalt: Fix a deadlock when release_buffer() attempts to re-acquire buffer_lock

Jan Kiszka (10):
      testsuite: alchemytests: Give more time when running in a VM
      cobalt: select: Move nfds range check to caller of xnselect
      ci: Exclude master branch from builds
      README: Update links according to our new homepage structure
      cobalt/vfile: Plug race while opening
      cobalt/intr: Restore support for IRQ sharing
      kernel/cobalt/posix: Stop supporting timeout parameter in recvmmsg by default
      ci: Tag build jobs
      ci: Fix detection of tags
      config: Bump version number

Richard Weinberger (1):
      cobalt/dovetail: Fill fault statistics counters

liyinjie (1):
      kernel/cobalt: use flexible array member for symbol in struct hashed_symbol

[1] https://lore.kernel.org/xenomai/8e0ce080-1167-486e-8887-9fd8a3d250dd@siemens.com/T/#u

Jan

-- 
Siemens AG, Technology
Linux Expert Center

