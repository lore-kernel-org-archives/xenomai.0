Message-ID: <4CEE7D0A.7050508@domain.hid>
Date: Thu, 25 Nov 2010 16:13:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <99ccb1608a0bd512c70a7d65a06888f2.squirrel@domain.hid>
In-Reply-To: <99ccb1608a0bd512c70a7d65a06888f2.squirrel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] help
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: George AFONSO <george.afonso@domain.hid>
Cc: xenomai@xenomai.org

Am 25.11.2010 10:05, George AFONSO wrote:
> Hello,
> 
> I'm trying xenomai for my architecture.
> I'm using a fedora 14 environment (2.6.35.6-45.fc14.i686 kernel)
> The kernel version used for the compilation is 2.6.35.7
> The Xenomai version used is 2.5.5.2
> I configure the kernel, with no errors, i perform the make install with no
> errors too.
> 
> My processor :
> 
> vendor_id        : AuthenticAMD
> cpu family        : 15
> model              : 107
> model name        : AMD Athlon(tm) 64 X2 Dual Core Processor 4800+
> 
> When i restart my computer i have a kernel panic, do you have any reason
> to explain that?
> 
> start screen :
> "
> Pid: 1, comm swapper Tainted:G D 2.6.35.7 #2
> Call Trace :
> panic+0x50/0xc5
> do_exist+0x61/0x60f
> ? _raw_spin_unlock_irqrestore+0x13/0x15
> (...)
> "
> You'll find the kernel ".config" attached.
> 

First of all, switch to an appropriate processor type, you are running
with brakes applied (CONFIG_M686 - no TSC etc.).

If the issue persists, please capture the full boot-up log, e.g. by
redirecting the kernel console to a uart (see
linux/Documentation/serial-console.txt).

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

