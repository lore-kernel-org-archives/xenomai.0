From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17618.14793.304543.952079@domain.hid>
Date: Thu, 3 Aug 2006 20:00:41 +0200
Subject: Re: [Xenomai-help] testing interrupt latency
In-Reply-To: <1154615459.9835.62.camel@domain.hid>
References: <1154615459.9835.62.camel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bart Jonkers <jonkersbart@domain.hid>
Cc: xenomai@xenomai.org

Bart Jonkers wrote:
 > Hey,
 > 
 > I have written a small module to test the interrupt response time of
 > Xenomai to compare it with the time of Linux.
 > 
 > I generate an interrupt on a GPIO pin and toggles another GPIO pin in
 > the interrupt service routine. (code below)
 > The time between the generated interrupt and the value change on the
 > GPIO pin is taken as interrupt response time.
 > 
 > Everything works well, but I notice a strange behavior.
 > I thought that the interrupt response time of xenomai should be (as good
 > as) constant all the time. But I see that this is not the case.
 > 
 > Did I do something wrong in my code or did I made a wrong assumption?

What should be guaranteed by Xenomai is that the response time is
bounded, not that it is constant. Of course, we make all we can to make
the bound as small as possible, but each hardware has its
limits.

-- 


					    Gilles Chanteperdrix.

