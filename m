Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7C4111BF
	for <xenomai@lists.linux.dev>; Wed, 14 May 2025 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241068; cv=fail; b=u1QV0RP0lm9+O1uL0sZfOMlqACOjKy3c4e9gN9UQHbyGwbdyvJFhSte7nhCkqhtfqdzI8Ev/xP41ktadIqpA8yQ2rtb3D3POqWaUpA/0TNr3laT7bJ8pkHER7mcMb9f1b4njP6DdQm9zeSm+HJ+teQJUOsW+jF7e2khXrje8uCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241068; c=relaxed/simple;
	bh=A3oTjvTsnyR+pZLjEu/gUgvsFV/FwuqsC4KUSuGmw94=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ky7YQSr6XnhaXtboKiuVjBY59zMXkDLUOliYgjGOjOZguC8OnvOvI3ceDcqXMMWF+OYXRfecxw1ChTbXMSl1hJuH4FFHK88DpG7crTKEZGoWKgo8vGAaQm9sE7jrz5WjH/Z3ziRQjRkBStTgAm+Qk26jUemkfK6YNT8tEhYorRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uxuWMfj2; arc=fail smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uxuWMfj2"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 2AC91435D4
	for <xenomai@lists.linux.dev>; Wed, 14 May 2025 16:44:17 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::5])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 47A32D81194
	for <xenomai@xenomai.org>; Wed, 14 May 2025 16:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iESc+21ZaKRv0B3bH4xJQA0G96dryQxf/3QKOq8Yp80Z6N04i/C/2baPt6FvrxcMEci4VyrPwjAMGLNEqUeWk9fvvN99aBAH6+xF1DzD1Mpb/zCJCsQ5D9sIHkDzTUrK3m6D+FpTLfWborLlgCc2h9xZ5ol4nAja8cvzdaQI09i8srKM9VkU4eUxymu21l45M661lgSWXrPKKcC/YJvbPcNVwRRo2jRBx2KNvAi4YvSNqYxrHIVf7X/54daVUV/XfeGgcvMzSr9BpznZgKqcsjpZY4NjfS82TfEDPg0vRhr7TmjR4h4EaR3iR3WrSgRNXlZK3iw+y5xmgrChtbGYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+XshYy/7plfDQtfiwnRNor4C970ubdwMzwXiJ+tNdM=;
 b=r4XgEBWzRnEk5aYyY0ZHlTgb9i+6x4CqgQhCEdOLxy6DgK7S50P19grga6+oZTXuNWoiNrS2NoDvfk2Wt/IZZ6ehUgh7uv+3+yCEe9YJK6DXBH1D9GsiJr82N0eoLCtEYVBUd1za+Ohrhezrx1Dm7TDg5S5PsqDbXqLqo7lEd/4Bcp9HjUa1vLet+EDU4L3VB5U3hEX99RZpfIcVsBgLnIxgJW/QmIsjEhAlf5ok6HLnkTn7bI/at082gKezSa8cfLRfwmbkIg0eFGSdDr+ZJhml6M2XQzE1XfxqJFeK6tHMVCZAFgNLlDd86qRwAD1es3GzkhcgXSe+veaw7BZeIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+XshYy/7plfDQtfiwnRNor4C970ubdwMzwXiJ+tNdM=;
 b=uxuWMfj2zZVoxedZkoJwgK97Ro9SdSmZTalf896P/tVDRF4TKWcmdnCj8M8617Z0hjQ2d0Q+awd2seqTQ5DmmUMRoWLxkVwFlbEDE50uTY8/C07KV48BYymSKjdjuCH0/RMK1rnOoXSHnP1cetSKD5O8n+C5l1imAdZllqTn70+pFu0ZxRwc+82CZ+rIhl6w/R0Dgzw+LtFhCLy22KMDCbqK/Hfo1xIfw4OjKRESlRZ8IKhTMzQcenDtz0pdpj3zYGUXZym9+1gQfX/RXVOdrfGCwqLsgvc0ZE326pktu9weRmUmXXO7FggDUdDa1b1hkbyRm6Z76dCHMe/MbdjOig==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 16:44:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 16:44:14 +0000
