Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B561A1EEE6
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655007; cv=none; b=ElZgDAS7l89URENnNIUzX6uiaoZrT2MBdQFHknAg3avGeliddgN3t0AecEuvQh9TT+kZ3OCaVAUIDjj74hp/q6j8UzHTP1LWC92IFUoRNbdQJTLlrPTAd+PHXoIp7wFasHhHlJ5zlLMEkFsHSNEhjXO4CHhpy+gnpnoSq/c/F3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655007; c=relaxed/simple;
	bh=wkny+ZmhvergUGEfMiCL7FHMvHoCjNZ+Ysqe6WjZWis=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qa/r7xnY1dG4W7X8CWg5ZRuAyZ4636DLAEqIn5EBeFcxxNsFN4a81rWQlCeNfRvF2ZPPpXZOAPJVnMNv9PEbp9fvjy/orbMKcs1fFgv3XhpbSwnPn8aHG9rivGc6JwdZXEuQ8yeo9cvskb4CpMjRMp1Ng+Zv1susK3xeasaDLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=hxAPdMlZ; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="hxAPdMlZ"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202410111356405652fdb5d2de5a9d80
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 15:56:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2zipugV13g08YFDd33Kcx5tT5loDLCMN2mDlSi8bVhY=;
 b=hxAPdMlZvtV+xyEZaYPvXHQPik16qZh/XtXYV5bE1kAJNi2012FBtKohekR/aoEwyeSuNR
 Xx/MVouq+eyQycM4mdScxGoO7WEwui7Cx18ZkJ4Pqa2Ih/sVzrAtSzPYCj6VIChqSrYYxPq1
 sRgcrizWIcV57qyY2UmknH57VdQpEiFzg3cw2h6UW2THPrittCAc3nl/lR7CKoHExNnWI5pX
 M1M1lwwXi16OOuWo7oRIj5QSL/6HlJUotTkMVhqQ97afCxed6v2MU9qSThBwt/ruvoXXzEF0
 JSx5TjQ3lZIBTjVjfDE+LMb7K+CAKW2C++ZuH9GdDUtWpxFeGhOcd78w==;
Message-ID: <20e035c9f61263d0085d6dae2d93829ee575b87e.camel@siemens.com>
Subject: Re: [PATCH dovetail 6.x] x86: dovetail: Fix inband IRQ state
 corruption on out-of-band compat syscall
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Date: Fri, 11 Oct 2024 15:56:39 +0200
In-Reply-To: <87frp4aqmu.fsf@xenomai.org>
References: <20241010154421.23303-1-florian.bezdeka@siemens.com>
	 <87frp4aqmu.fsf@xenomai.org>
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

On Thu, 2024-10-10 at 18:07 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
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
> Ack. Merged into 6.1.y, 6.6.y and 6.11, dovetail and evl trees.

Philippe, I have to apologize. The patch is correct for 6.11, but not
for the older ones. syscall_enter_from_user_enable_irqs() does not
exist in those branches.

I have to check why the build error was not properly detected on my
end. Can't tell yet...

I will work on backports, meanwhile you should drop it from 6.6 and
6.1. Thanks, and sorry.

Best regards,
Florian

>=20
> --=20
> Philippe.

