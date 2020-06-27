MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Sat, 27 Jun 2020 15:23:21 +0800
Message-ID: <CAAvDm6b-4a-n8HDRRQZScEKF1AmeJyWvYA1MH9MdOC43DMGzvw@mail.gmail.com>
Subject: [RFC]Are there some potential problems that I should be aware of if I
 use the kvmalloc() instead of kmalloc() in xnheap_init()?
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi, list

I found a solution to solve the problem(i.e. page allocation failure:
order:9, mode:0x60c0c0 (GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
nodemask=(null)). But I don't know whether there are some potential problems
or not if I repalce kmalloc() function by kvmalloc() (or vmalloc()) in
xnheap_init()?

I'm using xenomai3.1+linux4.19.84.

Here is the related call trace
(the whole log is seen at the footnote, I'd try to explain
my current understanding to the related code snippet blow):
dump_stack+0x9e/0xc8
warn_alloc+0x100/0x190
__alloc_pages_slowpath+0xb93/0xbd0
__alloc_pages_nodemask+0x26d/0x2b0
alloc_pages_current+0x6a/0xe0
kmalloc_order+0x18/0x40
kmalloc_order_trace+0x24/0xb0
__kmalloc+0x20e/0x230
? __vmalloc_node_range+0x171/0x250
xnheap_init+0x87/0x200
? remove_process+0xc0/0xc0
cobalt_umm_init+0x61/0xb0

Here is my current understanding of the most related snippet:
As the aforementioned call trace, the failure has some relation
to xnheap_init().

Kzalloc() is invoked by xnheap_init() in the xenomai source code(see
https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.1/kernel/cobalt/heap.c).
For your convenience, here is the most related code:
int xnheap_init(struct xnheap *heap, void *membase, size_t size)
{
    ...
nrpages = size >> XNHEAP_PAGE_SHIFT;
heap->pagemap = kzalloc(sizeof(struct xnheap_pgentry) * nrpages,
GFP_KERNEL);
...
}


As per the source of Linux kernel
(https://elixir.bootlin.com/linux/v4.9.182/source/include/linux/slab.h#L634),
kzalloc() invokes kmalloc() with a option of __GFP_ZERO.
So, we can say that kmalloc() is finally called by xnheap_init().

What's the exact value of the variable "size" (which is one of the input
arguments of xnheap_init())?
There is a clue from the said call trace.

Attach_process() is invoked by cobalt_umm_init().
It's the attach_proceess function passes the value to xnheap_init function(
see https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.1/kernel/cobalt/posix/process.c).
For your convenience, here is the most related code:
static int attach_process(struct cobalt_process *process)
{
...
ret = cobalt_umm_init(&p->umm, CONFIG_XENO_OPT_PRIVATE_HEAPSZ * 1024,
     post_ppd_release);
if (ret)
return ret;
...
}

So, the size passes to kmalloc() has a direct relation (for details,
see below) to
CONFIG_XENO_OPT_PRIVATE_HEAPSZ.
And CONFIG_XENO_OPT_PRIVATE_HEAPSZ is set to 81920(i.e. 81920KB
memory needs to be allocated by vmalloc()) when setting the kconfig.
Our user application may report the error of out of memory if I set
CONFIG_XENO_OPT_PRIVATE_HEAPSZ to a relatively small value(say 40MB).

As I said before, I have set the size of  private heap to a huge value.
This huge memory could be allocated by __vmalloc() successfully.
The private heap is managed by "pages" and each of the pages is 512Bytes.
Xenomai uses the struct named xnheap_pgentry to indicates the usage of
each page(of the private heap).
Each xnheap_pgentry needs 12Bytes(i.e. sizeof(xnheap_pgentry)=12).