Message-ID: <14e0c75f-9f4f-4035-8bed-5f798bc164f4@siemens.com>
Date: Wed, 14 May 2025 18:44:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Please recommend the appropriate Kernel and Xenomai version for
 my hardware.
To: =?UTF-8?B?7J6E7KSA7IiYKEp1bmVzb28gSW0pIOyImOyEnSDrkZDsgrDroZzrs7Tti7E=?=
 =?UTF-8?B?7Iqk?= <junesoo.im@doosan.com>,
 "xenomai@xenomai.org" <xenomai@xenomai.org>
References: <SL2P216MB227453A028F3203C05B5A8B3E091A@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <SL2P216MB227453A028F3203C05B5A8B3E091A@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:208:236::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f075c2b-0ff4-43f8-d642-08dd93068f3f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTZGcnd5UG5XWFJDVWVXNEQ5WTBaTEdwZUozMkltMVNsRjVVL3RnNjBwYkh6?=
 =?utf-8?B?NjVoWFdKemhwdGJrT25Ub2NhV0c0Nkh0M21pWmw3TUlYUUFCYXhJbXpMZjlP?=
 =?utf-8?B?RlhCcEJGWE9zY2hzdGZsZWhsc2dMdkpQN2NDTXMvT0RjQjNaS1ZYYi80OFE1?=
 =?utf-8?B?dUt3dVlkLzVZZUZmMmlya1ZCRVNYSHZsU2hMcDd2SHlaWWd6VVllUTBDeUxw?=
 =?utf-8?B?ZHMvUGw3M3J3blJDSG95S0VFZVA1U0ZKT3lIOXc2MTZ3SGdZc2VMR25NeFpK?=
 =?utf-8?B?M0ZURGZkUXE2V3cwZWcyRGtQNEVoaDhmeTNCRlUraDhUbmFjVGZIUHBTOXVt?=
 =?utf-8?B?d3czcWtSQmtLM1VLRGlNMEhTSEtHQ1h5VmFKVVFjVkFkSi9LSmpQUHU4Nk1Y?=
 =?utf-8?B?WmVJc1ZrY0JCTzJ6QlNEOGhtL0RTc05WcWthK0JpTFhPUFlpS1RVakZNV2Rn?=
 =?utf-8?B?VC8zZGl4MmJhK2w4Mm1IVjFNOENWNHVEay94cDIxQzdyYS9FcGlpY2xKQUlI?=
 =?utf-8?B?dVI5YzlhM1VqbUMzaVpIV3Z4Zm4vMmR1Tmc2ekRSL1pEYmp5N21KaTR0RHYr?=
 =?utf-8?B?bG56dTlDOEtBNGFmcytzSW5MK1Qyc3pCQTgveTNIOEhZN0tqRjRPV1drM0lH?=
 =?utf-8?B?Z2g1Tm9VT2pmanRzYVFRZldRaXFkUHlIbHF6YWRxTUFWNjU5U3dIWDFTRnRk?=
 =?utf-8?B?NCtoL1VsODFiQStldVYzbDZBQXJOV1RhVEZnY2dwcG84NWVwcFhSdUl3VWsr?=
 =?utf-8?B?Q2VvK3FJSzFRNGY5WXppUEYveGp1VDJqcnc5cXBVUFZVK1dvUmVraDlTMFhN?=
 =?utf-8?B?b2RTcDkxbC94OTlPWkI4OWJRYXZsWjExZ3ZJSXByK3pCT2hDNmd2YTVXVGZD?=
 =?utf-8?B?Y2U2Q2lCd0U1blpkNWp0WGRrdTljRnlXdGhqWG93Y1pwaTQ1eUpuMlZMeXI1?=
 =?utf-8?B?ZU9yUnBMK0R4T1FsZFUrUG5TOG81RXBKUWZsRkxyTUVWU09QY2ZzWGJtaUJP?=
 =?utf-8?B?Y1BHaXY3aUV1UHdEUy9SVU1oWFF2Z0ptWmFWdmpFWXplQXZRMHBwby9STzkz?=
 =?utf-8?B?ZFcyS2JIbXNPNGlxNnEwSERWK2ZJOUpwNUlEQ1VaNysvS1NYYmVqd3d2cDdZ?=
 =?utf-8?B?S0pWaVduVGFNY1NDczQ1RDd4Z0ZBUXlwZjV3STNLanA1UHVXL0dWUnFNb21T?=
 =?utf-8?B?UnFOYU52dkJIRlJTV3BETTVlbjJXMlpNaGtNVHBTU0piT01yM3JDV3B1cjBS?=
 =?utf-8?B?WXg5TUtEUlNhQ2dRcDlKd3dyNkFnZldzZlp3VE1YRExmdFBNTDRQdW9rRy9N?=
 =?utf-8?B?QnI1YlNXRG9iZmNqSEQ2bnozRnVlbDQvY0t1UUprTkZMOFNDN0ZHTWsvMkFP?=
 =?utf-8?B?U2RLYnhNSXdtK1ZKT2orWGpObG9sNlRYR0xNeFY1TWQrdCt2NUU2L0gzQk5B?=
 =?utf-8?B?WXhObnNYVGdFOHB5eC9kZmpRV01CeHlIUFB0cENJQ0U5NzAxNFkyVVkyUldD?=
 =?utf-8?B?d3FXdHhrUUhvSzE5eWFnUWZMbG5YcUtMZjc5YUVzN01zM1ZBUEFhdG1WTXJw?=
 =?utf-8?B?RWdBUEhuOGM5b0NpTUN4OTkyU2ZzTTI0UkpFcXJybTRuNzRyQ1VIWmtwbDBk?=
 =?utf-8?B?azV5UUNqcmlKTlhYZXBLZTh0YWxJN0J1blpvMW1pcHp4VGJrdm5HV1FmTEw0?=
 =?utf-8?B?elNOc3dzZGhta2NuVlRIbzhQOWJ0T3hnNE9jUXEvY0c1cC83Z05PRDJzc0JU?=
 =?utf-8?B?VHZQK3NLcVlUcWlzYy9QQXlnQndGZ0F3R2FrM08rWjVpRk5aaGxqRFo3UHdW?=
 =?utf-8?Q?mRNEJqJshjpICsCGVIlqx0PfUHbJfnE/hkLbQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmY0Zk9vVDVXWVdVbGs3SlZvY2dMMmRkSThLanFlaTY5NDBLQytMVVYyc2NO?=
 =?utf-8?B?V2QvT2ZSZ29TNmxHQVRSalN2SmkwMm03SnR2KzlWQS9vODB2NlBwOFVkaHlh?=
 =?utf-8?B?YUo5YTRPaUZTUXhiUUp4Rklia1czTCt3WUFhUDZwMnF3ZjFEdWZrdEFxWmtQ?=
 =?utf-8?B?T1RHZm9rWnM1Ny80cEJ1bE01MVFPSDAyZ081VUZhTXFiY2RINEp1THNnYVJB?=
 =?utf-8?B?TFltL0dmdjYzaXhCYlRwYmVlMnFvY3R0THR0MEtnTllTakZGUWpqbDRwL0Zs?=
 =?utf-8?B?dkZzVk9JOUw1M2I5N21YbGo1d1NFN2txRGVvSUxYZkx3eFhuRUp0UllIOUls?=
 =?utf-8?B?SkVFTWNsKzJ2aFdBczhFL3hoTXZMK3J2WGo4THR2VUk0RkV0UWV1TnNmUjI5?=
 =?utf-8?B?ck9DWU1YVFhNSVBaTzUwMWRwTVBVa0tYbGxKWFB0aFhSZFdTQlllVmJxbkVv?=
 =?utf-8?B?TE9VaGZKZ0dqd1lQUWh6UFR2aUpXakpIVU15VWJzc2NKK3I4cktCYTR1MGor?=
 =?utf-8?B?YWxGOFdNOVBTU0hka29BelpvM0xKZHYvL053TmJrcTcxQmVUTVlYNkQ5ZHFk?=
 =?utf-8?B?dDZETWRMRVkzbkJTa0Q5WDNYWWJRVTdGY0JDZmlKK1dRTFJyL3BEMGxmUS9o?=
 =?utf-8?B?MkZuNnNqaVBkU1JOakttZVE5ZTVxSWFuY2dIMUw5WGkwNWtzbm1TWEE1WkZ1?=
 =?utf-8?B?NEQ5WFhURWd1amlyMVRjdWhuYm1YSTM3ZTZVMEJqMXZPRm1UZ0xqVitlOWFR?=
 =?utf-8?B?d05OeWYxN3V6Q1FKR0Fsa2NmenIyeWNWQzVLZ2pOSWxpRHMxYVNqWjQ3M25r?=
 =?utf-8?B?U1Rya2oxSDQzb0MwaWNRRTFMYmxQN1NPYmthZzFWd3VwYWJ6SlVFUzV5QzFL?=
 =?utf-8?B?UmFhSFoveUtxQzY1YVd3R0FGNjhZSFN0VmZKQlBUT2FaUlJZTHhVM0VtS3pk?=
 =?utf-8?B?WS9zMEVPMXMwK3JnY3RwMXpRYXRYbUhvcDZ6V213V1VWTlY3YVVLb0tVcHgx?=
 =?utf-8?B?V2VqQXo5VElwaG8yRVZrYVl6OVVMT0Y5RkY2Wk1OQ1ZpcER0WFNsNkpOSk9y?=
 =?utf-8?B?UFdGNU5tcmF1Wll2bWV6NWJ0MXNHSG9aOWtpWklDSHU3QTJaaE84OE1SZXJs?=
 =?utf-8?B?SG5XVjdZQ3p0bkVZc0tSZ1E0bFg4ZDVmclBMYW9DbFZwNmpKOUV1eDV2REgy?=
 =?utf-8?B?aVRUWUFkZ1dSR0paNStPVXR1ZGhMM21MZTV2YWZxOW9pT05uS3ZONmtoSGYr?=
 =?utf-8?B?N2RsSFJRZ3oyWG1KZG5kN0g3SzM4eVV3VktZbEdBWmowODdMRjUyYWtBOGpj?=
 =?utf-8?B?QlJPUU80TnlWelkyUlBzZ2o3NDVJd01OeXlSRWM2dUkvNEJ1VE5HbUJqSEVp?=
 =?utf-8?B?MGx2c0x3ZTJVNE9BM3ZZMEpsTWlGZk50RFV0TEVHRmsvdlA3YmY3eXlibWVi?=
 =?utf-8?B?cnN4SE5zUXlMZzRQY3ppbVM0TUFrdUk0MU41SmU3TjJMS3JCYy9jbnp1b2tF?=
 =?utf-8?B?VjNCRldPaVAvYnZ5a01KVGRLN3JTTTdENFc0ZzlyRUtXbXdHVXlTSVdqM0Iy?=
 =?utf-8?B?Tk5QRFFaWk03eVVEZ21VVVN0LzhXYzM4U3FSLy9MQm1wTzJsc0FPblJSV0FH?=
 =?utf-8?B?OFFyQnVaTC81WXR2N2F2bnExOXNpL04vMGc3Vkk0UVBpWGNmNmt4bm5Ibmtw?=
 =?utf-8?B?Mi9iRmE0R2t4NjR5U1RjVGdYSGtCb3pxTnVkNXRoenpDS0IzRXdid1drYk80?=
 =?utf-8?B?MFNuaVRVUWR1a0NUVERSYTZWaTJrUHYvK3FPMkdRWnVaU2V4cjhyT0dQSlEy?=
 =?utf-8?B?MFg1VHFlekw4R0VOVHYrOE1hU0RDMEtYNWVMc2I5Q1FrSThiOWx0WTZiYi9U?=
 =?utf-8?B?SlljWUYxTTI1Qi9uSFZyT0d3WTUvT2MvZVZmcTRaNlVwVzFTSTA0SVV1cTY2?=
 =?utf-8?B?YXNzcExnWkoxWFZUZUlEZWFCQmVNci9DK1FvV2RDQWQwOTJUK2lVenF0VDlv?=
 =?utf-8?B?QWV0V3JYTmJoUDNzK01HKzZKTE5hRGpZWjhURHl5QW9IOEJqd3pwdUFCTW9D?=
 =?utf-8?B?VjJwU3dCTWFqRkVPYy8wR3BxQnhkN0ptS0Z6VEdNaXpxK09lK2poVENTR0NO?=
 =?utf-8?B?S29DZmR3VjhRQmpLTzBJYkYrTkVwV0F1blYwSVlXN2hTRUkvTnNOQ0d1ZkFq?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f075c2b-0ff4-43f8-d642-08dd93068f3f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 16:44:14.2442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZuEbfX/nNsayTvMOm48hBggP2Y7SfnHxEFzm4efY24DYWJWLDz2llk3sqJEqL2iDeXjJ6pBdBpkO4QEEc+QbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7874
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=uxuWMfj2;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:c201::5) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1")
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejhedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffgfuffvfhfhjggtgfggsehtkeertddtvdejnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnhepffegjeefgfeileeuueegjedtjedvhfehgeetveffvdegudegveduueejvddvgedtnecuffhomhgrihhnpehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgnecukfhppedvudejrdejtddrudejkedrvddugedpvdeitdefmedutdgrieemvddtsgemheekkeemmeduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvddugedphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

