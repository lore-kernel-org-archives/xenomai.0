Message-ID: <4A7BC4DC.70209@domain.hid>
Date: Fri, 07 Aug 2009 08:08:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <abaf774b0908040623w1583f930xda88c125b64394b1@domain.hid>
In-Reply-To: <abaf774b0908040623w1583f930xda88c125b64394b1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5-rc2 clock_gettime bad tv_nsec value
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve <sbxenomai@domain.hid>
Cc: xenomai@xenomai.org

Steve wrote:
> Hi,
> 
> Using Xenomai 2.5-rc2 on Linux 2.6.29.4 the following code
> periodically produces a bad result:
> 
> clock_gettime(CLOCK_REALTIME, timespec);
> 
> Where it assigns a timespec.tv_nsec that is greater than 1000 million.
>  If it helps the maximum returned value that i have seen before tv_sec
> increments and tv_nsec returns to a 'safe' value is 1048044075.
> 
> This does not happen using Xenomai 2.4.8 on the same Linux kernel.
> There are some differences between the kernel config files used for my
> 2.4.8 setup and 2.5-rc2 setup, but I don't imagine that that is the
> problem.
> 
> Any thoughts?

Well, yes. Xenomai 2.5-rc2 has been modified to do the conversion 
between ticks and timespec without divisions. I am afraid in some cases 
we are wrong (essentially, we replace the division with a 
multiplication, but it is entirely possible that the result of the 
multiplication is off by one, and so when computing the remainder, we 
get a too large value). Could you apply the following patch? It will 
modify clock_gettime implementation in kernel-space to print the value 
before conversion when the bug happens. Also tell us if you are running
in periodic mode or aperiodic mode (if you do not know, then you are
running in aperiodic mode).

diff --git a/ksrc/skins/posix/clock.c b/ksrc/skins/posix/clock.c
index 553e123..63a42fa 100644
--- a/ksrc/skins/posix/clock.c
+++ b/ksrc/skins/posix/clock.c
@@ -117,7 +117,10 @@ int clock_gettime(clockid_t clock_id, struct timespec *tp)

        switch (clock_id) {
        case CLOCK_REALTIME:
-               ticks2ts(tp, xntbase_get_time(pse51_tbase));
+               cpu_time = xntbase_get_time(pse51_tbase);
+               ticks2ts(tp, cpu_time);
+               if (tp->tv_nsec > 1000000000)
+                       printk("Bad conversion, time: %llu\n", cpu_time);
                break;

        case CLOCK_MONOTONIC:


-- 
					    Gilles.

