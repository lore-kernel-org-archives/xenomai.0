Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D0BA58
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 13:33:34 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E82611C000D;
	Fri,  1 Sep 2023 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1693575212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qhixd4HEIHo7nCqUTZe/2wTZCJ45SzZpYetBiBpREKc=;
	b=c4MFYyXt0RUszpAqE3EpCBWbGUE8sQe2cQQFCDGt7IofxjkiQ0yx2ckMjF17aegdWpqjmV
	EvecD0+q+RNDfV7t9NxP3AsGf2msNvXGCm8lPOhlXEwRKfYjR0lu9KNLoKwgSvpwzxpQcw
	LtzmtOmblwjizs0FytsAgRFC8ra9GkQkvze6sWwBJhbI5vE8wH+4kAOsmRDXfZI0g67/Qr
	gpLUWYiSyaWsaIx1xmsyMweJ1wXIc4txWVykuT/knqrM11nfDwzRP7fEf3KXmMimD2wRia
	aOGSwkLgIJAYv2KUSI5+W64IvIkZDpVUt3wVRsoB8T8t7aUUlwd3dZPI1ln2jg==
References: <20230825125844.588598-1-florian.bezdeka@siemens.com>
 <ec37174a-39fe-44c7-82a9-342b95682f81@siemens.com>
 <92c6af9151c4b3d2a1737484487ff1ea55e5f131.camel@siemens.com>
 <9cd49fec-3f65-47c9-91cc-d13754e29d94@siemens.com>
 <87sf83ky7h.fsf@xenomai.org>
 <618b6fc31635f1227270790282a02eaba3a02f38.camel@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev, Clara
 Kowalsky <clara.kowalsky@siemens.com>
