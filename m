Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1C2DECBA
	for <xenomai@lists.linux.dev>; Tue, 27 Jan 2026 06:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769494518; cv=fail; b=HSZcLiXUvvjuWhqRoOZTfs/tDoMDqWwmT+BBX0qaGOTySAWoWpXllwFYWWo0lqQeRg2ZlNLDx/NZSv5pHMVy+ppJjYkdVbDBREsIrrVfjVnB04oeOlC01zSBZ3pIF1hHzhJ6BhkYZGTW1bBwU/emKxdSB0OEzMeRW+CY4yndcLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769494518; c=relaxed/simple;
	bh=RD6sopO06GeOZ7xQv6XKL5Tl5MQQTs6G/y+wKMPkUbY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gnK5wh0gpniKJWEOm6XK8hiMpNEbal3C5EiCsOSMuyaCgXWt7nWGJc43xH6mXN+vV/UK8bCAIs1z9Y6GGSAkhCjKz53LlHz1WLTI612EdG94fBWhrgJaSZ0RdeHltMfD4a4XNctxhAt39Nk61s+V3GKZO3s2FiKxZ2D8f61DXZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mbB2HVNX; arc=fail smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mbB2HVNX"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id B43A643EBA
	for <xenomai@lists.linux.dev>; Tue, 27 Jan 2026 06:15:13 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 50BA2460BB2
	for <xenomai@xenomai.org>; Tue, 27 Jan 2026 07:15:13 +0100 (CET)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=mbB2HVNX;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c20f::7 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQZTtedc5L1+gjM/1KWB6gkgguHC8AkeIez8OiBJ5uXNp6+FwcuJFU2+/rZ/grDV7bzlNqnU82lN6gjpHCP5J+SnFlaG1MNYYqTfcnYtdIMHbyAQ391X/On19/jHiSWBnd5l5/RJzbbiCX2/PFW6EasGQzUimj7xhOJVdwpgN7gCV4qN3Vj+M/xov6tV3KPCC0CfGu1X391MlhdSW6cPkSQMXHTPnPESVYa11m3B0kNpPEtIVpjkMdN43biAvsPTPDNO0o4TgocJHHSQzRwQn80XdrvZDw4csC/83SZCmXDfl5yrNHKIx3LbDIKExcr9WotV5o1ANVRTfdCUwTHMWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSlgJXHD7t0/JMhQYwnI4zK7REOCnTXQQT3oqex+3Lc=;
 b=tsWktPOWsimD3Pp+Z5IxlhBKMoEAlN/dIVWN2NCZsysdxsqDCt+yfGGGD9mYdeZkIo618eAwvmui3T4ZhLk1nGAEv6ss6hFErfaqiCXr6Fxg2K5IIbduoYynnZ+xNB+QWmV9M6LHrShUPXiHyakPJyAKYkDMwE3NKfFYsITSY4nkshU6h/h4bZSK4d4trpT419He03IfJ5fJUcffuL0ZGfhyAk2RN585r+y3w82BjMm5X3P++SbMeHG7iOej6piNRwQohcZH47azVOluMxH1AR+BDk86unj+yYDzCM6y6+eL+rT8I5tLpgc5v6ma6kqnS1qp4+hn580k2EsutNnpJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSlgJXHD7t0/JMhQYwnI4zK7REOCnTXQQT3oqex+3Lc=;
 b=mbB2HVNXXtYcvN036JOZupOFu58wUcYgKooHYZFZDum1a3tNb+OYM0jywclLFzTnEXq6BcOcihKntKCwmZQS2vP5Fpdgpug2QK9rgCeEn7vwP2G3gRRGKzuZO1yNlrLbzG7ckMcxYFKMlkEokPZKG9D1ECTdOM+2A1VTCPZHGUgliW8A57kr9cqSWgBZYBpN3QQ88Gzaq8G6XLCyg7y+YoPMgK52PTDBpWjl27tHKquKqtDZWMDo8eRC1jynPGCs424YKRAbaj5FCs2seahW5/soENYmXSSNfhzw3ZCUFgL5rZtqOqR6MOCMe2VvMW10ugmVZmVZ0gAl+spBAvD73w==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3976.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:140::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 27 Jan
 2026 06:15:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 06:15:09 +0000
Message-ID: <361f7fde-d60c-4b41-9fa5-81755352f5dd@siemens.com>
Date: Tue, 27 Jan 2026 07:15:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Allow changing CPU affinity of RT kernel tasks
To: Richard Weinberger <richard@sigma-star.at>,
 Richard Weinberger <richard@nod.at>, xenomai@xenomai.org,
 upstream+xenomai@sigma-star.at
