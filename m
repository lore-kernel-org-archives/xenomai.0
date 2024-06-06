Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC9331A89
	for <xenomai@lists.linux.dev>; Thu,  6 Jun 2024 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660054; cv=none; b=Y4CdmRDD5i73HqSblG2R+0fky51Wgd8R3iHseCheN+z+ilCgNTIdtLUbEJhk8OUUk280ePF+i0blyn4rPv32aTl0HNXCMBhOuAONxvoXk8+qDECTYjmrsV252UUinbjuGCvmUbq5QDg8T9/AW1XfPYs0eIekFw3Qbd7gnPEYfyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660054; c=relaxed/simple;
	bh=6wotfgVkQHwxTok9hkPDB1lbk2kyczDDZHPwCh39rNs=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=soSsN8Bb0e3V2VmFdmuUU2pBNcs/IM0CJwLzEuY8Ids/UoZhs5tVmD1e0ltRw4O6Bbi6TApo17iIZcDec2VinqZgZIUKWKFlbUBvRB2h16NVt+gOGg+Dn6zWxCx6iFlr+4SOy2CEPcKNmpKdtHK7fNukl3oBQV9KW+t0Orl8aGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=WjZk0rsc; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="WjZk0rsc"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240606074722db985930359a8f48a2
        for <xenomai@lists.linux.dev>;
        Thu, 06 Jun 2024 09:47:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=XJEv/mBwX1HB0GHtAuQMlsSJolBaMc+uxeAEVznyZrc=;
 b=WjZk0rscZlQkbF1kqcybfoJA6fgMbdcsLxVSoSqVeATxzfPy6AoIbliEfvVIq2ursreVnR
 VNCAFO6nLvc3ya+8ffMb49YQ1tEgrp7jHlIY9CvwCOzwkExA9YtbMXvMOxQP9FxUtpxQ0zxs
 fHeZA1V2iX+EQ63gzCKMgZqxxygfM=;
Message-ID: <1a4aa9f3bfb30fe5b5955fea1486a5fb8b040ff2.camel@siemens.com>
Subject: Dovetail/Xenomai 3: Timer tick locking problem
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev, Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu, 06 Jun 2024 09:47:21 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

I'm searching for the root cause of the following WARNING - followed by
a complete system hang:


[Xenomai] lock 00000000e04e7d2d already unlocked on CPU #3
          last owner =3D kernel/xenomai/pipeline/intr.c:26 (xnintr_core_clo=
ck_handler(), CPU #-2)
CPU: 3 PID: 31 Comm: ksoftirqd/3 Not tainted 6.1.34-xenomai-1 #1
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/20=
06


Up to now I'm only able to reproduce that with VirtualBox when the PV
spinlock infrastructure is enabled. It takes ~5 min to stall the system
by running stress-ng with the --iomix stressor. "nopvspin" to the
kernel cmdline "solves" this problem for now.

I'm able to stall the same image with the --iomix stressor when running
on kvm/qemu as well. Obviously there is no warning triggered. I'm using
"pci=3Dnomsi" on the kernel cmdline to get the same IRQ routing (via
IOAPIC) as VBox.

While reading all the related code I had some questions that I would
like to have answered.=20


First question:
Broken locking when Xenomai timer tick interrupts an OOB task?=C2=A0

The call stack into the xnintr_core_clock_handler():

#0  xnintr_host_tick (sched=3D0xffff88803e8ab060) at kernel/xenomai/pipelin=
e/intr.c:14
#1  xnintr_core_clock_handler () at kernel/xenomai/pipeline/intr.c:40
#2  0xffffffff81061fdc in clockevents_handle_event (ced=3D0xffff88803e89c28=
0) at ./include/linux/clockchips.h:281
#3  lapic_oob_handler (irq=3D<optimized out>, dev_id=3D<optimized out>) at =
arch/x86/kernel/apic/apic.c:503
#4  0xffffffff81112ecc in do_oob_irq (desc=3Ddesc@entry=3D0xffff88800392940=
0) at kernel/irq/pipeline.c:933
#5  0xffffffff8111315a in handle_oob_irq (desc=3D0xffff888003929400) at ker=
nel/irq/pipeline.c:1036
#6  handle_oob_irq (desc=3D0xffff888003929400) at kernel/irq/pipeline.c:991
#7  0xffffffff811133ff in generic_handle_irq_desc (desc=3D0xffff88800392940=
0) at ./include/linux/irqdesc.h:161
#8  generic_pipeline_irq_desc (desc=3Ddesc@entry=3D0xffff888003929400) at k=
ernel/irq/pipeline.c:1141
#9  0xffffffff81070e78 in arch_handle_irq (regs=3Dregs@entry=3D0xffffc90000=
09be38, vector=3Dvector@entry=3D236 '\354', irq_movable=3Dirq_movable@entry=
=3Dfalse) at arch/x86/kernel/irq_pipeline.c:243
#10 0xffffffff81f48dcb in arch_pipeline_entry (regs=3D0xffffc9000009be38, v=
ector=3D236 '\354') at arch/x86/kernel/irq_pipeline.c:291
#11 0xffffffff8200148a in asm_sysvec_apic_timer_interrupt () at ./arch/x86/=
include/asm/idtentry.h:760
#12 0x0000000000000000 in ?? ()

To my understanding this is an OOB IRQ, interrupting any task, OOB
tasks included. The code in xnintr_core_clock_handler():

	xnlock_get(&nklock);
	xnclock_tick(&nkclock);
	xnlock_put(&nklock);

When running over an OOB task that is currently owning nklock, we will
release the lock unconditionally, leaving the task "unprotected" /
unsynchronized. Right?

There is no OOB task running on my system yet, so it's likely not my
original problem.


Second question:
Back to the original problem. If I interpret the warning correctly
something like

    CPU #2                      CPU #3
                                xnlock_get(&nklock)
    xnlock_get(&nklock)
    xnlock_put(&nklock)
                                xnlock_put(&nklock) (triggers WARN)

must have happened. I think we agree that the infrastructure behind
xnlock_get() should take care that this scenario can never happen. Any
ideas what is going on here? Might that be a bug in the VBox PV
implementation?

The vCPUs should be "parked"/"halted" instead of spinning. On x86 we
run into kvm_wait() doing a "sti;hlt;" combination.

Once kicked by the current lock holder we should wake up and continue
after "hlt;". Even if this goes somehow wrong, some checks about
spurious wakeups are in place.

Might that be a memory "visibility problem", maybe due to a missing
barrier?


Ideas welcome...

Best regards,
Florian

--=20
Siemens AG, Technology
Linux Expert Center

