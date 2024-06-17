Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D29415F3E7
	for <xenomai@lists.linux.dev>; Mon, 17 Jun 2024 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642763; cv=fail; b=gV0jaxTHLc5/6wG3nzh+u4sCjiRUHckybuY7OdAHHXQ1JOmcOME8HFn6qz2WV3fv0ONHK663uqk3oS5ndf3CN1lGp9hoy8bS42EfSbMx9ZdwnW1Lp8XsH3WHZas946J+qF3TJPHa0qA4WLmWIPhkpmaOPY/TCR0E3Pa8lwK/6eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642763; c=relaxed/simple;
	bh=0Wbb+5OT4wyGBd+NmCfHqrfrh9oDwtfR8IZQtY7yhhw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RHUFwRcFrmvQjpa1m9Vf5vKuzKuS3VRu9vsBXyaRrBz/9dwATJBHhiwLOq5tfBSiqLv1pRVIUiZjAet2Vt2mt5x05oIvDBRTutHozak+67DaZf/Y5RupzNXXeWg3oCW5wiEfIphy0dQJx/kYSB8LrLVIXcAZt7K4fJBtLiN7+IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=w+lctkNA; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="w+lctkNA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pc1FaO23Izpu9+vQfER0hdvxGnMEg8FcSktUzheqjBN+JPx9pV9BBbmlAzr8VvV35MsVQYQyJQsoDl5IGAo66zD0u3V4TwjqPrM0MX0SUqW3e2yZSaXhv4I7BtxX2PiFkbhUg4vZZU+doFYJlkW/Hoj9Lx90rb6iMCBet67vSXPCU+xp6nBi+KYsPWnTmt7DO63e2cPoO6f/Oq5M8OCgw+uazutwLb1rNRIxVP5lto+IXHZwa2ks0AIzfZcf0XAU5tDvnuJGoX+GhPlfBq+X834GH3fKtxsDm4iX2XRzsXTcve6thgsLhmqZ7OWx6f4q4Nbyk+7RbxrOxMZwaGWWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwPnqIMvmmb6Aae3G9DWtV2XuwUEJX0l2k3XY3Sl2nY=;
 b=IILBOV5U/23Bf5gZwkiPJ+DfyPtD9+ip2Bjm+2yzb1TkuonbgzFHvNtct6oj5+28Rmo56ZgujZv2dNVxKyJ4gXYUa4rIu3krhUwWhDSHmo4tzW+221G9+/2A6kHMIJJlklGsSHiVNEAu8Svu1smZsSBAlfSe/N2Iu6qMqSTbCAsq/tG1Yb7U7w7jBzwAY7oE7vQ/vOEsKpHkIxjz3NZ77OT9OHLPdn1CXZ4IsmJAYidJjiIUiMWet4ihZtqgnP7gmsY2S+XK/VDm1XKQGlAZsrP9DQjXFGIkvRjHw2V1CY84yyzJWYRi91JL3rmOfFdu/zD5xcIopMT93Ds+cy1P/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwPnqIMvmmb6Aae3G9DWtV2XuwUEJX0l2k3XY3Sl2nY=;
 b=w+lctkNAUbaDqTWlhtWmINOxdEClh/K5ojy43eCouSRwid+2PW+i5AhRBwKHvtINZOccmvLCWT+Y9eMxeobQs7wIx0250Yqj0ZiMGVgkGU+WVjxIBvEhYEIoRdv2aN4vXw/Vbj0/tFUhhZ0zgJUqK9oXcTfs+b4TPHUoUlu77eC1b9hPeSn4O85/u2QJU0H49FqI5nRyth68GiYfafmjQ7Efl/u4hX+e4qdYPE2tsTI6mHxpOpDDSlC2hfCVI41if/N8N9MJC+WDTpI1IQsQmUIdFc8cwyLxQlN0llRtsKE6OXUCja2SwbNw9VeEWsFEXCBh1+Lub620mhnd/PxMkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB3PR10MB6882.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 16:45:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 16:45:56 +0000
Message-ID: <655ed859-97cf-4a9d-b9ad-08ad9dedeab5@siemens.com>
Date: Mon, 17 Jun 2024 18:45:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] testsuite: smokey - new testcase alchemy/task-11
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
 xenomai@lists.linux.dev
