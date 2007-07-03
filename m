Message-ID: <468A60C8.4050203@domain.hid>
Date: Tue, 03 Jul 2007 16:44:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4687F466.2020901@domain.hid>	
	<b647ffbd0707020435oc733ee2m2facf281ee0c5cbb@domain.hid>	
	<4688E373.5020205@domain.hid>
	<b647ffbd0707030713x7eec10d2j5355e6257445f970@domain.hid>
In-Reply-To: <b647ffbd0707030713x7eec10d2j5355e6257445f970@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF9A4301340E95126EF6E51B6"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH-STACK] Missing bits for -rc1
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
--------------enigF9A4301340E95126EF6E51B6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 02/07/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Dmitry Adamushko wrote:
>> > On 01/07/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> >> Hi all,
>> >>
>> >> I've just uploaded my rebased patch stack, including specifically t=
he
>> >> last bits that should go in before -rc1,
>=20
> a few comments:
>=20
> (1) in xnintr_irq_handler()
>=20
> +    xnlock_get(&xnirqs[irq].lock);
> +
> +#ifdef CONFIG_SMP
> +    /* In SMP case, we have to reload the cookie under the per-IRQ loc=
k
> +       to avoid racing with xnintr_detach. */
> +    intr =3D rthal_irq_cookie(&rthal_domain, irq);
> +    if (unlikely(!intr)) {
> +        s =3D 0;
> +        goto unlock_and_exit;
> +    }
> +#else
> +    intr =3D cookie;
> +#endif
>=20
> I think, it would be better to check 'intr' for NULL at this point so
> to cover 'cookie =3D=3D NULL' (who knows.. and it's better not to rely =
on
> the lower layer here), I guess.

The lower layer just passes what we hand over - and when we do so. Keep
in mind: this is the non-SMP case, thus we can rely on the atomicity of
this handler like the one of registering a handler + its cookie (like we
always did -- unfortunately also for SMP...). For me, checking for NULL
on UP is redundant code in a hotpath. Should I spread some comment
regarding this assumption?

>=20
> (2) use cases of xnintr_sync_stat_references() in xnintr_irq_detach()
>=20
> +
> +    xnlock_get(&xnirqs[irq].lock);
> +
> +    err =3D xnarch_release_irq(intr->irq);
> +    xnintr_sync_stat_references(intr);
> +    xnlock_put(&xnirqs[irq].lock);
>=20
> Why do you call xnintr_sync_stat_references() inside the locked section=

> here?
> Does xnintr_sync_stat_references() really need to be protected by
> 'intr->lock' (it's been already detached) ?

That's now my own overcautiousness :). I think we can move it out.
Someone must sync on some xnintr object while someone else tries to
re-register an object with very same address -- classical user error,
nothing we need to catch here.

Thanks,
Jan


--------------enigF9A4301340E95126EF6E51B6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGimDMniDOoMHTA+kRAhVYAJ9vDfQbBaOaYPunPrt3mf+Q/UKbqgCfaGou
Za9pi4/DZJA0yUmLf2ptBgg=
=XLHa
-----END PGP SIGNATURE-----

--------------enigF9A4301340E95126EF6E51B6--

