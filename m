Message-ID: <55A3C023.5070000@sigmatek.at>
Date: Mon, 13 Jul 2015 15:41:55 +0200
From: Johann Obermayr <johann.obermayr@sigmatek.at>
MIME-Version: 1.0
References: <559E65FB.8080904@sigmatek.at>
 <20150709141922.GG20176@hermes.click-hack.org> <559E9687.6020109@sigmatek.at>
 <20150709155115.GK20176@hermes.click-hack.org> <559F91C3.8090005@sigmatek.at>
 <20150710094655.GS20176@hermes.click-hack.org> <559FA1D1.6060602@sigmatek.at>
 <20150710104957.GT20176@hermes.click-hack.org>
In-Reply-To: <20150710104957.GT20176@hermes.click-hack.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Subject: Re: [Xenomai] usage of rtdm_task_sleep_abs
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Am 10.07.2015 um 12:49 schrieb Gilles Chanteperdrix:
> On Fri, Jul 10, 2015 at 12:43:29PM +0200, Johann Obermayr wrote:
>> Am 10.07.2015 um 11:46 schrieb Gilles Chanteperdrix:
>>> On Fri, Jul 10, 2015 at 11:34:59AM +0200, Johann Obermayr wrote:
>>>> Am 09.07.2015 um 17:51 schrieb Gilles Chanteperdrix:
>>>>> On Thu, Jul 09, 2015 at 05:43:03PM +0200, Johann Obermayr wrote:
>>>>>> Am 09.07.2015 um 16:19 schrieb Gilles Chanteperdrix:
>>>>>>> On Thu, Jul 09, 2015 at 02:15:55PM +0200, Johann Obermayr wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> we have follow situation
>>>>>>>>
>>>>>>>> u64 lrtdrv_time_of_irq_ns ;
>>>>>>>> void worker_task()
>>>>>>>> {
>>>>>>>> while(1)
>>>>>>>>      {
>>>>>>>>      rtdm_task_sleep_abs(lrtdrv_time_of_irq_ns + 950000ull,
>>>>>>>> RTDM_TIMERMODE_ABSOLUTE);
>>>>>>>>      do_something();
>>>>>>>>      }
>>>>>>>> }
>>>>>>>>
>>>>>>>> _kernel_rtdm_irq_handler()
>>>>>>>> {
>>>>>>>>      lrtdrv_time_of_irq_ns =3D rtdm_clock_read_monotonic();
>>>>>>>> }
>>>>>>>>
>>>>>>>> the  _kernel_irq_callback() is called every 1ms.
>>>>>>>> we will , that the worker_task begin 50us before next irq
>>>>>>>>
>>>>>>>> But sometime, the worker task start ~50us after irq. Why ?
>>>>>>> Best way to know, enable the I-pipe tracer, setup sufficient back
>>>>>>> trace points, and when the wrong wake up happens, trigger an I-pipe
>>>>>>> trace.
>>>>>>>
>>>>>> i will enable i-pipe tracer.
>>>>>> found out, that
>>>>>>
>>>>>> rtdm_task_sleep_abs(xxx, RTDM_TIMERMODE_ABSOLUTE);
>>>>>> u64 calc =3D rtdm_clock_read_monotonic();
>>>>>>
>>>>>> sometime the diff between xxx & calc is biger than 61000ns.
>>>>> This is called "kernel task scheduling latency". It can be measured by
>>>>> the latency -t 1 test.
>>>> Ok, i will test it with this test.
>>>> Here a simple list of measure from  rtdm_task_sleep_abs(xxx) calc =3D
>>>> rtdm_clock_read_monotonic
>>> Yeah, latency -t 1 does that too. Only much better.
>>>
>> Result a) only latency -t 1
>> RTT|  00:00:01  (in-kernel periodic task, 100 us period, priority 99)
>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
>> worst
>> RTD|     -2.618|     -2.481|     -2.384|       0|     0| -2.618|     -2.=
384
>> RTD|     -2.506|     -2.477|     -2.301|       0|     0| -2.618|     -2.=
301
>> RTD|     -2.590|     -2.479|     -2.192|       0|     0| -2.618|     -2.=
192
>> RTD|     -2.517|     -2.489|     -2.324|       0|     0| -2.618|     -2.=
192
>> RTD|     -2.612|     -2.490|     -2.335|       0|     0| -2.618|     -2.=
192
>> RTD|     -2.723|     -2.490|     -2.300|       0|     0| -2.723|     -2.=
192
>> RTD|     -2.521|     -2.491|     -2.332|       0|     0| -2.723|     -2.=
192
>> RTD|     -2.624|     -2.492|     -2.346|       0|     0| -2.723|     -2.=
192
>> RTD|     -2.520|     -2.490|     -2.341|       0|     0| -2.723|     -2.=
192
>> RTD|     -2.584|     -2.490|     -2.353|       0|     0| -2.723|     -2.=
192
>> RTD|     -2.521|     -2.487|     -2.333|       0|     0| -2.723|     -2.=
192
>> RTD|     -2.521|     -2.490|     -2.329|       0|     0| -2.723|     -2.=
192
>> RTD|     -2.519|     -2.488|     -1.946|       0|     0| -2.723|     -1.=
946
>> RTD|     -2.521|     -2.490|     -2.353|       0|     0| -2.723|     -1.=
946
>> RTD|     -2.605|     -2.490|     -2.343|       0|     0| -2.723|     -1.=
946
>> RTD|     -2.521|     -2.490|     -2.328|       0|     0| -2.723|     -1.=
946
>> RTD|     -2.568|     -2.489|     -2.337|       0|     0| -2.723|     -1.=
946
>> RTD|     -2.520|     -2.490|     -2.329|       0|     0| -2.723|     -1.=
946
>> RTD|     -2.553|     -2.491|     -2.337|       0|     0| -2.723|     -1.=
946
>> RTD|     -2.521|     -2.491|     -2.325|       0|     0| -2.723|     -1.=
946
>> RTD|     -2.521|     -2.490|     -2.341|       0|     0| -2.723|     -1.=
946
>>
>> Result b) with our application, that copy with a releaxed task from/to a
>> SRAM on a PCI Card.
>> RTT|  00:00:01  (in-kernel periodic task, 100 us period, priority 99)
>> RTH|---lat min|---lat avg|----lat max|-overrun|---msw|---lat best|--lat
>> worst
>> RTD|     -2.680|     -1.537|    716.496|       38|     0| -2.680|    716=
.496
>> RTD|     -2.680|     -1.414|    691.232|       81|     0| -2.680|    716=
.496
>> RTD|     -3.051|     -0.877|    739.939|     120|     0| -3.051|    739.=
939
>> RTD|     -2.662|     -1.422|    738.747|     160|     0| -3.051|    739.=
939
>> RTD|     -2.713|     -1.637|    726.880|     191|     0| -3.051|    739.=
939
>> RTD|     -2.656|     -1.044|    675.880|     218|     0| -3.051|    739.=
939
>> RTD|     -2.655|     -1.269|    753.354|     251|     0| -3.051|    753.=
354
>> RTD|     -2.661|     -1.344|    633.684|     301|     0| -3.051|    753.=
354
>> RTD|     -2.663|     -1.626|    698.008|     333|     0| -3.051|    753.=
354
>> RTD|     -2.662|     -0.579|    751.352|     379|     0| -3.051|    753.=
354
>> RTD|     -2.669|     -1.455|    733.275|     410|     0| -3.051|    753.=
354
>> RTD|     -2.758|     -1.670|    629.569|     434|     0| -3.051|    753.=
354
>> RTD|     -2.760|     -1.686|    690.451|     445|     0| -3.051|    753.=
354
>> RTD|     -2.668|     -1.032|    753.099|     483|     0| -3.051|    753.=
354
>> RTD|     -2.661|     -1.476|    735.519|     518|     0| -3.051|    753.=
354
>> RTD|     -2.660|     -1.647|    725.828|     552|     0| -3.051|    753.=
354
>> RTD|     -2.661|     -1.236|    250.879|     556|     0| -3.051|    753.=
354
> Your application (and more probably driver) has a problem, it
> probably creates large interrupts masking section. Once again, to
> understand what the problem is, I suggest using the I-pipe tracer.
>
Hello,

i have add a ipipe trace. But i don't understand it.

the function lrtdrv_monitoring_irq has no mutex, only a atomic funtion =

and write result into a ring buffer.
(see your trace screen. red lines)

http://www.pic-upload.de/view-27670244/Trace001.png.html


-------------- next part --------------
I-pipe frozen back-tracing service on 3.10.0/ipipe release #1
------------------------------------------------------------
CPU: 0, Freeze: 1294584251633 cycles, Trace Points: 2000 (+10)
Calibrated minimum trace-point overhead: 0.078 us

 +----- Hard IRQs ('|': locked)
 |+-- Xenomai
 ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||			  +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||			  |	   +- NMI noise ('N')
 |||			  |	   |
	  Type	  User Val.   Time    Delay  Function (Parent)
:|   #func               -1927	  0.178  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   #end     0x80000001 -1927	  0.133  hard_local_irq_restore+0x15 (ipipe_=
raise_irq+0x45)
:|   #begin   0x80000001 -1927	  0.127  hard_local_irq_save+0x16 (__ipipe_n=
otify_kevent+0x5b)
:|   #end     0x80000001 -1926	  0.138  hard_local_irq_restore+0x15 (__ipip=
e_notify_kevent+0x6b)
:|   #begin   0x80000000 -1926	  0.252  __schedule+0x3a3 (schedule+0x18)
:|   #func               -1926	  0.374  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|   #func               -1926	  0.135  ipipe_unstall_head+0x4 (xnshadow_re=
lax+0x91)
:|   #end     0x80000000 -1926	  0.114  hard_local_irq_enable+0x16 (ipipe_u=
nstall_head+0x2e)
:    #func               -1925	  0.124  __ipipe_reenter_root+0x4 (xnshadow_=
relax+0xa2)
:|   #begin   0x80000001 -1925	  0.141  debug_smp_processor_id+0x36 (__ipip=
e_reenter_root+0x13)
:|   #end     0x80000001 -1925	  0.129  debug_smp_processor_id+0x82 (__ipip=
e_reenter_root+0x13)
:    #func               -1925	  0.114  finish_task_switch+0x7 (__ipipe_ree=
nter_root+0x28)
:    #func               -1925	  0.126  _raw_spin_unlock_irq+0x3 (finish_ta=
sk_switch+0x4a)
:    #func               -1925	  0.123  ipipe_unstall_root+0x3 (_raw_spin_u=
nlock_irq+0x12)
:|   #begin   0x80000000 -1925	  0.126  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1925	  0.187  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1924	  0.114  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1924	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock_irq+0x1c)
:    +func               -1924	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1924	  0.256  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1924	  0.175  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1924	  0.115  sub_preempt_count+0x4 (__ipipe_reen=
ter_root+0x42)
:    +func               -1923	  0.126  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1923	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1923	  0.181  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   +begin   0x80000001 -1923	  0.210  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|   +end     0x80000001 -1923	  0.126  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:    +func               -1923	  0.118  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|   +begin   0x80000001 -1923	  0.155  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|   +end     0x80000001 -1922	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:    +func               -1922	  0.118  losyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:|   +begin   0x80000001 -1922	  0.181  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|   +end     0x80000001 -1922	  0.147  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|   +begin   0x80000000 -1922	  0.179  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|   +end     0x80000000 -1922	  0.139  __ipipe_syscall_root+0x9e (system_c=
all+0x30)
:    +func               -1922	  0.112  SyS_select+0x9 (syscall_call+0x7)
:    +func               -1921	  0.115  _copy_from_user+0x7 (SyS_select+0x3=
9)
:    +func               -1921	  0.118  ipipe_root_only+0x5 (_copy_from_use=
r+0x30)
:|   +begin   0x80000001 -1921	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1921	  0.127  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1921	  0.163  __copy_from_user_ll+0x6 (_copy_from=
_user+0x3c)
:    +func               -1921	  0.121  poll_select_set_timeout+0x6 (SyS_se=
lect+0x60)
:    +func               -1921	  0.118  core_sys_select+0xc (SyS_select+0x8=
0)
:    +func               -1920	  0.130  __rcu_read_lock+0x3 (core_sys_selec=
t+0x31)
:    +func               -1920	  0.126  __rcu_read_unlock+0x4 (core_sys_sel=
ect+0x47)
:    +func               -1920	  0.112  _copy_from_user+0x7 (get_fd_set+0x1=
b)
:    +func               -1920	  0.118  ipipe_root_only+0x5 (_copy_from_use=
r+0x30)
:|   +begin   0x80000001 -1920	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1920	  0.129  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1920	  0.132  __copy_from_user_ll+0x6 (_copy_from=
_user+0x3c)
:    +func               -1920	  0.117  _copy_from_user+0x7 (get_fd_set+0x1=
b)
:    +func               -1919	  0.117  ipipe_root_only+0x5 (_copy_from_use=
r+0x30)
:|   +begin   0x80000001 -1919	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1919	  0.129  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1919	  0.184  __copy_from_user_ll+0x6 (_copy_from=
_user+0x3c)
:    +func               -1919	  0.115  do_select+0xc (core_sys_select+0x12=
b)
:    +func               -1919	  0.144  __rcu_read_lock+0x3 (do_select+0x23)
:    +func               -1919	  0.118  __rcu_read_unlock+0x4 (do_select+0x=
e5)
:    +func               -1918	  0.163  poll_initwait+0x3 (do_select+0xfd)
:    +func               -1918	  0.118  fget_light+0x6 (do_select+0x2aa)
:    +func               -1918	  0.136  __rcu_read_lock+0x3 (fget_light+0x4=
a)
:    +func               -1918	  0.135  __rcu_read_unlock+0x4 (fget_light+0=
x7b)
:    +func               -1918	  0.112  eventfd_poll+0x6 (do_select+0x30f)
:    +func               -1918	  0.154  _raw_spin_lock_irqsave+0x5 (eventfd=
_poll+0x2f)
:    #func               -1918	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1918	  0.126  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1917	  0.154  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1917	  0.148  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1917	  0.123  __ipipe_spin_unlock_debug+0x3 (even=
tfd_poll+0x68)
:    #func               -1917	  0.132  _raw_spin_unlock_irqrestore+0x4 (ev=
entfd_poll+0x71)
:    #func               -1917	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1917	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1917	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1916	  0.141  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1916	  0.120  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1916	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1916	  0.190  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1916	  0.117  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1916	  0.118  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    +func               -1916	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1916	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1915	  0.136  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1915	  0.164  fput+0x5 (do_select+0x327)
:    +func               -1915	  0.114  fget_light+0x6 (do_select+0x2aa)
:    +func               -1915	  0.142  __rcu_read_lock+0x3 (fget_light+0x4=
a)
:    +func               -1915	  0.144  __rcu_read_unlock+0x4 (fget_light+0=
x7b)
:    +func               -1915	  0.138  sock_poll+0x5 (do_select+0x30f)
:    +func               -1915	  0.132  tcp_poll+0x6 (sock_poll+0x17)
:    +func               -1914	  0.127  fput+0x5 (do_select+0x327)
:    +func               -1914	  0.142  _cond_resched+0x3 (do_select+0x3f1)
:    +func               -1914	  0.130  poll_freewait+0x9 (do_select+0x4ab)
:    +func               -1914	  0.130  ipipe_root_only+0x5 (set_fd_set+0x1=
7)
:|   +begin   0x80000001 -1914	  0.152  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1914	  0.129  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1914	  0.139  __copy_to_user_ll+0x6 (set_fd_set+0=
x2d)
:    +func               -1913	  0.118  ipipe_root_only+0x5 (set_fd_set+0x1=
7)
:|   +begin   0x80000001 -1913	  0.178  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1913	  0.129  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1913	  0.142  __copy_to_user_ll+0x6 (set_fd_set+0=
x2d)
:    +func               -1913!  43.981  poll_select_copy_remaining+0x9 (Sy=
S_select+0x90)
:    +func               -1869	  0.114  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:    +func               -1869	  0.118  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|   +begin   0x80000001 -1869	  0.198  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1868	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1868	  0.118  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1868	  0.145  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1868	  0.136  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1868	  0.136  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:|  + begin   0x80000001 -1868	  0.221  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|   +end     0x80000001 -1868	  0.126  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:    +func               -1867	  0.117  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|   +begin   0x80000001 -1867	  0.155  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|   +end     0x80000001 -1867	  0.127  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:    +func               -1867	  0.151  losyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:    +func               -1867	  0.121  sys_rtdm_ioctl+0x3 (losyscall_event=
+0xb1)
:    +func               -1867	  0.112  __rt_dev_ioctl+0x9 (sys_rtdm_ioctl+=
0x1d)
:    +func               -1867	  0.121  rtdm_context_get+0x6 (__rt_dev_ioct=
l+0x24)
:|   +begin   0x80000000 -1867	  0.212  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  *+func               -1866	  0.141  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|   +end     0x80000000 -1866	  0.124  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|   +begin   0x80000001 -1866	  0.142  rtdm_in_rt_context+0x1d (__rt_dev_i=
octl+0x36)
:|   +end     0x80000001 -1866	  0.142  rtdm_in_rt_context+0x67 (__rt_dev_i=
octl+0x36)
:    +func               -1866	  0.115  lrt_non_rt_ioctl+0x3 [sigmatek_lrt]=
 (__rt_dev_ioctl+0x51)
