Subject: Re: [PATCH] dovetail: Adjust EXIT_SYSCALL_* values to avoid clash
 with seccomp
References: <35bbd40e-b5ea-a2e4-c01b-282850b84eee@siemens.com>
 <576b4524874fd0ce2afa5abc8e428b9484d6f55c.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <da004f16-4588-5fcc-7c49-c74adc6117ac@siemens.com>
Date: Fri, 12 Nov 2021 09:32:39 +0100
MIME-Version: 1.0
In-Reply-To: <576b4524874fd0ce2afa5abc8e428b9484d6f55c.camel@siemens.com>
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
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "rpm@xenomai.org" <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "andouyuuta@yamaha-motor.co.jp" <andouyuuta@yamaha-motor.co.jp>

On 12.11.21 09:29, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> On Thu, 2021-11-11 at 19:57 +0100, Jan Kiszka via Xenomai wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> __secure_computing, called by syscall_trace_enter, returns -1 when a
>> call should be skipped. We must avoid that this is interpreted as
>> EXIT_SYSCALL_OOB in the dovetail case.
>>
>> Fixes, e.g., crashes of Chrome in sandbox mode.
>>
>> Reported-by: Ando Yuta <andouyuuta@yamaha-motor.co.jp>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> "Fixes" is my observation - Yuta-san, please confirm also for your setup.
>>
>>  include/linux/entry-common.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
>> index 2a08b00632b9..43cf846111d9 100644
>> --- a/include/linux/entry-common.h
>> +++ b/include/linux/entry-common.h
>> @@ -66,8 +66,8 @@
>>   * Status codes of syscall entry when Dovetail is enabled. Must not
>>   * conflict with valid syscall numbers.
> 
> Maybe extend this comment why -1 can not be used here?
> 

Good point.

Jan

>>   */
>> -#define EXIT_SYSCALL_OOB     (-1)
>> -#define EXIT_SYSCALL_TAIL    (-2)
>> +#define EXIT_SYSCALL_OOB     (-2)
>> +#define EXIT_SYSCALL_TAIL    (-3)
>>
>>  /**
>>   * arch_check_user_regs - Architecture specific sanity check for user mode regs
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