On 14.05.25 15:57, 임준수(Junesoo Im) 수석 두산로보틱스 wrote:
> Hello, I'm Junesoo.Im.
> 
> 
> I am writing to you because I have a few questions about Xenomai.
> 
> 
> I have an Advantech PC with an Intel i3-N305 CPU. The CPU has 8 cores.
> 
> Q1. Could you recommend the appropriate Kernel and Xenomai version for my hardware?
>     *If possible, I would prefer I-PIPE or Dovetail. I understand that I-PIPE or Dovetail are more tested and have stable versions compared to EVL. I might be wrong about this.
> 

I-pipe is in deep maintenance and only available for very old kernels
(4.4-cip, 4.19-cip, 5.4) on which you surely don't want to start new
developments. A reasonable baseline now is 6.12, and that mandates dovetail.

Whether you choose Xenomai 3 or 4 (EVL) is that another point, see below.

> 
> Q2. Additionally, from what I found out on the Xenomai site,
>     dual kernel (Cobalt) is better for 4 cores or fewer, and single kernel is better for more than 4 cores.
>     Is this true?
> 

The scalability limitation of Xenomai 3 has been addressed in EVL. So,
if you have RT workload that actually needs to make use of all 8 cores,
you better have a look at Xenomai 4.

Regarding "single kernel": Do your measurement with PREEMPT-RT and
compare yourself if latencies and margins are sufficient for your
workload. There is also the aspect of clear separation between RT and
non-RT that comes with a dual kernel but not with a single one. However,
if you sufficiently understand what you are calling, what then happens
inside the kernel and how to tune that properly so that RT paths are
prioritized, PREEMPT-RT is a valid option.

> 
> Q3. I would like to learn more about single kernel. Could you recommend any resources?
> 

Start from here: https://wiki.linuxfoundation.org/realtime/start

Best regards,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
