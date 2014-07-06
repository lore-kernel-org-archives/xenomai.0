References: <1404640109.73994.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53B964DC.1020004@xenomai.org>
 <1404662453.79446.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53B974A3.5010004@xenomai.org>
Message-ID: <1404664284.37181.YahooMailNeo@web171606.mail.ir2.yahoo.com>
Date: Sun, 6 Jul 2014 17:31:24 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53B974A3.5010004@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] issue with cobalt/timer: avoid periodic timer drift
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=0A=0A=0A----- Original Message -----=0A> From: Gilles Chanteperdrix <gi=
lles.chanteperdrix@xenomai.org>=0A> To: Matthias Schneider <ma30002000@yaho=
o.de>; "xenomai@xenomai.org" <xenomai@xenomai.org>=0A> Cc: =0A> Sent: Sunda=
y, July 6, 2014 6:09 PM=0A> Subject: Re: [Xenomai] issue with cobalt/timer:=
 avoid periodic timer drift=0A> =0A> On 07/06/2014 06:00 PM, Matthias Schne=
ider wrote:=0A>>>  You seem to have created a periodic timer with a null pe=
riod. Could you=0A>>>  post a sample code allowing to reproduce this issue?=
=0A>>> =A0 =0A>> =0A>> =0A>>  This happens in most of my freertos apps (e.g=
. demo, etc.). However, =0A>>  I have not put any effort in narrowing the p=
roblem down, in the hope=0A>>  the problem would be deductible from the ker=
nel state. Maybe you could=0A>>  give a few hints where a periodic timer co=
uld come into play? In the=0A>>  freertos skin there are only tasks, queues=
 and semaphores, so I=0A>>  am not creating any periodic timer explicitly. =
Are there occasiosn=0A>>  when periodic timers are being created implicitly=
 using the three=0A>>  primitives mentioned above? Or can I configure an in=
telligent=0A>>  breakpoint to catch the creation of a periodic timer?=0A> =
=0A> Maybe you could put a breakpoint to see where xntimer_start is called?=
=0A=0A=0AI have already had the idea, unfortunately it seems to be called a=
ll=0Athe time:=0A=0A#0  xntimer_start (timer=3D0xc06b7628 <nksched+24>, val=
ue=3D405804, interval=3Dinterval@entry=3D0, mode=3Dmode@entry=3DXN_RELATIVE=
) at kernel/xenomai/timer.c:104=0A#1  0xc00ca504 in program_htick_shot (del=
ay=3D<optimized out>, cdev=3D<optimized out>) at kernel/xenomai/timer.c:572=
=0A#2  0xc007407c in clockevents_program_event (dev=3D0xc06a65c0 <clockeven=
t_gpt>, expires=3D..., force=3Dforce@entry=3Dfalse) at kernel/time/clockeve=
nts.c:269=0A#3  0xc0074a54 in tick_program_event (expires=3D..., force=3Dfo=
rce@entry=3D0) at kernel/time/tick-oneshot.c:31=0A#4  0xc0050974 in hrtimer=
_interrupt (dev=3D<optimized out>) at kernel/hrtimer.c:1360=0A=0AAny other =
idea?

