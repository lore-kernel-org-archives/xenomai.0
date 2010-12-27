From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.1.10.1012271521010.20479@domain.hid>
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
	<4D110810.1090504@domain.hid>
	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
	<alpine.DEB.1.10.1012271521010.20479@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 27 Dec 2010 17:31:24 +0100
Message-ID: <1293467484.1856.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gdb/gdbserver and pthread_cond_wait (was:
 gdb/gdbserver hangs...)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kolja Waschk <xenoka09@domain.hid>
Cc: Xenomai GNA <xenomai@xenomai.org>

On Mon, 2010-12-27 at 15:44 +0100, Kolja Waschk wrote:
> Hi,
> 
> I've made up a small test program for my issue with pthread_cond_wait and gdb.
> Sorry for posting code again, I've made it as compact as possible.
> 
> The behaviour of the attached program depends on whether it is run via
> gdbserver or without.

The test code creates SCHED_OTHER threads. This is likely not what you
wanted to do.

> 
> 
> When run via gdbserver, the pthread_cond_wait sometimes returns EPERM:
> 
> > Remote debugging from host 10.0.10.10
> > T0: pthread_cond_wait: 1
> > ... repeats for T0 and T1 ...
> > T1: pthread_cond_wait: 1
> > T1: pthread_cond_wait: 1
> > T0: pthread_cond_wait: 1
> > T2: pthread_cond_wait: 0
> > Child exited with retcode = 0
> 
> 
> Started directly, it prints what I would expect:
> 
> > T0: pthread_cond_wait: 0
> > T1: pthread_cond_wait: 0
> > T2: pthread_cond_wait: 0
> 
> 
> Am I missing something when configuring the threads, cond variable etc.?
> 
> About my environment:
> 
>   - Xenomai 2.5.5.2, unmodified
>   - blackfin FDPIC toolchain 2010R1-RC4 (gcc 4.3.5, gdb 6.6, gdbserver 6.5)
>   - blackfin-linux-dist 2010R1-RC5 (kernel 2.6.34 with I-pipe upgraded to 1.15-01)
> 
> 
> I compile "try.c" with the following command line:
> 
> bfin-linux-uclibc-gcc \
>    -I/opt/uClinux/blackfin-linux-dist/staging/usr/include \
>    -L/opt/uClinux/blackfin-linux-dist/staging/usr/lib \
>    -Wl,@/opt/uClinux/blackfin-linux-dist/staging/usr/lib/posix.wrappers \
>    -g -fPIC -fmessage-length=0 -mfast-fp -D_GNU_SOURCE -D_REENTRANT -D__XENO__ \
>    -o try try.c -lxenomai -lpthread_rt
> 
> 
> The gdb script contains only a few commands:
> 
> set verbose on
> set solib-absolute-prefix notexistent
> set solib-search-path /opt/uClinux/blackfin-linux-dist/staging/usr/lib:/opt/uClinux/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib
> file try 
> target remote 10.0.10.9:2222
> break main
> cont
> cont
> 
> 
> The pthread_cond_wait, returning EPERM immediately, causes a lockup in a
> program that I'm trying to debug (see old thread about gdb/gdbserver hanging).
> I currently know no measure against this behaviour other than to sleep for a
> while in that case...
> 
> Thanks for any hints!
> Kolja
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



