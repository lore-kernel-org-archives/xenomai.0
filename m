Message-ID: <43954D56.9020909@domain.hid>
Date: Tue, 06 Dec 2005 09:35:34 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai-PPC: Two problems
References: <25192.193.52.24.125.1133817387.squirrel@domain.hid>
In-Reply-To: <25192.193.52.24.125.1133817387.squirrel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: smannori@domain.hid
Cc: xenomai@xenomai.org

smannori@domain.hid wrote:
> Hi everybody.
> 

<snip>

> 2) If I activate the interrupt shield in the kernel, the kernel compilation
> stops this this message:
> 
> root@domain.hid# make
>   CHK     include/linux/version.h
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   CHK     include/linux/compile.h
>   CHK     usr/initramfs_list
>   CC      kernel/xenomai/nucleus/pod.o
>   CC      kernel/xenomai/nucleus/shadow.o
> kernel/xenomai/nucleus/shadow.c: In function `engage_irq_shield':
> kernel/xenomai/nucleus/shadow.c:164: warning: implicit declaration of
> function `__raw_read_lock'
> kernel/xenomai/nucleus/shadow.c:170: warning: implicit declaration of
> function `__raw_read_unlock'
> kernel/xenomai/nucleus/shadow.c: In function `disengage_irq_shield':
> kernel/xenomai/nucleus/shadow.c:188: warning: implicit declaration of
> function `__raw_write_lock'
> kernel/xenomai/nucleus/shadow.c:198: warning: implicit declaration of
> function `__raw_write_unlock'

This has been fixed in the latest ppc patch:
http://download.gna.org/adeos/patches/v2.6/adeos/ppc/adeos-ipipe-2.6.14-ppc-1.0-07.patch

-- 

Philippe.

