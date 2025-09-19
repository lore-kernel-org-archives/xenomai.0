Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C38C230BE9
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758280182; cv=fail; b=cO57hJjURJAPx2imDBPyInGVhWB1yFd+W2GtjzNTCCjmmMN5W3/w9doT6hLTrMM99k6NDZadgzaBLQEz2PM0Zr3SIFwQtGae+oaLgiMOONmdKeWdZ0bpL6M3iwabp5M2bYrcufNxe3lMaEUgF3sA1jnqsJoNvanEInGb5B585NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758280182; c=relaxed/simple;
	bh=ds0gszq/e+k8MVs07UoMYuNGIIv0mMwp6jb7Q9XmQqI=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=r2eQz4MeMprErI71rRjQdP9r++ZOGB2RD0xIoh4JA9TyhkpfEA+3gKHtFtM7YQ8GeFK7Lqv51OLuDmoclbPTQOVJ83zfpmtRkmD8VvYHM+56+1TWOU9MXP5wcbmovMuzBgo1GqdHx2E3BDygM4jBoCbi7FRc/zDews9UBDrljrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=GnjVfn7x; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="GnjVfn7x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dA6z2FzpBinMnMix7chrcyTdYFEVtMRTNFsHOuV5eyzGW96FSDyEJAFnPw4ZJtcS1ectHxXxqVsIr32lIBBP1bmSe/GjBGpH/zVZL489Ga1gTTvsYS5qQ4CgArEn9wFAw703APWnnEUtotv8frittGC7OJ6CfytqCSJZ26fr8O2xGzjpFFoBjXeV974iab87JFqJ3E350vvzyn120x1Nn/2iJQhi0GCDq4WK1z/RjP/MCLupAA5g+pVws5o71T9jg/KcUKjtZDcizwrLFFGdc3w//saIawPoZVsUCqA4cMEFVGo6wzeT61wwOtOxkd5SgBv/yb63G2g0xfVpzJrv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4Cvv5JEovhQcMK33C3wiQ19TXk7faicBNRWOxpCKb4=;
 b=F4d35ZNgUg3cNkp8bi6qvP5HKh5CR3705Za37+LMHzxMiCbBSAunSnt/B7yJdv9TrfMn9pSH6SyMg8A46qTs32V1fbyzn857pIJ75msa3SRZk3Xol2UWcjX8uC8vEk7XTPNREf0Uxb8d7f8qq03YBUnvqhZqX08LulzSF170mxTWuA6JD+5N4KkGBww6FA7RpY8Mj20T4mVkQnRwmLO4ZAz2bP1BkHi244HqX3sUWzivp9hmsWzW6fU50Zk4erbvWdCpMrWGl8jOtn+j2wIadAFy3YMlSUTUrgtsZdLtmGwEm1K2wgYEd3mDDsuMfX/jlwfufVb13K5jh89YzvY8Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4Cvv5JEovhQcMK33C3wiQ19TXk7faicBNRWOxpCKb4=;
 b=GnjVfn7xJWYF/7RSCgTqN+igK9PAKMdJz7ogeXIzDBmCKQbH/9PBs3YU7OziA15GFPeGvct58tXzS3QuMNxXSPfrEvywv5wrXQj0kqdFCBfGfBig0gfRI2JTwSQeSbnbXO/xswVfNs3M6rFJGMT31Ddg8D4a8A/1fuyaoNqMbvjkbxLGTlVLceBmERumKj0hJ7hOVgCWrtrR2jV4Oc8hx8iPvxzzGMnPqMxCjlZHGooLqTfxmArCtWBA62LNyFX6ddHtLZD8zhoE4Q12BkQzotV5htFmN01Tzu8oIzU5Pusgvo8OmmTnPjxKSi2mlIpWf15fX6DmAZ4M7qQqfOgX/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV1PR10MB8857.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 11:09:37 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 11:09:37 +0000
