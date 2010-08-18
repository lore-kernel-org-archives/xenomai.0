Message-ID: <4C6C6AF4.6080908@domain.hid>
Date: Thu, 19 Aug 2010 01:21:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C45539B.70204@domain.hid>
	<4C6932E8.7050701@domain.hid>	<4C694AB3.8050407@domain.hid>
	<4C698E16.5050806@domain.hid>	<1282040830.1730.232.camel@domain.hid>	<4C6ACA50.3080108@domain.hid>
	<1282120049.1730.304.camel@domain.hid>
In-Reply-To: <1282120049.1730.304.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Philippe Gerum wrote:
> - The very same kernel image does not break when booted via tftp here.
> It really seems to need a boot of the kernel image from the hard drive
> to get the issue. However, having the rootfs over NFS or on the hdd does
> not seem to make any difference. This could be the sign of a mishandled
> early access fault, which would be confirmed by your trace showing that
> the double fault handler is called.

Probably the sign that how the NIC is configured causes the interrupt or
not when re-enabling hardware interrupt: when network booting, the
bootloader or BIOS PXE loader leaves the NIC correctly disabled so that
no interupt can be generated.

-- 
					    Gilles.

