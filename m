Subject: Re: [RFC PATCH v2 1/4] y2038: Fixing the sem_timedwait syscall for 32
 bit systems
References: <87h7lqzzzw.fsf@xenomai.org>
 <20210308170206.313181-1-florian.bezdeka@siemens.com>
 <20210308170206.313181-2-florian.bezdeka@siemens.com>
 <95879ecb-09d5-79b4-34a3-91d3ca58bd0f@siemens.com>
 <e3b758642ba1ee6d8c4b459c2b476155194205bf.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <73957ba4-d06a-49c2-e6c0-0d43c8890632@siemens.com>
Date: Mon, 8 Mar 2021 19:22:42 +0100
MIME-Version: 1.0
In-Reply-To: <e3b758642ba1ee6d8c4b459c2b476155194205bf.camel@siemens.com>
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
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "rpm@xenomai.org" <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "chensong@kylinos.cn" <chensong@kylinos.cn>

On 08.03.21 19:11, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> On Mon, 2021-03-08 at 18:12 +0100, Jan Kiszka wrote:
>> On 08.03.21 18:02, Florian Bezdeka wrote:
>>> On systems using 32 bit for time_t the sem_timedwait syscall was broken
>>> because the function used for copying the timeout value from userspace
>>> to kernel (=sem_fetch_timeout()) was always copying
>>> sizeof(struct timespec64).
>>>
>>> A 32 bit application (or more specific an application with 4 byte
>>> time_t) would only provide sizeof(struct old_timespec32).
>>>
>>> Notable changes:
>>>   - The copy operation from userspace to kernel is now already done in
>>>     the syscall handler. So it is always done. Previously it was copied
>>>     over and validated before the first use (when used at all).
>>>     So we have some additional instructions now that may be
>>>     unnecessary, but that simplifies the code.
>>>
>>>   - Validation: Switched to timespec64_valid() instead of our own
>>>     check.
>>>
>>> Fixes: 8043eccd232d ("cobalt/kernel: y2038: convert struct timespec to timespec64")
>>
>> This patch was dropped from next again (and that sha was never applied).
>> We should go a for fixed version of that series (patches 2..5, only
>> patch 1 is now applied).
> 
> That's one of the things that may happen when working with branches
> that are getting rebased... The correct refspec is maybe 4d31feb5 now,
> which is part of wip/dovetail.

All these are development branches, nothing considered stable. And, no,
even wip/dovetail is the wrong target. The right one is the patch that
needs to be fixed in v2 of Philippe's series.

> 
> Please note the RFC tag. Would be nice to get some feedback before
> going ahead, otherwise the loops with all the necessary synchronization
> and rebases is getting endless...

For this particular patch, Philippe should comment first.
I will have a look at the rest now.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

