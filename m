Message-ID: <4804C64A.4030102@domain.hid>
Date: Tue, 15 Apr 2008 17:14:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47FFB7D3.3040000@domain.hid>	<18432.49619.109362.265306@domain.hid>
	<4804BF8B.3050103@domain.hid>
In-Reply-To: <4804BF8B.3050103@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xeno_16550A and multiple channels
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Anders Blomdell wrote:
> With a PCI multiport I/O-card, configured with:
> 
>   modprobe xeno_16550A.ko io=0xd400,0xd080 irq=5,5
> 
> I can't get cross-link to work. This is what I get:
> 
>   main : write-file opened
>   main : write-config written
>   main : can't open rtser1 (read), Device or resource busy
>   main : rtser0 (write) -> closed
> 
> The reason is that the second call (xeno_16550A.c) to:
> 
>   err = rtdm_irq_request(&ctx->irq_handle, irq[dev_id],
> 			 rt_16550_interrupt,
> 			 RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE,
> 			 context->device->proc_name, ctx);
> 
> returns -16.
> 
> This somehow makes sense since rtser0 and rtser1 uses the same interrupt, but
> having multiple channels sharing the same interrupt seems to be a valid usecase
> according to http://www.xenomai.org/index.php/16550A.
> 
> Kernel version is 2.6.24.3 and Xenomai version is 2.4.2.
> 
> Any ideas of what might be wrong?

CONFIG_XENO_OPT_SHIRQ?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

