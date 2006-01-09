Message-ID: <43C1CFC2.8040104@domain.hid>
Date: Mon, 09 Jan 2006 03:51:46 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency kernel part crashes on ppc64
References: <43C12304.4040802@domain.hid>	<43C12CEC.8070403@domain.hid>	<43C14453.3040907@domain.hid>	<1136754149.17443.21.camel@domain.hid>
	<43C18CE1.5040509@domain.hid>
In-Reply-To: <43C18CE1.5040509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Stelian Pop wrote:
>=20
>>Le dimanche 08 janvier 2006 =E0 18:56 +0200, Heikki Lindholm a =E9crit =
:
>>
>>
>>
>>>>>Some recent changes (*cough* RTDM benchmark driver *cough*) broke ke=
rnel
>>>>>mode benchmarking for ppc64. Previously klatency worked fine, but no=
w
>>>>>latency -t 1 crashes somewhere in xnpod_schedule. Jan, any pending
>>>>>patches a comin'?
>>
>>
>>So it seems I'm not alone.=20
>>
>>I have done some additionnal debugging on this issue in the last days. =
I
>>still haven't find the bug but I narrowed it down a bit.
>>
>>
>>>>Nope, it should work as it is. But as Stelian also reported problems =
on
>>>>his fresh ARM port with the in-kernel test, I cannot exclude that the=
re
>>>>/might/ be a problem in the benchmark.
>>>>
>>>>As I don't have any ppc64 hanging around somewhere, we will have to g=
o
>>>>through this together. Things I would like to know:
>>>

Hi guys, it's "/me too" time here for ppc. My mpc5200 board is jumping ou=
t of the=20
window when running "./latency -t1", while "./latency -t2" works. No trac=
e dump,=20
hard freeze or spontaneous reboot, at your option. OPT_NUCLEUS_DEBUG spit=
s=20
nothing. No issue with the regular user-space test though.

x86 has no problem at all.

--=20

Philippe.

