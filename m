MIME-Version: 1.0
In-Reply-To: <CAKS01omHoKh6EVznDXULTuxBS0O=3=V0fWL+24Z_8HgOuCAfxA@mail.gmail.com>
References: <CAKS01omHoKh6EVznDXULTuxBS0O=3=V0fWL+24Z_8HgOuCAfxA@mail.gmail.com>
Date: Mon, 21 Oct 2013 14:39:41 +0200
Message-ID: <CAKS01okgeh+nEV=9fNKXGBuUCYMiUo5bVOBGYhMZmtdKi5Nt-A@mail.gmail.com>
From: Anup Kini <akini@synapticon.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] error while porting Xenomai to linux-xlnx-V14.5 zynq
	soc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

an update:

i find the following function call in : *
drivers/remoteproc/zynq_remoteproc.c*
line 267:
        local->ipino = be32_to_cpup(of_prop);
*        ret = set_ipi_handler(local->ipino, ipi_kick, "Firmware kick");*
        if (ret) {
                dev_err(&pdev->dev, "IPI handler already registered\n");
                goto ipi_fault;
        }

is this suppose to be here, i checked all the three patches and this file
doesnt have any changes.
Let me know if there is an additional patch file that i have missed out.



On 21 October 2013 14:31, Anup Kini <akini@synapticon.com> wrote:

> Hi All,
>
> I am trying to port Xenomai 2.6.3 to linux-xlnx tag=14.5 as mentioned in
> the wiki.
> I could successfully run prepare-kernel.sh but failed to build the modules.
>
> patches applied: in the below mentioned order.
>  - ipipe-core-3.8-zynq-pre.patch
>  - ipipe-core-3.8-arm-1.patch
>  - ipipe-core-3.8-zynq-post.patch
>
> prepare-kernel.sh --arch=arm --linux=$LINUX_DIR
> cd $LINUX_DIR
>
> make ARCH=arm CROSS_COMPILE=arm-xilinx-linux-gnueabi xilinx_zynq_defconfig
> make ARCH=arm CROSS_COMPILE=arm-xilinx-linux-gnueabi
> CONFIG_DEBUG_SECTION_MISMATCH=y bzImage modules
>
>   LINK    vmlinux
>   LD      vmlinux.o
>   MODPOST vmlinux.o
> WARNING: vmlinux.o(.text+0xe510): Section mismatch in reference from the
> function armpmu_register() to the function .init.text:armpmu_init()
> The function armpmu_register() references
> the function __init armpmu_init().
> This is often because armpmu_register lacks a __init
> annotation or the annotation of armpmu_init is wrong.
>
> WARNING: vmlinux.o(.text+0x10128): Section mismatch in reference from the
> function __ipipe_tsc_register() to the variable
> .init.text:__ipipe_tsc_area_start
> The function __ipipe_tsc_register() references
> the variable __init __ipipe_tsc_area_start.
> This is often because __ipipe_tsc_register lacks a __init
> annotation or the annotation of __ipipe_tsc_area_start is wrong.
>
> WARNING: vmlinux.o(.text+0x10130): Section mismatch in reference from the
> function __ipipe_tsc_register() to the variable
> .init.text:__kuser_helper_end
> The function __ipipe_tsc_register() references
> the variable __init __kuser_helper_end.
> This is often because __ipipe_tsc_register lacks a __init
> annotation or the annotation of __kuser_helper_end is wrong.
>
> WARNING: vmlinux.o(.text+0x2942dc): Section mismatch in reference from the
> function vexpress_sysreg_probe() to the function
> .init.text:vexpress_sysreg_setup()
> The function vexpress_sysreg_probe() references
> the function __init vexpress_sysreg_setup().
> This is often because vexpress_sysreg_probe lacks a __init
> annotation or the annotation of vexpress_sysreg_setup is wrong.
>
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   KSYM    .tmp_kallsyms1.o
>   KSYM    .tmp_kallsyms2.o
>   LD      vmlinux
>   SORTEX  vmlinux
> sort done marker at 602c48
>   SYSMAP  System.map
>   OBJCOPY arch/arm/boot/Image
>   Kernel: arch/arm/boot/Image is ready
>   GZIP    arch/arm/boot/compressed/piggy.gzip
>   AS      arch/arm/boot/compressed/piggy.gzip.o
>   CC      arch/arm/boot/compressed/misc.o
>   CC      arch/arm/boot/compressed/decompress.o
>   CC      arch/arm/boot/compressed/string.o
>   LD      arch/arm/boot/compressed/vmlinux
>   OBJCOPY arch/arm/boot/zImage
>   Kernel: arch/arm/boot/zImage is ready
>   Building modules, stage 2.
>   MODPOST 20 modules
> ERROR: "set_ipi_handler" [drivers/remoteproc/zynq_remoteproc.ko] undefined!
> ERROR: "clear_ipi_handler" [drivers/remoteproc/zynq_remoteproc.ko]
> undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
>
>
> The entire make output is in the following link:
> http://pastebin.com/dyjZnh9F
>
> Let me know if i am missing some patch or should use a older version of
> xenomai.
>
> --
>
> *Anup Kini
> *Systems Engineer****
> *
> ------------------------------
> *
>
> *Synapticon** * |  Cyber-Physical System Solutions ****
>
> Mobile:
>
> Direct:
>
> +49 151 / 638 646 73
>
> +49 7335 / 186 999 21
>
> Fax:****
> +49 7335 / 186 999 1
>
>
>  **
>
>  ****
>
> synapticon.com <http://www.synapticon.com/>  |  @synapticon_co<https://twitter.com/#!/synapticon_co>
> ****
>
> Synapticon GmbH  |  Hohlbachweg 2  |  73344 Gruibingen, DE
> Secretary +49 7335 / 186 999 0  |  General Manager: Nikolai Ensslen
> Registry Court Ulm HRB 725114  |  USt-ID DE271647127****
>
> This message and any files transmitted with it are confidential and
> intended
> solely for the use of the individual or entity to whom they are addressed.
> Please notify the sender immediately if you have received this e-mail by
> mistake and delete it from your system.
>



-- 

*Anup Kini
*Systems Engineer****
*
------------------------------
*

*Synapticon** * |  Cyber-Physical System Solutions ****

Mobile:

Direct:

+49 151 / 638 646 73

+49 7335 / 186 999 21

Fax:****
+49 7335 / 186 999 1


 **

 ****

synapticon.com <http://www.synapticon.com/>  |
@synapticon_co<https://twitter.com/#!/synapticon_co>
****

Synapticon GmbH  |  Hohlbachweg 2  |  73344 Gruibingen, DE
Secretary +49 7335 / 186 999 0  |  General Manager: Nikolai Ensslen
Registry Court Ulm HRB 725114  |  USt-ID DE271647127****

This message and any files transmitted with it are confidential and
intended
solely for the use of the individual or entity to whom they are addressed.
Please notify the sender immediately if you have received this e-mail by
mistake and delete it from your system.
