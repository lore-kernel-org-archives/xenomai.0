Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB60377AA7
	for <xenomai@lists.linux.dev>; Wed, 29 Jul 2026 05:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785303018; cv=fail; b=W2Rh9gV40L4sAlriWX/omg2o9kESDdcdVf9y8hCuW9ArzOjxObP17zsOBYUVI5TrKm6QpYXSFp+tGfnzEDp82FZw8OAv9I0i3euPYGk0JRc5S4TR+G68cIpbTWRYJ9WlFno13pFNfcEZ+XAFS9xO6fCPTHd6UZ3mX9eexWHvJvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785303018; c=relaxed/simple;
	bh=frMuMtuw8xmTdEyEf2ia0LZell/AFgkZ/DmrNgJOT4I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FuR3/Wv2OAS/Y8gvOBCNQgxd6KKwIzcOzaYPLsRheZ/8jN+kytrp8FWqTTUqoNtWrLVdQr9S1OtFYJa4RJ5oL6ZzGAqu51mOczX7lLFYwKRHhTliJlogU4at/bo5WHQHer7vq8wMJuemgs64yTCF4zEUdoIhm0etbzoDwPUvEpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nLoZs9Fw; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nLoZs9Fw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Efv+wLogmSyJCALS549pbqeouQ/TtCE0LaaDxAzClI6p0gtWCWhIppwR2Lms+tKiqqbqGleOqhF9F4cVlc+DvNNFfq6vU92QEB9bZrZoqXCbwzIDY/42aaAtUB9WA+VRCaTL4yxRZcfu0G7NBhNWxHGLGK6k81nzWsBR88iG3QP/2LEWRZmFz2Fem77hDVZMGdDUkZQT8EM+PnCwOrpMEdz0X8yKCw02oLpcJQ0vfHBk+LkF8qviSlibZ4etAgOHW7DwMm9YhByoT7xryh1ztb/jq42zE731iGxfxdBSBLyNUSjhaRqt1pLqsIglOPwrAf9SXJJu856sdK8qx9VKOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=co+mAcowAfgx7GgRCDaJNJvn4eeT2UQ0Eb4OX1v/MHU=;
 b=x/7K/5YAoUScEp6BRgNa4YokxHXh4pQ/HDl7D589T2nPrPqSRzHo0YoQkYSReZR/GAOIL/0pmP7j2AFEbirHuNWikgEi92dp0csOS9R6IzhrgrfCD3AesPW2AHZ88erfhLeCrP65Up4+33od+xPc2bA+oCwLsoyF4fRetrmr6SjMZscid6NfFFTgNjZE6eaOmMOZWyfk5P/rQZvKHjE7DXnpBjUi+K1Xqb/yXiL16M5YSnich6B4NPZUWg7naj0fpF06Eqjq7E4TIP5cPth6e2Lk/KTY0mbuoCHyABvEkYidaqHHlvpCDaS9VPJPJq7fyNN5ZkDSfjWVQMSI1tiRwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co+mAcowAfgx7GgRCDaJNJvn4eeT2UQ0Eb4OX1v/MHU=;
 b=nLoZs9Fwrip7V26l/FGyTeu3csfkpArLiVsGn2NIKgycqzx0lRX4QRFvWY6v0csDSNq9LtO5Ds9tIpkAEBpHqmRCs9jx92rzGYtBpmD5fZorODl8HwLnxJhHqdmG0SYQXX74SsVPQgMy+iJ2DpQ/dhvWxQ83causp2MmHDjIXrYFEmADUT8z5IbKf/FMbTqytyM8vMZ9XJfeLixXCHLL8k7NHV1xs8Y/qQEs0HjA3e2pWnrrMcFOFybhmuFvwSCnEFYJzXWk1ww2NTH19+YbEAAt8IJOOLxtEIeDj3Hgp+eCxTBBykFMb+s+a3nj4cujpuq/u8Au2ySoTv1CSs6gyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB9132.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 05:30:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 05:30:11 +0000
Message-ID: <480ff592-a77e-4d9b-957b-aa856e41821e@siemens.com>
Date: Wed, 29 Jul 2026 07:30:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Fw: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on
 Intel Ultra 5 125H
