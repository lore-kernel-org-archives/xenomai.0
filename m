References: <60deb062-29ca-da10-10d5-2f6e61dcca67@siemens.com>
 <b58a6e58-e38e-fbc5-801a-83c430ed1bbf@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] cobalt/arch/arm: arith: Avoid r7 usage in helpers
In-reply-to: <b58a6e58-e38e-fbc5-801a-83c430ed1bbf@siemens.com>
Date: Mon, 09 Aug 2021 17:09:20 +0200
Message-ID: <87eeb24pun.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>, "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 07.08.21 17:52, Jan Kiszka via Xenomai wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> 
>> Since gcc-9, direct usage of r7 is in conflict with compiler
>> allocations. Skip it.
>> 
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  .../arch/arm/include/asm/xenomai/uapi/arith.h      | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>> 
>> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/arith.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/arith.h
>> index cf897b44fa..4d3ae65411 100644
>> --- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/arith.h
>> +++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/arith.h
>> @@ -79,9 +79,9 @@ mach_arm_nodiv_ullimd(const unsigned long long op,
>>  	register unsigned frach __asm__ ("r3");
>>  	register unsigned integ __asm__("r4") = rhs_integ;
>>  	register unsigned opl __asm__ ("r6");
>> -	register unsigned oph __asm__ ("r7");
>> -	register unsigned tl __asm__("r8");
>> -	register unsigned th __asm__("r9");
>> +	register unsigned oph __asm__ ("r8");
>> +	register unsigned tl __asm__("r9");
>> +	register unsigned th __asm__("r10");
>>  
>>  	xnarch_u64tou32(op, oph, opl);
>>  	xnarch_u64tou32(frac, frach, fracl);
>> @@ -109,10 +109,10 @@ mach_arm_nodiv_llimd(const long long op,
>>  	register unsigned frach __asm__ ("r3");
>>  	register unsigned integ __asm__("r4") = rhs_integ;
>>  	register unsigned opl __asm__ ("r6");
>> -	register unsigned oph __asm__ ("r7");
>> -	register unsigned tl __asm__("r8");
>> -	register unsigned th __asm__("r9");
>> -	register unsigned s __asm__("r10");
>> +	register unsigned oph __asm__ ("r8");
>> +	register unsigned tl __asm__("r9");
>> +	register unsigned th __asm__("r10");
>> +	register unsigned s __asm__("r11");
>
> Florian just pointed out that r11 is the frame pointer. Not many options
> remaining - ideas?

Try r12(ip) adding it to the clobber list.

-- 
Philippe.

