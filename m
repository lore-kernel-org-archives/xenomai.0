Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07232F44
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657994; cv=none; b=NEFA6GVBEe8jcw1gVdtHBgcfiFFi66Me9SBK69++ATquVnEFNSw//JTQeAo2612GdzZ+kTupQs/fYee192usy7FFbMADzoSsWemf1yLNhWRpSb1+rzrRaHkL34/7hxGRz5EDUuOh1WOej5nyh/32YxSMFevGquUB3Fm2RDZjmxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657994; c=relaxed/simple;
	bh=Jvxl0xsQ7rTW3ENCfd9upweWryezmCXro1LYhq6/jik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pwcMqNqcYwwYdU1Z9HymmSGSwXpB9g1Yt+RGrNxCWPNuqDqe11Rs8gUu8KguEpNsWUxVhYGA6c17eqShBYPDWAyutO9c8p2mhmCjtYOCF3wKiHbzY5hRnwIZ5+pBjYn5GXEOARqKKpi4DIQx/OYWv6vQlNPyWtLAx5yC3uHhD3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=X3OF2irU; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="X3OF2irU"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20241011144626f30dba2b4d0455c0c5
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 16:46:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=g74Kttl+mZOpinSkCWPQ64u+96+gnI8Ec68lxOiNEnY=;
 b=X3OF2irUyJzIU9J27Vb0B+fALiaRuNdK/5cVp7OrZBK6KiqC8ca/s6QGrfw7FmrGipvyBW
 nHqThjP/3unFFbhOqJTxNUKBi6/gxOiUweLEKvUGRQ/Z26ata4usQzJOmfniiNbqQxxhbYbf
 v2mBlKpIKX9fLQKviK135S2h2FcjikYeMQNaclNj9vmc5ekAeOK9Xp3QZeKcdaLnNZMozqcG
 RWYly8+/o2CVrm7rZ/VptqzOFuPmnYIS1P0YlMpdAmrOIpyn6jW6COn++9J2In9GI3lAAfLH
 3wiqJzxJe4Uqk77Gmy9vPQ3eJg45fhoEePh37zPxZ+X68Lb28DX2obog==;
Message-ID: <5283127a991ae241c18f0540e2cb9edafeb8de45.camel@siemens.com>
Subject: Re: [PATCH dovetail 6.x] x86: dovetail: Fix inband IRQ state
 corruption on out-of-band compat syscall
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Date: Fri, 11 Oct 2024 16:46:25 +0200
In-Reply-To: <5d65f813-3b5e-4dd4-8665-83d1af64a23f@siemens.com>
References: <20241010154421.23303-1-florian.bezdeka@siemens.com>
	 <87frp4aqmu.fsf@xenomai.org>
	 <20e035c9f61263d0085d6dae2d93829ee575b87e.camel@siemens.com>
	 <87v7xy7lwm.fsf@xenomai.org>
	 <5d65f813-3b5e-4dd4-8665-83d1af64a23f@siemens.com>
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

