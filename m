Subject: Re: dovetail vs. ipipe: COW-breaking in copy_pte_range
References: <3df057f7-cab7-4886-ed46-12084157eb45@siemens.com>
 <87y2jx86rw.fsf@xenomai.org>
 <d3a675fd-f35f-9f1a-1d87-d5e5ca7d6185@siemens.com>
 <87y2jx3uro.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0e954ac7-b8fd-52c2-e1fc-4e509f940b77@siemens.com>
Date: Fri, 23 Oct 2020 16:19:39 +0200
MIME-Version: 1.0
In-Reply-To: <87y2jx3uro.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>, "Meng, Fino" <fino.meng@intel.com>

On 23.10.20 16:02, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 23.10.20 14:29, Philippe Gerum wrote:
>>>
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> Hi Philippe,
>>>>
>>>> a merge conflict in 5.4-stable requires me to look into [1]. It states:
>>>>
>>>>>     Revisit: Further COW breaking in copy_user_page() and copy_pte_range()
>>>>>     may be useless once __ipipe_disable_ondemand_mappings() has run for a
>>>>>     co-kernel task, since all of its mappings have been populated, and
>>>>>     unCOWed if applicable.
>>>>
>>>> And if I look into the dovetail baseline commit, this logic is indeed
>>>> gone. Did you revisit this and came to the conclusion that it can safely
>>>> be dropped? Or did it take other changes in dovetail to make it
>>>> obsolete? Would help to resolve [2] if we could simply drop it...
>>>>
>>>
>>> I dropped it from Dovetail because mlock already breaks COW for private
>>> mappings, shared ones cannot be COWed, so I don't see any reason to
>>> enforce this again.
>>>
>>
>> Were we always overly cautious with this in I-pipe, or did anything
>> change along the kernels or nucleuses? I'm asking as I will have to
>> write some good removal commit log for 4.19 as the merge conflict will
>> bite us there as well.
>>
> 
> We may expect mlock() to:
> 
> 1- commit the data from any backing store to RAM
> 2- break COW if present
> 3- populate the PTEs
> 
> The hack from copy_pte_range() dates back to 2006 or so. IIRC, the
> reason was to ensure that any mapping duplicated from a parent process
> which has pinned its memory via an earlier call to
> __ipipe_disable_ondemand_mappings() would be immediately un-COWed upon
> fork() in the child process. On second thoughts, this is useless since
> the child process either:
> 
> - if it has to, explicitly attaches to the real-time core, which ends up
>   calling mlock(), therefore causing these mappings to be un-COWed if
>   need be. IOW, there is no inheritance of the Cobalt context at
>   fork. Maybe at some point in time there was the assumption that such
>   context might be shared between both processes somehow, which has been
>   ruled out later on.
> 
> - the child process does not attach to the real-time core, in which case
>   COW is a non-issue.
> 
> The reason to still have __ipipe_disable_ondemand_mappings() or
> force_commit_memory() is to make sure (3) actually happens for all
> regular pages the caller may use, which may not always be the case with
> mlock() (we need all these pages to be actually faulted in so that a
> minor fault is emulated via handle_mm_fault() right away). However, (1)
> and (2) are fully covered by mlock() already.
> 
> Executive summary: using belt and suspenders may be ok for peace of
> mind, but still slightly overkill on a diving suit.
> 

Makes perfect sense, thanks a lot. Will use that for a 4.19 commit and
drop it from 5.4 from the beginning.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