Message-ID: <b4e5f0dd-aeda-4015-95b4-54ca52ddd78a@siemens.com>
Date: Fri, 19 Sep 2025 13:09:35 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: ipipe-core-5.4.299-x86-18, ipipe-core-4.19.325-cip123-x86-31 and a
 reminder
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::20) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV1PR10MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: ccebb516-a833-41b5-370e-08ddf76d0576
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHlxZnh3NkZCYzQ2M1ZxZGVSbFd4YTZEamdWZTRxRU8xMmlpYytKSnNXOVd1?=
 =?utf-8?B?RjI1SDlEN2U1MEhySG5OZnNHZ2xUblpoYldtRFdHTU9Cb08yQzNUMUk5V1Nx?=
 =?utf-8?B?QmRIeFpMOFBYR1FpbWx2a0dPMUR6VjYwR0VjRkFGcFdUZnh5cC9NVjlOMmVu?=
 =?utf-8?B?S0RyODhqY3hhY294akJKdmQ4Zk9kdUZSVDdrdkxZc2t0NzNTc1ZhalNKbGtm?=
 =?utf-8?B?ay9QZkloOWt6U1hzMUhmYngxNXV4UzZ6anBUK1VSOURFbXl3akZGZFRpNndE?=
 =?utf-8?B?ZTlqYTVnQmJDeDVkUjdUMGRGbWlrSjlYazdlVFZvSDVHNXVSRVFCVFFpb085?=
 =?utf-8?B?QjlHYnZLaGI1YngrQWV0UFIyb2ZGUjNQc1JPUTExYysrdWF1M2FzMG1HUUc2?=
 =?utf-8?B?RUFsb3RSOStVYmppbWJ4MWRvMGRsM0ZUMDBjVUIycG1hbmRGRTE0YUUxRXhs?=
 =?utf-8?B?ZkZDVEJpRnE3RFl0aGV4K2YyNlZmL2tuaUlJRDVmQU42cjRuSjFuTEVLSlJW?=
 =?utf-8?B?QVd3bVNTT1Q5R2lhWFFXTVhPSVFpNGx6TmRSYnh4Q2d6UlpHeDFvTXh3THBm?=
 =?utf-8?B?bzhsYmpYMTZXcVE5WDVXbFFNa0U4c28vYnlPazYra243emVaSVFseWRuQitO?=
 =?utf-8?B?cnBLUDBRM2s0Sk05WEFwNzRvT2hoYms4TStyUSthNjlKQ1J2RjYrbFZVbVFJ?=
 =?utf-8?B?M0pGWU1GdDRIaENNWXJYMDUrM3ZENWdVb3UyU2xqV0ZHTWxiVHRJUndPdTUy?=
 =?utf-8?B?Yll5aWRjcDdubDRzNzNDZUFYVWFIUERuQTNzamFhRXpyNkZLRjdCODF2NlV3?=
 =?utf-8?B?TnpjUlFKOU0vZmNTZ3NqcnJDZkpGMFZjRDV5WnJOVUJESHR3YkMzS1BuVnk0?=
 =?utf-8?B?MTJhSVZIa21saDJXYjV5Y1dHNVhCclN6WW1Jc2MxTHhlcHUxUVl4YnRRdVVn?=
 =?utf-8?B?S3c3eC9OU3QrNWljRGZVUHVVRmdwaTFiQmZOMmZ3bWEyWVI4L3BXNUxieE14?=
 =?utf-8?B?WmFNcmpaUEh2RWVrenI1ZWdYNFJELzlIVkZXdWVBRFM1UUZvVkJjZ3NPRTU4?=
 =?utf-8?B?dmJ4b0FJeTdyL2V2bzN4bWtobUx3a05iSC93b0x4RE1DeEg3NmtrekJ1L0Ev?=
 =?utf-8?B?T0xXTWRYK0NZN0MwNFZpQUdKZ29sWmJJODlVV2JDWjZ0VUF5YTdrZ0ViMXEr?=
 =?utf-8?B?ZklSMStVS1U0bW1TbGtTb0c4SXdxTTFWYm1iZ2RkMzdyMTg4akdmVm5QeXdn?=
 =?utf-8?B?eG1kUS9lSldDdnRQZWRwaUswdXBia1o4ZU44aDdxazdueTN5Nitldzl6SnRz?=
 =?utf-8?B?U0diQU1icWlUMy9OOFpYQXN5bEV6bWJYV0JtTlZvdGtVZUx4OEhjRHhsUmNi?=
 =?utf-8?B?TXZNZDEzNlJvblUrQzZqK3RSS0pLN0dZKzZkRG9SU1hOWTZsUHlvR1RxSXZS?=
 =?utf-8?B?eS80LzF1dHJDTjIySmVZY3IzWGFsSldDRUJBeWVjWllnT05ZVkc2ZHlVUHpL?=
 =?utf-8?B?dEh4QlE3Z2w4RmJNZzdEeVFBb2ZkVkNnamR3cFA1NDhLQUFpNHJVcnBCOXJL?=
 =?utf-8?B?d3pJcTQreXNFNTUxN1pIME5UaHh2SWUwTmVWODYrT3J6Kzk2TUVpVVR5dHA2?=
 =?utf-8?B?dUlZOTZUbmphVGNHSWNvNmhhKzJvenVGRy9jNk5vN2l2L1N1VlhGV09GWWta?=
 =?utf-8?B?UURIamZUOWRYUmtaeC9PbmM4dlNlN2NBZlljS3ljUTFyNTJBVGlrUEF3ZGtn?=
 =?utf-8?B?MUhZTE9KdGlFM1h3WVduMjdJU0pjSHQxWk8yZFZUOGhpc2JnTmtTNUJIV2pr?=
 =?utf-8?B?U21CZkt6VjQ2Yzd6U1ZQV2dUaU01ZzUzeSs3Q29PUEM0eGQ4c0tZV2pLS3d4?=
 =?utf-8?B?dDdjZjZhakZ0OWZaRmVwbW02c2trNk9wNWJRbFl5UHpJUkVUOURzaS9lK041?=
 =?utf-8?Q?tvBxc8dV5Fw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFMwc2YrT2xQRmFCZjBEUi9WMWFYOURqUkxBRVFEd0R6VVV4MUxndDRYQk5J?=
 =?utf-8?B?U3BtZHgySmpxbmN6VDhGSjFJeDhlQlEzQnJVL1JyTFd2QkJ2RENkVDBrQmg0?=
 =?utf-8?B?bGQ1SnNkQ1ppNTliYnlBc3B4VDU1YlVJWVQwSFlkNVlBOXUyUGtvRGFiaGt2?=
 =?utf-8?B?UnNVUmVrZUtXQi9uWERVK3BTSFo2cUF0SFdkb0VLb2VzekYvWW5kd1plWTJM?=
 =?utf-8?B?eTQ0ZHgzMldieU9NNE5EckZjSFVnQWQxR3hOVFNDU2ZLcXptVkdmeWN4ZzJt?=
 =?utf-8?B?blBXSnF5UGhTTEtIendSK2tlZGR3SXJoTjUxbVhEUCtiUXlyRC9aMXhTMklr?=
 =?utf-8?B?UGc0bm5ucC9WdHl4U0RsdjRiMTZwckRtbWl1aDgzVUxMTUtSQzlpbEJQMVAv?=
 =?utf-8?B?cEpzcG1yeE9CNkRrY1k2YkZWZTRkT3d6akxhY0RjRnZvUGI5ZGgveC9HZ0dP?=
 =?utf-8?B?Y3ZJMkxKYXkyU2JIeXVicFgyMEsyelRTQm9PQVNqeEs4RGR4WkZwSGc0bmVi?=
 =?utf-8?B?K3h2S29mSExBZDk2bk1jZUxzc0FtZ0laamgwNERod0liMDBVcjkza3Q4ejVq?=
 =?utf-8?B?U1lvVjBlSCt6Q1lWUUNFbHo4K3ZUNmMraWUrc21ZVGNTRzFrMFBLU0liSVlx?=
 =?utf-8?B?NFZNSnpqekFhMjdzNjF0SVE2V2JMbjR3SXhJUm5aM3ZzNmcyVnBRTkQ3L1Jz?=
 =?utf-8?B?NWQwdktLLyt2czlZQ3RiMVI5V3UyY1I4N3Y1Tk9ITXJqbmRnYjdTZiszSTZV?=
 =?utf-8?B?TW9CN3NpbXg0ckNVUlA4MGVLVmJTZFNCeDRPR3BSK2FNamJFVWNVa3J5Y2pW?=
 =?utf-8?B?bnZKN2t0SENmbENtU3o1UlpybTRrOTBkSGV6RlA1UndTUTNRZ3NtSU5kWHdR?=
 =?utf-8?B?V3BDdkg1aS9LODVrRCt3NTBXaFV5TW11em96Ui9MTUpkdmlGY1RyamZ6bGJM?=
 =?utf-8?B?VjRXVUxLN2NTbk9JSkIrTklUSkZWRTNmMzZUaGRDaWl4ZnVZRm9sNzNydnFF?=
 =?utf-8?B?QmsvaUQxd1Rubk95bFVyME9KNGdyUmhaU2FtTVlPSUdnOFkyMDY3QVFUbFRF?=
 =?utf-8?B?QWhuVzF5ZE9JajNpaTdCOGROK21mV3UzS1R6Wk9oVURjMUtqaC9SWTZGamJz?=
 =?utf-8?B?aStFNFhrejRnTXRQRkdYUXhuV3ZKaEQ4TzV5aWRvU0RqcDdQWFhpZW5oQkFR?=
 =?utf-8?B?dmFvQU85YzcyMXIwbEZDZlNQaWM3R2RzTTNJQjNYUndUNmhpczNVdkc0WUhL?=
 =?utf-8?B?M2FkRE1RZEphdWk1bXdBaUFHYko2T29xZ21NTnBsT2J5S0JQUncxSytmNHM2?=
 =?utf-8?B?RVp6MzY2UklwT0tQRm5ESjFYOVVZRkk1b1hLWmdOYllpaFRYQzdWOC9yVERh?=
 =?utf-8?B?K0I0WHptTDJ5ZTRKQ3FIbWVEYi9jMWEwbnQzdVM4VUhOL2M3c0s4ejNGZDdD?=
 =?utf-8?B?TVhsRWlRYjdVSXRqNGdJZlN5bWdWTzBrcW1hb0UxQ2xJUkFhRzBaMWVGSFlJ?=
 =?utf-8?B?V3U2UU82cWdHQkEzNkt3eFphMzhxOUFWMmt5NU1jZTVRNjEvUDlSZXg1bGFi?=
 =?utf-8?B?WkptL3hWaGF4YjV4Z3pEZjgrVFN4ZFBZbXhPcGZBSWRrSDZBU2I2aDhIWFo5?=
 =?utf-8?B?WGV0QUNqSGRSR2ZRUXB2dkMzS05TcDQ5UFdlaDI3eFNpcjVxdXZtQzJZbm9s?=
 =?utf-8?B?VERFaWI4WmhTaE9Lck1qYk1vS0VOQUdYeWZGTk5nS3NCSDZVKzFmL3RVRE9m?=
 =?utf-8?B?OW9YbG5Td1JzalRkZzFSM2FicDR6ckZWdTFnN2ZuK2VqWXRwRzBoRkpHSnJp?=
 =?utf-8?B?SUlrWWtHakZNRnpxL3M3YlhXYlBDSFdrWG80Ym9RbDhObmFUQWFkSHY5R1Q5?=
 =?utf-8?B?bWNNOWc1ckhzWmRUWXdvejFMWnkyVXdqNTdtWi9yVUN2eTE1TVFDOU54SEc0?=
 =?utf-8?B?Z1RlTnVqYm1kMW5lWUpaVG81OVRyOW9ZcUNjRlhTS2c0NC9IbDdCTFRWSlk0?=
 =?utf-8?B?OTU3blBsOC9ZNlZhSW9oVURyRkxHZHJick9vOTJQTUIvL1gzd1JLM2N6dGF6?=
 =?utf-8?B?KzY4M25qdDB1SkJPS0Yvdzdta05EdkN1aHJrc093Z1I1dGI3QXhKNGMxckI5?=
 =?utf-8?B?VWdBQXJmQXNaSFdWYVRNalNrZWlrOXpJaHpOV0FPNldFbzN5NnptMHZtSVk0?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccebb516-a833-41b5-370e-08ddf76d0576
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 11:09:37.4026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiURxYBHKlleEUhoYA4Jh0aepJQ5OwfOYfNGbcPpsKIaBkR3Z0LtoQ/KEwgifzDBg2kXxJlwkvI6DROlA9EaCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8857

Hi,

while doing dovetail kernel updates, I also once again had a look at the
ageing ipipe trees. So there are two updates available now.

For 5.4, this might have been the last update. As you hopefully know,
the 5.4 stable maintenance ends in two months, and we will soon after
that drop this kernel from our pipelines.

For 4.19 which is cip-backed, there will be further stable updates.
Still, I will not do frequent ones for ipipe anymore. It may very well
be that this was the last one as well.

As you hopefully noticed earlier already, there has been no updates to
non-x86 ipipe patches for years (with exception of the meanwhile retired
4.4-cip series). Consequently, no one should use those kernels anymore.

With the ipipe kernels reaching their end, one after the other, 3.1.x
will do as well. I did a 3.1.7 recently, but the whole maintenance will
make little sense if there are no active kernels for it anymore.

IOW: Move your projects forward - or keep them frozen while praying that
no one will force you to prove that they are still being maintained
securely. ;)

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

