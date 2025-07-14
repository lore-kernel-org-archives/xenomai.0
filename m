Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C947D2376F8
	for <xenomai@lists.linux.dev>; Mon, 14 Jul 2025 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752525508; cv=none; b=hsnYrDt4xM4nAn15f9q4AOt6D/wBu/F9i+mghiYmgPikOop9XxuO3XN+v/4qYaKhkYKI64y5QgM3/Pp6ioDFq+1UC4b/CiOtcSi9pUwFcsdpi4f1lQolEqMFf+y9fFVUzXtUu40Fa3Kpq983CIBEGq1hn1oGPRC9KRQwSfh9Ia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752525508; c=relaxed/simple;
	bh=iMcAs3ZZ/B6rAyAJa/tXJr7tBZxZ7WKb/p13i99vWnQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a4ffCPuUUaRkNLbddaUVnCgY3deliYb314gM89uVpqS3ZVJsqfjVlh5xp4kgsb9hZaXP11+43o8Xl0tyHVTM6RDvj8ZA9m5ddY6wgxyA1G/RgRfHSUWqYiZBomu1oYAh9cdOSGOdGoPF7G7f+ByP3suMF4W2haLWs2urpGzVjFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=iLQHNLuh; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="iLQHNLuh"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250714145747368b5144676d01f77a
        for <xenomai@lists.linux.dev>;
        Mon, 14 Jul 2025 16:57:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=aObw+3Yyn3TZ7B4fPRW3MjGmHP1jdpObLFMTIsDvsQE=;
 b=iLQHNLuh7SZzNmdm/3Pa9egELUWRP6qBM8NdBREI/FF3qHWdeosLYfEjB3HN/YFwkHU9yK
 c10XxQhnf6BPToKPARg9Bad9KISojg2SS3XIY4IKWj4hBQpyw657OHfSnF3srXKIQfORKxYP
 Hxg/RF4iWdMQD6QbytcqfZbxG6auUhswdx8vOY8i8Q/YXWtEukMNNs5RYX9HW5U3DzLJTLMd
 SNsKuz6S2krY3aiCKtynzsUiFBmy7Bz9nsMT+IiUlIPNC9/L2MTwXIB1m1cDgW4rWrTtlx6q
 93cDaShAS+B4ANkWNIZNaoDvPI5pV5P/wRdIvzE9lYQppfOt5rjKGyNQ==;
Message-ID: <f9245ae15561f12335177c73df9d9b53de4d7ac9.camel@siemens.com>
Subject: Re: Dovetail 6.15: x86: Invalid wait context
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 14 Jul 2025 16:57:46 +0200
In-Reply-To: <87a55bw26w.fsf@xenomai.org>
References: <ee6e634d9d87ef52670dbb9ce91d7080b8640a71.camel@siemens.com>
		<87tt4ubote.fsf@xenomai.org>
		<997e11d95184f34a23fad2607504ef567ec07758.camel@siemens.com>
	 <87a55bw26w.fsf@xenomai.org>
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

On Fri, 2025-07-11 at 10:40 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Thu, 2025-06-05 at 10:00 +0200, Philippe Gerum wrote:
> > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > >=20
> > > > Hi Philippe,
> > > >=20
> > > > the following is taken from our CI, testing Dovetail 6.15.
> > > > On x86 we have an invalid wait context reported:
> > > >=20
> > > > [  151.574032]=20
> > > > [  151.574039] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > [  151.574043] [ BUG: Invalid wait context ]
> > > > [  151.574046] 6.15.0 #1 Not tainted
> > > > [  151.574048] -----------------------------
> > > > [  151.574048] swapper/0/0 is trying to lock:
> > > > [  151.574050] ffffffff841174c0 (&state->readq){....}-{3:3}, at: __=
wake_up+0x21/0x60
> > > > [  151.574063] other info that might help us debug this:
> > > > [  151.574064] context-{2:2}
> > > > [  151.574065] no locks held by swapper/0/0.
> > > > [  151.574066] stack backtrace:
> > > > [  151.574073] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.1=
5.0 #1 PREEMPT(full)=20
> > > > [  151.574078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > > > [  151.574079] IRQ stage: Linux
> > > > [  151.574083] Call Trace:
> > > > [  151.574086]  <IRQ>
> > > > [  151.574088]  dump_stack_lvl+0x79/0xe0
> > > > [  151.574095]  __lock_acquire+0x942/0xbf0
> > > > [  151.574104]  lock_acquire+0xe2/0x2f0
> > > > [  151.574107]  ? __wake_up+0x21/0x60
> > > > [  151.574111]  ? find_held_lock+0x2b/0x80
> > > > [  151.574115]  _raw_spin_lock_irqsave+0x49/0x60
> > > > [  151.574120]  ? __wake_up+0x21/0x60
> > > > [  151.574122]  __wake_up+0x21/0x60
> > > > [  151.574125]  xnpipe_wakeup_proc+0x152/0x590
> > > > [  151.574132]  handle_synthetic_irq+0xc2/0x250
> > > > [  151.574137]  arch_do_IRQ_pipelined+0xca/0x180
> > > > [  151.574141]  </IRQ>
> > > > [  151.574142]  <TASK>
> > > > [  151.574144]  sync_current_irq_stage+0xaa/0x110
> > > > [  151.574147]  inband_irq_enable+0x42/0x60
> > > > [  151.574151]  cpuidle_idle_call+0x17d/0x200
> > > > [  151.574155]  do_idle+0x89/0xd0
> > > > [  151.574158]  cpu_startup_entry+0x29/0x30
> > > > [  151.574160]  rest_init+0xf0/0x190
> > > > [  151.574164]  start_kernel+0x632/0x700
> > > > [  151.574179]  x86_64_start_reservations+0x18/0x30
> > > > [  151.574185]  x86_64_start_kernel+0x78/0x80
> > > > [  151.574188]  common_startup_64+0x13e/0x148
> > > > [  151.574198]  </TASK>
> > > >=20
> > > > That seems to be triggered by the Xenomai 3 smokey testsuite.
> > > >=20
> > > > Any ideas?
> > >=20
> > > Does this happen when full preemption is disabled on x86?
> >=20
> > Test-Log: https://lava.xenomai.org/scheduler/job/21679
> > Kernel-Config: https://source.denx.de/Xenomai/xenomai-images/-/blob/nex=
t/recipes-kernel/linux/files/amd64_defconfig?ref_type=3Dheads
>=20
> I can reproduce a similar issue with EVL right now, but this requires
> full preemption to be enabled for the bug to show up, starting from
> 6.15. I can see the reason for lockdep to complain in this case, since
> synthetic irqs are not relayed via softirqs yet. However, this can't
> explain why an oldish 4.14 kernel would complain.

Thanks for letting us know. But: Where is 4.14 coming into the game?
Our reports (from CI testing) were 6.15 related, nothing older.

Is there a specific change in 6.15 that broke the synthetic IRQ
handling? Are you already working an a fix?


