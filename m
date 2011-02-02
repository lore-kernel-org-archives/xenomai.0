From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <000701cbc314$969f5de0$c3de19a0$@de>
References: <000701cbc314$969f5de0$c3de19a0$@de>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Feb 2011 23:04:49 +0100
Message-ID: <1296684289.1995.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [    1.954665] Xenomai: native skin init failed,
 code -19
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Franz Engel <franz_lambert_engel@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2011-02-02 at 21:05 +0100, Franz Engel wrote:
> Hello,
> 
> I have a little problem. I'm a Xenomai newbie (that is not the
> problem). My problem begun with the installation. I installed Xenomai
> on my PC at work (Intel, 64 Bit Ubuntu). Now I try to install Xenomai
> also on my home PC (AMD Phenom II X6, 64 Bit Ubuntu). On my PC at work
> there is no problem. But at home I have no chance.
> I already read about this problem. When I start the latency test I get
> this message:
> Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
> (modprobe xeno_native?)
> 
> Furthermore my log contains the following message:
> [    1.457598] I-pipe: Domain Xenomai registered.
> [    1.458017] Xenomai: hal/x86_64 started.
> [    1.458154] Xenomai: scheduling class idle registered.
> [    1.458210] Xenomai: scheduling class rt registered.
> [    1.462730] Xenomai: real-time nucleus v2.5.5.2 (Ghosts) loaded.
> [    1.954665] Xenomai: native skin init failed, code -19.
> [    1.954752] Xenomai: starting POSIX services.
> [    2.454765] Xenomai: POSIX skin init failed, code -19.
> [    2.954863] Xenomai: RTDM skin init failed, code -19.

This issue has been reported recently also on Phenom; even if it still
remains to be tracked down, it is very likely an Adeos issue. A Phenom
X4-based toaster has just landed close to my desk lately, so I'll
definitely have a look in a reasonable time frame.

In the mean time, please send me your .config, to get more information
about the context.

> 
> I read that the APIC could be a problem. So I insert "lapic" to my
> GRUB 2 boot file (I know, it is not good to change this file):
> linux    /boot/vmlinuz-2.6.32.7-xenomai
> root=UUID=03b334bf-d381-4065-bdc1-64c267d32c4c ro lapic
> 
> But nothing happens.
> 
> I tried to change the following lines in my kernel ".config":
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> 
> But even when I change this lines they set back when I make "make
> menuconfig".
> 
> When I used the Xenomai-Skript:
> ./prepare-kernel.sh --linux=/usr/src/linux
> 
> I choose the default parameter "X86_64" (I use a 64 Bit Ubuntu) and I
> tried different processor configurations on my kernel
> (Opteron/Athlon64/Hammer/K8 and Generic-x86-64). Does somewhere know
> what I made wrong? Do I have to change the prepare-kernel.sh parameter
> from x86_64 to something else?
> 
> Best regards,
>    Franz
> 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



