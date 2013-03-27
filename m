Message-ID: <1364419549.61697.YahooMailNeo@web161405.mail.bf1.yahoo.com>
Date: Wed, 27 Mar 2013 14:25:49 -0700 (PDT)
From: Tom Z <tomz30@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Xenomai: watchdog triggered -- signaling runaway thread
Reply-To: Tom Z <tomz30@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,=0AI am running Xenomai 2.6.2.1 on Ubuntu 12.04 (kernel 3.5.7), and all =
these things are running inside VMWare Player, and when I execute some user=
 space tasks, I noticed the following messages in the kernel message log (b=
y dmesg)=0ADuring one execution:=0A=0A[ 6079.315824] [sched_delayed] sched:=
 RT throttling activated=0A[34851.996274] hrtimer: interrupt took 541193159=
 ns=0A=0ADuring another execution which was run with the same programs agai=
n after the above execution terminates=0A=0A[72934.383249] Xenomai: watchdo=
g triggered -- signaling runaway thread 'target_task_6'=0A=0AThe user tasks=
 are very simple, they just periodic consume some CPU (by rt_wait_period & =
rt_timer_spin). =0A=0A=0AMy Xenomai was configured and installed according =
to this instruction:=0Ahttp://www.xenomai.org/index.php/Configuring_x86_ker=
nels=0A=0AWhat cause the above kernel messages? Are they related to the vir=
tual machine environment? BTW, my computer has an i-3 CPU which comes with =
hardware visualization.=0A=0A=0A=0AThanks,=0ATom=0A
