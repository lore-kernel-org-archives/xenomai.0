Message-ID: <8753eb14-d31f-6d82-08c3-6f10d930160c@siemens.com>
Date: Tue, 24 May 2022 08:39:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] x86/fpu: fix compile error without kernel_fpu_disabled()
Content-Language: en-US
References: <20220516153242.12622-1-jamienstar@163.com>
 <04bc2dc30b2195aeaa3a6e16c175fc8906640251.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <04bc2dc30b2195aeaa3a6e16c175fc8906640251.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "rpm@xenomai.org" <rpm@xenomai.org>, "jamienstar@163.com" <jamienstar@163.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 16.05.22 17:59, Bezdeka, Florian via Xenomai wrote:
> On Mon, 2022-05-16 at 23:32 +0800, Jamie Huang via Xenomai wrote:
>> From: Jamie <jamienstar@163.com>
> 
> It's up to Jan but I guess a complete name would be nice here. Same
> fore the Signed-off-by below.

Philippe is maintaining the dovetail tree but, yes, we generally need a
real name to be able to check back regarding
https://developercertificate.org if any questions should arise in the
future.

Jan

> 
>>
>> In v5.18-evl-rebase, function kernel_fpu_disabled() has been removed in
>> commit 59f5ede3bc0f("x86/fpu: Prevent FPU state corruption"), so we will
>> get compile error when CONFIG_DOVETAIL is enabled:
>> arch/x86/kernel/fpu/core.c:931:6: error: implicit declaration of function ‘kernel_fpu_disabled’; did you mean ‘perf_pmu_disable’? [-Werror=implicit-function-declaration]
>>   if (kernel_fpu_disabled()) {
>>       ^~~~~~~~~~~~~~~~~~~
>>       perf_pmu_disable
>> cc1: all warnings being treated as errors
>> So, fix it.
>>
>> Signed-off-by: Jamie <jamienstar@163.com>
>> ---
>>  arch/x86/kernel/fpu/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
>> index 6a0d1e7f278f..c3adbbb73226 100644
>> --- a/arch/x86/kernel/fpu/core.c
>> +++ b/arch/x86/kernel/fpu/core.c
>> @@ -928,7 +928,7 @@ void fpu__suspend_inband(void)
>>  	 * preemption of an inband kernel context currently using the
>>  	 * fpu by a thread which resumes on the oob stage.
>>  	 */
>> -	if (kernel_fpu_disabled()) {
>> +	if (this_cpu_read(in_kernel_fpu)) {
>>  		save_fpregs_to_fpstate(kfpu);
>>  		__cpu_invalidate_fpregs_state();
>>  		oob_fpu_set_preempt(&tsk->thread.fpu);
> 
> Reviewed-By: Florian Bezdeka <florian.bezdeka@siemens.com>
> 
> I noticed that while investigating the FPU test issue that I already
> reported, but missed that we already have a dovetail branch which is
> affected.
> 
> Non-Git reference would be
> https://lore.kernel.org/lkml/20220501193102.588689270@linutronix.de/
> 
> 
> Best regards,
> Florian Bezdeka
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

