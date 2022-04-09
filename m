References: <48e0fc4f-0020-907c-136e-53f01e596fda@siemens.com>
 <874k34gbk8.fsf@xenomai.org>
 <ed782d4c-544d-8d10-d53f-4c95f017ce3d@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: 5.10-dovetail regression?
Date: Sat, 09 Apr 2022 11:16:55 +0200
In-reply-to: <ed782d4c-544d-8d10-d53f-4c95f017ce3d@siemens.com>
Message-ID: <87k0by4nkc.fsf@xenomai.org>
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
Cc: Xenomai <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 07.04.22 17:24, Philippe Gerum wrote:
>> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> Hi Philippe,
>>>
>>> does this already ring some bell?
>>>
>>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/419210
>>>
>>> Only triggers with qemu-amd64, not on real HW and not with 5.15.
>>>
>> 
>> I could not reproduce locally, but visual inspection revealed something
>> fishy in #8e2c09ee5323. Could you try this on the failing kernel? TIA,
>> 
>> diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
>> index 2651c6cfd034..da6735d45a8a 100644
>> --- a/kernel/time/clockevents.c
>> +++ b/kernel/time/clockevents.c
>> @@ -644,8 +644,8 @@ void clockevents_exchange_device(struct clock_event_device *old,
>>  		 * to the release list, keep it around but mark it as
>>  		 * reserved.
>>  		 */
>> +		list_del(&old->list);
>>  		if (tick_check_is_proxy(new)) {
>> -			list_del(&old->list);
>>  			clockevents_switch_state(old, CLOCK_EVT_STATE_RESERVED);
>>  		} else {
>>  			clockevents_switch_state(old, CLOCK_EVT_STATE_DETACHED);
>> 
>
> Didn't reproduce locally for me as well, though using the same image.
> But the patch helped on the CI system.
>

It does not seem to be enough though, that patch fixes a different bug
actually. So there are two of them:

1. lockup when running "corectl --stop" on 5.10/kvm_x86 configurations,
not reproducible here on any other setup

2. list poisoning which triggers an assertion at boot on "some" x86
configurations

The patch above definitely fixes #1, makes sense. I managed to reproduce
#2 on real hw, with kernel 5.15 this time. Same gremlin:

[    2.052096] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1152
[    2.052273] ------------[ cut here ]------------
[    2.053250] list_del corruption, ffff8881001ce0b8->next is LIST_POISON1 (dead000000000100)
[    2.053250] WARNING: CPU: 0 PID: 1 at lib/list_debug.c:45 __list_del_entry_valid+0x81/0xe0
[    2.053250] Modules linked in:
[    2.053250] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.32+ #100
[    2.053250] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name, BIOS 5.12.09.16.05 07/26/2017
[    2.053250] IRQ stage: Linux
[    2.053250] RIP: 0010:__list_del_entry_valid+0x81/0xe0
[    2.053250] Code: 85 c5 ff 49 8b 55 08 4c 39 e2 75 5b b8 01 00 00 00 5d 41 5c 41 5d c3 4c 89 ea 48 8d 75 00 48 c7 c7 80 99 80 ad e8 ea fb 83 00 <0f> 0b 5d 41 5c 31 c0 41 5d c3 49 8d 14 24 48 8d 75 00 48 c7 c7 e0
[    2.053250] RSP: 0000:ffff888100287dc0 EFLAGS: 00010246
[    2.053250] RAX: 0000000000000000 RBX: ffff8881001ce000 RCX: 0000000000000000
[    2.053250] RDX: 0000000000000002 RSI: 0000000000000008 RDI: ffffed1020050fae
[    2.053250] RBP: ffff8881001ce0b8 R08: ffffffffac22b384 R09: ffffffffac279120
[    2.053250] R10: ffff888100287aaf R11: ffffed1020050f55 R12: dead000000000122
[    2.053250] R13: dead000000000100 R14: 0000000000000002 R15: ffffffffadff62a0
[    2.053250] FS:  0000000000000000(0000) GS:ffff88815c800000(0000) knlGS:0000000000000000
[    2.053250] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.053250] CR2: ffff888104e01000 CR3: 0000000103e10000 CR4: 00000000003506f0
[    2.053250] Call Trace:
[    2.053250]  <TASK>
[    2.053250]  clockevents_exchange_device+0x16c/0x2a0
[    2.053250]  tick_check_new_device+0x1c3/0x230
[    2.053250]  clockevents_register_device+0xc3/0x170
[    2.053250]  setup_boot_APIC_clock+0x526/0x553
[    2.053250]  ? default_ioapic_phys_id_map+0x40/0x40
[    2.053250]  native_smp_prepare_cpus+0x2cd/0x3ef
[    2.053250]  kernel_init_freeable+0xc0/0x290
[    2.053250]  ? rest_init+0xe0/0xe0
[    2.053250]  kernel_init+0x19/0x130
[    2.053250]  ret_from_fork+0x22/0x30
[    2.053250]  </TASK>

I'm on it.

-- 
Philippe.

