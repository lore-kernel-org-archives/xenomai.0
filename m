Subject: Re: affinity of main thread is bound to current core
References: <VI1PR05MB591718EB50E68F91B3DFD398F6AA0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <4211a9c2-957d-886d-da52-260a24a64632@siemens.com>
 <VI1PR05MB59174076484DB2BB0A1DF552F6A50@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6bfc5604-8ab9-a950-b651-c8a25c76c94c@xenomai.org>
Date: Thu, 22 Aug 2019 17:29:13 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB59174076484DB2BB0A1DF552F6A50@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 8/22/19 5:16 PM, Lange Norbert via Xenomai wrote:
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Donnerstag, 22. August 2019 16:52
>> To: Lange Norbert <norbert.lange@andritz.com>; Xenomai
>> (xenomai@xenomai.org) <xenomai@xenomai.org>
>> Subject: Re: affinity of main thread is bound to current core
>>
>> E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE, PLEASE
>> EXERCISE CAUTION WITH E-MAIL CONTENT AND ANY LINKS OR
>> ATTACHMENTS.
>>
>>
>> On 21.08.19 14:12, Lange Norbert via Xenomai wrote:
>>> Hello,
>>>
>>> I use Xenomai master on ipipe-core-4.19.60-x86-5.
>>> I start out with an affinity mask of 0xF, in the function cobalt_init_2,
>> pthread_setschedparam will get called, after the syscall
>> sc_cobalt_thread_setschedparam_ex the affinity mask will contain a single
>> CPU (supposedly the current one).
>>>
>>> All methods to control affinity are executed before this point (cmdline args,
>> /proc/xenomai/affinity), so there is no working way to control it.
>>>
>>
>> Not sure I get the problem yet: "some-xenomai-app --cpu-affinity X" seems
>> to work fine, so does setting /proc/xenomai/affinity. Can you describe more
>> concretely what behaves unexpectedly, maybe with a test case?
> 
> Well, it does not work for me.
> 
> ------------------ file test.c
> #define _GNU_SOURCE
> #include <stdio.h>
> 
> #include <sched.h>
> #include <pthread.h>
> 
> static void printaff()
> {
>     cpu_set_t cpuset;
>     pthread_getaffinity_np(pthread_self(), sizeof(cpuset), &cpuset);
>     printf("Affinity: ");
>     for(unsigned i = 0; i < 256; ++i)
>     {
>         if(CPU_ISSET(i, &cpuset))
>             printf("%u,", i);
>     }
>     printf("\n");
> }
> 
> int main(int argc, char const *argv[])
> {
> printaff();
> return 0;
> }
> ------------------
> 
> root@buildroot:~# cat /proc/xenomai/affinity
> 0000000f
> 
> root@buildroot:~# /tmp/a.out
> Affinity: 2,
> 
> root@buildroot:~# /tmp/a.out app --cpu-affinity 0,1,2,3
> Affinity: 3,
> 
> I traced the point where affinity collapsed to the
> sc_cobalt_thread_setschedparam_ex call.
> 

Feature, note bug. CPU migration is at odds with (very) low-latency
requirement, so cobalt pins the thread to one of the cores defined by
--cpu-affinity, preferably the current one. There is no point in having
more than a single core in the affinity mask for a real-time thread: we
simply don't want that one to be involved in any load balancing strategy.


-- 
Philippe.

