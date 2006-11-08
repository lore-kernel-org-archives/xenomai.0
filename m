Message-ID: <4551E045.4050107@domain.hid>
Date: Wed, 08 Nov 2006 14:48:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] ISR arguments with Native skin
References: <4551DA2A.90607@domain.hid>
In-Reply-To: <4551DA2A.90607@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Hallo,
> 
> I just realized, that the ISR registered with rt_intr_create() must be 
> of type:
> 
>   int isr(struct xnintr *irq)
> 
> I expected "RT_INTR *" as type of the argument. The documentation is not 
> clear about that (what rt_isr_t) is. A hyper-link would be nice.
> 
> Thanks.

You can use the I_DESC macro to get the RT_INTR * from the xnintr_t *

-- 
                                                  Gilles Chanteperdrix

