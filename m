Message-ID: <f45934df5baec3a570da12209565f49f.squirrel@127.0.0.1>
In-Reply-To: <5215C1D1.1020707@siemens.com>
References: <52147CD7.70400@siemens.com> <52147DF2.8060407@xenomai.org>
	<52147E94.6070309@siemens.com> <5214802B.9060001@siemens.com>
	<5214A55E.2070902@xenomai.org> <5214A886.30608@siemens.com>
	<5214A941.6070302@xenomai.org> <5214AA25.5070500@siemens.com>
	<5214AB5F.7050302@xenomai.org> <5214C300.40205@siemens.com>
	<5215059B.7020309@xenomai.org> <5215C1D1.1020707@siemens.com>
Date: Thu, 22 Aug 2013 11:37:41 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [RFC] x86 port to kernel 3.10
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>


Jan Kiszka wrote:
>>> 2. How to deal with conflicts during the merge that affect architecture
>>>    that the merger is not (immediately or at all) testing?
>>>     - commit them unresolved and commit resolutions on top?
>>>     - resolve them as good as possible and leave the review/fix-up to
>>>       the respective arch maintainer?
>>>
>>> I don't see other options for 2. at this moment.
>>
>> What I say, is that the two answers you propose to question 2 result in
>> a series of commit which can not be bisected.
>
> s/cannot/may not/. The current one is likely not bisectable due to the
> 3.9 merge of Philippe which left some unresolved conflicts behind. But
> if we resolve conflicts for all arches during the mege, there is a good
> chance that early parts of the merge are still working and that later
> parts can be made working more easily (e.g. by temporarily applying
> fix-ups from the head) if bisection is required.

In my experience, with the ARM architecture, the result of the merge,
however trivial, does not work, additional work is needed.

>
>> With 2.1, you are warned
>> at compilation time, because the unbisectable commits do not compile,
>> with 2.2 you have to test the kernel to realize that it is not working.
>
> With complex tree, you generally also have to fix-up bisection points in
> order to make them work. The question is, how much work that is.

With the ARM architecture evolution pace having increased lately, this is
the major part of the work of porting the I-pipe patch from one kernel to
the next.

>
>>
>> So, the only possibility to have a fully bisectable hisotry would be to
>> somehow handle all architectures at once, whether with one, or several
>> commits.
>>
>> The result being that the new approach results in a bisectable kernel
>> only for one architecture, and greatly complicates the merge of the
>> other architectures, I am wondering about the benefits of this new
>> approach.
>>
>
> I don't see yet what complicates the merge of other archs that much.
> Look at the merge commits that had conflicts on ARM (e.g. git log
> --first-parent -p -c master..next-x86 arch/arm) and review the
> resolutions. Many of them will likely be correct, so you no longer have
> to do this job yourself. And the number of conflicts is not much higher
> than when doing a single merge, it's just spread over several commits.

Because having one set of diffs is simpler than having to skim through
several commits. Also, I want to do the merge myself, because my memory
is associative, and when I see a bug when testing the result of the merge,
which never works out of the box, it may remind me of a merge that could be
the cause of the bug. Having not done the merge myself will make the debug
harder, I will have to discover what I could already know.

So, please commit the merge conflicts and let me resolve them. There is no
perfect solution, let us take the one which does not make the job too hard.

-- 
                                              Gilles


