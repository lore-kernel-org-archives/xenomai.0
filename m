Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F4F63A3
	for <xenomai@lists.linux.dev>; Tue, 29 Aug 2023 07:52:52 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230829074243882f277e6afcb4e847
        for <xenomai@lists.linux.dev>;
        Tue, 29 Aug 2023 09:42:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Hl7KmmoVSBxSP2NWUHFi1zOJx8BYZJinKbV2Ts4F52g=;
 b=eFFh6Abe3adOCO9exWIcrqFbRB77aIHdIxjIpnosz4HEFuEE44z+zF4LG6Xmper4oCmx/v
 X8woLbt5oT58PXwf3q8+1JswGwMe+0ysgRAhuD1RbPIkcRiqeKy4EdaTTGPLixbEUTRebbST
 GJcxPlBeI5AaVIF+WWMNk4AgHKilE=;
Message-ID: <618b6fc31635f1227270790282a02eaba3a02f38.camel@siemens.com>
Subject: Re: [PATCH] arm64: dovetail: Fix undefinstr/break trap handling
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev, Clara Kowalsky <clara.kowalsky@siemens.com>
Date: Tue, 29 Aug 2023 09:42:41 +0200
In-Reply-To: <87sf83ky7h.fsf@xenomai.org>
References: <20230825125844.588598-1-florian.bezdeka@siemens.com>
	 <ec37174a-39fe-44c7-82a9-342b95682f81@siemens.com>
	 <92c6af9151c4b3d2a1737484487ff1ea55e5f131.camel@siemens.com>
	 <9cd49fec-3f65-47c9-91cc-d13754e29d94@siemens.com>
	 <87sf83ky7h.fsf@xenomai.org>
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

