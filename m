MIME-Version: 1.0
References: <0cb43191-7b16-2e4b-cb49-807b26d3b45b@rambler.ru>
In-Reply-To: <0cb43191-7b16-2e4b-cb49-807b26d3b45b@rambler.ru>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 3 Sep 2018 10:54:12 -0400
Message-ID: <CALLqZ8T4HPVNMHKcn0UsxpMYQKY+WeDerYAgLPOfXt6EUT7Q2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] kernel BUG
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: leo <feedcom@rambler.ru>
Cc: Xenomai@xenomai.org

On Mon., Sep. 3, 2018, 10:28 a.m. leo, <feedcom@rambler.ru> wrote:

>
> Good day!
>
> I'm learning Xenomai technology by reading the documentation.
> The first small step is to try to push the ipipe-arm64 4.14.4 core
> upstream.
> Philippe's idea to consistently apply a set of patches is very good and
> I almost got it.
> First used 80 pieces 4.14.38 ipipe-noarch to kernel v4.14.65,
> To the fact that I did it, I used the last of 7 pieces from ipipe-arm64
> 4.14.4 ( what belongs to arm64 ).
> And fixed compilation errors.
> Second step. I made a General patch ipipe-arm 4.14.62 (actual for today)
> and applied it to the core 4.14.67.
> Then applied a set of patches for arm64 from kernel 4.14.65.
>
> In both cases, /usr/xenomai/cyclictest shows:
> 99.98% of results is in the range of 0 - 50 milliseconds.
> 0.02% is in the range of 51-150 milliseconds.
>
> But while running, when starting firefox or apt install or dpkg -i, an
> error is printed that I can't handle.
>
> [  160.408477] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [  160.413968] Modules linked in: ir_lirc_codec lirc_dev
> snd_soc_simple_card snd_soc_simple_card_utils snd_soc_hdmi_codec
> sunxi_cir sun4i_i2s hid_a4m
> [  160.450662] CPU: 2 PID: 3493 Comm: mkimage Not tainted
> 4.14.67-ipipe-sunxi64 #6
> [  160.458124] Hardware name: Xunlong Orange Pi PC 2 (DT)
> [  160.463420] I-pipe domain: Linux
> [  160.466644] task: ffff800034cb8000 task.stack: ffff00000c538000
> [  160.472564] PC is at __find_get_block+0x2a0/0x340
> [  160.477265] LR is at __find_get_block+0x24/0x340
> [  160.482081] pc : [<ffff000008279078>] lr : [<ffff000008278dfc>]
> pstate: 80000145
> [  160.489631] sp : ffff00000c53b880
> [  160.493104] x29: ffff00000c53b880 x28: ffff80000974a000
> [  160.499022] x27: 0000000000001000 x26: 0000000000000010
> [  160.504927] x25: 00000000000000cb x24: ffff8000367b8340
> [  160.510680] x23: 0000000000000008 x22: 00000000000000cb
> [  160.516145] x21: ffff8000367b8340 x20: ffff00000c53ba70
> [  160.521896] x19: 0000000000001000 x18: 000000000000054b
> [  160.527206] x17: 00000000004281e0 x16: 0000ffff9ca3b478
> [  160.532515] x15: 0000ffff9ca0ae08 x14: 0000ffff9ca18308
> [  160.537978] x13: 0000ffff9cb8d048 x12: 0000000000000000
> [  160.543868] x11: 0000000000000000 x10: 0101010101010101
> [  160.549460] x9 : 0000000000000000 x8 : ffff8000352ce4e0
> [  160.554929] x7 : 0000000000000000 x6 : 0000000000000000
> [  160.560674] x5 : 0000000000000000 x4 : 0000000000000140
> [  160.565983] x3 : ffff000008d59710 x2 : 0000000000001000
> [  160.571292] x1 : 00000000000000cb x0 : 0000000000000001
> [  160.576800] Process mkimage (pid: 3493, stack limit =
> 0xffff00000c538000)
> [  160.583741] Call trace:
> [  160.586188] Exception stack(0xffff00000c53b740 to 0xffff00000c53b880)
> [  160.592917] b740: 0000000000000001 00000000000000cb 0000000000001000
> ffff000008d59710
> [  160.601181] b760: 0000000000000140 0000000000000000 0000000000000000
> 0000000000000000
> [  160.609166] b780: ffff8000352ce4e0 0000000000000000 0101010101010101
> 0000000000000000
> [  160.617267] b7a0: 0000000000000000 0000ffff9cb8d048 0000ffff9ca18308
> 0000ffff9ca0ae08
> [  160.625248] b7c0: 0000ffff9ca3b478 00000000004281e0 000000000000054b
> 0000000000001000
> [  160.633068] b7e0: ffff00000c53ba70 ffff8000367b8340 00000000000000cb
> 0000000000000008
> [  160.641175] b800: ffff8000367b8340 00000000000000cb 0000000000000010
> 0000000000001000
> [  160.649158] b820: ffff80000974a000 ffff00000c53b880 ffff000008278dfc
> ffff00000c53b880
> [  160.656978] b840: ffff000008279078 0000000080000145 0000000000001000
> 0000000053800002
> [  160.665086] b860: 0000ffffffffffff ffff000008089fe0 ffff00000c53b880
> ffff000008279078
> [  160.673072] [<ffff000008279078>] __find_get_block+0x2a0/0x340
> [  160.678811] [<ffff000008279140>] __getblk_gfp+0x28/0x2c0
> [  160.684455] [<ffff0000082e5ef4>] __ext4_get_inode_loc+0xe4/0x3b0
> [  160.690959] [<ffff0000082ea9e4>] ext4_reserve_inode_write+0x54/0xf0
> [  160.697389] [<ffff0000082ead04>] ext4_mark_inode_dirty+0x4c/0x1b0
> [  160.703730] [<ffff0000082ef07c>] ext4_dirty_inode+0x44/0x70
> [  160.709456] [<ffff00000826eedc>] __mark_inode_dirty+0x3c/0x208
> [  160.715285] [<ffff00000825d320>] generic_update_time+0x68/0xa8
> [  160.721406] [<ffff00000825d6a0>] file_update_time+0xe8/0x128
> [  160.727228] [<ffff0000082ef338>] ext4_page_mkwrite+0x68/0x4b0
> [  160.732972] [<ffff0000081def5c>] do_page_mkwrite+0x34/0xa8
> [  160.738721] [<ffff0000081e175c>] do_wp_page+0x264/0x5e8
> [  160.744388] [<ffff0000081e4c50>] __handle_mm_fault+0x750/0xce0
> [  160.750656] [<ffff0000081e52ec>] handle_mm_fault+0x10c/0x1d0
> [  160.756475] [<ffff0000080995b4>] do_page_fault+0x1cc/0x480
> [  160.762030] [<ffff000008080bc8>] do_mem_abort+0x68/0x100
> [  160.767334] Exception stack(0xffff00000c53bec0 to 0xffff00000c53c000)
> [  160.774052] bec0: 0000000000815a17 000000005b8ac4a8 0000000056190527
> 0000000000000048
> [  160.782318] bee0: 0000000000000008 0000000000000010 fefefefefefeff47
> 7f7f7f7f7f7f7f7f
> [  160.790579] bf00: 0101010101010101 0000000000000003 0101010101010101
> 0000000000000000
> [  160.798841] bf20: 0000000000000000 0000ffff9cb8d048 0000ffff9ca18308
> 0000ffff9ca0ae08
> [  160.807104] bf40: 0000ffff9ca3b478 00000000004281e0 000000000000054b
> 0000ffff9c1f1000
> [  160.815084] bf60: 0000000000428f10 0000000000429000 00000000a52721e5
> 0000ffffd3830bb8
> [  160.822903] bf80: 0000000000428f10 00000000004176e8 0000000000000000
> 0000000000000000
> [  160.831010] bfa0: 0000000000000000 0000ffffd3830c40 00000000004039c8
> 0000ffffd3830b10
> [  160.839261] bfc0: 0000000000403a00 0000000020000000 0000000000000000
> 00000000ffffffff
> [  160.847245] bfe0: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
> [  160.855168] [<ffff000008082eac>] el0_da+0x20/0x24
> [  160.860191] Code: 17ffffab aa1503e0 97fd0a98 17ffffe6 (d4210000)
> [  160.866454] ------------[ cut here ]------------
> [  160.871232] kernel BUG at fs/buffer.c:1279!
> [  160.875579] ---[ end trace a7edb645be9f1aef ]---
>
> the code in the fs/buffer file.c:1279! around the line looks:
>
> 1276    static inline void check_irqs_on(void)
> 1277    {
> 1278    #ifdef irqs_disabled
> 1279        BUG_ON(irqs_disabled());
> 1280    #endif
> 1281    }
>
> and
> [  160.756475] [<ffff0000080995b4>] do_page_fault+0x1cc/0x480
> [  160.762030] [<ffff000008080bc8>] do_mem_abort+0x68/0x100
> These two lines point to the files:
> arch/arm64/mm/fault.c
> arch/arm64/kernel/entry.S
>
> Help please to understand that I did something wrong by promoting code
> arm64,
> or, this error applies to kernel 4.14.(65-67) and the ext4 file system?
>
> Attached to the letter a set of patches for the kernel 4.14.67
>
> ---------
>
> Leonid
>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: ipipe-arm-arm64-4.14.67.tar.gz
> Type: application/gzip
> Size: 168925 bytes
> Desc: not available
> URL: <
> http://xenomai.org/pipermail/xenomai/attachments/20180903/b6393c70/attachment.bin
> >
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


Do you see the error when using the ipipe-arm tree?  Want board are you
using?

Greg
