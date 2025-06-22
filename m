Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47F9E555
	for <xenomai@lists.linux.dev>; Sun, 22 Jun 2025 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750597588; cv=none; b=K7/2PmIIV9hDdZYCkqbfVasAWlI22q6FUGVTCjUZ0Xv27Q1SC+3fNQzj2GMetlhuqEGsJFE18LuPdRw0RrQnxjcJ+zkCe8DJnbnmVRacL9mQPY+wxDyhWf2SGgbPGaUMajPKcQ5p5bl7OBrHT/5+WC0JIUb1Wxzq1YETEoYR6BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750597588; c=relaxed/simple;
	bh=k85VWqne4sVf/bjIeGINxt7s1KvE1iE/0I4Umqi4yhg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kV78vGXsZ5/ooiy2YyqXkiJtpbD9Ej/T4jfCckPscRQF6ad0oz80z/SdbRwWCTUrU0mzRbCidMJM6vFHdhyxSNee6Bc7qs1udECpSOF507wtn67FpblqKgJXiAPMSUKr5UHVy7bMQwqu2p2sL9br7/6VpQbmE+IxbpZ9946rlJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=uCMyUnhh; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="uCMyUnhh"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250622130613b6da78ac0921620bf4
        for <xenomai@lists.linux.dev>;
        Sun, 22 Jun 2025 15:06:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=e9HKWwXI3MLj1DDDmozLWccyyNszZBlaV+PYYA+aewU=;
 b=uCMyUnhhTgibEAGz5gmqBx6aSMzBo+2CXbEpYPrqDCkt6V5U1QX/LyGWEBYuZDRiaFcABo
 WzIgqzfXiuO92+JXcXEK7Z6wd85sBXwT6/MjibPSSm6LY8aEByCAU3+Wf1fJC+zr8JmW1NXm
 g/iEKG21U9wzWLyE4Cv4vOpo4/bZxIHCM4foGfYoGlKq8SvHTxvw+xjT9h+p594u446BJ5WC
 JCnY27m8Fo3x4sAjMHHZTngqJ1Aq5GSPZzdQ/42sCSNDVPhFYcs3Ncn2dJqtx8LFR7DFRtJQ
 sL07xWND8ovd2EW0ygoc3oqJ2b5XQkbRAeA83ZkQYqfqwoYvqSnSG10w==;
Message-ID: <19a580b69bcbde87c2e6d30a8df8dbc11156ddff.camel@siemens.com>
Subject: Re: Dovetail 6.15: x86: Invalid wait context
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>
Date: Sun, 22 Jun 2025 15:06:12 +0200
In-Reply-To: <87ldq6ax7s.fsf@xenomai.org>
References: <ee6e634d9d87ef52670dbb9ce91d7080b8640a71.camel@siemens.com>
		<87tt4ubote.fsf@xenomai.org>
		<997e11d95184f34a23fad2607504ef567ec07758.camel@siemens.com>
		<a6c0bc4c19cf73a94ae409b1cd7cd5993da5e162.camel@siemens.com>
	 <87ldq6ax7s.fsf@xenomai.org>
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

On Thu, 2025-06-05 at 19:56 +0200, Philippe Gerum wrote:
> >=20
> > Btw: Enabling CONFIG_DEBUG_ENTRY on 6.15 delivers:
> >=20
> > vmlinux.o: warning: objtool: do_int80_emulation+0x204: return with inst=
rumentation enabled
> > vmlinux.o: warning: objtool: irqentry_exit+0xdc: call to synchronize_pi=
peline() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: ct_idle_exit+0x1: call to inband_irq_save(=
) leaves .noinstr.text section
> > vmlinux.o: warning: objtool: cpuidle_enter_state+0x1a4: return with ins=
trumentation enabled
> > vmlinux.o: warning: objtool: default_idle+0x7: call to inband_irq_disab=
le() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: mwait_idle+0x44: call to inband_irq_disabl=
e() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x9a: call=
 to inband_irq_disable() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x60: call to inband_=
irq_enable() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: intel_idle_irq+0x54: call to inband_irq_di=
sable() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: acpi_safe_halt+0x1a: call to inband_irq_di=
sable() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: poll_idle+0x1d: call to inband_irq_enable(=
) leaves .noinstr.text section
> >=20
> > Is that something we should look into?
>=20
> Yes, we need to keep those calls within the instrumentation_begin/end
> blocks, or annotate them. There are imbalanced calls to fix as well,
> e.g.
>=20
> diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> index 54749f4736633..cb1b4ad38568c 100644
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -173,6 +173,7 @@ __visible noinstr void do_int80_emulation(struct pt_r=
egs *regs)
>  	if (dovetailing()) {
>  		if (nr =3D=3D EXIT_SYSCALL_OOB) {
>  			hard_local_irq_disable();
> +			instrumentation_end();
>  			return;
>  		}
>  		if (nr =3D=3D EXIT_SYSCALL_TAIL)

After addressing the low hanging fruits (results parked at [1] the
following remains:

vmlinux.o: warning: objtool: ct_idle_exit+0x1: call to inband_irq_save() le=
aves .noinstr.text section
vmlinux.o: warning: objtool: default_idle+0x13: call to inband_irq_disable(=
) leaves .noinstr.text section
vmlinux.o: warning: objtool: mwait_idle+0x51: call to inband_irq_disable() =
leaves .noinstr.text section
vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x9a: call to =
inband_irq_disable() leaves .noinstr.text section
vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x60: call to inband_irq_=
enable() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle_irq+0x54: call to inband_irq_disabl=
e() leaves .noinstr.text section
vmlinux.o: warning: objtool: acpi_safe_halt+0x1a: call to inband_irq_disabl=
e() leaves .noinstr.text section
vmlinux.o: warning: objtool: poll_idle+0x2a: call to inband_irq_enable() le=
aves .noinstr.text section

The problem / pattern is always the same: Idle implementations -
located inside the __cpuidle section - using the raw_local_irq_*()
interfaces.

Linux has no real "call" in the affected code paths. Everything is
inlined, so objtool is happy. inbaind_irq_*() are functions located
outside the noinstr / cpuidle section.

All functions in the affected call paths have to reside inside the
noinstr section. That's why moving inbaind_irq_*() to this section
seems too invasive.

Any ideas?

Best regards,
Florian

[1] https://gitlab.com/Xenomai/dovetail-hacker-space/-/commits/flo/add-hype=
rv-support-for-6-15?ref_type=3Dheads
