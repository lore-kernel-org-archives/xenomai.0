Sender: chensong_2000@189.cn
Subject: Re: [PATCH v2 3/3] y2038: testsuite/smokey/y2038: testcase for
 nanosleep64
References: <1618994335-21566-1-git-send-email-chensong_2000@189.cn>
 <a983931b4ac76dffd6df9d3327bd7fa38c1feb66.camel@siemens.com>
From: "chensong_2000@189.cn" <chensong_2000@189.cn>
Message-ID: <3becbc07-779c-2d09-59b4-2d1245569141@189.cn>
Date: Tue, 27 Apr 2021 01:05:36 +0800
MIME-Version: 1.0
In-Reply-To: <a983931b4ac76dffd6df9d3327bd7fa38c1feb66.camel@siemens.com>
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
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "chensong@tj.kylinos.cn" <chensong@tj.kylinos.cn>



在 2021/4/23 下午8:48, Bezdeka, Florian 写道:
> On Wed, 2021-04-21 at 16:38 +0800, Song Chen wrote:
>>   
>>
>> +static int test_sc_cobalt_clock_nanosleep64(void)+{
>> +	long ret;
>> +	int code = __xn_syscode(sc_cobalt_clock_nanosleep64);
>> +	struct xn_timespec64 next, rmt;
>> +	struct timespec now;
>> +
>> +	/* Make sure we don't crash because of NULL pointers */
>> +	ret = syscall(code, NULL, NULL, NULL, NULL);
>> +	if (ret == -1 && errno == ENOSYS) {
>> +		smokey_note("clock_nanosleep64: skipped. (no kernel support)");
>> +		return 0; // Not implemented, nothing to test, success
>> +	}
>> +	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>> +		return errno;
>> +
>> +	/* Provide a valid 64bit timespec*/
>> +	ret = clock_gettime(CLOCK_MONOTONIC, &now);
>> +	if (ret) {
>> +		smokey_warning("clock_gettime failed in clock_nanosleep64.");
>> +		return errno;
>> +	}
>> +
>> +	/* Providing an invalid address has to deliver EFAULT */
>> +	ret = syscall(code, CLOCK_MONOTONIC, TIMER_ABSTIME,
>> +				(void *)0xdeadbeefUL, &rmt);
>> +	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>> +		return errno;
>> +
>> +	next.tv_sec  = now.tv_sec + 1;
>> +	next.tv_nsec = now.tv_nsec;
>> +
>> +	ret = syscall(code, CLOCK_MONOTONIC, TIMER_ABSTIME,
>> +				&next, (void *)0xdeadbeefUL);
>> +	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>> +		return errno;
>> +
>> +	next.tv_sec  = next.tv_sec + 1;
> 
> That looks like duplicate code. The last call to nanosleep was an error
> handling check, so we would end up here adding 2 secs to "now".

point taken
> 
>> +
>> +	ret = syscall(code, CLOCK_MONOTONIC, TIMER_ABSTIME, &next, &rmt);
>> +	if (!smokey_assert(!ret))
>> +		return errno;
>> +
> 
> As long as nobody has a better idea we should make sure that we don't
> come back to early. Checking for the upper boundary requires some magic
> numbers as already discussed, so let's check at least the lower
> boundary.

point is not taken, could you please explain upper/lower boundary more 
specifically, thanks.

Song

> 
>> +	return 0;
>> +}
>> +
>>   static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
>>   {
>>   	int ret;
>> @@ -244,5 +290,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
>>   	if (ret)
>>   		return ret;
>>   
>> +	ret = test_sc_cobalt_clock_nanosleep64();
>> +	if (ret)
>> +		return ret;
>> +
>>   	return 0;
>>   }
> 

