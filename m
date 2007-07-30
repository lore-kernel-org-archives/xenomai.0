Message-ID: <46ADC051.7020608@domain.hid>
Date: Mon, 30 Jul 2007 12:41:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <e39c9190707291316l237d572btd75f570d39ab75e@domain.hid>
In-Reply-To: <e39c9190707291316l237d572btd75f570d39ab75e@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig322110002548DE11C52E1005"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] RTDM driver hints
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: juanba romance <juanba.romance@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig322110002548DE11C52E1005
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

juanba romance wrote:
> Hello all, i am re-writing a old linux driver which i did myself some
> time ago, cause i am in charge to provide a RT system framework. This
> is one of the first steps so i have followed the RTDM model to do the
> stuff.
> Now i also have enough time to change its ugly capabilities/defects
> but i am a little stuck right now..
>=20
> I would like to improve my previous design fully buffering the
> incoming user data flow on write method so a input FIFO it's planned.
> The FIFO will be emptied using a rt-task created from the "open"
> procedure and signalled from the "write" method before the user flow
> exit. The point is:
> where the FIFO handler references should be defined ?
>=20
> I have take a look to the serial driver 16550 and my code is really
> biased by its data device definition strategy ( obviously this is my
> first RTDM monster ;-) and i need some guide ), instead of my
> proposal, its design empty the TX FIFO from the IRQ service stuff
> where the user context was passed as argument at the "open" call, so
> all the parts are softly linked..
>=20
> I would prefer to add the above program capability to avoid rewrite as
> much as possible the current ISR symbol.
> but i don't know the beast strategy to be applied to overcome the .
>=20
> I have pass the "context" field dev_private area pointer to the
> rt_task "by hand" but its value is really weird. Should this kind of
> information be defined globally trough the "static" stuff and pass
> this argument to the rt_task_init symbol

Before going into details on how to pass references between driver tasks
etc.:

Why do you want to establish a dedicated task for transmission? Is the
job you have to perform there too heavy for IRQ context? Keep in mind
that such a task requires additional management (assign reasonable
priorities e.g.) and adds further latencies. It's no magic bullet, but
it may be appropriate if there is actually a lot of work to do that
shall not block other, more important jobs.

Jan


--------------enig322110002548DE11C52E1005
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGrcBRniDOoMHTA+kRAv78AJsEuKcjnnHjZ/t7NSbnqp//BhWfKACfaWjY
rxce53XL9mrmvao3w4/JEsQ=
=i6e+
-----END PGP SIGNATURE-----

--------------enig322110002548DE11C52E1005--