Cc: richard@nod.at, lorenz@sigma-star.at
References: <20240617091654.66342-1-david.oberhollenzer@sigma-star.at>
 <20240617091654.66342-5-david.oberhollenzer@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240617091654.66342-5-david.oberhollenzer@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB3PR10MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: df75e69a-3d0a-4294-b2bc-08dc8eecf595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnJYTm1BazZLTWFENHg5SzBLb1Qzb1JZamFOcGpRZVQ0RWJ0ZjUwNW00WkY4?=
 =?utf-8?B?a2RTckxLU2NsYithdG40UmRJSEpYZGJpZ21qZVRzQmhrVTFLS1Z3K3ZjVFBT?=
 =?utf-8?B?ZzlyL0h5blhENExMNGZSRnRkZ2MzaFI3UmEwQjhBRXJCQ3l5QWxZcXVac2hy?=
 =?utf-8?B?WWxyc0ZBSVdJNVlVelFxTFRDVnRReS8wRjhWaHE5d2NiakJBaEtScENPZm9R?=
 =?utf-8?B?M3MwY0lpYXVpK2dOY1laNDlNV3ROdXF0YUNjL3BhNGFraHhvZTFYeXVPWWFx?=
 =?utf-8?B?YjJLZzJKVkhVbFU4RzkreHhmVEZ5TlgxUjRzYnpkdXByWjczN0tGeDNpL2ZH?=
 =?utf-8?B?eTJVVWVIaXkvbVpEemFsNW9zM1RQYTV0MTVKWXVyMkVqY2VEM0pEQm9Belh3?=
 =?utf-8?B?anRYak5uTWtRdFh1eHFuM00ydGV6R1lFZ2VaZWZRZm9jcElZS0NraGwwK3dR?=
 =?utf-8?B?VFZKU3JjTWNzdHJ6Tmk4Ym1RcHl4d2hsdU41YmRtbzZ3TG9GOGpSVzNzbkIw?=
 =?utf-8?B?bzRYSno3QnA1blgvRk93Q1c4SlF2T2VVMUJVczF4VlFnejlsbk1XWk4yZVU1?=
 =?utf-8?B?WGlhdklBMmV4ck1kZFByYWc1WWE0eWl0MnVYY0ZJMjR3NXdLMVMzR3NkcFlx?=
 =?utf-8?B?UDd1akJ6QnAvUXBBZUhhSG5zbjNvSjlDZlp1dVVWeW5GcEJFY0RWKzI1dXh2?=
 =?utf-8?B?T0F3U3E1WnZXNGhqODBaOFhxdlNTeS8zNWUzRXJ4YVFGOWxFK05VNnU1cnFT?=
 =?utf-8?B?SmlFQUhYaHY4UjhCblllMXhZWlQ2dEZnUU9WeVJhWmhSZnhYWWNWT2FES0pr?=
 =?utf-8?B?ODhuWE5GeEZJRWx0RVUvanZKOTJaS1B3cTlzckRZaVA2ZXdoYjFIZWZxb3d6?=
 =?utf-8?B?M3VvUFIrVXdCN3FhT0l5QkM1L3RPcGVHazNHTStqQVYzUHAxcCtlb1VrZFhL?=
 =?utf-8?B?YnB3Z1NVZzZxckYwNnk5VlhrTkpCWEJibDhnbURoU0FqWmdtMThmVmN0TWd1?=
 =?utf-8?B?NTNMTFloUXV6RzBXMGhHT0lYbWE0a253cFQ3dFRnVzBrOUdId0tuNU1zbzM0?=
 =?utf-8?B?bndyWWxyMW1TMVkzUXhEMkNoUUgzM1FkSW1LTjV5VHNYQjc5SUdrbHV5Tndo?=
 =?utf-8?B?bFhyMEliU3RMZmRVcEdZRVBuaHZac203emp6aXgwbmxzdHRzUGxleTdOaWh1?=
 =?utf-8?B?cTNtSmJIT2dUdVI4Z2dUNnAvanE1Nksrc2JjVVVvbnZ0ZUNoTmtJYUZkUitz?=
 =?utf-8?B?T2ZpQ3EvekYwYno1UUU4ZFlRZCs4QW53VWRFckk2aDd0M3hqRkZNRlQyVVZ2?=
 =?utf-8?B?Mm1qbWg4WklnK1ZLZW02SHUyNTZMbnRiNlNCd1k3UGpSN0szanVrbEM2QWh1?=
 =?utf-8?B?WkoxbzlWVmVGd2xCS1lsRUg1bW1RbnU0WnRPaVNNcndXVjVRQzlMdWpjRzc2?=
 =?utf-8?B?clN5djlTVGdWVklhNEtJSERhUDZBZDZXQkpsVVFnQ016NTUvMjVZTkZVSUFu?=
 =?utf-8?B?b0JSamJ2WHIwUm5TRW85ZlN0SnpyWFg5dkFzdzl2Qm1zV1hTRmpNOXdjSWxM?=
 =?utf-8?B?dUUvSzdHaEg3V2IwMSt5cFZMOVJwWllKSmNkeXR2TlFFV2t4V1ROOWVQdVpK?=
 =?utf-8?B?RzNtRVlHbkRjZi9qUFdwMGM0cHl3ejQ0RmxSYnFkV04vNm5OUUFCZW1WYTFx?=
 =?utf-8?Q?XjW4OC4JKrvysVIqWgI7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGxncDZNSXhQWHZUQWlaa2lUUXhFdGYyRmVCSnBueURkQWFZeENBVXdsT21k?=
 =?utf-8?B?VFJEM2lIa1dqTS9ncE10WFU1NVAxMnQxT3dONC82SGN2WFBpV25NazBxdzRK?=
 =?utf-8?B?dGsrTGwxMzZzOXlIbTR3b0tKaW01TS9RZzdTMnhqN1dFaG43SEl2YUpqbytp?=
 =?utf-8?B?UlRKU05CdjBTMGJxcUNPYmxwa0JoWG5RT3lWVnAxNzZIQ1dybVZBbXh3T3pQ?=
 =?utf-8?B?ZFhWMXJBaU5nWDNuOGR6WWwzQW0vR0Z4K1lpM1RkV2tzTkxDYkR0Tm51dzcr?=
 =?utf-8?B?QUFIdThHeTBiS2hHYlczU1BhbmZtM1BNZUVMM1h4dTduczlvWGY0R3pPT1VW?=
 =?utf-8?B?RlNPVGdkODF6QWRhQ2Qzc1dieW5JdWJOcDJsMnlSRE4yTEJUdkNDMmo3c2Ja?=
 =?utf-8?B?aDNKc1MxVmF2aWdGdHdjVmNRZzk4SDdPUEpSQllKYVlpazFHTm5qbkJCWFR5?=
 =?utf-8?B?QTNwc1dHUWR6R0FwS2FJbVB6N3NyRVRlY1VWT2V3UmU0MEUvWlJRa1lJc2JT?=
 =?utf-8?B?cXV5YlF1L1R4NFFzL3o5di8rWXE5aTR5TzZVMkxCMmtKcmNkNldDYk93Yyt1?=
 =?utf-8?B?bnN5Y2lJS3Y1YzJ3VHIremlmYU9NU3Y2bS91SDdvd0REbWVVTE1KdVlkK3c3?=
 =?utf-8?B?dGVDYVpYQnh6RWpPR1JPSlZubndPSTFrcFFpQ0NJaFVpNmFOWmJvVnlQZitu?=
 =?utf-8?B?NTZudnpzbW1SeDdrbGZaT2hPaDdVU1JuVS9kWjMybFRPUkcvNVpBdEcvL1JK?=
 =?utf-8?B?ZE1OTy9pampGc3RhZm4vVkFKamkvTVdPb2tGT29DYnFuMTExM01yUk9ENkN4?=
 =?utf-8?B?U2RQN0orUWc5VitWWXpVNVJReGhxT0tLWTk4d25aZ0gycktYTVVmcHZXZXU4?=
 =?utf-8?B?T0M2d0hDNStMZ05BNjBxbEhUeklwTm41QkF4M2dldWtvQzFnN3FqMSszeUpV?=
 =?utf-8?B?NjBwR2h4ajVXc3FlMHVTeUhEN3g4VXZ3V0luY3BWbFFaQkM4Mi9CSlVoNzBi?=
 =?utf-8?B?Q2Z0SFpPakt6RXVTNEZXeVFGVzdncitUQ21ndkVQb3o3ZU1iRXFJS3JCQy8z?=
 =?utf-8?B?MkxFWFNLbHU3OE5yWXk2Wm5zZkxyOWU4SGdLR1MyaWIxZ1V1NktNa3dZZGFt?=
 =?utf-8?B?SDRqNkhnYklDN0xrSUgydmRqODRNRjNLSFlMaU1WRlU2czhDUjVBeFJyQ21B?=
 =?utf-8?B?bm1vNHZqWlhnV04xdnhhVUdHMGE0TzZkd3RnQ3NNQjNZSERDbmE1eGNKRFB2?=
 =?utf-8?B?T1k2RUtJQTZxdi9vSXRva0pFZ3RiVlBONDRiQlJQOUhNSmtGTDBteHkyc3g3?=
 =?utf-8?B?ZDFXZFdOUnpQTklxeS96NklieEhHSi9RMWY2RHNNTXpoaFkwOW91UXpOcGJN?=
 =?utf-8?B?UEw3WHlMZkgraWs3dFlwbVZQY1RtSkx2Y2tZeEtENXdlYjN1R0ZYd3MzVmVP?=
 =?utf-8?B?M0hqdGhaSE55ZkoxMHc4djFOYWxQQy9QZlZxam9nZTQ4VHJaR2NJRG82aU1r?=
 =?utf-8?B?T1VFdE5HSWtqK1p0UmpXZFdnWThRdGJSUUdILzVvdkttaUVPNnZsNmViZ0NK?=
 =?utf-8?B?NC9TVWxFVFJoRGRJZWNHdnZkekEzRlU2Qm5uSThQS1BZcXBoUEp6Tzk3aURY?=
 =?utf-8?B?UVNaeXhDVjF2NnBYcFJnTUplM3FNdkdlWDFnZ0tSa0hobFRQb0VxMDVHQWlT?=
 =?utf-8?B?YkR0YjJhZEpjYkNJZ3FFUXQ2dzZYMnorTlNYbktlM3ZZNzE5cnl4TFlSdks1?=
 =?utf-8?B?b2lveUpoSWxSQ0NxbnhCdzREVWdIdXZVWEVUY25LVVRGa2ZDdHpEWm94Z29N?=
 =?utf-8?B?NHBxNWE5RHp3MDNmdDFhZUU0cmZvNWljcU0wZ3BvK252Ukp6RzVDelB2UXZK?=
 =?utf-8?B?WTlYZVJjcUlGZnplNDczbWdFcmx6bUltYlNKN1Y1NGhHYk9vWWFFcXhHU3F1?=
 =?utf-8?B?Z0FaTnc2VGFsQW9uR01UNDN4a2NYak1ESi82MXFDMGZoTTBTU1RyWFp6dVVm?=
 =?utf-8?B?K3VUS1Z5SXd6QVpUSUJPTExodC91L2ZOQ0NLeVd1TVJEdFlDZkRVejhJRE4w?=
 =?utf-8?B?NXVNZys5NXRIQWpSUmsvQW1KWUxRcmJBUVRRWmk3S1BQUTZGV01aZVhRdzBJ?=
 =?utf-8?B?bzFaZVJlK1dBVGdwRktUbjB2dDczMGo4TUNtdkU4enVRYzFLcEsvaE5iNFJ4?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df75e69a-3d0a-4294-b2bc-08dc8eecf595
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 16:45:56.4283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hbvcbtkSIwbxHteQCYD8/lRReDPzrzTdR/bie0N0B9eCcFZNQMp4/yXbiOQQIg3C1qlpKrkFD75V/wGn4cTGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6882

