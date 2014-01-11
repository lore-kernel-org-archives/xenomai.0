Message-ID: <52D1B083.5090709@steinkuehler.net>
Date: Sat, 11 Jan 2014 14:58:43 -0600
From: Charles Steinkuehler <charles@steinkuehler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] BeagleBone Xenomai Latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

(Starting a new thread)
On 1/7/2014 5:13 PM, Gilles Chanteperdrix wrote:
> On 01/07/2014 11:55 PM, Charles Steinkuehler wrote:
>> On 1/7/2014 4:47 PM, Gilles Chanteperdrix wrote:
>>> Is there any chance you could trigger a trace with the I-pipe =

>>> tracer?
>
>> I can try...give me a while to sort through the I-pipe:Tracer wiki
>> page (or are there better instructions?).
>
> Enable I-pipe tracer in kernel configuration, especially
> IPIPE_TRACE_MCOUNT, and IPIPE_TRACE_VMALLOC.
>
> When the system has booted, do:
>
> echo 1 > /proc/ipipe/trace/enable
> echo 1000 > /proc/ipipe/trace/back_trace_points
>
> Then launch latency -p 200 -f
>
> Run the load you usually run (for instance dohell).
>
> When the test is finished, do
> cat /proc/ipipe/trace/frozen > /tmp/frozen.txt
>
> then post the resulting frozen.txt to this list.
>
> Expect the latency found by the test to be double the latency you get
> without the I-pipe tracer.

OK, I tested a variety of kernels.  Simply enabling the ipipe trace
options on the otherwise unchanged kernel configuration I'm using
resulted in a system that was *EXTREMELY* slow and unresponsive, even
before I enabled the iPipe trace.  After waiting the better part of a
day for a GUI application to launch, I gave up on this kernel and tested
one with the recommended performance options:


Already in the BeagleBone Xenomai kernels I've been building:
> optimize for size
> disable CONFIG_PREEMPT
> enable stack unwinding
> disable root thread priority coupling (xenomai option)

Updated to desired setting in dbg_opt kernel:
> disable unlocked context switch (xenomai option)
> disable CONFIG_SMP

Recommended but not selected (causes linking errors apparently due to
the kernel size being too large for some of the limited reach thumb2
jump/branch instructions):
> Also note that there are some options which improve latency, such as:
> compiling kernel and user-space using thumb2 (but in that case do not
> forget to enable ARM_ERRATA_430973)

This resulted in a much more usable kernel and the resulting frozen
details are attached, along with the kernel configuration for reference.

Let me know if you spot anything, or if I can provide any more details.

I also have a couple frozen dumps from the debugging kernel with really
awful performance, if it's of interest.

OVERALL RESULTS:
Adding the recommended options dramatically helped with latency when
iPipe trace was enabled, but not so much for the normal kernel.  I did
see typical and best case latency drop significantly (by about 25%) with
the recommended options, but worst-case latency for both kernels
remained around 50 uS.  This is still a substantial improvement over the
80-90 uS worst-case latencies I was getting with the first Xenomai
kernels for the BeagleBone (prior to the official release of a supported
iPipe patch).

-- =

Charles Steinkuehler
charles@steinkuehler.net
-------------- next part --------------
I-pipe frozen back-tracing service on 3.8.13xenomai-dbg_opt-bone33/ipipe re=
lease #3
------------------------------------------------------------
CPU: 0, Freeze: 91813954129 cycles, Trace Points: 1000 (+10)
Calibrated minimum trace-point overhead: 0.680 us

 +----- Hard IRQs ('|': locked)
 |+-- Xenomai
 ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||			  +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||			  |	   +- NMI noise ('N')
 |||			  |	   |
	  Type	  User Val.   Time    Delay  Function (Parent)
:    #func               -1804	  1.000  ipipe_unstall_root+0x10 (_raw_spin_=
unlock_irq+0x1c)
:|   #begin   0x80000000 -1803	  0.720  ipipe_unstall_root+0x2c (_raw_spin_=
unlock_irq+0x1c)
:|   #func               -1802	  1.000  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000 -1801+   1.480  ipipe_unstall_root+0x64 (_raw_spin=
_unlock_irq+0x1c)
:    +func               -1800	  0.680  rcu_bh_qs+0x10 (__do_softirq+0x168)
:|   +begin   0x80000001 -1799	  0.760  rcu_bh_qs+0x2c (__do_softirq+0x168)
:|   #end     0x80000001 -1798	  1.000  rcu_bh_qs+0x4c (__do_softirq+0x168)
:    #func               -1797	  0.680  ipipe_unstall_root+0x10 (rcu_bh_qs+=
0x9c)
:|   #begin   0x80000000 -1797+   1.040  ipipe_unstall_root+0x2c (rcu_bh_qs=
+0x9c)
:|   #func               -1796	  0.720  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000 -1795	  0.960  ipipe_unstall_root+0x64 (rcu_bh_qs+=
0x9c)
:|   +begin   0x80000001 -1794+   1.040  __do_softirq+0x18c (irq_exit+0x54)
:|   #end     0x80000001 -1793	  0.720  __do_softirq+0x1ac (irq_exit+0x54)
:    #func               -1792+   1.320  __local_bh_enable+0x10 (__do_softi=
rq+0x1d8)
:    #func               -1791+   1.120  ipipe_root_only+0x10 (__local_bh_e=
nable+0x9c)
:    #func               -1790+   1.360  idle_cpu+0x10 (irq_exit+0x5c)
:    #func               -1789	  0.960  rcu_irq_exit+0x10 (irq_exit+0x98)
:|   #begin   0x80000001 -1788	  0.800  rcu_irq_exit+0x2c (irq_exit+0x98)
:|   #end     0x80000001 -1787+   2.000  rcu_irq_exit+0x4c (irq_exit+0x98)
:|   #begin   0x80000000 -1785+   1.240  __ipipe_do_sync_stage+0x22c (__ipi=
pe_do_sync_pipeline+0x9c)
:|   +end     0x00000053 -1784	  0.600  __ipipe_grab_irq+0x94 (omap3_intc_h=
andle_irq+0x70)
:|   +func               -1783+   1.080  __ipipe_exit_irq+0x10 (__ipipe_gra=
b_irq+0x9c)
:|   +func               -1782+   1.120  __ipipe_check_root_interruptible+0=
x10 (__irq_svc+0x5c)
:|   +func               -1781	  0.640  __ipipe_bugon_irqs_enabled+0x10 (__=
ipipe_fast_svc_irq_exit+0x4)
:|   +end     0x90000000 -1780+   1.200  __ipipe_fast_svc_irq_exit+0x18 (ip=
ipe_unstall_root+0x68)
:    +func               -1779	  0.640  mempool_alloc+0x14 (get_request+0x2=
ec)
:    +func               -1778	  1.000  ipipe_root_only+0x10 (mempool_alloc=
+0x2c)
:    +func               -1777+   1.120  _cond_resched+0x10 (mempool_alloc+=
0x30)
:    +func               -1776	  0.720  mempool_alloc_slab+0x10 (mempool_al=
loc+0x64)
:    +func               -1775	  0.800  kmem_cache_alloc+0x14 (mempool_allo=
c_slab+0x24)
:|   +begin   0x80000001 -1775+   1.040  kmem_cache_alloc+0x58 (mempool_all=
oc_slab+0x24)
:|   #end     0x80000001 -1774+   2.400  kmem_cache_alloc+0x78 (mempool_all=
oc_slab+0x24)
:    #func               -1771+   1.400  ipipe_unstall_root+0x10 (kmem_cach=
e_alloc+0xd8)
:|   #begin   0x80000000 -1770	  0.760  ipipe_unstall_root+0x2c (kmem_cache=
_alloc+0xd8)
:|   #func               -1769	  1.000  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000 -1768+   1.680  ipipe_unstall_root+0x64 (kmem_cach=
e_alloc+0xd8)
:    +func               -1766+   4.480  blk_rq_init+0x10 (get_request+0x30=
0)
:    +func               -1762+   1.280  elv_set_request+0x10 (get_request+=
0x36c)
:    +func               -1761+   1.320  cfq_set_request+0x14 (elv_set_requ=
est+0x2c)
:    +func               -1759	  0.720  ipipe_root_only+0x10 (cfq_set_reque=
st+0x5c)
:    +func               -1759	  0.680  _cond_resched+0x10 (cfq_set_request=
+0x60)
:    +func               -1758	  0.680  _raw_spin_lock_irq+0x10 (cfq_set_re=
quest+0x68)
:|   +begin   0x80000001 -1757	  0.800  _raw_spin_lock_irq+0x30 (cfq_set_re=
quest+0x68)
:|   #end     0x80000001 -1756+   4.280  _raw_spin_lock_irq+0x50 (cfq_set_r=
equest+0x68)
:    #func               -1752	  0.720  _raw_spin_unlock_irq+0x10 (cfq_set_=
request+0x204)
:    #func               -1751	  1.000  ipipe_unstall_root+0x10 (_raw_spin_=
unlock_irq+0x1c)
:|   #begin   0x80000000 -1750	  0.840  ipipe_unstall_root+0x2c (_raw_spin_=
unlock_irq+0x1c)
:|   #func               -1750	  0.720  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000 -1749	  1.000  ipipe_unstall_root+0x64 (_raw_spin_=
unlock_irq+0x1c)
:    +func               -1748+   2.160  get_io_context+0x10 (get_request+0=
x388)
:    +func               -1746+   1.840  init_request_from_bio+0x10 (blk_qu=
eue_bio+0x1d0)
:    +func               -1744+   1.320  blk_rq_bio_prep+0x10 (init_request=
_from_bio+0x6c)
:    +func               -1742+   1.240  blk_recount_segments+0x10 (bio_phy=
s_segments+0x20)
:    +func               -1741+   3.040  __blk_recalc_rq_segments+0x14 (blk=
_recount_segments+0x28)
:    +func               -1738+   1.600  page_address+0x10 (blk_rq_bio_prep=
+0x60)
:    +func               -1737	  0.680  _raw_spin_lock_irq+0x10 (blk_queue_=
bio+0x2d8)
:|   +begin   0x80000001 -1736	  0.960  _raw_spin_lock_irq+0x30 (blk_queue_=
bio+0x2d8)
:|   #end     0x80000001 -1735+   1.640  _raw_spin_lock_irq+0x50 (blk_queue=
_bio+0x2d8)
:    #func               -1733+   2.520  drive_stat_acct+0x10 (blk_queue_bi=
o+0x2e8)
:    #func               -1731+   2.320  disk_map_sector_rcu+0x10 (drive_st=
at_acct+0x94)
:    #func               -1728+   1.360  part_round_stats+0x10 (drive_stat_=
acct+0xe4)
:    #func               -1727+   1.240  part_round_stats_single.isra.16+0x=
10 (part_round_stats+0x48)
:    #func               -1726+   1.120  part_round_stats_single.isra.16+0x=
10 (part_round_stats+0x54)
:    #func               -1725+   3.440  __elv_add_request+0x10 (blk_queue_=
bio+0x2f8)
:    #func               -1721+   2.440  elv_rqhash_add+0x10 (__elv_add_req=
uest+0x264)
:    #func               -1719	  0.760  cfq_insert_request+0x10 (__elv_add_=
request+0x214)
:    #func               -1718+   2.280  cfq_init_prio_data+0x10 (cfq_inser=
t_request+0x30)
:    #func               -1716+   1.120  cfq_add_rq_rb+0x14 (cfq_insert_req=
uest+0x78)
:    #func               -1715+   1.360  elv_rb_add+0x10 (cfq_add_rq_rb+0x5=
4)
:    #func               -1713+   1.520  cfq_choose_req+0x14 (cfq_add_rq_rb=
+0xd0)
:    #func               -1712+   3.160  cfq_prio_tree_add+0x10 (cfq_add_rq=
_rb+0xe8)
:    #func               -1709+   1.120  __cfq_update_io_thinktime+0x10 (cf=
q_insert_request+0xb4)
:    #func               -1708+   4.200  __cfq_update_io_thinktime+0x10 (cf=
q_insert_request+0xc4)
:    #func               -1703+   1.320  __blk_run_queue+0x10 (blk_queue_bi=
o+0x300)
:    #func               -1702+   2.000  mmc_request_fn+0x10 (__blk_run_que=
ue+0x44)
:    #func               -1700+   1.280  wake_up_process+0x10 (mmc_request_=
fn+0x78)
:    #func               -1699	  0.720  try_to_wake_up+0x10 (wake_up_proces=
s+0x40)
:    #func               -1698	  1.000  _raw_spin_lock_irqsave+0x10 (try_to=
_wake_up+0x2c)
:|   #begin   0x80000001 -1697	  0.680  _raw_spin_lock_irqsave+0x30 (try_to=
_wake_up+0x2c)
:|   #end     0x80000001 -1696+   1.480  _raw_spin_lock_irqsave+0x50 (try_t=
o_wake_up+0x2c)
:    #func               -1695+   1.320  _raw_spin_lock+0x10 (try_to_wake_u=
p+0x60)
:    #func               -1694+   1.040  activate_task+0x10 (try_to_wake_up=
+0x70)
:    #func               -1693	  1.000  enqueue_task+0x10 (activate_task+0x=
38)
:    #func               -1692+   2.200  update_rq_clock+0x10 (enqueue_task=
+0x24)
:    #func               -1689+   2.360  enqueue_task_fair+0x14 (enqueue_ta=
sk+0x58)
:    #func               -1687+   2.560  update_curr+0x14 (enqueue_task_fai=
r+0x58)
:    #func               -1684+   2.880  update_min_vruntime+0x10 (update_c=
urr+0xc0)
:    #func               -1682+   3.440  update_cfs_shares+0x10 (enqueue_ta=
sk_fair+0xa8)
:    #func               -1678+   1.960  __enqueue_entity+0x10 (enqueue_tas=
k_fair+0x360)
:    #func               -1676+   1.160  ttwu_do_wakeup.constprop.74+0x10 (=
try_to_wake_up+0xd8)
:    #func               -1675+   1.480  check_preempt_curr+0x10 (ttwu_do_w=
akeup.constprop.74+0x60)
:    #func               -1673+   2.160  check_preempt_wakeup+0x10 (check_p=
reempt_curr+0x38)
:    #func               -1671	  0.960  update_curr+0x14 (check_preempt_wak=
eup+0x130)
:    #func               -1670+   1.320  wakeup_preempt_entity+0x10 (check_=
preempt_wakeup+0x148)
:    #func               -1669	  0.800  set_next_buddy+0x10 (check_preempt_=
wakeup+0x160)
:    #func               -1668+   1.200  resched_task+0x10 (check_preempt_w=
akeup+0x168)
:|   #begin   0x80000001 -1667+   1.040  resched_task+0x44 (check_preempt_w=
akeup+0x168)
:|   #end     0x80000001 -1666	  0.960  resched_task+0x60 (check_preempt_wa=
keup+0x168)
:    #func               -1665+   1.400  _raw_spin_unlock+0x10 (try_to_wake=
_up+0xe0)
:    #func               -1664	  1.000  _raw_spin_unlock_irqrestore+0x10 (t=
ry_to_wake_up+0x134)
:    #func               -1663	  0.720  _raw_spin_unlock_irq+0x10 (blk_queu=
e_bio+0x308)
:    #func               -1662	  1.000  ipipe_unstall_root+0x10 (_raw_spin_=
unlock_irq+0x1c)
:|   #begin   0x80000000 -1661	  0.800  ipipe_unstall_root+0x2c (_raw_spin_=
unlock_irq+0x1c)
:|   #func               -1660	  0.720  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000 -1659+   2.400  ipipe_unstall_root+0x64 (_raw_spin=
_unlock_irq+0x1c)
:    +func               -1657+   1.240  bio_put+0x10 (submit_bh+0x254)
:    +func               -1656	  0.720  ipipe_root_only+0x10 (ext4_bread+0x=
54)
:    +func               -1655	  1.000  _cond_resched+0x10 (ext4_bread+0x58)
:    +func               -1654	  0.640  __cond_resched+0x10 (_cond_resched+=
0x48)
:    +func               -1653	  1.000  ipipe_root_only+0x10 (__cond_resche=
d+0x18)
:    +func               -1652	  0.720  __schedule+0x14 (__cond_resched+0x3=
4)
:    +func               -1652	  0.680  rcu_sched_qs+0x10 (__schedule+0x34)
:|   +begin   0x80000001 -1651+   1.200  rcu_sched_qs+0x2c (__schedule+0x34)
:|   #end     0x80000001 -1650+   1.120  rcu_sched_qs+0x4c (__schedule+0x34)
:    #func               -1649	  0.920  ipipe_unstall_root+0x10 (rcu_sched_=
qs+0xd4)
:|   #begin   0x80000000 -1648	  0.760  ipipe_unstall_root+0x2c (rcu_sched_=
qs+0xd4)
:|   #func               -1647	  0.720  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000 -1646	  0.760  ipipe_unstall_root+0x64 (rcu_sched_=
qs+0xd4)
:    +func               -1646+   1.040  ipipe_root_only+0x10 (__schedule+0=
x48)
:    +func               -1644	  0.640  _raw_spin_lock_irq+0x10 (__schedule=
+0x9c)
:|   +begin   0x80000001 -1644+   1.320  _raw_spin_lock_irq+0x30 (__schedul=
e+0x9c)
:|   #end     0x80000001 -1643+   1.200  _raw_spin_lock_irq+0x50 (__schedul=
e+0x9c)
:    #func               -1641+   1.240  update_rq_clock+0x10 (__schedule+0=
x1e4)
:    #func               -1640+   1.240  put_prev_task_fair+0x10 (__schedul=
e+0x1f8)
:    #func               -1639	  0.960  update_curr+0x14 (put_prev_task_fai=
r+0x38)
:    #func               -1638+   2.320  update_min_vruntime+0x10 (update_c=
urr+0xc0)
:    #func               -1636+   1.800  cpuacct_charge+0x10 (update_curr+0=
x12c)
:    #func               -1634+   1.400  __enqueue_entity+0x10 (put_prev_ta=
sk_fair+0xac)
:    #func               -1632	  1.000  update_curr+0x14 (put_prev_task_fai=
r+0x38)
:    #func               -1631+   1.960  __enqueue_entity+0x10 (put_prev_ta=
sk_fair+0xac)
:    #func               -1629+   1.040  pick_next_task_fair+0x10 (__schedu=
le+0x220)
:    #func               -1628	  0.960  __pick_first_entity+0x10 (pick_next=
_task_fair+0x2c)
:    #func               -1627+   1.040  wakeup_preempt_entity+0x10 (pick_n=
ext_task_fair+0x9c)
:    #func               -1626+   1.600  clear_buddies+0x10 (pick_next_task=
_fair+0xb0)
:    #func               -1625	  1.000  set_next_entity+0x10 (pick_next_tas=
k_fair+0xbc)
:    #func               -1624+   1.560  update_stats_wait_end+0x10 (set_ne=
xt_entity+0x2c)
:    #func               -1622+   3.120  __dequeue_entity+0x10 (set_next_en=
tity+0x38)
:|   #begin   0x80000001 -1619	  0.680  __schedule+0x274 (__cond_resched+0x=
34)
:|   #end     0x80000001 -1618+   3.200  __schedule+0x298 (__cond_resched+0=
x34)
:|   #begin   0x80000000 -1615+   2.160  __schedule+0x464 (__cond_resched+0=
x34)
:|   #func               -1613+   1.440  __ipipe_switch_to_notifier_call_ch=
ain+0x10 (__switch_to+0x2c)
:|   #func               -1612	  1.000  atomic_notifier_call_chain+0x14 (__=
ipipe_switch_to_notifier_call_chain+0x6c)
:|   #func               -1611	  0.680  __atomic_notifier_call_chain+0x14 (=
atomic_notifier_call_chain+0x28)
:|   #func               -1610	  0.760  notifier_call_chain+0x10 (__atomic_=
notifier_call_chain+0x28)
:|   #func               -1609+   1.680  vfp_notifier+0x10 (notifier_call_c=
hain+0x48)
:|   #func               -1607+   2.160  thumbee_notifier+0x10 (notifier_ca=
ll_chain+0x48)
:|   #func               -1605+   2.240  __ipipe_restore_root_nosync+0x10 (=
__ipipe_switch_to_notifier_call_chain+0x7c)
:|   #func               -1603+   1.160  __ipipe_switch_tail+0x10 (__schedu=
le+0x504)
:|   #end     0x80000000 -1602	  0.760  __ipipe_switch_tail+0x70 (__schedul=
e+0x504)
:    #func               -1601	  1.000  finish_task_switch.constprop.72+0x1=
0 (__schedule+0x514)
:    #func               -1600+   1.160  _raw_spin_unlock_irq+0x10 (finish_=
task_switch.constprop.72+0x60)
:    #func               -1599	  0.680  ipipe_unstall_root+0x10 (_raw_spin_=
unlock_irq+0x1c)
:|   #begin   0x80000000 -1598+   1.080  ipipe_unstall_root+0x2c (_raw_spin=
_unlock_irq+0x1c)
:|   #func               -1597	  0.760  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000 -1596+   3.520  ipipe_unstall_root+0x64 (_raw_spin=
_unlock_irq+0x1c)
:    +func               -1593	  0.720  down+0x10 (mmc_queue_thread+0x44)
:    +func               -1592	  0.640  _raw_spin_lock_irqsave+0x10 (down+0=
x1c)
:|   +begin   0x80000001 -1592+   1.440  _raw_spin_lock_irqsave+0x30 (down+=
0x1c)
:|   #end     0x80000001 -1590+   1.640  _raw_spin_lock_irqsave+0x50 (down+=
0x1c)
:    #func               -1589	  0.800  _raw_spin_unlock_irqrestore+0x10 (d=
own+0x48)
:    #func               -1588	  0.920  ipipe_unstall_root+0x10 (_raw_spin_=
unlock_irqrestore+0x28)
:|   #begin   0x80000000 -1587	  0.760  ipipe_unstall_root+0x2c (_raw_spin_=
unlock_irqrestore+0x28)
:|   #func               -1586+   1.040  ipipe_root_only+0x10 (ipipe_unstal=
l_root+0x30)
:|   +end     0x80000000 -1585	  0.720  ipipe_unstall_root+0x64 (_raw_spin_=
unlock_irqrestore+0x28)
:    +func               -1584	  0.720  _raw_spin_lock_irq+0x10 (mmc_queue_=
thread+0x4c)
:|   +begin   0x80000001 -1584	  0.720  _raw_spin_lock_irq+0x30 (mmc_queue_=
thread+0x4c)
:|   #end     0x80000001 -1583+   1.360  _raw_spin_lock_irq+0x50 (mmc_queue=
_thread+0x4c)
:    #func               -1581	  0.880  blk_fetch_request+0x10 (mmc_queue_t=
hread+0x60)
:    #func               -1581+   1.840  blk_peek_request+0x10 (blk_fetch_r=
equest+0x18)
:    #func               -1579+   2.120  cfq_dispatch_requests+0x14 (blk_pe=
ek_request+0x1e0)
:|   #begin   0x90000000 -1577+   1.160  __irq_svc+0x44 (cfq_dispatch_reque=
sts+0x1b8)
:|   #func               -1575+   1.320  omap3_intc_handle_irq+0x10 (__irq_=
svc+0x58)
:|   #func               -1574	  0.920  irq_find_mapping+0x10 (omap3_intc_h=
andle_irq+0x64)
:|   #func               -1573+   1.480  irq_domain_legacy_revmap+0x10 (irq=
_find_mapping+0x5c)
:|   #func               -1572	  0.680  __ipipe_grab_irq+0x10 (omap3_intc_h=
andle_irq+0x70)
:|   #begin   0x00000053 -1571	  1.000  __ipipe_grab_irq+0x24 (omap3_intc_h=
andle_irq+0x70)
:|   #func               -1570+   1.040  __ipipe_dispatch_irq+0x10 (__ipipe=
_grab_irq+0x8c)
:|   #func               -1569+   1.680  irq_to_desc+0x10 (__ipipe_dispatch=
_irq+0x4c)
:|   #func               -1567+   1.680  irq_to_desc+0x10 (__ipipe_dispatch=
_irq+0x2ac)
:|   #func               -1566	  0.720  __ipipe_ack_hrtimer_irq+0x10 (__ipi=
pe_dispatch_irq+0xd8)
:|   #func               -1565	  0.720  __ipipe_ack_level_irq+0x10 (__ipipe=
_ack_hrtimer_irq+0x30)
:|   #func               -1564+   1.320  omap_mask_ack_irq+0x10 (__ipipe_ac=
k_level_irq+0x4c)
:|   #func               -1563+   1.280  irq_gc_mask_disable_reg+0x10 (omap=
_mask_ack_irq+0x18)
:|   #func               -1562+   1.040  omap2_gp_timer_ack+0x10 (__ipipe_a=
ck_hrtimer_irq+0x40)
:|   #func               -1561	  0.960  __ipipe_end_level_irq+0x10 (__ipipe=
_ack_hrtimer_irq+0x58)
:|   #func               -1560+   1.440  irq_gc_unmask_enable_reg+0x10 (__i=
pipe_end_level_irq+0x24)
:|  #*func               -1558+   2.360  xnintr_clock_handler+0x14 (__ipipe=
_dispatch_irq+0x1cc)
:|  #*func               -1556+   1.520  xntimer_tick_aperiodic+0x14 (xnint=
r_clock_handler+0x128)
:|  #*func               -1554	  1.000  xnthread_periodic_handler+0x10 (xnt=
imer_tick_aperiodic+0xac)
:|  #*func               -1553+   1.440  xnpod_resume_thread+0x14 (xnthread=
_periodic_handler+0x30)
:|  #*[ 3238] samplin 99 -1552+   1.960  xnpod_resume_thread+0x108 (xnthrea=
d_periodic_handler+0x30)
:|  #*func               -1550+   1.160  xntimer_next_local_shot+0x10 (xnti=
mer_tick_aperiodic+0x208)
:|  #*event   tick@-1277 -1549	  0.920  xntimer_next_local_shot+0xd0 (xntim=
er_tick_aperiodic+0x208)
:|  #*func               -1548	  0.760  ipipe_timer_set+0x10 (xntimer_next_=
local_shot+0xd8)
:|  #*func               -1547+   2.760  omap2_gp_timer_set_next_event+0x10=
 (ipipe_timer_set+0x64)
:|  #*func               -1544+   1.920  __xnpod_schedule+0x14 (xnintr_cloc=
k_handler+0x29c)
:|  #*[ 3827] -<?>-   -1 -1542	  0.680  __xnpod_schedule+0x134 (xnintr_cloc=
k_handler+0x29c)
:|  #*func               -1542+   2.680  xnsched_pick_next+0x10 (__xnpod_sc=
hedule+0x160)
:|  #*func               -1539+   3.160  check_and_switch_context+0x14 (__x=
npod_schedule+0x3ec)
:|  #*[ 3238] samplin 99 -1536+   2.520  __xnpod_schedule+0x45c (xnpod_susp=
end_thread+0x444)
:|  #*func               -1533+   1.960  xntimer_get_overruns+0x14 (xnpod_w=
ait_thread_period+0x168)
:|  #*func               -1531	  0.880  __ipipe_restore_head+0x10 (xnpod_wa=
it_thread_period+0x2e8)
:|  +*end     0x80000000 -1531+   1.480  __ipipe_restore_head+0x108 (xnpod_=
wait_thread_period+0x2e8)
:   +*func               -1529+   1.040  __ipipe_uaccess_might_fault+0x10 (=
__rt_task_wait_period+0x48)
:|  +*begin   0x80000001 -1528	  0.920  __ipipe_uaccess_might_fault+0x2c (_=
_rt_task_wait_period+0x48)
:|  +*end     0x80000001 -1527+   2.200  __ipipe_uaccess_might_fault+0x8c (=
__rt_task_wait_period+0x48)
:|  +*begin   0x80000001 -1525+   1.240  __ipipe_notify_syscall+0xc0 (__ipi=
pe_syscall_root+0x84)
:|  +*end     0x80000001 -1524	  0.760  __ipipe_notify_syscall+0x138 (__ipi=
pe_syscall_root+0x84)
:|  +*begin   0x80000000 -1523+   1.240  __ipipe_syscall_root+0xa0 (vector_=
swi+0x7c)
:|  +*end     0x80000000 -1522	  0.880  __ipipe_syscall_root+0x11c (vector_=
swi+0x7c)
:|  +*func               -1521	  0.960  __ipipe_bugon_irqs_enabled+0x10 (__=
ipipe_ret_to_user_irqs_disabled+0x4)
:|  +*end     0x90000000 -1520+   4.400  __ipipe_ret_to_user_irqs_disabled+=
0x18 (<b6f245e0>)
:|  +*begin   0x90000000 -1515+   1.120  vector_swi+0x3c (<b6f245dc>)
:   +*func               -1514+   1.080  __ipipe_syscall_root+0x10 (vector_=
swi+0x7c)
:   +*func               -1513	  0.680  __ipipe_notify_syscall+0x14 (__ipip=
e_syscall_root+0x84)
:|  +*begin   0x80000001 -1513	  0.720  __ipipe_notify_syscall+0x34 (__ipip=
e_syscall_root+0x84)
:|  +*end     0x80000001 -1512+   1.200  __ipipe_notify_syscall+0x94 (__ipi=
pe_syscall_root+0x84)
:   +*func               -1511+   1.120  ipipe_syscall_hook+0x10 (__ipipe_n=
otify_syscall+0xa4)
:   +*func               -1509+   1.720  hisyscall_event+0x14 (ipipe_syscal=
l_hook+0x44)
:   +*func               -1508	  0.720  __rt_task_wait_period+0x14 (hisysca=
ll_event+0x17c)
:   +*func               -1507	  0.720  rt_task_wait_period+0x10 (__rt_task=
_wait_period+0x24)
:   +*func               -1506	  0.960  xnpod_wait_thread_period+0x14 (rt_t=
ask_wait_period+0x48)
:|  +*begin   0x80000000 -1505+   1.680  xnpod_wait_thread_period+0x3c (rt_=
task_wait_period+0x48)
:|  #*func               -1504+   1.760  xnpod_suspend_thread+0x14 (xnpod_w=
ait_thread_period+0x144)
:|  #*func               -1502+   1.200  __xnpod_schedule+0x14 (xnpod_suspe=
nd_thread+0x444)
:|  #*[ 3238] samplin 99 -1501	  0.680  __xnpod_schedule+0x134 (xnpod_suspe=
nd_thread+0x444)
:|  #*func               -1500+   1.920  xnsched_pick_next+0x10 (__xnpod_sc=
hedule+0x160)
:|  #*func               -1498+   2.160  check_and_switch_context+0x14 (__x=
npod_schedule+0x3ec)
:|  #*[   66] mmcqd/0 -1 -1496+   2.360  __xnpod_schedule+0x45c (xnintr_clo=
ck_handler+0x29c)
:|   #func               -1494+   1.480  __ipipe_do_sync_pipeline+0x10 (__i=
pipe_dispatch_irq+0x28c)
:|   #end     0x00000053 -1492	  0.680  __ipipe_grab_irq+0x94 (omap3_intc_h=
andle_irq+0x70)
:|   #func               -1491+   1.680  __ipipe_exit_irq+0x10 (__ipipe_gra=
b_irq+0x9c)
:|   #func               -1490+   1.360  __ipipe_check_root_interruptible+0=
x10 (__irq_svc+0x5c)
:|   #func               -1488	  0.680  __ipipe_bugon_irqs_enabled+0x10 (__=
ipipe_fast_svc_irq_exit+0x4)
:|   #end     0x90000000 -1488+   2.120  __ipipe_fast_svc_irq_exit+0x18 (cf=
q_dispatch_requests+0x1b8)
:    #func               -1486+   3.960  cfq_should_idle+0x10 (cfq_dispatch=
_requests+0x674)
:    #func               -1482+   1.040  cfq_dispatch_insert+0x10 (cfq_disp=
atch_requests+0x7e8)
:    #func               -1481+   2.720  cfq_find_next_rq+0x14 (cfq_dispatc=
h_insert+0x38)
:    #func               -1478	  0.800  cfq_choose_req+0x14 (cfq_find_next_=
rq+0x98)
:    #func               -1477+   1.440  cfq_remove_request+0x10 (cfq_dispa=
tch_insert+0x44)
:    #func               -1476+   3.640  elv_rb_del+0x10 (cfq_remove_reques=
t+0x90)
:    #func               -1472	  0.680  elv_dispatch_sort+0x10 (cfq_dispatc=
h_insert+0x6c)
:    #func               -1471+   3.520  elv_rqhash_del.isra.1+0x10 (elv_di=
spatch_sort+0x34)
:    #func               -1468+   2.320  cfq_activate_request+0x10 (blk_pee=
k_request+0x64)
:    #func               -1465+   2.400  mmc_prep_request+0x10 (blk_peek_re=
quest+0x114)
:    #func               -1463+   1.280  blk_start_request+0x10 (blk_fetch_=
request+0x24)
:    #func               -1462+   1.960  blk_dequeue_request+0x10 (blk_star=
t_request+0x1c)
:    #func               -1460+   1.360  blk_add_timer+0x10 (blk_start_requ=
est+0x3c)
:    #func               -1458+   1.200  _raw_spin_unlock_irq+0x10 (mmc_que=
ue_thread+0x74)
:    #func               -1457	  0.760  ipipe_unstall_root+0x10 (_raw_spin_=
unlock_irq+0x1c)
:|   #begin   0x80000000 -1457+   1.280  ipipe_unstall_root+0x2c (_raw_spin=
_unlock_irq+0x1c)
:|   #func               -1455	  1.000  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000 -1454+   1.560  ipipe_unstall_root+0x64 (_raw_spin=
_unlock_irq+0x1c)
:    +func               -1453+   1.280  mmc_blk_issue_rq+0x14 (mmc_queue_t=
hread+0xa8)
:    +func               -1451+   1.960  __mmc_claim_host+0x14 (mmc_blk_iss=
ue_rq+0x44)
:    +func               -1449	  0.800  ipipe_root_only+0x10 (__mmc_claim_h=
ost+0x5c)
:    +func               -1449+   1.240  _cond_resched+0x10 (__mmc_claim_ho=
st+0x60)
:    +func               -1447	  0.720  add_wait_queue+0x10 (__mmc_claim_ho=
st+0x6c)
:    +func               -1447	  0.680  _raw_spin_lock_irqsave+0x10 (add_wa=
it_queue+0x30)
:|   +begin   0x80000001 -1446+   1.080  _raw_spin_lock_irqsave+0x30 (add_w=
ait_queue+0x30)
:|   #end     0x80000001 -1445+   1.720  _raw_spin_lock_irqsave+0x50 (add_w=
ait_queue+0x30)
:    #func               -1443+   1.080  _raw_spin_unlock_irqrestore+0x10 (=
add_wait_queue+0x54)
:    #func               -1442	  0.680  ipipe_unstall_root+0x10 (_raw_spin_=
unlock_irqrestore+0x28)
:|   #begin   0x80000000 -1441	  0.760  ipipe_unstall_root+0x2c (_raw_spin_=
unlock_irqrestore+0x28)
:|   #func               -1441	  1.000  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000 -1440	  0.960  ipipe_unstall_root+0x64 (_raw_spin_=
unlock_irqrestore+0x28)
:    +func               -1439	  0.640  _raw_spin_lock_irqsave+0x10 (__mmc_=
claim_host+0x74)
:|   +begin   0x80000001 -1438	  0.760  _raw_spin_lock_irqsave+0x30 (__mmc_=
claim_host+0x74)
:|   #end     0x80000001 -1437+   2.080  _raw_spin_lock_irqsave+0x50 (__mmc=
_claim_host+0x74)
:    #func               -1435	  1.000  _raw_spin_unlock_irqrestore+0x10 (_=
_mmc_claim_host+0x144)
:    #func               -1434	  0.680  ipipe_unstall_root+0x10 (_raw_spin_=
unlock_irqrestore+0x28)
:|   #begin   0x80000000 -1434	  0.760  ipipe_unstall_root+0x2c (_raw_spin_=
unlock_irqrestore+0x28)
:|   #func               -1433	  1.000  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000 -1432	  0.960  ipipe_unstall_root+0x64 (_raw_spin_=
unlock_irqrestore+0x28)
:    +func               -1431	  0.680  remove_wait_queue+0x10 (__mmc_claim=
_host+0x150)
:    +func               -1430	  0.640  _raw_spin_lock_irqsave+0x10 (remove=
_wait_queue+0x20)
:|   +begin   0x80000001 -1430	  0.760  _raw_spin_lock_irqsave+0x30 (remove=
_wait_queue+0x20)
:|   #end     0x80000001 -1429+   1.320  _raw_spin_lock_irqsave+0x50 (remov=
e_wait_queue+0x20)
:    #func               -1427	  0.760  _raw_spin_unlock_irqrestore+0x10 (r=
emove_wait_queue+0x4c)
:    #func               -1427	  0.680  ipipe_unstall_root+0x10 (_raw_spin_=
unlock_irqrestore+0x28)
:|   #begin   0x80000000 -1426+   1.040  ipipe_unstall_root+0x2c (_raw_spin=
_unlock_irqrestore+0x28)
:|   #func               -1425	  0.760  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000 -1424+   1.400  ipipe_unstall_root+0x64 (_raw_spin=
_unlock_irqrestore+0x28)
:    +func               -1423+   1.400  omap_hsmmc_enable_fclk+0x10 (__mmc=
_claim_host+0x17c)
:    +func               -1421+   1.240  __pm_runtime_resume+0x10 (omap_hsm=
mc_enable_fclk+0x20)
:    +func               -1420	  0.680  ipipe_root_only+0x10 (__pm_runtime_=
resume+0x34)
:    +func               -1419	  0.920  _cond_resched+0x10 (__pm_runtime_re=
sume+0x38)
:    +func               -1419	  0.680  _raw_spin_lock_irqsave+0x10 (__pm_r=
untime_resume+0x64)
:|   +begin   0x80000001 -1418	  0.960  _raw_spin_lock_irqsave+0x30 (__pm_r=
untime_resume+0x64)
:|   #end     0x80000001 -1417+   1.520  _raw_spin_lock_irqsave+0x50 (__pm_=
runtime_resume+0x64)
:    #func               -1415+   3.400  rpm_resume+0x14 (__pm_runtime_resu=
me+0x74)
:    #func               -1412	  0.800  _raw_spin_unlock_irqrestore+0x10 (_=
_pm_runtime_resume+0x84)
:    #func               -1411	  0.680  ipipe_unstall_root+0x10 (_raw_spin_=
unlock_irqrestore+0x28)
:|   #begin   0x80000000 -1411+   1.080  ipipe_unstall_root+0x2c (_raw_spin=
_unlock_irqrestore+0x28)
:|   #func               -1409	  0.720  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000 -1409+   1.040  ipipe_unstall_root+0x64 (_raw_spin=
_unlock_irqrestore+0x28)
:    +func               -1408+   3.160  dev_get_drvdata+0x10 (mmc_blk_issu=
e_rq+0x4c)
:    +func               -1405+   1.840  mmc_blk_issue_rw_rq+0x14 (mmc_blk_=
issue_rq+0x434)
:    +func               -1403+   4.400  mmc_blk_rw_rq_prep+0x10 (mmc_blk_i=
ssue_rw_rq+0x9c)
:    +func               -1398+   4.320  mmc_set_data_timeout+0x10 (mmc_blk=
_rw_rq_prep+0x268)
:    +func               -1394+   1.160  mmc_queue_map_sg+0x10 (mmc_blk_rw_=
rq_prep+0x27c)
:    +func               -1393+   1.960  blk_rq_map_sg+0x14 (mmc_queue_map_=
sg+0x34)
:    +func               -1391+   3.600  __blk_segment_map_sg+0x14 (blk_rq_=
map_sg+0xa0)
:    +func               -1387+   1.640  mmc_queue_bounce_pre+0x10 (mmc_blk=
_rw_rq_prep+0x2e8)
:    +func               -1386+   1.480  mmc_start_req+0x10 (mmc_blk_issue_=
rw_rq+0xb8)
:    +func               -1384+   2.080  omap_hsmmc_pre_req+0x10 (mmc_start=
_req+0x48)
:    +func               -1382+   2.520  omap_hsmmc_pre_dma_transfer+0x14 (=
omap_hsmmc_pre_req+0x5c)
:    +func               -1380+   2.400  page_address+0x10 (omap_hsmmc_pre_=
dma_transfer+0xc8)
:    +func               -1377+   1.960  arm_dma_map_sg+0x14 (omap_hsmmc_pr=
e_dma_transfer+0x100)
:    +func               -1375+   2.000  arm_dma_map_page+0x10 (arm_dma_map=
_sg+0x74)
:    +func               -1373+   1.720  __dma_page_cpu_to_dev+0x14 (arm_dm=
a_map_page+0x48)
:    +func               -1371+   1.400  dma_cache_maint_page+0x10 (__dma_p=
age_cpu_to_dev+0x34)
:    +func               -1370+   7.960  page_address+0x10 (dma_cache_maint=
_page+0x108)
:    +func               -1362	  0.920  __mmc_start_req+0x10 (mmc_start_req=
+0xe4)
:    +func               -1361+   3.200  __init_waitqueue_head+0x10 (__mmc_=
start_req+0x38)
:    +func               -1358+   1.160  led_trigger_event+0x10 (__mmc_star=
t_req+0x130)
:    +func               -1357+   1.920  _raw_read_lock+0x10 (led_trigger_e=
vent+0x2c)
:    +func               -1355+   1.760  led_set_brightness+0x10 (led_trigg=
er_event+0x40)
:    +func               -1353+   1.920  gpio_led_set+0x10 (led_set_brightn=
ess+0x64)
:    +func               -1351+   2.320  __gpio_set_value+0x10 (gpio_led_se=
t+0x78)
:    +func               -1349	  0.920  gpio_set+0x10 (__gpio_set_value+0xe=
0)
:    +func               -1348	  0.720  __ipipe_spin_lock_irqsave+0x10 (gpi=
o_set+0x30)
:|   +begin   0x80000001 -1347+   1.200  __ipipe_spin_lock_irqsave+0x30 (gp=
io_set+0x30)
:|   #func               -1346+   2.960  _set_gpio_dataout_reg+0x10 (gpio_s=
et+0x48)
:|   #func               -1343	  0.960  __ipipe_spin_unlock_irqrestore+0x10=
 (gpio_set+0x54)
