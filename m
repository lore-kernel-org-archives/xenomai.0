Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCA78F6A
	for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728596521; cv=none; b=QKkShBTbFEdZtaoxrKlVNOPLjf+SPAJ21BqNT7/VPGaNVeKtA+FsYLzBvCHe8bF9AxO106mUGT0gAZRfvVCXh/g36LBOqspu7F7nbCP2LqhEE9ZOENWkxlqDRcFJGKtgFIId52cx9D7Yb6g/kva9kVFbupaGiUhVv2kosy6v6ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728596521; c=relaxed/simple;
	bh=5obqpBoIL1iJTw5RZ63dzlx9mf0vLUdznLAW0N3yFyE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cmAhs0INjHsFdObNMNwMQHxzjeqCKtvtW+knzoaDa9ybZU+7MvXOIFk9hekM/whE5sVLkHyH9OedjxdOMwTYAdb+I3TPFT9qgancbtgSe7Zmf/uTo/s0gkdPkufpbMJpTVFXCRmAUFjowyhUa2SrvQflqfui9sB7C2RqVSjUOkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=O2grSeyn; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="O2grSeyn"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2024101021414628ebc14ee9c216939f
        for <xenomai@lists.linux.dev>;
        Thu, 10 Oct 2024 23:41:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UDPeOwKA9+IFn9peq74Cc+D7heVljQ7yOoZth4bpMpA=;
 b=O2grSeynVyOsxSp4YP+PAewYHSxE27VXiPFP524YhoWljvbUm5YF95o0aoHrqQ2IqYMCSU
 Whg5Krz9u4qjFJhOu+PtsjKNKfsK25Ld7pMrfpGSyiThyr7J6QBm3kMOX2R4AZvOVfunq3R0
 3BRVCbXovuU0D0Wb5bGb/SeveVweP+rJmPXA0G9f9aMjv4JPYoU9uFTwItIIo5Ckl5CyEBvJ
 giYatV+3w4x4+c9JBBzwgsWlifonE5ZmAWr5rE5cfEDmb1i/0U4wRXpu+9DmPNrYMLC+ZgbI
 pmF/HRRToIxqXYSTMML5VCWPgemy+vUBZeRCjbCxJexbJ1J4+H5SKwDg==;
Message-ID: <5dee5801df25853860a25e858a4cd6324ec94ced.camel@siemens.com>
Subject: Re: [PATCH dovetail 6.x] x86: dovetail: Fix inband IRQ state
 corruption on out-of-band compat syscall
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, rpm@xenomai.org
Cc: xenomai@lists.linux.dev
Date: Thu, 10 Oct 2024 23:41:45 +0200
In-Reply-To: <2da42ac8-e531-49a0-87b3-639c8158fcc4@siemens.com>
References: <20241010154421.23303-1-florian.bezdeka@siemens.com>
	 <2da42ac8-e531-49a0-87b3-639c8158fcc4@siemens.com>
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

On Thu, 2024-10-10 at 19:14 +0200, Jan Kiszka wrote:
> On 10.10.24 17:44, Florian Bezdeka wrote:
> > The following kernel splat was found when running the Xenomai 3
> > testsuite in compat on dovetail enabled kernels:
> >=20
> > [  513.620975] IRQ pipeline: some code running in oob context 'Xenomai'
> >                              called an in-band only routine
> > [  513.620998] CPU: 0 PID: 510 Comm: smokey Not tainted 6.10.0+ #76
> > [  513.621003] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 1.16.2-debian-1.16.2-1 04/01/2014
> > [  513.621005] IRQ stage: Xenomai
> > [  513.621007] Call Trace:
> > [  513.621011]  <TASK>
> > [  513.621015]  dump_stack_lvl+0x6f/0xd0
> > [  513.621202]  __inband_irq_enable+0xb/0x60
> > [  513.621249]  do_int80_emulation+0x68/0x160
> > [  513.621265]  asm_int80_emulation+0x1a/0x20
> > [  513.621285] RIP: 0023:0xf7f692ba
> > [  513.621288] Code: Unable to access opcode bytes at 0xf7f69290.
> > [  513.621303] RSP: 002b:00000000ffeedf40 EFLAGS: 00000282 ORIG_RAX: 00=
00000000000127
> > [  513.621307] RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 0000000=
0ffeedfa0
> > [  513.621309] RDX: 0000000000088000 RSI: 0000000000000000 RDI: 0000000=
0f7f7aff4
> > [  513.621311] RBP: 00000000ffeedf88 R08: 0000000000000000 R09: 0000000=
000000000
> > [  513.621313] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000=
000000000
> > [  513.621315] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000=
000000000
> > [  513.621319]  </TASK>
> >=20
> > When entering the low level entry code from the out-of-band stage
> > the in-band IRQ state was changed. That is now avoided by calling
> > syscall_enter_from_user_enable_irqs() as all other entry points do.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  arch/x86/entry/common.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> > index 467e2511df2e..13589f1ca89b 100644
> > --- a/arch/x86/entry/common.c
> > +++ b/arch/x86/entry/common.c
> > @@ -259,7 +259,7 @@ __visible noinstr void do_int80_emulation(struct pt=
_regs *regs)
> > =20
> >  	nr =3D syscall_32_enter(regs);
> > =20
> > -	local_irq_enable_full();
> > +	syscall_enter_from_user_enable_irqs();
> >  	nr =3D syscall_enter_from_user_mode_work(regs, nr);
> > =20
> >  	if (dovetailing()) {
>=20
> So, the subject strongly suggests the issue was not present in 5.10 and
> 5.15, but just to be sure: Is that correct?

Yep.=20

be5341eb ("x86/entry: Convert INT 0x80 emulation to IDTENTRY") is the
main reason behind the scenes. This was backported to 6.x only. 5.x is
not affected.

>=20
> Thanks,
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

