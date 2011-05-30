Date: Mon, 30 May 2011 09:03:22 +0200
From: Pavel Machek <pma@domain.hid>
Message-ID: <20110530070322.GA3248@domain.hid>
References: <4DDE8DC9.2020905@domain.hid> <4DDF475A.5080504@domain.hid>
	<4DDFB30F.8000003@domain.hid> <4DDFB780.4010009@domain.hid>
	<4DDFBDCD.4040809@domain.hid> <4DDFEDA2.40206@domain.hid>
	<4DDFF74E.2000400@domain.hid> <4DE1078D.3090503@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DE1078D.3090503@domain.hid>
Subject: Re: [Xenomai-help] Huge clock drift
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Sat 2011-05-28 16:32:45, Jan Kiszka wrote:
> On 2011-05-27 21:11, Gilles Chanteperdrix wrote:
> > On 05/27/2011 08:29 PM, Jonas Witt wrote:
> >> Sorry, I missed the NTP-part. I am not using NTP. Just plain timer 
> >> queries on a single system.
> >>
> >> My clock source is tsc which is the same for Xenomai I suppose.
> >>
> >> I wonder how a Xenomai task, even if it occupies 50% or even 90% of a 4 
> >> milliseconds time slice can interfere with the tsc. The tsc is not 
> >> incremented via an interrupt, is it? But I do not know much about the 
> >> inner workings of these functions.
> > 
> > The problem is not the clocksource, the problem is the timer interrupt.
> > The kernel expects 1 timer tick every millisecond.
> 
> Not on archs that are CONFIG_NO_HZ capable.

Umm. NO_HZ is only active while system is idle. Kernel will still
expect the periodic ticks when CPU is busy....

(I'm not sure how the compensation works; perhaps it can compensate
even while busy..)

									Pavel

