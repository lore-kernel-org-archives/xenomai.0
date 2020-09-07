References: <20200907130938.416831-1-rpm@xenomai.org>
 <20200907130938.416831-5-rpm@xenomai.org>
 <e9de4ff9-49e6-6e3b-e578-0c3a17008b75@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 5/6] x86/ipipe: fix build with CONFIG_X86_UV enabled
In-reply-to: <e9de4ff9-49e6-6e3b-e578-0c3a17008b75@siemens.com>
Date: Mon, 07 Sep 2020 17:11:10 +0200
Message-ID: <87o8mhaagh.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 07.09.20 15:09, Philippe Gerum wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>> 
>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> ---
>>  arch/x86/kernel/ipipe.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
>> index 3f3afcecc1b9..c5ebfdf2dfb3 100644
>> --- a/arch/x86/kernel/ipipe.c
>> +++ b/arch/x86/kernel/ipipe.c
>> @@ -72,6 +72,7 @@ void smp_irq_move_cleanup_interrupt(struct pt_regs *regs);
>>  void smp_reboot_interrupt(void);
>>  void smp_thermal_interrupt(struct pt_regs *regs);
>>  void smp_threshold_interrupt(struct pt_regs *regs);
>> +void uv_bau_message_interrupt(struct pt_regs *regs);
>>  
>>  void __ipipe_do_IRQ(unsigned int irq, void *cookie);
>>  
>> 
>
> IIRC, I broke that intentionally. There is more needed, and no one
> should get something building but subtly not working. But we may better do
>
>     depends on !IPIPE
>

Indeed, otherwise plain build tests with e.g. allyesconfig fail miserably.

-- 
Philippe.

