Message-ID: <4F15CBB8.1070406@domain.hid>
Date: Tue, 17 Jan 2012 20:27:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <9BF63BF19AC3441EB4E1567EB07B78A0@domain.hid>
	<4F14BF9B.6030706@domain.hid>
	<2F9F10CEA75644AA8CF542029C058C57@domain.hid>
In-Reply-To: <2F9F10CEA75644AA8CF542029C058C57@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai IRQ question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Terry Fryar <terry.fryar@domain.hid>
Cc: xenomai@xenomai.org

On 01/17/2012 05:25 PM, Terry Fryar wrote:
> Ok, on a falling edge irq, I'm using an RTDM driver and I'm down to 2.3uS,
> which is quite an improvement.  However, it's still not fast enough...I need
> to hit a window of about 500nS.  Any other suggestions?

>From what I recall, irq latency under load on a 720 MHz OMAP3 is more
around 20us.

> 
> I use the rtdm_irq_request to hook the ISR, and I set up the irq by hand
> using mem mapping to directly access the registers on the beagle.  At this
> point, I'm not sure where else to try and speed things up?

500ns is not much. I do not think we support this kind of latency on any
processor.

-- 
                                                                Gilles.

