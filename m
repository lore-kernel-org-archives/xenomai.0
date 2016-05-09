References: <5730DF08.8080309@siemens.com> <5730E228.3010306@siemens.com>
 <5730E382.6070505@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5730E49D.2080807@siemens.com>
Date: Mon, 9 May 2016 21:27:25 +0200
MIME-Version: 1.0
In-Reply-To: <5730E382.6070505@xenomai.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Prio ceiling mutex issues
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2016-05-09 21:22, Philippe Gerum wrote:
> On 05/09/2016 09:16 PM, Jan Kiszka wrote:
>> On 2016-05-09 21:03, Jan Kiszka wrote:
>>> Hi Philippe,
>>>
>>> we ran into at least one bug of the current prio ceiling support for
>>> synch objects: on xnsynch_release, we only reschedule if we woken up a
>>> new owner. But we also have to reschedule after dropping the ceiling
>>> prio as some higher prio thread may be waiting.
>>>
>>> For that, I would propose to alter the return type and semantic of
>>> xnsynch_release from "pointer to new owner" into "bool, true if
>>> reschedule is needed". It seems, no caller of xnsynch_release makes a
>>> non-boolean use of the return value anyway. And then we can simply
>>> return true on "synch->status & XNSYNCH_PP".
>>>
>>> That leads to the question what would happen in the fast case. Consider
>>>
>>> pthread_mutex_lock(ceiling_mutex);
>>> wake_up_thread(some_thread); // caller_prio < target_prio < ceiling_prio
>>> pthread_mutex_unlock(ceiling_mutex);
>>>
>>> To my current understanding, there is nothing enforcing a syscall for
>>> the unlock caller if some thread woke up after the lock, thus may have a
>>> high prio after the unlock. Or am I missing something?
>>
>> OK, I think I got it: When we found a reason to reschedule after taking
>> such a ceiling lock lazily, we commit the prio-boost and enforce the
>> kernel exit on release via xnsynch_fast_ceiling in commit_ceiling,
>> right?
> 
> Correct (at the very least this is the intent of the implementation).
> 

Good... I pushed the two patches I have in mind, but both lack testing
beyond "builds for me". I will let them run to our scenario tomorrow
unless you see a problem.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

