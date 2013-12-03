From: Kurijn Buys <kurijn.buys@open.ac.uk>
Date: Tue, 3 Dec 2013 11:38:14 +0000
Message-ID: <40A5BE95-8E78-4CD6-81D2-C97AA7A58FBB@open.ac.uk>
MIME-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] latency spikes under load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hi all,

New to Xenomai, and having passed the last few weeks on attempting to set i=
t up on a Pentium 4 (see lower for hard-, software and config details), the=
re seems to be something wrong, as I experience large latency spikes, espec=
ially under load.
I searched in the archives, I followed the troubleshooting guide (notably t=
he part on high latencies), but with no success...
I ran the I-pipe tracer with latency -f (and
 dohell in another terminal) and I pasted the frozen output at the end of t=
his message.
I googled for some terms to understand this log, but I can't figure out how=
 to interpret it. I hope someone of you has some advice on that and/or sees=
 potential problems in my set-up...

Thanks in advance!
]{urijn

Some tests I performed:
-xenomai/bin/latency (priority 99) -> latency spike from time to time, espe=
cially under load they can be up to 400=B5s, but also without load they can=
 be up to 200=B5s sometimes.
-A similar test (from: http://www.blaess.fr/christophe/livres/solutions-tem=
ps-reel-sous-linux/) with a 3000 =B5s period, allowed to observe statistica=
l output. While running the xenomai/bin/dohell program in parallel, I obtai=
ned a normal distribution, within the range [2913 - 3087]=B5s, except for a=
bout ten (out of 336688) measurements who occurred between 1=B5s and 400=B5=
s! (also tested with /proc/sys/kernel/sched_rt_runtime_us on -1)

The kernel log looks normal to me...:
[    1.973038] I-pipe: Domain Xenomai registered.
[    1.973559] Xenomai: hal/i386 started.
[    1.973949] Xenomai: scheduling class idle registered.
[    1.974135] Xenomai: scheduling class rt registered.
[    1.998987] Xenomai: real-time nucleus v2.6.3 (Lies and Truths) loaded.
[    1.999195] Xenomai: debug mode enabled.
[    2.000391] Xenomai: SMI-enabled chipset found
[    2.000605] Xenomai: SMI workaround enabled
[    2.001015] Xenomai: starting native API services.
[    2.001198] Xenomai: starting POSIX services.
[    2.001753] Xenomai: starting RTDM services.

And the files in /proc/ipipe look how they should...

Hardware: Pentium IV (lspci: 3,2GHz, i686, 32,64bit, 2 cpu's), 2Gb RAM
Software: Ubuntu 10.04, kernel&patch 2.6.38.8, Xenomai 2.6.3
Installation details:
-kernel configuration options (starting from the kernel config that my mach=
ine was already using)
-http://www.xenomai.org/index.php/Configuring_x86_kernels
-http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/inde=
x.html#kconf
-options for Analogy (as I want to use a National Instruments card): http:/=
/www.lara.unb.br/wiki/index.php/Data_Acquisition_Xenomai_Analogy
-to avoid conflicts, I deactivated the Comedi drivers (Device drivers/Stagi=
ng drivers/Exclude Staging drivers from being built/Data acquisition suppor=
t (comedi) -> disabled)
-as recommended by the book "Solutions temps r=E9el sous Linux",
-set "Processor type and features/Preemption Model" to "Preemptible Kernel =
(Low-Latency Desktop)
-enable "Real-time sub-system/Priority Coupling Support"
-I-pipe tracer options (http://www.xenomai.org/index.php/I-pipe:Tracer)
-xenomai configuration options:  --enable-smp --enable-x86-sep --enable-x86=
-tsc --enable-debug
(I chose to enable smp as I found smp enabled in the kernel options that wo=
rked with the original ubuntu install, however, I've tried also to install =
xenomai without this option here)

Notes:
-My processor seems to support both 32 as 64 bit, now I'm using 32 (but may=
be I should have opted for 64?)
-I've set the SMI workaround by adding "xeno_hal.smi=3D-1" on the kernel co=
mmand line (http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESH=
OOTING/index.html#SMI), but maybe it makes a difference when it is set in t=
he kernel config, as proposed here (http://www.xenomai.org/index.php/Config=
uring_x86_kernels), by setting the CONFIG_XENO_HW_SMI_WORKAROUND variable. =
However, I didn't find this variable in my kernel configuration...
-I disabled the legacy USB switch at BIOS configuration level.
-After the dpkg command to install the linux image I had a post installatio=
n script error that seems due to the fact the .deb  still ships a vmlinuz f=
ile, but no bzImage file (http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=
=3D561287), but I successfully followed the instructions proposed on that s=
ite: correcting the concerning .postinst file and running apt-get -f instal=
l.


I-pipe frozen back-tracing service on 2.6.38.8-xenomai-2.6.3-2nd/ipipe-2.11=
-03
------------------------------------------------------------
CPU: 0, Freeze: 1977279815608 cycles, Trace Points: 128 (+10)
Calibrated minimum trace-point overhead: 0.222 us

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- <unused>
 |||+-- Xenomai
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 1=
0 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:    #func                -227    0.502  hid_dump_input+0xf [hid] (hid_proc=
ess_event+0x25 [hid])
:    #func                -226    0.469  hid_resolv_usage+0x9 [hid] (hid_du=
mp_input+0x23 [hid])
:    #func                -226    0.474  kmem_cache_alloc_trace+0xf (hid_re=
solv_usage+0x261 [hid])
:    #func                -225    0.432  ipipe_check_context+0xf (kmem_cach=
e_alloc_trace+0x63)
:|   #begin   0x80000001  -225    0.557  ipipe_check_context+0xa3 (kmem_cac=
he_alloc_trace+0x63)
:|   #end     0x80000001  -224    0.582  ipipe_check_context+0x87 (kmem_cac=
he_alloc_trace+0x63)
:    #func                -224    0.509  __ipipe_restore_root+0x4 (kmem_cac=
he_alloc_trace+0xca)
:    #func                -223    0.444  ipipe_check_context+0xf (__ipipe_r=
estore_root+0x15)
:|   #begin   0x80000001  -223    0.524  ipipe_check_context+0xa3 (__ipipe_=
restore_root+0x15)
:|   #end     0x80000001  -222    0.639  ipipe_check_context+0x87 (__ipipe_=
restore_root+0x15)
:    #func                -221    0.954  memset+0xd (kmem_cache_alloc_trace=
+0xdf)
:    #func                -220    0.912  strnlen+0x3 (string+0x38)
:    #func                -220+   1.359  strlen+0x4 (hid_resolv_usage+0x1b0=
 [hid])
