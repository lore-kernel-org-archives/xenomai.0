Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11ED32D0E3
	for <xenomai@lists.linux.dev>; Mon, 17 Aug 2026 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958041; cv=none; b=WI/o5bLiFQWcrHODkLcymbLcEDzf06v/9kySjWaBfCia9oOsUlXRF04i+NDNJrzNuL74YOOboDJ7Rj5xrPf7xpGc+QcL90mHttynrvYev+r0dDXimiS+FRE9Le7BnzksOQJg5/nnnqeubSFejk079j7YabLVSduECG08M1reh60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958041; c=relaxed/simple;
	bh=/GUKKPNmBSk/5oP8KXfHPTfkwyAHAu7ood76YEcSqVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sSm4BzZmr4VRaZf+r/yKhSb3fC3KLtoAr8bYAMIE7CqUqiiy3SmU8MJUkmBhQPMn3t+Zd8Sdn8tKCIZcHhFblcif26irCYcz9VhHelmpGpj3TlVnDZ1ZfGPYs9DkTOhOsEoy1M24I2bmimN0jbUec8mcEIijyhitA5QAGJGCkQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Vf248ABW; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Vf248ABW"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFC4F3EBC4;
	Mon, 17 Aug 2026 09:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1786958031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TzNntRXxBRSp3wJfN8e7ugiUI3xZSyZT+twzNIGbRhw=;
	b=Vf248ABWc/GOxzsw0GivbHFPvUXA7NzEvmWxOjE1BK9DLAk/q1XBAW+uMtTAWB274Sq5xa
	ILscwhJlV3pzDDQwLqtwRPvIKM1u8a1Nwm5XXcp/mdKXU8FaS468dxb2Kc3FDhteDCBgnO
	1yT3OZv6udcdstb+LUeFEv2inK1KTyYVwFtnhrzfFZO7HKaxIUjLQtwRhJdrxyL0PAB40m
	JIZ8eZDqMVw9u6m70dA9hJZbXpX6hecYmhufwIvKlMHVTnWKK61QxD1v8TjM2ri6iVaFSU
	yulDaEA9ggx+4V40+dDaOq8JD9ZU4XoIOca/708iU7zQu0MXJgKqkDuuFe8IhQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Cc: xenomai@lists.linux.dev
