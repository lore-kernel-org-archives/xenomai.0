Subject: Re: libcopperplate.so depends on modecheck?
References: <VI1PR05MB59179589CFDB55840B07A386F6190@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <0023f233-2b01-83c4-74a1-deaed32d7544@siemens.com>
 <VI1PR05MB5917F2C22AECF59AEC2543B5F6190@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <17efb9fb-afd9-a999-5f82-e60a358c015a@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4c219ecd-8125-763f-a20e-c5b83ee684bf@xenomai.org>
Date: Fri, 31 May 2019 17:55:40 +0200
MIME-Version: 1.0
In-Reply-To: <17efb9fb-afd9-a999-5f82-e60a358c015a@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>, Henning Schild <henning.schild@siemens.com>

On 5/31/19 5:31 PM, Jan Kiszka wrote:
> On 31.05.19 17:13, Lange Norbert wrote:
>>> -----Original Message-----
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: Freitag, 31. Mai 2019 16:26
>>> To: Lange Norbert <norbert.lange@andritz.com>; Xenomai
>>> (xenomai@xenomai.org) <xenomai@xenomai.org>; Philippe Gerum
>>> <rpm@xenomai.org>; Henning Schild <henning.schild@siemens.com>
>>> Subject: Re: libcopperplate.so depends on modecheck?
>>>
>>> E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE, PLEASE
>>> EXERCISE CAUTION WITH E-MAIL CONTENT AND ANY LINKS OR
>>> ATTACHMENTS.
>>>
>>>
>>> On 31.05.19 14:12, Lange Norbert via Xenomai wrote:
>>>> I still believe this to be a bug, adding a patch to correct this.
>>>>
>>>
>>> The patch lacks a commit message that explains "why". Also, inline
>>> would be
>>> preferred (unless your mail client is consistently preventing that).
>>
>> I have the choice between git-send-email without context of the
>> previous mail,
>> or Outlook which breaks any formatting.
>> (I was kinda expecting a discussion and thus a V2)
> 
> Something which starts with "[PATCH]" and continues with code has a
> higher chance of attention, but your questions would have deserved
> feedback nevertheless.
> 
>>
>>> The idea of the wrapping is to establish an instrumentation point
>>> that will
>>> give us an early warning when an application calls into non-rt
>>> malloc/free
>>> from rt context. As those glibc calls only occasionally cause a
>>> syscall, the hook
>>> is needed to have that deterministic warning.
>>
>> Sure, but this is NOT __wrap_malloc but __real_malloc, which seems
>> pointless to me
>> (this is just routed through as-is to malloc).
>>
> 
> As I wrote, something is fishy for me as well. But we should first try
> to understand why the author added those tags (original intention) and
> then match it against the current implementation.

The original authors says that you can drop the __STD() tag from all
call sites in libcopperplate/*.c, the intent was to prevent mode
checkers to get in the way when such calls are legit would a rt context
is actually running non-rt stuff like prep or cleanup code. However,
regular pthreads or Xenomai threads running the weak scheduling policy
are the only possible callers, so we basically don't care.

-- 
Philippe.

