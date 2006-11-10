Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Xenomai Kernel limits
Date: Fri, 10 Nov 2006 14:00:41 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB0154E67A@is-hdq-exchange.marel.net>
In-Reply-To: <45548032.9040400@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi Jan,


jan.kiszka@domain.hid wrote:
> Maybe that bug is a symptom of some other scalability issue.

I suppose so, too.
=20
>> +++
>> bash-2.05b# cat /proc/heap
>> size=3D131072:used=3D134400:pagesz=3D512
>> +++
>>=20
>> This looks odd. Either the output is misleading or we have used more
>> resources than possible. But then I would expect that the Xenomai
>> initialization routines (e.g. pthread_create(), rt_dev_open(), etc.)
>> should return with an error. Either should be fixed, I suppose.
>=20
> Every services that allocates memory from the real-time heap should
> fail now. If it doesn't (pthread_create is a good test candidate
> here), we "only" face a statistics bug. Can you confirm that starting
> further applications only increases the used counter but otherwise
> works?   =20

I was running the cyclictest and the switchbench without problems at the
same time and the /proc/xenomai/heap showed even a usage of 135 kBytes.
So I assume that is a statistics bug.

>> I configured Xenomai in the Kernel with the following values, but
>> please bear in mind that was after I thought about a resource
>> shortage:=20
>>=20
>> CONFIG_XENO_OPT_PIPE_NRDEV=3D320
>=20
> This looks exceptional. Do you really use pipes that heavily?

We do not use pipes at all. Just shooting around in the forest ....
Which pipes are meant here actually ? Native Pipes ? Which effect does
this option have if I did not compile in support for Pipes of the native
API ? Again: a comprehensive description of these options would probably
help. Is it possible to get these inside 2.4 Kernel as well ?

>> CONFIG_XENO_OPT_REGISTRY_NRSLOTS=3D2560
>=20
> Do you every have so many registered objects active in parallel?
> Should be no problem, but I wonder if it is needed.=20

Well per default it is set to 256. We are using more IPC objects. So I
increased it by 10 times to be on the safe side. I do not know what
actually can occupy a "registry slot". Explanation ?

>> - I realized that when setting CONFIG_XENO_DRIVERS_RTCAN_RXBUF_SIZE
>> to 131072, my application does not run. Which are the upper limits I
>> can=20
>> set for all the configurable Xenomai parameters ?
>=20
> That buffer is part of each CAN socket instance which is allocated
> via kmalloc - hence the 132K limit here. But you shouldn't normally
> need such large intermediate buffers when no CAN receiver gets
> delayed unreasonably long.  =20

Right, the default of 1024 should be pretty enough, despite we had to
increae it to 8096 not to get any receive socket buffer overflow
messages. Investigation pending ...
I understand that kmalloc has 132K limit. But if I allocate 131072 bytes
this is within the limits of kmalloc I suppose.


> It melts down that you will have to try to isolate the reason(s) for
> unexpected behaviours. I suspect some internal buffer overrun that
> causes all those ugly side effects. =20
>=20
> Can you try to scale your app down, remove features/service calls so
> that subsystems can be excluded systematically?=20

I feared you asked for that. Well yes, this will actually be the tough
task to do, I suppose. Will need quite a time though. Until then: any
debugging trick I could try as well ?


Best regards,

Daniel.

