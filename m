MIME-Version: 1.0
In-Reply-To: <314E5ECDAA86314791309FA670550F89C9C50321@SINTEFEXMBX05.sintef.no>
References: <314E5ECDAA86314791309FA670550F89C9C4FD8A@SINTEFEXMBX05.sintef.no>
 <20141201073433.GR2964@hermes>
 <314E5ECDAA86314791309FA670550F89C9C5006D@SINTEFEXMBX05.sintef.no>
 <20141201085028.GA21004@hermes>
 <314E5ECDAA86314791309FA670550F89C9C50321@SINTEFEXMBX05.sintef.no>
Date: Mon, 1 Dec 2014 12:35:18 +0100
Message-ID: <CAD3Bbm+rTuzSWJ+ikNMDZgi3CW7yO4wUgawQco+C4ChG-rLj8A@mail.gmail.com>
From: Hidde Verstoep <hverstoep@e2mtechnologies.eu>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] WARNING: at arch/arm/kernel/ipipe.c:157
	ipipe_set_irq_affinity+0x47/0x70()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Terje_Fr=C3=B8ysa?= <Terje.Froysa@sintef.no>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> By the way.. When compiling kernel for Xenomai, I am advised to turn off CPU Frequency scaling "as it is known to cause trouble".
> When enabled I could inspect and set the CPU clock frequency by the "cpufreq-info" and "cpufreq-set".
> These tools are no longer available and I don't find any settings in the menuconfig.
>
> What is the default BBB CPU frequency when frequency scaling is turned off?

>From my experience with the BBB and Xenomai:
The default CPU frequency with frequency scaling turned off is 600
MHz. This was not acceptable for me since the BBB supports 1000 Mhz.
So, I left frequency scaling on in the kernel, but set the default
mode to "performance" (always runs the CPU at max frequency). Issue
with this is that the mode still gets reset to "ondemand" every now
and then (I have no clue as to why). So, I configured the kernel with
frequency scaling on, the default mode set to "performance" and all
other modes disabled. This seems to work without issues with Xenomai.

Kind regards,
Hidde Verstoep