:    +func               -1866	  0.187  lrt_non_rt_ioctl_work+0xc [sigmatek=
_lrt] (lrt_non_rt_ioctl+0x10 [sigmatek_lrt])
:    +func               -1865	  0.120  xnshadow_harden+0x9 (losyscall_even=
t+0x88)
:    +func               -1865	  0.114  down_interruptible+0x6 (xnshadow_ha=
rden+0x4f)
:    +func               -1865	  0.144  _raw_spin_lock_irqsave+0x5 (down_in=
terruptible+0x12)
:    #func               -1865	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1865	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1865	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1865	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1865	  0.130  __ipipe_spin_unlock_debug+0x3 (down=
_interruptible+0x33)
:    #func               -1864	  0.124  _raw_spin_unlock_irqrestore+0x4 (do=
wn_interruptible+0x3c)
:    #func               -1864	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1864	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1864	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1864	  0.141  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1864	  0.120  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1864	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1863	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1863	  0.115  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1863	  0.118  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    +func               -1863	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1863	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1863	  0.135  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1863	  0.112  add_preempt_count+0x4 (xnshadow_har=
den+0x76)
:    +func               -1863	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1862	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1862	  0.145  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1862	  0.123  wake_up_process+0x4 (xnshadow_harde=
n+0xe1)
:    +func               -1862	  0.112  try_to_wake_up+0x9 (wake_up_process=
+0x2e)
:    +func               -1862	  0.142  _raw_spin_lock_irqsave+0x5 (try_to_=
wake_up+0x25)
:    #func               -1862	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1862	  0.120  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1861	  0.166  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1861	  0.164  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1861	  0.219  select_task_rq_rt+0x6 (select_task_=
rq+0x15)
:|   #begin   0x80000001 -1861	  0.142  debug_smp_processor_id+0x36 (try_to=
_wake_up+0x106)
:|   #end     0x80000001 -1861	  0.129  debug_smp_processor_id+0x82 (try_to=
_wake_up+0x106)
:    #func               -1861	  0.118  cpus_share_cache+0x4 (try_to_wake_u=
p+0x10d)
:    #func               -1861	  0.111  _raw_spin_lock+0x4 (try_to_wake_up+=
0x15a)
:    #func               -1860	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck+0x15)
:    #func               -1860	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1860	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1860	  0.141  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1860	  0.115  ttwu_do_activate.constprop.91+0x5 (=
try_to_wake_up+0x163)
:    #func               -1860	  0.117  activate_task+0x4 (ttwu_do_activate=
.constprop.91+0x2b)
:    #func               -1860	  0.115  enqueue_task+0x8 (activate_task+0x2=
1)
:    #func               -1860	  0.139  update_rq_clock+0x6 (enqueue_task+0=
x1a)
:|   #begin   0x80000001 -1859	  0.154  debug_smp_processor_id+0x36 (__cycl=
es_2_ns+0x14)
:|   #end     0x80000001 -1859	  0.147  debug_smp_processor_id+0x82 (__cycl=
es_2_ns+0x14)
:    #func               -1859	  0.112  enqueue_task_rt+0x7 (enqueue_task+0=
x28)
:    #func               -1859	  0.130  dequeue_rt_stack+0x9 (enqueue_task_=
rt+0x2c)
:    #func               -1859	  0.158  cpupri_set+0x6 (enqueue_task_rt+0xc=
a)
:    #func               -1859	  0.124  update_rt_migration+0x4 (enqueue_ta=
sk_rt+0xea)
:    #func               -1859	  0.115  ttwu_do_wakeup+0x6 (ttwu_do_activat=
e.constprop.91+0x50)
:    #func               -1858	  0.187  check_preempt_curr+0x7 (ttwu_do_wak=
eup+0x14)
:    #func               -1858	  0.120  check_preempt_curr_rt+0x5 (check_pr=
eempt_curr+0x2c)
:    #func               -1858	  0.139  resched_task+0x5 (check_preempt_cur=
r_rt+0x82)
:|   #begin   0x80000001 -1858	  0.142  debug_smp_processor_id+0x36 (resche=
d_task+0x48)
:|   #end     0x80000001 -1858	  0.135  debug_smp_processor_id+0x82 (resche=
d_task+0x48)
:    #func               -1858	  0.117  task_woken_rt+0x4 (ttwu_do_wakeup+0=
x5b)
:    #func               -1858	  0.123  _raw_spin_unlock+0x3 (try_to_wake_u=
p+0x16f)
:    #func               -1858	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
:    #func               -1857	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1857	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1857	  0.133  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1857	  0.130  __ipipe_spin_unlock_debug+0x3 (try_=
to_wake_up+0x177)
:    #func               -1857	  0.121  _raw_spin_unlock_irqrestore+0x4 (tr=
y_to_wake_up+0x182)
:    #func               -1857	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1857	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1856	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1856	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1856	  0.121  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1856	  0.126  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1856	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1856	  0.114  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1856	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    +func               -1856	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1855	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1855	  0.148  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1855	  0.123  schedule+0x3 (xnshadow_harden+0xe6)
:    +func               -1855	  0.112  __schedule+0x9 (schedule+0x18)
:    +func               -1855	  0.114  add_preempt_count+0x4 (__schedule+0=
x23)
:    +func               -1855	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1855	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1854	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   +begin   0x80000001 -1854	  0.152  debug_smp_processor_id+0x36 (__sche=
dule+0x28)
:|   +end     0x80000001 -1854	  0.129  debug_smp_processor_id+0x82 (__sche=
dule+0x28)
:    +func               -1854	  0.115  rcu_note_context_switch+0x9 (__sche=
dule+0x3a)
:    +func               -1854	  0.144  rcu_sched_qs+0x3 (rcu_note_context_=
switch+0x2a)
:    #func               -1854	  0.121  rcu_preempt_qs+0x3 (rcu_note_contex=
t_switch+0x147)
:    #func               -1854	  0.111  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1854	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1853	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1853	  0.127  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1853	  0.121  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1853	  0.126  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1853	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1853	  0.130  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1853	  0.118  sub_preempt_count+0x4 (__schedule+0=
x54)
:    +func               -1852	  0.123  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1852	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1852	  0.135  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1852	  0.117  ipipe_root_only+0x5 (__schedule+0x7=
3)
:|   +begin   0x80000001 -1852	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1852	  0.127  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1852	  0.127  _raw_spin_lock_irq+0x4 (__schedule+=
0xba)
:    #func               -1851	  0.117  add_preempt_count+0x4 (_raw_spin_lo=
ck_irq+0x1a)
:    #func               -1851	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1851	  0.175  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1851	  0.147  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1851	  0.112  deactivate_task+0x4 (__schedule+0x1=
0e)
:    #func               -1851	  0.115  dequeue_task+0x8 (deactivate_task+0=
x21)
:    #func               -1851	  0.190  update_rq_clock+0x6 (dequeue_task+0=
x1a)
:    #func               -1850	  0.120  dequeue_task_rt+0x5 (dequeue_task+0=
x28)
:    #func               -1850	  0.124  update_curr_rt+0x9 (dequeue_task_rt=
+0x13)
:    #func               -1850	  0.120  sched_avg_update+0x9 (update_curr_r=
t+0xc9)
:    #func               -1850	  0.144  dequeue_rt_stack+0x9 (dequeue_task_=
rt+0x1b)
:    #func               -1850	  0.115  update_rt_migration+0x4 (dequeue_rt=
_stack+0x121)
:    #func               -1850	  0.127  dequeue_pushable_task+0x5 (dequeue_=
task_rt+0x24)
:    #func               -1850	  0.136  pre_schedule_rt+0x3 (__schedule+0x2=
42)
:    #func               -1850	  0.123  put_prev_task_rt+0x5 (__schedule+0x=
275)
:    #func               -1849	  0.126  update_curr_rt+0x9 (put_prev_task_r=
t+0x14)
:    #func               -1849	  0.123  pick_next_task_stop+0x4 (__schedule=
+0x299)
:    #func               -1849	  0.118  pick_next_task_rt+0x5 (__schedule+0=
x299)
:    #func               -1849	  0.132  dequeue_pushable_task+0x5 (pick_nex=
t_task_rt+0x5b)
:    #func               -1849	  0.118  taskSwitchLinux+0x6 [sigmatek_lrt] =
(__schedule+0x2dc)
:    #func               -1849	  0.135  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchLinux+0x32 [sigmatek_lrt])
:    #func               -1849	  0.120  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:    #func               -1849	  0.213  rt_task_set_mode+0x7 (taskSwitchLin=
ux+0x4f [sigmatek_lrt])
:    #func               -1848	  0.155  rt_task_set_mode+0x7 (taskSwitchLin=
ux+0xbf [sigmatek_lrt])
:    #func               -1848	  0.115  __ipipe_notify_kevent+0x9 (__schedu=
le+0x391)
:    #func               -1848	  0.115  ipipe_root_only+0x5 (__ipipe_notify=
_kevent+0x1b)
:|   #begin   0x80000001 -1848	  0.154  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1848	  0.130  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001 -1848	  0.144  hard_local_irq_save+0x16 (__ipipe_n=
otify_kevent+0x20)
:|   #end     0x80000001 -1848	  0.126  hard_local_irq_restore+0x15 (__ipip=
e_notify_kevent+0x49)
:    #func               -1847	  0.115  ipipe_kevent_hook+0x4 (__ipipe_noti=
fy_kevent+0x54)
:    #func               -1847	  0.139  schedule_event+0x9 (ipipe_kevent_ho=
ok+0x1c)
:|   #begin   0x80000000 -1847	  0.161  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  *#func               -1847	  0.161  xnsched_peek_rpi+0x3 (schedule_even=
t+0x14c)
:|  *#func               -1847	  0.145  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|   #end     0x80000000 -1847	  0.124  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|   #begin   0x80000001 -1847	  0.127  hard_local_irq_save+0x16 (__ipipe_n=
otify_kevent+0x5b)
:|   #end     0x80000001 -1846	  0.138  hard_local_irq_restore+0x15 (__ipip=
e_notify_kevent+0x6b)
:|   #begin   0x80000000 -1846	  0.155  __schedule+0x3a3 (schedule+0x18)
:|   #func               -1846	  0.233  __switch_to+0x9 (__schedule+0x50a)
:|   #func               -1846	  0.139  __ipipe_switch_tail+0x4 (__schedule=
+0x514)
:|   #end     0x80000000 -1846	  0.133  hard_local_irq_enable+0x16 (__ipipe=
_switch_tail+0x2e)
:|   #begin   0x80000001 -1846	  0.142  debug_smp_processor_id+0x36 (__sche=
dule+0x51d)
:|   #end     0x80000001 -1846	  0.130  debug_smp_processor_id+0x82 (__sche=
dule+0x51d)
:    #func               -1845	  0.114  finish_task_switch+0x7 (__schedule+=
0x533)
:    #func               -1845	  0.124  _raw_spin_unlock_irq+0x3 (finish_ta=
sk_switch+0x4a)
:    #func               -1845	  0.123  ipipe_unstall_root+0x3 (_raw_spin_u=
nlock_irq+0x12)
:|   #begin   0x80000000 -1845	  0.126  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1845	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1845	  0.114  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1845	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock_irq+0x1c)
:    +func               -1844	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1844	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1844	  0.148  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   +begin   0x80000001 -1844	  0.145  debug_smp_processor_id+0x36 (__sche=
dule+0x538)
:|   +end     0x80000001 -1844	  0.126  debug_smp_processor_id+0x82 (__sche=
dule+0x538)
:    +func               -1844	  0.115  sub_preempt_count+0x4 (__schedule+0=
x56c)
:    +func               -1844	  0.124  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1844	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1843	  0.203  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1843	  0.132  kthread_should_stop+0x3 (gatekeeper=
_thread+0xc3)
:    +func               -1843	  0.117  rpi_pop+0x9 (gatekeeper_thread+0xf0)
:|   +begin   0x80000000 -1843	  0.170  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  *+func               -1843	  0.176  xnsched_peek_rpi+0x3 (rpi_pop+0x6e)
:|  *+func               -1843	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|   +end     0x80000000 -1842	  0.117  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:    +func               -1842	  0.120  xnsched_renice_root+0x7 (rpi_pop+0x=
b4)
:|   +begin   0x80000000 -1842	  0.210  hard_local_irq_disable+0x15 (xnsche=
d_renice_root+0x1e)
:|  *+func               -1842	  0.126  xnsched_track_policy+0x6 (xnsched_r=
enice_root+0x6a)
:|  *+[    0] -<?>-   -1 -1842	  0.145  xnsched_renice_root+0x82 (rpi_pop+0=
xb4)
:|  *+func               -1842	  0.135  __ipipe_restore_head+0x4 (xnsched_r=
enice_root+0xd6)
:|   +end     0x80000000 -1842	  0.123  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|   +begin   0x80000000 -1841	  0.157  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  *+func               -1841	  0.145  xnpod_resume_thread+0x9 (gatekeeper=
_thread+0x11a)
:|  *+[  582] cyclic: 30 -1841	  0.185  xnpod_resume_thread+0x39 (gatekeepe=
r_thread+0x11a)
:|  *+func               -1841	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|   +end     0x80000000 -1841	  0.121  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:    +func               -1841	  0.120  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|   +begin   0x80000001 -1841	  0.142  ipipe_get_current_domain+0x1d (__xn=
pod_schedule+0x15)
:|   +end     0x80000001 -1840	  0.132  ipipe_get_current_domain+0x67 (__xn=
pod_schedule+0x15)
:    +func               -1840	  0.120  ipipe_raise_irq+0x8 (__xnpod_schedu=
le+0x26)
:|   +begin   0x80000001 -1840	  0.141  hard_local_irq_save+0x16 (ipipe_rai=
se_irq+0x14)
:|   +func               -1840	  0.112  irq_hook_handler+0x5 [sigmatek_lrt]=
 (ipipe_raise_irq+0x36)
