Message-ID: <456DC2F5.5020005@domain.hid>
Date: Wed, 29 Nov 2006 18:27:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] Fix ipipe_tsc2ns for ARM
References: <E1GpRBe-0001FR-Mq@domain.hid>
In-Reply-To: <E1GpRBe-0001FR-Mq@domain.hid>
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
To: Sebastian Smolorz <ssm@domain.hid>
Cc: adeos-main@gna.org

Sebastian Smolorz wrote:
> Hi,
> 
> the current implementation of ipipe_tsc2ns for ARM does not compile (undefined 
> reference to `__udivdi3'). The attached patch fixes that.

the point of using ((t) * 1000) / (freq / 1000000) is to avoid using the
64 bits division. I would rather think a simple cast to unsigned is
missing. What value is a 64 bits when it fails,
__ipipe_mach_ticks_per_jiffy or t ?

-- 
                                                 Gilles Chanteperdrix

