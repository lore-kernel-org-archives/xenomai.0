From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17379.21361.248057.857514@domain.hid>
Date: Fri, 3 Feb 2006 13:58:25 +0100
Subject: Re: [Xenomai-core] xenomai posix build errs
In-Reply-To: <43E28991.80509@domain.hid>
References: <43E28991.80509@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org

Jim Cromie wrote:
 > 
 > build error after selecting POSIX interface,
 > on svn-head - ie 515
 > 
 > [jimc@domain.hid linux-2.6.15.1-ipipe-103-sonyI]$ make
 > CHK include/linux/version.h
 > SPLIT include/linux/autoconf.h -> include/config/*
 > CHK include/linux/compile.h
 > CHK usr/initramfs_list
 > CC [M] kernel/xenomai/skins/posix/sched.o
 > In file included from kernel/xenomai/skins/posix/../posix/internal.h:24,
 > from kernel/xenomai/skins/posix/../posix/thread.h:23,
 > from kernel/xenomai/skins/posix/sched.c:19:
 > include/xenomai/posix/posix.h:43:19: error: errno.h: No such file or 
 > directory

Could you try re-running prepare-kernel.sh ?

-- 


					    Gilles Chanteperdrix.