:|   +end     0x80000001 -1342+   1.120  __ipipe_spin_unlock_irqrestore+0x5=
0 (gpio_set+0x54)
:    +func               -1341+   1.680  _raw_read_unlock+0x10 (led_trigger=
_event+0x54)
:    +func               -1339+   2.280  omap_hsmmc_request+0x14 (__mmc_sta=
rt_req+0x144)
:    +func               -1337+   1.760  set_data_timeout+0x10 (omap_hsmmc_=
request+0x27c)
:    +func               -1335+   1.120  clk_get_rate+0x10 (set_data_timeou=
t+0x3c)
:    +func               -1334	  0.680  mutex_lock+0x10 (clk_get_rate+0x20)
:    +func               -1333	  0.720  ipipe_root_only+0x10 (mutex_lock+0x=
1c)
:    +func               -1333+   1.040  _cond_resched+0x10 (mutex_lock+0x2=
0)
:    +func               -1332+   1.480  __mutex_lock_slowpath+0x14 (mutex_=
lock+0x28)
:|   +begin   0x80000001 -1330+   1.320  __mutex_lock_slowpath+0x90 (mutex_=
lock+0x28)
:|   #end     0x80000001 -1329+   3.880  __mutex_lock_slowpath+0xb0 (mutex_=
lock+0x28)
:    #func               -1325	  0.960  ipipe_unstall_root+0x10 (__mutex_lo=
ck_slowpath+0x2d0)
:|   #begin   0x80000000 -1324	  0.720  ipipe_unstall_root+0x2c (__mutex_lo=
ck_slowpath+0x2d0)
:|   #func               -1323	  1.000  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000 -1322+   2.440  ipipe_unstall_root+0x64 (__mutex_l=
ock_slowpath+0x2d0)
:    +func               -1320	  0.960  __clk_get_rate+0x10 (clk_get_rate+0=
x48)
:    +func               -1319	  0.920  mutex_unlock+0x10 (clk_get_rate+0x5=
4)
:    +func               -1318+   1.280  __mutex_unlock_slowpath+0x10 (mute=
x_unlock+0x18)
:|   +begin   0x80000001 -1317+   1.040  __mutex_unlock_slowpath+0x88 (mute=
x_unlock+0x18)
:|   #end     0x80000001 -1316+   2.640  __mutex_unlock_slowpath+0xa8 (mute=
x_unlock+0x18)
:    #func               -1313	  0.680  ipipe_unstall_root+0x10 (__mutex_un=
lock_slowpath+0x148)
:|   #begin   0x80000000 -1312	  1.000  ipipe_unstall_root+0x2c (__mutex_un=
lock_slowpath+0x148)
:|   #func               -1311	  0.720  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000 -1311+   3.520  ipipe_unstall_root+0x64 (__mutex_u=
nlock_slowpath+0x148)
:    +func               -1307+   1.960  edma_control+0x14 (omap_hsmmc_requ=
est+0x338)
:    +func               -1305+   1.400  omap_hsmmc_pre_dma_transfer+0x14 (=
omap_hsmmc_request+0x354)
:    +func               -1304+   1.800  edma_prep_slave_sg+0x14 (omap_hsmm=
c_request+0x38c)
:    +func               -1302+   1.120  __kmalloc+0x14 (edma_prep_slave_sg=
+0xec)
:|   +begin   0x80000001 -1301+   1.040  __kmalloc+0x90 (edma_prep_slave_sg=
+0xec)
:|   #end     0x80000001 -1300+   2.280  __kmalloc+0xb4 (edma_prep_slave_sg=
+0xec)
:    #func               -1298	  0.640  ipipe_unstall_root+0x10 (__kmalloc+=
0x114)
:|   #begin   0x80000000 -1297	  0.960  ipipe_unstall_root+0x2c (__kmalloc+=
0x114)
:|   #func               -1296	  1.000  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000 -1295+   5.360  ipipe_unstall_root+0x64 (__kmalloc=
+0x114)
:    +func               -1290+   1.760  dma_async_tx_descriptor_init+0x10 =
(edma_prep_slave_sg+0x2cc)
:    +func               -1288	  0.960  vchan_tx_submit+0x10 (omap_hsmmc_re=
quest+0x3c0)
:    +func               -1287	  0.680  _raw_spin_lock_irqsave+0x10 (vchan_=
tx_submit+0x28)
:|   +begin   0x80000001 -1286	  0.760  _raw_spin_lock_irqsave+0x30 (vchan_=
tx_submit+0x28)
:|   #end     0x80000001 -1285+   1.640  _raw_spin_lock_irqsave+0x50 (vchan=
_tx_submit+0x28)
:    #func               -1284	  0.800  _raw_spin_unlock_irqrestore+0x10 (v=
chan_tx_submit+0x6c)
:    #func               -1283	  0.960  ipipe_unstall_root+0x10 (_raw_spin_=
unlock_irqrestore+0x28)
:|   #begin   0x80000000 -1282	  0.760  ipipe_unstall_root+0x2c (_raw_spin_=
unlock_irqrestore+0x28)
:|   #func               -1281	  0.720  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000 -1281+   1.160  ipipe_unstall_root+0x64 (_raw_spin=
_unlock_irqrestore+0x28)
:    +func               -1279	  0.680  edma_issue_pending+0x10 (omap_hsmmc=
_request+0x3d8)
:    +func               -1279	  0.680  _raw_spin_lock_irqsave+0x10 (edma_i=
ssue_pending+0x24)
:|   +begin   0x80000001 -1278	  1.000  _raw_spin_lock_irqsave+0x30 (edma_i=
ssue_pending+0x24)
:|   #end     0x80000001 -1277+   1.600  _raw_spin_lock_irqsave+0x50 (edma_=
issue_pending+0x24)
:    #func               -1275+   1.840  edma_execute+0x10 (edma_issue_pend=
ing+0x7c)
:    #func               -1274+   1.040  edma_write_slot+0x10 (edma_execute=
+0x78)
:|   #begin   0x90000000 -1273+   1.160  __irq_svc+0x44 (__ipipe_trace+0x40=
8)
:|   #func               -1271+   1.640  omap3_intc_handle_irq+0x10 (__irq_=
svc+0x58)
:|   #func               -1270+   1.400  irq_find_mapping+0x10 (omap3_intc_=
handle_irq+0x64)
:|   #func               -1268+   1.120  irq_domain_legacy_revmap+0x10 (irq=
_find_mapping+0x5c)
:|   #func               -1267	  0.640  __ipipe_grab_irq+0x10 (omap3_intc_h=
andle_irq+0x70)
:|   #begin   0x00000053 -1267	  0.800  __ipipe_grab_irq+0x24 (omap3_intc_h=
andle_irq+0x70)
:|   #func               -1266+   1.280  __ipipe_dispatch_irq+0x10 (__ipipe=
_grab_irq+0x8c)
:|   #func               -1265+   1.720  irq_to_desc+0x10 (__ipipe_dispatch=
_irq+0x4c)
:|   #func               -1263	  1.000  irq_to_desc+0x10 (__ipipe_dispatch_=
irq+0x2ac)
:|   #func               -1262	  0.920  __ipipe_ack_hrtimer_irq+0x10 (__ipi=
pe_dispatch_irq+0xd8)
:|   #func               -1261	  0.720  __ipipe_ack_level_irq+0x10 (__ipipe=
_ack_hrtimer_irq+0x30)
:|   #func               -1260+   1.240  omap_mask_ack_irq+0x10 (__ipipe_ac=
k_level_irq+0x4c)
:|   #func               -1259+   1.120  irq_gc_mask_disable_reg+0x10 (omap=
_mask_ack_irq+0x18)
:|   #func               -1258+   1.120  omap2_gp_timer_ack+0x10 (__ipipe_a=
ck_hrtimer_irq+0x40)
:|   #func               -1257	  0.960  __ipipe_end_level_irq+0x10 (__ipipe=
_ack_hrtimer_irq+0x58)
:|   #func               -1256+   1.760  irq_gc_unmask_enable_reg+0x10 (__i=
pipe_end_level_irq+0x24)
:|  #*func               -1254+   2.200  xnintr_clock_handler+0x14 (__ipipe=
_dispatch_irq+0x1cc)
:|  #*func               -1252+   1.840  xntimer_tick_aperiodic+0x14 (xnint=
r_clock_handler+0x128)
:|  #*func               -1250	  0.960  xnthread_periodic_handler+0x10 (xnt=
imer_tick_aperiodic+0xac)
:|  #*func               -1249+   1.160  xnpod_resume_thread+0x14 (xnthread=
_periodic_handler+0x30)
:|  #*[ 3783] servo-t 98 -1248+   2.400  xnpod_resume_thread+0x108 (xnthrea=
d_periodic_handler+0x30)
:|  #*func               -1245+   1.080  xntimer_next_local_shot+0x10 (xnti=
mer_tick_aperiodic+0x208)
:|  #*event   tick@-1100 -1244	  0.920  xntimer_next_local_shot+0xd0 (xntim=
er_tick_aperiodic+0x208)
:|  #*func               -1243	  0.720  ipipe_timer_set+0x10 (xntimer_next_=
local_shot+0xd8)
:|  #*func               -1243+   2.520  omap2_gp_timer_set_next_event+0x10=
 (ipipe_timer_set+0x64)
:|  #*func               -1240+   1.760  __xnpod_schedule+0x14 (xnintr_cloc=
k_handler+0x29c)
:|  #*[   66] mmcqd/0 -1 -1238	  0.640  __xnpod_schedule+0x134 (xnintr_cloc=
k_handler+0x29c)
:|  #*func               -1238+   2.600  xnsched_pick_next+0x10 (__xnpod_sc=
hedule+0x160)
:|  #*func               -1235+   2.720  check_and_switch_context+0x14 (__x=
npod_schedule+0x3ec)
:|  #*[ 3783] servo-t 98 -1232+   3.000  __xnpod_schedule+0x45c (xnpod_susp=
end_thread+0x444)
:|  #*func               -1229+   1.760  xntimer_get_overruns+0x14 (xnpod_w=
ait_thread_period+0x168)
:|  #*func               -1228	  0.880  __ipipe_restore_head+0x10 (xnpod_wa=
it_thread_period+0x2e8)
:|  +*end     0x80000000 -1227+   1.160  __ipipe_restore_head+0x108 (xnpod_=
wait_thread_period+0x2e8)
:   +*func               -1226+   1.080  __ipipe_uaccess_might_fault+0x10 (=
__rt_task_wait_period+0x48)
:|  +*begin   0x80000001 -1225+   1.480  __ipipe_uaccess_might_fault+0x2c (=
__rt_task_wait_period+0x48)
:|  +*end     0x80000001 -1223+   2.720  __ipipe_uaccess_might_fault+0x8c (=
__rt_task_wait_period+0x48)
:|  +*begin   0x80000001 -1220	  0.880  __ipipe_notify_syscall+0xc0 (__ipip=
e_syscall_root+0x84)
:|  +*end     0x80000001 -1219	  0.720  __ipipe_notify_syscall+0x138 (__ipi=
pe_syscall_root+0x84)
:|  +*begin   0x80000000 -1219+   1.160  __ipipe_syscall_root+0xa0 (vector_=
swi+0x7c)
:|  +*end     0x80000000 -1218	  0.800  __ipipe_syscall_root+0x11c (vector_=
swi+0x7c)
:|  +*func               -1217	  0.720  __ipipe_bugon_irqs_enabled+0x10 (__=
ipipe_ret_to_user_irqs_disabled+0x4)
:|  +*end     0x90000000 -1216!  89.160  __ipipe_ret_to_user_irqs_disabled+=
0x18 (<b6f2f5e0>)
:|  +*begin   0x90000000 -1127+   2.040  vector_swi+0x3c (<b6f2f5dc>)
:   +*func               -1125+   1.160  __ipipe_syscall_root+0x10 (vector_=
swi+0x7c)
:   +*func               -1124	  0.680  __ipipe_notify_syscall+0x14 (__ipip=
e_syscall_root+0x84)
:|  +*begin   0x80000001 -1123	  0.720  __ipipe_notify_syscall+0x34 (__ipip=
e_syscall_root+0x84)
:|  +*end     0x80000001 -1122+   1.280  __ipipe_notify_syscall+0x94 (__ipi=
pe_syscall_root+0x84)
:   +*func               -1121	  0.800  ipipe_syscall_hook+0x10 (__ipipe_no=
tify_syscall+0xa4)
:   +*func               -1120+   1.280  hisyscall_event+0x14 (ipipe_syscal=
l_hook+0x44)
:   +*func               -1119+   1.080  __rt_task_wait_period+0x14 (hisysc=
all_event+0x17c)
:   +*func               -1118	  0.840  rt_task_wait_period+0x10 (__rt_task=
_wait_period+0x24)
:   +*func               -1117	  1.000  xnpod_wait_thread_period+0x14 (rt_t=
ask_wait_period+0x48)
:|  +*begin   0x80000000 -1116+   2.120  xnpod_wait_thread_period+0x3c (rt_=
task_wait_period+0x48)
:|  #*func               -1114+   1.440  xnpod_suspend_thread+0x14 (xnpod_w=
ait_thread_period+0x144)
:|  #*func               -1112+   1.280  __xnpod_schedule+0x14 (xnpod_suspe=
nd_thread+0x444)
:|  #*[ 3783] servo-t 98 -1111	  0.960  __xnpod_schedule+0x134 (xnpod_suspe=
nd_thread+0x444)
:|  #*func               -1110+   2.360  xnsched_pick_next+0x10 (__xnpod_sc=
hedule+0x160)
:|  #*func               -1108+   2.520  check_and_switch_context+0x14 (__x=
npod_schedule+0x3ec)
:|  #*[   66] mmcqd/0 -1 -1105+   2.880  __xnpod_schedule+0x45c (xnintr_clo=
ck_handler+0x29c)
:|   #func               -1102+   1.760  __ipipe_do_sync_pipeline+0x10 (__i=
pipe_dispatch_irq+0x28c)
:|   #end     0x00000053 -1101	  0.680  __ipipe_grab_irq+0x94 (omap3_intc_h=
andle_irq+0x70)
:|   #func               -1100+   1.520  __ipipe_exit_irq+0x10 (__ipipe_gra=
b_irq+0x9c)
:|   #func               -1099+   1.440  __ipipe_check_root_interruptible+0=
x10 (__irq_svc+0x5c)
:|   #func               -1097	  0.680  __ipipe_bugon_irqs_enabled+0x10 (__=
ipipe_fast_svc_irq_exit+0x4)
:|   #end     0x90000000 -1096+   1.160  __ipipe_fast_svc_irq_exit+0x18 (__=
ipipe_trace+0x408)
:|   #begin   0x90000000 -1095+   1.200  __irq_svc+0x44 (__ipipe_trace+0x40=
8)
:|   #func               -1094	  0.960  omap3_intc_handle_irq+0x10 (__irq_s=
vc+0x58)
:|   #func               -1093+   1.240  irq_find_mapping+0x10 (omap3_intc_=
handle_irq+0x64)
:|   #func               -1092+   1.160  irq_domain_legacy_revmap+0x10 (irq=
_find_mapping+0x5c)
:|   #func               -1091	  0.680  __ipipe_grab_irq+0x10 (omap3_intc_h=
andle_irq+0x70)
:|   #begin   0x00000053 -1090+   1.040  __ipipe_grab_irq+0x24 (omap3_intc_=
handle_irq+0x70)
:|   #func               -1089	  0.720  __ipipe_dispatch_irq+0x10 (__ipipe_=
grab_irq+0x8c)
:|   #func               -1088+   1.160  irq_to_desc+0x10 (__ipipe_dispatch=
_irq+0x4c)
:|   #func               -1087+   1.520  irq_to_desc+0x10 (__ipipe_dispatch=
_irq+0x2ac)
:|   #func               -1086	  0.680  __ipipe_ack_hrtimer_irq+0x10 (__ipi=
pe_dispatch_irq+0xd8)
:|   #func               -1085+   1.040  __ipipe_ack_level_irq+0x10 (__ipip=
e_ack_hrtimer_irq+0x30)
:|   #func               -1084	  0.640  omap_mask_ack_irq+0x10 (__ipipe_ack=
_level_irq+0x4c)
:|   #func               -1083+   1.200  irq_gc_mask_disable_reg+0x10 (omap=
_mask_ack_irq+0x18)
:|   #func               -1082+   1.280  omap2_gp_timer_ack+0x10 (__ipipe_a=
ck_hrtimer_irq+0x40)
:|   #func               -1081	  0.680  __ipipe_end_level_irq+0x10 (__ipipe=
_ack_hrtimer_irq+0x58)
:|   #func               -1080+   1.440  irq_gc_unmask_enable_reg+0x10 (__i=
pipe_end_level_irq+0x24)
:|  #*func               -1079+   1.960  xnintr_clock_handler+0x14 (__ipipe=
_dispatch_irq+0x1cc)
:|  #*func               -1077+   1.120  xntimer_tick_aperiodic+0x14 (xnint=
r_clock_handler+0x128)
:|  #*func               -1076	  0.960  xnthread_periodic_handler+0x10 (xnt=
imer_tick_aperiodic+0xac)
:|  #*func               -1075	  0.840  xnpod_resume_thread+0x14 (xnthread_=
periodic_handler+0x30)
:|  #*[ 3238] samplin 99 -1074+   1.640  xnpod_resume_thread+0x108 (xnthrea=
d_periodic_handler+0x30)
:|  #*func               -1072+   1.440  xntimer_next_local_shot+0x10 (xnti=
mer_tick_aperiodic+0x208)
:|  #*event   tick@-620  -1071	  0.600  xntimer_next_local_shot+0xd0 (xntim=
er_tick_aperiodic+0x208)
:|  #*func               -1070	  0.720  ipipe_timer_set+0x10 (xntimer_next_=
local_shot+0xd8)
:|  #*func               -1069+   1.880  omap2_gp_timer_set_next_event+0x10=
 (ipipe_timer_set+0x64)
