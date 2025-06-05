Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0575B1B3930
	for <xenomai@lists.linux.dev>; Thu,  5 Jun 2025 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111300; cv=none; b=u5r5fTrKejUG7ON9gnDDY/FwiW3rl/tz6Jr50a2+a4AM68AjsQCCzwc20Hg2K+xo+nVjzrj/xSymn1fMcEDXuNwYoTfb3EjiE5bnoVl1Hj/XILerGQAOgMme62XUmFvFTi3LfN5Hdz+5Phn9Ih9p0b/1LelGsH5HHZj7mnMuI4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111300; c=relaxed/simple;
	bh=fAWdLF2itKdPyVtVbnhgZkvkc7sYr99SJKUrlJ9vXKU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k+KlywZGTocHfIdLMkrqiz6i59CwXub84BT028e8y8v8P3pcVw14Yvy0kNzzfMdrnVcqCZSADuDCeEJ++Kg/JsSu5cX3xHLvNSIcPZOVtDv973K4dllMKEUtQge1tO1iTSamrSJzcVFQWptjlAWMMJF+R7VHu1o2nMuAATxdB9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=bYuxbGfO; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="bYuxbGfO"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250605081451fbb86da8d2e79ca76b
        for <xenomai@lists.linux.dev>;
        Thu, 05 Jun 2025 10:14:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=YdDft+xvEjqprqwwVurKAUsZeSUe3PvMmI/mKVzMLss=;
 b=bYuxbGfO3kAtDMW+ZkGfeuZqtMqobUnNqZ/0OQdxgOT1u5NOgCZBfvnPlKzaSNwUhO852g
 JTBXjs2Vmp/2dYAKNxyTLWFtPHtWeh221BI8pOBDE2yI3kZfMi+fzN1xRsJYGQWF196pEufC
 N+0VLffRXZWis9r1J/A+8Cr0CORGM3XSU9JIQgwL0ik4CG4ROcwIYD4Mwenrc4MkCGjEv8na
 UDFbaXc/i+Zs5I5OaaGOi2n2/zbGhRf0i1x4mrf+UhmvcRQyOFdGapxap9PEvoCpQjPHA5+D
 8Xfk4kr+gGl9g3XfU170mssECiJDncbHKZxhAZrF082HLKuuAx8aDWHg==;
Message-ID: <997e11d95184f34a23fad2607504ef567ec07758.camel@siemens.com>
Subject: Re: Dovetail 6.15: x86: Invalid wait context
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu, 05 Jun 2025 10:14:50 +0200
In-Reply-To: <87tt4ubote.fsf@xenomai.org>
References: <ee6e634d9d87ef52670dbb9ce91d7080b8640a71.camel@siemens.com>
	 <87tt4ubote.fsf@xenomai.org>
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

On Thu, 2025-06-05 at 10:00 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > Hi Philippe,
> >=20
> > the following is taken from our CI, testing Dovetail 6.15.
> > On x86 we have an invalid wait context reported:
> >=20
> > [  151.574032]=20
> > [  151.574039] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [  151.574043] [ BUG: Invalid wait context ]
> > [  151.574046] 6.15.0 #1 Not tainted
> > [  151.574048] -----------------------------
> > [  151.574048] swapper/0/0 is trying to lock:
> > [  151.574050] ffffffff841174c0 (&state->readq){....}-{3:3}, at: __wake=
_up+0x21/0x60
> > [  151.574063] other info that might help us debug this:
> > [  151.574064] context-{2:2}
> > [  151.574065] no locks held by swapper/0/0.
> > [  151.574066] stack backtrace:
> > [  151.574073] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.15.0 =
#1 PREEMPT(full)=20
> > [  151.574078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > [  151.574079] IRQ stage: Linux
> > [  151.574083] Call Trace:
> > [  151.574086]  <IRQ>
> > [  151.574088]  dump_stack_lvl+0x79/0xe0
> > [  151.574095]  __lock_acquire+0x942/0xbf0
> > [  151.574104]  lock_acquire+0xe2/0x2f0
> > [  151.574107]  ? __wake_up+0x21/0x60
> > [  151.574111]  ? find_held_lock+0x2b/0x80
> > [  151.574115]  _raw_spin_lock_irqsave+0x49/0x60
> > [  151.574120]  ? __wake_up+0x21/0x60
> > [  151.574122]  __wake_up+0x21/0x60
> > [  151.574125]  xnpipe_wakeup_proc+0x152/0x590
> > [  151.574132]  handle_synthetic_irq+0xc2/0x250
> > [  151.574137]  arch_do_IRQ_pipelined+0xca/0x180
> > [  151.574141]  </IRQ>
> > [  151.574142]  <TASK>
> > [  151.574144]  sync_current_irq_stage+0xaa/0x110
> > [  151.574147]  inband_irq_enable+0x42/0x60
> > [  151.574151]  cpuidle_idle_call+0x17d/0x200
> > [  151.574155]  do_idle+0x89/0xd0
> > [  151.574158]  cpu_startup_entry+0x29/0x30
> > [  151.574160]  rest_init+0xf0/0x190
> > [  151.574164]  start_kernel+0x632/0x700
> > [  151.574179]  x86_64_start_reservations+0x18/0x30
> > [  151.574185]  x86_64_start_kernel+0x78/0x80
> > [  151.574188]  common_startup_64+0x13e/0x148
> > [  151.574198]  </TASK>
> >=20
> > That seems to be triggered by the Xenomai 3 smokey testsuite.
> >=20
> > Any ideas?
>=20
> Does this happen when full preemption is disabled on x86?

Test-Log: https://lava.xenomai.org/scheduler/job/21679
Kernel-Config: https://source.denx.de/Xenomai/xenomai-images/-/blob/next/re=
cipes-kernel/linux/files/amd64_defconfig?ref_type=3Dheads




