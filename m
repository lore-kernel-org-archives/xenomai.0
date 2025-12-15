Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011021.outbound.protection.outlook.com [40.107.130.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838927F017
	for <xenomai@lists.linux.dev>; Mon, 15 Dec 2025 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815201; cv=fail; b=IEyj7hlwDFbdoBYX+r/Task8qCVjhDK3noij9wfzhj7gHr+HnbUy7qcOaAIuMyLc7wn/hFpQgZ1VBTX6mMWGsIfdfSEPY0wk2kk17ZuDiPFSHbWkzWHgQ3TpGWmAnqZ345YLLE0sFqsJSKOlVv8XZgRqXyBpUrtyYIoifPwuN+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815201; c=relaxed/simple;
	bh=XaoPTa8b5ezQpNacnyMctzWIll9cv7uyHAT2ZdKRI5I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rh8Bzh+d2sA4VOcUs4DvILxq7mHfxEyII+CKdPDE52w2lyrr1DUZZR7Zv8QxZWDGpL4lDuSwCV/+tMxjRJeN672D8dcwjVMxI8fOXx3q6ZRJrZk5z7nIBO7qRhZl+NASplizX/m0nJCCHB16NcjVBKPzGHz5NPAqvU6X8YaGl4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kOIG9x0L; arc=fail smtp.client-ip=40.107.130.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kOIG9x0L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4+y5ERUFYsuGdXdk346SdoykaSJw5KHuEpG1TUolfuOwH5qkmyXOBbHV8JpGOkQxx2pJslMcf21ayEQd6b1X/Eu0PGxqIUk9h6sCXZxyJEiPlIbFuGfXN6GC3v1ZdUpPEaqU4sJcHWJvMeh3bv/PmzznEsbbUbNUR/GJhJjHhGkxAoQmdToFM2ESlJrZrUC4RxBPA84iFJQL1TIUXqUyX0cK+IjDWQ4ZCObgOjSQbNAiKtolYn71cG2jVLfR7FOIAmsn1GcRQEwgsyenaDAyap3ysnN7vMFpwrEph9Flwji1UwNVRGjkm/x+ToejFjKelDvpWxik7CPCyQeK7PGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dq98zn7qZ3b0s19AJcj6knxfygSPboblYeixYmGgLjo=;
 b=Vo7AYUcX0jvc4bfACkCvZIb2/NRCTYq5sn/uu7FRPELIbt/5U/l8hMvVbtxLyVugovBAWazyMzg0t5FnBareFJN07klqPYBdKI9Ao+S5xl6v2YM9PAJZLn7+s0Az31MoS2szRr6bzaloix2IeRvtNtGBHvb2IXZUXLb/WpB98kmKbMJnliDBHrezgeffEv48XZQN8in+bCQXYhz9vkPpM9qDN3rCqyFjyXSvaRT97k4/8rUwxFDFeo1CJLxEqlUwuBlxaI5Tz9rht1AJU3t+qIBiTdMjwcSVocATaAOuz6azW1hs8BOnB729Y/QTuRVwMqIlbG4QVoqNrbvwKEkeiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dq98zn7qZ3b0s19AJcj6knxfygSPboblYeixYmGgLjo=;
 b=kOIG9x0LsZtnoTX3/jALBU/RJr9rGKoAWFy21vcZu9XphgitQo4mFS1osEmLMOGIlosvAX2PAYLrHCpTyaf+0OvSOZ8AEEaTAH2I/Iu1oSkKwHy3NUtAJyFPuaIq6bAVesnr977Zpc9bxjfhaprwuwEcY+3ekL2W4/BufaaVA3y/dnHeBM7DlEfeVAlBQBtriG0PL4qMq+86GjPliag3dvnf7C005NJ8ZrmfZeWiG7QkOU5Sbu3Y+YZMBmYXtWAVcZ0TbnzuNbdNVIcxp7dEwOabkMo6ewYAWk8hV1wB6OmljAMplzcTTxmoOBbHrwocxjXfs53UBZ+LoklKj9DN4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5876.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:13:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 16:13:16 +0000
Message-ID: <93803e08-3855-48c1-93f8-c2954b0ff0ad@siemens.com>
Date: Mon, 15 Dec 2025 17:13:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] testsuite/smokey/posix-select: Extend the testsuite
 by invalid timeouts
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Andreas Ziegler <ziegler.andreas@siemens.com>
References: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
 <20251204-flo-fix-select-syscall-v1-6-7f9c545a63ce@siemens.com>
 <12fc2bb5-4abb-43fd-bcb3-ea7823501bd4@siemens.com>
 <19de2f5d6b7515054ead79a11c90767598a7c0c9.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <19de2f5d6b7515054ead79a11c90767598a7c0c9.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ac0411-0a41-4ad6-191e-08de3bf4dae6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RCtPVEtHRWMwVzUxa1NheHpLTWdreDNYazJJcDNadElxUVF0RzFVb0FKZnl1?=
 =?utf-8?B?TEx2OGszQ3N2T1F0TC9aWGduNVBGOUV3aTgrUU55ZGw1TjUrSUJ1eHlrN0Ur?=
 =?utf-8?B?RUNFdE1SMnZmbkY0Y0g1aitkOXFiRkVDTVZBK2RQemw4aEVmMk80YTRYN05n?=
 =?utf-8?B?dE9pZFdFS2pGZlFoUE41bDhLK0p4UXRmWGxDYmFZb1RnV25rSTg4V0JTQkcz?=
 =?utf-8?B?NWJHRkMxclJldVY1cVNyY29QWElHcjRsY3J4VWV0YlBlblZNOGtyb0oyUGNH?=
 =?utf-8?B?Q01GRWEwV0psZGE3U1o1VnVaSW5tejNkdkd1TUNvemJrd1VyMEVxT2t4Y25H?=
 =?utf-8?B?anA5UllYdVJDMi8wcm9qU0NrK0tIWjk4V0RNd2dvblRnNXNpeTVIR3p0Vkph?=
 =?utf-8?B?Wk5LUncvYXYxNm01RTZwS2FUTk1rSExqVFRoYUt3WVRySitUWmRiamdFd2Za?=
 =?utf-8?B?MjRkVVpWVStyQUp4Y1ptOHpONTlJQ3lCZlhKV0JhbzlFMGNZbk8zRUl0d3d2?=
 =?utf-8?B?U2JTcm1xUkFFY1FXMjl6Mkh4di9OcGVQR1NrT3ZQMnc1blNHTmRxbXRwbHpu?=
 =?utf-8?B?SHM3WEgvMUhUd2V1b0xiUVp5Ym8zU1BPdmNwQ1JVYllEREtnRWh5MVdqRUJS?=
 =?utf-8?B?Z1lzb0NYNHpQekNXU3p3KzZ2SldQT0liSEdJZzAwbWhCRWd5ZDJJd0E1RGx6?=
 =?utf-8?B?OVBZR09UZGM5UGVCN2tHam5HbkUxTGJWWG9hRU9zcERNVVhtYzhvQnE2VWVz?=
 =?utf-8?B?eWRPd0w5QTB1VWZVeFNoZDY4Uk9adTVoa1FVcyt1ZmFHZU41cTNCdjhGMERY?=
 =?utf-8?B?bnVJMFg4MlgrMGZyK2MxYUNBdVFhb1o3am54LzJsRFVGR2dXQUV0eUp1L3oz?=
 =?utf-8?B?WTlCWEtROEJxVFZlMWJhQndacnBscXllZUhzV0k2bG5Ua3EzZS81ZmM3ZFVq?=
 =?utf-8?B?UmpOWTlKeWY0NEpjMERNVytRcG15K25udmJFV0JCWlU0bkhmTFpPYWl0QUkr?=
 =?utf-8?B?MDlZT1JuSmdTeTFvemhEakVRWk1nTkxQditVeTgzdmd3ZTB1Nk1iMXhTWnJn?=
 =?utf-8?B?U0Y2L0Irc2dkVTdUYzhFUklYd29HQXZoL0twZmJOLzFyeVZWZEUzZ1B6NjVX?=
 =?utf-8?B?RTBrTURUTUVCNUcxaHFoNm9MaUJnQkRHaUN0WUEvT0JaVmtINUpuVnAwYXpU?=
 =?utf-8?B?QU1Gb1dVd2VOa3Q4OHo4UW9veTd1Q1FrMldJV0lheDJTSmhUQWJML0lXeW43?=
 =?utf-8?B?V1E0ZjU2NHVDOEtnRnRrR2Z0YTNTSHNRZW1YNVFMdEdDMHhZMkpGWkpZVnBI?=
 =?utf-8?B?NmhoZzJnVWlHNU9tTWpQdjNLZmxMbFpuczFjc0REbDVObjBmYWtOVTRPekxQ?=
 =?utf-8?B?c1ZXODhzRlV0UDN6RVhlVG15SUVVQnRjNUc4MkU2THBmcE5HV1dISnJqbW5E?=
 =?utf-8?B?NGQ5eWZOb2E5KzhBT3RiWTIzVXpROUtydjJhT0NrTEMzUzJncTRCdlpEZlQ2?=
 =?utf-8?B?Mm5lVmgxNlJaOEdwOXg2Y21qYTFURWFXWU8zeUs1eFc2UDNpTzVyZjJ1NGVI?=
 =?utf-8?B?d2wrMk03VlNuTFJDMXFqejdCNXFJQldjTW1UY3VoMWdvZ2pCWTQyd2xWcG0w?=
 =?utf-8?B?T01TZjM0R1pNTk5BWWJaSy9JTGNQL2FXeDV2dWt2MWdpMysva2c4em1kQVhY?=
 =?utf-8?B?SENoc0xDU1hjR2dCNjIvdTVoYjdCbFd1NUd5THdCbWFkNWlNeCtMN2JjbkNp?=
 =?utf-8?B?RkNvUmRsK2pydktmTWR6Sk5nTzVHSHFhMmpsYndnOVRtL3g0QWdNdFZyRlBC?=
 =?utf-8?B?bm1oTFJWSytHb2MrclY4aVlSSDEwOHdLKzJGcGhKNFhHUUlKUG5NUDAyRisx?=
 =?utf-8?B?aDZOL0FLMWZaM0RjUURnN0hIcWxLd2RFNk0vdE4wdTMwSC9UY3NQQmFzczdy?=
 =?utf-8?Q?1TedSMz2o0xaqfGg4RHSG0cX9NMk1MFD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXdxM2F6NkNic1RxVCtmRmhGM2xXSlhER3AyZk51YkpoS1lTcjkyOURqMm5X?=
 =?utf-8?B?aUNGbkt6MTZ4YXhxZ1dYak1wVllOM1VpOXFwUTJwNkRqVFlTUHlNdW1jQU5i?=
 =?utf-8?B?VjE4YXVSd3JXTCtWUDBDSDhxZFQvZ3k5bUxJSVNuQUJwZFRxRzkxbHlJOEZi?=
 =?utf-8?B?MzJFYlZodUl3NmUxRkhJM2NNRWxFeHljdHlGT0lnNjlPWGIvK2dWcjdsTENl?=
 =?utf-8?B?THdzOW1KSVk5N2RvZDE4NmpFcjAwb3BTM3R2WnB2WnJPM0pWWHMzcExqalZS?=
 =?utf-8?B?a0VMUXJiVTkvaUhONmtRcHpwcVRNZnlic2JXWnhXQW12RDQ1bDdOU1l5SEJE?=
 =?utf-8?B?TkRidzJ2bTZHc2ZYdks5RndOcnpybk1zR0Q2d1ZTVE5rQUdYVHBZSWd4ajI5?=
 =?utf-8?B?dnpLc0wzMHJTTTA2TzFlcnY2MFd3TjM3dmp4ek1sc0dpcnZyd2ZCSUpxc0JG?=
 =?utf-8?B?RVNSdEtJNmRpOEtZbjFnalIzdHROaG13R2RiZFpoVXY4b2FGQ2ZaK1dKL3hw?=
 =?utf-8?B?UjVOQ0lJT2UxMTVFa0JlR1Ywc1htUGJZK0lDbFVmR2dZNDROT3JTTnVEaE5l?=
 =?utf-8?B?RnB3d2hZUmp4cDZxOEFVaUVuWEMrYi9yRElud0svOHFrWEEzU0VYbkd2Wnp2?=
 =?utf-8?B?T0ZENml0QWZ0dmZETVBnOHdaN1oxaHd6WHdYRE9XRU5wWm04ZVozNVc0NmQw?=
 =?utf-8?B?cXQ4SkJJaVB6TFZkM1AwK1Zva0loZzlmVExubStQNFBKTElFOXV6cVdOQWVP?=
 =?utf-8?B?SlNHQVdTUWhWUEVodVNwQ3NXdG9neWlkZE16clJYdVYvQnhLYktEaDQ2YTdl?=
 =?utf-8?B?UEw0WmRLRE9rekRiNnd5ekdTeUNMOGhmLzNPajVoZ0V3bmQ4ak5US2h1YkRG?=
 =?utf-8?B?YWZvVTBjNC9YaitLR1hudHVubWVTdmpRbS9RYm1WMzB4L1ZRUHJUWmdXb3dN?=
 =?utf-8?B?b09kVUozd0MyazhEc2wzUmpJc0h4MDhvTDdmQWpNU3ZNK2RGY0dFd0hjNExU?=
 =?utf-8?B?cjhLTUxUYVhHTzlBQkt2QmY1SXFpV09PeHpnWnM4NjlOVmJ2YVlNNjZ2RWRi?=
 =?utf-8?B?TTZKS0lobkdyZkJOMXVhMTl2OFl3aFB1RFQwMDVsVllBQ2owNXZBaG5OcUVP?=
 =?utf-8?B?d1NnbDgwMkNBbkszTldqVDFkMlFnQjJXQjhNM1hwbzF2N0dNbVhXdElCaUpZ?=
 =?utf-8?B?YS9vbVg1TWpQZ3F3V3R3N1JsWHV4TVRadVJiVFpzL29wYUxNazRmREx4NjhW?=
 =?utf-8?B?ejJJc1FnUm96RWpHbUlpb0VDcFlzaDJLNGFKTnNlSlUrdlB3V0tiQUxVRENL?=
 =?utf-8?B?L2V1SlFFeC9vTUliMWRQeStjVzZORnd5aWlYbzRkYjhnSHFJUUlhb3dWK2ll?=
 =?utf-8?B?aDd6aS9HckExV1RxaXNJa1FpSzdVaUVZVGc3am9NMDBTVGJDRmsrY3kyZEND?=
 =?utf-8?B?ekQzOXdsYVdad2NhK3RWNXM1MVhFbm96ZXZtemhYb3pqcTNJcWtReDUwdzVM?=
 =?utf-8?B?V0hna0N0NkxMSW1MaGZxNXNiWlJRRkFNTWtmeTdrMlRUdGJjem9QdGRLd2d2?=
 =?utf-8?B?eEt3eFNFSnVyVnFEVDhZUUZOTEpvSkEveVZ2RTlFcFhkM0I4R2o4UER5eExN?=
 =?utf-8?B?UmNkcVViWWxvNmdZTDAzNWh4NWR4Nm1kcjM0RlQ2Qk56MGl2TVpCM3A1WXND?=
 =?utf-8?B?Q1V3c205WXJGYVFvV3dpaWxvVWxXdHB6RmdjaUxPYXhJT24wdjMzZDNteDdh?=
 =?utf-8?B?eFFmcHR6eTB1Z3FOcWU0enMrNjllMDg3YnVRSGNhenJ4cktyWmcyRkNiODl2?=
 =?utf-8?B?VzVHODErMHVHbERKVUx1YmsrU21UQzNpdi9tbUc3NkZCRzBjYnRNc3dsZUZW?=
 =?utf-8?B?ZGxSQVdnVjVyUlQ3ZERlSGprc2J2YTZMQlBDUXl1YzcxMTI1ZHl4NFRGUFRL?=
 =?utf-8?B?S1NsZC95bVcxM1NibHF4UzZuOFJsS211NmRaQUJBcWkvQ0R2L3doMjE5RUN5?=
 =?utf-8?B?NDg0eUE3R2hQV25teEU4R1ViV1gvTW84b1NObzhyQ0pIajQ4TFc2ay9HbXVm?=
 =?utf-8?B?emFhZmFtU2pVZG03VlZIRmJxSUdlazV0eDYvdDg4N0lrVExLc05BbGU5Skxz?=
 =?utf-8?B?Q0hPenFLM3M3RyswUHJEV3o0YndHKzdmRG9vT2g5c2pIc2luYXQ2ZWIzQXR2?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ac0411-0a41-4ad6-191e-08de3bf4dae6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:13:16.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Bp/g4hzQWA2ffHScfTgCqZrd6TIcwMIC9NlMc/xurKRxtJU7RHhJYZ7wGcPxKlLIfliJoHZdju0LUeJuIbjXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5876