On 17.06.24 11:16, David Oberhollenzer wrote:
> The testcase ensures the correct switching of the task period. If we
> switch the period after a number of iterations, the current iteration
> still needs to complete with the old period. The iterations following
> that need to complete with the new period.
> 
> Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
> ---
>  testsuite/smokey/alchemytests/Makefile.am    |   7 +-
>  testsuite/smokey/alchemytests/alchemytests.c |   3 +-
>  testsuite/smokey/alchemytests/task-11.c      | 101 +++++++++++++++++++
>  3 files changed, 109 insertions(+), 2 deletions(-)
>  create mode 100644 testsuite/smokey/alchemytests/task-11.c
> 
> diff --git a/testsuite/smokey/alchemytests/Makefile.am b/testsuite/smokey/alchemytests/Makefile.am
> index eba82f8ec..5fe481c29 100644
> --- a/testsuite/smokey/alchemytests/Makefile.am
> +++ b/testsuite/smokey/alchemytests/Makefile.am
> @@ -33,7 +33,8 @@ test_PROGRAMS =				\
>  		alchemytests_task7	\
>  		alchemytests_task8	\
>  		alchemytests_task9	\
> -		alchemytests_task10
> +		alchemytests_task10	\
> +		alchemytests_task11
>  
>  alchemycppflags =			\
>  	$(XENO_USER_CFLAGS)		\
> @@ -138,3 +139,7 @@ alchemytests_task10_SOURCES = task-10.c
>  alchemytests_task10_CPPFLAGS = $(alchemycppflags)
>  alchemytests_task10_LDADD = $(alchemyldadd)
>  alchemytests_task10_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task11_SOURCES = task-11.c
> +alchemytests_task11_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task11_LDADD = $(alchemyldadd)
> +alchemytests_task11_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
> index 947fa37b9..177d59b9c 100644
> --- a/testsuite/smokey/alchemytests/alchemytests.c
> +++ b/testsuite/smokey/alchemytests/alchemytests.c
> @@ -25,7 +25,8 @@ static const char * const tests[] = {
>  	"alchemytests_task7",
>  	"alchemytests_task8",
>  	"alchemytests_task9",
> -	"alchemytests_task10"
> +	"alchemytests_task10",
> +	"alchemytests_task11"
>  };
>  
>  static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
> diff --git a/testsuite/smokey/alchemytests/task-11.c b/testsuite/smokey/alchemytests/task-11.c
> new file mode 100644
> index 000000000..062c24219
> --- /dev/null
> +++ b/testsuite/smokey/alchemytests/task-11.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <copperplate/traceobj.h>
> +#include <alchemy/task.h>
> +#include <alchemy/timer.h>
> +
> +#define TEST_ITERATIONS (10)
> +#define PERIOD_SWITCH_ITERATION (5)
> +
> +#define PERIOD_INITIAL (2000 * 1000)
> +#define PERIOD_SWITCH (1000 * 1000)
> +#define PERIOD_ERROR_MAX (5)
> +
> +static RT_TASK t_test;
> +static ticks_t duration[TEST_ITERATIONS];
> +
> +static struct traceobj trobj;
> +
> +static int tseq[] = {
> +	1, 2,
> +	3, 4, 3, 4, 3, 4, 3, 4, 3, 4,
> +	3, 4, 3, 4, 3, 4, 3, 4, 3, 4,
> +	5, 6, 7
> +};
> +
> +static void test_task(void *arg)
> +{
> +	(void)arg;
> +
> +	traceobj_enter(&trobj);
> +
> +	traceobj_mark(&trobj, 2);
> +
> +	rt_task_set_periodic(NULL, TM_NOW, PERIOD_INITIAL);
> +
> +	for (size_t i = 0; i < TEST_ITERATIONS; ++i) {
> +		ticks_t start, end;
> +		int ret;
> +
> +		traceobj_mark(&trobj, 3);
> +
> +		start = clockobj_get_time(&alchemy_clock);
> +
> +		if (i == PERIOD_SWITCH_ITERATION)
> +			rt_task_set_periodic(NULL, TM_NOW, PERIOD_SWITCH);
> +
> +		ret = rt_task_wait_period(NULL);
> +		traceobj_check(&trobj, ret, 0);
> +
> +		end = clockobj_get_time(&alchemy_clock);
> +
> +		duration[i] = end - start;
> +
> +		traceobj_mark(&trobj, 4);
> +	}
> +
> +	traceobj_mark(&trobj, 5);
> +
> +	traceobj_exit(&trobj);
> +}
> +
> +int main(int argc, char *const argv[])
> +{
> +	int ret;
> +
> +	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
> +
> +	ret = rt_task_create(&t_test, "test_task", 0, 99, 0);
> +	traceobj_check(&trobj, ret, 0);
> +
> +	traceobj_mark(&trobj, 1);
> +
> +	ret = rt_task_start(&t_test, test_task, NULL);
> +	traceobj_check(&trobj, ret, 0);
> +
> +	traceobj_join(&trobj);
> +
> +	traceobj_mark(&trobj, 6);
> +
> +	for (size_t i = 0; i < TEST_ITERATIONS; ++i) {
> +		ticks_t value, expect, diff, error;
> +
> +		expect = PERIOD_INITIAL;
> +		if (i > PERIOD_SWITCH_ITERATION)
> +			expect = PERIOD_SWITCH;
> +
> +		value = duration[i];
> +
> +		diff = value < expect ? (expect - value) : (value - expect);
> +		error = (100 * diff) / expect;
> +
> +		traceobj_assert(&trobj, error <= PERIOD_ERROR_MAX);
> +	}
> +
> +	traceobj_mark(&trobj, 7);
> +
> +	traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
> +
> +	exit(0);
> +}

This causes sporadic failures in qemu, see e.g.

https://source.denx.de/Xenomai/xenomai-images/-/jobs/852670

Could it be that we need to add some "VM slack" here, like we have in
other tests already?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

