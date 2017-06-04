MIME-Version: 1.0
In-Reply-To: <6f55db98-0988-3b9f-f1dc-6f393211af4d@xenomai.org>
References: <CAF06wtgV=DewshLh48CMNFy3J7SzBk06ToJjaQsXpF2+TkBqoA@mail.gmail.com>
 <6f55db98-0988-3b9f-f1dc-6f393211af4d@xenomai.org>
From: Jim Langston <jim.langston@gmail.com>
Date: Sun, 4 Jun 2017 14:02:11 -0400
Message-ID: <CAF06wtgMdvZ-K2yNMY6wZMSUa+ELdwBV=rbm7F1vAiLX57OyeQ@mail.gmail.com>
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

The backtrace I get when I run gdb on the target is:

#0  0x00000000 in ?? ()
#1  0xb77b617c in do_open (
    path=path@entry=0xb77bd31d "/dev/rtdm/memdev-private",
    oflag=oflag@entry=2, mode=0) at rtdm.c:51
#2  0xb77b61dc in __cobalt_open (path=0xb77bd31d
"/dev/rtdm/memdev-private",
    oflag=2) at rtdm.c:74
#3  0xb77b844d in __map_umm (
    name=name@entry=0xb77bd31d "/dev/rtdm/memdev-private",
    size_r=size_r@entry=0xb77c53b0 <private_size>) at umm.c:53
#4  0xb77b8506 in init_bind () at umm.c:110
#5  0xb7722aa5 in pthread_once () from /lib/libc.so.0
#6  0xb77b85cd in cobalt_init_umm (vdso_offset=0) at umm.c:133
#7  0xb77b3acf in low_init () at init.c:128
#8  0xb77b3b3c in __cobalt_init () at init.c:147
#9  cobalt_init () at init.c:198
#10 0xb77ba7b3 in __xenomai_init (argcp=argcp@entry=0xbfc9f0c0,
    argvp=argvp@entry=0xbfc9f0bc, me=me@entry=0xb77bdf56 "program")
    at setup.c:574
#11 0xb77ba8d1 in xenomai_init (argcp=0xbfc9f0c0, argvp=0xbfc9f0bc)
    at setup.c:629
#12 0x08049565 in call_init (argvp=0xbfc9f0bc, argcp=0xbfc9f0c0)
    at bootstrap.c:76
#13 xenomai_bootstrap () at bootstrap.c:140
#14 0x0804b180 in __do_global_ctors_aux ()
#15 0x08049011 in _init ()
#16 0xb77554a3 in __uClibc_main () from /lib/libc.so.0
#17 0x08049b05 in _start ()

'/dev/rtdm/memdev-private' does exist in the filesystem, and has the
following settings:

crw-rw----    1    root    root    252

I hope this helps.  Thanks again for responding.

Jim


On Sun, Jun 4, 2017 at 12:43 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 06/04/2017 06:34 PM, Jim Langston wrote:
> > Hello,
> >
> > I am attempting to run Xenomai 3.0.5 on an embedded system.
> >
> > It is being built using Buildroot 2017.02.2, Xenomai 3.0.5, Kernel
> 4.1.18,
> > Adeos patch 4.1.18 #9.
>
> I cannot infere the CPU architecture from this information.
>
> > The resultant image boots, and I can see that Xenomai is running:
> >
>
> [snip]
>
> > > Any ideas on where i could start looking about?  I don't see any
> causality
> > here...
> >
>
> Could you run the latency utility over gdb and get a stack backtrace
> when it breaks?
>
> For the backtrace to be meaningful, you will need to pass
> --enable-debug=symbols to the configure script for building Xenomai's
> user-space libs and programs.
>
> --
> Philippe.
>
