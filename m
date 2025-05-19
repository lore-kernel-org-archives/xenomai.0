Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C4A26C382
	for <xenomai@lists.linux.dev>; Mon, 19 May 2025 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643700; cv=fail; b=pLbo3HrfQqlJcWBg9vd6QKKnnjgjCLyquLFwsIE7K3cTSOtsPUsmeyhd48LCHXHITaCBa9v2fWOEG/Q0ihwxJlGese/HrJmH0ZTUE8eM1BjUYVsJwJF/hdjSo5Nj6yzgHOwH4v6IGuPxArLPJFRm0h2lisgyLlqLZzstrtOYmi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643700; c=relaxed/simple;
	bh=pCGpwcYvIaiDrTwNd4uvhthtLxHr0MQP54Kr6KjujYQ=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=ZJc0f0NlQ4YAxwPW18BDxbpa5+wn3EBJ9d92gUccsKblK3xl+PpZHI4sfN6dkayc8uNbGBiZDjaZFpfRQLggJeFg3JkEzo90cYkRSan/RsaN7VJ7isAXki9IJngn9cMF/KJ9kxR/DvqWiU9dhu4oaqExqIj1+wDQWwNe7ZTwn24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EgVZTnNU; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EgVZTnNU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQ+Plb5BC1puBc27YWzXIetou3UCYekfKq2Z4QmIw7R/67RPYwKiFdC0DJE7gktSdJDTN2E2O6ADvx6p9+uyBVhdw3MjKbND1f3hs420xglH/w/IDFm8f9Y4q9DatP4C+CKCNQxzPLTv/+Y271dybzN2b7fBpg+0N24kX/dMRIPKjFnLaT9dcyj4NdaNDj6jCuN3f7xCx0DN+dOXaEiDyA841rWQNCPMH5znARPIakPo0JDqjGVlqNKMp2usYFY7RJMDf+J6E2ZA/kcPR3sPy3uDJf/Qz0708m7C16S46NmRqPWjOzbrl4E3EgBz/+9XRLJbswoaZU91S1eLBbcXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEqUyDysHrT7E0nyJOVsnQ/WL7g4/Gh26WG6hfhEHcQ=;
 b=tex/8MpwTEvyejYwTGCeRhpPNjh5m+W7JHDzcxCn3fpHGFSOy7XT1FkIJoPXbYiKBxMlTzW7svW8uasayDcUwZ8qw0npXVoEVIiGMQFKC39VXkeMnAIpq+KLqTb/onrFHF1mowOVNWmyU3laEEN76Vky80vypH+lhmq/BO2tYw+Ojfd26HLbhDnlqp8ydDoTnR1vwYj0STNi4uNRcXosV5LMIx+vqCUCDhwuKR7stgu6g+L4R2+3OuwE1Qd2P8EZ+4UJsGhyYwUiRG2gT3idjO+enJlBwgvhJQ0teHwRoUcsCp/0ExzxIwIPKeZr3XZiEuP6IAsnyDtRUbxE3ktQEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEqUyDysHrT7E0nyJOVsnQ/WL7g4/Gh26WG6hfhEHcQ=;
 b=EgVZTnNUVCHbMUdncmo0TZUNXwuVg7UJwgDC08EzK3Fkio0OeOYDWruLuTvanizoIr9iLBXnFLcDkTtCGNgpGHHbUpYtlqjiiJbOBrbCZqZ6O+FOVyVt56tvMe5WuzQb8CjyHtAeqQJvOr75VpLWh+cQLCo2HeUhYWSAN0MEpHwemIQZgnJJ8Cob4Qf3dq9uHTpd8RsSYvtCndkAWK+BylsF46+97jhgHMZVtrct6kEuObTdvLyzMbW4oCYGxkDFw9xPD40Ze20UQdngCUtX1WOCmqoM9YfiAo2kwurD/LO6pqw3wCs3v3DGbRP4kRVAAj+j5K83JUAteBOANSLAwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB8033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:558::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 08:34:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 08:34:55 +0000
