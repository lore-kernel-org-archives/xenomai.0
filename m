Message-ID: <582ADD06.5000901@numalliance.com>
Date: Tue, 15 Nov 2016 11:01:42 +0100
From: =?ISO-8859-1?Q?St=E9phane_ancelot?= <sancelot@numalliance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] ipipe trace understanding
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

In order to solve my realtime pb, I  have a bit  some problems to 
understand my ipipe trace that has been frozen.

My task should normally spend almost 200us to run and in this case, it 
spends more than 500us.

My task starts at -723 and stops at -14.

I made some comments in the trace, but have problem understanding where 
is the biggest problem.

Regards
S.Ancelot

I-pipe frozen back-tracing service on 3.18.20test/ipipe release #3
------------------------------------------------------------
CPU: 2, Freeze: 10618160523400 cycles, Trace Points: 500 (+10)
Calibrated minimum trace-point overhead: 0.110 us

  +----- Hard IRQs ('|': locked)
  |+-- Xenomai
  ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
  |||              +---------- Delay flag ('+': > 1 us, '!': > 10 us)
  |||              |       +- NMI noise ('N')
  |||              |       |
       Type      User Val.   Time    Delay  Function (Parent)
:|   +end     0x80000000  -986      0.226  hard_local_irq_enable+0x17 
(ipipe_unstall_root+0x2d)
:    +func                -986      0.234  flush_work+0x0 
(__cancel_work_timer+0xff)
:    +func                -985      0.216  ipipe_root_only+0x0 
(flush_work+0x1c)
:|   +begin   0x80000001  -985      0.240  hard_local_irq_save+0x18 
(ipipe_root_only+0x13)
:|   +end     0x80000001  -985      0.334  hard_local_irq_restore+0x18 
(ipipe_root_only+0x4c)
:    #func                -985      0.276  get_work_pool+0x0 
(flush_work+0x2e)
:    #func                -984      0.248  ipipe_unstall_root+0x0 
(flush_work+0x40)
:|   #begin   0x80000000  -984      0.200  hard_local_irq_disable+0x18 
(ipipe_unstall_root+0xe)
:|   #func                -984      0.324  ipipe_root_only+0x0 
(ipipe_unstall_root+0x13)
:|   +end     0x80000000  -984      0.400  hard_local_irq_enable+0x17 
(ipipe_unstall_root+0x2d)
:    +func                -983      0.270  round_jiffies_up_relative+0x0 
(__i915_add_request+0x1e4 [i915])
:    +func                -983      0.254  
__round_jiffies_up_relative+0x0 (round_jiffies_up_relative+0x16)
:    +func                -983      0.318  round_jiffies_common+0x0 
(__round_jiffies_up_relative+0x1e)
:    +func                -982      0.509  queue_delayed_work_on+0x0 
(__i915_add_request+0x1ff [i915])
:    #func                -982      0.272  ipipe_restore_root+0x0 
(arch_local_irq_restore+0x14)
:    #func                -982      0.244  ipipe_root_only+0x0 
(ipipe_restore_root+0x13)
:|   #begin   0x80000001  -981      0.733  hard_local_irq_save+0x18 
(ipipe_root_only+0x13)
:|   #end     0x80000001  -981      0.230  hard_local_irq_restore+0x18 
(ipipe_root_only+0x4c)
:    #func                -980      0.238  ipipe_unstall_root+0x0 
(ipipe_restore_root+0x24)
:|   #begin   0x80000000  -980      0.276  hard_local_irq_disable+0x18 
(ipipe_unstall_root+0xe)
:|   #func                -980      0.338  ipipe_root_only+0x0 
(ipipe_unstall_root+0x13)
:|   +end     0x80000000  -980      0.246  hard_local_irq_enable+0x17 
(ipipe_unstall_root+0x2d)
:    +func                -979      0.408  intel_mark_busy+0x0 [i915] 
(__i915_add_request+0x207 [i915])
:    +func                -979      0.463  kfree+0x0 
(i915_gem_ringbuffer_submission+0x50d [i915])
:    +func                -978      0.292  
i915_gem_execbuffer_unreserve_vma+0x0 [i915] 
(i915_gem_do_execbuffer.isra.15+0xa08 [i915])
:    +func                -978      0.312  
i915_gem_execbuffer_unreserve_vma+0x0 [i915] 
(i915_gem_do_execbuffer.isra.15+0xa08 [i915])
:    +func                -978      0.266  
i915_gem_execbuffer_unreserve_vma+0x0 [i915] 
(i915_gem_do_execbuffer.isra.15+0xa08 [i915])
:    +func                -978      0.527  kfree+0x0 
(i915_gem_do_execbuffer.isra.15+0xa1b [i915])
:    +func                -977      0.270  preempt_count_add+0x0 
(kfree+0x87)
:    +func                -977      0.330  preempt_count_sub+0x0 
(kfree+0xa1)
:    +func                -976      0.495  mutex_unlock+0x0 
(i915_gem_do_execbuffer.isra.15+0xa28 [i915])
:    +func                -976      0.372  intel_runtime_pm_put+0x0 
[i915] (i915_gem_do_execbuffer.isra.15+0xa31 [i915])
:    +func                -976      0.398  __pm_runtime_suspend+0x0 
(intel_runtime_pm_put+0x49 [i915])
:    +func                -975      0.427  kfree+0x0 
(drm_free_large+0x25 [i915])
:    +func                -975      0.264  preempt_count_add+0x0 
(kfree+0x87)
:    +func                -974      0.597  preempt_count_sub+0x0 
(kfree+0xa1)
:    +func                -974      0.282  syscall_trace_leave+0x0 
(int_check_syscall_exit_work+0x34)
:    +func                -974      0.298  __audit_syscall_exit+0x0 
(syscall_trace_leave+0x48)
:    +func                -973      0.260  path_put+0x0 
(audit_free_names+0x91)
:    +func                -973      0.236  dput+0x0 (path_put+0x17)
:    +func                -973      0.282  mntput+0x0 (path_put+0x1f)
:    +func                -973      0.292  unroll_tree_refs+0x0 
(__audit_syscall_exit+0x8d)
:    +func                -972!  23.847  kfree+0x0 
(__audit_syscall_exit+0xf0)
:    +func                -948      0.278  
syscall_trace_enter_phase1+0x0 (tracesys+0x14)
:    +func                -948      0.252  do_audit_syscall_entry+0x0 
(syscall_trace_enter_phase1+0x11a)
:    +func                -948      0.256  __audit_syscall_entry+0x0 
(do_audit_syscall_entry+0x63)
:    +func                -948      0.274  current_kernel_time+0x0 
(__audit_syscall_entry+0xaa)
:    +func                -947      0.240  SyS_ioctl+0x0 
(system_call_fastpath+0x12)
:    +func                -947      0.260  __fdget+0x0 (SyS_ioctl+0x24)
:    +func                -947      0.256  __fget_light+0x0 (__fdget+0x13)
:    +func                -947      0.290  security_file_ioctl+0x0 
(SyS_ioctl+0x3e)
:    +func                -946      0.246  cap_file_ioctl+0x0 
(security_file_ioctl+0x16)
:    +func                -946      0.370  do_vfs_ioctl+0x0 (SyS_ioctl+0x53)
:    +func                -946      0.364  drm_ioctl+0x0 [drm] 
(do_vfs_ioctl+0x356)
:    +func                -945      0.270  i915_gem_busy_ioctl+0x0 
[i915] (drm_ioctl+0x39f [drm])
:    +func                -945      0.246  
i915_mutex_lock_interruptible+0x0 [i915] (i915_gem_busy_ioctl+0x1e [i915])
:    +func                -945      0.250  i915_gem_wait_for_error+0x0 
[i915] (i915_mutex_lock_interruptible+0x1e [i915])
:    +func                -945      0.238  mutex_lock_interruptible+0x0 
(i915_mutex_lock_interruptible+0x2b [i915])
:    +func                -944      0.557  ipipe_root_only+0x0 
(mutex_lock_interruptible+0x13)
:|   +begin   0x80000001  -944      0.246  hard_local_irq_save+0x18 
(ipipe_root_only+0x13)
:|   +end     0x80000001  -943      0.244  hard_local_irq_restore+0x18 
(ipipe_root_only+0x4c)
:    +func                -943      0.288  drm_gem_object_lookup+0x0 
[drm] (i915_gem_busy_ioctl+0x37 [i915])
:    +func                -943      0.236  _raw_spin_lock+0x0 
(drm_gem_object_lookup+0x21 [drm])
:    +func                -943      0.607  preempt_count_add+0x0 
(_raw_spin_lock+0x18)
:    +func                -942      0.256  _raw_spin_unlock+0x0 
(drm_gem_object_lookup+0x52 [drm])
:    +func                -942      0.320  preempt_count_sub+0x0 
(_raw_spin_unlock+0x16)
:    +func                -942      0.601  
i915_gem_object_flush_active+0x0 [i915] (i915_gem_busy_ioctl+0x47 [i915])
:    +func                -941      0.495  mutex_unlock+0x0 
(i915_gem_busy_ioctl+0x85 [i915])
:    +func                -940      0.276  syscall_trace_leave+0x0 
(int_check_syscall_exit_work+0x34)
:    +func                -940      0.242  __audit_syscall_exit+0x0 
(syscall_trace_leave+0x48)
:    +func                -940      0.232  path_put+0x0 
(audit_free_names+0x91)
:    +func                -940      0.278  dput+0x0 (path_put+0x17)
:    +func                -939      0.274  mntput+0x0 (path_put+0x1f)
:    +func                -939      0.280  unroll_tree_refs+0x0 
(__audit_syscall_exit+0x8d)
:    +func                -939+   1.619  kfree+0x0 
(__audit_syscall_exit+0xf0)
:    +func                -937      0.485  
syscall_trace_enter_phase1+0x0 (tracesys+0x14)
:    +func                -937      0.266  do_audit_syscall_entry+0x0 
(syscall_trace_enter_phase1+0x11a)
:    +func                -936      0.661  __audit_syscall_entry+0x0 
(do_audit_syscall_entry+0x63)
:    +func                -936+   1.156  current_kernel_time+0x0 
(__audit_syscall_entry+0xaa)
:    +func                -935      0.228  SyS_ioctl+0x0 
(system_call_fastpath+0x12)
:    +func                -934      0.352  __fdget+0x0 (SyS_ioctl+0x24)
:    +func                -934      0.356  __fget_light+0x0 (__fdget+0x13)
:    +func                -934      0.449  security_file_ioctl+0x0 
(SyS_ioctl+0x3e)
:    +func                -933      0.324  cap_file_ioctl+0x0 
(security_file_ioctl+0x16)
:    +func                -933      0.238  do_vfs_ioctl+0x0 (SyS_ioctl+0x53)
:    +func                -933      0.831  drm_ioctl+0x0 [drm] 
(do_vfs_ioctl+0x356)
:    +func                -932      0.533  i915_gem_madvise_ioctl+0x0 
[i915] (drm_ioctl+0x39f [drm])
:    +func                -931      0.254  
i915_mutex_lock_interruptible+0x0 [i915] (i915_gem_madvise_ioctl+0x28 
[i915])
:    +func                -931      0.793  i915_gem_wait_for_error+0x0 
[i915] (i915_mutex_lock_interruptible+0x1e [i915])
:    +func                -930      0.260  mutex_lock_interruptible+0x0 
(i915_mutex_lock_interruptible+0x2b [i915])
:    +func                -930      0.445  ipipe_root_only+0x0 
(mutex_lock_interruptible+0x13)
:|   +begin   0x80000001  -930+   1.062  hard_local_irq_save+0x18 
(ipipe_root_only+0x13)
:|   +end     0x80000001  -928      0.276  hard_local_irq_restore+0x18 
(ipipe_root_only+0x4c)
:    +func                -928      0.244  drm_gem_object_lookup+0x0 
[drm] (i915_gem_madvise_ioctl+0x43 [i915])
:    +func                -928      0.230  _raw_spin_lock+0x0 
(drm_gem_object_lookup+0x21 [drm])
:    +func                -928      0.310  preempt_count_add+0x0 
(_raw_spin_lock+0x18)
:    +func                -927      0.423  _raw_spin_unlock+0x0 
(drm_gem_object_lookup+0x52 [drm])
:    +func                -927      0.773  preempt_count_sub+0x0 
(_raw_spin_unlock+0x16)
:    +func                -926      0.467  mutex_unlock+0x0 
(i915_gem_madvise_ioctl+0xce [i915])
:    +func                -926      0.222  syscall_trace_leave+0x0 
(int_check_syscall_exit_work+0x34)
:    +func                -926      0.236  __audit_syscall_exit+0x0 
(syscall_trace_leave+0x48)
:    +func                -925      0.214  path_put+0x0 
(audit_free_names+0x91)
:    +func                -925      0.469  dput+0x0 (path_put+0x17)
:    +func                -925      0.226  mntput+0x0 (path_put+0x1f)
:    +func                -924      0.236  unroll_tree_refs+0x0 
(__audit_syscall_exit+0x8d)
:    +func                -924!  92.999  kfree+0x0 
(__audit_syscall_exit+0xf0)
:    +func                -831      0.713  
syscall_trace_enter_phase1+0x0 (tracesys+0x14)
:    +func                -830      0.513  do_audit_syscall_entry+0x0 
(syscall_trace_enter_phase1+0x11a)
:    +func                -830      0.336  __audit_syscall_entry+0x0 
(do_audit_syscall_entry+0x63)
:    +func                -830      0.657  current_kernel_time+0x0 
(__audit_syscall_entry+0xaa)
:    +func                -829+   1.271  SyS_ioctl+0x0 
(system_call_fastpath+0x12)
:    +func                -828      0.290  __fdget+0x0 (SyS_ioctl+0x24)
:    +func                -827      0.856  __fget_light+0x0 (__fdget+0x13)
:    +func                -827      0.226  security_file_ioctl+0x0 
(SyS_ioctl+0x3e)
:    +func                -826      0.699  cap_file_ioctl+0x0 
(security_file_ioctl+0x16)
:    +func                -826+   1.435  do_vfs_ioctl+0x0 (SyS_ioctl+0x53)
:    +func                -824      0.577  drm_ioctl+0x0 [drm] 
(do_vfs_ioctl+0x356)
:    +func                -824+   1.080  i915_gem_pwrite_ioctl+0x0 
[i915] (drm_ioctl+0x39f [drm])
:    +func                -823      0.683  
i915_mutex_lock_interruptible+0x0 [i915] (i915_gem_pwrite_ioctl+0x6f [i915])
:    +func                -822      0.258  i915_gem_wait_for_error+0x0 
[i915] (i915_mutex_lock_interruptible+0x1e [i915])
:    +func                -822      0.529  mutex_lock_interruptible+0x0 
(i915_mutex_lock_interruptible+0x2b [i915])
:    +func                -821      0.320  ipipe_root_only+0x0 
(mutex_lock_interruptible+0x13)
:|   +begin   0x80000001  -821+   1.222  hard_local_irq_save+0x18 
(ipipe_root_only+0x13)
:|   +end     0x80000001  -819      0.691  hard_local_irq_restore+0x18 
(ipipe_root_only+0x4c)
:    +func                -819      0.286  drm_gem_object_lookup+0x0 
[drm] (i915_gem_pwrite_ioctl+0xda [i915])
:    +func                -819+   1.068  _raw_spin_lock+0x0 
(drm_gem_object_lookup+0x21 [drm])
:    +func                -817      0.793  preempt_count_add+0x0 
(_raw_spin_lock+0x18)
:    +func                -817      0.374  _raw_spin_unlock+0x0 
(drm_gem_object_lookup+0x52 [drm])
:    +func                -816+   1.134  preempt_count_sub+0x0 
(_raw_spin_unlock+0x16)
:    +func                -815      0.330  cpu_write_needs_clflush+0x0 
[i915] (i915_gem_pwrite_ioctl+0x1ce [i915])
:    +func                -815      0.771  cpu_cache_is_coherent+0x0 
[i915] (cpu_write_needs_clflush+0x26 [i915])
:    +func                -814      0.435  cpu_write_needs_clflush+0x0 
[i915] (i915_gem_pwrite_ioctl+0x33e [i915])
:    +func                -814      0.214  cpu_cache_is_coherent+0x0 
[i915] (cpu_write_needs_clflush+0x26 [i915])
:    +func                -813      0.495  
i915_gem_object_wait_rendering+0x0 [i915] (i915_gem_pwrite_ioctl+0x34b 
[i915])
:    +func                -813      0.623  i915_gem_object_retire+0x0 
[i915] (i915_gem_pwrite_ioctl+0x365 [i915])
:    +func                -812+   1.984  i915_gem_object_get_pages+0x0 
[i915] (i915_gem_pwrite_ioctl+0x3ad [i915])
:    +func                -810+   1.050  preempt_count_add+0x0 
(i915_gem_pwrite_ioctl+0x4de [i915])
:    +func                -809      0.547  preempt_count_sub+0x0 
(pagefault_enable+0xe [i915])
:    +func                -809      0.719  mutex_unlock+0x0 
(i915_gem_pwrite_ioctl+0x702 [i915])
:    +func                -808      0.483  syscall_trace_leave+0x0 
(int_check_syscall_exit_work+0x34)
:    +func                -807      0.286  __audit_syscall_exit+0x0 
(syscall_trace_leave+0x48)
:    +func                -807      0.581  path_put+0x0 
(audit_free_names+0x91)
:    +func                -807      0.643  dput+0x0 (path_put+0x17)
:    +func                -806      0.238  mntput+0x0 (path_put+0x1f)
:    +func                -806      0.461  unroll_tree_refs+0x0 
(__audit_syscall_exit+0x8d)
:    +func                -805+   1.012  kfree+0x0 
(__audit_syscall_exit+0xf0)
:    +func                -804      0.419  
syscall_trace_enter_phase1+0x0 (tracesys+0x14)
:    +func                -804      0.505  do_audit_syscall_entry+0x0 
(syscall_trace_enter_phase1+0x11a)
:    +func                -803      0.234  __audit_syscall_entry+0x0 
(do_audit_syscall_entry+0x63)
:    +func                -803      0.767  current_kernel_time+0x0 
(__audit_syscall_entry+0xaa)
:    +func                -802      0.741  SyS_ioctl+0x0 
(system_call_fastpath+0x12)
:    +func                -802      0.214  __fdget+0x0 (SyS_ioctl+0x24)
:    +func                -801      0.529  __fget_light+0x0 (__fdget+0x13)
:    +func                -801      0.238  security_file_ioctl+0x0 
(SyS_ioctl+0x3e)
:    +func                -801+   1.323  cap_file_ioctl+0x0 
(security_file_ioctl+0x16)
:    +func                -799      0.493  do_vfs_ioctl+0x0 (SyS_ioctl+0x53)
:    +func                -799      0.346  drm_ioctl+0x0 [drm] 
(do_vfs_ioctl+0x356)
:    +func                -798      0.906  i915_gem_pwrite_ioctl+0x0 
[i915] (drm_ioctl+0x39f [drm])
:    +func                -798      0.364  
i915_mutex_lock_interruptible+0x0 [i915] (i915_gem_pwrite_ioctl+0x6f [i915])
:    +func                -797      0.268  i915_gem_wait_for_error+0x0 
[i915] (i915_mutex_lock_interruptible+0x1e [i915])
:    +func                -797+   1.483  mutex_lock_interruptible+0x0 
(i915_mutex_lock_interruptible+0x2b [i915])
:    +func                -795      0.210  ipipe_root_only+0x0 
(mutex_lock_interruptible+0x13)
:|   +begin   0x80000001  -795+   1.084  hard_local_irq_save+0x18 
(ipipe_root_only+0x13)
:|   +end     0x80000001  -794      0.513  hard_local_irq_restore+0x18 
(ipipe_root_only+0x4c)
:    +func                -794      0.264  drm_gem_object_lookup+0x0 
[drm] (i915_gem_pwrite_ioctl+0xda [i915])
:    +func                -793      0.378  _raw_spin_lock+0x0 
(drm_gem_object_lookup+0x21 [drm])
:    +func                -793      0.952  preempt_count_add+0x0 
(_raw_spin_lock+0x18)
:    +func                -792      0.230  _raw_spin_unlock+0x0 
(drm_gem_object_lookup+0x52 [drm])
:    +func                -792+   1.138  preempt_count_sub+0x0 
(_raw_spin_unlock+0x16)
:    +func                -791      0.214  cpu_write_needs_clflush+0x0 
[i915] (i915_gem_pwrite_ioctl+0x1ce [i915])
:    +func                -790      0.551  cpu_cache_is_coherent+0x0 
[i915] (cpu_write_needs_clflush+0x26 [i915])
:    +func                -790      0.394  cpu_write_needs_clflush+0x0 
[i915] (i915_gem_pwrite_ioctl+0x33e [i915])
:    +func                -789      0.234  cpu_cache_is_coherent+0x0 
[i915] (cpu_write_needs_clflush+0x26 [i915])
:    +func                -789+   1.096  
i915_gem_object_wait_rendering+0x0 [i915] (i915_gem_pwrite_ioctl+0x34b 
[i915])
:    +func                -788      0.230  i915_gem_object_retire+0x0 
[i915] (i915_gem_pwrite_ioctl+0x365 [i915])
:    +func                -788+   1.098  i915_gem_object_get_pages+0x0 
[i915] (i915_gem_pwrite_ioctl+0x3ad [i915])
:    +func                -787+   1.740  preempt_count_add+0x0 
(i915_gem_pwrite_ioctl+0x4de [i915])
:    +func                -785      0.306  preempt_count_sub+0x0 
(pagefault_enable+0xe [i915])
:    +func                -785      0.449  mutex_unlock+0x0 
(i915_gem_pwrite_ioctl+0x702 [i915])
:    +func                -784      0.904  syscall_trace_leave+0x0 
(int_check_syscall_exit_work+0x34)
:|   +begin   0x000000ef  -783+   3.881  apic_timer_interrupt+0x6d 
(__ipipe_trace+0x384)
:|  # [ 1331] TASK_DC 97  -780+   1.447  xnthread_resume+0x8c 
(timeout_handler+0x21)
:|  # event   tick@398    -778+   1.908  xnclock_core_local_shot+0xa0 
(xnclock_tick+0x1d2)
:|  # [  545] X       -1  -776+   2.750  ___xnsched_run+0x6c 
(xnsched_run+0x3e)
:|  # func                -773      0.677  __switch_to_xtra+0x0 
(__switch_to+0x252)
:|  # func                -773      0.208  xnthread_switch_fpu+0x0 
(___xnsched_run+0x1ec)
:|  # func                -773      0.866  xnarch_switch_fpu+0x0 
(xnthread_switch_fpu+0x2d)
:|  # [ 1331] TASK_DC 97  -772+   1.251  ___xnsched_run+0x20c 
(__xnsched_run+0x21)
:|  # func                -770      0.254  __ipipe_restore_head+0x0 
(__xnlock_put_irqrestore.constprop.16+0x67)
:|  + end     0x80000000  -770!  10.657  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:   + func                -760      0.719  ipipe_fastcall_hook+0x0 
(system_call_after_swapgs+0x6b)
:   + func                -759      0.511  handle_head_syscall+0x0 
(ipipe_fastcall_hook+0x18)
:   + func                -758      0.781  CoBaLt_kill+0x0 
(handle_head_syscall+0x151)
:|  + begin   0x80000000  -758      0.388  hard_local_irq_disable+0x16 
(__xnlock_get_irqsave.constprop.13+0x9)
:|  # func                -757      0.960  cobalt_thread_find+0x0 
(CoBaLt_kill+0x2b)
:|  # func                -756      0.248  __cobalt_kill+0x0 
(CoBaLt_kill+0x40)
:|  # func                -756      0.491  xnthread_resume+0x0 
(__cobalt_kill+0xa5)
:|  # [ 1332] Automat 97  -755      0.332  xnthread_resume+0x8c 
(__cobalt_kill+0xa5)
:|  # func                -755      0.276  ___xnsched_run+0x0 
(xnsched_run+0x3e)
:|  # [ 1331] TASK_DC 97  -755      0.198  ___xnsched_run+0x6c 
(xnsched_run+0x3e)
:|  # func                -755+   1.148  xnsched_pick_next+0x0 
(___xnsched_run+0xaa)
:|  # func                -753      0.206  __ipipe_restore_head+0x0 
(__xnlock_put_irqrestore.constprop.12+0x67)
:|  + end     0x80000000  -753+   4.194  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:   + func                -749      0.274  ipipe_fastcall_hook+0x0 
(system_call_after_swapgs+0x6b)
:   + func                -749+   1.549  handle_head_syscall+0x0 
(ipipe_fastcall_hook+0x18)
:   + func                -747      0.789  CoBaLt_clock_nanosleep+0x0 
(handle_head_syscall+0x151)
:   + func                -746+   1.343  __cobalt_clock_nanosleep+0x0 
(CoBaLt_clock_nanosleep+0x58)
:|  + begin   0x80000000  -745      0.380  hard_local_irq_disable+0x16 
(__xnlock_get_irqsave.constprop.17+0x9)
:|  # func                -745+   1.840  xnthread_suspend+0x0 
(__cobalt_clock_nanosleep+0xd1)
:|  # func                -743      0.402  xntimer_start+0x0 
(xnthread_suspend+0x10b)
:|  # func                -742+   2.195  xnclock_core_ns_to_ticks+0x0 
(xntimer_start+0xd8)
:|  # func                -740+   2.024  xntimer_heading_p+0x0 
(xntimer_start+0x1cd)
:|  # func                -738      0.324  xnclock_core_local_shot+0x0 
(xntimer_start+0x1f6)
:|  # event   tick@55     -738      0.661  xnclock_core_local_shot+0xa0 
(xntimer_start+0x1f6)
:|  # func                -737+   1.409  ipipe_timer_set+0x0 
(xnclock_core_local_shot+0xa8)
:|  # func                -736      0.384  lapic_next_deadline+0x0 
(ipipe_timer_set+0x94)
:|  # func                -735      0.593  ___xnsched_run+0x0 
(__xnsched_run+0x21)
:|  # [ 1331] TASK_DC 97  -735      0.184  ___xnsched_run+0x6c 
(__xnsched_run+0x21)
:|  # func                -735      0.930  xnsched_pick_next+0x0 
(___xnsched_run+0xaa)
:|  # func                -734+   5.008  xnarch_switch_to+0x0 
(___xnsched_run+0x1ce)
:|  # func                -729+   2.099  __switch_to_xtra+0x0 
(__switch_to+0x252)
:|  # func                -727      0.210  xnthread_switch_fpu+0x0 
(___xnsched_run+0x1ec)
:|  # func                -726+   3.478  xnarch_switch_fpu+0x0 
(xnthread_switch_fpu+0x2d)
:|  # [ 1332] Automat 97  -723      0.681  ___xnsched_run+0x20c 
(__xnsched_run+0x21)
:|  # func                -722      0.206  __ipipe_restore_head+0x0 
(__xnlock_put_irqrestore.constprop.12+0x67)
:|  + end     0x80000000  -722+   5.040  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:   + func                -717+   1.702  ipipe_fastcall_hook+0x0 
(system_call_after_swapgs+0x6b)
:   + func                -715+   1.810  handle_head_syscall+0x0 
(ipipe_fastcall_hook+0x18)
:   + func                -714      0.475  CoBaLt_trace+0x0 
(handle_head_syscall+0x151)

