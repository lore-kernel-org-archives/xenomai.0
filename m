From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Tue, 9 Dec 2014 20:49:49 +0000
Message-ID: <3d1763453771465c9d014b3313bc82c6@EX132MBOX1A.de2.local>
References: <471986235a5c47e395ece6b3d18830bd@EX132MBOX1A.de2.local>
 <20141207124041.GS10014@hermes.click-hack.org>
 <76bf78d4e9644f9394558dc10207fb96@EX132MBOX1A.de2.local>,
 <20141207135204.GT10014@hermes.click-hack.org>,
 <08dc5da0a9d94655819f8094c4ac6c7a@EX132MBOX1A.de2.local>,
 <acbe2f0f37f447bea2205fcafd963830@EX132MBOX1A.de2.local>
In-Reply-To: <acbe2f0f37f447bea2205fcafd963830@EX132MBOX1A.de2.local>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=
Now with the fix from above unfortunately I ran into another problem. =0A=
=0A=
After some undetermined situation nuclues freezes. That means all tasks run=
ning in primary domain are freezed. In contrast all processes and tasks of =
secondary domain are still running without any problem at the same time. Th=
e xenomai task states are looking normal:=0A=
=0A=
~ # cat /proc/xenomai/stat=0A=
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME=0A=
  0  0      0          13914      0     00500080   98.8  ROOT=0A=
  0  83     196        196        0     00300380    0.0  DOS4=0A=
  0  82     13         13         0     00300380    0.0  DOS5=0A=
=0A=
I have enabled ipipe traceing to figure out what's happening here (see outp=
ut below, created after tasks have freezed). However I am not sure how to i=
nterpret that. Does anyone has an idea?=0A=
=0A=
~ # echo 1 > /proc/ipipe/trace/frozen =0A=
~ # cat /proc/ipipe/trace/frozen =0A=
I-pipe frozen back-tracing service on 3.10.18-rt14-arvero-rev01-ipipe/ipipe=
 release #1=0A=
------------------------------------------------------------=0A=
CPU: 0, Freeze: 2248334328 cycles, Trace Points: 100 (+10)=0A=
Calibrated minimum trace-point overhead: 1.080 us=0A=
=0A=
 +----- Hard IRQs ('|': locked)=0A=
 |+-- Xenomai=0A=
 ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)=0A=
 |||			  +---------- Delay flag ('+': > 1 us, '!': > 10 us)=0A=
 |||			  |	   +- NMI noise ('N')=0A=
 |||			  |	   |=0A=
	  Type	  User Val.   Time    Delay  Function (Parent)=0A=
