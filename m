Subject: Re: xenomai-2.6.5 pause in rt_task_create()
References: <518806e7-27e3-4a9e-b8f6-ddcf74be41a5.demon.han@aliyun.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9828984e-d395-4b56-1796-c25d0e29656b@siemens.com>
Date: Wed, 3 Apr 2019 09:13:18 +0200
MIME-Version: 1.0
In-Reply-To: <518806e7-27e3-4a9e-b8f6-ddcf74be41a5.demon.han@aliyun.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: "demon.han" <demon.han@aliyun.com>, xenomai <xenomai@xenomai.org>

On 03.04.19 05:30, demon.han via Xenomai wrote:
> Hi,all
> I am working on xenomai :Ubuntu12 + linux-3.18.20 + xenomai-2.6.5 on intel 6200 platform. > After I compiled the kernel and install xenomai lib as xenomai.org says, I 
want to run some examples to check my installation.
> Here are my questions asking for help:
> It's strange that the system will stop in function rt_task_create() with nothing return,
> I found this in run 'latency' or 'trivial-periodic' in example.
> 
> The dmesg is this:

There is probably more above this line, and that may tell more about the error.

> [  618.237608] Call Trace:
> [  618.237614]  [<c1155c44>] __rt_task_create+0x114/0x1e0
> [  618.237618]  [<c108b2f8>] ? up_read+0x8/0x20
> [  618.237622]  [<c1040d57>] ? __do_page_fault+0x297/0x540
> [  618.237625]  [<c10584c7>] ? recalc_sigpending+0x17/0x50
> [  618.237629]  [<c113ff14>] ? hisyscall_event+0x14/0x370
> [  618.237632]  [<c114031f>] losyscall_event+0xaf/0x240
> [  618.237636]  [<c10edeba>] ipipe_syscall_hook+0x3a/0x50
> [  618.237639]  [<c10ecde9>] __ipipe_notify_syscall+0xa9/0x160
> [  618.237645]  [<c16d98c4>] pipeline_sysenter+0x7/0x1e
> [  618.237646] Code: 83 c4 08 5b 5d c3 90 90 90 90 90 90 90 55 89 e5 83 ec 0c 89 5d f4 89 75 f8 89 7d fc e8 dc 1f 10 00 89 d6 89 c7 89 ca 85 c9 74 0b <ac> aa 84 c0 74 03 49 75 f7 29 ca 8b 5d f4 89 d0 8b 75 f8 8b 7d
> [  618.237689] EIP: [<c15d753e>] rthal_strncpy_from_user+0x1e/0x40 SS:ESP 0068:e64fbed8
> [  618.237693] CR2: 00000000bff85f3c
> [  618.237696] ---[ end trace 96ac88920e748b8c ]---
> 
> and the teminal is this:
> aos:~$ cd /usr/xenomai/bin/
> aos:/usr/xenomai/bin$ ./latency
> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> (nothing list in the following )
> 
> my system is this:
> aos@aos:/usr/xenomai/bin$ uname -a
> Linux aos 3.18.20-xenomai-2.6.5 #1 SMP Tue Apr 2 20:04:01 CST 2019 i686 i686 i386 GNU/Linux
> 
> I found it on google and found few ideas.
> Please give me some help,thanks anyway.
> 
> demon.
> 

I might be that you ran into a bug that was fixed in the maintained Xenomai 3 
releases.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

