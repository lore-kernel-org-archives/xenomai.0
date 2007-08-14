MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18113.34663.646158.524696@domain.hid>
Date: Tue, 14 Aug 2007 12:43:51 +0200
In-Reply-To: <2862c2c80708140315y6cb029e4j8b5f7e9d95ae2bf1@domain.hid>
References: <2862c2c80708140315y6cb029e4j8b5f7e9d95ae2bf1@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Kernel Opps calling rtdm_irq_request
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yeoh Chun Yeow <yeohchunyeow@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

Yeoh Chun Yeow wrote:
 > Dear all,
 > 
 > I have try to attach a AT91 TC hardware interrupt using rtdm_irq_request.

Sorry, I misunderstood your question. No, you can not do that, the TC
hardware is driven by Xenomai in one shot mode, you can not expect it to
tick on a regular basis. Besides, timers (either posix timers or native
alarms) are really what you are looking for. Nevertheless, you should
not get a oops when trying to do that.

 > 
 > Whenever the rtdm_irq_request is called, the kernel Oops occurs.
 > 
 > Any ideas on the problem?


Either a programming error, or a bug in Xenomai. Could you show us the
code that triggers this behaviour ? Did you enable support for shared
IRQs in Xenomai ? The TC irq has to be shared in Xenomai domain, since
it is used by Xenomai and you also want to use it.

-- 


					    Gilles Chanteperdrix.

