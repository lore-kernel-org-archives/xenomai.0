Message-ID: <51518D16.2050803@xenomai.org>
Date: Tue, 26 Mar 2013 12:57:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5148C728.6000101@gmail.com> <5148CEA9.7060700@xenomai.org>
	<515175FA.4030901@gmail.com>
In-Reply-To: <515175FA.4030901@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Decrease Latency (below 10 us) on x32 or x32_64?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Manuel Huber <manuel.h87@gmail.com>
Cc: xenomai@xenomai.org

On 03/26/2013 11:18 AM, Manuel Huber wrote:

> Hello!
> 
> Sorry for the delay. I have re-compiled the Kernel with the I-pipe
> tracer enabled, and I disabled the HPET. Then, I tried to reset the
> tracer by writing 0 to /proc/ipipe/trace/frozen and some string to
> /proc/ipipe/trace/max. Then I started the latency program with the -f
> option for some minutes and afterwards captured the variables in
> /proc/ipipe/trace/. One test has been made in single-user mode and
> without the nouveau driver (plain-vga_300.txt) and the other trace has
> been made in normal multi-user mode with gdm running (and the nouveau
> driver; gui_300.txt). There is one trace without any USB-device
> attached (plain-vga_300_no_usb.txt), but I'm not sure if that makes
> any difference.
> 
> I hope I used the I-pipe tracer correctly. I'm sorry to bother you
> again, but I can't interpret the results :( Maybe you could interpret
> the trace, if you have time for it...


The traces are too short. Try:
echo 1000 > /proc/ipipe/trace/back_trace_points

There should be at least a "tick@" trace indicating the time when the
timer was supposed to tick and when it did not, so that we have an idea
of the latency.

What is the period you use for the latency test?

-- 
                                                                Gilles.

