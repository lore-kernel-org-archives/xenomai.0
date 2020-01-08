Subject: Re: migrating to xenomai 3
References: <269aa40f-de14-b7a5-0486-98df418befbf@compador.de>
 <048dfe58-6214-1beb-18cf-c954057f4abc@siemens.com>
 <8f615935-b958-5aad-dc68-c0c7e801047e@compador.de>
 <49929049-cdd8-f132-832f-718d35c9f01a@siemens.com>
From: Johannes Holtz <johannes.holtz@compador.de>
Message-ID: <1f2feb0f-b5ed-c5a5-07b6-730304be4dc3@compador.de>
Date: Wed, 8 Jan 2020 13:11:05 +0100
MIME-Version: 1.0
In-Reply-To: <49929049-cdd8-f132-832f-718d35c9f01a@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

Am 08.01.20 um 12:50 schrieb Jan Kiszka:
> On 08.01.20 12:40, Johannes Holtz wrote:
>> Am 07.01.20 um 13:50 schrieb Jan Kiszka:
>>> On 07.01.20 11:42, Johannes Holtz via Xenomai wrote:
>>>> Hi,
>>>>
>>>> after a long and exhausting year I finally found time to experiment 
>>>> on migrating our application from Xenomai 2.6.4 to Xenomai 3.
>>>>
>>>> So I downloaded the latest stable release 3.0.10 and somehow found 
>>>> out I can't use the 4.19 ipipe kernel but the 4.14 so i also got 
>>>> that. patched, build, installed and tested the kernel an the 
>>>> binaries and now I was going to see what I have to do to build my 
>>>> application.
>>>>
>>>> I used to build my app with these flags:
>>>>
>>>> XENO_CONFIG    = /opt/xenomai/bin/xeno-config
>>>> XENO_CFLAGS    = $(shell $(XENO_CONFIG) --skin=rtdm --cflags 
>>>> 2>/dev/null)
>>>> XENO_LDFLAGS    = $(shell $(XENO_CONFIG) --skin=rtdm --ldflags 
>>>> 2>/dev/null) -lnative
>>>>
>>>> If you ask why I use rtdm and native. I need -lnative else I get this:
>>>>
>>>> rt_x_threads.c:(.text+0x3e9): undefined reference to `rt_timer_read'
>>>> rt_x_threads.c:(.text+0x3fd): undefined reference to `rt_task_join'
>>>> rt_x_threads.c:(.text+0x40b): undefined reference to `rt_task_delete'
>>>> rt_x_threads.c:(.text+0x429): undefined reference to `rt_timer_read'
>>>>
>>>> And I need -lrtdm else I get this:
>>>>
>>>> rt_x_ipc.c:(.text+0x4a): undefined reference to `rt_dev_socket'
>>>> rt_x_ipc.c:(.text+0x9e): undefined reference to `rt_dev_ioctl'
>>>> rt_x_ipc.c:(.text+0xde): undefined reference to `rt_dev_ioctl'
>>>> rt_x_ipc.c:(.text+0x112): undefined reference to `rt_dev_ioctl'
>>>> rt_x_ipc.c:(.text+0x16c): undefined reference to `rt_dev_ioctl'
>>>> rt_x_ipc.c:(.text+0x17f): undefined reference to `rt_dev_close'
>>>> rt_x_ipc.c:(.text+0x1ac): undefined reference to `rt_dev_close'
>>>> rt_x_ipc.c:(.text+0x206): undefined reference to `rt_dev_close'
>>>> rt_x_ipc.c:(.text+0x219): undefined reference to `rt_dev_close'
>>>>
>>>> I wanted to used the native interface so I can distinguish rt 
>>>> syscalls from standard posix calls.
>>>>
>>>>
>>>> FFD to my migration. I build Xenomai in cobalt skin and not 
>>>> mercury. I added the --compat switch to xeno-config but -lnative 
>>>> and -lrtdm are both not found anymore. Meaning there is a ton of 
>>>> undefined references.
>>>>
>>>> What would be the best strategy to solve this? Do I have to migrate 
>>>> all my native calls to posix calls or is there maybe a wrapper?
>>>>
>>>
>>> Try --skin=native instead - there is "rtdm" skin anymore.
>>>
>>> And for the rt_dev_* symbols: Those should magically be resolved as 
>>> well because they are static-inline wrappers in lib/trank.
>>>
>>> I bet this is somewhere documented as well in 
>>> https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Migrating_From_Xenomai_2_To_3. 
>>>
>>>
>>> Jan
>>>
>> Thanks, I finally got it to compile completely. The trick was to use 
>> "xeno-config --ccld".
>>
>> Now I still get a lot of "unused parameter" warnings like
>>
>> /opt/xenomai/include/copperplate/heapobj.h: In function 
>> ‘heapobj_unlink_session’:
>> /opt/xenomai/include/copperplate/heapobj.h:425:54: warning: unused 
>> parameter ‘session’ [-Wunused-parameter]
>>   static inline int heapobj_unlink_session(const char *session)
>>
>> Is there a way to get rid of them without turning the flag off 
>> completely? I like to see all warnings for my own code but the output 
>> is flooded with this messages from within the copperplate interface.
>
> We would need to remove the dependency on -Wno-unused-parameter (see 
> configure.ac) from Xenomai first. You only highlighted one function 
> that has an issue with that.
>
> Jan
>

Here is a list of all functions I was able to identify. Maybe that can 
help in the future.

/opt/xenomai/include/trank/rtdk.h: In function ‘rt_print_auto_init’:
/opt/xenomai/include/trank/rtdk.h:27:43: warning: unused parameter 
‘enable’ [-Wunused-parameter]
  static inline void rt_print_auto_init(int enable)

  /opt/xenomai/include/trank/native/task.h: In function ‘rt_task_notify’:
/opt/xenomai/include/trank/native/task.h:39:43: warning: unused 
parameter ‘task’ [-Wunused-parameter]
  static inline int rt_task_notify(RT_TASK *task, rt_sigset_t sigs)

/opt/xenomai/include/trank/native/task.h:39:61: warning: unused 
parameter ‘sigs’ [-Wunused-parameter]
  static inline int rt_task_notify(RT_TASK *task, rt_sigset_t sigs)

/opt/xenomai/include/copperplate/threadobj.h: In function 
‘threadobj_save_timeout’:
/opt/xenomai/include/copperplate/threadobj.h:71:56: warning: unused 
parameter ‘corespec’ [-Wunused-parameter]
  void threadobj_save_timeout(struct threadobj_corespec *corespec,
                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
/opt/xenomai/include/copperplate/threadobj.h:72:31: warning: unused 
parameter ‘timeout’ [-Wunused-parameter]
         const struct timespec *timeout)
         ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
/opt/xenomai/include/copperplate/threadobj.h: In function 
‘__threadobj_tag_locked’:
/opt/xenomai/include/copperplate/threadobj.h:288:61: warning: unused 
parameter ‘thobj’ [-Wunused-parameter]
  static inline void __threadobj_tag_locked(struct threadobj *thobj)
                                            ~~~~~~~~~~~~~~~~~~^~~~~
/opt/xenomai/include/copperplate/threadobj.h: In function 
‘__threadobj_tag_unlocked’:
/opt/xenomai/include/copperplate/threadobj.h:292:63: warning: unused 
parameter ‘thobj’ [-Wunused-parameter]
  static inline void __threadobj_tag_unlocked(struct threadobj *thobj)
~~~~~~~~~~~~~~~~~~^~~~~
/opt/xenomai/include/copperplate/threadobj.h: In function 
‘__threadobj_check_locked’:
/opt/xenomai/include/copperplate/threadobj.h:296:63: warning: unused 
parameter ‘thobj’ [-Wunused-parameter]
  static inline void __threadobj_check_locked(struct threadobj *thobj)
~~~~~~~~~~~~~~~~~~^~~~~
/opt/xenomai/include/copperplate/threadobj.h: In function 
‘threadobj_local_p’:
/opt/xenomai/include/copperplate/threadobj.h:385:55: warning: unused 
parameter ‘thobj’ [-Wunused-parameter]
  static inline int threadobj_local_p(struct threadobj *thobj)

  /opt/xenomai/include/copperplate/heapobj.h: In function ‘pshared_check’:
/opt/xenomai/include/copperplate/heapobj.h:328:39: warning: unused 
parameter ‘heap’ [-Wunused-parameter]
  static inline int pshared_check(void *heap, void *addr)
                                  ~~~~~~^~~~
/opt/xenomai/include/copperplate/heapobj.h:328:51: warning: unused 
parameter ‘addr’ [-Wunused-parameter]
  static inline int pshared_check(void *heap, void *addr)
                                              ~~~~~~^~~~
/opt/xenomai/include/copperplate/heapobj.h: In function 
‘heapobj_bind_session’:
/opt/xenomai/include/copperplate/heapobj.h:420:52: warning: unused 
parameter ‘session’ [-Wunused-parameter]
  static inline int heapobj_bind_session(const char *session)
                                         ~~~~~~~~~~~~^~~~~~~
/opt/xenomai/include/copperplate/heapobj.h: In function 
‘heapobj_unlink_session’:
/opt/xenomai/include/copperplate/heapobj.h:425:54: warning: unused 
parameter ‘session’ [-Wunused-parameter]
  static inline int heapobj_unlink_session(const char *session)

  /opt/xenomai/include/copperplate/clockobj.h: In function 
‘__clockobj_ticks_to_timeout’:
/opt/xenomai/include/copperplate/clockobj.h:167:51: warning: unused 
parameter ‘clkobj’ [-Wunused-parameter]
  void __clockobj_ticks_to_timeout(struct clockobj *clkobj,
                                   ~~~~~~~~~~~~~~~~~^~~~~~
/opt/xenomai/include/copperplate/clockobj.h: In function 
‘__clockobj_ticks_to_timespec’:
/opt/xenomai/include/copperplate/clockobj.h:179:52: warning: unused 
parameter ‘clkobj’ [-Wunused-parameter]
  void __clockobj_ticks_to_timespec(struct clockobj *clkobj,
                                    ~~~~~~~~~~~~~~~~~^~~~~~
/opt/xenomai/include/copperplate/clockobj.h: In function 
‘clockobj_get_resolution’:
/opt/xenomai/include/copperplate/clockobj.h:193:55: warning: unused 
parameter ‘clkobj’ [-Wunused-parameter]
  unsigned int clockobj_get_resolution(struct clockobj *clkobj)
                                       ~~~~~~~~~~~~~~~~~^~~~~~
/opt/xenomai/include/copperplate/clockobj.h: In function 
‘clockobj_get_frequency’:
/opt/xenomai/include/copperplate/clockobj.h:199:54: warning: unused 
parameter ‘clkobj’ [-Wunused-parameter]
  unsigned int clockobj_get_frequency(struct clockobj *clkobj)
                                      ~~~~~~~~~~~~~~~~~^~~~~~
/opt/xenomai/include/copperplate/clockobj.h: In function 
‘clockobj_ns_to_ticks’:
/opt/xenomai/include/copperplate/clockobj.h:204:62: warning: unused 
parameter ‘clkobj’ [-Wunused-parameter]
  static inline sticks_t clockobj_ns_to_ticks(struct clockobj *clkobj,
~~~~~~~~~~~~~~~~~^~~~~~
/opt/xenomai/include/copperplate/clockobj.h: In function 
‘clockobj_ticks_to_ns’:
/opt/xenomai/include/copperplate/clockobj.h:210:62: warning: unused 
parameter ‘clkobj’ [-Wunused-parameter]
  static inline sticks_t clockobj_ticks_to_ns(struct clockobj *clkobj,

/opt/xenomai/include/boilerplate/shared-list.h: In function 
‘__inith_nocheck’:
/opt/xenomai/include/boilerplate/shared-list.h:38:42: warning: unused 
parameter ‘heap’ [-Wunused-parameter]
  static inline void __inith_nocheck(void *heap, struct holder *holder)
                                     ~~~~~~^~~~
/opt/xenomai/include/boilerplate/shared-list.h: In function ‘__ath’:
/opt/xenomai/include/boilerplate/shared-list.h:55:32: warning: unused 
parameter ‘heap’ [-Wunused-parameter]
  static inline void __ath(void *heap, struct holder *head,
                           ~~~~~~^~~~
/opt/xenomai/include/boilerplate/shared-list.h: In function ‘__dth’:
/opt/xenomai/include/boilerplate/shared-list.h:70:32: warning: unused 
parameter ‘heap’ [-Wunused-parameter]
  static inline void __dth(void *heap, struct holder *holder)
                           ~~~~~~^~~~
/opt/xenomai/include/boilerplate/shared-list.h: In function 
‘__holder_linked’:
/opt/xenomai/include/boilerplate/shared-list.h:111:41: warning: unused 
parameter ‘heap’ [-Wunused-parameter]
  static inline int __holder_linked(void *heap, const struct holder *holder)
                                    ~~~~~~^~~~
/opt/xenomai/include/boilerplate/shared-list.h: In function ‘__list_join’:
/opt/xenomai/include/boilerplate/shared-list.h:158:38: warning: unused 
parameter ‘heap’ [-Wunused-parameter]
  static inline void __list_join(void *heap, struct listobj *lsrc,
                                 ~~~~~~^~~~
/opt/xenomai/include/boilerplate/shared-list.h: In function ‘__list_empty’:
/opt/xenomai/include/boilerplate/shared-list.h:199:38: warning: unused 
parameter ‘heap’ [-Wunused-parameter]
  static inline int __list_empty(void *heap, const struct listobj *list)
                                 ~~~~~~^~~~
/opt/xenomai/include/boilerplate/shared-list.h: In function 
‘__list_heading_p’:
/opt/xenomai/include/boilerplate/shared-list.h:221:42: warning: unused 
parameter ‘heap’ [-Wunused-parameter]
  static inline int __list_heading_p(void *heap, const struct holder 
*holder,

/opt/xenomai/include/copperplate/threadobj.h: In function 
‘threadobj_save_timeout’:
/opt/xenomai/include/copperplate/threadobj.h:71:56: warning: unused 
parameter ‘corespec’ [-Wunused-parameter]
  void threadobj_save_timeout(struct threadobj_corespec *corespec,
                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
/opt/xenomai/include/copperplate/threadobj.h:72:31: warning: unused 
parameter ‘timeout’ [-Wunused-parameter]
         const struct timespec *timeout)
         ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
/opt/xenomai/include/copperplate/threadobj.h: In function 
‘__threadobj_tag_locked’:
/opt/xenomai/include/copperplate/threadobj.h:288:61: warning: unused 
parameter ‘thobj’ [-Wunused-parameter]
  static inline void __threadobj_tag_locked(struct threadobj *thobj)
                                            ~~~~~~~~~~~~~~~~~~^~~~~
/opt/xenomai/include/copperplate/threadobj.h: In function 
‘__threadobj_tag_unlocked’:
/opt/xenomai/include/copperplate/threadobj.h:292:63: warning: unused 
parameter ‘thobj’ [-Wunused-parameter]
  static inline void __threadobj_tag_unlocked(struct threadobj *thobj)
~~~~~~~~~~~~~~~~~~^~~~~
/opt/xenomai/include/copperplate/threadobj.h: In function 
‘__threadobj_check_locked’:
/opt/xenomai/include/copperplate/threadobj.h:296:63: warning: unused 
parameter ‘thobj’ [-Wunused-parameter]
  static inline void __threadobj_check_locked(struct threadobj *thobj)
~~~~~~~~~~~~~~~~~~^~~~~
/opt/xenomai/include/copperplate/threadobj.h: In function 
‘threadobj_local_p’:
/opt/xenomai/include/copperplate/threadobj.h:385:55: warning: unused 
parameter ‘thobj’ [-Wunused-parameter]
  static inline int threadobj_local_p(struct threadobj *thobj)
                                      ~~~~~~~~~~~~~~~~~~^~~~~
/opt/xenomai/include/trank/native/task.h: In function ‘rt_task_notify’:
/opt/xenomai/include/trank/native/task.h:39:43: warning: unused 
parameter ‘task’ [-Wunused-parameter]
  static inline int rt_task_notify(RT_TASK *task, rt_sigset_t sigs)
                                   ~~~~~~~~~^~~~
/opt/xenomai/include/trank/native/task.h:39:61: warning: unused 
parameter ‘sigs’ [-Wunused-parameter]
  static inline int rt_task_notify(RT_TASK *task, rt_sigset_t sigs)