:|  #*func               -1067+   1.240  __xnpod_schedule+0x14 (xnintr_cloc=
k_handler+0x29c)
:|  #*[   66] mmcqd/0 -1 -1066	  0.920  __xnpod_schedule+0x134 (xnintr_cloc=
k_handler+0x29c)
:|  #*func               -1065+   1.640  xnsched_pick_next+0x10 (__xnpod_sc=
hedule+0x160)
:|  #*func               -1064+   2.920  check_and_switch_context+0x14 (__x=
npod_schedule+0x3ec)
:|  #*[ 3238] samplin 99 -1061+   2.920  __xnpod_schedule+0x45c (xnpod_susp=
end_thread+0x444)
:|  #*func               -1058+   1.320  xntimer_get_overruns+0x14 (xnpod_w=
ait_thread_period+0x168)
:|  #*func               -1056	  0.800  __ipipe_restore_head+0x10 (xnpod_wa=
it_thread_period+0x2e8)
:|  +*end     0x80000000 -1056+   1.600  __ipipe_restore_head+0x108 (xnpod_=
wait_thread_period+0x2e8)
:   +*func               -1054	  0.800  __ipipe_uaccess_might_fault+0x10 (_=
_rt_task_wait_period+0x48)
:|  +*begin   0x80000001 -1053+   1.200  __ipipe_uaccess_might_fault+0x2c (=
__rt_task_wait_period+0x48)
:|  +*end     0x80000001 -1052+   2.040  __ipipe_uaccess_might_fault+0x8c (=
__rt_task_wait_period+0x48)
:|  +*begin   0x80000001 -1050	  0.880  __ipipe_notify_syscall+0xc0 (__ipip=
e_syscall_root+0x84)
:|  +*end     0x80000001 -1049+   1.040  __ipipe_notify_syscall+0x138 (__ip=
ipe_syscall_root+0x84)
:|  +*begin   0x80000000 -1048+   1.120  __ipipe_syscall_root+0xa0 (vector_=
swi+0x7c)
:|  +*end     0x80000000 -1047	  0.720  __ipipe_syscall_root+0x11c (vector_=
swi+0x7c)
:|  +*func               -1046	  1.000  __ipipe_bugon_irqs_enabled+0x10 (__=
ipipe_ret_to_user_irqs_disabled+0x4)
:|  +*end     0x90000000 -1045+   4.160  __ipipe_ret_to_user_irqs_disabled+=
0x18 (<b6f245e0>)
:|  +*begin   0x90000000 -1041+   1.280  vector_swi+0x3c (<b6f245dc>)
:   +*func               -1040	  0.760  __ipipe_syscall_root+0x10 (vector_s=
wi+0x7c)
:   +*func               -1039	  0.640  __ipipe_notify_syscall+0x14 (__ipip=
e_syscall_root+0x84)
:|  +*begin   0x80000001 -1038	  0.960  __ipipe_notify_syscall+0x34 (__ipip=
e_syscall_root+0x84)
:|  +*end     0x80000001 -1037	  0.680  __ipipe_notify_syscall+0x94 (__ipip=
e_syscall_root+0x84)
:   +*func               -1037	  0.760  ipipe_syscall_hook+0x10 (__ipipe_no=
tify_syscall+0xa4)
:   +*func               -1036+   1.280  hisyscall_event+0x14 (ipipe_syscal=
l_hook+0x44)
:   +*func               -1035	  0.720  __rt_task_wait_period+0x14 (hisysca=
ll_event+0x17c)
:   +*func               -1034+   1.040  rt_task_wait_period+0x10 (__rt_tas=
k_wait_period+0x24)
:   +*func               -1033	  0.680  xnpod_wait_thread_period+0x14 (rt_t=
ask_wait_period+0x48)
:|  +*begin   0x80000000 -1032+   1.520  xnpod_wait_thread_period+0x3c (rt_=
task_wait_period+0x48)
:|  #*func               -1031+   1.200  xnpod_suspend_thread+0x14 (xnpod_w=
ait_thread_period+0x144)
:|  #*func               -1030	  0.840  __xnpod_schedule+0x14 (xnpod_suspen=
d_thread+0x444)
:|  #*[ 3238] samplin 99 -1029	  1.000  __xnpod_schedule+0x134 (xnpod_suspe=
nd_thread+0x444)
:|  #*func               -1028+   1.840  xnsched_pick_next+0x10 (__xnpod_sc=
hedule+0x160)
:|  #*func               -1026+   1.800  check_and_switch_context+0x14 (__x=
npod_schedule+0x3ec)
:|  #*[   66] mmcqd/0 -1 -1024+   2.240  __xnpod_schedule+0x45c (xnintr_clo=
ck_handler+0x29c)
:|   #func               -1022	  0.880  __ipipe_do_sync_pipeline+0x10 (__ip=
ipe_dispatch_irq+0x28c)
:|   #end     0x00000053 -1021	  0.640  __ipipe_grab_irq+0x94 (omap3_intc_h=
andle_irq+0x70)
:|   #func               -1020+   1.400  __ipipe_exit_irq+0x10 (__ipipe_gra=
b_irq+0x9c)
:|   #func               -1019	  0.800  __ipipe_check_root_interruptible+0x=
10 (__irq_svc+0x5c)
:|   #func               -1018	  0.600  __ipipe_bugon_irqs_enabled+0x10 (__=
ipipe_fast_svc_irq_exit+0x4)
:|   #end     0x90000000 -1018+   2.240  __ipipe_fast_svc_irq_exit+0x18 (__=
ipipe_trace+0x408)
:    #func               -1015+   6.040  _memcpy_toio+0x10 (edma_write_slot=
+0x4c)
:    #func               -1009+   2.240  edma_link+0x10 (edma_execute+0xa4)
:    #func               -1007+   2.600  edma_start+0x10 (edma_execute+0xb8)
:    #func               -1004	  0.840  _raw_spin_unlock_irqrestore+0x10 (e=
dma_issue_pending+0x88)
:    #func               -1004	  1.000  ipipe_unstall_root+0x10 (_raw_spin_=
unlock_irqrestore+0x28)
:|   #begin   0x80000000 -1003	  0.960  ipipe_unstall_root+0x2c (_raw_spin_=
unlock_irqrestore+0x28)
:|   #func               -1002	  0.800  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000 -1001+   1.840  ipipe_unstall_root+0x64 (_raw_spin=
_unlock_irqrestore+0x28)
:    +func                -999+   3.800  omap_hsmmc_start_command+0x10 (oma=
p_hsmmc_request+0x428)
:    +func                -995	  0.680  _raw_spin_lock_irq+0x10 (mmc_queue_=
thread+0x4c)
:|   +begin   0x80000001  -995+   1.040  _raw_spin_lock_irq+0x30 (mmc_queue=
_thread+0x4c)
:|   #end     0x80000001  -993+   2.320  _raw_spin_lock_irq+0x50 (mmc_queue=
_thread+0x4c)
:|   #begin   0x90000000  -991+   1.400  __irq_svc+0x44 (do_raw_spin_lock+0=
xe4)
:|   #func                -990+   1.040  omap3_intc_handle_irq+0x10 (__irq_=
svc+0x58)
:|   #func                -989	  0.720  irq_find_mapping+0x10 (omap3_intc_h=
andle_irq+0x64)
:|   #func                -988+   1.120  irq_domain_legacy_revmap+0x10 (irq=
_find_mapping+0x5c)
:|   #func                -987	  0.640  __ipipe_grab_irq+0x10 (omap3_intc_h=
andle_irq+0x70)
:|   #begin   0x00000050  -986	  0.960  __ipipe_grab_irq+0x24 (omap3_intc_h=
andle_irq+0x70)
:|   #func                -985	  0.680  __ipipe_dispatch_irq+0x10 (__ipipe_=
grab_irq+0x8c)
:|   #func                -985	  1.000  irq_to_desc+0x10 (__ipipe_dispatch_=
irq+0x4c)
:|   #func                -984+   2.200  irq_to_desc+0x10 (__ipipe_dispatch=
_irq+0x2ac)
:|   #func                -981	  0.680  __ipipe_ack_irq+0x10 (__ipipe_dispa=
tch_irq+0xd8)
:|   #func                -981	  0.640  __ipipe_ack_level_irq+0x10 (__ipipe=
_ack_irq+0x1c)
:|   #func                -980	  0.920  omap_mask_ack_irq+0x10 (__ipipe_ack=
_level_irq+0x4c)
:|   #func                -979+   1.240  irq_gc_mask_disable_reg+0x10 (omap=
_mask_ack_irq+0x18)
:|   #func                -978+   2.280  __ipipe_set_irq_pending+0x10 (__ip=
ipe_dispatch_irq+0x24c)
:|   #func                -976	  0.800  __ipipe_do_sync_pipeline+0x10 (__ip=
ipe_dispatch_irq+0x28c)
:|   #end     0x00000050  -975	  0.600  __ipipe_grab_irq+0x94 (omap3_intc_h=
andle_irq+0x70)
:|   #func                -974+   1.360  __ipipe_exit_irq+0x10 (__ipipe_gra=
b_irq+0x9c)
:|   #func                -973	  0.800  __ipipe_check_root_interruptible+0x=
10 (__irq_svc+0x5c)
:|   #func                -972	  0.600  __ipipe_bugon_irqs_enabled+0x10 (__=
ipipe_fast_svc_irq_exit+0x4)
:|   #end     0x90000000  -971+   1.400  __ipipe_fast_svc_irq_exit+0x18 (do=
_raw_spin_lock+0xe4)
:    #func                -970	  0.680  blk_fetch_request+0x10 (mmc_queue_t=
hread+0x60)
:    #func                -969+   1.160  blk_peek_request+0x10 (blk_fetch_r=
equest+0x18)
:    #func                -968+   1.760  cfq_dispatch_requests+0x14 (blk_pe=
ek_request+0x1e0)
:    #func                -966	  0.800  _raw_spin_unlock_irq+0x10 (mmc_queu=
e_thread+0x74)
:    #func                -966+   1.040  ipipe_unstall_root+0x10 (_raw_spin=
_unlock_irq+0x1c)
:|   #begin   0x80000000  -965+   1.080  ipipe_unstall_root+0x2c (_raw_spin=
_unlock_irq+0x1c)
:|   #func                -964	  0.800  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +func                -963+   2.240  __ipipe_do_sync_stage+0x10 (ipipe_=
unstall_root+0x50)
:|   #end     0x80000000  -961+   1.480  __ipipe_do_sync_stage+0x1ac (ipipe=
_unstall_root+0x50)
:    #func                -959+   1.480  __ipipe_do_IRQ+0x10 (__ipipe_do_sy=
nc_stage+0x214)
:    #func                -958	  0.720  handle_IRQ+0x10 (__ipipe_do_IRQ+0x1=
c)
:    #func                -957	  0.760  irq_enter+0x10 (handle_IRQ+0x28)
:    #func                -956	  0.960  rcu_irq_enter+0x10 (irq_enter+0x18)
:|   #begin   0x80000001  -955+   1.040  rcu_irq_enter+0x2c (irq_enter+0x18)
:|   #end     0x80000001  -954+   1.080  rcu_irq_enter+0x4c (irq_enter+0x18)
:    #func                -953+   1.400  ipipe_root_only+0x10 (irq_enter+0x=
58)
:    #func                -952	  0.640  generic_handle_irq+0x10 (handle_IRQ=
+0x70)
:    #func                -951+   1.200  irq_to_desc+0x10 (generic_handle_i=
rq+0x1c)
:    #func                -950	  0.640  handle_level_irq+0x10 (generic_hand=
le_irq+0x30)
:    #func                -949+   2.080  _raw_spin_lock+0x10 (handle_level_=
irq+0x24)
:    #func                -947+   1.040  handle_irq_event+0x10 (handle_leve=
l_irq+0xa4)
:    #func                -946+   1.160  _raw_spin_unlock+0x10 (handle_irq_=
event+0x40)
:    #func                -945+   1.240  handle_irq_event_percpu+0x14 (hand=
le_irq_event+0x4c)
:    #func                -944+   3.480  omap_hsmmc_irq+0x10 (handle_irq_ev=
ent_percpu+0x70)
:    #func                -940	  0.960  add_interrupt_randomness+0x14 (hand=
le_irq_event_percpu+0x264)
:    #func                -939+   2.640  read_current_timer+0x10 (add_inter=
rupt_randomness+0x38)
:    #func                -937+   1.520  note_interrupt+0x10 (handle_irq_ev=
ent_percpu+0x284)
:    #func                -935	  0.840  _raw_spin_lock+0x10 (handle_irq_eve=
nt+0x58)
:    #func                -934+   1.040  unmask_irq+0x10 (handle_level_irq+=
0xcc)
:|   #begin   0x80000001  -933	  0.720  unmask_irq+0x40 (handle_level_irq+0=
xcc)
:|   #func                -932	  1.000  irq_gc_unmask_enable_reg+0x10 (unma=
sk_irq+0x50)
:|   #end     0x80000001  -931	  1.000  unmask_irq+0x6c (handle_level_irq+0=
xcc)
:    #func                -930+   1.120  _raw_spin_unlock+0x10 (handle_leve=
l_irq+0xd4)
:    #func                -929	  0.960  irq_exit+0x10 (handle_IRQ+0x74)
:    #func                -928	  1.000  ipipe_root_only+0x10 (irq_exit+0x18)
:    #func                -927+   1.200  idle_cpu+0x10 (irq_exit+0x5c)
:    #func                -926+   1.040  rcu_irq_exit+0x10 (irq_exit+0x98)
:|   #begin   0x80000001  -925+   1.400  rcu_irq_exit+0x2c (irq_exit+0x98)
:|   #end     0x80000001  -924	  0.920  rcu_irq_exit+0x4c (irq_exit+0x98)
:|   #begin   0x80000000  -923+   1.280  __ipipe_do_sync_stage+0x22c (ipipe=
_unstall_root+0x50)
:|   +end     0x80000000  -921	  0.760  ipipe_unstall_root+0x64 (_raw_spin_=
unlock_irq+0x1c)
:    +func                -921	  1.000  mmc_blk_issue_rq+0x14 (mmc_queue_th=
read+0xa8)
:    +func                -920	  0.840  dev_get_drvdata+0x10 (mmc_blk_issue=
_rq+0x4c)
:    +func                -919	  1.000  mmc_blk_issue_rw_rq+0x14 (mmc_blk_i=
ssue_rq+0x434)
:    +func                -918	  0.960  mmc_start_req+0x10 (mmc_blk_issue_r=
w_rq+0xb8)
:    +func                -917+   1.040  mmc_wait_for_req_done+0x10 (mmc_st=
art_req+0x60)
:    +func                -916	  0.960  wait_for_completion+0x10 (mmc_wait_=
for_req_done+0x2c)
:    +func                -915	  0.640  wait_for_common+0x14 (wait_for_comp=
letion+0x20)
:    +func                -914+   1.040  ipipe_root_only+0x10 (wait_for_com=
mon+0x2c)
:    +func                -913	  0.800  _cond_resched+0x10 (wait_for_common=
+0x30)
:    +func                -912+   1.040  _raw_spin_lock_irq+0x10 (wait_for_=
common+0x38)
:|   +begin   0x80000001  -911	  0.680  _raw_spin_lock_irq+0x30 (wait_for_c=
ommon+0x38)
:|   #end     0x80000001  -911+   2.640  _raw_spin_lock_irq+0x50 (wait_for_=
common+0x38)
:    #func                -908	  0.800  _raw_spin_unlock_irq+0x10 (wait_for=
_common+0x134)
:    #func                -907	  0.640  ipipe_unstall_root+0x10 (_raw_spin_=
unlock_irq+0x1c)
:|   #begin   0x80000000  -907+   1.320  ipipe_unstall_root+0x2c (_raw_spin=
_unlock_irq+0x1c)
:|   #func                -905	  0.720  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000  -905+   1.120  ipipe_unstall_root+0x64 (_raw_spin=
_unlock_irq+0x1c)
:    +func                -903	  0.680  schedule_timeout+0x14 (wait_for_com=
mon+0x13c)
:    +func                -903+   1.320  schedule+0x10 (schedule_timeout+0x=
2c)
:    +func                -901	  0.680  __schedule+0x14 (schedule+0x94)
:    +func                -901	  0.680  rcu_sched_qs+0x10 (__schedule+0x34)
:|   +begin   0x80000001  -900+   1.040  rcu_sched_qs+0x2c (__schedule+0x34)
:|   #end     0x80000001  -899+   1.280  rcu_sched_qs+0x4c (__schedule+0x34)
:    #func                -898	  0.680  ipipe_unstall_root+0x10 (rcu_sched_=
qs+0xd4)
:|   #begin   0x80000000  -897+   1.080  ipipe_unstall_root+0x2c (rcu_sched=
_qs+0xd4)
:|   #func                -896	  0.720  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000  -895+   1.400  ipipe_unstall_root+0x64 (rcu_sched=
_qs+0xd4)
:    +func                -894	  0.800  ipipe_root_only+0x10 (__schedule+0x=
48)
:    +func                -893	  0.680  _raw_spin_lock_irq+0x10 (__schedule=
+0x9c)
:|   +begin   0x80000001  -892	  1.000  _raw_spin_lock_irq+0x30 (__schedule=
+0x9c)
:|   #end     0x80000001  -891+   1.840  _raw_spin_lock_irq+0x50 (__schedul=
e+0x9c)
:    #func                -890	  1.000  deactivate_task+0x10 (__schedule+0x=
560)
:    #func                -889+   1.200  dequeue_task+0x10 (deactivate_task=
+0x38)
:    #func                -887+   1.800  update_rq_clock+0x10 (dequeue_task=
+0x28)
:    #func                -886+   1.480  dequeue_task_fair+0x14 (dequeue_ta=
sk+0xb8)
:    #func                -884+   1.400  update_curr+0x14 (dequeue_task_fai=
r+0x40)
:    #func                -883+   1.840  update_min_vruntime+0x10 (update_c=
urr+0xc0)
:    #func                -881+   2.640  cpuacct_charge+0x10 (update_curr+0=
x12c)
:    #func                -878+   1.360  clear_buddies+0x10 (dequeue_task_f=
air+0xa4)
:    #func                -877+   1.040  account_entity_dequeue+0x10 (deque=
ue_task_fair+0xcc)
:    #func                -876+   1.480  update_min_vruntime+0x10 (dequeue_=
task_fair+0xf4)
:    #func                -874+   1.600  update_cfs_shares+0x10 (dequeue_ta=
sk_fair+0xfc)
:    #func                -873+   1.080  put_prev_task_fair+0x10 (__schedul=
e+0x1f8)
:    #func                -872+   1.240  pick_next_task_fair+0x10 (__schedu=
le+0x220)
:    #func                -870	  0.840  __pick_first_entity+0x10 (pick_next=
_task_fair+0x2c)
:    #func                -870	  0.920  clear_buddies+0x10 (pick_next_task_=
fair+0xb0)
:    #func                -869	  1.000  set_next_entity+0x10 (pick_next_tas=
k_fair+0xbc)
:    #func                -868+   1.840  update_stats_wait_end+0x10 (set_ne=
xt_entity+0x2c)
:    #func                -866+   2.880  __dequeue_entity+0x10 (set_next_en=
tity+0x38)
:    #func                -863	  0.800  __pick_first_entity+0x10 (pick_next=
_task_fair+0x2c)
:    #func                -862	  0.640  clear_buddies+0x10 (pick_next_task_=
fair+0xb0)
:    #func                -862	  1.000  set_next_entity+0x10 (pick_next_tas=
k_fair+0xbc)
:    #func                -861+   1.240  update_stats_wait_end+0x10 (set_ne=
xt_entity+0x2c)
:    #func                -859+   1.440  __dequeue_entity+0x10 (set_next_en=
tity+0x38)
:|   #begin   0x80000001  -858	  1.000  __schedule+0x274 (schedule+0x94)
:|   #end     0x80000001  -857+   3.200  __schedule+0x298 (schedule+0x94)
:|   #begin   0x80000000  -854+   1.440  __schedule+0x464 (schedule+0x94)
:|   #func                -852	  0.840  __switch_mm_inner+0x10 (__schedule+=
0x4c4)
:|   #func                -851+   2.880  check_and_switch_context+0x14 (__s=
witch_mm_inner+0x50)
:|   #func                -848+   1.520  __ipipe_switch_to_notifier_call_ch=
ain+0x10 (__switch_to+0x2c)
:|   #func                -847	  0.720  atomic_notifier_call_chain+0x14 (__=
ipipe_switch_to_notifier_call_chain+0x6c)
:|   #func                -846	  0.680  __atomic_notifier_call_chain+0x14 (=
atomic_notifier_call_chain+0x28)
:|   #func                -846+   1.080  notifier_call_chain+0x10 (__atomic=
_notifier_call_chain+0x28)
:|   #func                -844+   1.440  vfp_notifier+0x10 (notifier_call_c=
hain+0x48)
:|   #func                -843+   1.760  thumbee_notifier+0x10 (notifier_ca=
ll_chain+0x48)
:|   #func                -841+   1.680  __ipipe_restore_root_nosync+0x10 (=
__ipipe_switch_to_notifier_call_chain+0x7c)
:|   #func                -840	  0.760  __ipipe_switch_tail+0x10 (__schedul=
e+0x504)
:|   #end     0x80000000  -839+   1.040  __ipipe_switch_tail+0x70 (__schedu=
le+0x504)
:    #func                -838+   1.040  finish_task_switch.constprop.72+0x=
10 (__schedule+0x514)
:    #func                -837	  0.800  _raw_spin_unlock_irq+0x10 (finish_t=
ask_switch.constprop.72+0x60)
:    #func                -836	  1.000  ipipe_unstall_root+0x10 (_raw_spin_=
unlock_irq+0x1c)
:|   #begin   0x80000000  -835	  0.840  ipipe_unstall_root+0x2c (_raw_spin_=
unlock_irq+0x1c)
:|   #func                -834+   1.080  ipipe_root_only+0x10 (ipipe_unstal=
l_root+0x30)
:|   +end     0x80000000  -833+   2.640  ipipe_unstall_root+0x64 (_raw_spin=
_unlock_irq+0x1c)
:|   +begin   0x80000000  -830+   1.240  do_work_pending+0x144 (work_pendin=
g+0xc)
:|   +func                -829	  0.960  __ipipe_bugon_irqs_enabled+0x10 (no=
_work_pending+0x4)
:|   +end     0x90000000  -828+   7.360  no_work_pending+0x18 (<b6e35592>)
:|   +begin   0x90000000  -821+   1.600  __und_usr+0x20 (<b6e2138c>)
:|   +func                -819+   4.600  __ipipe_notify_trap+0x14 (__und_us=
r+0x58)
:|   +func                -815+   1.080  __ipipe_check_root+0x10 (ret_from_=
exception+0x8)
:|   +func                -814	  0.600  __ipipe_bugon_irqs_enabled+0x10 (no=
_work_pending+0x4)
:|   +end     0x90000000  -813+   2.960  no_work_pending+0x18 (<b6e2138a>)
:|   +begin   0x90000000  -810+   1.800  vector_swi+0x3c (<b69ac008>)
:    +func                -808+   1.240  __ipipe_syscall_root+0x10 (vector_=
swi+0x7c)
:    +func                -807	  0.680  sys_gettimeofday+0x14 (ret_fast_sys=
call+0x0)
:    +func                -806	  0.720  do_gettimeofday+0x14 (sys_gettimeof=
day+0x2c)
:    +func                -806+   4.320  getnstimeofday+0x10 (do_gettimeofd=
ay+0x24)
:|   +func                -801	  0.640  __ipipe_bugon_irqs_enabled+0x10 (re=
t_fast_syscall+0x14)
:|   +end     0x90000000  -801+   2.920  ret_fast_syscall+0x2c (<b69ac00c>)
:|   +begin   0x90000000  -798+   1.440  vector_swi+0x3c (<b69ac008>)
:    +func                -796	  0.720  __ipipe_syscall_root+0x10 (vector_s=
wi+0x7c)
:    +func                -796	  0.640  sys_gettimeofday+0x14 (ret_fast_sys=
call+0x0)
:    +func                -795	  0.880  do_gettimeofday+0x14 (sys_gettimeof=
day+0x2c)
:    +func                -794+   1.280  getnstimeofday+0x10 (do_gettimeofd=
ay+0x24)
:|   +func                -793	  0.600  __ipipe_bugon_irqs_enabled+0x10 (re=
t_fast_syscall+0x14)
:|   +end     0x90000000  -792+   5.240  ret_fast_syscall+0x2c (<b69ac00c>)
:|   +begin   0x90000000  -787+   1.120  vector_swi+0x3c (<b69d2f00>)
:    +func                -786+   1.080  __ipipe_syscall_root+0x10 (vector_=
swi+0x7c)
:    +func                -785+   3.120  sys_select+0x14 (ret_fast_syscall+=
0x0)
:    +func                -782+   1.320  poll_select_set_timeout+0x14 (sys_=
select+0xb8)
:    +func                -780+   1.920  ktime_get_ts+0x10 (poll_select_set=
_timeout+0x40)
:    +func                -778+   1.160  timespec_add_safe+0x18 (poll_selec=
t_set_timeout+0x54)
:    +func                -777+   2.080  set_normalized_timespec+0x10 (time=
spec_add_safe+0x58)
:    +func                -775+   5.040  core_sys_select+0x14 (sys_select+0=
xe4)
:    +func                -770+   1.920  do_select+0x14 (core_sys_select+0x=
234)
:    +func                -768+   1.880  poll_initwait+0x10 (do_select+0x11=
c)
:    +func                -766+   1.400  select_estimate_accuracy+0x14 (do_=
select+0x180)
:    +func                -765	  0.960  ktime_get_ts+0x10 (select_estimate_=
accuracy+0xd0)
:    +func                -764+   1.120  set_normalized_timespec+0x10 (sele=
ct_estimate_accuracy+0xf4)
:    +func                -763+   4.040  task_nice+0x10 (select_estimate_ac=
curacy+0x44)
:    +func                -759+   1.240  poll_schedule_timeout+0x10 (do_sel=
ect+0x458)
:    +func                -757+   1.240  schedule_hrtimeout_range+0x10 (pol=
l_schedule_timeout+0x44)
:    +func                -756+   1.960  schedule_hrtimeout_range_clock+0x1=
4 (schedule_hrtimeout_range+0x1c)
:    +func                -754+   2.320  hrtimer_init+0x10 (schedule_hrtime=
out_range_clock+0x70)
:    +func                -752+   1.080  ktime_add_safe+0x10 (schedule_hrti=
meout_range_clock+0x8c)
:    +func                -751	  1.000  hrtimer_start_range_ns+0x14 (schedu=
le_hrtimeout_range_clock+0xbc)
:    +func                -750	  0.680  __hrtimer_start_range_ns+0x14 (hrti=
mer_start_range_ns+0x34)
:    +func                -749	  0.680  _raw_spin_lock_irqsave+0x10 (__hrti=
mer_start_range_ns+0x34)
:|   +begin   0x80000001  -749	  0.720  _raw_spin_lock_irqsave+0x30 (__hrti=
mer_start_range_ns+0x34)
:|   #end     0x80000001  -748+   1.840  _raw_spin_lock_irqsave+0x50 (__hrt=
imer_start_range_ns+0x34)
:    #func                -746+   2.440  ktime_add_safe+0x10 (__hrtimer_sta=
rt_range_ns+0x100)
:    #func                -744+   2.960  enqueue_hrtimer+0x10 (__hrtimer_st=
art_range_ns+0x15c)
:    #func                -741+   1.120  _raw_spin_unlock_irqrestore+0x10 (=
__hrtimer_start_range_ns+0x264)
:    #func                -739	  0.960  ipipe_unstall_root+0x10 (_raw_spin_=
unlock_irqrestore+0x28)
:|   #begin   0x80000000  -738+   1.080  ipipe_unstall_root+0x2c (_raw_spin=
_unlock_irqrestore+0x28)
:|   #func                -737	  0.800  ipipe_root_only+0x10 (ipipe_unstall=
_root+0x30)
:|   +end     0x80000000  -737+   1.160  ipipe_unstall_root+0x64 (_raw_spin=
_unlock_irqrestore+0x28)
:    +func                -735+   1.120  schedule+0x10 (schedule_hrtimeout_=
range_clock+0xd8)
:    +func                -734	  0.640  __schedule+0x14 (schedule+0x94)
:    +func                -734	  0.680  rcu_sched_qs+0x10 (__schedule+0x34)
:|   +begin   0x80000001  -733+   1.080  rcu_sched_qs+0x2c (__schedule+0x34)
:|   #end     0x80000001  -732+   1.640  rcu_sched_qs+0x4c (__schedule+0x34)
:    #func                -730	  0.720  ipipe_unstall_root+0x10 (rcu_sched_=
qs+0xd4)
:|   #begin   0x80000000  -730	  0.760  ipipe_unstall_root+0x2c (rcu_sched_=
qs+0xd4)
:|   #func                -729+   1.080  ipipe_root_only+0x10 (ipipe_unstal=
l_root+0x30)
:|   +end     0x80000000  -728	  0.640  ipipe_unstall_root+0x64 (rcu_sched_=
qs+0xd4)
:    +func                -727	  0.760  ipipe_root_only+0x10 (__schedule+0x=
48)
:    +func                -726	  0.680  _raw_spin_lock_irq+0x10 (__schedule=
+0x9c)
:|   +begin   0x80000001  -726	  0.800  _raw_spin_lock_irq+0x30 (__schedule=
+0x9c)
:|   #end     0x80000001  -725+   1.160  _raw_spin_lock_irq+0x50 (__schedul=
e+0x9c)
:    #func                -724	  0.960  deactivate_task+0x10 (__schedule+0x=
560)
:    #func                -723	  0.640  dequeue_task+0x10 (deactivate_task+=
0x38)
:    #func                -722+   2.320  update_rq_clock+0x10 (dequeue_task=
+0x28)
:    #func                -720+   1.040  dequeue_task_fair+0x14 (dequeue_ta=
sk+0xb8)
:    #func                -719+   1.080  update_curr+0x14 (dequeue_task_fai=
r+0x40)
:    #func                -718	  0.840  update_min_vruntime+0x10 (update_cu=
rr+0xc0)
:    #func                -717+   1.600  cpuacct_charge+0x10 (update_curr+0=
x12c)
:    #func                -715+   1.080  clear_buddies+0x10 (dequeue_task_f=
air+0xa4)
:    #func                -714	  0.800  account_entity_dequeue+0x10 (dequeu=
e_task_fair+0xcc)
:    #func                -713+   1.240  update_min_vruntime+0x10 (dequeue_=
task_fair+0xf4)
:    #func                -712+   1.720  update_cfs_shares+0x10 (dequeue_ta=
sk_fair+0xfc)
:    #func                -710	  0.920  set_next_buddy+0x10 (dequeue_task_f=
air+0x12c)
:    #func                -709+   1.280  update_cfs_shares+0x10 (dequeue_ta=
sk_fair+0x158)
:    #func                -708	  0.840  put_prev_task_fair+0x10 (__schedule=
+0x1f8)
:    #func                -707	  0.680  update_curr+0x14 (put_prev_task_fai=
r+0x38)
:    #func                -707+   1.240  update_min_vruntime+0x10 (update_c=
urr+0xc0)
:    #func                -705	  0.960  __enqueue_entity+0x10 (put_prev_tas=
k_fair+0xac)
:    #func                -704	  0.640  pick_next_task_fair+0x10 (__schedul=
e+0x220)
:    #func                -704	  1.000  __pick_first_entity+0x10 (pick_next=
_task_fair+0x2c)
:    #func                -703	  0.720  wakeup_preempt_entity+0x10 (pick_ne=
xt_task_fair+0x9c)
:    #func                -702+   1.040  clear_buddies+0x10 (pick_next_task=
_fair+0xb0)
:    #func                -701+   1.120  set_next_entity+0x10 (pick_next_ta=
sk_fair+0xbc)
:    #func                -700	  0.800  update_stats_wait_end+0x10 (set_nex=
t_entity+0x2c)
:    #func                -699+   1.520  __dequeue_entity+0x10 (set_next_en=
tity+0x38)
:    #func                -698	  0.680  __pick_first_entity+0x10 (pick_next=
_task_fair+0x2c)
:    #func                -697	  0.680  clear_buddies+0x10 (pick_next_task_=
fair+0xb0)
:    #func                -696	  0.920  set_next_entity+0x10 (pick_next_tas=
k_fair+0xbc)
:    #func                -695+   1.160  update_stats_wait_end+0x10 (set_ne=
xt_entity+0x2c)
:    #func                -694+   1.560  __dequeue_entity+0x10 (set_next_en=
tity+0x38)
:|   #begin   0x80000001  -693	  0.680  __schedule+0x274 (schedule+0x94)
:|   #end     0x80000001  -692+   1.640  __schedule+0x298 (schedule+0x94)
:|   #begin   0x80000000  -690+   1.200  __schedule+0x464 (schedule+0x94)
:|   #func                -689	  0.960  __switch_mm_inner+0x10 (__schedule+=
0x4c4)
:|   #func                -688+   2.520  check_and_switch_context+0x14 (__s=
witch_mm_inner+0x50)
:|   #func                -686+   1.200  __ipipe_switch_to_notifier_call_ch=
ain+0x10 (__switch_to+0x2c)
:|   #func                -684	  0.640  atomic_notifier_call_chain+0x14 (__=
ipipe_switch_to_notifier_call_chain+0x6c)
:|   #func                -684	  1.000  __atomic_notifier_call_chain+0x14 (=
atomic_notifier_call_chain+0x28)
:|   #func                -683	  0.720  notifier_call_chain+0x10 (__atomic_=
notifier_call_chain+0x28)
:|   #func                -682+   1.040  vfp_notifier+0x10 (notifier_call_c=
hain+0x48)
:|   #func                -681+   1.400  thumbee_notifier+0x10 (notifier_ca=
ll_chain+0x48)
:|   #func                -680+   1.920  __ipipe_restore_root_nosync+0x10 (=
__ipipe_switch_to_notifier_call_chain+0x7c)
:|   #func                -678+   1.280  __ipipe_switch_tail+0x10 (__schedu=
le+0x504)
:|   #end     0x80000000  -676+   1.080  __ipipe_switch_tail+0x70 (__schedu=
le+0x504)
:    #func                -675+   1.080  finish_task_switch.constprop.72+0x=
10 (__schedule+0x514)
:    #func                -674+   1.120  _raw_spin_unlock_irq+0x10 (finish_=
task_switch.constprop.72+0x60)
:    #func                -673	  0.720  ipipe_unstall_root+0x10 (_raw_spin_=
unlock_irq+0x1c)
:|   #begin   0x80000000  -672	  0.840  ipipe_unstall_root+0x2c (_raw_spin_=
unlock_irq+0x1c)
:|   #func                -672+   1.080  ipipe_root_only+0x10 (ipipe_unstal=
l_root+0x30)
:|   +end     0x80000000  -670+   1.680  ipipe_unstall_root+0x64 (_raw_spin=
_unlock_irq+0x1c)
:|   +begin   0x80000000  -669	  0.880  do_work_pending+0x144 (work_pending=
+0xc)
:|   +func                -668	  0.800  __ipipe_bugon_irqs_enabled+0x10 (no=
_work_pending+0x4)
:|   +end     0x90000000  -667!  51.840  no_work_pending+0x18 (<0003b6f8>)
:|   +begin   0x90000000  -615+   1.840  __irq_usr+0x20 (<000d0248>)
:|   +func                -613+   1.360  omap3_intc_handle_irq+0x10 (__irq_=
usr+0x5c)
:|   +func                -612+   1.040  irq_find_mapping+0x10 (omap3_intc_=
handle_irq+0x64)
:|   +func                -611+   1.080  irq_domain_legacy_revmap+0x10 (irq=
_find_mapping+0x5c)
:|   +func                -610	  0.680  __ipipe_grab_irq+0x10 (omap3_intc_h=
andle_irq+0x70)
:|   +begin   0x00000053  -609	  0.800  __ipipe_grab_irq+0x24 (omap3_intc_h=
andle_irq+0x70)
:|   +func                -608	  0.760  __ipipe_dispatch_irq+0x10 (__ipipe_=
grab_irq+0x8c)
:|   +func                -608+   1.600  irq_to_desc+0x10 (__ipipe_dispatch=
_irq+0x4c)
:|   +func                -606+   1.320  irq_to_desc+0x10 (__ipipe_dispatch=
_irq+0x2ac)
:|   +func                -605	  0.960  __ipipe_ack_hrtimer_irq+0x10 (__ipi=
pe_dispatch_irq+0xd8)
:|   +func                -604	  0.680  __ipipe_ack_level_irq+0x10 (__ipipe=
_ack_hrtimer_irq+0x30)
:|   +func                -603	  0.760  omap_mask_ack_irq+0x10 (__ipipe_ack=
_level_irq+0x4c)
:|   +func                -602+   1.560  irq_gc_mask_disable_reg+0x10 (omap=
_mask_ack_irq+0x18)
:|   +func                -601+   1.280  omap2_gp_timer_ack+0x10 (__ipipe_a=
ck_hrtimer_irq+0x40)
:|   +func                -600	  0.720  __ipipe_end_level_irq+0x10 (__ipipe=
_ack_hrtimer_irq+0x58)
:|   +func                -599+   1.400  irq_gc_unmask_enable_reg+0x10 (__i=
pipe_end_level_irq+0x24)
:|  # func                -597+   2.080  xnintr_clock_handler+0x14 (__ipipe=
_dispatch_irq+0x1cc)
:|  # func                -595+   1.400  xntimer_tick_aperiodic+0x14 (xnint=
r_clock_handler+0x128)
:|  # func                -594	  0.680  xnthread_periodic_handler+0x10 (xnt=
imer_tick_aperiodic+0xac)
:|  # func                -593+   1.920  xnpod_resume_thread+0x14 (xnthread=
_periodic_handler+0x30)
:|  # [ 3238] samplin 99  -591+   2.760  xnpod_resume_thread+0x108 (xnthrea=
d_periodic_handler+0x30)
:|  # func                -589+   1.160  xntimer_next_local_shot+0x10 (xnti=
mer_tick_aperiodic+0x208)
:|  # event   tick@-317   -587	  0.960  xntimer_next_local_shot+0xd0 (xntim=
er_tick_aperiodic+0x208)
:|  # func                -586	  0.760  ipipe_timer_set+0x10 (xntimer_next_=
local_shot+0xd8)
:|  # func                -586+   2.120  omap2_gp_timer_set_next_event+0x10=
 (ipipe_timer_set+0x64)
:|  # func                -584+   1.880  __xnpod_schedule+0x14 (xnintr_cloc=
k_handler+0x29c)
:|  # [   66] mmcqd/0 -1  -582	  0.720  __xnpod_schedule+0x134 (xnintr_cloc=
k_handler+0x29c)
:|  # func                -581+   3.160  xnsched_pick_next+0x10 (__xnpod_sc=
hedule+0x160)
:|  # func                -578+   2.640  check_and_switch_context+0x14 (__x=
npod_schedule+0x3ec)
:|  # [ 3238] samplin 99  -575+   4.000  __xnpod_schedule+0x45c (xnpod_susp=
end_thread+0x444)
:|  # func                -571+   3.280  xntimer_get_overruns+0x14 (xnpod_w=
ait_thread_period+0x168)
:|  # func                -568+   1.080  __ipipe_restore_head+0x10 (xnpod_w=
ait_thread_period+0x2e8)
:|  + end     0x80000000  -567+   1.240  __ipipe_restore_head+0x108 (xnpod_=
wait_thread_period+0x2e8)
:   + func                -566	  0.800  __ipipe_uaccess_might_fault+0x10 (_=
_rt_task_wait_period+0x48)
:|  + begin   0x80000001  -565+   1.120  __ipipe_uaccess_might_fault+0x2c (=
__rt_task_wait_period+0x48)
:|  + end     0x80000001  -564+   2.640  __ipipe_uaccess_might_fault+0x8c (=
__rt_task_wait_period+0x48)
:|  + begin   0x80000001  -561	  0.880  __ipipe_notify_syscall+0xc0 (__ipip=
e_syscall_root+0x84)
:|  + end     0x80000001  -560	  0.760  __ipipe_notify_syscall+0x138 (__ipi=
pe_syscall_root+0x84)
:|  + begin   0x80000000  -559+   1.200  __ipipe_syscall_root+0xa0 (vector_=
swi+0x7c)
:|  + end     0x80000000  -558	  0.800  __ipipe_syscall_root+0x11c (vector_=
swi+0x7c)
:|  + func                -557	  1.000  __ipipe_bugon_irqs_enabled+0x10 (__=
ipipe_ret_to_user_irqs_disabled+0x4)
:|  + end     0x90000000  -556+   4.560  __ipipe_ret_to_user_irqs_disabled+=
0x18 (<b6f245e0>)
:|  + begin   0x90000000  -552+   1.600  vector_swi+0x3c (<b6f245dc>)
:   + func                -550+   1.120  __ipipe_syscall_root+0x10 (vector_=
swi+0x7c)
:   + func                -549	  0.720  __ipipe_notify_syscall+0x14 (__ipip=
e_syscall_root+0x84)
:|  + begin   0x80000001  -548	  0.720  __ipipe_notify_syscall+0x34 (__ipip=
e_syscall_root+0x84)
:|  + end     0x80000001  -548	  1.000  __ipipe_notify_syscall+0x94 (__ipip=
e_syscall_root+0x84)
:   + func                -547+   1.280  ipipe_syscall_hook+0x10 (__ipipe_n=
otify_syscall+0xa4)
:   + func                -545+   1.680  hisyscall_event+0x14 (ipipe_syscal=
l_hook+0x44)
:   + func                -544	  0.680  __rt_task_wait_period+0x14 (hisysca=
ll_event+0x17c)
:   + func                -543	  0.720  rt_task_wait_period+0x10 (__rt_task=
_wait_period+0x24)
:   + func                -542	  0.960  xnpod_wait_thread_period+0x14 (rt_t=
ask_wait_period+0x48)
:|  + begin   0x80000000  -541+   1.600  xnpod_wait_thread_period+0x3c (rt_=
task_wait_period+0x48)
:|  # func                -540+   1.720  xnpod_suspend_thread+0x14 (xnpod_w=
ait_thread_period+0x144)
:|  # func                -538+   1.160  __xnpod_schedule+0x14 (xnpod_suspe=
nd_thread+0x444)
:|  # [ 3238] samplin 99  -537	  0.640  __xnpod_schedule+0x134 (xnpod_suspe=
nd_thread+0x444)
:|  # func                -536+   1.960  xnsched_pick_next+0x10 (__xnpod_sc=
hedule+0x160)
:|  # func                -534+   2.320  check_and_switch_context+0x14 (__x=
npod_schedule+0x3ec)
:|  # [ 3795] axis    -1  -532+   2.160  __xnpod_schedule+0x45c (xnintr_clo=
ck_handler+0x29c)
:|   +func                -530+   1.280  __ipipe_do_sync_pipeline+0x10 (__i=
pipe_dispatch_irq+0x28c)
:|   +end     0x00000053  -529	  0.720  __ipipe_grab_irq+0x94 (omap3_intc_h=
andle_irq+0x70)
:|   +func                -528+   1.400  __ipipe_exit_irq+0x10 (__ipipe_gra=
b_irq+0x9c)
:|   +func                -526	  0.760  __ipipe_check_root_interruptible+0x=
10 (__irq_usr+0x60)
:|   +func                -526	  0.680  __ipipe_bugon_irqs_enabled+0x10 (no=
_work_pending+0x4)
:|   +end     0x90000000  -525! 212.800  no_work_pending+0x18 (<000d0248>)
:|   +begin   0x90000000  -312+   3.040  __irq_usr+0x20 (<0002506a>)
:|   +func                -309+   1.200  omap3_intc_handle_irq+0x10 (__irq_=
usr+0x5c)
:|   +func                -308+   1.120  irq_find_mapping+0x10 (omap3_intc_=
handle_irq+0x64)
:|   +func                -307+   1.360  irq_domain_legacy_revmap+0x10 (irq=
_find_mapping+0x5c)
:|   +func                -305+   1.040  __ipipe_grab_irq+0x10 (omap3_intc_=
handle_irq+0x70)
:|   +begin   0x00000053  -304+   1.120  __ipipe_grab_irq+0x24 (omap3_intc_=
handle_irq+0x70)
:|   +func                -303	  0.760  __ipipe_dispatch_irq+0x10 (__ipipe_=
grab_irq+0x8c)
:|   +func                -303+   1.200  irq_to_desc+0x10 (__ipipe_dispatch=
_irq+0x4c)
:|   +func                -301+   1.080  irq_to_desc+0x10 (__ipipe_dispatch=
_irq+0x2ac)
:|   +func                -300	  0.680  __ipipe_ack_hrtimer_irq+0x10 (__ipi=
pe_dispatch_irq+0xd8)
:|   +func                -300	  1.000  __ipipe_ack_level_irq+0x10 (__ipipe=
_ack_hrtimer_irq+0x30)
:|   +func                -299	  0.640  omap_mask_ack_irq+0x10 (__ipipe_ack=
_level_irq+0x4c)
:|   +func                -298+   1.240  irq_gc_mask_disable_reg+0x10 (omap=
_mask_ack_irq+0x18)
:|   +func                -297+   1.040  omap2_gp_timer_ack+0x10 (__ipipe_a=
ck_hrtimer_irq+0x40)
:|   +func                -296	  0.960  __ipipe_end_level_irq+0x10 (__ipipe=
_ack_hrtimer_irq+0x58)
:|   +func                -295+   1.200  irq_gc_unmask_enable_reg+0x10 (__i=
pipe_end_level_irq+0x24)
:|  # func                -293+   3.040  xnintr_clock_handler+0x14 (__ipipe=
_dispatch_irq+0x1cc)
:|  # func                -290+   1.520  xntimer_tick_aperiodic+0x14 (xnint=
r_clock_handler+0x128)
:|  # func                -289+   1.120  xnthread_periodic_handler+0x10 (xn=
timer_tick_aperiodic+0xac)
:|  # func                -288+   1.120  xnpod_resume_thread+0x14 (xnthread=
_periodic_handler+0x30)
:|  # [ 3783] servo-t 98  -287+   1.920  xnpod_resume_thread+0x108 (xnthrea=
d_periodic_handler+0x30)
:|  # func                -285+   1.680  xntimer_next_local_shot+0x10 (xnti=
mer_tick_aperiodic+0x208)
:|  # event   tick@-140   -283	  0.640  xntimer_next_local_shot+0xd0 (xntim=
er_tick_aperiodic+0x208)
:|  # func                -282+   1.040  ipipe_timer_set+0x10 (xntimer_next=
_local_shot+0xd8)
:|  # func                -281+   1.720  omap2_gp_timer_set_next_event+0x10=
 (ipipe_timer_set+0x64)
