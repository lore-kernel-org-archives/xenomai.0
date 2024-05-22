Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2047.outbound.protection.outlook.com [40.107.13.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4DD3BB21
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716363392; cv=fail; b=rf4uPnBRf26MtYs8qzRgI6MuR/qSQWD+xpeRQyKv9MV7VkMvuNPJUl4BvwmcGUm7Ojhl8y1BMLlMO00J8RM4QwpVbkhhuNjDIucmGd9soG2cfmakznQ2e0UFMrpBgT3mxniy44EPF2DyPCG+/BN3/m6sBPND5FxBVWnoIc8G8fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716363392; c=relaxed/simple;
	bh=rBW5SMf751s+PKyC2dBHNIReESPw5lBsK92OKveo8bQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LkJp0WPAP2icrFII3r6XDDn+2xzsYFQ+bC4FmOChfbbzcQMamymCbiE5e6U5m4ODA9BK9Ye7IaaczGatKxA8nX8LnHjYvthX1GsDLjHFqI/qzBXmq/07pFwCed9iHBCj2DgmSp+595mu/Lf5jni5B6Y+bof35ZbRu/lo229jQlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rxK2tlo9; arc=fail smtp.client-ip=40.107.13.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rxK2tlo9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPpqPp8k/o4n1SiF1gfyCulAa1xJxjwtin8zVbZpleb+8nc6iPlYtxj+UM1i0bUnfpA2xlpn6Th6GCejOXQ4SPiG2N3rtvu20/R5+xlrDUH5xDNuqNqrH+bad+/5+d3D2YBl8gY33Rz+a+KsvSh3eyh5hw18kHKWE7f8ZxvGbrQjG0L83SKtqvNY/es4CiRbFJjD96oHVpmZ+uErFwU34GpmfI/mkaZBgnpqiBrDTu//HCvirlizufs5bGd5eLJzcYQKomcWR9S58ZBLowsNv70zyMNrCzr80Qv/6n9MtcGjJhGoEScvy442Z6XIlla7FsRJED/nJTtledeyHt3Ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wV9LLGC0TBJRBcKT5oyLMDZs03ToEoKy8/Q7CPUCkx0=;
 b=V1hH7mOHHhsiMre7nhGI5gLCavXC4kojK5ygYSBKgOvOwiw8OBCZF6rULtbh9xf8JNvz2Pmc5wiqUgguuathqkxxhZMk3bKsV16UZNTncFwFs/BO4r7mlP/C71IBxj8KhG5Q0W6GjD6CxT6kPclWly5+Tx3lUmyu5KMDxBDsyvRS79UKZSTq5dsTaqfIzrrtjCAU1tt+zDMa9mB22h+41e5xUScshyHtgqzGS7dY4gA443cYHeyWYuuE4UuBIYCeTlLFRh1OiwlKogmkAyIx9QXrg7i/2sPEpfIFXR9NgqR1C2pAbLev7zpR5X1IGoDbnAW6OhmcKNbny1lK8/joqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wV9LLGC0TBJRBcKT5oyLMDZs03ToEoKy8/Q7CPUCkx0=;
 b=rxK2tlo9qdxPJx/INty4+H5vNSMdd09QP0kDMh9ZolNmuceSU+zXZnqEYo49PALFSREiSEuqCIrLj1jHQFx5Ll904ub7IbyHj0RA5IKVHj40Q70FlbVQlyF9HupmJPSnL+qVxPKkAjjbwTVOilrOc1K6QoGYlPbUoGKQfzLY95GHI3BY4dDhIW8EosY9LBwhS8sTy27ZYSl8dVqRdCWlb3N0MfBQvIuP0TAAiI5Qm99vtW1U3IBIhYWnQ3rku3vlEHv1hBgcF55rwJJCvn40yPCsBA3G/xbYralv1E3QkR+Pz0SpZmg28PQdGjyT14AbhitiGphQMdkJf52mpLihnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5985.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 07:36:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 07:36:25 +0000
Message-ID: <1296dc7f-1435-4796-b317-7f9c01d261cc@siemens.com>
Date: Wed, 22 May 2024 09:36:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/spi: Avoid legacy functions and types
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <5b789e4b-5375-47fe-a49e-f48fba026250@siemens.com>
 <CAFLxGvxHA6fOAHs7kzs1i8stS81q68rzq4xGqbtP8NC6Q4UdDA@mail.gmail.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAFLxGvxHA6fOAHs7kzs1i8stS81q68rzq4xGqbtP8NC6Q4UdDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc36e0d-0cc2-4ba8-216a-08dc7a31e2cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1A2NW1tUjRKSHlLRWpRbUswVEV3V0lDaXc2RkJRN21yYXV4U1VtV2E4V0l0?=
 =?utf-8?B?RTk4YUpBYTJabU55c3N3eUh1cFZqbHFLcXk4aUk0di8zNVdPdjFGSzloZldZ?=
 =?utf-8?B?QVh4UkdRQjk2RXI3NWJQUHRWdk1ySVorUTNMemNCNXBSRWNxd0pQT21iVlNC?=
 =?utf-8?B?UTlTVnhLQ255b2F1Tkdoa0xnS0NLVU1EMzlpQ25ZR2J0MURRZW5oZVluY01H?=
 =?utf-8?B?cGkzazRqNDZ3b3RwR2NLVWR3bVQ0dnJteHczZGw4Z3doZnZ0Wnk3SDNOSkRI?=
 =?utf-8?B?MXVOWkx5U1BKOFdZQnFkSUE5RVdEd0xMSW5TQTNUTXluY2NVcHZhaFFHNHNa?=
 =?utf-8?B?ZEt4QkpHc01nVVlzRE1ycStwOFNvSWJtdEdaNzV3MHVhZzJiMDdKZm9aOGRr?=
 =?utf-8?B?eHRCZUtobG9ZSGp6TUJqUzdvaG9yekYxL1QvdmxhOVBBS01QL0w3N21GTFhj?=
 =?utf-8?B?eWhHSytIbzF5SGh1K1JFNlNxTFZILzIzREJoZDJINHlrYmhORTJHRDhOcmt1?=
 =?utf-8?B?QU1uY1hINTFkTVBHREZWTFpwcDdjb1FtUVZWeVdaZUpiWm9IWmVQandJQnl1?=
 =?utf-8?B?bFU1QTJsVnQvbzRXVUVKZi9wWmloWG5oeU9TK1huY0NvcHpjNzRONHk5cG1J?=
 =?utf-8?B?V0Zmc0JwL0w0ckJOVFdPZmErQUdUSVpub3piTUJLNldWR1lKaExKemJkejhs?=
 =?utf-8?B?b2RQeEQrODBmSSt2UTVubVo4OUV4enI5b2Izak00UzFVRzlyalBLTlJqOTZI?=
 =?utf-8?B?U09hbkRKUk93bnJNSENiK1FORUVMVmJuRzFaZCtHeVArSXRTOG53NUpYL3cv?=
 =?utf-8?B?UVVscGNEcERnRFc0OUtaUTZhV1Bid3RSdDVJMjdZU0FTUjRiSGhlTDR2cEpY?=
 =?utf-8?B?UXUvR0Z0OFVRTjNoTHdLR0Z3NXlHc3g5MWZjY2hobE9TM0FYSHFQdCswSUlT?=
 =?utf-8?B?WXlwR0NnZEU2MmZpYVVSTDVZUFU5Y3RCRkxtUDhQc2cwREUzSmRLWWRGeDBC?=
 =?utf-8?B?d1ZrOWJXSEVwbS9OZVVhNWNxSnFlR2dhT2dXRFBLaE9LSXRvMWFWS2UzYjlM?=
 =?utf-8?B?WlF1UG9sbmFlRE44eHMzbVBOa3pEc1lpZDRZbm9IMUM5ekFBaG1qOXRzNDB1?=
 =?utf-8?B?WTBRY016WGpwSmFqaldxTk5vVmFRTXgxemkvVlZVOW5laDMzSUR0anFqaFlQ?=
 =?utf-8?B?bTVHbi9hWlh2REZRMmpWbEZSWG10U3JZZ1ViVTdRY1BNM0xkQVBjT0hiWkxV?=
 =?utf-8?B?UkVhNHJPcFYrc0xzWmUxS1N3VjZubEFHb1gxbVQrMXFYRHZOSXBTRVN1UVIw?=
 =?utf-8?B?Y283SFQxOG5XQ3ZzbEtOQ2dvUmRzV1dSYjhMQkJtbmQ4RDZOdHB3b1hiVTJK?=
 =?utf-8?B?a1N6OVZLK2Jub2pxTlg0Q0NuMDRYRStNdlRYc1RLNTVaQmZJY3BRZ1dxTEl1?=
 =?utf-8?B?TEhYMU1WRzlOTzdMcWV6T3g3cVZNVXUwWEZrb0QxL3E4ajc5aEkzNjI3bkdr?=
 =?utf-8?B?Y1hJN0dxWUk1OGROTnp6dWVQQ0VEV3ZXQ1lwVE5uTmlUcVdVMms4OStTNkxZ?=
 =?utf-8?B?OG5ZVkVHZkZhUFFjTWEzOGtmRzJ1UVFyb2lTMUFhbTdGVFY0UGsybW9xbTl4?=
 =?utf-8?B?WlFCd0RPdnJvSmJmS3JzOWVWU3I0VnpPMHhVTHVBWllvZXQ2cE85WTVoa1pm?=
 =?utf-8?B?UjJBbWhpeHV0YW9Fd3poVXpaclBkWmFhRnFEQXdKT05pWTdlQnV1TWR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rmg4UmdISFpzOEZiOWo5LzYwTG5SMVZZWUk0Zm9LM2hHWS9McC82bFJIQXk5?=
 =?utf-8?B?ai9TcFIxNDdYQzRuanpSWUliQ0JIUGhDd1NJUFJYcG9Qb1drRFJhZVNCbytw?=
 =?utf-8?B?NFlTSTBXMU5KUnM0a2UxYXJCLzc2R1BFcW0xUExCNzN0OExtM0cxaUt4Z3oz?=
 =?utf-8?B?WUxVU1AxdEdLN1cwZ0paWDhmbmM5cXM4UkVOeTdLZkluTFhXTWpKQ2svSDNa?=
 =?utf-8?B?bVN1enJSdndQdVg1cnYvd2dGOHB1L0dVd2c5QlVySFAxa1NsK0tra25JbzUr?=
 =?utf-8?B?RXV3NVRXZ2kzOGF4WmxEeExhL1BBeE1wN2s0SXZYc0x6ZEt0T3d6MGNhWURj?=
 =?utf-8?B?dVpBdEtJRUtPbVM5QjNkK3JXaHFJL3NtVk02QXBBZVhuY24rVTk1OGkvNHc1?=
 =?utf-8?B?RWRvbEFlUGYreGcwV3VDUGVpSnNqWkJDajZzYUI1cWI1YTZwVXJ2S2ZvZ3Fu?=
 =?utf-8?B?c2MzSUZSMGU0NHpQTWg1aitqNVk3aGVtSjJDdnduNTJlcUU1SHo4cXc0MUx3?=
 =?utf-8?B?dGVST2tZcy9SUmFrVUQxYXI2NzFDRmZEQXNSY09oVGxyVGNZU0ZKbmZ2Mnh5?=
 =?utf-8?B?VmVTU2hoa09LQU1yT0x5bkxTWkwyRlhwdUR2UTVUa0lkUEZvbEtGbG1kRStK?=
 =?utf-8?B?ZDF3TnBGalpjSDNiRElpTGRDcUR0WFZYWTBCeDQwSnJCTXE1UFVkQlRHRk12?=
 =?utf-8?B?L3FlNkNXZmJGdVFGREhiNWRNcUNrQnBwQnhhR21RRTZPUUFaYlYzRHhGNE95?=
 =?utf-8?B?bElMK0s4RlhreWRRTUJwRVlibHYxd2dyV1FaYzhlQlZZQnFhbjRUU1loNlcr?=
 =?utf-8?B?RjJ1N21kdVdkek1RT0luYlg3Ky8zNGNCVW5MZ3MrNHYvQjFiQWRNTEtFMVZO?=
 =?utf-8?B?RTY0UlFWb0RIMm9heGNxRElFVHl2RmU5ZkpaQ28xY2RPRDk3TTNBMlNDZlBY?=
 =?utf-8?B?RnF5L2F4S1hhZjJzaS8rWGk1M1BQdDd1a3RuMlg3TkR5eXdVLzloK3Qvbm1t?=
 =?utf-8?B?U2REcGo2UXpsbmlMOVlpaC80YVdHeU8yMlB5dTE2MFk3S0puaVdiZldKZlQ5?=
 =?utf-8?B?ZEprOHV0V2N3QjFKeFZ0bS9hTWJaalp1M3RObnNGYmRkbnhOVTJoMWU1Y2N4?=
 =?utf-8?B?bktXTzI3M3U1ZVh4UURQU0VxczVrWHJ0NjNYMEljWjlGMCtnek9EbHR3aitJ?=
 =?utf-8?B?Vno1UHVqQ2xnRldva2pXdXlPTWpxQjhvcHRqaWZUblVjcWtDRndoTWhtaXlm?=
 =?utf-8?B?OWdzMTh2Uys0YVFseG80KzQraUpWVDA3bUxDRGIzZFVQL3ZyQ0tydi83YStE?=
 =?utf-8?B?dHc5QVd4cy9jMkt6MGJwbmZOaWxqaXlLWVFSNmRRdURmeXhZdzFjNnJPUkRk?=
 =?utf-8?B?N2wwMDdxekFtRmQ4MEt3RC9mOHBOL3BLdUkxSi9JWlZTMy84SkdVU1BiYmFR?=
 =?utf-8?B?eU1nSXdvY3kweDMzeFp4bmx5ZHVwUVJ2WjROYlJrY2VHSjFDU29ZVlZETFZP?=
 =?utf-8?B?ajF6cUltNGNuODlIbUlvYkd0ZkZ5ODJRSGtDdHl4RFUxZTY4WFU3VVc2dGZz?=
 =?utf-8?B?M0ZOMHQxSmdiZVo4UEFPWjVrTW9UVGxwRGVnN3pkOVA2MjFjcThSaGlFSlhl?=
 =?utf-8?B?aGovd1MxWWVpMVJRRm9MazI5bXBpSlA5OHdlWFR1dXE3S0ZraytnVFR4bU5t?=
 =?utf-8?B?elpsYm0xTlNmMURFaEM4QVZQN0pZckZHMURwSjc3c2ROeVRQWnQzTXd0LzBv?=
 =?utf-8?B?VDFoSm5Rc3hnT2ZmaUhqa0lQOGQ5b25KbWE2V0s0SnF1M25ra1pqZXNXMXpS?=
 =?utf-8?B?WVZ5ajNtcFU1aG9qbXNDSkFCV1AvemhwV3g1UFRiRm0rTEd0SUZoZEtVRzZY?=
 =?utf-8?B?aU9QZ3ZDNVVyNWVrYm1EYy9iL0UwYXpyN3pWOCsxNExIY3JadFE0UXRjbXlj?=
 =?utf-8?B?c1RWakZZR21PNHBVYlh2N3J1M2xLZ1dsbldUODNuNzBmcjY5aEZqd0JoMkxj?=
 =?utf-8?B?MWd2L2pSRmJTOFlDSVBEK2UxdW45SW5JY2tJYXlCckxUaUIwcG12Zm9vTU1Y?=
 =?utf-8?B?Ynd2Q3ZMUlJOMldSdXIxekYxU2RyeWlXdzI3U0I5SkdvUy9PbEhudkx6NEdQ?=
 =?utf-8?Q?+3vovfD2YVfTwxg3ED/CNzNwx?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc36e0d-0cc2-4ba8-216a-08dc7a31e2cf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 07:36:25.8190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9afvMz45Ad7bmkAKAVJnCHi6vBxMCLREHtlbrhfsT2tW/MMOfp2T4SnmehWnJ1SSSsKPd7Mnr7er5MzIwdvWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5985

On 22.05.24 08:53, Richard Weinberger wrote:
> On Wed, May 22, 2024 at 8:00 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Those have been dropped with 6.9, but we already have them since 4.13,
>> thus before our current oldest supported kernel.
> 
> Are the supported kernel versions somewhere available?
> scripts/prepare-kernel.sh should check them too.
> Currently it tests only whether the target kernel is version 2.* and
> aborts if so.

Implicitly: master/next no longer supports I-pipe, thus is limited to
5.10+. This can also be seen in against which kernel versions we test it.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

