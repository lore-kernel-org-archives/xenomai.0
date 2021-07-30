Subject: Re: [PATCH] cobalt/posix/mutex: Harmonize pthread_mutex_timedlock()
 and sem_timedwait()
References: <20210729144707.58398-1-florian.bezdeka@siemens.com>
 <87k0l95fdy.fsf@xenomai.org>
 <b98d9a35-a57e-6850-db78-78f82e7031a3@siemens.com>
 <7d60072faa0e9f1d38b3047d92a672c502bc7d2a.camel@siemens.com>
 <046b0330-607f-4ec9-0a64-5f640747e05a@siemens.com>
 <27cab8ba0a03e759cc5c378c11a2ba0d59da4176.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f1bb7231-92cc-d488-da90-80bdc09a5892@siemens.com>
Date: Fri, 30 Jul 2021 10:13:28 +0200
MIME-Version: 1.0
In-Reply-To: <27cab8ba0a03e759cc5c378c11a2ba0d59da4176.camel@siemens.com>
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
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "rpm@xenomai.org" <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "chensong_2000@189.cn" <chensong_2000@189.cn>

On 30.07.21 09:14, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> On Thu, 2021-07-29 at 19:29 +0200, Jan Kiszka wrote:
>> On 29.07.21 18:22, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
>>> On Thu, 2021-07-29 at 17:45 +0200, Jan Kiszka wrote:
>>>> On 29.07.21 17:06, Philippe Gerum wrote:
>>>>>
>>>>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>>>>
>>>>>> According to the POSIX spec the value of the timeout parameter needs
>>>>>> not to be validated if the mutex/semaphore could be taken immediately.
>>>>>>
>>>>>> While the implementation of the semaphore timedwait (sem_timedwait())
>>>>>> allowed an invalid timeout pthread_mutex_timedlock() was failing with
>>>>>> -EFAULT in case the mutex could be taken immediately.
>>>>>>
>>>>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>>> ---
>>>>>>
>>>>>> This was detected while preparing y2038 stuff. Not sure if that should
>>>>>> go into 3.2. Comments welcome...
>>>>>>
>>>>>
>>>>> upsides: save a few cycles in the non-contended case by not copying in
>>>>> the timeout from userland uselessly + might help passing some picky
>>>>> POSIX compliance tests.
>>>>>
>>>>> downside: adds an extra atomic op in the contended case.
>>>>>
>>>>
>>>> How do we compare to libc implementations here?
>>>
>>> I changed the validation done on cobalt side, not libcobalt. So what
>>> exactly do you mean?
>>>
>>
>> Indeed, I was looking for the fast or almost fast paths in userspace.
>>
>> But now I'm confused: The uncontended case is generally not supposed to
>> trigger a syscall. That is always the slow path anyway, e.g. because ned
>> to migrated first (likely how you were able to trigger the issue?).
> 
> The fast-path was always fine, that is right. But please note that
> depending on the kernel configuration (especially with
> CONFIG_XENO_OPT_DEBUG_MUTEX_SLEEP enabled) we will always be forced
> into the slow-path.
> 
> So we had another imbalance depending on the kernel configuration.
> 

OK, I just wanted to understand whether that single atomic more is an
issue - it's not at all, we are slow already at that point.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