:    #func                -218    0.664  memcpy+0x11 (vsnprintf+0x2da)
:    #func                -218    0.559  strnlen+0x3 (string+0x38)
:    #func                -217    0.639  strlen+0x4 (hid_dump_input+0x2e [h=
id])
:    #func                -216    0.694  memcpy+0x11 (vsnprintf+0x2da)
:    #func                -216    0.522  memcpy+0x11 (vsnprintf+0x2da)
:    #func                -215    0.492  hid_debug_event+0x9 [hid] (hid_dum=
p_input+0x59 [hid])
:    #func                -215    0.514  __wake_up+0xf (hid_debug_event+0xb=
5 [hid])
:    #func                -214    0.549  _raw_spin_lock_irqsave+0xd (__wake=
_up+0x20)
:    #func                -214    0.494  ipipe_check_context+0xf (_raw_spin=
_lock_irqsave+0x3e)
:|   #begin   0x80000001  -213    0.642  ipipe_check_context+0xa3 (_raw_spi=
n_lock_irqsave+0x3e)
:|   #end     0x80000001  -212    0.544  ipipe_check_context+0x87 (_raw_spi=
n_lock_irqsave+0x3e)
:    #func                -212    0.459  ipipe_check_context+0xf (add_preem=
pt_count+0x15)
:|   #begin   0x80000001  -211    0.567  ipipe_check_context+0xa3 (add_pree=
mpt_count+0x15)
:|   #end     0x80000001  -211+   1.039  ipipe_check_context+0x87 (add_pree=
mpt_count+0x15)
:    #func                -210    0.759  __wake_up_common+0x9 (__wake_up+0x=
3c)
:    #func                -209    0.672  __ipipe_spin_unlock_debug+0x3 (__w=
ake_up+0x43)
:    #func                -208    0.404  _raw_spin_unlock_irqrestore+0x3 (_=
_wake_up+0x4c)
:    #func                -208    0.422  __ipipe_restore_root+0x4 (_raw_spi=
n_unlock_irqrestore+0x19)
:    #func                -208    0.432  ipipe_check_context+0xf (__ipipe_r=
estore_root+0x15)
:|   #begin   0x80000001  -207    0.582  ipipe_check_context+0xa3 (__ipipe_=
restore_root+0x15)
:|   #end     0x80000001  -207    0.584  ipipe_check_context+0x87 (__ipipe_=
restore_root+0x15)
:    #func                -206    0.472  ipipe_check_context+0xf (sub_preem=
pt_count+0x15)
:|   #begin   0x80000001  -205    0.592  ipipe_check_context+0xa3 (sub_pree=
mpt_count+0x15)
:|   #end     0x80000001  -205    0.717  ipipe_check_context+0x87 (sub_pree=
mpt_count+0x15)
:    #func                -204    0.542  kfree+0x9 (hid_dump_input+0x60 [hi=
d])
:    #func                -204    0.434  ipipe_check_context+0xf (kfree+0x8=
7)
:|   #begin   0x80000001  -203    0.552  ipipe_check_context+0xa3 (kfree+0x=
87)
:|   #end     0x80000001  -203    0.532  ipipe_check_context+0x87 (kfree+0x=
87)
:    #func                -202    0.469  __ipipe_restore_root+0x4 (kfree+0x=
da)
:    #func                -202    0.419  ipipe_check_context+0xf (__ipipe_r=
estore_root+0x15)
:|   #begin   0x80000001  -201    0.739  ipipe_check_context+0xa3 (__ipipe_=
restore_root+0x15)
:|   #end     0x80000001  -200    0.822  ipipe_check_context+0x87 (__ipipe_=
restore_root+0x15)
:    #func                -200    0.502  __wake_up+0xf (hid_dump_input+0x7c=
 [hid])
