References: <CO6PR11MB56493CA60ADCFBEFC2670FF3BA749@CO6PR11MB5649.namprd11.prod.outlook.com>
 <87pmz5nu08.fsf@xenomai.org>
 <fd783792-f2ee-c18d-7836-26221b10195a@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Xenomai Community Call Minutes - April 7, 2021
In-reply-to: <fd783792-f2ee-c18d-7836-26221b10195a@siemens.com>
Date: Thu, 08 Apr 2021 09:21:07 +0200
Message-ID: <87h7khnsws.fsf@xenomai.org>
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
Cc: "Wang, Rick Y via Xenomai" <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 08.04.21 08:57, Philippe Gerum via Xenomai wrote:
>> 
>> Hello Rick,
>> 
>> At what time did that meeting take place yesterday? I tried to connect
>> several times to the usual 'teams' room from 7:55 to 8:10, but nobody
>> was there.
>
> CEST mess: The meeting moved to 9am our time due to daylight saving.
>

Mmf, ok.

> Jan
>
>> 
>> Wang, Rick Y via Xenomai <xenomai@xenomai.org> writes:
>> 
>>> Attendees:
>>>
>>> Jan Kiszka, Florian Bezdeka, Florent Pirou, Hongzhan Chen,
>>> Dao Zhang, Jianbo Cao, Yanfeng Pu, Rick Wang
>>>
>>>
>>> *Community update
>>>
>>> - No code change in the past two weeks
>>> - Greg is debugging jitter issue on ARM.
>>> - Siemens is testing WIP-Dovetail branch internally. Some issues were
>>> reported related to clock source or gdb crash.
>>> - Jan will log the issues to gitlab Xenomai hacker space:
>>> https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues
>>> - For Xenomai 3.2, there are some submitted patches pending on Jan's review
>>> and merge. Also some patches in Philippe's private tree are pending on
>>> submission.
>>> - Florian and Song are working on Y2038 issue on Philippe's tree. It depends
>>> on some Dovetail codes to be merged first.
>>> - Hongzhan is working on latmus GPIO porting. 5.10 Dovetail-based Xenomai
>>> and EVL can't boot up on his dev board yet. 5.9 kernel can boot on the
>>> same board. It could be related to clock source and ACPI changes in kernel.
>>>
>>>
>>>
>>> Thanks,
>>> Rick
>> 
>> 


-- 
Philippe.

