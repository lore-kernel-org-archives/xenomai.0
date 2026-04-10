Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464438A70A
	for <xenomai@lists.linux.dev>; Fri, 10 Apr 2026 19:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850855; cv=none; b=c15nmPVlevtcftexOkixb5zMtOvRAOgcdR47SJO8w04FJu/cAZ7082W4rQeKFC3hRyA+D4IMPq3bTkof37/LeSj45oaECzTtc7R2F37WT6LBso0lHuhldJKLtgWEKF8D1HMbuGL5wh/pZZzy8pe0HiBuCopoKSsLSudHWBP12sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850855; c=relaxed/simple;
	bh=aEQihE3hKO6Vu6qTHHENAc0opjleM+wkL8246f0XpR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DxyNTdkeeJcYqDmZAUYSnYcSIk3NzR8mg1LlMdGXgX5DgIN8dGZ3Ww0StRbb9RhFWD4JbrXHHuEVz7LdL+i6qWbk5rzl8bloBS/eddO8iY9UDMpjJ1+ddUnAHgKMvIAtZq1Nl5GMH2VZ+5b3Qrt3SV1i67/xSw5P4yxeIxasg3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vzj8XSjT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzj8XSjT"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso29128555e9.1
        for <xenomai@lists.linux.dev>; Fri, 10 Apr 2026 12:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775850852; x=1776455652; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GvtdIaW2dzD1OvOEJDWjgkb4dr3CVaBymSTwpiKiOZ4=;
        b=Vzj8XSjTKlQL1PR8a/alsD7XezKGCI4206DsubzJAZJXAm2sH6jBWb6siY3VV3fTxZ
         nVdSCVsEcVfzP3kqO6T1gJ5eEwA623pfFNVVrFHnEpPf1NJlFUlyE/6jLOGE1hQeCzsi
         OH5qB0ajJRrs7U1g4+wKmm+JKFhV/5KFqXr8Mq4WJ9CuTqE3nLZ8VAcvSa1EZaBf83q9
         CbNV57/lGTizAyaPszK15nGtEa0OeLfcLRSHYE6i4iHhY1RM2HD+fvthJKK6xxl25yFg
         w89T14sqZ494petubbAPZIF0HfVquE5nDmzxJ4fyaqyke7LQw5zshLM1ElnHoaurizwI
         tQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850852; x=1776455652;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvtdIaW2dzD1OvOEJDWjgkb4dr3CVaBymSTwpiKiOZ4=;
        b=G7JfdajMv9XhlEzLHvClfyaj3aXIcjbO3raCN/lioTopqk5diytpoY2xA00X+RJ6sC
         l0B6U74KVvppQkqgltRC/lCrcDQQkxBKUN87hMtW/l/1sLoAKZe5Ti6vfwBINzR/Qtnp
         +Nxob2B/YoNZQ8euVb+AfMGYh8w2oUvltiXYiAdUQcJhVPWpxn51HHy6tvoDqj4lV4x1
         cKlZ9mzIljezCGTJzgev1NM32Z1kEbbxjrvfJCjLM1avk1lQphBKhwy0SzL4nv1bukdg
         RMDhsDXJgUN4eWfZWbZTtGnwScVUC0Vgj/lLo72AJkD1rOSP8QC9xxRrqyLQvdSIPoJH
         UA0A==
X-Forwarded-Encrypted: i=1; AJvYcCVpRaetAVIWiuOMMMFeKEYCJ9EgCUaTkI/1Y/lgLHRe+Yjj+SmuAe5wsLH8c5opjnyMclDCFo90@lists.linux.dev
X-Gm-Message-State: AOJu0YxNGhvEAhImpxpoY1pclFlzzHVrSG9Gtna+lbXFBZ6h25XkF91N
	AL4PSsD2AuD/jwUhRe+ENb45KixZcRVA4N/aOtLzPsgj3iYKHxE0mnGq
X-Gm-Gg: AeBDiesrnLHuYy8yLoMR9iXoZ8cMAx2hEOfEoqpIJLNOEBzK0TUtKM6ELIVSmqdOXGc
	Ehsm3Ytwo7pBkLT8IV/WNkjuedbID2ewhCMf7U+O+WupbJXLTOXTaLZIJkzWyA/1SnrSu2A4IDO
	nvKD0GDg/4wLhdCkVMeOljU5nZG4IWRMQkTIiSAOX3HMPxKyPLkA3lzakxM+lbjxc8DAfI1hpcQ
	DtyjMG2BucXEAh3daLelr3Ra7eDe+/bIUb20tHYfuOKs1QldtBxSZeEbDDOB0YYnW3ceLecox4W
	rsCIsERnxbo/Sus0rsEjnb4FOV3oN5gleIRKQrq2eszNsWSri1zc7qQ+3CDwlwUP8l9cTb+S8Ur
	oifFWXqCFaXHpkCuUtpYhBW8AXl2vm1I9bzqh9WEPFddC2V2jJD4Q9eJAhSIHzxvcDXtu5saiqC
	ytnzLacBfcexCSALAG9M2EoTylWJBMaLM=