:    #func                -199    0.484  _raw_spin_lock_irqsave+0xd (__wake=
_up+0x20)
:    #func                -199    0.462  ipipe_check_context+0xf (_raw_spin=
_lock_irqsave+0x3e)
:|   #begin   0x80000001  -198    0.654  ipipe_check_context+0xa3 (_raw_spi=
n_lock_irqsave+0x3e)
:|   #end     0x80000001  -198    0.527  ipipe_check_context+0x87 (_raw_spi=
n_lock_irqsave+0x3e)
:    #func                -197    0.484  ipipe_check_context+0xf (add_preem=
pt_count+0x15)
:|   #begin   0x80000001  -197    0.679  ipipe_check_context+0xa3 (add_pree=
mpt_count+0x15)
:|   #end     0x80000001  -196    0.604  ipipe_check_context+0x87 (add_pree=
mpt_count+0x15)
:    #func                -195    0.479  __wake_up_common+0x9 (__wake_up+0x=
3c)
:    #func                -195    0.464  __ipipe_spin_unlock_debug+0x3 (__w=
ake_up+0x43)
:    #func                -194    0.437  _raw_spin_unlock_irqrestore+0x3 (_=
_wake_up+0x4c)
:    #func                -194    0.427  __ipipe_restore_root+0x4 (_raw_spi=
n_unlock_irqrestore+0x19)
:    #func                -193    0.514  ipipe_check_context+0xf (__ipipe_r=
estore_root+0x15)
:|   #begin   0x80000001  -193    0.634  ipipe_check_context+0xa3 (__ipipe_=
restore_root+0x15)
:|   #end     0x80000001  -192    0.607  ipipe_check_context+0x87 (__ipipe_=
restore_root+0x15)
:    #func                -192    0.672  ipipe_check_context+0xf (sub_preem=
pt_count+0x15)
:|   #begin   0x80000001  -191+   2.031  ipipe_check_context+0xa3 (sub_pree=
mpt_count+0x15)
:|   #end     0x80000001  -189    0.584  ipipe_check_context+0x87 (sub_pree=
mpt_count+0x15)
:    #func                -188    0.444  hidinput_hid_event+0xf [hid] (hid_=
process_event+0xf2 [hid])
:    #func                -188    0.457  input_event+0xf (hidinput_hid_even=
t+0x152 [hid])
:    #func                -187    0.519  _raw_spin_lock_irqsave+0xd (input_=
event+0x46)
:    #func                -187    0.459  ipipe_check_context+0xf (_raw_spin=
_lock_irqsave+0x3e)
:|   #begin   0x80000001  -187    0.584  ipipe_check_context+0xa3 (_raw_spi=
n_lock_irqsave+0x3e)
:|   #end     0x80000001  -186    0.467  ipipe_check_context+0x87 (_raw_spi=
n_lock_irqsave+0x3e)
:    #func                -185    0.392  ipipe_check_context+0xf (add_preem=
pt_count+0x15)
:|   #begin   0x80000001  -185    0.549  ipipe_check_context+0xa3 (add_pree=
mpt_count+0x15)
:|   #end     0x80000001  -185    0.462  ipipe_check_context+0x87 (add_pree=
mpt_count+0x15)
:    #func                -184    0.447  add_input_randomness+0x4 (input_ev=
ent+0x55)
:    #func                -184    0.414  add_timer_randomness+0x8 (add_inpu=
t_randomness+0x32)
:    #func                -183    0.324  ipipe_check_context+0xf (add_preem=
pt_count+0x15)
:|   #begin   0x80000001  -183    0.437  ipipe_check_context+0xa3 (add_pree=
mpt_count+0x15)
:|   #end     0x80000001  -182    0.454  ipipe_check_context+0x87 (add_pree=
mpt_count+0x15)
:    #func                -182    0.352  mix_pool_bytes_extract+0x9 (add_ti=
mer_randomness+0x8c)
:    #func                -182    0.364  _raw_spin_lock_irqsave+0xd (mix_po=
ol_bytes_extract+0x48)
:    #func                -181    0.329  ipipe_check_context+0xf (_raw_spin=
_lock_irqsave+0x3e)
:|   #begin   0x80000001  -181    0.437  ipipe_check_context+0xa3 (_raw_spi=
n_lock_irqsave+0x3e)
:|   #end     0x80000001  -180    0.407  ipipe_check_context+0x87 (_raw_spi=
n_lock_irqsave+0x3e)
:    #func                -180    0.322  ipipe_check_context+0xf (add_preem=
pt_count+0x15)
:|   #begin   0x80000001  -180    0.439  ipipe_check_context+0xa3 (add_pree=
mpt_count+0x15)
:|   #end     0x80000001  -179! 149.235  ipipe_check_context+0x87 (add_pree=
mpt_count+0x15)
:|   #begin   0xffffff0c   -30    0.707  ipipe_ipi0+0x30 (mix_pool_bytes_ex=
tract+0x105)
:|   #func                 -29    0.739  __ipipe_handle_irq+0x9 (ipipe_ipi0=
+0x37)
:|   #func                 -29    0.547  irq_to_desc+0x3 (__ipipe_handle_ir=
q+0x250)
:|   #func                 -28    0.542  __ipipe_ack_apic+0x3 (__ipipe_hand=
le_irq+0x257)
:|   #func                 -28    0.542  native_apic_mem_write+0x3 (__ipipe=
_ack_apic+0x1b)
:|   #func                 -27    0.597  __ipipe_dispatch_wired+0x11 (__ipi=
pe_handle_irq+0x1ed)
:|   #func                 -26    0.789  __ipipe_dispatch_wired_nocheck+0x9=
 (__ipipe_dispatch_wired+0x48)
