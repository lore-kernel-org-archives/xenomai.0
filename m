Date: Wed, 29 Aug 2007 16:34:39 +0200
From: "Axel Beierlein" <belatronix@domain.hid>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
Message-ID: <op.txtr31btt06gyn@domain.hid>
Subject: [Xenomai-help] System hangs in/after rtdm_lock_put_irqrestore
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

what could it be that an simple rt_dev_open locks up my system when it  =

calls rtdm_lock_put_irqrestore?

[...]
if (rtdm_irq_request(&ctx->irq_handle,
		        MPC5xxx_PSC2_IRQ,
			rt_psc_interrupt,
			RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE,
				context->device->proc_name,
				ctx))
	{
		printk ("psc5200B.c: request_irq() failed\n");
		return -1;
	}

     rtdm_irq_enable(&ctx->irq_handle);

     rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);

     ctx->imr_status =3D MPC5xxx_PSC_IMR_RXRDY;
	out_be16(&psc->mpc5xxx_psc_imr, ctx->imr_status);

	rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	Here i get the crash


The test prog is a simple  =

fd=3Drt_dev_open("nameofdevice",0)......rt_dev_close(fd).


Axel