Message-ID: <dbf7a323-f79b-4cdb-aa8d-7d86aaa5127f@siemens.com>
Date: Mon, 19 May 2025 10:34:54 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH v2] lib/cobalt: Unbreak sigshadow installation for statically
 linked applications
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Haiyang He <aspirestro@163.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 6efe04da-6f95-492a-aa79-08dd96b00806
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2J4SXNqalRQZmcxUzlZVnlxV0REYjlqb0J1V2xsdS94QjN4dUV5TmR0Ykdp?=
 =?utf-8?B?NHhOZmpiVUhiVGRidTQ4WWkzRktHUmo0dkVnclVxZDRsanFkZmU2ZzhKVmpx?=
 =?utf-8?B?RFFGbUJXc1QxNk9RMThLcUNjREprM0VCTkNUbE1oL0VpdWN4eDRDRk5ORlhY?=
 =?utf-8?B?M3RpeWJJSG41SHZmcGRQZGpoT1pTdys0T3pUM203cktla2c3MjdGNzJsYkN6?=
 =?utf-8?B?b0ltYmYwWThzWjdCWWYzRGlwOHdGdFBQTHR2OWpIVENuNURXNmRNQ0sxVHBX?=
 =?utf-8?B?NGd4NFBtSWRKQ0VwVE00TW1nUkVKc0dGYjhJc0hRZytVQzR4WEJOcW0yNW1J?=
 =?utf-8?B?cHZBUjFuVitZMGx1dEFDSllFOGRDbk5wbUdLZHlzL2VsYjlkejBrZkhHa1BC?=
 =?utf-8?B?TXZ6YmR1OEI4ZW9ZaDVOVGNRRHpDMllGSGVUdUFnY0puSXY0NUZBK1A5by9u?=
 =?utf-8?B?dUZqcXRwVU1Hei9NdHNWajlndTZlZW9BM2haSXZrTlRzdE0vN0FVMWcvWjdS?=
 =?utf-8?B?Uiszd3ljUEN0a1NnajM3TU9NLytiTmJRZ1hidG90WHNFOGpoRDR4OURsRmJ1?=
 =?utf-8?B?SWYwcXVndDErWFBHQU00T0Z3bU9XUFpPR3IrVVBBUm9yaXg0d1JpUzUra0g0?=
 =?utf-8?B?ZUhMOVFxYllRcnZBakNpMURTWmJPWFljTGxxWDhvcDdGeUlFWFNVVU1Cbnpl?=
 =?utf-8?B?aEdnUDZGQUx6anZTb3NwR0prVGxLazBvbFZadFFCZk9VTkFQQVorUGxPS1lI?=
 =?utf-8?B?WkdLY1Awc2Nvd2xUS0x2OWFkQURzcTRmWXFTRCtYQjYxeGVQSWhMTHpuMC9R?=
 =?utf-8?B?eFFlcncyMk12M1BYbVpnWDkyTVBaOENVK0w3aUZwVnV5Slcwd0J4T2cvZCsz?=
 =?utf-8?B?aWJVWDJGTTNvMFlmNmNjV2lxOGpVVkxSNUM5Z2ZUTWlLTktZMEgxWXczRW9O?=
 =?utf-8?B?N29WOHYrN3B6NVM3NlhGc2F4T08vK3phVDZob2N3NHJ3bng1Y1Jic3ZMZTZx?=
 =?utf-8?B?aHE4ZjY5ejNjeUZZRjV0ckJ0djNIa3dlNjY0T3Y5ZWp3KzJVRkNXSzRyYTNX?=
 =?utf-8?B?VDhKNUlUNTVRUnRGQUVBaXZ4R2NSQXVFNFRPeWRoSjJ1VlNuUTFxVElLZ3B0?=
 =?utf-8?B?VFNSTjBiWWJFSHVkcTkvZFVtMUNhcFRDQjRVZm5rNHhNWlJReGVJeC9PclZF?=
 =?utf-8?B?RGNFdkVpSDhaZUpySVJoWHpTdGh4cnVKdk5JRE5QamN3QzY3bi8zakRQWkVn?=
 =?utf-8?B?UUhOOW02b3NuWDE5ZHhycTlMWWl2L2tYaXBTL2VtRFR6SGo5RjVYQldFTCs4?=
 =?utf-8?B?U1lEc2x4NC9SdmVKZ1cvaHF0MWk5WXJoN1NuZEZDY3o0ekFPYWJRVjhwU255?=
 =?utf-8?B?K1JmdzB0SG01N3JCQnZWNEs3aEd0UDJITEdyM1FTcEplMXkyeDZaTDg4eG1w?=
 =?utf-8?B?Q1NraW1FOGdyb3NGMVhEZWlmNlQ0UmtUV1JoRmNVNFoyVDJyR2ZhWFRoa2kx?=
 =?utf-8?B?SXAxK0pDRFhYV29IcUt5dU1sZU1XQjdSWnBuR09uTzVqUDRwWkJ2eWU4UUYy?=
 =?utf-8?B?SU1vK0lqRkk2SkdaWVgwL29HanRhaUZiRGxkUUljbGpyY1M0ZDA5SXd0VVZ4?=
 =?utf-8?B?Q1ZOQThGQ0g1YXJreVhTZ1BLUzliQWh4czhFZW1qNkpzeUZKWUlXakJCT2VK?=
 =?utf-8?B?WUJqWVJIYTFoa1J5VllsM2hlMmpIQnhFVVhiSGRocnhDM01TV3lLS0xBelYz?=
 =?utf-8?B?eHRTRk8rQ3lpNWh5NHVjcllWMDd3MEVOTVJHaE1OakkzMzZ5UGZGNlpaYVFL?=
 =?utf-8?B?cWxPZ0pRWUtJb0o2d1ZVR2JEZVJOY1RUb1RkQ1dMd2tuQTB6ZVpHN2E5K1Vu?=
 =?utf-8?B?Um9DRktIcW5ENGVNRUxQUXBDcWtOMnVGalB4eFZaUWlmQnRQZVBOcEtuVVhn?=
 =?utf-8?Q?BKlsEyiPwqk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmdpN05kZ0VoZVF1US9JdXpDaVJ3aW10cW1YZURjZmtScDdLTWZzREJOK3Qv?=
 =?utf-8?B?TEwzSENUZDM5ZHg4d2tJN1RTaWJmN3BpbzluRENGSVEvZXhURUdGS3d6REYw?=
 =?utf-8?B?ZFZXZWR6L0d0ay9rbkdVUTZnRGhXNHFPS3VHU2ZpK0h2WGxqVlgrL2txMHhK?=
 =?utf-8?B?TDhjUkpjZlhvMTVOdHBqNlJFZlVFOFFKNUV5ZHhhMGgrRFR1WG5WNDRYSUV6?=
 =?utf-8?B?RmIrVEY2cWpUOU9idjRtTURxakxSelN2cVJHb292TVhsRU9HYVZhRFlmblZs?=
 =?utf-8?B?Umo4NzV6Y2w4aUNWYXI1ZVFuYkhGUXVERWZOWlp2L3pJbTFPT0dQejJ3b3NV?=
 =?utf-8?B?VWZZUU44cUdXSlZQZDVRVVRvTmVYTkJJNmVJbUQ5QzBOaTQvTG9aUHRvWlJT?=
 =?utf-8?B?SVpIL0VwaW42UXhrdUJITDVJWVgrUU9TWlkrN0N6VXpRazF1cEV3TGlneWk2?=
 =?utf-8?B?V21DaTFVUG1XT280UHc1WjlnL2VrSlY1S3JVN1d2bFg1UHhUWFU2U2JSMnRa?=
 =?utf-8?B?MnVCUWE5Tm5hVlBIczd1UU5WYlJiV1ZvZGFmckxQaVVJRll5M05EclU1bytw?=
 =?utf-8?B?M2N0WW05d2ZLcTh5b2FMaDNHQXFkekhlcVFuZnl2ZTFRSENLWFNldXQ2VnRE?=
 =?utf-8?B?cEFZQXh5LzlBazdwSm1WdkRtRmxZbEhTbFh0M2ZqVG1ySU81L0JQdk04VXV2?=
 =?utf-8?B?bTI5dm55OTQ2OFdxYW9vTUtPMDZoOWY1VGpSZ2x5THlLbnFGMmE4SmhYUnFO?=
 =?utf-8?B?UUlYVHNrNW5FVkNWMzdSNWE1WG0yWkVCaXNmZnZLakJkN3F2UDdyd0xNVFJK?=
 =?utf-8?B?SEtVQUxsSzJhSTlSb0VjUnR3aUxwNHFoV3pLYUJ4czhtdkJhMzJQakVjeUlU?=
 =?utf-8?B?UzB0bFJ5cU81dWpWaHlWdW1jcGY3emVmUUV6Vld4cDhOSVFPOWJFcjB1eTNF?=
 =?utf-8?B?Q3labmU0TE0rSHUwa3M1SlN3RkhicGQ1MzQ3RHNlTDZwZTlEQ2NlelVIQXdy?=
 =?utf-8?B?K1JuaW1VeVdHZURwYzNvN3oyamhUV29DaXBCZVExL2ZPT3BHWXR2WGNiODVP?=
 =?utf-8?B?UVA1ZmFrVEVKc2daRVFMZWU1NkpXOUh0UktCWmQ2R0lxYk5TZGpsMU5HWm1x?=
 =?utf-8?B?aGhoWnlMU1huT3pOcmRVN1ByZHZXbmQ0YlJZaFM4NzFpcnJSenFZQWJrSTRG?=
 =?utf-8?B?aGpDV2dTN2NhU2d0WjBEQ0FJS0pqT01pZXVnMUFHRXFsOTFORmFVVnJIemQ0?=
 =?utf-8?B?TjJRZDRXYS9DUHY3M2RZaEUraDRuenJ4VGcwOHpGazBMbGNYNERsM3NoNXZj?=
 =?utf-8?B?cnNrMkd2M045VDEwaFF0czFsZ0hKQnFETmRzTmM1T05BUWxEZWJoRkQzbERN?=
 =?utf-8?B?L1oxcFNMVElTS3lFeml5ZUl3NUJuRSt1VFdZeGxBVzFJQkd4LytDN0YwN05E?=
 =?utf-8?B?QkNmeDNOa2hEVFp5NFhPd2k1NkNkVG5WZE8zTG8yRE9pOUl3THltVlhqZVRk?=
 =?utf-8?B?TEp2NG8wL0cwOGlsQk1rWk85b08yVUhJUWhZQUxjaXlzZHhnb2M1djc4R0Jz?=
 =?utf-8?B?UXQwanAvcnRYTytSRFhudGljOUE1MUlJVW1zdGVxdkE1YjlSeWdrQ1VlOVQ2?=
 =?utf-8?B?MERzWWRWM2o0cDZNb2ZtS3pBUHNLV3JFeUxYSjVUVE1zSFFia0xIWXIvVlVv?=
 =?utf-8?B?VE1NdmxIanR6QXpuUVBhZ0xtNlF5TjYvZyt3eS9tRiszZ2tpeCtrTDIwWXEx?=
 =?utf-8?B?S0ZvVEtDcHpyaHdLUHNNUjBqTHZHb2lXSXBzaVpZMWVFM2NWT3pDR00vbkVm?=
 =?utf-8?B?S1llVldjcHlsRHc0NXBwUTNYYlhwSUhMZXlncG40c3AraG5JSUdYWjZ2YkFu?=
 =?utf-8?B?dHRtV2JYSlB0WUFNTkh6NkZQZlFNTVNrbk52UzlDY2NuNEViL3c3YzBaWUZy?=
 =?utf-8?B?cEhPY2xIeW85UUQxVVNhTlZtdzZ0eGxlb2VsTXlNRElKNVdVaGNISTdGYi9i?=
 =?utf-8?B?ZjJieGN5dlV6MTNkZERsTjZMVzAxS1pXcDRzWTlkQ242MW40V1dIa3lRYVJr?=
 =?utf-8?B?V25yeTlrYUxBUy9ucTVZYXBkS3ZtQVhvdWdLVTRNSVIrdzNjZk11eFNrZVgx?=
 =?utf-8?Q?qfLaoJURaKIbjQs5N0QMoI5pa?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efe04da-6f95-492a-aa79-08dd96b00806
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 08:34:55.1223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDNjXSBVNyi5I9wrEr8jHQIs3d6x3KxM+mKnyF/4QNAUAXfHRJVuu+0PxPbVqc/txvE0pBh1Yrmchjap1cEldQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB8033

