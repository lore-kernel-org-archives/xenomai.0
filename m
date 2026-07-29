Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013015.outbound.protection.outlook.com [52.101.72.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32275442113
	for <xenomai@lists.linux.dev>; Wed, 29 Jul 2026 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317135; cv=fail; b=ZKPvG/KWKhxkzPN6Y2fJtdivXOAOMKWOGd88t3VqAUdd5ntDAghnWoJnkY6szCGjwL5RPDTj75wdu+btC9TqJeKDwmrniVlRucu8k4bKSLoTdUWT9iGClU9V1ZT6Ltz934qZw8OvaVlymtS0PzZawsI6qpsfc3pPsA2se01GOGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317135; c=relaxed/simple;
	bh=3dOS5XD0FyR2wQ0/Vwqqoye2p57HIFjaN3Lgs0DK2oI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ovcpzhojW6n1nl82sliXyQDf6+GKy7klNAcYEiJNR9ttUZIAflBL+wQy1eOTiR0QrQUyxITaxuoZPGT9aXOk/8RzMnAh+GoViQ1MjYaeDpzIVKX130sySI/TVLumUjh+8VIR1ArQ9ezwtTCXTM6/M5Ib+Jw1dQ5CYeDwK6ARVQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iAMdWpa8; arc=fail smtp.client-ip=52.101.72.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iAMdWpa8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppNrEd522lmdwt4QWxMVCVlzQro+wqSQ22sqedQ2BqgQFLt0ZtL6AWHMD38rUZ4BVQexT9q+Ohbh6jKtqME9zpAZffV0/Ee6FkDwk9KRpVdEAD7vDYU54GgamPQjwt+QuUxLgH+JuhANtfQrmdbMjh+DYicmZbHYbVlIwnLrUeWUaO3xvig7VbO3QvCe1GTg/t1KYB1Rpqx6cPrGbacuqzUcx58ueGeNAZ8B17A5bWy9dLVrNZqL5YLIl2TrQqa+fJVCBN/Stxgl9f6bv4TG5kjtCAdQDpcNkPKwirccq5YkcqtVdoqmCBfagXk67dNdQivhJF2hnFwvshiGgHNY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4xBGm3qWleol2wD3jzjE0SfYcTqjlCkQujVOanTpaA=;
 b=XhuaM3PJZZuzGyy4MFb82SXomit5agw7+RB+VAMnDVb7mF4x7fdM5QPsJFCa1enPsrt4TyBTc7kSFZ7IkhJRUVSgPy8gCnNy/8wfwjBeLKmInZv/NeXJQvIXE6Ck2lXgUCSDfmNvUDIC33RUhImHMuUiy0e6fQbZ0cuOOCH9BWZ60FRDu4e+ov2VQbVJOp322xhxC/7bMPPPAgjRv4N9rsQax2MjW1B50HQ2SQcaqiqKrYJibtwa+KXQIXr4KkokxtDc23XnUx0bjKYmJA64WKHrfEgh0THmEqfhlzuDNcimmHDmwwBo74hj1OufSFnxO7QOcokk6eL5Pr0Lz96wjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4xBGm3qWleol2wD3jzjE0SfYcTqjlCkQujVOanTpaA=;
 b=iAMdWpa858YlY843rmLjtg8Ql0x0Frg9TUPi9i58rYR+yJwxElwRSafroFVXTbdKgCHkSnHErdx4EQwcgXJlqBfReKYu7HAmUrFyuYkTlSpwMt9nJxLQuTrddQkT0FEirhgD/EwGLA5zP9Nk9vU7nLt+keZEjFhEqYu6GkO/pwrb3hG9kHyLQCMrfnIBMONORez8P38ECRMliIAd7I9A97ExRi3dkwAOI45RI/DQ7wPW4cssuptnTVib5tUl+gxLa+VORvZ60RsOSpCK4tcs5aKbUsUYMb+heDeI282qEd0GHRwOvKeKgbPEPlWnnebsSoU3e1L7lEZ9TTgPwheEog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6760.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:334::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 09:25:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 09:25:28 +0000
Message-ID: <2b95f251-e2a6-4c7f-bffc-7cbc15d9eed3@siemens.com>
Date: Wed, 29 Jul 2026 11:25:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel
 Ultra 5 125H
To: =?UTF-8?B?5YiY5p2o?= <liuyang@sinsegye.com.cn>
Cc: xenomai <xenomai@lists.linux.dev>, =?UTF-8?B?5a6L5YGl546u?=
 <songjianwei@sinsegye.com.cn>, =?UTF-8?B?5p2O5bCP5a6B?=
 <lixiaoning@sinsegye.com.cn>, =?UTF-8?B?6ams5ZCb?= <majun@sinsegye.com.cn>
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.3e5e7d15.7682.47ce.94bc.841347b177b8@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.38eb388a.cbef.4959.96f3.b61a0b0ee8f9@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5cc6cb43.b732.48d7.97db.585e1489779a@feishu.cn>
 <480ff592-a77e-4d9b-957b-aa856e41821e@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5571d0ff.0b5a.4df0.8cd4.bf262a5fca73@feishu.cn>
 <08769a2a-4249-4dc2-a1c7-ca402de19470@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.ce37a487.5a5d.42c0.8403.e19ea2d59537@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.53860c2d.1bc0.4564.872b.fffc828b78ef@feishu.cn>
 <5905a920-e911-48bd-9959-d8702b512272@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.2cdf3bbf.6288.45f6.b5d6.9760f144d99c@feishu.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.2cdf3bbf.6288.45f6.b5d6.9760f144d99c@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: e320ef39-9551-45ea-e9c2-08deed535153
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|4143699003|11063799006|5023799004|10067099003|6133799003|55112099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	pkHi9N11K6J5dHcJFBWMCAXa//VtWLj7e58Qs64gThWMCV66fcNZap1F1vYlOLD088YQMNuf33XIf4ygb9EfW5F5UTZs92rivvmGxOWRtWGoF1JhlWzliCnfQcTTOXnPYJHaROjnf20coKhMqw0bxiFlyEuRp63mzfn5J9CXtGC4rlvJPNyskKXbJ8Xfy1R/teTNLd5pcyQcXKZwf6e5JWgRgMx5ugXtUHpcuEX2sV8jNLagj2VvSrgw1vH8XtzCT14MSoR1kpbtUVfjKlwicmROjXqQHSFPAXffLDOSQFiEjHVY6+amFzrIeW0+EYtj0teKZEsdtTl+RqHXf/vcvfkbDuNnsRk9RAokI8nhjdpavXKf3FuSKVaj4CHn+TMjT3tC8kPNTqMa/eUvH4uhKjki7aq8IIZmGtyxOO10H/ar2Va417lVqhZsVkemdtQMyVtnksa1URDaSm/m18B0KFbdmA5I81b3jUvoSIHZsw5tgDgP1N7E+k3b3olV8inSU2it6N7mbkSux/yEy++du6QMsT85m+MUH8WxGFgZEyd6VZL+IhIWxiOBlKEHK7mKdTQ/SR/v9oQF6NMQEm2H5cCJ7gNr4TgraIudwpF3NAmP9OD0hpXCc94jSqnUS4Ojr8A8Zn3p0W3ThEf8jph4Jawg9EDFwV8aoVALRjc3kUA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(5023799004)(10067099003)(6133799003)(55112099003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUJtcWwxMC9ZOHpsUFZrTDFiVUJ6YzRjc1RCUVBVSUhPdEtNSXp2M0ZrK3Zs?=
 =?utf-8?B?eGpxTnpHSU51cnlaSEgzV2V6NEJscnBQQXNCLzFJNGpVVVp2Wm8vc1Fidmgy?=
 =?utf-8?B?ZVhZOC9BNXFGRzBoMzh6bkVWcU0wVGtkU2x2Mk5sV2NEL0JZS1N6ejN2aUNp?=
 =?utf-8?B?MWpobXBWN0duc2NDdDN5aVlZRjB5clptOUp4RWd3cHUwSjUvdXRlVm9VTEhD?=
 =?utf-8?B?U1FrNlNhOUxRYlV0a01ZcmJPbURUT1BXWCswM0h4VzRVS3NhaGFiQjZGdXM3?=
 =?utf-8?B?MWRVREZnQ2dKNWFVS2RIVXFUUjVYUjc3MXJ1NnB6NVpmaFZkWGx3UHpGdEpu?=
 =?utf-8?B?WGhoNlFoMWtJMnV2d3BJZDcxcHJmVkExZys5WlhYSEV4cnI0Y203QkpSbm5w?=
 =?utf-8?B?cllDaU55RGhXckJvOWswTzJqL0tzTG5xTU4vODBoSnprZGFyQk55Ymh5Qm80?=
 =?utf-8?B?b2JEN0ZPVkpYa05UdG9weG9vaDl1cDdjZnpoTTR0cTBDS1J5bmhQZGs0bS9D?=
 =?utf-8?B?Z0c5TCs1bGhvMGczdnhqQmQ3ejZOcWRkRXNSYWVIZjI3UDZwU1RNOFNPSHBt?=
 =?utf-8?B?dW9vUFpBeEozL2VZS2ovdkx1cEZqeFhqK0xXeUlVUlFiYURLODlIOTZzeTBi?=
 =?utf-8?B?TC82M2RSN2wyelRGcUZ6YUtjRGx5SjdFK254cnFVaXpuSFdvS0E4cnpCckFX?=
 =?utf-8?B?UUMwNHRLblNFeFpoV1NTbFN1S2h1NDlTV2tNRFhVeE1Xb052cGphd0VCVkVV?=
 =?utf-8?B?NGpORVFBV3hSNSsrd3hGemM3WlVVRGdMWmVpN2pYU3JKVXY2MkxwclN5TXJk?=
 =?utf-8?B?LytNQlFkL041a2MvOTFMazdHQm5xWHZYWEkramgwUVBjZFVkTFVXYWpkeVpQ?=
 =?utf-8?B?QmpubktPQU1WWFF2N0pic0JMbnA0RThSYXFDcTZ6N2Y4eG1ZTXpsZk5WOXhF?=
 =?utf-8?B?STlPbVoxQWRYemsvNlJvYW4zRlpFVC93L3lJU3gzYTBIdlpmamZpdEpuVkJO?=
 =?utf-8?B?cmMvWXhsTEJSV0N5SC9MVlJ1dmVEMk44NktGakhqUG1rS0JRZUNobWdLN245?=
 =?utf-8?B?WGE4UnZZdGRRaVcybE9GU01BV2IrZ2RGU2p2MjhmRXU3b0szcDllQmIxRGNT?=
 =?utf-8?B?eGgzTFpacm5NbnBSZ1FmeTNxQTdBMXRpOENjZ1d4RkRBSWNuRStsLy9EVEIx?=
 =?utf-8?B?eHBaTmpRQU1maVRKWUN1SUVUc1lvVTdhUUV6eTZvaHlaMitHOCtIYVYrOEpw?=
 =?utf-8?B?dTA0M2YwUHhERHEwaDlScXIxbzVHQmF1M2VyWXdqUDJSMzhZREhtbjJGUEhS?=
 =?utf-8?B?a0tzeXErVWNWM3NiZjQzdE5veDIrVXVhZ3hhRFhJbjh5NkM4MmpLd2ZnUks0?=
 =?utf-8?B?dUtqRTVzQjg4RWFvZjA0RGppN2FaU3dydXkxaW1JYkl2QWJMWVdXRzN1V2pN?=
 =?utf-8?B?M3BqWE9jRzJpTml2RjFCdlRxVnUvVWYwMm5EcW0vMGp5SXhQYTV0VHM1M0lV?=
 =?utf-8?B?SEhKVUVEcEdhQ1VPZGNJcGtuM1ZRQnFJQWxOYlMzVmVKZzlFcnk4NDcvWmZE?=
 =?utf-8?B?VG1RaEVaY21KVXNocGtFWHRCMjhMMlIyQ3dPKzVtSmhZUFhZTUpVS0NkWHFN?=
 =?utf-8?B?c2VDK2lDS0dldDlwcnpoUml6aEVTelBDZ2Q2ZFdJM0hNK1prby92SXMreXN0?=
 =?utf-8?B?YmVmL2VGd2RjRVdRQmZWZXFLZkRiVys2SE02WlpCOUVxOURJempwSGhuS2pm?=
 =?utf-8?B?U3Z1N1c5MkNONWdkWGxhQTh1dXRkanhBQTZwUXVkTjNLbHNKOS96QTdBRzVw?=
 =?utf-8?B?N25YL1JPOWNiTHNRQWJQcUlWN2U3R2Q1bFlDam85YkM5blhEYjhvMjRVTTQ5?=
 =?utf-8?B?UUlmQ3VrMnZQQmwvSlp5ZXQ3eDJUaE0waGtoWDdUTVl6V0VRV2NXeUI3N3Bo?=
 =?utf-8?B?SW1xblJHdndrSStPNlNOUy81RU1CTDFPbjF3QmlEelB6bCtqOWgrN3Z4alZB?=
 =?utf-8?B?RFRFbzNXdGRsZzlWNm9RWFFVRWtqWnowM09namtWSUpaa0ZPM0l0VThWM0VE?=
 =?utf-8?B?RnQ1eW00YW9uTTJrUXJYUFQ0M3VPNUZiTFNjakhTek9OdldsZ1F2VUZEUjdl?=
 =?utf-8?B?dEFiUEVjUDRKMnNidzVzRzJCUEZVZDJFbEkxenV2cGtqZTNqZGRBU2Y4QXFD?=
 =?utf-8?B?MG5hVXdRT3ZrdTBXOTZYa0s5SEpyK21kR2h0YUR4ZE9UVUQ3ZGlndGxPZzJ5?=
 =?utf-8?B?VDNVZ2FEZkpTKy92UjRzdllXWndvTWQ5U3J6ZlZpWVpEV3RwRXgzOFgyTFJ1?=
 =?utf-8?B?RjhmSFZRcm5lVkFkUFE0aG5JN2FmdVBqN3lqVnRLeVZ3VWR1QVNpZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e320ef39-9551-45ea-e9c2-08deed535153
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:25:27.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPR2ZT38rfVMh+zv/cqC3BvLjEbyOHVhF7O1uMt1lU+sUTCpxeoRM5FFuj5PhlxYYrYntHy7pQ9DXk6gYxjGAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6760

On 29.07.26 10:04, 刘杨 wrote:
> Thank you for your reply. Regarding kernel ftrace, do you have any suggestions on which parts I should mainly trace? If I enable tracing for everything, the output file will become extremely large
> 

Baseline trace:
- cobalt*
- sched*
- irq and irq_vectors
- signal*

You could use continuous tracing into RAM (without writing it to disk)
and trigger the stop rcu_stall_warning:

echo traceoff > /sys/kernel/tracing/events/rcu/rcu_stall_warning/trigger
(untested, might be wrong)

If the trace is then actually stopped after the error, you can safe it
from /sys/kernel/tracing/trace, or via trace-cmd.

If the events are still too many, drop irqs first.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
