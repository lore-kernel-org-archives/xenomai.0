References: <E1aJQEe-0006t5-UO@sd-51317.xenomai.org>
 <56969AF7.6040505@xenomai.org> <5696A8BE.7070907@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56976051.2070201@xenomai.org>
Date: Thu, 14 Jan 2016 09:46:09 +0100
MIME-Version: 1.0
In-Reply-To: <5696A8BE.7070907@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Fix
 invalidation of cond shadow
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On 01/13/2016 08:42 PM, Jan Kiszka wrote:
> On 2016-01-13 19:44, Philippe Gerum wrote:
>> On 01/13/2016 07:33 PM, git repository hosting wrote:
>>> Module: xenomai-jki
>>> Branch: for-forge
>>> Commit: b7d37dab571df0c0cd42aae094c3d5d1bc71db80
>>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=b7d37dab571df0c0cd42aae094c3d5d1bc71db80
>>>
>>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>>> Date:   Wed Jan 13 19:31:23 2016 +0100
>>>
>>> cobalt/kernel: Fix invalidation of cond shadow
>>>
>>> pthread_cond_destroy fails to invalidate also the shadow object. This
>>> can cause spurious -EBUSY errors on re-initialization of the very same
>>> shadow as condition variable later on.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> ---
>>>
>>>  kernel/cobalt/posix/cond.c |    2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/kernel/cobalt/posix/cond.c b/kernel/cobalt/posix/cond.c
>>> index 7e115cf..84ae8fd 100644
>>> --- a/kernel/cobalt/posix/cond.c
>>> +++ b/kernel/cobalt/posix/cond.c
>>> @@ -117,6 +117,8 @@ static inline int pthread_cond_destroy(struct cobalt_cond_shadow *cnd)
>>>  
>>>  	cobalt_cond_reclaim(&cond->resnode, s); /* drops lock */
>>>  
>>> +	cobalt_mark_deleted(cnd);
>>> +
>>>  	return 0;
>>>  }
>>>  
>>>
>>
>> cobalt_cond_reclaim() invalidates the shadow object already. Did you
> 
> Nope, it only invalidates cond->magic, i.e. the object itself. We also
> need to invalidate cnd->magic here. See also mutex.c, it has the same
> pattern.
> 

Ack, I misread the patch. This is a regression compared to 2.x, we need
both descriptors to be invalidated indeed.

-- 
Philippe.

