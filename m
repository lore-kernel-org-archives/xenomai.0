Message-ID: <48FECFF5.2030208@domain.hid>
Date: Wed, 22 Oct 2008 09:02:13 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <loom.20081016T124807-588@domain.hid>
	<1224605536.10407.15.camel@domain.hid>
In-Reply-To: <1224605536.10407.15.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Henry Bausley <hbausley@domain.hid>
Cc: xenomai@xenomai.org

Henry Bausley wrote:
> Is there any way the kernel mode interrupt handling maximum times can be
> decreased.  I very much need to reduce my kernel mode interrupt
> latencies.  I know my hardware is capable of better performance based
> upon measurements done with RT Linux.  Below is our timing comparison,
> all times are the maximums.
> 
> 
> Xenomai 2.4.5 interrupt handler  w/ Kernel 2.6.26 powerpc, gcc 4.2
> -------------------------------------------------------------------
> AMCC 440EP - 24.5 usec
> AMCC 460EX - 16.5 usec
> 
> 
> FSM Labs RT-Linux 2.2 w/ Kernel 2.6.14 ppc, gcc 3.3
> ---------------------------------------------------
> AMCC 440EP - 10.0 usec
> AMCC 460EX - Not Available, would require 10's of thousands of dollars
> to WindRiver

What exactly did you measure and did you run the tests under comparable
(non real-time) system load? As cache re-fills are causing significant
latencies, code size matters, but I'm surprised that the difference is
that big.

Wolfgang.

