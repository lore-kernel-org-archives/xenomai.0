Message-ID: <4FD9435D.4060203@ebus.com>
Date: Wed, 13 Jun 2012 18:50:21 -0700
From: Doug Brunner <dbrunner@ebus.com>
MIME-Version: 1.0
References: <4FA87007.1040105@ebus.com> <4FA875BF.7040103@xenomai.org>
	<4FC6ADD6.8000509@ebus.com> <4FC716C1.2030701@xenomai.org>
	<4FC71FF6.4020103@xenomai.org>
In-Reply-To: <4FC71FF6.4020103@xenomai.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: Re: [Xenomai] [Xenomai-help] Debugging oops in xnheap_init
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 05/31/2012 12:38 AM, Philippe Gerum wrote:
> On 05/31/2012 08:59 AM, Gilles Chanteperdrix wrote:
>> On 05/31/2012 01:31 AM, Doug Brunner wrote:
>>> On 05/07/2012 06:24 PM, Gilles Chanteperdrix wrote:
>>>> On 05/08/2012 02:59 AM, Doug Brunner wrote:
>>>>> I just got an oops from running one of my POSIX skin RT applications:
>>>>>
>>>>>        [183168.735823] BUG: unable to handle kernel paging request at=
 00700bf5
>>>>>        [183168.737436] IP: [<c10c091f>] xnheap_init+0x1cf/0x210
>>>>>        [183168.738604] *pde =3D 00000000
>>>>>        [183168.739406] Oops: 0002 [#1] PREEMPT
>>>>>        [183168.740173] last sysfs file: /sys/devices/virtual/bdi/0:19=
/uevent
>>>>>        [183168.740173] Modules linked in: e1000 xeno_rtipc lxfb cfbco=
pyarea
>>>>> cfbimgblt cfbfillrect binfmt_misc psmouse usbhid serio_raw hid ata_pi=
ix
>>>>> [last unloaded: e1000]
>>>>>        [183168.740173]
>>>>>        [183168.740173] Pid: 2557, comm: eve_dal Not tainted 2.6.37 #1=
 /Bochs
>>>>>        [183168.740173] EIP: 0060:[<c10c091f>] EFLAGS: 00010246 CPU: 0
>>>>>        [183168.740173] EIP is at xnheap_init+0x1cf/0x210
>>>>>        [183168.740173] EAX: 00700bf1 EBX: eed0e210 ECX: eed0e730 EDX:=
 eed0e2fc
>>>>>        [183168.740173] ESI: 00000000 EDI: 00000000 EBP: eed27da4 ESP:=
 eed27d7c
>>>>>        [183168.740173]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
>>>>>        [183168.740173] Process eve_dal (pid: 2557, ti=3Deed26000
>>>>> task=3Df5773280 task.ti=3Deed26000)
>>>>>        [183168.740173] I-pipe domain Linux
>>>>>        [183168.740173] Stack:
>>>>>        [183168.740173]  eed0e304 00000030 c157d4a9 eed0e210 eed0e2fc
>>>>> eed0e2fc 0000003e 00000000
>>>>>        [183168.740173]  f85ea000 eed0e210 eed27dc8 c10c0c44 00001000
>>>>> 00000000 f85aa000 00040000
>>>>>        [183168.740173]  eed0e200 fffffff4 eed0e210 eed27df0 c10cf198
>>>>> eed27de4 c1058b86 eed27f20
>>>>>        [183168.740173] Call Trace:
>>>>>        [183168.740173]  [<c10c0c44>] ? xnheap_init_mapped+0xd4/0x210
>>>>>        [183168.740173]  [<c10cf198>] ? xnshadow_sys_event+0x68/0x210
>>>>>        [183168.740173]  [<c1058b86>] ? commit_creds+0xe6/0x190
>>>>>        [183168.740173]  [<c10cefa3>] ? xnshadow_sys_bind+0x293/0x420
>>>>>        [183168.740173]  [<c114b22e>] ? __d_lookup+0x12e/0x160
>>>>>        [183168.740173]  [<c114bf96>] ? dput+0x66/0x1b0
>>>>>        [183168.740173]  [<c1141b9e>] ? path_to_nameidata+0x1e/0x50
>>>>>        [183168.740173]  [<c1143e02>] ? link_path_walk+0x422/0x7c0
>>>>>        [183168.740173]  [<c11425f5>] ? path_put+0x25/0x30
>>>>>        [183168.740173]  [<c109559d>] ? __ipipe_restore_root+0x1d/0x30
>>>>>        [183168.740173]  [<c112d537>] ? kmem_cache_free+0xa7/0x100
>>>>>        [183168.740173]  [<c11423ea>] ? putname+0x2a/0x40
>>>>>        [183168.740173]  [<c1144cfa>] ? user_path_at+0x4a/0x80
>>>>>        [183168.740173]  [<c10cd82d>] ? losyscall_event+0xad/0x200
>>>>>        [183168.740173]  [<c1095035>] ? __ipipe_dispatch_event+0xb5/0x=
170
>>>>>        [183168.740173]  [<c10cd780>] ? losyscall_event+0x0/0x200
>>>>>        [183168.740173]  [<c10166d5>] ? __ipipe_syscall_root+0x45/0xd0
>>>>>        [183168.740173]  [<c145526d>] ? system_call+0x2d/0x53
>>>>>        [183168.740173] Code: 24 e8 a6 cc 19 00 fa 8b 0d 28 36 61 c1 0=
f ba
>>>>> 2d c0 1b 61 c1 00 19 f6 8b 55 e8 83 e6 01 89 8b f0 00 00 00 8b 01 89 =
83
>>>>> ec 00 00 00<89>     50 04 31 c0 89 11 8b 15 c0 1b 61 c1 83 05 2c 36 6=
1 c1 01 83
>>>>>        [183168.740173] EIP: [<c10c091f>] xnheap_init+0x1cf/0x210 SS:E=
SP
>>>>> 0068:eed27d7c
>>>>>        [183168.740173] CR2: 0000000000700bf5
>>>>>
>>>>> As you can see, this happened with kernel 2.6.37, and I built it with
>>>>> Xenomai 2.6.0. The offending instruction was at xnheap_init + 463:
>>>>>
>>>>>        0xc10c090b<xnheap_init+443>:	mov    -0x18(%ebp),%edx
>>>>>        0xc10c090e<xnheap_init+446>:	and    $0x1,%esi
>>>>>        0xc10c0911<xnheap_init+449>:	mov    %ecx,0xf0(%ebx)
>>>>>        0xc10c0917<xnheap_init+455>:	mov    (%ecx),%eax
>>>>>        0xc10c0919<xnheap_init+457>:	mov    %eax,0xec(%ebx)
>>>>>        0xc10c091f<xnheap_init+463>:	mov    %edx,0x4(%eax)
>>>>>        0xc10c0922<xnheap_init+466>:	xor    %eax,%eax
>>>>>        0xc10c0924<xnheap_init+468>:	mov    %edx,(%ecx)
>>>>>        0xc10c0926<xnheap_init+470>:	mov    0xc1611bc0,%edx
>>>>>        0xc10c092c<xnheap_init+476>:	addl   $0x1,0xc161362c
>>>>>        0xc10c0933<xnheap_init+483>:	addl   $0x1,0xc17c83e4
>>>>>
>>>>> This corresponds to ath(xnholder_t *, xnholder_t *) in
>>>>> include/xenomai/nucleus/queue.h, line 48:
>>>>>
>>>>>        43	static inline void ath(xnholder_t *head, xnholder_t *holder)
>>>>>        44	{
>>>>>        45		/* Inserts the new element right after the heading one  */
>>>>>        46		holder->last =3D head;
>>>>>        47		holder->next =3D head->next;
>>>>>        48		holder->next->last =3D holder;
>>>>>        49		head->next =3D holder;
>>>>>        50	}
>>>>>
>>>>> It's apparently the call to appendq() at
>>>>> kernel/xenomai/nucleus/heap.c:332 that does this, with a junk pointer
>>>>> dereference. So, heap->stat_link.next is not valid at the time of this
>>>>> call, yet it's initialized by the call to inith() on line 319. I don't
>>>>> know what would have changed that, unless it's a bad pointer elsewhere
>>>>> that caused overwriting of this data. Any ideas where to go from here?
>>>>>
>>>> If the bug is reproducible, two things you can try:
>>>> - enable CONFIG_XENO_OPT_DEBUG_QUEUES
>>>> - enable the I-pipe tracer and panic freezes, you should get a trace
>>>> when the bug happens.
>>>>
>>> Hi Gilles,
>>>
>>> I finally got a bit more information. The crash occurred again today on
>>> my testing hardware, so I installed a kernel with I-pipe trace and queue
>>> debugging and tried to reproduce. I didn't get the same error, and the
>>> kernel didn't oops, but I did get some interesting-looking information
>>> in the log. It looks like something bad was happening with XDDP, but I
>>> can't figure out what. Hopefully the attached log file will get through.
>> Nothing seems obvious from the trace. Also, you may want to increase the
>> trace to 10000 points for instance, in order to have more history. But
>> if the issue is a memory corruption, chances are that it may not be enou=
gh.
>>
> nklock is leaking in the traces, we should not be holding the superlock on
> entry to xnbufd_copy_to_kmem. Doug, please apply the patch below, with
> CONFIG_XENO_OPT_DEBUG_XNLOCK enabled. This may tell us which routine on t=
he
> current code path grabbed that lock.
>
> diff --git a/ksrc/nucleus/bufd.c b/ksrc/nucleus/bufd.c
> index c482b9d..8fd2ec5 100644
> --- a/ksrc/nucleus/bufd.c
> +++ b/ksrc/nucleus/bufd.c
> @@ -371,6 +371,9 @@ ssize_t xnbufd_copy_to_kmem(void *to, struct xnbufd *=
bufd, size_t len)
>
>   	if (xnpod_userspace_p()&&  !xnpod_asynch_p()&&
>   	current->mm =3D=3D bufd->b_mm) {
> +		if (xnlock_is_owner(&nklock))
> +			printk(KERN_ERR "Xenomai: nklock held: %s:%u (%s())\n",
> +			       nklock.file, nklock.line, nklock.function);
>   		XENO_BUGON(NUCLEUS, xnlock_is_owner(&nklock) || spltest());
>   		if (__xn_safe_copy_from_user(to, (void __user *)from, len))
>   			return -EFAULT;
More interesting results (sorry about the delay, my testing hardware was =

in pieces until this morning). I haven't been able to reproduce the =

second bug (the one which prompted Philippe to suggest the above =

diagnostic patch), but I was able to trigger something similar to the =

first bug. I also have figured out an apparently reliable way to =

reproduce it.

I noticed a discussion on the list recently about the inadvisability of =

enabling KGDB, so I looked in my kernel configuration and found that it =

was turned on. I first tried triggering the bug with the kernel that had =

KGDB enabled; this produced the log attached as eve-log-20120613-01. EIP =

pointed at kernel/xenomai/nucleus/heap.c:332 (interestingly, not inside =

the appendq() call that was a problem before). The system was still =

somewhat responsive, but crippled; disk writes no longer seemed to work. =

Next, I turned off KGDB, and still got the crash, but a much shorter =

log, attached as eve-log-20120613-02. The system was completely locked =

up after this log was output.

The scenario that triggers this is:
1. RT task creates XDDP socket and binds it to minor 0
2. Linux process opens /dev/rtp0
3. RT task is killed; Linux process appears to stay blocked on read() of =

/dev/rtp0
4. New RT task attempts to create XDDP socket and bind it to minor 0
I'm going to try to refine this into a small test case.

Gilles, the kernel is 2.6.37, patched with =

adeos-ipipe-2.6.37.6-x86-2.9-02.patch. Xenomai version is 2.6.0 (since =

that is the latest stable version shown on the wiki).

Thanks,
     --Doug Brunner
-------------- next part --------------
[  262.198260] I-pipe: Detected stalled topmost domain, probably caused by =
a bug.
[  262.198284]         A critical section may have been left unterminated.
[  262.200668] Pid: 1364, comm: eve_dal Not tainted 2.6.37ipipedebug #11
[  262.200668] Call Trace:
[  262.200668]  [<c108b88f>] ipipe_check_context+0x8f/0xb0
[  262.200668]  [<c1003483>] ? ftrace_call+0x5/0x8
[  262.200668]  [<c101710d>] __ipipe_handle_exception+0x1dd/0x270
[  262.200668]  [<c10ba14f>] ? __xnlock_get_irqsave+0xf/0xc0
[  262.200668]  [<c14aa665>] error_code+0x5d/0x6c
[  262.200668]  [<c10ba7cc>] ? xnheap_init+0x35c/0x530
[  262.200668]  [<fa82f576>] xddp_ioctl+0x3d6/0xaf0 [xeno_rtipc]
[  262.200668]  [<fa82e11c>] ? rtipc_ioctl+0xc/0x30 [xeno_rtipc]
[  262.200668]  [<c108efba>] ? ipipe_trace_function+0x2a/0x30
[  262.200668]  [<fa82e132>] rtipc_ioctl+0x22/0x30 [xeno_rtipc]
[  262.200668]  [<c113f114>] __rt_dev_ioctl+0xd4/0xf0
[  262.200668]  [<c108efba>] ? ipipe_trace_function+0x2a/0x30
[  262.200668]  [<c114442d>] sys_rtdm_ioctl+0x2d/0x30
[  262.200668]  [<c10dd7ad>] losyscall_event+0xad/0x200
[  262.200668]  [<c108c5fe>] __ipipe_dispatch_event+0x8e/0x200
[  262.200668]  [<c10dd700>] ? losyscall_event+0x0/0x200
[  262.200668]  [<c1016bd3>] __ipipe_syscall_root+0x43/0x100
[  262.200668]  [<c1002e78>] sysenter_past_esp+0x55/0x6c
[  262.200668] I-pipe tracer log (100 points):
[  262.200668]  |  *+func                    0 ipipe_trace_panic_freeze+0x4=
 (ipipe_check_context+0x4c)
[  262.200668]  |  *+func                   -1 ipipe_check_context+0x7 (__i=
pipe_handle_exception+0x1dd)
[  262.200668]  |  *+func                   -2 __ipipe_handle_exception+0x9=
 (error_code+0x5d)
[  262.200668]  |  *+func                   -4 __xnlock_get_irqsave+0xf (xn=
heap_init+0x340)
[  262.200668]  |   +begin   0x80000000     -6 __xnlock_get_irqsave+0xa3 (x=
nheap_init+0x322)
[  262.200668]      +func                   -6 __xnlock_get_irqsave+0xf (xn=
heap_init+0x322)
[  262.200668]      +func                  -13 memcpy+0x11 (vsnprintf+0x2da)
[  262.200668]  |   +end     0x80000000    -16 __ipipe_restore_pipeline_hea=
d+0x52 (xnlock_put_irqrestore+0xb0)
[  262.200668]  |  *+func                  -17 __ipipe_restore_pipeline_hea=
d+0x6 (xnlock_put_irqrestore+0xb0)
[  262.200668]  |  *+func                  -18 xnlock_put_irqrestore+0x8 (x=
nheap_init+0x2d0)
[  262.200668]  |   +begin   0x80000000    -19 __xnlock_get_irqsave+0xa3 (x=
nheap_init+0x29f)
[  262.200668]      +func                  -20 __xnlock_get_irqsave+0xf (xn=
heap_init+0x29f)
[  262.200668]  |   +end     0x80000000    -20 __ipipe_restore_pipeline_hea=
d+0x52 (xnlock_put_irqrestore+0xb0)
[  262.200668]  |  *+func                  -21 __ipipe_restore_pipeline_hea=
d+0x6 (xnlock_put_irqrestore+0xb0)
[  262.200668]  |  *+func                  -23 xnlock_put_irqrestore+0x8 (x=
nheap_init+0x286)
[  262.200668]  |   +begin   0x80000000    -24 __xnlock_get_irqsave+0xa3 (x=
nheap_init+0x20e)
[  262.200668]      +func                  -25 __xnlock_get_irqsave+0xf (xn=
heap_init+0x20e)
[  262.200668]      +func                 -470 xnheap_init+0xf (xddp_ioctl+=
0x3d6 [xeno_rtipc])
[  262.200668]      +func                 -472 ipipe_check_context+0x7 (sub=
_preempt_count+0x15)
[  262.200668]  |   +end     0x80000000   -473 __ipipe_unstall_root+0x45 (_=
_ipipe_restore_root+0x2d)
[  262.200668]  |   #func                 -474 ipipe_check_context+0x7 (__i=
pipe_unstall_root+0x19)
[  262.200668]  |   #begin   0x80000000   -475 __ipipe_unstall_root+0x53 (_=
_ipipe_restore_root+0x2d)
[  262.200668]      #func                 -475 __ipipe_unstall_root+0x3 (__=
ipipe_restore_root+0x2d)
[  262.200668]      #func                 -476 ipipe_check_context+0x7 (__i=
pipe_restore_root+0x15)
[  262.200668]      #func                 -477 __ipipe_restore_root+0x4 (__=
ipipe_pin_range_globally+0x14f)
[  262.200668]      #func                 -478 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -479 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -480 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -481 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -482 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -483 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -484 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -485 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -486 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -487 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -488 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -489 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -490 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -491 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -492 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -493 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -494 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -495 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -496 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -497 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -498 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -499 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -500 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -501 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -502 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -503 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -504 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -505 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -506 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -507 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -508 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -509 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -510 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -511 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -512 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -513 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -514 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -515 ipipe_check_context+0x7 (add=
_preempt_count+0x15)
[  262.200668]      +func                 -516 ipipe_check_context+0x7 (__i=
pipe_pin_range_globally+0x59)
[  262.200668]      +func                 -517 ipipe_check_context+0x7 (sub=
_preempt_count+0x15)
[  262.200668]  |   +end     0x80000000   -518 __ipipe_unstall_root+0x45 (_=
_ipipe_restore_root+0x2d)
[  262.200668]  |   #func                 -518 ipipe_check_context+0x7 (__i=
pipe_unstall_root+0x19)
[  262.200668]  |   #begin   0x80000000   -519 __ipipe_unstall_root+0x53 (_=
_ipipe_restore_root+0x2d)
[  262.200668]      #func                 -520 __ipipe_unstall_root+0x3 (__=
ipipe_restore_root+0x2d)
[  262.200668]      #func                 -521 ipipe_check_context+0x7 (__i=
pipe_restore_root+0x15)
[  262.200668]      #func                 -521 __ipipe_restore_root+0x4 (__=
ipipe_pin_range_globally+0x14f)
[  262.200668]      #func                 -523 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -524 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -525 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -526 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -527 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -528 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -529 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -531 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -532 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -533 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -534 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -535 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -536 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -537 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -539 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -540 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -541 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -542 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -543 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -544 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -545 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -547 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -548 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -549 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -550 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -551 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -552 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -553 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668]      #func                 -554 page_address+0x9 (__ipipe_pi=
n_range_globally+0xe7)
[  262.200668] BUG: unable to handle kernel NULL pointer dereference at 000=
00004
[  262.200668] IP: [<c10ba7cc>] xnheap_init+0x35c/0x530
[  262.200668] *pde =3D 00000000 =

