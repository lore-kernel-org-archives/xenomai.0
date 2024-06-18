Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FC36D1B9
	for <xenomai@lists.linux.dev>; Tue, 18 Jun 2024 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696358; cv=fail; b=ExZH9ke3Do8tp+BnV6xOjATJWVagjAiThwYMOjHTNEKD+Oh9WEuIFrwuEMARDFaPr8uPRe8BqkH+yNK305wBJzgzke6mMU5ZAw7JkpqZNy3yN6zZnDsmabAgV18JyNiyTkb3CgYrQNbPbj4nCH6EqB+rgckTrVC2di1agwG5BTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696358; c=relaxed/simple;
	bh=n4Gd0wU/B708LvCfoI7U/KmCU/pW2H2aGk0s9xBKafs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n6dz2v+EQxcWNoQir9SbTQduAVzYKPeIhLeyjFdbciZ+diPVvhf1X5Zqd8Duufz9Zc5L7zT9EZI4KXZl75ariuhk74SHiYEDPeeeL0uYwm4/PJuD2Zflh3+W9ZAsRB9idUHo69/MtWfgMXiOsiApzNfiB6Mn+Rv6+GUqY29Azmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DqBEPT8u; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DqBEPT8u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtC0ib8jKcuEmGwY0u2osgbsluRBky25JXkZQuuhz6lA2TcwE2TzC1/DvNZuemcCug8a2Av9P3gzWJkQHYurYZrIC3n5qKu4KuxdiXdsPRnsuK+8CJFWJ9Su3IMdofdlF4i/9ECyMR4wI4uWY099aTRWeFlAo0XGv6Bii4R/w7Li1/JwE2l6W1Q0lnIrFEPD4zAvYLthNTNDRuc76THpYt+1DqGVaA5NzZOwWm9gzrDgQSnqTNjknuUKKztRT023AZVm0fHdr8TgDXKLr602NKpP5TPCBGQ5H63tUf2qgLUobdqCj/d/RDMsqvakaSvR9gDYZQqVqK5y99c9RiA86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=823yYkJ+aGU/s7++i4Ck0AD2dWU0Ae0Pc8q/DHTQR9w=;
 b=FnnZs1IOCHcHgEInYDwyLv92J74WbtearLNjCbteW2XR3S8iR25VRF3q76qEv0ndBwkHPJteAXmQAb8K5eBML7p7nxqckIY1m9ZA0YSdjpRLvqWugenf1LO8pwWXtKjqe83S1Y0x9ZlsI4hIFFbxSJzEeKFEumVV7w76r/rk4KzXsWHRTFmH3uIkrNZsUFApX98Pxy5dsclCKfZiI+rfO9zkvOfEnor58YRrnA/KSeaf9V7qLItrkF7GdIozWRIzQA0cOADrHAwC9cAVcDWTUdFqqOHowfvpnGAVcyLaJSXsYlDGiBBh6WYPe1YxUPyF8aKVoCnGZKR7LBR48q59hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=823yYkJ+aGU/s7++i4Ck0AD2dWU0Ae0Pc8q/DHTQR9w=;
 b=DqBEPT8ujYkDgjeC4/t6E9ENSC0LwHJ0aNYEgQ7chtRiyQzuupyyHyyGJzh+Qy40Bbnv+qHmJY7CVqVSFAnqFCofAatF+nntbUjv1LBO6QeePF0qmIdi3wKxC2GPa+YuWfB/jqPyI/4HmI4kkyWtnuDluwXxJJi1t7ln8KTvFx1gNclh6VLCbUAmUT/1SohXXBFTlD7y+9ujRmkv7cLzaMYOcXlC7jTZTE/Gs7kyyHqOSGgMyzbxMxJe6nRC7O8qLVWib0IBApHMtysUJFzwlklUYQbTBglqm729sjPONv1seeqoCAwjbCIg/GT7kWnZ9XDmApHOLRDgv8+JfyyrRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6715.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 07:39:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 07:39:11 +0000
