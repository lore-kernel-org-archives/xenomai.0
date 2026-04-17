Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F87347532
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776460371; cv=fail; b=SbAtE5WoyRQyU+8s1wsZiM9EhtDLrufic/bQiAzYnuobThuDDfD6DV6DGwp0rg4vPIFZ0JaktbT+BPY09lCkJoxFR5shKNbmtzmWQeUy/KXUxMxN9BXHxLKACwlYf9gIPA5EPAHGfoP7/1/Jx2s9b5Fdsr6xaSG7/UKR0/D2QEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776460371; c=relaxed/simple;
	bh=5nXWzzflKt6jJI49iGEyxM6s/npZ+i5OkSgqngmhTcA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YJLWpwi54ioEBSyi3swfNvWFyZBEUekchCJ17O8LPhBwGbHP8AGJcrbSTWzqrwBd9NWEerdlOwYSNRVRxT2X4RStYWETJdrfIA8XurCX85iOHNGPDiBIg5kKMj8gE58n7NRkVzbWA9eyW2nT2Rrmwi30THft1FWPg9pJPxsOkkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=swmxh3Zx; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="swmxh3Zx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCmJdJuLS3y5qRPE8z3BX1q7WaZm+W3TxQsTnFTObPER2Ak9aVg9NrBXpr6o0/yRZP3Z2ItYObpbSjZ7DnDLiTusH9gwwsdAR+g9/QOejUx7QaQrgFinRiPFCVod+YdqvkIBlVEKI8+1F1sIOG0tWDzc7fhqWGi7+gdnwXzeRR9RjHPMmMOjwxCz/kCPLMRR7Cj5KPCEk2mbGWrpKhUgWA8iSYZvwqOoJcpW0bTe19zUt9eOMSYzLsIBU8Dv67/PVNzlwQTY5qttAYlAFtUzwY2UzxBBSEW7VjDxo/ybjh7RIoE/WSkA+QScZnedlJX9QrZOUj+Ky48Sb5ie96DJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHJ9ehYJZUlaCOgqINx04eure2FuKMmGZtt3AlUCqoc=;
 b=x6cUl7jnAwSTqIpqJKlHXNjZtBqok+fznq1L53ZyovTjbB4tACoNmAiK+sdBqu0shgfyoGt5RwxYxmY6SRdBIbuArKFzrtMCxPdC2/ZN5eexWs51Qhn42UIEqPmMnGVNv3cQXZL9l0waepPC2PGmWoypnGoK50hFNRgH+5rXNdSPuQh6Bo68XVfxqIBi/PJVlGObX453suRPchCGQ8AaExYIVnGGe6bzZDcbUPjx6r3LbKmS3eZafNEwTeRkIBn9HpZGdcM1UYh1S6sMyMzRb1QhmT5vbM+T9J54IjC45y3GdtcrY72+tGgWkHYowRY52xB99uSnGmY6n3/7qHNeyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHJ9ehYJZUlaCOgqINx04eure2FuKMmGZtt3AlUCqoc=;
 b=swmxh3ZxQLJJGdFFivkfB1Nt/0K8Ag017kyHk6WLErdlwLnLV3HlzlMGalqu3L9hyP6yUxlJoXAdPJAz/2yHaiBUrAaFGTugG3Q/mpefRIiJuHH4TerAfrM9yrG1rwwTvq9yezMc5nvn1/63E4vpY9gWiicZ39z8COrOiDsRJCfMcqJ7C7YIfw3icSpeba6ytf1/d1sX7X1INbTX5SVOoC52b0s9CEZfuMGYpRdd/LyCS59l3y1x/txrYkYwogGihmVF/X4023HGR62h18aQjHJ0AWaulppuBRo+kLDDU02wheQHd+tlxSYtWCHAjJdK4oSPoKmCqmDC2xEa6pVLHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GV1PR10MB8568.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 21:12:44 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 21:12:44 +0000
