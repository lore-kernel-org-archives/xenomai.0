Message-ID: <4DA2AC9C.2030607@domain.hid>
Date: Mon, 11 Apr 2011 09:24:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20110409184122.GA11908@domain.hid>
	<20110409185503.GB11908@domain.hid>
	<4DA0B580.4070602@domain.hid> <4DA0B878.9010106@domain.hid>
	<20110410065250.GA28869@domain.hid>
	<4DA192E0.2090802@domain.hid>
	<20110411055344.GA5854@domain.hid>
In-Reply-To: <20110411055344.GA5854@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] arm ixp: more trouble with recent xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

Richard Cochran wrote:
> On Sun, Apr 10, 2011 at 01:22:08PM +0200, Gilles Chanteperdrix wrote:
>> Also, about the performances, Xenomai 2.4 did not have the Xenomai
>> preemptible context switches. Maybe with FCSE, it results in reduced
>> latencies to disable this option in Xenomai 2.5.
> 
> So, are you saying that XENO_HW_UNLOCKED_SWITCH=n might improve
> latency?
> 
> The help for this option says...
> 
>     This option reduces interrupt latency when costly cache and
>     TLB flushes are required to switch context, and may improve
>     concurrency on some SMP/multi-core systems as well.
> 
>     You definitely want to enable that option on embedded ARM
>     platforms.
> 
> so I am confused.

Is is a trade-off.

With this option enabled a context switch may be interrupted, this
improves interrupt latency, but at the expense of scheduling latency.

It makes a lot of sense without FCSE, when each context switch implies a
200us cache flush. A bit less with FCSE in guaranteed mode.


-- 
                                                                Gilles.

