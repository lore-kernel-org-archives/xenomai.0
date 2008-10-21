From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Tue, 21 Oct 2008 23:00:39 +0200
References: <loom.20081016T124807-588@domain.hid>
	<1224605536.10407.15.camel@domain.hid>
	<48FE01D1.3070805@domain.hid>
In-Reply-To: <48FE01D1.3070805@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810212300.39565.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] Reducing Kernel Mode Interrupt Latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

> Henry Bausley wrote:
> > Is there any way the kernel mode interrupt handling maximum times can be
> > decreased.  I very much need to reduce my kernel mode interrupt
> > latencies.  I know my hardware is capable of better performance based
> > upon measurements done with RT Linux.  Below is our timing comparison,
> > all times are the maximums.
> >
> >
> > Xenomai 2.4.5 interrupt handler  w/ Kernel 2.6.26 powerpc, gcc 4.2
> > -------------------------------------------------------------------
> > AMCC 440EP - 24.5 usec
> > AMCC 460EX - 16.5 usec
> >
> >
> > FSM Labs RT-Linux 2.2 w/ Kernel 2.6.14 ppc, gcc 3.3
> > ---------------------------------------------------
> > AMCC 440EP - 10.0 usec
> > AMCC 460EX - Not Available, would require 10's of thousands of dollars
> > to WindRiver
>
> It would be interesting to know the figures for 2.6.14 ppc w/o RTLinux +
> Xenomai 2.4.5.

Just for information, I was able to launch some tests on an AMCC PPC440EP eval 
board (yosemite I think) I borrowed. I did not have the time to change the 
configuration so I launched the latency test (-t 0) on a Linux kernel 2.6.19 
+Xenomai 2.3.3 (no module). The results are in the same range: 

./latency -t 0 + ping -f + ls -lR / 

RTT|  00:10:31  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -3.744|      -2.379|      14.660|       0|      -4.333|      26.621
RTD|      -3.744|      -2.236|      13.198|       0|      -4.333|      26.621
RTD|      -3.738|      -2.259|      15.240|       0|      -4.333|      26.621
RTD|      -3.744|      -2.349|      12.870|       0|      -4.333|      26.621
RTD|      -3.744|      -2.304|      14.752|       0|      -4.333|      26.621

There is no finetuning in /proc/xenomai/latency:
# cat /proc/xenomai/latency 
9498

Alexis.


