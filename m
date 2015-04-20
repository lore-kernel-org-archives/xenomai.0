MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <553232db.8404460a.6101.538c@mx.google.com>
References: <553232db.8404460a.6101.538c@mx.google.com>
Date: Mon, 20 Apr 2015 09:28:17 +0100
Message-ID: <CAKk99t1NdbeEWeB9hTztoZyDS7XDFzHeDRjMypfURLVkLqENkA@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Error: could not insert module kernel-task.ko:
 Unknown symbol in module
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "crazylinuxcnc@gmail.com" <crazylinuxcnc@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Maybe in the makefile you do not included the right path for headers.
A generic makefile for simple kernel modules (2.6.x and 3.x), which gets
correct path from Xenoma, using xeno-config, is:

obj-m   := kernel-task.o

$(eval EXTRA_CFLAGS := $(shell xeno-config --kcflags))
#or
#$(eval ccflags-y = $(shell xeno-config --kcflags))

all:
make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
clean:
make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
rm *~


Note: Is is assumed that Xenomai binary path, which is where xeno-config is
stored, is in the search PATH.
The default path should be:

/usr/xenomai/bin



On 18 April 2015 at 11:32, crazylinuxcnc@gmail.com <crazylinuxcnc@gmail.com>
wrote:

>
>
> ----- Reply message -----
> From: "Helder Daniel" <hdaniel@ualg.pt>
> To: "Ruika You" <crazylinuxcnc@gmail.com>
> Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>
> Subject: [Xenomai] Error: could not insert module kernel-task.ko: Unknown
> symbol in module
> Date: Sat, Apr 18, 2015 5:35 PM
>
> Hi,
>
> Are you using Xenomai version 3.x or 2.6.x?
>
> My xenomai version is 2.6.4
>
> In version 3.x the native API is no longer exported to kernel, only the
> RTDM API.
>
> //NOT EXPORTED in 3.x: #include <native/task.h>
>
> Helder
>
>
>
> On 18 April 2015 at 03:52, Ruika You <crazylinuxcnc@gmail.com> wrote:
>
>> Dear all,
>>
>> I just start to explore xenomai with compile a kernel module as simple as
>> "hello world". After compile successful, sudo insmod kernel-task.ko,
>> failed, error message as follow:
>> Error: could not insert module kernel-task.ko: Unknown symbol in module
>>
>> Dmesg result as belllow:
>> [52170.262642] kernel_task: Unknown symbol rt_task_create (err 0)
>> [52170.262688] kernel_task: Unknown symbol rt_task_start (err 0)
>> [52170.262722] kernel_task: Unknown symbol rt_task_delete (err 0)
>>
>> Source code:
>> #include <native/task.h>
>> #define TASK_PRIO 99 /* Highest RT priority */
>> #define TASK_MODE T_FPU|T_CPU(0) /* Uses FPU, bound to CPU #0 */
>> #define TASK_STKSZ 4096 /* Stack size (in bytes) */
>> RT_TASK task_desc;
>> void task_body (void *cookie)
>> {
>> for (;;) {
>> /* ... "cookie" should be NULL ... */
>> }
>> }
>> int init_module (void)
>> {
>> int err;
>> /* ... */
>> err =
>> rt_task_create(&task_desc,"MyTaskName",TASK_STKSZ,TASK_PRIO,TASK_MODE);
>> if (!err)
>> rt_task_start(&task_desc,&task_body,NULL);
>> return 1;
>> /* ... */
>> }
>> void cleanup_module (void)
>> {
>> rt_task_delete(&task_desc);
>> }
>>
>> As I analyzed the reason might be :
>>
>> 1. kernel build configure problem ?
>> 2. xenomai userland  configure problem?
>> 3. any xenomai module not loaded? native?
>> 4. have to export all these unknow symbol to kernel?
>>
>> Please advise!
>> Thank you very much!
>> -chengxi
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai
>>
>
>
>
> --
> Helder Daniel
> UALG - FCT
> DEEI
>
> http://w3.ualg.pt/~hdaniel
>



-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
