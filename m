Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A5F278751
	for <xenomai@lists.linux.dev>; Tue,  6 May 2025 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746544015; cv=fail; b=sDrYd8Uldb7diLAhc5QyF42KfphcISzqWo/8/tTvBQe5dQo1zZV+fCBJ/hDKz96h/ITtxEi0nWciOsSt4WdrNuM9TGxeWdZvDiHRTXqDx06yJSBWx5/wWJ/jzUhmPjEqPqisjPBSNPy4MfLM6QkVbsztmw3V4lggoDl1pX2thVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746544015; c=relaxed/simple;
	bh=oGlB/wL9BczF7Y90zWRAGq994C5ZyUsQexzHZ4Cu0MI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Re55Jr7vdvD2OvabfBEQElisjCokAHfYDL4fvS6zTbxcRPAE65Pbnlo2Ps69VLKCxY2gH1XSNuAxtBHSG4qgeLSfISLUS719ICjN1Ib5pd77VKE2nDE1pLwz6dC5pzgUioGvwL9b53IS/KRQCQsAnVGtuLj+d2f8xdaFYDbe6nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WJmB6JVL; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WJmB6JVL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rti9Aqgshz/w16pogwuSZ3hTnucKqkozlawDBmHGMGGQMDkbfnovwjcAUvahvAcYhq9qWHiD5TT+7ZE4G7wxCn2anxFODtyAxaVDp77NJGGdFDHTWauuaSGNziIWBGW1LhhtklLzkVvHQo0lJwoVibqgbHu6t/M0qFJ4M29tDO9kSij13Zt3VfJvUj5+rap0G6GkCz9Ts1ZbChKZq2V2jNzLHXfX9oJolZgefupUcc9SFgBPaSvEBMSWt2CLVAkGZ296gPoe7trE9fgTv1IXEVCKLK+UKqbUlGME3nm/4ogxhYkEMWkp7hSFSzIG8yUnXX3u1BkmCVsotxhF7kGYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7GDvtslbu6esmMgsZ8koa+x9NMfbAjwefu2rzWPspU=;
 b=Es2gJA3aIebTWiZ9Mj77PjPRATQYP/m+jVxEqA580eXF8enmga4dcgSmNugx1ESeK9lsEqGgFSG1ZjiPw3N5qMBebm0fy8AioBGg/XjHNQ9QzruW9sCqodjrHubjEhgD4LwnLFZqvsDjs62/SjafHK/OVLqA5XA4sE40odTHLuV9V8NTY32zHA4voHGZ6W150mfe16i9F9E7Ue+Wh2+Rw3fwQBKYS8TPITFpMykgoCU8bu74AE5Gn8AHO9tDWrTboAMVzCcZ0j9fyF+roZL49HJ00i8X2WMVkYMyLbEBOf6cPHcS0ft5WJM0X08EaRmwQm/saZpCY6Vqwlcl5W1RhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7GDvtslbu6esmMgsZ8koa+x9NMfbAjwefu2rzWPspU=;
 b=WJmB6JVLqxjPnVMDJbAEkuozmGDammdRdDWIzBxDZfG0ZZVd1uNYA6QstrsXHL8zdDvPJrPQUGYZemGyXnnzFtu6ZARa8dg9J+HDvuNhhdrSMthqp1OKl2J12aQneBRPmSlO4KU1szH/S85malNdjHGncl0WUYPugwwt454MKpp4L+JgkGOn+q6MEO9dZJ2L8EFR6fY5RJ/atVN868poB0QDR0CdEbIWYogEgaQ/O53SkmTPpQe9VjNuZLfpju8tcBEHZL6k+02SNghXL99xObWpHHCiCjcg090KR3552B7GJgY9UfeDk7itRHWL1/W8BHN4MWlD2sud6X20F1yn5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8169.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Tue, 6 May
 2025 15:06:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 15:06:50 +0000
Message-ID: <6196f5a3-472b-4863-8559-91c2c24a7d79@siemens.com>
Date: Tue, 6 May 2025 17:06:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Doc: Add fallback path for asciidoc-icons to fix install
 error
