Subject: Re: segmentation error when a task ends
References: <86e02eb5015e1b4754b8dbe367e62497.squirrel@mail.ige-grenoble.fr>
 <64bfd5ea-6509-f4c9-ec7b-c79fb7619767@xenomai.org>
 <b9873e80d75b24e63dd423288ecca54b.squirrel@mail.ige-grenoble.fr>
 <996f4ac9-17f7-0dd7-9582-72fa47b96e73@siemens.com>
 <985740edf2fc30f8994c45d19f58ca39.squirrel@mail.ige-grenoble.fr>
 <b4f7c3a0-a3b1-017a-e4b0-0179fdb1e3fc@siemens.com>
 <edbf92b20e6ee304e8a008b5d17a3cc3.squirrel@mail.ige-grenoble.fr>
 <f1ea101a-8736-1281-f75c-71f8d3d0cf59@siemens.com>
 <45d2719d6f71d799482e91d0c855acef.squirrel@mail.ige-grenoble.fr>
 <421ef59c-ddaf-63f3-efc8-6b7c62342154@xenomai.org>
 <0e8426ff-d0e8-9ed2-d3ad-4e54f678b36b@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <49b82be9-c4be-6fc9-982b-95110fb67bb8@xenomai.org>
Date: Sun, 17 Nov 2019 12:49:50 +0100
MIME-Version: 1.0
In-Reply-To: <0e8426ff-d0e8-9ed2-d3ad-4e54f678b36b@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, davy.regneau@univ-grenoble-alpes.fr
Cc: xenomai@xenomai.org

