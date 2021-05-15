References: <20210507215149.1409729-1-florian.bezdeka@siemens.com>
 <3c9f9d64-0b11-23fa-f283-0b8128ed6b67@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH v6 0/4] Adressing y2038 test failures on ARM and BBB
In-reply-to: <3c9f9d64-0b11-23fa-f283-0b8128ed6b67@siemens.com>
Date: Sat, 15 May 2021 18:12:42 +0200
Message-ID: <87cztsou11.fsf@xenomai.org>
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
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org, chensong_2000@189.cn


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 07.05.21 23:51, Florian Bezdeka wrote:
>> The CI pipeline discovered an invalid instruction on some ARM boards,
>> especially the BBB (beaglebone black). Applying this patch series should
>> fix the current test failure on "next" branch.
>> 
>> As already discussed: There might be another problem in the ARM syscall
>> prologue/epilogue but it still makes sense to use the same macro for
>> calling the syscalls as libcobalt does.
>> 
>> I'm still asking myself why libcobalt has special macros for calling the
>> syscalls instead of using plain syscall() from *libc. Any input?
>> 
>> The difference to v5:
>>  - Resend, forget to CC Philippe 
>>  - Fixed SPDX license header (newer version of checkpatch seems to care)
>>  - Fixed a typo in one of the test descriptions
>> 
>> The difference to v4:
>>  - Fixed the error handling / error reporting bugs introduced by v4
>>    errno => ret migration gone wrong
>>  - Took care of some review comments from Jan
>> 
>> The main difference to v3:
>>  - Migration from syscall() (libc) to XENOAMAI_SYSCALLx()
>> 
>> 
>> Florian Bezdeka (4):
>>   cobalt/sem: y2038: Fixing the sem_timedwait syscall for 32 bit systems
>>   y2038: Adding sem_timedwait64
>>   y2038: Add tests for the sc_cobalt_sem_timedwait64 syscall
>>   y2038: lib/cobalt: Add support of sc_cobalt_sem_timedwait64
>> 
>>  configure.ac                           |   1 +
>>  include/cobalt/kernel/time.h           |  20 +++
>>  include/cobalt/uapi/syscall.h          |   1 +
>>  kernel/cobalt/Makefile                 |   1 +
>>  kernel/cobalt/posix/sem.c              |  60 ++++++---
>>  kernel/cobalt/posix/sem.h              |  13 +-
>>  kernel/cobalt/posix/syscall32.c        |  17 ++-
>>  kernel/cobalt/posix/syscall32.h        |   6 +-
>>  kernel/cobalt/time.c                   |  27 ++++
>>  lib/cobalt/semaphore.c                 |   5 +
>>  testsuite/smokey/Makefile.am           |   6 +-
>>  testsuite/smokey/y2038/Makefile.am     |  10 ++
>>  testsuite/smokey/y2038/syscall-tests.c | 178 +++++++++++++++++++++++++
>>  13 files changed, 314 insertions(+), 31 deletions(-)
>>  create mode 100644 include/cobalt/kernel/time.h
>>  create mode 100644 kernel/cobalt/time.c
>>  create mode 100644 testsuite/smokey/y2038/Makefile.am
>>  create mode 100644 testsuite/smokey/y2038/syscall-tests.c
>> 
>
> With these four plus the first 5 of [1], testing passed - thanks, merged.
>
> Jan
>
> [1] https://xenomai.org/pipermail/xenomai/2021-May/045094.html

There is a kernel splat when CONFIG_DEBUG_DOVETAIL is enabled here, as a
result of running smokey--run=y2038 specifically, no other test triggers
this. Observed on x86 and ARM indifferently. Dovetail complains about
the (virtual) interrupt state being broken, meaning irqs_disabled() on
return from a pipelined syscall handled by Cobalt, while still running
in-band:

