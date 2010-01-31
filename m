Message-ID: <4B655AA4.1020002@domain.hid>
Date: Sun, 31 Jan 2010 11:25:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201001292104.42395.lux-integ@domain.hid>
In-Reply-To: <201001292104.42395.lux-integ@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] help with xenomai-2.5.0 on pure64bit linux x86_64
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: lux-integ <lux-integ@domain.hid>
Cc: xenomai@xenomai.org

lux-integ wrote:
> d) but when I type make  I encountered a failure  like so:-
> 
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/basic/docproc
>   HOSTCC  scripts/basic/hash
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/kxgettext.o
>   SHIPPED scripts/kconfig/zconf.tab.c
>   SHIPPED scripts/kconfig/lex.zconf.c
>   SHIPPED scripts/kconfig/zconf.hash.c
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTLD  scripts/kconfig/conf
> scripts/kconfig/conf -s arch/x86/Kconfig
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   UPD     include/linux/utsrelease.h
>   SYMLINK include/asm -> include/asm-x86
>   CC      kernel/bounds.s
>   GEN     include/linux/bounds.h
>   CC      arch/x86/kernel/asm-offsets.s
> In file included from include/linux/sched.h:62,
>                  from arch/x86/kernel/asm-offsets_64.c:8,
>                  from arch/x86/kernel/asm-offsets.c:4:
> include/linux/ipipe.h:76:2: error: #error "CONFIG_NR_CPUS is too large, please 
> lower it."
> make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1

This is starting to become an FAQ, and will undoubtedly be fixed in
future versions. In the meantime, please disable CONFIG_SPARSE_IRQ.

-- 
Gilles Chanteperdrix

