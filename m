References: <5283f8ff-33bf-910d-25b5-044ea6a963ae@siemens.com>
 <87a6iepm0x.fsf@xenomai.org>
 <f636f600-cf0f-54fd-149d-003fc2d10c28@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: dovetail: add prctl() call form
Date: Tue, 09 Nov 2021 11:23:17 +0100
In-reply-to: <f636f600-cf0f-54fd-149d-003fc2d10c28@siemens.com>
Message-ID: <871r3ppq5w.fsf@xenomai.org>
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
Cc: Xenomai <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 08.11.21 18:57, Philippe Gerum wrote:
>> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> Hi Philippe,
>>>
>>> this dovetail commit makes the pipeline go red, crashing the kernels
>>> (e.g. [1][2]). I hope this is something we can quickly fix in dovetail,
>>> maybe via a config option?
>>>
>>> Jan
>>>
>>> [1] https://source.denx.de/Xenomai/xenomai-images/-/jobs/348118#L966
>>> [2] https://source.denx.de/Xenomai/xenomai-images/-/jobs/348121#L1429
>> 
>> Cobalt needs some update to cope with this now. I'll send a fix either
>> way (dovetail or xenomai) tomorrow morning.
>
> This should be fixed in dovetail - API breakage. We can update Xenomai
> later, along with enabling this feature again.
>

We now have a change in the Dovetail tree which handles the fact that
some Dovetail-based core might lag behind a bit API-wise regarding the
new prctl-based call form. Since this simplifies the handling for any
companion core in that particular case, this seems legitimate to add
it. Tested on kvm-x86, -aarch64, and i.MX6-sabre with both Cobalt and
EVL cores. Both test suites run properly, so far so good.

However, please note that kernel API stability is not guaranteed by
Dovetail in general in the upstream tree. The reasons not to guarantee
that are well known and documented. I'll do my very best not to break it
mindlessly, I can make it easier to cope with such changes with config
switches, but do not expect it to be stable over time. Any change which
may introduce such breakage will be pushed to the mailing list first.

-- 
Philippe.

