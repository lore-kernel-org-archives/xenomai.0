Message-ID: <44C783ED.60406@domain.hid>
Date: Wed, 26 Jul 2006 17:02:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai task (beginner)
References: <1299EF3181B10F479D85C3280132852422DABC@THEZE.intra.cea.fr>	<44C657DD.1040800@domain.hid>
	<200607261639.08866.schwab@domain.hid>
In-Reply-To: <200607261639.08866.schwab@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD19C789CB9B9E454DE9F6E3B"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD19C789CB9B9E454DE9F6E3B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Ulrich Schwab wrote:
> On Tuesday 25 July 2006 19:41, Jan Kiszka wrote:
>> GUARDIOLA-FALCO Sebastien 204282 wrote:
>>> Hello,
>>>
>>> I'm waiting for Xenomai to be included in the ElinOS Linux package, s=
o I
>>> can't try it before next week.
>> Oh, good to hear that this long announced update finally takes place! =
I
>> think there are quite a few ElinOS users out there happily awaiting it=
=2E
>> Let's see what version they will deliver.
> I doubt this, since they have their own realtime implementation (PikeOS=
).
> According to them, it is better than any other, of course ! :-)

Not all of their customers "buy" this. PikeOS is a different league.
It's a microkernel-based full virtualisation of Linux, just like Jaluna,
Integrity, or what they are all called. It has its very specific
application domain (nothing comes for free, you know...). And you have
to consider that its proprietary software by vendor X - not really
popular anymore. :)

But ElinOS also has RTAI support, I know some of its users. One told me
that they will not migrate to Xenomai before Sysgo supports it -
political decision.

>=20
> I never saw  xenomai support announced, by the way.

Not officially, but I talked to them twice at some fairs, and they
confirmed to work on it. For me it appears logical when looking at their
board portfolio and given that RTAI is practically bound to x86 now.

Jan


--------------enigD19C789CB9B9E454DE9F6E3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEx4PtniDOoMHTA+kRAsaTAJ4gYQB6TJXQIm63qyw9YJoNdd8ktQCcCTRP
EGPNwCPii/skeruxFvb/p+g=
=1Zt6
-----END PGP SIGNATURE-----

--------------enigD19C789CB9B9E454DE9F6E3B--

