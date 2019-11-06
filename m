Subject: Re: segmentation error when a task ends
References: <86e02eb5015e1b4754b8dbe367e62497.squirrel@mail.ige-grenoble.fr>
 <64bfd5ea-6509-f4c9-ec7b-c79fb7619767@xenomai.org>
 <b9873e80d75b24e63dd423288ecca54b.squirrel@mail.ige-grenoble.fr>
 <996f4ac9-17f7-0dd7-9582-72fa47b96e73@siemens.com>
 <985740edf2fc30f8994c45d19f58ca39.squirrel@mail.ige-grenoble.fr>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b4f7c3a0-a3b1-017a-e4b0-0179fdb1e3fc@siemens.com>
Date: Wed, 6 Nov 2019 14:50:01 +0100
MIME-Version: 1.0
In-Reply-To: <985740edf2fc30f8994c45d19f58ca39.squirrel@mail.ige-grenoble.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: davy.regneau@univ-grenoble-alpes.fr
Cc: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

On 06.11.19 14:40, davy.regneau@univ-grenoble-alpes.fr wrote:
>> On 06.11.19 10:18, Davy via Xenomai wrote:
>>>
>>> Hi,
>>>
>>> Thanks for patching the shared sessions. It works.
>>>
>>> Now I have another segmentation error that appears when a task ends or
>>> is
>>> deleted :
>>>
>>>
>>>
>>> RT_TASK task;
>>> void foo(){
>>> 	int i = 3;
>>> 	while(i--){
>>> 		printf("Hello !\n");
>>> 		rt_task_sleep(1000000000);
>>> 	}
>>> 	return;
>>> }
>>> int main(int argc, char *argv[]){
>>> 	int n;
>>>   	if (mlockall( MCL_CURRENT | MCL_FUTURE )!=0)
>>>     		return 1;
>>> 	if ((n=rt_task_spawn( &task, NULL, 0, 99, T_JOINABLE, &foo, NULL))!=0){
>>>     		rt_printf("rt_task_spawn error %d\n",n);
>>>     		return 1;
>>>   	}
>>> 	printf("Join task\n");
>>>   	rt_task_join(&task);
>>> 	return EXIT_SUCCESS;
>>> }
>>>
>>>
>>> $ sudo ./foo
>>> Hello !
>>> Join task
>>> Hello !
>>> Hello !
>>> Erreur de segmentation
>>>
>>
>> Works find here. Could you use a debugger to find out where the
>> exception is thrown?
>>
> 
> I obtain this :
> 
> (gdb) run
> Starting program: /home/davy/Documents/Programmes_Test/test/foo
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> [New Thread 0x7ffff6db1700 (LWP 14620)]
> [New Thread 0x7ffff7ff6700 (LWP 14621)]
> Hello !
> Join task
>    0"025.863| WARNING: [main] Xenomai compiled with full debug enabled,
>                               very high latencies expected
> [--enable-debug=full]
> Hello !
> Hello !
> 
> Thread 3 "task@1[14616]" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7ffff7ff6700 (LWP 14621)]
> 0x00007ffff7799cf5 in shavlh_link (avl=0x7ffff7e47148, holder=0x0, dir=0)
> at ../../include/boilerplate/avl-inner.h:107
> 107		ptrdiff_t offset = holder->link[avl_type2index(dir)].offset;
> 

Backtrace? Values of the vars in question?

How did you configure Xenomai userspace (beyond --enable-debug=full)?

Philippe, any idea?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

