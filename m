Message-ID: <4720C9ED.8070402@domain.hid>
Date: Thu, 25 Oct 2007 18:53:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB266@domain.hid>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB266@domain.hid>
Content-Type: multipart/mixed; boundary="------------030008030406060606080808"
Subject: Re: [Xenomai-help] Problems building Xenomai 2.4-rc4 and linux2.6.23
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------030008030406060606080808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Fillod Stephane wrote:
> Robert Gubler wrote:
> [...]
>>    AS      arch/i386/boot/compressed/head.o
>>    CC      arch/i386/boot/compressed/misc.o 
>> In file included from include/linux/ipipe_base.h:29,
>>                   from include/linux/kernel.h:17,
>>                   from include/asm/system.h:4,
>>                   from include/asm/processor.h:18, 
>>                   from include/asm/thread_info.h:16,
>>                   from include/linux/thread_info.h:21,
>>                   from include/linux/preempt.h:9,
>>                   from include/linux/spinlock.h:49, 
>>                   from include/linux/vmalloc.h:4,
>>                   from arch/i386/boot/compressed/misc.c:14:
>> include/asm/ipipe_base.h:26:25: error: irq_vectors.h: No such file or
>> directory
>> make[2]: *** [arch/i386/boot/compressed/misc.o] Error 1
>> make[1]: *** [arch/i386/boot/compressed/vmlinux] Error 2
>> make: *** [bzImage] Error 2
> 
> I had the same issue with this setup(*). It went away when I switched 
> the subarch from CONFIG_X86_GENERICARCH (default with FC) to CONFIG_X86_PC.
> 
> setup:
> linux-2.6.23.1.tar.bz2
> xenomai-2.4-rc4.tar.bz2
> adeos-ipipe-2.6.23-i386-1.10-10.patch
> 
> If you do need GENERICARCH, you can tweak arch/i386/boot/compressed/Makefile
> and add -I${yourlinuxabsolutepath}/include/asm-i386/mach-default to CFLAGS.

The attached patch fixes it (failed to find the time for posting it
earlier, sorry). Philippe, we do need my original version here, mflags-y
is not enough (actually, it is not needed now).

> 
> BTW, I had also to patch include/asm-i386/mach-default/mach_time.h,
> adding a missing #include <linux/bcd.h> for BCD macros.
> 

That doesn't tell me anything. Also with the default .config and
X86_GENERIC? Otherwise, please provide the involved .config.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------030008030406060606080808
Content-Type: text/x-patch;
 name="fix-CONFIG_X86_GENERIC.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-CONFIG_X86_GENERIC.patch"

Index: linux-2.6.23/arch/i386/boot/compressed/Makefile
===================================================================
--- linux-2.6.23.orig/arch/i386/boot/compressed/Makefile
+++ linux-2.6.23/arch/i386/boot/compressed/Makefile
@@ -11,7 +11,7 @@ EXTRA_AFLAGS	:= -traditional
 LDFLAGS_vmlinux := -T
 hostprogs-y	:= relocs
 
-CFLAGS  := -m32 -D__KERNEL__ $(LINUXINCLUDE) $(mflags-y) -O2 \
+CFLAGS  := -m32 -D__KERNEL__ $(LINUXINCLUDE) -Iinclude/asm-i386/mach-default -O2 \
 	   -fno-strict-aliasing -fPIC \
 	   $(call cc-option,-ffreestanding) \
 	   $(call cc-option,-fno-stack-protector)

--------------030008030406060606080808--

