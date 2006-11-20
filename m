Message-ID: <45616F69.5090404@domain.hid>
Date: Mon, 20 Nov 2006 10:03:37 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] System freezes with Xenomai 2.2.5 and kernel 2.6.17
References: <20061117143512.191580@domain.hid> <455DCBAB.4090204@domain.hid>
	<45606152.2000100@domain.hid>
In-Reply-To: <45606152.2000100@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEA758E4C62DC2D2EC2F1963C"
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
To: karre@domain.hid
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEA758E4C62DC2D2EC2F1963C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Richard,

karre@domain.hid wrote:
> Hi Jan,
>=20
> thank you for your answer! Unfortunately, I didn't find your mail
> earlier as Thunderbird made a mistake.
>=20
> In the meantime I verified the freezing on another platform. Both are
> notebooks that are 3 years or older.
>=20

Same config? Then the same issue I will explain below.

>=20
>>>>> Another suspicious fact was numberous "nothing to do"-messages duri=
ng compilation of Xenomai.
>>>>>    =20
>>>    =20
>>>
>>> User-space part, I guess. Likely you already built it, no?
>>>  =20
>>  =20
> I think so as well. User-space part is the one that is not compiled int=
o
> the kernel but with a make/make install directly in the
> xenomai-directory, isn't it?

Not to forget "configure". Yes, that's the user-space part.

>=20
> But no, at least on this computer I haven't built it before. I
> downloaded a fresh copy of the Vanilla-2.6.17.14-Kernel and of Xenomai
> 2.2.5, expanded it, patched the kernel, and compiled the kernel and
> afterwards Xenomai (user part?).
>=20
>=20
>>>>> Now the system is bootable and Xenomai reported that hal&x86, real-=
time nucleus, nataive API, POSIX and RDTM services had started. Unfortuna=
tely, the system freezes unrecoverably shortly after login.
>>>>>    =20
>>>    =20
>>>
>>> .config, please. I'm running such a setup (SuSE 10.1, 2.6.17.14, late=
st
>>> Xenomai) successfully on my notebook.
>>>  =20
>>  =20
>=20
> That's great, also that your run it on a notebook as well!
>=20
> I appended my .config at the bottom of this email's copy to you. I left=

> it from the copy to xenomai-help, as it is 64 KB large. If it is no
> problem, I could also attach it hier.

Ok, this is fortunately a simple issue:

CONFIG_M586=3Dy
# CONFIG_M586TSC is not set

This forces Xenomai into TSC emulation mode using the PIT. Suboptimal
setup, choose at least M586TSC or even something closer to your real
processor.

The actual problem is the conflict with this option:

CONFIG_INPUT_PCSPKR=3Dy

That driver also uses the PIT and finally causes the lock-up. Upcoming
Xenomai 2.3 detects the conflict and warns you, but 2.2 lets you trap
into this without any hint.

=2E..
> By the way, when I compiled the rt-system on this second notebook, I go=
t
> the  "Cannot determine dependencies of module ..." not for reiserfs, bu=
t
> for processor, thermal,  jbd, ext3 (in this order and immediately
> afterwards a second time, again in this order). As I have already said,=

> I could provide you with the messages during build process.

Yeah, I know those (likely) SuSE-related warnings as well. I never felt
like looking for their reason, I can just say that they are harmless.

Jan


--------------enigEA758E4C62DC2D2EC2F1963C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFYW9pniDOoMHTA+kRAuebAJ9TEV6EYT+KfDRcfZGbg4LSY+obrACfTkzl
8jj5HA0F2SqF26zW0uCBsEU=
=cegV
-----END PGP SIGNATURE-----

--------------enigEA758E4C62DC2D2EC2F1963C--