Message-ID: <9668cb06-1044-4445-a156-5277cb428030@siemens.com>
Date: Fri, 17 Apr 2026 23:12:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-evl v2 0/2] Add RISC-V support to EVL
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
References: <20260320214149.2211433-1-tobias.schaffner@siemens.com>
 <926a16df-6114-4fdc-b2d7-70eb66eb9db1@siemens.com>
 <f554369e86fbe5c84f8a663456629ed28256677e.camel@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <f554369e86fbe5c84f8a663456629ed28256677e.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GV1PR10MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: aec536fc-d003-4f83-d2db-08de9cc61180
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	KI/5en1UgVeP3jOfT6z29ZCgGSi40Kp0+BLC1SqXioDLQiq76rxJm9gtp0H6GZysSbooJOk6BphaLy/68F9BOiECibG93yIq9cmX175g+RdzNqa7CiSporIa7lesbapGLV7YN+tK2CRjruUsWTcEEimhN8jS5yHbmokT3vvzGcZLkxJMRIaj6ozFBZUjXzZrbdrJVRNq4gUi53RBEhC5WCHcolbujBuV/a+GX6m+KneA91c0BVpCxC2bq1xxmGJRKo0uZaLQ9wYOWZ3XArDe6wz46kd/F9772urt7hWtN6uFDw+37nGFE2OZEJm3r4THvDECrWzKpeAjHVObFpsikK/pNugIe7Q2nufTwzoTSg9fLVucA5xNfj2++0tdmcf2pSrbQCLaI3/X0RAhjtYwLsxUGV9WCJ2h+DhF1HTEUeo/sOUA//cauw0aShpCBkDGmmIIu1QhRSWv56Qw/4LsCTrQR1iNfqSsW+MlFwmAOnhew97LwcKDJMJkvHbx1FfiDa3mMzQoYkE5ASU41PFcRboptZNl6jJFRHp+/Bfi3+XWcifJrMxYtSUqzeRjNQvcxkSEepjaFLYGeKH4F8XA8tvAFifpKUM0lY/Htkpl6kVJDg0ce28NX9Tr10R3gofFQhYjrLy/b0aunalIk7bpCZqZXpQtCirvFGMcrhvqkBTy2j68u+IlqKaK+zMMr6pyXE/4TTXZyz4f0xkWvHmGuII/wXEJkhWPhFJfC7xI1x8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXZzaElQcnl5c2NSaVRaWjJjMEZnVFNxc3BQMys2Z1NNRUg0RmVnTmQyZFJV?=
 =?utf-8?B?Rm1GUGljaWR2UmFaTGFUL0t6SkIvSW9hQzBaVW4rQWhpbUJidVZycnluY0c1?=
 =?utf-8?B?RDZyWkYrQWdTbnNOa1M5c24veVZQT3RjZnJDVlRjMUFxQzJzUkJ2M3NUN3Jm?=
 =?utf-8?B?RUZIKzd5d1JHQUdvbDlmREdXcUJEVjRXbUxYNlI0djZkS09ldXNFdFdoblBz?=
 =?utf-8?B?VVY4ZmM5OFl2OWVNRlA1Y3JTaTNDL2g0ZU82akVkR0o2STJyVnZNTG1lcmRN?=
 =?utf-8?B?TG5VdlFsWThmTFJMTVRlQkhSSkVEcmlYdFozZERrbm91U0RvQ1M1eVZDcHhK?=
 =?utf-8?B?LzQ2bElpblNXOGlPbG81RUcybjN3UmhVbWt6R2tDNXJGZzAwZXN4dk9CWDRh?=
 =?utf-8?B?b0JvVU1jdjNDMzh5blRlS2lha1lQMVU3eEpWOExXY1VZWlFVZ05wMFA4UnYw?=
 =?utf-8?B?ZTM2Y0c2MjRYelpva2Y4c1NmY29QTFFyZXBoUUM3NkdJZVF4V3NSZndyeGVo?=
 =?utf-8?B?TDgzaUFDdW1vQlNCK2hUcXhoWEdzWDV5N29FKys4TjRJVmxwdnFJcXB2VDBJ?=
 =?utf-8?B?MnF6QlN5NkE4MGU2YlVoWlNObE1kazdzSVBLdnhKWGxTNkVkV2Rwd0VmamZx?=
 =?utf-8?B?MVhManZhT1dRUXVGNkxjcjYwdWdiK0M3dG1CQnQxaUtWMlY0dmNVWG1XRXJI?=
 =?utf-8?B?MzFNOHhQeENQRWRKTnpqcFc1WCsySkRkdXM5MWU5aWhhVjJNVi84VEloTHBn?=
 =?utf-8?B?YjY5QkQ2LzdqTjFMWnR0QU9lWkVocXFGcW9NN2VheTlEcEIvUW9yQmZIdndu?=
 =?utf-8?B?K25TQzlIVnZWbjRpSC9pT2ZBWkt0N21zdDA2dlA4OER6Y0pMZElJdENraW9k?=
 =?utf-8?B?WHJQbloxYzJkRk5ERFMyLzB1anZ4b04velpwbDVaV3lTVDVVSDJsUlpWZ3d6?=
 =?utf-8?B?aGl6VEtOaklQdXhZWVpXSm85RVg3K2xzT0RvMnJLWVZkTFczYk5mdnE5MGdY?=
 =?utf-8?B?UnN1RmFsaFIyclVIWWszZmRSVjFaMWpwZHY1UitRZkh4VEpPVlZPeFJDNE9O?=
 =?utf-8?B?NktrWStuUGN5MlZwclNhM1VzcFBINTdSTUgvREw5TTVzZXRKNURwZzl3aWNT?=
 =?utf-8?B?YkxmSEhLWEVmZE9HZW9aeUY2eWp6bGFnVFNNMXBJYnpFSzN2cWgrT0l2elg4?=
 =?utf-8?B?elZFZm5vQTRKejNaSmU1Q0ladHBwWFRRMUVhODYxL0xGeTkvbG5VekVSUCta?=
 =?utf-8?B?SUpkaGp4NVgwWHg5RU1vL0dKS0RxU2VndUtaKytGWFdIdDJaL2JzSzNsQ1dN?=
 =?utf-8?B?cmI1bUdvY2JxRzJhNWFIRFZDbGdCdUorQlQrTFA1QkhGTkZyOGhnTDFRR09G?=
 =?utf-8?B?UEYyS0N1VXNhNXBMSk5aZ3VralJOZXMwZUxHWVpRZnZXRldGMnd4WVVtbHF6?=
 =?utf-8?B?VHZpSDErM0gxUzE4K0RyNzAxRnU5dWZmSnZOWmdER2V6Q1BrdUJiVUl2Nk5P?=
 =?utf-8?B?TWs5UCtLSW45YlRJU0hYMkNqK1FsS0d5TitXa3R4L2RLekc0OXdlL2xlY25h?=
 =?utf-8?B?VEdMTTdlWjdHVm01R2w4bkFMdlR1bDdKa0x3Y3RONFF5YmxPR0VnbDE5QndT?=
 =?utf-8?B?UUhJaXZBekhUUnhZVlNXVG9SdXhCL3VOZFMrY3FoWXVuOU51ejEyT3czeE81?=
 =?utf-8?B?dGg5SHZyQmdGUlVSQ0JsRGcrMDN3azd6dEc2dDBYM3N6VUtVd0dWNTJ5bUVE?=
 =?utf-8?B?OTdvWk56WHBpVWl5TXlCL0g1MGhPdndKVU81d1FRWXZrUkkzZ2tocmxRdE84?=
 =?utf-8?B?ZDkvQm5XdUovUlpvTGtXM0NvTTd0NjRPVU5PQ2x2U0s2RmVsQ2xkNVVqK096?=
 =?utf-8?B?OGhRRWVRZHVSc3MxK2Zmb0hYZFpUQkhMZ202NEFpS3JOWWFWOUxrazB0OGFN?=
 =?utf-8?B?TDhTdnlFM3RLa1F2RnM0VWMyNE5QTmRlV1VNMWhFVWt4dnU2UHA4K3FDVkJy?=
 =?utf-8?B?UlJZb0JJS2liM0tmR0tzR0IxbzUzUlhWOTNWbmxscG02TTBkVHN0MC9aTG02?=
 =?utf-8?B?L2JlMXd0c1UyaG1yOEg3ODkxSm1VYXRRS0xpZnpnMHZEdDlCZnVRVVJGRy9w?=
 =?utf-8?B?UnpVTU5oR0NHeXZsSVdMcFIzTzIzVFRQNkZrK2gzYnI1UjdNY0JxM3o5TWlQ?=
 =?utf-8?B?Y2tjaVV1YXBUSjdEUFdmM29XZXBseXJTTnlrNnM2dGRnVHVuNHhMNDFwU3hG?=
 =?utf-8?B?aDhYQ3R5RVkzdFZIeGlRZE5vbjFsb2lMRnZYVmFpS3g2aCt2aW5ZZzdydGNF?=
 =?utf-8?B?MFFPdk5jWXZRemtlL21WY3lzdXpONmR0d1ZDcmJJQmVhek41VVFuYkRYV2hO?=
 =?utf-8?Q?V+DykY5FNv7MtrsA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec536fc-d003-4f83-d2db-08de9cc61180
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 21:12:44.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkctG3VTwAISkecYxKP7ncoUOeKuiQGwIb80ph5YfQdjw6fC/zi35d+QFmfdwVWI6H2zMJCVFTZ7wjIsx++1hGLhgsCY9F1kyduIGQpQQDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8568

