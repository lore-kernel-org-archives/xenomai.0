Message-ID: <4C61A1F8.7080901@domain.hid>
Date: Tue, 10 Aug 2010 12:01:12 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4C5A26C4.3050702@domain.hid>	<4C5A631B.1040604@domain.hid>	<4C5CC360.7070707@domain.hid>
	<AANLkTikC5DvkOQDfGFWL7b8KXFYd+1OkZrQ0Gc+GzzZr@domain.hid>
	<4C60A3B8.2000603@domain.hid> <4C6151AC.1000708@domain.hid>
In-Reply-To: <4C6151AC.1000708@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM driver structure - an update
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

  Comments inline..

On 8/10/2010 6:18 AM, Gilles Chanteperdrix wrote:
> ...snipped...
> The RTDM_IRQTYPE_EDGE is documented in RTDM API documentation: "Mark IRQ
> as edge-triggered, relevant for correct handling of shared
> edge-triggered IRQs. " Here:
> http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__rtdmirq.html
The above quotation is the full extent of the documentation. The driver 
authors (we) ask the question, "Should I include this flag when I call 
rtdm_irq_request()?" The documentation leaves the answer ambiguous in 
the case where the RTDM_IRQTYPE_SHARED flag is not coded.

It also creates confusion. We assume that RTDM_IRQTYPE_EDGE will cause 
hardware to be configured similar to request_irq().We knows that the 
specification of RTDM_IRQTYPE_EDGE is insufficient.  Normally we need to 
specify which edge is to cause the interrupt. We question whether 
specifying RTDM_IRQTYPE_EDGE will cause our ISR to be entered on both 
rising and falling edges.

The essence of this e-mail discussion eventually needs to be added to 
the rtdm_irq_request() documentation.

Regards,
Bob Feretich

