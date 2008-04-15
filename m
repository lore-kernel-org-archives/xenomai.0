Message-ID: <4804BF8B.3050103@domain.hid>
Date: Tue, 15 Apr 2008 16:45:31 +0200
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <47FFB7D3.3040000@domain.hid>
	<18432.49619.109362.265306@domain.hid>
In-Reply-To: <18432.49619.109362.265306@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] xeno_16550A and multiple channels
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

With a PCI multiport I/O-card, configured with:

  modprobe xeno_16550A.ko io=0xd400,0xd080 irq=5,5

I can't get cross-link to work. This is what I get:

  main : write-file opened
  main : write-config written
  main : can't open rtser1 (read), Device or resource busy
  main : rtser0 (write) -> closed

The reason is that the second call (xeno_16550A.c) to:

  err = rtdm_irq_request(&ctx->irq_handle, irq[dev_id],
			 rt_16550_interrupt,
			 RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE,
			 context->device->proc_name, ctx);

returns -16.

This somehow makes sense since rtser0 and rtser1 uses the same interrupt, but
having multiple channels sharing the same interrupt seems to be a valid usecase
according to http://www.xenomai.org/index.php/16550A.

Kernel version is 2.6.24.3 and Xenomai version is 2.4.2.

Any ideas of what might be wrong?

/Anders

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

