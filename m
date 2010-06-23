From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTilBt1fx4MFJ_Tmuz-fUl1D190u_FYDfLn09JaA3@domain.hid>
References: <AANLkTikU5zPKew64ZxWGokwh5R5F-sNegWdDzOENWdzB@mail.gmail.com>
	<4C1B7EB1.2040006@domain.hid>
	<AANLkTinABTK2nMI0QfZVaULQ4OKwF0678PKOBc_OMIn1@domain.hid>
	<AANLkTiklRlwsIJfelo0eT2GZDvI6PtDAwc4qluLCr6R5@domain.hid>
	<4C1B8C04.3010900@domain.hid> <4C1BCCBF.7010400@domain.hid>
	<AANLkTilBt1fx4MFJ_Tmuz-fUl1D190u_FYDfLn09JaA3@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Jun 2010 00:00:01 +0200
Message-ID: <1277330401.2453.145.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Fwd: problem in pthread_mutex_lock/unlock
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Nero Fernandez <grimlynch@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2010-06-24 at 02:15 +0530, Nero Fernandez wrote:
> Thanks for your response, Gilles.
> 
> i modified the code to use semaphore instead of mutex, which worked
> fine.
> Attached is a compilation of some latency figures and system loading
> figures (using lmbench)
> that i obtained from my proprietary ARM-9 board, using Xenomai-2.5.2.
> 
> Any comments are welcome. TIY.
> 

Yikes. Let me sum up what I understood from your intent:

- you are measuring lmbench test latencies, that is to say, you don't
measure the real-time core capabilities at all. Unless you crafted a
Xenomai-linked version of lmbench, you are basically testing regular
processes.

- you are benchmarking your own port of the interrupt pipeline over some
random, outdated vendor kernel (2.6.18-based Mvista 5.0 dates back to
2007, right?), albeit the original ARM port of such code is based on
mainline since day #1. Since the latest latency-saving features like
FCSE are available with Adeos patches on recent kernels, you are likely
looking at ancient light rays from a fossile galaxy (btw, this may
explain the incorrect results in the 0k context switch test - you don't
have FCSE enabled in your Adeos port, right?).

- instead of reporting figures from a real-time interrupt handler
actually connected to the Xenomai core, you hijacked the system timer
core to pile up your instrumentation on top of the original code you
were supposed to benchmark. If this helps, run /usr/xenomai/bin/latency
-t2 and you will get the real figures.

Quoting you, from your document:
"The intent for running these tests is to gauge the overhead of running
interrupt-virtualization and further running a (real-time co-kernel + 
interrupt virtualization) on an embedded-device."

I'm unsure that you clearly identified the functional layers. If you
don't measure the Xenomai core based on Xenomai activities, then you
don't measure the co-kernel overhead. Besides, trying to measure the
interrupt pipeline overhead via the lmbench micro-benchmarks makes no
sense.

> 
> On Sat, Jun 19, 2010 at 1:15 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>         
>         Gilles Chanteperdrix wrote:
>         > Nero Fernandez wrote:
>         >> On Fri, Jun 18, 2010 at 7:42 PM, Gilles Chanteperdrix
>         >> <gilles.chanteperdrix@xenomai.org
>         >> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
>         >>
>         >>     Nero Fernandez wrote:
>         >>     > Hi,
>         >>     >
>         >>     > Please find an archive attached, containing :
>         >>     >  - a program for testing context-switch-latency using
>         posix-APIs
>         >>     >    for native linux kernel and xenomai-posix-skin
>         (userspace).
>         >>     >  - Makefile to build it using xenomai
>         >>
>         >>     Your program is very long to tell fast. But it seems
>         you are using the
>         >>     mutex as if they were recursive. Xenomai posix skin
>         mutexes used to be
>         >>     recursive by default, but no longer are.
>         >>
>         >>     Also note that your code does not check the return
>         value of the posix
>         >>     skin services, which is a really bad idea.
>         >>
>         >>     --
>         >>                                                Gilles.
>         >>
>         >>
>         >> Thanks for the prompt response.
>         >>
>         >> Could you explain  'recursive usage of mutex' a little
>         further?
>         >> Are the xenomai pthread-mutexes very different in behaviour
>         than regular
>         >> posix mutexes?
>         >
>         > The posix specification does not define the default type of
>         a mutex. So,
>         >  in short, the behaviour of a "regular posix mutex" is
>         unspecified.
>         > However, following the principle of least surprise, Xenomai
>         chose, like
>         > Linux, to use the "normal" type by default.
>         >
>         > What is the type of a posix mutex is explained in many
>         places, starting
>         > with Xenomai API documentation. So, no, I will not repeat it
>         here.
>         
>         
>         Actually, that is not your problem. However, you do not check
>         the return
>         value of posix services, which is a bad idea. And indeed, if
>         you check
>         it you will find your error: a thread which does not own a
>         mutex tries
>         to unlock it.
>         
>         Sorry, mutex are not semaphore, this is invalid, and Xenomai
>         returns an
>         error in such a case.
>         
>         --
>                                                    Gilles.
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.



