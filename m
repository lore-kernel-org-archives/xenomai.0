Message-ID: <44035219.1020302@domain.hid>
Date: Mon, 27 Feb 2006 20:25:13 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0602270656m4719d6aes@domain.hid>
In-Reply-To: <b647ffbd0602270656m4719d6aes@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7EC18E9898E9F40D867D6863"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [PATCH] Shared interrupts (yet another movie :)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7EC18E9898E9F40D867D6863
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> Hi there,
>=20
> I have explicitly cc'ed Gilles as this patch affects the posix skin.
>=20
> In the light of the recent discussions, the AUTOENA flag has been conve=
rted
> to NOAUTOENA and the IRQ line is re-enabled on return from
> xnintr_irq_handler() and shirq brothers by default.
> Also XN_ISR_CHAINED -> XN_ISR_PROPAGATE.
>=20
> I'm still not sutisfied with results, namely - return values of ISR. Bu=
t,
> well, this is a quite separate question to the shirq support so the lat=
er
> one should not remain in pending status only because of that.
>=20
> I still would like to see something along scalar values : NONE, HANDLED=
,
> PROPAGATE and xnintr_disable() being called in ISR to defer IRQ line
> enabling (not .ending -> PROPAGATE does it).
> (*)
>=20
> Currently, there is a XN_ISR_NOENABLE bit which asks the real-time laye=
r to
> defer the IRQ line, Warning!, .ending (and not just enabling) until lat=
er.
> In common case, xnarch_end_irq() must be called by the rt_task that sta=
nds
> for a bottom half (and not just xnintr_enable() - this may not work on =
ppc).
> This adds a bit of confusion and we will avoid it with (*) scheme. So t=
his
> is a subject to change in the future.
> As I pointed out in another message, the implementation for PPC is not =
yet
> clear at the moment. That's it...
>=20
> Ok, are there any objections as to the current patch? If no, please app=
ly.

No objections from my side (I'm overseeing those 2 or 3 white-space
inconsistencies ;) ), should get applied!

I will prepare and commit the remaining tiny updates of RTDM and 16550A
(regarding propagate and re-enable) as soon as this one is merged.

>=20
> CHANGELOG.patch is here
> https://mail.gna.org/public/xenomai-core/2006-02/msg00154.html
>=20
> --
> Best regards,
> Dmitry Adamushko
>=20

Thanks for all your efforts!

Jan


--------------enig7EC18E9898E9F40D867D6863
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEA1IaniDOoMHTA+kRAq6OAJ9aoZdPHtSu+5xGQ58gW3N+DqZawwCdFQkC
+TIbtjIVbCnTZEkmARu0O4A=
=35oh
-----END PGP SIGNATURE-----

--------------enig7EC18E9898E9F40D867D6863--

