Sender: chensong_2000@189.cn
Subject: Re: [PATCH] y2038: testsuite/smokey/y2038: replace syscall with
 XENOMAI_SYSCALL
References: <1621922726-7007-1-git-send-email-chensong_2000@189.cn>
 <9384709e-6dc5-f730-a9f5-53afcf8387af@siemens.com>
 <91aab68f-955f-6f47-2b4e-d8101249fa96@189.cn>
 <b74c37ea-631b-6050-b78e-352a07ddea0c@siemens.com>
From: "chensong_2000@189.cn" <chensong_2000@189.cn>
Message-ID: <2ba83d7f-f813-8c20-c0c1-df0e0fce19a0@189.cn>
Date: Tue, 25 May 2021 15:28:11 +0800
MIME-Version: 1.0
In-Reply-To: <b74c37ea-631b-6050-b78e-352a07ddea0c@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, florian.bezdeka@siemens.com, xenomai@xenomai.org



在 2021/5/25 下午3:16, Jan Kiszka 写道:
> On 25.05.21 09:13, chensong_2000@189.cn wrote:
>>
>>
>> 在 2021/5/25 下午2:44, Jan Kiszka 写道:
>>> On 25.05.21 08:05, Song Chen via Xenomai wrote:
>>>> replace syscall with XENOMAI_SYSCALL and handle return value differently
>>>>
>>>> Signed-off-by: Song Chen <chensong_2000@189.cn>
>>>> ---
>>>>    testsuite/smokey/y2038/syscall-tests.c | 128
>>>> +++++++++++++++------------------
>>>>    1 file changed, 56 insertions(+), 72 deletions(-)
>>>>
>>>> diff --git a/testsuite/smokey/y2038/syscall-tests.c
>>>> b/testsuite/smokey/y2038/syscall-tests.c
>>>> index 45f2fbe..f62ad9d 100644
>>>> --- a/testsuite/smokey/y2038/syscall-tests.c
>>>> +++ b/testsuite/smokey/y2038/syscall-tests.c
>>>> @@ -246,23 +246,23 @@ static int __mutex_timdlock64(pthread_mutex_t
>>>> *lock)
>>>>          ret = pthread_mutex_lock(lock);
>>>>        if (ret)
>>>> -        return errno;
>>>> +        return -errno;
>>>>          ret = pthread_create(&tid, NULL, __mutex_timedlock64_thread,
>>>> lock);
>>>>        if (ret)
>>>> -        return errno;
>>>> +        return -errno;
>>>>          ret = pthread_join(tid, NULL);
>>>>        if (ret)
>>>> -        return errno;
>>>> +        return -errno;
>>>>          ret = pthread_mutex_unlock(lock);
>>>>        if (ret)
>>>> -        return errno;
>>>> +        return -errno;
>>>>          ret = pthread_mutex_destroy(lock);
>>>>        if (ret)
>>>> -        return errno;
>>>> +        return -errno;
>>>>          return 0;
>>>>    }
>>>> @@ -329,7 +329,7 @@ static int test_sc_cobalt_mutex_timedlock64(void)
>>>>         */
>>>>        ret = __mutex_timdlock64(&lock);
>>>>        if (ret)
>>>> -        return errno;
>>>> +        return -errno;
>>>>          return 0;
>>>>    }
>>>> @@ -341,23 +341,21 @@ static int test_sc_cobalt_clock_gettime64(void)
>>>>        struct xn_timespec64 ts64;
>>>>          /* Make sure we don't crash because of NULL pointers */
>>>> -    ret = syscall(code, NULL, NULL);
>>>> -    if (ret == -1 && errno == ENOSYS) {
>>>> +    ret = XENOMAI_SYSCALL2(code, NULL, NULL);
>>>> +    if (ret == -ENOSYS) {
>>>>            smokey_note("clock_gettime64: skipped. (no kernel support)");
>>>>            return 0; // Not implemented, nothing to test, success
>>>>        }
>>>> -    if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>>>> -        return errno;
>>>>          /* Providing an invalid address has to deliver EFAULT */
>>>> -    ret = syscall(code, CLOCK_MONOTONIC, (void *)0xdeadbeefUL);
>>>> -    if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>>>> -        return errno;
>>>> +    ret = XENOMAI_SYSCALL2(code, CLOCK_MONOTONIC, (void
>>>> *)0xdeadbeefUL);
>>>> +    if (!smokey_assert(ret))
>>>> +        return ret ? ret : -EINVAL;
>>>>          /* Provide a valid 64bit timespec*/
>>>> -    ret = syscall(code, CLOCK_MONOTONIC, &ts64);
>>>> +    ret = XENOMAI_SYSCALL2(code, CLOCK_MONOTONIC, &ts64);
>>>>        if (!smokey_assert(!ret))
>>>> -        return errno;
>>>> +        return ret ? ret : -EINVAL;
>>>>          return 0;
>>>>    }
>>>> @@ -370,31 +368,27 @@ static int test_sc_cobalt_clock_settime64(void)
>>>>        struct timespec now;
>>>>          /* Make sure we don't crash because of NULL pointers */
>>>> -    ret = syscall(code, NULL, NULL);
>>>> -    if (ret == -1 && errno == ENOSYS) {
>>>> +    ret = XENOMAI_SYSCALL2(code, NULL, NULL);
>>>> +    if (ret == -ENOSYS) {
>>>>            smokey_note("clock_settime64: skipped. (no kernel support)");
>>>>            return 0; // Not implemented, nothing to test, success
>>>>        }
>>>> -    if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>>>> -        return errno;
>>>>          /* Providing an invalid address has to deliver EFAULT */
>>>> -    ret = syscall(code, CLOCK_MONOTONIC, (void *)0xdeadbeefUL);
>>>> -    if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>>>> -        return errno;
>>>> +    ret = XENOMAI_SYSCALL2(code, CLOCK_MONOTONIC, (void
>>>> *)0xdeadbeefUL);
>>>> +    if (!smokey_assert(ret))
>>>> +        return ret ? ret : -EINVAL;
>>>>          /* Provide a valid 64bit timespec*/
>>>>        ret = clock_gettime(CLOCK_MONOTONIC, &now);
>>>> -    if (ret) {
>>>> -        smokey_warning("clock_gettime failed in cloc_settime64.");
>>>> -        return errno;
>>>> -    }
>>>> +    if (ret)
>>>> +        return -errno;
>>>>    -    ts64.tv_sec  = now.tv_sec;
>>>> +    ts64.tv_sec  = now.tv_sec + 1;
>>>>        ts64.tv_nsec = now.tv_nsec;
>>>> -    ret = syscall(code, CLOCK_MONOTONIC, &ts64);
>>>> -    if (!smokey_assert(!ret))
>>>> -        return errno;
>>>> +    ret = XENOMAI_SYSCALL2(code, CLOCK_MONOTONIC, &ts64);
>>>> +    if (!smokey_assert(ret))
>>>> +        return ret ? ret : -EINVAL;
>>>>          return 0;
>>>>    }
>>>> @@ -408,39 +402,34 @@ static int test_sc_cobalt_clock_nanosleep64(void)
>>>>        long interval = 1;
>>>>          /* Make sure we don't crash because of NULL pointers */
>>>> -    ret = syscall(code, NULL, NULL, NULL, NULL);
>>>> -    if (ret == -1 && errno == ENOSYS) {
>>>> +    ret = XENOMAI_SYSCALL4(code, NULL, NULL, NULL, NULL);
>>>> +    if (ret == -ENOSYS) {
>>>>            smokey_note("clock_nanosleep64: skipped. (no kernel
>>>> support)");
>>>>            return 0; // Not implemented, nothing to test, success
>>>>        }
>>>> -    if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>>>> -        return errno;
>>>>          /* Providing an invalid address has to deliver EFAULT */
>>>> -    ret = syscall(code, CLOCK_MONOTONIC, TIMER_ABSTIME,
>>>> +    ret = XENOMAI_SYSCALL4(code, CLOCK_MONOTONIC, TIMER_ABSTIME,
>>>>                    (void *)0xdeadbeefUL, &rmt);
>>>> -    if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>>>> -        return errno;
>>>> +    if (!smokey_assert(ret))
>>>> +        return ret ? ret : -EINVAL;
>>>>          /* Provide a valid 64bit timespec, round 1*/
>>>>        ret = clock_gettime(CLOCK_MONOTONIC, &ts1);
>>>> -    if (ret) {
>>>> -        smokey_warning("clock_gettime failed in clock_nanosleep64.");
>>>> -        return errno;
>>>> -    }
>>>> +    if (ret)
>>>> +        return -errno;
>>>> +
>>>>        next.tv_sec  = ts1.tv_sec + interval;
>>>>        next.tv_nsec = ts1.tv_nsec;
>>>>    -    ret = syscall(code, CLOCK_MONOTONIC, TIMER_ABSTIME,
>>>> +    ret = XENOMAI_SYSCALL4(code, CLOCK_MONOTONIC, TIMER_ABSTIME,
>>>>                    &next, (void *)0xdeadbeefUL);
>>>>        if (!smokey_assert(!ret))
>>>> -        return errno;
>>>> +        return ret ? ret : -EINVAL;
>>>>          ret = clock_gettime(CLOCK_MONOTONIC, &ts2);
>>>> -    if (ret) {
>>>> -        smokey_warning("clock_gettime failed in clock_nanosleep64.");
>>>> -        return errno;
>>>> -    }
>>>> +    if (ret)
>>>> +        return -errno;
>>>>          timespec_sub(&delta, &ts2, &ts1);
>>>>        if (delta.tv_sec < interval)
>>>> @@ -450,15 +439,13 @@ static int test_sc_cobalt_clock_nanosleep64(void)
>>>>        next.tv_sec  = ts2.tv_sec + interval;
>>>>        next.tv_nsec = ts2.tv_nsec;
>>>>    -    ret = syscall(code, CLOCK_MONOTONIC, TIMER_ABSTIME, &next, &rmt);
>>>> +    ret = XENOMAI_SYSCALL4(code, CLOCK_MONOTONIC, TIMER_ABSTIME,
>>>> &next, &rmt);
>>>>        if (!smokey_assert(!ret))
>>>> -        return errno;
>>>> +        return ret ? ret : -EINVAL;
>>>>          ret = clock_gettime(CLOCK_MONOTONIC, &ts1);
>>>> -    if (ret) {
>>>> -        smokey_warning("clock_gettime failed in clock_nanosleep64.");
>>>> -        return errno;
>>>> -    }
>>>> +    if (ret)
>>>> +        return -errno;
>>>>          timespec_sub(&delta, &ts1, &ts2);
>>>>        if (delta.tv_sec < interval)
>>>> @@ -474,23 +461,22 @@ static int test_sc_cobalt_clock_getres64(void)
>>>>        struct xn_timespec64 ts64;
>>>>          /* Make sure we don't crash because of NULL pointers */
>>>> -    ret = syscall(code, NULL, NULL);
>>>> -    if (ret == -1 && errno == ENOSYS) {
>>>> +    ret = XENOMAI_SYSCALL2(code, NULL, NULL);
>>>> +    if (ret == -ENOSYS) {
>>>>            smokey_note("clock_getres64: skipped. (no kernel support)");
>>>>            return 0; // Not implemented, nothing to test, success
>>>>        }
>>>> -    if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>>>> -        return errno;
>>>>          /* Providing an invalid address has to deliver EFAULT */
>>>> -    ret = syscall(code, CLOCK_MONOTONIC, (void *)0xdeadbeefUL);
>>>> -    if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>>>> -        return errno;
>>>> +    ret = XENOMAI_SYSCALL2(code, CLOCK_MONOTONIC, (void
>>>> *)0xdeadbeefUL);
>>>> +    if (!smokey_assert(ret))
>>>> +        return ret ? ret : -EINVAL;
>>>>          /* Provide a valid 64bit timespec*/
>>>> -    ret = syscall(code, CLOCK_MONOTONIC, &ts64);
>>>> +    ret = XENOMAI_SYSCALL2(code, CLOCK_MONOTONIC, &ts64);
>>>>        if (!smokey_assert(!ret))
>>>> -        return errno;
>>>> +        return ret ? ret : -EINVAL;
>>>> +
>>>>        if (ts64.tv_sec != 0 || ts64.tv_nsec != 1)
>>>>            smokey_warning("High resolution timers not available\n");
>>>>    @@ -504,25 +490,23 @@ static int test_sc_cobalt_clock_adjtime64(void)
>>>>        struct xn_timex64 tx64 = {};
>>>>          /* Make sure we don't crash because of NULL pointers */
>>>> -    ret = syscall(code, NULL, NULL);
>>>> -    if (ret == -1 && errno == ENOSYS) {
>>>> +    ret = XENOMAI_SYSCALL2(code, NULL, NULL);
>>>> +    if (ret == -ENOSYS) {
>>>>            smokey_note("clock_adjtime64: skipped. (no kernel support)");
>>>>            return 0; // Not implemented, nothing to test, success
>>>>        }
>>>> -    if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>>>> -        return errno;
>>>>          /* Providing an invalid address has to deliver EFAULT */
>>>> -    ret = syscall(code, CLOCK_REALTIME, (void *)0xdeadbeefUL);
>>>> -    if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>>>> -        return errno;
>>>> +    ret = XENOMAI_SYSCALL2(code, CLOCK_REALTIME, (void *)0xdeadbeefUL);
>>>> +    if (!smokey_assert(ret))
>>>> +        return ret ? ret : -EINVAL;
>>>>          /* Provide a valid 64bit timex*/
>>>>        tx64.modes = ADJ_SETOFFSET;
>>>>        tx64.time.tv_usec = 123;
>>>> -    ret = syscall(code, CLOCK_REALTIME, &tx64);
>>>> -    if (!smokey_assert(!ret))
>>>> -        return errno;
>>>> +    ret = XENOMAI_SYSCALL2(code, CLOCK_REALTIME, &tx64);
>>>> +    if (!smokey_assert(ret))
>>>> +        return ret ? ret : -EINVAL;
>>>>          return 0;
>>>>    }
>>>>
>>>
>>> What is the baseline of this? It seems to be an unmerged patch, thus you
>>
>> yes, you are right, it's based on my unmerged patches, Florian will
>> merge them on [1] soon and this is the last one.
>>
>> baseline is [1], branch: florian/y2038.
>> [1]:git@gitlab.com:Xenomai/xenomai-hacker-space.git
>>
> 
> Ah, ok - tagging the patches would help, e.g. "[florian/y2038][PATCH] ...".

ok, will do in next patches.

> 
> Jan
> 
>> Song
>>
>>> rather want to send out a new version of that other patch, including
>>> this fix.
>>>
>>> Jan
>>>
> 
> 

