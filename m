Message-ID: <2ff1a98a0710290638i7204c9f7pfe4a26ecbe07af9f@domain.hid>
Date: Mon, 29 Oct 2007 14:38:45 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1193662459.4725d7fbcf9e6@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1193662459.4725d7fbcf9e6@domain.hid>
Subject: Re: [Xenomai-help] imx1 port.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: garryt <garryt@domain.hid>
Cc: xenomai@xenomai.org

On 10/29/07, garryt <garryt@domain.hid> wrote:
> Hello all,
>
> I had time to try again adeos+xenomai on a imx1 board. (i know this is quite
> old).

Thanks. The imx port should be integrated in the next I-pipe patch.

>
> This looks stable, i have been testing for several hours.
>
> I have followed the wiki documentation and performed some tests with xeno-test +
> ping flooding on this board, again i have no other *similar* board to compare
> results with, but here they are.
>
> I wonder if the difference between user-mode and in-kernel mode should be as
> much as this...

>From the tests I have seen so far, except those published by Adeneo,
there is always a great difference between user-mode an kernel-mode.
This is the price to pay for the comfort of user-space on ARM.

>
> By the way enabling ipipe tracer increase response time by a factor 2! is this
> ok with such HW ?

I guess so.

>
> I have attached the patch if someone is interested in, any remarks regarding
> this are welcome.

There is something suspicious, it is the loop:

 		do {
 			write_seqlock(&xtime_lock);
 			timer_tick();
+#ifdef CONFIG_IPIPE
+			last_jiffy_time += LATCH;
+#endif				/*  CONFIG_IPIPE */
 			write_sequnlock(&xtime_lock);
 			IMX_TCMP(TIMER_BASE) += evt_diff;
  	    } while (unlikely((int32_t) (IMX_TCMP(TIMER_BASE)
 					- IMX_TCN(TIMER_BASE)) < 0));

First, you should not touch IMX_TCMP(TIMER_BASE) in the loop, this is
done by __ipipe_mach_set_dec.

Second, with the current version of the I-pipe, the do/while loop
should be disabled when CONFIG_IPIPE is enabled. However, this is
going to change in the next version of I-pipe because of the so-called
"flat log" optimization, but I think IMX_TCMP(TIMER_BASE) should be
replaced with last_jiffy_time, because IMX_TCMP(TIMER_BASE) is the
date of the previous hardware timer tick, but the previous hardware
timer tick is not necessarily Linux timer previous tick. Anyway, I
will try and fix this and send a patch for testing.

>
>
> All tests have been performed with xeno-test +  ping flooding the board.

For a load that give worse figures, run the calibrator
http://www.cwi.nl/~manegold/Calibrator


-- 
                                               Gilles Chanteperdrix

