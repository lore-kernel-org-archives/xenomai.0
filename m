Message-ID: <4D74975F.4050009@domain.hid>
Date: Mon, 07 Mar 2011 09:29:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTik7MKLjvrZY1BsowqBtodJoP7fUt6--H4WOS-W4@domain.hid>
In-Reply-To: <AANLkTik7MKLjvrZY1BsowqBtodJoP7fUt6--H4WOS-W4@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] irqloop hangs on Beagleboard ARM with
	2.5.5.2/2.6.33
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Eric <ericrebates@domain.hid>
Cc: xenomai@xenomai.org

Eric Eric wrote:
> Hi, I'm attempting to run irqloop/irqbench and irqloop just appears to
> hang indefinitely.  Behavior is the same with -t0 and -t1.  I am able
> to successfully run other tests such as latency and switchtest.  Below
> is the output of strace ./irqloop -t1. xeno_irqbench is loaded, I have
> a null modem cable connected to an x86 running irqbench and have
> disabled the serial log output and serial tty on the beagle.

I am not sure, but I think irqloop currently only works on x86. You
should try gpioirqbench instead.

http://www.denx.de/wiki/DULG/AN2008_03_Xenomai_gpioirqbench

-- 
                                                                Gilles.

