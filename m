MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Wed, 13 May 2020 21:23:59 +0800
Message-ID: <CAAvDm6aVYC2HhAQOhTSM04=-3-7wyyUTVajkOO__Kfem3Kr-LA@mail.gmail.com>
Subject: BUG in low_init(): [main] binding failed: Cannot allocate memory.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi=EF=BC=8C
     I encounter a error when starts a realtime process on x86
embedded system .
     The point to be emphasized, all the realtime processes have worked
well for  more then one day.I have terminated the  realtime processes,
started them again now and then.
      When i met the error showed below, none realtime process could be
started again.

     Thank you for your attention to this matter.
     Look forward to hearing from you.

*#proceses error log*
yx@yx:~/Desktop/testfield$ sudo /usr/xenomai/demo/cyclictest
   0"000.000| BUG in low_init(): [main] binding failed: Cannot allocate
memory
yx@yx:~/Desktop/testfield$ sudo /usr/xenomai/demo/iddp-label
   0"000.000| BUG in low_init(): [main] binding failed: Cannot allocate
memory
yx@yx:~/Desktop/testfield$ sudo /usr/xenomai/demo/xddp-stream
   0"000.000| BUG in low_init(): [main] binding failed: Cannot allocate
memory

*#kernel start log which relates to xenomai*
[    1.892216] Scanning for low memory corruption every 60 seconds
[    1.893662] [Xenomai] scheduling class idle registered.
[    1.893666] [Xenomai] scheduling class rt registered.
[    1.893719] [Xenomai] SMI-enabled chipset found, but SMI workaround
disabled
                         (see xenomai.smi parameter). You might encounter
                         high latencies!
[    1.893825] I-pipe: head domain Xenomai registered.
[    2.441991] [Xenomai] Cobalt v3.1


*#some information maybe usefull*
yx@yx:~/Desktop/testfield$ cat /proc/xenomai/heap
    TOTAL      FREE  NAME
 83886080  83875840  system heap
 83886080  83885952  shared heap

yx@yx:~/Desktop/testfield$ free
              total        used        free      shared  buff/cache
available
Mem:        3924376      746036      175456      103176     3002884
2938096
Swap:        999420        1280      998140
yx@yx:~/Desktop/testfield$

*#related kernel log when process crashes*
yx@yx:~/Desktop/testfield$ dmesg
[127458.765120] cyclictest: page allocation failure: order:9,
mode:0x60c0c0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=3D(null)
[127458.765124] cyclictest cpuset=3D/ mems_allowed=3D0
[127458.765136] CPU: 1 PID: 22203 Comm: cyclictest Not tainted 4.19.84
[127458.765139] Hardware name:
[127458.765141] I-pipe domain: Linux
[127458.765143] Call Trace:
[127458.765156]  dump_stack+0x9e/0xc8
[127458.765163]  warn_alloc+0x100/0x190
[127458.765170]  __alloc_pages_slowpath+0xb93/0xbd0
[127458.765177]  __alloc_pages_nodemask+0x26d/0x2b0
[127458.765183]  alloc_pages_current+0x6a/0xe0
[127458.765189]  kmalloc_order+0x18/0x40
[127458.765193]  kmalloc_order_trace+0x24/0xb0
[127458.765199]  __kmalloc+0x20e/0x230
[127458.765204]  ? __vmalloc_node_range+0x171/0x250
[127458.765209]  xnheap_init+0x87/0x200
[127458.765214]  ? remove_process+0xc0/0xc0
[127458.765219]  cobalt_umm_init+0x61/0xb0
[127458.765224]  cobalt_process_attach+0x64/0x4c0
[127458.765230]  ? security_capable+0x46/0x60
[127458.765234]  bind_personality+0x5a/0x120
[127458.765238]  cobalt_bind_core+0x27/0x60
[127458.765243]  CoBaLt_bind+0x18a/0x1d0
[127458.765252]  ? handle_head_syscall+0x3f0/0x3f0
[127458.765256]  ipipe_syscall_hook+0x119/0x340
[127458.765262]  __ipipe_notify_syscall+0xd3/0x190
[127458.765267]  ? __x64_sys_rt_sigaction+0x7b/0xd0
[127458.765271]  ipipe_handle_syscall+0x3e/0xc0
[127458.765277]  do_syscall_64+0x3b/0x250
[127458.765282]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[127458.765287] RIP: 0033:0x7f566df60481
[127458.765292] Code: 89 c6 48 8b 05 10 6b 21 00 c7 04 24 00 00 00 a4 8b 38
85 ff 75 43 bb 00 00 00 10 c7 44 24 04 11 00 00 00 48 89 e7 89 d8 0f 05
<bf> 04 00 00 00 48 89 c3 e8 e2 e0 ff ff 8d 53 26 83 fa 26 0f 87 46
[127458.765295] RSP: 002b:00007ffc0f2f7260 EFLAGS: 00000246 ORIG_RAX:
0000000010000000
[127458.765300] RAX: ffffffffffffffda RBX: 0000000010000000 RCX:
00007f566df60481
[127458.765302] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
00007ffc0f2f7260
[127458.765305] RBP: 00007f566e383b00 R08: 00007ffc0f2f71b0 R09:
0000000000000000
[127458.765307] R10: 0000000000000008 R11: 0000000000000246 R12:
00007f566e177b00
[127458.765310] R13: 0000000000712650 R14: 00007f566e177d40 R15:
0000000000712440
[127458.765315] Mem-Info:
[127458.765323] active_anon:73467 inactive_anon:73484 isolated_anon:0
                 active_file:280299 inactive_file:358436 isolated_file:0
                 unevictable:8 dirty:2 writeback:0 unstable:0
                 slab_reclaimable:66323 slab_unreclaimable:19884
                 mapped:51606 shmem:25794 pagetables:6947 bounce:0
                 free:25150 free_pcp:0 free_cma:0
