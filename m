Subject: Re: [PATCH] testsuite/smokey: y2038: Fix evaluation of pthread_join
 result
References: <ff6fb552-1773-59ed-8c34-1d443ad56016@siemens.com>
 <6c4e6acd3766cd68d06ecc63a74b48469b79dce0.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a61c52cb-2f2f-91b5-70af-3ec4ee9f079b@siemens.com>
Date: Mon, 9 Aug 2021 13:48:18 +0200
MIME-Version: 1.0
In-Reply-To: <6c4e6acd3766cd68d06ecc63a74b48469b79dce0.camel@siemens.com>
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
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09.08.21 09:52, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> On Mon, 2021-08-09 at 09:15 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The status value is the pointer, not where the pointer points to.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Not yet resolving the unexpected assertion, though.
>>
>>  testsuite/smokey/y2038/syscall-tests.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
>> index 90bfe28d48..afbe8d42a6 100644
>> --- a/testsuite/smokey/y2038/syscall-tests.c
>> +++ b/testsuite/smokey/y2038/syscall-tests.c
>> @@ -150,7 +150,7 @@ static int run_thread(void *(*thread)(void *), void *arg, int exp_result)
>>       if (!__T(ret, pthread_join(tid, &status)))
>>               return ret;
>>
>> -     res = *((long *) status);
>> +     res = (long)status;
> 
> Had a look again. That's correct. Do you want me to integrate it into
> the patch that introduced it?
> 
> Thanks for fixing this up.

Ah, it's not yet in master - I'll fold this in, need to rebase anyway.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

