Message-ID: <43E70D55.4090305@domain.hid>
Date: Mon, 06 Feb 2006 01:48:21 -0700
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] xenomai posix build errs
References: <43E28991.80509@domain.hid>
	<17379.21361.248057.857514@domain.hid>
In-Reply-To: <17379.21361.248057.857514@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Jim Cromie wrote:
>  > 
>  > build error after selecting POSIX interface,
>  > on svn-head - ie 515
>  > 
>  > [jimc@domain.hid linux-2.6.15.1-ipipe-103-sonyI]$ make
>  > CHK include/linux/version.h
>  > SPLIT include/linux/autoconf.h -> include/config/*
>  > CHK include/linux/compile.h
>  > CHK usr/initramfs_list
>  > CC [M] kernel/xenomai/skins/posix/sched.o
>  > In file included from kernel/xenomai/skins/posix/../posix/internal.h:24,
>  > from kernel/xenomai/skins/posix/../posix/thread.h:23,
>  > from kernel/xenomai/skins/posix/sched.c:19:
>  > include/xenomai/posix/posix.h:43:19: error: errno.h: No such file or 
>  > directory
>
> Could you try re-running prepare-kernel.sh ?
>
>   
yes, that worked.  thanks,

Odd thing is, it caused a make to run 'make oldconfig',
*and* it rejected XENO_* config items as unknown.
Dunno why, but poking/rerunning it a few more times fixed things.

sorry for the delay in anwering.

