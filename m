Sender: chensong_2000@189.cn
Subject: Re: [PATCH v3 3/3] y2038: testsuite/smokey/y2038: testcase for
 nanosleep64
References: <1619505695-14319-1-git-send-email-chensong_2000@189.cn>
 <61cf70a8e5cd6a4b76d013121f352a36dc4b2dbe.camel@siemens.com>
From: "chensong_2000@189.cn" <chensong_2000@189.cn>
Message-ID: <8dbb7a66-d8ec-7adc-2e4b-077bad78509b@189.cn>
Date: Tue, 27 Apr 2021 15:35:02 +0800
MIME-Version: 1.0
In-Reply-To: <61cf70a8e5cd6a4b76d013121f352a36dc4b2dbe.camel@siemens.com>
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



在 2021/4/27 下午3:27, Bezdeka, Florian 写道:
> On Tue, 2021-04-27 at 14:41 +0800, Song Chen wrote:
>> +	ret = clock_gettime(CLOCK_MONOTONIC, &ts2);
>> +	if (ret) {
>> +		smokey_warning("clock_gettime failed in clock_nanosleep64.");
>> +		return errno;
>> +	}
>> +
>> +	timespec_sub(&delta, &ts2, &ts1);
> 
> Where is timespec_sub coming from and why can't you re-use ts_less as
> we did before in test_sc_cobalt_sem_timedwait64 where we do a similar
> check?

check this out [1]
https://elixir.bootlin.com/glibc/latest/source/sysdeps/pthread/posix-timer.h#L148
i printed the result of timespec_sub, it's correct.

ts_less returns a bool but i need a value.

Song

> 
>> +	if (delta.tv_sec < interval)
>> +		smokey_warning("nanosleep didn't sleep long enough.");
>> +
>> +	/* Provide a valid 64bit timespec, round 2*/
>> +	next.tv_sec  = ts2.tv_sec + interval;
>> +	next.tv_nsec = ts2.tv_nsec;
>> +
>> +	ret = syscall(code, CLOCK_MONOTONIC, TIMER_ABSTIME, &next, &rmt);
>> +	if (!smokey_assert(!ret))
>> +		return errno;
>> +
>> +	ret = clock_gettime(CLOCK_MONOTONIC, &ts1);
>> +	if (ret) {
>> +		smokey_warning("clock_gettime failed in clock_nanosleep64.");
>> +		return errno;
>> +	}
>> +
>> +	timespec_sub(&delta, &ts1, &ts2);
>> +	if (delta.tv_sec < interval)
>> +		smokey_warning("nanosleep didn't sleep long enough.");
>> +
>> +	return 0;
>> +}
> 

