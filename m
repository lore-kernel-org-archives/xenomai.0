Message-ID: <44643F29.8010701@domain.hid>
Date: Fri, 12 May 2006 09:54:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Stalled xenomai domain with head-optimisation
References: <446364DB.50908@domain.hid> <4463BB6F.8050008@domain.hid>
	<4463CF17.8070901@domain.hid> <44642811.20500@domain.hid>
In-Reply-To: <44642811.20500@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig40836A148EE6BAA04203F896"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig40836A148EE6BAA04203F896
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>>
>> As long as I didn't messed my build up (it's late...): no effect for
>> both patches.
>>
>=20
> Ok, thanks. So does the following patch on the trunk/ make the bug
> disappear, when using a vanilla Adeos support?
>=20
> --- include/asm-generic/hal.h    (revision 1078)
> +++ include/asm-generic/hal.h    (working copy)
> @@ -118,7 +118,7 @@
>  /* Obsolete Adeos patches do not support the invariant pipeline head
>     optimization, so we check for the presence of __ipipe_pipeline_head=

>     to detect it. */
> -#if defined(CONFIG_XENO_OPT_PIPELINE_HEAD) &&
> defined(__ipipe_pipeline_head)
> +#if defined(CONFIG_XENO_OPT_PIPELINE_HEAD) &&
> defined(__ipipe_pipeline_head) && 0
>  #define rthal_local_irq_disable()    ipipe_stall_pipeline_head()
>  #define rthal_local_irq_enable()    ipipe_unstall_pipeline_head()
>  #define rthal_local_irq_save(x)        ((x) =3D
> !!ipipe_test_and_stall_pipeline_head())
>=20

This works now.

Jan


--------------enig40836A148EE6BAA04203F896
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEZD8pniDOoMHTA+kRAllfAJwIV+hDsAOQL9Oj/ayAswSnyGpclwCfRTgi
wOazvVkDGzSzdfy63VpENdM=
=YL3U
-----END PGP SIGNATURE-----

--------------enig40836A148EE6BAA04203F896--