:|   +func               -1840	  0.144  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func               -1840	  0.129  __ipipe_handle_irq+0x7 (ipipe_raise=
_irq+0x3e)
:|   +func               -1840	  0.120  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -1840	  0.163  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func               -1839	  0.147  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -1839	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   +func               -1839	  0.203  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1839	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1839	  0.145  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1839	  0.135  xnpod_schedule_handler+0x3 (__ipipe=
_dispatch_irq+0x182)
:|  # func               -1839	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1 -1838	  0.121  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1838	  0.127  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1838	  0.301  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -1838	  0.253  __switch_to+0x9 (__schedule+0x50a)
:|  # func               -1838	  0.190  __ipipe_switch_tail+0x4 (__schedule=
+0x514)
:|  # func               -1837	  0.234  xnpod_switch_fpu+0x3 (xnshadow_hard=
en+0x133)
:|  # func               -1837	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1837	  0.133  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:   + func               -1837	  0.120  sys_rtdm_ioctl+0x3 (losyscall_event=
+0xb1)
:   + func               -1837	  0.124  __rt_dev_ioctl+0x9 (sys_rtdm_ioctl+=
0x1d)
:   + func               -1837	  0.123  rtdm_context_get+0x6 (__rt_dev_ioct=
l+0x24)
:|  + begin   0x80000000 -1836	  0.210  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  # func               -1836	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1836	  0.124  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1836	  0.144  rtdm_in_rt_context+0x1d (__rt_dev_i=
octl+0x36)
:|  + end     0x80000001 -1836	  0.147  rtdm_in_rt_context+0x67 (__rt_dev_i=
octl+0x36)
:   + func               -1836	  0.120  lrt_ioctl+0x3 [sigmatek_lrt] (__rt_=
dev_ioctl+0x46)
:   + func               -1836	  0.120  lrt_ioctl_work+0xc [sigmatek_lrt] (=
lrt_ioctl+0x10 [sigmatek_lrt])
:   + func               -1835	  0.151  __copy_from_user_ll_nozero+0x6 (rtd=
m_safe_copy_from_user.isra.4+0x23 [sigmatek_lrt])
:   + func               -1835	  0.126  lrtdrv_timing_watchdog+0x6 [sigmate=
k_lrt] (lrt_ioctl_work+0x4a2 [sigmatek_lrt])
:   + func               -1835	  0.120  setup_watchdog+0x6 [sigmatek_lrt] (=
lrtdrv_timing_watchdog+0x46 [sigmatek_lrt])
:   + func               -1835	  0.118  rt_task_self+0x3 (setup_watchdog+0x=
42 [sigmatek_lrt])
:   + func               -1835	  0.123  lrtdrv_timing_wait+0x9 [sigmatek_lr=
t] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:|  + begin   0x80000001 -1835	  0.147  lrtdrv_timing_wait+0x39 [sigmatek_l=
rt] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:|  + end     0x80000001 -1835	  0.127  lrtdrv_timing_wait+0x85 [sigmatek_l=
rt] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:   + func               -1835	  0.118  rtdm_event_wait+0x3 (lrtdrv_timing_=
wait+0xdc [sigmatek_lrt])
:   + func               -1834	  0.123  rtdm_event_timedwait+0x9 (rtdm_even=
t_wait+0x13)
:|  + begin   0x80000000 -1834	  0.154  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.14+0x9)
:|  # func               -1834	  0.172  xnsynch_sleep_on+0x9 (rtdm_event_ti=
medwait+0x8e)
:|  # func               -1834	  0.144  xnpod_suspend_thread+0x9 (xnsynch_s=
leep_on+0x8b)
:|  # func               -1834	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  582] cyclic: 30 -1834	  0.115  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1834	  0.262  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1833	  0.317  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [   23] gatekee -1 -1833	  0.198  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1833	  0.123  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1833	  0.115  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1833	  0.120  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1832	  0.310  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -1832	  0.188  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -1832	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +func               -1832	  0.198  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +end     0x80000001 -1832	  0.170  hard_local_irq_restore+0x15 (ipipe_=
raise_irq+0x45)
:    +func               -1831	  0.118  up+0x5 (gatekeeper_thread+0xb9)
:    +func               -1831	  0.141  _raw_spin_lock_irqsave+0x5 (up+0x11)
:    #func               -1831	  0.114  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1831	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1831	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1831	  0.141  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1831	  0.123  __ipipe_spin_unlock_debug+0x3 (up+0=
x2e)
:    #func               -1831	  0.121  _raw_spin_unlock_irqrestore+0x4 (up=
+0x37)
:    #func               -1830	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1830	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1830	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1830	  0.126  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1830	  0.121  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1830	  0.126  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1830	  0.187  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1829	  0.114  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1829	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    +func               -1829	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1829	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1829	  0.132  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1829	  0.115  schedule+0x3 (gatekeeper_thread+0xb=
e)
:    +func               -1829	  0.115  __schedule+0x9 (schedule+0x18)
:    +func               -1829	  0.114  add_preempt_count+0x4 (__schedule+0=
x23)
:    +func               -1828	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1828	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1828	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   +begin   0x80000001 -1828	  0.142  debug_smp_processor_id+0x36 (__sche=
dule+0x28)
:|   +end     0x80000001 -1828	  0.129  debug_smp_processor_id+0x82 (__sche=
dule+0x28)
:    +func               -1828	  0.115  rcu_note_context_switch+0x9 (__sche=
dule+0x3a)
:    +func               -1828	  0.144  rcu_sched_qs+0x3 (rcu_note_context_=
switch+0x2a)
:    #func               -1828	  0.121  rcu_preempt_qs+0x3 (rcu_note_contex=
t_switch+0x147)
:    #func               -1827	  0.112  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1827	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1827	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1827	  0.127  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1827	  0.123  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1827	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1827	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1826	  0.117  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1826	  0.117  ipipe_root_only+0x5 (__schedule+0x7=
3)
:|   +begin   0x80000001 -1826	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1826	  0.127  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1826	  0.129  _raw_spin_lock_irq+0x4 (__schedule+=
0xba)
:    #func               -1826	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irq+0x1a)
:    #func               -1826	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1826	  0.175  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1825	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1825	  0.114  deactivate_task+0x4 (__schedule+0x1=
0e)
:    #func               -1825	  0.114  dequeue_task+0x8 (deactivate_task+0=
x21)
:    #func               -1825	  0.149  update_rq_clock+0x6 (dequeue_task+0=
x1a)
:|   #begin   0x80000001 -1825	  0.141  debug_smp_processor_id+0x36 (__cycl=
es_2_ns+0x14)
:|   #end     0x80000001 -1825	  0.144  debug_smp_processor_id+0x82 (__cycl=
es_2_ns+0x14)
:    #func               -1825	  0.112  dequeue_task_rt+0x5 (dequeue_task+0=
x28)
:    #func               -1824	  0.127  update_curr_rt+0x9 (dequeue_task_rt=
+0x13)
:    #func               -1824	  0.118  sched_avg_update+0x9 (update_curr_r=
t+0xc9)
:    #func               -1824	  0.138  dequeue_rt_stack+0x9 (dequeue_task_=
rt+0x1b)
:    #func               -1824	  0.158  cpupri_set+0x6 (dequeue_rt_stack+0x=
104)
:    #func               -1824	  0.120  update_rt_migration+0x4 (dequeue_rt=
_stack+0x121)
:    #func               -1824	  0.124  dequeue_pushable_task+0x5 (dequeue_=
task_rt+0x24)
:    #func               -1824	  0.111  pre_schedule_rt+0x3 (__schedule+0x2=
42)
:    #func               -1824	  0.121  pull_rt_task+0x9 (pre_schedule_rt+0=
x18)
:    #func               -1823	  0.129  idle_balance+0x9 (__schedule+0x252)
:    #func               -1823	  0.124  _raw_spin_unlock+0x3 (idle_balance+=
0x5f)
:    #func               -1823	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
:    #func               -1823	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1823	  0.152  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1823	  0.130  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1823	  0.118  __rcu_read_lock+0x3 (idle_balance+0=
x64)
:    #func               -1823	  0.112  __rcu_read_unlock+0x4 (idle_balance=
+0xee)
:    #func               -1822	  0.112  _raw_spin_lock+0x4 (idle_balance+0x=
f5)
:    #func               -1822	  0.114  add_preempt_count+0x4 (_raw_spin_lo=
ck+0x15)
:    #func               -1822	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1822	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1822	  0.141  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1822	  0.118  put_prev_task_rt+0x5 (__schedule+0x=
275)
:    #func               -1822	  0.121  update_curr_rt+0x9 (put_prev_task_r=
t+0x14)
:    #func               -1822	  0.114  pick_next_task_fair+0x7 (__schedule=
+0x28c)
:    #func               -1821	  0.117  pick_next_task_stop+0x4 (__schedule=
+0x299)
:    #func               -1821	  0.115  pick_next_task_rt+0x5 (__schedule+0=
x299)
:    #func               -1821	  0.135  pick_next_task_fair+0x7 (__schedule=
+0x299)
:    #func               -1821	  0.133  pick_next_task_idle+0x3 (__schedule=
+0x299)
:    #func               -1821	  0.147  taskSwitchLinux+0x6 [sigmatek_lrt] =
(__schedule+0x2dc)
:    #func               -1821	  0.167  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchLinux+0x32 [sigmatek_lrt])
:    #func               -1821	  0.129  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:    #func               -1820	  0.201  rt_task_set_mode+0x7 (taskSwitchLin=
ux+0x4f [sigmatek_lrt])
:    #func               -1820	  0.141  rt_task_set_mode+0x7 (taskSwitchLin=
ux+0xbf [sigmatek_lrt])
:|   #begin   0x80000000 -1820	  0.161  __schedule+0x3a3 (schedule+0x18)
:|   #func               -1820	  0.166  __switch_to+0x9 (__schedule+0x50a)
:|   #func               -1820	  0.139  __ipipe_switch_tail+0x4 (__schedule=
+0x514)
:|   #end     0x80000000 -1820	  0.126  hard_local_irq_enable+0x16 (__ipipe=
_switch_tail+0x2e)
:|   #begin   0x80000001 -1820	  0.142  debug_smp_processor_id+0x36 (__sche=
dule+0x51d)
:|   #end     0x80000001 -1819	  0.130  debug_smp_processor_id+0x82 (__sche=
dule+0x51d)
:    #func               -1819	  0.114  finish_task_switch+0x7 (__schedule+=
0x533)
:    #func               -1819	  0.126  _raw_spin_unlock_irq+0x3 (finish_ta=
sk_switch+0x4a)
:    #func               -1819	  0.123  ipipe_unstall_root+0x3 (_raw_spin_u=
nlock_irq+0x12)
:|   #begin   0x80000000 -1819	  0.126  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1819	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1819	  0.115  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1818	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock_irq+0x1c)
:    +func               -1818	  0.120  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1818	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1818	  0.152  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   +begin   0x80000001 -1818	  0.142  debug_smp_processor_id+0x36 (__sche=
dule+0x538)
:|   +end     0x80000001 -1818	  0.130  debug_smp_processor_id+0x82 (__sche=
dule+0x538)
:    +func               -1818	  0.139  _raw_spin_lock_irqsave+0x5 (post_sc=
hedule.part.48+0xc)
:    #func               -1817	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1817	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1817	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1817	  0.154  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1817	  0.114  post_schedule_idle+0x3 (post_schedu=
le.part.48+0x22)
:    #func               -1817	  0.130  __ipipe_spin_unlock_debug+0x3 (post=
_schedule.part.48+0x29)
:    #func               -1817	  0.123  _raw_spin_unlock_irqrestore+0x4 (po=
st_schedule.part.48+0x32)
:    #func               -1817	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1816	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1816	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1816	  0.127  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1816	  0.120  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1816	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1816	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1816	  0.115  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1815	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    +func               -1815	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1815	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1815	  0.133  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1815	  0.114  sub_preempt_count+0x4 (__schedule+0=
x56c)
:    +func               -1815	  0.126  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1815	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1815	  0.161  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1814	  0.118  add_preempt_count+0x4 (schedule_pre=
empt_disabled+0x21)
:    +func               -1814	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1814	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1814	  0.175  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1814	  0.127  tick_nohz_idle_enter+0x4 (cpu_start=
up_entry+0x24)
:    +func               -1814	  0.124  set_cpu_sd_state_idle+0x4 (tick_noh=
z_idle_enter+0x37)
:|   +begin   0x80000001 -1814	  0.142  debug_smp_processor_id+0x36 (set_cp=
u_sd_state_idle+0xe)
:|   +end     0x80000001 -1813	  0.126  debug_smp_processor_id+0x82 (set_cp=
u_sd_state_idle+0xe)
:    +func               -1813	  0.117  __rcu_read_lock+0x3 (set_cpu_sd_sta=
te_idle+0x15)
:    +func               -1813	  0.138  __rcu_read_unlock+0x4 (set_cpu_sd_s=
tate_idle+0x4d)
:|   #begin   0x80000001 -1813	  0.142  debug_smp_processor_id+0x36 (tick_n=
ohz_idle_enter+0x46)
:|   #end     0x80000001 -1813	  0.127  debug_smp_processor_id+0x82 (tick_n=
ohz_idle_enter+0x46)
:    #func               -1813	  0.120  __tick_nohz_idle_enter+0x9 (tick_no=
hz_idle_enter+0x5b)
:|   #begin   0x80000001 -1813	  0.142  debug_smp_processor_id+0x36 (__tick=
_nohz_idle_enter+0x16)
:|   #end     0x80000001 -1812	  0.129  debug_smp_processor_id+0x82 (__tick=
_nohz_idle_enter+0x16)
:    #func               -1812	  0.161  ktime_get+0x9 (__tick_nohz_idle_ent=
er+0x1e)
:|   #begin   0x80000001 -1812	  0.151  debug_smp_processor_id+0x36 (sched_=
clock_idle_sleep_event+0x8)
:|   #end     0x80000001 -1812	  0.145  debug_smp_processor_id+0x82 (sched_=
clock_idle_sleep_event+0x8)
:|   #begin   0x80000001 -1812	  0.149  debug_smp_processor_id+0x36 (__cycl=
es_2_ns+0x14)
:|   #end     0x80000001 -1812	  0.149  debug_smp_processor_id+0x82 (__cycl=
es_2_ns+0x14)
:|   #begin   0x80000001 -1812	  0.142  debug_smp_processor_id+0x36 (__tick=
_nohz_idle_enter+0x3b5)
:|   #end     0x80000001 -1811	  0.141  debug_smp_processor_id+0x82 (__tick=
_nohz_idle_enter+0x3b5)
:    #func               -1811	  0.136  timekeeping_max_deferment+0x5 (__ti=
ck_nohz_idle_enter+0x108)
:    #func               -1811	  0.142  rcu_needs_cpu+0x5 (__tick_nohz_idle=
_enter+0x124)
:|   #begin   0x80000001 -1811	  0.142  debug_smp_processor_id+0x36 (irq_wo=
rk_needs_cpu+0xe)
:|   #end     0x80000001 -1811	  0.133  debug_smp_processor_id+0x82 (irq_wo=
rk_needs_cpu+0xe)
:    #func               -1811	  0.118  get_next_timer_interrupt+0x9 (__tic=
k_nohz_idle_enter+0x147)
:|   #begin   0x80000001 -1811	  0.142  debug_smp_processor_id+0x36 (get_ne=
xt_timer_interrupt+0x25)
:|   #end     0x80000001 -1811	  0.130  debug_smp_processor_id+0x82 (get_ne=
xt_timer_interrupt+0x25)
:    #func               -1810	  0.114  _raw_spin_lock+0x4 (get_next_timer_=
interrupt+0x3f)
:    #func               -1810	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck+0x15)
:    #func               -1810	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1810	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1810	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1810	  0.127  _raw_spin_unlock+0x3 (get_next_time=
r_interrupt+0x158)
:    #func               -1810	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
:    #func               -1809	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1809	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1809	  0.145  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1809	  0.123  hrtimer_get_next_event+0x9 (get_nex=
t_timer_interrupt+0x162)
:|   #begin   0x80000001 -1809	  0.142  debug_smp_processor_id+0x36 (hrtime=
r_get_next_event+0x18)
:|   #end     0x80000001 -1809	  0.127  debug_smp_processor_id+0x82 (hrtime=
r_get_next_event+0x18)
:    #func               -1809	  0.142  _raw_spin_lock_irqsave+0x5 (hrtimer=
_get_next_event+0x26)
:    #func               -1809	  0.114  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1808	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1808	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1808	  0.141  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1808	  0.117  __ipipe_spin_unlock_debug+0x3 (hrti=
mer_get_next_event+0x97)
:    #func               -1808	  0.123  _raw_spin_unlock_irqrestore+0x4 (hr=
timer_get_next_event+0xa0)
:    #func               -1808	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1808	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1807	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1807	  0.151  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1807	  0.115  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func               -1807	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1807	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1807	  0.170  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1807	  0.130  nohz_balance_enter_idle+0x3 (__tick=
_nohz_idle_enter+0x24a)
:    #func               -1806	  0.123  calc_load_enter_idle+0x4 (__tick_no=
hz_idle_enter+0x24f)
:|   #begin   0x80000001 -1806	  0.142  debug_smp_processor_id+0x36 (calc_l=
oad_enter_idle+0x13)
:|   #end     0x80000001 -1806	  0.132  debug_smp_processor_id+0x82 (calc_l=
oad_enter_idle+0x13)
:    #func               -1806	  0.115  hrtimer_start+0x3 (__tick_nohz_idle=
_enter+0x2e1)
:    #func               -1806	  0.117  __hrtimer_start_range_ns+0x9 (hrtim=
er_start+0x14)
:    #func               -1806	  0.114  lock_hrtimer_base.isra.17+0x6 (__hr=
timer_start_range_ns+0x23)
:    #func               -1806	  0.141  _raw_spin_lock_irqsave+0x5 (lock_hr=
timer_base.isra.17+0x1c)
:    #func               -1806	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1805	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1805	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1805	  0.151  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001 -1805	  0.148  debug_smp_processor_id+0x36 (remove=
_hrtimer.part.15+0x1f)
:|   #end     0x80000001 -1805	  0.127  debug_smp_processor_id+0x82 (remove=
_hrtimer.part.15+0x1f)
:    #func               -1805	  0.124  __remove_hrtimer+0x9 (remove_hrtime=
r.part.15+0x3e)
:    #func               -1805	  0.132  hrtimer_force_reprogram+0x9 (__remo=
ve_hrtimer+0x64)
:|   #begin   0x80000001 -1805	  0.141  debug_smp_processor_id+0x36 (__hrti=
mer_start_range_ns+0x46)
:|   #end     0x80000001 -1804	  0.138  debug_smp_processor_id+0x82 (__hrti=
mer_start_range_ns+0x46)
:    #func               -1804	  0.115  ktime_add_safe+0x6 (hrtimer_set_exp=
ires_range_ns+0x21)
:    #func               -1804	  0.135  enqueue_hrtimer+0x6 (__hrtimer_star=
t_range_ns+0x155)
:|   #begin   0x80000001 -1804	  0.142  debug_smp_processor_id+0x36 (__hrti=
mer_start_range_ns+0x16d)
:|   #end     0x80000001 -1804	  0.136  debug_smp_processor_id+0x82 (__hrti=
mer_start_range_ns+0x16d)
:|   #begin   0x80000001 -1804	  0.142  debug_smp_processor_id+0x36 (__hrti=
mer_start_range_ns+0x192)
:|   #end     0x80000001 -1804	  0.133  debug_smp_processor_id+0x82 (__hrti=
mer_start_range_ns+0x192)
:    #func               -1803	  0.115  tick_program_event+0x4 (__hrtimer_s=
tart_range_ns+0x20a)
:    #func               -1803	  0.121  clockevents_program_event+0x9 (tick=
_program_event+0x24)
:    #func               -1803	  0.149  ktime_get+0x9 (clockevents_program_=
event+0x7a)
:    #func               -1803	  0.120  xnarch_next_htick_shot+0x5 (clockev=
ents_program_event+0xeb)
:|   #begin   0x80000000 -1803	  0.164  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  *#func               -1803	  0.127  xntimer_start_aperiodic+0x9 (xnarch=
_next_htick_shot+0x33)
:|  *#func               -1803	  0.141  xnarch_ns_to_tsc+0x6 (xntimer_start=
_aperiodic+0x67)
:|  *#func               -1802	  0.127  xntimer_next_local_shot+0x9 (xntime=
r_start_aperiodic+0x11a)
:|  *#event   tick@732804-1802	  0.117  xntimer_next_local_shot+0xca (xntim=
er_start_aperiodic+0x11a)
:|  *#func               -1802	  0.136  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  *#func               -1802	  0.242  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  *#func               -1802	  0.133  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|   #end     0x80000000 -1802	  0.147  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:    #func               -1802	  0.117  __ipipe_spin_unlock_debug+0x3 (unlo=
ck_hrtimer_base.isra.18+0x10)
:    #func               -1801	  0.127  _raw_spin_unlock_irqrestore+0x4 (un=
lock_hrtimer_base.isra.18+0x1b)
:    #func               -1801	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1801	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1801	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1801	  0.149  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1801	  0.115  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func               -1801	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1801	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1800	  0.152  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1800	  0.120  ipipe_unstall_root+0x3 (tick_nohz_i=
dle_enter+0x60)
:|   #begin   0x80000000 -1800	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1800	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1800	  0.130  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:|   +begin   0x80000001 -1800	  0.142  debug_smp_processor_id+0x36 (cpu_st=
artup_entry+0x33)
:|   +end     0x80000001 -1800	  0.151  debug_smp_processor_id+0x82 (cpu_st=
artup_entry+0x33)
:    #func               -1799	  0.114  arch_cpu_idle_enter+0x3 (cpu_startu=
p_entry+0x59)
:    #func               -1799	  0.121  local_touch_nmi+0x3 (arch_cpu_idle_=
enter+0xd)
:    #func               -1799	  0.147  rcu_idle_enter+0x5 (cpu_startup_ent=
ry+0x70)
:|   #begin   0x80000001 -1799	  0.151  debug_smp_processor_id+0x36 (rcu_id=
le_enter+0x1b)
:|   #end     0x80000001 -1799	  0.130  debug_smp_processor_id+0x82 (rcu_id=
le_enter+0x1b)
:    #func               -1799	  0.121  rcu_eqs_enter_common.isra.49+0x6 (r=
cu_idle_enter+0x76)
:|   #begin   0x80000001 -1799	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_enter_common.isra.49+0x7d)
:|   #end     0x80000001 -1798	  0.139  debug_smp_processor_id+0x82 (rcu_eq=
s_enter_common.isra.49+0x7d)
:    #func               -1798	  0.114  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1798	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1798	  0.173  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1798	  0.157  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001 -1798	  0.151  debug_smp_processor_id+0x36 (cpu_st=
artup_entry+0x75)
:|   #end     0x80000001 -1798	  0.129  debug_smp_processor_id+0x82 (cpu_st=
artup_entry+0x75)
:    #func               -1797	  0.121  ipipe_unstall_root+0x3 (cpu_startup=
_entry+0x8d)
:|   #begin   0x80000000 -1797	  0.126  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1797	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1797! 728.901  hard_local_irq_enable+0x16 (ipipe_=
unstall_root+0x2b)
:|   +begin   0x00000051 -1068	  0.173  common_interrupt+0x39 (need_resched=
+0x0)
:|   +func               -1068	  0.151  __ipipe_handle_irq+0x7 (common_inte=
rrupt+0x40)
:|   +func               -1068	  0.124  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -1068	  0.246  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func               -1067	  0.164  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -1067	  0.135  irq_to_desc+0x3 (__ipipe_dispatch_i=
rq+0x26)
:|   +func               -1067	  0.155  irq_to_desc+0x3 (__ipipe_dispatch_i=
rq+0x216)
:|   +func               -1067	  0.118  __ipipe_ack_fasteoi_irq+0x3 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -1067	  0.121  hold_ioapic_irq+0x4 (__ipipe_ack_fa=
steoi_irq+0x10)
:|   +func               -1067	  0.120  io_apic_modify_irq.isra.9+0x7 (hold=
_ioapic_irq+0x41)
:|   +func               -1067	  0.115  native_io_apic_read+0x4 (io_apic_re=
ad+0x9)
:|   +func               -1066+   1.348  io_apic_base+0x3 (native_io_apic_r=
ead+0x10)
:|   +func               -1065	  0.117  native_io_apic_modify+0x5 (io_apic_=
modify_irq.isra.9+0x36)
:|   +func               -1065	  0.132  io_apic_base+0x3 (native_io_apic_mo=
dify+0x13)
:|   +func               -1065	  0.130  io_apic_sync+0x3 (io_apic_modify_ir=
q.isra.9+0x41)
:|   +func               -1065+   1.161  io_apic_base+0x3 (io_apic_sync+0xf)
:|   +func               -1064	  0.167  ack_apic_level+0x5 (hold_ioapic_irq=
+0x50)
:|   +func               -1063	  0.130  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   +func               -1063	  0.210  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1063	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1063	  0.170  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1063	  0.142  xnintr_irq_handler+0x9 (__ipipe_dis=
patch_irq+0x182)
:|  # func               -1063	  0.120  irqhandler_fpga+0x9 [sigmatek_lrt] =
(xnintr_irq_handler+0x78)
:|  # func               -1063	  0.161  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x5a [sigmatek_lrt])
:|  # func               -1062+   1.642  ___xnpod_lock_sched+0x4 (__xnpod_l=
ock_sched+0x19 [sigmatek_lrt])
:|  # func               -1061	  0.155  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0xe6 [sigmatek_lrt])
:|  # func               -1061+   4.591  lrtdrv_monitoring_irq+0x4 [sigmate=
k_lrt] (irqhandler_fpga+0x13d [sigmatek_lrt])
:|  # func               -1056	  0.144  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x1a4 [sigmatek_lrt])
:|  # func               -1056	  0.184  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x1d2 [sigmatek_lrt])
:|  # func               -1056	  0.148  xnarch_tsc_to_ns+0x6 (irqhandler_fp=
ga+0x1e8 [sigmatek_lrt])
:|  # func               -1056	  0.115  xnarch_get_cpu_time+0x4 (irqhandler=
_fpga+0x225 [sigmatek_lrt])
:|  # func               -1055	  0.120  xnarch_tsc_to_ns+0x6 (xnarch_get_cp=
u_time+0x13)
:|  # func               -1055	  0.148  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x245 [sigmatek_lrt])
:|  # func               -1055	  0.120  xnarch_tsc_to_ns+0x6 (irqhandler_fp=
ga+0x25b [sigmatek_lrt])
:|  # func               -1055	  0.144  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x280 [sigmatek_lrt])
:|  # func               -1055	  0.120  period_update+0x4 [sigmatek_lrt] (i=
rqhandler_fpga+0x287 [sigmatek_lrt])
:|  # func               -1055	  0.163  lrtdrv_monitoring_start_timed+0x4 [=
sigmatek_lrt] (period_update+0x1f [sigmatek_lrt])
:|  # func               -1055	  0.216  rtdm_event_signal+0x5 (period_updat=
e+0xd9 [sigmatek_lrt])
:|  # func               -1054	  0.215  xnsynch_flush+0x9 (rtdm_event_signa=
l+0x25)
:|  # func               -1054	  0.149  __rtdm_synch_flush+0x6 (period_upda=
te+0xe3 [sigmatek_lrt])
:|  # func               -1054	  0.218  xnsynch_flush+0x9 (__rtdm_synch_flu=
sh+0x2f)
:|  # func               -1054	  0.155  rtdm_event_signal+0x5 (period_updat=
e+0xd9 [sigmatek_lrt])
:|  # func               -1054	  0.169  xnsynch_flush+0x9 (rtdm_event_signa=
l+0x25)
:|  # func               -1053	  0.141  xnpod_resume_thread+0x9 (xnsynch_fl=
ush+0x47)
:|  # [  584] realtim 95 -1053	  0.227  xnpod_resume_thread+0x39 (xnsynch_f=
lush+0x47)
:|  # func               -1053	  0.145  __rtdm_synch_flush+0x6 (period_upda=
te+0xe3 [sigmatek_lrt])
:|  # func               -1053	  0.158  xnsynch_flush+0x9 (__rtdm_synch_flu=
sh+0x2f)
:|  # func               -1053	  0.160  xnpod_resume_thread+0x9 (xnsynch_fl=
ush+0x47)
:|  # [  467] VARAN_T 30 -1053	  0.236  xnpod_resume_thread+0x39 (xnsynch_f=
lush+0x47)
:|  # func               -1052	  0.133  xnpod_resume_thread+0x9 (xnsynch_fl=
ush+0x47)
:|  # [  582] cyclic: 30 -1052	  0.155  xnpod_resume_thread+0x39 (xnsynch_f=
lush+0x47)
:|  # func               -1052	  0.133  xnpod_resume_thread+0x9 (xnsynch_fl=
ush+0x47)
:|  # [  580] Loader: 29 -1052	  0.239  xnpod_resume_thread+0x39 (xnsynch_f=
lush+0x47)
:|  # func               -1052	  0.115  ipipe_raise_irq+0x8 (period_update+=
0x10f [sigmatek_lrt])
:|  # func               -1052	  0.112  irq_hook_handler+0x5 [sigmatek_lrt]=
 (ipipe_raise_irq+0x36)
