References: <E1fxEEU-0004LE-Ln@xenomai.org>
 <7bf36155-eb1a-30a3-42ce-5256342dc74f@siemens.com>
 <32880d1f-2a02-57bd-3465-9ebb0aee9aca@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ebaacf7c-5fa5-1f5d-791e-6c4e01617303@siemens.com>
Date: Wed, 5 Sep 2018 10:34:48 +0200
MIME-Version: 1.0
In-Reply-To: <32880d1f-2a02-57bd-3465-9ebb0aee9aca@xenomai.org>
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

On 2018-09-05 10:16, Philippe Gerum wrote:
> On 09/04/2018 07:48 PM, Jan Kiszka wrote:
>>> diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
>>> index 7773a08e5..32df635a8 100644
>>> --- a/kernel/cobalt/synch.c
>>> +++ b/kernel/cobalt/synch.c
>>> @@ -902,7 +902,7 @@ void xnsynch_release_all_ownerships(struct
>>> xnthread *thread)
>>>    }
>>>    EXPORT_SYMBOL_GPL(xnsynch_release_all_ownerships);
>>>    -#if XENO_DEBUG(MUTEX_RELAXED)
>>> +#ifdef CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED
>>>      /*
>>>     * Detect when a thread is about to sleep on a synchronization
>>>
>>
>> Confused: This is not for next, is it?
>>
>> E.g. that hunk above does not apply there anymore, for about a year...
>>
> 
> Something looks wrong here. The three patches apply on commit #e23d58715
> [1] at [2], which is on top of stable/v3.0.x, post-3.0.7 material. Which
> tree/branch are you looking at?

next - stable is yours.

If you like review of stable backports, please tag those commits as 
[stable] or so. And maybe also explain any deviation.

My vision would be that only patches that are in next/master would make 
it to stable. Ideally, no or only minor tweaking should be needed to 
such commits for the backport.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

