Message-ID: <48F660E7.8090906@domain.hid>
Date: Wed, 15 Oct 2008 23:30:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F6195C.7070801@domain.hid> <48F6492C.4090500@domain.hid>
In-Reply-To: <48F6492C.4090500@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig318CB9E3FED703C84D2A8029"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] rt_task_info.status encoding
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig318CB9E3FED703C84D2A8029
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> the documentation refers to the Native Task Status (T_*) when it comes=

>> to documenting rt_task_info.status. That is not correct. That field
>> contains far more flags than T_* is describing and, even worse, comes
>> with two collisions: T_PRIMARY and T_JOINABLE are not reported by
>> rt_task_inquire, rather T_RELAX (!T_PRIMARY, arrrg...) and T_HELD.
>>
>=20
> T_PRIMARY is NOT meant to be reported by rt_task_inquire(), and actuall=
y, its
> value was picked to collide, to reflect the fact that it was a one-way

So you preferred to break rt_task_inquire instead of letting it return a
consistent value? Not really?

> specifier. You can't use T_RELAX because what is needed is a bit to for=
ce a
> transition to primary mode using rt_task_set_mode(), which is the actua=
l source
> of all uglinesses. Aside of this, the nucleus naturally wants a "relaxe=
d state"
> bit, and would not get any help from a "primary mode" bit for threads.

I'm not arguing for removing T_PRIMARY, I was just struggling with the
confusing values rt_task_inquire reported to me.

>=20
> We could have used a T_RELAX bit to clear in rt_task_set_mode() instead=
 of
> T_PRIMARY to set, but unfortunately, such a negative logic would have b=
een
> somewhat confusing to users, since what is provided is the secondary ->=
 primary
> mode switch.
>=20
> Sending back the current mode in rt_task_inquire() would lead to two ad=
ditional
> issues:
> 1) if for some reason, we would like to switch the caller to secondary =
mode at
> some point to be able to provide a more complete status, the primary/se=
condary
> status returned would make no sense at all. The fact that we don't do i=
t now
> does not preclude the need to do it in future releases.

Sorry, but this is very far fetched.

> 2) rt_task_set_mode(..., T_PRIMARY) is already vastly misused in a numb=
er of
> applications, sometimes uselessly, most of the time in a way that event=
 kills
> performances. Giving an interface to get back the current mode would cl=
ose the
> loop, triggering a whole set of new terminally silly usage of that hack=
=2E
> Applications should NEVER use that feature, it was initially designed f=
or
> internal code (i.e. RTDM if my memory serves me well). Actually, the mo=
re I
> think of it, the more I convinced that I'm going to slaughter this crap=
 in 2.5,
> providing an internal syscall from the XENOMAI_SYS class instead for us=
e only in
> proper contexts.

This is a different issue.

See, I needed rt_task_inquire for precisely the purpose it is (mostly)
designed for: tracing / debugging. And for that purpose, a valid
T_PRIMARY bit is of very high importance. I even implemented the same
inquire service for POSIX in the meantime so that I was able to
implement all functional tests I needed for the fast mutexes.

If you really argue for removing a T_PRIMARY-equivalent from
RT_TASK_INFO, you may also argue for removing the SIGXCPU helper - the
user should better not know in which context some of his threads
currently runs.

>=20
> T_JOINABLE might be reported, though, that is a different story.
>=20
>> I see two ways out of this:
>>
>>  a) Redirect the documentation to the nucleus thread state flags.
>>
>=20
> Which means that the documentation of the skin depends on the implement=
ation of
> the core. Bad idea.

OK, for the sake of API cleanness, I'm fine with wrapped state flags.
Will prepare the required patch to add missing (but also sufficiently
abstract) states and mask the rest from rt_task_inquire.

Jan


--------------enig318CB9E3FED703C84D2A8029
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj2YOkACgkQniDOoMHTA+nTlwCffV3KF5UFsv7KbZrUj71Uut9r
JoEAn0+isfbYHKe9iaVGX68PpeiIoP2y
=yvuq
-----END PGP SIGNATURE-----

--------------enig318CB9E3FED703C84D2A8029--

