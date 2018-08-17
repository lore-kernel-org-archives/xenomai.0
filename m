References: <1128666844.14578797.1534496239671.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <cdc86bc5-642a-b34f-2e60-68e243103165@siemens.com>
Date: Fri, 17 Aug 2018 11:46:13 +0200
MIME-Version: 1.0
In-Reply-To: <1128666844.14578797.1534496239671.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Question about kernel warning (Yocto/meta-linux +
 xenomai homebrew)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

On 2018-08-17 10:57, Per Oberg wrote:
> Hi there
> 
> could someone please help me understand what this warning is:
> 
> 
> [ 2932.508097] ------------[ cut here ]------------
> [ 2932.514724] WARNING: CPU: 0 PID: 20645 at /usr/src/kernel/arch/x86/include/asm/fpu/internal.h:538 fpu__drop+0x19e/0x200
> [ 2932.529155] Modules linked in:
> [ 2932.533513] CPU: 0 PID: 20645 Comm: cat Not tainted 4.9.90-xeno-cobolt #1
> [ 2932.542067] Hardware name: Hewlett-Packard HP Z620 Workstation/158A, BIOS J61 v03.65 12/19/2013
> [ 2932.552955] I-pipe domain: Linux
> [ 2932.557675]  ffffc90007f37dc8 ffffffff8143da78 0000000000000000 0000000000000000
> [ 2932.566582]  ffffffff81ba4cc0 ffffc90007f37e08 ffffffff810785c1 0000021a00000000
> [ 2932.576484]  0000000000025dc0 ffff88041a1d5780 0000000000000246 0000000000000000
> [ 2932.585818] Call Trace:
> [ 2932.590167]  [<ffffffff8143da78>] dump_stack+0xbf/0xe7
> [ 2932.593148]  [<ffffffff810785c1>] __warn+0xe1/0x100
> [ 2932.595426]  [<ffffffff810786ad>] warn_slowpath_null+0x1d/0x20
> [ 2932.597715]  [<ffffffff8102754e>] fpu__drop+0x19e/0x200
> [ 2932.600849]  [<ffffffff81025a15>] exit_thread+0xa5/0xc0
> [ 2932.603976]  [<ffffffff8107bd7d>] do_exit+0x2bd/0xb40
> [ 2932.606097]  [<ffffffff81045605>] ? __do_page_fault+0x285/0x550
> [ 2932.608534]  [<ffffffff8107c683>] do_group_exit+0x43/0xb0
> [ 2932.610757]  [<ffffffff8107c704>] SyS_exit_group+0x14/0x20
> [ 2932.613920]  [<ffffffff81001c92>] do_syscall_64+0x82/0xf0
> [ 2932.617071]  [<ffffffff8190903e>] entry_SYSCALL_64_after_swapgs+0x58/0xc6
> [ 2932.620705] ---[ end trace 8ef0d875e55c5ad1 ]---
> 
> 
> At the time of running I was doing
>> dohell 5&
> followed by
>> latency
> 
> Long story:
> Xenomai version is 3.0.7,
> Kernel is 4.9.90-ish
> 
> The kernel is a x86-64 yocto/meta-intel kernel patched with xenomai patches. Unfortunately they didn't have their branch merged at Linux 4.9.90 so I had to merge their mainline-linux branch into their project-branch myself, but there were no changes from their part compared to their previous "release-tag" and the merge was mostly ok except for some macros in intel hardware detection code for different sound chips.
> 
> Also, patching the xenomai-patches (4.9.90-x86-6 something..) went ok,  (except for som stupid whitespace-stuff in a mmu-function).
> 
> I will try with another kernel but I was having some troubles with module configuration since the default does not write any modules to the flash.

I would indeed be helpful if you can reproduce the issue with the 
ipipe-4.9 kernel we provide. The yocto-linux kernel is unfortunately not 
in a good shape /wrt will-never-go-upstream patches (like yocto is in 
general), though those patches should not touch core infrastructure 
(AFAIK). What is the added-value of that kernel you would need?

Jan
-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

