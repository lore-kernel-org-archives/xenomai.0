Message-ID: <4C2A1B0A.3000204@domain.hid>
Date: Tue, 29 Jun 2010 18:10:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimKEFqaOGLrvLhpf0FqqdTkAPraazAnbuUGMa0V@mail.gmail.com>	<4C289319.4050807@domain.hid>
	<AANLkTin9R46PUKwDQw_nXck_RkL9TH01Qqhuw-7YwmDT@mail.gmail.com>
In-Reply-To: <AANLkTin9R46PUKwDQw_nXck_RkL9TH01Qqhuw-7YwmDT@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ conflict issues with and ESD PMC card.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nape Ibrahim Lentsoane <nape.lentsoane@domain.hid>
Cc: xenomai@xenomai.org

Nape Ibrahim Lentsoane wrote:
> 
> I turned off CONFIG_XENOMAI and CONFIG_IPIPE and the machine boots with
> no problems.
> I use:
> --Linux kernel version 2.6.32.11
> --adeos-ipipe-2.6.32.11-x86-2.
> 6-03. intalled via the debian package: linux-patch-xenomai (2.5.3-2)
> --Xenomai version 2.5.3
> 
> The contents of /proc/interrupts are in the file attached:
> "pro_interrupts_no_xm.txt". '/proc/xenomai/irq' does not exist
> in the xenomai disabled configuration but in the other config I was
> abled to view the contents only after I have diabled
> 'PCI Express Port 3' in BIOS. The file is attached as "xenomai_irq.txt".

What I am interested in is the contents of /proc/interrupts and
/proc/xenomai/irq in the Xenomai case, to see if an IRQ is used by both
Xenomai and Linux.

> 
> I have also attched the two config files, one that
> boots("config_no_xenomai.txt") and the other which doesn't
> ("config_with_xenomai_ipipe.txt").
> The respective serial logs: 'Err_Msg_No_Xenomai.txt' and
> 'Err_Msg_No_Xenomai.txt'.

The serial logs are definitely too short. Your distribution probably
passes the "quiet" option on the kernel command line. Disable this
option and try again. We want the full log.

-- 
					    Gilles.

