Subject: Re: dovetail vs. ipipe: COW-breaking in copy_pte_range
References: <3df057f7-cab7-4886-ed46-12084157eb45@siemens.com>
 <87y2jx86rw.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d3a675fd-f35f-9f1a-1d87-d5e5ca7d6185@siemens.com>
Date: Fri, 23 Oct 2020 14:36:39 +0200
MIME-Version: 1.0
In-Reply-To: <87y2jx86rw.fsf@xenomai.org>
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

On 23.10.20 14:29, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> Hi Philippe,
>>
>> a merge conflict in 5.4-stable requires me to look into [1]. It states:
>>
>>>     Revisit: Further COW breaking in copy_user_page() and copy_pte_range()
>>>     may be useless once __ipipe_disable_ondemand_mappings() has run for a
>>>     co-kernel task, since all of its mappings have been populated, and
>>>     unCOWed if applicable.
>>
>> And if I look into the dovetail baseline commit, this logic is indeed
>> gone. Did you revisit this and came to the conclusion that it can safely
>> be dropped? Or did it take other changes in dovetail to make it
>> obsolete? Would help to resolve [2] if we could simply drop it...
>>
> 
> I dropped it from Dovetail because mlock already breaks COW for private
> mappings, shared ones cannot be COWed, so I don't see any reason to
> enforce this again.
> 

Were we always overly cautious with this in I-pipe, or did anything
change along the kernels or nucleuses? I'm asking as I will have to
write some good removal commit log for 4.19 as the merge conflict will
bite us there as well.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