:|  # func               -1051	  0.145  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1051	  0.130  __ipipe_handle_irq+0x7 (ipipe_raise=
_irq+0x3e)
:|  # func               -1051	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|  # func               -1051	  0.155  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1051	  0.136  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|  # func               -1051	  0.112  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x1db)
:|  # func               -1051	  0.151  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1051	  0.184  __ipipe_set_irq_pending+0x6 (__ipip=
e_dispatch_irq+0x1e4)
:|  # func               -1050	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|  # func               -1050	  0.191  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1050+   1.657  ___xnpod_unlock_sched+0x3 (__xnpod=
_unlock_sched+0x19 [sigmatek_lrt])
:|  # func               -1048+   1.634  ___xnpod_lock_sched+0x4 (__xnpod_l=
ock_sched+0x19 [sigmatek_lrt])
:|  # func               -1047	  0.152  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0xe6 [sigmatek_lrt])
:|  # func               -1047	  0.123  ___xnpod_unlock_sched+0x3 (__xnpod_=
unlock_sched+0x19 [sigmatek_lrt])
:|  # func               -1046	  0.194  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x10d [sigmatek_lrt])
:|  # func               -1046	  0.115  rthal_irq_end+0x5 (xnintr_irq_handl=
er+0x14d)
:|  # func               -1046	  0.123  irq_to_desc+0x3 (rthal_irq_end+0x1d)
:|  # func               -1046	  0.120  irq_to_desc+0x3 (rthal_irq_end+0x28)
:|  # func               -1046	  0.120  irq_to_desc+0x3 (rthal_irq_end+0x32)
:|  # func               -1046	  0.115  __ipipe_end_fasteoi_irq+0x3 (rthal_=
irq_end+0x38)
:|  # func               -1046	  0.115  release_ioapic_irq+0x5 (__ipipe_end=
_fasteoi_irq+0x16)
:|  # func               -1046	  0.152  __ipipe_spin_lock_irqsave+0x6 (rele=
ase_ioapic_irq+0x17)
:|  # func               -1045	  0.114  io_apic_modify_irq.isra.9+0x7 (rele=
ase_ioapic_irq+0x29)
:|  # func               -1045	  0.114  native_io_apic_read+0x4 (io_apic_re=
ad+0x9)
:|  # func               -1045+   1.346  io_apic_base+0x3 (native_io_apic_r=
ead+0x10)
:|  # func               -1044	  0.111  native_io_apic_modify+0x5 (io_apic_=
modify_irq.isra.9+0x36)
:|  # func               -1044	  0.123  io_apic_base+0x3 (native_io_apic_mo=
dify+0x13)
:|  # func               -1044	  0.201  __ipipe_spin_unlock_irqrestore+0x4 =
(release_ioapic_irq+0x35)
:|  # func               -1043	  0.175  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [   23] gatekee -1 -1043	  0.147  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1043	  0.142  ipipe_send_ipi+0x6 (__xnpod_schedul=
e+0x7d)
:|  # func               -1043	  0.178  default_send_IPI_mask_logical+0x6 (=
ipipe_send_ipi+0x40)
:|  # func               -1043	  0.149  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1043	  0.295  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -1042	  0.325  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  584] realtim 95 -1042	  0.193  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1042	  0.133  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1042	  0.151  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1042	  0.405  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1041	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1041	  0.178  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:   + func               -1041	  0.117  lrtdrv_timing_watchdog+0x6 [sigmate=
k_lrt] (lrt_ioctl_work+0x4ea [sigmatek_lrt])
:   + func               -1041	  0.117  setup_watchdog+0x6 [sigmatek_lrt] (=
lrtdrv_timing_watchdog+0x46 [sigmatek_lrt])
:   + func               -1041	  0.129  rt_task_self+0x3 (setup_watchdog+0x=
42 [sigmatek_lrt])
:   + func               -1040	  0.270  __copy_to_user_ll+0x6 (lrt_ioctl_wo=
rk+0x52e [sigmatek_lrt])
:|  + begin   0x80000001 -1040	  0.172  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1040	  0.151  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1040	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1040!  18.755  __ipipe_syscall_root+0x70 (sysente=
r_past_esp+0x5b)
:   + func               -1021	  0.120  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1021	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1021	  0.188  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1021	  0.126  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1020	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1020	  0.144  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1020	  0.201  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1020	  0.144  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1020	  0.120  sys_rtdm_ioctl+0x3 (hisyscall_event=
+0x129)
:   + func               -1020	  0.114  __rt_dev_ioctl+0x9 (sys_rtdm_ioctl+=
0x1d)
:   + func               -1020	  0.121  rtdm_context_get+0x6 (__rt_dev_ioct=
l+0x24)
:|  + begin   0x80000000 -1019	  0.262  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  # func               -1019	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1019	  0.124  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1019	  0.142  rtdm_in_rt_context+0x1d (__rt_dev_i=
octl+0x36)
:|  + end     0x80000001 -1019	  0.129  rtdm_in_rt_context+0x67 (__rt_dev_i=
octl+0x36)
:   + func               -1019	  0.117  lrt_ioctl+0x3 [sigmatek_lrt] (__rt_=
dev_ioctl+0x46)
:   + func               -1018	  0.142  lrt_ioctl_work+0xc [sigmatek_lrt] (=
lrt_ioctl+0x10 [sigmatek_lrt])
:   + func               -1018	  0.175  pci_locker_signal_stop+0x3 [sigmate=
k_lrt] (lrt_ioctl_work+0x768 [sigmatek_lrt])
:|  + begin   0x80000001 -1018	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1018	  0.132  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1018	  0.160  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1018	  0.628  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1017	  0.117  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1017	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1017	  0.242  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1017	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1016	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1016	  0.145  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1016	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1016	  0.126  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1016	  0.117  sys_rtdm_ioctl+0x3 (hisyscall_event=
+0x129)
:   + func               -1016	  0.115  __rt_dev_ioctl+0x9 (sys_rtdm_ioctl+=
0x1d)
:   + func               -1016	  0.121  rtdm_context_get+0x6 (__rt_dev_ioct=
l+0x24)
:|  + begin   0x80000000 -1016	  0.203  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  # func               -1015	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1015	  0.123  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1015	  0.145  rtdm_in_rt_context+0x1d (__rt_dev_i=
octl+0x36)
:|  + end     0x80000001 -1015	  0.126  rtdm_in_rt_context+0x67 (__rt_dev_i=
octl+0x36)
:   + func               -1015	  0.118  lrt_ioctl+0x3 [sigmatek_lrt] (__rt_=
dev_ioctl+0x46)
:   + func               -1015	  0.120  lrt_ioctl_work+0xc [sigmatek_lrt] (=
lrt_ioctl+0x10 [sigmatek_lrt])
:   + func               -1015	  0.151  __copy_from_user_ll_nozero+0x6 (rtd=
m_safe_copy_from_user.isra.4+0x23 [sigmatek_lrt])
:   + func               -1014	  0.124  lrtdrv_timing_watchdog+0x6 [sigmate=
k_lrt] (lrt_ioctl_work+0x4a2 [sigmatek_lrt])
:   + func               -1014	  0.117  setup_watchdog+0x6 [sigmatek_lrt] (=
lrtdrv_timing_watchdog+0x46 [sigmatek_lrt])
:   + func               -1014	  0.121  rt_task_self+0x3 (setup_watchdog+0x=
42 [sigmatek_lrt])
:   + func               -1014	  0.132  lrtdrv_timing_wait+0x9 [sigmatek_lr=
t] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:|  + begin   0x80000001 -1014	  0.163  lrtdrv_timing_wait+0x39 [sigmatek_l=
rt] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:|  + end     0x80000001 -1014	  0.127  lrtdrv_timing_wait+0x85 [sigmatek_l=
rt] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:   + func               -1014	  0.118  rtdm_event_wait+0x3 (lrtdrv_timing_=
wait+0xdc [sigmatek_lrt])
:   + func               -1014	  0.121  rtdm_event_timedwait+0x9 (rtdm_even=
t_wait+0x13)
:|  + begin   0x80000000 -1013	  0.213  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.14+0x9)
:|  # func               -1013	  0.158  xnsynch_sleep_on+0x9 (rtdm_event_ti=
medwait+0x8e)
:|  # func               -1013	  0.155  xnpod_suspend_thread+0x9 (xnsynch_s=
leep_on+0x8b)
:|  # func               -1013	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  584] realtim 95 -1013	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1013	  0.294  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1012	  0.400  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  582] cyclic: 30 -1012	  0.184  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1012	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1012	  0.142  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1011	  0.402  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1011	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1011	  0.161  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:   + func               -1011	  0.118  lrtdrv_timing_watchdog+0x6 [sigmate=
k_lrt] (lrt_ioctl_work+0x4ea [sigmatek_lrt])
:   + func               -1011	  0.118  setup_watchdog+0x6 [sigmatek_lrt] (=
lrtdrv_timing_watchdog+0x46 [sigmatek_lrt])
:   + func               -1011	  0.121  rt_task_self+0x3 (setup_watchdog+0x=
42 [sigmatek_lrt])
:   + func               -1010	  0.231  __copy_to_user_ll+0x6 (lrt_ioctl_wo=
rk+0x52e [sigmatek_lrt])
:|  + begin   0x80000001 -1010	  0.179  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1010	  0.147  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1010	  0.160  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1010+   1.202  __ipipe_syscall_root+0x70 (sysente=
r_past_esp+0x5b)
:   + func               -1009	  0.115  __ipipe_syscall_root+0x5 (system_ca=
ll+0x30)
:   + func               -1008	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1008	  0.188  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1008	  0.124  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1008	  0.121  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1008	  0.144  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1008	  0.127  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1008	  0.147  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1007	  0.120  xnshadow_relax+0xc (hisyscall_event=
+0x201)
:|  + begin   0x80000000 -1007	  0.148  hard_local_irq_disable+0x15 (xnshad=
ow_relax+0x30)
:|  # func               -1007	  0.209  rpi_push+0x9 (xnshadow_relax+0x4d)
:|  # func               -1007	  0.144  xnsched_renice_root+0x7 (rpi_push+0=
x8e)
:|  # func               -1007	  0.139  xnsched_track_policy+0x6 (xnsched_r=
enice_root+0x6a)
:|  # [    0] -<?>-   30 -1007	  0.151  xnsched_renice_root+0x82 (rpi_push+=
0x8e)
:|  # func               -1007	  0.145  schedule_linux_call+0x9 (xnshadow_r=
elax+0x5b)
:|  # func               -1006	  0.200  __ipipe_set_irq_pending+0x6 (schedu=
le_linux_call+0x83)
:|  # func               -1006	  0.184  xnpod_suspend_thread+0x9 (xnshadow_=
relax+0x8c)
:|  # func               -1006	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1006	  0.123  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000000 -1006	  0.148  hard_local_irq_disable+0x15 (xnpod_=
suspend_thread+0x17d)
:|  # func               -1006	  0.173  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  582] cyclic: 30 -1005	  0.121  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1005	  0.270  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1005	  0.316  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   30 -1005	  0.198  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1004	  0.118  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1004	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1004	  0.175  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1004	  0.341  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -1004	  0.194  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -1004	  0.148  __ipipe_do_sync_stage+0x9 (__ipipe_=
do_sync_pipeline+0x5e)
:|   #end     0x80000000 -1003	  0.115  hard_local_irq_enable+0x16 (__ipipe=
_do_sync_stage+0xa1)
:    #func               -1003	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_do_sync_stage+0xe4)
:    #func               -1003	  0.149  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:    #func               -1003	  0.118  irq_enter+0x4 (__ipipe_do_sync_stag=
e+0xe9)
:|   #begin   0x80000001 -1003	  0.142  debug_smp_processor_id+0x36 (irq_en=
ter+0xe)
:|   #end     0x80000001 -1003	  0.129  debug_smp_processor_id+0x82 (irq_en=
ter+0xe)
:    #func               -1003	  0.148  rcu_irq_enter+0x7 (irq_enter+0x15)
:|   #begin   0x80000001 -1002	  0.145  debug_smp_processor_id+0x36 (rcu_ir=
q_enter+0x1e)
:|   #end     0x80000001 -1002	  0.129  debug_smp_processor_id+0x82 (rcu_ir=
q_enter+0x1e)
:    #func               -1002	  0.133  rcu_eqs_exit_common.isra.47+0x5 (rc=
u_irq_enter+0x70)
:|   #begin   0x80000001 -1002	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_exit_common.isra.47+0x41)
:|   #end     0x80000001 -1002	  0.129  debug_smp_processor_id+0x82 (rcu_eq=
s_exit_common.isra.47+0x41)
:    #func               -1002	  0.114  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1002	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1002	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1001	  0.154  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1001	  0.117  local_bh_disable+0x3 (irq_enter+0x3=
9)
:    #func               -1001	  0.115  add_preempt_count+0x4 (local_bh_dis=
able+0x12)
:    #func               -1001	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1001	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1001	  0.138  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1001	  0.112  tick_check_idle+0x8 (irq_enter+0x40)
:    #func               -1000	  0.160  tick_check_oneshot_broadcast+0x3 (t=
ick_check_idle+0x19)
:    #func               -1000	  0.213  ktime_get+0x9 (tick_check_idle+0x31)
:    #func               -1000	  0.115  tick_nohz_stop_idle+0x4 (tick_check=
_idle+0x48)
:    #func               -1000	  0.115  update_ts_time_stats+0x9 (tick_nohz=
_stop_idle+0x20)
:    #func               -1000	  0.138  nr_iowait_cpu+0x3 (update_ts_time_s=
tats+0x31)
:|   #begin   0x80000001 -1000	  0.142  debug_smp_processor_id+0x36 (tick_c=
heck_idle+0x53)
:|   #end     0x80000001 -1000	  0.158  debug_smp_processor_id+0x82 (tick_c=
heck_idle+0x53)
:    #func                -999	  0.115  tick_do_update_jiffies64+0x9 (tick_=
check_idle+0x84)
:    #func                -999	  0.114  ipipe_restore_root+0x4 (tick_check_=
idle+0x97)
:    #func                -999	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -999	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -999	  0.152  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -999	  0.112  _local_bh_enable+0x3 (irq_enter+0x4=
5)
:    #func                -999	  0.139  __local_bh_enable+0x4 (_local_bh_en=
able+0x12)
:    #func                -999	  0.115  sub_preempt_count+0x4 (__local_bh_e=
nable+0x6a)
:    #func                -998	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -998	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -998	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -998	  0.118  add_preempt_count+0x4 (irq_enter+0x=
4f)
:    #func                -998	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -998	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -998	  0.147  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -997	  0.118  wait_domain_nrt_handler+0x3 [sigmat=
ek_lrt] (__ipipe_do_sync_stage+0xff)
:    #func                -997	  0.115  __wake_up+0x8 (wait_domain_nrt_hand=
ler+0x33 [sigmatek_lrt])
:    #func                -997	  0.141  _raw_spin_lock_irqsave+0x5 (__wake_=
up+0x1a)
:    #func                -997	  0.121  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func                -997	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -997	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -997	  0.170  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -996	  0.118  __wake_up_common+0x9 (__wake_up+0x2=
e)
:    #func                -996	  0.117  ipipe_root_only+0x5 (__wake_up_comm=
on+0x1b)
:|   #begin   0x80000001  -996	  0.184  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -996	  0.130  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -996	  0.112  __ipipe_spin_unlock_debug+0x3 (__wa=
ke_up+0x35)
:    #func                -996	  0.126  _raw_spin_unlock_irqrestore+0x4 (__=
wake_up+0x3e)
:    #func                -996	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -996	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -995	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -995	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -995	  0.114  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func                -995	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -995	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -995	  0.136  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -995	  0.127  irq_exit+0x3 (__ipipe_do_sync_stage=
+0x104)
:    #func                -994	  0.115  sub_preempt_count+0x4 (irq_exit+0x1=
7)
:    #func                -994	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -994	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -994	  0.158  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001  -994	  0.144  debug_smp_processor_id+0x36 (irq_ex=
it+0x4b)
:|   #end     0x80000001  -994	  0.126  debug_smp_processor_id+0x82 (irq_ex=
it+0x4b)
:    #func                -994	  0.148  idle_cpu+0x3 (irq_exit+0x50)
:    #func                -994	  0.123  tick_nohz_irq_exit+0x4 (irq_exit+0x=
79)
:|   #begin   0x80000001  -993	  0.152  debug_smp_processor_id+0x36 (tick_n=
ohz_irq_exit+0x13)
:|   #end     0x80000001  -993	  0.129  debug_smp_processor_id+0x82 (tick_n=
ohz_irq_exit+0x13)
:    #func                -993	  0.120  __tick_nohz_idle_enter+0x9 (tick_no=
hz_irq_exit+0x27)
:|   #begin   0x80000001  -993	  0.142  debug_smp_processor_id+0x36 (__tick=
_nohz_idle_enter+0x16)
:|   #end     0x80000001  -993	  0.127  debug_smp_processor_id+0x82 (__tick=
_nohz_idle_enter+0x16)
:    #func                -993	  0.155  ktime_get+0x9 (__tick_nohz_idle_ent=
er+0x1e)
:|   #begin   0x80000001  -993	  0.152  debug_smp_processor_id+0x36 (sched_=
clock_idle_sleep_event+0x8)
:|   #end     0x80000001  -992	  0.145  debug_smp_processor_id+0x82 (sched_=
clock_idle_sleep_event+0x8)
:|   #begin   0x80000001  -992	  0.142  debug_smp_processor_id+0x36 (__cycl=
es_2_ns+0x14)
:|   #end     0x80000001  -992	  0.169  debug_smp_processor_id+0x82 (__cycl=
es_2_ns+0x14)
:|   #begin   0x80000001  -992	  0.142  debug_smp_processor_id+0x36 (__tick=
_nohz_idle_enter+0x3b5)
:|   #end     0x80000001  -992	  0.190  debug_smp_processor_id+0x82 (__tick=
_nohz_idle_enter+0x3b5)
:    #func                -992	  0.133  timekeeping_max_deferment+0x5 (__ti=
ck_nohz_idle_enter+0x108)
:    #func                -991	  0.145  rcu_needs_cpu+0x5 (__tick_nohz_idle=
_enter+0x124)
:|   #begin   0x80000001  -991	  0.142  debug_smp_processor_id+0x36 (irq_wo=
rk_needs_cpu+0xe)
:|   #end     0x80000001  -991	  0.130  debug_smp_processor_id+0x82 (irq_wo=
rk_needs_cpu+0xe)
:    #func                -991	  0.120  get_next_timer_interrupt+0x9 (__tic=
k_nohz_idle_enter+0x147)
:|   #begin   0x80000001  -991	  0.142  debug_smp_processor_id+0x36 (get_ne=
xt_timer_interrupt+0x25)
:|   #end     0x80000001  -991	  0.129  debug_smp_processor_id+0x82 (get_ne=
xt_timer_interrupt+0x25)
:    #func                -991	  0.114  _raw_spin_lock+0x4 (get_next_timer_=
interrupt+0x3f)
:    #func                -991	  0.114  add_preempt_count+0x4 (_raw_spin_lo=
ck+0x15)
:    #func                -990	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -990	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -990	  0.147  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -990	  0.142  _raw_spin_unlock+0x3 (get_next_time=
r_interrupt+0x158)
:    #func                -990	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
:    #func                -990	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -990	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -989	  0.145  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -989	  0.120  hrtimer_get_next_event+0x9 (get_nex=
t_timer_interrupt+0x162)
:|   #begin   0x80000001  -989	  0.142  debug_smp_processor_id+0x36 (hrtime=
r_get_next_event+0x18)
:|   #end     0x80000001  -989	  0.127  debug_smp_processor_id+0x82 (hrtime=
r_get_next_event+0x18)
:    #func                -989	  0.142  _raw_spin_lock_irqsave+0x5 (hrtimer=
_get_next_event+0x26)
:    #func                -989	  0.114  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func                -989	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -989	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -988	  0.141  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -988	  0.117  __ipipe_spin_unlock_debug+0x3 (hrti=
mer_get_next_event+0x97)
:    #func                -988	  0.123  _raw_spin_unlock_irqrestore+0x4 (hr=
timer_get_next_event+0xa0)
:    #func                -988	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -988	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -988	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -988	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -987	  0.115  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func                -987	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -987	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -987	  0.172  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -987	  0.151  rcu_irq_exit+0x5 (irq_exit+0x7e)
:|   #begin   0x80000001  -987	  0.141  debug_smp_processor_id+0x36 (rcu_ir=
q_exit+0x1b)
:|   #end     0x80000001  -987	  0.130  debug_smp_processor_id+0x82 (rcu_ir=
q_exit+0x1b)
:    #func                -986	  0.120  rcu_eqs_enter_common.isra.49+0x6 (r=
cu_irq_exit+0x68)
:|   #begin   0x80000001  -986	  0.151  debug_smp_processor_id+0x36 (rcu_eq=
s_enter_common.isra.49+0x7d)
:|   #end     0x80000001  -986	  0.141  debug_smp_processor_id+0x82 (rcu_eq=
s_enter_common.isra.49+0x7d)
:    #func                -986	  0.112  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -986	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -986	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -986	  0.155  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -986	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_do_sync_stage+0x117)
:    #func                -985	  0.145  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   #begin   0x80000000  -985	  0.163  hard_local_irq_disable+0x17 (__ipip=
e_do_sync_stage+0x11c)
:|   #end     0x80000000  -985	  0.114  hard_local_irq_enable+0x16 (__ipipe=
_do_sync_stage+0xa1)
:    #func                -985	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_do_sync_stage+0xe4)
:    #func                -985	  0.144  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:    #func                -985	  0.118  irq_enter+0x4 (__ipipe_do_sync_stag=
e+0xe9)
:|   #begin   0x80000001  -985	  0.142  debug_smp_processor_id+0x36 (irq_en=
ter+0xe)
:|   #end     0x80000001  -984	  0.127  debug_smp_processor_id+0x82 (irq_en=
ter+0xe)
:    #func                -984	  0.147  rcu_irq_enter+0x7 (irq_enter+0x15)
:|   #begin   0x80000001  -984	  0.142  debug_smp_processor_id+0x36 (rcu_ir=
q_enter+0x1e)
:|   #end     0x80000001  -984	  0.129  debug_smp_processor_id+0x82 (rcu_ir=
q_enter+0x1e)
:    #func                -984	  0.135  rcu_eqs_exit_common.isra.47+0x5 (rc=
u_irq_enter+0x70)
:|   #begin   0x80000001  -984	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_exit_common.isra.47+0x41)
:|   #end     0x80000001  -984	  0.129  debug_smp_processor_id+0x82 (rcu_eq=
s_exit_common.isra.47+0x41)
:    #func                -983	  0.115  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -983	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -983	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -983	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -983	  0.114  local_bh_disable+0x3 (irq_enter+0x3=
9)
:    #func                -983	  0.115  add_preempt_count+0x4 (local_bh_dis=
able+0x12)
:    #func                -983	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -983	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -982	  0.132  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -982	  0.114  tick_check_idle+0x8 (irq_enter+0x40)
:    #func                -982	  0.117  tick_check_oneshot_broadcast+0x3 (t=
ick_check_idle+0x19)
:    #func                -982	  0.147  ktime_get+0x9 (tick_check_idle+0x31)
:    #func                -982	  0.117  tick_nohz_stop_idle+0x4 (tick_check=
_idle+0x48)
:    #func                -982	  0.114  update_ts_time_stats+0x9 (tick_nohz=
_stop_idle+0x20)
:    #func                -982	  0.129  nr_iowait_cpu+0x3 (update_ts_time_s=
tats+0x31)
:|   #begin   0x80000001  -982	  0.142  debug_smp_processor_id+0x36 (tick_c=
heck_idle+0x53)
:|   #end     0x80000001  -981	  0.157  debug_smp_processor_id+0x82 (tick_c=
heck_idle+0x53)
:    #func                -981	  0.115  tick_do_update_jiffies64+0x9 (tick_=
check_idle+0x84)
:    #func                -981	  0.114  ipipe_restore_root+0x4 (tick_check_=
idle+0x97)
:    #func                -981	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -981	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -981	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -981	  0.115  _local_bh_enable+0x3 (irq_enter+0x4=
5)
:    #func                -981	  0.130  __local_bh_enable+0x4 (_local_bh_en=
able+0x12)
:    #func                -980	  0.114  sub_preempt_count+0x4 (__local_bh_e=
nable+0x6a)
:    #func                -980	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -980	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -980	  0.141  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -980	  0.117  add_preempt_count+0x4 (irq_enter+0x=
4f)
:    #func                -980	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -980	  0.169  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -979	  0.145  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -979	  0.167  rthal_apc_handler+0x6 (__ipipe_do_s=
ync_stage+0xff)
:    #func                -979	  0.123  lostage_handler+0xc (rthal_apc_hand=
ler+0x6b)
:|   #begin   0x80000001  -979	  0.142  debug_smp_processor_id+0x36 (lostag=
e_handler+0x16)
:|   #end     0x80000001  -979	  0.149  debug_smp_processor_id+0x82 (lostag=
e_handler+0x16)
:    #func                -979	  0.117  xnsched_renice_root+0x7 (lostage_ha=
ndler+0xbb)
:|   #begin   0x80000000  -979	  0.164  hard_local_irq_disable+0x15 (xnsche=
d_renice_root+0x1e)
:|  *#func                -978	  0.130  xnsched_track_policy+0x6 (xnsched_r=
enice_root+0x6a)
:|  *#[    0] -<?>-   -1  -978	  0.145  xnsched_renice_root+0x82 (lostage_h=
andler+0xbb)
:|  *#func                -978	  0.135  __ipipe_restore_head+0x4 (xnsched_r=
enice_root+0xd6)
:|   #end     0x80000000  -978	  0.118  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:    #func                -978	  0.117  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|   #begin   0x80000001  -978	  0.152  ipipe_get_current_domain+0x1d (__xn=
pod_schedule+0x15)
:|   #end     0x80000001  -978	  0.126  ipipe_get_current_domain+0x67 (__xn=
pod_schedule+0x15)
:    #func                -977	  0.118  ipipe_raise_irq+0x8 (__xnpod_schedu=
le+0x26)
:|   #begin   0x80000001  -977	  0.129  hard_local_irq_save+0x16 (ipipe_rai=
se_irq+0x14)
:|   #func                -977	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (ipipe_raise_irq+0x36)
:|   #func                -977	  0.144  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   #func                -977	  0.130  __ipipe_handle_irq+0x7 (ipipe_raise=
_irq+0x3e)
:|   #func                -977	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   #func                -977	  0.144  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   #func                -977	  0.147  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   #func                -976	  0.112  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   #func                -976	  0.204  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  #*func                -976	  0.112  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  #*func                -976	  0.157  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  #*func                -976	  0.133  xnpod_schedule_handler+0x3 (__ipipe=
_dispatch_irq+0x182)
:|  #*func                -976	  0.175  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  #*[    0] -<?>-   -1  -976	  0.135  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  #*func                -975	  0.129  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  #*func                -975	  0.261  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  #*func                -975	  0.329  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  #*[  580] Loader: 29  -975	  0.184  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  #*func                -975	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  #*func                -974	  0.118  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  #*func                -974	  0.354  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  #*func                -974	  0.145  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  +*end     0x80000000  -974	  0.181  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:   +*func                -974	  0.250  __copy_to_user_ll+0x6 (lrt_ioctl_wo=
rk+0x465 [sigmatek_lrt])
:|  +*begin   0x80000001  -973	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  +*end     0x80000001  -973	  0.154  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  +*begin   0x80000000  -973	  0.173  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  +*end     0x80000000  -973+   1.297  __ipipe_syscall_root+0x70 (sysente=
r_past_esp+0x5b)
:   +*func                -972	  0.121  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   +*func                -971	  0.130  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  +*begin   0x80000001  -971	  0.204  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  +*end     0x80000001  -971	  0.135  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   +*func                -971	  0.118  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  +*begin   0x80000001  -971	  0.145  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  +*end     0x80000001  -971	  0.124  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   +*func                -971	  0.145  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   +*func                -970	  0.115  sys_rtdm_ioctl+0x3 (hisyscall_event=
+0x129)
:   +*func                -970	  0.115  __rt_dev_ioctl+0x9 (sys_rtdm_ioctl+=
0x1d)
:   +*func                -970	  0.120  rtdm_context_get+0x6 (__rt_dev_ioct=
l+0x24)
:|  +*begin   0x80000000  -970	  0.210  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  #*func                -970	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  +*end     0x80000000  -970	  0.121  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  +*begin   0x80000001  -970	  0.155  rtdm_in_rt_context+0x1d (__rt_dev_i=
octl+0x36)
:|  +*end     0x80000001  -969	  0.126  rtdm_in_rt_context+0x67 (__rt_dev_i=
octl+0x36)
:   +*func                -969	  0.123  lrt_ioctl+0x3 [sigmatek_lrt] (__rt_=
dev_ioctl+0x46)
:   +*func                -969	  0.118  lrt_ioctl_work+0xc [sigmatek_lrt] (=
lrt_ioctl+0x10 [sigmatek_lrt])
:   +*func                -969	  0.123  lrtdrv_timing_wait+0x9 [sigmatek_lr=
t] (lrt_ioctl_work+0x41d [sigmatek_lrt])
:|  +*begin   0x80000001  -969	  0.154  lrtdrv_timing_wait+0x39 [sigmatek_l=
rt] (lrt_ioctl_work+0x41d [sigmatek_lrt])
:|  +*end     0x80000001  -969	  0.127  lrtdrv_timing_wait+0x85 [sigmatek_l=
rt] (lrt_ioctl_work+0x41d [sigmatek_lrt])
:   +*func                -969	  0.117  rtdm_event_wait+0x3 (lrtdrv_timing_=
wait+0xdc [sigmatek_lrt])
:   +*func                -969	  0.120  rtdm_event_timedwait+0x9 (rtdm_even=
t_wait+0x13)
:|  +*begin   0x80000000  -968	  0.178  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.14+0x9)
:|  #*func                -968	  0.184  xnsynch_sleep_on+0x9 (rtdm_event_ti=
medwait+0x8e)
:|  #*func                -968	  0.158  xnpod_suspend_thread+0x9 (xnsynch_s=
leep_on+0x8b)
:|  #*func                -968	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  #*[  580] Loader: 29  -968	  0.118  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  #*func                -968	  0.255  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  #*func                -967	  0.313  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  #*[    0] -<?>-   -1  -967	  0.210  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  #*func                -967	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  #*func                -967	  0.126  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  #*func                -967	  0.129  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  #*func                -966	  0.308  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   #func                -966	  0.206  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   #func                -966	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   #func                -966	  0.193  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   #end     0x80000001  -966	  0.160  hard_local_irq_restore+0x15 (ipipe_=
raise_irq+0x45)
:    #func                -965	  0.117  wake_up_process+0x4 (lostage_handle=
r+0xcb)
:    #func                -965	  0.114  try_to_wake_up+0x9 (wake_up_process=
+0x2e)
:    #func                -965	  0.158  _raw_spin_lock_irqsave+0x5 (try_to_=
wake_up+0x25)
:    #func                -965	  0.112  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func                -965	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -965	  0.166  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -965	  0.161  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -965	  0.129  select_task_rq_rt+0x6 (select_task_=
rq+0x15)
:|   #begin   0x80000001  -964	  0.142  debug_smp_processor_id+0x36 (try_to=
_wake_up+0x106)
:|   #end     0x80000001  -964	  0.126  debug_smp_processor_id+0x82 (try_to=
_wake_up+0x106)
:    #func                -964	  0.123  cpus_share_cache+0x4 (try_to_wake_u=
p+0x10d)
:    #func                -964	  0.111  _raw_spin_lock+0x4 (try_to_wake_up+=
0x15a)
:    #func                -964	  0.114  add_preempt_count+0x4 (_raw_spin_lo=
ck+0x15)
:    #func                -964	  0.120  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -964	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -963	  0.149  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -963	  0.117  ttwu_do_activate.constprop.91+0x5 (=
try_to_wake_up+0x163)
:    #func                -963	  0.117  activate_task+0x4 (ttwu_do_activate=
.constprop.91+0x2b)
:    #func                -963	  0.115  enqueue_task+0x8 (activate_task+0x2=
1)
:    #func                -963	  0.144  update_rq_clock+0x6 (enqueue_task+0=
x1a)
:|   #begin   0x80000001  -963	  0.154  debug_smp_processor_id+0x36 (__cycl=
es_2_ns+0x14)
:|   #end     0x80000001  -963	  0.215  debug_smp_processor_id+0x82 (__cycl=
es_2_ns+0x14)
:    #func                -962	  0.117  enqueue_task_rt+0x7 (enqueue_task+0=
x28)
:    #func                -962	  0.138  dequeue_rt_stack+0x9 (enqueue_task_=
rt+0x2c)
:    #func                -962	  0.155  cpupri_set+0x6 (enqueue_task_rt+0xc=
a)
:    #func                -962	  0.124  update_rt_migration+0x4 (enqueue_ta=
sk_rt+0xea)
:    #func                -962	  0.115  ttwu_do_wakeup+0x6 (ttwu_do_activat=
e.constprop.91+0x50)
:    #func                -962	  0.144  check_preempt_curr+0x7 (ttwu_do_wak=
eup+0x14)
:    #func                -962	  0.148  resched_task+0x5 (check_preempt_cur=
r+0x3c)
:|   #begin   0x80000001  -962	  0.152  debug_smp_processor_id+0x36 (resche=
d_task+0x48)
:|   #end     0x80000001  -961	  0.130  debug_smp_processor_id+0x82 (resche=
d_task+0x48)
:    #func                -961	  0.123  task_woken_rt+0x4 (ttwu_do_wakeup+0=
x5b)
:    #func                -961	  0.123  _raw_spin_unlock+0x3 (try_to_wake_u=
p+0x16f)
:    #func                -961	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
:    #func                -961	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -961	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -961	  0.133  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -960	  0.127  __ipipe_spin_unlock_debug+0x3 (try_=
to_wake_up+0x177)
:    #func                -960	  0.124  _raw_spin_unlock_irqrestore+0x4 (tr=
y_to_wake_up+0x182)
:    #func                -960	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -960	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -960	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -960	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -960	  0.115  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func                -960	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -959	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -959	  0.193  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -959	  0.191  irq_exit+0x3 (__ipipe_do_sync_stage=
+0x104)
:    #func                -959	  0.115  sub_preempt_count+0x4 (irq_exit+0x1=
7)
:    #func                -959	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -959	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -958	  0.155  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001  -958	  0.141  debug_smp_processor_id+0x36 (irq_ex=
it+0x4b)
:|   #end     0x80000001  -958	  0.127  debug_smp_processor_id+0x82 (irq_ex=
it+0x4b)
:    #func                -958	  0.118  idle_cpu+0x3 (irq_exit+0x50)
:    #func                -958	  0.145  rcu_irq_exit+0x5 (irq_exit+0x7e)
:|   #begin   0x80000001  -958	  0.142  debug_smp_processor_id+0x36 (rcu_ir=
q_exit+0x1b)
:|   #end     0x80000001  -958	  0.136  debug_smp_processor_id+0x82 (rcu_ir=
q_exit+0x1b)
:    #func                -958	  0.118  rcu_eqs_enter_common.isra.49+0x6 (r=
cu_irq_exit+0x68)
:|   #begin   0x80000001  -957	  0.215  debug_smp_processor_id+0x36 (rcu_eq=
s_enter_common.isra.49+0x7d)
:|   #end     0x80000001  -957	  0.141  debug_smp_processor_id+0x82 (rcu_eq=
s_enter_common.isra.49+0x7d)
:    #func                -957	  0.112  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -957	  0.120  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -957	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -957	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -957	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_do_sync_stage+0x117)
:    #func                -956	  0.149  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   #begin   0x80000000  -956	  0.193  hard_local_irq_disable+0x17 (__ipip=
e_do_sync_stage+0x11c)
:|   +func                -956	  0.123  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +func                -956	  0.210  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +end     0x00000051  -956	  0.277  common_interrupt+0x51 (need_resched=
+0x0)
:|   +begin   0x80000001  -955	  0.142  debug_smp_processor_id+0x36 (cpu_st=
artup_entry+0x9f)
:|   +end     0x80000001  -955	  0.127  debug_smp_processor_id+0x82 (cpu_st=
artup_entry+0x9f)
:    +func                -955	  0.147  rcu_idle_exit+0x6 (cpu_startup_entr=
y+0xb8)
:|   #begin   0x80000001  -955	  0.151  debug_smp_processor_id+0x36 (rcu_id=
le_exit+0x1c)
:|   #end     0x80000001  -955	  0.130  debug_smp_processor_id+0x82 (rcu_id=
le_exit+0x1c)
:    #func                -955	  0.133  rcu_eqs_exit_common.isra.47+0x5 (rc=
u_idle_exit+0x73)
:|   #begin   0x80000001  -955	  0.152  debug_smp_processor_id+0x36 (rcu_eq=
s_exit_common.isra.47+0x41)
:|   #end     0x80000001  -954	  0.139  debug_smp_processor_id+0x82 (rcu_eq=
s_exit_common.isra.47+0x41)
:    #func                -954	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -954	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -954	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -954	  0.138  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -954	  0.123  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000  -954	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func                -954	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000  -953	  0.114  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func                -953	  0.127  arch_cpu_idle_exit+0x3 (cpu_startup=
_entry+0x136)
:    +func                -953	  0.121  tick_nohz_idle_exit+0x7 (cpu_startu=
p_entry+0x148)
:|   +begin   0x80000001  -953	  0.144  debug_smp_processor_id+0x36 (tick_n=
ohz_idle_exit+0x16)
:|   +end     0x80000001  -953	  0.142  debug_smp_processor_id+0x82 (tick_n=
ohz_idle_exit+0x16)
:    #func                -953	  0.148  ktime_get+0x9 (tick_nohz_idle_exit+=
0x62)
:    #func                -953	  0.117  tick_do_update_jiffies64+0x9 (tick_=
nohz_idle_exit+0x8b)
:    #func                -952	  0.121  update_cpu_load_nohz+0x5 (tick_nohz=
_idle_exit+0x90)
:|   #begin   0x80000001  -952	  0.142  debug_smp_processor_id+0x36 (update=
_cpu_load_nohz+0x14)
:|   #end     0x80000001  -952	  0.129  debug_smp_processor_id+0x82 (update=
_cpu_load_nohz+0x14)
:    #func                -952	  0.112  _raw_spin_lock+0x4 (update_cpu_load=
_nohz+0x2d)
:    #func                -952	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck+0x15)
:    #func                -952	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -952	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -952	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -951	  0.129  __update_cpu_load+0x9 (update_cpu_l=
oad_nohz+0x40)
:    #func                -951	  0.121  sched_avg_update+0x9 (__update_cpu_=
load+0xa9)
:    #func                -951	  0.127  _raw_spin_unlock+0x3 (update_cpu_lo=
ad_nohz+0x47)
:    #func                -951	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
:    #func                -951	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -951	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -951	  0.133  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -950	  0.121  calc_load_exit_idle+0x4 (tick_nohz_=
idle_exit+0x95)
:|   #begin   0x80000001  -950	  0.142  debug_smp_processor_id+0x36 (calc_l=
oad_exit_idle+0x13)
:|   #end     0x80000001  -950	  0.130  debug_smp_processor_id+0x82 (calc_l=
oad_exit_idle+0x13)
:    #func                -950	  0.121  hrtimer_cancel+0x4 (tick_nohz_idle_=
exit+0xa9)
:    #func                -950	  0.114  hrtimer_try_to_cancel+0x7 (hrtimer_=
cancel+0x12)
:    #func                -950	  0.117  lock_hrtimer_base.isra.17+0x6 (hrti=
mer_try_to_cancel+0x1e)
:    #func                -950	  0.139  _raw_spin_lock_irqsave+0x5 (lock_hr=
timer_base.isra.17+0x1c)
:    #func                -950	  0.114  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func                -949	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -949	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -949	  0.152  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001  -949	  0.142  debug_smp_processor_id+0x36 (remove=
_hrtimer.part.15+0x1f)
:|   #end     0x80000001  -949	  0.129  debug_smp_processor_id+0x82 (remove=
_hrtimer.part.15+0x1f)
:    #func                -949	  0.124  __remove_hrtimer+0x9 (remove_hrtime=
r.part.15+0x3e)
:    #func                -949	  0.129  hrtimer_force_reprogram+0x9 (__remo=
ve_hrtimer+0x64)
:    #func                -949	  0.111  __ipipe_spin_unlock_debug+0x3 (unlo=
ck_hrtimer_base.isra.18+0x10)
:    #func                -948	  0.124  _raw_spin_unlock_irqrestore+0x4 (un=
lock_hrtimer_base.isra.18+0x1b)
:    #func                -948	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -948	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -948	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -948	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -948	  0.114  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func                -948	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -947	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -947	  0.154  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -947	  0.121  hrtimer_forward+0xc (tick_nohz_idle=
_exit+0xd2)
:    #func                -947	  0.118  ktime_add_safe+0x6 (hrtimer_forward=
+0x103)
:    #func                -947	  0.120  ktime_add_safe+0x6 (hrtimer_forward=
+0x11d)
:    #func                -947	  0.114  hrtimer_start_range_ns+0x3 (hrtimer=
_start_expires.constprop.9+0x1d)
:    #func                -947	  0.115  __hrtimer_start_range_ns+0x9 (hrtim=
er_start_range_ns+0x15)
:    #func                -947	  0.114  lock_hrtimer_base.isra.17+0x6 (__hr=
timer_start_range_ns+0x23)
:    #func                -946	  0.141  _raw_spin_lock_irqsave+0x5 (lock_hr=
timer_base.isra.17+0x1c)
:    #func                -946	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func                -946	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -946	  0.175  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -946	  0.151  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001  -946	  0.141  debug_smp_processor_id+0x36 (__hrti=
mer_start_range_ns+0x46)
:|   #end     0x80000001  -946	  0.136  debug_smp_processor_id+0x82 (__hrti=
mer_start_range_ns+0x46)
:    #func                -945	  0.117  ktime_add_safe+0x6 (hrtimer_set_exp=
ires_range_ns+0x21)
:    #func                -945	  0.135  enqueue_hrtimer+0x6 (__hrtimer_star=
t_range_ns+0x155)
:|   #begin   0x80000001  -945	  0.142  debug_smp_processor_id+0x36 (__hrti=
mer_start_range_ns+0x16d)
:|   #end     0x80000001  -945	  0.138  debug_smp_processor_id+0x82 (__hrti=
mer_start_range_ns+0x16d)
:|   #begin   0x80000001  -945	  0.141  debug_smp_processor_id+0x36 (__hrti=
mer_start_range_ns+0x192)
:|   #end     0x80000001  -945	  0.133  debug_smp_processor_id+0x82 (__hrti=
mer_start_range_ns+0x192)
:    #func                -945	  0.115  tick_program_event+0x4 (__hrtimer_s=
tart_range_ns+0x20a)
:    #func                -945	  0.121  clockevents_program_event+0x9 (tick=
_program_event+0x24)
:    #func                -944	  0.151  ktime_get+0x9 (clockevents_program_=
event+0x7a)
:    #func                -944	  0.117  xnarch_next_htick_shot+0x5 (clockev=
ents_program_event+0xeb)
:|   #begin   0x80000000  -944	  0.166  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  *#func                -944	  0.133  xntimer_start_aperiodic+0x9 (xnarch=
_next_htick_shot+0x33)
:|  *#func                -944	  0.164  xnarch_ns_to_tsc+0x6 (xntimer_start=
_aperiodic+0x67)
:|  *#func                -944	  0.126  xntimer_next_local_shot+0x9 (xntime=
r_start_aperiodic+0x11a)
:|  *#event   tick@-194   -944	  0.117  xntimer_next_local_shot+0xca (xntim=
er_start_aperiodic+0x11a)
:|  *#func                -943	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  *#func                -943	  0.245  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  *#func                -943	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|   #end     0x80000000  -943	  0.126  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:    #func                -943	  0.112  __ipipe_spin_unlock_debug+0x3 (unlo=
ck_hrtimer_base.isra.18+0x10)
:    #func                -943	  0.126  _raw_spin_unlock_irqrestore+0x4 (un=
lock_hrtimer_base.isra.18+0x1b)
:    #func                -943	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -942	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -942	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -942	  0.141  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -942	  0.114  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func                -942	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -942	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -942	  0.158  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -941	  0.117  account_idle_ticks+0x3 (tick_nohz_i=
dle_exit+0x122)
:    #func                -941	  0.130  account_idle_time+0x6 (account_idle=
_ticks+0xd)
:|   #begin   0x80000001  -941	  0.142  debug_smp_processor_id+0x36 (accoun=
t_idle_time+0x1c)
:|   #end     0x80000001  -941	  0.133  debug_smp_processor_id+0x82 (accoun=
t_idle_time+0x1c)
:|   #begin   0x80000001  -941	  0.152  debug_smp_processor_id+0x36 (accoun=
t_idle_time+0x28)
:|   #end     0x80000001  -941	  0.127  debug_smp_processor_id+0x82 (accoun=
t_idle_time+0x28)
:    #func                -941	  0.121  ipipe_unstall_root+0x3 (tick_nohz_i=
dle_exit+0x127)
:|   #begin   0x80000000  -941	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func                -940	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000  -940	  0.114  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func                -940	  0.118  schedule_preempt_disabled+0x3 (cpu_=
startup_entry+0x14d)
:    +func                -940	  0.115  sub_preempt_count+0x4 (schedule_pre=
empt_disabled+0x12)
:    +func                -940	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001  -940	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -940	  0.130  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -939	  0.115  schedule+0x3 (schedule_preempt_disa=
bled+0x17)
:    +func                -939	  0.115  __schedule+0x9 (schedule+0x18)
:    +func                -939	  0.114  add_preempt_count+0x4 (__schedule+0=
x23)
:    +func                -939	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   +begin   0x80000001  -939	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -939	  0.138  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   +begin   0x80000001  -939	  0.152  debug_smp_processor_id+0x36 (__sche=
dule+0x28)
:|   +end     0x80000001  -939	  0.130  debug_smp_processor_id+0x82 (__sche=
dule+0x28)
:    +func                -938	  0.117  rcu_note_context_switch+0x9 (__sche=
dule+0x3a)
:    +func                -938	  0.145  rcu_sched_qs+0x3 (rcu_note_context_=
switch+0x2a)
:    #func                -938	  0.121  rcu_preempt_qs+0x3 (rcu_note_contex=
t_switch+0x147)
:    #func                -938	  0.112  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -938	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -938	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -938	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -938	  0.120  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000  -937	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func                -937	  0.187  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000  -937	  0.118  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func                -937	  0.118  ipipe_root_only+0x5 (__schedule+0x7=
3)
:|   +begin   0x80000001  -937	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -937	  0.127  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -937	  0.127  _raw_spin_lock_irq+0x4 (__schedule+=
0xba)
:    #func                -936	  0.117  add_preempt_count+0x4 (_raw_spin_lo=
ck_irq+0x1a)
:    #func                -936	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -936	  0.175  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -936	  0.148  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -936	  0.120  pre_schedule_idle+0x3 (__schedule+0=
x242)
:    #func                -936	  0.114  put_prev_task_idle+0x3 (__schedule+=
0x275)
:    #func                -936	  0.121  pick_next_task_stop+0x4 (__schedule=
+0x299)
:    #func                -936	  0.120  pick_next_task_rt+0x5 (__schedule+0=
x299)
:    #func                -935	  0.130  dequeue_pushable_task+0x5 (pick_nex=
t_task_rt+0x5b)
:    #func                -935	  0.127  taskSwitchLinux+0x6 [sigmatek_lrt] =
(__schedule+0x2dc)
:    #func                -935	  0.130  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchLinux+0x32 [sigmatek_lrt])
:    #func                -935	  0.120  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:    #func                -935	  0.154  rt_task_set_mode+0x7 (taskSwitchLin=
ux+0x4f [sigmatek_lrt])
:    #func                -935	  0.148  rt_task_set_mode+0x7 (taskSwitchLin=
ux+0xbf [sigmatek_lrt])
:    #func                -935	  0.115  __ipipe_notify_kevent+0x9 (__schedu=
le+0x391)
:    #func                -934	  0.117  ipipe_root_only+0x5 (__ipipe_notify=
_kevent+0x1b)
:|   #begin   0x80000001  -934	  0.152  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -934	  0.132  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001  -934	  0.144  hard_local_irq_save+0x16 (__ipipe_n=
otify_kevent+0x20)
:|   #end     0x80000001  -934	  0.124  hard_local_irq_restore+0x15 (__ipip=
e_notify_kevent+0x49)
:    #func                -934	  0.124  ipipe_kevent_hook+0x4 (__ipipe_noti=
fy_kevent+0x54)
:    #func                -934	  0.154  schedule_event+0x9 (ipipe_kevent_ho=
ok+0x1c)
:    #func                -934	  0.121  xnsched_renice_root+0x7 (schedule_e=
vent+0x1f0)
:|   #begin   0x80000000  -933	  0.154  hard_local_irq_disable+0x15 (xnsche=
d_renice_root+0x1e)
:|  *#func                -933	  0.130  xnsched_track_policy+0x6 (xnsched_r=
enice_root+0x6a)
:|  *#[    0] -<?>-   30  -933	  0.147  xnsched_renice_root+0x82 (schedule_=
event+0x1f0)
:|  *#func                -933	  0.135  __ipipe_restore_head+0x4 (xnsched_r=
enice_root+0xd6)
:|   #end     0x80000000  -933	  0.117  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:    #func                -933	  0.120  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|   #begin   0x80000001  -933	  0.141  ipipe_get_current_domain+0x1d (__xn=
pod_schedule+0x15)
:|   #end     0x80000001  -932	  0.126  ipipe_get_current_domain+0x67 (__xn=
pod_schedule+0x15)
:    #func                -932	  0.118  ipipe_raise_irq+0x8 (__xnpod_schedu=
le+0x26)
:|   #begin   0x80000001  -932	  0.129  hard_local_irq_save+0x16 (ipipe_rai=
se_irq+0x14)
:|   #func                -932	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (ipipe_raise_irq+0x36)
:|   #func                -932	  0.145  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   #func                -932	  0.130  __ipipe_handle_irq+0x7 (ipipe_raise=
_irq+0x3e)
:|   #func                -932	  0.120  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   #func                -932	  0.144  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   #func                -931	  0.141  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   #func                -931	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   #func                -931	  0.201  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  #*func                -931	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  #*func                -931	  0.147  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  #*func                -931	  0.132  xnpod_schedule_handler+0x3 (__ipipe=
_dispatch_irq+0x182)
:|  #*func                -931	  0.173  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  #*[    0] -<?>-   30  -930	  0.136  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  #*func                -930	  0.283  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|   #func                -930	  0.175  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   #func                -930	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   #func                -930	  0.178  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   #end     0x80000001  -929	  0.133  hard_local_irq_restore+0x15 (ipipe_=
raise_irq+0x45)
:|   #begin   0x80000001  -929	  0.139  hard_local_irq_save+0x16 (__ipipe_n=
otify_kevent+0x5b)
:|   #end     0x80000001  -929	  0.139  hard_local_irq_restore+0x15 (__ipip=
e_notify_kevent+0x6b)
:|   #begin   0x80000000  -929	  0.206  __schedule+0x3a3 (schedule+0x18)
:|   #func                -929	  0.381  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|   #func                -928	  0.135  ipipe_unstall_head+0x4 (xnshadow_re=
lax+0x91)
:|   #end     0x80000000  -928	  0.114  hard_local_irq_enable+0x16 (ipipe_u=
nstall_head+0x2e)
:    #func                -928	  0.123  __ipipe_reenter_root+0x4 (xnshadow_=
relax+0xa2)
:|   #begin   0x80000001  -928	  0.141  debug_smp_processor_id+0x36 (__ipip=
e_reenter_root+0x13)
:|   #end     0x80000001  -928	  0.127  debug_smp_processor_id+0x82 (__ipip=
e_reenter_root+0x13)
:    #func                -928	  0.114  finish_task_switch+0x7 (__ipipe_ree=
nter_root+0x28)
:    #func                -928	  0.124  _raw_spin_unlock_irq+0x3 (finish_ta=
sk_switch+0x4a)
:    #func                -928	  0.123  ipipe_unstall_root+0x3 (_raw_spin_u=
nlock_irq+0x12)
:|   #begin   0x80000000  -927	  0.126  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func                -927	  0.185  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000  -927	  0.114  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func                -927	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock_irq+0x1c)
:    +func                -927	  0.120  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001  -927	  0.166  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -927	  0.170  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -926	  0.115  sub_preempt_count+0x4 (__ipipe_reen=
ter_root+0x42)
:    +func                -926	  0.126  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001  -926	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -926	  0.181  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   +begin   0x80000001  -926	  0.210  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|   +end     0x80000001  -926	  0.124  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:    +func                -926	  0.118  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|   +begin   0x80000001  -925	  0.157  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|   +end     0x80000001  -925	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:    +func                -925	  0.118  losyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:|   +begin   0x80000001  -925	  0.181  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|   +end     0x80000001  -925	  0.147  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|   +begin   0x80000000  -925	  0.179  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|   +end     0x80000000  -925	  0.142  __ipipe_syscall_root+0x9e (system_c=
all+0x30)
:    +func                -924	  0.114  SyS_select+0x9 (syscall_call+0x7)
:    +func                -924	  0.114  _copy_from_user+0x7 (SyS_select+0x3=
9)
:    +func                -924	  0.118  ipipe_root_only+0x5 (_copy_from_use=
r+0x30)
:|   +begin   0x80000001  -924	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -924	  0.129  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -924	  0.167  __copy_from_user_ll+0x6 (_copy_from=
_user+0x3c)
:    +func                -924	  0.123  poll_select_set_timeout+0x6 (SyS_se=
lect+0x60)
:    +func                -923	  0.118  core_sys_select+0xc (SyS_select+0x8=
0)
:    +func                -923	  0.123  __rcu_read_lock+0x3 (core_sys_selec=
t+0x31)
:    +func                -923	  0.126  __rcu_read_unlock+0x4 (core_sys_sel=
ect+0x47)
:    +func                -923	  0.114  _copy_from_user+0x7 (get_fd_set+0x1=
b)
:    +func                -923	  0.118  ipipe_root_only+0x5 (_copy_from_use=
r+0x30)
:|   +begin   0x80000001  -923	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -923	  0.127  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -923	  0.133  __copy_from_user_ll+0x6 (_copy_from=
_user+0x3c)
:    +func                -922	  0.115  _copy_from_user+0x7 (get_fd_set+0x1=
b)
:    +func                -922	  0.118  ipipe_root_only+0x5 (_copy_from_use=
r+0x30)
:|   +begin   0x80000001  -922	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -922	  0.127  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -922	  0.184  __copy_from_user_ll+0x6 (_copy_from=
_user+0x3c)
:    +func                -922	  0.114  do_select+0xc (core_sys_select+0x12=
b)
:    +func                -922	  0.144  __rcu_read_lock+0x3 (do_select+0x23)
:    +func                -921	  0.120  __rcu_read_unlock+0x4 (do_select+0x=
e5)
:    +func                -921	  0.161  poll_initwait+0x3 (do_select+0xfd)
:    +func                -921	  0.120  fget_light+0x6 (do_select+0x2aa)
:    +func                -921	  0.136  __rcu_read_lock+0x3 (fget_light+0x4=
a)
:    +func                -921	  0.136  __rcu_read_unlock+0x4 (fget_light+0=
x7b)
:    +func                -921	  0.115  eventfd_poll+0x6 (do_select+0x30f)
:    +func                -921	  0.151  _raw_spin_lock_irqsave+0x5 (eventfd=
_poll+0x2f)
:    #func                -921	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func                -920	  0.124  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -920	  0.154  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -920	  0.148  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -920	  0.123  __ipipe_spin_unlock_debug+0x3 (even=
tfd_poll+0x68)
:    #func                -920	  0.132  _raw_spin_unlock_irqrestore+0x4 (ev=
entfd_poll+0x71)
:    #func                -920	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -920	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -919	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -919	  0.141  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -919	  0.121  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000  -919	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func                -919	  0.190  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000  -919	  0.117  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func                -919	  0.118  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    +func                -919	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001  -918	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -918	  0.136  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -918	  0.166  fput+0x5 (do_select+0x327)
:    +func                -918	  0.114  fget_light+0x6 (do_select+0x2aa)
:    +func                -918	  0.141  __rcu_read_lock+0x3 (fget_light+0x4=
a)
:    +func                -918	  0.151  __rcu_read_unlock+0x4 (fget_light+0=
x7b)
:    +func                -918	  0.130  sock_poll+0x5 (do_select+0x30f)
:    +func                -917	  0.132  tcp_poll+0x6 (sock_poll+0x17)
:    +func                -917	  0.127  fput+0x5 (do_select+0x327)
:    +func                -917	  0.127  _cond_resched+0x3 (do_select+0x3f1)
:    +func                -917	  0.124  poll_freewait+0x9 (do_select+0x4ab)
:    +func                -917	  0.133  ipipe_root_only+0x5 (set_fd_set+0x1=
7)
:|   +begin   0x80000001  -917	  0.152  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -917	  0.130  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -916	  0.138  __copy_to_user_ll+0x6 (set_fd_set+0=
x2d)
:    +func                -916	  0.118  ipipe_root_only+0x5 (set_fd_set+0x1=
7)
:|   +begin   0x80000001  -916	  0.179  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -916	  0.129  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -916	  0.141  __copy_to_user_ll+0x6 (set_fd_set+0=
x2d)
:    +func                -916! 189.808  poll_select_copy_remaining+0x9 (Sy=
S_select+0x90)
:    +func                -726	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:    +func                -726	  0.118  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|   +begin   0x80000001  -726	  0.198  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001  -726	  0.126  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func                -725	  0.121  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001  -725	  0.144  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001  -725	  0.138  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func                -725	  0.135  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:|  + begin   0x80000001  -725	  0.221  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|   +end     0x80000001  -725	  0.126  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:    +func                -724	  0.121  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|   +begin   0x80000001  -724	  0.155  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|   +end     0x80000001  -724	  0.124  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:    +func                -724	  0.151  losyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:    +func                -724	  0.117  sys_rtdm_ioctl+0x3 (losyscall_event=
+0xb1)
:    +func                -724	  0.114  __rt_dev_ioctl+0x9 (sys_rtdm_ioctl+=
0x1d)
:    +func                -724	  0.123  rtdm_context_get+0x6 (__rt_dev_ioct=
l+0x24)
:|   +begin   0x80000000  -724	  0.212  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  *+func                -723	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|   +end     0x80000000  -723	  0.124  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|   +begin   0x80000001  -723	  0.142  rtdm_in_rt_context+0x1d (__rt_dev_i=
octl+0x36)
:|   +end     0x80000001  -723	  0.144  rtdm_in_rt_context+0x67 (__rt_dev_i=
octl+0x36)
:    +func                -723	  0.115  lrt_non_rt_ioctl+0x3 [sigmatek_lrt]=
 (__rt_dev_ioctl+0x51)
