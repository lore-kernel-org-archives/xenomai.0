Subject: Re: [PATCH ipipe-noarch] ipipe: Disable rcuidle trace path when
 running over the head domain
References: <e9561ccb-175f-8cb2-2a93-48e90f262f97@siemens.com>
 <VI1PR05MB5917F023FAC7A3F8677125CAF6110@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f39b1859-1c0b-124f-bd02-698b30affd60@siemens.com>
Date: Tue, 18 Feb 2020 12:33:57 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917F023FAC7A3F8677125CAF6110@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 18.02.20 11:11, Lange Norbert wrote:
> Hello Jan,
> 
> yes this fixes the issue for me, what's the downside of not using *_rcuidle,
> is that a performance optimization?
> 

No, it's a correctness thing for Linux when you call a tracepoint from 
idle paths, see commit log. When in head domain, we do not stress that 
paths. That is at least my current understanding of the situation.

Jan

> Norbert Lange
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Montag, 17. Februar 2020 19:06
>> To: Philippe Gerum <rpm@xenomai.org>; Xenomai
>> <xenomai@xenomai.org>
>> Cc: Lange Norbert <norbert.lange@andritz.com>
>> Subject: [PATCH ipipe-noarch] ipipe: Disable rcuidle trace path when running
>> over the head domain
>>
>> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
>> ATTACHMENTS.
>>
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> We do not need the special handling of __DO_TRACE(..., rcuidle=1) when
>> running over the head domain. In fact, we cannot use it because it
>> switches to srcu which is incompatible with that context. It's safe to
>> switch to normal RCU because no head domain caller of a trace_*_rcuidle
>> tracepoints should do this from rcu-problematic paths, specifically
>> idle.
>>
>> Ported from the dovetail queue.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Philippe, does this description make sense?
>>
>> Norbert, please test.
>>
>>   include/linux/tracepoint.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
>> index e9de8ad0bad7..83df22a6f284 100644
>> --- a/include/linux/tracepoint.h
>> +++ b/include/linux/tracepoint.h
>> @@ -21,6 +21,7 @@
>>   #include <linux/cpumask.h>
>>   #include <linux/rcupdate.h>
>>   #include <linux/tracepoint-defs.h>
>> +#include <linux/ipipe.h>
>>
>>   struct module;
>>   struct tracepoint;
>> @@ -212,7 +213,7 @@ static inline struct tracepoint
>> *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>                          __DO_TRACE(&__tracepoint_##name,                \
>>                                  TP_PROTO(data_proto),                   \
>>                                  TP_ARGS(data_args),                     \
>> -                               TP_CONDITION(cond), 1);                 \
>> +                               TP_CONDITION(cond), ipipe_root_p);      \
>>          }
>>   #else
>>   #define __DECLARE_TRACE_RCU(name, proto, args, cond, data_proto,
>> data_args)
>> --
>> 2.16.4
> ________________________________
> 
> This message and any attachments are solely for the use of the intended recipients. They may contain privileged and/or confidential information or other information protected from disclosure. If you are not an intended recipient, you are hereby notified that you received this email in error and that any review, dissemination, distribution or copying of this email and any attachment is strictly prohibited. If you have received this email in error, please contact the sender and delete the message and any attachment from your system.
> 
> ANDRITZ HYDRO GmbH
> 
> 
> Rechtsform/ Legal form: Gesellschaft mit beschränkter Haftung / Corporation
> 
> Firmensitz/ Registered seat: Wien
> 
> Firmenbuchgericht/ Court of registry: Handelsgericht Wien
> 
> Firmenbuchnummer/ Company registration: FN 61833 g
> 
> DVR: 0605077
> 
> UID-Nr.: ATU14756806
> 
> 
> Thank You
> ________________________________
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

