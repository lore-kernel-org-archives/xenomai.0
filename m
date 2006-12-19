Message-ID: <45879DE5.5080507@domain.hid>
Date: Tue, 19 Dec 2006 09:08:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] NMI watchdog: Loading of xeno_native leads to
	reboot	of PC
References: <7145056.1166514841031.JavaMail.ngmail@domain.hid>
In-Reply-To: <7145056.1166514841031.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

M. Koehrer wrote:
> Hi!
> 
> Before digging deeper into the issue I have mailed yesterday (see below), I have to solve and
> to understand the NMI watchdog feature.
> I have enabled the NMI watchdog in the kernel configuration and set the time value to 100 now (100us).
> Also, I passed the nmi_watchdog=1 kernel parameter to GRUB.
> In dmesg's output I see the line:
> Testing NMI watchdog ... OK.
>  
> The Xenomai functionality is compiled as modules (as far as it is possible).
> 
> Now, I do a 
> modprobe xeno_nucleus
> This looks fine.
> 
> Now, I do a 
> modprobe xeno_native
> to load the native skin (I need it for my application to run).
> Then the PC reboots directly.
> This means I have no chance to  start my application as the PC reboots before
> I can start it...
> 
> I have the impression that some important thing is missing in my test.
> The xeno timer is not started after modprobe xenu_nucleus
> The contents of /proc/timer is:
> status=off:setup=120:tickval=0:jiffies=0
> 
> Could this be a reason for the behaviour?

That's normal, it is started on loading the first skin.

> Can I start the timer before loading xeno_native to avoid the NMIs?

Nope, the NMI must work as you tried to use it. I have basically the
same setup here (all modular, NMI on by default), but even with latest
kernel/ipipe everything is fine.

Could you post your .config to compare details? Also the output of
/proc/interrupts over .19 would be interesting.

Jan