On Fri, 2024-10-11 at 16:36 +0200, Jan Kiszka wrote:
> On 11.10.24 16:29, Philippe Gerum wrote:
> > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> >=20
> > > On Thu, 2024-10-10 at 18:07 +0200, Philippe Gerum wrote:
> > > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > > >=20
> > > > > The following kernel splat was found when running the Xenomai 3
> > > > > testsuite in compat on dovetail enabled kernels:
> > > > >=20
> > > > > [  513.620975] IRQ pipeline: some code running in oob context 'Xe=
nomai'
> > > > >                              called an in-band only routine
> > > > > [  513.620998] CPU: 0 PID: 510 Comm: smokey Not tainted 6.10.0+ #=
76
> > > > > [  513.621003] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)=
, BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > > > [  513.621005] IRQ stage: Xenomai
> > > > > [  513.621007] Call Trace:
> > > > > [  513.621011]  <TASK>
> > > > > [  513.621015]  dump_stack_lvl+0x6f/0xd0
> > > > > [  513.621202]  __inband_irq_enable+0xb/0x60
> > > > > [  513.621249]  do_int80_emulation+0x68/0x160
> > > > > [  513.621265]  asm_int80_emulation+0x1a/0x20
> > > > > [  513.621285] RIP: 0023:0xf7f692ba
> > > > > [  513.621288] Code: Unable to access opcode bytes at 0xf7f69290.
> > > > > [  513.621303] RSP: 002b:00000000ffeedf40 EFLAGS: 00000282 ORIG_R=
AX: 0000000000000127
> > > > > [  513.621307] RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 0=
0000000ffeedfa0
> > > > > [  513.621309] RDX: 0000000000088000 RSI: 0000000000000000 RDI: 0=
0000000f7f7aff4
> > > > > [  513.621311] RBP: 00000000ffeedf88 R08: 0000000000000000 R09: 0=
000000000000000
> > > > > [  513.621313] R10: 0000000000000000 R11: 0000000000000246 R12: 0=
000000000000000
> > > > > [  513.621315] R13: 0000000000000000 R14: 0000000000000000 R15: 0=
000000000000000
> > > > > [  513.621319]  </TASK>
> > > > >=20
> > > > > When entering the low level entry code from the out-of-band stage
> > > > > the in-band IRQ state was changed. That is now avoided by calling
> > > > > syscall_enter_from_user_enable_irqs() as all other entry points d=
o.
> > > > >=20
> > > > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > > > ---
> > > > >  arch/x86/entry/common.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> > > > > index 467e2511df2e..13589f1ca89b 100644
> > > > > --- a/arch/x86/entry/common.c
> > > > > +++ b/arch/x86/entry/common.c
> > > > > @@ -259,7 +259,7 @@ __visible noinstr void do_int80_emulation(str=
uct pt_regs *regs)
> > > > > =20
> > > > >  	nr =3D syscall_32_enter(regs);
> > > > > =20
> > > > > -	local_irq_enable_full();
> > > > > +	syscall_enter_from_user_enable_irqs();
> > > > >  	nr =3D syscall_enter_from_user_mode_work(regs, nr);
> > > > > =20
> > > > >  	if (dovetailing()) {
> > > >=20
> > > > Ack. Merged into 6.1.y, 6.6.y and 6.11, dovetail and evl trees.
> > >=20
> > > Philippe, I have to apologize. The patch is correct for 6.11, but not
> > > for the older ones. syscall_enter_from_user_enable_irqs() does not
> > > exist in those branches.
> > >=20
> > > I have to check why the build error was not properly detected on my
> > > end. Can't tell yet...
> > >=20
> > > I will work on backports, meanwhile you should drop it from 6.6 and
> > > 6.1. Thanks, and sorry.
> > >=20
> >=20
> > As Jan pointed out, your patch is fine for all 6.x so far, this helper
> > appears inline upstream in some header only after 6.6.
> >=20
>=20
> I think the issue is that, depending on some compiler settings, the
> function may or may not found. It is static inline only for
> kernel/entry/common.c, thus indeed naturally invisible for
> arch/x86/entry/common.c.
>=20
> ../arch/x86/entry/common.c: In function =E2=80=98do_int80_emulation=E2=80=
=99:
> ../arch/x86/entry/common.c:213:2: error: implicit declaration of
> function =E2=80=98syscall_enter_from_user_enable_irqs=E2=80=99; did you m=
ean
> =E2=80=98syscall_enter_from_user_mode_work=E2=80=99? [-Werror=3Dimplicit-=
function-declaration]
>   syscall_enter_from_user_enable_irqs();
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   syscall_enter_from_user_mode_work
> cc1: some warnings being treated as errors
>=20
> Jan

Close... It moved from kernel/entry/common.c to include/linux/entry-
common.h in newer releases. That's why it's visible.

Seems we have to do the same in a backport...

Florian

>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

