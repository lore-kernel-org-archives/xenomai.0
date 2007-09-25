From: Leopold Palomo-Avellaneda <lepalom@domain.hid>
Date: Tue, 25 Sep 2007 16:25:41 +0200
References: <46F9167F.20008@domain.hid>
In-Reply-To: <46F9167F.20008@domain.hid>
MIME-Version: 1.0
Message-Id: <200709251625.41744.lepalom@domain.hid>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Subject: Re: [Xenomai-help] Non-APIC setup broken for 2.4-SVN?
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

A Dimarts 25 Setembre 2007 16:09, Jan Kiszka va escriure:
> Hi,
>
> to make it short has anyone or could anyone try latest SVN over kernel
> 2.6.20 (i-pipe for 2.6.22 is instable) _without_ LAPIC? 

I'm running a 2.6.22 kernel patched with xenomai trunk (last week) and booting 
with noapic in the grub.

In the test, I got:

running: ./run -- -sh -T 120 -t0 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|     -16.738|     -16.613|     -14.489|       0|     -16.738|     -14.489
RTD|     -16.726|     -16.602|      -9.150|       0|     -16.738|      -9.150
RTD|     -16.738|     -16.587|     -10.463|       0|     -16.738|      -9.150
RTD|     -16.731|     -16.602|     -11.780|       0|     -16.738|      -9.150
RTD|     -16.731|     -16.605|     -13.943|       0|     -16.738|      -9.150
RTD|     -16.733|     -16.586|     -10.669|       0|     -16.738|      -9.150
RTD|     -16.732|     -16.604|     -13.736|       0|     -16.738|      -9.150
RTD|     -16.740|     -16.603|     -10.243|       0|     -16.740|      -9.150
RTD|     -16.732|     -16.585|     -10.725|       0|     -16.740|      -9.150
RTD|     -16.727|     -16.601|     -13.796|       0|     -16.740|      -9.150
RTD|     -16.726|     -16.603|     -13.741|       0|     -16.740|      -9.150       

> It works for me, 
> but exposes milliseconds of latencies. Same setup with LAPIC enabled is
> fine and obviously stable. Before digging into this (time is short
> anyway), I would like to exclude problems of my notebook hardware.

I cannot run it with lapic because the system hung.

Regards,

Leo

