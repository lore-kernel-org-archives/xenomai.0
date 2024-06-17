Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7972158A02
	for <xenomai@lists.linux.dev>; Mon, 17 Jun 2024 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634825; cv=fail; b=Y5JIjfeo7moo6THAkDmcaiBu04u5d7MNWB/Uum51oI+rjroF2HfX6HJu8HSFOVZsj8S5a6BlIRxkeV5yZ6zmIKwbQDrJKixkHbx9Bu0YHiuL84eqFv2/LNRsNwg0pXWk9zoR+bSX4clI8RcsMYOtyw05pA6E/kDmvE83n6HbaOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634825; c=relaxed/simple;
	bh=g7ZrgLX0AgMVx+EAvCcvBLBaJX3VSvm6Z75GPzkH9hQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HQLwP8XgfZRB84FcRPNtsApeW3ywV1hUE9D8ZN0LeCbUU2v17wDvuN/MH5D9IzZnJMGr8vSNVagldatQufPopzErJVMBEMfZiKC27vWfNPqiNUmnv6BsJGiuDJHI90CNnGkmoTtT7mW5WCMjbc+9YUP5pFOQeipmK6vz9rJvdi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KwqABnEf; arc=fail smtp.client-ip=40.107.20.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KwqABnEf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cq0jybaZPPGD09LNLUaV/UpZrNgolerQ1NwsphZeU/+noj7mS5GS06J2GghN3zzdWxntHEChqvQyFmj/F0EMFvu7XyU3fQBPpuqgLu2dLG5vLM4CBjMOKAauVDYx3tI6R7i3qAqRA8xjJsee+7fc9LGcG9IiLMxNJ029D0mO+BPUWiApwC9ENFFhCTpJwk3M5cEePmtNcGVBRD+vWTtPCWZMmcjkB4eOX3uhZtLmTfuKkXVXMeMH8hEA5T4I6yQm3eTsn+FcdhccvNP1s9VjnMDZkITn9OOt4+THeJssVLH/ngDWXpNHyNDurigcWp04ZYVzyln/AvRpDjXNZGyl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Qk3N9z9ljxS7PYaZM0fGZQZoIcfKZ1DeIeCveGVhME=;
 b=Iv3EDnvaRuoSTSyacAZ6Fg0zuGhKaB/FcXRFTgf2OvQPwm9mp88h9UJyxACN0T6bCu6vb64OABLTM6KBhgSj/26VJsCyiUvi+8dLHfB63jmVi20F++ErJWXyDbERqmatzpmgX4wYaCZxtx5888stlZx4UfU7Lmk1A/XvLeCHGHkBHMJDQi1KKedb08+YfYcVdPMSG0fFdpv3B1TLaMUWkp+3z/4dMI1SkSAGcsSadWIsStmKFZrndRby3qjk4xn4ddGeMCttQUx3r9jzbkSnr/zEPEOlgFC2BYOse7J8KRiInX24Zr9bTaFPcMeRgoaIQfywEo/pwCGMXy9d9ImLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Qk3N9z9ljxS7PYaZM0fGZQZoIcfKZ1DeIeCveGVhME=;
 b=KwqABnEf5FT5gVDU+V7yOi8kXniobnRRbtaeN7Aagg7yuX/7G1ach/dcUF3cZES3iOmc9oZYJnL2WmbecZfTVMQpeg4O7clWbX5M6yChyAPVZbCFia2bmWjRxphLl04MxUZcXjIvmChNvLT4HIT+LlG8zEr2dEWQgpMxplpbgyb5q5Z6aWovrQBjZFwj14q4uIJhuEkRs3CUVuEllNuXle+WapSR86Z9Jb/XU6HGzJ4Y5jMamQRDq5mV5yy/q4Dru/z+qzVnes0GHFaKL2wkg23oAEv6yjfLtt94uraRILY7UHvwPj7DyMyGuzm4V0tXyIwMop2+ych/ZqrWPMXOAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9183.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 14:33:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 14:33:38 +0000
Message-ID: <861d2244-bd4a-45fc-b227-692f3318bb42@siemens.com>
Date: Mon, 17 Jun 2024 16:33:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Improve period adjusting support
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
 xenomai@lists.linux.dev
