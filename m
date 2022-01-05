Message-ID: <862d5aa6-5e08-f33c-84d9-4ab98f0c6b29@siemens.com>
Date: Wed, 5 Jan 2022 17:13:36 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 0/7] y2038: cond_wait_prologue64 and related fixes
Content-Language: en-US
References: <20220105140650.1033850-1-florian.bezdeka@siemens.com>
 <13d8cb9c-591d-481a-73b6-623b892deea0@siemens.com>
 <c53158602ef5d92c35dade7e66e34fcbafaa333c.camel@siemens.com>
 <e5af2c61-57be-55c6-4c03-e9b4670fa5fb@siemens.com>
 <034ac263dbb354ed8af7b575b0e884d97f8968c8.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <034ac263dbb354ed8af7b575b0e884d97f8968c8.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian (T CED SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05.01.22 16:08, Bezdeka, Florian (T CED SES-DE) wrote:
> On Wed, 2022-01-05 at 15:58 +0100, Jan Kiszka wrote:
>> On 05.01.22 15:56, Bezdeka, Florian (T CED SES-DE) wrote:
>>> On Wed, 2022-01-05 at 15:43 +0100, Jan Kiszka wrote:
>>>> On 05.01.22 15:06, Florian Bezdeka wrote:
>>>>> Hi all,
>>>>>
>>>>> this is the last missing POSIX related y2038 affected syscall in
>>>>> Xenomai. With this applied we have two Xenomai specific syscalls
>>>>> missing:
>>>>>
>>>>>   - sc_cobalt_thread_setschedparam_ex
>>>>>   - sc_cobalt_thread_getschedparam_ex
>>>>>
>>>>> While adding tests for the introduced cond_wait_prologue64 I hit a
>>>>> kernel OOPS due to insuficient validation of user provided pointers.
>>>>> That has been addressed as well.
>>>>
>>>> Thanks for both! Is it possibly to move the fixes the front? That would
>>>> also ensure that I can easily pick them into stable.
>>>
>>> Yes. Patch 4 and 7 could be moved to the front easily. Do you want me
>>> to split patch 2 into the y2038 and non y2038 part, or does that not
>>> qualify for stable at all?
>>
>> Can I reorder things myself, or does patch 4 break (patch 7 does not,
>> already checked)? Then I just change the application order while doing
>> git am.
> 
> No breakage expected. The only "problematic" one would be patch 2 as it
> touches y2038 as well as non-y2038 syscall definitions. Let me know if
> I should split that into two parts (which would allow the non y2038
> related cleanup to be applied to stable separately)

The annotation patch is not needed for stable.

I'm applying now 4 7 1 2 3 5 6 and will kick off testing.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

