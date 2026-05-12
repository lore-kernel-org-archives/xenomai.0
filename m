Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013032.outbound.protection.outlook.com [52.101.72.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6048C395AC6
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581221; cv=fail; b=XYrLjy9KoI2blkTneEGS0W2TnilzUkazLM4+WFQe+ugUBHbovsncmzwB491YHex6VZOXgZZcctrcLjBrndCySD9CKNOZpBH5h/JFd0GqnX8mS8hznkhAmkQyp7HGYaKtom9es4T1rZIhsTnIpbFq/mcaoI6QAe6eLZenqJTX16k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581221; c=relaxed/simple;
	bh=nRPNKRBV+ds0zM3Zl02G6GKzBzvuLDL+RitW7y9+Mp0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cgSqVDl+J4amYpYlF9lULXmkHfAVjjTZ+aTN/V3ssqdWRkpGjvvK9QOO7z9kOU/Hs5TKDgkLBzHrtAhV3MnONpcjJmf/Poths7m+OrtI3ypnYWJwWzQcOLyyyVRHpJ2vxldGhIPrqWm3zAaHomQZ9iHOpqynVbqfK1k6BdN5Xuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rduVcqxq; arc=fail smtp.client-ip=52.101.72.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rduVcqxq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTcZJX+jX0ofTarMXpjhtFN5PkzGIB0sgZk/nd5B29NCE56U0XLvMi3gmgo/LDJOf0xYjxhWqgptT5HENxN5tbq5ZySaYHarS1bE2EM1aWfyIUi6kwJV721ufCW+etWdk0gcnkMAB5WcTvjeRzb31qKL04nNacKG7DncJtGwZHx2FSn/M9ur1hsGBG/EqcPcmAuTihk2Byc+G9D42KZM4+sC5P0SWFWmpEI3N4sD3vhqazvqsDop40VxOKmpJjPon+Fumwc5v6KCspHRgHHbPImhxYHLZ8sQsoM/guTpSQFQYdKXCmvAf6M1xfyIsNNNKEJEtANR15/gQPlVyl528g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7vIvWvSuOLYakqMDvMAlOCoH62HCoP1qgvrM8nVHp4=;
 b=nzyB5lTerTAzr4LQwl68+h/TG4NFNBArr36qVKECgIWlhENwJgbYd2tA2Svv+tvTFT9G43nV5qdzjwkkRPADF7QAkMdGPq7FWHOhBHQY2MBaHtrCUd4b9rtNxedOjBonKaFvOqcC0odqGbRscWcZB+sd81e0z6ZyEdg6w/XEq587MIZzZnf+U4rsUshk0JOcJbBu5dI9g5VebJTBU2Jf7oQ+O+ic9b1vsB85hFIzpKbwWQpBbCDa8EKGZMw40xpP1eoSPgpZ0jaCAQUV1S5YD0KTHHJXCflCBYbLJl5hWozG65mOtASQFrINrcde+62IKHzD5Zc/ydgwF/NCj+Lizg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7vIvWvSuOLYakqMDvMAlOCoH62HCoP1qgvrM8nVHp4=;
 b=rduVcqxqbTZheJA7LcOnkfhBxO30l6ixKMulAIZqpbQXsD7ZHwggVJQwE14YpZtuGENHtNXQVC0X8O9+Xpg7h7q/LOv2RMa7hlh8aZ0MoGyjVn3KK3Jfo5iicJjueve3zC83klXzSLeIzKeuP4Xr9JhDXabWufETc2LDhR64QBtyiMAToWU5wEn+7IXDDBtaUGtnQoa7f9Vh51wZVj1f3ul2TTPCb2vLWVmIB/O/6Z//V1ne93xpRLBCmDPcVM9MYUHOKmuCC4RivzolMUdFwNTMwIWN1GNCYJKUQjLeW0qxOrGAOujLMBBPNeAPi6IuLf5flrOkT9Hp5dj46FNBuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB9PR10MB7932.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:304::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 10:20:16 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 10:20:16 +0000
Message-ID: <a23d90ac-e797-43d3-80fe-4fa15df47e43@siemens.com>
Date: Tue, 12 May 2026 12:20:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/32] lib: Finish rearrangement of includes and license
 headers
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
 <aca24e6a-977d-428d-b892-403852958a3f@siemens.com>
 <bc8ac763cd82eb8f2d2ab53efc0a7b0275ec2551.camel@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <bc8ac763cd82eb8f2d2ab53efc0a7b0275ec2551.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB9PR10MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 6041afa3-18b8-4c2e-891e-08deb0100f20
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|11063799003|56012099003|22082099003|18002099003|8126099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	9aEQPyc/jWDsg7NDVxRkmGVB0fYTjabgwOYUH8W6Epkv1dbn2zZgiMpM7BOJ70QJYEYE/xnybRYtXPymeCcSCU5pVe7LheWvXl4ShHmTND4r46HFSlvgG/p73EqrHcsjb7rIHq8E0O1f8O6qV3l1z/DMJoMl3W8tw0hlAk/BLLQ1OChMGMBBil4xhXKqiDh8gYgJuUFdx5mwGya8ogkPbMsOn30m1DC6kkyAaIiv6Eh7TfWSoCZ/IhG+iCQkWCwcit+RaM+MRnZzhudr9xSH6iep7nI40xlgD2Ln6NVKPMG+mbXKsOaRMPME/nzHw8cEfK45hZtcnzDf33heWTzxsR1wbYWvOa6n4KYzjccQuWG8JiEVNWwqyd389S8Gcyum8P9O6l6xzSLoqQZLhF3Rlon2Ntom2adk0u00XOFN5pBFWrtZ7Dq+avRxlA9xpiUZytXQs1lwyrKXHLc8fb+TXCl+8u1LtOXS15i5kCn4hjf3tm+n1JKCUaD2mMQgaXTfviK8geVWqA2mIZ8uNUANIsHWMGVrZKXDQLkDXwlN5JiIDs3IdZVFWDoa9pSJvyPwS9GW37MX/3n9yXlOk8/jl4q2R0c55cj44vI9US0RKQa04f3ZT7neTYfn6SBF07pbIQMBgC8ALjmb+jTHXDURk1Gaw/pFda5PfOU22ML/Jjr1cMB/bKfWaQ2OnmBrY8mn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(56012099003)(22082099003)(18002099003)(8126099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d09tcVhqTDNNVnNNT2FjRG91bzZ5UWpRTWJqMnJLaU0xNGM3LzhiUzU2WGRv?=
 =?utf-8?B?aGlDaGZrRVJGVGdwaGliZC9qZ3lTVnNtNGlROEQrcGppVkV2Nzl3ZFpLZDhX?=
 =?utf-8?B?anJUNFUxOTdwOWN5cldwdkhlSmNFUWpsdThaTVRqUFFWZm05NWhVL1NQcDda?=
 =?utf-8?B?aWd3TjFreXJpUHp0L1h2eHhiM3hMaXdVeGFlOFo5eHg0bmM0RjEzVlIvVWdG?=
 =?utf-8?B?ZUh2cUlSK1J6MTVGMmZoZUJEMFBpZ2xTRHBTU0NyUzRJVGxpOExURWE4WjBv?=
 =?utf-8?B?OUVNQXZ3Rkg3aEtUeTk5QU1XbXhnWHN5cE14MUQvelVwYzlJMy94VXBaQ3JO?=
 =?utf-8?B?THU3a3N5MTFQYXlsR09jTWJzQ2pSRUFueFpVZ3NSZ00zd2NJWUpMWXh0dmEv?=
 =?utf-8?B?YzNoYk5hMS94ZERWNSs4OGcrdmVJTnprU0JrbWhoUzByZ1M0S0JKdXc1d3V6?=
 =?utf-8?B?dm9MTjhFWFpsdWlsYVdlSDBqWndVRWJWdEF4VE4yTExqWm9IdHpQMW0zWHNY?=
 =?utf-8?B?QlVyaCtyVVFWQXlsM2IrVjZkNUVHQ2Y3UUdGem9OY1dnK01YTGZFT2pQUjNt?=
 =?utf-8?B?MDhXcmdUNmFFMUFxN3pwV1JGajVnOEFaTXltWEVLTTNOVFIwaGx5NVdLVTUy?=
 =?utf-8?B?NVVYYnkvTUVNNCtzUHBvcnUvSERTL3U4dTFnNDZpcjJ2ZU5OVTRKVUdxTlNy?=
 =?utf-8?B?OGFvS3hCcm9oS21UakRFTUNWV1NUM01yTnFjVG5yLzluMG9IODNqVXp1QzVG?=
 =?utf-8?B?TkFNV3ZWWnYzc1lBWWtQZjVPNllVNWVOeDJjNXh2QTNKclNiTHN5Rk5iWXVK?=
 =?utf-8?B?aUVRb2JzQkxOd0V4a2VBRGFwVTN6bWRWNGFPQzE1RTQ5SUw5d29JTk9NVDQx?=
 =?utf-8?B?a1NOUXFYV3dQenVYZGxwK3VMNVp2amhjbDBVc1VNNEJFNW1ubGVzOHhkV2ta?=
 =?utf-8?B?QUFkUUQ3NUlPWldZRGJyUmNBK0VHYTRnZkFWODFaLytsUjVDbjFVZkFhNTNj?=
 =?utf-8?B?anM5TnpTeHh1Y1Jwc29LYUp0Nmh5TmpiSXR1aWd2RGF6eWdpcFpwQ0dRQ1B3?=
 =?utf-8?B?ZFhKYnZWRTVaTmh6UDRyMG5lck9ZbGtkd2tFdnlwL0Rwaks1eWVSZ1Qrc2xt?=
 =?utf-8?B?Um1Ib0drdy9iU3paeHJmYlJtSWJvd1JPdmExKzNieERXZVFFbEJsYmZSVUZq?=
 =?utf-8?B?TDJFRmU2S0x3US91RlQ1aEhQN01TbXNqS3I3OVJuYW1qamorcGdYQi9DNWtw?=
 =?utf-8?B?NVQ3NS9xR1N6akpMeVQyWXVvWXhKUHR4ZXA5T3RtVTZhSzVXODZsNktjZ2kw?=
 =?utf-8?B?OFRBdVdSTkxXV0dxR2Z0N2pVVS9xY0R0VXRmL21sblkzNFY2TmZ5Wm4xSnY4?=
 =?utf-8?B?YmxaR000ZFhXekN4QTdwRDliWktHTEFXaFBmMERYL1FnK284YjBoSHZWMkIy?=
 =?utf-8?B?QVBHSWlqKzY4dVJTZXd2YzNubEdTY1Q4NXRESUF3YWlraEVENG1yeFpuVDJY?=
 =?utf-8?B?aFpHNzBKYXFMMDJxcnBzYmhUMS84R0V2MGUwQ0p1TU9qZStGOEZtN01Da204?=
 =?utf-8?B?NC9FV2tWRUhzd0NQTnlWeDhpMlVBZlB6ODJveHhsODZkNllRU1pRS0R4eVJa?=
 =?utf-8?B?SmxqU1ZCc2drTzJ0YUNveXIyWlJtSGhiOTE2QUVibG9DVVVaa3JJUXRmK29Z?=
 =?utf-8?B?SEdaR1Foemd3czhodGkvSFdxcUc2UjBnZXk4RzFhb2hVVXk0UXhEV1JoMFEv?=
 =?utf-8?B?L0lrdVlFeXo0bFZELytONW5ObTVEcXV6WTc2bGpLc29WR0NLTkY4ZFlLRGpk?=
 =?utf-8?B?dWJnWEZ5akNzT1QzQWczSXB5VElIVy9mSUVMVVRhbDJVNHFjNzhxUDVnNDZ4?=
 =?utf-8?B?U0xUVDZmYWY4dUMxeDR4VW5TZW5OS1JsVi9uN0dqdGR6OE1DTDVGazBVaDlp?=
 =?utf-8?B?Yjd1bWZ5OWxFWFlXcUViY1pITTVVTko0OFQ0MG9LWVQ1REtZbXFCRUp1ZEhC?=
 =?utf-8?B?ZzFiSnkzODdKN0dpdU9TaVNjbVN6bndvWXlYWDBFUkcxeFJGeVk2Y2JNaWU1?=
 =?utf-8?B?djRTVVAxUEVvOGFSRVg5NW5HNDlHRWZZQkozeUVJc2JxRHZiSmdqQVNDZEMv?=
 =?utf-8?B?OTdYdm1DdDNSQUV5bDdZb3M3UEFaNWVsdWJ1RGpNNnVuMHR6a0xvcktOUkdt?=
 =?utf-8?B?bWhGdHlhTFU0bEx1eFB6V0dOK1JWTkZLVEFLZGVBU0ZReENxaDNZbWpCRitu?=
 =?utf-8?B?dmRGUUc3ekprekVDVXNEUStqMWVMSzBDRVl0dkZSWkY3WlNOT2FFTHhHOXYy?=
 =?utf-8?B?Ni9qOXVoVGFFcmdLZms2dEdMMTZzUGV0c3pnY29iRjNiRURCcHZYTDcvT2Ry?=
 =?utf-8?Q?FQaigenv0sa4Hn5Q=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6041afa3-18b8-4c2e-891e-08deb0100f20
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 10:20:16.2815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hu6vyvMjy1H7LtFx383Q3Su61XXDQ+ApZO9ajzYAfWyXP2C9kLhpL8qMdVQG24RVw0bmSSIGKFfCWY6ZbQRCi1d8Ht1cqWSYN63e5qNV8VY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7932

Hi Florian,

On 5/8/26 16:23, Florian Bezdeka wrote:
> On Fri, 2026-05-08 at 16:15 +0200, Jan Kiszka wrote:
>> On 08.05.26 08:22, Florian Bezdeka wrote:
>>> Hi all,
>>>
>>> This is the missing cleanup of demo/, lib/, testuite/ and utils/ that
>>> was partially handled already in the past as preparation commits for
>>> bugfixes or build optimizations. I finally found some time to finish
>>> that work for the missing folders.
>>>
>>> There might be even more potential for cleanups inside the include/
>>> directory - and as a result once again inside the already cleaned
>>> directories. I skipped that for now, as I consider include/ as an API.
>>> Changes might force users to adapt/recompile.
>>>
>>> Tested against Dovetail 7.0 already.
>>>
>>
>> How did you retrieve the header needs and coverage again, manually,
>> script-based or AI? And what do you suggest to maintain consistency in
>> the future?
>>
> 
> Sorry, forgot to mention that.
> 
> Formatting and sorting of includes: clang-format (with the option
> enabled in the last patch)
> 
> Indexer: The indexer part of JetBrains Clion. Used to find and eliminate
> unused includes. Followed by a manual compile to verify the result after
> each compile unit.
> 
> No AI.
> 
> I haven't checked yet if there is any command line tool for identifying
> unused includes yet. If so, we might be able to integrate something into
> CI - on the long run.
> 
> For the formatting part clang-format is able to report differences - or
> formatting violations. At the moment the code base is not ready for that
> yet. Too much differences. Step by step.

this must have been a lot of work and I really like that you started 
this. I had a closer look at the patches and decided to give summary 
instead of single comments on the patches as the comments apply to all 
patches.


A general questions first and maybe this has already been discussed 
behind the scenes: Are we sure that we want to we prefer minimization of 
includes over self containment?
Simple example from the first patch: lib/alchemy/init.c removing stdio 
but using fprinf() which is now included deep behind a pretty long 
include chain which is a bit hard to follow and changes for the 
different build configurations.
I personally think that only removing the unused includes and may be 
easier to maintain.


I tried some more exotic build configurations and e.g. Mercury fails 
when --disable-pshared or --enable-debug is used.


Can you somehow make sure, that we do not have any ifdefs silently 
taking the undef path after the changes?
Example: clocktest.c included xeno_config.h which is now removed. Is 
this still included indirectly and taking the if path when checking if 
HAVE_PTHREAD_SPIN_LOCK is set or is it always taking the else path now?


Some small nitpicks:

s/Harmonzie/Harmonize/ in the commit messages.


There are some commented includes left in the patches:
git grep "//#include"
demo/posix/cyclictest/error.h://#include <stdio.h>
lib/alchemy/event.h://#include <alchemy/event.h>
lib/trank/native.c://#include <copperplate/heapobj.h>
lib/trank/native.c://#include <copperplate/threadobj.h>


Best,
Tobias

>> Jan
>>
>> -- 
>> Siemens AG, Foundational Technologies
>> Linux Expert Center
> 

