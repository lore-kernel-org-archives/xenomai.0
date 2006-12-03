Subject: Re: =?ISO-8859-1?Q?R=E9p=2E?= : Re: [Xenomai-help]  Switch mode
	with x86
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45732660.6050605@domain.hid>
References: <s56d88c0.099@domain.hid>  <45732660.6050605@domain.hid>
Content-Type: text/plain
Date: Sun, 03 Dec 2006 22:02:37 +0100
Message-Id: <1165179758.4952.454.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2006-12-03 at 20:32 +0100, Jan Kiszka wrote:
> Nicolas BLANCHARD wrote:
> >>>>> "Nicolas BLANCHARD" <n.blanchard@domain.hid> 29.11 11:25 >>>
> >> Hello,
> >>
> >> I've tested wiith Xenomai 2.3-rc2 (adeos 1.5-02)
> >> and change the config : 
> >>                                        - CONFIG_M586
> >>                                        - disable CONFIG_INPUT_PCSPKR
> > (it was on module)
> >>                                        - disable prio boosting (check
> > CONFIG_XENO_OPT_RPDISALBLE)
> >> and it seems to work better, one hour without blocking, it's a record
> >> for me.
> >>
> >> So, i will investigate to find which modification improve my problem.
> > 
> > After somes tests (kernel compil), it seems that prio boost is
> > responsable of my
> > problem. When it's disable (kernel option checked) my program run
> > correctly.
> 
> Confirmed!
> 
> root@domain.hid :/root# cat /proc/xenomai/sched
> CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
>   0  0       99      0        0          R          ROOT
>   0  837     99      9999312  0          X          TASK1
>   0  838      0      10999998 0          R          TASK2
> 
> So far "only" on real hardware (P-I 133) with CONFIG_M586 and (this is
> likely also very important) CONFIG_PREEMPT. I'm now about to check if I
> can migrate this problem into qemu and/or capture it with the I-pipe tracer.
> 

I did not jump on that initially, but if task2 is supposedly in ready
state, then there must be a rescheduling missing somewhere, maybe task2
trying to migrate to primary mode, and for some reason, no rescheduling
took place on behalf of the gatekeeper. It would be interesting to know
the output of /proc/xenomai/stat, to get the full task states.

> Jan
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



