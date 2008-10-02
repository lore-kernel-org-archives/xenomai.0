Message-ID: <48E4649B.6090506@domain.hid>
Date: Thu, 02 Oct 2008 08:05:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <894886ec0810012230j57e2f87n343a5b07bbdbd46@domain.hid>	
	<48E45E3C.30605@domain.hid>
	<894886ec0810012258o67da00d7x2e3d54c7e601b470@domain.hid>
In-Reply-To: <894886ec0810012258o67da00d7x2e3d54c7e601b470@domain.hid>
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
Cc: Xenomai help <xenomai@xenomai.org>

Rob Wheeler wrote:
> Gilles,

Rob,

please do not drop the list from the CC, the conversation may interest
other people.

> 
> Thanks for the FAST response.  I'm currently calling gettimeofday()
> and clock_settime() one time just prior to creating my realtime
> thread.
> 
> My goal is to have a thread that wakes up every 1ms and performs some
> work and goes back to sleep until the next 1ms interval.  My current
> implementation calls clock_gettime() initially, and then sits in a
> while (1) loop that does some work and then calls
> clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, ...) with a timespec
> exactly 1ms since the last sleep.
> 
> Given my application, is your recommendation that I switch to using
> the CLOCK_MONOTONIC in my realtime loop and then have a non-realtime
> thread which basically does:
> 
> while (1) {
>   gettimeofday()
>   clock_settime(CLOCK_REALTIME)
>   sleep for a bit
> }
> 
> so that I can get close to synchronized time in my realtime code?

Yes.

> 
> Also, just for my education, is 50us/s a typical clock drift value?
> What exactly is the source of this drift and can anything be done to
> reduce the amount of drift?

I have no idea if this is normal. Xenomai uses the tsc as a clock
source. Linux may choose to use something else than the tsc (you should
see messages in the logs if it does), it may correct the tsc clock drift
if you use NTP, and since Xenomai does not correct the drift, you
observe a difference.

-- 
					    Gilles.

