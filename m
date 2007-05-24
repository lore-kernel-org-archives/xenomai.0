Message-ID: <46554468.70307@domain.hid>
Date: Thu, 24 May 2007 09:53:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <5C40CD1E4697424ABDE3AC57CF1B22C6032202C6@domain.hid>
In-Reply-To: <5C40CD1E4697424ABDE3AC57CF1B22C6032202C6@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB9624BCDC6D46A53C655A0C8"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [Newbie question] threads and task CPU affinity
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB9624BCDC6D46A53C655A0C8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

RAKOTOSALAMA, Nirilanto wrote:
>>> Hello,
>>>
>>> I have some question about CPU affinity with Xenomai 2.3.1.
>>> (it is to see if  xenomai support developing for a cpu=20
>> manager library is feasible)
>>
>> What will this library do? (/me just nosy)
>=20
> In fact, there's simulation programs that run on many different systems=
 (hard + soft),
> and to make this applications as portable as possible, they use librari=
es developed for every
> systems (dec alpha, pc, specific cards, linux, unix). And, I search if =
xenomai could be used
> with less re-implementation effort, so the more posix function are deve=
loped by xenomai,=20
> the better it is, and easier it is (for me :p).
> So first step is developing this libraries xenomai support (e.g. timer,=
 cpu).
> This cpu library should provides "simple" functions like : getting the =
number of cpu,
> setting/getting the cpu affinity for a process passing its pid, protect=
/un-protect cpu from running
> unwanted process.

OK, I see.

>=20
>>> When using rt_task_create, CPU mask can be specified.=20
>> However, when sched_setaffinity is called=20
>>> to modify main program affinity, and after, rt_task_create=20
>> is called without specifying CPU mask,
>>> did the child task inherits from the main program affinity ?
>> If you don't provide a target CPU (either on creation or via
>> /proc/xenomai/affinity), better consider the affinity as unspecified
>> (any possible CPU). The target CPU derives from Linux=20
>> decision where to
>> put the thread non-RT boot code on, Xenomai just nails that decision
>> down until someone explicitly migrates.
>>
>>> Same question for Posix skin threads ?
>>>
>>> Can native task affinity be set other than when creating ?=20
>> using sdhed_setaffinity ?
>>
>> /proc/xenomai/affinity (has global scope) or=20
>> sched_setaffinity. Xenomai
>> shadow threads follow the migration that may took place while in
>> secondary mode, and sched_setaffinity comes with such a mode switch.
>=20
> Thanks, If I have well understood, tasks or threads affinity can be set=
 using /proc/xenomai/affinity
> but, I have read that /proc/xenomai/affinity does not exist in xenomai =
2.3.1 and xenomai must be patched

Yes, it's an upcoming feature of 2.4.

> (I don't know how because I don't have nor SVN neither internet connect=
ion on my xenomai boxes).

There is a daily snapshot on gna.org: https://gna.org/svn/?group=3Dxenoma=
i

> So I can use sched_setaffinity, but it make switch to secondary mode.=20
> Does'nt matter if only threads must be RT and sched_setaffinity is call=
ed during a non-rt init phase, does it ?

Yep.

> That means that affinity does'nt depend on running on xenomai or second=
ary mode ?

Sorry, doesn't parse for me right now.

>=20
> BTW, is protecting a CPU with xenomai possible ?=20
> Does xenomai use /dev/cpuset or an other device ?

Xenomai doesn't directly interact with cpuset -- but... if you force
some RT process into a certain CPU and you don't override this decision
on RT thread creation, Xenomai will follow as explained.

Jan


--------------enigB9624BCDC6D46A53C655A0C8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGVURpniDOoMHTA+kRAsuDAJ9Pd5nPjo7yO0eEJnK+9mlnLZ1fHwCfbaug
CyJ1WWfQ1VMi/A3kBsRduSQ=
=rxz5
-----END PGP SIGNATURE-----

--------------enigB9624BCDC6D46A53C655A0C8--

