Date: Fri, 21 Aug 2015 11:56:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150821095651.GB12742@hermes.click-hack.org>
References: <4ac5d8524f864db989a3332282818783@dettmbx02.intra.ifm>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4ac5d8524f864db989a3332282818783@dettmbx02.intra.ifm>
Subject: Re: [Xenomai] timer "host-timer" gets stopped
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?iso-8859-1?Q?See=DFlen=2C?= Maximilian <maximilian.seesslen@ifm.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Aug 21, 2015 at 09:44:52AM +0000, See=DFlen, Maximilian wrote:
> Hi all,
>=20
> we are using kernel 3.5.7 with xenomai 2.6.2.1 on an MPC5121 PPC
> architecture. With xenomai 2.6.3 the problem also appeared.

Xenomai latest stable version is 2.6.4.

What data structure do you use for Xenomai timers, list, heap, or
wheel?

> The problem appears in combination with high system- and interrupt-load (=
via keys/gpio inputs). The keyboard-driver is non-xenomai.=20
> Without key-input the problem did not appear.
> =20
> There are 2 timer;
> =20
>    ~ # cat /proc/xenomai/timerstat/master
>    CPU  SCHEDULED   FIRED       TIMEOUT     INTERVAL    HANDLER      NAME=
             STATUS  =20
>    0    242075      232673      450150      -           NULL         [hos=
t-timer]     0       =20
>    0    232245      232244      175250      -           xnthread_ti  cycl=
e            0       =20
> =20
>=20
> For some reason the timer "[host-timer]" (aperiodic) stops after random t=
ime (statistically in an experiment set-up every 4 hours).=20
> The status switches to "1" which means "XNTIMER_DEQUEUED".
> As a result in the non-realtime-part no timing functions are usable any m=
ore. The system clock on console ("date") freezes.
>=20
> Once the "host-timer" gets restarted manually the system runs again witho=
ut any problems.
>=20
> We don't know where the host-timer usually gets restarted since it
> is an aperiodic timer.

It is aperiodic if you selected one-shot mode in Linux
configuration, periodic if you are running Linux in periodic mode.

In one-shot mode, Linux reprogramming its timer ends-up requeuing the
timer at Xenomai level. When Xenomai takes over the management of
the host timer, it installs its own callbacks in the Linux
clockevents structure, the installed callback is
xnarch_next_htick_shot, which you can find in
include/asm-generic/bits/pod.h

--=20
					    Gilles.
https://click-hack.org

