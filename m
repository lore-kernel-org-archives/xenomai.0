Content-Disposition: inline
From: Karl Tyss <karl.tyss@domain.hid>
Date: Fri, 5 Jun 2009 19:36:12 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200906051936.13169.karl.tyss@domain.hid>
Subject: Re: [Xenomai-help] IRQ-Latency when in idle State on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org


----------  Weitergeleitete Nachricht  ----------

Betreff: Re: [Xenomai-help] IRQ-Latency when in idle State on ARM
Datum: Freitag, 5. Juni 2009
Von: Karl Tyss <karl.tyss@domain.hid>
An: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Am Freitag, 5. Juni 2009 17:01:13 schrieb Karl Tyss:
> Karl Tyss wrote:
> > Disabling the I- or D-cache is available as an option by using
> > menuconfig under system-type.
>
> Ok. I misread the configuration file. Also note that the idle function
> for arm926 core only disables the I-cache if it was not already
> disabled. So, if you are running with I-cache disabled, fiddling with
> this code should not change anything.

Excuse me if I didn't say it clearly. English is not my native language. Your 
hint helped me to avoid longer latencies while in idle state with both caches 
on. So my configuration is now I-cache on and D-cache on. Then I commented out 
the two lines in the idle task which torn the cache off and on again. Now I see 
no differences in the lantecies when an idle task is being interrupted. The 
"demux_irq" function (not the exact name) in the gpio.c from the at91 tree is 
significantly slower if I-cache was disabled and enabled before.

> 13us or 15us is still ridiculous on ARM. 3us even more. Average values
> are irrelevant, what matters is the worst case. If you only get a 3us
> difference when loading the system, then you are not loading the system
> enough. You should see latencies above 100us when properly loading the
> system. As I already told you, the way to proper load the system is to
> run LTP.

Thanx. I'll put LTP as my next testing task :)

> Disabling the cache is not recommended.

Right before the cpu is put to sleep by cp15 the I-cache is being disabled in 
the idle task. I took this part out. So I leave the I-cache enabled when the 
cpu goes into the idle mode. I suppose that there is a reason for disabling 
the cache. I will ask my wise ARM book on monday. If this issue doesn't belong 
here (xenomai list) just say a word :)

Thanx,
Karl Tyss

-------------------------------------------------------------

