Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] driver migration
Date: Thu, 14 Sep 2006 15:22:28 +0530
Message-ID: <9D98C51005D80D43A19A3DF329A61D69515626@domain.hid>
From: "Nilanjan Roychowdhury" <Nilanjan.Roychowdhury@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

Jan,
I have a question on RTDM. Lets say I have chosen Xenomai as the FIRST
platform to develop my driver with a plan to move my driver to an RTOS
in future. And lets say this RTOS does not have an IO system. Does not
understand any /dev/XXX entry. In that RTOS you have tasks waiting for
events and you post the events from an ISR ( lets say by a message
queue).

In that case, do you suggest I go for RTDM. Or I just try to mimic the
same RTOS behavior by RT interrupts and rt tasks ??
-Nilanjan

-----Original Message-----
From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid
Sent: Thursday, September 14, 2006 3:11 PM
To: Nilanjan Roychowdhury
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] driver migration

Nilanjan Roychowdhury wrote:
>> Performance will remain a reason to go to kernel-space, specifically
if
>> you either share your device between multiple processes (having a
> driver
>> in a separate process comes at a price...) or if you need low latency
> on
>> IRQ handling. But there are also reasons to go to user-space, e.g.
>> license issues. We are trying to address both.
>=20
> Nilanjan :- Can I assume you are saying the latency is less when I run
> my interrupt processing code as an real time ISR rather than a user -
> space=20
> Thread ?

Yes, of course. Check the irqbench test for real numbers on your target
system.

> In that case I can run the ISR in kernel mode and signal the user
space
> RT task by a semaphore ( the user space task will bind this).

That would be the classic design if you have some simple job to do on
IRQ delivery (some direct fiddling with the hardware e.g.) + you want to
wakeup a thread waiting on the event. In this case you can use RTDM for
the in-kernel part and attach your application to the RTDM device your
driver will then export.

Jan


