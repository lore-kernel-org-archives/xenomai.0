Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F262701CA
	for <xenomai@lists.linux.dev>; Mon, 28 Jul 2025 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713438; cv=none; b=L1WoRcQKiZyi/RH4gBu4QC3UO+3XHMpRBraVZAbp71nL+r1HZ+0Eb5rLJMzEzeJK/fEEXjV6UqEXRLW9tbsV6BPQyqfU3KPfOXaH7kdAxd+R9GR7fiNsUzHA/wDz3XvAbsfFocSmONdaEc8H92Hj3lvh5z+93zExGKzIY708cZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713438; c=relaxed/simple;
	bh=uxtrn9ham88+oZcMymYVavsjlOs/XWe59TVGIs+v9e0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eYYEt97A7C9D5W/qaayiUiniWoS+QlyNCA4TMS+Wbh0mGYCmngewBA2N57GWlkHng55O+CL1zpFFy+mYg//dDGWuLeyKXUJHFtHv8zlfrRf11/DBrE1L9QimgB9h/U1ihD3OUx/5HKBJq+9pfACR3YgChXMOwpdx+Zns+yE/jmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=KYS+RJUh; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="KYS+RJUh"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250728143709faaab6e52d129c0b69
        for <xenomai@lists.linux.dev>;
        Mon, 28 Jul 2025 16:37:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Ev9DCylRbz3vcR1uK22tjd3fm5qeIWIzUZhi6BKcAng=;
 b=KYS+RJUhkX9f/WLBW5qOePs/lSz2fNqroLen3kJDq3eeln238U9g0zBggIH57AWED1xrNt
 +jjQcIW7w0fDOqycFyft+J97urSBaY3QmzqFG1KcHQp7vC3ugnmwyh19Uvqc9/yx4MKxd4k0
 R6bY5RxrLmWHZUULo8sg/jflA5of+6TwwIsoLI4F2Su02b7fLtpPdaGBdYyHatIcAdBN+cKS
 Szq8M3/2FgJmw3cB97I3f8TjCXmzz854boU0O/a5+aeQfIYww3fSYiT6VKghmHA5UCR/Adrc
 N2/i0XQ3SFk2WTt4f/mpeHwrX4lqXlCaB8LDG1NsCYz8ABx/TlAb4iJw==;
Message-ID: <6fcb3f9830056d99161ea8f50a016b99d98a7c71.camel@siemens.com>
Subject: Re: Dovetail 6.15: x86: Invalid wait context
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 28 Jul 2025 16:37:09 +0200
In-Reply-To: <87fres42zc.fsf@xenomai.org>
References: <ee6e634d9d87ef52670dbb9ce91d7080b8640a71.camel@siemens.com>
		<87tt4ubote.fsf@xenomai.org>
		<997e11d95184f34a23fad2607504ef567ec07758.camel@siemens.com>
		<87a55bw26w.fsf@xenomai.org>
		<f9245ae15561f12335177c73df9d9b53de4d7ac9.camel@siemens.com>
		<87ldok48lm.fsf@xenomai.org> <87fres42zc.fsf@xenomai.org>
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