X-Received: by 2002:a05:6000:2c07:b0:439:abcd:b314 with SMTP id ffacd0b85a97d-43d6424cbccmr6909160f8f.18.1775850851525;
        Fri, 10 Apr 2026 12:54:11 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a69sm9830340f8f.4.2026.04.10.12.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 12:54:11 -0700 (PDT)
Message-ID: <48689bee-2176-4def-bce8-33faa35a235f@gmail.com>
Date: Fri, 10 Apr 2026 21:54:10 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel WARNING in Xenomai3 with RTnet
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <4742f315-9fae-4165-b5c0-066e6500baed@gmail.com>
 <f10afb4e-2aaf-4a3a-8bc7-893c1a09cdd1@siemens.com>
From: Hannes Diethelm <hannes.diethelm@gmail.com>
Content-Language: de-CH
In-Reply-To: <f10afb4e-2aaf-4a3a-8bc7-893c1a09cdd1@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.04.26 um 08:46 schrieb Jan Kiszka:
> On 08.04.26 22:53, Hannes Diethelm wrote:
>> Configuration:
>>
>> Debian Trixie
>> xenomai3:master
>> linux-dovetail:v6.12.67-dovetail1
>>
>> I have the following warning as soon as I enable the network interface:
>> Apr 08 01:52:12 trixie-box kernel: ------------[ cut here ]------------
>> Apr 08 01:52:12 trixie-box kernel: memcpy: detected field-spanning write
>> (size 80) of single field "call->priv_data" at drivers/xenomai/net/
>> stack/rtnet_rtpc.c:93 (size 0)
>> Apr 08 01:52:12 trixie-box kernel: WARNING: CPU: 13 PID: 2480 at
>> drivers/xenomai/net/stack/rtnet_rtpc.c:93
>> rtnet_rtpc_dispatch_call+0x2df/0x3d0 [rtnet]
>> Apr 08 01:52:12 trixie-box kernel: Modules linked in: rtudp rtipv4
>> rt_loopback joydev uinput qrtr rfkill binfmt_misc intel_rapl_msr
>> intel_rapl_common ccp kvm snd_hda_codec_generic snd_hda_intel ir>
>> Apr 08 01:52:12 trixie-box kernel: CPU: 13 UID: 0 PID: 2480 Comm: rtping
>> Not tainted 6.12.67-xenomai3-73ad3b #3
>> Apr 08 01:52:12 trixie-box kernel: Hardware name: QEMU Standard PC (Q35
>> + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> Apr 08 01:52:12 trixie-box kernel: IRQ stage: Linux
>> Apr 08 01:52:12 trixie-box kernel: RIP:
>> 0010:rtnet_rtpc_dispatch_call+0x2df/0x3d0 [rtnet]
>> Apr 08 01:52:12 trixie-box kernel: Code: 26 50 00 00 00 0f 85 d1 fd ff
>> ff 31 c9 48 c7 c2 00 13 94 c0 4c 89 ee 48 c7 c7 48 13 94 c0 c6 05 06 50
>> 00 00 01 e8 51 d6 97 eb <0f> 0b e9 ab fd ff ff 84 d2 >
>> Apr 08 01:52:12 trixie-box kernel: RSP: 0018:ffffcdff82ebbd68 EFLAGS:
>> 00010286
>> Apr 08 01:52:12 trixie-box kernel: RAX: 0000000000000000 RBX:
>> ffff8988585012c0 RCX: 0000000000000027
>> Apr 08 01:52:12 trixie-box kernel: RDX: ffff898b6fca0948 RSI:
>> 0000000000000001 RDI: ffff898b6fca0940
>> Apr 08 01:52:12 trixie-box kernel: RBP: 00000000000001f4 R08:
>> 0000000000000000 R09: ffffcdff82ebbb28
>> Apr 08 01:52:12 trixie-box kernel: R10: ffffffffadeb9ee8 R11:
>> 0000000000000003 R12: 0000000000000000
>> Apr 08 01:52:12 trixie-box kernel: R13: 0000000000000050 R14:
>> ffffffffc0cff5b0 R15: ffffffffc0cff6e0
>> Apr 08 01:52:12 trixie-box kernel: FS:  00007f1499d11740(0000)
>> GS:ffff898b6fc80000(0000) knlGS:0000000000000000
>> Apr 08 01:52:12 trixie-box kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>> 0000000080050033
>> Apr 08 01:52:12 trixie-box kernel: CR2: 00007ffe3de7dff8 CR3:
>> 000000014d74e000 CR4: 0000000000750ef0
>> Apr 08 01:52:12 trixie-box kernel: PKRU: 55555554
>> Apr 08 01:52:12 trixie-box kernel: Call Trace:
>> Apr 08 01:52:12 trixie-box kernel:  <TASK>
>> Apr 08 01:52:12 trixie-box kernel:  ipv4_ioctl+0x16b/0x230 [rtipv4]
>> Apr 08 01:52:12 trixie-box kernel:  rtnet_ioctl+0x164/0x190 [rtnet]
>> Apr 08 01:52:12 trixie-box kernel:  ? __count_memcg_events+0x67/0x100
>> Apr 08 01:52:12 trixie-box kernel:  __x64_sys_ioctl+0x91/0xd0
>> Apr 08 01:52:12 trixie-box kernel:  do_syscall_64+0xc0/0x230
>> Apr 08 01:52:12 trixie-box kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> Apr 08 01:52:12 trixie-box kernel: RIP: 0033:0x7f1499e2091b
>> Apr 08 01:52:12 trixie-box kernel: Code: 00 48 89 44 24 18 31 c0 48 8d
>> 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24
>> 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c >
>> Apr 08 01:52:12 trixie-box kernel: RSP: 002b:00007ffe3de7e9f0 EFLAGS:
>> 00000246 ORIG_RAX: 0000000000000010
>> Apr 08 01:52:12 trixie-box kernel: RAX: ffffffffffffffda RBX:
>> 00007f1499d11740 RCX: 00007f1499e2091b
>> Apr 08 01:52:12 trixie-box kernel: RDX: 000055c8e00d60e0 RSI:
>> 00000000c0500285 RDI: 0000000000000003
>> Apr 08 01:52:12 trixie-box kernel: RBP: 0000000000000002 R08:
>> 0000000000000000 R09: 0000000000000000
>> Apr 08 01:52:12 trixie-box kernel: R10: 0000000000000003 R11:
>> 0000000000000246 R12: 00007ffe3de7f818
>> Apr 08 01:52:12 trixie-box kernel: R13: 0000000000000002 R14:
>> 00007f1499f60000 R15: 000055c8e00d5dd8
>> Apr 08 01:52:12 trixie-box kernel:  </TASK>
>> Apr 08 01:52:12 trixie-box kernel: ---[ end trace 0000000000000000 ]---
>>
>> This can be fixed with the following patch. However, I am not sure if
>> it's the right way to do it.
>> diff --git a/kernel/drivers/net/stack/rtnet_rtpc.c b/kernel/drivers/net/
>> stack/rtnet_rtpc.c
>> index cd5f0546d..caed27269 100644
>> --- a/kernel/drivers/net/stack/rtnet_rtpc.c
>> +++ b/kernel/drivers/net/stack/rtnet_rtpc.c
>> @@ -90,7 +90,7 @@ int rtnet_rtpc_dispatch_call(rtpc_proc proc, unsigned
>> int timeout,
>>       if (call == NULL)
>>           return -ENOMEM;
>>
>> -    memcpy(call->priv_data, priv_data, priv_data_size);
>> +    unsafe_memcpy(call->priv_data, priv_data, priv_data_size, /
>> *embedded variable length data*/);
>>
> 
> Yeah, good catch - the kernel and the toolchains improved their
> diagnosis features a lot since this was written more than 20 years ago.
> I bet we have a few more of those variable length fields in RTnet data
> structures. Those should be converted to flexible array members, see
> also
> https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays.
> Happy to review patches!
> 
> Jan
Thanks for the hint. So I think this is all that's needed, i tested it and with this change. I also have no
warnings any more.

diff --git a/kernel/drivers/net/stack/include/rtnet_rtpc.h b/kernel/drivers/net/stack/include/rtnet_rtpc.h
index 01d7ab152..f4ad47306 100644
--- a/kernel/drivers/net/stack/include/rtnet_rtpc.h
+++ b/kernel/drivers/net/stack/include/rtnet_rtpc.h
@@ -43,7 +43,7 @@ struct rt_proc_call {
         atomic_t ref_count;
         wait_queue_head_t call_wq;
         rtpc_cleanup_proc cleanup_handler;
-       char priv_data[0] __attribute__((aligned(8)));
+       char priv_data[] __attribute__((aligned(8)));
  };
  
  #define CALL_PENDING 1000 /* result value for blocked calls */

So you mean I should submit a patch? So that means using git format-patch and send it to the mailing list?
I can try that but I can't guarantee I won't mess it up. But I allready managed to setup my e-mail client to not
mess up the messages.

I have another patch and a bug report in the pipeline but one at a time.

Just some background: I am working on integrating Xenomai3/4 into LinuxCNC. It is just a hobby and I am not an official
maintainer. However, I am using Linux since i switched over from Windows 3.11 and I am quite experienced in C/C++ from
my day job and also personal projects. But the last time I was using mailing lists was like 20 years ago.

Hannes
> 
>>       call->processed = 0;
>>       call->proc = proc;
>>
>>
> 

