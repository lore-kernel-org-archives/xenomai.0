Message-ID: <4FBB8D1F.5060207@xenomai.org>
Date: Tue, 22 May 2012 14:57:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E2AB2206BF591546A1931EA4E7A9FBC841502023@Pele.in.dynetics.com>	<4FB54E89.3070505@xenomai.org>	<E2AB2206BF591546A1931EA4E7A9FBC841502090@Pele.in.dynetics.com>	<4FB557A5.5020202@xenomai.org>
	<CAKvQZ_0xN8yYdMJ6oaiPMTSTHEMB8U5oJ4YVikcQ=U8qqQRCYg@mail.gmail.com>
In-Reply-To: <CAKvQZ_0xN8yYdMJ6oaiPMTSTHEMB8U5oJ4YVikcQ=U8qqQRCYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-help] Xenomai Periodic Latency Spikes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Willy Lambert <lambert.willy@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 05/22/2012 01:53 PM, Willy Lambert wrote:
> 
> 
> 2012/5/17 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org
> <mailto:gilles.chanteperdrix@xenomai.org>>
> 
>     On 05/17/2012 09:35 PM, Wolz, Troy wrote:
>     > In the attached plots, there appear to be very periodic spikes in
>     > latency. In the time between these spikes, the worst case latency is
>     > around 5 us. Is this to be expected? Is worst case latency typically
>     > periodic in nature?
> 
>     From the measurements I posted recently:
>     http://sisyphus.hd.free.fr/~gilles/core-3.2-latencies
> 
>     It seems on higher-end machines, the probability decreases approximately
>     exponentially from the average latency to the max latency. So, every
>     latency smaller than the worst case latency has some probability to
>     happen, and happens from time to time.
> 
>     On an atom 230 (which admittedly is not a such high end machine), the
>     average latency is less than 10us, but the maximum latency reaches 70us
>     when running with CONFIG_SMP.
> 
>     The worst case latency you obtain on a machine without load, or over a
>     short period of time does not mean anything. If you are serious about
>     measuring the worst case latency, you have to do it over a long period
>     of time while running under load. We provide the "xeno-test" and
>     "dohell" scripts for that.
> 
>     If your kernel is running with CONFIG_HZ set to 1000,
> 
>     the thing which
>     happens once every 1ms is the 8254 timer interrupt, on cpu 0 at least.
> 
> 
> Hi,
> 
> Is it a good choice to configure CONFIG_HZ to 1kHz if all fast cycle
> work is done in xenomai (related to your "every 1ms interrupt" remark) ?
> Does this option has an impact on xenomai primary mode ? or is it just
> for the classic linux world ?

When the 1kHz timer interrupt over xenomai context, it is immediately
masked and acked in order to be handled later. If an interrupt happens
while the I-pipe is doing this, it has to wait for the operation to be
finished. I doubt this could be the cause of 30us latencies, though. And
in any case changing the frequency will not help reducing the worst case
latency, it will only help in having it happening less often.

And let me repeat it: the I-pipe tracer is the best tool to understand
what happens.

Re-posting the mail: the mailing list address has changed, it is
xenomai@xenomai.org now.

-- 
					    Gilles.