To: Haiyang He <aspirestro@163.com>
Cc: xenomai@lists.linux.dev
References: <20250506140443.2492075-1-aspirestro@163.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250506140443.2492075-1-aspirestro@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: acfc79a0-3f57-47ab-3cff-08dd8cafa0a6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkwxQVFzM3l5Sjh0dFNpbWRUbkdvU0lBOE9nVm5uNkg0QXNSM3ZoOGpWR05V?=
 =?utf-8?B?aHBYMW1HNjBYUG1tU2ZEYWlaYVdHQytWenl3c2lTK1QyQUZmTmhvbHIyVTJX?=
 =?utf-8?B?OEVmWC9obHIvWUhMTXNMUlY3OHV6ZFBrS2lwUGgzNkdBb3RVUmNpYVRKSHZ2?=
 =?utf-8?B?KzdYUm5WOVlMMXhsU0JZaGIwalpBUFRUQnRxaEpDcTZMNU5rdGNSS3NtUTVi?=
 =?utf-8?B?T2Nja1JWYncraDhDS3d3ZVF4WlBiTnFLQWg0SGRVT2VFUmRQRlA0WndXbmZY?=
 =?utf-8?B?MGl6UVFGOEt4bG1nWGFtQWtmNVJlMm1WYmMwZ1M0R0hBN3Nrb2RiRUtwcFVS?=
 =?utf-8?B?QS9PckJROFF6K2kybzR4NVhUT3hEZjZVQmpiNytEWnRXQnJRaitrRnRVUEF5?=
 =?utf-8?B?cFZJV04zQkZHVkhFUEpLNDBZWlhBYWtkRjc3NUdVTHIzTUw5Qm9HSzAzMUNT?=
 =?utf-8?B?VEttRlFMRThLTE1Jd0V3K2RUVGRLMm4yd1U1Y1BVSlZYUFdqZm5VeCtQblY2?=
 =?utf-8?B?Nkg3WGE2SEZ1MWFUTlNHRkJlbjcyWmFyelpEMHFqUExBWW04SEdBQlFQVG1u?=
 =?utf-8?B?eWdFMHBWUFBYc1p6TDNaSDNKUlplUGNiYzI0Q2E0V25pRk0xTjdXMXVWZ3Ny?=
 =?utf-8?B?R0cyMndtdzFFNlpaQUdDYlVKb0JCNytuQ0lncmRHcHlWRWE0U2toaEEwYkJ0?=
 =?utf-8?B?aWpqWjBaVVZxSzRUa2pUb0JkeHcvd24xMUdaOHh3T3MwSlZDOURQMVJTa1d6?=
 =?utf-8?B?b1huaGJ4YlFuWThWRkpYTDdxbStjKzhLcllzaUJGT1JJcFpjNzBSMWNvblVy?=
 =?utf-8?B?bnc2SUJZSGtkRittZTZEWGtOVjdmSVNaY1Z6czhndCs4ZGQzbXJqRWxNWG5i?=
 =?utf-8?B?aWRONHNTYVRCQjRxNFRWMW8reGRpaGF5R2tWNTF5SS9PMUpmS2xjRDhDNFFp?=
 =?utf-8?B?S2wxd1I2UlpuNDJXQ3NYUkkzd1hMM3dIVjcya0ZodnQzc3NpR0xqWk9GNDg5?=
 =?utf-8?B?Z2Y0Um9jUWpLYmNwR3VHNGZRZ1d3WFlybDQ4MGtqbTFwZERqd3pYZjNTdkJW?=
 =?utf-8?B?dlc3dHBscUZxcHZBRGRQQ1lDZTNMM3ZxSzhoanVZSGFEeTJkd0E2THR5S2NO?=
 =?utf-8?B?amltcHRudnZlL0psWkF0ZzFoWE1pWnZFVjN0TWRXN1NYL3laTmFRK0Z0eGJp?=
 =?utf-8?B?Z2RiQiszeDNVZU5IN0w4OHN2eWlJckNLU0pTL3pBVG5GY054RXIycmhlUjV4?=
 =?utf-8?B?VVBkZytSbVlFZ1F4QnB5a0NoVHkyZ3Bid05UOTkxSmsvVFdTZi8xT3hnRVRG?=
 =?utf-8?B?cm8zZ0xLVGtvSnNaOUpqOGU5eVZGS3BCVTZFSzkxV25xZ2dIKzF6S3o5ZUcz?=
 =?utf-8?B?VWc3VGlrTTV2YU9PV0lLYUI4YnZLSFRCM3FkVlU0TnptcGplTk5wY28yUExJ?=
 =?utf-8?B?dVVUdlR4NG5NTi81YUZEeFRsK0lFU0hCZ0FPdXkxMDlJOUlDOGxxeWJGOTVR?=
 =?utf-8?B?MFF2QXJQOFlINVJRb3grSFJqTVJNUmxmZlgveGdzLzRDV1FTY0EzOXdWZ0xX?=
 =?utf-8?B?UFRES2RkYWhnVHVjWS9GZ0pucERtYmlVY29ydzlSdWRuQ1huaW55Q0FxTHY4?=
 =?utf-8?B?alJjd09FdzZYYzR6ZWEyeFRXWEN5NEJMUEhHLy9wa2NtWE41bVRtZGt5amxS?=
 =?utf-8?B?dHZGeW9wWW9HUEtIcTVnSTZpTS9qc2RJN0p6M1NCWjBENmVOR1V5VkVieWZ5?=
 =?utf-8?B?ZHl1dG9Yb2I2OFdYZ1hzQnZ0T2p4OUU0b0NGS2kzSUtCRmhpakRhU2RUWlRE?=
 =?utf-8?B?Wld2SE9HZ2hJMUl1YWU3alNwMFZwWDRVaHBObXNIdkVycms0L29xUWl2aVdF?=
 =?utf-8?B?YzRyMHU2TDE3VUEwSDhsRnA5VndZbnFDVjZZd1JiTW1sbDNXZjNlVDNyT0xk?=
 =?utf-8?Q?kPhCGX3hjuc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjFtY1FqL0JGT2NGWUE2d0tHMmFSOGRUZjdEald4bEUwZ1VWY28vSFdDOU02?=
 =?utf-8?B?N29BNDI5dkFNR2k4RnNsbVZxQS8xQkpoZlpXVTBqaDhjRE5zSWk2MHQvRURR?=
 =?utf-8?B?aTQxMTRoa3pRVlVBUE5iU284OUFWVDZ4TkJLUmZHZWt3M0VLZ1gxR2ZxdG4v?=
 =?utf-8?B?SW9tU01lQTBzR2NJcThwMzdvVnpRa0lLY05rSWgxdjR2TDBHT1BjYXo3Q1Iv?=
 =?utf-8?B?RU9vRW12L1htQVh0Ukw5ZCsrTm5XSHFIV0wrbkxXOEZLSEhhaVJXZkJJdzdt?=
 =?utf-8?B?Mk92YkFjL0dOdmtJV2NPTDcvQXRjb1d1c3ZjbE5jNTlEYllJZG9WK3lpcTRR?=
 =?utf-8?B?THNTWDQydkVHM2hEZVJCTEpQWTFvSUcvR2JMQkZuRG4vTGxJdXFCaWZ0NCtN?=
 =?utf-8?B?WDBkV01xeXJuZFNZVFpRSFB6T3hKVjRSY3BtSndKcTB5R3pMTzlMMzhlY2VF?=
 =?utf-8?B?K0RVYjJVdTQ2eCtLWnE4QmNTQi9mNjFDMWQ4UVFRbjA4dnJhK0tFWTRRQjVF?=
 =?utf-8?B?VURXVWFEdUt2bC9IMVlIWGRFRnZxL0hVSkVqcHBUL0dzUlVFNWcveW5wbDdO?=
 =?utf-8?B?eDF2WmcrMkg0ZWUySGd2L25nUkNMNXdHQXBIQm5FbmtnZWtaRlZ3b1NtcE5r?=
 =?utf-8?B?QU5UTXhLTDhjVnh6SDVRdnM0WWRDMEtJNE8yejZrSnFxZmVrbUJUZk9PMmlr?=
 =?utf-8?B?T2FRNnN2M1l0MkZNZEFzNkNEVmhjM1B6amRROTRHMEZEWmFZK3R4NVZMcGww?=
 =?utf-8?B?WWM5RVNnL3F0Z2lqOG1BTnRieE44c1Zuemc5TStRYkR5czdsQWJDdjRYREF0?=
 =?utf-8?B?RTF2dFJwNnF5dWRnNlhRbUNYc3hsT2duckxidEpqNFcwcmJYTmM5VXNKMU9K?=
 =?utf-8?B?Q3dBY2RCTlFQall2UXhwRHNmT1RLdmR4K1pJNFN2eXlBbkJDT1htdHIzNis1?=
 =?utf-8?B?WVpMMDZBNkVaZTBuTkZwak93TzdSMzRoMzV5bXlFWU1yeUtlOXdPTVRGVWZX?=
 =?utf-8?B?QThBeWNEOTVWR1ovZEVXYTI4TnJ3NkdEbmxEQWpBbDR3QlNaaHNQN1c0T0pC?=
 =?utf-8?B?Yk1qTWRyWkNyV3FpTXJ0cERrRUtVZnJGbTZDU2pIa01TZVRJUWdDRXFQVUNT?=
 =?utf-8?B?bmxzWlhUV0tXRHRveWRZbGVGV2E2ZHhiN1dtZ3BXRGc2L1M0ZnpQZnVlZ1RN?=
 =?utf-8?B?TVNXWnBYWENDTWx2Yk5PSzdQMEc0REJvaHhETFVQU2xKaUZjdjVSTG5WQnNv?=
 =?utf-8?B?ZEFtMjRlUzdTUDRsdWlVd2toa0Q5a2QzTVJQRnlKUTI3NmZVQkpPUU5SMVRN?=
 =?utf-8?B?U1JRY1lBc2dlbHZCcU9HeTc1ZFIvZGlxVVdRanJJc2M1OEJyUnVrTXpORHQ1?=
 =?utf-8?B?ZjdSUUUxZHZEdDJLQktJaUlScGNQc2NXcGxsU2VzMXRGOGdReU1FQTRCV0pW?=
 =?utf-8?B?YXVlTnFLQXMyUmFWL3BUMFN1K0ZaS1pWZCtRSFJoWm93VlY2YjNMcHY2RWJy?=
 =?utf-8?B?aG1XUTl3eFd1QlBoSm44ZzUvQlQ0Vk1sL2FMYk5QYmZOUTlTV3F1aGxOZDc3?=
 =?utf-8?B?RXkweWRBVXpTaTdrVkNJSkFKQ2NCRUxEd3U4ZVljM1lwUWdZK05pQmphUmpP?=
 =?utf-8?B?eitxT1oraVRxdlQ4c2dRS1ZMdUJnMWx4OVcyZlBGWlByMHRiMjJXMWlZc2dk?=
 =?utf-8?B?VVVOMW84cjl6NWppVy9OM1R5NUpGMnUyeGFsUFhqRDdXemFXSDR5Y2EreHNC?=
 =?utf-8?B?TVJNOUZjMlh1Wms5UldRbXdUbDg1dHYyQ1ZYd1dydnhwMDRicWRHeHB0dU9v?=
 =?utf-8?B?eURrN01scE9WR0N3RnJYMGIxMUU4cVlaVUlzbnh4azJiUmRiY1FhM0E5K0lG?=
 =?utf-8?B?R3JqNlpWNEs4Mm1kSitRS0pFaU80d1Y1eDBJWDNlc2VXaHo3RzdVVzFOYklG?=
 =?utf-8?B?ZGxXVXhtbHFucVZnOHRCMENaeThUN1Vlcko0cUxLMWwvdnJiMWQ0T21sNU9t?=
 =?utf-8?B?M3ZVVWNDTE53RXphMGtVUEpPTEcxK3RYK04ySmNURWsxelJ0d1pNZG1paGRS?=
 =?utf-8?B?RzduMXFhL0lTVlB6SW1NRE5sZDZSVWNpeHRQN2lqUzJRRHNGZ3A2b3Q5NUlY?=
 =?utf-8?B?NHhoNTUrT2JSb0t2ZDl4VitzalpQaERpVVZ0VEZHSS9uRkV2dEdlUEZkR0s4?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfc79a0-3f57-47ab-3cff-08dd8cafa0a6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 15:06:50.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5tQAAVVEjcot2WMLURh3zyYEVH2Ol5m2CBllv3q+m+17vj41/twq4NTD3/eS5NzA+mn2kL7uuONI3LsZYcgcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8169

