Message-ID: <42660D98.9000400@domain.hid>
Date: Wed, 20 Apr 2005 10:06:48 +0200
From: Paolo Mantegazza <mantegazza@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: Interrupt Latency Question
References: <1CFEB358338412458B21FAA0D78FE86D4F0D3F@rennsmail02.eu.thmulti.com> <425EA538.5000306@domain.hid> <42654F7E.5090209@domain.hid>
In-Reply-To: <42654F7E.5090209@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Max Krasnyansky <maxk@domain.hid>
Cc: Fillod Stephane <stephane.fillod@domain.hid>, Wolfgang Grandegger <wolfgang.grandegger@domain.hid>, rtai@domain.hid, adeos-main@gna.org

Max Krasnyansky wrote:
> Hi Paolo,
> 
>> If you have a multicpus machine and can reserve CPUs to real time only,
>> than the picture will change a lot. No Linux activity on them, just your
>> real time programs and irq handlers, likely stuck and fully cached to 
>> those CPUs.
>>
>> This is the solution you'll see native in Linux soon. With true 
>> lowcost multicpus on a single chip massively available within a short 
>> time at the kids' game and mama's word processors store it will change 
>> the whole picture.
> 
> 
> Actually this is kind of available right now with vanilla 2.6 kernel.
> I'm talking about CPU reservation. Here is an example.
> Let's say we have dual CPU box and we want to dedicate CPU 1 to
> our application:
> - Configure the kernel with following boot options:
>     isolcpus=1 acpi_irq_nobalance noirqbalance
> 
>   This excludes CPU 1 from the scheduler balancing logic. And disables
>   ACPI and SW irq balancing.
>   Make sure that you don't run user-space IRQ balancer.
> 
> - Redirect all interrupts to CPU 0
>   for i in /proc/irq/*; do
>     echo 1 > $i/smp_affinity;
>   done
> 
> - Your app call now migrate to CPU 1
>   int cpu = 1;
>   uint32_t mask = (1 << cpu);
>   sched_setaffinity(0, sizeof(mask), (cpu_set_t *) &mask);
> 
> That's it. CPU 1 is yours. There will be almost zero activity on it, 
> besides
> your task of course.
> 

Well such a scheme has been available in RTAI even when it was not 
general in Linux yet (forcing interruts to a CPU dates back to 2.2.x).

For real time CPU reservation I mean something that estabilshes it as 
such directly at boot and are real time applications that have 
specifically to use it, the rest is excluded from the very beginning

Paolo.


