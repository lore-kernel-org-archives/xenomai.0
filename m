Message-ID: <47270861.8090500@domain.hid>
Date: Tue, 30 Oct 2007 11:33:05 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1078761341.20071030094041@domain.hid>
	<4726F2B5.5000307@domain.hid>
	<1935435350.20071030105318@domain.hid>
In-Reply-To: <1935435350.20071030105318@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] how to stop a runaway task
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Carsten_Spie=DF?= <mail@domain.hid>
Cc: xenomai@xenomai.org

Carsten Spie=DF wrote:
> Hello Philippe,
>=20
>>> But this approach didn't work, the higer prio task isn't called unless
>>> the lower prio task gives up cpu (by calling e.g. rt_task_yield or
>>> nanosleep) (see attached demo source)
>> This would basically say that the core does not give any real-time
>> guarantee.
> I hope this is not the case.
>> Please send some demo code showing this.
> I've attached it, please remove the rt_task_yield to see the effect.
>>> When not being cooperative (removing the rt_task_yield in the demo)
>>> my system is reset after some seconds.

This works fine on 2.4-rc4/x86-2.6.22 here, so I need to switch to a
similar ppc configuration to try reproducing it. More news later. Please
send your kernel .config for 2.4.25 in the meantime.

>>>
>>> Why isn't my supervising task scheduled?
>>>
>=20
>> Try enabling the nucleus watchdog (Xenomai debug options). It does kill
>> runaway tasks.
> O.k. i will try this.

You will have to remove the printf() from the low prio task for the
nucleus watchdog to detect the runaway situation, otherwise, your task
would be considered as being under the control of the Linux scheduler
until it issues a blocking Xenomai syscall (which it never does), and
therefore escape the watchdog detection. That's the particular case I
was talking about.

>=20
>> If this works on your setup, then your code must be
>> wrong. If it does not trigger, then we need to understand why  -- there
>> is one case where it may not trigger, but this does not involve any
>> breakage in task management.
>=20
> Regards Carsten


--=20
Philippe.

