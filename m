Message-ID: <460D4601.2090009@domain.hid>
Date: Fri, 30 Mar 2007 19:16:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Porting to Intel IXP425
References: <899865CA54E4444DAF2E3639C04C5F4805EC61@domain.hid>
In-Reply-To: <899865CA54E4444DAF2E3639C04C5F4805EC61@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Richard Cochran <richard.cochran@domain.hid>
Cc: adeos-main@gna.org

Richard Cochran wrote:
> Just to be clear, does __ipipe_mach_get_dec() return the _dialed_
> number of ticks, or the _remaining_ number of ticks?

__ipipe_mach_get_dec() is supposed to return the number of remaining ticks.

-- 
                                                 Gilles Chanteperdrix

