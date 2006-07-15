Message-ID: <44B87D16.7030407@domain.hid>
Date: Sat, 15 Jul 2006 13:28:54 +0800
From: Liu Zhenghui <ferretliu@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Different performance in irq handling between native
	skin and rtdm?
Reply-To: ferretliu@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai <xenomai@xenomai.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have an A/D card which has a shared irq number 16 with the Radeon 7500
video card. So I have to in isr tell whether this interrupt is from AD
card. If not, then let other isr handle it. For native skin, this is
done by returning RT_INTR_PROPAGATE in isr, while for rtdm, by using
RTDM_IRQTYPE_SHARED flag when request the interrupt. I found both works,
but rtdm solution make the xorg very slow (open a new window, animation
etc.), while native skin not. It seems that it take a much longer
latency for rtdm to propagate the irq to video card than for native
skin. How did this happen?

My xenomai version is 2.1.0, linux kernel is 2.6.15.7

* The simplest codes for native skin is like following:

  RT_INTR AD_intr;

  err=rt_intr_create(&AD_intr, "ADISR", 16, AD_ISR, NULL, 0);

  err=rt_intr_enable(&AD_intr);

And in the cleanup function:

  rt_intr_delete(&AD_intr);

And the ISR:

  int AD_ISR(struct xnintr *intr)
  {
	if(AD_IS_IRQ){  //A macro to know whether it's an AD card IRQ
        	
		//do some thing

		//the returned value tell RTAI IRQ is done
		return (RT_INTR_HANDLED);
	}
	else{
		//this IRQ is not AD card IRQ
		//the returned value let linux to handle such IRQ
		return (RT_INTR_NONE | RT_INTR_PROPAGATE);
	}
  }


* The simplest codes for rtdm is like following:

  rtdm_irq_t AD_intr;

  err = rtdm_irq_request(&AD_intr, 16, AD_ISR, RTDM_IRQTYPE_SHARED, 		
			  ADISR", NULL);

  err = rtdm_irq_enable(&AD_intr);

And in the cleanup function:

  rtdm_irq_free(&AD_intr);

And the ISR:

  static int AD_ISR(rtdm_irq_t *irq_handle)
  {
	if(AD_IS_IRQ){  //A macro to know whether it's an AD card IRQ
        	
		//do some thing

		//the returned value tell RTAI IRQ is done
		return (RTDM_IRQ_HANDLED);
	}
	else{
		//this IRQ is not AD card IRQ
		//the returned value let linux to handle such IRQ
		return (RTDM_IRQ_NONE);
	}

  }


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEuH0WGufRPjRB9aARAiE5AJ4j56xRJo1tIhm4+eMJFGWDNiBCkgCfTHJs
YWccJyqmlTYKFFRZQJAuDzQ=
=ZuqS
-----END PGP SIGNATURE-----

