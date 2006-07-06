Message-ID: <44ACF135.9060402@domain.hid>
Date: Thu, 06 Jul 2006 13:17:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] delete queues "offline"; /proc/stat
References: <5D63919D95F87E4D9D34FF7748CE2C2A3F8CE2@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A3F8CE2@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8753C3694634091BE5752D3A"
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
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8753C3694634091BE5752D3A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roderik_Wildenburg@domain.hid wrote:
>>> when a xenomai-task crashs which created some queues=20
>>> (rt_queue_create)=20
>>> and I try to restart the task the creation of the queues=20
>>> will fail as=20
>>> the queue still exists (error EEXIST =3D=3D 17). Is there a=20
>>> possibility to=20
>>> see which queues exist (I did not find a hint in the /proc/xenomai
>>> directory) and to get rid of these queues (or geneally=20
>>> spoken : to get=20
>>> rid of allocated resources) e.g. with a commandline tool ?
>=20
>> Native or posix skin? Gilles added per-process resource=20
>> cleanup to the posix skin in 2.2-rc3.
>>
>=20
> following Murphys law, I, of course, use native skin where this mechani=
sm isn?t=20
> implemented yet ;-)
> What does "per-process resource cleanup" mean ?=20
> When the process/thread is killed the queues and other resources of thi=
s=20
> process/thread are deleted automaticaly ?

Exactly.

>=20
>> Otherwise: the names should be found in=20
>> /proc/xenomai/registry. Writing a tiny tool to pick up a name=20
>> and resources type, attach to it, and then release it should=20
>> be straightforward. But I think we will have per-process=20
>> cleanup also for other skins in the future.
>>
>=20
> The trick with this is the attachement with the resource.
> I can?t see a way to attach to a queue whos handle (RT_QUEUE)
> is lost (it can?t be reconstructed out of the data from the=20
> registry).  Are there some other "tricks" ?

If there is a name registered, rt_queue_bind() should do the trick - but
that's pure theory, I may oversee some detail ATM.

>=20
>=20
>> Stalled RTDM descriptors can be released via "echo DESCR_NO >=20
>> /proc/xenomai/rtdm/open_fildes" (I still have to make use of Gilles'
>> per-process cleanup also for the posix rtdm part...).
>>
>>> An other question, I would appreciate some help for, is :
>>> How could I determine the CPU-load when a xenomai thread is=20
>> running?=20
>>> Is the data provided by /proc/stat valid with xenomai ?
>> Nope, they aren't. We actually need to do something in this=20
>> direction, maybe a simple per-xeno-thread execution time=20
>> accounting if XENO_OPT_STATS is set.
>>
>=20
> A summary of Xenomai used time in /proc/stat would be fine too:
> CPU : "User time" "nice time" "system time" "xenomai time" "idle time".=

> But this probably is not compatible.
>=20

I've just hacked a patch for per-thread stats. Seems to work. I will
post it in a few minutes on xenomai-core together with some explanations
and suggestions. Stay tuned!

Jan


--------------enig8753C3694634091BE5752D3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErPE1niDOoMHTA+kRAjkGAJ9Vr2i9A26QdfHUAeVN2hlI8cwqNACfcgX0
mpnLyhxYFk3TKHF0bWaPadg=
=DkUu
-----END PGP SIGNATURE-----

--------------enig8753C3694634091BE5752D3A--

