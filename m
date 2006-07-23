Subject: Re: [Xenomai-core] [BUG] x86 TSC emulation broken
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44C3E17C.2050906@domain.hid>
References: <44C3B1DB.2040807@domain.hid> <1153686507.8053.9.camel@domain.hid>
	<44C3E17C.2050906@domain.hid>
Content-Type: text/plain
Date: Sun, 23 Jul 2006 23:22:12 +0200
Message-Id: <1153689732.8053.32.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Sun, 2006-07-23 at 22:52 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Sun, 2006-07-23 at 19:28 +0200, Jan Kiszka wrote:
> >> Hi,
> >>
> >> I happened to switch on some CPU type that enabled the Xenomai's TSC
> >> emulation code. The result was an ugly lock-up: endless loop in the
> >> timer IRQ handler.
> >>
> >> The reason: the TSC emulation collides with the VT sound output / the PC
> >> speaker driver. Over 2.6, one can easily avoid this my switching off
> >> CONFIG_INPUT_PCSPKR. 2.4 requires to export and than manipulate
> >> kb_mksound (the pointer to the sound gen*
> >> erating code).
> > 
> > There is an issue in the Adeos 2.4 patch (1.2-05) which is not
> > preventing the kernel from poking into the 8254 registers to determine
> > the current time offset.
> 
> But the TSC emulation itself is not an Adeos service. Shouldn't it be
> better moved?

Unfortunately, we can't do that. The relevant code is in
arch/i386/kernel/time.c, do_slow_gettimeoffset(), you just can't
abstract this from the kernel sanely. It's a recurring issue with any
Adeos port over x86, and this got more complex with 2.6.

Btw, it's not an emulation issue that Adeos processes that way, it's
about dealing with the true owner of the PIT - as a non-virtualizable
resource -, i.e. Linux, or some domain above it. When Linux does not
"own" the PIT, it should refrain from touching it, period; and that's
what this code actually ensures. This is consistent with
ipipe_tune_timer(), which on some archs, is even used to tell Linux that
some domain is grabbing the timer for its own use (e.g. ia64).

>  Then I would happily leave it up to you. :)

I've a fix pending for the do_slow_gettimeofset() issue in 2.4 (2.6 is
fine). Adeos could export kd_mksound too, even if it's a terminally ugly
way of fixing this, but I have no better approach at hand.

> > 
> >> The latter pointer rang some bell. I once fixed a broken RTAI build due
> >> to that code. So I pulled out vulcano and actually found the related
> >> code + an extension of the original ipipe patch to export kb_mksound. I
> >> guess it would have been too complicated for Paolo to explain the reason
> >> of this export to us...
> >>
> >> Anyway, this digging revealed another potential breakage in the
> >> emulation code: RTAI takes care to read the emulated TSC at least once
> >> per 50 ms, to avoid overflows I assume. Xenomai does not.
> > 
> > Mm, through the host timer service, it should at least each 10ms period.
> 
> Yeah, true. I probably got blinded by the existing RTAI code.

I recall having once thoroughly debugged the non-TSC case circa fusion
0.6.4 or so, this is why I'm relatively confident that we should be able
to reactivate such support without too much burden. It's confined in the
HAL, so the impact on the rest of the code is minimal.

>  There is
> just the likely theoretical case that there is no host tick (LAPIC +
> emulated TSC? Not configurable, is it?).
> 

Nope; in the LAPIC case, the hw must provide a TSC anyway.

> Jan
> 
-- 
Philippe.