:|  #*func                 -26    0.594  xnintr_clock_handler+0x9 (__ipipe_=
dispatch_wired_nocheck+0x91)
:|  #*func                 -25    0.529  xntimer_tick_aperiodic+0x9 (xnintr=
_clock_handler+0xba)
:|  #*func                 -24    0.424  xnthread_periodic_handler+0x3 (xnt=
imer_tick_aperiodic+0xce)
:|  #*func                 -24    0.579  xnpod_resume_thread+0x9 (xnthread_=
periodic_handler+0x25)
:|  #*[ 1226] -<?>-   99   -23    0.499  xnpod_resume_thread+0xe5 (xnthread=
_periodic_handler+0x25)
:|  #*func                 -23    0.807  T.832+0xf (xnpod_resume_thread+0x1=
bf)
:|  #*func                 -22    0.467  xntimer_next_local_shot+0xf (xntim=
er_tick_aperiodic+0x86)
:|  #*event   tick@33      -22    0.454  xntimer_next_local_shot+0x9f (xnti=
mer_tick_aperiodic+0x86)
:|  #*func                 -21    0.517  native_apic_mem_read+0x3 (xntimer_=
next_local_shot+0xe3)
:|  #*func                 -21    0.584  native_apic_mem_write+0x3 (xntimer=
_next_local_shot+0xf6)
:|  #*func                 -20    0.709  __xnpod_schedule+0x9 (xnintr_clock=
_handler+0x245)
:|  #*[ 1625] -<?>-   -1   -19    0.459  __xnpod_schedule+0x132 (xnintr_clo=
ck_handler+0x245)
:|  #*func                 -19+   1.592  xnsched_pick_next+0x11 (__xnpod_sc=
hedule+0x1d2)
:|  #*[ 1226] -<?>-   99   -17    0.832  __xnpod_schedule+0x4e0 (xnpod_sche=
dule+0x3d)
:|  #*func                 -17    0.624  T.832+0xf (__xnpod_schedule+0x175)
:|  #*func                 -16    0.594  T.832+0xf (xnpod_suspend_thread+0x=
160)
:|  #*func                 -15    0.614  xntimer_get_overruns+0xf (xnpod_wa=
it_thread_period+0x14a)
:|  #*func                 -15    0.672  T.832+0xf (xnpod_wait_thread_perio=
d+0x162)
:|  #*func                 -14    0.614  __ipipe_restore_pipeline_head+0xc =
(T.832+0xb8)
:|  +*end     0x80000000   -13    0.787  __ipipe_restore_pipeline_head+0x80=
 (T.832+0xb8)
