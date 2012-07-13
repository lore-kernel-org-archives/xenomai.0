Message-ID: <4FFFE746.5030804@xenomai.org>
Date: Fri, 13 Jul 2012 11:15:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <B8BB1834-3B77-49F2-8F40-C4801E858698@kabelmail.de>
	<4FFFE3B1.60403@xenomai.org>
In-Reply-To: <4FFFE3B1.60403@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 2.6.1 on beaglebone (TI AM3359 SoC)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stephan Kappertz <stephan.kappertz@kabelmail.de>
Cc: xenomai@xenomai.org

On 07/13/2012 11:00 AM, Gilles Chanteperdrix wrote:
> On 07/12/2012 09:54 PM, Stephan Kappertz wrote:
>> So far I found two things the AM3359 handles different compared to the Igepv2 board:
>>
>> 1) MACHINE_START has .handle_irq = omap3_intc_handle_irq while it is not defined in the ipipe-2.6 kernel repository
> 
> I see now, that is the problem. You have to either disable
> CONFIG_MULTI_IRQ_HANDLER, or modify omap3_intc_handle_irq to call
> ipipe_grab_irq instead of handle_IRQ.

ipipe_handle_multi_irq instead of ipipe_grab_irq will allow the code to
work both with and without CONFIG_IPIPE

-- 
					    Gilles.

