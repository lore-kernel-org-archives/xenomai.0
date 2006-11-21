Message-ID: <4562E24E.4000209@domain.hid>
Date: Tue, 21 Nov 2006 12:26:06 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 3/3] control POSIX skin
	debugging	independently
References: <456236E5.5060203@domain.hid> <4562CE05.70900@domain.hid>
In-Reply-To: <4562CE05.70900@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC1EC1A30FAADD44B0F74A5A6"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC1EC1A30FAADD44B0F74A5A6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Following the logic of per-subsystem debug feature control, this patch=

>> introduces a separate kconfig switch XENO_OPT_POSIX_DEBUG and updates
>> the involved source files.
>=20
> I find the "if(XENO_DEBUG(FOO))" notation make it hard to understand
> that the piece of code that follows is disabled at compilation time,
> #ifdef CONFIG_XENO_OPT_FOO_DEBUG is easier to read. This also avoid the=

> rather inelegant
>=20
> #ifndef CONFIG_XENO_OPT_POSIX_DEBUG
> #define CONFIG_XENO_OPT_POSIX_DEBUG 0
> #endif

For now that's just for the sake of consistency with other debugging
parts in Xenomai. But once you may want to use XENO_ASSERT or XENO_BUGON
also in the POSIX skin, the above becomes necessary anyway.

I thought a lot about how to encapsulate the #ifndef more gracefully,
but unfortunately you cannot build preprocessor statements from a
preprocessor macro. If anyone has an idea how to obtain the
XENO_ASSERT&friends semantics without any #ifndef-#define constructions,
please let me know.

About the "if (XENO_DEBUG(POSIX))": I'm OK with converting them back to
"#if XENO_DEBUG(POSIX)" if this is preferred.

>=20
> Now about the Posix skin patch, in my opinion the Posix skin debug
> should be enabled by default, because these printks are the indication
> that there is something wrong in the user code: some objects were
> created but not destroyed.

Ok, will make it "default y" in the next patch revision.

Jan


--------------enigC1EC1A30FAADD44B0F74A5A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFYuJPniDOoMHTA+kRAjiLAJ9VVhmQykl98pQVRWUehMBlKjwAdQCbBnpE
m++Pej+HZenfm+XLNOsjJXI=
=s0pV
-----END PGP SIGNATURE-----

--------------enigC1EC1A30FAADD44B0F74A5A6--

