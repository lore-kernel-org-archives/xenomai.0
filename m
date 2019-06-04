Subject: Re: RTnet bind failed socket again
References: <ea8b5153-3530-4b7b-3a73-586cda346cbe@compador.de>
 <1523560934.2012965.1559553044281.JavaMail.zimbra@wolfram.com>
 <ebc7a250-dbaa-c898-f04c-2822199d2f3a@siemens.com>
 <1132257520.2299169.1559634353991.JavaMail.zimbra@wolfram.com>
 <trinity-8b4a1a24-36bf-48e6-8b5e-ae45645c70ab-1559636643478@3c-app-gmx-bs58>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f2101cce-0b80-6c82-8808-02f02d307e4b@siemens.com>
Date: Tue, 4 Jun 2019 10:30:21 +0200
MIME-Version: 1.0
In-Reply-To: <trinity-8b4a1a24-36bf-48e6-8b5e-ae45645c70ab-1559636643478@3c-app-gmx-bs58>
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
To: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>, pero@wolfram.com
Cc: xenomai <xenomai@xenomai.org>

On 04.06.19 10:24, Sebastian Smolorz wrote:
> Hi,
> 
> on 04.06.2019 09:45, Per Oberg wrote:
>> ----- Den 3 jun 2019, på kl 17:33, Jan Kiszka jan.kiszka@siemens.com skrev:
>>
>>> On 03.06.19 11:10, Per Oberg via Xenomai wrote:
>>
>>
>>
>>>> ----- Den 3 jun 2019, på kl 11:06, xenomai xenomai@xenomai.org skrev:
>>
>>>>> Hi,
>>
>>>>> My program opens a RTnet socket successfully but the program gets killed
>>>>> by a different issue that has nothing to do with this. However, the
>>>>> RTnet socket is still bound. If I try to start the program again i get
>>>>> the error "Address already in use". If it would be a normal unix socket
>>>>> I would simply call it with SO_REUSEADDR but this is not possible with
>>>>> RTnet from what I understand.
>>
>>>> I tried this and failed miserably. That said, I'm also interested in the answer
>>>> to this question.
>>
>>>>> My question is why the socket is not unbound after the binding process
>>>>> is killed and if there is a way to reclaim this socket. By the way, it
>>>>> has to be this socket since the communication partner expects the server
>>>>> to listen on this exact port.
>>
>>>>> Cheers,
>>
>>>>> Johannes
>>
>>>> Per Öberg
>>
>>
>>> Are we talking about UDP in both cases?
>>
>> I use UDP, yes. But I had no problems with the UDP part.
>>
>> The problem I had was regarding the use of setsockopt. Because I test the code on a regular linux machine the lingering of the sockets after killing the application can be annoying. From what you describe below, SO_REUSEADDR should not be necessary for this case (did I get that correctly? ).
>>
>> Because I use the posix skin, and because it was necessary in regular linux, i started out using it in the common code base but I never managed to get it working in RT so I removed it again.
>>
>> I used something like:
>>
>>> int reuseSetting = 1;
>>> setsockopt(datagramSocket, SOL_SOCKET, SO_REUSEADDR, &reuseSetting, sizeof(int);
>>
>> Or even (because I use both rt and not rt sockets in the same code and I got the feeling that the automatic handling of this didn't quite work out.)
>>> __cobalt_setsockopt(datagramSocket, SOL_SOCKET, SO_REUSEADDR, &reuseSetting, sizeof(int);
>>
>>
>> This gave me:
>> ----------------------------------------------------------------------------------------------------------------------
>> 70642.666691] [Xenomai] switching App Thread to secondary mode after exception #14 in kernel-space at 0xffffffffa0281787 (pid 633)
>> [70642.667326] BUG: unable to handle kernel paging request at 00007fe06ff84d20
>> [70642.667948] IP: [<ffffffffa0281787>] rt_ip_ioctl+0x27/0x120 [rtipv4]
>> [70642.668566] PGD 80000002631e7067
>> [70642.668575] PUD 24a07d067
>> [70642.669184] PMD 260cab067
>> [70642.669189] PTE 800000023b6cc067
>> [70642.669805]
>> [70642.670403] Oops: 0001 [#5] PREEMPT SMP
>> [70642.670989] Modules linked in: rtudp rtipv4 intel_powerclamp intel_rapl coretemp rt_igb e1000e i915 rtnet pcan(O) video fan thermal_sys
>> [70642.671629] CPU: 3 PID: 633 Comm: App Thread Tainted: G      D W  O    4.9.90-xeno-cobolt #1
>> [70642.672239] Hardware name: Default string Default string/SKYBAY, BIOS 5.0.1.1 04/18/2016
>> [70642.672854] I-pipe domain: Linux
>> [70642.673459] task: ffff880263231b00 task.stack: ffffc90001798000
>> [70642.674066] RIP: 0010:[<ffffffffa0281787>]  [<ffffffffa0281787>] rt_ip_ioctl+0x27/0x120 [rtipv4]
>> [70642.674683] RSP: 0018:ffffc9000179bda8  EFLAGS: 00010246
>> [70642.675300] RAX: 000000000007ffff RBX: 0000000040180021 RCX: ffff88026dd80000
>> [70642.675923] RDX: 00007fe06ff84d20 RSI: 0000000040180021 RDI: ffff880262a86800
>> [70642.676544] RBP: ffffc9000179bdd0 R08: 0000000000000050 R09: ffff880263231b00
>> [70642.677166] R10: 00000000000000e6 R11: 0000000000000000 R12: ffff880262a86800
>> [70642.677783] R13: 0000000040180021 R14: 00007fe06ff84d20 R15: 0000000062a86800
>> [70642.678394] FS:  00007fe06ff85700(0000) GS:ffff88026dd80000(0000) knlGS:0000000000000000
>> [70642.679009] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>> [70642.679621] CR2: 00007fe06ff84d20 CR3: 0000000261678000 CR4: 0000000000360630
>> [70642.680233] Stack:
>> [70642.680838]  ffffffffa028c6f7 0000000000000001 ffffffff81178cd0 ffff880262a86800
>> [70642.681464]  0000000000000003 ffffc9000179be60 ffffffff811725be 0000000000000202
>> [70642.682086]  ffff880263231b00 ffff880200000010 ffffc9000179be70 ffffc9000179be08
>> [70642.682711] Call Trace:
>> [70642.683325]  [<ffffffffa028c6f7>] ? rt_udp_ioctl+0x67/0x8c [rtudp]
>> [70642.683949]  [<ffffffff81178cd0>] ? CoBaLt_fcntl+0x20/0x20
>> [70642.684573]  [<ffffffff811725be>] rtdm_fd_ioctl+0xee/0x280
>> [70642.685199]  [<ffffffff81178cd0>] ? CoBaLt_fcntl+0x20/0x20
>> [70642.685825]  [<ffffffff81178cd0>] ? CoBaLt_fcntl+0x20/0x20
>> [70642.686445]  [<ffffffff81178cde>] CoBaLt_ioctl+0xe/0x20
>> [70642.687064]  [<ffffffff81188472>] ipipe_syscall_hook+0x112/0x350
>> [70642.687686]  [<ffffffff8110acb8>] __ipipe_notify_syscall+0xc8/0x190
>> [70642.688306]  [<ffffffff8110adaa>] ipipe_handle_syscall+0x2a/0xb0
>> [70642.688925]  [<ffffffff81001c3d>] do_syscall_64+0x2d/0xf0
>> [70642.689514]  [<ffffffff818dffbe>] entry_SYSCALL_64_after_swapgs+0x58/0xc6
>> [70642.690073] Code: 68 b8 eb b0 e8 ab 04 66 e1 81 fe 27 00 10 40 0f 84 c1 00 00 00 7e 73 81 fe 20 00 18 40 74 3c 81 fe 21 00 18 40 0f 85 a0 00 00 00 <8b> 02 8b 4a 10 4c 8b 42 08 8b 72 04 85 c0 0f 85 d6 00 00 00 83
>> [70642.691405] RIP  [<ffffffffa0281787>] rt_ip_ioctl+0x27/0x120 [rtipv4]
>> [70642.692026]  RSP <ffffc9000179bda8>
>> [70642.692642] CR2: 00007fe06ff84d20
>> [70642.693250] ---[ end trace 53b7ee62f61c9cca ]---
>> ----------------------------------------------------------------------------------------------------------------------
> 
> This is the same error we faced several times already in RTnet:
> Unsafe direct access to userspace memory. I could prepare a patch
> as I did it just for rttcp.
> 

Ah, indeed - now I see the address from the right angle. Patch would be welcome!

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

