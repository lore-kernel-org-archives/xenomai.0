From: "Reitinger, Peter" <preitinger@carl-valentin.de>
Date: Mon, 4 Aug 2014 12:42:24 +0000
Message-ID: <431b7669858a4c3584ec344ec4b5a752@CVEX13.valentin-carl.de>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] RTNet, CONFIG_XENO_DRIVERS_16550A, Kernel 3.14,
	preempt_rt patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Xenomai people,

I read about RTNet 0.9.13 that it supports only Linux Kernels up to 3.2.
Is this still up-to-date? Or is there a new version (maybe not yet released=
) that is compatible with a newer Linux kernel, preferrable 3.14 or above?

I had problems to use rt_dev_send and receive, but now I noticed that in my=
 kernel config CONFIG_XENO_DRIVERS_16550A has not been set. Is CONFIG_XENO_=
DRIVERS_16550A required for usage of rt_dev_send? If yes, is CONFIG_XENO_DR=
IVERS_16550A compatible with kernel 3.14.0?

Is there a relation between RTNet and CONFIG_XENO_DRIVERS_16550A?

I also wonder if it is possible to use the RT_PREEMPT patch on 3.14 togethe=
r with xenomai? Do I have to do a 3-way merge to achieve this goal? I mean =
patch xenomai onto vanilla kernel 3.14. and then merge the patch for preemp=
t_rt or in the other order?

Many thanks in advance also for former help...

Kind regards
Peter Reitinger
