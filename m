From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: [PATCH 3/8] dovetail/clock: implement pipeline_set_timer_shot to
 trigger tick shot
Date: Tue, 19 Jan 2021 00:57:23 +0000
Message-ID: <MWHPR11MB1710D0A798FD868E6A7EA71FF2A30@MWHPR11MB1710.namprd11.prod.outlook.com>
References: <20210115011639.15390-1-hongzhan.chen@intel.com>
 <20210115011639.15390-3-hongzhan.chen@intel.com> <87zh19rt7r.fsf@xenomai.org>
In-Reply-To: <87zh19rt7r.fsf@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>



>-----Original Message-----
>From: Philippe Gerum <rpm@xenomai.org>=20
>Sent: Saturday, January 16, 2021 7:56 PM
>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>Cc: xenomai@xenomai.org
>Subject: Re: [PATCH 3/8] dovetail/clock: implement pipeline_set_timer_shot=
 to trigger tick shot
>
>
>The shortlog should mention the subsystem and the pipeline variant to
>allow for a quick comprehension of the scope; that would be
>"cobalt/tick: dovetail: ..." in this case.
>
>hongzha1 via Xenomai <xenomai@xenomai.org> writes:
>
>> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
>>
>> diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/c=
obalt/kernel/dovetail/pipeline/clock.h
>> index 28d89b44b..db982d969 100644
>> --- a/include/cobalt/kernel/dovetail/pipeline/clock.h
>> +++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
>> @@ -17,17 +17,7 @@ static inline u64 pipeline_read_cycle_counter(void)
>>  	return  ktime_get_raw_fast_ns();
>>  }
>> =20
>> -static inline void pipeline_set_timer_shot(unsigned long cycles)
>> -{
>> -	/*
>> -	 * N/A. Revisit: xnclock_core_local_shot() should go to the
>> -	 * I-pipe section, we do things differently on Dovetail via
>> -	 * the proxy tick device. As a consequence,
>> -	 * pipeline_set_timer_shot() should not be part of the
>> -	 * pipeline interface.
>> -	 */
>> -	TODO();
>> -}
>> +inline void pipeline_set_timer_shot(unsigned long cycles);
>> =20
>>  static inline const char *pipeline_timer_name(void)
>>  {
>> diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick=
.c
>> index 6a196496c..55039f96e 100644
>> --- a/kernel/cobalt/dovetail/tick.c
>> +++ b/kernel/cobalt/dovetail/tick.c
>> @@ -16,6 +16,43 @@ extern struct xnintr nktimer;
>> =20
>>  static DEFINE_PER_CPU(struct clock_proxy_device *, proxy_device);
>> =20
>> +inline void pipeline_set_timer_shot(unsigned long cycles)
>> +{
>> +	/*
>> +	 * N/A. Revisit: xnclock_core_local_shot() should go to the
>> +	 * I-pipe section, we do things differently on Dovetail via
>> +	 * the proxy tick device. As a consequence,
>> +	 * pipeline_set_timer_shot() should not be part of the
>> +	 * pipeline interface.
>> +	 */
>> +	struct clock_proxy_device *dev =3D __this_cpu_read(proxy_device);
>> +	struct clock_event_device *real_dev =3D dev->real_device;
>> +	int ret;
>> +	u64 sumcyc;
>> +	ktime_t t;
>> +
>> +	if (real_dev->features & CLOCK_EVT_FEAT_KTIME) {
>> +		t =3D ktime_add(cycles, xnclock_core_read_raw());
>> +		real_dev->set_next_ktime(t, real_dev);
>> +	} else {
>> +		if (cycles <=3D 0)
>> +			cycles =3D real_dev->min_delta_ns;
>> +		else {
>> +			cycles =3D min_t(int64_t, cycles,
>> +					real_dev->max_delta_ns);
>> +			cycles =3D max_t(int64_t, cycles,
>> +					real_dev->min_delta_ns);
>> +		}
>> +		sumcyc =3D ((u64)cycles * real_dev->mult) >> real_dev->shift;
>> +
>> +		ret =3D real_dev->set_next_event(sumcyc, real_dev);
>> +		if (ret) {
>> +			ret =3D real_dev->set_next_event(real_dev->min_delta_ticks,
>> +							real_dev);
>> +		}
>> +	}
>> +}
>> +
>>  static int proxy_set_next_ktime(ktime_t expires,
>>  				struct clock_event_device *proxy_dev)
>>  {
>
>This patch does not apply cleanly, raising a conflict in
>dovetail/pipeline/clock.h. Besides, as discussed recently, the comment  =20

The patch actually depends on previous 5 patches you already approved=20
to merge. One of them modified dovetail/pipeline/clock.h. =20

https://xenomai.org/pipermail/xenomai/2021-January/044123.html
https://xenomai.org/pipermail/xenomai/2021-January/044124.html
https://xenomai.org/pipermail/xenomai/2021-January/044125.html
https://xenomai.org/pipermail/xenomai/2021-January/044126.html
https://xenomai.org/pipermail/xenomai/2021-January/044127.html

>mentioning the need to revisit the code may not be accurate anymore. You

Thanks for your suggestions, I will refine it though.

>may want to drop it as part of the fix up.
>
>--=20
>Philippe.