References: <20260126125701.21000-1-richard@nod.at>
 <3016173.h6DGQjDypG@nailgun>
 <32b32829-18eb-47a2-8c7b-77e6f6733070@siemens.com>
 <8326375.4nMDBE73YP@nailgun>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <8326375.4nMDBE73YP@nailgun>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3976:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ed5d7c-0e8c-47c7-a767-08de5d6b6c90
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXUwNU50bGZYOUZUdWlKQWZYOWcxUEZON1JPVlVVUWl6S3ZCakNqTEV3dnFr?=
 =?utf-8?B?VlBzSGg5ZWFUeDlscFd5TkZHczRnMVNXbUFEakY2RlIrZHY5cGlEaVZscDhn?=
 =?utf-8?B?SlpyN2RzdzlPeDN4cURyQVZuWis0Rm5OVS9KRVlEK3BJTzlFZVdBL2tNUTNG?=
 =?utf-8?B?bjFLTlV5M0ZDNGRGWTRkc1R0RmtVS2VnV2hnVzQ3WWlyREZ0T1VIeVgyMmd2?=
 =?utf-8?B?MTlhK2NZY2VxRDJLTlh1NkRmbm5uaUlBSTNDZ1V4bEIyQVF3SzFWSDZXc2pY?=
 =?utf-8?B?OFZHN2s1ajdFaWJjQks2RnVMOTlxK3Vkc2cralZrR0ZXaVlQVmNKTmx4TWRR?=
 =?utf-8?B?UFVkejA1V01vNWRRdzUwVEJUdnEzQWxYU1lyNUs0bk51Z2o1YURUdWR1RUkv?=
 =?utf-8?B?bS94WFJGOFc4dmJ3MjJobXhVNVhBZmp0QjdyK09YamxoVEhFR21GbkZKb3pI?=
 =?utf-8?B?NUNIdXBBWDlSeDdsdXFoTTFRUVlxRExyS242R2pTOXJwMkZFdkdYUG5lTHNX?=
 =?utf-8?B?TlhaZUs5cHZFOVg1bDZVaUw4ay9NWERaU3NiVEladFlidGI0MXk0OFhjVGR4?=
 =?utf-8?B?c3dvbVpncjJhV2h0THlQWTA1d0RaTTJpcnkxaXg5SkdIam1TZTc2SEppa1Y3?=
 =?utf-8?B?MzNoZzJYV3lqN3gvck5VSHR3ejhBdC9QVnA0eE8yc1M5OWswbW5xQm9zTjJj?=
 =?utf-8?B?WUJMU1FYTzFsSzUzTERkYnRkdGxMOFVKbEN6TGVpVnVvcGlFcys0S1ZyMXow?=
 =?utf-8?B?WWRUUGhkRDlodUVqWk9LMjl0YUR4c3RSQjVBeVRiM01pa0JhQU4rNU1UaGV3?=
 =?utf-8?B?Y1RZNHM3V2JlekdKVlR3RG5OYU53M00wM1Z6WUZjWmtRSWJaZHV2R3FqMUxY?=
 =?utf-8?B?OVhtdExURThwSjE0NWZzWXpzK0RNMVB1cWJrd2psWEpIcGtSOXFxVUNZSS9t?=
 =?utf-8?B?OGtpcnpwRHdCaEpiQ3NUVm82bWE3ZGxCTk9QRUl0cjFSMm9ua0lOaVIyNEox?=
 =?utf-8?B?elVwSXp2R2U4Zm9NWE95VCtQcWFXZ1JwdXlMWHlZTGY5ZG1xZ0t1Vjh6cFNZ?=
 =?utf-8?B?OVA0eUJhR0hIYk5UTERTNmhEK1lXQ2hDRFNwRjV3YWFWQmN6b3pFZjVaTDBS?=
 =?utf-8?B?OFVxU1ZDU3R6N1hpWjB4K3hhQkxpdUFMMkp0UUE5K1FlVkZ0NEZNSjJBSHg5?=
 =?utf-8?B?c2RWdWczTk5EUXB0Y0dWc0RHRXNwdTBwRm82Q3o4SE0yUGtWdndPUmwrbUdz?=
 =?utf-8?B?OHQyQkxmdjBwQldMRVJPVzgyZUp6QVV6VHZrbDBmTHVEei9RSjUvUEZCRHJv?=
 =?utf-8?B?T29oZjNROEkvcFJPb3RSVzBmR3pONnBSbDZDSGVlNjhpVWdEdW5zUXRLR2Ji?=
 =?utf-8?B?ckRDNFcxRlk5UHJFRitIVkJ2eUVpSndla25oNkh3WUNDTHNyVVIwN25CUk1W?=
 =?utf-8?B?VWVTLy9ReUlXYk9BQlFnL3g5T3ROcVROZUd3Snp3c0VSR3dma0liTUsycjB4?=
 =?utf-8?B?RG5YRGpaRm9ybnhuNHVBbFEyMXhkdXdxblgzNDVwMkczbnlveUdwZThNV2dS?=
 =?utf-8?B?TzEyZHpEWFRpeGFOdURGbVR5MGtuZ3NzM2FZR0tYcnl4a3VnZC8yYkZSWTlt?=
 =?utf-8?B?dW1mSldIUzhZdkp0QmxYSEpsRitUN2ZjVG5nb04rWmJGZlRwZU50ZGpYU3Zx?=
 =?utf-8?B?TFBzMndvWkNyZjJZek5iV0tLNVZDTC8yZGNHcnZnOTBuMURsbTJDQ0V6Y0M1?=
 =?utf-8?B?RWJhTThUOWlRWHZ5bHpialZxNURwcTZRQSttVWhqTG5jZXlPRWg2T0pxZzdw?=
 =?utf-8?B?RmMrL3FJK0YvM0daVzhXdXp6Y1BRZmFwbFlXL0w1a3JNN0MyYm15dUZ2RHMr?=
 =?utf-8?B?ajBaTkhYWnVQbCtVNE1sQXIyRkNmeUV3WmE2dU1RSy9sSC9rWkQ2RVVpVHNu?=
 =?utf-8?B?K1YxSWJVVGJFd245WkNzQ0F0aE5Lc0p1UXVLMndGZGxBbEgrVjE4dnViekJG?=
 =?utf-8?B?RkVsMThad2NNSERVaCtnUjRPZUJpMzY3S1JCdExKK2I4dGcyUlZ5K2NuenRo?=
 =?utf-8?B?Ym9ETFJKYWxkVzVoL2lkaEhRSFhOekwrZ2grWFVJZFVNVFZ5eWNIQVN3blc5?=
 =?utf-8?Q?22t8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OERLbU12bzBMUzdmOEI0dkVDMkdJNjN1WDhoN3N2Z0RDR29sdjZMaWx0K2c1?=
 =?utf-8?B?aDJkbUJSbjBHR2YyYjVKVXlheXBZLzBaMWN4UzA4eE1PM0xoY1VaRVZQcGY2?=
 =?utf-8?B?aWpZVG5PMlFuRXVwdEI2YjZnUUQxekM3bURRenBnNDd1a1VjbGFLdHVqTmJj?=
 =?utf-8?B?L0VlNU5xNkU5Q0wzV3RtUEVkWUl4Vnh0VC82NmZuTjF4STk1YnNxa0J5SFhp?=
 =?utf-8?B?eEZKMHM1Mkl0MllJYVh2UE5NVDkybHJlUTFhS1VESmNLL2pRUGcyU0NlQm1z?=
 =?utf-8?B?aSsxTFRScDdqNGtidkJ6M0Zmdng2elVTZFNkNy84cmJIVEYvdHVFNk1jUWlD?=
 =?utf-8?B?Z1l1STBVSGtIM2RNUkRyajNMd2hJbHFVcEZMelhseEtVOWpRRWt5cjQxSW9x?=
 =?utf-8?B?UUNIOWxrVEc5SjFuZGlDdmxrZUVsMitsbUN5TU1nVUhuM1cwSFVKR2lla2Vm?=
 =?utf-8?B?Ui9LS0N2alVSK0l2cUUzNlE3Z05hOFZteDgzRjh6RXBIMzJ0ZXd2VVUrNllE?=
 =?utf-8?B?QnJDVnRodTBUUXJGOU9leGJjMmRsSmxHUFhCcTBHMDhDdVpQemc0WEZaUTNO?=
 =?utf-8?B?MXVpcjNaYmpQMHM2S1U0ek5Ccmk2YlZ1b3VyZFJuZ2lSa2dKV0F6YmE3QW9S?=
 =?utf-8?B?SGdkWndMY01jOGd6dWNNb0Q0QXlOQjRtRk1TZVJpcXVDYklrdFFaRjc2OGZF?=
 =?utf-8?B?Z3A4a3g2NDJET0NDVUZkRmJjQ1MzSmo1U2k2V0hhTEhvS1p0T3dWYnJnZzNT?=
 =?utf-8?B?N0JyWE1wdmtzblhYeGZ6YWF5NjhJUVVjWUxpaG9kMzFOZEtwOHpuTGFqQTRN?=
 =?utf-8?B?emQwV0FQYXdPcCs0S2Zjak1FMFRJSERKd3JxQVBqRGhOa1d1ZU9VcXNDeG5L?=
 =?utf-8?B?ZHJ6SGJraDFCL0RveU9pa1ZyMzlveHp2N2J6a2NKaWtvcWtwUWtDVXdMZ3kw?=
 =?utf-8?B?dVRLOGlJTDB6bWtzNGxxZStaTlkvWS9RZjBzOXMzZlkvTG55ZFZKcEp5YlpM?=
 =?utf-8?B?NXkxZklMSWdoYnJZQ0JiN0RFc1ZFN3ljSTVTUFh4RHJPT1IyR0l3RHNqSHlY?=
 =?utf-8?B?cW9NUDhCWHh0Ulhpa29UVkZoZDd2aE4wUjloRTBJQURUT2JoQ1g0TlNDcDV2?=
 =?utf-8?B?UnFvMmpIOTRzTHBJS3h0bEFiSHlVV0dRQkpVMXg4MlM3VWNjV2VsaGhVaUVY?=
 =?utf-8?B?R0t0a0xlOG5jSlV2dVBJanRGOWNRWm9TOFBpZ24zbjVrSTlWaTFyUzNldTBi?=
 =?utf-8?B?b0c1VEdqWE5ibHhndUp5S2lhUXZnZmkrd3Y0eXkrcmlLeHhvNVA0UTdKbVpI?=
 =?utf-8?B?MzFZZlhHWVNOZlBsUVA4T0prQ0JhY0xMcEhzeVk1eEJJOUtjYUVaeGN5Ni94?=
 =?utf-8?B?L0Rva0Z0NXhIdEJLYWlyYlgyKzJGd2FvN3RBUzhmWUE1eFFmK2w3TVJRTHA3?=
 =?utf-8?B?SkhIcTYyL0FwMnZOckR6YS9oVUlGVjI4d04xenRSTVdNY0RwTzJOdWpxenVs?=
 =?utf-8?B?eHZIZ3k3a2hiSlhrWHo5Y2RhQ0tyOGxoeFR5TXVHVG0xRkdPcHpVMGVpYy9O?=
 =?utf-8?B?bmFDSStPNzEzVGZSSkVSZTkzbkszRUtMLzMvazFmdS9EUzdwVlV1MnhuZitj?=
 =?utf-8?B?NFZLcjVYMjRQdm9rMHVXbzBHWlIyTWxNVGFtenNtZEt0UzVqS3A2NktIbUls?=
 =?utf-8?B?VjdhbjB5Y0NJMUR3WTd5enZCa1pnRURVT1pGblNXZ2lMZXdnOFpEeEFxSWh0?=
 =?utf-8?B?WXNjaWlISTFCTUNQMFhnNElOcHhSV3o3YXJvOVV5QVk0MndwYXZ0dnczdVpI?=
 =?utf-8?B?VWpMSmIzbkRYdjNtbTk1R2tMZnFwZnpPYkZ6ZlpSeHl0RHJnWmYveUNTRkFR?=
 =?utf-8?B?c0RBMFl4MG5BVW5uVXJnV1lEQ2VGSU9FL3dRaS9obTZ5V1REVEpwYVdmS0hr?=
 =?utf-8?B?TG1RSzJLVE9PMW5xRm9OcmpnK2RJazJjbC9RUnJkanlPOVUxUjFrUzYvMWhn?=
 =?utf-8?B?R2NKcEZHUE9PZEUxOVRFOGlqcFJxTlVsbHhKSUtucTB5bHlqQ3BUSjVLa3Vj?=
 =?utf-8?B?dmZxaWhKQUpuVDhlM0ZPbVdiVnNBbkVtb1h1V21Ec2FQdVNFMU9TcmhNaXpH?=
 =?utf-8?B?WDNWcnBHRkZJUUl6K21JcWlHVnBpb3J0WU5HWjRFSkpUVmpLWWRHaS92c3kx?=
 =?utf-8?B?UTBxdGV3Tnd2WUd4YXUzUnFsMU5YdXlGeUpnWkpIQVNKbkhVNWJjVkdBbjVh?=
 =?utf-8?B?MWVlSnlZZXhERlBZaXNzZ1V5R3JlRlppVXNHdTl2d3FQZk5oRW8vbnVKYlMv?=
 =?utf-8?B?cTl3blZtWGM0U2g0c1NBQUpkbWNaWStDcEgrV2pFZ1lML1poV2hGdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ed5d7c-0e8c-47c7-a767-08de5d6b6c90
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 06:15:09.8572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQOUKoyy1G0Ko4jm6OeJjdiuNZCHeSu1U0Y568gKn5KIKg11i4vY0eYbTvbIgRnaZT2gw1932UMgjJht7PftLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3976
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheeljeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffgfuffvfhfhjggtgfggsehtkeertddtvdejnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnheptdekudfhvdelhfefvedvtdetheegfefhgfejjeehhfdugeegfeekgeejvdeiledtnecukfhppedvudejrdejtddrudejkedrvddutddpvdeitdefmedutdgrieemvddtsgemheekkeemmeduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvddutddphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdpqhhiugepueegfeetieegfefgueetpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

