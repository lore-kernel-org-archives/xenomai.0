Date: Thu, 9 Nov 2006 19:36:32 +0100
From: Matthias Fechner <idefix@domain.hid>
Subject: Re: [Xenomai-help] Strange results with latency test
Message-ID: <20061109183631.GB40200@domain.hid>
References: <20061109133632.GA4205@domain.hid>
	<45533582.40808@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45533582.40808@domain.hid>
Sender: Matthias Fechner <idefix@domain.hid>
Reply-To: xenomai@xenomai.org
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

Hello Gilles and Wolfgang,

* Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> [09-11-06 15:04]:
> It means that Xenomai anticipates, that is, the timer is programmed
> to tick a bit early in order to account for the interrupt and scheduling
> latencies. In your case it is a bit too early, you can change this
> anticipation time at compilation time with the configuration constant
> CONFIG_OPT_TIMING_TIMERLAT and CONFIG_XENO_OPT_TIMING_SCHEDLAT, or 
> change it at run time by writing a new value in /proc/xenomai/latency.

ah ok thx a lot for that information.

Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook

