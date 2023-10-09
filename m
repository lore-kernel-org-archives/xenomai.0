Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC5F199B3
	for <xenomai@lists.linux.dev>; Mon,  9 Oct 2023 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="D1P53khj"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2023100913172359c245ebfc6c1ffe95
        for <xenomai@lists.linux.dev>;
        Mon, 09 Oct 2023 15:17:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xqVxFcEYQ0bZ2D0ji3ola9S54dpAw6rC+tBESaNksss=;
 b=D1P53khj8yvNUykbxGvTm+gOWsAgwCblHmV/XgLMVZ2iQRml5b7gTCZ0IVB3tUT27x8wuN
 tflJer4jGtt4fE3XsAo4s8xzhmIED6uu3tU00HLAleGiRYGGiDaUzbgJCtwfA3B5C1t4RBrl
 QB0DDZE0xRun2jwst88QAjDBfcpRg=;
Message-ID: <3b9681c7b077b7a0a282f91c12b6a9cf25699e62.camel@siemens.com>
Subject: Re: [RFC PATCH v2 1/2] arm64: dovetail: Fix undefinstr/break trap
 handling
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>, Clara Kowalsky
	 <clara.kowalsky@siemens.com>, "xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>
Cc: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Date: Mon, 09 Oct 2023 15:17:21 +0200
In-Reply-To: <VE1PR08MB4909ACFB96F3BEBA2D813FD092CEA@VE1PR08MB4909.eurprd08.prod.outlook.com>
References: <20231006104304.3813326-1-clara.kowalsky@siemens.com>
	 <20231006104304.3813326-2-clara.kowalsky@siemens.com>
	 <VE1PR08MB4909ACFB96F3BEBA2D813FD092CEA@VE1PR08MB4909.eurprd08.prod.outlook.com>
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

On Mon, 2023-10-09 at 12:44 +0000, Johannes Kirchmair wrote:
> Hey Clara,
>=20
> > -----Original Message-----
> > From: Clara Kowalsky <clara.kowalsky@siemens.com>
> > Sent: Freitag, 6. Oktober 2023 12:43
> > To: xenomai@lists.linux.dev
> > Cc: jan.kiszka@siemens.com; florian.bezdeka@siemens.com; Clara Kowalsky
> > <clara.kowalsky@siemens.com>
> > Subject: [RFC PATCH v2 1/2] arm64: dovetail: Fix undefinstr/break trap =
handling
> >=20
> > [Sie erhalten nicht h=C3=A4ufig E-Mails von clara.kowalsky@siemens.com.=
 Weitere
> > Informationen, warum dies wichtig ist, finden Sie unter
> > https://aka.ms/LearnAboutSenderIdentification ]
> >=20
> > CAUTION: External E-Mail !
> >=20
> > From: Florian Bezdeka <florian.bezdeka@siemens.com>
> >=20
> > When running an compat RT application on arm64 the break trap is
> > handled via the undefined instruction trap.
> >=20
> > A possible call stack looks like this:
> >=20
> > Call trace:
> >   handle_inband_event+0x2d0/0x320
> >   inband_event_notify+0x28/0x50
> >   signal_wake_up_state+0x7c/0xa4
> >   complete_signal+0x104/0x2d0
> >   __send_signal_locked+0x1d0/0x3e4
> >   send_signal_locked+0xf0/0x140
> >   force_sig_info_to_task+0xa0/0x164
> >   force_sig_fault+0x64/0x94
> >   arm64_force_sig_fault+0x48/0x80
> >   send_user_sigtrap+0x50/0x8c
> >   aarch32_break_handler+0xac/0x1d0
> >   do_undefinstr+0x6c/0x360
> >   el0_undef+0x4c/0xd0
> >   el0t_32_sync_handler+0xd0/0x140
> >   el0t_32_sync+0x190/0x194
> >=20
> > The trap is never reported to the companion core at that stage so
> > running_oob() in do_undefinstr() will always return true. As the
> > following bailout happens before calling the compat breakpoint
> > detection (aarch32_break_handler()) debugging the compat
> > application does not work.
> >=20
> > In addition aarch32_break_handler() has to report the trap entry to the
> > companion core.
> >=20
> > Reported-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> > Tested-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  arch/arm64/kernel/debug-monitors.c | 2 ++
> >  arch/arm64/kernel/traps.c          | 7 -------
> >  2 files changed, 2 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/deb=
ug-
> > monitors.c
> > index 32271ed24ef5..8157496bea62 100644
> > --- a/arch/arm64/kernel/debug-monitors.c
> > +++ b/arch/arm64/kernel/debug-monitors.c
> > @@ -373,7 +373,9 @@ int aarch32_break_handler(struct pt_regs *regs)
> >         if (!bp)
> >                 return -EFAULT;
> >=20
> > +       mark_trap_entry(ARM64_TRAP_UNDI, regs);
> >         send_user_sigtrap(TRAP_BRKPT);
> > +       mark_trap_entry(ARM64_TRAP_UNDI, regs);
> Should this be a mark_trap_exit?

It should (and it was in v1). That means that you manually modified the
patch... Seems like a broken workflow on your end.

>=20
>=20
> >         return 0;
> >  }
> >  NOKPROBE_SYMBOL(aarch32_break_handler);
> > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > index b0db35eda8f5..a8c3642c61dc 100644
> > --- a/arch/arm64/kernel/traps.c
> > +++ b/arch/arm64/kernel/traps.c
> > @@ -456,13 +456,6 @@ void do_el0_undef(struct pt_regs *regs, unsigned l=
ong
> > esr)
> >  {
> >         u32 insn;
> >=20
> > -       /*
> > -        * If the companion core did not switched us to in-band
> > -        * context, we may assume that it has handled the trap.
> > -        */
> > -       if (running_oob())
> > -               return;
> Shouldn't this be moved below the mark_trap_entry?
> If the companion core decides to handle the undefined instructions, we wi=
ll be running_oob after mark_trap_entry and we should not emit an signal in=
 that case.
>=20
> Best regards
> Johannes
> > -
> >         /* check for AArch32 breakpoint instructions */
> >         if (!aarch32_break_handler(regs))
> >                 return;
> > --
> > 2.39.2
> >=20
>=20