:|  # func                -280+   1.280  __xnpod_schedule+0x14 (xnintr_cloc=
k_handler+0x29c)
:|  # [ 3795] axis    -1  -278	  0.960  __xnpod_schedule+0x134 (xnintr_cloc=
k_handler+0x29c)
:|  # func                -277+   3.040  xnsched_pick_next+0x10 (__xnpod_sc=
hedule+0x160)
:|  # func                -274+   3.160  check_and_switch_context+0x14 (__x=
npod_schedule+0x3ec)
:|  # [ 3783] servo-t 98  -271+   3.560  __xnpod_schedule+0x45c (xnpod_susp=
end_thread+0x444)
:|  # func                -268+   1.360  xntimer_get_overruns+0x14 (xnpod_w=
ait_thread_period+0x168)
:|  # func                -266+   1.200  __ipipe_restore_head+0x10 (xnpod_w=
ait_thread_period+0x2e8)
:|  + end     0x80000000  -265+   1.240  __ipipe_restore_head+0x108 (xnpod_=
wait_thread_period+0x2e8)
:   + func                -264+   1.040  __ipipe_uaccess_might_fault+0x10 (=
__rt_task_wait_period+0x48)
:|  + begin   0x80000001  -263+   1.760  __ipipe_uaccess_might_fault+0x2c (=
__rt_task_wait_period+0x48)
:|  + end     0x80000001  -261+   2.520  __ipipe_uaccess_might_fault+0x8c (=
__rt_task_wait_period+0x48)
:|  + begin   0x80000001  -259	  0.800  __ipipe_notify_syscall+0xc0 (__ipip=
e_syscall_root+0x84)
:|  + end     0x80000001  -258+   1.360  __ipipe_notify_syscall+0x138 (__ip=
ipe_syscall_root+0x84)
:|  + begin   0x80000000  -256	  0.920  __ipipe_syscall_root+0xa0 (vector_s=
wi+0x7c)
:|  + end     0x80000000  -255+   1.120  __ipipe_syscall_root+0x11c (vector=
_swi+0x7c)
:|  + func                -254	  0.960  __ipipe_bugon_irqs_enabled+0x10 (__=
ipipe_ret_to_user_irqs_disabled+0x4)
:|  + end     0x90000000  -253!  96.800  __ipipe_ret_to_user_irqs_disabled+=
0x18 (<b6f2f5e0>)
:|  + begin   0x90000000  -157+   2.480  vector_swi+0x3c (<b6f2f5dc>)
:   + func                -154	  0.920  __ipipe_syscall_root+0x10 (vector_s=
wi+0x7c)
:   + func                -153	  0.760  __ipipe_notify_syscall+0x14 (__ipip=
e_syscall_root+0x84)
:|  + begin   0x80000001  -152+   1.160  __ipipe_notify_syscall+0x34 (__ipi=
pe_syscall_root+0x84)
:|  + end     0x80000001  -151	  0.720  __ipipe_notify_syscall+0x94 (__ipip=
e_syscall_root+0x84)
:   + func                -151+   1.080  ipipe_syscall_hook+0x10 (__ipipe_n=
otify_syscall+0xa4)
:   + func                -149+   2.080  hisyscall_event+0x14 (ipipe_syscal=
l_hook+0x44)
:   + func                -147	  0.720  __rt_task_wait_period+0x14 (hisysca=
ll_event+0x17c)
:   + func                -147+   1.760  rt_task_wait_period+0x10 (__rt_tas=
k_wait_period+0x24)
:   + func                -145	  0.680  xnpod_wait_thread_period+0x14 (rt_t=
ask_wait_period+0x48)
:|  + begin   0x80000000  -144+   2.200  xnpod_wait_thread_period+0x3c (rt_=
task_wait_period+0x48)
:|  # func                -142+   1.720  xnpod_suspend_thread+0x14 (xnpod_w=
ait_thread_period+0x144)
:|  # func                -140	  0.880  __xnpod_schedule+0x14 (xnpod_suspen=
d_thread+0x444)
:|  # [ 3783] servo-t 98  -139+   1.240  __xnpod_schedule+0x134 (xnpod_susp=
end_thread+0x444)
:|  # func                -138+   1.560  xnsched_pick_next+0x10 (__xnpod_sc=
hedule+0x160)
:|  # func                -137+   1.680  xntimer_next_local_shot+0x10 (__xn=
pod_schedule+0x294)
:|  # event   tick@-135   -135	  0.880  xntimer_next_local_shot+0xd0 (__xnp=
od_schedule+0x294)
:|  # func                -134	  0.800  ipipe_timer_set+0x10 (xntimer_next_=
local_shot+0xd8)
:|  # func                -133	  0.960  ipipe_raise_irq+0x10 (ipipe_timer_s=
et+0x54)
:|  # func                -132+   1.040  __ipipe_dispatch_irq+0x10 (ipipe_r=
aise_irq+0x3c)
:|  # func                -131+   1.680  irq_to_desc+0x10 (__ipipe_dispatch=
_irq+0x4c)
:|  # func                -130+   2.000  irq_to_desc+0x10 (__ipipe_dispatch=
_irq+0x2ac)
:|  # func                -128+   3.160  __ipipe_set_irq_pending+0x10 (__ip=
ipe_dispatch_irq+0x180)
:|  # func                -124+   2.400  check_and_switch_context+0x14 (__x=
npod_schedule+0x3ec)
:|  # [ 3795] axis    -1  -122+   3.840  __xnpod_schedule+0x45c (xnintr_clo=
ck_handler+0x29c)
:|   +func                -118	  0.840  __ipipe_do_sync_pipeline+0x10 (__ip=
ipe_dispatch_irq+0x28c)
:|  + func                -117+   1.520  __ipipe_do_sync_stage+0x10 (__ipip=
e_do_sync_pipeline+0xbc)
:|  # func                -116+   2.000  xnintr_clock_handler+0x14 (__ipipe=
_do_sync_stage+0x214)
:|  # func                -114+   1.560  xntimer_tick_aperiodic+0x14 (xnint=
r_clock_handler+0x128)
:|  # func                -112+   1.520  xnthread_periodic_handler+0x10 (xn=
timer_tick_aperiodic+0xac)
:|  # func                -111	  0.840  xnpod_resume_thread+0x14 (xnthread_=
periodic_handler+0x30)
:|  # [ 3238] samplin 99  -110+   1.600  xnpod_resume_thread+0x108 (xnthrea=
d_periodic_handler+0x30)
:|  # func                -108+   1.240  xntimer_next_local_shot+0x10 (xnti=
mer_tick_aperiodic+0x208)
:|  # event   tick@339    -107	  0.600  xntimer_next_local_shot+0xd0 (xntim=
er_tick_aperiodic+0x208)
:|  # func                -106	  0.760  ipipe_timer_set+0x10 (xntimer_next_=
local_shot+0xd8)
:|  # func                -106+   2.280  omap2_gp_timer_set_next_event+0x10=
 (ipipe_timer_set+0x64)
:|  # func                -103+   1.240  __xnpod_schedule+0x14 (xnintr_cloc=
k_handler+0x29c)
:|  # [ 3795] axis    -1  -102	  0.880  __xnpod_schedule+0x134 (xnintr_cloc=
k_handler+0x29c)
:|  # func                -101+   2.080  xnsched_pick_next+0x10 (__xnpod_sc=
hedule+0x160)
:|  # func                 -99+   2.520  check_and_switch_context+0x14 (__x=
npod_schedule+0x3ec)
:|  # [ 3238] samplin 99   -97+   2.520  __xnpod_schedule+0x45c (xnpod_susp=
end_thread+0x444)
:|  # func                 -94+   1.240  xntimer_get_overruns+0x14 (xnpod_w=
ait_thread_period+0x168)
:|  # func                 -93	  0.760  __ipipe_restore_head+0x10 (xnpod_wa=
it_thread_period+0x2e8)
:|  + end     0x80000000   -92+   1.560  __ipipe_restore_head+0x108 (xnpod_=
wait_thread_period+0x2e8)
:|  + begin   0x90000000   -91	  1.000  __irq_svc+0x44 (__ipipe_restore_hea=
d+0x10c)
:|  + func                 -90+   1.440  omap3_intc_handle_irq+0x10 (__irq_=
svc+0x58)
:|  + func                 -88+   1.040  irq_find_mapping+0x10 (omap3_intc_=
handle_irq+0x64)
:|  + func                 -87+   1.360  irq_domain_legacy_revmap+0x10 (irq=
_find_mapping+0x5c)
:|  + func                 -86	  1.000  __ipipe_grab_irq+0x10 (omap3_intc_h=
andle_irq+0x70)
:|  + begin   0x00000053   -85	  0.800  __ipipe_grab_irq+0x24 (omap3_intc_h=
andle_irq+0x70)
:|  + func                 -84	  0.640  __ipipe_dispatch_irq+0x10 (__ipipe_=
grab_irq+0x8c)
:|  + func                 -83+   1.320  irq_to_desc+0x10 (__ipipe_dispatch=
_irq+0x4c)
:|  + func                 -82	  0.960  irq_to_desc+0x10 (__ipipe_dispatch_=
irq+0x2ac)
:|  + func                 -81+   1.040  __ipipe_ack_hrtimer_irq+0x10 (__ip=
ipe_dispatch_irq+0xd8)
:|  + func                 -80	  0.720  __ipipe_ack_level_irq+0x10 (__ipipe=
_ack_hrtimer_irq+0x30)
:|  + func                 -79	  0.640  omap_mask_ack_irq+0x10 (__ipipe_ack=
_level_irq+0x4c)
:|  + func                 -79+   1.760  irq_gc_mask_disable_reg+0x10 (omap=
_mask_ack_irq+0x18)
:|  + func                 -77	  1.000  omap2_gp_timer_ack+0x10 (__ipipe_ac=
k_hrtimer_irq+0x40)
:|  + func                 -76	  0.680  __ipipe_end_level_irq+0x10 (__ipipe=
_ack_hrtimer_irq+0x58)
:|  + func                 -75+   1.400  irq_gc_unmask_enable_reg+0x10 (__i=
pipe_end_level_irq+0x24)
:|  # func                 -74+   1.760  xnintr_clock_handler+0x14 (__ipipe=
_dispatch_irq+0x1cc)
:|  # func                 -72+   1.240  xntimer_tick_aperiodic+0x14 (xnint=
r_clock_handler+0x128)
:|  # func                 -71	  1.000  xntimer_next_local_shot+0x10 (xntim=
er_tick_aperiodic+0x208)
:|  # event   tick@339     -70	  0.600  xntimer_next_local_shot+0xd0 (xntim=
er_tick_aperiodic+0x208)
:|  # func                 -69+   1.120  ipipe_timer_set+0x10 (xntimer_next=
_local_shot+0xd8)
:|  # func                 -68+   1.720  omap2_gp_timer_set_next_event+0x10=
 (ipipe_timer_set+0x64)
:|  + end     0x00000053   -66	  0.680  __ipipe_grab_irq+0x94 (omap3_intc_h=
andle_irq+0x70)
:|  + func                 -66+   1.160  __ipipe_exit_irq+0x10 (__ipipe_gra=
b_irq+0x9c)
:|  + func                 -65	  0.720  irq_find_mapping+0x10 (omap3_intc_h=
andle_irq+0x64)
:|  + func                 -64+   1.360  irq_domain_legacy_revmap+0x10 (irq=
_find_mapping+0x5c)
:|  + func                 -62	  0.720  __ipipe_grab_irq+0x10 (omap3_intc_h=
andle_irq+0x70)
:|  + begin   0x00000050   -62	  0.800  __ipipe_grab_irq+0x24 (omap3_intc_h=
andle_irq+0x70)
:|  + func                 -61+   1.040  __ipipe_dispatch_irq+0x10 (__ipipe=
_grab_irq+0x8c)
:|  + func                 -60	  0.760  irq_to_desc+0x10 (__ipipe_dispatch_=
irq+0x4c)
:|  + func                 -59+   1.160  irq_to_desc+0x10 (__ipipe_dispatch=
_irq+0x2ac)
:|  + func                 -58	  0.920  __ipipe_ack_irq+0x10 (__ipipe_dispa=
tch_irq+0xd8)
:|  + func                 -57	  0.680  __ipipe_ack_level_irq+0x10 (__ipipe=
_ack_irq+0x1c)
:|  + func                 -56	  0.880  omap_mask_ack_irq+0x10 (__ipipe_ack=
_level_irq+0x4c)
:|  + func                 -56+   1.120  irq_gc_mask_disable_reg+0x10 (omap=
_mask_ack_irq+0x18)
:|  + func                 -54	  0.880  __ipipe_set_irq_pending+0x10 (__ipi=
pe_dispatch_irq+0x24c)
:|  + end     0x00000050   -54	  0.920  __ipipe_grab_irq+0x94 (omap3_intc_h=
andle_irq+0x70)
:|  + func                 -53	  0.840  __ipipe_exit_irq+0x10 (__ipipe_grab=
_irq+0x9c)
:|  + func                 -52	  0.680  irq_find_mapping+0x10 (omap3_intc_h=
andle_irq+0x64)
:|  + func                 -51	  1.000  irq_domain_legacy_revmap+0x10 (irq_=
find_mapping+0x5c)
:|  + func                 -50	  0.680  __ipipe_grab_irq+0x10 (omap3_intc_h=
andle_irq+0x70)
:|  + begin   0x0000001c   -49+   1.120  __ipipe_grab_irq+0x24 (omap3_intc_=
handle_irq+0x70)
:|  + func                 -48	  0.720  __ipipe_dispatch_irq+0x10 (__ipipe_=
grab_irq+0x8c)
:|  + func                 -48	  1.000  irq_to_desc+0x10 (__ipipe_dispatch_=
irq+0x4c)
:|  + func                 -47+   1.880  irq_to_desc+0x10 (__ipipe_dispatch=
_irq+0x2ac)
:|  + func                 -45	  0.640  __ipipe_ack_irq+0x10 (__ipipe_dispa=
tch_irq+0xd8)
:|  + func                 -44	  0.840  __ipipe_ack_level_irq+0x10 (__ipipe=
_ack_irq+0x1c)
:|  + func                 -43	  0.920  omap_mask_ack_irq+0x10 (__ipipe_ack=
_level_irq+0x4c)
:|  + func                 -42+   1.440  irq_gc_mask_disable_reg+0x10 (omap=
_mask_ack_irq+0x18)
:|  + func                 -41+   1.280  __ipipe_set_irq_pending+0x10 (__ip=
ipe_dispatch_irq+0x24c)
:|  + end     0x0000001c   -40	  0.640  __ipipe_grab_irq+0x94 (omap3_intc_h=
andle_irq+0x70)
:|  + func                 -39+   1.320  __ipipe_exit_irq+0x10 (__ipipe_gra=
b_irq+0x9c)
:|  + func                 -38+   1.200  __ipipe_check_root_interruptible+0=
x10 (__irq_svc+0x5c)
:|  + func                 -36	  0.680  __ipipe_bugon_irqs_enabled+0x10 (__=
ipipe_fast_svc_irq_exit+0x4)
:|  + end     0x90000000   -36+   1.040  __ipipe_fast_svc_irq_exit+0x18 (__=
ipipe_restore_head+0x10c)
:   + func                 -35+   1.040  __ipipe_uaccess_might_fault+0x10 (=
__rt_task_wait_period+0x48)
:|  + begin   0x80000001   -34	  0.840  __ipipe_uaccess_might_fault+0x2c (_=
_rt_task_wait_period+0x48)
:|  + end     0x80000001   -33+   2.400  __ipipe_uaccess_might_fault+0x8c (=
__rt_task_wait_period+0x48)
:|  + begin   0x80000001   -30	  0.840  __ipipe_notify_syscall+0xc0 (__ipip=
e_syscall_root+0x84)
:|  + end     0x80000001   -30	  0.760  __ipipe_notify_syscall+0x138 (__ipi=
pe_syscall_root+0x84)
:|  + begin   0x80000000   -29+   1.160  __ipipe_syscall_root+0xa0 (vector_=
swi+0x7c)
:|  + end     0x80000000   -28	  0.760  __ipipe_syscall_root+0x11c (vector_=
swi+0x7c)
:|  + func                 -27	  0.880  __ipipe_bugon_irqs_enabled+0x10 (__=
ipipe_ret_to_user_irqs_disabled+0x4)
:|  + end     0x90000000   -26+   7.120  __ipipe_ret_to_user_irqs_disabled+=
0x18 (<b6f245e0>)
:|  + begin   0x90000000   -19	  1.000  vector_swi+0x3c (<00009d1c>)
:   + func                 -18+   1.040  __ipipe_syscall_root+0x10 (vector_=
swi+0x7c)
:   + func                 -17	  0.680  __ipipe_notify_syscall+0x14 (__ipip=
e_syscall_root+0x84)
:|  + begin   0x80000001   -16	  0.640  __ipipe_notify_syscall+0x34 (__ipip=
e_syscall_root+0x84)
:|  + end     0x80000001   -16	  0.960  __ipipe_notify_syscall+0x94 (__ipip=
e_syscall_root+0x84)
:   + func                 -15	  0.720  ipipe_syscall_hook+0x10 (__ipipe_no=
tify_syscall+0xa4)
:   + func                 -14+   2.160  hisyscall_event+0x14 (ipipe_syscal=
l_hook+0x44)
:   + func                 -12+   2.040  xnshadow_sys_trace+0x10 (hisyscall=
_event+0x17c)
:   + func                 -10	  0.920  ipipe_trace_frozen_reset+0x10 (xnsh=
adow_sys_trace+0x98)
:   + func                  -9+   1.560  __ipipe_global_path_lock+0x10 (ipi=
pe_trace_frozen_reset+0x18)
:   + func                  -7	  0.720  __ipipe_spin_lock_irqsave+0x10 (__i=
pipe_global_path_lock+0x1c)
:|  + begin   0x80000001    -6+   4.240  __ipipe_spin_lock_irqsave+0x30 (__=
ipipe_global_path_lock+0x1c)
:|  # func                  -2+   1.280  __ipipe_spin_unlock_irqcomplete+0x=
10 (__ipipe_global_path_unlock+0x68)
:|  + end     0x80000001    -1+   1.400  __ipipe_spin_unlock_irqcomplete+0x=
48 (__ipipe_global_path_unlock+0x68)
<   + freeze  0x0001bb5b     0	  1.480  xnshadow_sys_trace+0xa8 (hisyscall_=
event+0x17c)
 |  + begin   0x80000001     1	  0.960  __ipipe_notify_syscall+0xc0 (__ipip=
e_syscall_root+0x84)
 |  + end     0x80000001     2	  0.720  __ipipe_notify_syscall+0x138 (__ipi=
pe_syscall_root+0x84)
 |  + begin   0x80000000     3	  0.960  __ipipe_syscall_root+0xa0 (vector_s=
wi+0x7c)
 |  + end     0x80000000     4	  0.680  __ipipe_syscall_root+0x11c (vector_=
swi+0x7c)
 |  + func                   4	  0.640  __ipipe_bugon_irqs_enabled+0x10 (__=
ipipe_ret_to_user_irqs_disabled+0x4)
 |  + end     0x90000000     5	  2.040  __ipipe_ret_to_user_irqs_disabled+0=
x18 (<00009d20>)
 |  + begin   0x90000000     7	  0.760  vector_swi+0x3c (<b6f245dc>)
    + func                   8	  0.720  __ipipe_syscall_root+0x10 (vector_s=
wi+0x7c)
    + func                   8	  0.920  __ipipe_notify_syscall+0x14 (__ipip=
e_syscall_root+0x84)
 |  + begin   0x80000001     9	  0.000  __ipipe_notify_syscall+0x34 (__ipip=
e_syscall_root+0x84)
-------------- next part --------------
#
# Automatically generated file; DO NOT EDIT.
# Linux/arm 3.8.13 Kernel Configuration
#
CONFIG_ARM=3Dy
CONFIG_IPIPE_WANT_ACTIVE_MM=3Dy
CONFIG_SYS_SUPPORTS_APM_EMULATION=3Dy
CONFIG_GENERIC_GPIO=3Dy
CONFIG_HAVE_PROC_CPU=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
CONFIG_ARCH_HAS_CPUFREQ=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_NEED_DMA_MAP_STATE=3Dy
CONFIG_VECTORS_BASE=3D0xffff0000
CONFIG_ARM_PATCH_PHYS_VIRT=3Dy
CONFIG_GENERIC_BUG=3Dy
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
CONFIG_HAVE_IRQ_WORK=3Dy
CONFIG_IRQ_WORK=3Dy
CONFIG_BUILDTIME_EXTABLE_SORT=3Dy

#
# General setup
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32
CONFIG_CROSS_COMPILE=3D""
CONFIG_LOCALVERSION=3D"xenomai-dbg_opt"
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_HAVE_KERNEL_GZIP=3Dy
CONFIG_HAVE_KERNEL_LZMA=3Dy
CONFIG_HAVE_KERNEL_XZ=3Dy
CONFIG_HAVE_KERNEL_LZO=3Dy
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=3Dy
# CONFIG_KERNEL_LZO is not set
CONFIG_DEFAULT_HOSTNAME=3D"(none)"
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_SYSVIPC_SYSCTL=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
CONFIG_FHANDLE=3Dy
# CONFIG_AUDIT is not set
CONFIG_HAVE_GENERIC_HARDIRQS=3Dy

#
# IRQ subsystem
#
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_GENERIC_IRQ_SHOW=3Dy
CONFIG_HARDIRQS_SW_RESEND=3Dy
CONFIG_GENERIC_IRQ_CHIP=3Dy
CONFIG_IRQ_DOMAIN=3Dy
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_SPARSE_IRQ=3Dy
CONFIG_GENERIC_TIME_VSYSCALL=3Dy
CONFIG_KTIME_SCALAR=3Dy
CONFIG_GENERIC_CLOCKEVENTS=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=3Dy
CONFIG_NO_HZ=3Dy
CONFIG_HIGH_RES_TIMERS=3Dy

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_BSD_PROCESS_ACCT_V3=3Dy
CONFIG_TASKSTATS=3Dy
CONFIG_TASK_DELAY_ACCT=3Dy
CONFIG_TASK_XACCT=3Dy
CONFIG_TASK_IO_ACCOUNTING=3Dy

#
# RCU Subsystem
#
CONFIG_TINY_RCU=3Dy
# CONFIG_PREEMPT_RCU is not set
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
CONFIG_LOG_BUF_SHIFT=3D17
CONFIG_CGROUPS=3Dy
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_CPUACCT=3Dy
CONFIG_RESOURCE_COUNTERS=3Dy
CONFIG_MEMCG=3Dy
# CONFIG_MEMCG_SWAP is not set
# CONFIG_MEMCG_KMEM is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_SCHED=3Dy
CONFIG_FAIR_GROUP_SCHED=3Dy
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_BLK_CGROUP=3Dy
# CONFIG_DEBUG_BLK_CGROUP is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_NAMESPACES=3Dy
CONFIG_UTS_NS=3Dy
CONFIG_IPC_NS=3Dy
CONFIG_PID_NS=3Dy
CONFIG_NET_NS=3Dy
CONFIG_SCHED_AUTOGROUP=3Dy
CONFIG_MM_OWNER=3Dy
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_RD_GZIP=3Dy
CONFIG_RD_BZIP2=3Dy
CONFIG_RD_LZMA=3Dy
CONFIG_RD_XZ=3Dy
CONFIG_RD_LZO=3Dy
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_ANON_INODES=3Dy
CONFIG_EXPERT=3Dy
CONFIG_HAVE_UID16=3Dy
CONFIG_UID16=3Dy
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=3Dy
CONFIG_KALLSYMS_ALL=3Dy
CONFIG_HOTPLUG=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SIGNALFD=3Dy
CONFIG_TIMERFD=3Dy
CONFIG_EVENTFD=3Dy
CONFIG_SHMEM=3Dy
CONFIG_AIO=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=3Dy
CONFIG_PERF_USE_VMALLOC=3Dy

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=3Dy
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=3Dy
CONFIG_COMPAT_BRK=3Dy
CONFIG_SLAB=3Dy
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_PROFILING=3Dy
CONFIG_TRACEPOINTS=3Dy
CONFIG_OPROFILE=3Dm
CONFIG_HAVE_OPROFILE=3Dy
CONFIG_KPROBES=3Dy
# CONFIG_JUMP_LABEL is not set
CONFIG_KRETPROBES=3Dy
CONFIG_HAVE_KPROBES=3Dy
CONFIG_HAVE_KRETPROBES=3Dy
CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
CONFIG_HAVE_DMA_ATTRS=3Dy
CONFIG_HAVE_DMA_CONTIGUOUS=3Dy
CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
CONFIG_HAVE_CLK=3Dy
CONFIG_HAVE_DMA_API_DEBUG=3Dy
CONFIG_HAVE_HW_BREAKPOINT=3Dy
CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=3Dy
CONFIG_HAVE_ARCH_SECCOMP_FILTER=3Dy
CONFIG_SECCOMP_FILTER=3Dy
CONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy
CONFIG_MODULES_USE_ELF_REL=3Dy
CONFIG_CLONE_BACKWARDS=3Dy

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_HAVE_GENERIC_DMA_COHERENT=3Dy
CONFIG_SLABINFO=3Dy
CONFIG_RT_MUTEXES=3Dy
CONFIG_BASE_SMALL=3D0
CONFIG_MODULES=3Dy
CONFIG_MODULE_FORCE_LOAD=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_MODULE_SRCVERSION_ALL=3Dy
# CONFIG_MODULE_SIG is not set
CONFIG_BLOCK=3Dy
CONFIG_LBDAF=3Dy
CONFIG_BLK_DEV_BSG=3Dy
CONFIG_BLK_DEV_BSGLIB=3Dy
CONFIG_BLK_DEV_INTEGRITY=3Dy
# CONFIG_BLK_DEV_THROTTLING is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=3Dy
CONFIG_MSDOS_PARTITION=3Dy
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=3Dy
# CONFIG_SYSV68_PARTITION is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
# CONFIG_CFQ_GROUP_IOSCHED is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=3Dy
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"cfq"
CONFIG_ASN1=3Dm
CONFIG_UNINLINE_SPIN_UNLOCK=3Dy

#
# Real-time sub-system
#
CONFIG_XENOMAI=3Dy
CONFIG_XENO_GENERIC_STACKPOOL=3Dy
CONFIG_XENO_FASTSYNCH_DEP=3Dy
CONFIG_XENO_FASTSYNCH=3Dy
CONFIG_XENO_OPT_NUCLEUS=3Dy
CONFIG_XENO_OPT_PERVASIVE=3Dy
# CONFIG_XENO_OPT_PRIOCPL is not set
CONFIG_XENO_OPT_PIPELINE_HEAD=3Dy
# CONFIG_XENO_OPT_SCHED_CLASSES is not set
CONFIG_XENO_OPT_PIPE=3Dy
CONFIG_XENO_OPT_MAP=3Dy
CONFIG_XENO_OPT_VFILE=3Dy
CONFIG_XENO_OPT_PIPE_NRDEV=3D32
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=3D512
CONFIG_XENO_OPT_SYS_HEAPSZ=3D256
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=3D128
CONFIG_XENO_OPT_SEM_HEAPSZ=3D12
CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ=3D12
CONFIG_XENO_OPT_STATS=3Dy
CONFIG_XENO_OPT_DEBUG=3Dy
# CONFIG_XENO_OPT_DEBUG_NUCLEUS is not set
CONFIG_XENO_OPT_DEBUG_XNLOCK=3Dy
# CONFIG_XENO_OPT_DEBUG_QUEUES is not set
# CONFIG_XENO_OPT_DEBUG_REGISTRY is not set
# CONFIG_XENO_OPT_DEBUG_TIMERS is not set
CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX=3Dy
CONFIG_XENO_OPT_WATCHDOG=3Dy
CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=3D4
# CONFIG_XENO_OPT_SHIRQ is not set
CONFIG_XENO_OPT_SELECT=3Dy
CONFIG_XENO_OPT_HOSTRT=3Dy

#
# Timing
#
# CONFIG_XENO_OPT_TIMING_PERIODIC is not set
CONFIG_XENO_OPT_TIMING_VIRTICK=3D1000
CONFIG_XENO_OPT_TIMING_SCHEDLAT=3D0

#
# Scalability
#
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
CONFIG_XENO_OPT_TIMER_LIST=3Dy
# CONFIG_XENO_OPT_TIMER_HEAP is not set
# CONFIG_XENO_OPT_TIMER_WHEEL is not set

#
# Machine
#
# CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH is not set
CONFIG_XENO_HW_FPU=3Dy
# CONFIG_XENO_HW_UNLOCKED_SWITCH is not set

#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=3Dy
CONFIG_XENO_OPT_NATIVE_PERIOD=3D0
CONFIG_XENO_OPT_NATIVE_PIPE=3Dy
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=3D1024
CONFIG_XENO_OPT_NATIVE_SEM=3Dy
CONFIG_XENO_OPT_NATIVE_EVENT=3Dy
CONFIG_XENO_OPT_NATIVE_MUTEX=3Dy
CONFIG_XENO_OPT_NATIVE_COND=3Dy
CONFIG_XENO_OPT_NATIVE_QUEUE=3Dy
CONFIG_XENO_OPT_NATIVE_BUFFER=3Dy
CONFIG_XENO_OPT_NATIVE_HEAP=3Dy
CONFIG_XENO_OPT_NATIVE_ALARM=3Dy
CONFIG_XENO_OPT_NATIVE_MPS=3Dy
# CONFIG_XENO_OPT_NATIVE_INTR is not set
CONFIG_XENO_OPT_DEBUG_NATIVE=3Dy
CONFIG_XENO_SKIN_POSIX=3Dy
CONFIG_XENO_OPT_POSIX_PERIOD=3D0
# CONFIG_XENO_OPT_POSIX_SHM is not set
# CONFIG_XENO_OPT_POSIX_INTR is not set
CONFIG_XENO_OPT_POSIX_SELECT=3Dy
CONFIG_XENO_OPT_DEBUG_POSIX=3Dy
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_OPT_NOWARN_DEPRECATED is not set
CONFIG_XENO_SKIN_RTDM=3Dy
CONFIG_XENO_OPT_RTDM_PERIOD=3D0
CONFIG_XENO_OPT_RTDM_FILDES=3D128
CONFIG_XENO_OPT_RTDM_SELECT=3Dy
# CONFIG_XENO_OPT_DEBUG_RTDM is not set
CONFIG_XENO_OPT_DEBUG_RTDM_APPL=3Dy

#
# Drivers
#

#
# Serial drivers
#
# CONFIG_XENO_DRIVERS_16550A is not set

#
# Testing drivers
#
CONFIG_XENO_DRIVERS_TIMERBENCH=3Dy
# CONFIG_XENO_DRIVERS_KLATENCY is not set
# CONFIG_XENO_DRIVERS_IRQBENCH is not set
CONFIG_XENO_DRIVERS_SWITCHTEST=3Dy
# CONFIG_XENO_DRIVERS_RTDMTEST is not set

