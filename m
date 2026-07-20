Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8195C3E8686
	for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559850; cv=fail; b=muxAegZmoytrXpmDsK/6za6Hz4Dj0WHspdOuwAEDKJAuzLs0+1N2ouiAUS//ahnA5c9xFIGTQkF4hNbIyEcgRkLC0n/6qREFxHau/GEkg6ZmqkkSDlx1jOl0rwAZUbGkKj8LS2/cRAbMyJmg+rDr8rWf9hTH6QIgUhevTkq3eeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559850; c=relaxed/simple;
	bh=v4EsLejhI1L+4krI9iMnVuw37mazxfTTg/LsyAcjPB8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NCIdDc70V8nxbBESmOc7m1d8A2Xp+z3C18bj3tK6kNx6+vAnl8uaqbx60BgOZ8OusLeApeD1Z7Tov9B/7/qIXIwzk+w4Z/xAMe6cu0C+0sFGr+lZS4nRmqfIslO+1f4mAXkn4gA1hwEzxhdKdK/iuXw4K0A+gplHlj4MKmX+Yys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jWqYs8Ve; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jWqYs8Ve"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCtRgKNDWnWfIWtxLTvxagmuZat1q0MsTOm7ogZSvt0JwYYzQQifnTgLTQ8A6ED3I4MKOSyjhIS9kalYbv0LuKFbRtiSlFxu2eI9dCSftENVImVv+g5R0ZGViOQBf1RJOv6F+QGTh4jB82XzcRyMWIvy61VMMEaeWGJHGBwV+WWllymrlGyr0UBRNWouCgZswJhmN/RpjEjcpmHEhDz8hbfDO3BiMTk84j6n5bgeyIvODH/munKrpAjOdc9SIf9g3imFmbrdNkCWa8ePIiiQbbEapqKicf/8aK8pPgcqSX+692Ak1ITcYHtrkDp8WXhPusnJaJarrBiDbMOSERrGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0NLq4AC8uM54TAnXKZaPpJg308Cx3wlqitUHsF9riY=;
 b=Xv85Edad/btr1ac0o7klda7Pw5ZjbqDEdreVFVfhAS3ebcSz+fNdQLxTFjLPfYOk23JMyAt4SPvkv2+yQQebcma/9y5TAQV/RrepiBrjGjXNjxMG0NnPGlYCPsheTRdhPGZhIDBilRaVTI+DoXXsS0PP8tSCXT7/3DRDyfIl3bE5yT0mryGHc4BozLW2Xs7sjkfMPXLZdSEnMJO6ki6a3jZA0GYtAsGK0sd6Xn7lj4QXBPuEfUhb4LRYje1qK1ceKkmXOlh1can1xNWOTIF1UWw92RAQSDBoPIfRzzJw/3qixKI/T8AwnVBKZf/6brdSk51KqXfRMnn1SzHKDbBRFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0NLq4AC8uM54TAnXKZaPpJg308Cx3wlqitUHsF9riY=;
 b=jWqYs8VeMGp0D0GF7yCf8sYfv2QyU5aifOkTcb7SaR2TsmOev7Ngw2eH09FRRM+HG8GT0rNOLar6aSam1XXrqLLol45i6scYk3JN9RIuuwWQ9CnnAO85rF7L5hsrlgYDxsiNGsHOldb7I0hkSomfj468Y10YtceUYge3bMyCi0kKYK3nQTxfxGrRPKyBPzct6pAMeHOVjCSSdSlf4OGNCgZ0euf9ImHsu5Kz3J0VSSWeiGN7rx0uGb40rxv8urbb8QWmHgn5a9sa0ojLaKX3/e504/zcQaJqVwbM5sxKNVofBSsiWB0YUN+wGhPqlRf/e7Zab9nH7gqqcVVFPxEzEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by VI1PR10MB3277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:135::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:04:05 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%4]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 15:04:05 +0000
