Message-ID: <496E5896.7020801@domain.hid>
Date: Wed, 14 Jan 2009 22:26:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <894886ec0810012230j57e2f87n343a5b07bbdbd46@domain.hid>
In-Reply-To: <894886ec0810012230j57e2f87n343a5b07bbdbd46@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] clock drift
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rob Wheeler <wheeler@domain.hid>
Cc: xenomai@xenomai.org

Rob Wheeler wrote:
> Hello,
> 
> I was recently debugging a problem in our code base and tracked the
> issue down to differences between calling gettimeofday() from our
> non-realtime code and calling clock_gettime() from our realtime
> control loop.  A little poking around with Google led me to clocktest
> program in the Xenomai testsuite.  We are routinely seeing differences
> of around 4 minutes (~240 seconds) between gettimeofday() and
> clock_gettime() immediately after a reboot.  The clocks continue to
> drift apart (or together) at the rate of about 50us/s.

Hi Rob,

when chasing unrelated issues, I found what could be the cause of the
original 4 minutes difference. The bug is fixed in the svn repository. I
think it goes in the "very stupid bugs" category.

Well, tooks only 3 monthes...

Regards.

-- 
					    Gilles.

