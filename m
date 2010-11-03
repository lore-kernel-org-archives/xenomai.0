Message-ID: <4CD18782.7090607@domain.hid>
Date: Wed, 03 Nov 2010 17:02:10 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>	<4CC84327.9070202@domain.hid>	<4CC92786.3030509@domain.hid>	<4CC92902.4040904@domain.hid>	<4CC943A2.9020806@domain.hid>	<4CC94E0B.9070106@domain.hid>	<4CCEF104.7050409@domain.hid>	<4CD11AB1.8090407@domain.hid>
	<4CD13A70.8040702@domain.hid>	<4CD14B1E.4000707@domain.hid>
	<4CD14C92.90901@domain.hid>	<4CD14DBC.3060505@domain.hid>
	<4CD1509A.3000908@domain.hid>	<4CD152F3.4080203@domain.hid>
	<4CD16654.6080704@domain.hid>
In-Reply-To: <4CD16654.6080704@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Anders Blomdell wrote:
> Jan Kiszka wrote:
>> additional barrier. Can you check this?
>>
>> diff --git a/include/nucleus/sched.h b/include/nucleus/sched.h
>> index df56417..66b52ad 100644
>> --- a/include/nucleus/sched.h
>> +++ b/include/nucleus/sched.h
>> @@ -187,6 +187,7 @@ static inline int xnsched_self_resched_p(struct 
>> xnsched *sched)
>>    if (current_sched != (__sched__))    {                \
>>        xnarch_cpu_set(xnsched_cpu(__sched__), 
>> current_sched->resched);    \
>>        setbits((__sched__)->status, XNRESCHED);                \
>> +      xnarch_memory_barrier();                        \
>>    }                                    \
>>  } while (0)
> 
> In progress, if nothing breaks before, I'll report status tomorrow morning.
It still breaks (in approximately the same way). I'm currently putting a 
barrier in the other macro doing a RESCHED, also adding some tracing to 
see if a read barrier is needed.

Interesting side-note:

Harddisk accesses seems to get real slow after error has occured (kernel 
installs progresses with 2-3 modules installed per second), while lots 
of idle time reported on all cpu's, weird...

/Anders