[127458.765329] Node 0 active_anon:293868kB inactive_anon:293936kB
active_file:1121196kB inactive_file:1433744kB unevictable:32kB
isolated(anon):0kB isolated(file):0kB mapped:206424kB dirty:8kB
writeback:0kB shmem:103176kB writeback_tmp:0kB unstable:0kB
all_unreclaimable? no
[127458.765332] Node 0 DMA free:15080kB min:32kB low:44kB high:56kB
active_anon:0kB inactive_anon:0kB active_file:240kB inactive_file:548kB
unevictable:0kB writepending:0kB present:15992kB managed:15892kB
mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB
local_pcp:0kB free_cma:0kB
[127458.765340] lowmem_reserve[]: 0 2805 3764 3764
[127458.765350] Node 0 DMA32 free:77852kB min:5840kB low:8712kB
high:11584kB active_anon:212020kB inactive_anon:81800kB
active_file:900260kB inactive_file:1349344kB unevictable:0kB
writepending:4kB present:3017476kB managed:2927216kB mlocked:0kB
kernel_stack:1296kB pagetables:5452kB bounce:0kB free_pcp:0kB local_pcp:0kB
free_cma:0kB
[127458.765358] lowmem_reserve[]: 0 0 958 958
[127458.765369] Node 0 Normal free:7668kB min:1992kB low:2972kB high:3952kB
active_anon:81592kB inactive_anon:212236kB active_file:220696kB
inactive_file:84104kB unevictable:32kB writepending:4kB present:1048576kB
managed:981268kB mlocked:32kB kernel_stack:5088kB pagetables:22336kB
bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[127458.765377] lowmem_reserve[]: 0 0 0 0
[127458.765387] Node 0 DMA: 4*4kB (UM) 5*8kB (UME) 1*16kB (U) 3*32kB (UME)
5*64kB (UME) 2*128kB (ME) 2*256kB (UE) 1*512kB (E) 3*1024kB (UME) 1*2048kB
(E) 2*4096kB (M) =3D 15080kB
[127458.765433] Node 0 DMA32: 1334*4kB (UME) 443*8kB (UME) 384*16kB (UME)
350*32kB (UME) 458*64kB (UME) 129*128kB (M) 27*256kB (UM) 0*512kB 0*1024kB
0*2048kB 0*4096kB =3D 78960kB
[127458.765472] Node 0 Normal: 1024*4kB (UMEH) 225*8kB (UMEH) 86*16kB
(UMEH) 13*32kB (UME) 4*64kB (M) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB
0*4096kB =3D 7944kB
[127458.765508] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_sur=
p=3D0
hugepages_size=3D2048kB
[127458.765510] 664534 total pagecache pages
[127458.765514] 3 pages in swap cache
[127458.765516] Swap cache stats: add 148, delete 145, find 0/0
[127458.765518] Free swap  =3D 998140kB
[127458.765520] Total swap =3D 999420kB
[127458.765523] 1020511 pages RAM
[127458.765524] 0 pages HighMem/MovableOnly
[127458.765526] 39417 pages reserved
[127458.765528] 0 pages hwpoisoned
yx@yx:~/Desktop/testfield$
