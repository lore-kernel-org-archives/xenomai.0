Message-ID: <46838C9C.7030303@domain.hid>
Date: Thu, 28 Jun 2007 12:25:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB14C@rennsmail04.eu.thmulti.com>
	<4680DA9B.5020501@domain.hid>
In-Reply-To: <4680DA9B.5020501@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDAAEF642A49F7AF41ADD2409"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Group-based RT caps
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDAAEF642A49F7AF41ADD2409
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Fillod Stephane wrote:
>> ...
>> I think Johan was not asking to disable the mlockall, but to allow som=
e.
>> non-root user to be able to do it. He found his solution anyway, which=

>> is worth an entry in the FAQ.
>>
>> Since it is going to be a FAQ for those people in embedded business,
>> some
>> tricks to allow non-root operation of mlockall, SCHED_FIFO, etc., woul=
d
>> be=20
>> useful. For example, you may hack the commoncap in linux/security/,=20
>> or a better solution would be to rely on realtime-lsm[1][2], thanks to=
=20
>> the audio folks.
>>
>> [1] http://sourceforge.net/projects/realtime-lsm/
>> [2] http://lwn.net/Articles/110346/
>>
>=20
> I think we could and should incorporate such a feature into the nucleus=
=2E
>=20
> There is already code in xnshadow_map playing with cap_effective, but
> that happens too late. Instead, we should establish a group-based acces=
s
> control just like rt-lsm (the other knobs of that module are either
> irrelevant for Xenomai (mlock=3D0) or broken security-wise (any=3D1)) a=
nd
> raise the required caps for a process that belongs to the specified
> group, likely when an Xenomai interface gets attached by that process.
>=20
> Comments? Volunteer coders...?

I couldn't resist, the approach looked too simple and appealing:

http://www.rts.uni-hannover.de/rtaddon/patches/xenomai/rt-caps-group.patc=
h

Actually, it's even more advanced than realtime-lsm in so far as it also
checks for secondary group membership. You can use the nucleus module
parameter "xenomai_gid" to control the Xenomai group, also during
runtime using /sys.

Works nicely for me. I'm able to run testsuite programs under my user
account that now additionally belongs to the "xenomai" group. :)

One issue popped up and costed some nerves: linuxthreads-based
pthread_create() (non-NPTL glibc, uClibc) with SCHED_FIFO/RR attribute
fails already in userland because that library overeagerly checks for
root permissions. This is now worked around, but maybe not in the
cleanest way as it changes the initial thread scheduling order (more
problematic for the POSIX skin than for Native).


*BIG FAT WARNING*
Don't believe that this patch allows to run Xenomai applications in
whatever securely confined way! We grant CAP_SYS_RAWIO to all Xenomai
users, some Xenomai services can easily be corrupted/exploited from user
space (those based on shared heaps e.g.), and no one audits the core or
all the drivers for security. The advantage of having a separate Xenomai
group instead of just assigning root access directly is being able to
avoid _accidental_ changes, nothing more!

Jan


--------------enigDAAEF642A49F7AF41ADD2409
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGg4ycniDOoMHTA+kRAg6UAJ9uiNK1sq2eFxYw1+MB5gPMtPjVyACeORr8
jLRBYRvQwEmK356QHJ0w9z8=
=r0RN
-----END PGP SIGNATURE-----

--------------enigDAAEF642A49F7AF41ADD2409--

