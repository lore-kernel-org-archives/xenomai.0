Message-ID: <461BC626.3070403@domain.hid>
Date: Tue, 10 Apr 2007 19:15:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <305035a40704100947n5d426f9ahf8608957a2264f2f@domain.hid>
In-Reply-To: <305035a40704100947n5d426f9ahf8608957a2264f2f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] AT91SAM9261 adeos support for 2.6.19 kernel
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gregory CLEMENT <gclement00@domain.hid>
Cc: BOUIN Alexandre <abouin@domain.hid>, adeos-main@gna.org

Gregory CLEMENT wrote:
> Hello,
> 
> We port the adeos-ipipe-2.6.19-arm-1.6-05.patch for AT91SAM9261.
> 
> This patch must be applied on vanilla 2.6.19 with at91 patch (
> http://maxim.org.za/AT91RM9200/2.6/2.6.19-at91.patch.gz ) applied for
> supporting AT91SAM9261.
> So first get vanilla kernel, then apply at91 patch then apply our
> patch instead of adeos-ipipe-2.6.19-arm-1.6-05.patch.
> 
> For now it works with Xenomai on AT91SAM9261-EK, if someone is
> intersting we can send the benchmark result.
> As AT91SAM926x are pretty similar of AT91RM9200, there is a some
> duplicate code and some common code.
> In the future it could be also work on all AT91SAM926x, we can test
> it. But before going ahead we would like some comment on this patch.
> 
> The better would be working on 2.6.20 which already have support for
> AT91SAM926x, but we didn't see any arm patch on this kernel nor any
> file modified on git.
> 
> Hope this patch will be usefull.

It looks good. I will try and port the I-pipe patch for ARM to Linux
2.6.20. In the meantime, could you separate the AT91SAM9261 specific
code and the changes (if any) made to the rest of the I-pipe from the
rest of the I-pipe ? This would ease distribution and maintenance.

> PS: Would we post it on xenomai list also?

Yes, maybe some people there would like to know about this patch.

-- 
                                                 Gilles Chanteperdrix

