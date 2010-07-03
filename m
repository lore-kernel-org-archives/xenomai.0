Message-ID: <4C2F8DCF.2050903@domain.hid>
Date: Sat, 03 Jul 2010 21:21:51 +0200
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
References: <1278071353-13836-1-git-send-email-wolfgang.mauerer@domain.hid>
	<1278071353-13836-6-git-send-email-wolfgang.mauerer@domain.hid>
	<4C2F273C.8060201@domain.hid>
In-Reply-To: <4C2F273C.8060201@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 5/7] posix: Support reading the host
 realtime clock in realtime context
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Wolfgang Mauerer wrote:
>> Wall time management is typically assisted by the NTP
>> protocol in the Linux context, but this information is
>> not propagated to Xenomai. This patch adds support
>> for a CLOCK_HOST_REALTIME clock id that is coupled to the
>> host operating system's realtime clock. The required
>> information from the Kernel into Xenomai. The data exchange
>> is designed to allow for lockless reading from userland.
>>
>> Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>> ---
>>  include/posix/time.h     |    2 +
>>  ksrc/skins/posix/clock.c |   90 +++++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 91 insertions(+), 1 deletions(-)
>>
>> diff --git a/include/posix/time.h b/include/posix/time.h
>> index 4f2d760..938feb6 100644
>> --- a/include/posix/time.h
>> +++ b/include/posix/time.h
>> @@ -50,6 +50,8 @@
>>  #define CLOCK_MONOTONIC 1
>>  #endif /* CLOCK_MONOTONIC */
>>  
>> +#define CLOCK_HOST_REALTIME 16
>> +
>>  #if defined(__KERNEL__) || defined(__XENO_SIM__)
>>  
>>  struct sigevent;
>> diff --git a/ksrc/skins/posix/clock.c b/ksrc/skins/posix/clock.c
>> index 553e123..f5a789b 100644
>> --- a/ksrc/skins/posix/clock.c
>> +++ b/ksrc/skins/posix/clock.c
>> @@ -50,6 +50,13 @@
>>   *@{*/
>>  
>>  #include <posix/thread.h>
>> +#include <linux/ipipe_tickdev.h>
>> +#include <linux/math64.h>
> 
> Do we really need this? Because we probably do not have it in 2.4
> kernels. Besides, we do not include linux/ headers in Xenomai code.
> 
right, math64.h should be xenomai/asm-generic/arith.h for
xnarch_divrem_billion(). ipipe_tickdev.h is superfluous since
all definitions go through xnarch and rthal.

>> +static int do_clock_host_realtime(struct timespec *tp)
>> +{
>> +#ifdef CONFIG_XENO_OPT_HOSTRT
>> (...)
>> +	return 0;
>> +#else /* CONFIG_XENO_OPT_HOSTRT */
>> +	return -1;
> 
> return -EINVAL;
> 
>> +	case CLOCK_HOST_REALTIME:
>> +		if (do_clock_host_realtime(tp) != 0) {
> 		rc = do_clock_host_realtime(tp);
> 		if (rc < 0) {
> 			thread_set_errno(-rc);
> 			return -1;
> 		}
> 
> 


