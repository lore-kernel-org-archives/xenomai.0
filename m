Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF79AD38
	for <xenomai@lists.linux.dev>; Mon, 11 Sep 2023 08:52:08 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202309110841423d9d5c5afaf50ad89f
        for <xenomai@lists.linux.dev>;
        Mon, 11 Sep 2023 10:41:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=1Pw84rbKvH9R1IKvYNyUMvfTTRs3rQOQ0qDhq8YNGiU=;
 b=O/Zqe7+iowN8l295Pwu2z0lXnA02HD5az5PiczCYtUxVY0xo3xUb8efba6sQ4EwggZ7u/d
 mdoUBGQU3T3bMj+SLIHMpJrCHBdigtyMAYtfgkG83REDOuldoC2bYbMBPZkDChrL0monDuij
 ZfyGgeqZXqYuumxM12fhWgHfPnhJE=;
Message-ID: <7212c5ca53968beeee4753065fbbb700e1ccdbd6.camel@siemens.com>
Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>, 
	"xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 11 Sep 2023 10:41:41 +0200
In-Reply-To: <VE1PR08MB49094D931267988E377A9A2E92EEA@VE1PR08MB4909.eurprd08.prod.outlook.com>
References: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
	 <d5e43ccdceba5f28de7798c0826318e1bbcfc1d4.camel@siemens.com>
	 <VE1PR08MB49094D931267988E377A9A2E92EEA@VE1PR08MB4909.eurprd08.prod.outlook.com>
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

On Thu, 2023-09-07 at 10:48 +0000, Johannes Kirchmair wrote:
> Hey Florian,
>=20
> > -----Original Message-----
> > From: Florian Bezdeka <florian.bezdeka@siemens.com>
> [...]
> > > +COBALT_SYSCALL32emu(sigaction, current,
> > > +                 (int sig, void __user *handler, void __user *restor=
er))
> > > +{
> > > +     struct cobalt_ppd *sys_ppd =3D cobalt_ppd_get(0);
> > > +
> > > +     if (sig < 0 || sig >=3D _NSIG)
> > > +             return -EINVAL;
> > > +
> > > +     sys_ppd->sighand[sig] =3D handler;
> > > +
> > > +     if (!sys_ppd->sigrestorer)
> > > +             sys_ppd->sigrestorer =3D restorer;
> > > +
> > > +     return 0;
> > > +}
> > > +
> >=20
> > You did not touch the syscall32-table.h (x86 specific), so I would
> > expect that your compat support is broken right now. You should end up
> > in the "native" so x86_64 implementation. That brings me to the next
> > question:
> Checked this and you are right, we end up in the "native" implementation =
of the syscall.
> Will drop the compat syscall.

Fine.

>=20
> >=20
> > Can't we avoid a special compat case here? The pointers themselfs are
> > corrected by the syscall entry machinery but the memory pointed to is
> > not. So is the memory pointed to by handler and restorer different in
> > terms of memory layout/padding?
> We don=E2=80=99t access the memory pointed to from kernel space, so this =
should not be imported or am I missing something?

This is obsolete. We could drop the compat case.

>=20
> >=20
> > In addition you should update kernel/cobalt/trace/cobalt-posix.h to get
> > proper trace support.
> Changed the following define to look like this:
> #define __cobalt_syscall_name(__nr)					\
> 	__print_symbolic((__nr),					\
> 		....
> 		__cobalt_symbolic_syscall(pselect64),			\
> 		__cobalt_symbolic_syscall(sigreturn),			\
> 		__cobalt_symbolic_syscall(sigaction))
>=20
> Is this sufficient or do I have to change something else?

Yes, that should be sufficient.

>=20
> Best regards Johannes
>=20
>=20

