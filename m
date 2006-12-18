Message-ID: <4586A5AE.6020002@domain.hid>
Date: Mon, 18 Dec 2006 15:29:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: Aw: Re: [RTnet-users] [Xenomai-help] rtnet / Xenomai: Kernel
	2.6.19.1
References: <10606813.1166451623805.JavaMail.ngmail@domain.hid>
In-Reply-To: <10606813.1166451623805.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid, rtnet-users@domain.hid

M. Koehrer wrote:
> Hi Jan,
> 
> I tried disabling SMP - but no success...
> Unfortuantely, the SMI watchdog does not work on my machine.
> After booting the PC, dmesg shows me the line
> Xenomai: NMI watchdog not available.
> 
> Is the NMI watchdog support somehow configurable or is this a real hardware issue?
> 
> For patching the kernel, I used the adeos-ipipe-2.6.19-i386-1.6-02.patch which is
> part of Xenomai.
> 
> As I do not see an easy way to get the 2.6.19.* running,  I think, I will switch back to 
> the latest 2.6.17.* kernel (2.6.17.14) which works fine.

In order to get the NMI watchdog, you have to enable it on kernel
command line, passing nmi_watchdog=2 or nmi_watchdog=1. Read linux
Documentation/nmi_watchdog.txt for more details.

-- 
                                                 Gilles Chanteperdrix