#
# CAN drivers
#
# CONFIG_XENO_DRIVERS_CAN is not set

#
# ANALOGY drivers
#
# CONFIG_XENO_DRIVERS_ANALOGY is not set

#
# Real-time IPC drivers
#
CONFIG_XENO_DRIVERS_RTIPC=3Dy
CONFIG_XENO_DRIVERS_RTIPC_XDDP=3Dy
CONFIG_XENO_DRIVERS_RTIPC_IDDP=3Dy
CONFIG_XENO_OPT_IDDP_NRPORT=3D32
CONFIG_XENO_DRIVERS_RTIPC_BUFP=3Dy
CONFIG_XENO_OPT_BUFP_NRPORT=3D32
CONFIG_FREEZER=3Dy

#
# System Type
#
CONFIG_MMU=3Dy
# CONFIG_ARCH_MULTIPLATFORM is not set
# CONFIG_ARCH_INTEGRATOR is not set
# CONFIG_ARCH_REALVIEW is not set
# CONFIG_ARCH_VERSATILE is not set
# CONFIG_ARCH_AT91 is not set
# CONFIG_ARCH_BCM2835 is not set
# CONFIG_ARCH_CNS3XXX is not set
# CONFIG_ARCH_CLPS711X is not set
# CONFIG_ARCH_GEMINI is not set
# CONFIG_ARCH_SIRF is not set
# CONFIG_ARCH_EBSA110 is not set
# CONFIG_ARCH_EP93XX is not set
# CONFIG_ARCH_FOOTBRIDGE is not set
# CONFIG_ARCH_MXS is not set
# CONFIG_ARCH_NETX is not set
# CONFIG_ARCH_H720X is not set
# CONFIG_ARCH_IOP13XX is not set
# CONFIG_ARCH_IOP32X is not set
# CONFIG_ARCH_IOP33X is not set
# CONFIG_ARCH_IXP4XX is not set
# CONFIG_ARCH_DOVE is not set
# CONFIG_ARCH_KIRKWOOD is not set
# CONFIG_ARCH_MV78XX0 is not set
# CONFIG_ARCH_ORION5X is not set
# CONFIG_ARCH_MMP is not set
# CONFIG_ARCH_KS8695 is not set
# CONFIG_ARCH_W90X900 is not set
# CONFIG_ARCH_LPC32XX is not set
# CONFIG_ARCH_TEGRA is not set
# CONFIG_ARCH_PXA is not set
# CONFIG_ARCH_MSM is not set
# CONFIG_ARCH_SHMOBILE is not set
# CONFIG_ARCH_RPC is not set
# CONFIG_ARCH_SA1100 is not set
# CONFIG_ARCH_S3C24XX is not set
# CONFIG_ARCH_S3C64XX is not set
# CONFIG_ARCH_S5P64X0 is not set
# CONFIG_ARCH_S5PC100 is not set
# CONFIG_ARCH_S5PV210 is not set
# CONFIG_ARCH_EXYNOS is not set
# CONFIG_ARCH_SHARK is not set
# CONFIG_ARCH_U300 is not set
# CONFIG_ARCH_U8500 is not set
# CONFIG_ARCH_NOMADIK is not set
# CONFIG_PLAT_SPEAR is not set
# CONFIG_ARCH_DAVINCI is not set
CONFIG_ARCH_OMAP=3Dy
# CONFIG_ARCH_VT8500_SINGLE is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set

#
# TI OMAP Common Features
#
# CONFIG_ARCH_OMAP1 is not set
CONFIG_ARCH_OMAP2PLUS=3Dy

#
# OMAP Feature Selections
#
CONFIG_OMAP_RESET_CLOCKS=3Dy
CONFIG_OMAP_MUX=3Dy
CONFIG_OMAP_MUX_DEBUG=3Dy
CONFIG_OMAP_MUX_WARNINGS=3Dy
CONFIG_OMAP_MBOX_FWK=3Dy
CONFIG_OMAP_MBOX_KFIFO_SIZE=3D256
CONFIG_OMAP_32K_TIMER=3Dy
# CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE is not set
CONFIG_OMAP_32K_TIMER_HZ=3D512
CONFIG_OMAP_DM_TIMER=3Dy
CONFIG_OMAP_PM_NOOP=3Dy
CONFIG_MACH_OMAP_GENERIC=3Dy

#
# TI OMAP2/3/4 Specific Features
#
CONFIG_ARCH_OMAP2PLUS_TYPICAL=3Dy
CONFIG_SOC_HAS_OMAP2_SDRC=3Dy
# CONFIG_ARCH_OMAP2 is not set
CONFIG_ARCH_OMAP3=3Dy
CONFIG_ARCH_OMAP4=3Dy
# CONFIG_SOC_OMAP5 is not set
CONFIG_SOC_OMAP3430=3Dy
# CONFIG_SOC_TI81XX is not set
CONFIG_SOC_AM33XX=3Dy
CONFIG_OMAP_PACKAGE_CBB=3Dy
CONFIG_OMAP_PACKAGE_CBL=3Dy
CONFIG_OMAP_PACKAGE_CBS=3Dy

#
# OMAP Board Type
#
CONFIG_MACH_AM335XEVM=3Dy
CONFIG_MACH_AM335XIAEVM=3Dy
CONFIG_MACH_TAM335X=3Dy
CONFIG_MACH_OMAP3_BEAGLE=3Dy
# CONFIG_MACH_DEVKIT8000 is not set
# CONFIG_MACH_OMAP_LDP is not set
# CONFIG_MACH_OMAP3530_LV_SOM is not set
# CONFIG_MACH_OMAP3_TORPEDO is not set
# CONFIG_MACH_OVERO is not set
# CONFIG_MACH_OMAP3EVM is not set
# CONFIG_MACH_OMAP3517EVM is not set
# CONFIG_MACH_CRANEBOARD is not set
# CONFIG_MACH_OMAP3_PANDORA is not set
# CONFIG_MACH_TOUCHBOOK is not set
# CONFIG_MACH_OMAP_3430SDP is not set
# CONFIG_MACH_NOKIA_RM680 is not set
# CONFIG_MACH_NOKIA_RX51 is not set
# CONFIG_MACH_OMAP_ZOOM2 is not set
# CONFIG_MACH_OMAP_ZOOM3 is not set
# CONFIG_MACH_CM_T35 is not set
# CONFIG_MACH_CM_T3517 is not set
CONFIG_MACH_IGEP0020=3Dy
# CONFIG_MACH_IGEP0030 is not set
# CONFIG_MACH_SBC3530 is not set
# CONFIG_MACH_OMAP_3630SDP is not set
# CONFIG_MACH_OMAP_4430SDP is not set
CONFIG_MACH_OMAP4_PANDA=3Dy
# CONFIG_OMAP3_EMU is not set
# CONFIG_OMAP3_SDRC_AC_TIMING is not set
# CONFIG_OMAP4_ERRATA_I688 is not set
# CONFIG_ARCH_VT8500 is not set
CONFIG_IPIPE_ARM_KUSER_TSC=3Dy

#
# Processor Type
#
CONFIG_CPU_V7=3Dy
CONFIG_CPU_32v6K=3Dy
CONFIG_CPU_32v7=3Dy
CONFIG_CPU_ABRT_EV7=3Dy
CONFIG_CPU_PABRT_V7=3Dy
CONFIG_CPU_CACHE_V7=3Dy
CONFIG_CPU_CACHE_VIPT=3Dy
CONFIG_CPU_COPY_V6=3Dy
CONFIG_CPU_TLB_V7=3Dy
CONFIG_CPU_HAS_ASID=3Dy
CONFIG_CPU_CP15=3Dy
CONFIG_CPU_CP15_MMU=3Dy

#
# Processor Features
#
# CONFIG_ARM_LPAE is not set
# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
CONFIG_ARM_THUMB=3Dy
CONFIG_ARM_THUMBEE=3Dy
# CONFIG_ARM_VIRT_EXT is not set
CONFIG_SWP_EMULATE=3Dy
# CONFIG_CPU_ICACHE_DISABLE is not set
# CONFIG_CPU_DCACHE_DISABLE is not set
# CONFIG_CPU_BPREDICT_DISABLE is not set
CONFIG_OUTER_CACHE=3Dy
CONFIG_OUTER_CACHE_SYNC=3Dy
CONFIG_CACHE_L2X0=3Dy
CONFIG_CACHE_PL310=3Dy
CONFIG_ARM_L1_CACHE_SHIFT_6=3Dy
CONFIG_ARM_L1_CACHE_SHIFT=3D6
CONFIG_ARM_DMA_MEM_BUFFERABLE=3Dy
CONFIG_ARM_NR_BANKS=3D8
CONFIG_MULTI_IRQ_HANDLER=3Dy
# CONFIG_ARM_ERRATA_430973 is not set
# CONFIG_ARM_ERRATA_458693 is not set
# CONFIG_ARM_ERRATA_460075 is not set
CONFIG_PL310_ERRATA_588369=3Dy
CONFIG_ARM_ERRATA_720789=3Dy
CONFIG_PL310_ERRATA_727915=3Dy
# CONFIG_ARM_ERRATA_743622 is not set
# CONFIG_ARM_ERRATA_751472 is not set
# CONFIG_PL310_ERRATA_753970 is not set
# CONFIG_ARM_ERRATA_754322 is not set
# CONFIG_PL310_ERRATA_769419 is not set
# CONFIG_ARM_ERRATA_775420 is not set
CONFIG_ARM_GIC=3Dy
CONFIG_TI_PRIV_EDMA=3Dy

#
# Bus support
#
# CONFIG_PCI_SYSCALL is not set
# CONFIG_PCCARD is not set

#
# Kernel Features
#
CONFIG_HAVE_SMP=3Dy
# CONFIG_SMP is not set
# CONFIG_ARM_ARCH_TIMER is not set
CONFIG_VMSPLIT_3G=3Dy
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=3D0xC0000000
CONFIG_ARCH_NR_GPIO=3D0
CONFIG_IPIPE=3Dy
CONFIG_IPIPE_LEGACY=3Dy
CONFIG_IPIPE_CORE=3Dy
CONFIG_IPIPE_CORE_APIREV=3D2
CONFIG_IPIPE_WANT_APIREV_2=3Dy
CONFIG_IPIPE_TARGET_APIREV=3D2
CONFIG_IPIPE_HAVE_HOSTRT=3Dy
CONFIG_IPIPE_DELAYED_ATOMICSW=3Dy
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=3Dy
# CONFIG_PREEMPT is not set
CONFIG_HZ=3D512
# CONFIG_THUMB2_KERNEL is not set
CONFIG_AEABI=3Dy
CONFIG_OABI_COMPAT=3Dy
CONFIG_ARCH_HAS_HOLES_MEMORYMODEL=3Dy
# CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
# CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
CONFIG_HAVE_ARCH_PFN_VALID=3Dy
CONFIG_HIGHMEM=3Dy
# CONFIG_HIGHPTE is not set
CONFIG_HW_PERF_EVENTS=3Dy
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_FLATMEM_MANUAL=3Dy
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
CONFIG_HAVE_MEMBLOCK=3Dy
CONFIG_PAGEFLAGS_EXTENDED=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=3D999999
# CONFIG_COMPACTION is not set
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_ZONE_DMA_FLAG=3D0
CONFIG_BOUNCE=3Dy
CONFIG_VIRT_TO_BUS=3Dy
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096
CONFIG_CROSS_MEMORY_ATTACH=3Dy
CONFIG_NEED_PER_CPU_KM=3Dy
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
CONFIG_FORCE_MAX_ZONEORDER=3D12
CONFIG_ALIGNMENT_TRAP=3Dy
# CONFIG_UACCESS_WITH_MEMCPY is not set
CONFIG_SECCOMP=3Dy
# CONFIG_CC_STACKPROTECTOR is not set
# CONFIG_XEN is not set

#
# Boot options
#
CONFIG_USE_OF=3Dy
CONFIG_ATAGS=3Dy
# CONFIG_DEPRECATED_PARAM_STRUCT is not set
CONFIG_ZBOOT_ROM_TEXT=3D0x0
CONFIG_ZBOOT_ROM_BSS=3D0x0
# CONFIG_ARM_APPENDED_DTB is not set
CONFIG_CMDLINE=3D""
# CONFIG_XIP_KERNEL is not set
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_AUTO_ZRELADDR=3Dy

#
# CPU Power Management
#

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set

#
# Floating point emulation
#

#
# At least one emulation must be selected
#
# CONFIG_FPE_NWFPE is not set
# CONFIG_FPE_FASTFPE is not set
CONFIG_VFP=3Dy
CONFIG_VFPv3=3Dy
CONFIG_NEON=3Dy

#
# Userspace binary formats
#
CONFIG_BINFMT_ELF=3Dy
CONFIG_ARCH_BINFMT_ELF_RANDOMIZE_PIE=3Dy
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
CONFIG_HAVE_AOUT=3Dy
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=3Dm
CONFIG_COREDUMP=3Dy

#
# Power management options
#
CONFIG_SUSPEND=3Dy
CONFIG_SUSPEND_FREEZER=3Dy
CONFIG_PM_SLEEP=3Dy
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM_RUNTIME=3Dy
CONFIG_PM=3Dy
CONFIG_PM_DEBUG=3Dy
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=3Dy
# CONFIG_APM_EMULATION is not set
CONFIG_ARCH_HAS_OPP=3Dy
CONFIG_PM_OPP=3Dy
CONFIG_PM_CLK=3Dy
CONFIG_CPU_PM=3Dy
CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
CONFIG_ARM_CPU_SUSPEND=3Dy
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_PACKET_DIAG=3Dm
CONFIG_UNIX=3Dy
CONFIG_UNIX_DIAG=3Dm
CONFIG_XFRM=3Dy
CONFIG_XFRM_ALGO=3Dm
CONFIG_XFRM_USER=3Dm
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=3Dm
CONFIG_NET_KEY=3Dm
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
# CONFIG_IP_FIB_TRIE_STATS is not set
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
CONFIG_IP_ROUTE_CLASSID=3Dy
CONFIG_IP_PNP=3Dy
CONFIG_IP_PNP_DHCP=3Dy
CONFIG_IP_PNP_BOOTP=3Dy
CONFIG_IP_PNP_RARP=3Dy
CONFIG_NET_IPIP=3Dm
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_IP_MROUTE=3Dy
CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy
CONFIG_IP_PIMSM_V1=3Dy
CONFIG_IP_PIMSM_V2=3Dy
CONFIG_ARPD=3Dy
CONFIG_SYN_COOKIES=3Dy
CONFIG_NET_IPVTI=3Dm
CONFIG_INET_AH=3Dm
CONFIG_INET_ESP=3Dm
CONFIG_INET_IPCOMP=3Dm
CONFIG_INET_XFRM_TUNNEL=3Dm
CONFIG_INET_TUNNEL=3Dm
CONFIG_INET_XFRM_MODE_TRANSPORT=3Dm
CONFIG_INET_XFRM_MODE_TUNNEL=3Dm
CONFIG_INET_XFRM_MODE_BEET=3Dm
CONFIG_INET_LRO=3Dy
CONFIG_INET_DIAG=3Dy
CONFIG_INET_TCP_DIAG=3Dy
CONFIG_INET_UDP_DIAG=3Dy
CONFIG_TCP_CONG_ADVANCED=3Dy
CONFIG_TCP_CONG_BIC=3Dm
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_TCP_CONG_WESTWOOD=3Dm
CONFIG_TCP_CONG_HTCP=3Dm
CONFIG_TCP_CONG_HSTCP=3Dm
CONFIG_TCP_CONG_HYBLA=3Dm
CONFIG_TCP_CONG_VEGAS=3Dm
CONFIG_TCP_CONG_SCALABLE=3Dm
CONFIG_TCP_CONG_LP=3Dm
CONFIG_TCP_CONG_VENO=3Dm
CONFIG_TCP_CONG_YEAH=3Dm
CONFIG_TCP_CONG_ILLINOIS=3Dm
CONFIG_DEFAULT_CUBIC=3Dy
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
CONFIG_TCP_MD5SIG=3Dy
CONFIG_IPV6=3Dy
CONFIG_IPV6_PRIVACY=3Dy
CONFIG_IPV6_ROUTER_PREF=3Dy
CONFIG_IPV6_ROUTE_INFO=3Dy
CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
CONFIG_INET6_AH=3Dm
CONFIG_INET6_ESP=3Dm
CONFIG_INET6_IPCOMP=3Dm
CONFIG_IPV6_MIP6=3Dm
CONFIG_INET6_XFRM_TUNNEL=3Dm
CONFIG_INET6_TUNNEL=3Dm
CONFIG_INET6_XFRM_MODE_TRANSPORT=3Dm
CONFIG_INET6_XFRM_MODE_TUNNEL=3Dm
CONFIG_INET6_XFRM_MODE_BEET=3Dm
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=3Dm
CONFIG_IPV6_SIT=3Dm
CONFIG_IPV6_SIT_6RD=3Dy
CONFIG_IPV6_NDISC_NODETYPE=3Dy
CONFIG_IPV6_TUNNEL=3Dm
CONFIG_IPV6_GRE=3Dm
CONFIG_IPV6_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_SUBTREES=3Dy
CONFIG_IPV6_MROUTE=3Dy
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_PIMSM_V2=3Dy
CONFIG_NETLABEL=3Dy
CONFIG_NETWORK_SECMARK=3Dy
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=3Dy
CONFIG_BRIDGE_NETFILTER=3Dy

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=3Dm
CONFIG_NETFILTER_NETLINK_ACCT=3Dm
CONFIG_NETFILTER_NETLINK_QUEUE=3Dm
CONFIG_NETFILTER_NETLINK_LOG=3Dm
CONFIG_NF_CONNTRACK=3Dm
CONFIG_NF_CONNTRACK_MARK=3Dy
CONFIG_NF_CONNTRACK_SECMARK=3Dy
CONFIG_NF_CONNTRACK_ZONES=3Dy
CONFIG_NF_CONNTRACK_PROCFS=3Dy
CONFIG_NF_CONNTRACK_EVENTS=3Dy
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
CONFIG_NF_CT_PROTO_DCCP=3Dm
CONFIG_NF_CT_PROTO_GRE=3Dm
CONFIG_NF_CT_PROTO_SCTP=3Dm
CONFIG_NF_CT_PROTO_UDPLITE=3Dm
CONFIG_NF_CONNTRACK_AMANDA=3Dm
CONFIG_NF_CONNTRACK_FTP=3Dm
CONFIG_NF_CONNTRACK_H323=3Dm
CONFIG_NF_CONNTRACK_IRC=3Dm
CONFIG_NF_CONNTRACK_BROADCAST=3Dm
CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dm
# CONFIG_NF_CONNTRACK_SNMP is not set
CONFIG_NF_CONNTRACK_PPTP=3Dm
CONFIG_NF_CONNTRACK_SANE=3Dm
CONFIG_NF_CONNTRACK_SIP=3Dm
CONFIG_NF_CONNTRACK_TFTP=3Dm
CONFIG_NF_CT_NETLINK=3Dm
CONFIG_NF_CT_NETLINK_TIMEOUT=3Dm
# CONFIG_NF_CT_NETLINK_HELPER is not set
CONFIG_NETFILTER_NETLINK_QUEUE_CT=3Dy
CONFIG_NF_NAT=3Dm
CONFIG_NF_NAT_NEEDED=3Dy
CONFIG_NF_NAT_PROTO_DCCP=3Dm
CONFIG_NF_NAT_PROTO_UDPLITE=3Dm
CONFIG_NF_NAT_PROTO_SCTP=3Dm
CONFIG_NF_NAT_AMANDA=3Dm
CONFIG_NF_NAT_FTP=3Dm
CONFIG_NF_NAT_IRC=3Dm
CONFIG_NF_NAT_SIP=3Dm
CONFIG_NF_NAT_TFTP=3Dm
CONFIG_NETFILTER_TPROXY=3Dm
CONFIG_NETFILTER_XTABLES=3Dm

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=3Dm
CONFIG_NETFILTER_XT_CONNMARK=3Dm

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=3Dm
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm
CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_CT=3Dm
CONFIG_NETFILTER_XT_TARGET_DSCP=3Dm
CONFIG_NETFILTER_XT_TARGET_HL=3Dm
CONFIG_NETFILTER_XT_TARGET_HMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=3Dm
CONFIG_NETFILTER_XT_TARGET_LED=3Dm
CONFIG_NETFILTER_XT_TARGET_LOG=3Dm
CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
CONFIG_NETFILTER_XT_TARGET_NETMAP=3Dm
CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dm
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm
CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dm
CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dm
CONFIG_NETFILTER_XT_TARGET_REDIRECT=3Dm
CONFIG_NETFILTER_XT_TARGET_TEE=3Dm
CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dm
CONFIG_NETFILTER_XT_TARGET_TRACE=3Dm
CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dm
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dm

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dm
CONFIG_NETFILTER_XT_MATCH_CLUSTER=3Dm
CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
CONFIG_NETFILTER_XT_MATCH_CPU=3Dm
CONFIG_NETFILTER_XT_MATCH_DCCP=3Dm
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=3Dm
CONFIG_NETFILTER_XT_MATCH_DSCP=3Dm
CONFIG_NETFILTER_XT_MATCH_ECN=3Dm
CONFIG_NETFILTER_XT_MATCH_ESP=3Dm
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_HELPER=3Dm
CONFIG_NETFILTER_XT_MATCH_HL=3Dm
CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dm
CONFIG_NETFILTER_XT_MATCH_IPVS=3Dm
CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_MAC=3Dm
CONFIG_NETFILTER_XT_MATCH_MARK=3Dm
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dm
CONFIG_NETFILTER_XT_MATCH_NFACCT=3Dm
CONFIG_NETFILTER_XT_MATCH_OSF=3Dm
CONFIG_NETFILTER_XT_MATCH_OWNER=3Dm
CONFIG_NETFILTER_XT_MATCH_POLICY=3Dm
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=3Dm
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm
CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dm
CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dm
CONFIG_NETFILTER_XT_MATCH_REALM=3Dm
CONFIG_NETFILTER_XT_MATCH_RECENT=3Dm
CONFIG_NETFILTER_XT_MATCH_SCTP=3Dm
CONFIG_NETFILTER_XT_MATCH_SOCKET=3Dm
CONFIG_NETFILTER_XT_MATCH_STATE=3Dm
CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm
CONFIG_NETFILTER_XT_MATCH_STRING=3Dm
CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dm
CONFIG_NETFILTER_XT_MATCH_TIME=3Dm
CONFIG_NETFILTER_XT_MATCH_U32=3Dm
# CONFIG_IP_SET is not set
CONFIG_IP_VS=3Dm
CONFIG_IP_VS_IPV6=3Dy
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=3D12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=3Dy
CONFIG_IP_VS_PROTO_UDP=3Dy
CONFIG_IP_VS_PROTO_AH_ESP=3Dy
CONFIG_IP_VS_PROTO_ESP=3Dy
CONFIG_IP_VS_PROTO_AH=3Dy
CONFIG_IP_VS_PROTO_SCTP=3Dy

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=3Dm
CONFIG_IP_VS_WRR=3Dm
CONFIG_IP_VS_LC=3Dm
CONFIG_IP_VS_WLC=3Dm
CONFIG_IP_VS_LBLC=3Dm
CONFIG_IP_VS_LBLCR=3Dm
CONFIG_IP_VS_DH=3Dm
CONFIG_IP_VS_SH=3Dm
CONFIG_IP_VS_SED=3Dm
CONFIG_IP_VS_NQ=3Dm

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=3D8

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=3Dm
CONFIG_IP_VS_NFCT=3Dy
CONFIG_IP_VS_PE_SIP=3Dm

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=3Dm
CONFIG_NF_CONNTRACK_IPV4=3Dm
CONFIG_NF_CONNTRACK_PROC_COMPAT=3Dy
CONFIG_IP_NF_QUEUE=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_AH=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_RPFILTER=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_NF_NAT_IPV4=3Dm
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_NETMAP=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_NF_NAT_PROTO_GRE=3Dm
CONFIG_NF_NAT_PPTP=3Dm
CONFIG_NF_NAT_H323=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_CLUSTERIP=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_TTL=3Dm
CONFIG_IP_NF_RAW=3Dm
CONFIG_IP_NF_SECURITY=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IP_NF_ARP_MANGLE=3Dm

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV6=3Dm
CONFIG_NF_CONNTRACK_IPV6=3Dm
CONFIG_IP6_NF_IPTABLES=3Dm
CONFIG_IP6_NF_MATCH_AH=3Dm
CONFIG_IP6_NF_MATCH_EUI64=3Dm
CONFIG_IP6_NF_MATCH_FRAG=3Dm
CONFIG_IP6_NF_MATCH_OPTS=3Dm
CONFIG_IP6_NF_MATCH_HL=3Dm
CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
CONFIG_IP6_NF_MATCH_MH=3Dm
CONFIG_IP6_NF_MATCH_RPFILTER=3Dm
CONFIG_IP6_NF_MATCH_RT=3Dm
CONFIG_IP6_NF_TARGET_HL=3Dm
CONFIG_IP6_NF_FILTER=3Dm
CONFIG_IP6_NF_TARGET_REJECT=3Dm
CONFIG_IP6_NF_MANGLE=3Dm
CONFIG_IP6_NF_RAW=3Dm
CONFIG_IP6_NF_SECURITY=3Dm
CONFIG_NF_NAT_IPV6=3Dm
CONFIG_IP6_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP6_NF_TARGET_NPT=3Dm

#
# DECnet: Netfilter Configuration
#
CONFIG_DECNET_NF_GRABULATOR=3Dm
CONFIG_BRIDGE_NF_EBTABLES=3Dm
CONFIG_BRIDGE_EBT_BROUTE=3Dm
CONFIG_BRIDGE_EBT_T_FILTER=3Dm
CONFIG_BRIDGE_EBT_T_NAT=3Dm
CONFIG_BRIDGE_EBT_802_3=3Dm
CONFIG_BRIDGE_EBT_AMONG=3Dm
CONFIG_BRIDGE_EBT_ARP=3Dm
CONFIG_BRIDGE_EBT_IP=3Dm
CONFIG_BRIDGE_EBT_IP6=3Dm
CONFIG_BRIDGE_EBT_LIMIT=3Dm
CONFIG_BRIDGE_EBT_MARK=3Dm
CONFIG_BRIDGE_EBT_PKTTYPE=3Dm
CONFIG_BRIDGE_EBT_STP=3Dm
CONFIG_BRIDGE_EBT_VLAN=3Dm
CONFIG_BRIDGE_EBT_ARPREPLY=3Dm
CONFIG_BRIDGE_EBT_DNAT=3Dm
CONFIG_BRIDGE_EBT_MARK_T=3Dm
CONFIG_BRIDGE_EBT_REDIRECT=3Dm
CONFIG_BRIDGE_EBT_SNAT=3Dm
CONFIG_BRIDGE_EBT_LOG=3Dm
CONFIG_BRIDGE_EBT_ULOG=3Dm
CONFIG_BRIDGE_EBT_NFLOG=3Dm
CONFIG_IP_DCCP=3Dm
CONFIG_INET_DCCP_DIAG=3Dm

#
# DCCP CCIDs Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=3Dy
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=3Dy

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# CONFIG_NET_DCCPPROBE is not set
CONFIG_IP_SCTP=3Dm
CONFIG_NET_SCTPPROBE=3Dm
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=3Dy
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=3Dy
CONFIG_SCTP_COOKIE_HMAC_SHA1=3Dy
CONFIG_RDS=3Dm
CONFIG_RDS_TCP=3Dm
# CONFIG_RDS_DEBUG is not set
CONFIG_TIPC=3Dm
CONFIG_TIPC_PORTS=3D8191
CONFIG_ATM=3Dm
CONFIG_ATM_CLIP=3Dm
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=3Dm
CONFIG_ATM_MPOA=3Dm
CONFIG_ATM_BR2684=3Dm
CONFIG_ATM_BR2684_IPFILTER=3Dy
CONFIG_L2TP=3Dm
CONFIG_L2TP_DEBUGFS=3Dm
CONFIG_L2TP_V3=3Dy
CONFIG_L2TP_IP=3Dm
CONFIG_L2TP_ETH=3Dm
CONFIG_STP=3Dm
CONFIG_GARP=3Dm
CONFIG_BRIDGE=3Dm
CONFIG_BRIDGE_IGMP_SNOOPING=3Dy
CONFIG_HAVE_NET_DSA=3Dy
CONFIG_NET_DSA=3Dy
CONFIG_NET_DSA_TAG_DSA=3Dy
CONFIG_NET_DSA_TAG_EDSA=3Dy
CONFIG_NET_DSA_TAG_TRAILER=3Dy
CONFIG_VLAN_8021Q=3Dm
CONFIG_VLAN_8021Q_GVRP=3Dy
CONFIG_DECNET=3Dm
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=3Dm
CONFIG_LLC2=3Dm
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
CONFIG_LAPB=3Dm
CONFIG_WAN_ROUTER=3Dm
CONFIG_PHONET=3Dm
CONFIG_IEEE802154=3Dm
CONFIG_IEEE802154_6LOWPAN=3Dm
CONFIG_MAC802154=3Dm
CONFIG_NET_SCHED=3Dy

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_HFSC=3Dm
CONFIG_NET_SCH_ATM=3Dm
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_MULTIQ=3Dm
CONFIG_NET_SCH_RED=3Dm
# CONFIG_NET_SCH_SFB is not set
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_SCH_NETEM=3Dm
CONFIG_NET_SCH_DRR=3Dm
# CONFIG_NET_SCH_MQPRIO is not set
# CONFIG_NET_SCH_CHOKE is not set
# CONFIG_NET_SCH_QFQ is not set
CONFIG_NET_SCH_CODEL=3Dm
CONFIG_NET_SCH_FQ_CODEL=3Dm
# CONFIG_NET_SCH_INGRESS is not set
# CONFIG_NET_SCH_PLUG is not set

#
# Classification
#
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_BASIC=3Dm
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_FW=3Dm
# CONFIG_NET_CLS_U32 is not set
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
# CONFIG_NET_CLS_FLOW is not set
# CONFIG_NET_CLS_CGROUP is not set
CONFIG_NET_EMATCH=3Dy
CONFIG_NET_EMATCH_STACK=3D32
CONFIG_NET_EMATCH_CMP=3Dm
CONFIG_NET_EMATCH_NBYTE=3Dm
CONFIG_NET_EMATCH_U32=3Dm
CONFIG_NET_EMATCH_META=3Dm
CONFIG_NET_EMATCH_TEXT=3Dm
CONFIG_NET_EMATCH_CANID=3Dm
CONFIG_NET_CLS_ACT=3Dy
CONFIG_NET_ACT_POLICE=3Dm
CONFIG_NET_ACT_GACT=3Dm
CONFIG_GACT_PROB=3Dy
CONFIG_NET_ACT_MIRRED=3Dm
CONFIG_NET_ACT_IPT=3Dm
CONFIG_NET_ACT_NAT=3Dm
CONFIG_NET_ACT_PEDIT=3Dm
CONFIG_NET_ACT_SIMP=3Dm
CONFIG_NET_ACT_SKBEDIT=3Dm
CONFIG_NET_ACT_CSUM=3Dm
# CONFIG_NET_CLS_IND is not set
CONFIG_NET_SCH_FIFO=3Dy
CONFIG_DCB=3Dy
CONFIG_DNS_RESOLVER=3Dy
CONFIG_BATMAN_ADV=3Dm
CONFIG_BATMAN_ADV_BLA=3Dy
# CONFIG_BATMAN_ADV_DAT is not set
# CONFIG_BATMAN_ADV_DEBUG is not set
CONFIG_OPENVSWITCH=3Dm
CONFIG_NETPRIO_CGROUP=3Dm
CONFIG_BQL=3Dy
CONFIG_BPF_JIT=3Dy

#
# Network testing
#
CONFIG_NET_PKTGEN=3Dm
# CONFIG_NET_TCPPROBE is not set
# CONFIG_NET_DROP_MONITOR is not set
CONFIG_HAMRADIO=3Dy

#
# Packet Radio protocols
#
CONFIG_AX25=3Dm
CONFIG_AX25_DAMA_SLAVE=3Dy
CONFIG_NETROM=3Dm
CONFIG_ROSE=3Dm

#
# AX.25 network device drivers
#
CONFIG_MKISS=3Dm
CONFIG_6PACK=3Dm
CONFIG_BPQETHER=3Dm
CONFIG_BAYCOM_SER_FDX=3Dm
CONFIG_BAYCOM_SER_HDX=3Dm
CONFIG_YAM=3Dm
CONFIG_CAN=3Dm
CONFIG_CAN_RAW=3Dm
CONFIG_CAN_BCM=3Dm
CONFIG_CAN_GW=3Dm

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=3Dm
CONFIG_CAN_SLCAN=3Dm
CONFIG_CAN_DEV=3Dm
CONFIG_CAN_CALC_BITTIMING=3Dy
CONFIG_CAN_TI_HECC=3Dm
CONFIG_CAN_MCP251X=3Dm
CONFIG_CAN_GRCAN=3Dm
# CONFIG_CAN_SJA1000 is not set
CONFIG_CAN_C_CAN=3Dm
CONFIG_CAN_C_CAN_PLATFORM=3Dm
# CONFIG_CAN_CC770 is not set

#
# CAN USB interfaces
#
CONFIG_CAN_EMS_USB=3Dm
CONFIG_CAN_ESD_USB2=3Dm
CONFIG_CAN_KVASER_USB=3Dm
CONFIG_CAN_PEAK_USB=3Dm
# CONFIG_CAN_SOFTING is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_IRDA=3Dm

#
# IrDA protocols
#
CONFIG_IRLAN=3Dm
CONFIG_IRNET=3Dm
CONFIG_IRCOMM=3Dm
CONFIG_IRDA_ULTRA=3Dy

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=3Dy
CONFIG_IRDA_FAST_RR=3Dy
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=3Dm

#
# Dongle support
#
CONFIG_DONGLE=3Dy
CONFIG_ESI_DONGLE=3Dm
CONFIG_ACTISYS_DONGLE=3Dm
CONFIG_TEKRAM_DONGLE=3Dm
CONFIG_TOIM3232_DONGLE=3Dm
CONFIG_LITELINK_DONGLE=3Dm
CONFIG_MA600_DONGLE=3Dm
CONFIG_GIRBIL_DONGLE=3Dm
CONFIG_MCP2120_DONGLE=3Dm
CONFIG_OLD_BELKIN_DONGLE=3Dm
CONFIG_ACT200L_DONGLE=3Dm
CONFIG_KINGSUN_DONGLE=3Dm
CONFIG_KSDAZZLE_DONGLE=3Dm
CONFIG_KS959_DONGLE=3Dm

