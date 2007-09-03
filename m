Message-ID: <46DC7E8F.4000503@domain.hid>
Date: Mon, 03 Sep 2007 23:37:19 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <FDBBB5CC70676540B3EF7CFE83FD94E099942B@EINT11.einet.ad.eivd.ch>	<1188824753.6037.27.camel@domain.hid>
	<FDBBB5CC70676540B3EF7CFE83FD94E0B475ED@EINT11.einet.ad.eivd.ch>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0B475ED@EINT11.einet.ad.eivd.ch>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig30BFCED9C6C8942832AE9F10"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] RE : Activation of IRQ handler in the Linux
	domain
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig30BFCED9C6C8942832AE9F10
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

[Some add-ons to what Philippe already pointed out:]

ROSSIER Daniel wrote:
> ...
> Ok, I totally agree. I've tried to use a rtdm_event object which I've
> declared in the Linux driver side. Then, the write function is called f=
rom a RT task,

That sounds error-prone: Is "write" only called from RT context? Does it
have to synchronise with functions running in non-RT context, and is
this synchronisation done in a RT-safe manner (rtdm_lock_...)? You may
check this offline - or online with CONFIG_IPIPE_DEBUG_CONTEXT.

> then it calls rtdm_event_wait() at a certain point, and the i2c ISR per=
forms a rtdm_event_signal()
> to wake up the RT task. However, I got a kernel crash when rtdm_event_w=
ait() is called.

Sometimes it is helpful to analyse what the crash says precisely, e.g.
at which line of code (during which memory access) the crash happens.
Also, debugging options may help to catch some potential root bug earlier=
=2E

In general, I also smell a bit too much hacking and too less designing
here... ;)

Jan


--------------enig30BFCED9C6C8942832AE9F10
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG3H6QniDOoMHTA+kRAusPAJ0eSixSfsg3lW3rJ58a5wAo5WqxpgCfags+
q/J7A1Pvwrqbfz/WZyFRn4g=
=gT7/
-----END PGP SIGNATURE-----

--------------enig30BFCED9C6C8942832AE9F10--

