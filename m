Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE5B20F1
	for <xenomai@lists.linux.dev>; Wed, 23 Aug 2023 07:31:42 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C674E240006;
	Wed, 23 Aug 2023 07:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1692775895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n1ufJF56UDV5aVH4GjOQcj2uHIyOxJFY52bGdMUzax8=;
	b=fAp4WL0NpciB0YjxDQtvD6hw5pIp9QjpIV8pZj5Ll82y7jgV+frbtg6fWIgtj5GBGlvW7E
	50MncDfjX3KgXhXn6Z8ESF4YO5GYqTdoZcgUTJTMTU2qylF/VQr/Mqs04mVenwlV424No0
	Efz3DtwRNFK/e3gdFhEtTIFQRj74ShowK4mH+sv41DTazm2VzG95OTfbaFucQhiHWrii4y
	3w1wxTG5sUHr6UhjYDPYzKXiT0XuXKt5xH+jCdp+o25aAylvfFD4dwX/gf5yNmm8y1m1vP
	LCf7qWfGOG2EAP3Qf71Ml8tmdgQ8igTfOAELFF30R9CvhmAkyZMOPe3X2roTXw==
References: <PH1P110MB1050E89C04D3AE6B62BB426FE21FA@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB105005EB4439ACFDCAA9C0F2E21FA@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Dave Rolenc
 <Dave.Rolenc@kratosdefense.com>
Subject: Re: CPU Stuck Error When Using Xbufs
Date: Wed, 23 Aug 2023 09:29:32 +0200
In-reply-to: <PH1P110MB105005EB4439ACFDCAA9C0F2E21FA@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87il96p63x.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Hello,
>
> I am running into a CPU Stuck issue when I added another xbuf to our
> application where we have data being transported from EVL  to Linux
> constantly. 
>
> I get a message on the console that mentions there is a CPU that is stuck
> due to spinlock recursion:
> "
> Message from syslogd@Modem1 at Aug 18 23:02:25 ...
> kernel:BUG: spinlock cpu recursion on CPU#5, SINK_0_DATA/4437
> Message from syslogd@Modem1 at Aug 18 23:02:25 ...
> kernel: lock: 0xffff8f27d329f610, .magic: dead4ead, .owner:
> SINK_0_XBUF_L/4402, .owner_cpu: 5
> "
>
> I collected some data using sysrq and got the following stacks for both of
> the threads in question:
> "
> task:SINK_0_DATA     state:S stack:    0 pid:15095 ppid: 14415
> flags:0x00000000
> Call Trace:
> <TASK>
> ? wait_events.isra.15+0xae/0x3e0
> ? evl_lock_mutex_timeout+0x45/0x540
> ? evl_flush_wait+0x50/0x50
> ? monitor_oob_ioctl+0x487/0xbd0
> ? poll_oob_ioctl+0xc7/0x440
> ? EVL_ioctl+0x46/0xa0
> ? do_oob_syscall+0x251/0x260
> ? handle_oob_syscall+0xa4/0xf0
> ? pipeline_syscall+0x65/0x130
> ? syscall_enter_from_user_mode+0x4d/0x120
> ? do_syscall_64+0x1d/0xa0
> ? entry_SYSCALL_64_after_hwframe+0x67/0xd1
> </TASK>
>
> task:SINK_0_XBUF_L   state:R  running task     stack:    0 pid:15059 ppid:
> 14333 flags:0x00000008
> Call Trace:
> <TASK>
> dovetail_context_switch+0xaf/0x200
> __evl_schedule+0x266/0x560
> run_oob_call+0x99/0x170
> inbound_signal_output+0xab/0xb0
> do_xbuf_read+0x1b3/0x240
> xbuf_read+0x4d/0x70
> ? do_irq_work+0x70/0x70
> vfs_read+0x9b/0x1a0
> ksys_read+0xc4/0xe0
> __x64_sys_read+0x15/0x20
> do_syscall_64+0x4c/0xa0
> entry_SYSCALL_64_after_hwframe+0x67/0xd1
> "
>
> NOTE: SINK_0_DATA is the thread in the EVL app that is pushing data onto the
> xbuf. SINK_0_XBUF_L is the thread in the Linux app that is pulling data off
> of the xbuf.
>
> Do you have any idea would could be going on?

Yes, quite clearly now. I'll follow up on this in the coming days.

> Is there any additional data
> you would like me to collect that would be helpful to understand
> what is happening?
>

Not ATM, thanks.

-- 
Philippe.
