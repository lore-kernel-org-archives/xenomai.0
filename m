Message-ID: <435807DC.9090303@domain.hid>
Date: Thu, 20 Oct 2005 23:10:52 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Replacement for rt_save_flags_and_cli
References: <40292.128.93.15.41.1129793705.squirrel@domain.hid>
	<435766D6.6090605@domain.hid> <43576FA9.6010202@domain.hid>
	<4357C11B.3080103@domain.hid> <4357C464.5050206@domain.hid>
	<4357CC7D.2030907@domain.hid> <4357DF8F.9080403@domain.hid>
In-Reply-To: <4357DF8F.9080403@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Ignacio Garc=EDa P=E9rez wrote:
>=20
>>>But: both primitives are rather low-level. Do you really need that
>>>"hard" locks? What are you synchronising this way, IRQ handlers with
>>>tasks, tasks with other tasks?
>>>
>>>
>>
>>An IRQ handler with a task.
>>
>>Yeah, I know I could just use rt_intr_disable on that interrupt object,
>>but for reasons too long to explain, the it is encapsulated in a piece
>>of code and I'd rather not allow other code to see it. Probably not a
>>good design but at this stage of the port, I'd like to get it working
>>under xenomai with as little modifications as possible.
>>
>>Another place I've used it sometimes is substituting a mutex for very
>>short pieces of code such as:
>>
>>cli()
>>a =3D b + c;
>>sti()
>>
>>It is usually more efficient that using a mutex, and this may be
>>important in low-end processors with little horsepower.
>>
>=20
>=20
> Agree. But even when developing for a low-end UP system, it's good styl=
e
> to use spinlocks (IRQ: xnlock_get, task: xnlock_get_irqsave) for it.
> They will cause the same code to be generated on UP, but will continue
> to work in case more CPUs pop up someday...
>=20

I would disagree regarding one situation though: the actual SMP one, when=
 the=20
construct is really a matter of local preemption. In the case above, usin=
g a=20
spinlock would uselessly prevent two CPUs or more from entering the same =
section=20
of code, albeit one only needs to keep interrupt-safe on the local proces=
sor in=20
order to avoid unwanted preemption. Additionally, the only way to go to s=
leep=20
safely holding the spinlock would be to use the nucleus lock, in which ca=
se the=20
potential for contention would be even higher.

--=20

Philippe.