:    +func                -181+   1.040  ipipe_root_only+0x10 (rt_spin_lock=
_slowunlock+0x1c)=0A=
:    +func                -180+   1.200  ipipe_root_only+0x10 (rt_spin_lock=
_slowunlock+0x88)=0A=
:    +func                -179+   2.160  filp_close+0x10 (do_dup2+0xdc)=0A=
:    +func                -177+   1.760  locks_remove_posix+0x14 (filp_clos=
e+0x64)=0A=
:    +func                -175+   1.240  fput+0x10 (filp_close+0x6c)=0A=
:|   +begin   0x80000001  -174+   1.520  fput+0xe8 (filp_close+0x6c)=0A=
:|   +end     0x80000001  -172+   1.240  fput+0xfc (filp_close+0x6c)=0A=
:|   +func                -171	  0.880  __ipipe_bugon_irqs_enabled+0x10 (re=
t_fast_syscall+0x14)=0A=
:|   +end     0x90000000  -170+   2.080  ret_fast_syscall+0x2c (<0000b5bc>)=
=0A=
:|   +begin   0x90000000  -168+   2.320  vector_swi+0x3c (<0000b3d8>)=0A=
:    +func                -166+   1.360  __ipipe_syscall_root+0x10 (vector_=
swi+0x74)=0A=
:    +func                -164	  0.920  SyS_close+0x10 (ret_fast_syscall+0x=
0)=0A=
:    +func                -164+   1.080  __close_fd+0x10 (SyS_close+0x30)=
=0A=
:    +func                -162	  0.880  rt_spin_lock+0x10 (__close_fd+0x28)=
=0A=
:    +func                -162	  0.960  ipipe_root_only+0x10 (rt_spin_lock+=
0x1c)=0A=
:    +func                -161	  0.920  rt_spin_lock_slowlock+0x14 (rt_spin=
_lock+0x24)=0A=
:    +func                -160+   1.320  ipipe_root_only+0x10 (rt_spin_lock=
_slowlock+0x40)=0A=
:    +func                -158+   1.520  __try_to_take_rt_mutex+0x14 (rt_sp=
in_lock_slowlock+0x70)=0A=
:    +func                -157+   2.080  ipipe_root_only+0x10 (rt_spin_lock=
_slowlock+0x238)=0A=
:    +func                -155	  0.880  rt_spin_unlock+0x10 (__close_fd+0xb=
c)=0A=
:    +func                -154	  0.880  rt_spin_lock_slowunlock+0x10 (rt_sp=
in_unlock+0x18)=0A=
:    +func                -153	  1.000  ipipe_root_only+0x10 (rt_spin_lock_=
slowunlock+0x1c)=0A=
:    +func                -152+   1.040  ipipe_root_only+0x10 (rt_spin_lock=
_slowunlock+0x88)=0A=
:    +func                -151+   1.120  filp_close+0x10 (__close_fd+0xc8)=
=0A=
:    +func                -150+   1.120  locks_remove_posix+0x14 (filp_clos=
e+0x64)=0A=
:    +func                -149	  0.960  fput+0x10 (filp_close+0x6c)=0A=
:|   +begin   0x80000001  -148	  0.920  fput+0xe8 (filp_close+0x6c)=0A=
:|   +end     0x80000001  -147+   1.800  fput+0xfc (filp_close+0x6c)=0A=
:|   +func                -145	  1.000  __ipipe_bugon_irqs_enabled+0x10 (re=
t_fast_syscall+0x14)=0A=
:|   +end     0x90000000  -144!  18.320  ret_fast_syscall+0x2c (<0000b3dc>)=
=0A=
:|   +begin   0x90000000  -126+   2.360  vector_swi+0x3c (<0012097c>)=0A=
:    +func                -123+   1.800  __ipipe_syscall_root+0x10 (vector_=
swi+0x74)=0A=
:    +func                -122+   1.960  SyS_wait4+0x14 (ret_fast_syscall+0=
x0)=0A=
:    +func                -120+   2.440  do_wait+0x14 (SyS_wait4+0x94)=0A=
:    +func                -117+   1.320  add_wait_queue+0x10 (do_wait+0x6c)=
=0A=
:    +func                -116+   1.200  rt_spin_lock+0x10 (add_wait_queue+=
0x30)=0A=
:    +func                -115+   1.160  ipipe_root_only+0x10 (rt_spin_lock=
+0x1c)=0A=
:    +func                -113	  0.920  rt_spin_lock_slowlock+0x14 (rt_spin=
_lock+0x24)=0A=
:    +func                -113+   1.640  ipipe_root_only+0x10 (rt_spin_lock=
_slowlock+0x40)=0A=
:    +func                -111+   1.320  __try_to_take_rt_mutex+0x14 (rt_sp=
in_lock_slowlock+0x70)=0A=
:    +func                -110+   2.040  ipipe_root_only+0x10 (rt_spin_lock=
_slowlock+0x238)=0A=
:    +func                -108+   1.040  rt_spin_unlock+0x10 (add_wait_queu=
e+0x50)=0A=
:    +func                -107	  0.880  rt_spin_lock_slowunlock+0x10 (rt_sp=
in_unlock+0x18)=0A=
:    +func                -106	  1.000  ipipe_root_only+0x10 (rt_spin_lock_=
slowunlock+0x1c)=0A=
:    +func                -105+   1.920  ipipe_root_only+0x10 (rt_spin_lock=
_slowunlock+0x88)=0A=
:    +func                -103+   1.080  rt_read_lock+0x10 (do_wait+0xb0)=
=0A=
:    +func                -102	  0.880  __rt_spin_lock+0x10 (rt_read_lock+0=
x3c)=0A=
:    +func                -101	  0.960  ipipe_root_only+0x10 (__rt_spin_loc=
k+0x1c)=0A=
:    +func                -100	  0.920  rt_spin_lock_slowlock+0x14 (__rt_sp=
in_lock+0x24)=0A=
:    +func                 -99+   1.160  ipipe_root_only+0x10 (rt_spin_lock=
_slowlock+0x40)=0A=
:    +func                 -98	  1.000  __try_to_take_rt_mutex+0x14 (rt_spi=
n_lock_slowlock+0x70)=0A=
:    +func                 -97+   1.920  ipipe_root_only+0x10 (rt_spin_lock=
_slowlock+0x238)=0A=
:    +func                 -95+   2.440  wait_consider_task+0x14 (do_wait+0=
xec)=0A=
:    +func                 -92+   3.360  task_stopped_code+0x10 (wait_consi=
der_task+0xe4)=0A=
:    +func                 -89+   1.160  rt_read_unlock+0x10 (do_wait+0x194=
)=0A=
:    +func                 -88	  0.880  __rt_spin_unlock+0x10 (rt_read_unlo=
ck+0x2c)=0A=
:    +func                 -87	  0.880  rt_spin_lock_slowunlock+0x10 (__rt_=
spin_unlock+0x18)=0A=
:    +func                 -86	  1.000  ipipe_root_only+0x10 (rt_spin_lock_=
slowunlock+0x1c)=0A=
:    +func                 -85+   1.760  ipipe_root_only+0x10 (rt_spin_lock=
_slowunlock+0x88)=0A=
:    +func                 -83	  0.880  remove_wait_queue+0x10 (do_wait+0x1=
14)=0A=
:    +func                 -82	  0.880  rt_spin_lock+0x10 (remove_wait_queu=
e+0x20)=0A=
:    +func                 -82	  0.960  ipipe_root_only+0x10 (rt_spin_lock+=
0x1c)=0A=
:    +func                 -81	  0.920  rt_spin_lock_slowlock+0x14 (rt_spin=
_lock+0x24)=0A=
:    +func                 -80	  1.000  ipipe_root_only+0x10 (rt_spin_lock_=
slowlock+0x40)=0A=
:    +func                 -79	  1.000  __try_to_take_rt_mutex+0x14 (rt_spi=
n_lock_slowlock+0x70)=0A=
:    +func                 -78+   1.680  ipipe_root_only+0x10 (rt_spin_lock=
_slowlock+0x238)=0A=
:    +func                 -76	  0.880  rt_spin_unlock+0x10 (remove_wait_qu=
eue+0x48)=0A=
:    +func                 -75	  0.880  rt_spin_lock_slowunlock+0x10 (rt_sp=
in_unlock+0x18)=0A=
:    +func                 -74	  1.000  ipipe_root_only+0x10 (rt_spin_lock_=
slowunlock+0x1c)=0A=
:    +func                 -73+   1.560  ipipe_root_only+0x10 (rt_spin_lock=
_slowunlock+0x88)=0A=
:    +func                 -72+   1.480  put_pid+0x10 (SyS_wait4+0xa0)=0A=
:|   +func                 -70	  0.840  __ipipe_bugon_irqs_enabled+0x10 (re=
t_fast_syscall+0x14)=0A=
:|   +end     0x90000000   -69!  18.440  ret_fast_syscall+0x2c (<00120980>)=
=0A=
:|   +begin   0x90000000   -51+   2.240  vector_swi+0x3c (<0000b4f8>)=0A=
:    +func                 -49+   1.560  __ipipe_syscall_root+0x10 (vector_=
swi+0x74)=0A=
:    +func                 -47+   1.200  SyS_write+0x14 (ret_fast_syscall+0=
x0)=0A=
:    +func                 -46+   2.320  fget_light+0x10 (SyS_write+0x28)=
=0A=
:    +func                 -44+   2.640  vfs_write+0x14 (SyS_write+0x50)=0A=
:    +func                 -41+   2.640  rw_verify_area+0x14 (vfs_write+0x8=
c)=0A=
:    +func                 -38+   1.280  __sb_start_write+0x14 (vfs_write+0=
x1c8)=0A=
:    +func                 -37	  1.000  ipipe_root_only+0x10 (__sb_start_wr=
ite+0x48)=0A=
:    +func                 -36+   1.920  ipipe_root_only+0x10 (__sb_start_w=
rite+0x70)=0A=
:    +func                 -34+   2.120  proc_reg_write+0x14 (vfs_write+0xc=
c)=0A=
:|   +begin   0x80000001   -32+   1.360  proc_reg_write+0xb8 (vfs_write+0xc=
c)=0A=
:|   +end     0x80000001   -31+   2.040  proc_reg_write+0xe0 (vfs_write+0xc=
c)=0A=
:    +func                 -29+   7.080  __ipipe_frozen_ctrl+0x14 (proc_reg=
_write+0x94)=0A=
:    +func                 -22	  0.920  _mutex_lock+0x10 (__ipipe_frozen_ct=
rl+0x9c)=0A=
:    +func                 -21+   1.080  rt_mutex_lock+0x10 (_mutex_lock+0x=
18)=0A=
:    +func                 -20+   1.440  ipipe_root_only+0x10 (rt_mutex_loc=
k+0x1c)=0A=
:    +func                 -18+   1.080  rt_mutex_slowlock+0x14 (rt_mutex_l=
ock+0x30)=0A=
:    +func                 -17+   1.800  ipipe_root_only+0x10 (rt_mutex_slo=
wlock+0x38)=0A=
:    +func                 -15+   1.320  __try_to_take_rt_mutex+0x14 (rt_mu=
tex_slowlock+0x74)=0A=
:    +func                 -14+   1.800  ipipe_root_only+0x10 (rt_mutex_slo=
wlock+0x128)=0A=
:    +func                 -12+   1.240  ipipe_trace_frozen_reset+0x10 (__i=
pipe_frozen_ctrl+0xa0)=0A=
:    +func                 -11+   2.160  __ipipe_global_path_lock+0x10 (ipi=
pe_trace_frozen_reset+0x18)=0A=
:    +func                  -9+   1.400  __ipipe_spin_lock_irqsave+0x10 (__=
ipipe_global_path_lock+0x1c)=0A=
:|   +begin   0x80000001    -7+   3.960  __ipipe_spin_lock_irqsave+0x5c (__=
ipipe_global_path_lock+0x1c)=0A=
:|   #func                  -3+   1.680  __ipipe_spin_unlock_irqcomplete+0x=
10 (__ipipe_global_path_unlock+0x6c)=0A=
:|   +end     0x80000001    -2+   2.120  __ipipe_spin_unlock_irqcomplete+0x=
48 (__ipipe_global_path_unlock+0x6c)=0A=
<    +freeze  0xffffffff     0	  1.440  __ipipe_frozen_ctrl+0xb0 (proc_reg_=
write+0x94)=0A=
     +func                   1	  1.200  _mutex_unlock+0x10 (__ipipe_frozen_=
ctrl+0xb8)=0A=
     +func                   2	  0.920  rt_mutex_unlock+0x10 (_mutex_unlock=
+0x18)=0A=
     +func                   3	  1.160  ipipe_root_only+0x10 (rt_mutex_unlo=
ck+0x1c)=0A=
     +func                   4	  1.560  ipipe_root_only+0x10 (rt_mutex_unlo=
ck+0x88)=0A=
     +func                   6	  1.280  unuse_pde+0x10 (proc_reg_write+0xa0=
)=0A=
 |   +begin   0x80000001     7	  1.120  unuse_pde+0x58 (proc_reg_write+0xa0=
)=0A=
 |   +end     0x80000001     8	  2.320  unuse_pde+0x6c (proc_reg_write+0xa0=
)=0A=
     +func                  11	  1.240  __fsnotify_parent+0x14 (vfs_write+0=
x168)=0A=
     +func                  12	  1.520  fsnotify+0x14 (vfs_write+0x184)=0A=
     +func                  13	  0.000  __srcu_read_lock+0x10 (fsnotify+0x1=
d0)=0A=
~ # =0A=
=0A=
Regards,=0A=
Christoph=0A=