[  262.200668] Oops: 0000 [#1] PREEMPT =

[  262.200668] last sysfs file: /sys/bus/pnp/drivers/xeno_16550A/uevent
[  262.200668] Modules linked in: xeno_rtipc xeno_16550A xeno_can_isa xeno_=
can_sja1000 lxfb cfbcopyarea cfbimgblt cfbfillrect binfmt_misc snd_cs5535au=
dio snd_ac97_codec ac97_bus snd_pcm usbhid snd_timer e100 hid snd soundcore=
 snd_page_alloc cs5535_mfgpt serio_raw cs5535_gpio pata_cs5536
[  262.200668] =

[  262.200668] Pid: 1364, comm: eve_dal Not tainted 2.6.37ipipedebug #11 /
[  262.200668] EIP: 0060:[<c10ba7cc>] EFLAGS: 00010293 CPU: 0
[  262.200668] EIP is at xnheap_init+0x35c/0x530
[  262.200668] EAX: 00000001 EBX: f5023644 ECX: 00000000 EDX: c14bc3f5
[  262.200668] ESI: 00000002 EDI: 00000005 EBP: f5053e3c ESP: f5053e0c
[  262.200668]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
[  262.200668] Process eve_dal (pid: 1364, ti=3Df5052000 task=3Df50ebf20 ta=
sk.ti=3Df5052000)
[  262.200668] I-pipe domain Linux
[  262.200668] Stack:
[  262.200668]  c14bc3f5 00000030 c15d4f93 f5023644 00000000 f503aae0 f5023=
674 00000000
[  262.200668]  f5023778 00000000 f503aae0 f5023600 f5053ee0 fa82f576 00000=
200 00000054
[  262.200668]  00000000 00000082 00000082 00000000 f6802500 00000282 f5023=
644 faccf000
[  262.200668] Call Trace:
[  262.200668]  [<fa82f576>] ? xddp_ioctl+0x3d6/0xaf0 [xeno_rtipc]
[  262.200668]  [<fa82e11c>] ? rtipc_ioctl+0xc/0x30 [xeno_rtipc]
[  262.200668]  [<c108efba>] ? ipipe_trace_function+0x2a/0x30
[  262.200668]  [<fa82e132>] ? rtipc_ioctl+0x22/0x30 [xeno_rtipc]
[  262.200668]  [<c113f114>] ? __rt_dev_ioctl+0xd4/0xf0
[  262.200668]  [<c108efba>] ? ipipe_trace_function+0x2a/0x30
[  262.200668]  [<c114442d>] ? sys_rtdm_ioctl+0x2d/0x30
[  262.200668]  [<c10dd7ad>] ? losyscall_event+0xad/0x200
[  262.200668]  [<c108c5fe>] ? __ipipe_dispatch_event+0x8e/0x200
[  262.200668]  [<c10dd700>] ? losyscall_event+0x0/0x200
[  262.200668]  [<c1016bd3>] ? __ipipe_syscall_root+0x43/0x100
[  262.200668]  [<c1002e78>] ? sysenter_past_esp+0x55/0x6c
[  262.200668] Code: b5 7e c1 c7 04 24 f5 c3 4b c1 e8 90 f9 ff ff 8b 0d a4 =
b5 7e c1 8b 3d a8 b5 7e c1 81 f9 a0 b5 7e c1 0f 84 92 00 00 00 39 fe 7d 46 =
<8b> 49 04 83 c6 01 eb e8 e8 27 fa ff ff 8b 4d ec c7 44 24 10 47 =

[  262.200668] EIP: [<c10ba7cc>] xnheap_init+0x35c/0x530 SS:ESP 0068:f5053e=
0c
[  262.200668] CR2: 0000000000000004
[  262.200668] ---[ end trace 42427ce7f2d030b2 ]---
-------------- next part --------------
[  255.185332] Xenomai: corrupted queue, qslot->elems=3D5/5, qslot=3Dc17eb5=
a0 at kernel/xenomai/nucleus/heap.c:332
[  255.189731] =

[  255.189731]  CPU  PID    PRI      TIMEOUT  STAT      NAME
[  255.189731] >  0  0       -1      0        00500080  ROOT
[  255.189731]    0  1351     0      0        00b00380  eve_dal
[  255.189731]    0  1353    99      75327489 00300184  eve_dal
[  255.189731]    0  1354    99      54990725 00300184  eve_dal
[  255.189731]    0  1355    99      205020388 00300184  eve_dal
[  255.189731]    0  1356    99      355059396 00300184  eve_dal
[  255.189731] Master time base: clock=3D132791887205
[  255.189731] I-pipe: Detected stalled topmost domain, probably caused by =
a bug.
[  255.189731]         A critical section may have been left unterminated.
