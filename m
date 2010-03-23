Message-ID: <4BA8C15E.5050707@domain.hid>
Date: Tue, 23 Mar 2010 14:25:50 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4BA39C3D.1040802@domain.hid> <4BA4EF75.7010202@domain.hid>
	<4BA74820.2090401@domain.hid> <4BA8752E.8090407@domain.hid>
In-Reply-To: <4BA8752E.8090407@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig488D23A11AC1C63714DE8DCC"
Subject: Re: [Xenomai-help] crash after termination
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig488D23A11AC1C63714DE8DCC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 23.03.2010 09:00, schrieb Jan Kiszka:
> Stefan Kisdaroczi wrote:
>> Am 20.03.2010 16:53, schrieb Jan Kiszka:
>>> Stefan Kisdaroczi wrote:
>>>> hi all,
>>>>
>>>> after termination of my xenomai applications, my box crashed often (=
3 of 4 times) with xenomai 2.5.1.
>>>> Today I updated to current git-2.5, rebuilt xenomai and the kernel. =
Still crashes.
>>>> I have captured two traces over a serial connection. I have attached=
 the kernel config, the two
>>>> traces and the cpuinfo (UP x86 Pentium III). Help is welcome. Thank =
you.
>>> Both crashes seem to be caused by corrupted skbs. There are (at least=
)
>>> two uncommon network component in your kernel: ARCNET and ISDN. Do yo=
u
>>> make use of them or are they just passively loaded? If the former: Ca=
n
>>
>> Just passively loaded.
>>
>>> you retry without them? >(The Kernel's ISDN stuff is of, well, mixed
>>> quality, and ARCNET is so old and uncommon that the code /may/ have
>>> bit-rotted -
>>
>> I disable them.
>>
>>> just an attempt to detract the attention from Xenomai. :) )
>>
>> I think the problem is in my apps, but I had some hope that
>> some changes for 2.5.2 (about thread cleanup,fork) would help.
>=20
> Is your application partially or fully kernel homed? Because no user
> space application is allowed to crash your host, anything else is a bug=

> in the kernel as well.

Hi Jan,

Only user space using the native skin. Some additional notes:
I'm using the freepascal compiler and link against libnative, i dont use =
gcc.
There is one process starting the other ten processes using fork() & exec=
l().
The tasks do a lot of mode switching between primary/secondary.
The stacksize for the tasks is 1MB. We only use between 4K-16K of stack i=
n our
applications. So there should be still a bit less than 1 MB for socket ca=
lls
and printf, is this to low ?

I rebuilt the kernel without arcnet and isdn and disabled smp too, using =
2.5.1.
It still crashes every time on termination. If I pull the network connect=
or,
I could start and shutdown the applications 5 times without problem. If t=
he
network is connected, as soon as there is some network activity like ssh/=
samba
on termination the box crashes. Sometimes it gets even back to the prompt=
 before
crashing. Its a rtl8139 network card, but happens in a virtualbox-vm with=
 a pcnet
card too. In the traces is always a "do_IRQ+0x...", so I think the proble=
m is
related to IRQ-handling.

Stefan

>>
>>> What other network components are actively involved in your scenario?=

>>
>> Only TCP/IP (non-realtime). Currently a dozen xenomai native tasks are=

>> doing standard socket calls. If everything works, there will be about
>> 60 tasks using socket calls, but its still a long way.
>>
>> I focus now first on another problem I have in my apps with a shared h=
eap,
>> so one question about that: There was no H_NONCACHED flag at the time =
I
>> did write some library code. I use a rt_heap as shared memory between =
8
>> processes on x86. According to the documentation H_NONCACHED is only
>> relevant for ARM, is that true?
>=20
> AFAIK, yes.
>=20
> Jan
>=20



--------------enig488D23A11AC1C63714DE8DCC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLqMFjIPTw9rIdn6oRAuRSAJ4w5OZzKnBQBBkD0BYAa8hmwq5/OgCZAZKs
/+Sgf3Uh4DCypVMPL1XUNyo=
=VuC7
-----END PGP SIGNATURE-----

--------------enig488D23A11AC1C63714DE8DCC--

