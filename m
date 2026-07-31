Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5972EEE9D
	for <xenomai@lists.linux.dev>; Fri, 31 Jul 2026 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785500437; cv=fail; b=OrWUbp8VqkwVKH+Cv2DhXprb7gTeD2+ZZxQPzXWOfRAiL9z54f9ly5mjfOnDREc766uqMUZ3DJwiWm+pxjXJiowGfek0jk8eAfhIqTHkPfmKjEkMUA/Jd00dS3NDoWOAP9G/c4jANkGo7xvokSc15TbEVEHAtHXClqqnEd7s7bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785500437; c=relaxed/simple;
	bh=kmtd443oW1AXI6xd5JancBmhwprUIAnW6NNOoOfVSJg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KQm3N7qi42iUF2/X+/w8nqATS0h6iGEpoZqHylRywaUX8lI7tyXhVH3I4VhnuE7CGwlSRRLlypnjYdkdTU3Pj/E/YwnX9K6iTy87snwXN3eIOxMjgw4qEa+o1oS1ZkVZ3aNtQ4Nlc8qsigL6cwzeFyADzafZbaGF3LgALo/iuRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dA1zv/sY; arc=fail smtp.client-ip=52.101.70.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dA1zv/sY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXmS8HCKwR/jucPqWH2WD3/3xfSAJnEc4a2+yFA/oqq/ZuUQfemd5mwUCjHaZiPiiDJNSM0Om6YPAawaSDYRy9ow1rhNM1qeS5NI8kxfuMPXlVyR0X28G9NBObRoUFbFqr8Kxvq7Nl9kXaVJv9E4JD4Kf+SnMOJ+AffsGBukz/SKId5EVuDWFU7nWHtJ2YLLlrjGU+MpRjNWYJNorMT+5RkiRJNS4AItpdrsht4qB/zUAaGSt6kJC4gzDsQtzpEotOjgBweY4sIf0Pel5e25gbPG6qCN7E1vUOGqeU382MG7Ag6TlFLVfRpvIO9H7oHHCMvdfm8txTv5e1BzGQYyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JO0vYQ98tCMQbqSMVoLzwFB8P/GrjryvEMOEv5zcH0=;
 b=h3r0Pcc6aiS5CuHPFW09MnSWvG6sJ00iZn/AB0wx5qoeiAt+w7qwMM+kj8NJ6KbSJLBZXWzjathPTYHeupIUko65s1buaxAC+5DNlXTdreYPNamAZ+eY1IvZbl7LohFKlIfzRz4djD9JSHprLMxe5Vz867ZEQsWZoU38LPQMoiS7IvnIHdWj0nFaWOTiUimDVNcs1KRswzMSfwiLNsNKw4+viIdwHtamMeiB/5JigLaNaITEBqWI3dc/xS8lrrgvRmlUR4xu7ypxx24t7g8pU6xIASowGOWeduogGFbdDW4aWV9hzXE6kpEHcMH5cxXJM+PliRPp54WtxhNKZ50CZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JO0vYQ98tCMQbqSMVoLzwFB8P/GrjryvEMOEv5zcH0=;
 b=dA1zv/sYdVJDi4VEVad/VIFaehQgX1HF+XU1hdAOVxmDeuEwqeq/iNj3TXTc44xF+M4iiBc2auJEQHy/cyzU5/cZhDD0elk30Zri5R7LuSBCW/Du6FxWAsqxP5S0B+1KUh2F/whgca6fCV46ts0TLLCa0yU8+0XR0OaQ5efJRH2zBm+N/MgejtH1tlVJSrfw8UIrH0XDhVS4DyU582/Z39qprn26MiLl9U7bEjppaKSZRb+kk6HrpI7+Lr2HCkiqY34sMZSL/zOBFLWsgfb3k90G2mpHwNQEpH+jRfDGQoVhLPxVYNTXhyYupPXWgfeqTJvs649AX93OJoGLr39EzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 12:20:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 12:20:32 +0000
Message-ID: <b3f2f3bb-5d35-44f8-ba13-37b9ab3752a6@siemens.com>
Date: Fri, 31 Jul 2026 14:20:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel
 Ultra 5 125H