And the said variable named nrpages is equivalent to the above equation.
So another 1920KB(i.e. nrpages*sizeof(xnheap_pgentry) memory
(to indicates the usage of each page of the private heap)
has to be allocated by kmalloc(). And it finally caused the allocation
failure.

I think the kmalloc function should be replaced by kvmalloc() or
 vmalloc(). It just needs some memory to store the array of
struct xnheap_pgentry. So the memory does not need to be physically
continuous. What do you think about it?

Thank you for your attention to this matter.
Look forward to hearing from you.

Here is the whole log:
[22041.387673] HelloWorld: page allocation failure: order:9,
mode:0x60c0c0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null)
[22041.387678] HelloWorld cpuset=/ mems_allowed=0
[22041.387690] CPU: 3 PID: 27737 Comm: HelloWorldExamp Not tainted 4.19.84
[22041.387695] I-pipe domain: Linux
[22041.387697] Call Trace:
[22041.387711]  dump_stack+0x9e/0xc8
[22041.387718]  warn_alloc+0x100/0x190
[22041.387725]  __alloc_pages_slowpath+0xb93/0xbd0
[22041.387732]  __alloc_pages_nodemask+0x26d/0x2b0
[22041.387739]  alloc_pages_current+0x6a/0xe0
[22041.387744]  kmalloc_order+0x18/0x40
[22041.387748]  kmalloc_order_trace+0x24/0xb0
[22041.387754]  __kmalloc+0x20e/0x230
[22041.387759]  ? __vmalloc_node_range+0x171/0x250
[22041.387765]  xnheap_init+0x87/0x200
[22041.387770]  ? remove_process+0xc0/0xc0
[22041.387775]  cobalt_umm_init+0x61/0xb0
[22041.387779]  cobalt_process_attach+0x64/0x4c0
[22041.387784]  ? snprintf+0x45/0x70
[22041.387790]  ? security_capable+0x46/0x60
[22041.387794]  bind_personality+0x5a/0x120
[22041.387798]  cobalt_bind_core+0x27/0x60
[22041.387803]  CoBaLt_bind+0x18a/0x1d0
[22041.387812]  ? handle_head_syscall+0x3f0/0x3f0
[22041.387816]  ipipe_syscall_hook+0x119/0x340
[22041.387822]  __ipipe_notify_syscall+0xd3/0x190
[22041.387827]  ? __x64_sys_rt_sigaction+0x7b/0xd0
[22041.387832]  ipipe_handle_syscall+0x3e/0xc0
[22041.387837]  do_syscall_64+0x3b/0x250
[22041.387842]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[22041.387847] RIP: 0033:0x7ff3d074e481
[22041.387852] Code: 89 c6 48 8b 05 10 6b 21 00 c7 04 24 00 00 00 a4
8b 38 85 ff 75 43 bb 00 00 00 10 c7 44 24 04 11 00 00 00 48 89 e7 89
d8 0f 05 <bf> 04 00 00 00 48 89 c3 e8 e2 e0 ff ff 8d 53 26 83 fa 26 0f
87 46
[22041.387855] RSP: 002b:00007ffc62caf210 EFLAGS: 00000246 ORIG_RAX:
0000000010000000
[22041.387860] RAX: ffffffffffffffda RBX: 0000000010000000 RCX: 00007ff3d074e481
[22041.387863] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffc62caf210
[22041.387865] RBP: 00007ff3d20a3780 R08: 00007ffc62caf160 R09: 0000000000000000
[22041.387868] R10: 0000000000000008 R11: 0000000000000246 R12: 00007ff3d0965b00
[22041.387870] R13: 0000000001104320 R14: 00007ff3d0965d40 R15: 0000000001104050
[22041.387876] Mem-Info:
[22041.387885] active_anon:56054 inactive_anon:109301 isolated_anon:0
                active_file:110190 inactive_file:91980 isolated_file:0
                unevictable:9375 dirty:1 writeback:0 unstable:0
                slab_reclaimable:22463 slab_unreclaimable:19122
                mapped:101678 shmem:25642 pagetables:7663 bounce:0
                free:456443 free_pcp:0 free_cma:0
[22041.387891] Node 0 active_anon:224216kB inactive_anon:437204kB
active_file:440760kB inactive_file:367920kB unevictable:37500kB
isolated(anon):0kB isolated(file):0kB mapped:406712kB dirty:4kB
writeback:0kB shmem:102568kB writeback_tmp:0kB unstable:0kB
all_unreclaimable? no
[22041.387893] Node 0 DMA free:15892kB min:32kB low:44kB high:56kB
active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB
unevictable:0kB writepending:0kB present:15992kB managed:15892kB
mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB
local_pcp:0kB free_cma:0kB
[22041.387901] lowmem_reserve[]: 0 2804 3762 3762
[22041.387912] Node 0 DMA32 free:1798624kB min:5836kB low:8704kB
high:11572kB active_anon:188040kB inactive_anon:219400kB
active_file:184156kB inactive_file:346776kB unevictable:24900kB
writepending:0kB present:3017476kB managed:2927216kB mlocked:24900kB
kernel_stack:1712kB pagetables:7564kB bounce:0kB free_pcp:0kB
local_pcp:0kB free_cma:0kB
[22041.387920] lowmem_reserve[]: 0 0 958 958
[22041.387930] Node 0 Normal free:11256kB min:1992kB low:2972kB
high:3952kB active_anon:36084kB inactive_anon:218100kB
active_file:257220kB inactive_file:21148kB unevictable:12600kB
writepending:4kB present:1048576kB managed:981268kB mlocked:12600kB
kernel_stack:5280kB pagetables:23088kB bounce:0kB free_pcp:0kB
local_pcp:0kB free_cma:0kB
[22041.387938] lowmem_reserve[]: 0 0 0 0
[22041.387948] Node 0 DMA: 3*4kB (U) 3*8kB (U) 1*16kB (U) 1*32kB (U)
3*64kB (U) 0*128kB 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M)
3*4096kB (M) = 15892kB
[22041.387990] Node 0 DMA32: 14912*4kB (UME) 13850*8kB (UME) 9325*16kB
(UME) 5961*32kB (UME) 3622*64kB (UME) 2359*128kB (UME) 1128*256kB
(UME) 524*512kB (M) 194*1024kB (UM) 0*2048kB 0*4096kB = 1799872kB
[22041.388033] Node 0 Normal: 1643*4kB (UME) 71*8kB (UME) 47*16kB (UM)
35*32kB (M) 38*64kB (M) 1*128kB (M) 0*256kB 0*512kB 0*1024kB 0*2048kB
0*4096kB = 11572kB
[22041.388071] Node 0 hugepages_total=0 hugepages_free=0
hugepages_surp=0 hugepages_size=2048kB
[22041.388073] 232507 total pagecache pages
[22041.388077] 7 pages in swap cache
[22041.388079] Swap cache stats: add 1015, delete 1008, find 0/1
[22041.388081] Free swap  = 995068kB
[22041.388083] Total swap = 999420kB
[22041.388086] 1020511 pages RAM
[22041.388088] 0 pages HighMem/MovableOnly
[22041.388090] 39417 pages reserved
[22041.388092] 0 pages hwpoisoned