Message-ID: <138b3617-f2b2-40e0-88c9-0a6ebbdd9b42@siemens.com>
Date: Tue, 18 Jun 2024 09:39:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rpi4: fix arm64_defconfig CONFIG_BCMGENET
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Yi Jiang <yi.jiang@siemens.com>, xenomai@lists.linux.dev
References: <20240617152859.32359-1-yi.jiang@siemens.com>
 <ab5621f9-de3e-4d49-98b9-0440f35bc006@siemens.com>
 <5b831c9e1d047ba3e30f7d9497b934753bd7ac3f.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <5b831c9e1d047ba3e30f7d9497b934753bd7ac3f.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0282.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a90a23-436a-4b88-644c-08dc8f69bea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFpUYWE1TCtmUmdVdGg2b3ZwdlRlUlJkdDE0dXVDcWcrNWpRUytWa0dic2NB?=
 =?utf-8?B?T3dCTmJ2Z1NtYmtGU0JOR1hQbkVpK2pTcGJaUEZTL3VFbEhnY1BkZS9KUEVt?=
 =?utf-8?B?MzJqcVZMcTlJM2Rld09NcEdxRFBFMjV4dWljT09EcENQeDVMNVM2c1VNcGJu?=
 =?utf-8?B?ZUh2QTRRSUgwdnFIc0N4VkFHTlZPWThOb1FBWDVtYXJod2ttbEY1KzkzaVJF?=
 =?utf-8?B?RTgxYW11ZENibjhOa1dUU2JlazhybFhXbkF6M0x1UTJESDVKZ3oxOWU4V2FS?=
 =?utf-8?B?d2dKQVo4UUozd211Y3RIM3VBTVpldDUwTWJzVlE0Q2I5L3RMY1llUXdCbjlQ?=
 =?utf-8?B?RUJWMG1MU0szWkg4bktPSm5rZVJqSnRGVVhzVjlGcEVoTFdEUXl4VHIvNjdN?=
 =?utf-8?B?eTR1VHVHNXd4TXUyMWJMb2krc3pHcm9sWEZYT0hSQnNmeUthZVBQem5qYlUw?=
 =?utf-8?B?V0ZYSDJCdEM4VG5hdVhla2VwVEswU0JMYVMwL0s0ZDJ1cEdCVVN5ZHJ2emI0?=
 =?utf-8?B?WXZjaERraENjeXdUUFR2YnZYTU1Hc2ZLQWRqN1BweCtRMUtPQ0hZK3A1TXdq?=
 =?utf-8?B?RGVic21Gd3E2ZGREQkxiNzBibHQzUElGalFLekxYNnJVa09lY3IwOG14aVhF?=
 =?utf-8?B?QWJ6TmNxSHpHaUNNN2o3TFh6RTBxV1MrOEt4b050QlBvYThSOFpRczNTV2hN?=
 =?utf-8?B?cFVSSXhOMGFScWtrL0pGSUtwZUhtckg4R0tVVHhjeVQyRWVUTHV1R3RmdWh2?=
 =?utf-8?B?cDhKUE9WWlhBbDJzZVFCSWFXaTN1M2ZRQjlkTWg1bkg4RHVudVA5amsrMUhk?=
 =?utf-8?B?elNnb0Y5Rng2REJlWVlnOXQvUUJWL1VSc0NMMmJHVUJncjZHTVdwTWhlMHhW?=
 =?utf-8?B?V1BKSkVGQXJsMFZXcnlHTHRMNzUxYjVHc0pKL0NueExOOCt6SHVOMmdNQkM1?=
 =?utf-8?B?M1pNNUNjVWwydjh1c2RtYlQwU21UZThEN25VRmxlbEwxeWhRQmRub0tER3ZL?=
 =?utf-8?B?KytsU09ROWVhQVc1bGdCMHZReE9ZRE1sZWh5OWd4MWUvNEVpSXZuekZhQzRi?=
 =?utf-8?B?UGdMUVZneHVxSWFFMFZKeTluYndka0lxaXA0UTg5ZmVNWEc3Tk1EMEI2dHpX?=
 =?utf-8?B?bkdsZjJpTXRTQkZPSXk2cmVVU1M4TVljVmFXUVZJQ1hFK3hxV0Rwa05hZHRD?=
 =?utf-8?B?VHBiQm1oSHZTaVJ4bmZyc2tZeHJGRkljbXY4Vyt6UUpheEVya2VpT2V2UXA2?=
 =?utf-8?B?RlFRdk5IajRDaTlFUXh5QzhaMW00aUxFMXNZaWV6UXUxMmtmOW9SZTJKcFg0?=
 =?utf-8?B?aEkyb1llSmhZZzZNazFiT2xrd01XRFFranhwTUJmcHE0YmQzQzA2WHpaRWlJ?=
 =?utf-8?B?NXllNGZWNkFsQllWWDRmLzJNR1ZnTVBvcjFMM3cvcU5zUFhCUVBpRDFkTk14?=
 =?utf-8?B?NHVWMER3T0NhR2w4KzRlRVNpVC9oYm5GL2lJQm9FRU9RWDlEVzRZVlkxMEZs?=
 =?utf-8?B?NlZnT1dIMTdNVEc1OWEzUmNVZGUrMHdIQ2VsNEJTQXM4Z2lPWUFCcWNLQTlj?=
 =?utf-8?B?dHM0b2ZJN1MxUEQwODVORGdaNGNpcU5jNzU4TVJUeWRWbWY4NExpM3pxSkov?=
 =?utf-8?B?WlhyUWlpZ2JJcnZRN2xzczMyOEVxK2FSdCtiNTB3QlFXRW8rOGJJakR0ZzlM?=
 =?utf-8?B?QVk0V0RkMnl6MVhuNnZIcVBSenVJdlZ2Q3kweEJySEUrV0hXd3BKRmw0Q3Z1?=
 =?utf-8?Q?rJDo7/Gd4PZnDYdtB4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUY2UHB1RGFkTWJsSVZTVzlWK1VxV0poTDhoMEtaSFAvV3BUUFErb3lnMSsv?=
 =?utf-8?B?SWFIeVNtSlhWbjFINVpHK3ZZSjdKUTNjSjFZUmFlMmdMNE00M0Q0UzdacWJY?=
 =?utf-8?B?ZzlLZWtGU1RKc3Frak1qNlNBU3c0VWlRK21EUjlCbkljdUVVYXF3Uk5oZm5N?=
 =?utf-8?B?YnE0RlFGa0cvUXlyWlpRSHhlOXpFMzNKY1hYaDk3aTFad2M0Y082L2tUa0hG?=
 =?utf-8?B?Mnk0MC8wdnFHYm1IbC8xZjkrbHlWYk5EaWxKQk9DTWwwZXB1UGVGY0NVU3Vl?=
 =?utf-8?B?cEVWa2NxUVFuQnM5T2MxbEQ1dzh3MUc0NmhwNEtaYWNwVWErZ3N5S0hZcFl1?=
 =?utf-8?B?QUdTdWxxRVpmU1JwL216cE5zRmhQV0VkV0RMVVVoRXJqU3RuRmFKRU5YMUU2?=
 =?utf-8?B?OVV5SUdHeHFVdC9wVXJLOFR1NlpsejJVQ3ZlcS8vQjZ4UDNCZzV5NkxEUXgz?=
 =?utf-8?B?ME1nbmRGMUpqQTN6U2hYcHEwNjhQVm5FaEYyQ1VyOHRTSTRoQWx0bjRnOFV5?=
 =?utf-8?B?SEpRcG1BdGloWWN1dEZ4bWI1d0RXNGFFMENDd2FLZjNmMUVRVTBTNnhPTkUx?=
 =?utf-8?B?OHFsWFBGSG5QcmdoZ2d1ZFRyUDduUGwyMWtVdkgyZnFLQUtNWGduZDkycUZV?=
 =?utf-8?B?WkUveWVVNml4NGs1V1dOTVVVdE1KTTExLzNpV1Vxd0lXU3k0dVAyMFkxdzRM?=
 =?utf-8?B?VmRmTGxueFEyY2RYZHUrNWIrdHZoajYzdnU3WTlmL2pKdEFIVWhNT01pbXc5?=
 =?utf-8?B?NWtIQ1I0TktTaUlMQ2V3ZzdHeUxpb2FlYk9OY0tRZEVndHlYSTRNRmVpWVdo?=
 =?utf-8?B?dlVZQTBBc3BUVnZVRVJhMUE5NlZWZDhZb2kwTFR1YlIzUEs5M29RMk93ZTBz?=
 =?utf-8?B?cjBScThLR2VESU1kckFTSlVFdUM0NHhZK0svemo5QURRTVk1VVN3eEY4UE9K?=
 =?utf-8?B?MjMwYmpXT0E0VTRoZm9ySkVHQVBWQnRvSFdCOWtPZUJwbjdOMjJ0L1ZVQzZz?=
 =?utf-8?B?UzVlWllIWHlZbjJGb0NzNUprMUh6dWtWODBvcUZCSUtZL0tvVGNVdE9TbHU5?=
 =?utf-8?B?L0NjaVVUMU1QYmxjMUtWVnArQ2NJa3JZYVI1alZSOEs1UUFoNXNQWEd5M1N4?=
 =?utf-8?B?TEpySTZ3cnBHNlM4N25kSE1uOE9Ib2R4WlF5SW83cm9yVlFpLzVkdmNsRkly?=
 =?utf-8?B?TkZGTHhZbmpZdnhMeUpJekp0c0xWVUQzc05iRlZwT3M4SlFXNWhkMExWTDhY?=
 =?utf-8?B?K2VmMDFUS1FaQW9VMmNCdkR0UFNBVVJHUGhOak1kU3IraG5PY0VVTjlkc2s0?=
 =?utf-8?B?SVpuWVBjZThqbnRUVnF1clBVUko5Wk1VRTQ4enlYMzlwczZzQk0rdDVYUmR5?=
 =?utf-8?B?Z0RodDdCOVVFZ0NDWlpmOThudmNDeVlNMEczQ0xpYkJvWmpTbG1ZeU8xbFcv?=
 =?utf-8?B?SHdZalNRQU5BblJtdExad0t0QU9RUUI3SzdScFF4U3l6djUzLzNld1pwTzFl?=
 =?utf-8?B?N2k1dk54MUpYV2owN1YwU0RpeGNTdWFKck1Hbm1uaXY5d2VhbnpRSFdiN2Jw?=
 =?utf-8?B?SXl3STJPMFUrMGpsWnZwVVRTbnJuMHNuQkFXU2VZdFBUTVhObUZSWVRNNmlp?=
 =?utf-8?B?WTNZVmpqbHhLWlpnTjAreFJpdHh6czVrb29VckduY2R0R0hHbmd5NVhRQmtk?=
 =?utf-8?B?U1N4UVBRWDZCZGtlTWtJQXgyeFpZOURscW5MVjJ4MCtYb3ZpOHBDWmJVTzNv?=
 =?utf-8?B?SXB6UnhOdnVXMmhSUVdhUWluSUhmU3ZHeDF6ekJxK04yTVBQVXFNYzN1cVB5?=
 =?utf-8?B?b0s3Ty9mbCtyZTJCcytoVmZiVWZJZVU2L0VabWFtUE5zd0NGSTdHd2I2dGM3?=
 =?utf-8?B?NUVtcWNRa3dTNjBZbVU1T2xNMDdTaDRNMzByZDlKOTd4OHBYekQ2U3huZXVD?=
 =?utf-8?B?U0xjMXhrZU9tc0RLSWhFNklIUmNIZHpmT2hZdnBVZ0lPcEhXTFo3THoyUFNE?=
 =?utf-8?B?YVM0QnJPRG1ndWZnMmVpWkV5TnVnU1JIUjBBNEJzZjJibnFqQW5sZFZUUy9C?=
 =?utf-8?B?aUxTTW5CaHZoQ1dHNSsyb3JNQmEvNHFNaDhpbGFSRWZsYkhiZjVOQytvbFRM?=
 =?utf-8?B?Mml2T0FHUlE5SFJaaUxFdG5MV3RCYW5rUC9Ea2pKeXBnQ1VMMUNySGZocDRh?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a90a23-436a-4b88-644c-08dc8f69bea2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 07:39:11.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lUV1F2PDz5C/9bowaVR+4KjCdvwDbkVOZnMzemnA/d92ZnzYwwLQ5ByjGv6977FwfDnN5AxGNIj8NIlNmwIHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6715

