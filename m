Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] driver migration
Date: Thu, 14 Sep 2006 15:07:17 +0530
Message-ID: <9D98C51005D80D43A19A3DF329A61D69515624@domain.hid>
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

>Performance will remain a reason to go to kernel-space, specifically if
>you either share your device between multiple processes (having a
driver
>in a separate process comes at a price...) or if you need low latency
on
>IRQ handling. But there are also reasons to go to user-space, e.g.
>license issues. We are trying to address both.

Nilanjan :- Can I assume you are saying the latency is less when I run
my interrupt processing code as an real time ISR rather than a user -
space=20
Thread ?
In that case I can run the ISR in kernel mode and signal the user space
RT task by a semaphore ( the user space task will bind this).


-----Original Message-----
From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid
Sent: Thursday, September 14, 2006 2:57 PM
To: Nilanjan Roychowdhury
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] driver migration

Nilanjan Roychowdhury wrote:
>=20
>=20
> Hi,
> I had a linux driver with functionalities like it blocks a thread on
an
> ioctl and wakes it up when an interrupt occurs and does some
processing.
> Now I want to migrate to xenomai space. Can I write a user  space
device
> driver for this like I create an user space rt_task and call
> rt_intr_wait in the entry fuction of the task and whenever I get an
> interrupt I wake up and do the processing. Will I have any performance
> hit?? I will make sure the priority of this xenomai task is higher
than
> any other xenomai task as it will do some interrupt processing.
>=20
> In general, if I need to migrate a traditional linux device driver
with
> only user space clients to xenomai space can I write a user - space
> device driver ???

You can. Both native and posix skin provide means to block a user-space
thread on an IRQ event. And if you already have a working user-space
driver, that step should be simple as there are likely no problems with
kernel-only services like DMA management.

It is planned to enhance the Real-Time Driver Model (RTDM) with
user-space support as well, keeping both the programming model for the
driver users (profiles) as well as for the driver developers as far as
feasible. The idea is to make drivers easily re-compilable/portable
between kernel and user-space - but that's something which cannot help
you yet.

>=20
> Under what scenario we place a driver as a kernel module in xenomai
> space??

Performance will remain a reason to go to kernel-space, specifically if
you either share your device between multiple processes (having a driver
in a separate process comes at a price...) or if you need low latency on
IRQ handling. But there are also reasons to go to user-space, e.g.
license issues. We are trying to address both.

In any case, a clear separation between driver and application design is
highly recommended and something we try to foster with RTDM.

Jan


