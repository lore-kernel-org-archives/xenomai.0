Subject: Re: [PATCH] testsuite/smokey: relax posix-clock time dependancy
References: <20181109091430.24559-1-henning.schild@siemens.com>
 <6bcda9af-aea0-970d-59f2-ed7a49222fe2@siemens.com>
 <20181119104016.7f303e5c@md1za8fc.ad001.siemens.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4b5a46a2-7683-8522-9570-2a04d590338d@xenomai.org>
Date: Mon, 19 Nov 2018 10:52:34 +0100
MIME-Version: 1.0
In-Reply-To: <20181119104016.7f303e5c@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On 11/19/18 10:40 AM, Henning Schild wrote:
> Am Fri, 16 Nov 2018 07:23:47 +0100
> schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> 
>> On 09.11.18 10:14, Henning Schild via Xenomai wrote:
>>> The test often asserted. This patch gives the thread a priority,
>>> introduces a 25us margin and prints the value in case we still fail.
>>>
>>> Signed-off-by: Henning Schild <henning.schild@siemens.com>
>>> ---
>>>   testsuite/smokey/posix-clock/posix-clock.c | 15 ++++++++++++++-
>>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/testsuite/smokey/posix-clock/posix-clock.c
>>> b/testsuite/smokey/posix-clock/posix-clock.c index
>>> f672a9d52..36e0f5dea 100644 ---
>>> a/testsuite/smokey/posix-clock/posix-clock.c +++
>>> b/testsuite/smokey/posix-clock/posix-clock.c @@ -417,8 +417,10 @@
>>> static int clock_decrease_after_periodic_timer_first_tick(void) 
>>>   	diff = now.tv_sec * 1000000000ULL + now.tv_nsec -
>>>   		(timer.it_value.tv_sec * 1000000000ULL +
>>> timer.it_value.tv_nsec);
>>> -	if (!smokey_assert(diff < 1000000000))
>>> +	if (!smokey_assert(diff < 1000000000ULL + 25000ULL)) {  
>>
>> Philippe, is this margin also reasonable from your perspective? Or
>> are we risking to miss a problem this way? I'm currently lacking a
>> feeling.
> 
> Good question. That is an estimate suitable for x86. While it should
> not defeat the test, the test failing 60% of the time renders it not
> too useful.
> 

Did you calibrate the timer shot with the autotune utility before
running that test?

-- 
Philippe.

