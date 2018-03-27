MIME-Version: 1.0
In-Reply-To: <CAA3JOdYcsqAU7z0nhd7WMCcH-3z-XiDP2RfS6RKK0hYi2Br59Q@mail.gmail.com>
References: <CAA3JOdYcsqAU7z0nhd7WMCcH-3z-XiDP2RfS6RKK0hYi2Br59Q@mail.gmail.com>
From: Virendra Kate <virendrakate@gmail.com>
Date: Mon, 26 Mar 2018 17:58:02 -0700
Message-ID: <CAA3JOdasXZGO9Dpyu3UU4rUgkjueP69hLBSi4R8hfn93xB1TTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] GDB freezes with breakpoints inside RT POSIX App
	(ARM64)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

Could someone please help me out with this issue? This is an important
issue for us as it is hindering efficient debugging.

We thought of moving the application to the alchemy skin but given the fact
that the posix skin is the fastest ( https://xenomai.org/
pipermail/xenomai/2017-June/037400.html )  we would like to stick with
posix.

Thank you,
Virendra

On Mon, Mar 12, 2018 at 3:14 PM, Virendra Kate <virendrakate@gmail.com>
wrote:

> Hello,
>
> I have been trying to debug a xenomai-cobalt application which uses
> the POSIX API.
> Target environment:
> hw = ARM64,
> linux kernel = 4.12.14,
> "cat /proc/xenomai/version" = 3.1-devel,
> "cat /proc/ipipe/version" = 2.
>
> Debugger/compiler info:
> gdb (on the target board): GNU gdb (Ubuntu 7.11.1-0ubuntu1~16.5) 7.11.1
> gcc (on the target board):(Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0
> 20160609
> Installed Xenomai 3 libraries from the latest xenomai-next package
> with the target's default toolchain mentioned above using :
> ./scripts/bootstrap
> ./configure CFLAGS="-march=armv8-a" LDFLAGS="-march=armv8-a"
> --with-core=cobalt --enable-smp --enable-pshared
> make
> sudo make install
>
> Compiled the Posix App on the target using the attached makefile. Then
> ran the application - works perfectly fine. I can also see the RT
> thread (with correct priority) in "cat /proc/xenomai/sched/threads".
> Now I ran the application with gdb (no breakpoints) - works perfectly
> fine. Next I ran the application with breakpoints inside "main" & the
> RT task - only the "main" breakpoints were hit and gdb freezes without
> hitting the RT bereakpoint. I also ran a simple "alchemy" based
> application and the breakpoints in the RT task worked perfectly fine.
>
> At the moment the only workaround I use is to switch to the
> SCHED_OTHER (non-RT) scheme & then the breakpoints work fine.
> Did anyone face this issue? If yes how was this resolved with SCHED_FIFO
> on?
>
> Thank you,
> Virendra
>
