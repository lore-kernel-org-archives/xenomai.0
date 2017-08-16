References: <CA+K1mPF52Gd8b1qviDH=KMpasF1E6CiWki0KAzY67BmCsZQfMw@mail.gmail.com>
 <183ffb03-aac8-85a9-e8df-da22aeddc301@xenomai.org>
 <CA+K1mPFDrpDqUrNq2axA0J=+-Jm4K-DaMUhxURNMXaOby9mA4g@mail.gmail.com>
 <CA+K1mPEhSNW2UAsHY-y+bSFueQK3HTuYMoq4o0uFqBaUMj0mPQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8ed35202-9444-acfa-8cd0-5081932e6a05@xenomai.org>
Date: Wed, 16 Aug 2017 15:19:35 +0200
MIME-Version: 1.0
In-Reply-To: <CA+K1mPEhSNW2UAsHY-y+bSFueQK3HTuYMoq4o0uFqBaUMj0mPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Fwd: rt_pipe_* - must link xenomai and flush the pipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>, xenomai@xenomai.org

On 08/16/2017 02:14 AM, C Smith wrote:
> Oops, I accidentally sent this to Philippe instead of the list --
> 
> ---------- Forwarded message ----------
> From: C Smith <csmithquestions@gmail.com>
> Date: Mon, Aug 14, 2017 at 3:48 PM
> Subject: Re: [Xenomai] rt_pipe_* - must link xenomai and flush the pipe
> To: Philippe Gerum <rpm@xenomai.org>
> 
> 
> Thanks -- sorry I was sparse with details --

- what are the parameters passed to rt_pipe_create(), rt_pipe_read() in
the failing case? (sizes, flags etc).

- what is the exact return value of write() on the non-rt side, which
does not trigger any receipt from rt_pipe_read()?

- what is the _exact_ Xenomai 2.6 release you have been using so far?
Several bug fixes have been applied to the message pipes along the 2.6.x
lifetime, only 2.6.5 includes them all.

> 
> I am using xenomai 2.6.

I would strongly recommend to use Xenomai 3.0.x instead of 2.6. The
Xenomai 2.6.x series is not maintained anymore (EOL since January last
year).

I would also recommend to go for the POSIX interface instead of the
so-called native/alchemy API: less overhead, more users, better
maintenance. With Xenomai 3.x, the POSIX API is truly the "native" one,
compared to all other APIs - include alchemy - which have to go through
the "Copperplate" mediation layer for reaching the core real-time services.

Xenomai's "alchemy" API should be seen as a compatibility layer for
people who want to port Xenomai 2.6 applications originally implemented
with the "native" API to Xenomai 3.x. I would NOT recommend it for new
projects.

  I am observing this behavior when a non-RT task
> writes to the pipe using write(), and an RT task reads the pipe with
> rt_pipe_read.  The RT task is not a kernel module, just started from an ELF
> executable I run from the command line.
> 
> BTW, linking in xenomai libraries makes a huge difference -- according to
> gdb, when I leave xenomai libraries out (of a program with no xenomai calls
> and no threading calls), the process is single-threaded; but when I link it
> with -lxenomai -lpthread_rt then gdb shows two threads, even if I stop it
> immediately by typing 'break main' before 'run'.  One of the threads always
> has this call stack:
> 
> #0  0xffffe424 in __kernel_vsyscall ()
> #1  0xb7e90966 in nanosleep () from /lib/libpthread.so.0
> #2  0xb7ea0819 in printer_loop (arg=0x0) at rt_print.c:691
> #3  0xb7e89adf in start_thread () from /lib/libpthread.so.0
> #4  0xb720d55e in clone () from /lib/libc.so.6
> 

That is expected; this is a helper thread started from a Xenomai library
constructor, dealing with deferred printf() output.

-- 
Philippe.

