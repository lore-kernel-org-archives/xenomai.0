Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C7F431E67
	for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558438; cv=fail; b=njHW63cwvADFNlV5jOtMQXFbTQG5CXinoq+yd84VQ5/ypLkBt+iWJ0xGWZEVr4cAdp3T7vzwQT+ofiAXQDRyOsZLY/WWXBU3daJXhS6hMYiel6BG6Bro4qJiri1vE7F7/LsOE5IicgEBJ1lCoud9UUJ6LW73bnwLHzgTOvOn8lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558438; c=relaxed/simple;
	bh=tRmSJV4LsPdnOzKB6j9yYtN+7fWRrszmVqMZ+9hNfRA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X7gXmCtctVJVxCpHgMiU1dE4oRBfzRZpgejpfEsdZ/jdRKK8H0jDAzIoe9SXI0ZsGf/uj8S9BhxAC+AtAvz9N/LB0cvjFi5hDCmxVugxt0lRN7iziCLxeFjRC8UMFxc6U4sLifONFd2Z19hfU/rqru4qXhg9LlQDqr0y7f1TdMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IpsaxZc7; arc=fail smtp.client-ip=52.101.69.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IpsaxZc7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duVyf3CQCgVD26DXt476ykyXf3kVm8ZdqsXwQNqcnRC5tFI87e6AbRuVookB5X0tb0ul43FXzQ0uDcn45h/o0A5VtDAssB3DarOtUg0l02BJDkY59XKpBlynNeCYhh7Na7MCF7IgxGdQ6kFWwqwbh6pqzPWSM5LKydow5AExG+1S4F4ZYj5/tLY2PUMS9Nxem52mAhG0L/2QbIkXT1s9GQuBQ9szl/5FLHYU71U6Q8KYrs9vZ5nFER7SGrTrAP9wekf9mXFw5zuiCgr7JOBugBA8RoZvixMu6VNH5+rYZIDjfdBrGk+eaabXoyTWf8RUJ1XhuTjgrThi46l02f+SNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9Da/OSNo+9bwkxcujhXYvxmTWYpF3L0NWCtOoawtjU=;
 b=vrFRQXXUQ1hD0nr2Zax1w+mdIVzTg4imfhsRHpf2CZo1TEwtVKwXIe7T434lgm4QGwsczzPKKMdeCsikQLSvtUn93JeWk5gLOH7z6YW3wiVLpKx2A1qTem/nSePOTWh56TlOkcrhsrA/AWWoRq6UCfqsnEwfmHQ6FX11710liR/dOXxD7NW42d0bHjAHecaIqNUMjIB0BPcjfv65dVo8+MJOX2F3mpSnyM1J2l2FhNEVqf4TbOGQMsJnm7/+jU0s3G4SoGQFzb5wKzTyLKS/wadj1VR1BwdPcWYnCFVj+wCltzzSemCqwy9dQauCRPTPwx/4ZMqVtw3lcfdeY12asg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9Da/OSNo+9bwkxcujhXYvxmTWYpF3L0NWCtOoawtjU=;
 b=IpsaxZc7TNpIxFcybYto3sd1kcRTGlbzoLMKq9Q12v/LHdvC4Q/QMKLvGYuB4KxDoBce3FWIenkrnm0rEWO62+Qx3wBCmXymMoxPwqWb3vYYYb9jNFq7/ESJ+8kVnL9xiiEO/Crrl0GkP0X3Qvh9PhLc2sSCHZkGxpB/z3E+pUdEhqR3Kc+YM/k78Ukiot94E9u9l7tCdZtFvsi2jvpMqBcqBlzmMLZIuVNg6yaEA45gLR/+75tt1p7XcU0nivGIE1WXPokyf01agUoyb3cUydhSwUEhxr0DOWf+OEAshCYTs1ruNrcKBT88Lx9IpuWHgydqnrI6ZcpQ5R4PLdcyfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PRAPR10MB5201.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:278::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 14:40:32 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%4]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 14:40:32 +0000
