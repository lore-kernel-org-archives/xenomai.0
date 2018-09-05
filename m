References: <E1fxEEU-0004LE-Ln@xenomai.org>
 <7bf36155-eb1a-30a3-42ce-5256342dc74f@siemens.com>
 <32880d1f-2a02-57bd-3465-9ebb0aee9aca@xenomai.org>
 <ebaacf7c-5fa5-1f5d-791e-6c4e01617303@siemens.com>
 <e9af2ce8-1fc2-4fc5-d4fd-04ca030ffc49@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8ff02c03-6cdf-10ab-0eb8-98edfcf9ffe5@siemens.com>
Date: Wed, 5 Sep 2018 11:44:15 +0200
MIME-Version: 1.0
In-Reply-To: <e9af2ce8-1fc2-4fc5-d4fd-04ca030ffc49@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [PATCH] cobalt/kernel: always use explicit
 preprocessor conditionals
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 2018-09-05 11:33, Philippe Gerum wrote:
> On 09/05/2018 10:34 AM, Jan Kiszka wrote:
>> On 2018-09-05 10:16, Philippe Gerum wrote:
>>> On 09/04/2018 07:48 PM, Jan Kiszka wrote:
>>>>> diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
>>>>> index 7773a08e5..32df635a8 100644
>>>>> --- a/kernel/cobalt/synch.c
>>>>> +++ b/kernel/cobalt/synch.c
>>>>> @@ -902,7 +902,7 @@ void xnsynch_release_all_ownerships(struct
>>>>> xnthread *thread)
>>>>>     }
>>>>>     EXPORT_SYMBOL_GPL(xnsynch_release_all_ownerships);
>>>>>     -#if XENO_DEBUG(MUTEX_RELAXED)
>>>>> +#ifdef CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED
>>>>>       /*
>>>>>      * Detect when a thread is about to sleep on a synchronization
>>>>>
>>>>
>>>> Confused: This is not for next, is it?
>>>>
>>>> E.g. that hunk above does not apply there anymore, for about a year...
>>>>
>>>
>>> Something looks wrong here. The three patches apply on commit #e23d58715
>>> [1] at [2], which is on top of stable/v3.0.x, post-3.0.7 material. Which
>>> tree/branch are you looking at?
>>
>> next - stable is yours.
>>
> 
> Is it? Ok, for now, until a -stable maintainer is appointed eventually.
> 
>> If you like review of stable backports, please tag those commits as
>> [stable] or so. And maybe also explain any deviation.
>>
> 
> The way -stable was used is obviously different in the new process, and
> the patches were consistent with the previous process, so let's drop
> those patches if you can't review them, I'll rebase over the upcoming
> -next branch to make it easier for everyone.
> 
>> My vision would be that only patches that are in next/master would make
>> it to stable.
> 
> I understand that you want to align with the basics of the mainline
> kernel workflow, I'm ok with this. Please set (or re-purpose) the
> (existing) git branches on gitlab the way you want to, to clarify the
> situation.
> 
>   Ideally, no or only minor tweaking should be needed to
>> such commits for the backport.
>>
> 
> This should be ok in most cases. Unfortunately, the XENO_DEBUG() fixes
> are going to be an exception because they have to spread all over the
> map - unless they don't go to stable, which could be an issue since the
> corresponding bug may produce bad kernels.
> 

It seems we addressed most of the XENO_DEBUG cases in next. Are the 
related commits no stable candidates because they do more? If they are, 
I would start with backporting them, and then address what remains.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

