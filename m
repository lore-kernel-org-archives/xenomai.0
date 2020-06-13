Subject: Re: Exception #14 in kernel space when using rttcp
References: <1293572894.22066.1591975586278.JavaMail.zimbra@wolfram.com>
 <f545866d-efc1-e35e-5f69-6a40102a5cb0@siemens.com>
 <544072279.25640.1591976851898.JavaMail.zimbra@wolfram.com>
 <393bccc6-8d64-b382-dc54-14893cbd385c@siemens.com>
 <121459932.109963.1592035509405.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <25ce38d1-1fa6-61ec-5051-1fbbb17a5c5a@siemens.com>
Date: Sat, 13 Jun 2020 17:11:32 +0200
MIME-Version: 1.0
In-Reply-To: <121459932.109963.1592035509405.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset="utf-8"
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
To: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

On 13.06.20 10:05, Per Oberg wrote:
> 
> ----- Den 12 jun 2020, på kl 17:54, Jan Kiszka jan.kiszka@siemens.com skrev:
> 
>> On 12.06.20 17:47, Per Oberg via Xenomai wrote:
>>> ----- Den 12 jun 2020, på kl 17:33, Jan Kiszka jan.kiszka@siemens.com skrev:
> 
>>>> On 12.06.20 17:26, Per Oberg via Xenomai wrote:
>>>>> Hi list
> 
>>>>> I get a massive amount of "swithching ... to secondary mode after exception #14
>>>>> in kernel-space ..." followed by a WARNING as shown below.
> 
>>>>> Can someone enlighten me regarding the meaning of exception #14 ?
> 
>>>>> Is the "WARNING: CPU: 0 ..." the cause or the symptom ? It has a macro at fd.c
>>>>> calling "XENO_WARN_ON(COBALT, fd->refs <= 0);
> 
> 
>>>> Likely related: The WARN_ON triggers a stack dump and that may trigger
>>>> fixable or ignorable faults. We may consider converting that
>>>> XENO_WARN_ON into XENO_WARN_ON_ONCE.
> 
>>>> What is actually interesting is the warning itself. Reference counting
>>>> became imbalanced. How do you trigger that?
> 
>>> Where do you see that? I can't figure out anything about what is going on from
>>> that warning...
> 
> 
>> Warning at .../rtdm/fd.c:299:
> 
>> static void __put_fd(struct rtdm_fd *fd, spl_t s)
>> {
>> ...
>> XENO_WARN_ON(COBALT, fd->refs <= 0);
> 
> Oh, yes of course. Didn't make the connections to the source. Thought you could see it directly in the kernel message. My bad. 
> 
>> So, the file descriptor is released although its internal reference
>> counter says it's not held. That is a bug in the kernel, likely leading
>> to use-after-release issues.
> 
>>> Not sure what I am actually doing, but I'd be glad to debug it if I knew where
>>> to start.
> 
>>> I'm working on compiling a network library for use in Xenomai. It uses a lot of
>>> extra stuff to get everything up and running,but in the end it will use UDP for
>>> the data exchange. So switching to secondary mode may be ok during the startup.
> 
> 
>> I suppose you are writing a userspace application that uses RT-TCP here.
>> That usage pattern up to the point you see the first warning would be
>> interesting, ideally as minimal testcase. Also the configuration of the
>> RTnet stack (compile-time and runtime).
> 
> One thing that is noteworthy is that I was running Xenomai 3.1 with a 4.9.90 kernel (reporting itself as Xenomai 3.1), which seems like a big mess up. When I cleaned up my build-tree properly it wouldn't compile anymore which gave me the idea that I somehow managed to mix and match two xenomai versions in the same kernel. 
> 
> Anyway, I recompiled everything from scratch using :
> Xenomai 3.1
> Linux 4.19.114-cip24 with ipipe patch 12 
> 
> Now I get other errors, but I'm not sure yet whether that is because I have turned on the watchdog. I did a little quick-and dirty config of the kernel to get it up and running so I am not sure exactly how much that differs between my this and my old setup. Here goes: 
> 
> [ 1054.259075] [Xenomai] watchdog triggered on CPU #0 -- runaway thread 'RTTest' signaled
> [ 1054.260509] ------------[ cut here ]------------
> [ 1054.260510] [Xenomai] switching rtnet-stack to secondary mode after exception #6 in kernel-space at 0xffffffff8bd7064b (pid 1449)
> [ 1054.260517] WARNING: CPU: 0 PID: 1449 at /usr/src/kernel/kernel/xenomai/rtdm/fd.c:299 __put_fd+0x26b/0x2c0
> [ 1054.260517] Modules linked in: rttcp rtudp rtipv4 rt_igb rtnet x86_pkg_temp_thermal
> [ 1054.260521] CPU: 0 PID: 1449 Comm: rtnet-stack Not tainted 4.19.114-cip24xeno-cobalt #1
> [ 1054.260522] Hardware name: Default string Default string/SKYBAY, BIOS 5.0.1.1 04/18/2016
> [ 1054.260522] I-pipe domain: Linux
> [ 1054.260524] RIP: 0010:__put_fd+0x26b/0x2c0
> [ 1054.260525] Code: 83 e0 01 49 39 c4 74 08 4c 89 e7 e8 8f 98 f9 ff 48 8d 7d b0 e8 36 99 f9 ff e9 81 fe ff ff 48 c7 c7 e0 b0 db 8c e8 1e 4b f3 ff <0f> 0b 41 8b 5d 18 e9 ca fd ff ff 48 8b 05 eb d0 2d 01 49 c7 45 30
> [ 1054.260525] RSP: 0018:ffff94f9c0223dc0 EFLAGS: 00010282
> [ 1054.260526] RAX: 0000000000000028 RBX: 0000000000000000 RCX: 0000000000000001
> [ 1054.260527] RDX: 0000000000000000 RSI: 0000000000001140 RDI: ffffffff8d77d500
> [ 1054.260528] RBP: ffff94f9c0223e20 R08: 0000000000000045 R09: 000000000002e7c0
> [ 1054.260528] R10: ffff94f9c0223e38 R11: 0000000000000000 R12: 0000000000000000
> [ 1054.260529] R13: ffff919461fb4800 R14: 0000000000000000 R15: ffffffffc011d1e0
> [ 1054.260529] FS:  0000000000000000(0000) GS:ffff919465a00000(0000) knlGS:0000000000000000
> [ 1054.260530] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1054.260531] CR2: 0000000000000000 CR3: 00000001dba0a001 CR4: 00000000003606f0
> [ 1054.260531] Call Trace:
> [ 1054.260534]  ? rtdm_nrtsig_pend+0x43/0x70
> [ 1054.260536]  ? rtdm_cleanup+0x10/0x10
> [ 1054.260537]  ? rtdm_fd_unlock+0x9b/0xd0
> [ 1054.260538]  rtdm_fd_unlock+0x9b/0xd0
> [ 1054.260540]  rt_ip_rcv+0x129/0x180 [rtipv4]
> [ 1054.260542]  rt_stack_deliver+0x22c/0x3a0 [rtnet]
> [ 1054.260544]  ? xnthread_map+0x370/0x370
> [ 1054.260545]  rt_stack_mgr_task+0x66/0xa0 [rtnet]
> [ 1054.260546]  kthread_trampoline+0x77/0x133
> [ 1054.260548]  kthread+0x10e/0x130
> [ 1054.260550]  ? kthread_create_worker_on_cpu+0x70/0x70
> [ 1054.260552]  ret_from_fork+0x36/0x50
> [ 1054.260554] ---[ end trace a6a10c1d0c5fd7df ]---
> [ 1054.260555] ------------[ cut here ]------------
> [ 1054.260571] WARNING: CPU: 0 PID: 1449 at /usr/src/kernel/kernel/xenomai/rtdm/drvlib.c:884 rtdm_event_timedwait+0x50/0x320
> [ 1054.260572] Modules linked in: rttcp rtudp rtipv4 rt_igb rtnet x86_pkg_temp_thermal
> [ 1054.260573] CPU: 0 PID: 1449 Comm: rtnet-stack Tainted: G        W         4.19.114-cip24xeno-cobalt #1
> [ 1054.260574] Hardware name: Default string Default string/SKYBAY, BIOS 5.0.1.1 04/18/2016
> [ 1054.260574] I-pipe domain: Linux
> [ 1054.260575] RIP: 0010:rtdm_event_timedwait+0x50/0x320
> [ 1054.260575] Code: c0 48 85 f6 78 46 48 c7 c2 40 01 03 00 48 89 d0 65 48 03 05 da 17 2a 74 f6 40 09 40 74 19 48 c7 c7 e0 b0 db 8c e8 f9 77 f3 ff <0f> 0b 41 bc ff ff ff ff e9 24 01 00 00 65 48 03 15 b3 17 2a 74 48
> [ 1054.260576] RSP: 0018:ffff94f9c0223e80 EFLAGS: 00010282
> [ 1054.260576] RAX: 0000000000000024 RBX: ffffffffc0105e00 RCX: 0000000000000000
> [ 1054.260577] RDX: 0000000000000000 RSI: ffffffff8cdd42b1 RDI: 00000000ffffffff
> [ 1054.260577] RBP: ffffffffc0104300 R08: ffff919465a00000 R09: 0000000000000466
> [ 1054.260578] R10: ffff94f9c0223e38 R11: 0000000000000000 R12: ffff94f9c02b3a90
> [ 1054.260578] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffffc0104300
> [ 1054.260579] FS:  0000000000000000(0000) GS:ffff919465a00000(0000) knlGS:0000000000000000
> [ 1054.260579] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1054.260580] CR2: 0000000000000000 CR3: 00000001dba0a001 CR4: 00000000003606f0
> [ 1054.260580] Call Trace:
> [ 1054.260580]  ? rt_stack_deliver+0x28b/0x3a0 [rtnet]
> [ 1054.260581]  ? xnthread_map+0x370/0x370
> [ 1054.260581]  rt_stack_mgr_task+0x27/0xa0 [rtnet]
> [ 1054.260582]  kthread_trampoline+0x77/0x133
> [ 1054.260582]  kthread+0x10e/0x130
> [ 1054.260583]  ? kthread_create_worker_on_cpu+0x70/0x70
> [ 1054.260583]  ret_from_fork+0x36/0x50
> [ 1054.260584] ---[ end trace a6a10c1d0c5fd7e0 ]---
> 
> 
> I will try to make a minimal example of my example and my current setup. Am I right in believing that there is now a "Standard distro" for xenomai that I can try this on with well known settings? If so, how can I take it out for a spin?
> 

Yes, we testing via xenomai-images [1] (thought not all aspects). If you
managed to reproduce the issue for its qemu-x86 configuration, that
would be perfect.

Jan

[1] https://gitlab.denx.de/Xenomai/xenomai-images

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

