Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D8850A7E
	for <xenomai@lists.linux.dev>; Fri, 17 May 2024 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715951911; cv=none; b=MuzOWi2mEjBkJ+bSLPIQkCCU76TUvGJHeahRSE4eSEh2rhxZRChdtAdLG90lb/jMec3FoaY272mLcGMoYrYK0SKMHG/KvFZcbXjrHwHQwUy+7l7HK3tbsOamcRmqn0QVOr7YWYlfbI9NDSzkygsAtHq6LV6yg4pumKU8JZnUdjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715951911; c=relaxed/simple;
	bh=NGVOs8joOhqUo64iPIEsrpHATPDdWG2ZfCWfGn/V4h8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=KZXNeyJYi9sOq33edIbcO7OQOIuCUvzvMS9pkSypvJlcY26Oow00XWBUnEVdmxxtFOV6MOUUHteCrxwauwBATd5f9WPRHyZzl2LosE0iOfAQxiTcN2rV6rq5fZS2sa0rnquX5OUMR2jt95WeVH1707LPd5Lsv/UnNjySZIxhLdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34db9a38755so115260f8f.1
        for <xenomai@lists.linux.dev>; Fri, 17 May 2024 06:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715951907; x=1716556707;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxczsBY4nPCjh/NzAaXDPY/ADF2JjESJvJ4QRggNP20=;
        b=ldR8igN2FTIuYk2q4h/+jOv5udd2C0EBJCf6qgDIRJm8roCmqQUmh5vxvNs6b37UqZ
         JpPU6urw2z4w7btbvLj6WbRGJV6XSYcd1cY5zKU2hyNKSPpuBnJ3r/wQ6a/FksAAdWfC
         sbLSUHiu6/3ubzsyUNiRpuhHpnFW50HKghDUF4psl06y8B23JF/M8sI02LxRp/ibSFBG
         w9a2LH3ggCQl5Y/tnlCKh/V6cs5Cz/SdL3MB3S4HqvSbh41jrn+3L6D2ifWbPEUtJ4l2
         xgR4fvaeJQKCbKlxrwtVtx8adWclbNAVAtmf8duFHwcTfkJQRWD11XPWZMaz+Wd7EhfB
         H7Qg==
X-Gm-Message-State: AOJu0Yxox2Rmjkk9dWEh3XQW7VnVn6UMi902TYQCZRH1JwldZX4c9/5w
	dTscW9auHJcy5qozF3FDT3RyhZbQsa61UVqM369AiEYfPYb8QbBdw+ouVw==
X-Google-Smtp-Source: AGHT+IFGYqRbnl4F1t5lCLPpoJSIhtTQmmTOr/DGkMYUL9lv077kSwrvT9Oe0DTU55gSpIfp8fK5LQ==
X-Received: by 2002:adf:f5ce:0:b0:34a:d130:611b with SMTP id ffacd0b85a97d-3504a737804mr22411249f8f.17.1715951907213;
        Fri, 17 May 2024 06:18:27 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896a11sm21827739f8f.38.2024.05.17.06.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 06:18:26 -0700 (PDT)
References: <PH0PR11MB594952BA30D4672C8271E6A0F4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: "Nechita, Ionut" <ionut.nechita@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: WARN Kernel v6.9-evl-rebase - poll_idle
Date: Fri, 17 May 2024 15:17:57 +0200
In-reply-to: <PH0PR11MB594952BA30D4672C8271E6A0F4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
Message-ID: <87ttiwr2zi.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> Hello Xenomai Team,
>
> I notice one warning message today in dmesg, when using 6.9-evl branch.
>
> Output(dmesg):
>
> [    0.447973] ------------[ cut here ]------------
> [    0.447975] WARNING: CPU: 3 PID: 0 at kernel/irq/pipeline.c:303 inband_irq_enable+0x21/0x40
> [    0.447981] Modules linked in:
> [    0.447983] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.9.0-x64v1-lowlatency1 #4
> [    0.447986] Hardware name: Intel(R) Client Systems NUC7i7BNH/NUC7i7BNB, BIOS BNKBL357.86A.0083.2020.0714.1344 07/14/2020
> [    0.447987] IRQ stage: Linux
> [    0.447989] RIP: 0010:inband_irq_enable+0x21/0x40
> [    0.447992] Code: 90 90 90 90 90 90 90 90 90 55 48 89 e5 53 0f b6 1d 35 05 3d 02 80 fb 01 0f 87 ba 6f fd 00 83 e3 01 75 09 9c 58 f6 c4 02 75 02 <0f> 0b e8 58 ff ff ff 48 8b 5d f8 c9 31 c0 31 f6 31 ff c3 cc cc cc
> [    0.447994] RSP: 0000:ffffa955c012be00 EFLAGS: 00010046
> [    0.447997] RAX: 0000000000000046 RBX: 0000000000000000 RCX: 0000000000000000
> [    0.447999] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [    0.448000] RBP: ffffa955c012be08 R08: 0000000000000000 R09: 0000000000000000
> [    0.448001] R10: 0000000000000000 R11: 0000000000000000 R12: ffff998b1ed88c20
> [    0.448003] R13: ffffffffad67f8c0 R14: 0000000000000000 R15: 0000000000000000
> [    0.448004] FS:  0000000000000000(0000) GS:ffff998b1ed00000(0000) knlGS:0000000000000000
> [    0.448006] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.448008] CR2: 0000000000000000 CR3: 00000005e2232001 CR4: 00000000003706f0
> [    0.448010] Call Trace:
> [    0.448012]  <TASK>
> [    0.448014]  ? show_regs+0x71/0x90
> [    0.448018]  ? inband_irq_enable+0x21/0x40
> [    0.448021]  ? __warn+0x8c/0x160
> [    0.448025]  ? inband_irq_enable+0x21/0x40
> [    0.448028]  ? report_bug+0x1ab/0x1c0
> [    0.448033]  ? handle_bug+0x52/0xc0
> [    0.448035]  ? exc_invalid_op+0x10c/0x140
> [    0.448037]  ? asm_exc_invalid_op+0x1b/0x20
> [    0.448041]  ? inband_irq_enable+0x21/0x40
> [    0.448045]  poll_idle+0x28/0xb4
> [    0.448048]  cpuidle_enter_state+0x9f/0x490
> [    0.448051]  cpuidle_enter+0x2e/0x50
> [    0.448055]  call_cpuidle+0x22/0x50
> [    0.448059]  do_idle+0x22f/0x2a0
> [    0.448061]  ? complete+0x6d/0x80
> [    0.448065]  cpu_startup_entry+0x2c/0x30
> [    0.448068]  start_secondary+0x119/0x140
> [    0.448072]  common_startup_64+0x13e/0x141
> [    0.448077]  </TASK>
> [    0.448078] ---[ end trace 0000000000000000 ]---
>

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index d86fe89830872..79ea798076764 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -19,8 +19,8 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 
 	dev->poll_time_limit = false;
 
-	raw_local_irq_enable();
 	hard_cond_local_irq_enable();
+	raw_local_irq_enable();
 	if (!current_set_polling_and_test()) {
 		unsigned int loop_count = 0;
 		u64 limit;

-- 
Philippe.
