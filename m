Message-ID: <4B163F13.90400@domain.hid>
Date: Wed, 02 Dec 2009 11:18:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <c024fefc0912011838r6d34e396se2a276e5d7316786@domain.hid>	
	<4B162421.20907@domain.hid>
	<c024fefc0912020042v7bfe223q8f67c7787284c066@domain.hid>
In-Reply-To: <c024fefc0912020042v7bfe223q8f67c7787284c066@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai Ready PC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Adrian Boeing <aboeing@domain.hid>
Cc: xenomai@xenomai.org

Adrian Boeing wrote:
> We are having trouble just getting the PC to install linux (it fails
> to install, and if we install on another machine, and bring the HDD
> across then it boots very very slowly), we also have to write our own
> Xenomai CAN drivers.

So your problem seems rather to be with Linux than with Xenomai? Or did
you recompile the kernel?

As far as I know, a distribution with a non working kernel for your PC
can nevertheless be installed on the PC provided that you change the
kernel used for installation, and use that same kernel once the
distribution installed. Slow boot probably means that the kernel is
using the wrong drivers for the disk. That is because upon first
installation, the initrd/initramfs that is build and will be used for
next boots is specific to your disk controller. This can be fixed after
the slow boot by rerunning mkinitrd/mkinitramfs/whatever your
distribution provides to re-adapt the initrd/initramfs to your disk
controller. But you can avoid this issue completely by building a kernel
tailored to your PC without even the need for an initrd/initramfs.

Of course, if your chipset/disk controller is not even recognized by
recent kernels, you are toast. But that should be the exception, not the
rule.

> 
> We would strongly prefer to purchase a complete system that is known
> to work with Xenomai.

I do not know if such a thing exist. The problems to avoid (specific to
Xenomai I mean), if that is an x86, are:
- check that there is no SMI issue, or if there is, that the SMI can be
safely disabled (that is that they can be disabled at all, and that
disabling them does not cause issues such as overheating);
- check that there is no IRQ sharing between real-time drivers (such as
RT-can) and other peripherals on your board. If that happens, you may be
able to fix it by swapping PCI cards, and/or using BIOS to disable
integrated peripherals, or disable them in the kernel configuration.


-- 
                                          Gilles


