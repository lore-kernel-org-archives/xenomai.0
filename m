Message-ID: <4AB2725C.90703@domain.hid>
Date: Thu, 17 Sep 2009 19:31:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <9aa019ba0909150827u38360ec1m7b749838ab0c54c4@domain.hid>	<1253116044.2676.153.camel@domain.hid>
	<9aa019ba0909171026i51de25a7g6e0c5fd60273747@domain.hid>
In-Reply-To: <9aa019ba0909171026i51de25a7g6e0c5fd60273747@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt only runs once
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: James Kilts <jameskilts@domain.hid>
Cc: xenomai@xenomai.org

James Kilts wrote:
> Philippe,
> 
> Indeed it was a problem with __set_irq_handler() not assigning appropriate
> handlers, since this board doesn't fall into any of the existing handler
> categories.

If your PIC needs an EOI, you can define the irq_finish macro in
include/mach/irqs.h like the AT91, and use the level handler. The I-pipe
should handled that, since it already does for AT91.

-- 
					    Gilles.

