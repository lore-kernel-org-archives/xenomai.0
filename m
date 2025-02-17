Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D928EC
	for <xenomai@lists.linux.dev>; Tue, 18 Feb 2025 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739837561; cv=none; b=NwHswXN2g+FpgtVgRfAuUaRHEfsDoLa3D2NvwPNeu9yweu7Af78duv7AGEKb+arOUqGFE3aP+VUUsOabFHtBPDjOYkGYnX28+n4pEM/QdHX7ZgTrjRFzhI3eMig4hqepauS7zvDJpI5/pNFCg6W2/Mioe4WZtAqHpYwSwQTEcPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739837561; c=relaxed/simple;
	bh=uAdDEiQ/xL4DzqpJyjhh0gIG4ChnFo0oNleBmys17WU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SYh/pUt0NLMCyVOZzPSfpLzGNoD2CJ4opnNhyIVHNvyOBEQ2F18rNR/yzkoXb7SeA3/COcB2QDGPrusdzF7xk+h8MaJVi+Jla3HuUhhWpjI5xDaOPaFXFe3k0iD2UN+odE6iHHuNDkmAFFXb15kt4dW3pt5lkzXHSNuIP1awJt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=WqK8YRIf; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="WqK8YRIf"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025021722320493c5278233faba4ffc
        for <xenomai@lists.linux.dev>;
        Mon, 17 Feb 2025 23:32:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Bpmik9F0iww9WsCgRGLPSwqRltcjlTUPGCRoPzceLXw=;
 b=WqK8YRIfTcJFp0aBmF8PxQh7bkOhJo7GAWjWPS4bxoHrriw7B1+7pBC5hx93QJRDkdveKM
 6hB1xH/63FriRL9xSbkaytoBBXp8yGIRM6hJ83bb7P/QXbbgyu7TOp73otcGQuSrQw3wEe5V
 pR4XmNNIjWTHLiJDIfwxsY0qJTgY7LbjMSeP+s2o6vxmhUxl+7m4qaVM0Gb6ZrPSrZaRiUrh
 aPS3PNWV2MEJLRmUAfYCHYflCSUKpRb+AG/Tr6nh4lZMRU8TwXMa/D+tTbMTf/vT2rSgEi7r
 t1uBHpFBYT36+O/pClsAJ36FOaX3l7+FRDIQ3TmoqX8gjKELznfrpPCQ==;
Message-ID: <bb3d5883b5fadf01598a192c5afacdcbe66a0ce7.camel@siemens.com>
Subject: Re: Problem with moving from Ipipe to dovetail
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Marc =?ISO-8859-1?Q?Str=E4mke?=
	 <marc.straemke@eltropuls.de>, xenomai@lists.linux.dev
Date: Mon, 17 Feb 2025 23:32:04 +0100
In-Reply-To: <23280aaa-d95d-4ae0-8ce4-ebfcdb857e44@siemens.com>
References: <34ff489c-a946-4fa5-a542-89aec2d1c8f9@eltropuls.de>
	 <26540366296aa067a398520f3a9cfa94caa19fe8.camel@siemens.com>
	 <fac0181a-eee1-4820-ad8c-ea2b88629f5f@eltropuls.de>
	 <a398fe9f-d3c0-4254-8a9e-5fe0eff25f86@eltropuls.de>
	 <23280aaa-d95d-4ae0-8ce4-ebfcdb857e44@siemens.com>
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

