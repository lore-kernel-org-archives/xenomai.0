Message-ID: <43D8A936.3010500@domain.hid>
Date: Thu, 26 Jan 2006 08:49:26 -0200
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
MIME-Version: 1.0
References: <200601251552.10271.lbocseg@domain.hid>
	<43D7D7E3.3040804@domain.hid> <43D81B11.2020809@domain.hid>
	<43D8891D.7000405@domain.hid>
In-Reply-To: <43D8891D.7000405@domain.hid>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Re: RTDM and udelay
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
Cc: xenomai@xenomai.org


>>>>Is there any alternative to udelay on RTDM?
>>>>
>>>>Or should I do something like:
>>>>
>>>>void rt_udelay(unsigned int usec) {
>>>> uint64_t timeout =3D rtdm_clock_read () + usec;
>>>> while (rtdm_clock_read () < timeout);
>>>>}
>>>> =20
>>>>       =20
>>>>
>>>You mean something like this: =3D:)
>>>
>>>http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/rtdm/drvlib=
.c?v=3DSVN-trunk#L366
>>>     =20
>>>
>>Yes, but it seemed too complex for me, since it disables IRQ and I do
>>not need this feature. It will no problem if, instead of waiting 2us, I
>>   =20
>>
>Are we talking about the same function??? Don't think so.
> =20
>
Is there any related function that do not disable IRQ? I know it is not=20
a big deal and I'll use the suggested function if there is no=20
alternative, but I would prefer using some delay function that will not=20
disable interrupts when delaying.

>>have to wait 100us because some interrupt has occurred. After I write to
>>the board i2c registers, I need to wait *at least*, say, 2us before
>>writing another i2c cycle.
>>   =20
>>
>
>Then this is the perfect choice for you.
>
> =20
>
>>One more thing: although the name of the function has the word "task", I
>>think it is not task specific. Documentation even says it can be called
>>from initialization/cleanup code. But it doesn't say if it can be called
>>from an ioctl handler or any other context, although I see no problem
>>when reviewing the code. Thus, I think a better name would be something
>>like rtdm_busy_sleep() or rtdm_ns_delay(). Just a suggestion.
>>   =20
>>
>
>The idea is to put most functions into some related group. As
>rtdm_task_busy_sleep() is an alternative to rtdm_task_sleep(), I placed
>them close to each other in the doc, i.e. in the same group (rtdm_task_xxx=
).
>
>Note that an ioctl handler (just like any device operation handler) has
>no separate context. Depending on if we are talking about the _rt or the
>_nrt handler, it either executes in a RT task or in non-RT context,
>invoked by a user space or kernel space caller. All this is covered by
>the environments listed for rtdm_task_busy_sleep.
> =20
>
Thanks for clarifying. One more doubt. Suppose my driver has only the=20
non-RT close handler. If the user close the file descriptor from a=20
RT-context, it will call the non-RT close handler? If yes, will that=20
handler be called in a RT-context? If not, could I use the same handler=20
(function) for both RT and non-RT handlers?

Thank you again,

Rodrigo.


=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



