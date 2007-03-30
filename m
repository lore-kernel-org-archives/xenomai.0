Message-ID: <460D219D.5070302@domain.hid>
Date: Fri, 30 Mar 2007 16:41:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Porting to Intel IXP425
References: <899865CA54E4444DAF2E3639C04C5F4805EC60@domain.hid>
In-Reply-To: <899865CA54E4444DAF2E3639C04C5F4805EC60@domain.hid>
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
>>The timer is aperiodic (most of the time) when running Xenomai, so
>>__ipipe_mach_set_dec is called for each timer tick and programs the
>>timer hardware for the next tick.
> 
> 
> Okay, so does that mean that I should implement a "one-shot" timer, or
> are we talking about resetting the periodic timer once in a while?
> 
> (BTW, in one-shot mode, the IXP425 timer does not do what the Developers
> Manual, part 252480-006, says that it does!)

Yes, the one shot mode is Xenomai default mode. The implementation of a
periodic timer over the one-shot timer is already done by the generic
ARM part of the Adeos patch.

> 
> 
>>__ipipe_mach_release_timer is called when Xenomai stops handling the
>>timer and let Linux handle it.
> 
> 
> But why does Xenomai do this? When unloading the module?

Yes, exactly.

-- 
                                                 Gilles Chanteperdrix

