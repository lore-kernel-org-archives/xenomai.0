Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366373D648A
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783462712; cv=none; b=s7wzlRJSQ09K9C3AIi0fEM3hWYukrPVVV07f788SM5zvUwbap73aaxiQ8ZDcudP7fwhChHBQunuOm0IhshB2xCkAWbj/k5OYXvTYtJs7/5/thcWqIpr1u7Ul2WpQtLl1GbXjj53Osc9tGjFNOqwYpsPW85iVcUEHPJbsP0KuABk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783462712; c=relaxed/simple;
	bh=lzAeMmFO8xmYJgs7H2VeLRANJ45G7E0qjEepsIT01q8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KImj5fY3vgCXwnGsO7GG36KbxwARMOU2hsw9emCSe0Ji9MN9d9+EbSFpfYsUPkt2pcA9nLx6mVfy8jki6inhuiCDR4aSBvB9C+VQsCL91puUQ4NA80uElgZmYFLdndK5FKJKpTkYBF+suUl9zWJfxLiNg4wG/XCHGxQbRvfjw18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=SMLGG+++; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="SMLGG+++"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260707221818ba4fd6ad510002078f
        for <xenomai@lists.linux.dev>;
        Wed, 08 Jul 2026 00:18:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=bEsd4xf6dLNTqY+dllMy4XYcENvaDiq0Y6gZtVQQA/k=;
 b=SMLGG+++irf1TX++fOXM+KyKIRgB+y8NwzMj1LQizr13pyCcOGyPk9v2hPbxmBr7kC0BRy
 B2+WKk446gYnHC7L1bVoU8TLV6QzU9H/Hl5aK7Hc+aLKp37KTe6bohkgrmCkdi6AYmfuOxy1
 PMJVXg1kG4v0D8OQoFXfghSSJvMzbEunQbpHc80RPE7o7Rd+243tTjCs3SG7h5NeEbROMsfC
 8qwVJyRwy0M4WnFVLE85TqBMXN3sWd2BRLHa1PIcPtrNYDFyCM3jQ9/YNGE1LQIH+K6Fp0c8
 n3bwK3OOJTze+leEeha7vIWgb7s4bHAr66h3IPt+IUz3AiRN0JFWe0Aw==;
Message-ID: <df451d92ebfd185c10095a5635b44b150a1786de.camel@siemens.com>
Subject: Re: [PATCH dovetail v9 11/11] riscv: dovetail: add core support
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, rpm@xenomai.org
Cc: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Date: Wed, 08 Jul 2026 00:18:18 +0200
In-Reply-To: <dd6f0c05-ae5f-4e2c-a96e-d476168907fc@siemens.com>
References: <20260703152738.129122-1-tobias.schaffner@siemens.com>
	 <20260703152738.129122-12-tobias.schaffner@siemens.com>
	 <60e6a386a564780148293e3b47692d636e91ba2f.camel@siemens.com>
	 <dd6f0c05-ae5f-4e2c-a96e-d476168907fc@siemens.com>
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

On Mon, 2026-07-06 at 19:16 +0200, Tobias Schaffner wrote:
> On 7/6/26 17:06, Florian Bezdeka wrote:
> > On Fri, 2026-07-03 at 17:27 +0200, Tobias Schaffner wrote:
> > > @@ -359,6 +391,15 @@ void do_trap_ecall_u(struct pt_regs *regs)
> > >  =20
> > >   		syscall =3D syscall_enter_from_user_mode(regs, syscall);
> > >  =20
> > > +		if(dovetailing()) {
> >=20
> > checkpatch:
> >=20
> > ERROR: space required before the open parenthesis '('
> > #1426: FILE: arch/riscv/kernel/traps.c:394:
> > +		if(dovetailing()) {
> >=20
> >=20
> > Please double check checkpatch output for the complete series, there
> > seems room for improvement.
>=20
> Ah... That's the only checkpatch comlain. I will send a new version.

Looking at the complete series there is more...

The most important ones (on v10):

WARNING: function definition argument 'struct pt_regs *' should also
have an identifier name
#271: FILE: arch/riscv/include/asm/irq_pipeline.h:131:
+extern void (*handle_arch_irq)(struct pt_regs *);

WARNING: Missing a blank line after declarations
#682: FILE: arch/riscv/kernel/traps.c:455:
+	struct pt_regs *old_regs =3D set_irq_regs(regs);
+	handle_arch_irq(regs);

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#1174: FILE: arch/riscv/include/asm/dovetail.h:1:
+/*

WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
#1175: FILE: arch/riscv/include/asm/dovetail.h:2:
+* SPDX-License-Identifier: GPL-2.0

WARNING: Block comments should align the * on each line
#1175: FILE: arch/riscv/include/asm/dovetail.h:2:
+/*
+* SPDX-License-Identifier: GPL-2.0

Any reasons why you didn't address all those further warnings?

Btw: Line numbers above relate to a one-series mailbox file compiled by
b4:=20

b4 am <your-message-id-from-the-list>
scripts/checkpatch <generated.mbox>

>=20
> > > +			if (syscall =3D=3D EXIT_SYSCALL_OOB) {
> > > +				hard_local_irq_disable();
> > > +				return;
> > > +			}
> > > +			if (syscall =3D=3D EXIT_SYSCALL_TAIL)
> > > +				goto done_inband;
> > > +		}
> > > +