To: =?UTF-8?B?5YiY5p2o?= <liuyang@sinsegye.com.cn>
Cc: xenomai <xenomai@lists.linux.dev>, =?UTF-8?B?5a6L5YGl546u?=
 <songjianwei@sinsegye.com.cn>, =?UTF-8?B?5p2O5bCP5a6B?=
 <lixiaoning@sinsegye.com.cn>, =?UTF-8?B?6ams5ZCb?= <majun@sinsegye.com.cn>
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.3e5e7d15.7682.47ce.94bc.841347b177b8@feishu.cn>
 <5905a920-e911-48bd-9959-d8702b512272@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.2cdf3bbf.6288.45f6.b5d6.9760f144d99c@feishu.cn>
 <2b95f251-e2a6-4c7f-bffc-7cbc15d9eed3@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.09468bbe.a918.4120.abc3.991d1d35a187@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.06d37e0f.d9fe.473b.a955.bacccbca8173@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.8107967f.ab56.4b5f.bc5e.7ddd5ae2be4c@feishu.cn>
 <1c7d4293-6754-4690-bf73-aba6e17d0c0e@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.c699737c.9d30.43b7.9ed8.a2a9042fb8f3@feishu.cn>
 <67ed5d8f-0a4c-432b-ab59-a4cbcbe91a34@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.feee15f9.216e.4b39.b573.9ad554d5eb50@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.30d266af.c20f.4e5e.b7f2.5899ed8cff1b@feishu.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.30d266af.c20f.4e5e.b7f2.5899ed8cff1b@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0294.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8f5f02-97c3-4bdd-1338-08deeefe1db7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|4143699003|6133799003|56012099006|3023799007|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	rVkueMmm79n0iLjCZFLgcitRPtuy1/zfz7SwbI6fbWetMlHNkNcXfI0EqhyoaOPdqfeqFZObStWp5Ov2gC5lNV0IwGyjBHD0ca7mxyY0PBa7b1tSsV3VKFSJdJnPtdaAazdAWFkgp26l5mtyz9mJOQHNnu1rg5F4e2i3Om5nD5/YmIN8Nl9YQnSthj3GBgn0rHH2P0ow41FQPessAkk08Bfu3Q909TXs2bsCBoJvN/Kg7kFYC+lRPmuSjUJnEHsT38nwKqte3H1amTmYrBCSFlekSDiQH9ANbXada0YhjH7VKUonXphJGSqpjsuQPQGABkoaGdUnTGwsKW2JD1jS9kRbMNEMWcPkSUBFSVaTVqpJPjdJayQ+nWHznLnBthlPZEMOaofs9wxT8shjrbRQTjz6pZHoW0QozO65OIMUsf/8pqw9ErY78cHLtY+Sr3t/k5ubgqzEkBV6/e5GUCO6HaBpFhLyRgLiJCcd2h6UNWHx+va7EDn5Ivua1twIniOJe/J+xzCU9s9KLTS8Xzjpg457hUOElyvFCL4wmmMu4sXcrnmtL9+5PlQyD+0Ai+f1tzTyQmTIWWnKG/ho4SoVF4xCxq8nCZO+SF4kgFoi1kcHnrgbZf9fr0MyH//SGz8gNifpc/upHVmTrJuRY7Ey0oGFdr/o4evB7FjM3xnu24M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(4143699003)(6133799003)(56012099006)(3023799007)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUhjemdwL2R6Vi96MTFLQy9LaElhOGVtRHQvR2o1SVptZVBydzUyZFErUGZk?=
 =?utf-8?B?WVhXbWVsRThGNVZ0ZXBWN3owTU5WNklNdVlKbVdzUUpGUnJEa3ZRZnlHY2tP?=
 =?utf-8?B?R1hSdC9sSUJkRy9WNmJHSld0RFNRYWxyUGNSZnVKOFVuTFdjUjJnbmNJaHdh?=
 =?utf-8?B?Y1lzYVB5a3pscmpUaHJyNzBEdkl1NEEvVVh2UisvQnByenBqMmJYVnBuN3lB?=
 =?utf-8?B?dVFPZ2JYa1JQc1l4dTg5ZmpGZHdZajVuNlU3MjhFWmFKNFV1MDNBWnZjV0th?=
 =?utf-8?B?eGhTQ3ZPUjM0UG81d3BWMWJwSmhlMzJvLytHUEtQQllkZENtaWhOdUFwTTI0?=
 =?utf-8?B?S3hiamhsUDFTSGdxUzFBY0VSanh5cjlocjBNSDg4SGUxOEtMTjRKYzcrWVBJ?=
 =?utf-8?B?WkFWQnR1RGQrdVNjWXVyb0ppWS8vMCtPMGtVdncrRFVZYnh0SStIaEMycjJj?=
 =?utf-8?B?WFZ2VjhUMkkyTUhFUWIzNlNNOUJTWVRKdENUN1RyOFlhaVI0OGxaT0N1SjlF?=
 =?utf-8?B?ZXJQdStEejFiTWkrai8rYWJSRkwyUWFtc0tUNStoeU13TUtEVVBMMG9sN0lz?=
 =?utf-8?B?cGVhdEl0aFRkeWk3OXpjRzNUbnYranRCR3c0dU9TQkRZOE5MeGRGblhGb3Q5?=
 =?utf-8?B?YU13alptOUNVKzBRekNaUndVYnZPTFprbjdDRnk0bXA5YWluUWZqVzRaTDlV?=
 =?utf-8?B?RFNOMzhLOURrSkljdzZQa3VVWGJNUEZBSTFnajBJajBxRFNubXBzMlFETG5Q?=
 =?utf-8?B?TXdmMGh6NEhiS1dFRDYxZHhpdURhQ2tzeEc0VTEzVUtPdVJzVU5qMDlJanlY?=
 =?utf-8?B?YU1aZEd0TEtwT2pTWnE2bG5SbEhTU3dUbDM3MjUzL2NGK2UwWXFOZjdXSmFD?=
 =?utf-8?B?WmtiRnhld1hoSlp2Q2wxaFRHYmxaOUIxRGdMeWRPcDBZbjFYaDk0YzYzWDZV?=
 =?utf-8?B?MDZRa3NURExCb2oxVXMzaDMyT29ZNnpMQXBSc3p1TDFOaVFxbHYyeStsMXB0?=
 =?utf-8?B?K2NLbEpyZzRSUlNVTVFRdGttV2RQYzNHdUZvTEJzRVV4aWpEUXJ4R1dSZVZH?=
 =?utf-8?B?dTJkRWFnOTVtSm9yRDlsb08wQWczTzJvdjA0TnZJcnRUSDlYWm01UG1lSW5n?=
 =?utf-8?B?QmxyazhqOVVqRnBZV3cweUNYSkZudmF4a3RrL1Awa2EwYldkclZvV2VkWnpW?=
 =?utf-8?B?RjlyQUJLNU56YjdPald6UWpuZzlRYWRkenZSaGszaDk5WXRNd2lJalJ2K2FY?=
 =?utf-8?B?SWt4QkhqampWY2VxUFZjL1V4K2JIM3hwL1h5ckJ0d1diQlhMbTZnY1ZQbklS?=
 =?utf-8?B?LzAzOTc1MDdlMjNvU1Z1SmNCblhPMFhVa2VPeURBUlZvQU1hSEpGbnV0WmhO?=
 =?utf-8?B?T0R1bnpYNFllOHQ4SnJLUDNDbmdUOTN4Mk1Wb2JTdEtYMTViUndLQ0ZDdnhY?=
 =?utf-8?B?ZlMvUFBzZHpRVjlpcHBEQUQ2by9sREhtMEJyQnJibWdMMHNjZE54TlczaTVX?=
 =?utf-8?B?aGN3MUlLQ1p0bm5JdG1meTVXZUFKeU9qRXZGcVhCRXhyS0N1S3RnejdxcnEz?=
 =?utf-8?B?WU00c256RGltZTVwaDY0OWw1S085M0srdTgvZXRWbGhxUEphVTZpUVFyUVV1?=
 =?utf-8?B?OWR3dGxHYlFFWUdMWmFTRmlhR1RMY1VQbmE1NXlEUG1DcW9oTEF3Nlh2SG8w?=
 =?utf-8?B?UFdtamp1Y1g2SWtBdHN3U3VMQ2QyZHBvaEtOYUJ6NDNiaFBHVE9qVkwzQm1Z?=
 =?utf-8?B?UjJrWEovSVNCMVVLVUdQU2xhYmNuLzVUYmpkYkIxZVVCVmFZeHhoMkpPcGVv?=
 =?utf-8?B?MmhyTVZJdlVWUmI5M3VacUk5UG1jOFJ1UzRaSDRXcWw4alhJYnBtWTd1cWJl?=
 =?utf-8?B?b1UvWG8rYm1EVlVQZ1lDajNQeGhYMHhQL3o4NTc0QkZCbEpaREFwNVlCQUVr?=
 =?utf-8?B?cXQ4YVRhMnRpNDhKS0NiR0JYTkFNMmgxWmRCL1JXdWVHWFc2TnBvQ0hJZVJt?=
 =?utf-8?B?S2JhdnB0Uk16YkFhdzNkNVdQa2FpT3ltUzZoOU10ZEpldm5TVDZnM0pkVGx4?=
 =?utf-8?B?VUJMakJCakRzbmxPMWdLanc5NWZ0cTJrTElwR3NITlRNMHhMYmsxbzVNNDJJ?=
 =?utf-8?B?RkNmZnpRY1dLczY0M28zb3NiM0lLQ1F5QjNCdG55U2JSeHlPZm14TUFZWGp4?=
 =?utf-8?B?a3AzOVY5SW95ak1VSUU4VHluM25NT2xEZWh5dVdGUGFZWEdwKzlEUm9MaGla?=
 =?utf-8?B?NVIxL0h0MEZCZkZMNzEvUVBMclE3T3prcW5Hc3dqR1F3ODZScmo4NHltcHcx?=
 =?utf-8?B?ZVVhTU1qc2dGNHl4alA5QXNsUktEQ3NmWkx4cUphYy9RQ0g0dEhQdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8f5f02-97c3-4bdd-1338-08deeefe1db7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 12:20:32.2364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hMkscHtuVrpjx2Sxqitayzi/bll3MluPdz8kPQzQ7FkWyy7OpTele6mk5G3IFfQxs+UrOUX+jxCI1tlVgu2zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7014

