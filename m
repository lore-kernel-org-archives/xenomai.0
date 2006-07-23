Subject: Re: [Xenomai-core] [BUG] x86 TSC emulation broken
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44C3B1DB.2040807@domain.hid>
References: <44C3B1DB.2040807@domain.hid>
Content-Type: text/plain
Date: Sun, 23 Jul 2006 22:28:27 +0200
Message-Id: <1153686507.8053.9.camel@domain.hid>
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

On Sun, 2006-07-23 at 19:28 +0200, Jan Kiszka wrote:
> Hi,
> 
> I happened to switch on some CPU type that enabled the Xenomai's TSC
> emulation code. The result was an ugly lock-up: endless loop in the
> timer IRQ handler.
> 
> The reason: the TSC emulation collides with the VT sound output / the PC
> speaker driver. Over 2.6, one can easily avoid this my switching off
> CONFIG_INPUT_PCSPKR. 2.4 requires to export and than manipulate
> kb_mksound (the pointer to the sound gen*
> erating code).

There is an issue in the Adeos 2.4 patch (1.2-05) which is not
preventing the kernel from poking into the 8254 registers to determine
the current time offset.

> 
> The latter pointer rang some bell. I once fixed a broken RTAI build due
> to that code. So I pulled out vulcano and actually found the related
> code + an extension of the original ipipe patch to export kb_mksound. I
> guess it would have been too complicated for Paolo to explain the reason
> of this export to us...
> 
> Anyway, this digging revealed another potential breakage in the
> emulation code: RTAI takes care to read the emulated TSC at least once
> per 50 ms, to avoid overflows I assume. Xenomai does not.

Mm, through the host timer service, it should at least each 10ms period.

> 
> Before spending "some" time on a clean (in contrast to what I just read
> in foreign code...) fix for Xenomai, I would like to cross-check if this
> emulation is still considered useful. No one seems to use it, otherwise
> we should have received complaints much earlier.
> 
> Fix it or drop it?
> 
> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



