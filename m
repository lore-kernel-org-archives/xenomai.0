Message-ID: <4847120F.7040905@domain.hid>
Date: Thu, 05 Jun 2008 00:07:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1212614370.21088.23.camel@domain.hid>
In-Reply-To: <1212614370.21088.23.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCE846FEC7EE93B90B9C9D49C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Saving floating point registers inside ISR
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henry Bausley <hbausley@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCE846FEC7EE93B90B9C9D49C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Henry Bausley wrote:
> I am converting a 440EP power pc FSM Labs RT-Linux application to a
> Xenomai 2.4.2 posix application. Previously we saved the floating point=

> registers in the ISR.  I had the following code with RTLinux.
>=20
> //---------------------------------------------------------------------=
--------
> int phase_intr(xnintr_t *cookie)
> {
>   rthal_fpenv_t fpustate;

Do you know how large this structure is? And do you know how much stack
space is still free when entering here, in the worst case? That may
differ from RTLinux, probably running on some older kernel.

>=20
>   rthal_save_fpu(&fpustate);
>=20
>   phase();
>=20
>   =EF=BB=BFrthal_restore_fpu(&fpustate);
>   return (XN_ISR_HANDLED);
> }
>=20
> with xenomai if we do the the same thing the system hangs.
>=20
>=20
> However if we make the location where we save the registers global, or
> declare it static inside the ISR we don't have a problem.  I don't want=


That should ring the bell above...

> to do that since there are cases when the interrupt can be re-entered.
> Does anyone have any ideas?
>=20
> rthal_fpenv_t fpustate;
>=20
> =EF=BB=BF//------------------------------------------------------------=
-----------------
> int phase_intr(xnintr_t *cookie)
> {
>=20
>   rthal_save_fpu(&fpustate);
>=20
>   phase();
>=20
>   =EF=BB=BFrthal_restore_fpu(&fpustate);
>   return (XN_ISR_HANDLED);
> }
>=20

If the stack size is not the problem here, compare to disassembly of the
involved versions, local vs. global fpustate, and then the one from RTLin=
ux.

Jan


--------------enigCE846FEC7EE93B90B9C9D49C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIRxIPniDOoMHTA+kRAjEfAJsGhykE3wy8OLMeCwL2QWiAaaeVEwCfXaiK
YcrHUdUJnPIfIG6Gmpupj1s=
=wrS2
-----END PGP SIGNATURE-----

--------------enigCE846FEC7EE93B90B9C9D49C--

