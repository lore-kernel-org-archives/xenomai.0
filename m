MIME-Version: 1.0
In-Reply-To: <a977c731-91ce-e308-8676-1a1a82f7cf22@xenomai.org>
References: <CAF06wtgV=DewshLh48CMNFy3J7SzBk06ToJjaQsXpF2+TkBqoA@mail.gmail.com>
 <6f55db98-0988-3b9f-f1dc-6f393211af4d@xenomai.org>
 <CAF06wtgMdvZ-K2yNMY6wZMSUa+ELdwBV=rbm7F1vAiLX57OyeQ@mail.gmail.com>
 <a977c731-91ce-e308-8676-1a1a82f7cf22@xenomai.org>
From: Jim Langston <jim.langston@gmail.com>
Date: Mon, 5 Jun 2017 22:12:59 -0400
Message-ID: <CAF06wtjLv+nTAyYv-BZCg51JbJEi+e-MWD7ZjZ-TG=K=kWDNcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Issues with Xenomai 3.0.5...
Reply-To: jlangston@panurgyinc.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe,

That worked well, thank you!

Now that my test applications are running, I wanted to be sure that
everything was kosher.  If I run 'latency' or 'switchtest' and press CTRL+C
to stop them, I get a seg fault.  Otherwise they seem to run normally,
basically the same as my old 2.X Xenomai systems.

*gdb latency*

Thread 4 "sampling-1035" received signal SIGXCPU, CPU time limit exceeded.

#0  0xb770c25d in __cobalt_read (fd=3, buf=0xb74373a8, nbyte=8) at
rtdm.c:180
#1  0x08049e60 in latency (cookie=0x0) at latency.c:165
#2  0xb770d760 in cobalt_thread_trampoline (p=0xbfff47bc) at thread.c:166
#3  0xb76bc5bc in start_thread () from /lib/libc.so.0
#4  0xb7678ded in clone () from /lib/libc.so.0


*gdb switchtest*
Thread 18 "rtuo_ufps-20" received signal SIG32, Real-time event 32.

#0  0xb7729f42 in do_ioctl (fd=fd@entry=3, request=request@entry=2148009525,

    arg=arg@entry=0xb718d358) at rtdm.c:132
#1  0xb772a204 in __cobalt_ioctl (fd=3, request=2148009525) at rtdm.c:167
#2  0x0804b1a5 in rtuo (cookie=0x97bec30) at switchtest.c:654
#3  0xb772b760 in cobalt_thread_trampoline (p=0xbfb88afc) at thread.c:166
#4  0xb76da5bc in start_thread () from /lib/libc.so.0
#5  0xb7696ded in clone () from /lib/libc.so.0

Is this normal, or do I need to do some more digging through my build
environment?

Thanks,
Jim

On Mon, Jun 5, 2017 at 4:24 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 06/04/2017 08:02 PM, Jim Langston wrote:
> > Philippe,
> >
> > The backtrace I get when I run gdb on the target is:
> >
> > #0  0x00000000 in ?? ()
> > #1  0xb77b617c in do_open (
> >     path=path@entry=0xb77bd31d "/dev/rtdm/memdev-private",
> >     oflag=oflag@entry=2, mode=0) at rtdm.c:51
>
> It looks like the *libc you are using does not enable the
> sysenter/sysexit kernel call convention for x86, you may want to pass
> --disable-x86-vsyscall to the configure script, then rebuild from scratch.
>
> Also, I would recommend to pass --disable-smp in the same move, since
> Xenomai enables SMP support by default for the x86 architecture, and
> although this would still work with a UP kernel (the opposite would
> not), there is no point on the Geode.
>
> --
> Philippe.
>
