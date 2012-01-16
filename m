Message-ID: <4F1493B5.1000501@domain.hid>
Date: Mon, 16 Jan 2012 22:16:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAP1XtZzB34=+B+fwWpswhqfFVMd3YmU4etoYOSxXFOMbEH7myg@domain.hid>
In-Reply-To: <CAP1XtZzB34=+B+fwWpswhqfFVMd3YmU4etoYOSxXFOMbEH7myg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Processor type for installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Santiago Focke <focke.85@domain.hid>
Cc: xenomai@xenomai.org

On 01/16/2012 09:03 PM, Santiago Focke wrote:
> Dear all
> 
> I've been trying to install Xenomai but I haven't been able to do it
> right.  After being able of building and installin the kernel and Xenomai,
> I tried to run the example program trivial-periodic, I got the following
> error

We do not know which kernel version, which xenomai version, which adeos
I-pipe version.

> 
> /usr/src/xenomai-2.6/examples/native$ ./trivial-periodic
> Xenomai: incompatible feature set
> (userland requires "tsc fastsynch", kernel provides "sep fastsynch smp",
> missing="tsc").
> 
> I read that the reason for this is that I didn't configure correctly the
> processor family (with xconfig). Is that the reason? Also, I've been trying
> to know which option should I choose (I chose CONFIG_M586 at the
> beggining), but I don't know were to get that information. The CPU info
> goes as follows:
> 
> /proc/cpuinfo
> 
> processor    : 0
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 37
> model name    : Intel(R) Core(TM) i7 CPU       M 620  @ 2.67GHz

So, you have a core i7, anything newer than "pentium pro" (an older than
ten years old architecture) should do, but better select the processor
you actually have or the nearest substitute: so, assuming you are
compiling a 2.6.38 kernel, "core 2/newer xeon" should do. Also note that
a core i7 is able to run in 64 bits mode, so running it in 32 bits mode
is a bit a pity.


-- 
                                                                Gilles.

