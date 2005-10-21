Message-ID: <4358BC0D.3010502@domain.hid>
Date: Fri, 21 Oct 2005 11:59:41 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Replacement for rt_save_flags_and_cli
References: <40292.128.93.15.41.1129793705.squirrel@domain.hid>
	<435766D6.6090605@domain.hid> <43576FA9.6010202@domain.hid>
	<4357C11B.3080103@domain.hid> <4357C464.5050206@domain.hid>
	<4357CC7D.2030907@domain.hid> <4357DF8F.9080403@domain.hid>
	<435897D8.8020708@domain.hid>
In-Reply-To: <435897D8.8020708@domain.hid>
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
To: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

Ignacio Garc=EDa P=E9rez wrote:
> Jan Kiszka wrote:
>=20
>=20
>>Ignacio Garc=EDa P=E9rez wrote:
>>=20
>>
>>
>>>>But: both primitives are rather low-level. Do you really need that
>>>>"hard" locks? What are you synchronising this way, IRQ handlers with
>>>>tasks, tasks with other tasks?
>>>>
>>>>
>>>>    =20
>>>>
>>>
>>>An IRQ handler with a task.
>>>
>>>Yeah, I know I could just use rt_intr_disable on that interrupt object=
,
>>>but for reasons too long to explain, the it is encapsulated in a piece
>>>of code and I'd rather not allow other code to see it. Probably not a
>>>good design but at this stage of the port, I'd like to get it working
>>>under xenomai with as little modifications as possible.
>>>
>>>Another place I've used it sometimes is substituting a mutex for very
>>>short pieces of code such as:
>>>
>>>cli()
>>>a =3D b + c;
>>>sti()
>>>
>>>It is usually more efficient that using a mutex, and this may be
>>>important in low-end processors with little horsepower.
>>>
>>>  =20
>>>
>>
>>Agree. But even when developing for a low-end UP system, it's good styl=
e
>>to use spinlocks (IRQ: xnlock_get, task: xnlock_get_irqsave) for it.
>>They will cause the same code to be generated on UP, but will continue
>>to work in case more CPUs pop up someday...
>>=20
>>
>=20
> Yup. Thank you for the tip. I have never worked with MP and never thoug=
h
> of that problem.
>=20
>=20
>>>Man, you just read my mind :-)
>>>
>>>I just have to say it:
>>>
>>>1- It is amazing that fusion has progressed from conception to its
>>>actual usable, stable state in such a short time.
>>>
>>>2- In general, I appreciate good design and robustness over efficiency
>>>and other issues, but IMHO, for real-time systems it must be the numbe=
r
>>>one priority, which I'm not sure it was in the "formerly related
>>>project". Too many large changes in too many time.
>>>
>>>3- The patent issue may not be a priority in the academic world, but i=
t
>>>definitely is for industrial applications.
>>>
>>>  =20
>>>
>>
>>I generally consider the last topic as a psychological issue: people in
>>industry feel better when they get farther away from well-known mined
>>places - although the whole area is full of more or less effective mine=
s
>>these days. As only few minelayers really try to trigger them but rathe=
r
>>use them more subtle, it's an issue, though.
>>=20
>>
>=20
> Well, actually I agree. I'm in the industry and I'm not that worried
> about the patent issue. What troubled me actually was not the fact that
> the "formerly related project" overrided the adeos protection, but
> rather the fact that the deceision seemed (to me) somewhat unilateral.
>=20

Seemed to me too, believe me.

--=20

Philippe.

