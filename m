MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18112.16815.606280.878902@domain.hid>
Date: Mon, 13 Aug 2007 13:34:07 +0200
In-Reply-To: <2862c2c80708130403v62b21fd5va7b5919bd996dbaf@domain.hid>
References: <2862c2c80708130403v62b21fd5va7b5919bd996dbaf@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] System Timer Interrupt Sharing?
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
 > Is that possible to share the system timer interrupt used for xenomai kernel
 > scheduling for any other purposes?
 > 
 > Please advice. Thanks

I guess you are talking about Xenomai on AT91. Xenomai on AT91 does not
use the system timer interrupt, it uses the timer counter interrupt
instead. So, yes, you can use system timer interrupt for any other non
real-time activity.

Now, if your question is to know if it is possible to share an interrupt
between real-time and not real-time activity, the answer is that it is
not easy. If you want to do this, you will have to move the hardware
acknowledgement part of the non real-time interrupt handler to a
real-time interrupt handler, and, when an event is pending for the non
real-time domain, propagate the irq.

-- 


					    Gilles Chanteperdrix.

