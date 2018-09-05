References: <E1fxEEU-0004LE-Ln@xenomai.org>
 <7bf36155-eb1a-30a3-42ce-5256342dc74f@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <32880d1f-2a02-57bd-3465-9ebb0aee9aca@xenomai.org>
Date: Wed, 5 Sep 2018 10:16:13 +0200
MIME-Version: 1.0
In-Reply-To: <7bf36155-eb1a-30a3-42ce-5256342dc74f@siemens.com>
Content-Type: text/plain; charset="utf-8"
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 09/04/2018 07:48 PM, Jan Kiszka wrote:
>> diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
>> index 7773a08e5..32df635a8 100644
>> --- a/kernel/cobalt/synch.c
>> +++ b/kernel/cobalt/synch.c
>> @@ -902,7 +902,7 @@ void xnsynch_release_all_ownerships(struct
>> xnthread *thread)
>>   }
>>   EXPORT_SYMBOL_GPL(xnsynch_release_all_ownerships);
>>   -#if XENO_DEBUG(MUTEX_RELAXED)
>> +#ifdef CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED
>>     /*
>>    * Detect when a thread is about to sleep on a synchronization
>>
> 
> Confused: This is not for next, is it?
> 
> E.g. that hunk above does not apply there anymore, for about a year...
> 

Something looks wrong here. The three patches apply on commit #e23d58715
[1] at [2], which is on top of stable/v3.0.x, post-3.0.7 material. Which
tree/branch are you looking at?


[1]
commit e23d587156f138a8f9bff648e310427127a98cfc (origin/stable/v3.0.x)
Author: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Date:   Thu Aug 16 21:10:00 2018 +0200

    net: Split internal rtnet.h and install rtdm/net.h and rtdm/uapi/net.h

    For external projects wanting to use RTnet with its special
    features like RTnet IOCTLs it is necessary to provide the API
    headers in the Xenomai installation directory.

[2] https://gitlab.denx.de/Xenomai/xenomai/commits/stable/v3.0.x

-- 
Philippe.

