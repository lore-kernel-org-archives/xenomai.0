From: =?iso-8859-1?Q?Lassi_Niemist=F6?= <lassi.niemisto@wapice.com>
Date: Mon, 13 Jun 2016 14:01:10 +0000
Message-ID: <09ef98ed5f8a438fa3703a3e3f5736f5@EDB2.wapice.localdomain>
References: <47132d04b76942d8bd15c82a5a460f7b@EDB3.wapice.localdomain>
 <20160403190948.GC20399@hermes.click-hack.org>
 <20160430064939.GC1781@hermes.click-hack.org>  
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] PowerPC hardware watchpoints unstable with GDB and Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

Note: please keep gdb@sourceware.org as a recipient - I tried to post on bo=
th but xenomai rejected due to missing membership and I do not want to re-p=
ost on gdb..=20

I am trying to debug (applications, not kernel) using hardware watchpoints =
(memory breakpoints) with=20

GDB: 7.10.1 and 7.11 (local mode)
Processor: PowerPC e300c3 (MPC8309E)
Xenomai: 2.6.1
Linux: 3.1.10-ipipe

I have two issues:

1) If I set up a while(1) loop with (a global) counter and sleep, and place=
 the watchpoint on the counter variable, I get GDB to break nicely to each =
increment if I use usleep() in my loop. Instead, if I use rt_task_sleep(), =
the watchpoint may go unnoticed for up to 100 loops, then trigger, then aga=
in go unnoticed for 5 loops and so on. Triggering happens on correct line, =
though. This is reproducable with a simple C main with only rt_task_shadow =
and the loop.=20

2) The watchpoint seems to go broken (at least sometimes) when new (rt) thr=
eads are being created. The GDB still thinks the watchpoint exists, but it =
never gets triggered. If I remove the wp and create it again, it starts tri=
ggering. This finding I will investigate further and see if it is reproduca=
ble with simple test code.

Are these known issues? I found only little information about using watchpo=
ints on xenomai, so is it something rarely used? Or is the PowerPC integrat=
ion the broken part here? GDB, in turn, has had some patches on the hardwar=
e-watchpoint inheritance at thread creation, so I would assume that it at l=
east "should work". Any hints for debugging the issue further?

BR,
Lassi Niemist=F6
Wapice Oy
Vaasa, Finland

