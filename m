Message-ID: <4576C2D8.8090202@domain.hid>
Date: Wed, 06 Dec 2006 14:17:12 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] Fix ipipe_tsc2ns for ARM
References: <E1GpRBe-0001FR-Mq@domain.hid>	
	<E1GpiKm-0003ul-LY@mailer.emlix.com>
	<456EE5BA.8080106@domain.hid>	
	<E1GrB4y-0006gX-JS@mailer.emlix.com> <45740364.4060404@domain.hid>
	<1165406258.7218.116.camel@domain.hid>
In-Reply-To: <1165406258.7218.116.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org

Philippe Gerum wrote:
> It's a detail, but ipipe_tsc2ns() was once designed as a helper for
> implementing the now defunct I-pipe stats support, which has been
> replaced by the tracer. The values (time delta between -normally- short
> events) were guaranteed to be small enough to fit in 32bits, so other
> ports just cast the input data within the macro. No other I-pipe code
> should rely on better precision.
> 
> This said, in this case, my preferred option is the one of the Adeos
> maintainer for ARM, who is... oh, yeah! you are. So, I hereby agree with
> the choice you are going to make next.

Ok, let us go for what other ports do then, let us cast the argument to
a 32 bits value.

-- 
                                                 Gilles Chanteperdrix

