Message-ID: <4AC454E0.1070307@domain.hid>
Date: Thu, 01 Oct 2009 09:06:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AC2448B.1080500@domain.hid>	<634c78ce0909300710i6d30b905kafdf7d76b2b31c7c@domain.hid>
	<4AC371B2.8040109@domain.hid>
In-Reply-To: <4AC371B2.8040109@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0AB6ACA72AC7518E21035BF3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] RFC: 2.5 todo list.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0AB6ACA72AC7518E21035BF3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Peter Soetens wrote:
>> On Tue, Sep 29, 2009 at 19:31, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> Hi guys,
>>>
>>> full of energy after this tremendous first XUM, I would like to start=
 a
>>> discussion about what people would like to see in the 2.5 branch.
>> So if we answer positively, we'll delay the release ? I'd rather get
>> 2.5 out, and develop any new stuff on 2.6. I would also expect that
>> this list (or part of ) goes to xenomai-help too.
>=20
> Actually, it is badly expressed. What I would like to know is what
> people had in mind, what they intended to put in the 2.5 version, so as=

> to discuss of what we will put in it and what will be postponed, to hav=
e
> a more precise idea of the 2.5 development (or end of development, more=

> precisely, since we already released rc3...) schedule. This comes from
> the fact that we had postponed this signals thing, and that it almost
> went forgotten, so, I would like to be sure that we do not forget anyth=
ing.
>=20

We all know the problem here: 2.5 is almost done and should have been
rolled out much earlier, but our resources are limited. Then, 2.5 is
intended to be a long-term maintenance branch, likely the last one in
2.x. Pushing more 2.x features in, enforcing a 2.6 series would make 2.5
an "ordinary" series and, again, require more of our scarce resources.
That would likely be at the expense of long announced 3.0.

We surely can't have all, so we have to pick the best option. Right now
I see the following ones:

 1. Postpone 2.5.0 until all desired ABI-breaking feature are done and
    mature enough.
 2. Release 2.5.0 soon and push the new features into a 2.6 series.
 3. Allow the integration of non-ABI-breaking features into 2.5.1 or
    later (e.g. some heap statistics or unwrapped posix services) and
    develop the other features within 3.0.

My personal prioritization is 3 over 2 over 1. I would really hate to
see 2.5.0 delayed by new features at this point. Also, when looking at
our project with Healthcare, having to wait much longer for 2.5 due to
anything else than bug fixes would complicate things here a lot.

Jan

PS: Hope everyone enjoyed Dresden at least as much like I did. The XUM
was really a great event at the right time!


--------------enig0AB6ACA72AC7518E21035BF3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrEVOQACgkQitSsb3rl5xQj9wCgwVfS6Gtui1O1v2RoScFZGZ4i
UYsAn3W80yDtwPmw62w8Ym4IFIq1IgGi
=Gns5
-----END PGP SIGNATURE-----

--------------enig0AB6ACA72AC7518E21035BF3--