:    +func                -723	  0.151  lrt_non_rt_ioctl_work+0xc [sigmatek=
_lrt] (lrt_non_rt_ioctl+0x10 [sigmatek_lrt])
:    +func                -723	  0.120  xnshadow_harden+0x9 (losyscall_even=
t+0x88)
:    +func                -722	  0.115  down_interruptible+0x6 (xnshadow_ha=
rden+0x4f)
:    +func                -722	  0.142  _raw_spin_lock_irqsave+0x5 (down_in=
terruptible+0x12)
:    #func                -722	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func                -722	  0.120  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -722	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -722	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -722	  0.132  __ipipe_spin_unlock_debug+0x3 (down=
_interruptible+0x33)
:    #func                -721	  0.121  _raw_spin_unlock_irqrestore+0x4 (do=
wn_interruptible+0x3c)
:    #func                -721	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -721	  0.120  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -721	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -721	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -721	  0.121  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000  -721	  0.126  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func                -721	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000  -720	  0.114  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func                -720	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    +func                -720	  0.120  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001  -720	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -720	  0.133  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -720	  0.114  add_preempt_count+0x4 (xnshadow_har=
den+0x76)
:    +func                -720	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   +begin   0x80000001  -720	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -719	  0.145  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -719	  0.124  wake_up_process+0x4 (xnshadow_harde=
n+0xe1)
:    +func                -719	  0.111  try_to_wake_up+0x9 (wake_up_process=
+0x2e)
:    +func                -719	  0.141  _raw_spin_lock_irqsave+0x5 (try_to_=
wake_up+0x25)
:    #func                -719	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func                -719	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -719	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -718	  0.166  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -718	  0.139  select_task_rq_rt+0x6 (select_task_=
rq+0x15)
:|   #begin   0x80000001  -718	  0.141  debug_smp_processor_id+0x36 (try_to=
_wake_up+0x106)
:|   #end     0x80000001  -718	  0.127  debug_smp_processor_id+0x82 (try_to=
_wake_up+0x106)
:    #func                -718	  0.124  cpus_share_cache+0x4 (try_to_wake_u=
p+0x10d)
:    #func                -718	  0.111  _raw_spin_lock+0x4 (try_to_wake_up+=
0x15a)
:    #func                -718	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck+0x15)
:    #func                -718	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -717	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -717	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -717	  0.117  ttwu_do_activate.constprop.91+0x5 (=
try_to_wake_up+0x163)
:    #func                -717	  0.115  activate_task+0x4 (ttwu_do_activate=
.constprop.91+0x2b)
:    #func                -717	  0.117  enqueue_task+0x8 (activate_task+0x2=
1)
:    #func                -717	  0.138  update_rq_clock+0x6 (enqueue_task+0=
x1a)
:|   #begin   0x80000001  -717	  0.155  debug_smp_processor_id+0x36 (__cycl=
es_2_ns+0x14)
:|   #end     0x80000001  -716	  0.145  debug_smp_processor_id+0x82 (__cycl=
es_2_ns+0x14)
:    #func                -716	  0.114  enqueue_task_rt+0x7 (enqueue_task+0=
x28)
:    #func                -716	  0.127  dequeue_rt_stack+0x9 (enqueue_task_=
rt+0x2c)
:    #func                -716	  0.151  cpupri_set+0x6 (enqueue_task_rt+0xc=
a)
:    #func                -716	  0.124  update_rt_migration+0x4 (enqueue_ta=
sk_rt+0xea)
:    #func                -716	  0.114  ttwu_do_wakeup+0x6 (ttwu_do_activat=
e.constprop.91+0x50)
:    #func                -716	  0.190  check_preempt_curr+0x7 (ttwu_do_wak=
eup+0x14)
:    #func                -715	  0.118  check_preempt_curr_rt+0x5 (check_pr=
eempt_curr+0x2c)
:    #func                -715	  0.139  resched_task+0x5 (check_preempt_cur=
r_rt+0x82)
:|   #begin   0x80000001  -715	  0.142  debug_smp_processor_id+0x36 (resche=
d_task+0x48)
:|   #end     0x80000001  -715	  0.136  debug_smp_processor_id+0x82 (resche=
d_task+0x48)
:    #func                -715	  0.117  task_woken_rt+0x4 (ttwu_do_wakeup+0=
x5b)
:    #func                -715	  0.123  _raw_spin_unlock+0x3 (try_to_wake_u=
p+0x16f)
:    #func                -715	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
:    #func                -715	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -714	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -714	  0.133  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -714	  0.130  __ipipe_spin_unlock_debug+0x3 (try_=
to_wake_up+0x177)
:    #func                -714	  0.121  _raw_spin_unlock_irqrestore+0x4 (tr=
y_to_wake_up+0x182)
:    #func                -714	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -714	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -714	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -714	  0.138  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -713	  0.123  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000  -713	  0.126  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func                -713	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000  -713	  0.114  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func                -713	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    +func                -713	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001  -713	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -712	  0.148  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -712	  0.120  schedule+0x3 (xnshadow_harden+0xe6)
:    +func                -712	  0.115  __schedule+0x9 (schedule+0x18)
:    +func                -712	  0.114  add_preempt_count+0x4 (__schedule+0=
x23)
:    +func                -712	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   +begin   0x80000001  -712	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -712	  0.138  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   +begin   0x80000001  -711	  0.152  debug_smp_processor_id+0x36 (__sche=
dule+0x28)
:|   +end     0x80000001  -711	  0.130  debug_smp_processor_id+0x82 (__sche=
dule+0x28)
:    +func                -711	  0.114  rcu_note_context_switch+0x9 (__sche=
dule+0x3a)
:    +func                -711	  0.142  rcu_sched_qs+0x3 (rcu_note_context_=
switch+0x2a)
:    #func                -711	  0.121  rcu_preempt_qs+0x3 (rcu_note_contex=
t_switch+0x147)
:    #func                -711	  0.112  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -711	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -711	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -710	  0.127  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -710	  0.121  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000  -710	  0.126  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func                -710	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000  -710	  0.130  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func                -710	  0.118  sub_preempt_count+0x4 (__schedule+0=
x54)
:    +func                -710	  0.123  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001  -709	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -709	  0.135  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -709	  0.117  ipipe_root_only+0x5 (__schedule+0x7=
3)
:|   +begin   0x80000001  -709	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -709	  0.129  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -709	  0.129  _raw_spin_lock_irq+0x4 (__schedule+=
0xba)
:    #func                -709	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irq+0x1a)
:    #func                -709	  0.120  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -708	  0.175  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -708	  0.147  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -708	  0.112  deactivate_task+0x4 (__schedule+0x1=
0e)
:    #func                -708	  0.117  dequeue_task+0x8 (deactivate_task+0=
x21)
:    #func                -708	  0.190  update_rq_clock+0x6 (dequeue_task+0=
x1a)
:    #func                -708	  0.120  dequeue_task_rt+0x5 (dequeue_task+0=
x28)
:    #func                -708	  0.126  update_curr_rt+0x9 (dequeue_task_rt=
+0x13)
:    #func                -707	  0.120  sched_avg_update+0x9 (update_curr_r=
t+0xc9)
:    #func                -707	  0.144  dequeue_rt_stack+0x9 (dequeue_task_=
rt+0x1b)
:    #func                -707	  0.117  update_rt_migration+0x4 (dequeue_rt=
_stack+0x121)
:    #func                -707	  0.132  dequeue_pushable_task+0x5 (dequeue_=
task_rt+0x24)
:    #func                -707	  0.135  pre_schedule_rt+0x3 (__schedule+0x2=
42)
:    #func                -707	  0.123  put_prev_task_rt+0x5 (__schedule+0x=
275)
:    #func                -707	  0.123  update_curr_rt+0x9 (put_prev_task_r=
t+0x14)
:    #func                -707	  0.121  pick_next_task_stop+0x4 (__schedule=
+0x299)
:    #func                -706	  0.117  pick_next_task_rt+0x5 (__schedule+0=
x299)
:    #func                -706	  0.136  dequeue_pushable_task+0x5 (pick_nex=
t_task_rt+0x5b)
:    #func                -706	  0.147  taskSwitchLinux+0x6 [sigmatek_lrt] =
(__schedule+0x2dc)
:    #func                -706	  0.139  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchLinux+0x32 [sigmatek_lrt])
:    #func                -706	  0.120  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:    #func                -706	  0.218  rt_task_set_mode+0x7 (taskSwitchLin=
ux+0x4f [sigmatek_lrt])
:    #func                -706	  0.145  rt_task_set_mode+0x7 (taskSwitchLin=
ux+0xbf [sigmatek_lrt])
:    #func                -705	  0.115  __ipipe_notify_kevent+0x9 (__schedu=
le+0x391)
:    #func                -705	  0.117  ipipe_root_only+0x5 (__ipipe_notify=
_kevent+0x1b)
:|   #begin   0x80000001  -705	  0.152  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -705	  0.132  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001  -705	  0.144  hard_local_irq_save+0x16 (__ipipe_n=
otify_kevent+0x20)
:|   #end     0x80000001  -705	  0.124  hard_local_irq_restore+0x15 (__ipip=
e_notify_kevent+0x49)
:    #func                -705	  0.115  ipipe_kevent_hook+0x4 (__ipipe_noti=
fy_kevent+0x54)
:    #func                -704	  0.141  schedule_event+0x9 (ipipe_kevent_ho=
ok+0x1c)
:|   #begin   0x80000000  -704	  0.160  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  *#func                -704	  0.160  xnsched_peek_rpi+0x3 (schedule_even=
t+0x14c)
:|  *#func                -704	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|   #end     0x80000000  -704	  0.123  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|   #begin   0x80000001  -704	  0.126  hard_local_irq_save+0x16 (__ipipe_n=
otify_kevent+0x5b)
:|   #end     0x80000001  -704	  0.138  hard_local_irq_restore+0x15 (__ipip=
e_notify_kevent+0x6b)
:|   #begin   0x80000000  -703	  0.178  __schedule+0x3a3 (schedule+0x18)
:|   #func                -703	  0.166  __switch_to+0x9 (__schedule+0x50a)
:|   #func                -703	  0.138  __ipipe_switch_tail+0x4 (__schedule=
+0x514)
:|   #end     0x80000000  -703	  0.133  hard_local_irq_enable+0x16 (__ipipe=
_switch_tail+0x2e)
:|   #begin   0x80000001  -703	  0.142  debug_smp_processor_id+0x36 (__sche=
dule+0x51d)
:|   #end     0x80000001  -703	  0.130  debug_smp_processor_id+0x82 (__sche=
dule+0x51d)
:    #func                -703	  0.114  finish_task_switch+0x7 (__schedule+=
0x533)
:    #func                -702	  0.124  _raw_spin_unlock_irq+0x3 (finish_ta=
sk_switch+0x4a)
:    #func                -702	  0.123  ipipe_unstall_root+0x3 (_raw_spin_u=
nlock_irq+0x12)
:|   #begin   0x80000000  -702	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func                -702	  0.187  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000  -702	  0.115  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func                -702	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock_irq+0x1c)
:    +func                -702	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001  -702	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -701	  0.148  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   +begin   0x80000001  -701	  0.152  debug_smp_processor_id+0x36 (__sche=
dule+0x538)
:|   +end     0x80000001  -701	  0.129  debug_smp_processor_id+0x82 (__sche=
dule+0x538)
:    +func                -701	  0.115  sub_preempt_count+0x4 (__schedule+0=
x56c)
:    +func                -701	  0.124  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001  -701	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -701	  0.188  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -700	  0.123  kthread_should_stop+0x3 (gatekeeper=
_thread+0xc3)
:    +func                -700	  0.118  rpi_pop+0x9 (gatekeeper_thread+0xf0)
:|   +begin   0x80000000  -700	  0.170  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  *+func                -700	  0.170  xnsched_peek_rpi+0x3 (rpi_pop+0x6e)
:|  *+func                -700	  0.133  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|   +end     0x80000000  -700	  0.117  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:    +func                -700	  0.120  xnsched_renice_root+0x7 (rpi_pop+0x=
b4)
:|   +begin   0x80000000  -699	  0.216  hard_local_irq_disable+0x15 (xnsche=
d_renice_root+0x1e)
:|  *+func                -699	  0.121  xnsched_track_policy+0x6 (xnsched_r=
enice_root+0x6a)
:|  *+[    0] -<?>-   -1  -699	  0.147  xnsched_renice_root+0x82 (rpi_pop+0=
xb4)
:|  *+func                -699	  0.135  __ipipe_restore_head+0x4 (xnsched_r=
enice_root+0xd6)
:|   +end     0x80000000  -699	  0.124  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|   +begin   0x80000000  -699	  0.157  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  *+func                -699	  0.145  xnpod_resume_thread+0x9 (gatekeeper=
_thread+0x11a)
:|  *+[  582] cyclic: 30  -698	  0.185  xnpod_resume_thread+0x39 (gatekeepe=
r_thread+0x11a)
:|  *+func                -698	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|   +end     0x80000000  -698	  0.121  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:    +func                -698	  0.120  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|   +begin   0x80000001  -698	  0.142  ipipe_get_current_domain+0x1d (__xn=
pod_schedule+0x15)
:|   +end     0x80000001  -698	  0.132  ipipe_get_current_domain+0x67 (__xn=
pod_schedule+0x15)
:    +func                -698	  0.120  ipipe_raise_irq+0x8 (__xnpod_schedu=
le+0x26)
:|   +begin   0x80000001  -697	  0.141  hard_local_irq_save+0x16 (ipipe_rai=
se_irq+0x14)
:|   +func                -697	  0.112  irq_hook_handler+0x5 [sigmatek_lrt]=
 (ipipe_raise_irq+0x36)
