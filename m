MIME-Version: 1.0
References: <mailman.3.1647601201.30395.xenomai@xenomai.org>
In-Reply-To: <mailman.3.1647601201.30395.xenomai@xenomai.org>
From: Ashwik John <johnashwik994@gmail.com>
Date: Fri, 22 Apr 2022 10:34:58 +0200
Message-ID: <CAESnvfPvby7Wi5ncyB-KZQgR69pQ1p+6Xh5uVxMJUnKpQPaHqg@mail.gmail.com>
Subject: Re: Xenomai Digest, Vol 119, Issue 50
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I have the same problem when running #evl test.

basic-xbuf: OK
clock-timer-periodic: OK
clone-fork-exec: OK
detach-self: OK
duplicate-element: OK
element-visibility: OK
fault: OK
fpu-preload: OK
fpu-stress: OK
heap-torture: OK
mapfd: OK
monitor-deadlock: OK
monitor-event: OK
monitor-flags: OK
monitor-pi: OK
monitor-pi-deadlock: OK
monitor-pp-dynamic: OK
monitor-pp-lower: OK
monitor-pp-nested: OK
monitor-pp-pi: OK
monitor-pp-raise: OK
monitor-pp-tryenter: OK
monitor-pp-weak: OK
monitor-steal: OK
monitor-wait-multiple: OK
observable-hm: OK
observable-inband: OK
observable-master: OK
observable-onchange: OK
observable-oob: OK
observable-race: OK
observable-thread: OK
poll-close: OK
poll-flags: OK
poll-many: OK
*** stack smashing detected ***: <unknown> terminated
Aborted (core dumped)
** poll-multiple: BROKEN


(gdb) run
Starting program: /usr/evl/tests/poll-multiple
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
[New Thread 0x7ffff7ff0700 (LWP 18985)]
[New Thread 0x7ffff7fd7700 (LWP 18988)]
[Thread 0x7ffff7ff0700 (LWP 18985) exited]
*** stack smashing detected ***: <unknown> terminated
[Thread 0x7ffff7fd7700 (LWP 18988) exited]

Thread 1 "poll-multi:1898" received signal SIGABRT, Aborted.
__GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
51 ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
(gdb) backtrace
#0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
#1  0x00007ffff75f67f1 in __GI_abort () at abort.c:79
#2  0x00007ffff763f837 in __libc_message (action=action@entry=do_abort,
fmt=fmt@entry=0x7ffff776c869 "*** %s ***: %s terminated\n") at
../sysdeps/posix/libc_fatal.c:181
#3  0x00007ffff76eab31 in __GI___fortify_fail_abort
(need_backtrace=need_backtrace@entry=false, msg=msg@entry=0x7ffff776c847
"stack smashing detected") at fortify_fail.c:33
#4  0x00007ffff76eaaf2 in __stack_chk_fail () at stack_chk_fail.c:29
#5  0x0000555555401d27 in main ()

Thank you for your support to solve this issue.

On Fri, Mar 18, 2022 at 12:00 PM <xenomai-request@xenomai.org> wrote:

