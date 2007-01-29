Message-ID: <45BE1104.3010000@domain.hid>
Date: Mon, 29 Jan 2007 16:21:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] BUG: unable to handle kernel paging request
References: <1169811995.462.13.camel@domain.hid>	<1169827668.3346.61.camel@domain.hid>	<b647ffbd0701261046m52172774lf5a7b4d08e090583@domain.hid>	<1169851606.3346.75.camel@domain.hid>
	<1169852516.3346.77.camel@domain.hid>
	<1170073409.26457.8.camel@domain.hid>
In-Reply-To: <1170073409.26457.8.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
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
To: Victor Shulyak <V.I.Shulyak@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Victor Shulyak wrote:
> Hello
> 
> 
> 
>>>>>However, since there seem to be a clean backtrace, maybe we could give a
>>>>>try anyway. Could you objdump your kernel image, then locate the faulty
>>>>>routine containing eip=0xc7b84d51?
> 
> I can apply objdump to kernel modules, but when this utility was applied
> to kernel image, error message is displayed
> objdump: /boot/vmlinuz-xenomai: File format not recognized
> How could I objdump my kernel image?

Instead of vmlinuz, you should pick vmlinux at the root of the kernel
build directory.

> 
> 
> 
>>>>Let's suppose we can believe in sanity of the call trace, then would
>>>>you, Victor, provide a disassembled code for
>>>>__ipipe_handle_exception() ?
>>>>
> 
> I will do this with pleasure, one thing to know, which tools can help
> me?

objdump as well

-- 
                                                 Gilles Chanteperdrix

