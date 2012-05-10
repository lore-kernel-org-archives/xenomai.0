Message-ID: <4FABDF16.2090702@domain.hid>
Date: Thu, 10 May 2012 17:30:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1582745274.144720341.1336663098702.JavaMail.root@domain.hid>
In-Reply-To: <1582745274.144720341.1336663098702.JavaMail.root@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on the TS-7553 ARM SBC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: aubin.rebillat@domain.hid
Cc: xenomai@xenomai.org

On 05/10/2012 05:18 PM, aubin.rebillat@domain.hid wrote:
>> root=/dev/ram0 means that you are using an initrd, which has been 
>> deprecated for many years.
> 
> I don't really have another option because the board does not support
> U-BOOT (according to the manufacturer) and due to the specific
> bootloader on the board I need an initrd : The bootloader only
> initialises some hardware and loads the kernel image and the initrd
> in memory before jumping on the kernel code. Then it uses the "linux
> booting linux" technique to launch debian. I agree with you that it
> is not the way of doing it today and i suspect the board manufacturer
> to do so to sell a "fast booting board" because linux is booted in
> less than 4 secs (of course for debian, it takes really more). They
> actually made many things that seemed nice when i read the
> description but when i wanted to develop with it I saw a lot of
> really strange technique / behaviors (See the UART after for
> example).

There is no difference that I know of from the bootloader side whether
booting with an initrd or an initramfs. Anyway, the only difference is
that initramfs wastes more memory, it is not what is causing the
problem. Either using an initrd or an initramfs wastes boot time, which
is usually a scarse resource on embedded systems. Whatever the
bootloader, I do not see what prevents you from passing different
parameters than "root=/dev/ram0" to the kernel, which would be enough to
boot from another device.

But all this is unimportant.

> I will look into the OABI and EABI settings then. I will also set up
> an NFS file system to mount debian from and see what is happening.
> 
> Thank you Gilles for your reply. I will keep posting about my
> progresses.

The issue may simply well be that your timer code does not work. Could
you post the code for your port? That is, the code you added to get it
work with the I-pipe patch. Have you checked that linux timer is still
ticking after Xenomai has been started?

You can also try to boot with CONFIG_IPIPE but without CONFIG_XENOMAI.

Note that in case you do not know it, there is a guide for porting the
I-pipe patch on new ARM platforms:

http://www.xenomai.org/index.php/I-pipe:ArmPorting

-- 
					    Gilles.

