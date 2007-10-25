Message-ID: <4720D056.1010403@domain.hid>
Date: Thu, 25 Oct 2007 19:20:22 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB266@domain.hid>
	<4720C9ED.8070402@domain.hid>
In-Reply-To: <4720C9ED.8070402@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Problems building Xenomai 2.4-rc4 and linux2.6.23
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Fillod Stephane wrote:
>> Robert Gubler wrote:
>> [...]
>>>    AS      arch/i386/boot/compressed/head.o
>>>    CC      arch/i386/boot/compressed/misc.o 
>>> In file included from include/linux/ipipe_base.h:29,
>>>                   from include/linux/kernel.h:17,
>>>                   from include/asm/system.h:4,
>>>                   from include/asm/processor.h:18, 
>>>                   from include/asm/thread_info.h:16,
>>>                   from include/linux/thread_info.h:21,
>>>                   from include/linux/preempt.h:9,
>>>                   from include/linux/spinlock.h:49, 
>>>                   from include/linux/vmalloc.h:4,
>>>                   from arch/i386/boot/compressed/misc.c:14:
>>> include/asm/ipipe_base.h:26:25: error: irq_vectors.h: No such file or
>>> directory
>>> make[2]: *** [arch/i386/boot/compressed/misc.o] Error 1
>>> make[1]: *** [arch/i386/boot/compressed/vmlinux] Error 2
>>> make: *** [bzImage] Error 2
>> I had the same issue with this setup(*). It went away when I switched 
>> the subarch from CONFIG_X86_GENERICARCH (default with FC) to CONFIG_X86_PC.
>>
>> setup:
>> linux-2.6.23.1.tar.bz2
>> xenomai-2.4-rc4.tar.bz2
>> adeos-ipipe-2.6.23-i386-1.10-10.patch
>>
>> If you do need GENERICARCH, you can tweak arch/i386/boot/compressed/Makefile
>> and add -I${yourlinuxabsolutepath}/include/asm-i386/mach-default to CFLAGS.
> 
> The attached patch fixes it (failed to find the time for posting it
> earlier, sorry). Philippe, we do need my original version here, mflags-y
> is not enough (actually, it is not needed now).

The proper fix is the one below. Forcing mach-default as your patch does
would prevent the per-platform overrides to happen for some headers,
like irq_vectors.h. We do need the contents of mflags-y to be passed to
the leaf Makefile, verbatim. It's only a matter of proper quoting of
theisvariable when running make recursively, actually.

diff --git a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile
index f78f5fe..4e6a230 100644
--- a/arch/i386/boot/Makefile
+++ b/arch/i386/boot/Makefile
@@ -94,7 +94,7 @@ $(obj)/setup.bin: $(obj)/setup.elf FORCE
 	$(call if_changed,objcopy)

 $(obj)/compressed/vmlinux: FORCE
-	$(Q)$(MAKE) $(build)=$(obj)/compressed mflags-y=$(mflags-y)
IMAGE_OFFSET=$(IMAGE_OFFSET) $@
+	$(Q)$(MAKE) $(build)=$(obj)/compressed mflags-y="$(mflags-y)"
IMAGE_OFFSET=$(IMAGE_OFFSET) $@

 # Set this if you want to pass append arguments to the
zdisk/fdimage/isoimage kernel
 FDARGS =
{rpm@xenomai.org} git diff arch/i386
diff --git a/arch/i386/Makefile b/arch/i386/Makefile
index 3b17aed..1fc6175 100644
--- a/arch/i386/Makefile
+++ b/arch/i386/Makefile
@@ -128,7 +128,7 @@ all: bzImage
 zImage zlilo zdisk: KBUILD_IMAGE := arch/i386/boot/zImage

 zImage bzImage: vmlinux
-	$(Q)$(MAKE) $(build)=$(boot) mflags-y=$(mflags-y) $(KBUILD_IMAGE)
+	$(Q)$(MAKE) $(build)=$(boot) mflags-y="$(mflags-y)" $(KBUILD_IMAGE)

 compressed: zImage

diff --git a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile
index f78f5fe..4e6a230 100644
--- a/arch/i386/boot/Makefile
+++ b/arch/i386/boot/Makefile
@@ -94,7 +94,7 @@ $(obj)/setup.bin: $(obj)/setup.elf FORCE
 	$(call if_changed,objcopy)

 $(obj)/compressed/vmlinux: FORCE
-	$(Q)$(MAKE) $(build)=$(obj)/compressed mflags-y=$(mflags-y)
IMAGE_OFFSET=$(IMAGE_OFFSET) $@
+	$(Q)$(MAKE) $(build)=$(obj)/compressed mflags-y="$(mflags-y)"
IMAGE_OFFSET=$(IMAGE_OFFSET) $@

 # Set this if you want to pass append arguments to the
zdisk/fdimage/isoimage kernel
 FDARGS =

-- 
Philippe.

