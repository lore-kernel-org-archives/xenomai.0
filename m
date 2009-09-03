From: Andreas Glatz <andreasglatz@domain.hid>
In-Reply-To: <1251272663.2944.7.camel@domain.hid>
References: <1251243937.10269.32.camel@domain.hid>
	<1251272663.2944.7.camel@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Sep 2009 16:44:17 -0400
Message-Id: <1252010657.27175.52.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai 2.4.9: Debugger freezes when
	stepping	with gdb/gdbserver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

Hi Philippe,

On Wed, 2009-08-26 at 09:44 +0200, Philippe Gerum wrote:
> On Tue, 2009-08-25 at 19:45 -0400, Andreas Glatz wrote:
> > Hi,
> > 
> > As I already told u, we upgraded to the newest Xenomai version (2.4.9)
> > and now we are experiencing problems when trying to step through 
> > the application with gdb/gdbserver which we haven't seen with previous
> > version of Xenomai/Linux kernel. Basically, if I run the whole thing
> > as described below on Xenomai 2.4.8 (with the alignment patch)
> > everything works fine...
> > 
> > Configuration:
> > - MPC8360
> > - Linux 2.6.30
> > - Ipipe 2.7-00
> > - Xenomai 2.4.9
> > - Alignment patch applied (see previous post)
> > 

> > <snip>
> > powerpc-linux-gnu-gdb -x gdbinit_ROX_MPC83XX_hu
> > GNU gdb 6.8-debian
> > Copyright (C) 2008 Free Software Foundation, Inc.
> > License GPLv3+: GNU GPL version 3 or later
> > <http://gnu.org/licenses/gpl.html>
> > This is free software: you are free to change and redistribute it.
> > There is NO WARRANTY, to the extent permitted by law.  Type "show
> > copying"
> > and "show warranty" for details.
> > This GDB was configured as "--host=i486-linux-gnu
> > --target=powerpc-linux-gnu".
> > Breakpoint 1 at 0x10001c98: file main.c, line 37.
> > (gdb) b main.c:24
> > Breakpoint 2 at 0x10001b68: file main.c, line 24.
> > (gdb) run
> > Starting
> > program: /home/andreasglatz/ROX-RCLib/ROX-RCLibrary/ROX-MPC83XX/out/main 
> > [New Thread 3316]
> > Error while mapping shared library sections:
> 
> That sounds bad. Could you try bissecting the I-pipe support, namely
> 2.6.29.4-powerpc-2.5-01, 2.6.29.4-powerpc-2.6-00 and eventually
> 2.6.30-powerpc-2.6-03 if no difference arises between the first two?
> TIA,

Finally I found some time to investigate that gdb/gdbserver issue.

The good news is that it doesn't seem to be Xenomai or Ipipe related.

I could reproduce the same problem with a test application
which used pthread_create instead of rt_task_create. And further 
investigation confirmed that gdbserver hangs when trying to 
single step because it doesn't receive SIGSTOP from the kernel
for a child process which was created (gdbserver stops all the
threads of an application when single stepping...).

So something must have changed in 2.6.30 as everything runs fine on 
2.6.26. I have to admit though that I haven't checked yet if
things run fine on a Vanilla kernel.

I think, I'm gonna do that first and try to report it to a gdb NG.

Andreas


