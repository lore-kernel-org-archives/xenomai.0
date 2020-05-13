Subject: =?UTF-8?Q?Re=3a_When_the_linux_process_could_recieve_the_message_tr?=
 =?UTF-8?Q?ansport_through_XDDP=ef=bc=9f?=
References: <CAAvDm6bKxtaf-xg5bM+SGgt39CrTh94chO9rfs-NuAO4nwPx3w@mail.gmail.com>
 <37d2adba-f2e4-dd77-89cc-a6d5ee95ee34@freyder.net>
 <CAAvDm6ZKzpHp5g6G2x71-HSzOaq88E6TbhbbUMBZwx+pE9-NhA@mail.gmail.com>
From: steve freyder <steve@freyder.net>
Message-ID: <5a270695-681c-6797-1192-933d9c685ac4@freyder.net>
Date: Tue, 12 May 2020 23:18:21 -0500
MIME-Version: 1.0
In-Reply-To: <CAAvDm6ZKzpHp5g6G2x71-HSzOaq88E6TbhbbUMBZwx+pE9-NhA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 5/12/2020 1:37 AM, 孙世龙 wrote:
> Hi,Steve:
>      Thank you for the clarification.
>
>     >>Will ADOES wake up the related linux process at once when the head
>     >>domain write something to the XDDP node?* Or, the linux process
>     >>has to wait for the schedule of linux kernel, if the processor is
>     >>busy, it may wait for a long long time.
>     >The Linux process cannot wake up immediately, otherwise what would
>     >be the point of having an RT co-kernel if it didn't preempt the
>     >non-RT environment.
>      Yea，I can't agree  more.
>      Imagine this scenario, your processor have 4 cores and you only 
> have one
>      RT process which has single thread.So, there are 3 cores could be 
> used
>      for the linux processes at least. What i am interested in is 
> that*if *
> *     the linux process wait to receive message through XDDP has to 
> compete*
> *     for the cpu resources** with so many other linux processes .*
>      >If you're going to build code that makes a NRT process a subordinate
>      >of an RT process, you're going to have to employ some non-standard
>     >logic and get creative about how you deal with the inverted priority
>     >relationship that implicitly exists between the RT/NRT schedulers
>     >involved in that scenario.
>     What do you mean by " employ  some non-standard logic"？Could you 
> make me more clearlly?
>
>      Thank you for your attention.
>      Look forward to hearing from you.
>
> steve freyder <steve@freyder.net <mailto:steve@freyder.net>> 
> 于2020年5月12日周二 上午11:43写道：
>
>     On 5/11/2020 9:16 PM, 孙世龙 via Xenomai wrote:
>>     Hi,
>>           As i am using XDDP to transport messages bettween the head domain and
>>     linux domain(i mean there are two processes, one is rt process, the other
>>     is linux process.),I wonder that when the linux process could recieve the
>>     message？
>>           *Will ADOES wake up the related linux process at once when the head
>>     domain write something to the XDDP node?* Or, the linux process has to wait
>>     for the schedule of linux kernel, if the processor is busy, it may wait for
>>     a long long time.
>>
>>           Thank you for your attention.
>>           Looking forward to hearing from you.
>
>     The Linux process cannot wake up immediately, otherwise what would
>     be the point of having an RT co-kernel if it didn't preempt the
>     non-RT environment.
>
>
>     If the RT process wishes to give the non-RT process an opportunity
>     to run in order to receive the just-sent message, it had better
>     relinquish the CPU.  Inserting an rt_sleep() call (or equivalent)
>     might be one (inelegant?) option, but certainly nothing in iPipe
>     or anything at that layer is going to magically solve that problem
>     for you.
>
>
>     If you're going to build code that makes a NRT process a
>     subordinate of an RT process, you're going to have to employ some
>     non-standard logic and get creative about how you deal with the
>     inverted priority relationship that implicitly exists between the
>     RT/NRT schedulers involved in that scenario.  XDDP is a
>     bidirectional data relay, not a scheduler.
>
>
>     Regards,
>
>     Steve
>
>
You're right, and I shouldn't have ignored the scenario that you pointed 
out where there are multiple CPUs available.  Certainly if there is more 
than one CPU, then it's possible for the Linux process on the NRT side 
of the XDDP socket to wake up immediately when the RT side sends data on 
the socket assuming that the NRT process is waiting for read completion 
and that it's the highest priority process on the Linux side.  To the 
extent that you can ensure those conditions are met, you'll be able to 
ensure the kind of performance you're looking for.


