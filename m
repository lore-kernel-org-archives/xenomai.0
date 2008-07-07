MIME-Version: 1.0
Date: Mon, 7 Jul 2008 11:49:46 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <4871CA89.8060703@domain.hid>
References: <4871CA89.8060703@domain.hid>
Message-ID: <5883386fa4d9312cda538cb80f032180@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
Reply-To: matthieu.connaulte_xenomai@domain.hid
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

Hi

Well I'm going to try to be clear :

I work on a project that aims at migrating VxWorks tasks from PPC boards =
on
VME crate to X86 Computer ruuning with Linux. The cost of using Xenomai A=
PI
instead of vxworks skin seems very costly. The idea is to keep the maximu=
m
of mechanisms.

As there is no implementation of vxworks periodic task instruction, the
idea was to use watchdogs. In fact, as watchdogs are counting from ticks,
it's easy to make tasks periodic if the period of the task is a multiple =
of
the tick period. So each task starts it's watchdog, executes some routine=
,
and suspends itself. The watchdog, when the specified delay ticks elapsed=
,
resumes the task. And so on...

The use of multiple PPC boards, with periodic tasks that need to be
synchronized, has required the use of an hardware interrupt, spread to al=
l
CPUs, and which handler tickAnnouce() vxworks. I know that this mechanism
isn't still necessary as there is only one vxworks tick on Xenomai, even =
if
I work with many CPUs. But in the new configuration, I have a PCI card th=
at
will send this interrupt. So I need to stop the automatic vxworks tick wi=
th
tick_arg=3D0 and to handle this interrupt to tickAnnouce() manually. As I
will don't have this card all the day, I need to simulate this mecanism,
and I need to create something that will tickAnnouce() at a periodic time=
.

I created a module that, in on case, will handle the interrupt, and on an
other case, will create a xenomai rt_task that tickAnnouce. And this
doesn't work. I want the ioctl method send the period to the module in
order to modify the period of the tick.

I still have created this driver has you see but it doesn't work. I'm goi=
ng
to test your modifications. Thank you for that.

I will also need to get a precise time, and Gilles suggest me to use
xntbase, but xntbase_get_time(&nktbase); isn't recognized. I will see mor=
e
information in the timebase programming documentation I think.
(http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__tim=
ebase.html
?)

I hope these information will help you in understanding what i want to
archieve.

Thank you again for you help

Matthieu



