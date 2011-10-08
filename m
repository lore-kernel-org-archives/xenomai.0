Message-ID: <4E907256.1010707@domain.hid>
Date: Sat, 08 Oct 2011 17:55:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACFV95JranppM+ZDoqsgjO5nJ-Th2fFAD0HowBSkL-t_wQ-t4w@domain.hid>
	<4E8F1643.1050700@domain.hid>
	<CACFV95LnySGuKP2NQ+BcYk-wuk+S9Gh2iu1Xmqh9VLNsH1Az0w@domain.hid>
	<4E8F2CFA.1070306@domain.hid>
	<CACFV95LX8U8U=UW6EicEjRYSjToSmL9-PPVf=n16GfKW9pLsPg@domain.hid>
In-Reply-To: <CACFV95LX8U8U=UW6EicEjRYSjToSmL9-PPVf=n16GfKW9pLsPg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai: /dev/rtheap is missing (chardev,
 major=10 minor=254) in mini2440
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Siva kumar Balasubramanian <sivakumar.bs@domain.hid>
Cc: xenomai@xenomai.org

On 10/08/2011 08:28 AM, Siva kumar Balasubramanian wrote:
> After  configuring --enable-arm-eabi , now i am getting following message
> 
> Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.(modprobe xeno
> native?)
> 
> i downloaded  adeos-ipipe-2.6.37.6-arm-1.18-03.patch separately and patched
> with kernel-2.6.37.6.
> and configured the kernel as mini2440_defconfig, and compiled the kernel
> 
> i missed the prepare-kernel.sh step.
> 
> 
> If i patch the xenomai using the following step , the kernel is not booting
> 
> $xenomai_root/scripts/prepare-kernel.sh --arch=arm \
>   --adeos=$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-2.6.37.6-arm-* \
>   --linux=$linux_tree
> 
> After patching i used mini2440_defconfig. The kernel is not booting
> From the log i find it is hanging in
> 
> ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> 
> s3c2410-ohci s3c2410-ohci: S3C24XX OHCI
> 
> s3c2410-ohci s3c2410-ohci: new USB bus registered, assigned bus number 1
> 
> s3c2410-ohci s3c2410-ohci: irq 42, io mem 0x49000000
> 
> 
> My complete log file is in http://pastebin.com/Z64key6P

What version of xenomai are you using? Only 2.6.0 works with 2.6.37.


-- 
                                                                Gilles.

