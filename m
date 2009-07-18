Message-ID: <4A61D0C1.30607@domain.hid>
Date: Sat, 18 Jul 2009 15:40:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1247750127.306081.22356.nullmailer@domain.hid>		<1247754601.4228.73.camel@domain.hid>		<1247829470.829653.30773.nullmailer@domain.hid>		<1247832340.4228.132.camel@domain.hid>		<1247837534.904271.19070.nullmailer@domain.hid>	<1247838733.4228.139.camel@domain.hid>	<1247845909.586479.22758.nullmailer@domain.hid>
	<4A618239.90506@domain.hid> <4A61A4BE.5070308@domain.hid>
	<4A61C690.3030306@domain.hid> <4A61C7B6.2080704@domain.hid>
	<4A61CEAF.6060902@domain.hid>
In-Reply-To: <4A61CEAF.6060902@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_shadow returns always -EFAULT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai-help <xenomai@xenomai.org>

Jan Kiszka wrote:
> What was the precise brokenness you saw? Also a missing syscall
> argument initialization? Can you easily reproduce the ARM issue?
> Would be

It is here:
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=38815

The arm syscalls contain a workaround, I copy the values to some
temporary variables, but I can not make it work with the bugzilla sample
(though I am almost sure I tested it when I did it, I may have changed
toolchain version in the mean time).


> interesting to know if '+r' makes a difference there, too.

I tested it after you mention it, and no, it makes no difference.

-- 
					    Gilles.

