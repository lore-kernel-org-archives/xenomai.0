Subject: Re: libcopperplate.so depends on modecheck?
References: <VI1PR05MB59179589CFDB55840B07A386F6190@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <0023f233-2b01-83c4-74a1-deaed32d7544@siemens.com>
 <VI1PR05MB5917F2C22AECF59AEC2543B5F6190@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <17efb9fb-afd9-a999-5f82-e60a358c015a@siemens.com>
Date: Fri, 31 May 2019 17:31:32 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917F2C22AECF59AEC2543B5F6190@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>, Henning Schild <henning.schild@siemens.com>

On 31.05.19 17:13, Lange Norbert wrote:
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Freitag, 31. Mai 2019 16:26
>> To: Lange Norbert <norbert.lange@andritz.com>; Xenomai
>> (xenomai@xenomai.org) <xenomai@xenomai.org>; Philippe Gerum
>> <rpm@xenomai.org>; Henning Schild <henning.schild@siemens.com>
>> Subject: Re: libcopperplate.so depends on modecheck?
>>
>> E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE, PLEASE
>> EXERCISE CAUTION WITH E-MAIL CONTENT AND ANY LINKS OR
>> ATTACHMENTS.
>>
>>
>> On 31.05.19 14:12, Lange Norbert via Xenomai wrote:
>>> I still believe this to be a bug, adding a patch to correct this.
>>>
>>
>> The patch lacks a commit message that explains "why". Also, inline would be
>> preferred (unless your mail client is consistently preventing that).
> 
> I have the choice between git-send-email without context of the previous mail,
> or Outlook which breaks any formatting.
> (I was kinda expecting a discussion and thus a V2)

Something which starts with "[PATCH]" and continues with code has a higher 
chance of attention, but your questions would have deserved feedback nevertheless.

> 
>> The idea of the wrapping is to establish an instrumentation point that will
>> give us an early warning when an application calls into non-rt malloc/free
>> from rt context. As those glibc calls only occasionally cause a syscall, the hook
>> is needed to have that deterministic warning.
> 
> Sure, but this is NOT __wrap_malloc but __real_malloc, which seems pointless to me
> (this is just routed through as-is to malloc).
> 

As I wrote, something is fishy for me as well. But we should first try to 
understand why the author added those tags (original intention) and then match 
it against the current implementation.

> The bigger idea behind this is to use preload libraries (#1), at which point this symbol wrapping is
> counter-productive.
> 

Then please propose tool and method for upstream integration if it can replace 
existing static instrumentations without drawbacks.

Jan

>>
>> That instrumentation should also work for indirect malloc/free via our
>> libraries. From that perspective, I would rather expect unwrapped calls so
>> that they *do* point to libmodechk helpers. Seems inconsistent from that
>> angle. OTH, internal calls could also be instrumented at build-time, thus could
>> avoid the wrapping trick.
> 
> Again, the symbols are not the checked ones by libmodechk, and you can avoid the
> build-time wrapping with preloaded libraries.
> 
>> But all this is fairly complex. Philippe and Henning should have thought this
>> through a bit more.
>>
>> Jan
> 
> #1: https://github.com/nolange/preload_checkers
> 
> Regards,
> Norbert
>>
>>> Regards, Norbert
>>>
>>>> -----Original Message-----
>>>> From: Lange Norbert
>>>> Sent: Mittwoch, 20. März 2019 11:49
>>>> To: Xenomai (xenomai@xenomai.org) <xenomai@xenomai.org>
>>>> Subject: libcopperplate.so depends on modecheck?
>>>>
>>>> Hello,
>>>>
>>>> Seems like libcopperplate.so always depends on libmodechk.so, as the
>>>> following symbols would imply:
>>>>
>>>> nm -D /home/lano/buildroot/host/x86_64-buildroot-linux-
>>>> gnu/sysroot/usr/xenomai/lib/libcopperplate.so | grep __real
>>>>                    U __real_free
>>>>                    U __real_malloc
>>>>
>>>> xeno-config deals with this by always linking modeck, even if you add
>>>> --no-
>>>> mode-check-
>>>>
>>>> I am not completely confident with the wrapper-magic, but shouldn't
>>>> libcopperplate use either cobalt_malloc or the libc malloc?
>>>> __real_malloc is just a stub for libc malloc, so I really don't get
>>>> the point (assuming this is intentional).
>>>>
>>>> Modeswitches could also be detected by interposing libraries, so
>>>> removing libmodechk Is a viable thing to do.
>>>> (shameless plug: https://github.com/nolange/preload_checkers )
>>>>
>>>>
>>>> Regards, Norbert
>>> ________________________________
>>>
>>> This message and any attachments are solely for the use of the intended
>> recipients. They may contain privileged and/or confidential information or
>> other information protected from disclosure. If you are not an intended
>> recipient, you are hereby notified that you received this email in error and
>> that any review, dissemination, distribution or copying of this email and any
>> attachment is strictly prohibited. If you have received this email in error,
>> please contact the sender and delete the message and any attachment from
>> your system.
>>>
>>> ANDRITZ HYDRO GmbH
>>>
>>>
>>> Rechtsform/ Legal form: Gesellschaft mit beschränkter Haftung /
>>> Corporation
>>>
>>> Firmensitz/ Registered seat: Wien
>>>
>>> Firmenbuchgericht/ Court of registry: Handelsgericht Wien
>>>
>>> Firmenbuchnummer/ Company registration: FN 61833 g
>>>
>>> DVR: 0605077
>>>
>>> UID-Nr.: ATU14756806
>>>
>>>
>>> Thank You
>>> ________________________________
>>> -------------- next part -------------- A non-text attachment was
>>> scrubbed...
>>> Name: 0001-remove-__STD-for-heap-function.patch
>>> Type: application/octet-stream
>>> Size: 5265 bytes
>>> Desc: 0001-remove-__STD-for-heap-function.patch
>>> URL:
>>>
>> <http://xenomai.org/pipermail/xenomai/attachments/20190531/6c808169/a
>> t
>>> tachment.obj>
>>
>> --
>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate
>> Competence Center Embedded Linux
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