Here my Automat task has been waken up .
Then it sends an ethernet frame,
wait for reception of an ethernet frame.
do some treatments and stops

:   + (0x41)    0x000003e8  -713!  17.951  CoBaLt_trace+0x98 
(handle_head_syscall+0x151)
:   + func                -695      0.262  ipipe_fastcall_hook+0x0 
(system_call_after_swapgs+0x6b)
:   + func                -695      0.278  handle_head_syscall+0x0 
(ipipe_fastcall_hook+0x18)
:   + func                -695      0.543  CoBaLt_sendmsg+0x0 
(handle_head_syscall+0x151)
:   + func                -694      0.334  rtdm_fd_sendmsg+0x0 
(CoBaLt_sendmsg+0x39)
:   + func                -694      0.958  rtdm_fd_get+0x0 
(rtdm_fd_sendmsg+0x26)
:|  + begin   0x80000000  -693+   1.369  hard_local_irq_disable+0x16 
(__xnlock_get_irqsave.constprop.11+0x9)
:|  # func                -691      0.202  __ipipe_restore_head+0x0 
(__xnlock_put_irqrestore.constprop.10+0x67)
:|  + end     0x80000000  -691+   1.044  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:|  + begin   0x80000001  -690      0.198  ipipe_get_current_domain+0x23 
(rtdm_fd_sendmsg+0x94)
:|  + end     0x80000001  -690      0.803  ipipe_get_current_domain+0x77 
(rtdm_fd_sendmsg+0x94)
:   + func                -689      0.547  rt_packet_sendmsg+0x0 
[rtpacket] (rtdm_fd_sendmsg+0xb1)
:   + func                -689      0.613  rtdev_get_by_index+0x0 
[rtnet] (rt_packet_sendmsg+0xbc [rtpacket])
:|  + begin   0x80000000  -688      0.565  hard_local_irq_disable+0x16 
[rtnet] (__rtdm_lock_get_irqsave.constprop.3+0xb [rtnet])
:|  # func                -687      0.433  xnsched_lock+0x0 
(__rtdm_lock_get_irqsave.constprop.3+0x41 [rtnet])
:|  # func                -687+   2.291  rtdev_reference+0x0 [rtnet] 
(rtdev_get_by_index+0x34 [rtnet])
:|  # func                -685      0.256  xnsched_unlock+0x0 
(rtdm_lock_put_irqrestore.constprop.2+0x15 [rtnet])
:|  # func                -684      0.202  __ipipe_restore_head+0x0 
(rtdm_lock_put_irqrestore.constprop.2+0x59 [rtnet])
:|  + end     0x80000000  -684+   1.583  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:   + func                -683      0.254  alloc_rtskb+0x0 [rtnet] 
(rt_packet_sendmsg+0xdc [rtpacket])
:   + func                -682      0.362  rtskb_pool_dequeue+0x0 
[rtnet] (alloc_rtskb+0x15 [rtnet])
:|  + begin   0x80000000  -682      0.370  hard_local_irq_disable+0x16 
[rtnet] (__rtdm_lock_get_irqsave+0xf [rtnet])
:|  # func                -682      0.202  xnsched_lock+0x0 
(__rtdm_lock_get_irqsave+0x3e [rtnet])
:|  # func                -681      0.254  __rtskb_pool_dequeue+0x0 
[rtnet] (rtskb_pool_dequeue+0x2c [rtnet])
:|  # func                -681      0.785  rtskb_nop_pool_trylock+0x0 
[rtnet] (__rtskb_pool_dequeue+0x18 [rtnet])
:|  # func                -680      0.236  xnsched_unlock+0x0 
(rtdm_lock_put_irqrestore+0x11 [rtnet])
:|  # func                -680      0.214  __ipipe_restore_head+0x0 
(rtdm_lock_put_irqrestore+0x55 [rtnet])
:|  + end     0x80000000  -680      0.842  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:   + func                -679+   1.052  rt_eth_header+0x0 [rtnet] 
(rt_packet_sendmsg+0x174 [rtpacket])
:   + func                -678+   1.784  rt_memcpy_fromkerneliovec+0x0 
[rtnet] (rt_packet_sendmsg+0x1b7 [rtpacket])
:   + func                -676      0.364  rtdev_xmit+0x0 [rtnet] 
(rt_packet_sendmsg+0x1c7 [rtpacket])
:   + func                -676      0.228  rtskb_acquire+0x0 [rtnet] 
(rtdev_xmit+0x35 [rtnet])
:|  + begin   0x80000000  -676      0.328  hard_local_irq_disable+0x16 
[rtnet] (__rtdm_lock_get_irqsave+0xf [rtnet])
:|  # func                -675      0.196  xnsched_lock+0x0 
(__rtdm_lock_get_irqsave+0x3e [rtnet])
:|  # func                -675      0.232  __rtskb_pool_dequeue+0x0 
[rtnet] (rtskb_acquire+0x33 [rtnet])
:|  # func                -675      0.497  rtdev_pool_trylock+0x0 
[rtnet] (__rtskb_pool_dequeue+0x18 [rtnet])
:|  # func                -674      0.543  rtdev_reference+0x0 [rtnet] 
(rtdev_pool_trylock+0xe [rtnet])
:|  # func                -674      0.208  xnsched_unlock+0x0 
(rtskb_acquire+0x58 [rtnet])
:|  # func                -674      0.459  xnsched_lock+0x0 
(rtskb_acquire+0x8e [rtnet])
:|  # func                -673      0.761  __rtskb_pool_queue_tail+0x0 
[rtnet] (rtskb_acquire+0x99 [rtnet])
:|  # func                -672      0.234  rtskb_nop_pool_unlock+0x0 
[rtnet] (__rtskb_pool_queue_tail+0x35 [rtnet])
:|  # func                -672      0.220  xnsched_unlock+0x0 
(rtdm_lock_put_irqrestore+0x11 [rtnet])
:|  # func                -672      0.192  __ipipe_restore_head+0x0 
(rtdm_lock_put_irqrestore+0x55 [rtnet])
:|  + end     0x80000000  -672      0.603  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:   + func                -671      0.262  rtdev_locked_xmit+0x0 [rtnet] 
(rtdev_xmit+0x56 [rtnet])
:   + func                -671      0.360  rtdm_mutex_lock+0x0 
(rtdev_locked_xmit+0x27 [rtnet])
:   + func                -671      0.412  rtdm_mutex_timedlock+0x0 
(rtdm_mutex_lock+0x12)
:|  + begin   0x80000000  -670+   1.040  hard_local_irq_disable+0x16 
(__xnlock_get_irqsave.constprop.17+0x9)
:|  # func                -669+   1.246  xnsynch_try_acquire+0x0 
(rtdm_mutex_timedlock+0x58)
:|  # func                -668      0.198  __ipipe_restore_head+0x0 
(ipipe_restore_head+0x4d)
:|  + end     0x80000000  -668      0.487  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:   + func                -667+   1.473  igb_xmit_frame+0x0 [rt_igb] 
(rtdev_locked_xmit+0x33 [rtnet])
:   + func                -666+   4.450  igb_xmit_frame_ring+0x0 
[rt_igb] (igb_xmit_frame+0x40 [rt_igb])
:   + func                -661      0.942  rtdm_mutex_unlock+0x0 
(rtdev_locked_xmit+0x3e [rtnet])
:   + func                -660+   2.149  xnsynch_release+0x0 
(rtdm_mutex_unlock+0x3c)
:   + func                -658      0.284  rtdm_fd_put+0x0 
(rtdm_fd_sendmsg+0xbc)
:|  + begin   0x80000000  -658      0.505  hard_local_irq_disable+0x16 
(__xnlock_get_irqsave.constprop.11+0x9)
:|  # func                -657      0.439  __put_fd+0x0 (rtdm_fd_put+0x22)
:|  # func                -657      0.224  __ipipe_restore_head+0x0 
(__xnlock_put_irqrestore.constprop.10+0x67)
:|  + end     0x80000000  -657+   5.088  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:   + func                -652      0.266  ipipe_fastcall_hook+0x0 
(system_call_after_swapgs+0x6b)
:   + func                -651      0.531  handle_head_syscall+0x0 
(ipipe_fastcall_hook+0x18)
:   + func                -651+   2.538  CoBaLt_clock_nanosleep+0x0 
(handle_head_syscall+0x151)
:   + func                -648      0.212  __cobalt_clock_nanosleep+0x0 
(CoBaLt_clock_nanosleep+0x58)
:|  + begin   0x80000000  -648      0.483  hard_local_irq_disable+0x16 
(__xnlock_get_irqsave.constprop.17+0x9)
:|  # func                -648      0.555  xnthread_suspend+0x0 
(__cobalt_clock_nanosleep+0xd1)
:|  # func                -647      0.262  xntimer_start+0x0 
(xnthread_suspend+0x10b)
:|  # func                -647+   1.936  xnclock_core_ns_to_ticks+0x0 
(xntimer_start+0xd8)
:|  # func                -645      0.226  xntimer_heading_p+0x0 
(xntimer_start+0x1cd)
:|  # func                -645      0.643  xnclock_core_local_shot+0x0 
(xntimer_start+0x1f6)
:|  # event   tick@-589   -644      0.290  xnclock_core_local_shot+0xa0 
(xntimer_start+0x1f6)
:|  # func                -644      0.268  ipipe_timer_set+0x0 
(xnclock_core_local_shot+0xa8)
:|  # func                -643+   1.012  lapic_next_deadline+0x0 
(ipipe_timer_set+0x94)
:|  # func                -642+   1.122  ___xnsched_run+0x0 
(__xnsched_run+0x21)
:|  # [ 1332] Automat 97  -641      0.208  ___xnsched_run+0x6c 
(__xnsched_run+0x21)
:|  # func                -641      0.304  xnsched_pick_next+0x0 
(___xnsched_run+0xaa)
:|  # func                -641+   1.579  xnarch_switch_to+0x0 
(___xnsched_run+0x1ce)
:|  # [  545] X       -1  -639+   2.337  ___xnsched_run+0x20c 
(xnsched_run+0x3e)
:|   +end     0x000000ef  -637      0.902  apic_timer_interrupt+0x8f 
(__ipipe_trace+0x384)
:    +func                -636      0.274  __audit_syscall_exit+0x0 
(syscall_trace_leave+0x48)
:    +func                -636      0.408  path_put+0x0 
(audit_free_names+0x91)
:    +func                -635      0.495  dput+0x0 (path_put+0x17)
:    +func                -635      0.352  mntput+0x0 (path_put+0x1f)
:    +func                -634      0.493  unroll_tree_refs+0x0 
(__audit_syscall_exit+0x8d)
:    +func                -634+   7.080  kfree+0x0 
(__audit_syscall_exit+0xf0)
:    +func                -627      0.663  
syscall_trace_enter_phase1+0x0 (tracesys+0x14)
:    +func                -626      0.759  do_audit_syscall_entry+0x0 
(syscall_trace_enter_phase1+0x11a)
:    +func                -625+   1.188  __audit_syscall_entry+0x0 
(do_audit_syscall_entry+0x63)
:    +func                -624+   1.016  current_kernel_time+0x0 
(__audit_syscall_entry+0xaa)
:    +func                -623      0.747  SyS_ioctl+0x0 
(system_call_fastpath+0x12)
:    +func                -622      0.314  __fdget+0x0 (SyS_ioctl+0x24)
:    +func                -622      0.962  __fget_light+0x0 (__fdget+0x13)
:    +func                -621+   1.176  security_file_ioctl+0x0 
(SyS_ioctl+0x3e)
:    +func                -620      0.799  cap_file_ioctl+0x0 
(security_file_ioctl+0x16)
:    +func                -619      0.990  do_vfs_ioctl+0x0 (SyS_ioctl+0x53)
:    +func                -618      0.737  drm_ioctl+0x0 [drm] 
(do_vfs_ioctl+0x356)
:    +func                -617      0.412  i915_gem_busy_ioctl+0x0 
[i915] (drm_ioctl+0x39f [drm])
:    +func                -617+   1.587  
i915_mutex_lock_interruptible+0x0 [i915] (i915_gem_busy_ioctl+0x1e [i915])
:    +func                -615      0.332  i915_gem_wait_for_error+0x0 
[i915] (i915_mutex_lock_interruptible+0x1e [i915])
:    +func                -615      0.749  mutex_lock_interruptible+0x0 
(i915_mutex_lock_interruptible+0x2b [i915])
:    +func                -614      0.238  ipipe_root_only+0x0 
(mutex_lock_interruptible+0x13)
:|   +begin   0x80000001  -614+   1.401  hard_local_irq_save+0x18 
(ipipe_root_only+0x13)
:|   +end     0x80000001  -613+   1.339  hard_local_irq_restore+0x18 
(ipipe_root_only+0x4c)
:    +func                -611      0.290  drm_gem_object_lookup+0x0 
[drm] (i915_gem_busy_ioctl+0x37 [i915])
:    +func                -611      0.214  _raw_spin_lock+0x0 
(drm_gem_object_lookup+0x21 [drm])
:    +func                -611+   2.451  preempt_count_add+0x0 
(_raw_spin_lock+0x18)
:    +func                -608      0.308  _raw_spin_unlock+0x0 
(drm_gem_object_lookup+0x52 [drm])
:    +func                -608+   1.419  preempt_count_sub+0x0 
(_raw_spin_unlock+0x16)
:    +func                -607      0.904  
i915_gem_object_flush_active+0x0 [i915] (i915_gem_busy_ioctl+0x47 [i915])
:    +func                -606      0.541  mutex_unlock+0x0 
(i915_gem_busy_ioctl+0x85 [i915])
:    +func                -605      0.268  syscall_trace_leave+0x0 
(int_check_syscall_exit_work+0x34)
:    +func                -605      0.292  __audit_syscall_exit+0x0 
(syscall_trace_leave+0x48)
:    +func                -605      0.258  path_put+0x0 
(audit_free_names+0x91)
:    +func                -604      0.256  dput+0x0 (path_put+0x17)
:    +func                -604      0.282  mntput+0x0 (path_put+0x1f)
:    +func                -604      0.246  unroll_tree_refs+0x0 
(__audit_syscall_exit+0x8d)
:    +func                -604+   1.529  kfree+0x0 
(__audit_syscall_exit+0xf0)
:    +func                -602      0.457  
syscall_trace_enter_phase1+0x0 (tracesys+0x14)
:    +func                -602      0.408  do_audit_syscall_entry+0x0 
(syscall_trace_enter_phase1+0x11a)
:    +func                -601      0.232  __audit_syscall_entry+0x0 
(do_audit_syscall_entry+0x63)
:    +func                -601+   1.052  current_kernel_time+0x0 
(__audit_syscall_entry+0xaa)
:    +func                -600+   1.922  SyS_ioctl+0x0 
(system_call_fastpath+0x12)
:    +func                -598      0.226  __fdget+0x0 (SyS_ioctl+0x24)
:    +func                -598      0.962  __fget_light+0x0 (__fdget+0x13)
:    +func                -597      0.226  security_file_ioctl+0x0 
(SyS_ioctl+0x3e)
:    +func                -597      0.848  cap_file_ioctl+0x0 
(security_file_ioctl+0x16)
:    +func                -596      0.406  do_vfs_ioctl+0x0 (SyS_ioctl+0x53)
:    +func                -595+   1.162  drm_ioctl+0x0 [drm] 
(do_vfs_ioctl+0x356)
:    +func                -594      0.441  i915_gem_madvise_ioctl+0x0 
[i915] (drm_ioctl+0x39f [drm])
:    +func                -594      0.408  
i915_mutex_lock_interruptible+0x0 [i915] (i915_gem_madvise_ioctl+0x28 
[i915])
:    +func                -593      0.256  i915_gem_wait_for_error+0x0 
[i915] (i915_mutex_lock_interruptible+0x1e [i915])
:    +func                -593      0.663  mutex_lock_interruptible+0x0 
(i915_mutex_lock_interruptible+0x2b [i915])
:    +func                -592      0.228  ipipe_root_only+0x0 
(mutex_lock_interruptible+0x13)
:|   +begin   0x80000001  -592      0.328  hard_local_irq_save+0x18 
(ipipe_root_only+0x13)
:|   +end     0x80000001  -592+   2.257  hard_local_irq_restore+0x18 
(ipipe_root_only+0x4c)
:    +func                -590      0.252  drm_gem_object_lookup+0x0 
[drm] (i915_gem_madvise_ioctl+0x43 [i915])
:    +func                -589      0.565  _raw_spin_lock+0x0 
(drm_gem_object_lookup+0x21 [drm])
:    +func                -589+   1.100  preempt_count_add+0x0 
(_raw_spin_lock+0x18)
:    +func                -588      0.282  _raw_spin_unlock+0x0 
(drm_gem_object_lookup+0x52 [drm])
:    +func                -587      0.673  preempt_count_sub+0x0 
(_raw_spin_unlock+0x16)
:|   +begin   0x000000ef  -587+   2.193  apic_timer_interrupt+0x6d 
(__ipipe_trace+0x384)
:|  # [ 1332] Automat 97  -585+   3.674  xnthread_resume+0x8c 
(timeout_handler+0x21)
:|  # event   tick@55     -581      0.769  xnclock_core_local_shot+0xa0 
(xnclock_tick+0x1d2)
:|  # [  545] X       -1  -580      0.910  ___xnsched_run+0x6c 
(xnsched_run+0x3e)
:|  # func                -579      0.771  __switch_to_xtra+0x0 
(__switch_to+0x252)
:|  # func                -578      0.204  xnthread_switch_fpu+0x0 
(___xnsched_run+0x1ec)
:|  # func                -578      0.246  xnarch_switch_fpu+0x0 
(xnthread_switch_fpu+0x2d)
:|  # [ 1332] Automat 97  -578+   2.678  ___xnsched_run+0x20c 
(__xnsched_run+0x21)
:|  # func                -575      0.232  __ipipe_restore_head+0x0 
(__xnlock_put_irqrestore.constprop.16+0x67)
:|  + end     0x80000000  -575+   4.975  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:   + func                -570+   1.962  ipipe_fastcall_hook+0x0 
(system_call_after_swapgs+0x6b)
:   + func                -568      0.322  handle_head_syscall+0x0 
(ipipe_fastcall_hook+0x18)
:   + func                -568      0.507  CoBaLt_clock_nanosleep+0x0 
(handle_head_syscall+0x151)
:   + func                -567      0.701  __cobalt_clock_nanosleep+0x0 
(CoBaLt_clock_nanosleep+0x58)
:|  + begin   0x80000000  -567      0.280  hard_local_irq_disable+0x16 
(__xnlock_get_irqsave.constprop.17+0x9)
:|  # func                -566      0.427  xnthread_suspend+0x0 
(__cobalt_clock_nanosleep+0xd1)
:|  # func                -566      0.256  xntimer_start+0x0 
(xnthread_suspend+0x10b)
:|  # func                -566      0.390  xnclock_core_ns_to_ticks+0x0 
(xntimer_start+0xd8)
:|  # func                -565+   1.040  xntimer_heading_p+0x0 
(xntimer_start+0x1cd)
:|  # func                -564      0.212  xnclock_core_local_shot+0x0 
(xntimer_start+0x1f6)
:|  # event   tick@-558   -564      0.412  xnclock_core_local_shot+0xa0 
(xntimer_start+0x1f6)
:|  # func                -564      0.248  ipipe_timer_set+0x0 
(xnclock_core_local_shot+0xa8)
:|  # func                -563      0.396  lapic_next_deadline+0x0 
(ipipe_timer_set+0x94)
:|  # func                -563      0.292  ___xnsched_run+0x0 
(__xnsched_run+0x21)
:|  # [ 1332] Automat 97  -563      0.200  ___xnsched_run+0x6c 
(__xnsched_run+0x21)
:|  # func                -562      0.298  xnsched_pick_next+0x0 
(___xnsched_run+0xaa)
:|  # func                -562+   1.038  xnarch_switch_to+0x0 
(___xnsched_run+0x1ce)
:|  # [  545] X       -1  -561      0.683  ___xnsched_run+0x20c 
(xnsched_run+0x3e)
:|   +end     0x000000ef  -560+   1.944  apic_timer_interrupt+0x8f 
(__ipipe_trace+0x384)
:    +func                -559      0.667  mutex_unlock+0x0 
(i915_gem_madvise_ioctl+0xce [i915])
:    +func                -558      0.236  syscall_trace_leave+0x0 
(int_check_syscall_exit_work+0x34)
:    +func                -558      0.410  __audit_syscall_exit+0x0 
(syscall_trace_leave+0x48)
:    +func                -557      0.222  path_put+0x0 
(audit_free_names+0x91)
:    +func                -557+   1.808  dput+0x0 (path_put+0x17)
:|   +begin   0x000000ef  -555+   2.311  apic_timer_interrupt+0x6d 
(__ipipe_trace+0x384)
:|  # [ 1332] Automat 97  -553      0.473  xnthread_resume+0x8c 
(timeout_handler+0x21)
:|  # event   tick@55     -552      0.529  xnclock_core_local_shot+0xa0 
(xnclock_tick+0x1d2)
:|  # [  545] X       -1  -552+   5.882  ___xnsched_run+0x6c 
(xnsched_run+0x3e)
:|  # func                -546+   2.201  __switch_to_xtra+0x0 
(__switch_to+0x252)
:|  # func                -544+   1.168  xnthread_switch_fpu+0x0 
(___xnsched_run+0x1ec)
:|  # func                -543      0.501  xnarch_switch_fpu+0x0 
(xnthread_switch_fpu+0x2d)
:|  # [ 1330] Thread  98  -542      0.880  ___xnsched_run+0x20c 
(__xnsched_run+0x21)
:|  # func                -541      0.236  __ipipe_restore_head+0x0 
(ipipe_restore_head+0x4d)
:|  + end     0x80000000  -541+   1.090  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:|  + begin   0x000000ee  -540      0.254  
ipipe_reschedule_interrupt+0x6d (hard_local_irq_enable+0x19)
:|  + func                -540      0.252  __ipipe_handle_irq+0x0 
(ipipe_reschedule_interrupt+0x7c)
:|  + func                -539      0.829  __ipipe_dispatch_irq+0x0 
(__ipipe_handle_irq+0x109)
:|  + func                -539      0.292  __ipipe_ack_apic+0x0 
(__ipipe_dispatch_irq+0xaf)
:|  + func                -538      0.350  dispatch_irq_head+0x0 
(__ipipe_dispatch_irq+0x113)
:|  # func                -538      0.749  __xnsched_run_handler+0x0 
(dispatch_irq_head+0x6b)
:|  + end     0x000000ee  -537      0.429  
ipipe_reschedule_interrupt+0x8f (hard_local_irq_enable+0x19)
:|  + begin   0x80000000  -537      0.254  hard_local_irq_disable+0x16 
[rtpacket] (__rtdm_lock_get_irqsave+0xf [rtpacket])
:|  # func                -536      0.511  xnsched_lock+0x0 
(__rtdm_lock_get_irqsave+0x3e [rtpacket])
:|  # func                -536+   2.233  xnsched_unlock+0x0 
(rtdm_lock_put_irqrestore+0x11 [rtpacket])
:|  # func                -534      0.222  __ipipe_restore_head+0x0 
(rtdm_lock_put_irqrestore+0x55 [rtpacket])
:|  + end     0x80000000  -534      0.386  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:   + func                -533+   1.690  rt_memcpy_tokerneliovec+0x0 
[rtnet] (rt_packet_recvmsg+0x151 [rtpacket])
:   + func                -531+   1.996  kfree_rtskb+0x0 [rtnet] 
(rt_packet_recvmsg+0x15f [rtpacket])
:|  + begin   0x80000000  -529      0.864  hard_local_irq_disable+0x16 
[rtnet] (__rtdm_lock_get_irqsave+0xf [rtnet])
:|  # func                -529      0.284  xnsched_lock+0x0 
(__rtdm_lock_get_irqsave+0x3e [rtnet])
:|  # func                -528      0.763  xnsched_unlock+0x0 
(rtdm_lock_put_irqrestore+0x11 [rtnet])
:|  # func                -528      0.533  __ipipe_restore_head+0x0 
(rtdm_lock_put_irqrestore+0x55 [rtnet])
:|  + end     0x80000000  -527      0.226  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:   + func                -527      0.292  rtskb_pool_queue_tail+0x0 
[rtnet] (kfree_rtskb+0x82 [rtnet])
:|  + begin   0x80000000  -526      0.254  hard_local_irq_disable+0x16 
[rtnet] (__rtdm_lock_get_irqsave+0xf [rtnet])
:|  # func                -526      0.230  xnsched_lock+0x0 
(__rtdm_lock_get_irqsave+0x3e [rtnet])
:|  # func                -526      0.781  __rtskb_pool_queue_tail+0x0 
[rtnet] (rtskb_pool_queue_tail+0x34 [rtnet])
:|  # func                -525      0.226  rtskb_nop_pool_unlock+0x0 
[rtnet] (__rtskb_pool_queue_tail+0x35 [rtnet])
:|  # func                -525      0.529  xnsched_unlock+0x0 
(rtdm_lock_put_irqrestore+0x11 [rtnet])
:|  # func                -524      0.914  __ipipe_restore_head+0x0 
(rtdm_lock_put_irqrestore+0x55 [rtnet])
:|  + end     0x80000000  -524      0.346  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:   + func                -523+   1.946  rtdm_fd_put+0x0 
(rtdm_fd_recvmsg+0xbc)
:|  + begin   0x80000000  -521      0.270  hard_local_irq_disable+0x16 
(__xnlock_get_irqsave.constprop.11+0x9)
:|  # func                -521      0.633  __put_fd+0x0 (rtdm_fd_put+0x22)
:|  # func                -520      0.693  __ipipe_restore_head+0x0 
(__xnlock_put_irqrestore.constprop.10+0x67)
:|  + end     0x80000000  -520!  17.762  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:   + func                -502      0.236  ipipe_fastcall_hook+0x0 
(system_call_after_swapgs+0x6b)
:   + func                -502+   2.036  handle_head_syscall+0x0 
(ipipe_fastcall_hook+0x18)
:   + func                -500      0.360  CoBaLt_recvmsg+0x0 
(handle_head_syscall+0x151)
:   + func                -499      0.743  rtdm_fd_recvmsg+0x0 
(CoBaLt_recvmsg+0x3d)
:   + func                -498      0.224  rtdm_fd_get+0x0 
(rtdm_fd_recvmsg+0x26)
:|  + begin   0x80000000  -498      0.332  hard_local_irq_disable+0x16 
(__xnlock_get_irqsave.constprop.11+0x9)
:|  # func                -498      0.206  __ipipe_restore_head+0x0 
(__xnlock_put_irqrestore.constprop.10+0x67)
:|  + end     0x80000000  -498+   1.988  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:|  + begin   0x80000001  -496      0.196  ipipe_get_current_domain+0x23 
(rtdm_fd_recvmsg+0x94)
:|  + end     0x80000001  -496      0.272  ipipe_get_current_domain+0x77 
(rtdm_fd_recvmsg+0x94)
:   + func                -495      0.380  rt_packet_recvmsg+0x0 
[rtpacket] (rtdm_fd_recvmsg+0xb1)
:   + func                -495      0.302  rtdm_sem_timeddown+0x0 
(rt_packet_recvmsg+0x65 [rtpacket])
:|  + begin   0x80000000  -495      0.274  hard_local_irq_disable+0x16 
(__xnlock_get_irqsave.constprop.17+0x9)
:|  # func                -494      0.304  xnsynch_sleep_on+0x0 
(rtdm_sem_timeddown+0x9d)
:|  # func                -494      0.264  xnthread_suspend+0x0 
(xnsynch_sleep_on+0x14b)
:|  # func                -494      0.254  ___xnsched_run+0x0 
(__xnsched_run+0x21)
:|  # [ 1330] Thread  98  -493      0.358  ___xnsched_run+0x6c 
(__xnsched_run+0x21)
:|  # func                -493      0.240  xnsched_pick_next+0x0 
(___xnsched_run+0xaa)
:|  # func                -493+   1.672  xnarch_switch_to+0x0 
(___xnsched_run+0x1ce)
:|  # func                -491+   1.670  __switch_to_xtra+0x0 
(__switch_to+0x252)
:|  # func                -490      0.200  xnthread_switch_fpu+0x0 
(___xnsched_run+0x1ec)
:|  # func                -489      0.485  xnarch_switch_fpu+0x0 
(xnthread_switch_fpu+0x2d)
:|  # [ 1332] Automat 97  -489+   1.964  ___xnsched_run+0x20c 
(__xnsched_run+0x21)
:|  # func                -487      0.206  __ipipe_restore_head+0x0 
(__xnlock_put_irqrestore.constprop.16+0x67)
:|  + end     0x80000000  -487!  37.941  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:   + func                -449+   2.959  ipipe_fastcall_hook+0x0 
(system_call_after_swapgs+0x6b)
:   + func                -446+   1.327  handle_head_syscall+0x0 
(ipipe_fastcall_hook+0x18)
:   + func                -444+   1.052  CoBaLt_mq_timedreceive+0x0 
(handle_head_syscall+0x151)
:   + func                -443      0.334  __cobalt_mq_timedreceive+0x0 
(CoBaLt_mq_timedreceive+0x60)
:   + func                -443      0.404  rtdm_fd_get+0x0 
(cobalt_mqd_get+0xe)
:|  + begin   0x80000000  -443+   1.259  hard_local_irq_disable+0x16 
(__xnlock_get_irqsave.constprop.11+0x9)
:|  # func                -441+   1.186  __ipipe_restore_head+0x0 
(__xnlock_put_irqrestore.constprop.10+0x67)
:|  + end     0x80000000  -440      0.222  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:|  + begin   0x80000000  -440      0.573  hard_local_irq_disable+0x16 
(__xnlock_get_irqsave.constprop.17+0x9)
:|  # func                -439      0.212  __ipipe_restore_head+0x0 
(__xnlock_put_irqrestore.constprop.19+0x67)
:|  + end     0x80000000  -439      0.320  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:   + func                -439      0.222  rtdm_fd_put+0x0 
(__cobalt_mq_timedreceive+0x25c)
:|  + begin   0x80000000  -439      0.220  hard_local_irq_disable+0x16 
(__xnlock_get_irqsave.constprop.11+0x9)
:|  # func                -438      0.493  __put_fd+0x0 (rtdm_fd_put+0x22)
:|  # func                -438      0.206  __ipipe_restore_head+0x0 
(__xnlock_put_irqrestore.constprop.10+0x67)
:|  + end     0x80000000  -438! 423.494  hard_local_irq_enable+0x17 
(__ipipe_restore_head+0x70)
:   + func                 -14+   2.201  ipipe_fastcall_hook+0x0 
(system_call_after_swapgs+0x6b)
:   + func                 -12      0.543  handle_head_syscall+0x0 
(ipipe_fastcall_hook+0x18)

