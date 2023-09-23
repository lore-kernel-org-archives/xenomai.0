Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C45DDAB
	for <xenomai@lists.linux.dev>; Sat, 23 Sep 2023 10:25:05 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id B1144C8203
	for <xenomai@lists.linux.dev>; Sat, 23 Sep 2023 10:12:36 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1619C0002;
	Sat, 23 Sep 2023 10:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1695463949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LK6UBgnGOWSsxckCwVR6F5ScvDY9tKvhgk9nz8q3Xp0=;
	b=GkBeSVrDphAlQt8pxBjQgMbHpJ7MMAUsffGsNrof/37hTmmtFQygdXtupng4ytwuFjjLaf
	kH/5d5a1427bZ+WCQE5KUtigFjxVXuEN1a9W8YXMDtATH+kurUKgwLrCyDOsAC0o7PJgfv
	966T1drQYxa0q5ZbAjdlFrqZM2Zoe7EFD6rhwwz8Sdg8GSoqNDCnV0Za4SZyWGN93YIXVp
	C4Q1uzxbLhwzr4cr1ZYdB50mpo2/oQUMlGyjAu9qAsuEPMmeC1cQdNKZZDI5t0EM4e9aUD
	o0/YXMqFNyjLf3wQXIKRtl6ADPAONqfVr6dP8mpF8b7hlcPMMC5MAjtwxFaCvg==
References: <f5149f19-4eaa-4844-8602-1c181532dd88@siemens.com>
 <878r8ymqzp.fsf@xenomai.org>
 <544dee0a-c072-4f7d-b5e3-84e6d50df093@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: Dovetail 5.15.129 and 6.1.54: New kernel warning on ARM
Date: Sat, 23 Sep 2023 12:07:32 +0200
In-reply-to: <544dee0a-c072-4f7d-b5e3-84e6d50df093@siemens.com>
Message-ID: <87pm29xkon.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 22.09.23 12:21, Philippe Gerum wrote:
>> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> Hi Philippe,
>>>
>>> something regressed:
>>>
>>> 2023-09-21T18:21:40 [    0.000000] ------------[ cut here ]------------
>>> 2023-09-21T18:21:40 [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pipeline.c:1829 irq_pipeline_init+0xbc/0xe0
>>> 2023-09-21T18:21:40 [    0.000000] Modules linked in:
>>> 2023-09-21T18:21:40 [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.129+ #1
>>> 2023-09-21T18:21:40 [    0.000000] Hardware name: Generic AM33XX (Flattened Device Tree)
>>> 2023-09-21T18:21:40 [    0.000000] IRQ stage: Linux
>>> 2023-09-21T18:21:40 [    0.000000] [<c03117e0>] (unwind_backtrace) from [<c030bd10>] (show_stack+0x10/0x14)
>>> 2023-09-21T18:21:40 [    0.000000] [<c030bd10>] (show_stack) from [<c1092dd0>] (dump_stack_lvl+0x8c/0xc0)
>>> 2023-09-21T18:21:40 [    0.000000] [<c1092dd0>] (dump_stack_lvl) from [<c0346b00>] (__warn+0x88/0x128)
>>> 2023-09-21T18:21:40 [    0.000000] [<c0346b00>] (__warn) from [<c108ea28>] (warn_slowpath_fmt+0x70/0xc8)
>>> 2023-09-21T18:21:40 [    0.000000] [<c108ea28>] (warn_slowpath_fmt) from [<c171d37c>] (irq_pipeline_init+0xbc/0xe0)
>>> 2023-09-21T18:21:40 [    0.000000] [<c171d37c>] (irq_pipeline_init) from [<c1700fec>] (start_kernel+0x4ec/0x6d8)
>>> 2023-09-21T18:21:40 [    0.000000] [<c1700fec>] (start_kernel) from [<00000000>] (0x0)
>>> 2023-09-21T18:21:40 [    0.000000] ---[ end trace 58996bc4bee07162 ]---
>>>
>>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/693461#L544
>>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/693455#L543
>>>
>>> Not seeing this with latest 5.10-dovetail.
>>>
>> 
>> This means the CI runs a SMP kernel on this uniprocessor SoC. It's fine
>> except for latency measurement - the impact of the SMP glue on the worst
>> case figure is noticeable in this case (+10%). Anyway, I'll work around
>> this.
>
> Yes, we are running the same kernel config on arm in xenomai-images.
> Given that you basically can't buy new single-core SOCs anymore, it's
> more important to test and qualify SMP than UP.
>

You are not testing much of the SMP capabilities on a bbb anyway, but I
get the idea. The warning is fixed upstream, including v5.10.y which
also had the issue - SMP was most likely disabled for this one in the CI
image.

-- 
Philippe.
