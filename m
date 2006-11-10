Message-ID: <45545120.1070809@domain.hid>
Date: Fri, 10 Nov 2006 11:14:56 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] I-pipe patch for ARM S3C24xx (v4)
References: <E1GiChy-0006Bp-5K@mailer.emlix.com>
In-Reply-To: <E1GiChy-0006Bp-5K@mailer.emlix.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Sebastian Smolorz wrote:
> Hi all,
> 
> now that the teething problems of my I-pipe port to the S3C24xx are cured 
> (hopefully ...) I'm going to iterate it to v4. We've established a project 
> homepage for that port
> http://opensource.emlix.com/ipipe-s3c24xx/

What happens with __ipipe_mach_irq_mux_p if irq is smaller than IRQ_CAM ?

-- 
                                                  Gilles Chanteperdrix

