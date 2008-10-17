Message-ID: <48F88A37.7050509@domain.hid>
Date: Fri, 17 Oct 2008 14:51:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081016154620.320953568@domain.hid>
	<48F884EE.2030801@domain.hid> <48F888A2.7010404@domain.hid>
In-Reply-To: <48F888A2.7010404@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 00/12] Generic fast xnsynch support & more
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Here comes a significantly reworked patch series to improve fast mutex
>>> support of Xenomai.
>>>
>>> This approach now introduces a generic fast xnsynch core and converts
>>> the existing POSIX implementation over. It also comes with a second
>>> user, the Native skin. Additionally, it improves xeno_get_current via
>>> a TLS variable and addresses the issue that threads in secondary mode
>>> acquiring an uncontended mutex need to be migrated first.
>>>
>>> At this chance, the TLS optimization is also applied on self-lookups of
>>> task handles (Native, VRTX and VxWorks). And I included my
>>> SMP-by-default patch for user libs which is highly recommended to reduce
>>> the risk of accidental code breakage on SMP with the new mutex code.
>> A minor remark. This is the third round of patches for fast mutexes, and
>>  each round, you submit even more changes to review than the previous
>> round. If I doubted of your honesty, I could think that you are trying
>> to dilute some questionable changes into more changes so that they get
>> unnoticed.
> 
> May I recall the changelog of this round? In short:
> 
>  - generic xnsynch
>  - fixed prio-inversion when coming from secondary mode
> 
> These are major changes, addressing specifically the NACKs of the
> previous rounds.
> 
> If you find "questionable changes", please point them out. So far I only
> recall the discussion about lockcnt maintenance policy, and I will try
> to sort that one out.

The problem is that it took me about one hour reviewing your 12 patches
(I know, I am a slow guy), and that I am not even sure that I saw all
the changes.

The lockcnt change in patch 8 for instance is not even mentioned in the
patch comments, and it is only because I originally did not understand
the change in rt_cond_wait_inner that I now know about this change.

> 
>> Could we focus on a small set of changes, reach consensus, merge them,
>> and then move to the next set of changes?
> 
> No problem. Maybe I missed or forgot the clear OK for patches 1..4 to
> commit them, but I will now soon. Moreover, I just felt uncomfortable
> with merging patch 5 without having written to following ones.

I think Philippe should merge the patches.

-- 
                                                 Gilles.