#
# FIR device drivers
#
CONFIG_USB_IRDA=3Dm
CONFIG_SIGMATEL_FIR=3Dm
CONFIG_MCS_FIR=3Dm
CONFIG_BT=3Dm
CONFIG_BT_RFCOMM=3Dm
CONFIG_BT_RFCOMM_TTY=3Dy
CONFIG_BT_BNEP=3Dm
CONFIG_BT_BNEP_MC_FILTER=3Dy
CONFIG_BT_BNEP_PROTO_FILTER=3Dy
CONFIG_BT_HIDP=3Dm

#
# Bluetooth device drivers
#
CONFIG_BT_HCIBTUSB=3Dm
CONFIG_BT_HCIBTSDIO=3Dm
CONFIG_BT_HCIUART=3Dm
CONFIG_BT_HCIUART_H4=3Dy
CONFIG_BT_HCIUART_BCSP=3Dy
CONFIG_BT_HCIUART_ATH3K=3Dy
CONFIG_BT_HCIUART_LL=3Dy
CONFIG_BT_HCIUART_3WIRE=3Dy
CONFIG_BT_HCIBCM203X=3Dm
CONFIG_BT_HCIBPA10X=3Dm
CONFIG_BT_HCIBFUSB=3Dm
CONFIG_BT_HCIVHCI=3Dm
CONFIG_BT_MRVL=3Dm
CONFIG_BT_MRVL_SDIO=3Dm
CONFIG_BT_ATH3K=3Dm
CONFIG_BT_WILINK=3Dm
CONFIG_AF_RXRPC=3Dm
# CONFIG_AF_RXRPC_DEBUG is not set
CONFIG_RXKAD=3Dm
CONFIG_FIB_RULES=3Dy
CONFIG_WIRELESS=3Dy
CONFIG_WIRELESS_EXT=3Dy
CONFIG_WEXT_CORE=3Dy
CONFIG_WEXT_PROC=3Dy
CONFIG_WEXT_SPY=3Dy
CONFIG_WEXT_PRIV=3Dy
CONFIG_CFG80211=3Dm
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_REG_DEBUG is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_DEFAULT_PS=3Dy
CONFIG_CFG80211_DEBUGFS=3Dy
# CONFIG_CFG80211_INTERNAL_REGDB is not set
CONFIG_CFG80211_WEXT=3Dy
CONFIG_LIB80211=3Dm
CONFIG_LIB80211_CRYPT_WEP=3Dm
CONFIG_LIB80211_CRYPT_CCMP=3Dm
CONFIG_LIB80211_CRYPT_TKIP=3Dm
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=3Dm
CONFIG_MAC80211_HAS_RC=3Dy
CONFIG_MAC80211_RC_PID=3Dy
CONFIG_MAC80211_RC_MINSTREL=3Dy
CONFIG_MAC80211_RC_MINSTREL_HT=3Dy
CONFIG_MAC80211_RC_DEFAULT_PID=3Dy
# CONFIG_MAC80211_RC_DEFAULT_MINSTREL is not set
CONFIG_MAC80211_RC_DEFAULT=3D"pid"
CONFIG_MAC80211_MESH=3Dy
CONFIG_MAC80211_LEDS=3Dy
CONFIG_MAC80211_DEBUGFS=3Dy
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_WIMAX=3Dm
CONFIG_WIMAX_DEBUG_LEVEL=3D8
CONFIG_RFKILL=3Dm
CONFIG_RFKILL_LEDS=3Dy
CONFIG_RFKILL_INPUT=3Dy
CONFIG_RFKILL_REGULATOR=3Dm
CONFIG_RFKILL_GPIO=3Dm
CONFIG_NET_9P=3Dm
CONFIG_NET_9P_VIRTIO=3Dm
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=3Dm
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=3Dm
CONFIG_CAIF_USB=3Dm
CONFIG_CEPH_LIB=3Dm
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
# CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
CONFIG_NFC=3Dm
CONFIG_NFC_NCI=3Dm
CONFIG_NFC_HCI=3Dm
CONFIG_NFC_SHDLC=3Dy
# CONFIG_NFC_LLCP is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_PN544_HCI_NFC=3Dm
CONFIG_NFC_PN533=3Dm
CONFIG_NFC_WILINK=3Dm
CONFIG_HAVE_BPF_JIT=3Dy

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH=3D""
CONFIG_DEVTMPFS=3Dy
CONFIG_DEVTMPFS_MOUNT=3Dy
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dy
CONFIG_FIRMWARE_IN_KERNEL=3Dy
CONFIG_EXTRA_FIRMWARE=3D"am335x-pm-firmware.bin"
CONFIG_EXTRA_FIRMWARE_DIR=3D"firmware"
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_REGMAP=3Dy
CONFIG_REGMAP_I2C=3Dy
CONFIG_REGMAP_SPI=3Dy
CONFIG_REGMAP_MMIO=3Dy
CONFIG_DMA_SHARED_BUFFER=3Dy
# CONFIG_CMA is not set

#
# Bus devices
#
CONFIG_OMAP_OCP2SCP=3Dy
CONFIG_OMAP_INTERCONNECT=3Dy
CONFIG_CONNECTOR=3Dy
CONFIG_PROC_EVENTS=3Dy
CONFIG_MTD=3Dy
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=3Dy
# CONFIG_MTD_AFS_PARTS is not set
CONFIG_MTD_OF_PARTS=3Dy
# CONFIG_MTD_AR7_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=3Dy
CONFIG_MTD_BLKDEVS=3Dy
CONFIG_MTD_BLOCK=3Dy
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=3Dy
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=3Dy
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=3Dy
CONFIG_MTD_CFI_I2=3Dy
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=3Dy
# CONFIG_MTD_CFI_AMDSTD is not set
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=3Dy
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_PHYSMAP_OF is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_M25P80 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOC2001PLUS is not set
# CONFIG_MTD_DOCG3 is not set
CONFIG_MTD_NAND_ECC=3Dy
# CONFIG_MTD_NAND_ECC_SMC is not set
CONFIG_MTD_NAND=3Dy
# CONFIG_MTD_NAND_ECC_BCH is not set
# CONFIG_MTD_SM_COMMON is not set
# CONFIG_MTD_NAND_MUSEUM_IDS is not set
# CONFIG_MTD_NAND_DENALI is not set
# CONFIG_MTD_NAND_GPIO is not set
CONFIG_MTD_NAND_OMAP2=3Dy
# CONFIG_MTD_NAND_OMAP_BCH is not set
CONFIG_MTD_NAND_IDS=3Dy
# CONFIG_MTD_NAND_DISKONCHIP is not set
# CONFIG_MTD_NAND_DOCG4 is not set
# CONFIG_MTD_NAND_NANDSIM is not set
# CONFIG_MTD_NAND_PLATFORM is not set
# CONFIG_MTD_ALAUDA is not set
CONFIG_MTD_ONENAND=3Dy
CONFIG_MTD_ONENAND_VERIFY_WRITE=3Dy
# CONFIG_MTD_ONENAND_GENERIC is not set
CONFIG_MTD_ONENAND_OMAP2=3Dy
# CONFIG_MTD_ONENAND_OTP is not set
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
# CONFIG_MTD_ONENAND_SIM is not set

#
# LPDDR flash memory drivers
#
# CONFIG_MTD_LPDDR is not set
CONFIG_MTD_UBI=3Dy
CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
CONFIG_MTD_UBI_BEB_LIMIT=3D20
CONFIG_MTD_UBI_FASTMAP=3Dy
# CONFIG_MTD_UBI_GLUEBI is not set
CONFIG_DTC=3Dy
CONFIG_OF=3Dy

#
# Device Tree and Open Firmware support
#
CONFIG_PROC_DEVICETREE=3Dy
# CONFIG_OF_SELFTEST is not set
CONFIG_OF_FLATTREE=3Dy
CONFIG_OF_EARLY_FLATTREE=3Dy
CONFIG_OF_DYNAMIC=3Dy
CONFIG_OF_ADDRESS=3Dy
CONFIG_OF_IRQ=3Dy
CONFIG_OF_DEVICE=3Dy
CONFIG_OF_I2C=3Dy
CONFIG_OF_NET=3Dy
CONFIG_OF_MDIO=3Dy
CONFIG_OF_MTD=3Dy
CONFIG_OF_RESOLVE=3Dy
CONFIG_OF_OVERLAY=3Dy
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=3Dy
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dy
CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_BLK_DEV_RAM_SIZE=3D16384
# CONFIG_BLK_DEV_XIP is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_MG_DISK is not set
CONFIG_VIRTIO_BLK=3Dm
# CONFIG_BLK_DEV_RBD is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
# CONFIG_AD525X_DPOT is not set
# CONFIG_ATMEL_PWM is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=3Dm
# CONFIG_SENSORS_BH1780 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=3Dm
# CONFIG_DS1682 is not set
# CONFIG_TI_DAC7512 is not set
CONFIG_BMP085=3Dy
CONFIG_BMP085_I2C=3Dm
# CONFIG_BMP085_SPI is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
CONFIG_GPEVT=3Dy
CONFIG_GROVE_I2C=3Dy
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=3Dy
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=3Dy
# CONFIG_EEPROM_93XX46 is not set

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=3Dm
# CONFIG_SENSORS_LIS3_SPI is not set
# CONFIG_SENSORS_LIS3_I2C is not set

#
# Altera FPGA firmware download module
#
# CONFIG_ALTERA_STAPL is not set
CONFIG_BEAGLEBONE_PINMUX_HELPER=3Dy
CONFIG_BEAGLEBONE_IIO_HELPER=3Dy
CONFIG_CAPE_BEAGLEBONE=3Dy
CONFIG_CAPE_BEAGLEBONE_GEIGER=3Dy
CONFIG_CAPE_BEAGLEBONE_ARGUS=3Dy
CONFIG_CAPE_BEAGLEBONE_NIXIE=3Dy

#
# SCSI device support
#
CONFIG_SCSI_MOD=3Dy
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=3Dy
CONFIG_SCSI_DMA=3Dy
# CONFIG_SCSI_TGT is not set
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dy
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_MULTI_LUN=3Dy
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=3Dy

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
CONFIG_SCSI_ISCSI_ATTRS=3Dm
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
CONFIG_SCSI_LOWLEVEL=3Dy
CONFIG_ISCSI_TCP=3Dm
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_LIBFC is not set
# CONFIG_LIBFCOE is not set
# CONFIG_SCSI_DEBUG is not set
CONFIG_SCSI_VIRTIO=3Dm
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
# CONFIG_ATA is not set
CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dm
CONFIG_MD_LINEAR=3Dm
CONFIG_MD_RAID0=3Dm
CONFIG_MD_RAID1=3Dm
CONFIG_MD_RAID10=3Dm
CONFIG_MD_RAID456=3Dm
CONFIG_MD_MULTIPATH=3Dm
CONFIG_MD_FAULTY=3Dm
CONFIG_BLK_DEV_DM=3Dy
CONFIG_DM_DEBUG=3Dy
CONFIG_DM_CRYPT=3Dm
CONFIG_DM_SNAPSHOT=3Dm
# CONFIG_DM_THIN_PROVISIONING is not set
CONFIG_DM_MIRROR=3Dm
CONFIG_DM_RAID=3Dm
# CONFIG_DM_LOG_USERSPACE is not set
CONFIG_DM_ZERO=3Dm
CONFIG_DM_MULTIPATH=3Dm
CONFIG_DM_MULTIPATH_QL=3Dm
CONFIG_DM_MULTIPATH_ST=3Dm
# CONFIG_DM_DELAY is not set
# CONFIG_DM_UEVENT is not set
# CONFIG_DM_FLAKEY is not set
# CONFIG_DM_VERITY is not set
# CONFIG_TARGET_CORE is not set
CONFIG_NETDEVICES=3Dy
CONFIG_NET_CORE=3Dy
CONFIG_BONDING=3Dm
CONFIG_DUMMY=3Dm
CONFIG_EQUALIZER=3Dm
CONFIG_MII=3Dy
CONFIG_IFB=3Dm
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
CONFIG_TUN=3Dm
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
CONFIG_ATM_DRIVERS=3Dy
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set

#
# CAIF transport drivers
#
# CONFIG_CAIF_TTY is not set
# CONFIG_CAIF_SPI_SLAVE is not set
# CONFIG_CAIF_HSI is not set

#
# Distributed Switch Architecture drivers
#
CONFIG_NET_DSA_MV88E6XXX=3Dy
CONFIG_NET_DSA_MV88E6060=3Dy
CONFIG_NET_DSA_MV88E6XXX_NEED_PPU=3Dy
CONFIG_NET_DSA_MV88E6131=3Dy
CONFIG_NET_DSA_MV88E6123_61_65=3Dy
CONFIG_ETHERNET=3Dy
CONFIG_NET_CADENCE=3Dy
# CONFIG_ARM_AT91_ETHER is not set
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_BROADCOM=3Dy
# CONFIG_B44 is not set
# CONFIG_NET_CALXEDA_XGMAC is not set
CONFIG_NET_VENDOR_CIRRUS=3Dy
# CONFIG_CS89x0 is not set
CONFIG_DM9000=3Dm
CONFIG_DM9000_FORCE_SIMPLE_PHY_POLL=3Dy
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_FARADAY=3Dy
# CONFIG_FTMAC100 is not set
# CONFIG_FTGMAC100 is not set
CONFIG_NET_VENDOR_INTEL=3Dy
CONFIG_NET_VENDOR_I825XX=3Dy
CONFIG_NET_VENDOR_MARVELL=3Dy
# CONFIG_MVMDIO is not set
CONFIG_NET_VENDOR_MICREL=3Dy
CONFIG_KS8842=3Dm
CONFIG_KS8851=3Dy
CONFIG_KS8851_MLL=3Dy
CONFIG_NET_VENDOR_MICROCHIP=3Dy
CONFIG_ENC28J60=3Dm
# CONFIG_ENC28J60_WRITEVERIFY is not set
CONFIG_NET_VENDOR_NATSEMI=3Dy
CONFIG_NET_VENDOR_8390=3Dy
# CONFIG_AX88796 is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_SEEQ=3Dy
# CONFIG_SEEQ8005 is not set
CONFIG_NET_VENDOR_SMSC=3Dy
CONFIG_SMC91X=3Dy
# CONFIG_SMC911X is not set
CONFIG_SMSC911X=3Dy
# CONFIG_SMSC911X_ARCH_HOOKS is not set
CONFIG_NET_VENDOR_STMICRO=3Dy
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_TI=3Dy
CONFIG_TI_DAVINCI_EMAC=3Dy
CONFIG_TI_DAVINCI_MDIO=3Dy
CONFIG_TI_DAVINCI_CPDMA=3Dy
CONFIG_TI_CPSW=3Dy
# CONFIG_TI_CPTS is not set
CONFIG_NET_VENDOR_WIZNET=3Dy
CONFIG_WIZNET_W5100=3Dm
CONFIG_WIZNET_W5300=3Dm
# CONFIG_WIZNET_BUS_DIRECT is not set
# CONFIG_WIZNET_BUS_INDIRECT is not set
CONFIG_WIZNET_BUS_ANY=3Dy
CONFIG_PHYLIB=3Dy

#
# MII PHY device drivers
#
CONFIG_AT803X_PHY=3Dy
# CONFIG_AMD_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
CONFIG_SMSC_PHY=3Dy
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_FIXED_PHY is not set
# CONFIG_MDIO_BITBANG is not set
CONFIG_MDIO_BUS_MUX=3Dm
# CONFIG_MDIO_BUS_MUX_GPIO is not set
CONFIG_MDIO_BUS_MUX_MMIOREG=3Dm
# CONFIG_MICREL_KS8995MA is not set
CONFIG_PPP=3Dm
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_FILTER=3Dy
CONFIG_PPP_MPPE=3Dm
CONFIG_PPP_MULTILINK=3Dy
CONFIG_PPPOATM=3Dm
CONFIG_PPPOE=3Dm
CONFIG_PPPOL2TP=3Dm
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_SLIP=3Dm
CONFIG_SLHC=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLIP_SMART=3Dy
CONFIG_SLIP_MODE_SLIP6=3Dy

#
# USB Network Adapters
#
CONFIG_USB_CATC=3Dm
CONFIG_USB_KAWETH=3Dm
CONFIG_USB_PEGASUS=3Dm
CONFIG_USB_RTL8150=3Dm
CONFIG_USB_USBNET=3Dy
CONFIG_USB_NET_AX8817X=3Dm
CONFIG_USB_NET_CDCETHER=3Dy
CONFIG_USB_NET_CDC_EEM=3Dm
CONFIG_USB_NET_CDC_NCM=3Dy
CONFIG_USB_NET_CDC_MBIM=3Dm
CONFIG_USB_NET_DM9601=3Dm
CONFIG_USB_NET_SMSC75XX=3Dm
CONFIG_USB_NET_SMSC95XX=3Dm
CONFIG_USB_NET_GL620A=3Dm
CONFIG_USB_NET_NET1080=3Dm
CONFIG_USB_NET_PLUSB=3Dm
CONFIG_USB_NET_MCS7830=3Dm
CONFIG_USB_NET_RNDIS_HOST=3Dy
CONFIG_USB_NET_CDC_SUBSET=3Dm
CONFIG_USB_ALI_M5632=3Dy
CONFIG_USB_AN2720=3Dy
CONFIG_USB_BELKIN=3Dy
CONFIG_USB_ARMLINUX=3Dy
CONFIG_USB_EPSON2888=3Dy
CONFIG_USB_KC2190=3Dy
CONFIG_USB_NET_ZAURUS=3Dm
CONFIG_USB_NET_CX82310_ETH=3Dm
CONFIG_USB_NET_KALMIA=3Dm
CONFIG_USB_NET_QMI_WWAN=3Dm
CONFIG_USB_HSO=3Dm
CONFIG_USB_NET_INT51X1=3Dm
CONFIG_USB_CDC_PHONET=3Dm
CONFIG_USB_IPHETH=3Dm
CONFIG_USB_SIERRA_NET=3Dm
CONFIG_USB_VL600=3Dm
CONFIG_WLAN=3Dy
CONFIG_LIBERTAS_THINFIRM=3Dm
# CONFIG_LIBERTAS_THINFIRM_DEBUG is not set
CONFIG_LIBERTAS_THINFIRM_USB=3Dm
CONFIG_AT76C50X_USB=3Dm
CONFIG_USB_ZD1201=3Dm
CONFIG_USB_NET_RNDIS_WLAN=3Dm
CONFIG_RTL8187=3Dm
CONFIG_RTL8187_LEDS=3Dy
CONFIG_MAC80211_HWSIM=3Dm
CONFIG_ATH_COMMON=3Dm
CONFIG_ATH_CARDS=3Dm
# CONFIG_ATH_DEBUG is not set
CONFIG_ATH9K_HW=3Dm
CONFIG_ATH9K_COMMON=3Dm
CONFIG_ATH9K_BTCOEX_SUPPORT=3Dy
CONFIG_ATH9K=3Dm
CONFIG_ATH9K_AHB=3Dy
CONFIG_ATH9K_DEBUGFS=3Dy
CONFIG_ATH9K_MAC_DEBUG=3Dy
CONFIG_ATH9K_RATE_CONTROL=3Dy
CONFIG_ATH9K_HTC=3Dm
CONFIG_ATH9K_HTC_DEBUGFS=3Dy
CONFIG_CARL9170=3Dm
CONFIG_CARL9170_LEDS=3Dy
# CONFIG_CARL9170_DEBUGFS is not set
CONFIG_CARL9170_WPC=3Dy
CONFIG_CARL9170_HWRNG=3Dy
CONFIG_ATH6KL=3Dm
CONFIG_ATH6KL_SDIO=3Dm
CONFIG_ATH6KL_USB=3Dm
# CONFIG_ATH6KL_DEBUG is not set
CONFIG_AR5523=3Dm
CONFIG_B43=3Dm
CONFIG_B43_SSB=3Dy
# CONFIG_B43_SDIO is not set
CONFIG_B43_PIO=3Dy
CONFIG_B43_PHY_N=3Dy
CONFIG_B43_PHY_LP=3Dy
# CONFIG_B43_PHY_HT is not set
CONFIG_B43_LEDS=3Dy
CONFIG_B43_HWRNG=3Dy
# CONFIG_B43_DEBUG is not set
CONFIG_B43LEGACY=3Dm
CONFIG_B43LEGACY_LEDS=3Dy
CONFIG_B43LEGACY_HWRNG=3Dy
# CONFIG_B43LEGACY_DEBUG is not set
CONFIG_B43LEGACY_DMA=3Dy
CONFIG_B43LEGACY_PIO=3Dy
CONFIG_B43LEGACY_DMA_AND_PIO_MODE=3Dy
# CONFIG_B43LEGACY_DMA_MODE is not set
# CONFIG_B43LEGACY_PIO_MODE is not set
CONFIG_BRCMUTIL=3Dm
CONFIG_BRCMFMAC=3Dm
CONFIG_BRCMFMAC_SDIO=3Dy
CONFIG_BRCMFMAC_SDIO_OOB=3Dy
CONFIG_BRCMFMAC_USB=3Dy
CONFIG_BRCM_TRACING=3Dy
CONFIG_BRCMDBG=3Dy
CONFIG_HOSTAP=3Dm
CONFIG_HOSTAP_FIRMWARE=3Dy
CONFIG_HOSTAP_FIRMWARE_NVRAM=3Dy
CONFIG_LIBERTAS=3Dm
CONFIG_LIBERTAS_USB=3Dm
CONFIG_LIBERTAS_SDIO=3Dm
CONFIG_LIBERTAS_SPI=3Dm
# CONFIG_LIBERTAS_DEBUG is not set
# CONFIG_LIBERTAS_MESH is not set
CONFIG_P54_COMMON=3Dm
CONFIG_P54_USB=3Dm
CONFIG_P54_SPI=3Dm
CONFIG_P54_SPI_DEFAULT_EEPROM=3Dy
CONFIG_P54_LEDS=3Dy
CONFIG_RT2X00=3Dm
CONFIG_RT2500USB=3Dm
CONFIG_RT73USB=3Dm
CONFIG_RT2800USB=3Dm
CONFIG_RT2800USB_RT33XX=3Dy
CONFIG_RT2800USB_RT35XX=3Dy
CONFIG_RT2800USB_RT53XX=3Dy
CONFIG_RT2800USB_UNKNOWN=3Dy
CONFIG_RT2800_LIB=3Dm
CONFIG_RT2X00_LIB_USB=3Dm
CONFIG_RT2X00_LIB=3Dm
CONFIG_RT2X00_LIB_FIRMWARE=3Dy
CONFIG_RT2X00_LIB_CRYPTO=3Dy
CONFIG_RT2X00_LIB_LEDS=3Dy
# CONFIG_RT2X00_LIB_DEBUGFS is not set
# CONFIG_RT2X00_DEBUG is not set
CONFIG_RTL8192CU=3Dm
CONFIG_RTLWIFI=3Dm
CONFIG_RTLWIFI_DEBUG=3Dy
CONFIG_RTL8192C_COMMON=3Dm
CONFIG_WL_TI=3Dy
CONFIG_WL1251=3Dm
CONFIG_WL1251_SPI=3Dm
CONFIG_WL1251_SDIO=3Dm
CONFIG_WL12XX=3Dm
CONFIG_WL18XX=3Dm
CONFIG_WLCORE=3Dm
CONFIG_WLCORE_SPI=3Dm
CONFIG_WLCORE_SDIO=3Dm
CONFIG_WL12XX_PLATFORM_DATA=3Dy
CONFIG_ZD1211RW=3Dm
# CONFIG_ZD1211RW_DEBUG is not set
CONFIG_MWIFIEX=3Dm
CONFIG_MWIFIEX_SDIO=3Dm
CONFIG_MWIFIEX_USB=3Dm

#
# WiMAX Wireless Broadband devices
#
# CONFIG_WIMAX_I2400M_USB is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=3Dm
CONFIG_IEEE802154_FAKEHARD=3Dm
CONFIG_IEEE802154_FAKELB=3Dm
CONFIG_IEEE802154_AT86RF230=3Dm
CONFIG_IEEE802154_MRF24J40=3Dm
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=3Dy
CONFIG_INPUT_FF_MEMLESS=3Dm
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=3Dy

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_JOYDEV=3Dy
CONFIG_INPUT_EVDEV=3Dy
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=3Dy
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_OMAP4 is not set
CONFIG_KEYBOARD_TWL4030=3Dy
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
CONFIG_MOUSE_PS2_ALPS=3Dy
CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=3Dy
CONFIG_TOUCHSCREEN_ADS7846=3Dy
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=3Dy
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
CONFIG_TOUCHSCREEN_MMS114=3Dm
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
CONFIG_TOUCHSCREEN_EDT_FT5X06=3Dm
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=3Dy
# CONFIG_TOUCHSCREEN_PIXCIR is not set
CONFIG_TOUCHSCREEN_WM97XX=3Dm
CONFIG_TOUCHSCREEN_WM9705=3Dy
CONFIG_TOUCHSCREEN_WM9712=3Dy
CONFIG_TOUCHSCREEN_WM9713=3Dy
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
CONFIG_TOUCHSCREEN_TSC2005=3Dy
CONFIG_TOUCHSCREEN_TSC2007=3Dy
# CONFIG_TOUCHSCREEN_W90X900 is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_INPUT_MISC=3Dy
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_MPU3050 is not set
# CONFIG_INPUT_GP2A is not set
# CONFIG_INPUT_GPIO_TILT_POLLED is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_TWL4030_PWRBUTTON=3Dy
# CONFIG_INPUT_TWL4030_VIBRA is not set
CONFIG_INPUT_UINPUT=3Dm
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=3Dm
CONFIG_INPUT_ADXL34X=3Dm
CONFIG_INPUT_ADXL34X_I2C=3Dm
CONFIG_INPUT_ADXL34X_SPI=3Dm
CONFIG_INPUT_CMA3000=3Dm
CONFIG_INPUT_CMA3000_I2C=3Dm

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_SERPORT=3Dy
CONFIG_SERIO_LIBPS2=3Dy
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_CONSOLE_TRANSLATIONS=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_VT_CONSOLE_SLEEP=3Dy
CONFIG_HW_CONSOLE=3Dy
CONFIG_VT_HW_CONSOLE_BINDING=3Dy
CONFIG_UNIX98_PTYS=3Dy
# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
# CONFIG_LEGACY_PTYS is not set
CONFIG_JHD629_I2C=3Dy
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
CONFIG_DEVKMEM=3Dy

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_SERIAL_8250_NR_UARTS=3D32
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
CONFIG_SERIAL_8250_EXTENDED=3Dy
CONFIG_SERIAL_8250_MANY_PORTS=3Dy
CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
CONFIG_SERIAL_8250_DETECT_IRQ=3Dy
CONFIG_SERIAL_8250_RSA=3Dy
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_EM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
# CONFIG_SERIAL_OF_PLATFORM is not set
CONFIG_SERIAL_OMAP=3Dy
CONFIG_SERIAL_OMAP_CONSOLE=3Dy
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_HVC_DRIVER=3Dy
# CONFIG_HVC_DCC is not set
CONFIG_VIRTIO_CONSOLE=3Dy
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=3Dy
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
# CONFIG_HW_RANDOM_ATMEL is not set
CONFIG_HW_RANDOM_VIRTIO=3Dm
# CONFIG_HW_RANDOM_EXYNOS is not set
# CONFIG_R3964 is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
CONFIG_I2C=3Dy
CONFIG_I2C_BOARDINFO=3Dy
CONFIG_I2C_COMPAT=3Dy
CONFIG_I2C_CHARDEV=3Dy
CONFIG_I2C_MUX=3Dy

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=3Dy
CONFIG_I2C_MUX_PCA9541=3Dy
CONFIG_I2C_MUX_PCA954x=3Dy
CONFIG_I2C_MUX_PINCTRL=3Dm
CONFIG_I2C_HELPER_AUTO=3Dy
CONFIG_I2C_ALGOBIT=3Dy

#
# I2C Hardware Bus support
#

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_OMAP=3Dy
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=3Dy
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=3Dy

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_OMAP24XX=3Dy
# CONFIG_SPI_PXA2XX_PCI is not set
CONFIG_SPI_SC18IS602=3Dm
CONFIG_SPI_XCOMM=3Dm
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_DESIGNWARE is not set

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=3Dy
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_HSI is not set

#
# PPS support
#
CONFIG_PPS=3Dy
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=3Dy
CONFIG_PPS_CLIENT_GPIO=3Dy

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PINCTRL=3Dy

#
# Pin controllers
#
CONFIG_PINMUX=3Dy
CONFIG_PINCONF=3Dy
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_SINGLE=3Dy
# CONFIG_PINCTRL_EXYNOS is not set
# CONFIG_PINCTRL_EXYNOS5440 is not set
CONFIG_ARCH_HAVE_CUSTOM_GPIO_H=3Dy
CONFIG_ARCH_REQUIRE_GPIOLIB=3Dy
CONFIG_GPIOLIB=3Dy
CONFIG_OF_GPIO=3Dy
CONFIG_DEBUG_GPIO=3Dy
CONFIG_GPIO_SYSFS=3Dy
CONFIG_GPIO_OF_HELPER=3Dy

#
# Memory mapped GPIO drivers:
#
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_EM is not set
# CONFIG_GPIO_TS5500 is not set

#
# I2C GPIO expanders:
#
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCF857X=3Dy
# CONFIG_GPIO_SX150X is not set
CONFIG_GPIO_TWL4030=3Dy
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_ADNP is not set

#
# PCI GPIO expanders:
#

#
# SPI GPIO expanders:
#
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MCP23S08 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_74X164 is not set

#
# AC97 GPIO expanders:
#

#
# MODULbus GPIO expanders:
#

#
# USB GPIO expanders:
#
CONFIG_W1=3Dy
CONFIG_W1_CON=3Dy

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_DS2490=3Dm
CONFIG_W1_MASTER_DS2482=3Dm
CONFIG_W1_MASTER_DS1WM=3Dm
CONFIG_W1_MASTER_GPIO=3Dy
CONFIG_HDQ_MASTER_OMAP=3Dm

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=3Dy
CONFIG_W1_SLAVE_SMEM=3Dy
CONFIG_W1_SLAVE_DS2408=3Dm
CONFIG_W1_SLAVE_DS2423=3Dm
CONFIG_W1_SLAVE_DS2431=3Dm
CONFIG_W1_SLAVE_DS2433=3Dm
CONFIG_W1_SLAVE_DS2433_CRC=3Dy
CONFIG_W1_SLAVE_DS2760=3Dm
CONFIG_W1_SLAVE_DS2780=3Dm
CONFIG_W1_SLAVE_DS2781=3Dm
CONFIG_W1_SLAVE_DS28E04=3Dm
CONFIG_W1_SLAVE_BQ27000=3Dm
CONFIG_POWER_SUPPLY=3Dy
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=3Dm
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_BATTERY_BQ27x00 is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_TWL4030 is not set
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_GPIO=3Dm
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_POWER_RESET is not set
# CONFIG_POWER_AVS is not set
CONFIG_HWMON=3Dy
# CONFIG_HWMON_VID is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_AD7314 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADCXX is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7410=3Dm
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_AM335X_BANDGAP=3Dy
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_GPIO_FAN=3Dm
CONFIG_SENSORS_HIH6130=3Dm
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM70 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=3Dm
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=3Dm
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH56XX_COMMON is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_ADS1015=3Dm
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA2XX=3Dy
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=3Dm
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_THERMAL=3Dy
CONFIG_THERMAL_HWMON=3Dy
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=3Dy
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_FAIR_SHARE is not set
CONFIG_STEP_WISE=3Dy
# CONFIG_USER_SPACE is not set
CONFIG_WATCHDOG=3Dy
CONFIG_WATCHDOG_CORE=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
CONFIG_OMAP_WATCHDOG=3Dy
CONFIG_TWL4030_WATCHDOG=3Dy
# CONFIG_MAX63XX_WATCHDOG is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=3Dy

#
# Sonics Silicon Backplane
#
CONFIG_SSB=3Dm
CONFIG_SSB_BLOCKIO=3Dy
CONFIG_SSB_SDIOHOST_POSSIBLE=3Dy
CONFIG_SSB_SDIOHOST=3Dy
# CONFIG_SSB_SILENT is not set
# CONFIG_SSB_DEBUG is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=3Dy

#
# Broadcom specific AMBA
#
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=3Dy
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_ASIC3 is not set
CONFIG_MFD_TI_AM335X_TSCADC=3Dy
# CONFIG_HTC_EGPIO is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65217=3Dy
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=3Dy
# CONFIG_TWL4030_MADC is not set
CONFIG_TWL4030_POWER=3Dy
# CONFIG_MFD_TWL4030_AUDIO is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_STMPE is not set
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_T7L66XB is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_MFD_TC6387XB is not set
# CONFIG_MFD_TC6393XB is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_WL1273_CORE=3Dm
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_AS3711 is not set
CONFIG_REGULATOR=3Dy
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_DUMMY=3Dy
CONFIG_REGULATOR_FIXED_VOLTAGE=3Dy
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_GPIO=3Dy
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8973 is not set
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=3Dy
CONFIG_REGULATOR_TPS6507X=3Dy
CONFIG_REGULATOR_TPS65217=3Dy
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_REGULATOR_TWL4030=3Dy
CONFIG_MEDIA_SUPPORT=3Dy

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=3Dy
CONFIG_MEDIA_ANALOG_TV_SUPPORT=3Dy
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=3Dy
CONFIG_MEDIA_RADIO_SUPPORT=3Dy
CONFIG_MEDIA_RC_SUPPORT=3Dy
CONFIG_MEDIA_CONTROLLER=3Dy
CONFIG_VIDEO_DEV=3Dy
CONFIG_VIDEO_V4L2_SUBDEV_API=3Dy
CONFIG_VIDEO_V4L2=3Dy
CONFIG_VIDEO_ADV_DEBUG=3Dy
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=3Dm
CONFIG_V4L2_MEM2MEM_DEV=3Dm
CONFIG_VIDEOBUF_GEN=3Dy
CONFIG_VIDEOBUF_VMALLOC=3Dm
CONFIG_VIDEOBUF_DVB=3Dm
CONFIG_VIDEOBUF2_CORE=3Dy
CONFIG_VIDEOBUF2_MEMOPS=3Dy
CONFIG_VIDEOBUF2_DMA_CONTIG=3Dy
CONFIG_VIDEOBUF2_VMALLOC=3Dm
CONFIG_DVB_CORE=3Dy
CONFIG_DVB_NET=3Dy
CONFIG_DVB_MAX_ADAPTERS=3D8
CONFIG_DVB_DYNAMIC_MINORS=3Dy

