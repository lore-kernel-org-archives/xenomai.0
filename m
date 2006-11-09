Message-ID: <45533582.40808@domain.hid>
Date: Thu, 09 Nov 2006 15:04:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Strange results with latency test
References: <20061109133632.GA4205@domain.hid>
In-Reply-To: <20061109133632.GA4205@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Matthias Fechner wrote:
> Hi,
> 
> I tested today Xenomai on my AMD64 (32-bit mode) with the latency
> program from the testsuite and I got for lat min negative values.
> 
> Can my computer predict the future? :)

The expiration time of a timer is usually known in advance, so, in that
sense, your computer predicts the future.

> 
> How can I interpret these values?

It means that Xenomai anticipates, that is, the timer is programmed
to tick a bit early in order to account for the interrupt and scheduling
latencies. In your case it is a bit too early, you can change this
anticipation time at compilation time with the configuration constant
CONFIG_OPT_TIMING_TIMERLAT and CONFIG_XENO_OPT_TIMING_SCHEDLAT, or 
change it at run time by writing a new value in /proc/xenomai/latency.

-- 
                                                  Gilles Chanteperdrix

