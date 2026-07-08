Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB197420876
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 06:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491970; cv=fail; b=ekg6TXBXoe9YVCYEGdETLNahikrzKSgDfmUuc5fR3A8uclG+0YtodGVyaQEX0TMvUj+bOlcsp8Dbz4YvOe347R/Jmn0ToEsAyR0MqtckOb626XfZnzY92OSRQGI3LUkuKpKjSKUhgXn0EZ2hVzq1nrVxX4BdnfwowGXRHj4kYPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491970; c=relaxed/simple;
	bh=EIOBR1C7+e6anVyVKjhFq82eQnJ5REkNBqMXtOxhHFA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SNYVYC8yIZDBdox/VmlVHbwNShVzkl+GypWFlzG/QGvC7qTgvi+W1DIIpNz1oeeH0qknD8G9wbp1qVh+o53CLUAqMsldzBmvyj5SMsnBZdjBlLSr1sO91lPWuVlGP+VsXH86fpw2WxrMUopofiw2mPtNK1tRYcoe/ALd0aAnk1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QhsZL+AX; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QhsZL+AX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9YuRRUZ/V+W0d3Q8xL33aUCZWS2LnGY5x7rfsplNGv0/XTkLppz4/qmY+V9isJFVUR5m5aCoM1u1H/jIkqwxGrIEv53zJHR5seuGRA5VOnjD7fARv8z2oXGbbiCBxDs2K7CDI6Gzo8thWzbH2GZkqICZJ9bu9qEA2KAbTvLsLaTtdDiebiFW8wcI8D2Pazh9o5MSpUCdj1gb0fINyigEoYDUys0hRdEUYW8G/YXw4RyCkyefwYUQGPh4R5443M9VqWyqDE6f6/ZRx2CknUag7n/UbIMEU9AbXYTf+Xr0+rCWS2o/BKuqi05jESRf6MS7dxqbucegE87qjESAFeFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbcfDEi1mf5CfWYRt36X2XFymHLjSUbILPHE8H/lwu0=;
 b=jt9c8lbJfk7QUtw5ZabwhDr/pWRRw99i9Uum8/uNtIqw7+XdYIjCVg0va00y7AC5doloHOeP2Qs2QUvsY5EkoZX/EMXB7PQpOOnMvXV9Kp+jxQi9HTOAfTVkZL3CYWPlICTwDeSDm2Uw6JIJG2w77dkyV3YaeiY2mmgTcRBVOP3wqQ/Ri2Ch1gS0ZlIthVqubrgssAwJCWe8NHp6V0BG+X84cwLRYDIl/2v6Idis5HESThHLQ1PNgO0s0Lw3wEZ1VX9rdkYXdpyzhNXfKeP90HWZ7+o465srNltCXqa25riUud/QfLBwtYQtJF/2Ypgc88n5dRuqg8189zAvWF2lnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbcfDEi1mf5CfWYRt36X2XFymHLjSUbILPHE8H/lwu0=;
 b=QhsZL+AXZv302MczWGw9d8PGZBTj7TnVGzb1t36gL4IQp7Nd4SiUhT6qf8Sf4ka94o21E6itK7vvg2ARNI1rLsITmm65WIswT0ZkxxXd/JiG2JLFMYn6+X7hcWgYOSS30VXMtkDbueNVVUEiVGTlUwGGS6RF6cMdAXkyXZEmL53Z8MkOHpyCeK1T+sXTGeXVLMKV5dNjwJhzguQWnc/WJ5+PcpfZkT/s6l02az5kFO3vdqIm/KmgOGoURbEozwq9SDHpWKNZ5wuVj2CUZWuumjgWG7nDBE2g5raeXI6cQLLIB0GBQsFYGwxPpXlcOM/c8uspJp6p9+Een5BALA410w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU4PR10MB8397.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:561::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 06:26:05 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 06:26:05 +0000