> Send Xenomai mailing list submissions to
>         xenomai@xenomai.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://xenomai.org/mailman/listinfo/xenomai
> or, via email, send a message with subject or body 'help' to
>         xenomai-request@xenomai.org
>
> You can reach the person managing the list at
>         xenomai-owner@xenomai.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Xenomai digest..."
>
>
> Today's Topics:
>
>    1. WG: Where to start with Kernel config for Atom (64bit)
>       Xenomai4 (evl) (Steub, Peter)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Fri, 18 Mar 2022 07:19:28 +0000
> From: "Steub, Peter" <Peter.Steub@baumueller.com>
> To: "xenomai@xenomai.org" <xenomai@xenomai.org>
> Subject: WG: Where to start with Kernel config for Atom (64bit)
>         Xenomai4 (evl)
> Message-ID: <2360f46f5313427fb55b3ff9ae57855d@baumueller.com>
> Content-Type: text/plain; charset="utf-8"
>
> > > Hi all,
> > >
> > > I like to get evl running on a quadcore Atom box. I started with a
> > > standard ubuntu 20.04 installation
> >
> > Which will almost never work out of the box on x86. Some options
> > commonly selected there will likely cause issues with any real-time
> infrastructure.
>
> Can you give me an example, the Xenomai3 setup that I use very
> successfully, is based on a Ubuntu 16.04 desktop, although it is pretty old
> already, so I may have forgotten what I did exactly back then to make it
> work.
>
> > > and build a kernel from ,v5.15.y-evl-rebase' branch with evl enabled
> > > and things that ,evl check -file' told me disabled.
> >
> > What do you mean? "evl check" is about verifying a configuration, not
> > giving any runtime status. The output is a set of hints about kernel
> > options that should appear as indicated in the submitted .config file,
> but do not.
>
> Exactly, I did run "evl check" on the kernel config before I build the
> kernel. So ACPI_PROCESSOR_IDLE is deactivated as well.
>
> > > Also ,evl test' tells me:
> > > *** stack smashing detected ***: terminated Aborted (core dumped)
> > > ** poll-multiple: BROKEN
> >
> > # gdb /usr/evl/tests/poll-multiple
> >
> > may help, running it then asking for a backtrace when it breaks. I
> > could have a look at the backtrace output to figure out what happens,
> > since I cannot reproduce this on any of my fixtures ATM, so this may
> > depend on a glibc setup.
>
> (gdb) run
> Starting program: /usr/evl/tests/poll-multiple [Thread debugging using
> libthread_db enabled] Using host libthread_db library
> "/lib/x86_64-linux-gnu/libthread_db.so.1".
> [New Thread 0x7ffff7d8b700 (LWP 3404)]
> [New Thread 0x7ffff7d7a700 (LWP 3412)]
> [Thread 0x7ffff7d8b700 (LWP 3404) exited]
> *** stack smashing detected ***: terminated [Thread 0x7ffff7d7a700 (LWP
> 3412) exited]
>
> Thread 1 "poll-multi:3400" received signal SIGABRT, Aborted.
> __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
> 50      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
> (gdb) backtrace
> #0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
> #1  0x00007ffff7db1859 in __GI_abort () at abort.c:79
> #2  0x00007ffff7e1c29e in __libc_message (action=action@entry=do_abort,
> fmt=fmt@entry=0x7ffff7f4608f "*** %s ***: terminated\n") at
> ../sysdeps/posix/libc_fatal.c:155
> #3  0x00007ffff7ebeaea in __GI___fortify_fail (msg=msg@entry=0x7ffff7f46077
> "stack smashing detected") at fortify_fail.c:26
> #4  0x00007ffff7ebeab6 in __stack_chk_fail () at stack_chk_fail.c:24
> #5  0x0000555555557941 in main (argc=1, argv=0x7fffffffe558) at
> ../../home/bm_user/nas/libevl-master/tests/poll-multiple.c:163
>
> > > I'm also interested in the Raspberry PI port, but I don't like to
> > > try it all out again for myself, a kernel-config or in case of the
> > > PI even a binary or a hole Image would be great!
> >
> > Which PI? All PI kernels can be built using the default mainline
> > config for the architecture at hand. This is actually the ones I'm using.
> > e.g. ARCH=arm64 defconfig for PI3/64bit and PI4/64bit, or
> > multi_v7_defconfig for 32bit (including PI0 and PI2).
>
> Ok I started over with the kernel and now that I have done it, it seems
> obvious. Maybe someone could put a small list like this on the "Building
> the core" site so the next one who does not know how to start knows:
> # ARCH=x86_64 make defconfig
> # make menuconfig
>         -> Processor type and features -> EVL real-time core
>               Enabled
>         -> Processor type and features -> CPU core prioroties scheduler
> support Disable
>         -> Power management -> CPU Frequency scaling
>       Disable
>         -> Power management -> ACPI support -> Processor
>               Disable
>         ->Kernel hacking -> Tracers
>              Disable
>         #######Add addition Hardware support######### # make clean # make
> bindeb-pkg (or just make...)
>
> The result looks very promising, on an isolated core I get worst user
> values at around 3, on a non isolated core I get like 20. I haven't tested
> for long and not with different kind of loads but still it looks a lot
> better than before.  Now I need to port my application from X3 to X4 but
> those questions deserve a separate email.
>
> Thank you
>
> Peter Steub
> >
> > [1] https://evlproject.org/core/caveat/
> >
> > --
> > Philippe.
>
> ------------------------------
>
> Subject: Digest Footer
>
>
>
>
> ------------------------------
>
> End of Xenomai Digest, Vol 119, Issue 50
> ****************************************
>
