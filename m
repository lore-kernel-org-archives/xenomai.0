References: <ff7b3efb-7fb7-a26a-7412-953076de6ce6@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6a4b8afd-0e6a-e2e7-ed24-7650a4d742bf@xenomai.org>
Date: Thu, 14 Dec 2017 20:44:40 +0100
MIME-Version: 1.0
In-Reply-To: <ff7b3efb-7fb7-a26a-7412-953076de6ce6@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe: 4.4 BUG on x86, maybe on 4.9 as well
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

On 12/14/2017 08:28 PM, Jan Kiszka wrote:
> Hi Philippe,
> 
> something got broken with the exception path rework:
> 
> [    2.619458] debug: unmapping init [mem 0xffffffff81b43000-0xffffffff81ee5fff]
> [    2.622011] BUG: using __this_cpu_read() in preemptible [00000000] code: init/1
> [    2.623446] caller is __this_cpu_preempt_check+0x13/0x20
> [    2.624724] CPU: 2 PID: 1 Comm: init Not tainted 4.4.105+ #689
> [    2.626073] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014
> [    2.628911] I-pipe domain: Linux
> [    2.630083]  ffffffff81993439 ffff88003fb43c10 ffffffff813afa45 0000000000000002
> [    2.631427]  ffff88003fb38000 ffff88003fb43c50 ffffffff813db5eb ffffffff82c57340
> [    2.631427]  ffff88003fb43c98 0000000000000002 ffff88003fb44000 0000000000000000
> [    2.631427] Call Trace:
> [    2.631427]  [<ffffffff813afa45>] dump_stack+0xb2/0xdd
> [    2.631427]  [<ffffffff813db5eb>] check_preemption_disabled+0x17b/0x1c0
> [    2.631427]  [<ffffffff813db663>] __this_cpu_preempt_check+0x13/0x20
> [    2.631427]  [<ffffffff8104eb1f>] do_page_fault+0x3f/0x60
> [    2.631427]  [<ffffffff8170f8b7>] page_fault+0x27/0x60
> [    2.631427]  [<ffffffff813bcef2>] ? __clear_user+0x42/0x70
> [    2.631427]  [<ffffffff813bcf69>] clear_user+0x49/0x80
> [    2.631427]  [<ffffffff812727d4>] padzero+0x24/0x40
> [    2.631427]  [<ffffffff81274bfe>] load_elf_binary+0x8fe/0x10f0
> [    2.631427]  [<ffffffff81116ee8>] ? ipipe_unstall_root+0x58/0x90
> [    2.631427]  [<ffffffff812222c7>] search_binary_handler+0x97/0x1d0
> [    2.631427]  [<ffffffff81223b86>] do_execveat_common.isra.40+0x5d6/0x7e0
> [    2.631427]  [<ffffffff81223aff>] ? do_execveat_common.isra.40+0x54f/0x7e0
> [    2.631427]  [<ffffffff8122bb00>] ? path_openat+0x1440/0x14e0
> [    2.631427]  [<ffffffff816fff20>] ? rest_init+0xd0/0xd0
> [    2.631427]  [<ffffffff81223dbc>] do_execve+0x2c/0x30
> [    2.631427]  [<ffffffff810002eb>] run_init_process+0x2b/0x30
> [    2.631427]  [<ffffffff816fff5d>] kernel_init+0x3d/0xe0
> [    2.631427]  [<ffffffff8170d4c0>] ret_from_fork+0x40/0x70
> [    2.631427]  [<ffffffff816fff20>] ? rest_init+0xd0/0xd0
> 
> Unless you have some immediate idea, I will debug this tomorrow. Issue
> disappears when I revert the related patches in the ipipe queue.
> 

Issue may be in the changes affecting IPIPE_DO_TRAP() [4e180c151]. The
sequence used to be prologue -> handler -> restore_root, it is now
prologue -> restore_root -> handler, which basically means that the
stall bit fixup is no more, ... a fixup.

-- 
Philippe.