Message-ID: <4906b6de-86bf-4c44-8f7a-4486aebf3c58@siemens.com>
Date: Wed, 8 Jul 2026 08:26:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-evl 0/2] Add RISC-V support to EVL
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20251010101130.3758633-1-tobias.schaffner@siemens.com>
 <837969b0d849fb716bc712df566bde246c5ffc41.camel@siemens.com>
 <40c1b8c7-ffb9-4f13-801f-cdcaeeda5ce2@siemens.com>
 <e27b6011-a7f8-4be2-995c-2515f74e87b9@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <e27b6011-a7f8-4be2-995c-2515f74e87b9@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU4PR10MB8397:EE_
X-MS-Office365-Filtering-Correlation-Id: 369137a1-f795-4def-ee93-08dedcb9ca12
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|10070799003|366016|18002099003|55112099003|56012099006|11063799006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OlFk5WHQbC8yvrhLX6/7V6EseRhBPnixPWH+C/XGv1TImBMSRRIWeTF7CA2YYy0wu9B1ToZ+RQkOzHW3YZN9KpncCRdTLGZWLiMadgQUtN+k+TNU52XDfw6IeKH3lkpq3nDGueYaQK/u6EoebwiKOj+vfg5zhBHdEvxjzXluHN6hh7sCTzNsX1JEkbFq6yNev0PHdI6OKMhrKiYna00WOamHjTPZo3W8zhi1Q1DaeJ72IyW5Fg8UujL4f6jUBtE6wDR2d8Jua/MQ1l+yzIpccoMMIrnzaRW0g6SeC/VQG5I6ttagDZNU3EH31yKEOT8ZmwenAVb3yQIiXz4cKkoyVP4AH/hlq7m/VuVCzvd6QlDWnaMF13u5ZK0h7Rztta6/ssSOu4KGuR89yj2WHHq0LJGJgtmYjoWejUwbO4HUHKZNIBriW017lHOWjkghM4hojhuEdvPsmCcD4MDnIP5O4p2/b2BUR3zeARA6gKyCa/ib18wuGIqiPmygvllDpMSP1wK5Bkxi0iq7SH8NxAoNAIJkZ7BRuTZz8eTjgKW2+gB7oPhAzHva6ko9gYiuIbKhGYyYolGz8UpwfwMb5Xf4NwQvxY+EJkZOZzvCzZ6vIaMqWYbW6c3LSWFEavAoSqR+mPRjntUJH+y2bZMa6PqiLkEfCtVxGhQUMsKzQFqm0Y4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(10070799003)(366016)(18002099003)(55112099003)(56012099006)(11063799006)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0RFMkFjZ3BEdFRxRzE0MWFjczZwK0laM1JhTVJrVFQ2R0U1L1pDWjgycmpM?=
 =?utf-8?B?R2dkZG5tcmc1YzdIV2E3VkkxQXN6MlUvOCtZcG9UdzdobUN4Y0VwUnlOa3pX?=
 =?utf-8?B?UUFzOU1OWVpjUVg4d3dTQ3NYVXByVml4UkhPcDRwLzMwVWlpakUxZDV3TzN5?=
 =?utf-8?B?ck5CcWtuNVJIbno5UkxPa2d2WHNQLzc5UHN0N2haVkNWVm1xVHlzMjlyUWF0?=
 =?utf-8?B?RlAzNXFwOXloa3BBME1WOWRlb1N2ekZORTFka2pyVDB5M0JLcE5vaGpqQlVk?=
 =?utf-8?B?dGI4a2o3eStuT0dJNnM2Y3I2cFFvOVlGRUYwQ3F4RnBZTjZjYmZPdWVlQ3NF?=
 =?utf-8?B?RjNqMUo1cnI2aW9URXIvMWVGK2FxWXAxeU9WOEsyS3J5M091aTMzQnp2eVpF?=
 =?utf-8?B?OFBFZmhadXJLM2c5c0lqcUZqV2k0WE16Uk5TbFMwVHZWZGhFZHBZZE5ycFhU?=
 =?utf-8?B?RXpEQ3pKOXlqWGVsSE50cXpmWlRJb1RoQmZKdERPVW8xZjVEZTRsQjRMQXBG?=
 =?utf-8?B?dks4NG0wbXNqenI0MEVxd1ROVk5pN1p3M3B4TEhTTHYzZlFSWkRDUU94K2lm?=
 =?utf-8?B?VEo3ZHR4QkU5MjZNbEF2VkZOOS9BbGtOU1ZaNmtpd2FueGRIQ3p6UWRPckNO?=
 =?utf-8?B?MHpKVXpLK2xoaVptZnZ2RnVvK3B5aGY5TFVvd2FvUGNEZWVvc3RtcU80MW9X?=
 =?utf-8?B?clo0Mm95VXZKRHFhTWtuUHFxOTN1WFV6aEpoWFJmSnEyaitPZVUwbXJiYkti?=
 =?utf-8?B?b2xiZzdKK29hb002NGlrWDJBN0I5TUdnY21iaUpmWHNhbGNiYm1RU2xrUE40?=
 =?utf-8?B?KzE1VWQzTjBqcUhKUEF4NG15M3hiUVh6ZWVHQjZBYTlKejc5N0ZWeWtjRkNH?=
 =?utf-8?B?ak1PTlJ6QkZkUDMzY3BhcmdPR1UwaFhhODF6WS9ZWDZzblMwTGNRWDhDN05P?=
 =?utf-8?B?eS9MRVBDcFBWaVdEdncxbFByaGpoVnF2Y2piaXlFdWFiRVNwOERKRDNzZTdI?=
 =?utf-8?B?a0dYTVhEMXg1MFU5NElTUTJkWDdXNGl0cXVTTk1aMi9SR2Z6QVQ1SUo5QjI5?=
 =?utf-8?B?MlVyVU9kZmY4Ym5TbjhEMzBTWnZHb3RmRm9NZHlyZEVtMmJrRFI3VnBLeVdU?=
 =?utf-8?B?eGNIQVFGK1pyK3VHNVFNV0huajlnUC80V1dDck1vU0Z3eXVVa25nM0VRZzlS?=
 =?utf-8?B?VjBsTmRjUGFUWVJROWZvS3lmVnIrTFYvRmgvMDk0RXdTUllmYmM5bkJ4ekhH?=
 =?utf-8?B?Q2N6M1lhWUNKc2tnWVNpLy95dnhobmZaWmRDR3BsKzBrZ2NXVFZJR0Z5WVNM?=
 =?utf-8?B?dXVaUXZhMGpYVkpxNjFnblNWUmZMZjFKWXNLTWpWOFFWcUp1RFM1N2xtWEhZ?=
 =?utf-8?B?R1ZLbWIrVHIxSTFLQi9rUERCSlErRWRSejdtT2VUOUpVeGVVK0JNOVE2eWl4?=
 =?utf-8?B?R2FnSG1UVUl3WTRlK0RWZlZyTG5DekxRQ0dLcTFSNUlORE5NdEhyZHNVYkdo?=
 =?utf-8?B?VnJ3aFY5bCtSRWE0MkxvTjNSdzNyTXhqY3ZFTnEzVTZIYWxMdFhIOEtmdllT?=
 =?utf-8?B?Vkp4Yk9KM2RLcy9PN1hTUmFmYThQT3VrRitwdGFvK0QvUGQxNDd5U2NGNEc1?=
 =?utf-8?B?Z0RGRTVsZ1k3dis0L0ZwVDlhSlViM0FjQmtsR1J3WHZUQXdXZENoNmgyc2J6?=
 =?utf-8?B?VjhQQjRDNEZjRW42dEFrSS82anYxYW8wK3gxdUR2SEhrekJMRnZtS2hRcGxP?=
 =?utf-8?B?UmJSaTNXNEVmcGhraE5peVNqcUF3VFhTMDFrdGt0S1BqZWE3cm91VzNUdU5m?=
 =?utf-8?B?Z0hrbUFCbExxSTNjeVgzbWs3bXgxNlFzc250elJGS09ERjVpemtVNUpDSDBz?=
 =?utf-8?B?TUdKTGhFM1U4bnJveUF5OVExYlQxME5xdWU3Y0pSZ2tKc0c2Mml6SFNaRnpX?=
 =?utf-8?B?MUMrY1IydE5qM3djM2lqL081OFF3NVBYRFdQZWp2WmN3d1k1aW5HL0djMG5C?=
 =?utf-8?B?Q2xBNFJoY0tNZ2ZzaFhkR1o5WHpieDlYTE1SMHFBVWVFYjFvWjg1Q080bWFo?=
 =?utf-8?B?ZnZEYzI1aTVueWtMMlRrUkpOS3cwc0hOYnp0eXV2dW1zdmxKd1B6alNjZ1NB?=
 =?utf-8?B?bzJMWWlaRFFEV2I1NVg5KzNhbXVnZ1BQaEtMZ0ZKUGF1b0xjMkZXeHB1UUJH?=
 =?utf-8?B?RklnYkZ3Q3VTUVdydi9CZ0pwdk0wWVNVY2I2dDRaNktFSEtxQzVObGxlNGZ3?=
 =?utf-8?B?ZCtSV1ZtNXVKelNLak5yZmpETGM4Y2Zsc2p3SmVCWmtINUNHRXpzSjAxNzk2?=
 =?utf-8?B?YWJEcnBNUGU4R1prUXpqbHJTVTJnSWJnUk9GNGZLM3o1b0ZxdElyWmxoSXpC?=
 =?utf-8?Q?vU+X06QAS4T0W9mCuhPGeDbYZVroU1HL0ikc5hrJoTaiE?=
