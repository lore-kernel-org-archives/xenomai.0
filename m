Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010057.outbound.protection.outlook.com [52.101.69.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B07B3128B8
	for <xenomai@lists.linux.dev>; Mon, 13 Jul 2026 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939831; cv=fail; b=flJp6BTN+Ypx4qTjFxu6vsOwhEIC1CCcElzV3Px2lZ185ei9LFGFkd9nohsoxi3h9tZcJkDZ+nYI6aDghAllIAFSvE824X+25oMbSY4sQ2bjA82t+ctfiQPsEkFE6/c7f3PdI0s5Ns8oh/42P5VrxSB080r1daymMW75THu415k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939831; c=relaxed/simple;
	bh=8nJBCX9/V1hVT1aFhpE2iZL3N3bI0ws8wAXU2fX6+A0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uWv7+pZJpTg25R/O9787q/9t302EVGd7DnSv1aF9o/CvzeqFV21hNTM/CR8a1nMxZ3NVIhZ7PC8/5lUcc6e0tsWPK1l+tBFd4Ab+Lzh6CdLEhn2/NQxUn07ykSlellCTlp7yQ6MuenxYULIOVDHe7EGRmyXEEZQcdpxIbXtuIhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IwdHk5qs; arc=fail smtp.client-ip=52.101.69.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IwdHk5qs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVT2Kf1oOLFdvWUNERplA2a0FqrkEDu5fb9x02oXaVMuuYjDjiWDUlUdLFpxr0cCsbdIHIV5AGcDPoMuqtVW7/D594+VLYxfDJjpXovaKTVFoAMfoX3kVZk4yYZ8ZZRkLPQ6+7XOXTqFN0yd5a9dg8V19/mNPUl5jRjnQWIinnbTe0fXr/pceMbytw+df1WSt5Hn/ofuFJoU4oy+Goep3ulrSukAvlZb7N5aAM4K13JHyVIHLyGztdngANyJ173n2EWz3WGO3jGB9GPcindywISvvDC09MmTeBd52OYqUODVuIpcFm9Vke5waawoSWS2IbvA2NKXaAIigoRm+b9+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rApAow2KvD8LuPHcrA2pwlLuRXESlHMVJJxkXi3mX0=;
 b=HzPkoU4B3Fwky06q2O/e+9Sf0MODukQC5zmOwtchFbTGwAyq5uumRKEcFOsaLayK1VRAQNs+WNjc1HtlfllBXdOYqPPB9Ics/ZI8x6QRPWQc6A5z1/EeOXRWMDzyFHH6zQEjLrFFNJHr7Tx0PQ7IvRsFANK8t7OcJ+BJ9Icp+JjBlf1XQVbDwQkOWoVYwu9i5y3xAuc4nkx1wtTJRi0DGCH6j8by467NWruXUgrO8LHlS5MWlGCMTFIl7WOQvBNWDOT+Px6qZ7PR340KGIpOWM6WE08q9r02DBNM9lkdmds2FD+2yXxiMTtelsLrQIZCHg553SqQhPZIc6Rp1mX3Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rApAow2KvD8LuPHcrA2pwlLuRXESlHMVJJxkXi3mX0=;
 b=IwdHk5qsLU1843e03eRnDUHxygDEk8Dd15Ov9Gl1bR4SYVbpkPEluyggUadcn/gjqdLJ4y1q9lWiyEOvGfSo+m6e4Q+YcaDGhyaM87U1GdUsXcGEMRQPywvqFZnb8pYrN3D5W1fXZeQLfjQacFBrTT8OuzKtN4gH7dBSiktUYVO0+k4sguNTzwyXk50/koENA74uQUAZlqm2x7F7I8kYGO+rmEsQds7ODfD+Bf/4ZKFtfNEsXtHDlqwehGFrA8cVRzuBRZ24I58nl8qRnFmqwVDGbZ500ebSixK0RQhOOtCeHbXUv/y5jdL5XzFKfKfCbEZ6HLhNBXWhXAaaQoJ5jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5757.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:247::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 10:50:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 10:50:24 +0000
Message-ID: <5cf04167-e9fa-4e25-9fa3-c29e1a18fe3b@siemens.com>
Date: Mon, 13 Jul 2026 12:50:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] irqchip: gic-v3-its: irq_pipeline: fix OOB context
 in-band lock warning for ITS lock using hard spinlocks instead of hybrid
 spinlocks
