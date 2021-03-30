Subject: Re: [PATCH v3 5/5] y2038: testsuite/smokey/y2038: testcase for
 settime64 and gettime64
References: <1616052978-22093-1-git-send-email-chensong@tj.kylinos.cn>
 <6a859195-4560-1bed-5c66-9ad8c223eb00@siemens.com>
 <605D36D0.1080406@tj.kylinos.cn>
 <5302bb76-591a-430c-db43-e25d27a83551@siemens.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <6062FBFA.6070106@tj.kylinos.cn>+3BC3673AA9BE21B6
Date: Tue, 30 Mar 2021 18:22:50 +0800
MIME-Version: 1.0
In-Reply-To: <5302bb76-591a-430c-db43-e25d27a83551@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org, rpm@xenomai.org



On 2021年03月26日 17:53, Florian Bezdeka wrote:
> On 26.03.21 02:20, chensong wrote:
>>
>>
>> On 2021年03月24日 20:28, Florian Bezdeka wrote:
>>> On 18.03.21 08:36, chensong wrote:
>>>> new test case for clock_settime64 and clock_gettime64 and reorganize
>>>> run_2038.
>>>>
>>>> If you want to trigger and verify y2038 problem, please be careful and
>>>> make sure it has no impact to your test device.
>>>>
>>>> Signed-off-by: chensong <chensong@tj.kylinos.cn>
>>>> ---
>>>>    testsuite/smokey/y2038/syscall-tests.c | 115
>>>> +++++++++++++++++++++++++++++++--
>>>>    1 file changed, 109 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/testsuite/smokey/y2038/syscall-tests.c
>>>> b/testsuite/smokey/y2038/syscall-tests.c
>>>> index 1d61bbd..89e7d47 100644
>>>> --- a/testsuite/smokey/y2038/syscall-tests.c
>>>> +++ b/testsuite/smokey/y2038/syscall-tests.c
>>>> @@ -17,6 +17,38 @@
>>>>
>>>>    smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038
>>>> support");
>>>>
>>>> +
>>>> +#define RUN_TEST(name) test_ ## name
>
> Maybe we should rename it to something like TEST_NAME or remove it entirely.
>
>>>> +typedef int (*testee_func)(void);
>>>> +struct testee_info {
>
> I would vote for renaming it to test_info.

done
>
>>>> +    char *name;
>>>> +    testee_func func;
>
> No need for a typedef here. Could be done "inline":
>
> 	int (*func)(void);
>
> Better names might be test_name and test_fn. WDYT?

done
>
>>>> +};
>>>> +
>>>> +static int test_sc_cobalt_sem_timedwait64(void);
>>>> +static int test_sc_cobalt_clock_gettime64(void);
>>>> +static int test_sc_cobalt_clock_settime64(void);
>>>> +
>>>> +#define TESTEE_TABLE_COUNT 32
>>>> +static struct testee_info testee_table[TESTEE_TABLE_COUNT] = {
>
> TESTEE_TABLE_COUNT is not necessary. Remove it and use something like
>
> static struct test_info tests[] = {...};

done
>
>>>> +    {
>>>> +        .name = "sc_cobalt_sem_timedwait64",
>>>> +        .func = RUN_TEST(sc_cobalt_sem_timedwait64),
>>>> +    },
>>>> +    {
>>>> +        .name = "sc_cobalt_clock_gettime64",
>>>> +        .func = RUN_TEST(sc_cobalt_clock_gettime64),
>>>> +    },
>>>> +    {
>>>> +        .name = "sc_cobalt_clock_settime64",
>>>> +        .func = RUN_TEST(sc_cobalt_clock_settime64),
>>>> +    },
>>>> +    {
>>>> +        .name = NULL,
>>>> +        .func = NULL,
>>>> +    },
>>>> +};
>
> That's the "registration" part, will reference that below.
>
>>>> +
>>>>    /*
>>>>     * libc independent data type representing a time64_t based struct
>>>> timespec
>>>>     */
>>>> @@ -25,7 +57,8 @@ struct xn_timespec64 {
>>>>        int64_t tv_nsec;
>>>>    };
>>>>
>>>> -#define NSEC_PER_SEC 1000000000
>>>> +#define NSEC_PER_SEC        1000000000
>>>> +#define USEC_PER_SEC        1000000
>>>>
>>>>    static void ts_normalise(struct xn_timespec64 *ts)
>>>>    {
>>>> @@ -114,10 +147,10 @@ static int test_sc_cobalt_sem_timedwait64(void)
>>>>
>>>>        /*
>>>>         * The semaphore is already exhausted, so calling again will
>>>> validate
>>>> -     * the provided timeout now. Providing an invalid adress has to
>>>> deliver
>>>> +     * the provided timeout now. Providing an invalid address has to
>>>> deliver
>>>>         * EFAULT
>>>>         */
>>>> -    ret = syscall(code, &sem, (void*) 0xdeadbeefUL);
>>>> +    ret = syscall(code, &sem, (void *)0xdeadbeefUL);
>>>>        if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>>>>            return errno;
>>>>
>>>> @@ -163,13 +196,83 @@ static int test_sc_cobalt_sem_timedwait64(void)
>>>>        return 0;
>>>>    }
>>>>
>>>> +static int test_sc_cobalt_clock_gettime64(void)
>>>> +{
>>>> +    long ret;
>>>> +    int code = __xn_syscode(sc_cobalt_clock_gettime64);
>>>> +    struct xn_timespec64 ts64;
>>>> +
>>>> +    /* Make sure we don't crash because of NULL pointers */
>>>> +    ret = syscall(code, NULL, NULL);
>>>> +    if (ret == -1 && errno == ENOSYS) {
>>>> +        smokey_note("clock_gettime64: skipped. (no kernel support)");
>>>> +        return 0; // Not implemented, nothing to test, success
>>>> +    }
>>>> +    if (!smokey_assert(ret == -1) || !smokey_assert(errno == EINVAL))
>>>> +        return errno;
>>>> +
>>>> +    /* Providing an invalid address has to deliver EFAULT */
>>>> +    ret = syscall(code, CLOCK_REALTIME, (void *)0xdeadbeefUL);
>>>> +    if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>>>> +        return errno;
>>>> +
>>>> +    /* Provide a valid 64bit timespec*/
>>>> +    ret = syscall(code, CLOCK_REALTIME, &ts64);
>>>> +    if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>>>> +        return errno;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int test_sc_cobalt_clock_settime64(void)
>>>> +{
>>>> +    long ret;
>>>> +    int code = __xn_syscode(sc_cobalt_clock_settime64);
>>>> +    struct xn_timespec64 ts64;
>>>> +    struct timespec now;
>>>> +
>>>> +    /*Get current time and set it back at the end of the test*/
>>>> +    clock_gettime(CLOCK_REALTIME, &now);
>>>> +
>>>> +    /* Make sure we don't crash because of NULL pointers */
>>>> +    ret = syscall(code, NULL, NULL);
>>>> +    if (ret == -1 && errno == ENOSYS) {
>>>> +        smokey_note("clock_settime64: skipped. (no kernel support)");
>>>> +        return 0; // Not implemented, nothing to test, success
>>>> +    }
>>>> +    if (!smokey_assert(ret == -1) || !smokey_assert(errno == EINVAL))
>>>> +        goto out;
>>>> +
>>>> +    /* Providing an invalid address has to deliver EFAULT */
>>>> +    ret = syscall(code, CLOCK_REALTIME, (void *)0xdeadbeefUL);
>>>> +    if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>>>> +        goto out;
>>>> +
>>>> +    /* Provide a valid 64bit timespec*/
>>>> +    ts64.tv_sec  = now.tv_sec;
>>>> +    ts64.tv_nsec = now.tv_nsec;
>>>> +    ret = syscall(code, CLOCK_REALTIME, &ts64);
>>>> +    if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>>>> +        goto out;
>>>> +
>>>> +out:
>>>> +    clock_settime(CLOCK_REALTIME, &now);
>>>> +    return errno;
>>>> +}
>>>> +
>>>> +
>>>>    static int run_y2038(struct smokey_test *t, int argc, char *const
>>>> argv[])
>>>>    {
>>>>        int ret;
>>>> +    struct testee_info *p = testee_table;
>>>>
>>>> -    ret = test_sc_cobalt_sem_timedwait64();
>>>> -    if (ret)
>>>> -        return ret;
>>>> +    while (p->name != NULL) {
>>>> +        ret = p->func();
>>>> +        if (ret)
>>>> +            smokey_warning("%s failed, errno is %d\n", p->name, ret);
>>>> +
>>>> +        p++;
>>>> +    }
>
> If we stay with this approach, we should change the loop to "for" and
> rename the pointer to "t" meaning "test". Don't know why it's called
> "p". Something like
>
> 	struct test_info *t;
>
> 	for (t = tests; t->func != NULL; t++) {
> 		errno = t->func();
> 		if (errno)
> 			smokey_warning(...);
> 	}
>
>>>
>>> I thought about that again and I still see no value for that. We have
>>> all the assertions in place which will tell us where exactly we failed.
>>> So why adding another error reporting here?
>>>
>>> Just call the tests directly (without any need for additional
>>> infrastructure) and bail out on the first error.
>>
>> we will have dozens of syscall to be tested here, all of them will be
>> piled up at the end, like:
>>
>> ret = test_sc_cobalt_sem_timedwait64();
>> if (ret)
>>      return ret;
>>
>> ret = test_sc_cobalt_clock_gettime64();
>> if (ret)
>>      return ret;
>>
>> ret = test_sc_cobalt_clock_settime64();
>> if (ret)
>>      return ret;
>>
>> ret = test_sc_cobalt_clock_nanosleep();
>> if (ret)
>>      return ret;
>>
>> If you think it's ok, i will submit a new version, let me know.
>>
>> Song
>
> The benefit of your version is that the value of errno is printed. Not
> sure if the assertion would do that as well. Could you check that? That
> helps debugging.

assertions work, like "syscall-tests.c:260, assertion failed: ret == 0", 
no need to duplicate.

>
> The "registration" in your "test table" also requires 3 or 4 lines per
> testcase, so it's not really "shorter", but after another round of
> looking at it I start liking it...
>

if so, keep it that way

/Song

>
>>
>>>
>>>>
>>>>        return 0;
>>>>    }
>>>>
>>>
>>>
>>
>>
>
>