From: Jan Kiszka <jan.kiszka@siemens.com>

When statically linking, we do not have a .eh_frame_hdr section. If we
then call backtrace before frame_dummy was invoked during late
constructions, we abort. Address that by moving the backtrace warm-up
call into a separate constructor that is armed earlier by
install_sigshadow, or call it later directly if install_sigshadow is
running after the construction phase.

Reported-by: Haiyang He <aspirestro@163.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - use explicit lowest constructor prio to make it clearer that we need
   to be last

 lib/cobalt/sigshadow.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/lib/cobalt/sigshadow.c b/lib/cobalt/sigshadow.c
index 092cadb08a..10736b113f 100644
--- a/lib/cobalt/sigshadow.c
+++ b/lib/cobalt/sigshadow.c
@@ -33,6 +33,9 @@ static inline int backtrace(void **buffer, int size)
 
 static struct sigaction sigshadow_action_orig;
 
+static bool request_backtrace_init;
+static bool past_constructors;
+
 /*
  * The following handler is part of the inner user-interface: should
  * remain extern.
@@ -96,19 +99,35 @@ static void sigshadow_handler(int sig, siginfo_t *si, void *ctxt)
 	pthread_sigmask(SIG_SETMASK, &saved_sigset, NULL);
 }
 
-static void install_sigshadow(void)
+/*
+ * Kickstart backtrace() so that it may call malloc() from a safe context right
+ * now, not later on from the sigshadow handler.
+ *
+ * We can only trigger this after main() started or very late during
+ * construction because, when statically linked, frame_dummy in ctrstuff must
+ * have run already.
+ */
+static void __attribute__((constructor(65535))) trigger_backtrace(void)
 {
 	void *dummy[SIGSHADOW_BACKTRACE_DEPTH];
+
+	if (request_backtrace_init)
+		backtrace(dummy, SIGSHADOW_BACKTRACE_DEPTH);
+
+	past_constructors = true;
+	/* ensure visibility of past_constructors after init phase */
+	smp_mb();
+}
+
+static void install_sigshadow(void)
+{
 	struct sigaction new_sigshadow_action;
 	sigset_t saved_sigset;
 	sigset_t mask_sigset;
 
-	/*
-	 * Kickstart backtrace() so that it may call malloc() from a
-	 * safe context right now, not later on from the sigshadow
-	 * handler.
-	 */
-	backtrace(dummy, SIGSHADOW_BACKTRACE_DEPTH);
+	request_backtrace_init = true;
+	if (past_constructors)
+		trigger_backtrace();
 
 	sigemptyset(&mask_sigset);
 	sigaddset(&mask_sigset, SIGSHADOW);
-- 
2.43.0