X-MS-Exchange-AntiSpam-MessageData-1: S3MttHZ+FwMFD/A3gYchOMjvYCA8QoVbsus=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369137a1-f795-4def-ee93-08dedcb9ca12
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:26:05.1723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFpoOVPKULkv9yodnzKgfQTUT0dYqpT8XHEozrPVtkgvD06yGuD5xnx2++DMcYoSsQfKn4xNGi79/jt9ENOR7GONnVKuqaQmaqI4bVSs8CQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8397



On 7/8/26 08:07, Jan Kiszka wrote:
> On 08.07.26 07:17, Tobias Schaffner wrote:
>> On 7/8/26 00:30, Florian Bezdeka wrote:
>>> On Fri, 2025-10-10 at 12:10 +0200, Tobias Schaffner wrote:
>>>> Hi all,
>>>>
>>>> this series introduces an initial EVL port for RISC-V.
>>>>
>>>> While some tests are still failing, I’d like to share this early
>>>> version with the community to gather feedback, reviews, and hopefully
>>>> some assistance in refining the port.
>>>>
>>>> The patches have been tested in combination with the Dovetail RISC-V
>>>> port on top of v6.12-evl1-rebase.
>>>>
>>>> Looking forward to your feedback and suggestions.
>>>>
>>>
>>> I tried to apply this series today, and run into the following issues
>>> reported by my tooling.
>>>
>>> Patch 1 is fine, patch 2 has some checkpatch findings.
>>>
>>> A couple of debatable warnings like:
>>>
>>> WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
>>> #58: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:2:
>>> + * SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>>>
>>> WARNING: unnecessary whitespace before a quoted newline
>>> #95: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:34:
>>> +
>>>
>>> In addition to a serious one:
>>>
>>> ERROR: Missing Signed-off-by: line by nominal patch author 'shannmu
>>> <shanmu1901@gmail.com>'
>>
>> I did not get any responses from this email anymore. I can try to reach
>> out to him one last time, but what do we do about it if he will not
>> reply?
>>
> 
> If I read that patch correctly, it's majority is taken from the
> corresponding Xenomai 3 logic. How much is unique contribution, how much
> was your work, Tobias?

I added the evl_set_fpregs/evl_check_fpregs content which is a 
translation from what Gilles Chanteperdrix 
<gilles.chanteperdrix@xenomai.org> did for the x86 and arm architectures 
with some isa enablement bits added.

This should be the initial version by shanmu where I added this on top:
https://github.com/shannmu/linux/blob/xenomai4/wip/dovetail-riscv/evl_port/arch/riscv/include/asm/evl/fptest.h

Best,
Tobias

> Jan
> 
>>> My perspective: We definitely need that.
>>>
>>> Best regards,
>>> Florian
>>
>>
> 

