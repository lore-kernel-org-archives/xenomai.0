Sender: chensong_2000@189.cn
Subject: Re: [PATCH 3/3] y2038: testsuite/smokey/y2038: testcase for adjtime64
References: <1619682320-16309-1-git-send-email-chensong_2000@189.cn>
 <ada790d9-2a5d-d722-ee36-a1ef06986975@siemens.com>
From: "chensong_2000@189.cn" <chensong_2000@189.cn>
Message-ID: <54dc65b0-42f2-8ab3-3084-cd5e118713b2@189.cn>
Date: Wed, 2 Jun 2021 13:55:11 +0800
MIME-Version: 1.0
In-Reply-To: <ada790d9-2a5d-d722-ee36-a1ef06986975@siemens.com>
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org



在 2021/6/1 下午8:16, Florian Bezdeka 写道:
> On 29.04.21 09:45, Song Chen wrote:
>> add test case for clock_adjtime64 in testsuite
>>
>> Signed-off-by: Song Chen <chensong_2000@189.cn>
>> ---
>>   testsuite/smokey/y2038/syscall-tests.c | 71 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 71 insertions(+)
>>
>> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
>> index c59a9d6..22fd9b6 100644
>> --- a/testsuite/smokey/y2038/syscall-tests.c
>> +++ b/testsuite/smokey/y2038/syscall-tests.c
>> @@ -25,6 +25,43 @@ struct xn_timespec64 {
>>   	int64_t tv_nsec;
>>   };
>>   
>> +struct xn_timex_timeval {
>> +	int64_t tv_sec;
>> +	int64_t	tv_usec;
>> +};
>> +
>> +struct xn_timex64 {
>> +	unsigned int modes;	/* mode selector */
>> +	int:32;            /* pad */
>> +	long long offset;	/* time offset (usec) */
>> +	long long freq;	/* frequency offset (scaled ppm) */
>> +	long long maxerror;/* maximum error (usec) */
>> +	long long esterror;/* estimated error (usec) */
>> +	int status;		/* clock command/status */
>> +	int:32;            /* pad */
>> +	long long constant;/* pll time constant */
>> +	long long precision;/* clock precision (usec) (read only) */
>> +	long long tolerance;/* clock frequency tolerance (ppm) (read only) */
>> +	struct xn_timex_timeval time;	/* (read only, except for ADJ_SETOFFSET) */
>> +	long long tick;	/* (modified) usecs between clock ticks */
>> +
>> +	long long ppsfreq;/* pps frequency (scaled ppm) (ro) */
>> +	long long jitter; /* pps jitter (us) (ro) */
>> +	int shift;              /* interval duration (s) (shift) (ro) */
>> +	int:32;            /* pad */
>> +	long long stabil;            /* pps stability (scaled ppm) (ro) */
>> +	long long jitcnt; /* jitter limit exceeded (ro) */
>> +	long long calcnt; /* calibration intervals (ro) */
>> +	long long errcnt; /* calibration errors (ro) */
>> +	long long stbcnt; /* stability limit exceeded (ro) */
>> +
>> +	int tai;		/* TAI offset (ro) */
>> +
>> +	int:32; int:32; int:32; int:32;
>> +	int:32; int:32; int:32; int:32;
>> +	int:32; int:32; int:32;
>> +};
>> +
>>   #define NSEC_PER_SEC 1000000000
>>   
>>   static void ts_normalise(struct xn_timespec64 *ts)
>> @@ -326,6 +363,36 @@ static int test_sc_cobalt_clock_getres64(void)
>>   	return 0;
>>   }
>>   
>> +static int test_sc_cobalt_clock_adjtime64(void)
>> +{
>> +	long ret;
>> +	int code = __xn_syscode(sc_cobalt_clock_adjtime64);
>> +	struct xn_timex64 tx64 = {};
>> +
>> +	/* Make sure we don't crash because of NULL pointers */
>> +	ret = syscall(code, NULL, NULL);
>> +	if (ret == -1 && errno == ENOSYS) {
>> +		smokey_note("clock_adjtime64: skipped. (no kernel support)");
>> +		return 0; // Not implemented, nothing to test, success
>> +	}
>> +	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>> +		return errno;
>> +
>> +	/* Providing an invalid address has to deliver EFAULT */
>> +	ret = syscall(code, CLOCK_REALTIME, (void *)0xdeadbeefUL);
>> +	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>> +		return errno;
>> +
>> +	/* Provide a valid 64bit timex*/
>> +	tx64.modes = ADJ_SETOFFSET;
>> +	tx64.time.tv_usec = 123;
>> +	ret = syscall(code, CLOCK_REALTIME, &tx64);
> 
> In int __cobalt_clock_adjtime() we have
> 
> 	switch (clock_id) {
> 	case CLOCK_REALTIME:
> 	case CLOCK_MONOTONIC:
> 	case CLOCK_MONOTONIC_RAW:
> 	case CLOCK_HOST_REALTIME:
> 		return -EOPNOTSUPP;
> 
> So the test-failure I see on x86 is fully expected. How did you get this
> test running successfully?

In this revision, i got this:
root@kylin-Lenovo:/home/kylin/workspace/y2038/xenomai-hacker-space# 
./testsuite/smokey/smokey --run=27
syscall-tests.c:391, assertion failed: !ret
/home/kylin/workspace/y2038/xenomai-hacker-space/testsuite/smokey/.libs/lt-smokey: 
test y2038 failed: Unknown error -95 (which is EOPNOTSUPP)

In my last revision, which replaced syscall with XENOMAI_SYSCALL, it 
returns -95, i'm afraid it will terminate smokey test, i turned it to if 
!smokey_assert(ret) for now.

when __cobalt_clock_adjtime becomes supported, i will turn it back.

> 
> 
>> +	if (!smokey_assert(!ret))
>> +		return errno;
>> +
>> +	return 0;
>> +}
>> +
>>   static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
>>   {
>>   
>> @@ -351,5 +418,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
>>   	if (ret)
>>   		return ret;
>>   
>> +	ret = test_sc_cobalt_clock_adjtime64();
>> +	if (ret)
>> +		return ret;
>> +
>>   	return 0;
>>   }
>>
> 
> 

