Subject: Re: migrating to xenomai 3
References: <269aa40f-de14-b7a5-0486-98df418befbf@compador.de>
 <048dfe58-6214-1beb-18cf-c954057f4abc@siemens.com>
From: Johannes Holtz <johannes.holtz@compador.de>
Message-ID: <8f615935-b958-5aad-dc68-c0c7e801047e@compador.de>
Date: Wed, 8 Jan 2020 12:40:03 +0100
MIME-Version: 1.0
In-Reply-To: <048dfe58-6214-1beb-18cf-c954057f4abc@siemens.com>
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

Am 07.01.20 um 13:50 schrieb Jan Kiszka:
> On 07.01.20 11:42, Johannes Holtz via Xenomai wrote:
>> Hi,
>>
>> after a long and exhausting year I finally found time to experiment 
>> on migrating our application from Xenomai 2.6.4 to Xenomai 3.
>>
>> So I downloaded the latest stable release 3.0.10 and somehow found 
>> out I can't use the 4.19 ipipe kernel but the 4.14 so i also got 
>> that. patched, build, installed and tested the kernel an the binaries 
>> and now I was going to see what I have to do to build my application.
>>
>> I used to build my app with these flags:
>>
>> XENO_CONFIG    = /opt/xenomai/bin/xeno-config
>> XENO_CFLAGS    = $(shell $(XENO_CONFIG) --skin=rtdm  --cflags 
>> 2>/dev/null)
>> XENO_LDFLAGS    = $(shell $(XENO_CONFIG) --skin=rtdm --ldflags 
>> 2>/dev/null) -lnative
>>
>> If you ask why I use rtdm and native. I need -lnative else I get this:
>>
>> rt_x_threads.c:(.text+0x3e9): undefined reference to `rt_timer_read'
>> rt_x_threads.c:(.text+0x3fd): undefined reference to `rt_task_join'
>> rt_x_threads.c:(.text+0x40b): undefined reference to `rt_task_delete'
>> rt_x_threads.c:(.text+0x429): undefined reference to `rt_timer_read'
>>
>> And I need -lrtdm else I get this:
>>
>> rt_x_ipc.c:(.text+0x4a): undefined reference to `rt_dev_socket'
>> rt_x_ipc.c:(.text+0x9e): undefined reference to `rt_dev_ioctl'
>> rt_x_ipc.c:(.text+0xde): undefined reference to `rt_dev_ioctl'
>> rt_x_ipc.c:(.text+0x112): undefined reference to `rt_dev_ioctl'
>> rt_x_ipc.c:(.text+0x16c): undefined reference to `rt_dev_ioctl'
>> rt_x_ipc.c:(.text+0x17f): undefined reference to `rt_dev_close'
>> rt_x_ipc.c:(.text+0x1ac): undefined reference to `rt_dev_close'
>> rt_x_ipc.c:(.text+0x206): undefined reference to `rt_dev_close'
>> rt_x_ipc.c:(.text+0x219): undefined reference to `rt_dev_close'
>>
>> I wanted to used the native interface so I can distinguish rt 
>> syscalls from standard posix calls.
>>
>>
>> FFD to my migration. I build Xenomai in cobalt skin and not mercury. 
>> I added the --compat switch to xeno-config but -lnative and -lrtdm 
>> are both not found anymore. Meaning there is a ton of undefined 
>> references.
>>
>> What would be the best strategy to solve this? Do I have to migrate 
>> all my native calls to posix calls or is there maybe a wrapper?
>>
>
> Try --skin=native instead - there is "rtdm" skin anymore.
>
> And for the rt_dev_* symbols: Those should magically be resolved as 
> well because they are static-inline wrappers in lib/trank.
>
> I bet this is somewhere documented as well in 
> https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Migrating_From_Xenomai_2_To_3.
>
> Jan
>
Thanks, I finally got it to compile completely. The trick was to use 
"xeno-config --ccld".

Now I still get a lot of "unused parameter" warnings like

/opt/xenomai/include/copperplate/heapobj.h: In function 
‘heapobj_unlink_session’:
/opt/xenomai/include/copperplate/heapobj.h:425:54: warning: unused 
parameter ‘session’ [-Wunused-parameter]
  static inline int heapobj_unlink_session(const char *session)

Is there a way to get rid of them without turning the flag off 
completely? I like to see all warnings for my own code but the output is 
flooded with this messages from within the copperplate interface.

Cheers,

Johannes