To: =?UTF-8?B?5YiY5p2o?= <liuyang@sinsegye.com.cn>,
 xenomai <xenomai@lists.linux.dev>
Cc: =?UTF-8?B?5a6L5YGl546u?= <songjianwei@sinsegye.com.cn>
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.3e5e7d15.7682.47ce.94bc.841347b177b8@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.38eb388a.cbef.4959.96f3.b61a0b0ee8f9@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5cc6cb43.b732.48d7.97db.585e1489779a@feishu.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5cc6cb43.b732.48d7.97db.585e1489779a@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0273.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: d946651b-35fa-4dbd-8bc6-08deed3275f4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|56012099006|11063799006|4143699003|10067099003|3023799007|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	zlsNZfe2lxnIhANS5PxkYfy2VQ7zjqlKMSNu9LjOXN6xdz/EqjnQfI1R8xjRhehsCfWymVua8SKIEFdXhi849zKOJT2XXlzuhrNbXKatbK18/U0wDHbiBJvgY7xGYBoiYL0Sn9/1/SfsLmGjLDCzg1PTMv+bl88pzU5pWDPZBQ0UNGZ7UZN5iKHcwWL4/IYAr/+Fh09Q7IdEwi4TWbpRMcQtlmmhdBSA+q/52WGBK1+jETRnwNLFx7CJnqQlJiQ7tqKB5gMfVYzyq3fF86FiaqVJ4SM6Ghlo79qqzB38tDy7zYUdYgNiK+GhI8dU0ZSzEJWaR9lbxDR9ej84KbIPykYLPoryAJGx9dvwGSU6w8FQW0k5lD0NmQc0MlqRlRFPbXTiUe+9xgqISd+iTqLSZSlLGe5TvOr0hsJZTvLLzjYhxJTScHbaTB6rKVFfBTjgCmctE2jBELdWeVBcFDRox5OtkFeDRTLmr4dkTNkqILTPF2vCj0I4L6vJlgnHFMLqwC6ae1Ws7xHQ7lHrBOkVj+N8ejWJrli5IaSiDOEd37HJqyuEh7FSfo5JtD3uCwH2jTUghrnNC028ZQ79H1qDg4mk4mqMlDGl24e3bgSDdSfUSm6S1etFCIp8GkjFmegt8+A787gtl1ZCfm/6T89+gBw/6R5qZZWgpqJaM7KB5Zg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(3023799007)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFVGeWZCMHRsSlNkY0RVSkxjb1BNa2FnUkVNNFBvVXpWRmh1N1kxOWl6WWFp?=
 =?utf-8?B?djVpVE00K2F0dHIraHg3TWgvSWxqRGFkSTIxMGEzNFRHVzdJM0xTNHdwM0xJ?=
 =?utf-8?B?bC9DalBkZFJ6SjBsZktHZlVRZjFkZyt3Y2FvSUV6TTVTR0NEakNEcU1FUUlq?=
 =?utf-8?B?NTBpOE5nU1BJd3VKaWc4YmNyYVpleis2TjB0bEk1UDV0cmpMZTFYWkhsbUNt?=
 =?utf-8?B?V00yZy9Pa1hGL21XUUh6Z2Vna1hNcGhMc080aHVsM0lCV3QrK0l1aE5PUExC?=
 =?utf-8?B?SzZpNy9XQ3lUZGFvK0lvMi9Qb0lScHRJdDRRc0Nzc0FWalRWeVRvcWtaNEpU?=
 =?utf-8?B?VWZ1WGlZMkNWM210WkNvMENZZW8xamFham4rSWZ1Q0k4VjYxd1kwUU95dWQz?=
 =?utf-8?B?bUNtN09tZW40RStLdnN1TEJWYysxVE9yenhXbXlFcmYwM2RGSlRZdlRSbVQr?=
 =?utf-8?B?b0NkUi9rcFlvZlcwYUlnR0NDbFh3RFBrcUZpcWlLeHlKWkdqaEJ5a1RpZTEw?=
 =?utf-8?B?Q2tHeTk3cVhwbFRqMW9uQ241WFJPdXNiREhWQ2Y4am9yeVV2elY4bERlYTRY?=
 =?utf-8?B?Uk5qclJxU3VXNXVTdThVNG5UUklzcW4xeGFBQVN1MHpkblJEd3EwN3Z5Rm9r?=
 =?utf-8?B?Z0VwemtaNk5mUmt1RUxtajVBMjVWQ0o2VUU2MVlJVUxEQW53cy9GdjdRYkFm?=
 =?utf-8?B?aW9NcktwaDM5WGcwMjg5VFNreHRJdVJ5TEhHSzRCNm1RbzdBMFhzWXhZVWpw?=
 =?utf-8?B?M2I1dWdkekFYS0ttQk1WdXMxUllUZDFxamRHWkJKdjh3SDMrLzlVMXgwTi9a?=
 =?utf-8?B?VXZoM1pjaGNXRVByS2Rma1VzNFlQeFdnUDZGN1dhL2xHRHh5ZXczOHRoOWI1?=
 =?utf-8?B?Z3BwV1VKMXBiMnJaSjlyN1BGL2p1Szc1aDVvNTJkWDI4SzJKb1ZBSXcwdnYr?=
 =?utf-8?B?ZG9JcEtuY1B6b1UzeU94VzBGd0I4RXVkOFIyTjNpY0czNGE3VENRSDNYRHk1?=
 =?utf-8?B?Y29sNmx6S2VVMXRpSHhRanpQRnRxTWN3OWdDWTFwTzdnZEc1LzByK3pGb01E?=
 =?utf-8?B?ZUcwZitPYzZFV0VtRWlId2RUeXlqa2FIckRKbGp4a1VrMTJGUjVOeGQ0dnUv?=
 =?utf-8?B?S0lmMDc3RkcxTE9rbWhWcDF5ekVWMU5YRzNldXRuVXVSMEJkamhyRTVhNkZJ?=
 =?utf-8?B?ZGZncDFqZU5QQWx3dnhkaDB5elFOeTgxWnc5amtEMmRnRUl6bUVmdUsyY01j?=
 =?utf-8?B?U3FRMEhhYThoS0U4cmlPaWF6Z1pCS0kzZSsvaVFuUWpWNlhhUzkxMTY1QVVs?=
 =?utf-8?B?Y1NuMFE0aXNKQ0wyckMxL00wcVZBZ3pYZEFqWHpyYjRjTEpVM3lwZ0lITEhY?=
 =?utf-8?B?NjhsNnRLRHFDZzVnVy9Lc2xRMTV4NE53NDFGWlFFSHIwNDh3VGwwbnE4a2dt?=
 =?utf-8?B?T3BFMmlHMlBBekx2OE9kYkVnSWQ2M2JSRGhjc254TmRqaGFRd3FmWVFSbmNB?=
 =?utf-8?B?ZVo3ZTlYMEpFN2Y0cW5IWnBoQjF2Wm11dHVuamVVUlFKMVZuSFYwV3IwU1Q1?=
 =?utf-8?B?Q2Z0VFFkYXlLaUM3ckx2T3QxTXB2ZERpUENYMHo1NWFJZkNYZEVleFp3OWJ3?=
 =?utf-8?B?NVNma2J5cm1zVm5pUjRqMzBQa0h1RzJEdExHRUQ4NXh4RC93ZC9BaVo4SDVQ?=
 =?utf-8?B?dDQxb1ErV0ZrVlZZK0JSUFJicnE2MUlpeEEzMzExOEVWUFk0QVZsbUIwU0pv?=
 =?utf-8?B?Wit3ZXlRV0xCL1FNV2M4YUlmMHp4MHBsVGROU2VWZHR3TlJtRTBLVkFaSG1U?=
 =?utf-8?B?cEVzRGE0M201bGdOS2xXYk4yNmRoZUlRVEdXQW9oNlBZZ09oK0p4bU9GcVFY?=
 =?utf-8?B?NVJXVFFSRGFERXFCNm45NGhTNG9qcXM5dC9aVjltMTRBd2lxYWNwV1podEZI?=
 =?utf-8?B?TmppeXpPOThiZW1BeTMxM2xMeXdEWXVRZzRYMmxjY25jSmQ1aFE2dHlGcFhB?=
 =?utf-8?B?TmZiaGdXbTZaOXcvMXVZR2ZoeEtUTE5DNVJIVWNhMFl5UGRUczRwd0dSckY0?=
 =?utf-8?B?Q0ErRU9rMjNiczBMRzU4Q2FyMEZ4UXR4T21IMjV5RW1ZYnVYQnJad2Y1K3Q5?=
 =?utf-8?B?Z3JaQi9XTTdRREpVcG44NGk3SzdxV1YzSExTUDBjWDdWMDl4VVQ5TzNPOUlj?=
 =?utf-8?B?UXd6ZFBJTTdPWUpvZTZiU2VuQ093UlArNDdmTG84K1RCYWxJcWVXelh1Ukgv?=
 =?utf-8?B?OE93R3RzNmtVQlhpVXRiY1EyV0FmemhTSExhWVMvVXMwcFlJUGc2U0dtYWVH?=
 =?utf-8?B?UHI1UWlPaU16TWlVSmU2T0c5ck9DMVRROUppclp4dk1xaXh4Z3lIUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d946651b-35fa-4dbd-8bc6-08deed3275f4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 05:30:11.8554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCQBfZ9FB0hy/lsa5RyXQ+NzsAh6ugX7uIBuCOlW8OUyBAJcGzEq/tbnRXBebvsyah7wFpBQP91tTeZVFRm3Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9132

