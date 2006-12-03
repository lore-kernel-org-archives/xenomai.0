Message-ID: <4572E7D1.5020103@domain.hid>
Date: Sun, 03 Dec 2006 16:05:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCHES] cleanup minor quirks for 1.6-01
References: <4572DB9F.7040505@domain.hid> <1165157023.4952.361.camel@domain.hid>
In-Reply-To: <1165157023.4952.361.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig442A623AAB86BA19A383F159"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig442A623AAB86BA19A383F159
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2006-12-03 at 15:13 +0100, Jan Kiszka wrote:
>> Hi,
>>
>> I came across a few things in latest 2.6.19-i386-1.6-01 patch:
>>
>> The usage of __ipipe_pipelock in __ipipe_common_info_proc is broken (r=
aw lock used as
>> Linux lock here), and I do not see any volatile data it could protect =
anyway. So let's
>> remove it.
>=20
> The interrupt status word, and whether any virtual interrupt is
> allocated or not, are the volatile data protected by this lock on a SMP=

> system. Since this is a common spinlock with no interrupt control
> required which is only used over the Linux domain (/proc handler), you
> don't need to go for the _hw() form of it.

As far as I see, nothing prevents the other users of __ipipe_pipelock to
be executed over non-root domain (IRQ registration in Xenomai context is
allowed, no?).

But I have to re-check what data for __ipipe_common_info_proc actually
can be released (I'm not considering inconsistency a problem here). I
didn't see anything on first review.

Still, this kind of merging of _hw with non-_hw spinlock operations is
fishy in my eyes.

Jan


--------------enig442A623AAB86BA19A383F159
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFcufSniDOoMHTA+kRAtEnAJ4uygDxKY/VqCsgeQuJtUWy3zrh2ACggcoo
bjZ3633TY7S1R6Rmv8lPWjQ=
=4N1V
-----END PGP SIGNATURE-----

--------------enig442A623AAB86BA19A383F159--

