Message-ID: <1404677764.4624.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Date: Sun, 6 Jul 2014 21:16:04 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Issue with cobalt_monitor_wait()
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=0AHi all,=0A=0Amaybe someone of you could help me with the following is=
sue of forge/cobalt=A0=0A(it seems complicated, I hope I will make sense):=
=0A=0AA queue test of freertos reproducibly causes a freeze in the followin=
g=0Asituation:=0A=0Aa thread has apparently both XNRELAX and XNWEAK set.=0A=
=0Asyncobj_lock() is called, i.e.=A0=0A=A0 cobalt_monitor_enter() -> sc_cob=
alt_monitor_enter=0A=0Asyncobj_wait_grant(); is called, i.e.=A0=0A=A0 cobal=
t_monitor_wait()=0A=A0 =A0 =A0 -> sc_cobalt_monitor_wait/cobalt_monitor_wai=
t() in kernel mode=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 info =3D xnsynch_sleep_on(=
); seems to be interrupted (opret =3D -EINTR)=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0=
 cobalt_monitor_enter_inner() also seems to return (ret =3D -EINTR)=0A=A0 =
=A0 =A0 -> if -EINTR in userspace call cobalt_monitor_wait() <=3D=3D=3D thi=
s seems to block indefinitely=0A=0AThis is where the application reliably f=
reezes... To summarize what happens=A0=0Ain cobalt_monitor_wait it in words=
:=0A=0A* cobalt_monitor_wait() is called with mon->gate locked=0A* the lock=
 is unlocked via xnsynch_release();=0A* xnsynch_sleep_on(synch, timeout, tm=
ode), which should wait for an event=A0=0A=A0 on my queue is interrupted an=
d returns XNBREAK.=0A* cobalt_monitor_enter_inner also return -EINTR.=0A* c=
obalt_monitor_wait() is left without mon->gate locked=0A* back in user spac=
e, cobalt_monitor_wait() calls cobalt_monitor_enter()=A0=0A=A0 when getting=
 -EINTR, which will retry as long as possible to lock=A0=0A=A0 the object.=
=0A* cobalt_monitor_enter() goes into kernel space to lock the object and=
=A0=0A=A0 never returns.=0A=0AOn thing I do not understand is:=0A=0Ain kern=
el cobalt_monitor_wait(), the synch object is unlocked via=0Axnsynch_releas=
e(). What happens if this synchobj was locked via=A0=0Amon->gate.fastlock ?=
 Shouldnt that also be released?=0A=0AWhat other reason could there be if t=
he synch object was released=A0=0Avia xnsynch_release, xnsynch_acquire was =
interrupted for=A0=0Axnsynch_release to block?=0A=0AThanks in advance for h=
elping me on this,=0AMatthias