Cc: richard@nod.at, lorenz@sigma-star.at
References: <20240617091654.66342-1-david.oberhollenzer@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240617091654.66342-1-david.oberhollenzer@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0078.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: c3408e5c-f220-4949-5878-08dc8eda7a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXkyK2hnTHZnNGI1dXArZFhpTjlLYXlST0IvalZLMjlOY3dEeTkrSUlJTEVW?=
 =?utf-8?B?ZENXcXl5RWRpaUxjZklnTVNOK2VkMUwyRUJSWndLWGxkOHFPSmJ5Z3BKNjM3?=
 =?utf-8?B?MUdoMmVDaGxzOXZxVWpzNVNPdzNwUnNxbjhFdGJGdGJVaFl3K3BVUGIyNHFr?=
 =?utf-8?B?UnV3WTZXVE9qeTJkRGs1N2haQ0NVMzhlM252dmdrbnpQTTE0TVlYVEJnNGYr?=
 =?utf-8?B?NENxZ1BLWVAwTk0wYmgvWjVqZ2FSWmdjT1lxSW9VcmpUdlJqUnpDU0NoMHo2?=
 =?utf-8?B?aVdjeVgyWVJMTWJpMWdsMnpDOC9pbzU0eUVtWjN2ViswdDJxYzlaaHUwaC9j?=
 =?utf-8?B?WERCWWpuRWNmemtNNWZ4Ry9udXhXdTBhZDVRL2wrWmpMYXpYQVIvK1dxNjFQ?=
 =?utf-8?B?OTNVYys3TFIxUDNMZzY5UTVNbXowK0g4cE1nUnlJY1JJYWVyVnNvNjd1TlJ0?=
 =?utf-8?B?d2oraEJJOVZwNmpkZmtITzhjSVVjdTcxdkhyaTcrNVJ3MERuQ3Q4R1I0K3BD?=
 =?utf-8?B?TC9hR3dIcjExdTBhNTBhMXYwNFFZN2xsNnFFVk9Tc09aQTJQeUg1dk13MDM2?=
 =?utf-8?B?S2p0MUhaMGx1MmFIbjd5UC9UemJBUG5LckttVUV0czJpTTdwMTUwMkdsL1dW?=
 =?utf-8?B?TTZ5U2dPcEpodG10ZlRtbkNYT283NzhGcTVxeDVJcVRrMlpiSWFGMVB3ZE41?=
 =?utf-8?B?bU5GR3lvQlJmMDZGcExFTEhHRnpEMFlxSGlUNFFBUGt3dzNCYkUxU05ydjJJ?=
 =?utf-8?B?ejQ1QVBMR21kemE2WjJwN2k4SElEMGdxM3FTTEdVS25yVThmMUtXY3BtR3dV?=
 =?utf-8?B?MzBPTVpmaHQxb0ErMXdxY3UzK1hodjl4N2lQdHJwWjFxYkEvbnBIa1VPaDNx?=
 =?utf-8?B?TUNhaGV5MEh1SWtVRmZnOXFDUU5YWWUyZHo1RzB1TU1lL21oYy90a0UveHQ5?=
 =?utf-8?B?K0RTN2tPMUU1ek9TSXluZTR1TUJFQUxpTlIxVXBUa2txT05MTWVidTNtOFlX?=
 =?utf-8?B?d1BYUXg4SUx5NHJ3dmpia1BsdXgrVFBPYWxOV2dteG1wcGh4eU9rc0k2TUY4?=
 =?utf-8?B?TndYdTZEUHFBRCtxT29XOWovN01Rb1J6QmxNVHpRc1JkOUlqeXB3WHdNSlNJ?=
 =?utf-8?B?YmprZ3draHMweW8wVDU0TWIyUk9maVhGMzFua0ZkVTJMS01RSkU3TllvdEoy?=
 =?utf-8?B?eVN4c3NSWGZ0d2xvUFJPWEwzdmhYNlhaN0JJd0lvVXNaakE3RW1kYWU3eEVL?=
 =?utf-8?B?UUcyblBzYUN6b3VYU3ZGWVZGd0FJakhoRzk4aDJ4U2oxSjZxcW9ubFFUUXBQ?=
 =?utf-8?B?d2JvbW80OUZ4WkF1S1hhQkpTMEhyQ09JNTBlT3l4cWZQSzJ4dmdTMEMrWTFq?=
 =?utf-8?B?M1NXbDVUajlvS0RJVFFkeUtHdERXUFVNa1ZZcTlOcDV2SXNmbDdFUHlLQmZj?=
 =?utf-8?B?Vm5xK1ZCQTVoSGJJMzk3L0dGYVlWVSs5RzNvdG1IbzdMdzJBK1FxTWM5a09x?=
 =?utf-8?B?ODZRSGdwaGUrZnl1RkpEc1UxakF3SHpvODZ0a2RJUDFwd0k4dEREd09YQjEw?=
 =?utf-8?B?S3NMQ2h1Q0dxWk9paWpPL2RJMWNINE1OVDRXYzF3SzlycEF6THpiMW9MdXJW?=
 =?utf-8?B?OGFPZVllVmowd0VVaFhYb2NiK243RjZ6d291SGdML2VwZ2ZicE12N0R2SUxG?=
 =?utf-8?Q?qsm1RPy3tn26th3Obq28?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjcySDlTZU8xdWJXbzljeEpiM05HMmNMSVBZdTFBUEdvQWVVUHdDSkdtUGZq?=
 =?utf-8?B?K285eXZpNFNocWxENFdFTXQxNXZheHkrTUgzV2ZCdEwyZndQK2FCZlN5WURF?=
 =?utf-8?B?M2lVc0o1YllXRk1ScmxpdXBBb010ZzczeWZkMWpWbVFqTDh3bVoxSkpSbUJR?=
 =?utf-8?B?NU5vV3YvMHB4bmhwK21zWTlHQlJ2M1c1MjQzcWQ5b04zam8zWFZQNXdQYVJM?=
 =?utf-8?B?RkVIaCtyUjIydEVMR3FKYk9tQUU0UWVSeFp3cWFDTndtampoNmpVRExVdDQ1?=
 =?utf-8?B?NXMxV3NQNUxab0F1SkpVckhadUw1NmJVNTNZTGc4THhvRlg1RGJxbDNXb1A1?=
 =?utf-8?B?WUdmQ0RPdnVhYmI3VjRnVGNQMCtQREM3M0RUb1lYL05Da09USjkycUhPdzVW?=
 =?utf-8?B?Ulp0TFphZm1wTTlZWGdJbnRhbnIycU9LVDRHWnQrdEswTzFOOU8vSC81Wm5J?=
 =?utf-8?B?S0JjL0F6Z3VKKytmOFhMd3hYT0tUbUs2UkdXQzk4dkcyaFM0SVEvZlloZkQ2?=
 =?utf-8?B?Q1RHVldpSGcvc0h1K1ljcXlPdXEvZ3laalZUSW1JZkxiU3JBSnFUOS9DUVAw?=
 =?utf-8?B?SHlXTnBwZWRVaTM4OG1pOHNMRVdVK0NmSURlTHI2cFBib2VBWkRGY0ZjdmYr?=
 =?utf-8?B?b3VpVit6SEVQN055eHI4UE1TOVpVUEdNd3NDY3dLQXBNV2dTYXIrVjBYTm1y?=
 =?utf-8?B?TkliR243TWpyKzJwM0VGNjhHUHVQby9TcW5ZWW11bXU3eWpsZTZXQ1NocytD?=
 =?utf-8?B?NXNTeUUvVGFzNXJReFpzS25iZWw2cC9iZVpFL0dhc0lzRkU0dlZEN0pXanpF?=
 =?utf-8?B?TXhxSDZKdEZzbnVPMnk5bWZVdUIzcTdNc3RidlorZG0rTXdpdFMvS2hiYVdZ?=
 =?utf-8?B?OGtqcWc5SjhVK3NEWjdLNnVuNFJpaU9WUGpjc3RDWEdLa0hOL3pPS1F1SXhM?=
 =?utf-8?B?azNjeU1aQ2M2aTIwenkvdjlMZ29EZlc0NFRuZkhzVnJua0ovRnBHQkp5NEll?=
 =?utf-8?B?M2FTTG1aRWpzSHNPcjZpWDZsWjErcE5idWVrSEhyZnBodWRPem1wbDl3QWNI?=
 =?utf-8?B?UklnWlZ4d3JJZkY1OWJ6L002Kzd6K2RpSXg3N1BaWHRXaXJScE5GTzZQOTBP?=
 =?utf-8?B?STlnNm1xaFhXZVB0WkNWcG1lTXE0UjJxb2R6K3JUUHEwUHpCZ0VxcUc1eGVI?=
 =?utf-8?B?aDFUL1ZMRVM1TUNyU3p5S3BDbkRXL1ZsaXhmeUo2eWlnRlZsY3Y0ekdENU9y?=
 =?utf-8?B?ZFhvZVRTRkZyOFhVOU5QeWdHclVHNHUvcmRPcmtLYnVlZEpaeEVTTTl2VTcw?=
 =?utf-8?B?OGRGYnNCK0NQcEQzRVAyU09CT2M1bVY0c2ZJTUZ2SC9lajNKYktDeURjT1l1?=
 =?utf-8?B?eDIwVkVaK3pDQlFHR0I2dURzSk5ZM0lSRU5YeXBnMkhyOHVmMUFYQUhyenNu?=
 =?utf-8?B?czhkai9JK2xzK2RVZE1lV25OdTJXNkVNdVVtVU05MVZCTVZpSnRwbjZ6NzdN?=
 =?utf-8?B?bmJ6V2kvZVQ1WlJySENYK3U0bkFCcUNEYVpkUmpUdWExMm5hd3ZybFlnYUdu?=
 =?utf-8?B?OWFyc1pkY2RCcVRBbGdCNkkzOUh2K1ZJdmVzRFpuTk5jQUFjQjZhbWU1OE5M?=
 =?utf-8?B?L2tOVEk4ck1wdlVZZGZiUnovVHUxR1lST3V2ck92VVBzYUJDNVZhZlkzNnVR?=
 =?utf-8?B?WVBMTHkrcVJhYnJzQjV0d0M5MklHVDVQdVZsQTE0MUkvdkJBODVSN21VTFph?=
 =?utf-8?B?ODRuMG1vSTZ5RWRrQVZ2NFhUSzNuK2k1bGRuS1hGZ0NHaUFvL1F4OEFxTHVX?=
 =?utf-8?B?c0tuQWZjSUhlajNxS0JxMVg5ampIbU9uQjB6STcxejV3WnVCSVA3dkYyeUQz?=
 =?utf-8?B?aVFrWldPS2xROTBha01CeW9mZzNYK3FDWVRIR0NqK3hpRzVsVERrYnZqcWZv?=
 =?utf-8?B?QkxtRVcvRFI0RXJSbndrM1RHenBDWG5JUzEzdFBBRkloNERGOGU1R0FBQ1ND?=
 =?utf-8?B?djZXZk5VMlBtVEduVWVBOVRGMHp6dVg5UFJPOEtBZFU5UWRkUGk2bDF5dzM1?=
 =?utf-8?B?bEZDaVQ5WVZWc3R1RjhzZi9mTElxU1hqZEErNTVWSVFzVzNtUE00YWN3ajBJ?=
 =?utf-8?B?YUZVYldCcERUM1NSSm03QjhXeHJIbGpPNEZqRGYxVjJOOUNyb3N4QU53TnRN?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3408e5c-f220-4949-5878-08dc8eda7a2c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 14:33:38.5110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LNRPwUo+gpqy4KY+07fsXMaYlrF3RIZxZj+4gGDVm92OcgozvvPk1ZXGt5SD95SHC/gLICfnquZdEPpVl4GVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9183