Message-ID: <36b4022a-e6c0-4402-abac-27167859e08a@siemens.com>
Date: Mon, 20 Jul 2026 16:40:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] testsuite/smokey/psostests: Fix compile error seen
 with gcc 16
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260717-wip-flo-gcc-16-v3-0-5429c866bcca@siemens.com>
 <20260717-wip-flo-gcc-16-v3-4-5429c866bcca@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260717-wip-flo-gcc-16-v3-4-5429c866bcca@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0430.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::21) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PRAPR10MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: 082ae8ba-5423-4aaf-c35c-08dee66cda11
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|55112099003|18002099003|56012099006|11063799006|4143699003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	EINUq4zHCRJsazMSIz8GFJ6+/L5s0oegJ3kTfPmC+GsgawB9qldKOKkFFNAOkmYQdMSM/rKZDMoikmtczcLZ7O8QbcOMqp/LO02GEIJjgPL8YU9w7EuGXneuDDVWR3SWFWPIaqQK8NinwaULGP16FBGTV0NP4teL9ssZPfXW4XMnlMItGXCpy063cFIQX7v3HVnGrh1ICLAW+owbIX25I+JfvFy+Wjh3nf/EJMu2BptWXPq7SELCCINUUFB+ZzTVlZk4ePh/lJvs0kVwmKqbuq1ogYCQeUuMZYCWNnG9xUQMft43LoyHWTlNNnTbI+d1o5vHA7v84p3NGNhLiUwctysWl5fmfRRnTOLc05Y9PIrGU4KKvOMib2UlCOPZgbGXvDWqNZ4inEvHkN7hGlCYEmJTXQptq8L4HWXXkW4X+A8j2fjjwD6FVjkknkmaoSwVUTZXy84bPvgpuXcTgQ8ziUx7hurXpKZYx7Wjdv56+rKec8Zx2ZaAes8E7NUNObs8ixuibfGRlHjuiWkrimDJsGehO45t5w6XTIBJMTDcn1RYhVIzgMULJNyhhu/dk202ghxG+Jz+gCse8bUuIpPZGlQNkBeSTruBwOM83b58uTxuAKLwxLjIRn9AYnzY7v3R9xCjL3+7QGGjN+DqgpO8KygbrIbeRoPxswUL1VlETsU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(55112099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2ZoYXc0eVVZdGdQMlkvMndpWFR6WkJJQjc4ekU5SXViU3RZUUpSa2orUjcx?=
 =?utf-8?B?TitPSnhMdi9Lc1R3Yk4wdHY1bmZzRUtMeWZqQWN5c1IrZG5HZUsrc1hhOTlw?=
 =?utf-8?B?TFMwaEIvbytLY2h0d2dmVmd4enZheHBlekRlMjhQRDluRWE4U3FwUjhCSXdr?=
 =?utf-8?B?TTRNTmVZR1JBM25yb3E4NVpHZFZRclE2YzhpN0R2aVdZajFWQzJqNFRVbXIv?=
 =?utf-8?B?R3JMVnhUajN1ajVLdk1Nc2I5TXFKYllQZm9vTzBmaHAvVGtHVDlzZ2Z2Qk15?=
 =?utf-8?B?TDFnYkkvSFZkWjBSRFM4Rjk4VVdVQ2ZlMVRZeGFKYmZyU2ljVEN5L3U1TjVp?=
 =?utf-8?B?ajY1cHgvMHByeVl6cjUyWExkeXRlaC9jWkszWFAwUWdQL2U0YTRoM0ZROTJK?=
 =?utf-8?B?VjA5UFpvb3ZJQjBxQi9NalBqY2U5RW11VDF1SGF3U29uZDloTmFZWlpnWWJl?=
 =?utf-8?B?QzI1VFRPRWJ2UmR4RGliU3hZRm1LYlVMZ0VJVUVOTVl4bDF6OEJqa3lpUENk?=
 =?utf-8?B?S2JYMi9OSzVKZnlGbytBNmJOc0loQVBWSWoySVdVVVNBTm1yMUcyYUpqNm1Q?=
 =?utf-8?B?dTBqNTM5OStDOWVVMlYxajZRYjUxanZvZVArdysvRGRXRGFKQTRubE9JcVBW?=
 =?utf-8?B?M0lVL29jK2ZLa2VBLzI5alBkREo5ZldHdWlPK0NyaTM1eU1EcXkzVXREcEgx?=
 =?utf-8?B?OSt2akVTQ2QwRExxZWY5WUVKbVhKSmxHV0lONzFHL0hRS3E1Qkxrdi92NzI0?=
 =?utf-8?B?R0U1eDRYS3hnVng4bmVFdmMxczc4Q0JVZVljNkQ3dFBZNmRuTW9pMElvRVN2?=
 =?utf-8?B?L3ZaTDgxRFVtelZWNHU4dUNQcTRPUUhsTG1tVFBtUHJ4a2t0Z0NOc0d4bFo5?=
 =?utf-8?B?TDlCckJYREc5alo0eWN6WUROTXNHVUZDT1ZOZkp3L2gzd2gvTmxGLy9LZXVJ?=
 =?utf-8?B?KzVqdXljNGdqTm1rTjYvdG9YeW9ZeStONmt3b3hNZkhPY1h3bVo3VXR5Nm5m?=
 =?utf-8?B?TWZXdzErcityV1JTSGV0Qi9vQ0JNdHhkU2U5ZEZMZE8yOTlPdytYK3JYNkp0?=
 =?utf-8?B?RFhuV0o3TkRvWlZaNEIrU3QvVm5HZk1XSjA5ZjN4MURzNHZVNW0xV1FzRVB0?=
 =?utf-8?B?bmtZcnZiajhybFA5ZFdyQmljSm1YUmJWeHNva1pvbXZxbGoyaUJrWUVXUW5Z?=
 =?utf-8?B?Q2NJaG91cFJmOGlPM2hyUy9KcmVaSjNsU3V0WnhKdUtxQzdsL2ZDanhQZXBI?=
 =?utf-8?B?MEVSRW9IY3lKNnFKYStzc0hrY3ZEaEttZHI2NWY2Y2hqUWMzZG0zc0RCV3F0?=
 =?utf-8?B?TzYxMFJCV3BHbFlta3lVUUJ5QXRHUjNHbzdoeTgzZXVNRklPcDh3RWRFVWNY?=
 =?utf-8?B?cFlDZExuNXBabXdUY2xJRkJtTVZYTVFycTFEdUUvVXdYOFYrd2VQdWYzaWpL?=
 =?utf-8?B?WTgzaXM1MFNmS0RaR2Q2dTFhdEFySG9UUlpZeGszWUNiWW16dURtRW5JZHdh?=
 =?utf-8?B?QUZSNy9NeXBNa3dkZ2Q0WjE0NEJiWFFSMERYWTlQVCtFdFdkL0Vlc1NDM1Ro?=
 =?utf-8?B?UnFMR1VHWmJzNjlmVStXWkkvT0h0Um9tVU1HR25lbHZ6ZWtDek1xTlNtMkFv?=
 =?utf-8?B?SlNqcXA1SFVDRGZpZy83Z0FMTFl3VTI3UW1vWFlybkxTazVnYU1XOEJlSEgx?=
 =?utf-8?B?azk0VDZidUVzTzJzWDA2VmhMQkhYUndmNnRuVHdqWDhhVHJxZmRJOWVMUXpz?=
 =?utf-8?B?VytUSVFZSnd5V2E3UmxPbnlpUHkyUmxXSVV5NERUVm1SaExWYVMrVzZ1d3Rz?=
 =?utf-8?B?U0c3elhXVGlVYnI5cjZ5UmVaZWhLME4ydWMxZE5PdkhUSTY4RjI5TVFVWTZW?=
 =?utf-8?B?OGxUUmRkRjhna0MrQzdTZTYwdThsQUp5UWN4NjdUZThqQXdBSkUrUkVXZFJr?=
 =?utf-8?B?T1ZrTXN5MXBCR2xYSGdNd21uempxbm1LUUtkTWVMT2N5eldMMWw3QXJac3U0?=
 =?utf-8?B?cWV0VGRRRk9FQTNCV2RpR2tHNzltN2ljRGwra0dXb0FKMURiTTNmbCs3Qzgx?=
 =?utf-8?B?cWtYcUprdHVjOGEvNWt1L3pvRFozM3RkdzlURTQyaTF1K2xHbEVhNWdqQW1W?=
 =?utf-8?B?Vkp6bHVSek5GUG5NSEZqNUxQWUZEZHdXekpwSkxuM1dGK3NpZ05Kdm1XT2xq?=
 =?utf-8?B?R2t2TFBPRkpWdWZyTkVQSFFBY3BMNHh5S21XVzBES3ZFcDI0LzMxcWpvSlFx?=
 =?utf-8?B?UWxRcS8zRGdnb2NyOW55NjkvaDAxSTlBanNaa1FaQldiNnNMYVVybmU0aEQw?=
 =?utf-8?B?VXBsbHFiSVBMR2lQLzJWRFh3NGJoVkttT2JqMk9rYXBuZFNpckJwZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082ae8ba-5423-4aaf-c35c-08dee66cda11
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 14:40:32.4847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2So4rhCRREbSxKMMakCywv5GZHzxSVypPwOAxDaz3+hj31kPS65Ff4vV8HTtFbJNteazN2qr3InI/h+/UACYXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5201

On 17.07.26 09:45, Florian Bezdeka wrote:
> Fixes the following compile errors:
> 
> rn-1.c: In function ‘alloc_task’:
> rn-1.c:16:18: error: variable ‘n’ set but not used [-Werror=unused-but-set-variable=]
>    16 |         int ret, n;
>       |                  ^
> rn-1.c:15:22: error: variable ‘alloc_size’ set but not used [-Werror=unused-but-set-variable=]
>    15 |         u_long size, alloc_size = 0;
>       |
> 
> task-2.c: In function ‘backgroundTask’:
> task-2.c:19:42: error: variable ‘count’ set but not used [-Werror=unused-but-set-variable=]
>    19 |         unsigned int safety = 100000000, count = 0;
>       |                                          ^~~~~
> cc1: all warnings being treated as errors
> 
> The counting busy loop has been replaced by an interval based busy
> loop. While at it: Enable this test for CI. It was previously marked
> as broken. The counting busy loop was not enough to keep the task alive.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/smokey/psostests/psostests.c | 4 +---
>  testsuite/smokey/psostests/rn-1.c      | 7 +++----
>  testsuite/smokey/psostests/task-2.c    | 5 ++---
>  3 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
> index 289d563ac3595f0e2d21bc5f5746772fd51234b8..31347ba45ea430ac4b2e62be4c1e437519f2fb37 100644
> --- a/testsuite/smokey/psostests/psostests.c
> +++ b/testsuite/smokey/psostests/psostests.c
> @@ -15,9 +15,7 @@ static const char * const tests[] = {
>  	"psostests_sem1",
>  	"psostests_sem2",
>  	"psostests_task1",
> -	// 0"014.452| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
> -	//		../../../../../../../../../workspace/sources/xenomai/testsuite/smokey/psostests/task-2.c:56 => "ret == 0"
> -	//"psostests_task2",
> +	"psostests_task2",
>  	"psostests_task3",
>  	"psostests_task4",
>  	"psostests_task5",
> diff --git a/testsuite/smokey/psostests/rn-1.c b/testsuite/smokey/psostests/rn-1.c
> index 5e82d1506ca029ae2bf812ccbfbf9c3a9ab9cc7e..d2e847375212c9746de3e550a5d10a8be4694de5 100644
> --- a/testsuite/smokey/psostests/rn-1.c
> +++ b/testsuite/smokey/psostests/rn-1.c
> @@ -12,15 +12,15 @@ static u_long tid, rnid;
>  
>  static void alloc_task(u_long a1, u_long a2, u_long a3, u_long a4)
>  {
> -	u_long size, alloc_size = 0;
> -	int ret, n;
> +	u_long size;
>  	void *buf;
> +	int ret;
>  
>  	traceobj_enter(&trobj);
>  
>  	srandom(0x11223344);
>  
> -	for (n = 0;; n++) {
> +	for (;;) {
>  		size = (random() % (sizeof(rn_mem) / 8)) + 4;
>  		ret = rn_getseg(rnid, size, RN_NOWAIT, 0, &buf);
>  		if (ret) {
> @@ -28,7 +28,6 @@ static void alloc_task(u_long a1, u_long a2, u_long a3, u_long a4)
>  			break;
>  		}
>  		memset(buf, 0xaa, size);
> -		alloc_size += size;
>  	}
>  
>  	traceobj_exit(&trobj);
> diff --git a/testsuite/smokey/psostests/task-2.c b/testsuite/smokey/psostests/task-2.c
> index d24c13465367c7c2a6975dd4cbb01eb75f8fd1ad..21497433f1a3584184406b172c367eacd5a8b127 100644
> --- a/testsuite/smokey/psostests/task-2.c
> +++ b/testsuite/smokey/psostests/task-2.c
> @@ -2,6 +2,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> +#include <copperplate/threadobj.h>
>  #include <psos/psos.h>
>  
>  static struct traceobj trobj;
> @@ -16,7 +17,6 @@ static u_long sem_id;
>  
>  static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
>  {
> -	unsigned int safety = 100000000, count = 0;
>  	int ret;
>  
>  	traceobj_enter(&trobj);
> @@ -28,8 +28,7 @@ static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
>  
>  	traceobj_mark(&trobj, 2);
>  
> -	while (--safety > 0)
> -		count++;
> +	threadobj_spin(2000000);
>  

Here you do the right thing.

>  	traceobj_mark(&trobj, 3);
>  
> 

But the patch description is confusing: It only talks about fixing
compiler errors, but the code is actually re-enabling psostests_task2,
isn't it?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
