Message-ID: <511BB60E.7090900@mediso.hu>
Date: Wed, 13 Feb 2013 16:49:34 +0100
From: Norbert Bukuli <norbert.bukuli@mediso.hu>
MIME-Version: 1.0
References: <511B94E4.2070708@mediso.hu> <511B9901.7040104@xenomai.org>
In-Reply-To: <511B9901.7040104@xenomai.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Floating point operations in kernel on powerpc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dear Mr Gerum,

thank you for your kind answer.
As you can see in the example code I do not call explicitly either
_savefpr_XX or rthal_save_fpu and their restore counterparts. I only
do some floating point operations in a Xenomai domain kernel thread.
However the linker misses the routines mentioned earlier.
Are there linker flags to change this behaviour?
One important note, in the kernel configuration the hardware FPU
support is switched on. (CONFIG_XENO_HW_FPU=y)


Probably snippets of the compilation output can help:
Compilation:
  powerpc-linux-gcc -m32
-
-Wp,-MD,/home/bukulin/munka/gantry/Application/gantry/gantry-source/Documentation/snippets/fpu_test/.fpu_test.o.d
 -nostdinc -isystem
/opt/eldk-5.2.1/powerpc/sysroots/i686-eldk-linux/usr/lib/powerpc-linux/gcc/powerpc-linux/4.6.4/include
-
-I/home/bukulin/munka/gantry/Framework/src/Kernel/linux-gccb-v3.2.21_gccb.6/arch/powerpc/include
- -Iarch/powerpc/include/generated -Iinclude
-
-I/home/bukulin/munka/gantry/Framework/src/Kernel/linux-gccb-v3.2.21_gccb.6/include
- -include
/home/bukulin/munka/gantry/Framework/src/Kernel/linux-gccb-v3.2.21_gccb.6/include/linux/kconfig.h

-
-I/home/bukulin/munka/gantry/Application/gantry/gantry-source/Documentation/snippets/fpu_test
- -D__KERNEL__
-
-I/home/bukulin/munka/gantry/Framework/src/Kernel/linux-gccb-v3.2.21_gccb.6/arch/powerpc
- -Iarch/powerpc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
- -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration
- -Wno-format-security -fno-delete-null-pointer-checks -Os -msoft-float
- -pipe
-
-I/home/bukulin/munka/gantry/Framework/src/Kernel/linux-gccb-v3.2.21_gccb.6/arch/powerpc
- -Iarch/powerpc -ffixed-r2 -mmultiple -mno-altivec -mno-spe -mspe=no
- -funit-at-a-time -fno-dwarf2-cfi-asm -mno-string -mcpu=powerpc
- -Wa,-maltivec -Wframe-larger-than=1024 -fno-stack-protector
- -Wno-unused-but-set-variable -fomit-frame-pointer
- -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow
- -fconserve-stack -DCC_HAVE_ASM_GOTO
-
-I/home/bukulin/munka/gantry/Framework/src/Kernel/linux-gccb-v3.2.21_gccb.6/include/xenomai
- -Iinclude/xenomai
-
-I/home/bukulin/munka/gantry/Framework/src/Kernel/linux-gccb-v3.2.21_gccb.6/include/xenomai/posix
- -Iinclude/xenomai/posix -mhard-float  -DMODULE  -D"KBUILD_STR(s)=#s"
- -D"KBUILD_BASENAME=KBUILD_STR(fpu_test)"
- -D"KBUILD_MODNAME=KBUILD_STR(fpu_test)" -c -o
/home/bukulin/munka/gantry/Application/gantry/gantry-source/Documentation/snippets/fpu_test/fpu_test.o
/home/bukulin/munka/gantry/Application/gantry/gantry-source/Documentation/snippets/fpu_test/fpu_test.c

Link:
  powerpc-linux-gcc -m32
-
-Wp,-MD,/home/bukulin/munka/gantry/Application/gantry/gantry-source/Documentation/snippets/fpu_test/.fpu_test.mod.o.d
 -nostdinc -isystem
/opt/eldk-5.2.1/powerpc/sysroots/i686-eldk-linux/usr/lib/powerpc-linux/gcc/powerpc-linux/4.6.4/include
-
-I/home/bukulin/munka/gantry/Framework/src/Kernel/linux-gccb-v3.2.21_gccb.6/arch/powerpc/include
- -Iarch/powerpc/include/generated -Iinclude
-
-I/home/bukulin/munka/gantry/Framework/src/Kernel/linux-gccb-v3.2.21_gccb.6/include
- -include
/home/bukulin/munka/gantry/Framework/src/Kernel/linux-gccb-v3.2.21_gccb.6/include/linux/kconfig.h

