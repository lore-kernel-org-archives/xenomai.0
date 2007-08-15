MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18114.64293.110182.524820@domain.hid>
Date: Wed, 15 Aug 2007 15:09:57 +0200
In-Reply-To: <46C2EADF.4030505@domain.hid>
References: <2862c2c80708140315y6cb029e4j8b5f7e9d95ae2bf1@domain.hid>
	<18113.34663.646158.524696@domain.hid>
	<2862c2c80708150224s4dd154b1j2aad7333ac04d150@domain.hid>
	<46C2EADF.4030505@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Kernel Opps calling rtdm_irq_request
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
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Yeoh Chun Yeow wrote:
 > > By the way, do we need to invoke the rtdm_irq_enable after the
 > > rtdm_irq_request? After excuting the ISR, is that the return of
 > > RTDM_IRQ_HANDLED will reenble the interrupt?
 > 
 > Depends on the version: With RTDM revision 6 (will be part of Xenomai
 > 2.4), this is no longer required. Earlier revision needed it, though.
 > See documentation.

An if I am not wrong, RTDM revision 6 offers timers services as well,
so, Yeoh, developing your own timer management system really looks like
going the wrong way.

-- 


					    Gilles Chanteperdrix.

