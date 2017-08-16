MIME-Version: 1.0
In-Reply-To: <CA+K1mPFDrpDqUrNq2axA0J=+-Jm4K-DaMUhxURNMXaOby9mA4g@mail.gmail.com>
References: <CA+K1mPF52Gd8b1qviDH=KMpasF1E6CiWki0KAzY67BmCsZQfMw@mail.gmail.com>
 <183ffb03-aac8-85a9-e8df-da22aeddc301@xenomai.org>
 <CA+K1mPFDrpDqUrNq2axA0J=+-Jm4K-DaMUhxURNMXaOby9mA4g@mail.gmail.com>
From: C Smith <csmithquestions@gmail.com>
Date: Tue, 15 Aug 2017 17:14:15 -0700
Message-ID: <CA+K1mPEhSNW2UAsHY-y+bSFueQK3HTuYMoq4o0uFqBaUMj0mPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Fwd:  rt_pipe_* - must link xenomai and flush the pipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Oops, I accidentally sent this to Philippe instead of the list --

---------- Forwarded message ----------
From: C Smith <csmithquestions@gmail.com>
Date: Mon, Aug 14, 2017 at 3:48 PM
Subject: Re: [Xenomai] rt_pipe_* - must link xenomai and flush the pipe
To: Philippe Gerum <rpm@xenomai.org>


Thanks -- sorry I was sparse with details --

I am using xenomai 2.6.  I am observing this behavior when a non-RT task
writes to the pipe using write(), and an RT task reads the pipe with
rt_pipe_read.  The RT task is not a kernel module, just started from an ELF
executable I run from the command line.

BTW, linking in xenomai libraries makes a huge difference -- according to
gdb, when I leave xenomai libraries out (of a program with no xenomai calls
and no threading calls), the process is single-threaded; but when I link it
with -lxenomai -lpthread_rt then gdb shows two threads, even if I stop it
immediately by typing 'break main' before 'run'.  One of the threads always
has this call stack:

#0  0xffffe424 in __kernel_vsyscall ()
#1  0xb7e90966 in nanosleep () from /lib/libpthread.so.0
#2  0xb7ea0819 in printer_loop (arg=0x0) at rt_print.c:691
#3  0xb7e89adf in start_thread () from /lib/libpthread.so.0
#4  0xb720d55e in clone () from /lib/libc.so.6

Thanks,
Bob


On Sun, Aug 13, 2017 at 4:11 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 08/11/2017 11:59 PM, C Smith wrote:
>
>> Hi all --
>>
>> We have an architecture with 1 realtime task, and several non-realtime
>> processes (other programs) that communicate with the realtime task over
>> FIFOs.  We have used RTLinux in the past, and are porting to Xenomai.
>> I've
>> had to do some voodoo to get the FIFOs working, and I wonder if this
>> sounds
>> right to you folks:
>>
>> We are using the rt_pipe_* API.  The process that creates the realtime
>> task
>> creates the pipes with rt_pipe_create(), before starting the realtime
>> task.  The names show up in /proc/xenomai/registry/native/pipes/. The
>> non-realtime processes just use open() and write() to put data into the
>> pipe.  The non-realtime processes can compile and run without linking
>> against xenomai libraries.
>>
>> The two weird things I find are that:
>>
>>    1) If I don't link the non-realtime processes against xenomai
>> libraries,
>> the non-realtime process can write to the pipe without error, but the
>> realtime process never sees anything that it wrote; and
>>
>>
> Strange indeed. Linking is not expected to make any difference; using
> pipes on the non-rt side only depends on regular Linux I/O services tapping
> into a pseudo-device the real-time core exposes (just like RTLinux).
>
>    2) Even with xenomai linked in, the non-realtime task must flush the
>> pipe
>> (ioctl(fd, XNPIPEIOC_IFLUSH, 0); or else the realtime task never sees
>> anything they wrote.
>>
>> I've tried this with both blocking and non-blocking rt_pipe_read().
>>
>>
> - Which Xenomai version are you using?
> - Is the reader in userland?
> - How does the reader pull data from the pipe, using which call and syntax
> precisely?
>
> PS: although this should not be related to the issue, it is worth
> mentioning that RTLinux fifos were a byte-oriented mechanism; Xenomai pipes
> keep message boundaries on both sides by default, which means that each
> write() is normally paired with one read() on the remote side, with all
> data conveyed as a single bulk. There is a way to switch to byte-oriented
> mode in the rt -> non-rt direction though.
>
> --
> Philippe.
>