On 17.06.24 11:16, David Oberhollenzer wrote:
> Changes since v2 [0]:
> - Document changed behavior of rtdm_task_set_period
> 
> Changes since v1 [1]:
> - Document changed behavior of rtdm_task_set_period in MIGRATION.adoc
> - Remove confusingly named variable from xnthread_set_periodic
> 
> This series is loosely based on the RFC patch by Richard Weinberger
> titled "xnthread_set_periodic: Improve period adjusting support",
> posted last December [2].
> 
> The xnthread_set_periodic function is modified, such that for an
> already periodic thread, idate == XN_INFINITE picks the end of the
> current period as the start.
> 
> This way, we can simply change the interval with a single call to
> xnthread_set_periodic(), without creating intermittent, non-deterministic
> period lengths. The next period uses the new interval, while the the
> current one completes within the old interval.
> 
> The documentation is also updated to reflect this change.
> 
> rt_task_set_periodic in libalchemy is modified in similar spirit.
> A new helper function, threadobj_get_periodic is added to libcopperplate
> to facilitate the implementation of the new behavior.
> 
> A smokey test is added to check for the new semantics.
> 
> [0] https://lore.kernel.org/xenomai/20240608195337.11137-1-david.oberhollenzer@sigma-star.at/
> [1] https://lore.kernel.org/xenomai/20240528070432.6669-1-david.oberhollenzer@sigma-star.at/
> [2] https://lore.kernel.org/xenomai/20231220194855.8684-1-richard@nod.at/
> 
> David Oberhollenzer (4):
>   xnthread_set_periodic: Improve period adjusting support
>   lib/copperplate: Add threadobj_get_periodic
>   lib/alchemy: Improve period adjusting support
>   testsuite: smokey - new testcase alchemy/task-11
> 
>  doc/asciidoc/MIGRATION.adoc                  |   3 +-
>  include/copperplate/threadobj.h              |   4 +
>  kernel/cobalt/rtdm/drvlib.c                  |   4 +-
>  kernel/cobalt/thread.c                       |  18 ++--
>  lib/alchemy/task.c                           |  31 +++---
>  lib/copperplate/threadobj.c                  |  21 ++++
>  testsuite/smokey/alchemytests/Makefile.am    |   7 +-
>  testsuite/smokey/alchemytests/alchemytests.c |   3 +-
>  testsuite/smokey/alchemytests/task-11.c      | 101 +++++++++++++++++++
>  9 files changed, 170 insertions(+), 22 deletions(-)
>  create mode 100644 testsuite/smokey/alchemytests/task-11.c
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