On 26.01.26 23:05, Richard Weinberger wrote:
> On Montag, 26. Jänner 2026 17:26 Jan Kiszka wrote:
>> On 26.01.26 16:11, Richard Weinberger wrote:
>>> On Montag, 26. Jänner 2026 15:28 'Jan Kiszka' via upstream wrote:
>>>> This is one issue with setting the affinity "from outside",
>>>> asynchronously. The other is that it will always imply a migration of
>>>> the kernel task, thus a phase of non-RT. If someone forgets about this
>>>> and sets the affinity at the wrong time, it can ruin RT workloads.
>>>
>>> I assumed this is known and expected since changing the CPU affinity of userspace
>>> tasks as the same implications.
>>>
>>
>> Likely true. EINTR can be a topic with some calls there as well, and
>> some applications may just bail out (or because of trapping SIGDEBUG).
> 
> Yes. I did more investigation. sched_setaffinity() causes always two domain
> switches but cobalt syscalls get restarted automatically due to SA_RESTART
> of the SIGSHADOW handler.
> 
>>>> This tuning gap for RTDM task is rather old. I was already considering
>>>> to add an explicit affinity API to RTDM to set this from the driver.
>>>> That would allow to set the affinity early, right after task creation
>>>> and before the driver signals it is ready. Risk of such an interface is
>>>> that people start to hard-code the affinity into the drivers, rather
>>>> than making it configurable to userspace.
>>>
>>> Well, the goal of my patch is improving the situation to match userspace
>>> semantics.
>>> People expect that sched_setaffinity() kinda works.
>>
>> At least "taskset" (script-based tuning) - we do not have an API for
>> userspace to retrieve the PID of a RTDM task. Yeah, there is some truth
>> in this.
> 
> For scripts /proc/xenomai/sched/stat should work just fine.
> In my tests I'm always using it together with taskset.
> 
> Do you have a new cobalt syscall in mind to query the RTDM pid?
>  

