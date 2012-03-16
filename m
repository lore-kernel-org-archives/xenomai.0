Message-ID: <4F628474.1080805@domain.hid>
Date: Fri, 16 Mar 2012 01:08:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMJ=MEcVJCdP4wukwhqL83Ejorprnz32PB3vbpOK584GT1mkvg@domain.hid>
	<CAMJ=MEe1VkOMqUyAZ=X9ZHYweSAkjuBXnfVBR=sn-UD9sN_PYA@mail.gmail.com>
In-Reply-To: <CAMJ=MEe1VkOMqUyAZ=X9ZHYweSAkjuBXnfVBR=sn-UD9sN_PYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] xenomai-forge: round-robin scheduling in pSOS
 skin
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Ronny Meeus <ronny.meeus@domain.hid>
Cc: Xenomai-core@domain.hid

On 03/15/2012 08:49 PM, Ronny Meeus wrote:
> On Thu, Mar 8, 2012 at 3:30 PM, Ronny Meeus <ronny.meeus@domain.hid> wrote:
>> Hello
>>
>> I'm are using the xenomai-forge pSOS skin (Mercury).
>> My application is running on a P4040 (Freescale PPC with 4 cores).
>> Some code snippets are put in this mail but the complete testcode is
>> also attached.
>>
>> I have a test task that just consumes the CPU:
>>
>> int run_test = 1;
>> static void perform_work(u_long counter,u_long b,u_long c,u_long d)
>> {
>>  int i;
>>  while (run_test) {
>>    for (i=0;i<100000;i++);
>>    (*(unsigned long*)counter)++;
>>  }
>>  while (1) tm_wkafter(1000);
>> }
>>
>> If I create 2 instances of this task with the T_SLICE option set:
>>
>>    t_create("WORK",10,0,0,0,&tid);
>>    t_start(tid,T_TSLICE, perform_work, args);
>>
>>
>> I see that only 1 task is consuming CPU.
>>
>> # taskset 1 ./roundrobin.exe &
>> #    0"000.543| [main] SCHED_RT priorities => [1 .. 99]
>>   0"000.656| [main] SCHED_RT.99 reserved for IRQ emulation
>>   0"000.692| [main] SCHED_RT.98 reserved for scheduler-lock emulation
>> 0 -> 6602
>> 1 -> 0
>>
>> If I adapt the code so that I call in my init the threadobj_start_rr
>> function, I see that the load is equally distributed over the 2
>> threads:
>>
>> # taskset 1 ./roundrobin.exe &
>> #    0"000.557| [main] SCHED_RT priorities => [1 .. 99]
>>   0"000.672| [main] SCHED_RT.99 reserved for IRQ emulation
>>   0"000.708| [main] SCHED_RT.98 reserved for scheduler-lock emulation
>> 0 -> 3290
>> 1 -> 3291
>>
>> Here are the questions:
>> - why is the threadobj_start_rr function not called from the context
>> of the init of the psos layer.
>> - why is the roundrobin implemented in this way? If the tasks would be
>> mapped on the SCHED_RR instead of the SCHED_FF the Linux scheduler
>> would take care of this.
>> On the other hand, once the threadobj_start_rr function is called from
>> my init, and I create the tasks in T_NOTSLICE mode, the time-slicing
>> is still done.
>>
>> Thanks.
>>
>> ---
>> Ronny
> 
> Any comments on this?

I am afraid you will have to wait for Philippe to have time to answer
you. I am a bit ignorant about the psos API, but most importantly
completely ignorant of the mercury. I am working on forge, but mostly
with cobalt.

-- 
                                                                Gilles.