#
# Media drivers
#
CONFIG_RC_CORE=3Dy
CONFIG_RC_MAP=3Dm
CONFIG_RC_DECODERS=3Dy
CONFIG_LIRC=3Dm
CONFIG_IR_LIRC_CODEC=3Dm
CONFIG_IR_NEC_DECODER=3Dm
CONFIG_IR_RC5_DECODER=3Dm
CONFIG_IR_RC6_DECODER=3Dm
CONFIG_IR_JVC_DECODER=3Dm
CONFIG_IR_SONY_DECODER=3Dm
CONFIG_IR_RC5_SZ_DECODER=3Dm
CONFIG_IR_SANYO_DECODER=3Dm
CONFIG_IR_MCE_KBD_DECODER=3Dm
CONFIG_RC_DEVICES=3Dy
CONFIG_RC_ATI_REMOTE=3Dm
CONFIG_IR_IMON=3Dm
CONFIG_IR_MCEUSB=3Dm
CONFIG_IR_REDRAT3=3Dm
CONFIG_IR_STREAMZAP=3Dm
CONFIG_IR_IGUANA=3Dm
CONFIG_IR_TTUSBIR=3Dm
# CONFIG_IR_RX51 is not set
CONFIG_RC_LOOPBACK=3Dm
CONFIG_IR_GPIO_CIR=3Dm
CONFIG_MEDIA_USB_SUPPORT=3Dy

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=3Dm
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=3Dy
CONFIG_USB_GSPCA=3Dm
CONFIG_USB_M5602=3Dm
CONFIG_USB_STV06XX=3Dm
CONFIG_USB_GL860=3Dm
CONFIG_USB_GSPCA_BENQ=3Dm
CONFIG_USB_GSPCA_CONEX=3Dm
CONFIG_USB_GSPCA_CPIA1=3Dm
CONFIG_USB_GSPCA_ETOMS=3Dm
CONFIG_USB_GSPCA_FINEPIX=3Dm
CONFIG_USB_GSPCA_JEILINJ=3Dm
CONFIG_USB_GSPCA_JL2005BCD=3Dm
CONFIG_USB_GSPCA_KINECT=3Dm
CONFIG_USB_GSPCA_KONICA=3Dm
CONFIG_USB_GSPCA_MARS=3Dm
CONFIG_USB_GSPCA_MR97310A=3Dm
CONFIG_USB_GSPCA_NW80X=3Dm
CONFIG_USB_GSPCA_OV519=3Dm
CONFIG_USB_GSPCA_OV534=3Dm
CONFIG_USB_GSPCA_OV534_9=3Dm
CONFIG_USB_GSPCA_PAC207=3Dm
CONFIG_USB_GSPCA_PAC7302=3Dm
CONFIG_USB_GSPCA_PAC7311=3Dm
CONFIG_USB_GSPCA_SE401=3Dm
CONFIG_USB_GSPCA_SN9C2028=3Dm
CONFIG_USB_GSPCA_SN9C20X=3Dm
CONFIG_USB_GSPCA_SONIXB=3Dm
CONFIG_USB_GSPCA_SONIXJ=3Dm
CONFIG_USB_GSPCA_SPCA500=3Dm
CONFIG_USB_GSPCA_SPCA501=3Dm
CONFIG_USB_GSPCA_SPCA505=3Dm
CONFIG_USB_GSPCA_SPCA506=3Dm
CONFIG_USB_GSPCA_SPCA508=3Dm
CONFIG_USB_GSPCA_SPCA561=3Dm
CONFIG_USB_GSPCA_SPCA1528=3Dm
CONFIG_USB_GSPCA_SQ905=3Dm
CONFIG_USB_GSPCA_SQ905C=3Dm
CONFIG_USB_GSPCA_SQ930X=3Dm
CONFIG_USB_GSPCA_STK014=3Dm
CONFIG_USB_GSPCA_STV0680=3Dm
CONFIG_USB_GSPCA_SUNPLUS=3Dm
CONFIG_USB_GSPCA_T613=3Dm
CONFIG_USB_GSPCA_TOPRO=3Dm
CONFIG_USB_GSPCA_TV8532=3Dm
CONFIG_USB_GSPCA_VC032X=3Dm
CONFIG_USB_GSPCA_VICAM=3Dm
CONFIG_USB_GSPCA_XIRLINK_CIT=3Dm
CONFIG_USB_GSPCA_ZC3XX=3Dm
CONFIG_USB_PWC=3Dm
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=3Dy
CONFIG_VIDEO_CPIA2=3Dm
CONFIG_USB_ZR364XX=3Dm
CONFIG_USB_STKWEBCAM=3Dm
CONFIG_USB_S2255=3Dm
CONFIG_USB_SN9C102=3Dm

#
# Analog TV USB devices
#
CONFIG_VIDEO_AU0828=3Dm
CONFIG_VIDEO_PVRUSB2=3Dm
CONFIG_VIDEO_PVRUSB2_SYSFS=3Dy
CONFIG_VIDEO_PVRUSB2_DVB=3Dy
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=3Dm
CONFIG_VIDEO_TLG2300=3Dm
CONFIG_VIDEO_USBVISION=3Dm
CONFIG_VIDEO_STK1160=3Dm
CONFIG_VIDEO_STK1160_AC97=3Dy

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_CX231XX=3Dm
CONFIG_VIDEO_CX231XX_RC=3Dy
CONFIG_VIDEO_CX231XX_ALSA=3Dm
CONFIG_VIDEO_CX231XX_DVB=3Dm
CONFIG_VIDEO_TM6000=3Dm
CONFIG_VIDEO_TM6000_ALSA=3Dm
CONFIG_VIDEO_TM6000_DVB=3Dm

#
# Digital TV USB devices
#
CONFIG_DVB_USB=3Dm
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_A800=3Dm
CONFIG_DVB_USB_DIBUSB_MB=3Dm
CONFIG_DVB_USB_DIBUSB_MB_FAULTY=3Dy
CONFIG_DVB_USB_DIBUSB_MC=3Dm
CONFIG_DVB_USB_DIB0700=3Dm
CONFIG_DVB_USB_UMT_010=3Dm
CONFIG_DVB_USB_CXUSB=3Dm
CONFIG_DVB_USB_M920X=3Dm
CONFIG_DVB_USB_DIGITV=3Dm
CONFIG_DVB_USB_VP7045=3Dm
CONFIG_DVB_USB_VP702X=3Dm
CONFIG_DVB_USB_GP8PSK=3Dm
CONFIG_DVB_USB_NOVA_T_USB2=3Dm
CONFIG_DVB_USB_TTUSB2=3Dm
CONFIG_DVB_USB_DTT200U=3Dm
CONFIG_DVB_USB_OPERA1=3Dm
CONFIG_DVB_USB_AF9005=3Dm
CONFIG_DVB_USB_AF9005_REMOTE=3Dm
CONFIG_DVB_USB_PCTV452E=3Dm
CONFIG_DVB_USB_DW2102=3Dm
CONFIG_DVB_USB_CINERGY_T2=3Dm
CONFIG_DVB_USB_DTV5100=3Dm
CONFIG_DVB_USB_FRIIO=3Dm
CONFIG_DVB_USB_AZ6027=3Dm
CONFIG_DVB_USB_TECHNISAT_USB2=3Dm
CONFIG_DVB_USB_V2=3Dm
CONFIG_DVB_USB_CYPRESS_FIRMWARE=3Dm
CONFIG_DVB_USB_AF9015=3Dm
CONFIG_DVB_USB_AF9035=3Dm
CONFIG_DVB_USB_ANYSEE=3Dm
CONFIG_DVB_USB_AU6610=3Dm
CONFIG_DVB_USB_AZ6007=3Dm
CONFIG_DVB_USB_CE6230=3Dm
CONFIG_DVB_USB_EC168=3Dm
CONFIG_DVB_USB_GL861=3Dm
CONFIG_DVB_USB_IT913X=3Dm
CONFIG_DVB_USB_LME2510=3Dm
CONFIG_DVB_USB_MXL111SF=3Dm
CONFIG_DVB_USB_RTL28XXU=3Dm
# CONFIG_SMS_USB_DRV is not set
CONFIG_DVB_B2C2_FLEXCOP_USB=3Dm
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=3Dm
CONFIG_VIDEO_EM28XX_ALSA=3Dm
CONFIG_VIDEO_EM28XX_DVB=3Dm
CONFIG_VIDEO_EM28XX_RC=3Dm
CONFIG_TTPCI_EEPROM=3Dm
CONFIG_V4L_PLATFORM_DRIVERS=3Dy
# CONFIG_VIDEO_VPFE_CAPTURE is not set
# CONFIG_VIDEO_OMAP2_VOUT is not set
# CONFIG_VIDEO_TIMBERDALE is not set
CONFIG_SOC_CAMERA=3Dy
CONFIG_SOC_CAMERA_PLATFORM=3Dy
# CONFIG_VIDEO_SH_MOBILE_CSI2 is not set
# CONFIG_VIDEO_SH_MOBILE_CEU is not set
CONFIG_VIDEO_QL_CAMIF=3Dy
CONFIG_V4L_MEM2MEM_DRIVERS=3Dy
# CONFIG_VIDEO_MEM2MEM_DEINTERLACE is not set
CONFIG_V4L_TEST_DRIVERS=3Dy
CONFIG_VIDEO_VIVI=3Dm
CONFIG_VIDEO_MEM2MEM_TESTDEV=3Dm

#
# Supported MMC/SDIO adapters
#
# CONFIG_SMS_SDIO_DRV is not set
CONFIG_RADIO_ADAPTERS=3Dy
CONFIG_RADIO_SI470X=3Dy
CONFIG_USB_SI470X=3Dm
CONFIG_I2C_SI470X=3Dm
CONFIG_USB_MR800=3Dm
CONFIG_USB_DSBR=3Dm
# CONFIG_RADIO_SHARK is not set
CONFIG_RADIO_SHARK2=3Dm
CONFIG_I2C_SI4713=3Dm
CONFIG_RADIO_SI4713=3Dm
CONFIG_USB_KEENE=3Dm
CONFIG_RADIO_TEA5764=3Dm
CONFIG_RADIO_SAA7706H=3Dm
CONFIG_RADIO_TEF6862=3Dm
CONFIG_RADIO_WL1273=3Dm

#
# Texas Instruments WL128x FM driver (ST based)
#
CONFIG_RADIO_WL128X=3Dm
CONFIG_DVB_B2C2_FLEXCOP=3Dm
CONFIG_MEDIA_SUBDRV_AUTOSELECT=3Dy

#
# Media ancillary drivers (tuners, sensors, i2c, frontends)
#
CONFIG_VIDEO_TVEEPROM=3Dm
CONFIG_VIDEO_IR_I2C=3Dy

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_MSP3400=3Dm
CONFIG_VIDEO_CS53L32A=3Dm
CONFIG_VIDEO_WM8775=3Dm

#
# RDS decoders
#

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=3Dm
CONFIG_VIDEO_TVP5150=3Dm

#
# Video and audio decoders
#
CONFIG_VIDEO_CX25840=3Dm

#
# MPEG video encoders
#
CONFIG_VIDEO_CX2341X=3Dm

#
# Video encoders
#

#
# Camera sensor devices
#
CONFIG_VIDEO_MT9V011=3Dm

#
# Flash devices
#

#
# Video improvement chips
#

#
# Miscelaneous helper chips
#

#
# Sensors used on soc_camera driver
#

#
# soc_camera sensor drivers
#
# CONFIG_SOC_CAMERA_IMX074 is not set
CONFIG_SOC_CAMERA_MT9M001=3Dy
CONFIG_SOC_CAMERA_MT9M111=3Dy
CONFIG_SOC_CAMERA_MT9M114=3Dy
CONFIG_SOC_CAMERA_MT9T031=3Dy
CONFIG_SOC_CAMERA_MT9T112=3Dy
CONFIG_SOC_CAMERA_MT9V022=3Dy
# CONFIG_SOC_CAMERA_OV2640 is not set
# CONFIG_SOC_CAMERA_OV5642 is not set
# CONFIG_SOC_CAMERA_OV6650 is not set
# CONFIG_SOC_CAMERA_OV772X is not set
# CONFIG_SOC_CAMERA_OV9640 is not set
# CONFIG_SOC_CAMERA_OV9740 is not set
# CONFIG_SOC_CAMERA_RJ54N1 is not set
# CONFIG_SOC_CAMERA_TW9910 is not set
CONFIG_MEDIA_ATTACH=3Dy
CONFIG_MEDIA_TUNER=3Dy
CONFIG_MEDIA_TUNER_SIMPLE=3Dy
CONFIG_MEDIA_TUNER_TDA8290=3Dy
CONFIG_MEDIA_TUNER_TDA827X=3Dy
CONFIG_MEDIA_TUNER_TDA18271=3Dy
CONFIG_MEDIA_TUNER_TDA9887=3Dy
CONFIG_MEDIA_TUNER_TEA5761=3Dy
CONFIG_MEDIA_TUNER_TEA5767=3Dy
CONFIG_MEDIA_TUNER_MT20XX=3Dy
CONFIG_MEDIA_TUNER_MT2060=3Dm
CONFIG_MEDIA_TUNER_MT2063=3Dm
CONFIG_MEDIA_TUNER_MT2266=3Dm
CONFIG_MEDIA_TUNER_QT1010=3Dm
CONFIG_MEDIA_TUNER_XC2028=3Dy
CONFIG_MEDIA_TUNER_XC5000=3Dy
CONFIG_MEDIA_TUNER_XC4000=3Dy
CONFIG_MEDIA_TUNER_MXL5005S=3Dm
CONFIG_MEDIA_TUNER_MXL5007T=3Dm
CONFIG_MEDIA_TUNER_MC44S803=3Dy
CONFIG_MEDIA_TUNER_MAX2165=3Dm
CONFIG_MEDIA_TUNER_TDA18218=3Dm
CONFIG_MEDIA_TUNER_FC0011=3Dm
CONFIG_MEDIA_TUNER_FC0012=3Dm
CONFIG_MEDIA_TUNER_FC0013=3Dm
CONFIG_MEDIA_TUNER_TDA18212=3Dm
CONFIG_MEDIA_TUNER_E4000=3Dm
CONFIG_MEDIA_TUNER_FC2580=3Dm
CONFIG_MEDIA_TUNER_TUA9001=3Dm

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=3Dm
CONFIG_DVB_STB6100=3Dm
CONFIG_DVB_STV090x=3Dm
CONFIG_DVB_STV6110x=3Dm

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=3Dm
CONFIG_DVB_TDA18271C2DD=3Dm

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24123=3Dm
CONFIG_DVB_MT312=3Dm
CONFIG_DVB_ZL10039=3Dm
CONFIG_DVB_S5H1420=3Dm
CONFIG_DVB_STV0288=3Dm
CONFIG_DVB_STB6000=3Dm
CONFIG_DVB_STV0299=3Dm
CONFIG_DVB_STV6110=3Dm
CONFIG_DVB_STV0900=3Dm
CONFIG_DVB_TDA10086=3Dm
CONFIG_DVB_TUNER_ITD1000=3Dm
CONFIG_DVB_TUNER_CX24113=3Dm
CONFIG_DVB_TDA826X=3Dm
CONFIG_DVB_CX24116=3Dm
CONFIG_DVB_SI21XX=3Dm
CONFIG_DVB_DS3000=3Dm
CONFIG_DVB_TDA10071=3Dm

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_CX22702=3Dm
CONFIG_DVB_DRXD=3Dm
CONFIG_DVB_TDA1004X=3Dm
CONFIG_DVB_NXT6000=3Dm
CONFIG_DVB_MT352=3Dm
CONFIG_DVB_ZL10353=3Dm
CONFIG_DVB_DIB3000MB=3Dm
CONFIG_DVB_DIB3000MC=3Dm
CONFIG_DVB_DIB7000M=3Dm
CONFIG_DVB_DIB7000P=3Dm
CONFIG_DVB_TDA10048=3Dm
CONFIG_DVB_AF9013=3Dm
CONFIG_DVB_EC100=3Dm
CONFIG_DVB_CXD2820R=3Dm
CONFIG_DVB_RTL2830=3Dm
CONFIG_DVB_RTL2832=3Dm

#
# DVB-C (cable) frontends
#
CONFIG_DVB_TDA10023=3Dm
CONFIG_DVB_STV0297=3Dm

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=3Dm
CONFIG_DVB_BCM3510=3Dm
CONFIG_DVB_LGDT330X=3Dm
CONFIG_DVB_LGDT3305=3Dm
CONFIG_DVB_LG2160=3Dm
CONFIG_DVB_S5H1409=3Dm
CONFIG_DVB_AU8522=3Dm
CONFIG_DVB_AU8522_DTV=3Dm
CONFIG_DVB_AU8522_V4L=3Dm
CONFIG_DVB_S5H1411=3Dm

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=3Dm
CONFIG_DVB_DIB8000=3Dm
CONFIG_DVB_MB86A20S=3Dm

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=3Dm
CONFIG_DVB_TUNER_DIB0070=3Dm
CONFIG_DVB_TUNER_DIB0090=3Dm

#
# SEC control devices for DVB-S
#
CONFIG_DVB_LNBP21=3Dm
CONFIG_DVB_LNBP22=3Dm
CONFIG_DVB_ISL6421=3Dm
CONFIG_DVB_ISL6423=3Dm
CONFIG_DVB_A8293=3Dm
CONFIG_DVB_LGS8GXX=3Dm
CONFIG_DVB_ATBM8830=3Dm
CONFIG_DVB_IX2505V=3Dm
CONFIG_DVB_IT913X_FE=3Dm
CONFIG_DVB_M88RS2000=3Dm
CONFIG_DVB_AF9033=3Dm

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set

#
# Graphics support
#
CONFIG_DRM=3Dy
CONFIG_DRM_KMS_HELPER=3Dy
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_GEM_CMA_HELPER=3Dy
CONFIG_DRM_KMS_CMA_HELPER=3Dy

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=3Dy
# CONFIG_DRM_UDL is not set
CONFIG_DRM_TILCDC=3Dy
# CONFIG_VGASTATE is not set
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
CONFIG_DISPLAY_TIMING=3Dy
CONFIG_VIDEOMODE=3Dy
CONFIG_OF_DISPLAY_TIMING=3Dy
CONFIG_OF_VIDEOMODE=3Dy
CONFIG_HDMI=3Dy
CONFIG_FB=3Dy
CONFIG_FIRMWARE_EDID=3Dy
# CONFIG_FB_DDC is not set
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
CONFIG_FB_CFB_REV_PIXELS_IN_BYTE=3Dy
CONFIG_FB_SYS_FILLRECT=3Dy
CONFIG_FB_SYS_COPYAREA=3Dy
CONFIG_FB_SYS_IMAGEBLIT=3Dy
CONFIG_FB_FOREIGN_ENDIAN=3Dy
CONFIG_FB_BOTH_ENDIAN=3Dy
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=3Dy
# CONFIG_FB_WMT_GE_ROPS is not set
CONFIG_FB_DEFERRED_IO=3Dy
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=3Dy
CONFIG_FB_TILEBLITTING=3Dy

#
# Frame buffer hardware drivers
#
# CONFIG_FB_UVESA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_TMIO is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
CONFIG_FB_DA8XX=3Dy
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
CONFIG_FB_ST7735=3Dy
CONFIG_OMAP2_VRFB=3Dy
CONFIG_OMAP2_DSS=3Dm
# CONFIG_OMAP2_DSS_DEBUG is not set
# CONFIG_OMAP2_DSS_DEBUGFS is not set
CONFIG_OMAP2_DSS_DPI=3Dy
CONFIG_OMAP2_DSS_RFBI=3Dy
CONFIG_OMAP2_DSS_VENC=3Dy
CONFIG_OMAP4_DSS_HDMI=3Dy
CONFIG_OMAP2_DSS_SDI=3Dy
CONFIG_OMAP2_DSS_DSI=3Dy
CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=3D0
CONFIG_OMAP2_DSS_SLEEP_AFTER_VENC_RESET=3Dy
CONFIG_FB_OMAP2=3Dm
CONFIG_FB_OMAP2_DEBUG_SUPPORT=3Dy
CONFIG_FB_OMAP2_NUM_FBS=3D3

#
# OMAP2/3 Display Device Drivers
#
CONFIG_PANEL_GENERIC_DPI=3Dm
# CONFIG_PANEL_TFP410 is not set
# CONFIG_PANEL_LGPHILIPS_LB035Q02 is not set
CONFIG_PANEL_SHARP_LS037V7DW01=3Dm
CONFIG_PANEL_NEC_NL8048HL11_01B=3Dm
# CONFIG_PANEL_PICODLP is not set
CONFIG_PANEL_TAAL=3Dm
CONFIG_PANEL_TPO_TD043MTEA1=3Dm
CONFIG_PANEL_ACX565AKM=3Dm
# CONFIG_PANEL_N8X0 is not set
# CONFIG_EXYNOS_VIDEO is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
CONFIG_LCD_CLASS_DEVICE=3Dy
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
CONFIG_LCD_ILI9320=3Dy
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=3Dy
# CONFIG_LCD_S6E63M0 is not set
# CONFIG_LCD_LD9040 is not set
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
CONFIG_BACKLIGHT_GENERIC=3Dm
CONFIG_BACKLIGHT_PWM=3Dy
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_LM3630=3Dm
CONFIG_BACKLIGHT_LM3639=3Dm
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_PANDORA is not set
CONFIG_BACKLIGHT_TPS65217=3Dy
# CONFIG_BACKLIGHT_TLC59108 is not set

#
# Console display driver support
#
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
CONFIG_FONTS=3Dy
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
CONFIG_FONT_MINI_4x6=3Dy
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_10x18 is not set
CONFIG_LOGO=3Dy
CONFIG_LOGO_LINUX_MONO=3Dy
CONFIG_LOGO_LINUX_VGA16=3Dy
CONFIG_LOGO_LINUX_CLUT224=3Dy
CONFIG_FB_SSD1307=3Dy
CONFIG_SOUND=3Dy
CONFIG_SOUND_OSS_CORE=3Dy
CONFIG_SOUND_OSS_CORE_PRECLAIM=3Dy
CONFIG_SND=3Dy
CONFIG_SND_TIMER=3Dy
CONFIG_SND_PCM=3Dy
CONFIG_SND_HWDEP=3Dm
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_COMPRESS_OFFLOAD=3Dy
CONFIG_SND_JACK=3Dy
CONFIG_SND_SEQUENCER=3Dm
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dy
CONFIG_SND_PCM_OSS=3Dy
CONFIG_SND_PCM_OSS_PLUGINS=3Dy
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_HRTIMER=3Dy
CONFIG_SND_SEQ_HRTIMER_DEFAULT=3Dy
CONFIG_SND_DYNAMIC_MINORS=3Dy
CONFIG_SND_SUPPORT_OLD_API=3Dy
CONFIG_SND_VERBOSE_PROCFS=3Dy
CONFIG_SND_VERBOSE_PRINTK=3Dy
CONFIG_SND_DEBUG=3Dy
# CONFIG_SND_DEBUG_VERBOSE is not set
# CONFIG_SND_PCM_XRUN_DEBUG is not set
CONFIG_SND_VMASTER=3Dy
CONFIG_SND_RAWMIDI_SEQ=3Dm
# CONFIG_SND_OPL3_LIB_SEQ is not set
# CONFIG_SND_OPL4_LIB_SEQ is not set
# CONFIG_SND_SBAWE_SEQ is not set
# CONFIG_SND_EMU10K1_SEQ is not set
CONFIG_SND_AC97_CODEC=3Dm
CONFIG_SND_DRIVERS=3Dy
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
CONFIG_SND_AC97_POWER_SAVE=3Dy
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=3D0
CONFIG_SND_ARM=3Dy
CONFIG_SND_SPI=3Dy
CONFIG_SND_USB=3Dy
CONFIG_SND_USB_AUDIO=3Dm
CONFIG_SND_USB_UA101=3Dm
CONFIG_SND_USB_CAIAQ=3Dm
# CONFIG_SND_USB_CAIAQ_INPUT is not set
CONFIG_SND_USB_6FIRE=3Dm
CONFIG_SND_SOC=3Dy
CONFIG_SND_AM33XX_SOC=3Dy
# CONFIG_SND_DESIGNWARE_I2S is not set
CONFIG_SND_SOC_I2C_AND_SPI=3Dy
# CONFIG_SND_SOC_ALL_CODECS is not set
CONFIG_SND_SOC_TLV320AIC3X=3Dy
# CONFIG_SND_SIMPLE_CARD is not set
# CONFIG_SOUND_PRIME is not set
CONFIG_AC97_BUS=3Dm

#
# HID support
#
CONFIG_HID=3Dy
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=3Dy
CONFIG_UHID=3Dm
CONFIG_HID_GENERIC=3Dy

#
# Special HID drivers
#
CONFIG_HID_A4TECH=3Dm
CONFIG_HID_ACRUX=3Dm
CONFIG_HID_ACRUX_FF=3Dy
CONFIG_HID_APPLE=3Dm
CONFIG_HID_AUREAL=3Dm
CONFIG_HID_BELKIN=3Dm
CONFIG_HID_CHERRY=3Dm
CONFIG_HID_CHICONY=3Dm
CONFIG_HID_PRODIKEYS=3Dm
CONFIG_HID_CYPRESS=3Dm
CONFIG_HID_DRAGONRISE=3Dm
CONFIG_DRAGONRISE_FF=3Dy
CONFIG_HID_EMS_FF=3Dm
CONFIG_HID_ELECOM=3Dm
CONFIG_HID_EZKEY=3Dm
CONFIG_HID_HOLTEK=3Dm
CONFIG_HOLTEK_FF=3Dy
CONFIG_HID_KEYTOUCH=3Dm
CONFIG_HID_KYE=3Dm
CONFIG_HID_UCLOGIC=3Dm
CONFIG_HID_WALTOP=3Dm
CONFIG_HID_GYRATION=3Dm
CONFIG_HID_ICADE=3Dm
CONFIG_HID_TWINHAN=3Dm
CONFIG_HID_KENSINGTON=3Dm
CONFIG_HID_LCPOWER=3Dm
CONFIG_HID_LENOVO_TPKBD=3Dm
CONFIG_HID_LOGITECH=3Dm
CONFIG_HID_LOGITECH_DJ=3Dm
CONFIG_LOGITECH_FF=3Dy
CONFIG_LOGIRUMBLEPAD2_FF=3Dy
CONFIG_LOGIG940_FF=3Dy
CONFIG_LOGIWHEELS_FF=3Dy
CONFIG_HID_MAGICMOUSE=3Dm
CONFIG_HID_MICROSOFT=3Dm
CONFIG_HID_MONTEREY=3Dm
CONFIG_HID_MULTITOUCH=3Dm
CONFIG_HID_NTRIG=3Dm
CONFIG_HID_ORTEK=3Dm
CONFIG_HID_PANTHERLORD=3Dm
CONFIG_PANTHERLORD_FF=3Dy
CONFIG_HID_PETALYNX=3Dm
CONFIG_HID_PICOLCD=3Dm
CONFIG_HID_PICOLCD_FB=3Dy
CONFIG_HID_PICOLCD_BACKLIGHT=3Dy
CONFIG_HID_PICOLCD_LCD=3Dy
CONFIG_HID_PICOLCD_LEDS=3Dy
CONFIG_HID_PICOLCD_CIR=3Dy
CONFIG_HID_PRIMAX=3Dm
CONFIG_HID_PS3REMOTE=3Dm
CONFIG_HID_ROCCAT=3Dm
CONFIG_HID_SAITEK=3Dm
CONFIG_HID_SAMSUNG=3Dm
CONFIG_HID_SONY=3Dm
CONFIG_HID_SPEEDLINK=3Dm
CONFIG_HID_SUNPLUS=3Dm
CONFIG_HID_GREENASIA=3Dm
CONFIG_GREENASIA_FF=3Dy
CONFIG_HID_SMARTJOYPLUS=3Dm
CONFIG_SMARTJOYPLUS_FF=3Dy
CONFIG_HID_TIVO=3Dm
CONFIG_HID_TOPSEED=3Dm
CONFIG_HID_THRUSTMASTER=3Dm
CONFIG_THRUSTMASTER_FF=3Dy
CONFIG_HID_WACOM=3Dm
CONFIG_HID_WIIMOTE=3Dm
CONFIG_HID_WIIMOTE_EXT=3Dy
CONFIG_HID_ZEROPLUS=3Dm
CONFIG_ZEROPLUS_FF=3Dy
CONFIG_HID_ZYDACRON=3Dm
CONFIG_HID_SENSOR_HUB=3Dm

#
# USB HID support
#
CONFIG_USB_HID=3Dy
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB_ARCH_HAS_EHCI=3Dy
# CONFIG_USB_ARCH_HAS_XHCI is not set
CONFIG_USB_SUPPORT=3Dy
CONFIG_USB_COMMON=3Dy
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB=3Dy
CONFIG_USB_DEBUG=3Dy
CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy

#
# Miscellaneous USB options
#
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=3Dy
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_DWC3 is not set
CONFIG_USB_MON=3Dy
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1760_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_SSB is not set
CONFIG_USB_MUSB_HDRC=3Dy
# CONFIG_USB_MUSB_TUSB6010 is not set
# CONFIG_USB_MUSB_OMAP2PLUS is not set
# CONFIG_USB_MUSB_AM35X is not set
CONFIG_USB_MUSB_DSPS=3Dy
CONFIG_MUSB_PIO_ONLY=3Dy
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_RENESAS_USBHS is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=3Dy
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_WDM=3Dm
CONFIG_USB_TMC=3Dm

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=3Dy
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=3Dm
CONFIG_USB_MICROTEK=3Dm

#
# USB port drivers
#
CONFIG_USB_SERIAL=3Dm
CONFIG_USB_SERIAL_GENERIC=3Dy
CONFIG_USB_SERIAL_AIRCABLE=3Dm
CONFIG_USB_SERIAL_ARK3116=3Dm
CONFIG_USB_SERIAL_BELKIN=3Dm
CONFIG_USB_SERIAL_CH341=3Dm
CONFIG_USB_SERIAL_WHITEHEAT=3Dm
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
CONFIG_USB_SERIAL_CP210X=3Dm
CONFIG_USB_SERIAL_CYPRESS_M8=3Dm
CONFIG_USB_SERIAL_EMPEG=3Dm
CONFIG_USB_SERIAL_FTDI_SIO=3Dm
CONFIG_USB_SERIAL_FUNSOFT=3Dm
CONFIG_USB_SERIAL_VISOR=3Dm
CONFIG_USB_SERIAL_IPAQ=3Dm
CONFIG_USB_SERIAL_IR=3Dm
CONFIG_USB_SERIAL_EDGEPORT=3Dm
CONFIG_USB_SERIAL_EDGEPORT_TI=3Dm
CONFIG_USB_SERIAL_F81232=3Dm
CONFIG_USB_SERIAL_GARMIN=3Dm
CONFIG_USB_SERIAL_IPW=3Dm
CONFIG_USB_SERIAL_IUU=3Dm
CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
CONFIG_USB_SERIAL_KEYSPAN=3Dm
CONFIG_USB_SERIAL_KEYSPAN_MPR=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28X=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA18X=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19W=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA49W=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=3Dy
CONFIG_USB_SERIAL_KLSI=3Dm
CONFIG_USB_SERIAL_KOBIL_SCT=3Dm
CONFIG_USB_SERIAL_MCT_U232=3Dm
CONFIG_USB_SERIAL_METRO=3Dm
CONFIG_USB_SERIAL_MOS7720=3Dm
CONFIG_USB_SERIAL_MOS7840=3Dm
CONFIG_USB_SERIAL_MOTOROLA=3Dm
CONFIG_USB_SERIAL_NAVMAN=3Dm
CONFIG_USB_SERIAL_PL2303=3Dm
CONFIG_USB_SERIAL_OTI6858=3Dm
CONFIG_USB_SERIAL_QCAUX=3Dm
CONFIG_USB_SERIAL_QUALCOMM=3Dm
CONFIG_USB_SERIAL_SPCP8X5=3Dm
CONFIG_USB_SERIAL_HP4X=3Dm
CONFIG_USB_SERIAL_SAFE=3Dm
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
CONFIG_USB_SERIAL_SIEMENS_MPI=3Dm
CONFIG_USB_SERIAL_SIERRAWIRELESS=3Dm
CONFIG_USB_SERIAL_SYMBOL=3Dm
CONFIG_USB_SERIAL_TI=3Dm
CONFIG_USB_SERIAL_CYBERJACK=3Dm
CONFIG_USB_SERIAL_XIRCOM=3Dm
CONFIG_USB_SERIAL_WWAN=3Dm
CONFIG_USB_SERIAL_OPTION=3Dm
CONFIG_USB_SERIAL_OMNINET=3Dm
CONFIG_USB_SERIAL_OPTICON=3Dm
CONFIG_USB_SERIAL_VIVOPAY_SERIAL=3Dm
CONFIG_USB_SERIAL_ZIO=3Dm
CONFIG_USB_SERIAL_ZTE=3Dm
CONFIG_USB_SERIAL_SSU100=3Dm
CONFIG_USB_SERIAL_QT2=3Dm
CONFIG_USB_SERIAL_DEBUG=3Dm

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=3Dm
CONFIG_USB_EMI26=3Dm
CONFIG_USB_ADUTUX=3Dm
CONFIG_USB_SEVSEG=3Dm
CONFIG_USB_RIO500=3Dm
CONFIG_USB_LEGOTOWER=3Dm
CONFIG_USB_LCD=3Dm
CONFIG_USB_LED=3Dm
CONFIG_USB_CYPRESS_CY7C63=3Dm
CONFIG_USB_CYTHERM=3Dm
CONFIG_USB_IDMOUSE=3Dm
CONFIG_USB_FTDI_ELAN=3Dm
# CONFIG_USB_SISUSBVGA is not set
CONFIG_USB_LD=3Dm
CONFIG_USB_TRANCEVIBRATOR=3Dm
CONFIG_USB_IOWARRIOR=3Dm
CONFIG_USB_TEST=3Dm
CONFIG_USB_ISIGHTFW=3Dm
CONFIG_USB_YUREX=3Dm
CONFIG_USB_EZUSB_FX2=3Dm