On 15.12.25 11:28, Florian Bezdeka wrote:
> On Mon, 2025-12-15 at 08:14 +0100, Jan Kiszka wrote:
>> On 05.12.25 10:03, Florian Bezdeka wrote:
>>> One corner case was missing a normalization about the timeout value
>>> supplied to select(). Extending the testsuite to make sure we cover
>>> that case as well.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  testsuite/smokey/posix-select/posix-select.c | 28 ++++++++++++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>>
>>> diff --git a/testsuite/smokey/posix-select/posix-select.c b/testsuite/smokey/posix-select/posix-select.c
>>> index 154b3d730..6d1fcaa0d 100644
>>> --- a/testsuite/smokey/posix-select/posix-select.c
>>> +++ b/testsuite/smokey/posix-select/posix-select.c
>>> @@ -143,6 +143,30 @@ out:
>>>  	return ret;
>>>  }
>>>  
>>> +static int test_select_timeout(void)
>>> +{
>>> +	struct timeval tv;
>>> +	int ret;
>>> +
>>> +	/* Invalid timeval, usec too big, normalization to 1 sec, 1 usec */
>>> +	tv.tv_sec = 0;
>>> +	tv.tv_usec = 1000 * 1000 + 1;
>>> +
>>> +	/* y2038 speciality ahead:
>>> +	 * select() services provided by Linux and Cobalt both normalize the
>>> +	 * timeout value before using it. pselect() services do not do that.
>>> +	 *
>>> +	 * As the select() service of libcobalt is routed to the pselect() of
>>> +	 * Cobalt we have to do the normalization in userspace. The test below
>>> +	 * is exactly stressing that case.
>>> +	 */
>>> +	ret = select(0, NULL, NULL, NULL, &tv);
>>> +	if (!smokey_assert(ret == 0))
>>> +		return ret;
>>
>> This is checking that no error is returned but not that the timeout is
>> actually > 1 s. Maybe use a much larger overflow and validate that as well?
>>
> 
> We can't really check from userland that the overflow was correctly
> handled. I will try to add a check that the select() call did not come
> back to early. The upper boundary is obviously hard to test as we can't
> predict the jitter on all the platforms in a generic way.

Why can't we check that? If we set tv_usec to, say, 2 * USEC_PER_SEC,
that should be noticeable. For practical test, some extra hundreds of
milliseconds should be enough and validatible.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
