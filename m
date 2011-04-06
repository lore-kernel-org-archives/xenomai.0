From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <201104060918575625047@domain.hid>
References: <201104060918575625047@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 06 Apr 2011 08:57:24 +0200
Message-ID: <1302073044.2030.19.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Would Xenomai adopt RTL after the patent is
 expired?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "arethe.rtai" <arethe.rtai@domain.hid>
Cc: Xenomai-core <Xenomai-core@domain.hid>

On Wed, 2011-04-06 at 09:19 +0800, arethe.rtai wrote:
> HI:
>    The patents that cover RT-Linux are set to expire in a few years,
> then, would Xenomai adopt the RTL technology? As known, the RTL idea
> is clean and minimalistic, it may improve the determinism of Xenomai.

The trend is rather to blur the distinction between native real-time and
dual kernel approaches these days, not to downgrade to a kernel-only
interrupt handler with co-routines on top.

So no, there would be no rational reason to do that, not to mention the
fact that if we can assess the typical latency of Xenomai over the seven
architectures it runs on with the latest mainline kernels, we would be
unable to compare this to anything else than x86 over a legacy kernel
AFAIK. And no, I don't think that I'm going to send an inquiry to WRS
for information regarding how RTL performs on other architectures.
Incidentally, maybe you should ask yourself why they ship WR-Linux with
PREEMPT_RT.

> Regards arethe
> 2011-04-06 
> 
> ______________________________________________________________________
> arethe.rtai 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

-- 
Philippe.