To: linz <powertree@163.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>, xenomai@lists.linux.dev
References: <517534d7.8863.19efe1f45f1.Coremail.powertree@163.com>
 <ad8e6855-2d67-49a4-9a52-9819b93b1802@siemens.com>
 <023fa6882b563713cbcc06bd954c8e9db4200d73.camel@siemens.com>
 <c017bc0.9041.19f5afdb56f.Coremail.powertree@163.com>
 <6ca12451-a015-4b54-9e22-0256e97d834e@siemens.com>
 <581e35af.92dd.19f5b124b8a.Coremail.powertree@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <581e35af.92dd.19f5b124b8a.Coremail.powertree@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 43050ea9-de4b-4a6e-1539-08dee0cc8b01
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|55112099003|6133799003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	2ApSUJiKkLc1IXFs3Qn9TGXXW5+TtRD+kubtQDMh5Vxx7E/AXG2Y6TSAKgbx7PBnruQPvgiVuRS+qRDmrB0rrqqtzcqP1MeksN1jrNAwsq0joWHupb85ZyPgWlfd4tHIQ7DgDkh1t8bhut1pgYrGECzD1+QQBe/Cs3W8DI2bI5w+3OQ5kTHS9V9ZwLkQjQxBSPYll7sN4C9XvVPS7Ontt7IhkIi8LicKi9qgy0FYG7lADROst3gTM8YhK817oHYnPe3ULAGTIcRwih7FTxVuGgRI2X4oymLAImA3r7e80W/F61s2YhpHm363wkxtFdlNpD+Rj5PE1mI46tF3QLbyLh8MMWRiffc2DA9jQfnXQs4lzBtTkyFZZuwNdsa61Bupwd5tlw9kxpp3/n7iUizALkQlXZu/fLuGWGmsybjFStFcvHoeWE9UMaR5p9kLzYhEQVF7l/AmXhkuEBBSCV3uNVHLhDEoGB5faLYm3W2A1S1uro6zgwfpQcJ/Z7+PTzIS27ZLOCWhMpK1n1x8aF9VogOiiwqQLW9m61p7eRr83BvubyQP9UVjjmRFfXhd5UKqe7n7sKSxdX00T/hqgel50wDvB7qPFbqBzxyx20SSvpI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(55112099003)(6133799003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2RIZVV0NDRQWHU5dGJLKzZSUjdYSVpTbkM2UlpOQTNueG8zbUw2bXVzQWJQ?=
 =?utf-8?B?Ymhna05KaUJwa0tQZnNNdGdMci9jWVdxU09Rd3ZVK0NOVnYrSWdvemtrOFJP?=
 =?utf-8?B?bGxiNTNuRGo5RXNDdkt3RDU1WFlPSk8wSVRIeGxnSS9aOEdCSWxCenJHdm5a?=
 =?utf-8?B?V0xkS1JIMkRZOFBoazErTGUvWHRxUnZDMWp1M0NjTFpuUTd2bTdpdWJReFd5?=
 =?utf-8?B?bW9PTHFSa1dHelhPVkxVaXlrY3pQd2pqK3dhL3Jlc1lIOThIRHVWSUgvRHg0?=
 =?utf-8?B?MVBJczBiZkpxdlJubVFuNE5Vdkpkano0NnZaM3NBdVNZZllEZml2WHh4b3ox?=
 =?utf-8?B?eHo0ajh3WU1iVjZqS1NZZ0d6czFVK3BNVk1sa0dUL0FIaXhRdVA0cUErUUlr?=
 =?utf-8?B?SWthWndlY2JjL0dxQTZKdkxpb3AwMld0YlZDeTdWejJPaFhaWWR4NXppMXhT?=
 =?utf-8?B?V2pNYS85dkw3bFIrb0hzeGNidGNDdXNpYy9qNW1NUjdrbTFzKzh3clRsbjNv?=
 =?utf-8?B?WXVodlVKQ1E5OHNkTlphK3NiT0ZjRnk3RkprbXgwaGdMZzNuT0FJTVNsVis1?=
 =?utf-8?B?MlB5SVBna2pURStNSXgwL24vVDRNaHBFODVVVDduYU1Uc2pKWi9QcHpQbjhq?=
 =?utf-8?B?TDhZeWxJcldDZE5CMTMyVEFOOVNSRlR1V2VGdURhVHpobkYzNUN5Vk85akJ1?=
 =?utf-8?B?UGNZQld4N2d5a0JQTVA2Vng1TE1HTm1ubnlIK2NMZERkbDJwWEUxeVkxWGZm?=
 =?utf-8?B?RWRaalVKMnhDa1pkVnpmbVNGQzdPUHRhSEEzazNlZ1hUOWpIbUl6OGRkeGFp?=
 =?utf-8?B?MFFYVVdYTlUxcTFmV3czNWFnTVUzRGM4cG9NS21nVFVJWEJhSE9oOW4zeVY5?=
 =?utf-8?B?QUFvNlUyWGNKdTlZeEZQbDluclVkWFUySnFMZFpRWklRdWlteGtBc1dqTWdB?=
 =?utf-8?B?cnRtL1kxSy9TOUhPSk9zUVI0UHh3NDJORVovOU93UmFOUTE5TEFHSmhCTUNo?=
 =?utf-8?B?UVVIRnJ6MjBjVyswQk1SU1pHSTNUdlRudTVpdzZqNUJyZlBLdEhONytmaUlS?=
 =?utf-8?B?UjY3RWFlMTRHYzB3cVpOWHpBVDB0aE1uTHF1NWRubFphbFN6VkJhNkdQZmdT?=
 =?utf-8?B?SEVqVDQyd3pDb0k5MmJUcnpmTFB2SWU0Mzg0UEllYnJHMXFGTzRwcUQzd1NR?=
 =?utf-8?B?YWZpWWYxMXpqL004bGhTUmJFbG9ZOWxtNFFTL2xtM1QybXNRNUgzNkxvODNh?=
 =?utf-8?B?MkN5T2VHT1pESkJ1ZXc5bFZDbFllMFVBaEhNTDlKL1BXTklsQ0NjdTU3Tktn?=
 =?utf-8?B?dVlrcFU0TjBoTXZBT2t3MEtqdEZhNVFtNS9laGtnb1JxTjlnRE94blYramlB?=
 =?utf-8?B?T3FEQXJETzhMd1VpWTdwaEppV0F2YXBzUlZka0JjUm5HdTBOWEZ2QWpXSTd3?=
 =?utf-8?B?UlVaNHJ2UXZ4elZyQ3M0MXIrNjRZWDVXMkpiMmhSRW9tZTFxbXFNU1NnZ2JD?=
 =?utf-8?B?bktzZS9qL1lHSVJRTGJ5RjE4WnFIdHViaW0rc0dJR2F5dVhuenFiNFdCTmN0?=
 =?utf-8?B?anRCNjVVaVR0LzRxQkwzR0NKa0ViZjVFSmdoUHJ3eGVnN1NuK2NHRTUrR0Jz?=
 =?utf-8?B?UG5lNjNaY2RUSkp0WXpKcE1WWFRnRTJjbGpCWmFNNzNYMWd0YjRwbGNFekVM?=
 =?utf-8?B?SVlJZEVtbkVYRFcxSDRvOEJjRUtSU2tQUUlFUCs1ZVdsUkFPcGNlNXh4L2pJ?=
 =?utf-8?B?NXNtR0tJVFh2NWh3a2pHdFBKWEFWa1RBemREdWpiT1NRYVV3blMyUzFuRE94?=
 =?utf-8?B?bFVUNHQvYVNkdzRialhQelZoL1F5Z21oS0o0QTNLQ0VlMW4wakVIMFpHeDhT?=
 =?utf-8?B?bEJna3dBSWxNWGh3djYrYW93YWhOeXBTK3lUM2xFdVdXYVpFUlFzTkNqL0pl?=
 =?utf-8?B?Y3NHSnBuK0x5b3hCWGZ3bDR0VmhzZDd3OHh0cGFLbFVBVDFvNG9HdkdGaWdj?=
 =?utf-8?B?MEZvQlNnSHdiRWFDVEF3bk5LU3NDZ1NVYlRpaDgyVm1rYkZnbG53WU9Rd1Fy?=
 =?utf-8?B?V05ZMWFvcU9MQXI4QzRtRG1RazFNWUMyWm9Fa1p1ZTVDYmlETnNrUnc5NzRa?=
 =?utf-8?B?Sm5UME91bGNzbDlubjlqNWs4L2JKOU5zaGhDMUs3Z0JNQUY1UXFlbU04UHJW?=
 =?utf-8?B?NTNPTm9INlY1NDNDR3BTdWtXc0V0ellEZXFuWXJrdlpBNFB0dlBmZVI1RzhB?=
 =?utf-8?B?L01UTjF4QTBFcTdsQTNUV0t2LzdaQjA3VitGRVpSK29EWkR5cUlNbWs2Ymdz?=
 =?utf-8?B?OVZZdzlEU0NRYWsra0p0VzBIQi9Jd2JKMkJUMURJZXR3K0VBYWlRdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43050ea9-de4b-4a6e-1539-08dee0cc8b01
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:50:24.4686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3j3f9hnI3uScjZYNgl3X1M8ni0u8fp9BLJK+vDo7UcJM2oHcSzih8VKPUHMxskrZ2ETWrV4D0uq7ZA6v+KAkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5757

On 13.07.26 12:42, linz wrote:
> Thank you for your feedback
> 
> 
> The gic-v3 IRQ chip is already marked with IRQCHIP_PIPELINE_SAFE. The its_irq_chip is not marked with IRQCHIP_PIPELINE_SAFE. I added the flag and tested, but it did not have any effect.
> 
> Meanwhile, I read the code related to IRQCHIP_PIPELINE_SAFE. If the gic-v3 IRQ chip is not marked with IRQCHIP_PIPELINE_SAFE, a call trace like the following would be reported:
> MSI domain irqchip XXX is not pipeline-safe! or irqchip XXX is not pipeline-safe!
> However, I did not see any such message in my logs.
> 
> Based on Florian's suggestion, I revisited the Xenomai 4 documentation regarding hybrid_spinlock_t and hard_spinlock_t. 
> I agree with Florian's point that hybrid_spinlock_t should be limited to struct irq_desc and IRQ chips, and that hard_spinlock_t is more appropriate for the ITS node lock.
> 
> I changed the lock to hard_spinlock_t and tested it. The call trace no longer appears and the system works fine.
> 
> The patch is as follows. Please help review it:
> 

If you want to provide comments on your patch that should not go into
the git history (like the intro above)...

> From e0cbc9316af331bf007c86e1fcab0ef8699b05c9 Mon Sep 17 00:00:00 2001
> From: zhanglin1040 <powertree@163.com>
> Date: Mon, 13 Jul 2026 17:53:44 +0800
> Subject: [PATCH] irqchip: gic-v3-its: irq_pipeline: fix OOB context in-band
>  lock warning for ITS lock using hard spinlocks instead of hybrid spinlocks
> 
> ---

Put them right after this separator line.

But your patch is still lacking a commit message (text after subject and
that separator). And there is no Signed-off-by
(https://developercertificate.org/). Study how over patches look like
that are shared on this list.

Jan

>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 0e57735eac..3f2b02b8f4 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -94,7 +94,7 @@ struct its_device;
>   * list.
>   */
>  struct its_node {
> -    raw_spinlock_t        lock;
> +    hard_spinlock_t        lock;
>      struct mutex        dev_alloc_lock;
>      struct list_head    entry;
>      void __iomem        *base;
> -- 
> 2.34.1

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
