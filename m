Message-ID: <52C0644A.9080108@xenomai.org>
Date: Sun, 29 Dec 2013 19:04:58 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <52AEB440.5090103@xenomai.org> <52AF2686.7010907@xenomai.org>
 <52AF26C1.1060300@xenomai.org> <52AF2BDF.9000801@xenomai.org>
 <52AF2C6E.8010701@xenomai.org> <52AF2ED5.8070503@xenomai.org>
 <52C02780.2050104@xenomai.org>
In-Reply-To: <52C02780.2050104@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rehashing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 12/29/2013 02:45 PM, Gilles Chanteperdrix wrote:
> On 12/16/2013 05:48 PM, Philippe Gerum wrote:
>> On 12/16/2013 05:38 PM, Gilles Chanteperdrix wrote:
>>> On 12/16/2013 05:35 PM, Philippe Gerum wrote:
>>>> On 12/16/2013 05:13 PM, Gilles Chanteperdrix wrote:
>>>>> On 12/16/2013 05:12 PM, Philippe Gerum wrote:
>>>>>> On 12/16/2013 09:05 AM, Gilles Chanteperdrix wrote:
>>>>>>>
>>>>>>> Hi Philippe,
>>>>>>>
>>>>>>> looking at the registry code, I had an idea: we could increase the
>>>>>>> number of descriptors dynamically when they are exhausted, and
>>>>>>> increase
>>>>>>> the hash size as well. This would make the configurable number of
>>>>>>> slots
>>>>>>> a starting point, but not a liimit. The access to the registry by name
>>>>>>> does not really need to be fast, so we could protect it with a mutex
>>>>>>
>>>>>> The registry hash is a low contention resource, so using a dedicated
>>>>>> mutex is likely more efficient than grabbing the big nklock in most
>>>>>> cases anyway.
>>>>>>
>>>>>>> (that would mean that all services accessing the registry by name
>>>>>>> would
>>>>>>> need to run in secondary mode, but I am not sure we care, and if we
>>>>>>> do,
>>>>>>> we can use an xnsynch instead).
>>>>>>>
>>>>>>> What do you think?
>>>>>>>
>>>>>>
>>>>>> Recent Cobalt users of the registry put aside, this is basically about
>>>>>> deciding whether:
>>>>>>
>>>>>> - issuing connect() on a rtipc socket should switch the caller to
>>>>>> secondary mode, since other in-kernel users disappeared during the
>>>>>> Great
>>>>>> Refactoring (tm). bind() does have such requirement already.
>>>>>>
>>>>>> - all present and future callers of xnregistry_remove() should run in
>>>>>> secondary mode as well. There is only one caller remaining so far, and
>>>>>> it does (i.e. thread cleanup code).
>>>>>
>>>>> sem_destroy/sem_close/sem_unlink, pthread_mutex_destroy, and
>>>>> pthread_cond_destroy now call xnregistry_remove.
>>>>>
>>>>
>>>> Since your recent additions involve dropping keys from the registry from
>>>> mutex and cond deletion routines, I would then stick with an
>>>> implementation that allows primary-mode calls.
>>>
>>> Ok, just forgot that mutex and conds are anonymous, so, they need not
>>> access the hash table, only sem_unlink and sem_open will access the
>>> hash. Ok, I need to see what exactly needs to be protected during the
>>> rehash. Maybe not much after all.
>>>
>>
>> You also have to serialize access to the handle table, and keep key
>> indexing and handle registration seen as a single atomic operation from
>> external code.
>>
> Ok, I think I have found a way. It is not very complicated finally. I
> guess I found out something everybody knew already... When we know we
> are rehashing:
> - any search searches both in the old and the new hash
> - any insertion goes straight to the new hash.
> So, no wait for the rehash end is needed, except for the unlucky caller
> of the hash insertion routine which is doing the rehash.
>
> Here is the patch for the "xnid_table" hash, pushed yesterday, and used
> for named semaphores, file descriptors and timer ids.
>

I'm not fond of the concept of rehashing since this is introduced by the 
requirement to provide a dedicated mechanism for extending the (xn)file 
table dynamically in the first place.

I understand your concerns about keeping fast lookups while improving 
memory efficiency for the index meta-data. But at the same time, I'm not 
comfortable with the idea of introducing table rehash as a mean to deal 
with these goals.

Just like any other old cranky meatball whose education closely followed 
the ancient un*x mantra, I'm reluctant to introduce changes which would 
impact 100% of the user base only to address an issue experienced by 1% 
of it (i.e. those who would actually trigger the extension).

Could we try addressing the core issue using a different indexing 
structure, typically? Maybe we could reach an acceptable trade-off 
another way?

-- 
Philippe.

