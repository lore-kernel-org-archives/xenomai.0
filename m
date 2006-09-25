Subject: Re: [Xenomai-core] Problem with periodic timer on PPC40x solved
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200609252229.56854.niklaus.giger@domain.hid>
References: <200609232013.27649.niklaus.giger@domain.hid>
	<4516F39A.7040603@domain.hid> <1159199854.4970.19.camel@domain.hid>
	<200609252229.56854.niklaus.giger@domain.hid>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 22:59:47 +0200
Message-Id: <1159217987.4981.10.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

On Mon, 2006-09-25 at 22:29 +0200, Niklaus Giger wrote:
> Am Montag, 25. September 2006 17:57 schrieb Philippe Gerum:
> > On Sun, 2006-09-24 at 23:07 +0200, Wolfgang Grandegger wrote:
> > > Niklaus Giger wrote:
> <..>
> > Ok, we can go for the lazy fix here, since this code is poised to
> > disappear anyway. I've merged a variant of the above we already use for
> > the ARM port, which scales down the period to microseconds instead of
> > losing precision on the count of timebase ticks per jiffy.
> >
> > - ticks = ns * tb_ticks_per_jiffy / (1000000000 / HZ);
> > + ticks = (ns / 1000) * tb_ticks_per_jiffy / (1000000 / HZ);
> Thanks for finding this solution. I tried to understand mulhwu and 
> mulhwu_scale_factor but couldn't figure out a correct solution in a short 
> time.
> 
> The buildbot cannot presently power on and off my PPC405 target board, as the 
> my power outlet switching device is broken and has been sent back for a 
> remplacement.
> 
> I did however run some tests manually and have the following questions about 
> the output:
> Why do I get negative values for latenciy values?

Because the timer shot anticipation in /proc/xenomai/latency is too
large for the target, which in fact has a lower intrinsic latency than
expected. The default calibration values are obtained from
include/asm-*/calibration.h.

> Is the output of lines like "Xenomai: Switching display-3238 to secondary mode 
> after exception #1025 from user-space at 0x100033c4 (pid 3240)" harmless or 
> the result of a activated CONFIG_XENO_OPT_DEBUG<..> option?
> 

Oops. It's bad news. A memory access error occured while running the
test. Which Xenomai/Adeos combo are you currently running on the 4xx?

> Mon Sep 25 20:20:33 UTC 2006
> running: ./run -- -T 5 -t2 # latency
> *
> *
> * Type ^C to stop this application.
> *
> Xenomai: Switching display-3238 to secondary mode after exception #1025 from 
> user-space at 0x100033c4 (pid 3240)
> == Sampling period: 100 us
> == Test mode: in-kernel timer handler
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (in-kernel timer handler, 100 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
> RTD|      -5.108|      -4.754|      -0.905|       0|      -5.108|      -0.905
> RTD|      -4.963|      -4.871|       1.155|       0|      -5.108|       1.155
> Xenomai: Switching display-3238 to secondary mode after exception #1025 from 
> user-space at 0xfda9638 (pid 3240)
> RTD|      -4.963|      -4.758|      16.020|       0|      -5.108|      16.020
> RTD|      -6.313|      -4.861|      10.980|       0|      -6.313|      16.020
> Xenomai: Switching display-3238 to secondary mode after exception #1025 from 
> user-space at 0xfe7c1c4 (pid 3240)
> ---|------------|------------|------------|--------|-------------------------
> RTS|      -6.313|      -4.811|      16.020|       0|    00:00:05/00:00:05
> Xenomai: stopping RTDM services.
> 
> Best regards
-- 
Philippe.



