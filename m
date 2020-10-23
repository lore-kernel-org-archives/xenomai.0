References: <3df057f7-cab7-4886-ed46-12084157eb45@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: dovetail vs. ipipe: COW-breaking in copy_pte_range
In-reply-to: <3df057f7-cab7-4886-ed46-12084157eb45@siemens.com>
Date: Fri, 23 Oct 2020 14:29:39 +0200
Message-ID: <87y2jx86rw.fsf@xenomai.org>
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
Cc: Xenomai <xenomai@xenomai.org>, "Meng, Fino" <fino.meng@intel.com>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> a merge conflict in 5.4-stable requires me to look into [1]. It states:
>
>>     Revisit: Further COW breaking in copy_user_page() and copy_pte_range()
>>     may be useless once __ipipe_disable_ondemand_mappings() has run for a
>>     co-kernel task, since all of its mappings have been populated, and
>>     unCOWed if applicable.
>
> And if I look into the dovetail baseline commit, this logic is indeed
> gone. Did you revisit this and came to the conclusion that it can safely
> be dropped? Or did it take other changes in dovetail to make it
> obsolete? Would help to resolve [2] if we could simply drop it...
>

I dropped it from Dovetail because mlock already breaks COW for private
mappings, shared ones cannot be COWed, so I don't see any reason to
enforce this again.

-- 
Philippe.

