Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2AE17BB5
	for <xenomai@lists.linux.dev>; Fri,  2 Feb 2024 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863089; cv=fail; b=IXRjfqKG+zdffaKczmgkZv67vrFmrI5ORo2gGl+xpwgn2xzyUk3n0lO7nymv0m2seEV1NNT+2CiCBv8NC+n+uuISjLd0SmRbQzLoP7MWKoTrCaI1VXoQRPURM7j1b/k+taS0AMCfvCnrKtKcfviOTYsvzjSnkHpZuyZnZOTA7QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863089; c=relaxed/simple;
	bh=HevSF80cPih0qrmacqP70II0y/KB4B9s0j0JKh+2/c4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cdlIXiH1qqzX9rdb+ar2j4JD3/pyn2du72hZS6xXWS+Db7OUUQHL8RX/XjFdwAzKL7Cw1z9ABaIIAadQ0xgqvhvbKSH2Z4EgawrG6DnjKXgbxP2nx1gUVSOhDZONviG9KxCCjyPA8fM/m2peAjODoZI4fJouq5zvCGssBCeCKw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qo9jGVPo; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qo9jGVPo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjSZS8nyc1VnxqHsy6oYZ6II2fBpET2+QWVr7LUjbqo/Av3Z3a8+d1EqkDAjs9CoyksVz0Ul0ZNL8QttCwUqRt86fZDaE9FkLU2xDvpCrL6+yFyrXuC7qfkB+Yq6d6HdWpP9ydWc0Sqfms0qWPfoNjyVOLNVvm3NHqhG2hAgM+UP2O6z5/hhD+3B6J3goJzmI/ms1J6jBOV5y0/BOVesQwBcO9B1yA68yAE53v3qZCHnIIx151wDjAPt4NLs6R1VDNpQxQJS5vEONo4LVVsayoGADdZbxYRKYu018g5ffOrHHG+SyJtvjaEAbNJMdqwimX6f4xq+SWNC8N84I41WjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDjkmGphj+332hdbb6+9oGiX6SYNMYtMki2h0VoiQTw=;
 b=hfU4ROPjlIwzq52YnLgL5QKcCUsyRFukkgmZ1XHqiGzaaoeJoblIVe+4auy0aVExdha0fMWMTii1IjCBLN2vQywyK4gV1N08Qh6jcxyfh1PYJfcUFr5COKmrE3MltiHysllCa5wtEEVAKgV6YXQAuce8EtRbXSKG7C2yCOAnGtmCiLrA2vcr0HyUIgpIz19PSHyjVicFpqYVfegP7TdUqI7R9vB5s4Ya9bNXH1Wp05fHh6oARHWceMcNL1ymT/E3HWGpkl/rPUihPS3OmnkzV53UDJOs5oMtmFkXbX6vuozwzr8wt6oYmb7DwFu30VcJPUcqoORDwPzUYN5Rhmb8zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDjkmGphj+332hdbb6+9oGiX6SYNMYtMki2h0VoiQTw=;
 b=qo9jGVPoS8+LE6rBFNT4HrPHJbNhe7pMZzrKsrUu3Kn1ZvzCwERUbssfNgTzNpu0bggfmyPF5lk5NdkvkBPuWImZKvt2AMj3q3cJEKiAz34apOnIkGUsOZqFDLuptcFQNtWgEEG0boKRSx9Bmxut2ekws2jfPDz5AOg0py46iCD0avo+W76vlcjXfLVh9I2fLi5SG64JQWE9lmGDRDUkEWvrd/43mZDE18jKUxnGxc8C1s1d6Gjo2AezNG7ZWflBrtTbxGJXxhNInKDVQwjKSFSB0wvPT2gY5XqM/XVn7xhRWL3kO4/OwhG6RvG59aKCZBG2zCIsYax374AqIm+cfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7602.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:545::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 08:38:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 08:38:01 +0000
