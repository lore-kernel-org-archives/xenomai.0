Message-ID: <4986B44B.3030307@domain.hid>
Date: Mon, 02 Feb 2009 09:52:27 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <271563.65105.qm@domain.hid>
In-Reply-To: <271563.65105.qm@domain.hid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Problem with 	rtdm_irq_request
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: seb p <sebas_p2002@domain.hid>
Cc: xenomai@xenomai.org

seb p wrote:
> Hello,
> 
> I use a atmel card AT91SAM9260 and I install Linux 2.6.25 with xenomai
> 2.4.4. I am doing a RTDM serial driver. I use the function
> rtdm_irq_request
> <http://www.xenomai.org/documentation/trunk/html/api/group__rtdmirq.html#g9bb3d95218ac5261e4033fb0bf695073>
> with the routine rt_rs485_interrupt. The interrupt number is 7. The
> interrupt is enable when a carracter is in the buffer Rx and the
> programm execute the routine rt_rs485_interrupt. But in my programm,
> when a caracter is in the buffer Rx, the programm doesn't execute the
> routine and I must reboot the linux. The console don't answer.
> 
> Have you got an idea of the problem? Thanks.
>

Time is a scarce resource for everyone. With that in mind, please:

- do not report issues based on outdated Xenomai releases unless you made sure
that such issue also happens on the latest release. Xenomai 2.4.6.1 will happily
work over 2.6.25/arm.

- send an excerpt of your code that helps understanding the issue.

> Séb.
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

