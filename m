Message-ID: <44722D40.3090108@domain.hid>
Date: Mon, 22 May 2006 23:29:36 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Almost running - kernel BUG in add_preempt_count
	at	kernel/sched.c:2819!
References: <B4D14EA407C38B4DAF92B8EAC9249D7F02D0F285@domain.hid>
	<446E2107.8060504@domain.hid>
	<200605192019.k4JKJJFN007810@domain.hid>
	<446F5803.8030607@domain.hid> <446F8606.90704@domain.hid>
	<200605221925.k4MJPj5p019807@domain.hid>
In-Reply-To: <200605221925.k4MJPj5p019807@domain.hid>
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
To: wallace@domain.hid
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid, Jim.Rosenow@domain.hid

Gary Wallace wrote:
>   When I patch a generic 2.6.16.6 kernel with
> adeos-ipipe-2.6.14-ppc-1.3-03 and ipipe-tracer-2.6.14-ppc-1.3-03 and
> then enable the ipipe tracer I receive the undefined _mcount errors
> from the kernel build.  This happens even without the motorola patch.
> 
>   During the kernel build arch/ppc/kernel/ipipe-mcount.S is compiled
> to arch/ppc/kernel/ipipe-mcount.o, but for some reason ld still
> complains that _mcount is undefined.

Having your .config file would help.

> 
> Gary
> 
> --------------------------------------
> 
> 
>>Date: Sat, 20 May 2006 23:11:34 +0200
>>From: Philippe Gerum <rpm@xenomai.org>
>>
>>Jan Kiszka wrote:
>>
>>>Gary Wallace wrote:
>>>
>>>
>>>> My story is the same as Jim's except I used 2.6.16.6 and a gcc 3.3.3
>>>>cross compiler.  The ipipe patch applies just fine after the motorola
>>>>patch.  Building with ipipe disabled results in a kernel that boots
>>>>and runs just fine.  When ipipe is enabled, I sometimes get the error
>>>>Jim received, sometimes the kernel just hangs.  There is never a stack
>>>>trace on the console.  I've tried ipipe versions 1.2-01, 1.2-03,
>>>>1.3-00, 1.3-02, and 1.3-03, all with the same results (either the
>>>>kernel hangs or I get the kernel BUG error).
>>>>
>>>> I haven't been able to get the board to boot without using the
>>>>motorola patch.
>>>>
>>>> I have tried building with ipipe-tracer, but this results in compile
>>>>errors (the tracer patch applies just fine).  Here are the compile
>>>>errors when ipipe-tracer is enabled:
>>>>
>>>># make
>>>> CHK     include/linux/version.h
>>>> CHK     include/linux/compile.h
>>>> CHK     usr/initramfs_list
>>>> UIMAGE  arch/ppc/boot/images/uImage
>>>>"mkimage" command not found - U-Boot images will not be built
>>>> Image: arch/ppc/boot/images/uImage not made
>>>> AS      arch/ppc/boot/simple/head.o
>>>> AS      arch/ppc/boot/simple/relocate.o
>>>> CC      arch/ppc/boot/simple/misc.o
>>>> CC      arch/ppc/boot/simple/misc-mv64x60.o
>>>>powerpc-750-linux-gnu-objcopy -O elf32-powerpc \
>>>>       --add-section=.image=arch/ppc/boot/images/vmlinux.gz \
>>>>       --set-section-flags=.image=contents,alloc,load,readonly,data \
>>>>       arch/ppc/boot/simple/dummy.o arch/ppc/boot/simple/image.o
>>>>powerpc-750-linux-gnu-ld -T /usr/src/linux-2.6.14.6-ppc/arch/ppc/boot/ld.script -Ttext 0x00800000 -Bstatic -o arch/ppc/boot/simple/zvmlinux arch/ppc/boot/simple/head.o arch/ppc/boot/simple/relocate.o arch/ppc/boot/simple/misc.o arch/ppc/boot/simple/misc-mv64x60.o arch/ppc/boot/simple/image.o arch/ppc/boot/common/lib.a arch/ppc/boot/lib/lib.a
>>>>arch/ppc/boot/simple/misc.o(.text+0x10): In function `get_mem_size':
>>>>arch/ppc/boot/simple/misc.c:87: undefined reference to `_mcount'
>>>>arch/ppc/boot/simple/misc.o(.text+0x54): In function `decompress_kernel':
>>>>arch/ppc/boot/simple/misc.c:93: undefined reference to `_mcount'
>>>>arch/ppc/boot/simple/misc.o(.text+0x4b8): In function `board_isa_init':
>>>>arch/ppc/boot/simple/misc.c:274: undefined reference to `_mcount'
>>>>arch/ppc/boot/simple/misc.o(.text+0x4f8): In function `load_kernel':
>>>>arch/ppc/boot/simple/misc.c:281: undefined reference to `_mcount'
>>>>arch/ppc/boot/simple/misc-mv64x60.o(.text+0x10): In function `mv64360_get_mem_size':
>>>>arch/ppc/boot/simple/misc-mv64x60.c:31: undefined reference to `_mcount'
>>>>arch/ppc/boot/simple/misc-mv64x60.o(.text+0xbc):arch/ppc/boot/simple/misc-mv64x60.c:51: more undefined references to `_mcount' follow
>>>>make[2]: *** [arch/ppc/boot/simple/zvmlinux] Error 1
>>>>make[1]: *** [simple] Error 2
>>>>make: *** [zImage] Error 2
>>>># 
>>>>
>>>
>>>
>>>Philippe, can you comment on this? I do not have an PPC build
>>>environment at hand.
>>>
>>
>>I can't reproduce it here, but that does not mean much, since I can't 
>>select the same setup anyway, due to the missing patch. Is the file 
>>arch/ppc/ipipe-mcount.S listed as being compiled during the kernel build?
>>
>>
>>>@Gary: Do you get the same error without the Motorola patch?
>>>
>>
>>
>>-- 
>>
>>Philippe.
>>
> 
> 


-- 

Philippe.

