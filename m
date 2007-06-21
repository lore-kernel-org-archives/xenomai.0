From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <190993.20668.qm@domain.hid>
References: <190993.20668.qm@domain.hid>
Content-Type: text/plain
Date: Thu, 21 Jun 2007 16:02:16 +0200
Message-Id: <1182434536.9709.62.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] Domain switching latencies
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: poornima r <rpoornar@domain.hid>
Cc: adeos-main@gna.org, wg@domain.hid

On Thu, 2007-06-21 at 05:59 -0700, poornima r wrote:
>         
>         We are very thankful to you for providing help and
>         guidance in running latency testsuites and other
>         assignments 
>         We are trying to measure context switching latencies
>         between primary and secondary domains with changes in
>         the
>         latency code as specified in the below link
>         http://www.mail-archive.com/xenomai@xenomai.org
>         
>         The following changes are done in the latency code and
>         the applications are attached
>         -------------------------------------------------------
>         1:Measured using linux call printf
>         err = rt_task_wait_period(&ov);
>         before = rt_timer_tsc();
>         printf(" ");

You are measuring time for buffered I/O operations, so your measure is
fundamentally flawed, since this jump won't ever jump to kernel space
unless the buffer gets full once in a while, and the stdio layer has to
sync. At the very least, switch buffering off using setbuf(), give a
newline into the string (depends on underlying termio setup in effect,
so this is unreliable) or simply invoke an actual system call, like
getpgrp() or getppid (and _not_ getpid() which is optimized using direct
fetches from PTDs).

>         after = rt_timer_tsc();
>         dt = (long)(after - before);
>         --------------------------------------------------------
>         2. Measure using Native API call
>         err = rt_task_wait_period(&ov);
>         before = rt_timer_tsc();
>         rt_task_set_mode (T_PRIMARY, NULL, NULL);
>         after = rt_timer_tsc();
>         dt = (long)(after - before);
>         ---------------------------------------------------------
>         The worst case latencies was around 20 us using printf
>         call and around 60 us when rt_task_set_mode was called
>         
-- 
Philippe.



