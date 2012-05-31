Message-ID: <4FC71FF6.4020103@xenomai.org>
Date: Thu, 31 May 2012 09:38:30 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4FA87007.1040105@ebus.com> <4FA875BF.7040103@xenomai.org>
	<4FC6ADD6.8000509@ebus.com> <4FC716C1.2030701@xenomai.org>
In-Reply-To: <4FC716C1.2030701@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-help] Debugging oops in xnheap_init
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Doug Brunner <dbrunner@ebus.com>, xenomai@xenomai.org

On 05/31/2012 08:59 AM, Gilles Chanteperdrix wrote:
> On 05/31/2012 01:31 AM, Doug Brunner wrote:
>> On 05/07/2012 06:24 PM, Gilles Chanteperdrix wrote:
>>> On 05/08/2012 02:59 AM, Doug Brunner wrote:
>>>> I just got an oops from running one of my POSIX skin RT applications:
>>>>
>>>>       [183168.735823] BUG: unable to handle kernel paging request at 00700bf5
>>>>       [183168.737436] IP: [<c10c091f>] xnheap_init+0x1cf/0x210
>>>>       [183168.738604] *pde = 00000000
>>>>       [183168.739406] Oops: 0002 [#1] PREEMPT
>>>>       [183168.740173] last sysfs file: /sys/devices/virtual/bdi/0:19/uevent
>>>>       [183168.740173] Modules linked in: e1000 xeno_rtipc lxfb cfbcopyarea
>>>> cfbimgblt cfbfillrect binfmt_misc psmouse usbhid serio_raw hid ata_piix
>>>> [last unloaded: e1000]
>>>>       [183168.740173]
>>>>       [183168.740173] Pid: 2557, comm: eve_dal Not tainted 2.6.37 #1 /Bochs
>>>>       [183168.740173] EIP: 0060:[<c10c091f>] EFLAGS: 00010246 CPU: 0
>>>>       [183168.740173] EIP is at xnheap_init+0x1cf/0x210
>>>>       [183168.740173] EAX: 00700bf1 EBX: eed0e210 ECX: eed0e730 EDX: eed0e2fc
>>>>       [183168.740173] ESI: 00000000 EDI: 00000000 EBP: eed27da4 ESP: eed27d7c
>>>>       [183168.740173]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
>>>>       [183168.740173] Process eve_dal (pid: 2557, ti=eed26000
>>>> task=f5773280 task.ti=eed26000)
>>>>       [183168.740173] I-pipe domain Linux
>>>>       [183168.740173] Stack:
>>>>       [183168.740173]  eed0e304 00000030 c157d4a9 eed0e210 eed0e2fc
>>>> eed0e2fc 0000003e 00000000
>>>>       [183168.740173]  f85ea000 eed0e210 eed27dc8 c10c0c44 00001000
>>>> 00000000 f85aa000 00040000
>>>>       [183168.740173]  eed0e200 fffffff4 eed0e210 eed27df0 c10cf198
>>>> eed27de4 c1058b86 eed27f20
>>>>       [183168.740173] Call Trace:
>>>>       [183168.740173]  [<c10c0c44>] ? xnheap_init_mapped+0xd4/0x210
>>>>       [183168.740173]  [<c10cf198>] ? xnshadow_sys_event+0x68/0x210
>>>>       [183168.740173]  [<c1058b86>] ? commit_creds+0xe6/0x190
>>>>       [183168.740173]  [<c10cefa3>] ? xnshadow_sys_bind+0x293/0x420
>>>>       [183168.740173]  [<c114b22e>] ? __d_lookup+0x12e/0x160
>>>>       [183168.740173]  [<c114bf96>] ? dput+0x66/0x1b0
>>>>       [183168.740173]  [<c1141b9e>] ? path_to_nameidata+0x1e/0x50
>>>>       [183168.740173]  [<c1143e02>] ? link_path_walk+0x422/0x7c0
>>>>       [183168.740173]  [<c11425f5>] ? path_put+0x25/0x30
>>>>       [183168.740173]  [<c109559d>] ? __ipipe_restore_root+0x1d/0x30
>>>>       [183168.740173]  [<c112d537>] ? kmem_cache_free+0xa7/0x100
>>>>       [183168.740173]  [<c11423ea>] ? putname+0x2a/0x40
>>>>       [183168.740173]  [<c1144cfa>] ? user_path_at+0x4a/0x80
>>>>       [183168.740173]  [<c10cd82d>] ? losyscall_event+0xad/0x200
>>>>       [183168.740173]  [<c1095035>] ? __ipipe_dispatch_event+0xb5/0x170
>>>>       [183168.740173]  [<c10cd780>] ? losyscall_event+0x0/0x200
>>>>       [183168.740173]  [<c10166d5>] ? __ipipe_syscall_root+0x45/0xd0
>>>>       [183168.740173]  [<c145526d>] ? system_call+0x2d/0x53
>>>>       [183168.740173] Code: 24 e8 a6 cc 19 00 fa 8b 0d 28 36 61 c1 0f ba
>>>> 2d c0 1b 61 c1 00 19 f6 8b 55 e8 83 e6 01 89 8b f0 00 00 00 8b 01 89 83
>>>> ec 00 00 00<89>    50 04 31 c0 89 11 8b 15 c0 1b 61 c1 83 05 2c 36 61 c1 01 83
>>>>       [183168.740173] EIP: [<c10c091f>] xnheap_init+0x1cf/0x210 SS:ESP
>>>> 0068:eed27d7c
>>>>       [183168.740173] CR2: 0000000000700bf5
>>>>
>>>> As you can see, this happened with kernel 2.6.37, and I built it with
>>>> Xenomai 2.6.0. The offending instruction was at xnheap_init + 463:
>>>>
>>>>       0xc10c090b<xnheap_init+443>:	mov    -0x18(%ebp),%edx
>>>>       0xc10c090e<xnheap_init+446>:	and    $0x1,%esi
>>>>       0xc10c0911<xnheap_init+449>:	mov    %ecx,0xf0(%ebx)
>>>>       0xc10c0917<xnheap_init+455>:	mov    (%ecx),%eax
>>>>       0xc10c0919<xnheap_init+457>:	mov    %eax,0xec(%ebx)
>>>>       0xc10c091f<xnheap_init+463>:	mov    %edx,0x4(%eax)
>>>>       0xc10c0922<xnheap_init+466>:	xor    %eax,%eax
>>>>       0xc10c0924<xnheap_init+468>:	mov    %edx,(%ecx)
>>>>       0xc10c0926<xnheap_init+470>:	mov    0xc1611bc0,%edx
>>>>       0xc10c092c<xnheap_init+476>:	addl   $0x1,0xc161362c
>>>>       0xc10c0933<xnheap_init+483>:	addl   $0x1,0xc17c83e4
>>>>
>>>> This corresponds to ath(xnholder_t *, xnholder_t *) in
>>>> include/xenomai/nucleus/queue.h, line 48:
>>>>
>>>>       43	static inline void ath(xnholder_t *head, xnholder_t *holder)
>>>>       44	{
>>>>       45		/* Inserts the new element right after the heading one  */
>>>>       46		holder->last = head;
>>>>       47		holder->next = head->next;
>>>>       48		holder->next->last = holder;
>>>>       49		head->next = holder;
>>>>       50	}
>>>>
>>>> It's apparently the call to appendq() at
>>>> kernel/xenomai/nucleus/heap.c:332 that does this, with a junk pointer
>>>> dereference. So, heap->stat_link.next is not valid at the time of this
>>>> call, yet it's initialized by the call to inith() on line 319. I don't
>>>> know what would have changed that, unless it's a bad pointer elsewhere
>>>> that caused overwriting of this data. Any ideas where to go from here?
>>>>
>>> If the bug is reproducible, two things you can try:
>>> - enable CONFIG_XENO_OPT_DEBUG_QUEUES
>>> - enable the I-pipe tracer and panic freezes, you should get a trace
>>> when the bug happens.
>>>
>> Hi Gilles,
>>
>> I finally got a bit more information. The crash occurred again today on
>> my testing hardware, so I installed a kernel with I-pipe trace and queue
>> debugging and tried to reproduce. I didn't get the same error, and the
>> kernel didn't oops, but I did get some interesting-looking information
>> in the log. It looks like something bad was happening with XDDP, but I
>> can't figure out what. Hopefully the attached log file will get through.
> 
> Nothing seems obvious from the trace. Also, you may want to increase the
> trace to 10000 points for instance, in order to have more history. But
> if the issue is a memory corruption, chances are that it may not be enough.
> 

nklock is leaking in the traces, we should not be holding the superlock on
entry to xnbufd_copy_to_kmem. Doug, please apply the patch below, with
CONFIG_XENO_OPT_DEBUG_XNLOCK enabled. This may tell us which routine on the
current code path grabbed that lock.

diff --git a/ksrc/nucleus/bufd.c b/ksrc/nucleus/bufd.c
index c482b9d..8fd2ec5 100644
--- a/ksrc/nucleus/bufd.c
+++ b/ksrc/nucleus/bufd.c
@@ -371,6 +371,9 @@ ssize_t xnbufd_copy_to_kmem(void *to, struct xnbufd *bufd, size_t len)
 
 	if (xnpod_userspace_p() && !xnpod_asynch_p() &&
 	    current->mm == bufd->b_mm) {
+		if (xnlock_is_owner(&nklock))
+			printk(KERN_ERR "Xenomai: nklock held: %s:%u (%s())\n",
+			       nklock.file, nklock.line, nklock.function);
 		XENO_BUGON(NUCLEUS, xnlock_is_owner(&nklock) || spltest());
 		if (__xn_safe_copy_from_user(to, (void __user *)from, len))
 			return -EFAULT;

-- 
Philippe.