Here my task Automat has finished is work

:   + func                 -12      0.471  CoBaLt_trace+0x0 
(handle_head_syscall+0x151)
:   + (0xd0)    0x000007d0   -11+   1.591  CoBaLt_trace+0x98 
(handle_head_syscall+0x151)
:   + func                  -9      0.236  ipipe_fastcall_hook+0x0 
(system_call_after_swapgs+0x6b)
:   + func                  -9+   1.459  handle_head_syscall+0x0 
(ipipe_fastcall_hook+0x18)
:   + func                  -8      0.290  CoBaLt_trace+0x0 
(handle_head_syscall+0x151)
:   + func                  -7      0.296  ipipe_trace_frozen_reset+0x0 
(CoBaLt_trace+0x57)
:   + func                  -7      0.286  __ipipe_global_path_lock+0x0 
(ipipe_trace_frozen_reset+0x22)
:   + func                  -7      0.318  __ipipe_spin_lock_irqsave+0x0 
(__ipipe_global_path_lock+0x15)
:|  + begin   0x80000001    -7+   5.024  hard_local_irq_save+0x18 
(__ipipe_spin_lock_irqsave+0x17)
:|  # func                  -2      0.425  
__ipipe_spin_unlock_irqcomplete+0x0 (__ipipe_global_path_unlock+0x78)
:|  + end     0x80000001    -1+   1.613  hard_local_irq_restore+0x18 
(__ipipe_spin_unlock_irqcomplete+0x31)
<   + freeze  0x000001f4     0      6.792  CoBaLt_trace+0x63 
(handle_head_syscall+0x151)
     + func                   6      2.317  ipipe_fastcall_hook+0x0 
(system_call_after_swapgs+0x6b)
     + func                   9      0.296  handle_head_syscall+0x0 
(ipipe_fastcall_hook+0x18)
     + func                   9      1.724  CoBaLt_kill+0x0 
(handle_head_syscall+0x151)
  |  + begin   0x80000000    11      0.595  hard_local_irq_disable+0x16 
(__xnlock_get_irqsave.constprop.13+0x9)
  |  # func                  11      1.375  cobalt_thread_find+0x0 
(CoBaLt_kill+0x2b)
  |  # func                  13      0.589  __cobalt_kill+0x0 
(CoBaLt_kill+0x40)
  |  # func                  13      0.697  xnthread_suspend+0x0 
(__cobalt_kill+0x6f)
  |  # func                  14      0.627  ___xnsched_run+0x0 
(__xnsched_run+0x21)
  |  # [ 1332] Automat 97    15      0.334  ___xnsched_run+0x6c 
(__xnsched_run+0x21)
  |  # func                  15      0.000  xnsched_pick_next+0x0 
(___xnsched_run+0xaa)

