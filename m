Subject: Re: [Xenomai-help] xenomai on blackfin/uclinux does not compile
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20070108162216.GD23411@domain.hid>
References: <20070108162216.GD23411@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 08 Jan 2007 19:20:06 +0100
Message-Id: <1168280406.27800.16.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kai Timmer <email@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2007-01-08 at 17:22 +0100, Kai Timmer wrote:
> Hello,
> it tried to compile xenomai 2.3.0 with the uClinux 2006R1 RC2 Release
> for a Blackfin (BF537). The kernel patch i used was the=20
> adeos-ipipe-R06R1RC2-bf53x-1.4-03.patch file. It applied fine to the
> source tree.
> But now if i=B4going to compile the uClinux distribution i always get t=
his
> error:

We are still tracking a moving target on Blackfin, and 2.3 has been
ported to the project's CVS head which defines the missing symbols.
Please use ksrc/arch/blackfin/ipipe-bf53x-CVS-20061215-1.6-00 over a
kernel extracted from the Blackfin CVS/SVN as of this date instead.
Actually, 1.4-03 should have been removed from the patch series.

>=20
> /----------------------------------------------------------------------=
--
> kernel/built-in.o: In function `xntimer_do_tick_aperiodic':
> kernel/xenomai/nucleus/timer.c:(.text+0x24244): undefined reference to
> `bfin_write_TCOUNT'
> kernel/xenomai/nucleus/timer.c:(.text+0x2424c): undefined reference to
> `bfin_write_TCNTL'
> kernel/built-in.o: In function `xntimer_do_start_aperiodic':
> kernel/xenomai/nucleus/timer.c:(.text+0x24a42): undefined reference to
> `bfin_write_TCOUNT'
> kernel/xenomai/nucleus/timer.c:(.text+0x24a4a): undefined reference to
> `bfin_write_TCNTL'
> kernel/built-in.o: In function `xntimer_do_stop_aperiodic':
> kernel/xenomai/nucleus/timer.c:(.text+0x24dde): undefined reference to
> `bfin_write_TCOUNT'
> kernel/xenomai/nucleus/timer.c:(.text+0x24de6): undefined reference to
> `bfin_write_TCNTL'
> arch/blackfin/xenomai/built-in.o: In function `rthal_timer_release':
> (.text+0x2b4): undefined reference to `bfin_write_TCNTL'
> arch/blackfin/xenomai/built-in.o: In function `rthal_timer_request':
> (.text+0x2ee): undefined reference to `bfin_write_TCNTL'
> arch/blackfin/xenomai/built-in.o: In function `rthal_timer_request':
> (.text+0x2f6): undefined reference to `bfin_write_TSCALE'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make[1]: Leaving directory
> `/home/kai/workspace/studium/praktika/dspschool/uClinux-dist/linux-2.6.=
x'
> make: *** [linux] Error 1
> /----------------------------------------------------------------------=
--
>=20
> I also tried to apply the xenomai patches to uClinux 2006R2 RC2. But
> all of the included patchfiles failed to apply.
>=20
> I would be very pleased if someone can tell me whats going wrong.
>=20
> Greets,
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