On 31.07.26 14:16, 刘杨 wrote:
> Hi
>      I used the following changes
> 
> sudo sysctl -w kernel.panic_on_rcu_stall=1
> sudo sysctl -w kernel.ftrace_dump_on_oops=1
> sudo sysctl -w kernel.panic=0
> sudo trace-cmd start \
>   -e 'cobalt*' \
>   -e 'sched:*' \
>   -e 'irq:*' \
>   -e 'irq_vectors:*' \
>   -e 'signal:*' \
>   -e 'rcu:rcu_stall_warning'
> echo 'snapshot' | sudo tee /sys/kernel/debug/tracing/events/rcu/rcu_stall_warning/trigger
> echo 'traceoff' | sudo tee /sys/kernel/debug/tracing/events/rcu/rcu_stall_warning/trigger

Just to be clear: This approach if for the kernel/setup where you still
have ssh access afterwards. You need to be able to extract the frozen
trace after the stall was detected.

> 
> echo 10 > /sys/module/rcupdate/parameters/rcu_cpu_stall_timeout
> 
> Kernel config add 
> CONFIG_DEBUG_KERNEL=y 
> CONFIG_PROVE_LOCKING=y 
> CONFIG_PROVE_RAW_LOCK_NESTING=y 
> CONFIG_DEBUG_PREEMPT=y
> 
> The log obtained is as follows:
> 
> fiveages@W2-0000:~$ [18611.389806] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [18611.395936] rcu:     6-...0: (2 ticks this GP) idle=9d34/0/0x3 softirq=7383494/7383494 fqs=1876
> [18611.404400] rcu:     11-...0: (1 ticks this GP) idle=3a5c/1/0x4000000000000002 softirq=7395092/7395092 fqs=1876
> [18611.414250] rcu:     (detected by 1, t=15004 jiffies, g=14237693, q=73 ncpus=12)
> [18611.423416] rcu: rcu_preempt kthread starved for 7500 jiffies! g14237693 f0x0 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=0
> [18611.434054] rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> [18611.443210] rcu: RCU grace-period kthread stack dump:
> [18611.448322] rcu: Stack dump where RCU GP kthread last ran:
> [18611.454839] Kernel panic - not syncing: RCU Stall

So, lockdep is not reporting anything before this?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