RTDM tasks are no generic objects for userspace, thus such a syscall
cannot exist with the given APIs.

>> So we have the following issues still to consider when adding this
>> capability:
>>
>>  - Driver supporting external tuning need to handle EINTR from
>>    relevant blocking calls - others will fail, and that is fine.
> 
> The in-tree drivers needs only minimal changes from what I can tell.
> 
>>  - Affinity tuning by userspace should be done while the kernel thread
>>    is (still) "idle" - identifying this remains driver-specific. Maybe
>>    document this in rtdm_task_init?
> 
> Yes, I'll happily document this.
> 
>>  - Should we also provide a RTDM API that maps an RTDM task on
>>    set_cpus_allowed* or at least officially provide the task_struct for
>>    some rtdm_task_t? rtdm_task_t is opaque, xnthread_host_task is
>>    internal from RTDM-perspective.
> 
> What use cases do you have in mind?

If a driver creates a thread associated to specific IRQs and it already
uses rtdm_irq_set_affinity, based on userspace provided masks, then it
could self-adjust the thread affinity.

> 
> Beside of that, I have also a patch in the pipline which adds a new parameter
> to rtdm_task_init() to specify the target CPU instead of CPU_MASK_ALL.

...or that. I guess that should cover the above case (dynamic thread
creation on behalf of userspace with upfront known affinity).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