On Mon, 2025-02-17 at 16:19 +0100, Jan Kiszka wrote:
> On 17.02.25 13:42, Marc Str=C3=A4mke wrote:
> > Hello Florian,
> >=20
> > On 17.02.25 08:43, Marc Str=C3=A4mke wrote:
> > > Hi Florian,
> > >=20
> > > i cannot seem to get any kernel to run in QEMU ,-) I will need some
> > > time to dig in to it.
> > >=20
> > > Marc
> > >=20
> > > On 14.02.25 16:34, Florian Bezdeka wrote:
> > > > Hi Marc,
> >=20
> > Interestingly the error replicates in Qemu + KVM, but not in qemu soft
> > emulation.
> >=20
> > Maybe with this Information can someone help point me in the right
> > direction:
> >=20
> > 1. Scenario: Starting with qemu_system_x86_64 without kvm everything bo=
ots.
> >=20
> > 2. Scenario: Starting with accel=3Dkvm the machine hangs. GDB shows thi=
s
> > backtrace when frozen.
> >=20
>=20
> This can give you different CPU features and also different timings.
>=20
> > native_irq_disable () at ./arch/x86/include/asm/irqflags.h:46
> > 46=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 asm volatile("cli": : :"memory");
> > (gdb) bt
> > #0=C2=A0 native_irq_disable () at ./arch/x86/include/asm/irqflags.h:46
> > #1=C2=A0 default_idle () at arch/x86/kernel/process.c:743
> > #2=C2=A0 0xffffffff81f1d847 in default_idle_call () at kernel/sched/idl=
e.c:102
> > #3=C2=A0 0xffffffff810e6bf6 in cpuidle_idle_call () at kernel/sched/idl=
e.c:177
> > #4=C2=A0 do_idle () at kernel/sched/idle.c:296
> > #5=C2=A0 0xffffffff810e6e05 in cpu_startup_entry
> > (state=3Dstate@entry=3DCPUHP_ONLINE) at kernel/sched/idle.c:395
> > #6=C2=A0 0xffffffff81f1d9e0 in rest_init () at init/main.c:732
> > #7=C2=A0 0xffffffff83038939 in arch_call_rest_init () at init/main.c:82=
9
> > #8=C2=A0 0xffffffff83038e1c in start_kernel () at init/main.c:1077
> > #9=C2=A0 0xffffffff83042948 in x86_64_start_reservations
> > (real_mode_data=3Dreal_mode_data@entry=3D0x13cd0 <exception_stacks+3195=
2>
> > <error: Cannot access memory at address 0x13cd0>) at arch/x86/kernel/
> > head64.c:556
> > #10 0xffffffff83042a6c in x86_64_start_kernel (real_mode_data=3D0x13cd0
> > <exception_stacks+31952> <error: Cannot access memory at address
> > 0x13cd0>) at arch/x86/kernel/head64.c:537
> > #11 0xffffffff810001cb in secondary_startup_64 () at arch/x86/kernel/
> > head_64.S:449
> > #12 0x0000000000000000 in ?? ()
> > (gdb) q

Run lx-dmesg (see previous mails), just to make sure we don't have any
pending WARN() in the console buffer pending that did not make it to
the console (due to a broken IRQ pipeline) anymore.

In addition: We dropped the maintenance support for 6.6 a view weeks
ago. There was an announcement on the list. Can you reproduce the same
issue with 6.12? The 6.6 based branches will not be touched anymore.

Two more things that jumped at me but might be unrelated:
- Dynamic Preempt: full
- Clocksource: Each provided log seems to use a different clocksource,
  especially TSC is missing in the dmesg_runs_kvm_smp2 file.

> >=20
>=20
> You are just stopped in idle, waiting for the next irq (which may never
> come if we have a bug).
>=20
> >=20
> > Third Scenario: Start Qemu with accel=3Dkvm and smp=3D2 parameters for =
2
> > cpus. The VM boots.
>=20
> So, scenario 2 is single-core? Normally better to debug anyway.
>=20
> >=20
> > The reasoning behind the SMP parameter was that the target hardware has
> > 2 cores...
> >=20
> > I have attached all 3 bootlogs.
> >=20
>=20
> Can you also share what you did to reproduce in qemu/kvm? .config for
> the kernel, .config.yaml for xenomai-images etc.
>=20
> Jan
>=20

