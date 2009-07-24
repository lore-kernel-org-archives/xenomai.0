Date: Fri, 24 Jul 2009 18:13:31 +0200 (CEST)
From: Kolja Waschk <xenoka09@domain.hid>
Message-ID: <Pine.LNX.4.62.0907241731170.11473@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: [Xenomai-help] POSIX skin/Blackfin: SIGSEGV when stracing or gdb'ing
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

[On Blackfin uClinux 2.6.30 w/v2.5-rc2 with Philippe's patch from
yesterday, trying to run C or C++ FDPIC executables using the POSIX
skin]

When starting the example I recently posted (and a completely different
app, or even just an empty main(){return 0;} too) via "strace" or from
gdbserver, it segfaults almost immediately.

Unfortunately, I'm not able to make gdb break anywhere before this
happens. Therefore, I assume it happens before main().  The bfin trace
output shows that PC when it happened was at
libpthread/linuxthreads.old/signals.c:127 (uClibc __pthread_sigaction?)

These are the last instructions executed before the trap (last first)

    Source : <0xffa00740> { _trap + 0x1c } IF !CC JUMP
10 Target : <0xffa00724> { _trap + 0x0 }
    Source : <0x00457846> [ /lib/libpthread.so.0 + 0x7846 ] 0x9153
11 Target : <0x0045783a> [ /lib/libpthread.so.0 + 0x783a ]
    Source : <0x004578a2> [ /lib/libpthread.so.0 + 0x78a2 ] JUMP.S
12 Target : <0x0045789a> [ /lib/libpthread.so.0 + 0x789a ]
    Source : <0x00457838> [ /lib/libpthread.so.0 + 0x7838 ] IF !CC JUMP
       (libpthread/linuxthreads.old/signals.c:125)
13 Target : <0x004577fc> [ /lib/libpthread.so.0 + 0x77fc ]
       (libpthread/linuxthreads.old/internals.h:410)
    Source : <0xffa00cd6> { __common_int_entry + 0xde } RTI
14 Target : <0xffa00c74> { __common_int_entry + 0x7c }
    Source : <0xffa01070> { _evt_system_call + 0x64 } JUMP.S
15 Target : <0xffa01070> { _evt_system_call + 0x64 }
    Source : <0xffa00944> { _system_call + 0xe8 } RTS

As said, it happens with a source file consisting of only int main()
{return 0;} and a compiler invocation as simple as

  bfin-linux-uclibc-gcc -L/usr/xenomai/lib -lpthread_rt -pthread
     -Wl,@/usr/xenomai/lib/posix.wrappers main.c -o main

Any idea?

Thanks!
Kolja


