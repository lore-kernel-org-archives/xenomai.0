Message-ID: <45DECFAF.60304@domain.hid>
Date: Fri, 23 Feb 2007 12:27:43 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] latency hangs on AT91RM9200
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

Hi,

i pick up this issue again.

I am running 2.6.19 + adeos-ipipe-2.6.19-arm-1.6-02.patch + xenomai-svn-2007-02-22
on an AT91RM9200 (160MHz/80MHz).

When starting "latency -p 200" it runs for a while printing

RTT|  00:05:37  (periodic user-mode task, 200 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      11.200|     139.200|     236.800|       1|      10.800|     280.800
RTD|      11.200|     146.400|     253.200|       1|      10.800|     280.800
RTD|      11.200|     144.400|     240.400|       1|      10.800|     280.800

but then hangs. The timer LED stops blinking. No "soft lockup detected" appears.

Using a BDI200 it looks like that in kernel/sched.c:schedule() he is returning
in the lines

#ifdef CONFIG_IPIPE
        if (unlikely(!ipipe_root_domain_p))
                return;
#endif /* CONFIG_IPIPE */

When stepping trough I only see him getting into schedule() but leaving
it in the above lines and in include/linux/proc_fs.h:proc_net_fops_create() ...

-- 
Steven

