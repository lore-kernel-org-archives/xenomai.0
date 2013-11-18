Message-ID: <528A21A9.9050502@siemens.com>
Date: Mon, 18 Nov 2013 15:18:17 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <E1ViO8p-0004L8-4y@sd-51317.dedibox.fr>
 <528A156C.1070501@xenomai.org>
In-Reply-To: <528A156C.1070501@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : switchtest: Account for
 invalid last_switch.from field
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On 2013-11-18 14:26, Gilles Chanteperdrix wrote:
> On 11/18/2013 01:41 PM, git repository hosting wrote:
>> Module: xenomai-jki
>> Branch: for-forge
>> Commit: 3e6d8ff9a99262e78655329dc043aacc607eb158
>> URL:   
>> http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=3e6d8ff9a99262e78655329dc043aacc607eb158
>>
>>
>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>> Date:   Mon Nov 18 13:19:34 2013 +0100
>>
>> switchtest: Account for invalid last_switch.from field
>>
>> If we close a test device early, no switch may have yet taken place when
>> the first call to rtswitch_to_rt/nrt happens. This can cause to_idx to
>> become -1, and the system will crash. Handle this corner case
>> gracefully.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> ---
>>
>>   kernel/drivers/testing/switchtest.c |   10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/drivers/testing/switchtest.c
>> b/kernel/drivers/testing/switchtest.c
>> index 6f77ee9..7d17c5f 100644
>> --- a/kernel/drivers/testing/switchtest.c
>> +++ b/kernel/drivers/testing/switchtest.c
>> @@ -147,8 +147,11 @@ static int rtswitch_to_rt(rtswitch_context_t *ctx,
>>
>>       /* to == from is a special case which means
>>          "return to the previous task". */
>> -    if (to_idx == from_idx)
>> +    if (to_idx == from_idx) {
>>           to_idx = ctx->error.last_switch.from;
>> +        if (to_idx == -1)
>> +            return -EINVAL;
>> +    }
> 
> I do not see how we can reach rtswitch_to_rt without having switched
> context, since the first task to run is not an rt task.

Counter question: What should enforce this ordering? And via which call
stack should last_switch.from be first updated?

I suspect that the RT tasks overtake the non-RT one here, but - granted
- I didn't understand the control flow and synchronization of this
driver yet.

So even if this is not the cause, just curing a symptom, I think it is a
valid safety measure.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

