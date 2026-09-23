Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374819005E
	for <xenomai@lists.linux.dev>; Wed, 23 Sep 2026 05:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790141675; cv=fail; b=s6UiLzLdl00p3Nf1jSfmJnPML/j8JpsHypeZcMVFR9muetTwlGRjIFc4BPZ1KO5Xalvq6snvKDL5SXjA2stH6JzE1Z0KfCU6lTVZy/uLoF764OWWeb5LpCBEmuMjdAfSe/IGRQKWnjLzHkFFQjoyrLL9/Xo9FpseB1B9Y1UyFKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790141675; c=relaxed/simple;
	bh=+9SolgepLo/8Y/Z2G3R8bGeW1N1TRRF9uVd5wAZ18N4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ry+4mk3+OyATivCohM0ot5DU5ByLEQp7nCb3V4OVvnrLsRBuFSGa/LRpGTQ9AZz1HuYGekpKrosIDqj0bYRMEbqlnZFW0FWASAW1JqAHaAkKeq/Ed5bCXnI3LHajSHAVmlwHFHwujOFnYl1MEKhG609JFyWm+8bckHF5/AkBgx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Gkh+vsS7; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Gkh+vsS7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVe12JuOCLBn3llzNDuJnTrN0zDWWLEKs0UddHkQrLWaZogDoa5wYFStVsAIKIv1XP4UqIx1oG9ShTtVhku/8aEwZFXzjTlTMdggTWe96LVQEqR2F5XJ6/Mm93xGc5+qWTeZqZAkZkYPKn8tneFMgCsmf00ZXBz0MKKA8D+mKkGzD/j/b/kqWYDvJedbGJl1MqgOmelTLz/NxJbEw2PiAi0K7CwfDO9XydFX6lRpkJ9feqWKGvuYNH+mnS5cSG5M0Opki7JOmmZbRizgZmCJWN726j04VI6pO1m73rNcj5GV/4gtyx52RaXfvZ6xhqi1dljwyz8e9Q6o+Q6FRz+SlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nt5s6aiUoagsOiV49CzsOVpJLGdy5Ul6GB/FZlu/CO8=;
 b=c4v2VKuw3W7MWC82WDNZDMZXR/Bqle4hFalPboNCTh4f8WpA79awhxMIN7HeB7PyoM6jBlOvDgJf1qCp2g5xYYST9Bi5ntmraC+2Ywni0/hnALZeBCu/LSmRV6gdNYWoK5GuQwhE1QeCO172UoE5k9oI7KXYLpxJlOHFR6F7UZb8KhmT38q/0un7BgNdSjyn+bWxN6WRgw3oplrx6JBLUmZxLqJw35u1eXHTm2U4WBhsgOptPRcvbWkcZoJvqVeSLwd5PmBd0GI2fF5JFtWG14Upo+k8a6HsVuCSvNBqnt3Oun37Wb1giD/ZYLmXTlXf5LMYWaw3giKoRvdrjXiFVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nt5s6aiUoagsOiV49CzsOVpJLGdy5Ul6GB/FZlu/CO8=;
 b=Gkh+vsS7r9RM7hjNjmgmLf4RioyCfMfKAKAVLt1mrUOFgmvzFILo7v4ahSjDXNN7N502pLghE7Huxc8YILSngyTrah029K3RTzQ8XHKj0QEuBcrZ9+RXB3VN1KDIMLEFceps/uKNfKdRDS7qswOruDNXjOQFSQHCkJuXXmYY+Flp3brmkiB0UmJwGmbJBsjyHByfEv5Dlu0Sb3BiOTJYcZdsll1a7683OrUqFBuGb7kprymGDK1LvH3W56LQUeAHnKSYusIBs+RmH1uQyLgwYMpycpguWmsLQdCtNfCd4abRm7kpSRlrrMZ8j2iOn+uX6CMAX0a2fb7xlr8JcP6tDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7330.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 05:34:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 05:34:29 +0000
Message-ID: <8f3e2103-29a1-405e-b664-f1f1af82c4c5@siemens.com>
Date: Wed, 23 Sep 2026 07:34:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SVM: Fix physical interrupt handling during
 vmentry/vexit
To: =?UTF-8?B?5YiY5p2o?= <liuyang@sinsegye.com.cn>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, songjianwei@sinsegye.com.cn,
 Philippe Gerum <rpm@xenomai.org>