[  527.286726] WARNING: CPU: 1 PID: 230 at kernel/dovetail.c:224 pipeline_syscall+0x88/0xd0
[  527.294854] Modules linked in:
[  527.297948] CPU: 1 PID: 230 Comm: smokey Not tainted 5.10.32+ #63
[  527.304068] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name, BIOS 5.12.09.16.05 07/26/2017
[  527.313393] IRQ stage: Linux
[  527.316290] RIP: 0010:pipeline_syscall+0x88/0xd0
[  527.320923] Code: 00 e8 ec f5 04 00 8b 43 08 a8 04 74 26 48 8b 03 a9 00 00 00 04 75 2e 5b 5d b8 01 00 00 00 41 5c c3 e8 fc ad 7c 00 85 c0 74 14 <0f> 0b b8 ff ff ff ff eb ae e8 ea ad 7c 00 85 c0 74 02 0f 0b b8 ff
[  527.339702] RSP: 0018:ffffc9000007ff10 EFLAGS: 00010202
[  527.344945] RAX: 0000000000000001 RBX: ffff888101a03a80 RCX: 00000000ffffffff
[  527.352091] RDX: 0000000000000000 RSI: 0000000000000286 RDI: 0000000000000001
[  527.359235] RBP: ffffc9000007ff58 R08: 0000000000000286 R09: ffffffff82309340
[  527.366380] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000010000066
[  527.373525] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  527.380669] FS:  00007f8154aed740(0000) GS:ffff88817bc80000(0000) knlGS:0000000000000000
[  527.388761] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  527.394517] CR2: 0000000000000008 CR3: 0000000101af2000 CR4: 00000000003506e0
[  527.401663] Call Trace:
[  527.404138]  syscall_enter_from_user_mode+0x25/0x80
[  527.409037]  do_syscall_64+0xf/0x90
[  527.412540]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  527.417608] RIP: 0033:0x41c753
[  527.420681] Code: 83 f9 ff ff 0f 1f 00 41 54 31 f6 31 d2 55 bd 66 00 00 10 53 48 83 ec 40 48 8d 7c 24 20 e8 45 8e fe ff 31 f6 31 ff 89 e8 0f 05 <83> f8 da 0f 84 dc 00 00 00 48 89 c3 83 f8 ea 75 4c 48 8d 7c 24 20
[  527.439466] RSP: 002b:00007fff2ddb06c0 EFLAGS: 00000246 ORIG_RAX: 0000000010000066
[  527.447051] RAX: ffffffffffffffea RBX: 00000000004284c0 RCX: 000000000041c753
[  527.454200] RDX: 0000000000001000 RSI: 0000000000000000 RDI: 0000000000000000
[  527.461351] RBP: 0000000010000066 R08: 00007fff2ddb0694 R09: 0000000000000000
[  527.468498] R10: ffffffffffffffcc R11: 0000000000000246 R12: 00000000023dca20
[  527.475653] R13: 00007f8154aed740 R14: 0000000000000000 R15: 0000000000000000
[  527.482800] ---[ end trace 1c9b99d832e6d115 ]---
syscall-tests.c:160, sem_timedwait64 returned to early!
Expected wakeup at: 526 sec 163325942 nsec
Back at           : 526 sec 162839069 nsec

[   17.206475] ------------[ cut here ]------------
[   17.211138] WARNING: CPU: 3 PID: 229 at kernel/dovetail.c:224 pipeline_syscall+0x88/0xd0
[   17.219269] Modules linked in:
[   17.222349] CPU: 3 PID: 229 Comm: smokey Not tainted 5.10.32+ #64
[   17.228483] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name, BIOS 5.12.09.16.05 07/26/2017
[   17.237817] IRQ stage: Linux
[   17.240729] RIP: 0010:pipeline_syscall+0x88/0xd0
[   17.245367] Code: 00 e8 ec f5 04 00 8b 43 08 a8 04 74 26 48 8b 03 a9 00 00 00 04 75 2e 5b 5d b8 01 00 00 00 41 5c c3 e8 fc ad 7c 00 85 c0 74 14 <0f> 0b b8 ff ff ff ff eb ae e8 ea ad 7c 00 85 c0 74 02 0f 0b b8 ff
[   17.264180] RSP: 0018:ffffc90000253f10 EFLAGS: 00010202
[   17.269432] RAX: 0000000000000001 RBX: ffff888101b78000 RCX: 00000000fffffffd
[   17.276594] RDX: 0000000000000000 RSI: 0000000000000286 RDI: 0000000000000003
[   17.283748] RBP: ffffc90000253f58 R08: 0000000000000286 R09: ffffffff82309340
[   17.290903] R10: 0000000000000003 R11: 0000000000000000 R12: 0000000010000066
[   17.298056] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   17.305213] FS:  00007f4d06618740(0000) GS:ffff88817bd80000(0000) knlGS:0000000000000000
[   17.313323] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.319087] CR2: 0000000000000008 CR3: 0000000101c14000 CR4: 00000000003506e0
[   17.326241] Call Trace:
[   17.328719]  syscall_enter_from_user_mode+0x25/0x80
[   17.333620]  do_syscall_64+0xf/0x90
[   17.337132]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   17.342204] RIP: 0033:0x41c753
[   17.345284] Code: 83 f9 ff ff 0f 1f 00 41 54 31 f6 31 d2 55 bd 66 00 00 10 53 48 83 ec 40 48 8d 7c 24 20 e8 45 8e fe ff 31 f6 31 ff 89 e8 0f 05 <83> f8 da 0f 84 dc 00 00 00 48 89 c3 83 f8 ea 75 4c 48 8d 7c 24 20
[   17.364116] RSP: 002b:00007fff618cb770 EFLAGS: 00000246 ORIG_RAX: 0000000010000066
[   17.371713] RAX: ffffffffffffffea RBX: 00000000004284c0 RCX: 000000000041c753
[   17.378868] RDX: 0000000000001000 RSI: 0000000000000000 RDI: 0000000000000000
[   17.386026] RBP: 0000000010000066 R08: 00007fff618cb744 R09: 0000000000000000
[   17.393176] R10: ffffffffffffffcc R11: 0000000000000246 R12: 00000000010d3a20
[   17.400335] R13: 00007f4d06618740 R14: 0000000000000000 R15: 0000000000000000
[   17.407493] ---[ end trace 8da7e02b222f4015 ]---
syscall-tests.c:160, sem_timedwait64 returned to early!
Expected wakeup at: 16 sec 86652042 nsec
Back at           : 16 sec 86165276 nsec

Running from
https://lab.xenomai.org/xenomai-rpm.git/log/?h=for-upstream/dovetail,
which has just been rebased over -next. I did not look at the issue
closely yet.

-- 
Philippe.

