Message-ID: <4602A486.70707@domain.hid>
Date: Thu, 22 Mar 2007 16:45:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] New install of Xenomai 2.3 for 2.6.17 kernel....
	Various problems
References: <032220071508.5353.46029BD200057373000014E92216557996070E0301020A98@domain.hid>
In-Reply-To: <032220071508.5353.46029BD200057373000014E92216557996070E0301020A98@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@domain.hid, xenomai@xenomai.org

xenomai@domain.hid wrote:
>  -------------- Original message ----------------------
> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> 
>>xenomai@domain.hid wrote:
>>
>>>#
>>># SMI workaround
>>>#
>>># CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
>>>CONFIG_XENO_HW_SMI_DETECT=y
>>>CONFIG_XENO_HW_SMI_WORKAROUND=y
>>># CONFIG_XENO_HW_SMI_ALL is not set
>>># CONFIG_XENO_HW_SMI_INTEL_USB2 is not set
>>># CONFIG_XENO_HW_SMI_LEGACY_USB2 is not set
>>># CONFIG_XENO_HW_SMI_PERIODIC is not set
>>># CONFIG_XENO_HW_SMI_TCO is not set
>>># CONFIG_XENO_HW_SMI_MC is not set
>>>CONFIG_XENO_HW_SMI_APMC=y
>>># CONFIG_XENO_HW_SMI_LEGACY_USB is not set
>>>CONFIG_XENO_HW_SMI_BIOS=y
>>
>>Chances are that the latencies you get are due to the SMI you leave
>>enabled (APMC or BIOS). Could you try first with only
>>CONFIG_XENO_HW_SMI_ALL ?
>>
> WOW!!!  I did try that with the 2.6.17 kernel but it wouldnt boot,
> I had to enable APM.  It is working like  charm now.  Max latency
> is 4-5 us while running X.  If I drag a window around it goes up
> to 7us or so.  Deffinately a step in the righ direction!  Thanks.

Good news.

-- 
                                                 Gilles Chanteperdrix