On 06.05.25 16:04, Haiyang He wrote:
> By adding an additional check for the existence of the
> /usr/share/asciidoc/icons/ directory in the Makefile.am file, this
> patch improves compatibility across different environments and
> fix an install error due to missing icon files.
> 
> Symptom when running make install:
> cp: cannot stat '/etc/asciidoc/images/icons/': No such file or directory
> make[2]: *** [Makefile:629: html/asciidoc-icons] Error 1
> make[2]: Leaving directory '/root/xenomai-upstream/xenomai/doc/asciidoc'
> make[1]: *** [Makefile:421: install-recursive] Error 1
> make[1]: Leaving directory '/root/xenomai-upstream/xenomai/doc'
> make: *** [Makefile:472: install-recursive] Error 1
> 
> Environment:
> $ dpkg -S /usr/share/asciidoc/icons/
> asciidoc-common: /usr/share/asciidoc/icons
> 
> $ apt show asciidoc-common
> Package: asciidoc-common
> Version: 10.1.2-1
> 
> $ cat /etc/lsb-release
> DISTRIB_ID=Ubuntu
> DISTRIB_RELEASE=22.04
> DISTRIB_CODENAME=jammy
> DISTRIB_DESCRIPTION="Ubuntu 22.04.1 LTS"
> 
> Configure:
> $ ./configure \
> CFLAGS="-march=armv8-a" \
> LDFLAGS="-march=armv8-a" \
> --build=i686-pc-linux-gnu \
> --host=aarch64-linux-gnu \
> --enable-smp \
> --with-core=cobalt \
> --enable-doc-build \
> CC=aarch64-linux-gnu-gcc \
> LD=aarch64-linux-gnu-ld
> 
> Signed-off-by: Haiyang He <aspirestro@163.com>
> ---
>  doc/asciidoc/Makefile.am | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/doc/asciidoc/Makefile.am b/doc/asciidoc/Makefile.am
> index 2bacb7c10..782c7a23f 100644
> --- a/doc/asciidoc/Makefile.am
> +++ b/doc/asciidoc/Makefile.am
> @@ -112,6 +112,8 @@ html/asciidoc-icons:
>  		cp -a /usr/share/doc/asciidoc/images/icons/ html/asciidoc-icons; \
>  	elif test -d /usr/share/asciidoc/images/icons/; then \
>  		cp -a /usr/share/asciidoc/images/icons/ html/asciidoc-icons; \
> +	elif test -d /usr/share/asciidoc/icons/; then \
> +		cp -a /usr/share/asciidoc/icons/ html/asciidoc-icons; \
>  	else \
>  		cp -a /etc/asciidoc/images/icons/ html/asciidoc-icons; \
>  	fi

Thanks, applied.

Yeah, I think I've seen that with Debian as well while updating the
homepage last week - but then I worked around it locally. Thanks for
addressing it properly.

While at that, I was wondering if we shouldn't automate the doc
deployment further. We have a (not yet public) repo on source.denx.de
that builds the static doc pages, but I have to do this first:

- build xenomai with ../configure --enable-doc-build
- replace content in public/v3/html with
  - build/doc/asciidoc/html
  - build/doc/doxygen/html/xeno3rpm
- replace conent in public/v3/pdf with
  - build/doc/asciidoc/*.pdf
  - build/doc/doxygen/xeno3prm.pdf
- commit and push, CI pipeline will publish automatically

Would you be interested in working on an automation via gitlab-ci?

We are also lacking CI runs with --enable-doc-build inside Xenomai
itself. Such runs may have revealed issues like above already. And
possibly things like
https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/49...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