On Mon, 2023-08-28 at 16:36 +0200, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
>=20
> > On 28.08.23 14:52, Florian Bezdeka wrote:
> > > On Mon, 2023-08-28 at 14:33 +0200, Jan Kiszka wrote:
> > > > On 25.08.23 14:58, Florian Bezdeka wrote:
> > > > > When running an compat RT application on arm64 the break trap is
> > > > > handled via the undefined instruction trap.
> > > > >=20
> > > > > A possible call stack looks like this:
> > > > >=20
> > > > > Call trace:
> > > > >   handle_inband_event+0x2d0/0x320
> > > > >   inband_event_notify+0x28/0x50
> > > > >   signal_wake_up_state+0x7c/0xa4
> > > > >   complete_signal+0x104/0x2d0
> > > > >   __send_signal_locked+0x1d0/0x3e4
> > > > >   send_signal_locked+0xf0/0x140
> > > > >   force_sig_info_to_task+0xa0/0x164
> > > > >   force_sig_fault+0x64/0x94
> > > > >   arm64_force_sig_fault+0x48/0x80
> > > > >   send_user_sigtrap+0x50/0x8c
> > > > >   aarch32_break_handler+0xac/0x1d0
> > > > >   do_undefinstr+0x6c/0x360
> > > > >   el0_undef+0x4c/0xd0
> > > > >   el0t_32_sync_handler+0xd0/0x140
> > > > >   el0t_32_sync+0x190/0x194
> > > > >=20
> > > > > The trap is never reported to the companion core at that stage so
> > > > > running_oob() in do_undefinstr() will always return true. As the
> > > > > following bailout happens before calling the compat breakpoint
> > > > > detection (aarch32_break_handler()) debugging the compat=20
> > > > > application does not work.
> > > > >=20
> > > > > In addition aarch32_break_handler() has to report the trap entry =
to the
> > > > > companion core.
> > > > >=20
> > > > > Reported-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> > > > > Tested-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> > > > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > > > ---
> > > > >  arch/arm64/kernel/debug-monitors.c | 3 +++
> > > > >  arch/arm64/kernel/traps.c          | 7 -------
> > > > >  2 files changed, 3 insertions(+), 7 deletions(-)
> > > > >=20
> > > > > diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kern=
el/debug-monitors.c
> > > > > index 32271ed24ef5..ef7ac042a0a6 100644
> > > > > --- a/arch/arm64/kernel/debug-monitors.c
> > > > > +++ b/arch/arm64/kernel/debug-monitors.c
> > > > > @@ -373,7 +373,10 @@ int aarch32_break_handler(struct pt_regs *re=
gs)
> > > > >  	if (!bp)
> > > > >  		return -EFAULT;
> > > > > =20
> > > > > +	mark_trap_entry(ARM64_TRAP_UNDI, regs);
> > > > >  	send_user_sigtrap(TRAP_BRKPT);
> > > > > +	mark_trap_exit(ARM64_TRAP_UNDI, regs);
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > >  NOKPROBE_SYMBOL(aarch32_break_handler);
> > > > > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.=
c
> > > > > index cc68be400244..9bf2f309248f 100644
> > > > > --- a/arch/arm64/kernel/traps.c
> > > > > +++ b/arch/arm64/kernel/traps.c
> > > > > @@ -489,13 +489,6 @@ void arm64_notify_segfault(unsigned long add=
r)
> > > > > =20
> > > > >  void do_undefinstr(struct pt_regs *regs, unsigned long esr)
> > > > >  {
> > > > > -	/*
> > > > > -	 * If the companion core did not switched us to in-band
> > > > > -	 * context, we may assume that it has handled the trap.
> > > > > -	 */
> > > > > -	if (running_oob())
> > > > > -		return;
> > > > > -
> > > > >  	/* check for AArch32 breakpoint instructions */
> > > > >  	if (!aarch32_break_handler(regs))
> > > > >  		return;
> > > >=20
> > > > This is not against v6.5-dovetail-rebase, right? We likely need to =
start
> > > > from the top, then backport to stable.
> > >=20
> > > That applied for 6.1 and all other (lower) versions that are currentl=
y
> > > covered by our CI. Might need some lifting for 6.5, didn't check yet.
> > >=20
> > > >=20
> > > > Also note that this change came in via
> > > > https://source.denx.de/Xenomai/linux-dovetail/-/commit/2b2ccdaeb811=
6727cf4076960d664a3cedff0ac6,
> > > > so just dropping it will likely cause problems elsewhere. Should we
> > > > rather move that down in the handler?
> > >=20
> > > Well, as written in the commit message running_oob() will always retu=
rn
> > > true for RT tasks so I'm quite sure that the invalid instruction
> > > handling was broken on arm64 for some time now. We bailed out even
> > > before sending the notification to the companion core.
> > >=20
> > > Moving it down might fix the compat case but native arm64 would stay
> > > broken. No?
> > >=20
> >=20
> > Something looks still fishy, either in the original patch that
> > introduced the condition (I still don't get that special case) or now
> > with this change trying to restore things. I agree that also the
> > original change needed the notification to be delivered.
> >=20
> > Philippe, can you help clarifying the logic behind
> > do_undefinstr/do_el0_undef?
> >=20
>=20
> This very much looks like an unfortunate attempt to mimic the arm32
> logic, which does notify the core about the undefined insn trap prior to
> calling do_undefinstr() (und_fault from the asm entry code).
>=20
> So Florian is right, this should not apply to the arm64 side because
> unlike arm32, we need to wait until all branches which might be able to
> handle this fault directly from oob are considered
> (e.g. try_emulate_mrs()), before assuming that we might need the core to
> switch us in-band. IOW, do_el0_undef() is broken since it wrongly
> assumes that such switch might already have happened on entry. As a
> matter of fact, it did not for a reason.
>=20
> I see another issue hiding in the dark: emulation of the deprecated
> armv8 SWP{B} instruction cannot be done from the oob stage.  So in
> addition to fixing the aarch32 break handler, I would notify the core
> before handling the CONDTEST_PASS case as well (bluntly disabling
> all emulations from the oob stage entirely seems wrong ATM).

So it seems we are on the same page now, that's great.

To sum up: my "backport" is missing the armv8 SWP{B} part and we still
lack a fix for recent dovetail versions.

Who will write the necessary fixes? Philippe, could you jump on that?

Best regards,
Florian

>=20
> --=20
> Philippe.