References: <20260920032219.1799313-1-liuyang@sinsegye.com.cn>
 <b75042383d2c13a7714aa538c4cbbaf59575add1.camel@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.27e5e5db.849f.4897.86af.4aed0afaa453@feishu.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.27e5e5db.849f.4897.86af.4aed0afaa453@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 615325f8-87c2-47c0-162a-08df193456a3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|4143699003|10067099003|3023799007|18002099003|6133799003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fYMidyKPJLUP+3LXfnv6Ol9/ZKukEvzuKhqoGQaQniQU+3La4bG0IeUNj5CogmnlwrLWxKN/y19xBK6XgLnWQAiw82oqJbtiRNHSF0tCtrOVb/CggosM9gcJIkHC7KbqUtw6kIjxcMRHcqHoQhQUX7Vh3nb5OwplMCZlcv12DoLqZrwBlfZhL1oGby9g+/Z8ernWRNBwOmQWgmlipKyzBT4z8Ecj4Px9hFy3B6HKOKkDfV9dlNMwCEUMjx/EDdgKyvK9kAwS7o/6CVZcmef2/vK4D30sInxvB350EDwgvjQ+S6hZvWTv+IMM4+3W9Vhq/KTEHFFHsuCH6wtGToh/cgLSmo/EVfi1gkPdeM1K5GuPABi1uX2lR/VEBoWWR+na7EVDGAU7oCv+hiCIUS9bs3lY2P34RfUYtnO3/Ja3Mv4jiGe98cHatz8Wj/FhHfeg127mMCok6gKE/xh7TYuxcTJUkQYvSGSRkZzkkDI+QT2asc+HU0IieiBaDYjt527m4uk/e8vk5Q07X+iEvdU4TpWlaL0oOvp4CuMdxm85EaU1vyZBDCn5+cZVe6BYOhtUi5r3xqNUyzOqrcHO6VdLMEWUZErAsjbq/TDOzZmi6hhyROdkhp1JabYGG16PPRuVDxRPhxR1HQC3cyYAxPAFFwy8MwMc4YUc8SWWZ9vGE2o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(3023799007)(18002099003)(6133799003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWhqSFBKOFQzV09hL3Q2UHJIQS9Ea3gvTk03OTNIcUZwUG9JTDZXUTRaZGh0?=
 =?utf-8?B?Y1dZY01zTXJJbUcxRzRGMzloVEE3Y0tlVEFlODFFMGhNWURxQk1vYVlNUVhM?=
 =?utf-8?B?NUsrTCtYdFdQUnhBSTlXUVhzckNqS2N3QktoZkxYY1pqWHcrejB3ajJVWkF4?=
 =?utf-8?B?ZmcwdkcxdmN2T1ExTFZBMFJkNUFLR2lYeXF0RWVEbWs0OVdwVTdISkRNMjhI?=
 =?utf-8?B?bnZCai9WeUZHcEVCdkdPM3h3ZEdnaVhTZm5vSElQRjc5cndMMk5aUnVnd1Zy?=
 =?utf-8?B?elpHMm5TandKMlZhVVhFdjRKL0w4WWREZlJ0TG9GWUk5UXJRQTNURGowOHJ3?=
 =?utf-8?B?a3JBeTR3cllWM1dXVUJZYUc1Zmk4OXFCMUtLNGVpVkIxWTNLZTRWUnd1ZzJY?=
 =?utf-8?B?Vk5rcjZmNzBYVGY2MmZOM3J1b21mUWRzMXAzWVpoTDZ0cm9YaHZ5cUN0WEtq?=
 =?utf-8?B?bVMzWm53THdyVW11M200amprODFjZFhtSXFRV1l1QXZSakpOc0ErejJlSG5N?=
 =?utf-8?B?SjhIWFpqYlZhV1lkanFTS0xiY2EwV3Z3d2VTekMxTXZRVEtYMFJ3dURRelRN?=
 =?utf-8?B?Y2t4Q0hRZkVoMDlnWVF5amYrdDFhQURQZWxWTFVTeGE1RTBpWDF1am44MWx4?=
 =?utf-8?B?Zm1sZDZxN1pZa2FnRXVQczdRbEdTZXlIcXo0SGVZd29QTTRMcHhXWkJyU09r?=
 =?utf-8?B?SXp3SDRrbzVJcGJaUE9MNGNDbzQ2RlZwZi80a1B5RVV5aDdTR0lWS1ExSER6?=
 =?utf-8?B?UHBCaUhtVUpoUDltVG04cmRIUkk1TS9CdVhNOEZsWE0ybXJsTnhOb1R1ZU9L?=
 =?utf-8?B?d1crUFlySTlKbXVLZEp5Ym12NTF5bDZMMjFhK2RqamVjbDZjKzRObUxFMWlo?=
 =?utf-8?B?YklpQnJJdFd3VitFeHZnSitZMWw3cTNDNExaMUtIUTE2Z1ZlL0pGZmhIOEJw?=
 =?utf-8?B?T0E0aDl1dWxrNVhubEhlbDhtclVBeEFKZHNsZmg2UE0yaFpwSmVUbVErU2lj?=
 =?utf-8?B?WHAyMzZpVnVkb1RWT1IxODk3alFPSkNhUlJjMGpaRWNKVUVrM09ORE5sbzQ2?=
 =?utf-8?B?dTg3UVNFazBHcWtnRDZ0QS85Um42UUtGRjhrMEgxWlMyZGpaeU52eVJQMnBn?=
 =?utf-8?B?czhhMHppUUk2TFJNSnlicWJBamRJbXBhQzZoUE9UMDRYbi9sdDdrOTNXV2JL?=
 =?utf-8?B?Y1RqUkFuUTRmSmZxYlV5dHl5L2dEbXJUZUlSOVltOW5EeURUL3ZkN3RnL2p5?=
 =?utf-8?B?Yi9ENGdQSjZOcXZHV1I5Sm40QUhtMnV4VEZrQ1dVK3dvb05RL3JSb1Y4eHQ2?=
 =?utf-8?B?Q2ExSDZlTWRjOUk3VWpzZEY0SUc1enE5Vm5RSlROZXNOSnhDZjlhckc5TUZ0?=
 =?utf-8?B?QzJLMGRQMTVFT1FSSU1jclJjNzRMWVdrcTBvblcrZjF2dUFLV21vNGlxdzg4?=
 =?utf-8?B?REdYa1pRZHY1K2lxSUlSUTk5RTB6OUlTMHdvYWZ1Nnd2UWNRZm1KaWdpeUQr?=
 =?utf-8?B?OVJBKzU2M1RMa2c2UVJ6VG5Rd0R0V3l0Zkx2SGdDS2pTOU82NlhULzhBNzBM?=
 =?utf-8?B?aS9KcTNSZVRmYlVTbERCMFNQTjlncWxuTGxRT1E0NmIxVU9DRUtCQ0JGVXNV?=
 =?utf-8?B?Q1JmeFFsdHlNOUhnV1JtbG93U3dtVk1zVmNjeUVkc01oL21hYnJROXBzcGxp?=
 =?utf-8?B?Q0tBaHhMUzc2SW5Ba2ptNGx5aHA1dk1vR1pIWDVuZ3pFajlzUjh5L3o2U2Ji?=
 =?utf-8?B?QXFDWFRYcUZtSkZtVGNOQUp6RDkxeTdic1dmMGNpdFlBVDI4Q2MrR0MrRTNZ?=
 =?utf-8?B?eXppb04zNy9PYmJIS0ZMOENMTmZrRmNVL2NFQzlPbFY3bjRyaVFHd3ZScnlv?=
 =?utf-8?B?K3JGWjRyNHF3aGNwN3NhS0lXM0pJQjFhbVFIYWJDbFlia2V3SXVYMlRsSUpG?=
 =?utf-8?B?RnB6UitlZ2VOUHpET2tRbEFNcEltUFl5R1o4aUNqbFErdGlOTG81SThlMGVZ?=
 =?utf-8?B?cElwclBLN281NlBwWGtIdU9ZaFZlWXQ4ODYxOUhEY0pSVDk3eUVaSjkwV1li?=
 =?utf-8?B?Q2dnM2dDTUd6aThLbkRqM2gwblVjWHN6c0E0SE4zTHdYNlJ1dWI0UzFsSHhy?=
 =?utf-8?B?NmFlMjJRNURSWXpkRTZTWTA1UWUyTVlJb0JiMHB0QzIzRHRyTkEwS1p1Y3pp?=
 =?utf-8?B?Qm1ScmE4VTBEd0xMSmlqRlc3c0xwanFYZGljd0VJZDZGZVZkdnNvMFhVYjJN?=
 =?utf-8?B?MUJXdFZyYkxhZEpuVWJ5dkpDamM4ZEdZV1huOGxTZlc0bVhYVGFCR2pkY3NJ?=
 =?utf-8?B?ZFM5WXl4MGszdkpXaGEvYXhaU0w1ZDZJZEE4eHFOUCtxSnRXcGRIQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615325f8-87c2-47c0-162a-08df193456a3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 05:34:29.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X8ESTgTfCAKHdaORNdTfRKsENe6lZ2R1vL3MrHXuzUSenzmm71nCWz3iKXONBokCGcvHKKAJbE1/X2CjbDO8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7330

On 23.09.26 04:08, 刘杨 wrote:
> Thank you for your reply. My test setup is as follows: 
> We use KVM+QEMU on an AMD platform, with CPU passthrough and AMD integrated GPU passthrough. 
> The codebase is linux-dovetail 6.12.90 + Xenomai 3.3.2. The issue I encountered was that about one minute
>  after the virtual machine started, the entire system would hang. After I tried applying the above patch, 
> everything is running normally now. I'm not sure if there are other places that also need to be modified.
>  I have tested on both AMD Ryzen 7 8845HS and AMD Ryzen 7 7700.
> You can use an AMD platform and start any virtual machine on the latest linux-dovetail kernel.
> 

...or fully emulate SVM in QEMU - much slower but possibly also exposing
remaining races (if any) differently.

In any case and I as already pointed out the last time KVM came up: We
need KVM workload aside RT in our regular test pipeline. Could be
combined with switchtest or at least become part of the background load
that we run during latency tests. And if that requires having a physical
AMD machine in test rack, then we need to add one. But maybe QEMU is
sufficient for that as well.

> Thanks.
>> From: "Florian Bezdeka"<florian.bezdeka@siemens.com>
>> Date:  Tue, Sep 22, 2026, 21:15
>> Subject:  Re: [PATCH] KVM: SVM: Fix physical interrupt handling during vmentry/vexit
>> To: "liuyang"<liuyang@sinsegye.com.cn>, <xenomai@lists.linux.dev>
>> Cc: <songjianwei@sinsegye.com.cn>, "Philippe Gerum"<rpm@xenomai.org>
>> Hi,
>>  
>> first of all: 
>> Thanks for reporting that issue. Highly appreciated. 
>> Some comments below.
>>  
>> [ Cc: +Philippe ]
>>  
>> On Sun, 2026-09-20 at 11:22 +0800, liuyang wrote:
>>> commit b2a37d35 ("KVM: SVM: Use raw_local_irq_{disable,enable} in
>>> svm_vcpu_enter_exit") replaced the explicit cli/sti around VMRUN with
>>> raw_local_irq_disable()/raw_local_irq_enable().
>>  
>> The translation into the dovetail world:
>> commit b2a37d35 removed updating the hardware interrupt state.
>>  
>> The code below now touches both states, the hardware + virtual IRQ mask.
>> That is not an 1:1 replacement.
>>  
>>>  
>>> As a result, the pipeline may still believe that physical interrupts are enabled
>>> while they are actually masked. If a physical interrupt is taken during the
>>> VMRUN/VMEXIT window, the out-of-band stage can observe an inconsistent
>>> interrupt state, leading to a stuck vCPU.
>>>  
>>> Restore the explicit sti/cli around VMRUN so that the Dovetail pipeline stays
>>> consistent across the guest entry/exit path.
>>>  
>>> Fixes: b2a37d35 ("KVM: SVM: Use local_irq_{disable,enable}_full in svm_vcpu_enter_exit")
>>  
>> The Fixes part is not really correct. We never touched / supported the
>> AMD / SVM part of KVM on dovetail.
>>  
>> Looking at the Intel / VMX part (see commit 
>> f6885fab3c2b ("KVM: x86: dovetail: enable coexistence with out-of-band
>> scheduling") in 7.2-dovetail-rebase, I assume there is more work to do.
>>  
>> How did you test that? Did you (IO) stress the host as well as the
>> guest?
>>  
>> Seems I have no AMD system at hand ATM, so unclear how I could test
>> that.
>>  
>>  
>>> Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
>>> ---
>>>  arch/x86/kvm/svm/svm.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>  
>>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>>> index e02a38da5..0e19d42b7 100644
>>> --- a/arch/x86/kvm/svm/svm.c
>>> +++ b/arch/x86/kvm/svm/svm.c
>>> @@ -4406,7 +4406,7 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
>>>           * IRQs are being enabled/disabled.  Note!  GIF=0 for the entirety of
>>>           * this path, so IRQs aren't actually unmasked while running host code.
>>>           */
>>> -        raw_local_irq_enable();
>>> +        local_irq_enable_full();
>>>  
>>  
>> local_irq_enable_full() enables both, the hardware as well as the
>> virtual IRQs. The virtual part of that should be fine, I'm unsure if we
>> should (unconditionally) touch the hardware state.
>>  

This should be fine, look at the comment of the original code above.

I vaguely recall that guest entry has another IRQ mask that protects the
atomic section between the host switching certain bits to the guest
state and the actual guest entry instruction that switches the rest,
sets the guests virtual IRQ mask, and restores that GIF to 1 so that the
host will receive IRQs targeting itself (via a guest exit).

Jan

>>>          amd_clear_divider();
>>>  
>>> @@ -4416,7 +4416,7 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
>>>          else
>>>                  __svm_vcpu_run(svm, spec_ctrl_intercepted);
>>>  
>>> -        raw_local_irq_disable();
>>> +        local_irq_disable_full();
>>>  
>>>          guest_state_exit_irqoff();
>>>  }
>>> -- 
>>> 2.34.1
>>  
>> Best regards,
>> Florian
>>  
>> -- 
>> Siemens AG, Foundational Technologies
>> Linux Expert Center
>>  
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