Message-ID: <8cd9b8ce-5cdb-42df-bf89-63eed39aaf96@siemens.com>
Date: Mon, 20 Jul 2026 17:04:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] testsuite/smokey/psostests: Fix compile error seen
 with gcc 16
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260717-wip-flo-gcc-16-v3-0-5429c866bcca@siemens.com>
 <20260717-wip-flo-gcc-16-v3-4-5429c866bcca@siemens.com>
 <36b4022a-e6c0-4402-abac-27167859e08a@siemens.com>
 <7c80cb160002180c68ecade44b66fc3b488a3834.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <7c80cb160002180c68ecade44b66fc3b488a3834.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0151.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::6) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|VI1PR10MB3277:EE_
X-MS-Office365-Filtering-Correlation-Id: de021ea4-208b-44a4-ba53-08dee6702435
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|55112099003|10067099003|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	SqSVXwGacJG9VxHJ7nF0wE6sRCM6duCy0WAVcCjhbajdDgXTyzGS/PmOb5H3AWR68ZMmr6i5mJ9TjLg/Fzjvwtr2wQawNgZyi18/8nBbuaTTr2xWjnmBHqjfkrAFOpS1bXJJN3uBpJdm+qWc8pNprDT5C4NDaaLsds4u/XgNmohWBBSQ78Af4U7gbVSrmAru4wwcF1vlaJuHFt9BUDmn/s1RjVnL/R3ckm2JNc8s83OpgeKFXWXnuzF3eac3OWIxWmqMulblvmAIJ9fN4G09WPBoTlzZo5m7/h+QyHhLnOrtasZnId4DxPW6wHH3I+GJ9hzMR2HSr34wW7LTAy1JrCEpr9R8yUn0shj7EdtJkwQWEA4O0XVK0Qc2PbyuyLEWy4miF8h27nX1Obw+eNtTBPpG+1MEbm7oQE36GLXZW/TPvtQ3Xyt2ddeRajj3n1wXoPt9kBAeUaGTLeuA0H7jvfCK0ve+MaezcMCAmpsQSdzZ9Msi7sElELL8PPVj+3ClM67s8IHipZMNR9Av5rp/P38eNfSXMW3LBnUnLbM2tXbhhA7ZHWPrX6LrDTKAyijDKw6x3/Ul7eNod4zYrnJ1RqZiPEDQIoB9sDpD5ZxI/+O7s2RJuHWUFP/3ZoSJoeCt5LCOf9JeDw2cs8ON5UKlZzH063UT2TYFbcWQdSISl9w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(55112099003)(10067099003)(4143699003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUhWdGw1M2hJSnBtK0FsZzl2UFdNbm83ZnMwVkRHbjhTRWJjUkUwYjhvRUJY?=
 =?utf-8?B?d0RRUE95dmpsRjFKRlJmQ1BORm1CMC9TWFZFb1NBY3Z4TWY4Y0xTQjJaZlZx?=
 =?utf-8?B?RmgwTTdQdDFtUzV5eVFWRWZXNHFFN1hVMWo0R1VVVHBMclhRQlB2ZmpPZytO?=
 =?utf-8?B?VXNudWlGMHdOOEhEVTY4U3pJTExVbjhsWjlVMTUyVVlvN3NKdi8xaDFjL0ow?=
 =?utf-8?B?bHk0SG9lNGdPVkl3cTNwazdqdWtxNWxrWnFXQ3E3eUZ5QkhNUmlzVTJaTEZU?=
 =?utf-8?B?eEllRGMweE9CMElzM3hFQncyT0gvd1RiMWRMamxBbVpqQnVmLzFjVzhvaGwv?=
 =?utf-8?B?ZW5GWHZWQ1RZbzZOWllTZnM4Qmdqb1RxM0ZjWUtrUWVxR0d6c1ExVUJ5RnQy?=
 =?utf-8?B?eC9CVUxqQjFQTWVZTzFPV2FCNVByakdsNG5iUFBOUk5vSFJBbUFIck1qTU81?=
 =?utf-8?B?Y2FMM04xNmZXRFV1Y1VCWkdFVEoxNUpKTmRmWXF6TEVRZFRmVzJBMVlNNkV3?=
 =?utf-8?B?TG1hbUN0d3JTK1RoUThBOGx4T0g0Y1JpRkMxcFgxbnFVYVZxdDB5T1NZbmI2?=
 =?utf-8?B?dzJJcldXT3AxeUdockRoZ0lpTlJkU2hMNnRCNk1DVHFTVXRVRUxoNGJaL0px?=
 =?utf-8?B?RGJESmF4ZXNaN1BKbndXMUZOekNMY2ZWMjNxOW1uSUtpRUJvMndpN3V6SkdI?=
 =?utf-8?B?RkNpY1hTaVZSRTRpYXVBVUE4SzViczZJdzdiNGhHWFVZK1RiTUcySmZYV3kv?=
 =?utf-8?B?RmdDdHBZcURVQ24zUkx6M29YZ0dFbmVMaVd5azlTMUVmSmhhTm5sRWI3RDFP?=
 =?utf-8?B?dnBSL1hvNjFoOVIwNFRCTjd1T3h4MWloT3FJeUpsbFprNVhKRm9PS29ST3ln?=
 =?utf-8?B?Y0tEdTFCdjQxSDdZVG51aDE2SXVjWkV2QTdhbUxtakFONG90ek9LRCt6YkVv?=
 =?utf-8?B?eFFmcDVWdnRycTFIT0NzMS9nZDQvaEhyczFtMlBYalhqZlFwQmNMM2g1WVRn?=
 =?utf-8?B?cXR0QXJXZEF5cTZLRENPWjBNNGdTdmtQM0lPOEhuNHRFVjJ4VkFaWlVYR25G?=
 =?utf-8?B?MDBKVHRWaG1raHBkbnlIOUk2UlAwb3hTdUV1bnJIYWV3VUN5QWE0YTRRcGZ4?=
 =?utf-8?B?NkpaaUg4VWJPOC9uVEVPMWpOYWkxVHRVcFBqcEUxVUNzeklOSEtRd1dPbER5?=
 =?utf-8?B?K0UrcGY3NGlCM2xvb041SzJTTGdUU0J2V2hxdWhyWlJuUG1oQlhQbzBFYyt6?=
 =?utf-8?B?OUpvcDdPdXVEWmdTcCtZbjdpY1FtWitMYVdjS2hidHV2V0RSR0FrbXNEcEFn?=
 =?utf-8?B?S0p5WDRoNnFqdVRqMk5ic3RoVVdsYmhHeVZDNFNFZ3dXc2t4ZE9zZ2hERkNv?=
 =?utf-8?B?bmM0SmJURkpPWDhyYUZzeHNLQU1jTmZob2lwSEwwSWs4UEpwakNmMUZGY1ha?=
 =?utf-8?B?RGY3VXo3QkVzUWRZT0c3ZTVIaTNaVlVqYWRkUEp4dE05dmlmc0kxQ2NXV2o3?=
 =?utf-8?B?bGp2eUpUdTJxNGtCRE9uKzM1eFNjbGcrT1VNV0kxZGVrcTBrZnROY0E4TW1Q?=
 =?utf-8?B?cklsMEJGZ2F5Ty8yRSs3U21aMEdGR2YraExDazFqU0x1YkJuK3h5UWRBOWZr?=
 =?utf-8?B?bkQ5WnZMak16US9VTEFDbmxsb2xDdTRNelk4eEdjRzZJTWZ6YlZOVVRadUEr?=
 =?utf-8?B?WWIza1NHZDltREFSTFBpZEpvQnluQTJ6WHVIQWlOaVhZZUF2YXBVL0x5V253?=
 =?utf-8?B?SlNTeWdiLzNBT2hteWwwWEhsYXNFL3dlcEtxRTdrRVJNaFdsU2l4TGxRcUdy?=
 =?utf-8?B?aS9sQ2c2MEZzenh5dllydGExcWFHdzYxMFRCYTd1cHpBaHpIbnVVaWdKQi9W?=
 =?utf-8?B?NU11N2dWdTRzMXV3bXFoSTZ5WEZMVWRnVktZdVFMZHBBRVhjSE9UcEg0TkNV?=
 =?utf-8?B?NGpGckE4cTNOeHZ6M3VyK051YlZINlk4NXpPY0ZhT0VMM0F1ak1nOVBLaHkr?=
 =?utf-8?B?Z3E3bE1OTWNVcFg2eFRydFVwSnM4TlYwSkRGZjlZQkhwYzNBVHlHeW51cFRu?=
 =?utf-8?B?RzE5YVVtOWFvendwbXR0VDhuWGFGR01ucVpCZVRYTUVwY05ITUMyVGtWTGpN?=
 =?utf-8?B?N1BPOHprODhGMmVVOVpPVHY2aWtFYWtIdkVzU0tYQVY0TmduSitvMGRnRVJE?=
 =?utf-8?B?VjRiNWp2SDdHUkc0d2xscVZMOFZiYWNUSWlzYVJrMDJuUEFxeW1DQyt2Tnhm?=
 =?utf-8?B?K2tocVg3ZCs0UGpLbGx0amZMaTdVd1hSanJyV08ydDYvekFyeDQySkRYeEVp?=
 =?utf-8?B?dGtEYmVhK2s1eVZJdlFuYVFPM1QrelkxUi9IRjMxV0pNbkVMU3ZZQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de021ea4-208b-44a4-ba53-08dee6702435
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 15:04:05.2951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: km4xW+k1meDMI9ntNaLyD3Y691tp1iqw912bnxHJS0RnvICq1VQwuaPeqdEt7zBcMryipB4I4bTIR0ikViO1fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3277

On 20.07.26 17:02, Florian Bezdeka wrote:
> On Mon, 2026-07-20 at 16:40 +0200, Jan Kiszka wrote:
>> On 17.07.26 09:45, Florian Bezdeka wrote:
>>> Fixes the following compile errors:
>>>
>>> rn-1.c: In function ‘alloc_task’:
>>> rn-1.c:16:18: error: variable ‘n’ set but not used [-Werror=unused-but-set-variable=]
>>>    16 |         int ret, n;
>>>       |                  ^
>>> rn-1.c:15:22: error: variable ‘alloc_size’ set but not used [-Werror=unused-but-set-variable=]
>>>    15 |         u_long size, alloc_size = 0;
>>>       |
>>>
>>> task-2.c: In function ‘backgroundTask’:
>>> task-2.c:19:42: error: variable ‘count’ set but not used [-Werror=unused-but-set-variable=]
>>>    19 |         unsigned int safety = 100000000, count = 0;
>>>       |                                          ^~~~~
>>> cc1: all warnings being treated as errors
>>>
>>> The counting busy loop has been replaced by an interval based busy
>>> loop. While at it: Enable this test for CI. It was previously marked
>>> as broken. The counting busy loop was not enough to keep the task alive.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  testsuite/smokey/psostests/psostests.c | 4 +---
>>>  testsuite/smokey/psostests/rn-1.c      | 7 +++----
>>>  testsuite/smokey/psostests/task-2.c    | 5 ++---
>>>  3 files changed, 6 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
>>> index 289d563ac3595f0e2d21bc5f5746772fd51234b8..31347ba45ea430ac4b2e62be4c1e437519f2fb37 100644
>>> --- a/testsuite/smokey/psostests/psostests.c
>>> +++ b/testsuite/smokey/psostests/psostests.c
>>> @@ -15,9 +15,7 @@ static const char * const tests[] = {
>>>  	"psostests_sem1",
>>>  	"psostests_sem2",
>>>  	"psostests_task1",
>>> -	// 0"014.452| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
>>> -	//		../../../../../../../../../workspace/sources/xenomai/testsuite/smokey/psostests/task-2.c:56 => "ret == 0"
>>> -	//"psostests_task2",
>>> +	"psostests_task2",
>>>  	"psostests_task3",
>>>  	"psostests_task4",
>>>  	"psostests_task5",
>>> diff --git a/testsuite/smokey/psostests/rn-1.c b/testsuite/smokey/psostests/rn-1.c
>>> index 5e82d1506ca029ae2bf812ccbfbf9c3a9ab9cc7e..d2e847375212c9746de3e550a5d10a8be4694de5 100644
>>> --- a/testsuite/smokey/psostests/rn-1.c
>>> +++ b/testsuite/smokey/psostests/rn-1.c
>>> @@ -12,15 +12,15 @@ static u_long tid, rnid;
>>>  
>>>  static void alloc_task(u_long a1, u_long a2, u_long a3, u_long a4)
>>>  {
>>> -	u_long size, alloc_size = 0;
>>> -	int ret, n;
>>> +	u_long size;
>>>  	void *buf;
>>> +	int ret;
>>>  
>>>  	traceobj_enter(&trobj);
>>>  
>>>  	srandom(0x11223344);
>>>  
>>> -	for (n = 0;; n++) {
>>> +	for (;;) {
>>>  		size = (random() % (sizeof(rn_mem) / 8)) + 4;
>>>  		ret = rn_getseg(rnid, size, RN_NOWAIT, 0, &buf);
>>>  		if (ret) {
>>> @@ -28,7 +28,6 @@ static void alloc_task(u_long a1, u_long a2, u_long a3, u_long a4)
>>>  			break;
>>>  		}
>>>  		memset(buf, 0xaa, size);
>>> -		alloc_size += size;
>>>  	}
>>>  
>>>  	traceobj_exit(&trobj);
>>> diff --git a/testsuite/smokey/psostests/task-2.c b/testsuite/smokey/psostests/task-2.c
>>> index d24c13465367c7c2a6975dd4cbb01eb75f8fd1ad..21497433f1a3584184406b172c367eacd5a8b127 100644
>>> --- a/testsuite/smokey/psostests/task-2.c
>>> +++ b/testsuite/smokey/psostests/task-2.c
>>> @@ -2,6 +2,7 @@
>>>  #include <stdio.h>
>>>  #include <stdlib.h>
>>>  #include <copperplate/traceobj.h>
>>> +#include <copperplate/threadobj.h>
>>>  #include <psos/psos.h>
>>>  
>>>  static struct traceobj trobj;
>>> @@ -16,7 +17,6 @@ static u_long sem_id;
>>>  
>>>  static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
>>>  {
>>> -	unsigned int safety = 100000000, count = 0;
>>>  	int ret;
>>>  
>>>  	traceobj_enter(&trobj);
>>> @@ -28,8 +28,7 @@ static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
>>>  
>>>  	traceobj_mark(&trobj, 2);
>>>  
>>> -	while (--safety > 0)
>>> -		count++;
>>> +	threadobj_spin(2000000);
>>>  
>>
>> Here you do the right thing.
>>
>>>  	traceobj_mark(&trobj, 3);
>>>  
>>>
>>
>> But the patch description is confusing: It only talks about fixing
>> compiler errors, but the code is actually re-enabling psostests_task2,
>> isn't it?
> 
> Taken from the description above:
> 
> While at it: Enable this test for CI. It was previously marked
> as broken. The counting busy loop was not enough to keep the task alive.
> 
> I can re-order the description a bit to make that even clearer.
> 

Start with the subject...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
