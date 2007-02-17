Subject: Re: [Xenomai-core] [RFC][PATCH 1/2] real-time print library
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45D6C4B6.7010302@domain.hid>
References: <45D6C4B6.7010302@domain.hid>
Content-Type: text/plain
Date: Sat, 17 Feb 2007 13:12:25 +0100
Message-Id: <1171714345.18347.25.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Sat, 2007-02-17 at 10:02 +0100, Jan Kiszka wrote:
> This is a stand-alone real-time library for printf services. It is
> embedded into the Xenomai user space part but actually doesn't depend
> on any Xenomai service, just using plain Linux POSIX.
> 
> The librtprint API looks much like the printf(3) man page:

[...]

> Further features:
>  o Explicit or on-demand thread buffer creation
>  o Override of default buffer size and polling period via environment
>    variables ("RT_PRINT_BUFFER" and "RT_PRINT_PERIOD")
>  o Support for buffer names (useful for the following patch e.g.)
>  o Target output stream can be specified for each print invocation
>  o Breaks all builds except for x86 (missing ubarrier.h headers) :o)
> 

ubarrier.h is redundant. include/asm-*/atomic.h is already there for
such purpose.

> The code is stuffed into src/rtprint for now as patch 2/2 will need this
> lib to be built before the skin libraries. Better suggestions are
> welcome though.

I basically agree that we need to provide more
co-scheduler-based-rt-safe services, so a non-intrusive print out
support should be welcome. A few things more:

- looking beyond print out, we will probably want to iron more ANSI
services in the future. In order to prevent API proliferation, let's
consider the hardened print out support as the beginning of some
libansi_rt service collection.

- the same way libpthread_rt shadows 1003.1c services to iron them over
a co-scheduler, we should do the same for the ironed ANSI services. In
that sense, there is no need for rt_printf, rt_vsprintf and so on, we
just need to shadow printf, vsprintf and friends the same way we did for
pthread_create and such for substituting the 1003.1c support. Again, API
proliferation, especially of non-orthogonal stuff, needs to be fought
now. The bonus is that we would not have to ask people to rely on crufty
preprocessor tricks in order to compile their code in either real-time
layers X3 is going to provide (i.e. I-pipe-based co-scheduler and native
preemption). This would be consistent with the all-time Xenomai's
mantra, i.e. "integrate as seamlessly as you can, don't get uselessly
peculiar".

-- 
Philippe.



