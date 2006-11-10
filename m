Message-ID: <45549050.4090005@domain.hid>
Date: Fri, 10 Nov 2006 15:44:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai Kernel limits
References: <DD39B5C3F4963040ADC9768BE7E430CB0154E67A@is-hdq-exchange.marel.net>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0154E67A@is-hdq-exchange.marel.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig91EAE2615BFE93C606ADB12D"
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
To: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig91EAE2615BFE93C606ADB12D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Daniel Schnell wrote:
> Hi Jan,
>=20
>=20
> jan.kiszka@domain.hid wrote:
>> Maybe that bug is a symptom of some other scalability issue.
>=20
> I suppose so, too.
> =20
>>> +++
>>> bash-2.05b# cat /proc/heap
>>> size=3D131072:used=3D134400:pagesz=3D512
>>> +++
>>>
>>> This looks odd. Either the output is misleading or we have used more
>>> resources than possible. But then I would expect that the Xenomai
>>> initialization routines (e.g. pthread_create(), rt_dev_open(), etc.)
>>> should return with an error. Either should be fixed, I suppose.
>> Every services that allocates memory from the real-time heap should
>> fail now. If it doesn't (pthread_create is a good test candidate
>> here), we "only" face a statistics bug. Can you confirm that starting
>> further applications only increases the used counter but otherwise
>> works?   =20
>=20
> I was running the cyclictest and the switchbench without problems at th=
e
> same time and the /proc/xenomai/heap showed even a usage of 135 kBytes.=

> So I assume that is a statistics bug.

=2E..or some overwritten memory: The block size is encoded in each heap
chunk. Looks to me like we do not check for its sanity with a magic
number or so, do we? Would be a nice debug feature. Someone around who's
bored (rhetoric question)?

>=20
>>> I configured Xenomai in the Kernel with the following values, but
>>> please bear in mind that was after I thought about a resource
>>> shortage:=20
>>>
>>> CONFIG_XENO_OPT_PIPE_NRDEV=3D320
>> This looks exceptional. Do you really use pipes that heavily?
>=20
> We do not use pipes at all. Just shooting around in the forest ....
> Which pipes are meant here actually ? Native Pipes ? Which effect does
> this option have if I did not compile in support for Pipes of the nativ=
e
> API ? Again: a comprehensive description of these options would probabl=
y
> help. Is it possible to get these inside 2.4 Kernel as well ?

Everything is possible. Some smart script hacker could grab the info
from the 2.6 files, reformat it, and merge it into the central(!) help
file of 2.4. Just takes someone to do the work, as usual... :)

>=20
>>> CONFIG_XENO_OPT_REGISTRY_NRSLOTS=3D2560
>> Do you every have so many registered objects active in parallel?
>> Should be no problem, but I wonder if it is needed.=20
>=20
> Well per default it is set to 256. We are using more IPC objects. So I
> increased it by 10 times to be on the safe side. I do not know what
> actually can occupy a "registry slot". Explanation ?

None of the services you use from the POSIX skin, only named stuff like
mqueues or semaphores.

>=20
>>> - I realized that when setting CONFIG_XENO_DRIVERS_RTCAN_RXBUF_SIZE
>>> to 131072, my application does not run. Which are the upper limits I
>>> can=20
>>> set for all the configurable Xenomai parameters ?
>> That buffer is part of each CAN socket instance which is allocated
>> via kmalloc - hence the 132K limit here. But you shouldn't normally
>> need such large intermediate buffers when no CAN receiver gets
>> delayed unreasonably long.  =20
>=20
> Right, the default of 1024 should be pretty enough, despite we had to
> increae it to 8096 not to get any receive socket buffer overflow
> messages. Investigation pending ...
> I understand that kmalloc has 132K limit. But if I allocate 131072 byte=
s
> this is within the limits of kmalloc I suppose.

There is some further overhead involved.

>=20
>> It melts down that you will have to try to isolate the reason(s) for
>> unexpected behaviours. I suspect some internal buffer overrun that
>> causes all those ugly side effects. =20
>>
>> Can you try to scale your app down, remove features/service calls so
>> that subsystems can be excluded systematically?=20
>=20
> I feared you asked for that. Well yes, this will actually be the tough
> task to do, I suppose. Will need quite a time though. Until then: any
> debugging trick I could try as well ?
>=20

Play with all those modified limits in the kernel config. Does changing
/ reverting-to-default any of them modify the problem as well? Might
give further hints where to dig.

Jan


--------------enig91EAE2615BFE93C606ADB12D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFVJBQniDOoMHTA+kRAqGkAJ9nhYlaFt4s8LT74ed9I89e7a6Q5wCfTNzC
Yg2b4P53VqNqA3MqwuuowqQ=
=5lr5
-----END PGP SIGNATURE-----

--------------enig91EAE2615BFE93C606ADB12D--

