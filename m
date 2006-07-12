Subject: Re: [Xenomai-core] Xenomai on PXA
From: Bart Jonkers <jonkersbart@domain.hid>
In-Reply-To: <1152630145.21591.1.camel@domain.hid>
References: <200607071703.10700.vagninu@domain.hid>
	<17582.50372.830923.414981@domain.hid>
	<44B34343.9F56F13@domain.hid>
	<1152630145.21591.1.camel@domain.hid>
Content-Type: text/plain; charset=utf-8
Date: Wed, 12 Jul 2006 15:13:36 +0200
Message-Id: <1152710016.9488.15.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stelian Pop <stelian.pop@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2006-07-11 at 17:01 +0200, Stelian Pop wrote:
> Le mardi 11 juillet 2006 =C3=A0 08:20 +0200, Detlef Vollmann a =C3=A9cr=
it :
>=20
> > What is missing is a look at entry-macro.S.
> > Stelian Pop has done something for the Integrator that I don't
> > really understand and therefore I can't say whether the PXA needs
> > something similar.
>=20
> Well, you should have asked if you didn't undestand. :)
>=20
> The change in entry-macro.S does optimize the fast path for a timer
> interrupt. Instead of looking at each interrupt controller status and
> compute the irq number the code tests the timer interrupt status and
> returns immediately if true.=20

So this isn't really needed?

Are there other things where I have to take a look to?

I think I have found 2 errors in the code of Detlef Vollmann:
- timer_initialized is never set to 1, so __ipipe_mach_get_tsc will
always return 0. I have set timer_initialized to 1 at the end of
pxa_timer_init.

- __ipipe_mach_set_dec will return without calling
spin_unlock_irqrestore_hw(&timer_lock, flags); when delay < 8

When I use the adaptions of Detlef Vollmann and
adeos-ipipe-2.6.15-arm-1.3-04 Linux doesn't get any interrupts. During
initialization of the hard-disk I get the error 'hda: lost interrupt'.

Somebody an idea?

Bart


>=20
> Stelian.