#
# USB Physical Layer drivers
#
CONFIG_OMAP_USB2=3Dy
CONFIG_OMAP_CONTROL_USB=3Dy
CONFIG_USB_ISP1301=3Dm
# CONFIG_USB_RCAR_PHY is not set
# CONFIG_USB_ATM is not set
CONFIG_USB_GADGET=3Dy
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=3D2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=3D2

#
# USB Peripheral Controller
#
# CONFIG_USB_FUSB300 is not set
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_GADGET_MUSB_HDRC is not set
# CONFIG_USB_M66592 is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_DUMMY_HCD is not set
CONFIG_USB_LIBCOMPOSITE=3Dm
CONFIG_USB_ZERO=3Dm
CONFIG_USB_AUDIO=3Dm
# CONFIG_GADGET_UAC1 is not set
CONFIG_USB_ETH=3Dm
CONFIG_USB_ETH_RNDIS=3Dy
# CONFIG_USB_ETH_EEM is not set
CONFIG_USB_G_NCM=3Dm
CONFIG_USB_GADGETFS=3Dm
CONFIG_USB_FUNCTIONFS=3Dm
CONFIG_USB_FUNCTIONFS_ETH=3Dy
CONFIG_USB_FUNCTIONFS_RNDIS=3Dy
# CONFIG_USB_FUNCTIONFS_GENERIC is not set
CONFIG_USB_MASS_STORAGE=3Dm
CONFIG_USB_G_SERIAL=3Dm
CONFIG_USB_MIDI_GADGET=3Dm
CONFIG_USB_G_PRINTER=3Dm
CONFIG_USB_CDC_COMPOSITE=3Dm
CONFIG_USB_G_NOKIA=3Dm
CONFIG_USB_G_ACM_MS=3Dm
CONFIG_USB_G_MULTI=3Dm
CONFIG_USB_G_MULTI_RNDIS=3Dy
# CONFIG_USB_G_MULTI_CDC is not set
CONFIG_USB_G_HID=3Dm
# CONFIG_USB_G_DBGP is not set
CONFIG_USB_G_WEBCAM=3Dm

#
# OTG and related infrastructure
#
CONFIG_USB_OTG_UTILS=3Dy
CONFIG_USB_GPIO_VBUS=3Dm
# CONFIG_USB_ULPI is not set
CONFIG_TWL6030_USB=3Dy
CONFIG_NOP_USB_XCEIV=3Dy
CONFIG_MMC=3Dy
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_UNSAFE_RESUME=3Dy
# CONFIG_MMC_CLKGATE is not set

#
# MMC/SD/SDIO Card Drivers
#
CONFIG_MMC_BLOCK=3Dy
CONFIG_MMC_BLOCK_MINORS=3D8
CONFIG_MMC_BLOCK_BOUNCE=3Dy
CONFIG_SDIO_UART=3Dy
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_SDHCI is not set
# CONFIG_MMC_SDHCI_PXAV3 is not set
# CONFIG_MMC_SDHCI_PXAV2 is not set
CONFIG_MMC_OMAP=3Dy
CONFIG_MMC_OMAP_HS=3Dy
# CONFIG_MMC_DW is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=3Dy
CONFIG_LEDS_CLASS=3Dy

#
# LED drivers
#
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3642=3Dm
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=3Dy
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA9633 is not set
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_PWM=3Dy
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_RENESAS_TPU is not set
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_LM355x=3Dm
# CONFIG_LEDS_OT200 is not set
CONFIG_LEDS_BLINKM=3Dm
CONFIG_LEDS_TRIGGERS=3Dy

#
# LED Triggers
#
CONFIG_LEDS_TRIGGER_TIMER=3Dy
CONFIG_LEDS_TRIGGER_ONESHOT=3Dy
CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dy
CONFIG_LEDS_TRIGGER_BACKLIGHT=3Dy
CONFIG_LEDS_TRIGGER_CPU=3Dy
CONFIG_LEDS_TRIGGER_GPIO=3Dy
CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dy

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=3Dy
# CONFIG_ACCESSIBILITY is not set
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=3Dy
CONFIG_RTC_CLASS=3Dy
CONFIG_RTC_HCTOSYS=3Dy
CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=3Dy
CONFIG_RTC_INTF_PROC=3Dy
CONFIG_RTC_INTF_DEV=3Dy
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_DS1307=3Dy
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_TWL4030=3Dy
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_DS3234 is not set
# CONFIG_RTC_DRV_PCF2123 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
CONFIG_RTC_DRV_DS2404=3Dm

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_OMAP=3Dy
CONFIG_RTC_DRV_SNVS=3Dm
CONFIG_DMADEVICES=3Dy
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
# CONFIG_DW_DMAC is not set
# CONFIG_TIMB_DMA is not set
CONFIG_TI_EDMA=3Dy
# CONFIG_DMA_OMAP is not set
CONFIG_DMA_ENGINE=3Dy
CONFIG_DMA_VIRTUAL_CHANNELS=3Dy

#
# DMA Clients
#
# CONFIG_NET_DMA is not set
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set
# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=3Dy
CONFIG_UIO_PDRV=3Dy
CONFIG_UIO_PDRV_GENIRQ=3Dy
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_PRUSS=3Dm
CONFIG_VIRTIO=3Dy

#
# Virtio drivers
#
# CONFIG_VIRTIO_BALLOON is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_STAGING=3Dy
CONFIG_USBIP_CORE=3Dm
CONFIG_USBIP_VHCI_HCD=3Dm
CONFIG_USBIP_HOST=3Dm
# CONFIG_USBIP_DEBUG is not set
CONFIG_W35UND=3Dm
CONFIG_PRISM2_USB=3Dm
# CONFIG_ECHO is not set
# CONFIG_ASUS_OLED is not set
CONFIG_RTLLIB=3Dm
CONFIG_RTLLIB_CRYPTO_CCMP=3Dm
CONFIG_RTLLIB_CRYPTO_TKIP=3Dm
CONFIG_RTLLIB_CRYPTO_WEP=3Dm
CONFIG_R8712U=3Dm
CONFIG_RTS5139=3Dm
# CONFIG_RTS5139_DEBUG is not set
# CONFIG_TRANZPORT is not set
# CONFIG_LINE6_USB is not set
# CONFIG_USB_SERIAL_QUATECH2 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#
CONFIG_IIO_ST_HWMON=3Dm
CONFIG_IIO_SW_RING=3Dm

#
# Accelerometers
#
CONFIG_ADIS16201=3Dm
CONFIG_ADIS16203=3Dm
CONFIG_ADIS16204=3Dm
CONFIG_ADIS16209=3Dm
CONFIG_ADIS16220=3Dm
CONFIG_ADIS16240=3Dm
# CONFIG_KXSD9 is not set
CONFIG_LIS3L02DQ=3Dm
CONFIG_LIS3L02DQ_BUF_KFIFO=3Dy
# CONFIG_LIS3L02DQ_BUF_RING_SW is not set
CONFIG_SCA3000=3Dm

#
# Analog to digital converters
#
CONFIG_AD7291=3Dm
CONFIG_AD7606=3Dm
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD7606_IFACE_SPI=3Dm
CONFIG_AD799X=3Dm
CONFIG_AD799X_RING_BUFFER=3Dy
CONFIG_AD7780=3Dm
CONFIG_AD7816=3Dm
CONFIG_AD7192=3Dm
CONFIG_ADT7410=3Dm
CONFIG_AD7280=3Dm

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=3Dm
CONFIG_ADT7316_SPI=3Dm
CONFIG_ADT7316_I2C=3Dm

#
# Capacitance to digital converters
#
CONFIG_AD7150=3Dm
CONFIG_AD7152=3Dm
CONFIG_AD7746=3Dm

#
# Direct Digital Synthesis
#
CONFIG_AD5930=3Dm
CONFIG_AD9832=3Dm
CONFIG_AD9834=3Dm
CONFIG_AD9850=3Dm
CONFIG_AD9852=3Dm
CONFIG_AD9910=3Dm
CONFIG_AD9951=3Dm

#
# Digital gyroscope sensors
#
CONFIG_ADIS16060=3Dm
CONFIG_ADIS16080=3Dm
CONFIG_ADIS16130=3Dm
CONFIG_ADIS16260=3Dm
CONFIG_ADXRS450=3Dm

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=3Dm

#
# Inertial measurement units
#
CONFIG_ADIS16400=3Dm

#
# Light sensors
#
CONFIG_SENSORS_ISL29018=3Dm
CONFIG_SENSORS_ISL29028=3Dm
CONFIG_SENSORS_TSL2563=3Dm
CONFIG_TSL2583=3Dm
CONFIG_TSL2x7x=3Dm

#
# Magnetometer sensors
#
CONFIG_SENSORS_AK8975=3Dm
CONFIG_SENSORS_HMC5843=3Dm

#
# Active energy metering IC
#
CONFIG_ADE7753=3Dm
CONFIG_ADE7754=3Dm
CONFIG_ADE7758=3Dm
CONFIG_ADE7759=3Dm
CONFIG_ADE7854=3Dm
CONFIG_ADE7854_I2C=3Dm
CONFIG_ADE7854_SPI=3Dm

#
# Resolver to digital converters
#
CONFIG_AD2S90=3Dm
CONFIG_AD2S1200=3Dm
# CONFIG_AD2S1210 is not set

#
# Triggers - standalone
#
CONFIG_IIO_PERIODIC_RTC_TRIGGER=3Dm
CONFIG_IIO_GPIO_TRIGGER=3Dy
CONFIG_IIO_SYSFS_TRIGGER=3Dy
# CONFIG_IIO_SIMPLE_DUMMY is not set
CONFIG_ZRAM=3Dm
# CONFIG_ZRAM_DEBUG is not set
CONFIG_ZSMALLOC=3Dy
# CONFIG_TIDSPBRIDGE is not set
# CONFIG_USB_ENESTORAGE is not set
# CONFIG_BCM_WIMAX is not set
# CONFIG_FT1000 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# CONFIG_TOUCHSCREEN_CLEARPAD_TM1217 is not set
# CONFIG_TOUCHSCREEN_SYNAPTICS_I2C_RMI4 is not set
# CONFIG_STAGING_MEDIA is not set
# CONFIG_DRM_OMAP is not set

#
# Android
#
CONFIG_ANDROID=3Dy
CONFIG_ANDROID_BINDER_IPC=3Dy
CONFIG_ASHMEM=3Dy
CONFIG_ANDROID_LOGGER=3Dy
CONFIG_ANDROID_TIMED_OUTPUT=3Dy
CONFIG_ANDROID_TIMED_GPIO=3Dy
# CONFIG_ANDROID_LOW_MEMORY_KILLER is not set
CONFIG_ANDROID_INTF_ALARM_DEV=3Dy
# CONFIG_USB_WPAN_HCD is not set
# CONFIG_WIMAX_GDM72XX is not set
CONFIG_CSR_WIFI=3Dm
CONFIG_OMAP_BANDGAP=3Dm
CONFIG_OMAP4_THERMAL=3Dy
# CONFIG_CED1401 is not set
# CONFIG_DGRP is not set
CONFIG_CLKDEV_LOOKUP=3Dy
CONFIG_HAVE_CLK_PREPARE=3Dy
CONFIG_COMMON_CLK=3Dy

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_DEBUG=3Dy
CONFIG_HWSPINLOCK=3Dm

#
# Hardware Spinlock drivers
#
CONFIG_HWSPINLOCK_OMAP=3Dm
CONFIG_CLKSRC_MMIO=3Dy
CONFIG_IOMMU_SUPPORT=3Dy
CONFIG_OF_IOMMU=3Dy
# CONFIG_OMAP_IOMMU is not set

#
# Remoteproc drivers (EXPERIMENTAL)
#
CONFIG_REMOTEPROC=3Dy
CONFIG_STE_MODEM_RPROC=3Dm
CONFIG_PRU_RPROC=3Dy

#
# Rpmsg drivers (EXPERIMENTAL)
#
CONFIG_RPMSG=3Dy
CONFIG_RPMSG_NUM_BUFS=3D32
CONFIG_RPMSG_BUF_SIZE=3D16
CONFIG_VIRT_DRIVERS=3Dy
# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=3Dy
CONFIG_IIO_BUFFER=3Dy
CONFIG_IIO_BUFFER_CB=3Dy
CONFIG_IIO_KFIFO_BUF=3Dy
CONFIG_IIO_TRIGGERED_BUFFER=3Dy
CONFIG_IIO_TRIGGER=3Dy
CONFIG_IIO_CONSUMERS_PER_TRIGGER=3D2

#
# Accelerometers
#
CONFIG_HID_SENSOR_ACCEL_3D=3Dm
CONFIG_IIO_ST_ACCEL_3AXIS=3Dm
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=3Dm
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=3Dm

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=3Dm
CONFIG_AD7266=3Dm
CONFIG_AD7298=3Dm
CONFIG_AD7791=3Dm
CONFIG_AD7793=3Dm
CONFIG_AD7476=3Dm
# CONFIG_AD7887 is not set
# CONFIG_MAX1363 is not set
# CONFIG_TI_ADC081C is not set
CONFIG_TI_AM335X_ADC=3Dy

#
# Amplifiers
#
CONFIG_AD8366=3Dm

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=3Dm
CONFIG_HID_SENSOR_IIO_TRIGGER=3Dm
# CONFIG_HID_SENSOR_ENUM_BASE_QUIRKS is not set
CONFIG_IIO_ST_SENSORS_I2C=3Dm
CONFIG_IIO_ST_SENSORS_SPI=3Dm
CONFIG_IIO_ST_SENSORS_CORE=3Dm

#
# Digital to analog converters
#
CONFIG_AD5064=3Dm
CONFIG_AD5360=3Dm
CONFIG_AD5380=3Dm
CONFIG_AD5421=3Dm
CONFIG_AD5624R_SPI=3Dm
CONFIG_AD5446=3Dm
CONFIG_AD5449=3Dm
CONFIG_AD5504=3Dm
CONFIG_AD5755=3Dm
CONFIG_AD5764=3Dm
CONFIG_AD5791=3Dm
CONFIG_AD5686=3Dm
CONFIG_MAX517=3Dm
CONFIG_MCP4725=3Dm

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=3Dm

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=3Dm

#
# Digital gyroscope sensors
#
CONFIG_ADIS16136=3Dm
CONFIG_HID_SENSOR_GYRO_3D=3Dm
CONFIG_IIO_ST_GYRO_3AXIS=3Dm
CONFIG_IIO_ST_GYRO_I2C_3AXIS=3Dm
CONFIG_IIO_ST_GYRO_SPI_3AXIS=3Dm

#
# Inertial measurement units
#
CONFIG_ADIS16480=3Dm
CONFIG_IIO_ADIS_LIB=3Dm
CONFIG_IIO_ADIS_LIB_BUFFER=3Dy
CONFIG_INV_MPU6050_IIO=3Dm

#
# Light sensors
#
CONFIG_ADJD_S311=3Dm
CONFIG_VCNL4000=3Dm
CONFIG_HID_SENSOR_ALS=3Dm

#
# Magnetometer sensors
#
CONFIG_HID_SENSOR_MAGNETOMETER_3D=3Dm
CONFIG_IIO_ST_MAGN_3AXIS=3Dm
CONFIG_IIO_ST_MAGN_I2C_3AXIS=3Dm
CONFIG_IIO_ST_MAGN_SPI_3AXIS=3Dm
CONFIG_PWM=3Dy
CONFIG_PWM_SYSFS=3Dy
CONFIG_PWM_PCA9685=3Dm
CONFIG_PWM_TIECAP=3Dy
CONFIG_PWM_TIEHRPWM=3Dy
CONFIG_PWM_TIPWMSS=3Dy
CONFIG_PWM_TWL=3Dy
CONFIG_PWM_TWL_LED=3Dy
CONFIG_EHRPWM_TEST=3Dm
# CONFIG_IPACK_BUS is not set
CONFIG_RSTCTL=3Dy
CONFIG_RSTCTL_GPIO=3Dy
CONFIG_RSTCTL_TEST=3Dy
CONFIG_RSTCTL_TEST_CONSUMER=3Dy

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=3Dy
CONFIG_EXT2_FS=3Dy
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT2_FS_SECURITY=3Dy
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=3Dy
CONFIG_EXT3_DEFAULTS_TO_ORDERED=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS_SECURITY=3Dy
CONFIG_EXT4_FS=3Dy
CONFIG_EXT4_FS_POSIX_ACL=3Dy
CONFIG_EXT4_FS_SECURITY=3Dy
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
CONFIG_JBD2=3Dy
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=3Dy
CONFIG_REISERFS_FS=3Dm
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=3Dy
CONFIG_REISERFS_FS_POSIX_ACL=3Dy
CONFIG_REISERFS_FS_SECURITY=3Dy
CONFIG_JFS_FS=3Dm
CONFIG_JFS_POSIX_ACL=3Dy
CONFIG_JFS_SECURITY=3Dy
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=3Dy
CONFIG_XFS_FS=3Dm
CONFIG_XFS_QUOTA=3Dy
CONFIG_XFS_POSIX_ACL=3Dy
CONFIG_XFS_RT=3Dy
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=3Dm
CONFIG_GFS2_FS_LOCKING_DLM=3Dy
CONFIG_OCFS2_FS=3Dm
CONFIG_OCFS2_FS_O2CB=3Dm
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=3Dm
CONFIG_OCFS2_FS_STATS=3Dy
CONFIG_OCFS2_DEBUG_MASKLOG=3Dy
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=3Dy
CONFIG_BTRFS_FS_POSIX_ACL=3Dy
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
CONFIG_NILFS2_FS=3Dm
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_EXPORTFS=3Dy
CONFIG_FILE_LOCKING=3Dy
CONFIG_FSNOTIFY=3Dy
CONFIG_DNOTIFY=3Dy
CONFIG_INOTIFY_USER=3Dy
CONFIG_FANOTIFY=3Dy
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=3Dy
CONFIG_QUOTA=3Dy
CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
CONFIG_PRINT_QUOTA_WARNING=3Dy
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=3Dm
CONFIG_QFMT_V1=3Dm
CONFIG_QFMT_V2=3Dm
CONFIG_QUOTACTL=3Dy
CONFIG_AUTOFS4_FS=3Dy
CONFIG_FUSE_FS=3Dy
CONFIG_CUSE=3Dm
CONFIG_GENERIC_ACL=3Dy

#
# Caches
#
CONFIG_FSCACHE=3Dm
CONFIG_FSCACHE_STATS=3Dy
CONFIG_FSCACHE_HISTOGRAM=3Dy
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=3Dm
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_UDF_FS=3Dm
CONFIG_UDF_NLS=3Dy

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dy
CONFIG_MSDOS_FS=3Dy
CONFIG_VFAT_FS=3Dy
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
CONFIG_NTFS_FS=3Dm
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=3Dy

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_SYSCTL=3Dy
CONFIG_PROC_PAGE_MONITOR=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_TMPFS_POSIX_ACL=3Dy
CONFIG_TMPFS_XATTR=3Dy
# CONFIG_HUGETLB_PAGE is not set
CONFIG_CONFIGFS_FS=3Dm
CONFIG_MISC_FILESYSTEMS=3Dy
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=3Dm
CONFIG_HFS_FS=3Dm
CONFIG_HFSPLUS_FS=3Dm
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_JFFS2_FS=3Dm
CONFIG_JFFS2_FS_DEBUG=3D0
CONFIG_JFFS2_FS_WRITEBUFFER=3Dy
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_FS_XATTR is not set
CONFIG_JFFS2_COMPRESSION_OPTIONS=3Dy
CONFIG_JFFS2_ZLIB=3Dy
CONFIG_JFFS2_LZO=3Dy
CONFIG_JFFS2_RTIME=3Dy
CONFIG_JFFS2_RUBIN=3Dy
# CONFIG_JFFS2_CMODE_NONE is not set
CONFIG_JFFS2_CMODE_PRIORITY=3Dy
# CONFIG_JFFS2_CMODE_SIZE is not set
# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
# CONFIG_UBIFS_FS is not set
CONFIG_LOGFS=3Dm
CONFIG_CRAMFS=3Dm
CONFIG_SQUASHFS=3Dm
# CONFIG_SQUASHFS_XATTR is not set
CONFIG_SQUASHFS_ZLIB=3Dy
CONFIG_SQUASHFS_LZO=3Dy
CONFIG_SQUASHFS_XZ=3Dy
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3D3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
CONFIG_ROMFS_FS=3Dm
CONFIG_ROMFS_BACKED_BY_BLOCK=3Dy
# CONFIG_ROMFS_BACKED_BY_MTD is not set
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_BLOCK=3Dy
# CONFIG_PSTORE is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_F2FS_FS=3Dy
CONFIG_F2FS_STAT_FS=3Dy
CONFIG_F2FS_FS_XATTR=3Dy
CONFIG_F2FS_FS_POSIX_ACL=3Dy
CONFIG_NETWORK_FILESYSTEMS=3Dy
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V2=3Dy
CONFIG_NFS_V3=3Dy
CONFIG_NFS_V3_ACL=3Dy
CONFIG_NFS_V4=3Dy
CONFIG_NFS_SWAP=3Dy
CONFIG_NFS_V4_1=3Dy
CONFIG_PNFS_FILE_LAYOUT=3Dm
CONFIG_PNFS_BLOCK=3Dm
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN=3D"kernel.org"
CONFIG_ROOT_NFS=3Dy
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V2_ACL=3Dy
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_V3_ACL=3Dy
CONFIG_NFSD_V4=3Dy
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_NFS_ACL_SUPPORT=3Dy
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dy
CONFIG_SUNRPC_GSS=3Dy
CONFIG_SUNRPC_BACKCHANNEL=3Dy
CONFIG_SUNRPC_SWAP=3Dy
# CONFIG_SUNRPC_DEBUG is not set
CONFIG_CEPH_FS=3Dm
CONFIG_CIFS=3Dm
# CONFIG_CIFS_STATS is not set
CONFIG_CIFS_WEAK_PW_HASH=3Dy
CONFIG_CIFS_UPCALL=3Dy
CONFIG_CIFS_XATTR=3Dy
CONFIG_CIFS_POSIX=3Dy
CONFIG_CIFS_ACL=3Dy
CONFIG_CIFS_DEBUG=3Dy
# CONFIG_CIFS_DEBUG2 is not set
CONFIG_CIFS_DFS_UPCALL=3Dy
CONFIG_CIFS_SMB2=3Dy
# CONFIG_CIFS_FSCACHE is not set
CONFIG_NCP_FS=3Dm
CONFIG_NCPFS_PACKET_SIGNING=3Dy
CONFIG_NCPFS_IOCTL_LOCKING=3Dy
CONFIG_NCPFS_STRONG=3Dy
CONFIG_NCPFS_NFS_NS=3Dy
CONFIG_NCPFS_OS2_NS=3Dy
# CONFIG_NCPFS_SMALLDOS is not set
CONFIG_NCPFS_NLS=3Dy
CONFIG_NCPFS_EXTRAS=3Dy
CONFIG_CODA_FS=3Dm
CONFIG_AFS_FS=3Dm
# CONFIG_AFS_DEBUG is not set
# CONFIG_AFS_FSCACHE is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dy
CONFIG_NLS_CODEPAGE_737=3Dm
CONFIG_NLS_CODEPAGE_775=3Dm
CONFIG_NLS_CODEPAGE_850=3Dm
CONFIG_NLS_CODEPAGE_852=3Dm
CONFIG_NLS_CODEPAGE_855=3Dm
CONFIG_NLS_CODEPAGE_857=3Dm
CONFIG_NLS_CODEPAGE_860=3Dm
CONFIG_NLS_CODEPAGE_861=3Dm
CONFIG_NLS_CODEPAGE_862=3Dm
CONFIG_NLS_CODEPAGE_863=3Dm
CONFIG_NLS_CODEPAGE_864=3Dm
CONFIG_NLS_CODEPAGE_865=3Dm
CONFIG_NLS_CODEPAGE_866=3Dm
CONFIG_NLS_CODEPAGE_869=3Dm
CONFIG_NLS_CODEPAGE_936=3Dm
CONFIG_NLS_CODEPAGE_950=3Dm
CONFIG_NLS_CODEPAGE_932=3Dm
CONFIG_NLS_CODEPAGE_949=3Dm
CONFIG_NLS_CODEPAGE_874=3Dm
CONFIG_NLS_ISO8859_8=3Dm
CONFIG_NLS_CODEPAGE_1250=3Dm
CONFIG_NLS_CODEPAGE_1251=3Dm
CONFIG_NLS_ASCII=3Dm
CONFIG_NLS_ISO8859_1=3Dy
CONFIG_NLS_ISO8859_2=3Dm
CONFIG_NLS_ISO8859_3=3Dm
CONFIG_NLS_ISO8859_4=3Dm
CONFIG_NLS_ISO8859_5=3Dm
CONFIG_NLS_ISO8859_6=3Dm
CONFIG_NLS_ISO8859_7=3Dm
CONFIG_NLS_ISO8859_9=3Dm
CONFIG_NLS_ISO8859_13=3Dm
CONFIG_NLS_ISO8859_14=3Dm
CONFIG_NLS_ISO8859_15=3Dm
CONFIG_NLS_KOI8_R=3Dm
CONFIG_NLS_KOI8_U=3Dm
CONFIG_NLS_MAC_ROMAN=3Dm
CONFIG_NLS_MAC_CELTIC=3Dm
CONFIG_NLS_MAC_CENTEURO=3Dm
CONFIG_NLS_MAC_CROATIAN=3Dm
CONFIG_NLS_MAC_CYRILLIC=3Dm
CONFIG_NLS_MAC_GAELIC=3Dm
CONFIG_NLS_MAC_GREEK=3Dm
CONFIG_NLS_MAC_ICELAND=3Dm
CONFIG_NLS_MAC_INUIT=3Dm
CONFIG_NLS_MAC_ROMANIAN=3Dm
CONFIG_NLS_MAC_TURKISH=3Dm
CONFIG_NLS_UTF8=3Dm
CONFIG_DLM=3Dm
# CONFIG_DLM_DEBUG is not set

#
# Kernel hacking
#
CONFIG_PRINTK_TIME=3Dy
CONFIG_DEFAULT_MESSAGE_LOGLEVEL=3D4
CONFIG_ENABLE_WARN_DEPRECATED=3Dy
CONFIG_ENABLE_MUST_CHECK=3Dy
CONFIG_FRAME_WARN=3D1024
CONFIG_MAGIC_SYSRQ=3Dy
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=3Dy
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_IPIPE_DEBUG=3Dy
CONFIG_IPIPE_DEBUG_CONTEXT=3Dy
CONFIG_IPIPE_DEBUG_INTERNAL=3Dy
CONFIG_IPIPE_TRACE=3Dy
CONFIG_IPIPE_TRACE_ENABLE=3Dy
CONFIG_IPIPE_TRACE_MCOUNT=3Dy
CONFIG_IPIPE_TRACE_IRQSOFF=3Dy
CONFIG_IPIPE_TRACE_SHIFT=3D14
CONFIG_IPIPE_TRACE_VMALLOC=3Dy
CONFIG_IPIPE_TRACE_PANIC=3Dy
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_LOCKUP_DETECTOR=3Dy
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=3Dy
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D1
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=3D0
CONFIG_DETECT_HUNG_TASK=3Dy
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D60
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=3Dy
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D1
CONFIG_SCHED_DEBUG=3Dy
CONFIG_SCHEDSTATS=3Dy
CONFIG_TIMER_STATS=3Dy
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
CONFIG_DEBUG_SPINLOCK=3Dy
CONFIG_DEBUG_MUTEXES=3Dy
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_SPARSE_RCU_POINTER is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_STACKTRACE=3Dy
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_BUGVERBOSE=3Dy
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_WRITECOUNT is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set
CONFIG_FRAME_POINTER=3Dy
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# CONFIG_LKDTM is not set
CONFIG_NOTIFIER_ERROR_INJECTION=3Dm
CONFIG_PM_NOTIFIER_ERROR_INJECT=3Dm
# CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_NOP_TRACER=3Dy
CONFIG_HAVE_FUNCTION_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
CONFIG_HAVE_C_RECORDMCOUNT=3Dy
CONFIG_TRACE_CLOCK=3Dy
CONFIG_RING_BUFFER=3Dy
CONFIG_EVENT_TRACING=3Dy
CONFIG_EVENT_POWER_TRACING_DEPRECATED=3Dy
CONFIG_CONTEXT_SWITCH_TRACER=3Dy
CONFIG_RING_BUFFER_ALLOW_SWAP=3Dy
CONFIG_TRACING=3Dy
CONFIG_GENERIC_TRACER=3Dy
CONFIG_TRACING_SUPPORT=3Dy
CONFIG_FTRACE=3Dy
CONFIG_FUNCTION_TRACER=3Dy
CONFIG_FUNCTION_GRAPH_TRACER=3Dy
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_BRANCH_PROFILE_NONE=3Dy
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENT=3Dy
CONFIG_PROBE_EVENTS=3Dy
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=3Dy
# CONFIG_KGDB is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_STRICT_DEVMEM is not set
CONFIG_ARM_UNWIND=3Dy
CONFIG_OLD_MCOUNT=3Dy
# CONFIG_DEBUG_USER is not set
CONFIG_DEBUG_LL=3Dy
CONFIG_DEBUG_LL_UART_NONE=3Dy
# CONFIG_DEBUG_ICEDCC is not set
# CONFIG_DEBUG_SEMIHOSTING is not set
CONFIG_DEBUG_LL_INCLUDE=3D"mach/debug-macro.S"
CONFIG_EARLY_PRINTK=3Dy
# CONFIG_ARM_KPROBES_TEST is not set
# CONFIG_PID_IN_CONTEXTIDR is not set

#
# Security options
#
CONFIG_KEYS=3Dy
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEYS_DEBUG_PROC_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=3Dy
CONFIG_SECURITYFS=3Dy
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=3Dy
CONFIG_DEFAULT_SECURITY=3D""
CONFIG_XOR_BLOCKS=3Dm
CONFIG_ASYNC_CORE=3Dm
CONFIG_ASYNC_MEMCPY=3Dm
CONFIG_ASYNC_XOR=3Dm
CONFIG_ASYNC_PQ=3Dm
CONFIG_ASYNC_RAID6_RECOV=3Dm
CONFIG_CRYPTO=3Dy

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=3Dy
CONFIG_CRYPTO_ALGAPI2=3Dy
CONFIG_CRYPTO_AEAD=3Dm
CONFIG_CRYPTO_AEAD2=3Dy
CONFIG_CRYPTO_BLKCIPHER=3Dm
CONFIG_CRYPTO_BLKCIPHER2=3Dy
CONFIG_CRYPTO_HASH=3Dy
CONFIG_CRYPTO_HASH2=3Dy
CONFIG_CRYPTO_RNG2=3Dy
CONFIG_CRYPTO_PCOMP2=3Dy
CONFIG_CRYPTO_MANAGER=3Dy
CONFIG_CRYPTO_MANAGER2=3Dy
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
# CONFIG_CRYPTO_GF128MUL is not set
# CONFIG_CRYPTO_NULL is not set
CONFIG_CRYPTO_WORKQUEUE=3Dy
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=3Dm
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_SEQIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=3Dm
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=3Dm
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_PCBC=3Dm
# CONFIG_CRYPTO_XTS is not set

#
# Hash modes
#
CONFIG_CRYPTO_HMAC=3Dm
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=3Dy
# CONFIG_CRYPTO_GHASH is not set
CONFIG_CRYPTO_MD4=3Dm
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_MICHAEL_MIC=3Dy
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=3Dy
# CONFIG_CRYPTO_SHA1_ARM is not set
CONFIG_CRYPTO_SHA256=3Dm
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=3Dy
CONFIG_CRYPTO_AES_ARM=3Dy
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=3Dm
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=3Dm
CONFIG_CRYPTO_FCRYPT=3Dm
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=3Dy
# CONFIG_CRYPTO_ZLIB is not set
CONFIG_CRYPTO_LZO=3Dy

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_HW=3Dy
CONFIG_CRYPTO_DEV_OMAP_SHAM=3Dy
CONFIG_CRYPTO_DEV_OMAP_AES=3Dy
CONFIG_ASYMMETRIC_KEY_TYPE=3Dm
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dm
CONFIG_PUBLIC_KEY_ALGO_RSA=3Dm
CONFIG_X509_CERTIFICATE_PARSER=3Dm
CONFIG_BINARY_PRINTF=3Dy

#
# Library routines
#
CONFIG_RAID6_PQ=3Dm
CONFIG_BITREVERSE=3Dy
CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
CONFIG_GENERIC_STRNLEN_USER=3Dy
CONFIG_GENERIC_PCI_IOMAP=3Dy
CONFIG_GENERIC_IO=3Dy
CONFIG_PERCPU_RWSEM=3Dy
CONFIG_CRC_CCITT=3Dy
CONFIG_CRC16=3Dy
CONFIG_CRC_T10DIF=3Dy
CONFIG_CRC_ITU_T=3Dy
CONFIG_CRC32=3Dy
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=3Dy
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC7=3Dy
CONFIG_LIBCRC32C=3Dy
# CONFIG_CRC8 is not set
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dy
CONFIG_LZO_COMPRESS=3Dy
CONFIG_LZO_DECOMPRESS=3Dy
CONFIG_XZ_DEC=3Dy
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=3Dy
CONFIG_XZ_DEC_ARMTHUMB=3Dy
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=3Dy
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=3Dy
CONFIG_DECOMPRESS_BZIP2=3Dy
CONFIG_DECOMPRESS_LZMA=3Dy
CONFIG_DECOMPRESS_XZ=3Dy
CONFIG_DECOMPRESS_LZO=3Dy
CONFIG_GENERIC_ALLOCATOR=3Dy
CONFIG_TEXTSEARCH=3Dy
CONFIG_TEXTSEARCH_KMP=3Dm
CONFIG_TEXTSEARCH_BM=3Dm
CONFIG_TEXTSEARCH_FSM=3Dm
CONFIG_BTREE=3Dy
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT=3Dy
CONFIG_HAS_DMA=3Dy
CONFIG_DQL=3Dy
CONFIG_NLATTR=3Dy
CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=3Dy
CONFIG_AVERAGE=3Dy
CONFIG_CLZ_TAB=3Dy
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
CONFIG_MPILIB=3Dm
CONFIG_OID_REGISTRY=3Dm
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140111/e8b8c4e=
f/attachment.sig>
