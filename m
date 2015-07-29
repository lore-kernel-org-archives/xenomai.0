References: <55B8CB97.2030209@xenomai.org>
 <1736746819.4999197.1438182886239.JavaMail.yahoo@mail.yahoo.com>
 <55B91B0C.9030701@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55B91E8E.9010304@xenomai.org>
Date: Wed, 29 Jul 2015 20:42:22 +0200
MIME-Version: 1.0
In-Reply-To: <55B91B0C.9030701@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-3.0-rc5 : binding named semaphores from
 external process
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik_bayart@yahoo.co.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/29/2015 08:27 PM, Philippe Gerum wrote:
> On 07/29/2015 05:14 PM, Frederik Bayart wrote:
>>>
>>> On Wednesday, 29 July 2015, 14:48, Philippe Gerum <rpm@xenomai.org> wrote:
>>> On 07/29/2015 01:48 PM, Frederik Bayart wrote:
>>>>> On Wednesday, 29 July 2015, 12:12, Philippe Gerum <rpm@xenomai.org> wrote:
>>>>>
>>>>>
>>>>> On 07/28/2015 05:19 PM, Frederik Bayart wrote:
>>>>>>>> ./stest --session=foo 1
>>>>>>>>
>>>>>>>> The first process binds to the named semaphore which is not yet created. According to the description of rt_sem_bind,  if the object does not exist on entry, the caller may block until a semaphore of the given name is created.
>>>>>>>>
>>>>>>>> So based on this description, I would I expect that if the second process is started, the first process would bind and continue and blocks in the p operation. The same for the 2nd process. Is this correct ? At the moment, if I start the 2nd process, I get a segfault in rt_sem_create :
>>>>>>>>
>>>>>>>> [ 9758.887921] [Xenomai] switching main to secondary mode after exception #14 from user-space at 0x7f6ad8c4a43e (pid 9256)
>>>>>>>> [ 9758.887930] main[9256]: segfault at 7f903bf6e038 ip 00007f6ad8c4a43e sp 00007fffbd2c2eb8 error 6 in libcobalt.so.2.0.0[7f6ad8c3d000+1e000]
>>>>>>>>
>>>>>>>
>>>>>>> Looking at the copperplate code, yep, this definitely can't work. Ok,
>>>>>>> queued.
>>>>>>
>>>>>> I noticed also :
>>>>>>
>>>>>>  ./stest --session=foo 1
>>>>>>  ./stest --session=foo 0
>>>>>>
>>>>>> Both processes are waiting in rt_sem_p . The first process catches SIGINT, the second doesn't. If you press CTRL+C on the second process it stops but also the first process is falling through the rt_sem_p although no rt_sem_v is raised.
>>>>>
>>>>>
>>>>> Spurious wake up in the Cobalt kernel when aborting a sem wait operation
>>>>> due to a signal/unblock event, that is the reason why I could not see
>>>>> this from a Mercury setup. This is fixed in the -next branch.
>>>>>
>>>>>> At that moment no process is pending on rt_sem_p anymore. But if you do then a rt_sem_inquire, nwaiters is still 1.
>>>>>
>>>>> I don't observe this one. Assuming you enabled the registry, what does
>>>>> /var/run/xenomai/.../alchemy/semaphores/semtestsem tell you about the
>>>>> sema4 value?
>>>>>
>>>>
>>>> When I start my processes, I don't see this alchemy directory in my registry. Any suggestion why ?
>>>>
>>>> The output of 'xeno-config --info' is :
>>>>
>>>> Xenomai version: Xenomai/cobalt v3.0-rc5 --
>>>> Linux dev-x10sae 3.18.12-x86-64-xeno-3.0.rc5 #1 SMP PREEMPT Fri Jul 10 12:29:14 CEST 2015 x86_64 GNU/Linux
>>>> Kernel parameters: BOOT_IMAGE=/boot/vmlinuz-3.18.12-x86-64-xeno-3.0.rc5 root=UUID=fc8ecefa-fc73-487f-a045-cffa99c38a11 ro quiet console=tty0 console=ttyS0,115200n8
>>>> I-pipe release #1 detected
>>>> Cobalt core 3.0-rc5 detected
>>>> Compiler: gcc version 4.9.2 (Debian 4.9.2-10)
>>>> Build args: --prefix=/usr --includedir=/usr/include/xenomai --mandir=/usr/share/man --with-testdir=/usr/lib/xenomai/testsuite --with-core=cobalt --enable-smp --enable-pshared --enable-registry --build x86_64-linux-gnu build_alias=x86_64-linux-gnu
>>>>
>>>> I have only this in the registery :
>>>>
>>>> find /var/run/xenomai
>>>>
>>>> /var/run/xenomai
>>>> /var/run/xenomai/root
>>>> /var/run/xenomai/root/foo
>>>> /var/run/xenomai/root/foo/6210
>>>> /var/run/xenomai/root/foo/6203
>>>> /var/run/xenomai/root/foo/system
>>>>
>>>>
>>>> In attachment my latest version of stest.c to be sure, there are only small modifications.
>>>>
>>>> Below the output of the first process
>>>>
>>>> sudo ./stest --session=foo 1
>>>> stest.c:82: __XENO_COMPAT__ not defined, create = 1
>>>> stest.c:121: enter CTRL+C to continue...
>>>> stest.c:43: binding sem semtestsem...
>>>> stest.c:51: calling rt_sem_p...
>>>> ========= Now CTRL+C on the second (other) process ======================
>>>> stest.c:60: rt_sem_p passed
>>>
>>> You must mean interrupting the one enabling create mode, i.e.
>>> --session=foo 1. ^C on the other one will terminate it immediately since
>>> it does not trap this signal, leaving the first one hanging on
>>> rt_sem_p() as expected (with the latest fix applied).
>>>
>>>> ========= Now CTRL+C on this (first) process to interrupt the wait loop =========
>>>> stest.c:32: signal(2)
>>>> stest.c:146: nwaiters = 1
>>>> stest.c:147: count = 0
>>>> stest.c:152: calling rt_sem_v 1...
>>>> stest.c:161: rt_sem_v called
>>>> stest.c:186: nwaiters = 0
>>>> stest.c:187: count = 0
>>>>
>>>
>>> Looking at your code, I fail to see any issue with this trace output.
>>> What output would you expect instead?
>>
>> I switched to rc6 (kernel and libraries)
>>
>> Concerning the registry : 
>>
>> The fuse module is loaded :
>> $ lsmod | grep fuse
>> fuse                   87410  7 
>>
>> $ sudo ./stest  --dump-config|grep REGISTRY
>> based on Xenomai/cobalt v3.0-rc6 -- 
>> CONFIG_XENO_REGISTRY=1
>> CONFIG_XENO_REGISTRY_ROOT="/var/run/xenomai"
>>
>> Is this what I'm supposed to see ?
>>
>> Before start of the processes :
>>
>> $ find /var/run/xenomai/
>> /var/run/xenomai/
>> /var/run/xenomai/root
>>
>> After start of processes
>>
>> $ find /var/run/xenomai/
>> /var/run/xenomai/
>> /var/run/xenomai/root
>> /var/run/xenomai/root/foo
>> /var/run/xenomai/root/foo/4910
>> /var/run/xenomai/root/foo/4899
>> /var/run/xenomai/root/foo/system
>>
>> $ mount | grep xenomai
>> sysregd on /run/xenomai/root/foo/system type fuse.sysregd (rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions)
>> stest on /run/xenomai/root/foo/4899 type fuse.stest (rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions)
>> stest on /run/xenomai/root/foo/4910 type fuse.stest (rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions)
>>
>> So I haven't any idea why I don't see more subdirectories.
>>
>> Now concerning the semaphore :
>>
>> $cat /proc/xenomai/sched/threads | grep rt
>> 3  4899   rt     cobalt      0   -             X          main
>> 3  4902   rt     cobalt      0   -             X          sysregd
>> 3  4904   rt     cobalt      0   -             X          sysregd
>> 3  4906   rt     cobalt      0   -             X          stest
>> 3  4907   rt     cobalt    256   -             W          remote-agent
>> 3  4908   rt     cobalt     40   -             W          4899test
>> 0  4910   rt     cobalt      0   -             X          main
>> 0  4912   rt     cobalt      0   -             X          stest
>> 0  4913   rt     cobalt    256   -             W          remote-agent
>> 0  4914   rt     cobalt     40   -             W          4910test
>>
>>
>> Now I enter CTRL+C on the second process (the non-creating process). The SIGINT signal is not catched in this process. The second process is ended.
>>
>> $cat /proc/xenomai/sched/threads | grep rt
>> 3  4899   rt     cobalt      0   -             X          main
>> 3  4902   rt     cobalt      0   -             X          sysregd
>> 3  4904   rt     cobalt      0   -             X          sysregd
>> 3  4906   rt     cobalt      0   -             X          stest
>> 3  4907   rt     cobalt    256   -             W          remote-agent
>>
>>
>> The rt_sem_p call in the first process also returns with return value 0.
>> This has as consequence that the task 4899test of the first process is also ended.
> 
> Please merge the commit on top of -rc6 I mentioned this morning, which
> fixes the spurious wake up:
> 
> http://git.xenomai.org/xenomai-3.git/commit/?h=next&id=081cbb8b150f30a019245dfb0e2f0b92cc7f2dfd
> 

Actually, I did not mention it, that's why we don't seem to be on the
same page, sorry for this. We should resume the discussion from the
situation obtained with this commit on top of -rc6.

-- 
Philippe.

