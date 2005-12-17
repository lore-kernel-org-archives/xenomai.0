Message-ID: <43A4499A.9040004@domain.hid>
Date: Sat, 17 Dec 2005 18:23:38 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] debug_maxlat as module_param
References: <43A436A1.5070509@domain.hid>	<17316.16329.895671.929282@domain.hid>
	<43A4481B.7060401@domain.hid>
In-Reply-To: <43A4481B.7060401@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> 
>>Jan Kiszka wrote:
>> > Hi,
>> > 
>> > this tiny patch exports the NMI watchdog's threshold as module parameter
>> > "debug_maxlat" of xeno_hal. This means that one can either override the
>> > value via a kernel parameter or in sysfs/modules/xeno_hal/parameters
>> > (before activating the hal).
>>
>>rthal_maxlat_tsc should be updated when rthal_maxlat_us_arg changes.
>>
> 
> 
> I didn't digged that deep, is this possible during runtime? My current
> workflow looks like this: unload xeno_nucleus (and higher modules),
> change maxlat, reload the modules.
> 
> Mmh, I guess one has to register some update handler with sysfs in that
> case. Any hint where to look for a pattern?
> 

Please don't depend on sysfs for generic features since they would not 
be available on 2.4.

> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

