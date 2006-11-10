From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-core] I-pipe patch for ARM S3C24xx (v4)
Date: Fri, 10 Nov 2006 11:28:25 +0100
References: <E1GiChy-0006Bp-5K@mailer.emlix.com> <45545120.1070809@domain.hid>
In-Reply-To: <45545120.1070809@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1GiTcV-0000QG-Tt@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Am Freitag, 10. November 2006 11:14 schrieb Gilles Chanteperdrix:
> Sebastian Smolorz wrote:
> > Hi all,
> >
> > now that the teething problems of my I-pipe port to the S3C24xx are cured
> > (hopefully ...) I'm going to iterate it to v4. We've established a
> > project homepage for that port
> > http://opensource.emlix.com/ipipe-s3c24xx/
>
> What happens with __ipipe_mach_irq_mux_p if irq is smaller than IRQ_CAM ?

OK, this is not correct. I will fix it to

#define __ipipe_irqbit(irq) (1 << ((irq) - S3C2410_CPUIRQ_OFFSET))

as you suggested originally.


Thanks,

Sebastian