On 29.07.26 01:38, 刘杨 wrote:
> Hi Xenomai team,
> I am using Linux 6.12 with Xenomai 3.3.1 on an Intel Ultra 5 125H platform. The kernel randomly freezes, causing the entire system to hang. Below is my environment.
> • Platform: Intel Ultra 5 125H + NVIDIA 4060 GPU
> • Linux version: 6.12.55
> • Xenomai version: 3.3.1

Already tried to update to latest versions? Also if varying the major
kernel version makes any difference?

> • Linux grub parameters:
> isolcpus=0,1 nohz=0,1 nohz_full=0,1 rcu_nocbs=0,1 rcu_nocb_poll acpi_irq_nobalance noirqbalance processor.max_cstate=0 processor_idle.max_cstate=0 intel_idle.max_cstate=0 clocksource=tsc tsc=reliable hpet=disable nmi_watchdog=0 nowatchdog nosoftlockup softlockup_panic=0 selinux=0 enforcing=0 intel_pstate=disable idle=poll cpuidle.off=1 nohalt nosmap pcie_port_pm=off pcie_aspm.policy=performance ahci.mobile_lpm_policy=1 mce=off numa_balancing=disable apparmor=1 mem_sleep_default=deep console=tty console=ttyS0,115200n8 splash ibt=off usbcore.usbfs_memory_mb=512 vt.handoff=7
> • Use case: Humanoid robot
> • Applications: ROS2, CUDA 13

Okay... CUDA. Implies you are using an Nvidia driver - which one, binary
or OSS?

> The following is the log captured via serial port before the system froze:
>     fiveages@W2-0000:~$ [34822.953313] i915 0000:00:02.0: [drm] *ERROR* GT0: GUC: TLB invalidation response timed out for seqno 68639
> [34824.808351] xhci_hcd 0000:00:0d.0: xHCI host controller not responding, assume dead
> [34824.816041] xhci_hcd 0000:00:0d.0: HC died; cleaning up
> [34825.000349] i915 0000:00:02.0: [drm] *ERROR* GT0: GUC: TLB invalidation response timed out for seqno 68640
> [34870.898076] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [34870.904192] rcu: 7-...0: (1 GPs behind) idle=2684/1/0x4000000000000000 softirq=12697480/12697481 fqs=15002
> [34870.913954] rcu: (detected by 1, t=60017 jiffies, g=24464761, q=13288 ncpus=12)

What is the systems's workload at this point? Is there possibly some RT
thread running 100% of the time on some core? Do you have
CONFIG_XENO_OPT_WATCHDOG enabled?

Also, can you only reproduce this when the CUDA stack is in use?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
