Message-ID: <4FB557A5.5020202@domain.hid>
Date: Thu, 17 May 2012 21:55:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E2AB2206BF591546A1931EA4E7A9FBC841502023@domain.hid>,
	<4FB54E89.3070505@domain.hid>
	<E2AB2206BF591546A1931EA4E7A9FBC841502090@domain.hid>
In-Reply-To: <E2AB2206BF591546A1931EA4E7A9FBC841502090@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai Periodic Latency Spikes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Wolz, Troy" <Troy.Wolz@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 05/17/2012 09:35 PM, Wolz, Troy wrote:
> In the attached plots, there appear to be very periodic spikes in
> latency. In the time between these spikes, the worst case latency is
> around 5 us. Is this to be expected? Is worst case latency typically
> periodic in nature?

>From the measurements I posted recently:
http://sisyphus.hd.free.fr/~gilles/core-3.2-latencies

It seems on higher-end machines, the probability decreases approximately
exponentially from the average latency to the max latency. So, every
latency smaller than the worst case latency has some probability to
happen, and happens from time to time.

On an atom 230 (which admittedly is not a such high end machine), the
average latency is less than 10us, but the maximum latency reaches 70us
when running with CONFIG_SMP.

The worst case latency you obtain on a machine without load, or over a
short period of time does not mean anything. If you are serious about
measuring the worst case latency, you have to do it over a long period
of time while running under load. We provide the "xeno-test" and
"dohell" scripts for that.

If your kernel is running with CONFIG_HZ set to 1000, the thing which
happens once every 1ms is the 8254 timer interrupt, on cpu 0 at least.

If you want to know what happens when the worst case latency is reached
you have to enable the I-pipe tracer and run the latency test with the
"-f" argument.

I am not saying that there is not a problem with your setup, but there
is nothing proving that in what you posted.

Please no:
- private mails
- html mails
- un-wrapped lines
- top-posting.


-- 
                                                                Gilles.