Hi Florian,

On 3/27/26 09:56, Florian Bezdeka wrote:
> On Fri, 2026-03-20 at 23:31 +0100, Tobias Schaffner wrote:
>> Hi all!
>>
>> Some additional notes on this patch set:
>>
>> This has been tested together with the underlying v5 version of the
>> RISC-V Dovetail patches in QEMU, as well as on the StarFive VisionFive 2
>> board.
> 
> All the relevant debug options (PROVE_LOCKING and friends) were enabled?
> No fallouts during the load tests?

Sorry that I missed to answer this.

I am running tests with these debug options and hope that I did not miss 
any friend:
CONFIG_BUG_ON_DATA_CORRUPTION=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_DEBUG_VM=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_EVL_DEBUG=y
CONFIG_EVL_DEBUG_CORE=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_PROVE_LOCKING=y
CONFIG_STACKTRACE=y

The CI runs without stress applied but I also have no fallouts in my 
local tests with different stress-ng background loads.

Best,
Tobias

>>
>> These tests were done in my home lab, but I plan to integrate one of my
>> boards into the Xenomai-images lab next week.
> 
> Looking forward to that. If we can't run tests on that platform it's
> close to impossible to guarantee that this arch keeps working as
> expected.
> 
> 
> Best regards,
> Florian

