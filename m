Subject: Re: [PATCH 5/5] lib/cobalt/clock.c:dispatch clock_settime
References: <1604372743-2986-1-git-send-email-chensong@tj.kylinos.cn>
 <0ca03935-6895-f31e-f9ad-c910e0e22e36@siemens.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5FAB60C5.8030909@tj.kylinos.cn>+8F6DBCED54AD750E
Date: Wed, 11 Nov 2020 11:55:49 +0800
MIME-Version: 1.0
In-Reply-To: <0ca03935-6895-f31e-f9ad-c910e0e22e36@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org, henning.schild@siemens.com



On 2020年11月10日 18:24, Jan Kiszka wrote:
>
> On 03.11.20 04:05, chensong wrote:
>> Regarding sizeof time_t, dispatch 32bit timespec to clock_settime
>> and 64bit timespec to clock_settime64.
>>
>> Signed-off-by: chensong <chensong@tj.kylinos.cn>
>> ---
>>   lib/cobalt/clock.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
>> index 11fd1aa..44b2f3f 100644
>> --- a/lib/cobalt/clock.c
>> +++ b/lib/cobalt/clock.c
>> @@ -237,7 +237,11 @@ COBALT_IMPL(int, clock_settime, (clockid_t clock_id, const struct timespec *tp))
>>   {
>>   	int ret;
>>
>> -	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime, clock_id, tp);
>> +	if (sizeof(time_t) > 4)
>> +		ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime64,
>> +					clock_id, tp);
>> +	else
>> +		ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime, clock_id, tp);
>
> Maybe do a single
>
> XENOMAI_SYSCALL2(sizeof(time_t) > 4 ? sc_cobalt_clock_settime64
>                                      : sc_cobalt_clock_settime, ...)
>
> But we need ABI revision negotiation here. If a new lib is run on a
> kernel that does not have settime64, things will fail (the other way
> around is fine). We need to ensure that new userspace can check for this
> upfront while old userspace will happily run (hard requirement for
> making these patches part of 3.1.x).
>
> Jan

As far as my understanding, ABI revision negotiation happens in low_init 
already, it reminds userspace process that lib and kernel are not 
compatible at the first place. Therefore, it addresses the scenario you 
are talking about(new userspace, old kernel or the other way around).

what's more, do we or customers release lib without kernel. About y2038, 
vanilla kernel, glibc, libcobalt, xenomai, too many scenarios to be 
addressed, to complicated, we'd better simplify it if possible.

chensong
>
>>   	if (ret) {
>>   		errno = ret;
>>   		return -1;
>>
>



