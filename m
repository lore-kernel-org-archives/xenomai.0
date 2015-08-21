From: =?iso-8859-1?Q?See=DFlen=2C_Maximilian?= <maximilian.seesslen@ifm.com>
Date: Fri, 21 Aug 2015 09:44:52 +0000
Message-ID: <4ac5d8524f864db989a3332282818783@dettmbx02.intra.ifm>
MIME-Version: 1.0
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] timer "host-timer" gets stopped
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,

we are using kernel 3.5.7 with xenomai 2.6.2.1 on an MPC5121 PPC architectu=
re. With xenomai 2.6.3 the problem also appeared.
The problem appears in combination with high system- and interrupt-load (vi=
a keys/gpio inputs). The keyboard-driver is non-xenomai.=20
Without key-input the problem did not appear.
=20
There are 2 timer;
=20
   ~ # cat /proc/xenomai/timerstat/master
   CPU  SCHEDULED   FIRED       TIMEOUT     INTERVAL    HANDLER      NAME  =
           STATUS  =20
   0    242075      232673      450150      -           NULL         [host-=
timer]     0       =20
   0    232245      232244      175250      -           xnthread_ti  cycle =
           0       =20
=20

For some reason the timer "[host-timer]" (aperiodic) stops after random tim=
e (statistically in an experiment set-up every 4 hours).=20
The status switches to "1" which means "XNTIMER_DEQUEUED".
As a result in the non-realtime-part no timing functions are usable any mor=
e. The system clock on console ("date") freezes.

Once the "host-timer" gets restarted manually the system runs again without=
 any problems.

We don't know where the host-timer usually gets restarted since it is an ap=
eriodic timer.
=20
Thanks for your help,
   Max



