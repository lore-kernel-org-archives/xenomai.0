Message-ID: <4B655C00.6090809@domain.hid>
Date: Sun, 31 Jan 2010 11:31:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <fd55ced7db48fe30f8139df895fb9d4c.squirrel@domain.hid>
In-Reply-To: <fd55ced7db48fe30f8139df895fb9d4c.squirrel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai 2.5.0 uclibc 0.30 compatibility?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: sinisa.denic@domain.hid
Cc: xenomai@xenomai.org

sinisa.denic@domain.hid wrote:
> In file included from ../../../src/include/asm/xenomai/atomic.h:82,
>                  from ../../../include/nucleus/system.h:26,
>                  from ../../../src/include/asm/xenomai/system.h:223,
>                  from ../../../include/nucleus/types.h:40,
>                  from ../../../include/nucleus/thread.h:25,
>                  from ../../../include/posix/pthread.h:136,
> 
> from
> /opt/toolchains/arm926t-uclibcgnueabi/usr/include/bits/uClibc_mutex.h:15,
> 
> from
> /opt/toolchains/arm926t-uclibcgnueabi/usr/include/bits/uClibc_stdio.h:119,
> 
> from /opt/toolchains/arm926t-uclibcgnueabi/usr/include/stdio.h:72,
>                  from init.c:19:
> ../../../src/include/asm/xenomai/syscall.h: In
> function &#8216;xeno_arm_features_check&#8217;:
> ../../../src/include/asm/xenomai/syscall.h:377: error:
> &#8216;stderr&#8217; undeclared
> (first use in this function)
> ../../../src/include/asm/xenomai/syscall.h:377: error: (Each undeclared
> identifier is reported only once
> ../../../src/include/asm/xenomai/syscall.h:377: error: for each function it
> appears in.)

This is bad news, the problem is that uclibc's stdio.h needs pthread.h,
which because of the -I flags we pass is xenomai's pthread.h, which
includes asm/syscall.h, which needs stdio.h.

You can fix this locally by #including pthread.h before stdio.h. We will
 propose a better fix for 2.5.1.

-- 
Gilles Chanteperdrix

