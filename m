Message-ID: <45B09920.1040607@domain.hid>
Date: Fri, 19 Jan 2007 11:10:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Nocow patch.
References: <45A52B04.1010706@domain.hid> <45A6554D.2060900@domain.hid>	
	<1168714673.21854.17.camel@domain.hid>
	<45AB5BE6.8070309@domain.hid>	 <45B08DCF.3000708@domain.hid>
	<1169200733.3964.29.camel@domain.hid>
In-Reply-To: <1169200733.3964.29.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Fri, 2007-01-19 at 10:22 +0100, Gilles Chanteperdrix wrote:
> 
>>Gilles Chanteperdrix wrote:
>>
>>>However, after looking at the ARM patch, I am not so sure
>>>__ipipe_update_all_pinned_mm() is the way to go on all architectures.
>>>The ARM I-pipe handles vmalloc and ioremap faults without causing a mode
>>>switch, I wonder if it is not better than having
>>>__ipipe_update_all_pinned_mm() updating page directories all over the
>>>place.
>>
>>I checked with the I-pipe tracer the overhead on an ARM of a fault on a
>>vmalloced area: it costs around 5 us.
>>
> 
> 
> What is the average latency in user-space on this board for 1Khz and
> 10Khz periods?

At 10 kHz we get a lockup. At 1 kHz, we get a worst case latency around
200 us, with an average latency around 150 us if running the cache
calibrator in the background.

> 
> Beyond that, we may want to keep both approaches at hand in the core
> infrastructure; running the same benchmark on, say an integrator, may
> give much higher latencies due to lousy cache issues. This still needs
> to be verified though.

My original point was that the use of ipipe_disable_ondemand_mappings
may be traumatic on cache. I am wondering if we should not add a nucleus
syscall a bit like mlockall, to which we would pass some flags like
COW_CURRENT, VMALLOC_CURRENT, VMALLOC_FUTURE, and depending on these
flags, ipipe_disable_ondemand_mappings would only do parts of what it is
currently doing.

-- 
                                                 Gilles Chanteperdrix