Subject: Re: [PATCH] arm64: dovetail: Fix undefinstr/break trap handling
Date: Fri, 01 Sep 2023 15:29:50 +0200
In-reply-to: <618b6fc31635f1227270790282a02eaba3a02f38.camel@siemens.com>
Message-ID: <87edjiuifo.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Mon, 2023-08-28 at 16:36 +0200, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>> > On 28.08.23 14:52, Florian Bezdeka wrote:
>> > > On Mon, 2023-08-28 at 14:33 +0200, Jan Kiszka wrote:
>> > > > On 25.08.23 14:58, Florian Bezdeka wrote:
>> > > > > When running an compat RT application on arm64 the break trap is
>> > > > > handled via the undefined instruction trap.
>> > > > > 
>> > > > > A possible call stack looks like this:
>> > > > > 
>> > > > > Call trace:
>> > > > >   handle_inband_event+0x2d0/0x320
>> > > > >   inband_event_notify+0x28/0x50
>> > > > >   signal_wake_up_state+0x7c/0xa4
>> > > > >   complete_signal+0x104/0x2d0
>> > > > >   __send_signal_locked+0x1d0/0x3e4
>> > > > >   send_signal_locked+0xf0/0x140
>> > > > >   force_sig_info_to_task+0xa0/0x164
>> > > > >   force_sig_fault+0x64/0x94
>> > > > >   arm64_force_sig_fault+0x48/0x80
>> > > > >   send_user_sigtrap+0x50/0x8c
>> > > > >   aarch32_break_handler+0xac/0x1d0
>> > > > >   do_undefinstr+0x6c/0x360
>> > > > >   el0_undef+0x4c/0xd0
>> > > > >   el0t_32_sync_handler+0xd0/0x140
>> > > > >   el0t_32_sync+0x190/0x194
>> > > > > 
>> > > > > The trap is never reported to the companion core at that stage so
>> > > > > running_oob() in do_undefinstr() will always return true. As the
>> > > > > following bailout happens before calling the compat breakpoint
>> > > > > detection (aarch32_break_handler()) debugging the compat 
>> > > > > application does not work.
>> > > > > 
>> > > > > In addition aarch32_break_handler() has to report the trap entry to the
>> > > > > companion core.
>> > > > > 
>> > > > > Reported-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>> > > > > Tested-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>> > > > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> > > > > ---
>> > > > >  arch/arm64/kernel/debug-monitors.c | 3 +++
>> > > > >  arch/arm64/kernel/traps.c          | 7 -------
>> > > > >  2 files changed, 3 insertions(+), 7 deletions(-)
>> > > > > 
>> > > > > diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
>> > > > > index 32271ed24ef5..ef7ac042a0a6 100644
>> > > > > --- a/arch/arm64/kernel/debug-monitors.c
>> > > > > +++ b/arch/arm64/kernel/debug-monitors.c
>> > > > > @@ -373,7 +373,10 @@ int aarch32_break_handler(struct pt_regs *regs)
>> > > > >  	if (!bp)
>> > > > >  		return -EFAULT;
>> > > > >  
>> > > > > +	mark_trap_entry(ARM64_TRAP_UNDI, regs);
>> > > > >  	send_user_sigtrap(TRAP_BRKPT);
>> > > > > +	mark_trap_exit(ARM64_TRAP_UNDI, regs);
>> > > > > +
>> > > > >  	return 0;
>> > > > >  }
>> > > > >  NOKPROBE_SYMBOL(aarch32_break_handler);
>> > > > > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> > > > > index cc68be400244..9bf2f309248f 100644
>> > > > > --- a/arch/arm64/kernel/traps.c
>> > > > > +++ b/arch/arm64/kernel/traps.c
>> > > > > @@ -489,13 +489,6 @@ void arm64_notify_segfault(unsigned long addr)
>> > > > >  
>> > > > >  void do_undefinstr(struct pt_regs *regs, unsigned long esr)
>> > > > >  {
>> > > > > -	/*
>> > > > > -	 * If the companion core did not switched us to in-band
>> > > > > -	 * context, we may assume that it has handled the trap.
>> > > > > -	 */
>> > > > > -	if (running_oob())
>> > > > > -		return;
>> > > > > -
>> > > > >  	/* check for AArch32 breakpoint instructions */
>> > > > >  	if (!aarch32_break_handler(regs))
>> > > > >  		return;
>> > > > 
>> > > > This is not against v6.5-dovetail-rebase, right? We likely need to start
>> > > > from the top, then backport to stable.
>> > > 
>> > > That applied for 6.1 and all other (lower) versions that are currently
>> > > covered by our CI. Might need some lifting for 6.5, didn't check yet.
>> > > 
>> > > > 
>> > > > Also note that this change came in via
>> > > > https://source.denx.de/Xenomai/linux-dovetail/-/commit/2b2ccdaeb8116727cf4076960d664a3cedff0ac6,
>> > > > so just dropping it will likely cause problems elsewhere. Should we
>> > > > rather move that down in the handler?
>> > > 
>> > > Well, as written in the commit message running_oob() will always return
>> > > true for RT tasks so I'm quite sure that the invalid instruction
>> > > handling was broken on arm64 for some time now. We bailed out even
>> > > before sending the notification to the companion core.
>> > > 
>> > > Moving it down might fix the compat case but native arm64 would stay
>> > > broken. No?
>> > > 
>> > 
>> > Something looks still fishy, either in the original patch that
>> > introduced the condition (I still don't get that special case) or now
>> > with this change trying to restore things. I agree that also the
>> > original change needed the notification to be delivered.
>> > 
>> > Philippe, can you help clarifying the logic behind
>> > do_undefinstr/do_el0_undef?
>> > 
>> 
>> This very much looks like an unfortunate attempt to mimic the arm32
>> logic, which does notify the core about the undefined insn trap prior to
>> calling do_undefinstr() (und_fault from the asm entry code).
>> 
>> So Florian is right, this should not apply to the arm64 side because
>> unlike arm32, we need to wait until all branches which might be able to
>> handle this fault directly from oob are considered
>> (e.g. try_emulate_mrs()), before assuming that we might need the core to
>> switch us in-band. IOW, do_el0_undef() is broken since it wrongly
>> assumes that such switch might already have happened on entry. As a
>> matter of fact, it did not for a reason.
>> 
>> I see another issue hiding in the dark: emulation of the deprecated
>> armv8 SWP{B} instruction cannot be done from the oob stage.  So in
>> addition to fixing the aarch32 break handler, I would notify the core
>> before handling the CONDTEST_PASS case as well (bluntly disabling
>> all emulations from the oob stage entirely seems wrong ATM).
>
> So it seems we are on the same page now, that's great.
>
> To sum up: my "backport" is missing the armv8 SWP{B} part and we still
> lack a fix for recent dovetail versions.
>
> Who will write the necessary fixes? Philippe, could you jump on that?
>

Would you submit a consolidated patch against 6.1 or 6.5 which would
include all the bits we have been discussing first? I could pick it from
there and update other branches.

-- 
Philippe.