On Sat, 2025-07-19 at 17:25 +0200, Philippe Gerum wrote:
> Philippe Gerum <rpm@xenomai.org> writes:
>=20
> > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> >=20
> > > On Fri, 2025-07-11 at 10:40 +0200, Philippe Gerum wrote:
> > > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > > >=20
> > > > > On Thu, 2025-06-05 at 10:00 +0200, Philippe Gerum wrote:
> > > > > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > > > > >=20
> > > > > > > Hi Philippe,
> > > > > > >=20
> > > > > > > the following is taken from our CI, testing Dovetail 6.15.
> > > > > > > On x86 we have an invalid wait context reported:
> > > > > > >=20
> > > > > > > [  151.574032]=20
> > > > > > > [  151.574039] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > [  151.574043] [ BUG: Invalid wait context ]
> > > > > > > [  151.574046] 6.15.0 #1 Not tainted
> > > > > > > [  151.574048] -----------------------------
> > > > > > > [  151.574048] swapper/0/0 is trying to lock:
> > > > > > > [  151.574050] ffffffff841174c0 (&state->readq){....}-{3:3}, =
at: __wake_up+0x21/0x60
> > > > > > > [  151.574063] other info that might help us debug this:
> > > > > > > [  151.574064] context-{2:2}
> > > > > > > [  151.574065] no locks held by swapper/0/0.
> > > > > > > [  151.574066] stack backtrace:
> > > > > > > [  151.574073] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not taint=
ed 6.15.0 #1 PREEMPT(full)=20
> > > > > > > [  151.574078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2=
009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > > > > > > [  151.574079] IRQ stage: Linux
> > > > > > > [  151.574083] Call Trace:
> > > > > > > [  151.574086]  <IRQ>
> > > > > > > [  151.574088]  dump_stack_lvl+0x79/0xe0
> > > > > > > [  151.574095]  __lock_acquire+0x942/0xbf0
> > > > > > > [  151.574104]  lock_acquire+0xe2/0x2f0
> > > > > > > [  151.574107]  ? __wake_up+0x21/0x60
> > > > > > > [  151.574111]  ? find_held_lock+0x2b/0x80
> > > > > > > [  151.574115]  _raw_spin_lock_irqsave+0x49/0x60
> > > > > > > [  151.574120]  ? __wake_up+0x21/0x60
> > > > > > > [  151.574122]  __wake_up+0x21/0x60
> > > > > > > [  151.574125]  xnpipe_wakeup_proc+0x152/0x590
> > > > > > > [  151.574132]  handle_synthetic_irq+0xc2/0x250
> > > > > > > [  151.574137]  arch_do_IRQ_pipelined+0xca/0x180
> > > > > > > [  151.574141]  </IRQ>
> > > > > > > [  151.574142]  <TASK>
> > > > > > > [  151.574144]  sync_current_irq_stage+0xaa/0x110
> > > > > > > [  151.574147]  inband_irq_enable+0x42/0x60
> > > > > > > [  151.574151]  cpuidle_idle_call+0x17d/0x200
> > > > > > > [  151.574155]  do_idle+0x89/0xd0
> > > > > > > [  151.574158]  cpu_startup_entry+0x29/0x30
> > > > > > > [  151.574160]  rest_init+0xf0/0x190
> > > > > > > [  151.574164]  start_kernel+0x632/0x700
> > > > > > > [  151.574179]  x86_64_start_reservations+0x18/0x30
> > > > > > > [  151.574185]  x86_64_start_kernel+0x78/0x80
> > > > > > > [  151.574188]  common_startup_64+0x13e/0x148
> > > > > > > [  151.574198]  </TASK>
> > > > > > >=20
> > > > > > > That seems to be triggered by the Xenomai 3 smokey testsuite.
> > > > > > >=20
> > > > > > > Any ideas?
> > > > > >=20
> > > > > > Does this happen when full preemption is disabled on x86?
> > > > >=20
> > > > > Test-Log: https://lava.xenomai.org/scheduler/job/21679
> > > > > Kernel-Config: https://source.denx.de/Xenomai/xenomai-images/-/bl=
ob/next/recipes-kernel/linux/files/amd64_defconfig?ref_type=3Dheads
> > > >=20
> > > > I can reproduce a similar issue with EVL right now, but this requir=
es
> > > > full preemption to be enabled for the bug to show up, starting from
> > > > 6.15. I can see the reason for lockdep to complain in this case, si=
nce
> > > > synthetic irqs are not relayed via softirqs yet. However, this can'=
t
> > > > explain why an oldish 4.14 kernel would complain.
> > >=20
> > > Thanks for letting us know. But: Where is 4.14 coming into the game?
> >=20
> > Because the link you sent me referred to a kernel config for 4.14.71. I
> > assumed the yocto recipe which contains it did produce the qemu image
> > showing the issue.
> >=20
> > > Our reports (from CI testing) were 6.15 related, nothing older.
> > >=20
> > > Is there a specific change in 6.15 that broke the synthetic IRQ
> > > handling?
> >=20
> > 814b824b4466b irq_work: dovetail: never defer local work posted from oo=
b
> >=20
> > > Are you already working an a fix?
> >=20
> > Yep.
>=20
> The broken commit was reverted from v6.1.y-cip-rebase, v6.12.y-rebase
> and v6.15, things are back to normal for x4 now. I believe this should
> fix x3 as well.

At least our virtual x86 target is still reporting the same problem
when running the x3 testsuite. Other archs are still running, let's
see.

We do not have full preemption enabled.

Test run: https://lava.xenomai.org/scheduler/job/22325
Report  : https://lava.xenomai.org/scheduler/job/22325#L864