Subject: Re: The state of Xenomai 4 on Xilinx Zynq-7000 (or ARM32 in general)
In-Reply-To: <CAKndYJGo5Yu7Ak694tX=cqRjtJneXs22DPjz=UDVkUcNJMWyOA@mail.gmail.com>
	(Gerte Hoogewerf's message of "Mon, 17 Aug 2026 08:34:44 +0200")
References: <CAKndYJGo5Yu7Ak694tX=cqRjtJneXs22DPjz=UDVkUcNJMWyOA@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 17 Aug 2026 11:13:49 +0200
Message-ID: <87v799kt2q.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTGdM0ax9YaE7C8H95Dc7dnfKwKn+KtOxUP0iObQWy5WXG2X5h7s0ZI1yra0kQQpVRz5ZpDMZSdru3F3uU9yACXXw8MUa0FzxQJIy1Z8ym549x/N2/gpFwTik6T4n1B+Nl8Hr2gcRUVOKB4qocLdNzx0VNXJa+Rw5BKEmCPIB9e1gMidtkjYmobS0au1P2DmKwLv4q1G6jlNgv8WqXKrjLlUzCQ4SvqntkMlvxerzZ7OjzmTS0fCN36QiVaA9FGh+T9Tsdg1B7M+61Z6+/ZR9PqKb+oBMNlhY+TdvOseBINy0HhVNDTocOLMLTQS8jg3T0KTPyu5rZkt3iYUazgaeqWrFgbhMV4dmL7r48ywPK55VjssDlnm1XVmh5mFu7J7Cuh2ZDFkosjFRxXyZ2wEAYxGVlzRolTnvcjGqEVmRbcDEpH5lNCivMWs/lr32zgpt/hxJxXBtqx4EwaoNh+djpTWFjOdMBsFhE9a6q3MvhNMEpIdLF3CWlfN7pMngaFbj/ZnuDJN5CNZe61lfzv9zb3KUeJIjPIAyd5hz0wSQTRqRUQCP/TXrjnnQej2fwXL2FgcPugLT2+zC7niYt8hRzUrUm/7A4aMqf7CP20X4GnvSmmX60uAs/1oT9AjU/3HWwQIpaKPznzk2be+F17Uenhl4nGalN441CXHYMJoQDm8eg
X-GND-State: clean
X-GND-Score: -100

Gerte Hoogewerf <ghoogewerf@lmi3d.com> writes:

> Hi Xenomai team,
>
> At LMI, we are in the machine vision industry, where some applications
> require predictable and bounded ISR latency.   Although we are
> gradually migrating our installations to Xilinx Zynq UltraScale+, most
> field installations still run on the older Xilinx Zynq-7000 SoC.
>
> We've been running Xenomai on our customized Zynq-7000 boards since
> 2021 or so.  Our products have been shipping with Xenomai 3, ipipe,
> kernel 4.14 all this time.  Although it still runs and performs well,
> the age of the stack is starting to affect security certification.
>
> On multiple occasions, I've tried newer versions of Xenomai.   The
> most recent version that still functions properly was kernel 5.4 (i.e.
> the last version to support ipipe + Xenomai 3).  I was never able to
> successfully boot anything newer than that version.
>
> It typically hangs partway through boot, like this:
>
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 6.18.29-01121-g5d9e6ccea5cc
> (ghoogewerf@NLKRLTF0FQR04) (arm-none-linux-gnueabihf-gcc (LMI3D G++
> 11.4.1-p1) 11.4.1 20240321, GNU ld (LMI3D G++ 11.4.1-p1) 2.40) #2 SMP
> PREEMPT EVL Mon Jul 13 12:06:58 CEST 2026
> [    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=18c5387d
> [.....]
> [    0.815404] io scheduler kyber registered
> [    0.820358] zynq-pinctrl 700.pinctrl: zynq pinctrl initialized
> [    0.831589] dma-pl330 f8003000.dma-controller: Loaded driver for
> PL330 DMAC-241330
> [    0.839180] dma-pl330 f8003000.dma-controller:
> DBUFF-128x8bytes Num_Chans-8 Num_Peri-4 Num_Events-16
> [    0.857446] brd: module loaded
> [    0.865454] loop: module loaded
> [    1.260102] Freeing initrd memory: 5620K
> <======    HANG    ======>
>
> The peculiar thing is that either "CONFIG_EVL=n" or "CONFIG_SMP=n"
> works around this problem.  But that's not a good solution for obvious
> reasons.
>
> I am curious where Xenomai 4 stands regarding support for Zynq-7000
> (or ARM32 in general).  Are you aware of problems with these older
> boards?  Is there anything we can do ourselves to debug this further?
> We are happy to share the full boot log, kernel config, and device
> tree if that would help.  Any guidance or support you can offer would
> be appreciated.
>

To put it simply, every architecture Xenomai4 supports is considered
"tier 1", i.e. is actively maintained and must work
flawlessly. Therefore, although arm32 is aging, it is still fully
supported, not to speak of the fact that we do have quite a few projects
depending on it. However, we lost access to many platforms some time
ago, including Zynq hardware, so we can't test them routinely anymore.

Regarding the issue you are observing, it suspect this is
Dovetail-related. If so, xenomai 3.3 which is using Dovetail won't boot
on the Zynq either.

Such hang at boot is often the symptom of an issue with the proxy timer
Dovetail provides and xenomai relies on, i.e. the piece of code which
hands control over the system hardware timer to the real-time core.

To start debugging this, I would run the basic tests Dovetail provides
which cover the proxy tick management by configuring as follows:

CONFIG_DEBUG_IRQ_PIPELINE=y
CONFIG_IRQ_PIPELINE_TORTURE_TEST=y
CONFIG_DEBUG_DOVETAIL=y
CONFIG_EVL=n
CONFIG_SMP=y

These tests are executed during the boot sequence, a successful run
should look like this:

[    0.654959] Starting IRQ pipeline tests...
[    0.654981] IRQ pipeline: high-priority torture stage added.
[    0.654989] irq_pipeline-torture: CPU0 initiates stop_machine()
[    0.659603] irq_pipeline-torture: CPU3 responds to stop_machine()
[    0.659603] irq_pipeline-torture: CPU2 responds to stop_machine()
[    0.659603] irq_pipeline-torture: CPU1 responds to stop_machine()
[    0.659649] irq_pipeline-torture: CPU0 calls function on remote(s)
[    0.659666] irq_pipeline-torture: CPU1 handles remote function call
[    0.659677] irq_pipeline-torture: CPU2 handles remote function call
[    0.659689] irq_pipeline-torture: CPU3 handles remote function call
[    0.659856] CPU0: proxy tick device registered (396.00MHz)
[    0.659861] CPU2: proxy tick device registered (396.00MHz)
[    0.659867] CPU1: proxy tick device registered (396.00MHz)
[    0.666350] CPU3: proxy tick device registered (396.00MHz)
[    0.666440] irq_pipeline-torture: CPU0: irq_work handled
[    0.666451] irq_pipeline-torture: CPU0: in-band->in-band irq_work trigger works
[    0.666457] irq_pipeline-torture: CPU0: stage escalation request works
[    0.666465] irq_pipeline-torture: CPU0: irq_work handled
[    0.666475] irq_pipeline-torture: CPU0: oob->in-band irq_work trigger works
[    1.681508] CPU0: proxy tick device unregistered
[    1.681515] CPU2: proxy tick device unregistered
[    1.681521] CPU1: proxy tick device unregistered
[    1.688222] CPU3: proxy tick device unregistered
[    1.688345] IRQ pipeline: torture stage removed.
[    1.688354] IRQ pipeline tests OK.

Hopefully, some debug assertion this test suite enables is going to trip
instead.

-- 
Philippe.
