Message-ID: <4A29290E.7050609@domain.hid>
Date: Fri, 05 Jun 2009 16:17:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A28F029020000F80002DB14@domain.hid>	<4A28FAD4020000F80002DB27@domain.hid>
	<4A28FAD7.3E52.00F8.0@domain.hid><4A28FAD7.3E52.00F8.0@domain.hid>
	<4A28E5E0.9020805@domain.hid>
	<4A2907EF.3E52.00F8.0@domain.hid><4A2907EF.3E52.00F8.0@domain.hid>
	<4A2920C7.40200@domain.hid> <4A294359.3E52.00F8.0@domain.hid>
In-Reply-To: <4A294359.3E52.00F8.0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ-Latency when in idle State on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Tyss <tyss.k@domain.hid>
Cc: xenomai@xenomai.org

Karl Tyss wrote:
> Hi,
> 
> 5 minutes ago I found out that one of the caches definately has to
> cause the problem. I believe I would have to spent couple of more days
> to find out why. 
> 
> Your hint was a bulls eye. I tried a dirty trick and commented out the
> two lines responsible for disabling the I-cache.  It helped. I wonder if
> it leads to other problems. I will test it and post my results.
> 
> Thank you both for the quick and productive help.

Also, let me insist: 2 microseconds on ARM is peanuts. Really, it is
insignificant, you will get much worse jitters than that with a properly
loaded system.

-- 
					    Gilles.