On 18.06.24 09:20, Florian Bezdeka wrote:
> On Mon, 2024-06-17 at 18:47 +0200, Jan Kiszka wrote:
>> On 17.06.24 17:28, Yi Jiang wrote:
>>> Remove the typo "space" before CONFIG_BCMGENET, so that TFTP booting can be supported.
>>>
>>> Signed-off-by: Yi Jiang <yi.jiang@siemens.com>
>>> ---
>>>  recipes-kernel/linux/files/arm64_defconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/recipes-kernel/linux/files/arm64_defconfig b/recipes-kernel/linux/files/arm64_defconfig
>>> index 94f7b5b..1dc8b69 100644
>>> --- a/recipes-kernel/linux/files/arm64_defconfig
>>> +++ b/recipes-kernel/linux/files/arm64_defconfig
>>> @@ -1951,7 +1951,7 @@ CONFIG_MACB_USE_HWSTAMP=y
>>>  # CONFIG_MACB_PCI is not set
>>>  CONFIG_NET_VENDOR_BROADCOM=y
>>>  # CONFIG_B44 is not set
>>> - CONFIG_BCMGENET=y
>>> +CONFIG_BCMGENET=y
>>>  # CONFIG_BNX2 is not set
>>>  # CONFIG_CNIC is not set
>>>  # CONFIG_TIGON3 is not set
>>
>> Thanks, applied.
>>
>> Jan
>>
>> -- 
>> Siemens AG, Technology
>> Linux Expert Center
>>
> 
> We could still squash it into 
> 0ac81bd9b650 ("rpi4: Add rpi4 (Raspberry Pi 4) as target platform")
> 
> It's not part of main/master yet.
> 

Right, thanks, done now.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

