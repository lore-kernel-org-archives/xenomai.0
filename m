Date: Tue, 23 May 2006 18:48:55 -0400 (EDT)
Message-Id: <200605232248.k4NMmtqC024042@domain.hid>
From: Gary Wallace <wallace@domain.hid>
Subject: Re: [Xenomai-help] Almost running - kernel BUG in add_preempt_count
	at	kernel/sched.c:2819!
References: <447231CC.9080708@domain.hid>
	<44732162.8050606@domain.hid>
Reply-To: wallace@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid, Jim.Rosenow@domain.hid

  Thanks for the Makefile patch.  The kernel successfully compiles
with the tracer enabled after applying this.  Unfortunately I am now
getting a different error at boot time.

  The image file downloads and starts executing but fails with:

Uncompressing Linux...inflate returned FFFFFFFB
exit

Gary

------------------------------------

>Date: Tue, 23 May 2006 16:51:14 +0200
>From: Philippe Gerum <rpm@xenomai.org>
>
>Gary Wallace wrote:
>>   I've attached first the config file used without the motorola
>> patches, and then the config file used with a motorola patched
>> kernel.
>
>Try this:
>
>--- arch/ppc/boot/Makefile~	2006-01-31 07:52:07.000000000 +0100
>+++ arch/ppc/boot/Makefile	2006-05-23 16:49:46.000000000 +0200
>@@ -13,6 +13,14 @@
>  CFLAGS	 	+= -fno-builtin -D__BOOTER__ -Iarch/$(ARCH)/boot/include
>  HOSTCFLAGS	+= -Iarch/$(ARCH)/boot/include
>
>+ifdef CONFIG_IPIPE_TRACE
>+# do not trace the boot loader
>+nullstring :=
>+space      := $(nullstring) # end of the line
>+pg_flag     = $(nullstring) -pg # end of the line
>+CFLAGS     := $(subst ${pg_flag},${space},${CFLAGS})
>+endif
>+
>  BOOT_TARGETS	= zImage zImage.initrd znetboot znetboot.initrd
>
>  bootdir-y			:= simple
>
>-- 
>
>Philippe.
>

