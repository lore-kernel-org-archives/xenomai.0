Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D269CA4C
	for <xenomai@lists.linux.dev>; Fri, 22 Sep 2023 10:39:25 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 926DD1BF207;
	Fri, 22 Sep 2023 10:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1695379164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ElLro7eglmENn3CHSBLut79Vg2YwpcTyuSh2JP/2oY=;
	b=aJa+/TO35KmM866pKM/Tgd2sKRe0vaai8kKwSBTzxlau85auPtEJHPMipbuzv93OooWySp
	Gw6o5p12UtNfkKpFI4dNCyhBwUhZab1fsBpIJdXarodS1EiLwW54175tEV13S/zfDFVmhL
	9DBHrE2CERB58wH0l7uLgP1ccgBB9Hb8O0hRTwBMHpE6Pji07Z+C7oDL/l3wseVk9tEUro
	iaU8o/gV0Fil7BIDNtD3uYRwk8KQ923LYngNGyqgYk5IwuFi5orJtFfOO+PUs9qJtoqp5v
	GmJgjkY3Rb+whQI05VqjRxHwr/3obdMWAEq6L+wUrtTFDxpbw/m2jhjwD3Y/Hg==
References: <f5149f19-4eaa-4844-8602-1c181532dd88@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: Dovetail 5.15.129 and 6.1.54: New kernel warning on ARM
Date: Fri, 22 Sep 2023 12:21:51 +0200
In-reply-to: <f5149f19-4eaa-4844-8602-1c181532dd88@siemens.com>
Message-ID: <878r8ymqzp.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> something regressed:
>
> 2023-09-21T18:21:40 [    0.000000] ------------[ cut here ]------------
> 2023-09-21T18:21:40 [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pipeline.c:1829 irq_pipeline_init+0xbc/0xe0
> 2023-09-21T18:21:40 [    0.000000] Modules linked in:
> 2023-09-21T18:21:40 [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.129+ #1
> 2023-09-21T18:21:40 [    0.000000] Hardware name: Generic AM33XX (Flattened Device Tree)
> 2023-09-21T18:21:40 [    0.000000] IRQ stage: Linux
> 2023-09-21T18:21:40 [    0.000000] [<c03117e0>] (unwind_backtrace) from [<c030bd10>] (show_stack+0x10/0x14)
> 2023-09-21T18:21:40 [    0.000000] [<c030bd10>] (show_stack) from [<c1092dd0>] (dump_stack_lvl+0x8c/0xc0)
> 2023-09-21T18:21:40 [    0.000000] [<c1092dd0>] (dump_stack_lvl) from [<c0346b00>] (__warn+0x88/0x128)
> 2023-09-21T18:21:40 [    0.000000] [<c0346b00>] (__warn) from [<c108ea28>] (warn_slowpath_fmt+0x70/0xc8)
> 2023-09-21T18:21:40 [    0.000000] [<c108ea28>] (warn_slowpath_fmt) from [<c171d37c>] (irq_pipeline_init+0xbc/0xe0)
> 2023-09-21T18:21:40 [    0.000000] [<c171d37c>] (irq_pipeline_init) from [<c1700fec>] (start_kernel+0x4ec/0x6d8)
> 2023-09-21T18:21:40 [    0.000000] [<c1700fec>] (start_kernel) from [<00000000>] (0x0)
> 2023-09-21T18:21:40 [    0.000000] ---[ end trace 58996bc4bee07162 ]---
>
> https://source.denx.de/Xenomai/xenomai-images/-/jobs/693461#L544
> https://source.denx.de/Xenomai/xenomai-images/-/jobs/693455#L543
>
> Not seeing this with latest 5.10-dovetail.
>

This means the CI runs a SMP kernel on this uniprocessor SoC. It's fine
except for latency measurement - the impact of the SMP glue on the worst
case figure is noticeable in this case (+10%). Anyway, I'll work around
this.

-- 
Philippe.