-
-I/home/bukulin/munka/gantry/Application/gantry/gantry-source/Documentation/snippets/fpu_test
- -D__KERNEL__
-
-I/home/bukulin/munka/gantry/Framework/src/Kernel/linux-gccb-v3.2.21_gccb.6/arch/powerpc
- -Iarch/powerpc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
- -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration
- -Wno-format-security -fno-delete-null-pointer-checks -Os -msoft-float
- -pipe
-
-I/home/bukulin/munka/gantry/Framework/src/Kernel/linux-gccb-v3.2.21_gccb.6/arch/powerpc
- -Iarch/powerpc -ffixed-r2 -mmultiple -mno-altivec -mno-spe -mspe=no
- -funit-at-a-time -fno-dwarf2-cfi-asm -mno-string -mcpu=powerpc
- -Wa,-maltivec -Wframe-larger-than=1024 -fno-stack-protector
- -Wno-unused-but-set-variable -fomit-frame-pointer
- -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow
- -fconserve-stack -DCC_HAVE_ASM_GOTO
-
-I/home/bukulin/munka/gantry/Framework/src/Kernel/linux-gccb-v3.2.21_gccb.6/include/xenomai
- -Iinclude/xenomai
-
-I/home/bukulin/munka/gantry/Framework/src/Kernel/linux-gccb-v3.2.21_gccb.6/include/xenomai/posix
- -Iinclude/xenomai/posix -mhard-float  -D"KBUILD_STR(s)=#s"
- -D"KBUILD_BASENAME=KBUILD_STR(fpu_test.mod)"
- -D"KBUILD_MODNAME=KBUILD_STR(fpu_test)" -DMODULE  -c -o
/home/bukulin/munka/gantry/Application/gantry/gantry-source/Documentation/snippets/fpu_test/fpu_test.mod.o
/home/bukulin/munka/gantry/Application/gantry/gantry-source/Documentation/snippets/fpu_test/fpu_test.mod.c


Thank you!

On 2013-02-13 14:45, Philippe Gerum wrote:
> On 02/13/2013 02:28 PM, Norbert Bukuli wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> Dear List Members,
>> 
>> First of all, this will be a newbie question, sorry for it. 
>> Shortly, I have to port an old RTAI based kernelspace
>> application to Xenomai userpace. This application uses FPU so we
>> compile it hard float support. First step of the porting is
>> switching the real-time extension. I am done with this, however I
>> have some compilation warnings: WARNING: "_restfpr_22_x"
>> [app.ko] undefined! WARNING: "_restfpr_29_x" [app.ko] undefined!
>> WARNING: "_savefpr_22" [app.ko] undefined! WARNING: "_savefpr_29"
>> [app.ko] undefined!
>> 
>> I reproduced these warnings with the following example kernel 
>> module: http://pastebin.com/AAehcivx
>> 
>> The corresponding Kbuild is:
>> 
>> obj-m := fpu_test.o ccflags-y += -Iinclude/xenomai 
>> -Iinclude/xenomai/posix -mhard-float
>> 
>> As I see, the missing functions should be in the C runtime 
>> library, however the kernel library 
>> (arch/powerpc/lib/crtsavres.S) contains only save/restore macros 
>> for general purpose registers. On the other hand, the Xenomai 
>> extensions provides kernelspace FPU facility and the T_FPU flag 
>> was turned on rt_task_create(). So, my question is, how can I 
>> eliminate this problem?
>> 
> 
> Xenomai's context switching code does the necessary housekeeping to
> save/restore fprs. You don't have to call these routines.
> 

- -- 
Best regards,
Norbert Bukuli
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJRG7YOAAoJEJEs22zQJ00S6+4H+wVDpKCnDdiYpULaGNO8ls7O
9AzCQuj9QKOvWm3hFPfE1dJrclaDRu0JJKIHLl+Exxluo05+wN7/veRBuNtQQRnB
sq3QFq0Bbo3P/s0ihqSQCuFiB70666uSD73p4Tlct8juvffnDvw4EhwMU9RQzoNW
KcDw488/YdwBxy7hpn5qqoEDuu+55NiKn/kH5fRpnuvBq1gKQ1CTVd6WLLXypjcQ
BgNzAoQyaKKx+iavfPXjIZ6ElJpTwX+ON0wwh8zXaSTy0WTsBYlR9xYhQgMA51jI
3rYePEQZPs1kqSHaj4cKyZyfIpuH/lYmUc3w7cQLyCA+iK5Le55L+adFzQIOykE=
=UmzM
-----END PGP SIGNATURE-----

