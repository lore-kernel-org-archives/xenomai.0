From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C6C6AF4.6080908@domain.hid>
References: <4C45539B.70204@domain.hid> <4C6932E8.7050701@domain.hid>
	<4C694AB3.8050407@domain.hid> <4C698E16.5050806@domain.hid>
	<1282040830.1730.232.camel@domain.hid>
	<4C6ACA50.3080108@domain.hid>
	<1282120049.1730.304.camel@domain.hid>
	<4C6C6AF4.6080908@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 Aug 2010 07:18:17 +0200
Message-ID: <1282195097.1730.376.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
 boot on ubuntu lucid system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Thu, 2010-08-19 at 01:21 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > - The very same kernel image does not break when booted via tftp here.
> > It really seems to need a boot of the kernel image from the hard drive
> > to get the issue. However, having the rootfs over NFS or on the hdd does
> > not seem to make any difference. This could be the sign of a mishandled
> > early access fault, which would be confirmed by your trace showing that
> > the double fault handler is called.
> 
> Probably the sign that how the NIC is configured causes the interrupt or
> not when re-enabling hardware interrupt: when network booting, the
> bootloader or BIOS PXE loader leaves the NIC correctly disabled so that
> no interupt can be generated.
> 

Actually, the issue is that some device is raising an IRQ before the
kernel enters mem_init and raises a fault to test the write protect
feature. At this point, the kernel did disable interrupts at CPU level
(we do have an early local_irq_disable_hw() hanging around in
start_kernel() to ensure that anyway). However, it might happen that the
fault virtualization code introduced by the pipeline spuriously
re-enables them, causing havoc.

At this stage of the init process (i.e. when checking whether the CPU
honors the wp bit), we just can't take any interrupt yet, since the
pipeline did not fully initialize, and the kernel did not even install
its own handlers or configured the PIC.

-- 
Philippe.