Message-ID: <c79218e4-cc6d-4f34-93b3-e1405978476a@siemens.com>
Date: Fri, 2 Feb 2024 09:37:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: NX-protected page
Content-Language: en-US
To: JerryJun <jerryjun123@163.com>
Cc: xenomai <xenomai@lists.linux.dev>
References: <3ce13f2b.183be.18d2f264758.Coremail.jerryjun123@163.com>
 <87ca0f83-bb2f-49fd-8e30-8873778cd8a9@web.de>
 <6bec8d20.61c9.18d5e68d09d.Coremail.jerryjun123@163.com>
 <e1accac9-4044-4379-8d4f-f0eb7cd9d713@siemens.com>
 <fd2a3821-c4e6-4866-bc65-0bbadaf603e5@siemens.com>
 <799babe6.660d.18d68cb571a.Coremail.jerryjun123@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <799babe6.660d.18d68cb571a.Coremail.jerryjun123@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0327.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d7bec8-665f-47c9-1c91-08dc23ca4451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2ZcVaOEX3y8twfhPRIH87icMprLWEndv36SDB8BnfXR0EOuDzMU4dlLRMObflYK9hWPyA5i1EFSBYWinCliBgxORMAOqCvKGAhrcdFjI9PAQEomL1czNMgdEaAhMKe2l77BfOw/Nn1LqPdVOO5LSwkWVMYdSn/E1vUe7hR9ymAp5Y2Xa+TXGbpSe7wmJS62Kra47BBJlFJRxQkTd+xSBCLOSwSQn/K+yVRGsZYXiYwMveBRnU38QMcoC586BSmYPY7f4f5XExdD76Y5ygSHYjXrv1vraVkg3h2pA5WUH7igNyXil2DWMjqCjTam99YaCtgXi9O5HDdERLUI3OOwIVgSe3hd5Z61OpEzOm3PJM+NiibajNzHtdAbIPsf5a2N2Vzzm43JRsYJkyqAr9uz4GM+O7gqah57zUyK+pjG40iy2peGasG+cz1nGUrVhRvVfLtpBpsP6RkyT+Gj8lFTVK/9zaXSkPt71ZkIEBdPsw0Q0K0sz4qwawGILNh0K0U4+AVe1c2Cu3fleEFEBpMz8AgZVlyaZN77gX0sqaGYmpdGaDZbhNmkll8t6HDOi0LcRZH8jQhk2zyqGT3AhP3uXH8+s8p/hMLraiBBirCtQa2inG/i5Pk6lpxSLk6ACK4djHrSSFW7u0bK6aldDl/t3Jg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(31686004)(478600001)(44832011)(5660300002)(83380400001)(82960400001)(6486002)(6506007)(66946007)(4326008)(6916009)(66556008)(316002)(36756003)(8936002)(8676002)(66476007)(31696002)(6512007)(45080400002)(53546011)(86362001)(26005)(2616005)(41300700001)(3480700007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkJkMGg5QWVqOWwrMUZmU2NJTDl6UVRlRjhUWDFES3VQbG5DSnVWWDdub2Nl?=
 =?utf-8?B?K3VjZDA1RERuRTZwaVp0bEtTWHRVakJrZllqTGsxK1lEc0U4QUtnaGtOVTd4?=
 =?utf-8?B?M3E0ZGZxRUpDdnJJSEo5cVdsSnBkV003OEJicWZ1Y01GUHVFek5QTy9nUGtl?=
 =?utf-8?B?aTQwdCsvSyswd2Frc3Nab3pUVWRLVnFXRnZKV0J2bWhiRFVyaUNvT0pnZ0Rj?=
 =?utf-8?B?aW5ocldBT2Iwckl0dlN4enVuMjhTZ1V5R0ZPaHlBd2ZNT2l5eEVyOEY0UDJ6?=
 =?utf-8?B?OWNXRC9kenBLZjZiNzYzcFp5YlZuTFRBU0VYUkJBRFZWQi9KT0UyY0E2MTJI?=
 =?utf-8?B?WlVaZmx0dVhBZjJSeTNNUnd1NTcwTm15U3l0SE9zOUJYeFRHcitIQ2Y1dHcr?=
 =?utf-8?B?aFJndVhYZWpTRE5VM1VsNXRvbXBSTzVwQlVzTUZoemhwdk9RWmdJMk10VUhQ?=
 =?utf-8?B?N0QzQmU4UVdqQ0lPWnpuZ1dJMHFyTk42L09WbUtYTlA1TlhXVmN6UjNRTTIv?=
 =?utf-8?B?cmFTOHNzRkszN3MwK0lNVTA0bm42QTFDL2kxUWlNMlJub0NXNnFKSEExYjdu?=
 =?utf-8?B?VjJ5RDRxUkZTK21JdzhpQW8vZ2QrRzVJSTlmbXJSOWlBUGQ2ZlNtRkVwbGlD?=
 =?utf-8?B?VEQxbkd1UEIrVUcyK1ZHMEc4ank4Yzd6V3FJdTBmL0t6ZWkxUmtsQWxrOUtm?=
 =?utf-8?B?OHdSNzRpWWpQZ3ZJM0dGcTh5STEyQUU3blBuZ3Q1YnZQQzFmU3FJNU1JVW12?=
 =?utf-8?B?ZThCUE9mSVg4dGNld3ZuaXpGU2lnZXlVVGZXWlhEbi9EcTFOWkE3QzI0U1Vw?=
 =?utf-8?B?bWpyS1FmVWdxRkdwK3RLaHJwR0puMEJ6SlZBTUVLSnBiNG1yNnJmMmVhbXcr?=
 =?utf-8?B?bGRNVFR5RjhjdlJ0Vk0xc1F1QnZFdFExL05idEc3dU5HWktkQnJBSDNRZENi?=
 =?utf-8?B?VjRJN2x6K0Vvdzg0YXZ0dmswZ04wajhhU0xyNzl1a1ZIVFlZWXQ4cS9vUUtm?=
 =?utf-8?B?VVZxNlBTZGxMK1lKdG5hcWJyNkpXV2h4RWsyOFl4WTJRUEVIRWNacVNITFdn?=
 =?utf-8?B?QVIyck9Rb05QOS9xQ21VZnJ0NmFEbDFqMkE4N1lhR0c1S1BnSGo5dWczVkdv?=
 =?utf-8?B?TEp4U2NsT0RTY2lhOE5vM0NaWlNQVTFVeFdEVWg5V3JVUDNDNjNFYysxb0dN?=
 =?utf-8?B?c2dQdnlqSWNQTVdtdkR1S05TbzNaRlhDQm4wWVJ6Vm9XRDNxRHJsMzM5TWlh?=
 =?utf-8?B?bVAxZVNWUTFGamNrS0hYTnhycnZ3VE1YMzBjOHhmQnhMZFYzOEtHSnB5eFhF?=
 =?utf-8?B?RVMybWEyWW41L290V0E5RTBYL0JON05KdGxZY0Y3ajdnbWVFbDA1RTRxRnJ6?=
 =?utf-8?B?NmhzQ29mNEg1UmczejFqNjBsd3dEL1BhN2JJQTJZcGVINkJRRlgwRTZWaXdz?=
 =?utf-8?B?dUpCb1gyTGJ0RDBOOGVuTVU2cGk2ZnVwMEo2cmxHeGJ3MzN5THJnbFRISlBL?=
 =?utf-8?B?dVlqRFJJNVMxY0cwMjJ4aHkvZWtsd3RMcWEzdTR1d1ZPNFZRcWw4OWgrUDZM?=
 =?utf-8?B?Ui9ZNEVOTlF4VXdGcjZENFowY0Fkd25VRkI0VEFJcGtwYnVjM2hBSUtzbndo?=
 =?utf-8?B?S1FxQ0hTMWZpdWR2MjZkREhiNXErWkNManF1RTVCc29iYjRSRWhWVytsZ1o3?=
 =?utf-8?B?cW1ia3htbUhaR1JINFB4eEI1anRiTUtOZGRwUStWQzV0OENNcXZIcGMrZms0?=
 =?utf-8?B?dkd6aWQyQVFwTXhLZVZ6eWtaMmUyZ2lmbFViYUJWSUN0dWxSSnBEb3EvUzc2?=
 =?utf-8?B?NVJDOVozRmxFRDgzUDF6Y0VQRW9ITHp2YmNVaEZDQ2ZLZGpoSlhtQk9UTkxR?=
 =?utf-8?B?RE9qdkVuSDBCYllXay81QXhlVXpoSDBBTEVxb2pGc0djNytlMCs4WHpkODV2?=
 =?utf-8?B?SnMrNkNtR0Z0NFl6MVp5eTVNTmpiRFpDdU5xZVU2blB0UC82bnIwWjAyMWRh?=
 =?utf-8?B?eXhKbXZhWUJzWlM2eWVwV2lNeXBTZ3pMYzl2NkMzdU5PWlNGRWFNRmVVc0Fu?=
 =?utf-8?B?WDE2cXpSd2g2R3hYUjR0LzAwaWI1U0RzWFJ4aVNXVnIzZEdUSmFJY2g5WDYr?=
 =?utf-8?B?ZnAyVE1DaFhkdHMvcmhxcXVrbWIvQkxlR3hlL2NtdUtvdWpoVHQyTkcwbk41?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d7bec8-665f-47c9-1c91-08dc23ca4451
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 08:38:01.7330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6QAuCIPmBBQK/vP3HvRGlXyj6UsRuNUax1n6ZbZbhxWiQRmVD88XGkG935cTfeK29h9cPJGC5oq+qsk7Ys+NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7602

On 02.02.24 08:49, JerryJun wrote:
> 
> how long did you run it？it will take a while for this crash but not more than 12 hours at mostly.
> ok，i will try to run it without get /proc……
> thank you very much.
> 

Not for hours, but one setup was running for about 30 min. at least.

Jan

> 
> At 2024-02-02 14:49:53, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
>> On 01.02.24 08:09, Jan Kiszka wrote:
>>> On 31.01.24 08:25, JerryJun wrote:
>>>> yet， you just do make in the project to product the binary of oop-test, run kill_test.sh , and finally wait kernel oop .
>>>> we get the same results of kernel oop in the qemu-amd64, which use the config from xenomai-images ,"https://source.denx.de/Xenomai/xenomai-images/-/blob/master/recipes-kernel/linux/files/amd64_defconfig?ref_type=heads", as follow.
>>>> [ 6191.671953] BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>> [ 6191.671955] #PF: supervisor instruction fetch in kernel mode
>>>> [ 6191.671956] #PF: error_code(0x0010) - not-present page
>>>> [ 6191.671956] PGD 0 P4D 0
>>>> [ 6191.671958] Oops: 0010 [#1] PREEMPT SMP PTI IRQ_PIPELINE
>>>> [ 6191.671959] CPU: 3 PID: 7047 Comm: oop-test Kdump: loaded Not tainted 5.10.199-devo-3.2.4-20240130 #1
>>>> [ 6191.671960] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>>>> [ 6191.671961] IRQ stage: Linux
>>>> [ 6191.671961] RIP: 0010:0x0
>>>> [ 6191.671962] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
>>>> [ 6191.671962] RSP: 0018:ffffc90000118f80 EFLAGS: 00010246
>>>> [ 6191.671963] RAX: 0000000000000000 RBX: ffff888108d3d730 RCX: 0000000000000000
>>>> [ 6191.671964] RDX: ffff888108d3d738 RSI: ffffffff82516284 RDI: ffff888108d3d730
>>>> [ 6191.671965] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
>>>> [ 6191.671965] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
>>>> [ 6191.671966] R13: 0000000000000018 R14: ffffffff811d37e0 R15: 0000000000000000
>>>> [ 6191.671967] FS:  00007fc6e83ea780(0000) GS:ffff88813bd80000(0000) knlGS:0000000000000000
>>>> [ 6191.671967] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [ 6191.671968] CR2: ffffffffffffffd6 CR3: 0000000106750005 CR4: 0000000000170ee0
>>>> [ 6191.671968] Call Trace:
>>>> [ 6191.671968]  <IRQ>
>>>> [ 6191.671969]  ? show_trace_log_lvl+0x1c2/0x2c9
>>>> [ 6191.671969]  ? irq_work_single+0x42/0x80
>>>> [ 6191.671969]  ? __die_body.cold+0x8/0xd
>>>> [ 6191.671970]  ? no_context+0x13a/0x270
>>>> [ 6191.671970]  ? exc_page_fault+0x6f/0x200
>>>> [ 6191.671970]  ? asm_exc_page_fault+0x1e/0x30
>>>> [ 6191.671970]  ? handle_oob_irq+0x90/0x90
>>>> [ 6191.671971]  irq_work_single+0x42/0x80
>>>> [ 6191.671971]  irq_work_run_list+0x2d/0x40
>>>> [ 6191.671971]  irq_work_run+0x26/0x40
>>>> [ 6191.671972]  inband_work_interrupt+0xa/0x20
>>>> [ 6191.671972]  handle_synthetic_irq+0xb1/0x210
>>>> [ 6191.671972]  asm_call_irq_on_stack+0x12/0x20
>>>> [ 6191.671973]  </IRQ>
>>>> [ 6191.671973]  arch_do_IRQ_pipelined+0x15d/0x2a0
>>>> [ 6191.671973]  sync_current_irq_stage+0x157/0x1f0
>>>> [ 6191.671974]  __inband_irq_enable+0x4b/0x70
>>>> [ 6191.671974]  _raw_spin_unlock_irqrestore+0x35/0x70
>>>> [ 6191.671974]  __set_cpus_allowed_ptr+0xbf/0x230
>>>> [ 6191.671975]  sched_setaffinity+0x383/0x6b0
>>>> [ 6191.671975]  __x64_sys_sched_setaffinity+0x45/0x80
>>>> [ 6191.671975]  do_syscall_64+0x39/0x50
>>>> [ 6191.671978]  entry_SYSCALL_64_after_hwframe+0x62/0xc7
>>>> [ 6191.671979] RIP: 0033:0x7fc6e84d6617
>>>> [ 6191.671979] Code: 1f 40 00 48 8b 15 79 c8 0e 00 f7 d8 41 b9 ff ff ff ff 64 89 02 44 89 c8 c3 66 2e 0f 1f 84 00 00 00 00 00 b8 cb 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 29 41 89 c0 83 f8 ff 74 18 64 c7 04 25 38 00
>>>> [ 6191.671980] RSP: 002b:00007ffd574dfde8 EFLAGS: 00000206 ORIG_RAX: 00000000000000cb
>>>> [ 6191.671981] RAX: ffffffffffffffda RBX: 00007fc6e7b985c8 RCX: 00007fc6e84d6617
>>>> [ 6191.671982] RDX: 00007fc6e7b985f0 RSI: 0000000000000080 RDI: 0000000000001b8d
>>>> [ 6191.671982] RBP: 00007ffd574dfe70 R08: 00007fc6e83ea780 R09: 00000000ffffffff
>>>> [ 6191.671983] R10: fffffffffffffdca R11: 0000000000000206 R12: 000055a818eb61c0
>>>> [ 6191.671983] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>>> [ 6191.671984] Modules linked in:
>>>> [ 6191.671985] CR2: 0000000000000000
>>>>
>>>
>>> Okay... that is "good" news - looking for some time slot to reproduce
>>> and debug myself now.
>>>
>>
>> I've tried to reproduce, using the .config.yaml below for
>> xenomai-images, but it does not trigger here. Do I need to run this for
>> hours? What exactly did you do to trigger it in the qemu image of
>> xenomai-images?
>>
>> BTW, I assume the access of /proc/xenomai/sched/stat plays an important
>> role in causing the crash, right? You don't get it without them?
>>
>> Jan
>>
>> #
>> # Automatically generated by kas 4.2
>> #
>> _source_dir: /repo
>> build_system: isar
>> header:
>>  includes:
>>  - kas.yml
>>  - board-qemu-amd64.yml
>>  - opt-linux-latest-5.10.yml
>>  version: 16
>> menu_configuration:
>>  DEBUG: false
>>  KERNEL_4_19: false
>>  KERNEL_4_19_LATEST: false
>>  KERNEL_5_10: false
>>  KERNEL_5_10_LATEST: true
>>  KERNEL_5_15: false
>>  KERNEL_5_15_LATEST: false
>>  KERNEL_5_4: false
>>  KERNEL_5_4_LATEST: false
>>  KERNEL_6_1: false
>>  KERNEL_6_1_LATEST: false
>>  TARGET_BBB: false
>>  TARGET_HIKEY: false
>>  TARGET_QEMU_AMD64: true
>>  TARGET_QEMU_ARM: false
>>  TARGET_QEMU_ARM64: false
>>  TARGET_X86_64_EFI: false
>>  XENOMAI3: true
>>  XENOMAI4: false
>>  XENOMAI_3_0_LATEST: false
>>  XENOMAI_3_1_LATEST: false
>>  XENOMAI_3_2: true
>>  XENOMAI_3_2_LATEST: false
>>  XENOMAI_LATEST: false
>>
>> -- 
>> Siemens AG, Technology
>> Linux Expert Center

-- 
Siemens AG, Technology
Linux Expert Center

