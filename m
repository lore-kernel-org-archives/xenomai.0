Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDE31C13
	for <xenomai@lists.linux.dev>; Sat,  6 May 2023 11:34:39 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id CC741CC9D4
	for <xenomai@lists.linux.dev>; Sat,  6 May 2023 11:16:25 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id BCC13C0002;
	Sat,  6 May 2023 11:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1683371778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XYQ+v3m40XfRGOPjpstBrMB+hxfYAPbmZwyq4LptIDY=;
	b=QcG2fAXXr8HXDo3hYUsSz5isrZt5O07hilGkxYWdQV+SI0PPFKCcmiejtDrHwbAp2sDl/N
	+73MIAgbcvdgH8Bj4+Dz8HAxlZDXbdEi2c0s5pdTMOfv7th4MZK498oW9deeGuDiG+kR6a
	/y4beelHXCaYeKU5OzzyzZmxXTvHsyNDgmk8wjcexO5AG74YYYahRfhFG4M9mu3CpLldHx
	ygzLBbGZDoFPA7oc2QrbTHnVE8cshuQ3uSBpFnxcSDmfckzd4voKVtZJCdA/2qmq2GJTEo
	Hd0LrM66z3BrXN/p0DYGmLKijzJtuIZUYV9KHqhI2mFB3mbGG463VpVUReByjg==
References: <PH1P110MB1050E3792D231FD98FD707B7E2659@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <871qk5zqpp.fsf@xenomai.org>
 <PH1P110MB1666BA1533E0614496E7B678FE6B9@PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Dave Rolenc <Dave.Rolenc@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Russell Johnson
 <russell.johnson@kratosdefense.com>
Subject: Re: EVL Kernel Debugging
Date: Sat, 06 May 2023 12:56:53 +0200
In-reply-to: <PH1P110MB1666BA1533E0614496E7B678FE6B9@PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87o7mxpv5q.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Dave Rolenc <Dave.Rolenc@kratosdefense.com> writes:

>>> We get a CPU STUCK when restarting an evl-enabled app multiple times, 
>>> and one way to get more insight into this problem is with a kernel debugger.
>>> With the kernel debugger not working, it seems difficult to get any 
>>> kernel-level insight.
>
>> With x86, you could try passing nmi_watchdog=1 via the kernel cmdline
>> to enable the APIC watchdog on the CPUs, _only for the purpose of
>> debugging_ because this is likely going to make the latency figures
>> skyrocket (setting nmi_watchdog=0 is a common recommendation on x86
>> for a real-time configuration). But if the application logic can bear
>> with degraded response time, with luck you might get a kernel
>> backtrace exposing the culprit.
>
> With this approach, we did end up with some stack traces. They mostly look like this:
>
> sync_current_irq_stage (kernel/irq/pipeline.c:922 kernel/irq/pipeline.c:1288)
> __inband_irq_enable (arch/x86/include/asm/irqflags.h:41 arch/x86/include/asm/irqflags.h:91 kernel/irq/pipeline.c:287)
> inband_irq_enable (kernel/irq/pipeline.c:317 (discriminator 9))
> _raw_spin_unlock_irq (kernel/locking/spinlock.c:203)
> rwsem_down_write_slowpath (arch/x86/include/asm/current.h:15 (discriminator 1) kernel/locking/rwsem.c:1136 (discriminator 1))
> down_write (kernel/locking/rwsem.c:1535)

For some reason, this rwsem above does not seem to be released in time,
causing the hang. This happens into the kernelfs internals, but a
reasonable assumption is that EVL might be causing this, maybe due to
some EVL callback invoked by kernelfs holding this lock, which would
stall unexpectedly. This bug might be more likely if EVL elements are
created at high rate like when an app starts, quickly instantiating a
truckload of EVL resources in a row, as if some race occurred. Anyway,
the plan is to reproduce first, then find out if this scenario happens.

> kernfs_activate (fs/kernfs/dir.c:1302)
> kernfs_add_one (fs/kernfs/dir.c:774)
> kernfs_create_dir_ns (fs/kernfs/dir.c:1001)
> sysfs_create_dir_ns (fs/sysfs/dir.c:62)
> kobject_add_internal (lib/kobject.c:89 (discriminator 11) lib/kobject.c:255 (discriminator 11))
> kobject_add (lib/kobject.c:390 lib/kobject.c:442)
> ? _raw_spin_unlock (kernel/locking/spinlock.c:187)
> device_add (drivers/base/core.c:3329)
> ? __init_waitqueue_head (kernel/sched/wait.c:13)
> device_register (drivers/base/core.c:3476)
> create_sys_device (kernel/evl/factory.c:312)
> create_element_device (kernel/evl/factory.c:439)
> ioctl_clone_device (kernel/evl/factory.c:559)
>  __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:874 fs/ioctl.c:860 fs/ioctl.c:860)
> do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:89)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:118)
>
> I have to dig a little deeper about the origin of the ioctl from
> userspace.

The origin is evl_create_element(), in libevl. This happens every time a
new EVL element is created such as monitors (for
sema4/events/flags/mutexes), threads, proxies, and so
on. ioctl(EVL_IOC_CLONE) is the source.

> The top of the trace seems to vary a little bit above
> the inband_irq_enable. For example, here is another trace from
> the stuck CPU where the sync_current_irq_stage call is missing:
>
> __inband_irq_enable (arch/x86/include/asm/irqflags.h:41 arch/x86/include/asm/irqflags.h:91 kernel/irq/pipeline.c:287)
> inband_irq_enable (kernel/irq/pipeline.c:317 (discriminator 9))
> _raw_spin_unlock_irq (kernel/locking/spinlock.c:203)
> rwsem_down_write_slowpath (arch/x86/include/asm/current.h:15 (discriminator 1) kernel/locking/rwsem.c:1136 (discriminator 1))
> down_write (kernel/locking/rwsem.c:1535)
> kernfs_activate (fs/kernfs/dir.c:1302)
> kernfs_add_one (fs/kernfs/dir.c:774)
> kernfs_create_dir_ns (fs/kernfs/dir.c:1001)
> sysfs_create_dir_ns (fs/sysfs/dir.c:62)
> kobject_add_internal (lib/kobject.c:89 (discriminator 11) lib/kobject.c:255 (discriminator 11))
> kobject_add (lib/kobject.c:390 lib/kobject.c:442)
> ? _raw_spin_unlock (kernel/locking/spinlock.c:187)
> device_add (drivers/base/core.c:3329)
> ? __init_waitqueue_head (kernel/sched/wait.c:13)
> device_register (drivers/base/core.c:3476)
> create_sys_device (kernel/evl/factory.c:312)
> create_element_device (kernel/evl/factory.c:439)
> ioctl_clone_device (kernel/evl/factory.c:559)
> __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:874 fs/ioctl.c:860 fs/ioctl.c:860)
> do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:89)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:118)
>
> Any thoughts on what may be causing this?

A kernel device is mated to each EVL element, this is what gives us a
/sysfs representation for each of them (e.g. evl-ps reads those [thread]
device files to figure out what is running in the system).

-- 
Philippe.