:|  +*begin   0x80000001   -13    0.762  __ipipe_dispatch_event+0x20b (__ip=
ipe_syscall_root+0x51)
:|  +*end     0x80000001   -12    0.569  __ipipe_dispatch_event+0x297 (__ip=
ipe_syscall_root+0x51)
:|  +*begin   0x80000001   -11+   3.271  __ipipe_syscall_root+0x1b3 (sysent=
er_past_esp+0x55)
:   +*func                  -8    0.494  __ipipe_syscall_root+0xf (sysenter=
_past_esp+0x55)
:   +*func                  -8    0.457  __ipipe_dispatch_event+0x9 (__ipip=
e_syscall_root+0x51)
:|  +*begin   0x80000001    -7    0.682  __ipipe_dispatch_event+0x2cb (__ip=
ipe_syscall_root+0x51)
:|  +*end     0x80000001    -6    0.494  __ipipe_dispatch_event+0x1fa (__ip=
ipe_syscall_root+0x51)
:   +*func                  -6    0.967  hisyscall_event+0xf (__ipipe_dispa=
tch_event+0xc0)
:   +*func                  -5    0.854  xnshadow_sys_trace+0x11 (hisyscall=
_event+0x1db)
:   +*func                  -4    0.557  ipipe_trace_frozen_reset+0x9 (xnsh=
adow_sys_trace+0xd9)
:   +*func                  -4    0.442  __ipipe_global_path_lock+0x9 (ipip=
e_trace_frozen_reset+0x1d)
:   +*func                  -3    0.477  __ipipe_spin_lock_irqsave+0xf (__i=
pipe_global_path_lock+0x22)
:|  +*begin   0x80000001    -3+   2.046  __ipipe_spin_lock_irqsave+0xa3 (__=
ipipe_global_path_lock+0x22)
:|  #*func                  -1    0.564  __ipipe_spin_unlock_irqcomplete+0x=
f (__ipipe_global_path_unlock+0x67)
:|  +*end     0x80000001     0    0.514  __ipipe_spin_unlock_irqcomplete+0x=
6c (__ipipe_global_path_unlock+0x67)
<   +*freeze  0x0002515c     0    0.594  xnshadow_sys_trace+0xe2 (hisyscall=
_event+0x1db)
 |  +*begin   0x80000001     0    0.654  __ipipe_dispatch_event+0x20b (__ip=
ipe_syscall_root+0x51)
 |  +*end     0x80000001     1    0.669  __ipipe_dispatch_event+0x297 (__ip=
ipe_syscall_root+0x51)
 |  +*begin   0x80000001     1    0.884  __ipipe_syscall_root+0x1b3 (sysent=
er_past_esp+0x55)
    +*func                   2    0.509  __ipipe_syscall_root+0xf (sysenter=
_past_esp+0x55)
    +*func                   3    0.412  __ipipe_dispatch_event+0x9 (__ipip=
e_syscall_root+0x51)
 |  +*begin   0x80000001     3    0.609  __ipipe_dispatch_event+0x2cb (__ip=
ipe_syscall_root+0x51)
 |  +*end     0x80000001     4    0.482  __ipipe_dispatch_event+0x1fa (__ip=
ipe_syscall_root+0x51)
    +*func                   4    0.492  hisyscall_event+0xf (__ipipe_dispa=
tch_event+0xc0)
    +*func                   5    0.449  __rt_task_wait_period+0x7 (hisysca=
ll_event+0x1db)
    +*func                   5    0.000  rt_task_wait_period+0x3 (__rt_task=
_wait_period+0x16)


-- The Open University is incorporated by Royal Charter (RC 000391), an exe=
mpt charity in England & Wales and a charity registered in Scotland (SC 038=
302).