On 11/13/19 2:48 PM, Jan Kiszka wrote:
> On 10.11.19 18:25, Philippe Gerum wrote:
>> On 11/7/19 11:12 AM, davy.regneau@univ-grenoble-alpes.fr wrote:
>>>> On 06.11.19 15:23, davy.regneau@univ-grenoble-alpes.fr wrote:
>>>>>> On 06.11.19 14:40, davy.regneau@univ-grenoble-alpes.fr wrote:
>>>>>>>> On 06.11.19 10:18, Davy via Xenomai wrote:
>>>>>>>>>
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> Thanks for patching the shared sessions. It works.
>>>>>>>>>
>>>>>>>>> Now I have another segmentation error that appears when a task ends
>>>>>>>>> or
>>>>>>>>> is
>>>>>>>>> deleted :
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> RT_TASK task;
>>>>>>>>> void foo(){
>>>>>>>>>     int i = 3;
>>>>>>>>>     while(i--){
>>>>>>>>>         printf("Hello !\n");
>>>>>>>>>         rt_task_sleep(1000000000);
>>>>>>>>>     }
>>>>>>>>>     return;
>>>>>>>>> }
>>>>>>>>> int main(int argc, char *argv[]){
>>>>>>>>>     int n;
>>>>>>>>>        if (mlockall( MCL_CURRENT | MCL_FUTURE )!=0)
>>>>>>>>>              return 1;
>>>>>>>>>     if ((n=rt_task_spawn( &task, NULL, 0, 99, T_JOINABLE, &foo,
>>>>>>>>> NULL))!=0){
>>>>>>>>>              rt_printf("rt_task_spawn error %d\n",n);
>>>>>>>>>              return 1;
>>>>>>>>>        }
>>>>>>>>>     printf("Join task\n");
>>>>>>>>>        rt_task_join(&task);
>>>>>>>>>     return EXIT_SUCCESS;
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> $ sudo ./foo
>>>>>>>>> Hello !
>>>>>>>>> Join task
>>>>>>>>> Hello !
>>>>>>>>> Hello !
>>>>>>>>> Erreur de segmentation
>>>>>>>>>
>>>>>>>>
>>>>>>>> Works find here. Could you use a debugger to find out where the
>>>>>>>> exception is thrown?
>>>>>>>>
>>>>>>>
>>>>>>> I obtain this :
>>>>>>>
>>>>>>> (gdb) run
>>>>>>> Starting program: /home/davy/Documents/Programmes_Test/test/foo
>>>>>>> [Thread debugging using libthread_db enabled]
>>>>>>> Using host libthread_db library
>>>>>>> "/lib/x86_64-linux-gnu/libthread_db.so.1".
>>>>>>> [New Thread 0x7ffff6db1700 (LWP 14620)]
>>>>>>> [New Thread 0x7ffff7ff6700 (LWP 14621)]
>>>>>>> Hello !
>>>>>>> Join task
>>>>>>>     0"025.863| WARNING: [main] Xenomai compiled with full debug
>>>>>>> enabled,
>>>>>>>                                very high latencies expected
>>>>>>> [--enable-debug=full]
>>>>>>> Hello !
>>>>>>> Hello !
>>>>>>>
>>>>>>> Thread 3 "task@1[14616]" received signal SIGSEGV, Segmentation fault.
>>>>>>> [Switching to Thread 0x7ffff7ff6700 (LWP 14621)]
>>>>>>> 0x00007ffff7799cf5 in shavlh_link (avl=0x7ffff7e47148, holder=0x0,
>>>>>>> dir=0)
>>>>>>> at ../../include/boilerplate/avl-inner.h:107
>>>>>>> 107        ptrdiff_t offset = holder->link[avl_type2index(dir)].offset;
>>>>>>>
>>>>>>
>>>>>> Backtrace? Values of the vars in question?
>>>>>
>>>>> (gdb) backtrace
>>>>> #0  0x00007ffff7799cf5 in shavlh_link (avl=0x7ffff7e47148, holder=0x0,
>>>>> dir=0) at ../../include/boilerplate/avl-inner.h:107
>>>>> #1  0x00007ffff7799fa7 in shavl_inorder (avl=0x7ffff7e47148, holder=0x0,
>>>>> dir=1) at avl.c:55
>>>>> #2  0x00007ffff79b89a5 in shavl_next (avl=0x7ffff7e47148,
>>>>> holder=0x7ffff7e4d1c8) at ../../include/boilerplate/avl-inner.h:332
>>>>> #3  0x00007ffff79b8fe5 in find_next_neighbour (ext=0x7ffff7e47128,
>>>>> r=0x7ffff7e4d1c8) at heapobj-pshared.c:276
>>>>> #4  0x00007ffff79b90e0 in release_page_range (ext=0x7ffff7e47128,
>>>>> page=0x7ffff7f425c8, size=1024) at heapobj-pshared.c:303
>>>>> #5  0x00007ffff79b9f84 in sheapmem_free (heap=0x7ffff7e46000,
>>>>> block=0x7ffff7f425c8) at heapobj-pshared.c:594
>>>>> #6  0x00007ffff79bbb40 in xnfree (ptr=0x7ffff7f425c8) at
>>>>> heapobj-pshared.c:1203
>>>>> #7  0x00007ffff79b46a5 in __threadobj_free (p=0x7ffff7f425c8) at
>>>>> ../../include/copperplate/threadobj.h:312
>>>>> #8  0x00007ffff79b46d4 in threadobj_free (thobj=0x7ffff7f426d0) at
>>>>> ../../include/copperplate/threadobj.h:317
>>>>> #9  0x00007ffff79b64d4 in finalize_thread (p=0x7ffff7f426d0) at
>>>>> threadobj.c:1548
>>>>> #10 0x00007ffff735f5f9 in __nptl_deallocate_tsd () at
>>>>> pthread_create.c:291
>>>>> #11 0x00007ffff7360658 in __nptl_deallocate_tsd () at
>>>>> pthread_create.c:449
>>>>> #12 start_thread (arg=0x7ffff7ff6700) at pthread_create.c:469
>>>>> #13 0x00007ffff6e9ad0f in clone () at
>>>>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:97
>>>>>
>>>>>>
>>>>>> How did you configure Xenomai userspace (beyond --enable-debug=full)?
>>>>>
>>>>> $ /usr/xenomai/bin/xeno-config --info
>>>>> Xenomai version: Xenomai/cobalt v3.1-rc3
>>>>> Linux XportNew 4.19.75-xenomai-3.1-rc3 #3 SMP PREEMPT Wed Nov 6 13:48:28
>>>>> CET 2019 x86_64 GNU/Linux
>>>>> Kernel parameters: BOOT_IMAGE=/boot/vmlinuz-4.19.75-xenomai-3.1-rc3
>>>>> root=/dev/mapper/isw_bdaaiafbje_Volume11 ro dmraid=true quiet splash
>>>>> nopat
>>>>> crashkernel=384M-:128M
>>>>> I-pipe release #7 detected
>>>>> Cobalt core 3.1-rc3 detected
>>>>> Compiler: gcc version 4.9.2 (Debian 4.9.2-10+deb8u1)
>>>>> Build args: --with-core=cobalt --enable-smp --enable-pshared
>>>>> --enable-debug=full
>>>>>
>>>>
>>>> This is resolving the crash:
>>>>
>>>> diff --git a/lib/boilerplate/avl.c b/lib/boilerplate/avl.c
>>>> index 3bf9bf1345..c13ec8a940 100644
>>>> --- a/lib/boilerplate/avl.c
>>>> +++ b/lib/boilerplate/avl.c
>>>> @@ -53,7 +53,7 @@ struct __AVL_T (avlh) * __AVL(inorder)(const struct
>>>> __AVL_T(avl) * const avl,
>>>>       } else {
>>>>           for (;;) {
>>>>               next = __AVLH(up)(avl, holder);
>>>> -            if (next == __AVL(anchor)(avl))
>>>> +            if (!next || next == __AVL(anchor)(avl))
>>>>                   return NULL;
>>>>               if (holder->type != dir)
>>>>                   break;
>>>>
>>>> But I don't feel like we have a stable setup since 1a79c31c9f8. There
>>>> could very well be further cases that now break under the new NULL
>>>> return value.
>>>>
>>>> Philippe, please double check all affected code paths.
>>>>
>>>> Jan
>>>>
>>>> -- 
>>>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>>>> Corporate Competence Center Embedded Linux
>>>>
>>>
>>>
>>> Hi,
>>>
>>> I still get an error if I call rt_task_join() after rt_task_delete() (like
>>> recomended in documentation) or if I try to delete another task.
>>>
>>> I ran this program with debugger :
>>>
>>> void foo(){
>>>     while(1){
>>>         printf("task 1 !\n");
>>>         rt_task_sleep(1000000000);
>>>     }
>>>     return;
>>> }
>>> void bar(){
>>>     while(1){
>>>         printf("task 2 !\n");
>>>         rt_task_sleep(1000000000);
>>>     }
>>> }
>>> int main(int argc, char *argv[]){
>>>     int n;
>>>        if (mlockall( MCL_CURRENT | MCL_FUTURE )!=0)
>>>              return 1;
>>>     if ((n=rt_task_spawn( &task, NULL, 0, 99, 0, &foo, NULL))!=0){
>>>              rt_printf("rt_task_spawn error %d\n",n);
>>>              return 1;
>>>        }
>>>     if ((n=rt_task_spawn( &task2, NULL, 0, 99, 0, &bar, NULL))!=0){
>>>              rt_printf("rt_task_spawn error %d\n",n);
>>>              return 1;
>>>        }
>>>     rt_task_sleep(2000000000);
>>>     printf("Delete task 1\n");
>>>     rt_task_delete(&task);
>>> //    printf("Join task 1\n");
>>> //      rt_task_join(&task);
>>>     printf("Delete task 2\n");
>>>     rt_task_delete(&task2);
>>>     return EXIT_SUCCESS;
>>> }
>>>
>>>
>>> (gdb) run
>>> Starting program: /home/davy/Documents/Programmes_Test/test/foo
>>> [Thread debugging using libthread_db enabled]
>>> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
>>> [New Thread 0x7ffff6db1700 (LWP 32383)]
>>> [New Thread 0x7ffff7ff6700 (LWP 32384)]
>>> task 1 !
>>> [New Thread 0x7ffff7fe5700 (LWP 32385)]
>>> task 2 !
>>>     0"025.641| WARNING: [main] Xenomai compiled with full debug enabled,
>>>                                very high latencies expected
>>> [--enable-debug=full]
>>> task 1 !
>>> task 2 !
>>> task 1 !
>>> task 2 !
>>> Delete task 1
>>> Delete task 2
>>>
>>> Thread 3 "task@1[32379]" received signal SIGSEGV, Segmentation fault.
>>> [Switching to Thread 0x7ffff7ff6700 (LWP 32384)]
>>> 0x00007ffff779a684 in avlh_balance_add (avl=0x7ffff7e47148, holder=0x0,
>>> delta=1) at avl.c:267
>>> 267        if (holder->balance == delta)
>>> (gdb) backtrace
>>> #0  0x00007ffff779a684 in avlh_balance_add (avl=0x7ffff7e47148,
>>> holder=0x0, delta=1) at avl.c:267
>>> #1  0x00007ffff779ab11 in avl_insert_inner (avl=0x7ffff7e47148,
>>> parent=0x0, node=0x7ffff7f425c8, side=1) at avl.c:388
>>> #2  0x00007ffff779aeda in shavl_insert (avl=0x7ffff7e47148,
>>> holder=0x7ffff7f425c8, ops=0x7ffff7bc27c0 <addr_search_ops>) at avl.c:502
>>> #3  0x00007ffff79b91d1 in release_page_range (ext=0x7ffff7e47128,
>>> page=0x7ffff7f425c8, size=1024) at heapobj-pshared.c:318
>>> #4  0x00007ffff79b9f84 in sheapmem_free (heap=0x7ffff7e46000,
>>> block=0x7ffff7f425c8) at heapobj-pshared.c:594
>>> #5  0x00007ffff79bbb40 in xnfree (ptr=0x7ffff7f425c8) at
>>> heapobj-pshared.c:1203
>>> #6  0x00007ffff79b46a5 in __threadobj_free (p=0x7ffff7f425c8) at
>>> ../../include/copperplate/threadobj.h:312
>>> #7  0x00007ffff79b46d4 in threadobj_free (thobj=0x7ffff7f426d0) at
>>> ../../include/copperplate/threadobj.h:317
>>> #8  0x00007ffff79b64d4 in finalize_thread (p=0x7ffff7f426d0) at
>>> threadobj.c:1548
>>> #9  0x00007ffff735f5f9 in __nptl_deallocate_tsd () at pthread_create.c:291
>>> #10 0x00007ffff7360658 in __nptl_deallocate_tsd () at pthread_create.c:449
>>> #11 start_thread (arg=0x7ffff7ff6700) at pthread_create.c:469
>>> #12 0x00007ffff6e9ad0f in clone () at
>>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:97
>>>
>>>
>>
>> The previous patch was half-baked. Please apply this one on top; the alchemy test suite, smokey's pshared test and a couple more are now happy with that change, but anything you can add will help. Feedback appreciated since this issue is a release blocker. TIA,
>>
>> diff --git a/include/boilerplate/avl-inner.h b/include/boilerplate/avl-inner.h
>> index 8e4de8487..9c0576213 100644
>> --- a/include/boilerplate/avl-inner.h
>> +++ b/include/boilerplate/avl-inner.h
>> @@ -105,14 +105,14 @@ shavlh_link(const struct shavl *const avl,
>>           const struct shavlh *const holder, unsigned int dir)
>>   {
>>       ptrdiff_t offset = holder->link[avl_type2index(dir)].offset;
>> -    return offset ? (void *)avl + offset : NULL;
>> +    return offset == (ptrdiff_t)-1 ? NULL : (void *)avl + offset;
>>   }
>>     static inline void
>>   shavlh_set_link(struct shavl *const avl, struct shavlh *lhs,
>>           int dir, struct shavlh *rhs)
>>   {
>> -    ptrdiff_t offset = rhs ? (void *)rhs - (void *)avl : 0;
>> +    ptrdiff_t offset = rhs ? (void *)rhs - (void *)avl : (ptrdiff_t)-1;
>>       lhs->link[avl_type2index(dir)].offset = offset;
>>   }
>>   @@ -120,13 +120,13 @@ static inline
>>   struct shavlh *shavl_end(const struct shavl *const avl, int dir)
>>   {
>>       ptrdiff_t offset = avl->end[avl_type2index(dir)].offset;
>> -    return offset ? (void *)avl + offset : NULL;
>> +    return offset == (ptrdiff_t)-1 ? NULL : (void *)avl + offset;
>>   }
>>     static inline void
>>   shavl_set_end(struct shavl *const avl, int dir, struct shavlh *holder)
>>   {
>> -    ptrdiff_t offset = holder ? (void *)holder - (void *)avl : 0;
>> +    ptrdiff_t offset = holder ? (void *)holder - (void *)avl : (ptrdiff_t)-1;
>>       avl->end[avl_type2index(dir)].offset = offset;
>>   }
>>  
> 
> Davy, were you able to test meanwhile?
> 
> Philippe, could you send out a regular patch already?
> 

Ok, done. This has been tested here, but no feedback from interested parties, so it looks like we may assume that absolutely nobody depends on copperplate's pshared mode for their application. In this case, we might not care about having this fix in for 3.1, or maybe we do, whatever fits, I guess.

-- 
Philippe.

