Message-ID: <4AF993B8.6090402@domain.hid>
Date: Tue, 10 Nov 2009 17:24:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AF87D53.9090102@domain.hid> <4AF947FA.4030908@domain.hid>
	<4AF9571F.7090500@domain.hid> <4AF964C2.3060206@domain.hid>
In-Reply-To: <4AF964C2.3060206@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig154B4449D2D0F997D34568B5"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [pull request] heap reference and trivial build
 fixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
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
--------------enig154B4449D2D0F997D34568B5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> The following changes since commit 6d7d6bc436ef3d1fb51fa8de06d4ecf00=
4e3b6a5:
>>>>   Gilles Chanteperdrix (1):
>>>>         nucleus: defer selector block deletion to an APC.
>>>>
>>>> are available in the git repository at:
>>>>
>>>>   git://git.xenomai.org/xenomai-jki.git for-upstream
>>>>
>>>> Jan Kiszka (2):
>>>>       nucleus: Track heap mapping on to mm-clone
>>>>       nucleus: Fix trivial build warning
>>>>
>>>>  ksrc/nucleus/heap.c   |   12 +++++++++++-
>>>>  ksrc/nucleus/module.c |    2 +-
>>>>  2 files changed, 12 insertions(+), 2 deletions(-)
>>> Hi Jan,
>>>
>>> do you agree if I add the notification to the xenomai-git mailing lis=
t
>>> for your tree? It makes it possible to review your patches without an=
y
>>> action on your side. Note that a recent modification to the notificat=
ion
>>> mechanism only shows the relevant patches.
>>>
>> No problem. Ah, the new filter looks nice!
>>
>> And how would my new workflow look like? Just silently push into
>> 'for-upstream'?
>=20
> Well, it does not work for me, because I always realize that I screwed
> up AFTER I push the changes. Besides, we may push things only for
> review, so, I would keep the pull requests and the discussions on the
> list, only avoid publishing the patches manually on the list. But this
> is open for discussion of course.

Fine with me as well, specifically as I tend to face similar problems.
And as one can pick the patches for citing from xenomai-git, commenting
on patching shouldn't be much harder for the reviewer.

Jan


--------------enig154B4449D2D0F997D34568B5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkr5k88ACgkQitSsb3rl5xQRDgCgoF0lpfNETkwt9nC2QcpW9lvo
d8kAn1UuDEzHqbDLm8CQtDB7RBq0FnBS
=OHkJ
-----END PGP SIGNATURE-----

--------------enig154B4449D2D0F997D34568B5--