:|   +func                -697	  0.144  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func                -697	  0.141  __ipipe_handle_irq+0x7 (ipipe_raise=
_irq+0x3e)
:|   +func                -697	  0.120  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func                -697	  0.145  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func                -697	  0.145  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func                -696	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   +func                -696	  0.206  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                -696	  0.112  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func                -696	  0.145  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                -696	  0.132  xnpod_schedule_handler+0x3 (__ipipe=
_dispatch_irq+0x182)
:|  # func                -696	  0.175  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1  -696	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -695	  0.127  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -695	  0.292  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func                -695	  0.253  __switch_to+0x9 (__schedule+0x50a)
:|  # func                -695	  0.190  __ipipe_switch_tail+0x4 (__schedule=
+0x514)
:|  # func                -695	  0.245  xnpod_switch_fpu+0x3 (xnshadow_hard=
en+0x133)
:|  # func                -694	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000  -694	  0.132  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:   + func                -694	  0.118  sys_rtdm_ioctl+0x3 (losyscall_event=
+0xb1)
:   + func                -694	  0.126  __rt_dev_ioctl+0x9 (sys_rtdm_ioctl+=
0x1d)
:   + func                -694	  0.123  rtdm_context_get+0x6 (__rt_dev_ioct=
l+0x24)
:|  + begin   0x80000000  -694	  0.212  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  # func                -694	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000  -693	  0.124  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001  -693	  0.144  rtdm_in_rt_context+0x1d (__rt_dev_i=
octl+0x36)
:|  + end     0x80000001  -693	  0.147  rtdm_in_rt_context+0x67 (__rt_dev_i=
octl+0x36)
:   + func                -693	  0.120  lrt_ioctl+0x3 [sigmatek_lrt] (__rt_=
dev_ioctl+0x46)
:   + func                -693	  0.120  lrt_ioctl_work+0xc [sigmatek_lrt] (=
lrt_ioctl+0x10 [sigmatek_lrt])
:   + func                -693	  0.151  __copy_from_user_ll_nozero+0x6 (rtd=
m_safe_copy_from_user.isra.4+0x23 [sigmatek_lrt])
:   + func                -693	  0.126  lrtdrv_timing_watchdog+0x6 [sigmate=
k_lrt] (lrt_ioctl_work+0x4a2 [sigmatek_lrt])
:   + func                -692	  0.118  setup_watchdog+0x6 [sigmatek_lrt] (=
lrtdrv_timing_watchdog+0x46 [sigmatek_lrt])
:   + func                -692	  0.120  rt_task_self+0x3 (setup_watchdog+0x=
42 [sigmatek_lrt])
:   + func                -692	  0.123  lrtdrv_timing_wait+0x9 [sigmatek_lr=
t] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:|  + begin   0x80000001  -692	  0.144  lrtdrv_timing_wait+0x39 [sigmatek_l=
rt] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:|  + end     0x80000001  -692	  0.127  lrtdrv_timing_wait+0x85 [sigmatek_l=
rt] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:   + func                -692	  0.118  rtdm_event_wait+0x3 (lrtdrv_timing_=
wait+0xdc [sigmatek_lrt])
:   + func                -692	  0.120  rtdm_event_timedwait+0x9 (rtdm_even=
t_wait+0x13)
:|  + begin   0x80000000  -692	  0.155  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.14+0x9)
:|  # func                -691	  0.169  xnsynch_sleep_on+0x9 (rtdm_event_ti=
medwait+0x8e)
:|  # func                -691	  0.144  xnpod_suspend_thread+0x9 (xnsynch_s=
leep_on+0x8b)
:|  # func                -691	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  582] cyclic: 30  -691	  0.115  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -691	  0.262  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -691	  0.353  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [   23] gatekee -1  -690	  0.198  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -690	  0.123  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -690	  0.115  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -690	  0.120  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func                -690	  0.328  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func                -689	  0.190  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func                -689	  0.118  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +func                -689	  0.198  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +end     0x80000001  -689	  0.170  hard_local_irq_restore+0x15 (ipipe_=
raise_irq+0x45)
:    +func                -689	  0.118  up+0x5 (gatekeeper_thread+0xb9)
:    +func                -689	  0.141  _raw_spin_lock_irqsave+0x5 (up+0x11)
:    #func                -688	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func                -688	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -688	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -688	  0.141  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -688	  0.121  __ipipe_spin_unlock_debug+0x3 (up+0=
x2e)
:    #func                -688	  0.123  _raw_spin_unlock_irqrestore+0x4 (up=
+0x37)
:    #func                -688	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -687	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -687	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -687	  0.126  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -687	  0.120  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000  -687	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func                -687	  0.187  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000  -687	  0.114  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func                -687	  0.118  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    +func                -686	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001  -686	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -686	  0.132  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -686	  0.115  schedule+0x3 (gatekeeper_thread+0xb=
e)
:    +func                -686	  0.115  __schedule+0x9 (schedule+0x18)
:    +func                -686	  0.114  add_preempt_count+0x4 (__schedule+0=
x23)
:    +func                -686	  0.120  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   +begin   0x80000001  -686	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -685	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   +begin   0x80000001  -685	  0.142  debug_smp_processor_id+0x36 (__sche=
dule+0x28)
:|   +end     0x80000001  -685	  0.129  debug_smp_processor_id+0x82 (__sche=
dule+0x28)
:    +func                -685	  0.115  rcu_note_context_switch+0x9 (__sche=
dule+0x3a)
:    +func                -685	  0.144  rcu_sched_qs+0x3 (rcu_note_context_=
switch+0x2a)
:    #func                -685	  0.121  rcu_preempt_qs+0x3 (rcu_note_contex=
t_switch+0x147)
:    #func                -685	  0.112  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -684	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -684	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -684	  0.127  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -684	  0.121  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000  -684	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func                -684	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000  -684	  0.120  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func                -683	  0.117  ipipe_root_only+0x5 (__schedule+0x7=
3)
:|   +begin   0x80000001  -683	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -683	  0.127  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -683	  0.129  _raw_spin_lock_irq+0x4 (__schedule+=
0xba)
:    #func                -683	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irq+0x1a)
:    #func                -683	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -683	  0.175  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -683	  0.145  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -682	  0.114  deactivate_task+0x4 (__schedule+0x1=
0e)
:    #func                -682	  0.115  dequeue_task+0x8 (deactivate_task+0=
x21)
:    #func                -682	  0.149  update_rq_clock+0x6 (dequeue_task+0=
x1a)
:|   #begin   0x80000001  -682	  0.141  debug_smp_processor_id+0x36 (__cycl=
es_2_ns+0x14)
:|   #end     0x80000001  -682	  0.142  debug_smp_processor_id+0x82 (__cycl=
es_2_ns+0x14)
:    #func                -682	  0.114  dequeue_task_rt+0x5 (dequeue_task+0=
x28)
:    #func                -682	  0.126  update_curr_rt+0x9 (dequeue_task_rt=
+0x13)
:    #func                -681	  0.118  sched_avg_update+0x9 (update_curr_r=
t+0xc9)
:    #func                -681	  0.141  dequeue_rt_stack+0x9 (dequeue_task_=
rt+0x1b)
:    #func                -681	  0.172  cpupri_set+0x6 (dequeue_rt_stack+0x=
104)
:    #func                -681	  0.121  update_rt_migration+0x4 (dequeue_rt=
_stack+0x121)
:    #func                -681	  0.121  dequeue_pushable_task+0x5 (dequeue_=
task_rt+0x24)
:    #func                -681	  0.114  pre_schedule_rt+0x3 (__schedule+0x2=
42)
:    #func                -681	  0.121  pull_rt_task+0x9 (pre_schedule_rt+0=
x18)
:    #func                -681	  0.132  idle_balance+0x9 (__schedule+0x252)
:    #func                -680	  0.124  _raw_spin_unlock+0x3 (idle_balance+=
0x5f)
:    #func                -680	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
:    #func                -680	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -680	  0.152  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -680	  0.132  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -680	  0.118  __rcu_read_lock+0x3 (idle_balance+0=
x64)
:    #func                -680	  0.111  __rcu_read_unlock+0x4 (idle_balance=
+0xee)
:    #func                -680	  0.114  _raw_spin_lock+0x4 (idle_balance+0x=
f5)
:    #func                -679	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck+0x15)
:    #func                -679	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -679	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -679	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -679	  0.118  put_prev_task_rt+0x5 (__schedule+0x=
275)
:    #func                -679	  0.124  update_curr_rt+0x9 (put_prev_task_r=
t+0x14)
:    #func                -679	  0.114  pick_next_task_fair+0x7 (__schedule=
+0x28c)
:    #func                -679	  0.117  pick_next_task_stop+0x4 (__schedule=
+0x299)
:    #func                -678	  0.115  pick_next_task_rt+0x5 (__schedule+0=
x299)
:    #func                -678	  0.121  pick_next_task_fair+0x7 (__schedule=
+0x299)
:    #func                -678	  0.129  pick_next_task_idle+0x3 (__schedule=
+0x299)
:    #func                -678	  0.118  taskSwitchLinux+0x6 [sigmatek_lrt] =
(__schedule+0x2dc)
:    #func                -678	  0.149  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchLinux+0x32 [sigmatek_lrt])
:    #func                -678	  0.129  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:    #func                -678	  0.151  rt_task_set_mode+0x7 (taskSwitchLin=
ux+0x4f [sigmatek_lrt])
:    #func                -678	  0.136  rt_task_set_mode+0x7 (taskSwitchLin=
ux+0xbf [sigmatek_lrt])
:|   #begin   0x80000000  -677	  0.148  __schedule+0x3a3 (schedule+0x18)
:|   #func                -677	  0.164  __switch_to+0x9 (__schedule+0x50a)
:|   #func                -677	  0.139  __ipipe_switch_tail+0x4 (__schedule=
+0x514)
:|   #end     0x80000000  -677	  0.126  hard_local_irq_enable+0x16 (__ipipe=
_switch_tail+0x2e)
:|   #begin   0x80000001  -677	  0.142  debug_smp_processor_id+0x36 (__sche=
dule+0x51d)
:|   #end     0x80000001  -677	  0.130  debug_smp_processor_id+0x82 (__sche=
dule+0x51d)
:    #func                -677	  0.114  finish_task_switch+0x7 (__schedule+=
0x533)
:    #func                -676	  0.126  _raw_spin_unlock_irq+0x3 (finish_ta=
sk_switch+0x4a)
:    #func                -676	  0.123  ipipe_unstall_root+0x3 (_raw_spin_u=
nlock_irq+0x12)
:|   #begin   0x80000000  -676	  0.126  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func                -676	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000  -676	  0.115  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func                -676	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock_irq+0x1c)
:    +func                -676	  0.120  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001  -675	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -675	  0.152  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   +begin   0x80000001  -675	  0.142  debug_smp_processor_id+0x36 (__sche=
dule+0x538)
:|   +end     0x80000001  -675	  0.130  debug_smp_processor_id+0x82 (__sche=
dule+0x538)
:    +func                -675	  0.139  _raw_spin_lock_irqsave+0x5 (post_sc=
hedule.part.48+0xc)
:    #func                -675	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func                -675	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -675	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -674	  0.155  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -674	  0.114  post_schedule_idle+0x3 (post_schedu=
le.part.48+0x22)
:    #func                -674	  0.129  __ipipe_spin_unlock_debug+0x3 (post=
_schedule.part.48+0x29)
:    #func                -674	  0.123  _raw_spin_unlock_irqrestore+0x4 (po=
st_schedule.part.48+0x32)
:    #func                -674	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -674	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -674	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -673	  0.127  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -673	  0.120  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000  -673	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func                -673	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000  -673	  0.115  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func                -673	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    +func                -673	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001  -673	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -672	  0.133  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -672	  0.114  sub_preempt_count+0x4 (__schedule+0=
x56c)
:    +func                -672	  0.124  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001  -672	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -672	  0.166  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -672	  0.118  add_preempt_count+0x4 (schedule_pre=
empt_disabled+0x21)
:    +func                -672	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   +begin   0x80000001  -671	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001  -671	  0.169  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func                -671	  0.127  tick_nohz_idle_enter+0x4 (cpu_start=
up_entry+0x24)
:    +func                -671	  0.121  set_cpu_sd_state_idle+0x4 (tick_noh=
z_idle_enter+0x37)
:|   +begin   0x80000001  -671	  0.141  debug_smp_processor_id+0x36 (set_cp=
u_sd_state_idle+0xe)
:|   +end     0x80000001  -671	  0.126  debug_smp_processor_id+0x82 (set_cp=
u_sd_state_idle+0xe)
:    +func                -671	  0.118  __rcu_read_lock+0x3 (set_cpu_sd_sta=
te_idle+0x15)
:    +func                -670	  0.138  __rcu_read_unlock+0x4 (set_cpu_sd_s=
tate_idle+0x4d)
:|   #begin   0x80000001  -670	  0.141  debug_smp_processor_id+0x36 (tick_n=
ohz_idle_enter+0x46)
:|   #end     0x80000001  -670	  0.127  debug_smp_processor_id+0x82 (tick_n=
ohz_idle_enter+0x46)
:    #func                -670	  0.121  __tick_nohz_idle_enter+0x9 (tick_no=
hz_idle_enter+0x5b)
:|   #begin   0x80000001  -670	  0.142  debug_smp_processor_id+0x36 (__tick=
_nohz_idle_enter+0x16)
:|   #end     0x80000001  -670	  0.129  debug_smp_processor_id+0x82 (__tick=
_nohz_idle_enter+0x16)
:    #func                -670	  0.160  ktime_get+0x9 (__tick_nohz_idle_ent=
er+0x1e)
:|   #begin   0x80000001  -669	  0.142  debug_smp_processor_id+0x36 (sched_=
clock_idle_sleep_event+0x8)
:|   #end     0x80000001  -669	  0.145  debug_smp_processor_id+0x82 (sched_=
clock_idle_sleep_event+0x8)
:|   #begin   0x80000001  -669	  0.148  debug_smp_processor_id+0x36 (__cycl=
es_2_ns+0x14)
:|   #end     0x80000001  -669	  0.149  debug_smp_processor_id+0x82 (__cycl=
es_2_ns+0x14)
:|   #begin   0x80000001  -669	  0.154  debug_smp_processor_id+0x36 (__tick=
_nohz_idle_enter+0x3b5)
:|   #end     0x80000001  -669	  0.141  debug_smp_processor_id+0x82 (__tick=
_nohz_idle_enter+0x3b5)
:    #func                -669	  0.135  timekeeping_max_deferment+0x5 (__ti=
ck_nohz_idle_enter+0x108)
:    #func                -668	  0.142  rcu_needs_cpu+0x5 (__tick_nohz_idle=
_enter+0x124)
:|   #begin   0x80000001  -668	  0.142  debug_smp_processor_id+0x36 (irq_wo=
rk_needs_cpu+0xe)
:|   #end     0x80000001  -668	  0.132  debug_smp_processor_id+0x82 (irq_wo=
rk_needs_cpu+0xe)
:    #func                -668	  0.120  get_next_timer_interrupt+0x9 (__tic=
k_nohz_idle_enter+0x147)
:|   #begin   0x80000001  -668	  0.142  debug_smp_processor_id+0x36 (get_ne=
xt_timer_interrupt+0x25)
:|   #end     0x80000001  -668	  0.129  debug_smp_processor_id+0x82 (get_ne=
xt_timer_interrupt+0x25)
:    #func                -668	  0.114  _raw_spin_lock+0x4 (get_next_timer_=
interrupt+0x3f)
:    #func                -668	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck+0x15)
:    #func                -667	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -667	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -667	  0.157  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -667	  0.127  _raw_spin_unlock+0x3 (get_next_time=
r_interrupt+0x158)
:    #func                -667	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
:    #func                -667	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -667	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -666	  0.145  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -666	  0.121  hrtimer_get_next_event+0x9 (get_nex=
t_timer_interrupt+0x162)
:|   #begin   0x80000001  -666	  0.142  debug_smp_processor_id+0x36 (hrtime=
r_get_next_event+0x18)
:|   #end     0x80000001  -666	  0.127  debug_smp_processor_id+0x82 (hrtime=
r_get_next_event+0x18)
:    #func                -666	  0.142  _raw_spin_lock_irqsave+0x5 (hrtimer=
_get_next_event+0x26)
:    #func                -666	  0.114  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func                -666	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -666	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -665	  0.141  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -665	  0.117  __ipipe_spin_unlock_debug+0x3 (hrti=
mer_get_next_event+0x97)
:    #func                -665	  0.123  _raw_spin_unlock_irqrestore+0x4 (hr=
timer_get_next_event+0xa0)
:    #func                -665	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -665	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -665	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -665	  0.151  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -664	  0.115  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func                -664	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -664	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -664	  0.187  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -664	  0.130  nohz_balance_enter_idle+0x3 (__tick=
_nohz_idle_enter+0x24a)
:    #func                -664	  0.124  calc_load_enter_idle+0x4 (__tick_no=
hz_idle_enter+0x24f)
:|   #begin   0x80000001  -664	  0.142  debug_smp_processor_id+0x36 (calc_l=
oad_enter_idle+0x13)
:|   #end     0x80000001  -663	  0.132  debug_smp_processor_id+0x82 (calc_l=
oad_enter_idle+0x13)
:    #func                -663	  0.115  hrtimer_start+0x3 (__tick_nohz_idle=
_enter+0x2e1)
:    #func                -663	  0.115  __hrtimer_start_range_ns+0x9 (hrtim=
er_start+0x14)
:    #func                -663	  0.114  lock_hrtimer_base.isra.17+0x6 (__hr=
timer_start_range_ns+0x23)
:    #func                -663	  0.141  _raw_spin_lock_irqsave+0x5 (lock_hr=
timer_base.isra.17+0x1c)
:    #func                -663	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func                -663	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -663	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -662	  0.151  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001  -662	  0.148  debug_smp_processor_id+0x36 (remove=
_hrtimer.part.15+0x1f)
:|   #end     0x80000001  -662	  0.129  debug_smp_processor_id+0x82 (remove=
_hrtimer.part.15+0x1f)
:    #func                -662	  0.126  __remove_hrtimer+0x9 (remove_hrtime=
r.part.15+0x3e)
:    #func                -662	  0.130  hrtimer_force_reprogram+0x9 (__remo=
ve_hrtimer+0x64)
:|   #begin   0x80000001  -662	  0.142  debug_smp_processor_id+0x36 (__hrti=
mer_start_range_ns+0x46)
:|   #end     0x80000001  -662	  0.138  debug_smp_processor_id+0x82 (__hrti=
mer_start_range_ns+0x46)
:    #func                -661	  0.117  ktime_add_safe+0x6 (hrtimer_set_exp=
ires_range_ns+0x21)
:    #func                -661	  0.133  enqueue_hrtimer+0x6 (__hrtimer_star=
t_range_ns+0x155)
:|   #begin   0x80000001  -661	  0.142  debug_smp_processor_id+0x36 (__hrti=
mer_start_range_ns+0x16d)
:|   #end     0x80000001  -661	  0.136  debug_smp_processor_id+0x82 (__hrti=
mer_start_range_ns+0x16d)
:|   #begin   0x80000001  -661	  0.142  debug_smp_processor_id+0x36 (__hrti=
mer_start_range_ns+0x192)
:|   #end     0x80000001  -661	  0.135  debug_smp_processor_id+0x82 (__hrti=
mer_start_range_ns+0x192)
:    #func                -661	  0.114  tick_program_event+0x4 (__hrtimer_s=
tart_range_ns+0x20a)
:    #func                -661	  0.124  clockevents_program_event+0x9 (tick=
_program_event+0x24)
:    #func                -660	  0.151  ktime_get+0x9 (clockevents_program_=
event+0x7a)
:    #func                -660	  0.118  xnarch_next_htick_shot+0x5 (clockev=
ents_program_event+0xeb)
:|   #begin   0x80000000  -660	  0.170  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  *#func                -660	  0.129  xntimer_start_aperiodic+0x9 (xnarch=
_next_htick_shot+0x33)
:|  *#func                -660	  0.141  xnarch_ns_to_tsc+0x6 (xntimer_start=
_aperiodic+0x67)
:|  *#func                -660	  0.127  xntimer_next_local_shot+0x9 (xntime=
r_start_aperiodic+0x11a)
:|  *#event   tick@732804 -660	  0.117  xntimer_next_local_shot+0xca (xntim=
er_start_aperiodic+0x11a)
:|  *#func                -659	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  *#func                -659	  0.239  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  *#func                -659	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|   #end     0x80000000  -659	  0.148  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:    #func                -659	  0.117  __ipipe_spin_unlock_debug+0x3 (unlo=
ck_hrtimer_base.isra.18+0x10)
:    #func                -659	  0.126  _raw_spin_unlock_irqrestore+0x4 (un=
lock_hrtimer_base.isra.18+0x1b)
:    #func                -659	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -658	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -658	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -658	  0.149  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -658	  0.115  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func                -658	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001  -658	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -658	  0.152  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func                -657	  0.120  ipipe_unstall_root+0x3 (tick_nohz_i=
dle_enter+0x60)
:|   #begin   0x80000000  -657	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func                -657	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000  -657	  0.130  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:|   +begin   0x80000001  -657	  0.142  debug_smp_processor_id+0x36 (cpu_st=
artup_entry+0x33)
:|   +end     0x80000001  -657	  0.151  debug_smp_processor_id+0x82 (cpu_st=
artup_entry+0x33)
:    #func                -657	  0.114  arch_cpu_idle_enter+0x3 (cpu_startu=
p_entry+0x59)
:    #func                -657	  0.120  local_touch_nmi+0x3 (arch_cpu_idle_=
enter+0xd)
:    #func                -656	  0.148  rcu_idle_enter+0x5 (cpu_startup_ent=
ry+0x70)
:|   #begin   0x80000001  -656	  0.151  debug_smp_processor_id+0x36 (rcu_id=
le_enter+0x1b)
:|   #end     0x80000001  -656	  0.133  debug_smp_processor_id+0x82 (rcu_id=
le_enter+0x1b)
:    #func                -656	  0.118  rcu_eqs_enter_common.isra.49+0x6 (r=
cu_idle_enter+0x76)
:|   #begin   0x80000001  -656	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_enter_common.isra.49+0x7d)
:|   #end     0x80000001  -656	  0.141  debug_smp_processor_id+0x82 (rcu_eq=
s_enter_common.isra.49+0x7d)
:    #func                -656	  0.112  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func                -655	  0.120  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001  -655	  0.173  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001  -655	  0.155  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001  -655	  0.152  debug_smp_processor_id+0x36 (cpu_st=
artup_entry+0x75)
:|   #end     0x80000001  -655	  0.127  debug_smp_processor_id+0x82 (cpu_st=
artup_entry+0x75)
:    #func                -655	  0.120  ipipe_unstall_root+0x3 (cpu_startup=
_entry+0x8d)
:|   #begin   0x80000000  -655	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func                -654	  0.187  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000  -654! 586.646  hard_local_irq_enable+0x16 (ipipe_=
unstall_root+0x2b)
:|   +begin   0x00000051   -68	  0.173  common_interrupt+0x39 (cpu_startup_=
entry+0x91)
:|   +func                 -67	  0.148  __ipipe_handle_irq+0x7 (common_inte=
rrupt+0x40)
:|   +func                 -67	  0.124  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func                 -67	  0.253  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func                 -67	  0.164  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func                 -67	  0.138  irq_to_desc+0x3 (__ipipe_dispatch_i=
rq+0x26)
:|   +func                 -67	  0.155  irq_to_desc+0x3 (__ipipe_dispatch_i=
rq+0x216)
:|   +func                 -66	  0.118  __ipipe_ack_fasteoi_irq+0x3 (__ipip=
e_dispatch_irq+0xa9)
:|   +func                 -66	  0.129  hold_ioapic_irq+0x4 (__ipipe_ack_fa=
steoi_irq+0x10)
:|   +func                 -66	  0.124  io_apic_modify_irq.isra.9+0x7 (hold=
_ioapic_irq+0x41)
:|   +func                 -66	  0.112  native_io_apic_read+0x4 (io_apic_re=
ad+0x9)
:|   +func                 -66!  46.038  io_apic_base+0x3 (native_io_apic_r=
ead+0x10)
:|   +func                 -20	  0.121  native_io_apic_modify+0x5 (io_apic_=
modify_irq.isra.9+0x36)
:|   +func                 -20	  0.242  io_apic_base+0x3 (native_io_apic_mo=
dify+0x13)
:|   +func                 -20	  0.114  io_apic_sync+0x3 (io_apic_modify_ir=
q.isra.9+0x41)
:|   +func                 -19+   9.077  io_apic_base+0x3 (io_apic_sync+0xf)
:|   +func                 -10	  0.167  ack_apic_level+0x5 (hold_ioapic_irq=
+0x50)
:|   +func                 -10	  0.120  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   +func                 -10	  0.299  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                 -10	  0.112  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func                 -10	  0.175  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                 -10	  0.144  xnintr_irq_handler+0x9 (__ipipe_dis=
patch_irq+0x182)
:|  # func                  -9	  0.120  irqhandler_fpga+0x9 [sigmatek_lrt] =
(xnintr_irq_handler+0x78)
:|  # func                  -9	  0.160  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x5a [sigmatek_lrt])
:|  # func                  -9+   4.286  ___xnpod_lock_sched+0x4 (__xnpod_l=
ock_sched+0x19 [sigmatek_lrt])
:|  # func                  -5	  0.163  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0xe6 [sigmatek_lrt])
:|  # func                  -5+   4.623  lrtdrv_monitoring_irq+0x4 [sigmate=
k_lrt] (irqhandler_fpga+0x13d [sigmatek_lrt])
:|  # func                   0	  0.142  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x1a4 [sigmatek_lrt])
:|  # func                   0	  0.194  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x1d2 [sigmatek_lrt])
:|  # func                   0	  0.178  xnarch_tsc_to_ns+0x6 (irqhandler_fp=
ga+0x1e8 [sigmatek_lrt])
<|  # freeze  0x000106b1     0	  0.256  irqhandler_fpga+0x1ff [sigmatek_lrt=
] (xnintr_irq_handler+0x78)
 |  # func                   0	  0.268  printk+0x9 (irqhandler_fpga+0x214 [=
sigmatek_lrt])
 |  # func                   0	  1.579  __ipipe_spin_lock_irqsave+0x6 (prin=
tk+0x140)
 |  # func                   2	  0.160  __ipipe_spin_unlock_irqrestore+0x4 =
(printk+0x17b)
 |  # func                   2	  0.138  ipipe_raise_irq+0x8 (printk+0x189)
 |  # func                   2	  0.141  irq_hook_handler+0x5 [sigmatek_lrt]=
 (ipipe_raise_irq+0x36)
 |  # func                   2	  0.164  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
 |  # func                   2	  0.139  __ipipe_handle_irq+0x7 (ipipe_raise=
_irq+0x3e)
 |  # func                   2	  0.121  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
 |  # func                   2	  0.167  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
 |  # func                   3	  0.000  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
